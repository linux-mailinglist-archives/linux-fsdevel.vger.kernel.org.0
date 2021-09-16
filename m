Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E515040D814
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Sep 2021 13:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236603AbhIPLBn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Sep 2021 07:01:43 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:38420 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235628AbhIPLBm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Sep 2021 07:01:42 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id ACA7420074;
        Thu, 16 Sep 2021 11:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631790021; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NiFKkoj10cp+F/ra/0aEbVdN5ucaMmJMXGzMTQn3Qf4=;
        b=ztuEKtb6GT3HMts+fqm3Qi9K3wnKkY9g961MfsJC9Rd/3rFM0aKszn3L1gxOqr/5N8JH9q
        PE5Ajq6B1o2kHWOtGT3jzL2ynVNK642R+F3Kq93XrBL96BRv49lZBW451aCKbTjQXfty6h
        8dFAjKdhRn9j6dyzVJawm6vFwCspVpg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631790021;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NiFKkoj10cp+F/ra/0aEbVdN5ucaMmJMXGzMTQn3Qf4=;
        b=MqtywI4BDdy4ENd2fWnciZNzKRYlw48nTDclsOd+YLSddJAarIWl+XPyvmkwZGWUUIN2lp
        tk29dTBN/vn+6TAg==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 9E543A3B9B;
        Thu, 16 Sep 2021 11:00:16 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id DF6A01E0C04; Thu, 16 Sep 2021 13:00:16 +0200 (CEST)
Date:   Thu, 16 Sep 2021 13:00:16 +0200
From:   Jan Kara <jack@suse.cz>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     viro@zeniv.linux.org.uk,
        Linux fsdevel mailing list <linux-fsdevel@vger.kernel.org>,
        linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, xu.xin16@zte.com.cn,
        Christoph Hellwig <hch@infradead.org>, zhang.yunkai@zte.com.cn
Subject: Re: [PATCH] init/do_mounts.c: Harden split_fs_names() against buffer
 overflow
Message-ID: <20210916110016.GG10610@quack2.suse.cz>
References: <YUIPnPV2ttOHNIcX@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUIPnPV2ttOHNIcX@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 15-09-21 11:22:04, Vivek Goyal wrote:
> split_fs_names() currently takes comma separated list of filesystems
> and converts it into individual filesystem strings. Pleaces these
> strings in the input buffer passed by caller and returns number of
> strings.
> 
> If caller manages to pass input string bigger than buffer, then we
> can write beyond the buffer. Or if string just fits buffer, we will
> still write beyond the buffer as we append a '\0' byte at the end.
> 
> Will be nice to pass size of input buffer to split_fs_names() and
> put enough checks in place so such buffer overrun possibilities
> do not occur.
> 
> Hence this patch adds "size" parameter to split_fs_names() and makes
> sure we do not access memory beyond size. If input string "names"
> is larger than passed in buffer, input string will be truncated to
> fit in buffer.
> 
> Reported-by: xu xin <xu.xin16@zte.com.cn>
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>

The patch looks correct but IMO is more complicated than it needs to be...
See below.

> Index: redhat-linux/init/do_mounts.c
> ===================================================================
> --- redhat-linux.orig/init/do_mounts.c	2021-09-15 08:46:33.801689806 -0400
> +++ redhat-linux/init/do_mounts.c	2021-09-15 09:52:09.884449718 -0400
> @@ -338,19 +338,20 @@ __setup("rootflags=", root_data_setup);
>  __setup("rootfstype=", fs_names_setup);
>  __setup("rootdelay=", root_delay_setup);
>  
> -static int __init split_fs_names(char *page, char *names)
> +static int __init split_fs_names(char *page, size_t size, char *names)
>  {
>  	int count = 0;
> -	char *p = page;
> +	char *p = page, *end = page + size - 1;
> +
> +	strncpy(p, root_fs_names, size);

Why not strlcpy()? That way you don't have to explicitely terminate the
string...

> +	*end = '\0';
>  
> -	strcpy(p, root_fs_names);
>  	while (*p++) {
>  		if (p[-1] == ',')
>  			p[-1] = '\0';
>  	}
> -	*p = '\0';
>  
> -	for (p = page; *p; p += strlen(p)+1)
> +	for (p = page; p < end && *p; p += strlen(p)+1)
>  		count++;

And I kind of fail to see why you have a separate loop for counting number
of elements when you could count them directly when changing ',' to '\0'.
There's this small subtlety that e.g. string 'foo,,bar' will report to have
only 1 element with the above code while direct computation would return 3
but that's hardly problem IMHO.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
