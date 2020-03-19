Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10EA818B204
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Mar 2020 12:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgCSLE4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Mar 2020 07:04:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45064 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgCSLE4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Mar 2020 07:04:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Z8k5rxxuWJeifREgQU7npm0AxV0O+HvW6zpGtvds6oI=; b=h22azbs6kOrxgCeM2CER1MvB/F
        nzVY1oKsfJNndoqnTYxXjLohFNHtF/549gKeKID2vhuuA8lSt2dcyRkbX5EBjajghlihjYaP5n6fK
        5IkOMlFMNHaEnLF95CW0+s81grvKSTu/KGoPLajsfB6zB0IbgLAd+wFYUq+/fT+R4GD4GOyROFBxS
        zOPEXB4pMkv4HDMRRfapcGp9lQmencPDW2201XRwlxAK0V2l+CJe3cnriFSBHoidGjPcls3090U7R
        GJyP2/+y4iy1LuvGqWTpiMrAm/CtyYE3dqT+yLXX5o2858rAVGYP3DDDV3QwJ39c+SfchouVOj3Aj
        OvOuBEFQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jEsyu-0004gA-Es; Thu, 19 Mar 2020 11:04:56 +0000
Date:   Thu, 19 Mar 2020 04:04:56 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v8 03/11] block: Make blk-integrity preclude hardware
 inline encryption
Message-ID: <20200319110456.GB20097@infradead.org>
References: <20200312080253.3667-1-satyat@google.com>
 <20200312080253.3667-4-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312080253.3667-4-satyat@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 12, 2020 at 01:02:45AM -0700, Satya Tangirala wrote:
> There's no hardware currently that supports both integrity and inline
> encryption. However, it seems possible that there will be in the near
> future, based on discussion at
> https://lore.kernel.org/r/20200108140730.GC2896@infradead.org/
> But properly integrating both features is not trivial, and without
> real hardware that implements both, it is difficult to tell if it will
> be done correctly by the majority of hardware that support both, and
> through discussions at
> https://lore.kernel.org/r/20200224233459.GA30288@infradead.org/
> it seems best not to support both features together right now, and
> to decide what to do at probe time.

Please don't reference web links, just inline the important information.

> diff --git a/block/bio-integrity.c b/block/bio-integrity.c
> index bf62c25cde8f..a5c57991c6fa 100644
> --- a/block/bio-integrity.c
> +++ b/block/bio-integrity.c
> @@ -42,6 +42,11 @@ struct bio_integrity_payload *bio_integrity_alloc(struct bio *bio,
>  	struct bio_set *bs = bio->bi_pool;
>  	unsigned inline_vecs;
>  
> +	if (bio_has_crypt_ctx(bio)) {
> +		pr_warn("blk-integrity can't be used together with inline en/decryption.");
> +		return ERR_PTR(-EOPNOTSUPP);
> +	}

This is a hard error and should just be a WARN_ON_ONCE.

I'm also not sure we need the register time warnings at all.
