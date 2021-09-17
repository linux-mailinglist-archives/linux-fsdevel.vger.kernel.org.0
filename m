Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBC5540F3BB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Sep 2021 10:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245093AbhIQIJ3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Sep 2021 04:09:29 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:49672 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244038AbhIQIJZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Sep 2021 04:09:25 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 718A91FD5D;
        Fri, 17 Sep 2021 08:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631866054; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E5XZpzgvqBnXXjYC5QF8VCuzvvIAEV9UHmd8F5JPqu0=;
        b=aPErrLQWgqwvdKCXDVdPJxpl7NLgpyIMoSRYb5pLYIdT6YhpsTrPy181qCPfvmjjZQY5xk
        xa4sk8iUMViYKM8hP4j37NAKP774m6L1wSZyC6wi63g4p5Zouo+Kr8LA4BM1bMxjK8m78V
        HYfnREG8L1+iCU1ApD6dBvsskGM8g1Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631866054;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E5XZpzgvqBnXXjYC5QF8VCuzvvIAEV9UHmd8F5JPqu0=;
        b=6aUop1pZyho3bhKRMQq6UN4ClxB3H0Obm2byvkqeMqP9aGWrr+iiRqc1tHkuvgqNtS7n0n
        PDt9vFCvcaVmKPBg==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 1EB1BA3B84;
        Fri, 17 Sep 2021 08:07:34 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 034A81E0CA7; Fri, 17 Sep 2021 10:07:30 +0200 (CEST)
Date:   Fri, 17 Sep 2021 10:07:30 +0200
From:   Jan Kara <jack@suse.cz>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        viro@zeniv.linux.org.uk,
        Linux fsdevel mailing list <linux-fsdevel@vger.kernel.org>,
        linux kernel mailing list <linux-kernel@vger.kernel.org>,
        xu.xin16@zte.com.cn
Subject: Re: [PATCH v2] init/do_mounts.c: Harden split_fs_names() against
 buffer overflow
Message-ID: <20210917080730.GA5284@quack2.suse.cz>
References: <YUNn4k1FCgQmOpuw@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUNn4k1FCgQmOpuw@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 16-09-21 11:50:58, Vivek Goyal wrote:
> split_fs_names() currently takes comma separate list of filesystems
> and converts it into individual filesystem strings. Pleaces these
> strings in the input buffer passed by caller and returns number of
> strings.
> 
> If caller manages to pass input string bigger than buffer, then we
> can write beyond the buffer. Or if string just fits buffer, we will
> still write beyond the buffer as we append a '\0' byte at the end.
> 
> Pass size of input buffer to split_fs_names() and put enough checks
> in place so such buffer overrun possibilities do not occur.
> 
> This patch does few things.
> 
> - Add a parameter "size" to split_fs_names(). This specifies size
>   of input buffer.
> 
> - Use strlcpy() (instead of strcpy()) so that we can't go beyond
>   buffer size. If input string "names" is larger than passed in
>   buffer, input string will be truncated to fit in buffer.
> 
> - Stop appending extra '\0' character at the end and avoid one
>   possibility of going beyond the input buffer size.
> 
> - Do not use extra loop to count number of strings.
> 
> - Previously if one passed "rootfstype=foo,,bar", split_fs_names()
>   will return only 1 string "foo" (and "bar" will be truncated
>   due to extra ,). After this patch, now split_fs_names() will
>   return 3 strings ("foo", zero-sized-string, and "bar").
> 
>   Callers of split_fs_names() have been modified to check for
>   zero sized string and skip to next one.
> 
> Reported-by: xu xin <xu.xin16@zte.com.cn>
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  init/do_mounts.c |   28 ++++++++++++++++++++--------
>  1 file changed, 20 insertions(+), 8 deletions(-)

Just one nit below:

> Index: redhat-linux/init/do_mounts.c
> ===================================================================
> --- redhat-linux.orig/init/do_mounts.c	2021-09-15 08:46:33.801689806 -0400
> +++ redhat-linux/init/do_mounts.c	2021-09-16 11:28:36.753625037 -0400
> @@ -338,19 +338,25 @@ __setup("rootflags=", root_data_setup);
>  __setup("rootfstype=", fs_names_setup);
>  __setup("rootdelay=", root_delay_setup);
>  
> -static int __init split_fs_names(char *page, char *names)
> +static int __init split_fs_names(char *page, size_t size, char *names)
>  {
>  	int count = 0;
>  	char *p = page;
> +	bool str_start = false;
>  
> -	strcpy(p, root_fs_names);
> +	strlcpy(p, root_fs_names, size);
>  	while (*p++) {
> -		if (p[-1] == ',')
> +		if (p[-1] == ',') {
>  			p[-1] = '\0';
> +			count++;
> +			str_start = false;
> +		} else {
> +			str_start = true;
> +		}
>  	}
> -	*p = '\0';
>  
> -	for (p = page; *p; p += strlen(p)+1)
> +	/* Last string which might not be comma terminated */
> +	if (str_start)
>  		count++;

You could avoid the whole str_start logic if you just initialize 'count' to
1 - in the worst case you'll have 0-length string at the end (for case like
xfs,) but you deal with 0-length strings in the callers anyway. Otherwise
the patch looks good so feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
