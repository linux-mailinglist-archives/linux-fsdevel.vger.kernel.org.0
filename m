Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD2C823FC2C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Aug 2020 04:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgHICbo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Aug 2020 22:31:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50558 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726049AbgHICbo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Aug 2020 22:31:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596940302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MbLkPd5h+w3HuYbUtFGo2ztSxrORHhNasP5E8T/5k6w=;
        b=NF21pfVXxy3swUjgM5H59RZGoebSPJVgQQnFeQ7uOyTUz/ron4Xf0xfdZKmfYsNpvuzwBN
        2s3/C9ewmx5YaHu6fyk/GC9jFduzMphSlXNCtdodu8Y49YX7kcBXjl37WNaL5lsw5W/jyo
        1enXdaw/cEnVE0S0Ur/p7bxQuo+1rQg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-lJlH5iseOYKkf00s_8JW6w-1; Sat, 08 Aug 2020 22:31:39 -0400
X-MC-Unique: lJlH5iseOYKkf00s_8JW6w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EA29E79EC0;
        Sun,  9 Aug 2020 02:31:37 +0000 (UTC)
Received: from T590 (ovpn-12-63.pek2.redhat.com [10.72.12.63])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 82CD25F9DC;
        Sun,  9 Aug 2020 02:31:28 +0000 (UTC)
Date:   Sun, 9 Aug 2020 10:31:23 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+61acc40a49a3e46e25ea@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: splice: infinite busy loop lockup bug
Message-ID: <20200809023123.GB2134904@T590>
References: <00000000000084b59f05abe928ee@google.com>
 <29de15ff-15e9-5c52-cf87-e0ebdfa1a001@I-love.SAKURA.ne.jp>
 <20200807122727.GR1236603@ZenIV.linux.org.uk>
 <20200807123854.GS1236603@ZenIV.linux.org.uk>
 <20200807134114.GA2114050@T590>
 <20200807141148.GD17456@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807141148.GD17456@casper.infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 07, 2020 at 03:11:48PM +0100, Matthew Wilcox wrote:
> On Fri, Aug 07, 2020 at 09:41:14PM +0800, Ming Lei wrote:
> > On Fri, Aug 07, 2020 at 01:38:54PM +0100, Al Viro wrote:
> > > FWIW, my preference would be to have for_each_bvec() advance past zero-length
> > > segments; I'll need to go through its uses elsewhere in the tree first, though
> > > (after I grab some sleep),
> > 
> > Usually block layer doesn't allow/support zero bvec, however we can make
> > for_each_bvec() to support it only.
> > 
> > Tetsuo, can you try the following patch?
> > 
> > diff --git a/include/linux/bvec.h b/include/linux/bvec.h
> > index ac0c7299d5b8..b03c793dd28d 100644
> > --- a/include/linux/bvec.h
> > +++ b/include/linux/bvec.h
> > @@ -117,11 +117,19 @@ static inline bool bvec_iter_advance(const struct bio_vec *bv,
> >  	return true;
> >  }
> >  
> > +static inline void bvec_iter_skip_zero_vec(const struct bio_vec *bv,
> > +		struct bvec_iter *iter)
> > +{
> > +	iter->bi_idx++;
> > +	iter->bi_bvec_done = 0;
> > +}
> > +
> >  #define for_each_bvec(bvl, bio_vec, iter, start)			\
> >  	for (iter = (start);						\
> >  	     (iter).bi_size &&						\
> > -		((bvl = bvec_iter_bvec((bio_vec), (iter))), 1);	\
> > -	     bvec_iter_advance((bio_vec), &(iter), (bvl).bv_len))
> > +		((bvl = bvec_iter_bvec((bio_vec), (iter))), 1);		\
> > +	  (bvl).bv_len ? bvec_iter_advance((bio_vec), &(iter), (bvl).bv_len) : \
> > +			bvec_iter_skip_zero_vec((bio_vec), &(iter)))
> 
> Uhm, bvec_iter_advance() already skips over zero length bio_vecs.
> 
>         while (bytes && bytes >= bv[idx].bv_len) {
>                 bytes -= bv[idx].bv_len;
>                 idx++;
>         }

The issue is that zero (bvl).bv_len passed to bvec_iter_advance(), so
the iterator can't move on.

And I tried to avoid change to bvec_iter_advance() since this exact
issue only exists on for_each_bvec, and block layer won't support/allow
zero-length bvec.

> 
> The problem is when the _first_ bio_vec is zero length.

It can be any zero-length bvec during the iterating. 

> Maybe something more
> like this (which doesn't even compile, but hopefully makes my point):
> 
> @@ -86,12 +86,24 @@ struct bvec_iter_all {
>         (mp_bvec_iter_page((bvec), (iter)) +                    \
>          mp_bvec_iter_page_idx((bvec), (iter)))
>  
> -#define bvec_iter_bvec(bvec, iter)                             \
> -((struct bio_vec) {                                            \
> -       .bv_page        = bvec_iter_page((bvec), (iter)),       \
> -       .bv_len         = bvec_iter_len((bvec), (iter)),        \
> -       .bv_offset      = bvec_iter_offset((bvec), (iter)),     \
> -})
> +static inline bool bvec_iter_bvec(struct bio_vec *bv, struct bio_vec *bvec,
> +               struct bvec_iter *iter)
> +{
> +       unsigned int idx = iter->bi_idx;
> +
> +       if (!iter->bi_size)
> +               return false;
> +
> +       while (!bv[idx].bv_len)
> +               idx++;
> +       iter->bi_idx = idx;
> +
> +       bv->bv_page = bvec_iter_page(bvec, *iter);
> +       bv->bv_len = bvec_iter_len(bvec, *iter);
> +       bv->bv_offset = bvec_iter_offset(bvec, *iter);
> +
> +       return true;
> +}
>  
>  static inline bool bvec_iter_advance(const struct bio_vec *bv,
>                 struct bvec_iter *iter, unsigned bytes)
> @@ -119,8 +131,7 @@ static inline bool bvec_iter_advance(const struct bio_vec *bv,
>  
>  #define for_each_bvec(bvl, bio_vec, iter, start)                       \
>         for (iter = (start);                                            \
> -            (iter).bi_size &&                                          \
> -               ((bvl = bvec_iter_bvec((bio_vec), (iter))), 1); \
> +            bvec_iter_bvec(&(bvl), (bio_vec), &(iter));                \
>              bvec_iter_advance((bio_vec), &(iter), (bvl).bv_len))
>  
>  /* for iterating one bio from start to end */
> 
> (I find the whole bvec handling a mess of confusing macros and would
> welcome more of it being inline functions, in general).

The above change may bring more code duplication. Meantime, it can't
work because (bvl).bv_len isn't taken into account into bvec_iter_bvec(),
then how can the iterator advance?


Thanks,
Ming

