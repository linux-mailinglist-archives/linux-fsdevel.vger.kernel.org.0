Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A95136B997
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Apr 2021 21:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239924AbhDZTDe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 15:03:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51970 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239901AbhDZTDd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 15:03:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619463771;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ouGZBrLLWit6/ZcOCgBmqDAJzjKl2dpVcZkTyeLSBYo=;
        b=KANKAak/woxpsMagSNye5ofkBdj2nKGC2aIE8VfD7H3deB53hRBG3FUB+WwfNAR71IVD5d
        7TIp4R0e8zuOy7l5hlKZ8o3xrgH8JCHrSWS2LxnrAvfTozWoCrgPiiQ0kj/9dbhnRYgutT
        jhzI+TrOdyU8/9U3XG0F5NIePl4i0PM=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-IwPttPDlMbWQE0oC9hxHuQ-1; Mon, 26 Apr 2021 15:02:48 -0400
X-MC-Unique: IwPttPDlMbWQE0oC9hxHuQ-1
Received: by mail-qt1-f198.google.com with SMTP id h12-20020ac8744c0000b02901ba644d864fso11813974qtr.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Apr 2021 12:02:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=ouGZBrLLWit6/ZcOCgBmqDAJzjKl2dpVcZkTyeLSBYo=;
        b=PfUclogvrTdXJZpf9s+Uqoe+ug84kJOKhE6V6XbisyVqPUCnCyprb4dvIgM4grOpwZ
         3Um2UcrUlxwlpvb1EP0o5Cdhedh1+dHnPOp2c1N6AnKORCDFU90OLofkTDDln2XDwo5j
         IZuIDxXssakIYLuIL3YT1GOh7wuAqLH/5ZdTuqMebi2fxCfBMvvxCZ/g6Dmafzo+XlKT
         4zxNsoP4fUy34SE87UF2qXoTUabI7y3h3KpckBkEtHB/wod6JVMe8EQYDqMQRqGEO7R/
         aUHau66W643c/YHEC3LW/BSy5yaZ74vqKzmIa5MjDtzryX/2KqMAbi8FvQiVxoaxYalN
         W1NA==
X-Gm-Message-State: AOAM533DS1k4JhtRyBXjwoAsB9y21UboDU8N8zE226tHTDB3eoJ193fr
        dPeon0xeprxURe5M+UeRoQtq68siW/Yiir9nRQ6Th3WwoDAJOXFY1XJPv56X4MEC2T75vSNXza0
        xh7Iw8c1sYHF+nZyCoV0hxg+fAg==
X-Received: by 2002:a05:6214:12ab:: with SMTP id w11mr2594677qvu.14.1619463768329;
        Mon, 26 Apr 2021 12:02:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwGCsMCqX/N3XGxXqCeA/FOnTSmKwq96TpGbwn+GxMf4WVXk/guJWr0j2oTl477h4kubLqiGw==
X-Received: by 2002:a05:6214:12ab:: with SMTP id w11mr2594656qvu.14.1619463768135;
        Mon, 26 Apr 2021 12:02:48 -0700 (PDT)
Received: from [192.168.1.180] (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id c17sm11477744qtd.71.2021.04.26.12.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 12:02:47 -0700 (PDT)
Message-ID: <9e5744b2b647a8ff9cdea6efb58c39adde48f7f0.camel@redhat.com>
Subject: Re: [PATCH] iov_iter: Four fixes for ITER_XARRAY
From:   Jeff Layton <jlayton@redhat.com>
To:     David Howells <dhowells@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org,
        Dave Wysochanski <dwysocha@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        linux-kernel@vger.kernel.org
Date:   Mon, 26 Apr 2021 15:02:46 -0400
In-Reply-To: <3545034.1619392490@warthog.procyon.org.uk>
References: <161918448151.3145707.11541538916600921083.stgit@warthog.procyon.org.uk>
         <161918446704.3145707.14418606303992174310.stgit@warthog.procyon.org.uk>
         <3545034.1619392490@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.0 (3.40.0-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2021-04-26 at 00:14 +0100, David Howells wrote:
> Hi Al,
> 
> I think this patch should include all the fixes necessary.  I could merge
> it in, but I think it might be better to tag it on the end as an additional
> patch.
> 
> David
> ---
> iov_iter: Four fixes for ITER_XARRAY
> 
> Fix four things[1] in the patch that adds ITER_XARRAY[2]:
> 
>  (1) Remove the address_space struct predeclaration.  This is a holdover
>      from when it was ITER_MAPPING.
> 
>  (2) Fix _copy_mc_to_iter() so that the xarray segment updates count and
>      iov_offset in the iterator before returning.
> 
>  (3) Fix iov_iter_alignment() to not loop in the xarray case.  Because the
>      middle pages are all whole pages, only the end pages need be
>      considered - and this can be reduced to just looking at the start
>      position in the xarray and the iteration size.
> 
>  (4) Fix iov_iter_advance() to limit the size of the advance to no more
>      than the remaining iteration size.
> 
> Reported-by: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Link: https://lore.kernel.org/r/YIVrJT8GwLI0Wlgx@zeniv-ca.linux.org.uk [1]
> Link: https://lore.kernel.org/r/161918448151.3145707.11541538916600921083.stgit@warthog.procyon.org.uk [2]
> ---
>  include/linux/uio.h |    1 -
>  lib/iov_iter.c      |    5 +++++
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/uio.h b/include/linux/uio.h
> index 5f5ffc45d4aa..d3ec87706d75 100644
> --- a/include/linux/uio.h
> +++ b/include/linux/uio.h
> @@ -10,7 +10,6 @@
>  #include <uapi/linux/uio.h>
>  
> 
> 
> 
>  struct page;
> -struct address_space;
>  struct pipe_inode_info;
>  
> 
> 
> 
>  struct kvec {
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 44fa726a8323..61228a6c69f8 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -791,6 +791,8 @@ size_t _copy_mc_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
>  			curr_addr = (unsigned long) from;
>  			bytes = curr_addr - s_addr - rem;
>  			rcu_read_unlock();
> +			i->iov_offset += bytes;
> +			i->count -= bytes;
>  			return bytes;
>  		}
>  		})
> @@ -1147,6 +1149,7 @@ void iov_iter_advance(struct iov_iter *i, size_t size)
>  		return;
>  	}
>  	if (unlikely(iov_iter_is_xarray(i))) {
> +		size = min(size, i->count);
>  		i->iov_offset += size;
>  		i->count -= size;
>  		return;
> @@ -1346,6 +1349,8 @@ unsigned long iov_iter_alignment(const struct iov_iter *i)
>  			return size | i->iov_offset;
>  		return size;
>  	}
> +	if (unlikely(iov_iter_is_xarray(i)))
> +		return (i->xarray_start + i->iov_offset) | i->count;
>  	iterate_all_kinds(i, size, v,
>  		(res |= (unsigned long)v.iov_base | v.iov_len, 0),
>  		res |= v.bv_offset | v.bv_len,
> 

I did a test run with your v7 pile, this patch, and my ceph fscache
rework patches and it did fine. You can add:

Tested-by: Jeff Layton <jlayton@redhat.com>

