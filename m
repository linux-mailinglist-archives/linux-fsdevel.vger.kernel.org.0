Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6F01BB432
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 04:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgD1CyG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 22:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726284AbgD1CyG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 22:54:06 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC30EC09B050
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2020 19:54:05 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id x26so9613884pgc.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2020 19:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8X7sjxWfBXEnwlAIccc/BIFynhnhZILqHqql667aJyw=;
        b=MJ2naptCGJtgldjUsJvu9/UwdOT0JmFnfH/+x5mMTpOnQ2ncMJYuaCx4zW6DF/4t4c
         itBoG6k6aRmVzhMwFOtGzK/GZ5wAgSEAxGOR7n6aVsRdnfy4C2qEyzLaIyvp1hd7FrbX
         2ss7j58r/AX/yAF33kt4HFZOxhckH8CumL7yyrLbDKd+RZHObMK5kNIwvj829/j2A5FZ
         37K8QxqtAgS4jMIrpXW9RSPnmwuJf9mpr0FKyCwWjJcjkupDaO8gO+L5QXcrgzSGEMRf
         1I7WtlEw+d+pSjqOzeIEY36vua57zSKEj4NpyxCARWZD+/tZi76RXArDTGag40uTZ4Qx
         N89Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8X7sjxWfBXEnwlAIccc/BIFynhnhZILqHqql667aJyw=;
        b=UUU9AmWC7U2Tutgou9BDIAzP4zVS8ZN37TYD1vtBklOh/K+tFGa0e6AB2iEOv4xL0l
         9J9LXP3x4l39l2i/FxkP9iLNqvp1Dgwgqq5GOQPyQ7Zi7H/oWgqSe0NWAXUHlgTaiUIa
         DOh71Ct+eQ2EDpDkBja0658rVcufEqKa0RYjeik8W6G1TN+E0POKpAGGsQuhjZSECDOP
         h0MLEb2euYdGSi2se66u7Uqtwcl+zr8nLMw1ptucAsuA/nmsAMsTvdYg/NQobvFPYpAW
         fwoiU+Lij4ISvyr/FDUHjkX1M/96brch4Z2kkB08KQfKlxR9MRCfxTNp+goJAnJIU7u7
         /HYg==
X-Gm-Message-State: AGi0PubId58UBeEBTXZ/HpUqRZv5MmJJJbiID87hH+v+nquyMRJpMYTf
        EipbFlQJmX19RXw0MJi5fJNYiA==
X-Google-Smtp-Source: APiQypIEv+gxMsWu08uDFo3qeiz6pIj/YV2Suq5AiiZQNzFqX8Rk/gg5BKQwyeLAGuc9ioMjuiPC6A==
X-Received: by 2002:a62:2783:: with SMTP id n125mr28966313pfn.133.1588042444920;
        Mon, 27 Apr 2020 19:54:04 -0700 (PDT)
Received: from google.com (56.4.82.34.bc.googleusercontent.com. [34.82.4.56])
        by smtp.gmail.com with ESMTPSA id 127sm14238478pfw.72.2020.04.27.19.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 19:54:04 -0700 (PDT)
Date:   Tue, 28 Apr 2020 02:54:00 +0000
From:   Satya Tangirala <satyat@google.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v10 03/12] block: Inline encryption support for blk-mq
Message-ID: <20200428025400.GB52406@google.com>
References: <20200408035654.247908-1-satyat@google.com>
 <20200408035654.247908-4-satyat@google.com>
 <20200422093502.GB12290@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422093502.GB12290@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 22, 2020 at 02:35:02AM -0700, Christoph Hellwig wrote:
