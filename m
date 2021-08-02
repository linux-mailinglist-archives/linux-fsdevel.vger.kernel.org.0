Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F17A13DE0FB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Aug 2021 22:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbhHBUrS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Mon, 2 Aug 2021 16:47:18 -0400
Received: from mail-40131.protonmail.ch ([185.70.40.131]:43484 "EHLO
        mail-40131.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbhHBUrQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Aug 2021 16:47:16 -0400
Date:   Mon, 02 Aug 2021 20:47:01 +0000
Authentication-Results: mail-40131.protonmail.ch; dkim=none
To:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Cc:     richard@sigma-star.at, Andrew Morton <akpm@linux-foundation.org>
Reply-To: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Subject: Re: [PATCH] Log if a core dump is aborted due to changed file permissions
Message-ID: <76fdf2e7-272f-8771-3a88-ab387ec8954b@sigma-star.at>
In-Reply-To: <20210701233151.102720-1-david.oberhollenzer@sigma-star.at>
References: <20210701233151.102720-1-david.oberhollenzer@sigma-star.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.0 required=10.0 tests=ALL_TRUSTED shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Friendly ping :-)

On 7/2/21 1:31 AM, David Oberhollenzer wrote:
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
>
> Signed-off-by: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
> ---
>   fs/coredump.c | 13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/fs/coredump.c b/fs/coredump.c
> index c3d8fc14b993..3e53d3e18b0e 100644
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -782,10 +777,17 @@ void do_coredump(const kernel_siginfo_t *siginfo)
>   		 * filesystem.
>   		 */
>   		mnt_userns = file_mnt_user_ns(cprm.file);
> -		if (!uid_eq(i_uid_into_mnt(mnt_userns, inode), current_fsuid()))
> +		if (!uid_eq(i_uid_into_mnt(mnt_userns, inode),
> +			    current_fsuid())) {
> +			pr_info_ratelimited("Core dump to |%s aborted: cannot preserve file owner\n",
> +					    cn.corename);
>   			goto close_fail;
> -		if ((inode->i_mode & 0677) != 0600)
> +		}
> +		if ((inode->i_mode & 0677) != 0600) {
> +			pr_info_ratelimited("Core dump to |%s aborted: cannot preserve file permissions\n",
> +					    cn.corename);
>   			goto close_fail;
> +		}
>   		if (!(cprm.file->f_mode & FMODE_CAN_WRITE))
>   			goto close_fail;
>   		if (do_truncate(mnt_userns, cprm.file->f_path.dentry,
> --
> 2.31.1
>


