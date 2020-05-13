Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDB51D06A7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 07:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbgEMFtz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 01:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728680AbgEMFtz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 01:49:55 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389B9C061A0C;
        Tue, 12 May 2020 22:49:55 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYkH8-007EUK-Qh; Wed, 13 May 2020 05:49:51 +0000
Date:   Wed, 13 May 2020 06:49:50 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     axboe@kernel.dk, zohar@linux.vnet.ibm.com, mcgrof@kernel.org,
        keescook@chromium.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] fs: avoid fdput() after failed fdget() in
 kernel_read_file_from_fd()
Message-ID: <20200513054950.GT23230@ZenIV.linux.org.uk>
References: <cover.1589311577.git.skhan@linuxfoundation.org>
 <1159d74f88d100521c568037327ebc8ec7ffc6ef.1589311577.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1159d74f88d100521c568037327ebc8ec7ffc6ef.1589311577.git.skhan@linuxfoundation.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 12, 2020 at 01:43:05PM -0600, Shuah Khan wrote:
> Fix kernel_read_file_from_fd() to avoid fdput() after a failed fdget().
> fdput() doesn't do fput() on this file since FDPUT_FPUT isn't set
> in fd.flags. Fix it anyway since failed fdget() doesn't require
> a fdput().
> 
> This was introduced in a commit that added kernel_read_file_from_fd() as
> a wrapper for the VFS common kernel_read_file().
> 
> Fixes: b844f0ecbc56 ("vfs: define kernel_copy_file_from_fd()")
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
>  fs/exec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index 06b4c550af5d..ea24bdce939d 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1021,8 +1021,8 @@ int kernel_read_file_from_fd(int fd, void **buf, loff_t *size, loff_t max_size,
>  		goto out;
>  
>  	ret = kernel_read_file(f.file, buf, size, max_size, id);
> -out:
>  	fdput(f);
> +out:
>  	return ret;

Again, that goto is a pointless obfuscation; just return -EBADF
and be done with that.

Incidentally, why is that thing exported?
