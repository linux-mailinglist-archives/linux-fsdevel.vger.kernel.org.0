Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB00433D1E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 19:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbhJSRPV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 13:15:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31623 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230303AbhJSRPU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 13:15:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634663587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4i8IYWG9Vqjc7NrxHtrIVVcfleXY1klKtzfa0ewfz4w=;
        b=gCwv+PqV7NJfQgAG0eVDmGkuM3HW+5uSYXJbWK5MCwk5Vbt85RxTazvEo6NGuzc4tJxOK4
        DpcrvPUl8kljKr99KkE/01KuiZj59w/L5pG7UsKpWlJ69uDq7mNxdvDT/VSpFNlk8KbV+7
        SNvICqWKMDTILFgEFIR/u+CdFy4IzfQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337--K1_niTJMgSva63ABZ84wA-1; Tue, 19 Oct 2021 13:13:06 -0400
X-MC-Unique: -K1_niTJMgSva63ABZ84wA-1
Received: by mail-qk1-f200.google.com with SMTP id h8-20020a05620a284800b0045ec745583cso441575qkp.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Oct 2021 10:13:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=4i8IYWG9Vqjc7NrxHtrIVVcfleXY1klKtzfa0ewfz4w=;
        b=yfLmoCh2BEcbRnRVT2oJ7JqpkiceAWCcsJ356rGXJUwmExAAf7WH8fnwg5aAeAcEwH
         KNoAX9S/FZKgGb0bdjUBBXNoia7kSEEe+5A3zv+X2gvq+T8XdjHdQ/YhZeow1L6O9HZy
         AiNt8v7SSnfabgOscXcBV0vnbFWXBqkEalWX27OEUr2iUj/gp7D9KZsg3GV4GXCubeDw
         4cetc/4x/sfov2yoTEKJgorqFxwMXEsmqYjyS23sjbOXXALwFSeUUzuSSSqtgRTqTyLr
         Srx5oKOjZ1aij1E8FFvFGXBOzSfe9BlPNwM/mGJcV7G5kp0BwoXr2OcUOJxPPMzZpI+I
         MuCw==
X-Gm-Message-State: AOAM531b5zJeYmzG48XMiCYEX9cnE+Ea6mr7yvUyGVv41Jab3RKL1Vcd
        siKRwSS0X8KKAr5+lmPKHeU96t+E3SpQiQ8v90fLy3p2SXFltU9eCXBizW/7phXAvPuev3HSVU8
        Kw82fLlNRcRAlbE8z9SESlqy9Nw==
X-Received: by 2002:ac8:59ce:: with SMTP id f14mr1309285qtf.418.1634663585799;
        Tue, 19 Oct 2021 10:13:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxCTLnI4O14CVDS0WnTvhZl4wAoj8tNDS3DFRVR0xteRC6rTs30rKL1ujbd9t4swW1RKTIeyw==
X-Received: by 2002:ac8:59ce:: with SMTP id f14mr1309267qtf.418.1634663585628;
        Tue, 19 Oct 2021 10:13:05 -0700 (PDT)
Received: from [192.168.1.3] (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id s203sm8190618qke.21.2021.10.19.10.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 10:13:05 -0700 (PDT)
Message-ID: <b8cd66bd0c6341b5f9fb8c885013bbb7a8abd3f2.camel@redhat.com>
Subject: Re: [PATCH 01/67] mm: Stop filemap_read() from grabbing a
 superfluous page
From:   Jeff Layton <jlayton@redhat.com>
To:     David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Date:   Tue, 19 Oct 2021 13:13:04 -0400
In-Reply-To: <163456863216.2614702.6384850026368833133.stgit@warthog.procyon.org.uk>
References: <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk>
         <163456863216.2614702.6384850026368833133.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.40.4 (3.40.4-2.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2021-10-18 at 15:50 +0100, David Howells wrote:
> Under some circumstances, filemap_read() will allocate sufficient pages to
> read to the end of the file, call readahead/readpages on them and copy the
> data over - and then it will allocate another page at the EOF and call
> readpage on that and then ignore it.  This is unnecessary and a waste of
> time and resources.
> 
> filemap_read() *does* check for this, but only after it has already done
> the allocation and I/O.  Fix this by checking before calling
> filemap_get_pages() also.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> Acked-by: Kent Overstreet <kent.overstreet@gmail.com>
> cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> cc: linux-mm@kvack.org
> cc: linux-fsdevel@vger.kernel.org
> Link: https://lore.kernel.org/r/160588481358.3465195.16552616179674485179.stgit@warthog.procyon.org.uk/
> ---
> 
>  mm/filemap.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index dae481293b5d..c0cdc44c844e 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2625,6 +2625,10 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
>  		if ((iocb->ki_flags & IOCB_WAITQ) && already_read)
>  			iocb->ki_flags |= IOCB_NOWAIT;
>  
> +		isize = i_size_read(inode);
> +		if (unlikely(iocb->ki_pos >= isize))
> +			goto put_pages;
> +
>  		error = filemap_get_pages(iocb, iter, &pvec);
>  		if (error < 0)
>  			break;
> 
> 

I would wager that it's worth checking for this. I imagine read calls
beyond EOF are common enough that it's probably helpful to optimize that
case:

Acked-by: Jeff Layton <jlayton@redhat.com>

