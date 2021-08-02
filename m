Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6E23DE1C3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Aug 2021 23:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbhHBVke (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Aug 2021 17:40:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:46346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229567AbhHBVkd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Aug 2021 17:40:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3193660F9C;
        Mon,  2 Aug 2021 21:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1627940423;
        bh=PTjmIT0FyL9vrQDQubxChFqAemPGmMIiB/y0LI5d3Cw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vsqKoarz9SSKlE1tvLTLWONR2nY4ncmciCUty30+LD5LZWfUKqrjCBRbsaD4R1oWy
         AJyLkZ334jqwIa4PdUWdDM5RJM9qZRy7UoIwmd/YINwBYpSkvR0n+wEnkH1Ob5jomM
         Dm1WiMdM6mT0E1U2q/HDeYQjxEh/pipnTndHvKfY=
Date:   Mon, 2 Aug 2021 14:40:20 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, richard@sigma-star.at
Subject: Re: [PATCH] Log if a core dump is aborted due to changed file
 permissions
Message-Id: <20210802144020.1d898eeaedc615776b0d2996@linux-foundation.org>
In-Reply-To: <20210701233151.102720-1-david.oberhollenzer@sigma-star.at>
References: <20210701233151.102720-1-david.oberhollenzer@sigma-star.at>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri,  2 Jul 2021 01:31:51 +0200 David Oberhollenzer <david.oberhollenzer@sigma-star.at> wrote:

> For obvious security reasons, a core dump is aborted if the
> filesystem cannot preserve ownership or permissions of the
> dump file.
> 
> This affects filesystems like e.g. vfat, but also something like
> a 9pfs share in a Qemu test setup, running as a regular user,
> depending on the security model used. In those cases, the result
> is an empty core file and a confused user.
> 
> To hopefully safe other people a lot of time figuring out the
> cause, this patch adds a simple log message for those specific
> cases.

Seems sane.

> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -782,10 +777,17 @@ void do_coredump(const kernel_siginfo_t *siginfo)
>  		 * filesystem.
>  		 */
>  		mnt_userns = file_mnt_user_ns(cprm.file);
> -		if (!uid_eq(i_uid_into_mnt(mnt_userns, inode), current_fsuid()))
> +		if (!uid_eq(i_uid_into_mnt(mnt_userns, inode),
> +			    current_fsuid())) {
> +			pr_info_ratelimited("Core dump to |%s aborted: cannot preserve file owner\n",

But why the "|%s"?  This signifies dump-to-pipe, yes?  Don't we need
the below?

--- a/fs/coredump.c~log-if-a-core-dump-is-aborted-due-to-changed-file-permissions-fix
+++ a/fs/coredump.c
@@ -784,12 +784,12 @@ void do_coredump(const kernel_siginfo_t
 		mnt_userns = file_mnt_user_ns(cprm.file);
 		if (!uid_eq(i_uid_into_mnt(mnt_userns, inode),
 			    current_fsuid())) {
-			pr_info_ratelimited("Core dump to |%s aborted: cannot preserve file owner\n",
+			pr_info_ratelimited("Core dump to %s aborted: cannot preserve file owner\n",
 					    cn.corename);
 			goto close_fail;
 		}
 		if ((inode->i_mode & 0677) != 0600) {
-			pr_info_ratelimited("Core dump to |%s aborted: cannot preserve file permissions\n",
+			pr_info_ratelimited("Core dump to %s aborted: cannot preserve file permissions\n",
 					    cn.corename);
 			goto close_fail;
 		}
_

