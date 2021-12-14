Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 612D647434F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Dec 2021 14:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234328AbhLNNU7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Dec 2021 08:20:59 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:51904 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbhLNNU6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Dec 2021 08:20:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75C46614DC;
        Tue, 14 Dec 2021 13:20:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EB26C34605;
        Tue, 14 Dec 2021 13:20:56 +0000 (UTC)
Date:   Tue, 14 Dec 2021 14:20:52 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Qing Wang <wangqing@vivo.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: xattr: use vmemdup_user instead of kvmalloc and
 copy_from_user
Message-ID: <20211214132052.loq4gp2wlj4s2nf7@wittgenstein>
References: <1639484357-76013-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1639484357-76013-1-git-send-email-wangqing@vivo.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 14, 2021 at 04:19:17AM -0800, Qing Wang wrote:
> From: Wang Qing <wangqing@vivo.com>
> 
> fix memdup_user.cocci warning:
> fs/xattr.c:563:11-19: WARNING opportunity for vmemdup_user
> 
> Signed-off-by: Wang Qing <wangqing@vivo.com>
> ---
>  fs/xattr.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/xattr.c b/fs/xattr.c
> index 5c8c517..71c301d
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -560,11 +560,9 @@ setxattr(struct user_namespace *mnt_userns, struct dentry *d,
>  	if (size) {
>  		if (size > XATTR_SIZE_MAX)
>  			return -E2BIG;
> -		kvalue = kvmalloc(size, GFP_KERNEL);
> -		if (!kvalue)
> -			return -ENOMEM;
> -		if (copy_from_user(kvalue, value, size)) {
> -			error = -EFAULT;
> +		kvalue = vmemdup_user(value, size);

This changes the allocation type from GFP_KERNEL to GFP_USER which is
probably not what we need at least it's not clear to me that it is.
