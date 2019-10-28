Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E19AEE71A9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2019 13:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389188AbfJ1MmZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Oct 2019 08:42:25 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34114 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389163AbfJ1MmX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Oct 2019 08:42:23 -0400
Received: by mail-lj1-f196.google.com with SMTP id 139so10992854ljf.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Oct 2019 05:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YXz21DLbYChNtLC16qKg/F5siZzPuHpmcF6L0vjR70Q=;
        b=UDy5cy9jp7qw9ea3NmGoBYL5rkK3rD7lP+Y1vSO/MvqCsnHZxGiFpUyWebGJzCFW9E
         O4EN/t7pstqQFEkuseKzS6HdAafHy69l0s5ygYkRkW8TfdZhrlCNwaXt87RY98wEt4RP
         Is7yuQa+XX5HsO0mbecgrOsACK82b0mMHfbbMNG+RwruNptd7tjW6NPWahNTvZ/ZFKST
         2P+zFWeOa9FKappwZ+pztKsRRDT1l00rkjKdMCAIe4JbmppMd9zzBec12Pq0lMHa2GJ7
         Nl6Qdmal2rG3oTZIll/X/BRfpYMawwGMn5q0oMGKiT8/fQssH8XyiL1bv1kzEd1UPD1C
         iwTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YXz21DLbYChNtLC16qKg/F5siZzPuHpmcF6L0vjR70Q=;
        b=NOfTfjPRGFG0CTcd/Es8q5xibSbTfqD8JaEodjCJz96XowZi3KRDom/2bILDaA0aCZ
         gOCm28BPgHaZA+4oXBQqsP1Lf38sM4OFXbN0N5ybHHTtoMCZMsTRnhKB+YpG30fjaA4+
         tw6BsSjq1WupvkGFkZqOOuVV4GnrdUItaZUCfHKt5P/C3IGV9iaQXESVvk0h+KErAVIz
         gOubgIVUIQ3XnZpkr2vvr3c9UgBOQZ7dDJ8Dl4WgHSi03LUoB5fsLhr7MElfdzhJXaPe
         Is/TP828lFX0g0TpDMe0X5764nyvmRBYVbMy1fn+z7o1kxPTiRALFlcrbgn30xxKh7pm
         5M/A==
X-Gm-Message-State: APjAAAUAloqrb94xTJfk/P3o0EzitpfZjfFiQYN9qFVnV9AcdiNNEIcy
        f4mWE2ZOhCZXpwUyCXxNMO8R7Q==
X-Google-Smtp-Source: APXvYqzeBill5sGQdQXwwRpWKiSVdlLvWFYx2xLqvPT8yXAFAWaeU7gv4dx3rhmelIIJkIMHn+8r0A==
X-Received: by 2002:a2e:547:: with SMTP id 68mr11779036ljf.150.1572266541309;
        Mon, 28 Oct 2019 05:42:21 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id 4sm6328938lfa.95.2019.10.28.05.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 05:42:20 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 86B96100242; Mon, 28 Oct 2019 15:42:22 +0300 (+03)
Date:   Mon, 28 Oct 2019 15:42:22 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Steven Whitehouse <swhiteho@redhat.com>
Subject: Re: [PATCH] mm/filemap: do not allocate cache pages beyond end of
 file at read
Message-ID: <20191028124222.ld6u3dhhujfqcn7w@box>
References: <157225677483.3442.4227193290486305330.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157225677483.3442.4227193290486305330.stgit@buzz>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 28, 2019 at 12:59:34PM +0300, Konstantin Khlebnikov wrote:
> Page cache could contain pages beyond end of file during write or
> if read races with truncate. But generic_file_buffered_read() always
> allocates unneeded pages beyond eof if somebody reads here and one
> extra page at the end if file size is page-aligned.
> 
> Function generic_file_buffered_read() calls page_cache_sync_readahead()
> if page not found in cache and then do another lookup. Readahead checks
> file size in __do_page_cache_readahead() before allocating pages.
> After that generic_file_buffered_read() falls back to slow path and
> allocates page for ->readpage() without checking file size.
> 
> This patch checks file size before allocating page for ->readpage().
> 
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> ---
>  mm/filemap.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 85b7d087eb45..92abf5f348a9 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2225,6 +2225,10 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
>  		goto out;
>  
>  no_cached_page:
> +		/* Do not allocate cache pages beyond end of file. */
> +		if (((loff_t)index << PAGE_SHIFT) >= i_size_read(inode))
> +			goto out;
> +
>  		/*
>  		 * Ok, it wasn't cached, so we need to create a new
>  		 * page..
> 
> 

CC Steven.

I've tried something of this sort back in 2013:

http://lore.kernel.org/r/1377099441-2224-1-git-send-email-kirill.shutemov@linux.intel.com

and I've got push back.

Apparently, some filesystems may not have valid i_size before >readpage().
Not sure if it's still the case...

Anyway I don't think it's valid reason for this inefficiency. These
filesystems have to have own implementation of >read_iter() to deal with
this.

-- 
 Kirill A. Shutemov
