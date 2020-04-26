Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD7CA1B8C60
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Apr 2020 06:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgDZErZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Apr 2020 00:47:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:37844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726101AbgDZErZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Apr 2020 00:47:25 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBF99206D4;
        Sun, 26 Apr 2020 04:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587876445;
        bh=Ed67bnHI9OcrbnOogb7cRpweoPOXndi3LfHAp1KEHNU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VFSFTqIkT30VQv/yqmwoiheYULSHC7LBREaYVEFRbiJt7N9sU3UVjVvCyt//ew1k3
         QWT1YQSEti18WMfchHZBCnyl9qpwh+UmcBplK9lmYsDiAgsRv62q1g57b9dtVVzqAz
         Dwl5D4QRSHUBhY/aww8YGmR9u9n6LKHhV87QfYvw=
Date:   Sat, 25 Apr 2020 21:47:24 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeremy Kerr <jk@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] signal: factor copy_siginfo_to_external32 from
 copy_siginfo_to_user32
Message-Id: <20200425214724.a9a00c76edceff7296df7874@linux-foundation.org>
In-Reply-To: <20200421154204.252921-3-hch@lst.de>
References: <20200421154204.252921-1-hch@lst.de>
        <20200421154204.252921-3-hch@lst.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 21 Apr 2020 17:41:59 +0200 Christoph Hellwig <hch@lst.de> wrote:

> To remove the use of set_fs in the coredump code there needs to be a
> way to convert a kernel siginfo to a userspace compat siginfo.
> 
> Call that function copy_siginfo_to_compat and factor it out of
> copy_siginfo_to_user32.
> 
> The existence of x32 complicates this code.  On x32 SIGCHLD uses 64bit
> times for utime and stime.  As only SIGCHLD is affected and SIGCHLD
> never causes a coredump I have avoided handling that case.

x86_64 allmodconfig:

kernel/signal.c: In function 'copy_siginfo_to_external32':
kernel/signal.c:3299:7: error: 'x32_ABI' undeclared (first use in this function); did you mean 'CTL_ABI'?
   if (x32_ABI) {
       ^~~~~~~

I looked at fixing it but surely this sort of thing:


int copy_siginfo_to_user32(struct compat_siginfo __user *to,
			   const struct kernel_siginfo *from)
#if defined(CONFIG_X86_X32_ABI) || defined(CONFIG_IA32_EMULATION)
{
	return __copy_siginfo_to_user32(to, from, in_x32_syscall());
}
int __copy_siginfo_to_user32(struct compat_siginfo __user *to,
			     const struct kernel_siginfo *from, bool x32_ABI)
#endif
{
	...


is too ugly to live?
