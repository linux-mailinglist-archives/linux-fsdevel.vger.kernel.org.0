Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91C0618EA9A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Mar 2020 17:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbgCVQ5H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 Mar 2020 12:57:07 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37370 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgCVQ5H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 Mar 2020 12:57:07 -0400
Received: by mail-pg1-f195.google.com with SMTP id a32so5898930pga.4
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Mar 2020 09:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dc2ft7jmj6hxFB83CfxE8r8hUsUgGlvpHZTaLQ9Mj8c=;
        b=abYLlraReyPJ1+n1SLVb1EZKISahqek0PA2wFE0h+NbfYdSVu980mfLzvdGwJk6IXS
         HHscNptr41y2v29Wj1Dj8cKpGcarslk7RotihDl0CGHLtiS+wbNaep63ZXK+f9s/ioiC
         KVNkSPc2TmLWA/o9l6AnHdlXQPiaJ0npLgEw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dc2ft7jmj6hxFB83CfxE8r8hUsUgGlvpHZTaLQ9Mj8c=;
        b=LPzB5GW17TDNQkeaQDUsqBFUqrJw2XahfRJex+3sgKrrHRxhPhqFeRvI00MWZRDkFa
         OO2RCc8ATaiyScuhMi2HNviPfcNFQY4o5H2213y+VLn41OLFHd8GpnvQDQ/t8/J4/H6z
         4V2He1EyLddUUFqOOs2DT+yKJMPWVoqpvIDO+69r2nk9kFZ42oNtmQwUe2+JxFizkEN9
         KTMI+HOGYTZPUWbq67Ywd4bzexLkO3ewnPqijJ1DuT7V/9foWDSw4J5Rdkx5R0SctnGS
         84BTG+6CLoOyjex8iXLZ//4yU6cBOXu1+SZm2tjPh+DNAl3Z9mKt27xs0XL5UlfAP9PW
         ZpqA==
X-Gm-Message-State: ANhLgQ1SBurhLnXEjaHOd6BE4bJVJXLvC6HxK5Ma8sWHXiyQL/yBa7vS
        jIBCBBfE27vKIC387ZWJON78RQ==
X-Google-Smtp-Source: ADFU+vuvlYyKKsqi5xEyU7cb8qW3ImSL8Yy96K5kakEKiPLla3VrlEvzBr6kjH1Lyejqj8NIlEZceg==
X-Received: by 2002:a63:2323:: with SMTP id j35mr17960882pgj.440.1584896225995;
        Sun, 22 Mar 2020 09:57:05 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x24sm2124386pfn.140.2020.03.22.09.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2020 09:57:04 -0700 (PDT)
Date:   Sun, 22 Mar 2020 09:57:03 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        glider@google.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        syzbot+fcab69d1ada3e8d6f06b@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] libfs: fix infoleak in simple_attr_read()
Message-ID: <202003220954.24E1E2EB5E@keescook>
References: <CAG_fn=WvVp7Nxm5E+1dYs4guMYUV8D1XZEt_AZFF6rAQEbbAeg@mail.gmail.com>
 <20200308023849.988264-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200308023849.988264-1-ebiggers@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Mar 07, 2020 at 06:38:49PM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Reading from a debugfs file at a nonzero position, without first reading
> at position 0, leaks uninitialized memory to userspace.
> 
> It's a bit tricky to do this, since lseek() and pread() aren't allowed
> on these files, and write() doesn't update the position on them.  But
> writing to them with splice() *does* update the position:
> 
> 	#define _GNU_SOURCE 1
> 	#include <fcntl.h>
> 	#include <stdio.h>
> 	#include <unistd.h>
> 	int main()
> 	{
> 		int pipes[2], fd, n, i;
> 		char buf[32];
> 
> 		pipe(pipes);
> 		write(pipes[1], "0", 1);
> 		fd = open("/sys/kernel/debug/fault_around_bytes", O_RDWR);
> 		splice(pipes[0], NULL, fd, NULL, 1, 0);
> 		n = read(fd, buf, sizeof(buf));
> 		for (i = 0; i < n; i++)
> 			printf("%02x", buf[i]);
> 		printf("\n");
> 	}
> 
> Output:
> 	5a5a5a5a5a5a5a5a5a5a5a5a5a5a5a5a5a5a5a5a5a5a5a30
> 
> Fix the infoleak by making simple_attr_read() always fill
> simple_attr::get_buf if it hasn't been filled yet.
> 
> Reported-by: syzbot+fcab69d1ada3e8d6f06b@syzkaller.appspotmail.com
> Reported-by: Alexander Potapenko <glider@google.com>
> Fixes: acaefc25d21f ("[PATCH] libfs: add simple attribute files")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Yikes, that's an important fix!

Acked-by: Kees Cook <keescook@chromium.org>

Luckily (as Alexander mentioned too), most distros make debugfs
non-accessible by non-root (I hope):

$ ls -lda /sys/kernel/debug
drwx------ 39 root root 0 Jan  8 09:10 /sys/kernel/debug/

That function is also exposed via DEFINE_SIMPLE_ATTRIBUTE(), but those
users appear to also be mostly (all?) debugfs too.

And, just to note, for v5.3 and later, this would be fully mitigated by
booting with "init_on_alloc=1".

-Kees

> ---
>  fs/libfs.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/libfs.c b/fs/libfs.c
> index c686bd9caac6..3759fbacf522 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -891,7 +891,7 @@ int simple_attr_open(struct inode *inode, struct file *file,
>  {
>  	struct simple_attr *attr;
>  
> -	attr = kmalloc(sizeof(*attr), GFP_KERNEL);
> +	attr = kzalloc(sizeof(*attr), GFP_KERNEL);
>  	if (!attr)
>  		return -ENOMEM;
>  
> @@ -931,9 +931,11 @@ ssize_t simple_attr_read(struct file *file, char __user *buf,
>  	if (ret)
>  		return ret;
>  
> -	if (*ppos) {		/* continued read */
> +	if (*ppos && attr->get_buf[0]) {
> +		/* continued read */
>  		size = strlen(attr->get_buf);
> -	} else {		/* first read */
> +	} else {
> +		/* first read */
>  		u64 val;
>  		ret = attr->get(attr->data, &val);
>  		if (ret)
> -- 
> 2.25.1
> 

-- 
Kees Cook