> > +/**
> > + * __blk_crypto_bio_prep - Prepare bio for inline encryption
> > + *
> > + * @bio_ptr: pointer to original bio pointer
> > + *
> > + * Succeeds if the bio doesn't have inline encryption enabled or if the bio
> > + * crypt context provided for the bio is supported by the underlying device's
> > + * inline encryption hardware. Ends the bio with error otherwise.
> > + *
> > + * Caller must ensure bio has bio_crypt_ctx.
> > + *
> > + * Return: true on success; false on error (and bio->bi_status will be set
> > + *	   appropriately, and bio_endio() will have been called so bio
> > + *	   submission should abort).
> > + */
> > +bool __blk_crypto_bio_prep(struct bio **bio_ptr)
> > +{
> > +	struct bio *bio = *bio_ptr;
> 
> Why is the bio passed by references?  As far as I can see it is never
> changed.
> 
It's modified by additions in the next patch in the series and I
thought I should introduce the function with the final type from the
get go - is that alright?
> > +
> > +	/* Error if bio has no data. */
> > +	if (WARN_ON_ONCE(!bio_has_data(bio)))
> > +		goto fail;
> > +
> > +	if (!bio_crypt_check_alignment(bio))
> > +		goto fail;
> > +
> > +	/*
> > +	 * Success if device supports the encryption context, and blk-integrity
> > +	 * isn't supported by device/is turned off.
> > +	 */
> > +	if (!blk_ksm_crypto_cfg_supported(bio->bi_disk->queue->ksm,
> > +				&bio->bi_crypt_context->bc_key->crypto_cfg)) {
> 
> The indentation here looks odd.
> 
> > +		bio->bi_status = BLK_STS_NOTSUPP;
> > +		goto fail;
> > +	}
> > +
> > +	return true;
> > +fail:
> > +	bio_endio(*bio_ptr);
> 
> This seems to fail to set a status for the bio_has_data case,
> and setting the status for bio_crypt_check_alignment should be moved
> to here, where we also end the IO.
> 
> > + * __blk_crypto_rq_bio_prep - Prepare a request when its first bio is inserted
> > + *
> > + * @rq: The request to prepare
> > + * @bio: The first bio being inserted into the request
> > + *
> > + * Frees the bio crypt context in the request's old rq->crypt_ctx, if any, and
> > + * moves the bio crypt context of the bio into the request's rq->crypt_ctx.
> > + */
> > +void __blk_crypto_rq_bio_prep(struct request *rq, struct bio *bio)
> > +{
> > +	mempool_free(rq->crypt_ctx, bio_crypt_ctx_pool);
> > +	rq->crypt_ctx = bio->bi_crypt_context;
> > +	bio->bi_crypt_context = NULL;
> > +}
> 
> This seems to be called in case of the both the initial request
> creation and merging a bio into the request (although only the
> front merge and not the back merge, which seems weird).
> 
> But even then the behvior seems odd as bio->bi_crypt_context becomes
> NULL as soon as the bio is attached to a request, which seems like
> a somewhat dangerous condition.  Maybe it works, but is it really worth
> saving a little memory?  Why not just propagate the context of the first
> bio to the request, and free them when the bio is completed?
> 
> Why do we always take the context from the bio instead of keeping
> the one in the request?  After all we merge the bio into the request.
> 
> > +void __blk_crypto_rq_prep_clone(struct request *dst, struct request *src)
> > +{
> > +	dst->crypt_ctx = src->crypt_ctx;
> 
> Probably worth just open coding in the only caller..
> 
> > +
> > +/**
> > + * __blk_crypto_insert_cloned_request - Prepare a cloned request to be inserted
> > + *					into a request queue.
> > + * @rq: the request being queued
> > + *
> > + * Return: BLK_STS_OK on success, nonzero on error.
> > + */
> > +blk_status_t __blk_crypto_insert_cloned_request(struct request *rq)
> > +{
> > +	return blk_crypto_init_request(rq);
> 
> Same.
> 
> >  	__blk_queue_split(q, &bio, &nr_segs);
> > @@ -2011,6 +2015,15 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
> >  
> >  	blk_mq_bio_to_request(rq, bio, nr_segs);
> >  
> > +	ret = blk_crypto_init_request(rq);
> > +	if (ret != BLK_STS_OK) {
> > +		bio->bi_status = ret;
> > +		bio_endio(bio);
> > +		blk_mq_free_request(rq);
> > +		return BLK_QC_T_NONE;
> > +	}
> 
> Didn't Eric have a comment last round that we shoul dtry this before
> attaching the bio to simplify error handling?
> 
In the previous round, I believe Eric commented that I should call
blk_crypto_init_request after bio_to_request so that we can do away
with some of the arguments to blk_crypto_init_request and also a
boilerplate function used only while calling blk_crypto_init_request.
I realize you wrote "And we can fail just the request on an error, so
yes this doesn't seem too bad." in response to this particular
comment of Eric's, and it seems I might not actually have understood
what that meant - did you have something in mind different from what I'm
doing here?

> > +#define BLK_CRYPTO_DUN_ARRAY_SIZE	(BLK_CRYPTO_MAX_IV_SIZE/sizeof(u64))
> 
> Please use whitespace before and after operators.
