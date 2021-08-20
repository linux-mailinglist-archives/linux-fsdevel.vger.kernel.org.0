Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6C03F2809
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Aug 2021 10:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhHTIAN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Aug 2021 04:00:13 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:60744 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbhHTIAM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Aug 2021 04:00:12 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D552122161;
        Fri, 20 Aug 2021 07:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629446369; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fX0iF/Va7fLkHv5IISyOTys0XVxkkhe6oRnstITZ1+U=;
        b=XYBOdlx0IT7mnCdcVyoLsM6/7PMWjd3yauhTMxCuWw3nFslFYl7irzM1d9iFsIXtc/RZeB
        H8agiIYIYpurRXcl7ksKOQJ5qzfsbNzrEWQJ6yWK6VK9Y3SDTMVg8XBSFt74yXcEP+NBGF
        oq3214rXlGLHu2Yhy/k5YWd26C0iIpE=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 7AB791333E;
        Fri, 20 Aug 2021 07:59:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id Xn1tG+FgH2HzQwAAGKfGzw
        (envelope-from <nborisov@suse.com>); Fri, 20 Aug 2021 07:59:29 +0000
Subject: Re: [PATCH v10 02/14] fs: export variant of generic_write_checks
 without iov_iter
To:     Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-api@vger.kernel.org
References: <cover.1629234193.git.osandov@fb.com>
 <237db7dc485834d3d359b5765f07ebf7c3514f3a.1629234193.git.osandov@fb.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <ae6f8c7e-3b9b-bd95-140d-b556ce04df8f@suse.com>
Date:   Fri, 20 Aug 2021 10:59:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <237db7dc485834d3d359b5765f07ebf7c3514f3a.1629234193.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 18.08.21 г. 0:06, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> Encoded I/O in Btrfs needs to check a write with a given logical size
> without an iov_iter that matches that size (because the iov_iter we have
> is for the compressed data). So, factor out the parts of
> generic_write_check() that expect an iov_iter into a new
> __generic_write_checks() function and export that.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  fs/read_write.c    | 40 ++++++++++++++++++++++------------------
>  include/linux/fs.h |  1 +
>  2 files changed, 23 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/read_write.c b/fs/read_write.c
> index 0029ff2b0ca8..3bddd5ee7f64 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -1633,6 +1633,26 @@ int generic_write_check_limits(struct file *file, loff_t pos, loff_t *count)
>  	return 0;
>  }
>  
> +/* Like generic_write_checks(), but takes size of write instead of iter. */
> +int __generic_write_checks(struct kiocb *iocb, loff_t *count)
> +{
> +	struct file *file = iocb->ki_filp;
> +	struct inode *inode = file->f_mapping->host;
> +
> +	if (IS_SWAPFILE(inode))
> +		return -ETXTBSY;

 Missing 'if(!count) return 0' from original code ?

<snip>
