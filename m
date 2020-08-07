Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB79B23EEC4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Aug 2020 16:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgHGOMO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Aug 2020 10:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbgHGOMF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Aug 2020 10:12:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA5AC061756;
        Fri,  7 Aug 2020 07:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=X4HvivKxs4JnWuaKwX6bcx1NKb6uODngs3oeNIMTkPI=; b=TNiS7VCE4rF3DJ+iptLazUJtN0
        nV9TbHNLVeNlNXmmcrrLWXfFtcfirlHvcYzrcpksjZtBVq57vcprsC3MEE2Lpc5Okx4pHl1Ab88+z
        RpsMoCj+L5lZhUc0ncq33fiyaPPtSxIVHN27pGdstdTiBQUBxKngnHpXEAcgsF0Qt24dNrj63btjL
        Z6uJWVap6trIM7vrMOF+tv7c+Uy6LOt470XNluKHuqZnbtnJ9+4m3WpEvDS1979Fz1Pz854HdJ/9b
        x+rqHflT+6UULcnU/hlatXwLGvWDNlttB2D76HgHK6Zv8WD3LfdQURoqyRV2k1yfnlEyEdbjRf6vL
        fNNMtzKg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k4364-0005Ld-Ot; Fri, 07 Aug 2020 14:11:48 +0000
Date:   Fri, 7 Aug 2020 15:11:48 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+61acc40a49a3e46e25ea@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: splice: infinite busy loop lockup bug
Message-ID: <20200807141148.GD17456@casper.infradead.org>
References: <00000000000084b59f05abe928ee@google.com>
 <29de15ff-15e9-5c52-cf87-e0ebdfa1a001@I-love.SAKURA.ne.jp>
 <20200807122727.GR1236603@ZenIV.linux.org.uk>
 <20200807123854.GS1236603@ZenIV.linux.org.uk>
 <20200807134114.GA2114050@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807134114.GA2114050@T590>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 07, 2020 at 09:41:14PM +0800, Ming Lei wrote:
> On Fri, Aug 07, 2020 at 01:38:54PM +0100, Al Viro wrote:
> > FWIW, my preference would be to have for_each_bvec() advance past zero-length
> > segments; I'll need to go through its uses elsewhere in the tree first, though
> > (after I grab some sleep),
> 
> Usually block layer doesn't allow/support zero bvec, however we can make
> for_each_bvec() to support it only.
> 
> Tetsuo, can you try the following patch?
> 
> diff --git a/include/linux/bvec.h b/include/linux/bvec.h
> index ac0c7299d5b8..b03c793dd28d 100644
> --- a/include/linux/bvec.h
> +++ b/include/linux/bvec.h
> @@ -117,11 +117,19 @@ static inline bool bvec_iter_advance(const struct bio_vec *bv,
>  	return true;
>  }
>  
> +static inline void bvec_iter_skip_zero_vec(const struct bio_vec *bv,
> +		struct bvec_iter *iter)
> +{
> +	iter->bi_idx++;
> +	iter->bi_bvec_done = 0;
> +}
> +
>  #define for_each_bvec(bvl, bio_vec, iter, start)			\
>  	for (iter = (start);						\
>  	     (iter).bi_size &&						\
> -		((bvl = bvec_iter_bvec((bio_vec), (iter))), 1);	\
> -	     bvec_iter_advance((bio_vec), &(iter), (bvl).bv_len))
> +		((bvl = bvec_iter_bvec((bio_vec), (iter))), 1);		\
> +	  (bvl).bv_len ? bvec_iter_advance((bio_vec), &(iter), (bvl).bv_len) : \
> +			bvec_iter_skip_zero_vec((bio_vec), &(iter)))

Uhm, bvec_iter_advance() already skips over zero length bio_vecs.

        while (bytes && bytes >= bv[idx].bv_len) {
                bytes -= bv[idx].bv_len;
                idx++;
        }

The problem is when the _first_ bio_vec is zero length.  Maybe something more
like this (which doesn't even compile, but hopefully makes my point):

@@ -86,12 +86,24 @@ struct bvec_iter_all {
        (mp_bvec_iter_page((bvec), (iter)) +                    \
         mp_bvec_iter_page_idx((bvec), (iter)))
 
-#define bvec_iter_bvec(bvec, iter)                             \
-((struct bio_vec) {                                            \
-       .bv_page        = bvec_iter_page((bvec), (iter)),       \
-       .bv_len         = bvec_iter_len((bvec), (iter)),        \
-       .bv_offset      = bvec_iter_offset((bvec), (iter)),     \
-})
+static inline bool bvec_iter_bvec(struct bio_vec *bv, struct bio_vec *bvec,
+               struct bvec_iter *iter)
+{
+       unsigned int idx = iter->bi_idx;
+
+       if (!iter->bi_size)
+               return false;
+
+       while (!bv[idx].bv_len)
+               idx++;
+       iter->bi_idx = idx;
+
+       bv->bv_page = bvec_iter_page(bvec, *iter);
+       bv->bv_len = bvec_iter_len(bvec, *iter);
+       bv->bv_offset = bvec_iter_offset(bvec, *iter);
+
+       return true;
+}
 
 static inline bool bvec_iter_advance(const struct bio_vec *bv,
                struct bvec_iter *iter, unsigned bytes)
@@ -119,8 +131,7 @@ static inline bool bvec_iter_advance(const struct bio_vec *bv,
 
 #define for_each_bvec(bvl, bio_vec, iter, start)                       \
        for (iter = (start);                                            \
-            (iter).bi_size &&                                          \
-               ((bvl = bvec_iter_bvec((bio_vec), (iter))), 1); \
+            bvec_iter_bvec(&(bvl), (bio_vec), &(iter));                \
             bvec_iter_advance((bio_vec), &(iter), (bvl).bv_len))
 
 /* for iterating one bio from start to end */

(I find the whole bvec handling a mess of confusing macros and would
welcome more of it being inline functions, in general).
