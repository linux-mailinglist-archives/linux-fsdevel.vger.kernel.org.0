Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58D7929A9F4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Oct 2020 11:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1417645AbgJ0KpB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Oct 2020 06:45:01 -0400
Received: from casper.infradead.org ([90.155.50.34]:37592 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1417294AbgJ0Ko7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Oct 2020 06:44:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=F58e9lenK+1xet9ATHqeZj7trQCacmvynWTT0IRQJmA=; b=e/y8y89gFRbPjSRkI3uK2ifUJ6
        xALm8WO3xpKt0y1aTyxpPpXpfaUVNzg+bGirhMZGvntd4IvAiApKmcVzsYaIe5K1vRH7o+KBdto3a
        N55Yt9LjByKd7/t/kXvuoB4MiDOH0vW0InTjzQOslxkoDFQDjfO9rJ/7+sLB8aMSDWEZSD+pvpLG2
        Gqn1ZPIcGqHfrHIVS6QvK2yS40druv0vq6l9qJPXpn1urJyYSuBJ8wa++xLecPcAOqd1mGcLYO9Zb
        hpXdQdJ5zR3lS3XSRDZZqB7kYFJK5eRFJlDbxrwUA7pxagY87ST+bRhj6ADW8ibhN0pFF8nt6ug0N
        jPQe7gIA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kXMTC-0002QN-PH; Tue, 27 Oct 2020 10:44:50 +0000
Date:   Tue, 27 Oct 2020 10:44:50 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] seq_file: fix clang warning for NULL pointer arithmetic
Message-ID: <20201027104450.GA8864@infradead.org>
References: <20201026215321.3894419-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026215321.3894419-1-arnd@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> index f277d023ebcd..b55e6ef4d677 100644
> --- a/fs/kernfs/file.c
> +++ b/fs/kernfs/file.c
> @@ -124,7 +124,7 @@ static void *kernfs_seq_start(struct seq_file *sf, loff_t *ppos)
>  		 * The same behavior and code as single_open().  Returns
>  		 * !NULL if pos is at the beginning; otherwise, NULL.
>  		 */
> -		return NULL + !*ppos;
> +		return (void *)(uintptr_t)!*ppos;

Yikes.  This is just horrible, why bnot the completely obvious:

	if (ops->seq_start) {
		...
		return next;
	}

	if (*ppos)
		return NULL;
	return ppos; /* random cookie */

>  static void *single_start(struct seq_file *p, loff_t *pos)
>  {
> -	return NULL + (*pos == 0);
> +	return (void *)(uintptr_t)(*pos == 0);

Same here.
