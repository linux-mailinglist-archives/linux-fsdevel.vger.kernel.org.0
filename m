Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC846195BE6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Mar 2020 18:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbgC0RFg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Mar 2020 13:05:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44206 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727254AbgC0RFf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Mar 2020 13:05:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nQwtzNXpf86itTjaB1edkzN5h3XvovjaCziQk9DtCjM=; b=tJHUKbZBjsey04PmV3H0dCje7e
        bYKkkq6017QpkZgT1ElJKViJOrTCd7UCVOEZRVRF6tPwwlnll/gKoVxqCy/1XMb/AHQaUrLBj/NC3
        tBw4POPUFD3N/CFouNP73J5J5wYWrOGmz+YqLJ3hKO5+/AhYSOTmdJvvjogLQxzbSLqpgAoASBzgI
        QqiQJeYh+w/7R4WbwSgVu5ZYKTZyajcVh058adQbz/pv1GRD16BS0VUde8wkrh3+gCs0MZljoIzIM
        GJQRxIF3ZihKK2bgZ2ln/osQrAbO/suKfl6oWss51RtXITpHhUsGodIPRNRreKE0Y8uC8VX9l0j3a
        LhqGwHBg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHsQI-0002G0-5a; Fri, 27 Mar 2020 17:05:34 +0000
Date:   Fri, 27 Mar 2020 10:05:34 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Satya Tangirala <satyat@google.com>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v9 02/11] block: Inline encryption support for blk-mq
Message-ID: <20200327170534.GB24682@infradead.org>
References: <20200326030702.223233-1-satyat@google.com>
 <20200326030702.223233-3-satyat@google.com>
 <20200326200511.GA186343@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326200511.GA186343@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 26, 2020 at 01:05:11PM -0700, Eric Biggers wrote:
> > +{
> > +	int i = 0;
> > +	unsigned int inc = bytes >> bc->bc_key->data_unit_size_bits;
> > +
> > +	while (i < BLK_CRYPTO_DUN_ARRAY_SIZE) {
> > +		if (bc->bc_dun[i] + inc != next_dun[i])
> > +			return false;
> > +		/*
> > +		 * If addition of inc to the current entry caused an overflow,
> > +		 * then we have to carry "1" for the next entry - so inc
> > +		 * needs to be "1" for the next loop iteration). Otherwise,
> > +		 * we need inc to be 0 for the next loop iteration. Since
> > +		 * overflow can be determined by (bc->bc_dun[i] + inc)  < inc
> > +		 * we can do the following.
> > +		 */
> > +		inc = ((bc->bc_dun[i] + inc)  < inc);
> > +		i++;
> > +	}
> 
> This comment is verbose but doesn't really explain what's going on.
> I think it would be much more useful to add comments like:

Also the code is still weird.  Odd double whitespaces, expression that
evaluate to bool.

> 
> 		/*
> 		 * If the addition in this limb overflowed, then the carry bit
> 		 * into the next limb is 1.  Else the carry bit is 0.
> 		 */
> 		inc = ((bc->bc_dun[i] + inc)  < inc);

		if (bc->bc_dun[i] + carry < carry)
			carry = 1;
		else
			carry = 0;

> 
> > +blk_status_t __blk_crypto_init_request(struct request *rq,
> > +				       const struct blk_crypto_key *key)
> > +{
> > +	return blk_ksm_get_slot_for_key(rq->q->ksm, key, &rq->crypt_keyslot);
> > +}
> 
> The comment of this function seems outdated.  All it does it get a keyslot, but
> the comment talks about initializing "crypto fields" (plural).

This is a classic case where I think the top of the function comment
is entirely useless. If there is a single caller in core code and the
function is completely trivial, there really is no point in a multi-line
comment.  Comment should explain something unexpected or non-trivial,
while much of the comments in this series are just boilerplate making
the code harder to read.

> >  	blk_queue_bounce(q, &bio);
> >  	__blk_queue_split(q, &bio, &nr_segs);
> > @@ -2002,6 +2006,14 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
> >  
> >  	cookie = request_to_qc_t(data.hctx, rq);
> >  
> > +	ret = blk_crypto_init_request(rq, bio_crypt_key(bio));
> > +	if (ret != BLK_STS_OK) {
> > +		bio->bi_status = ret;
> > +		bio_endio(bio);
> > +		blk_mq_free_request(rq);
> > +		return BLK_QC_T_NONE;
> > +	}
> > +
> >  	blk_mq_bio_to_request(rq, bio, nr_segs);
> 
> Wouldn't it make a lot more sense to do blk_crypto_init_request() after
> blk_mq_bio_to_request() rather than before?
> 
> I.e., initialize request::crypt_ctx first, *then* get the keyslot.  Not the
> other way around.
> 
> That would allow removing the second argument to blk_crypto_init_request() and
> removing bio_crypt_key().  blk_crypto_init_request() would only need to take in
> the struct request.

And we can fail just the request on an error, so yes this doesn't
seem too bad.
