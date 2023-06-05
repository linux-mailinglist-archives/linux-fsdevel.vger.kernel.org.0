Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B83A57227B6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jun 2023 15:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234122AbjFENoK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jun 2023 09:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjFENoJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jun 2023 09:44:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF2BED;
        Mon,  5 Jun 2023 06:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mCvoAgk8zhYKOoAjq5TY4OQ9rPhl649ZNxRx5rL2Pgk=; b=e00kjrppO7/UDAnEpoZmC5VmeB
        E7eqvoNBSi328I1yZzpw0lKldIjK1ThTD2ydNi6t4PHGUucx35NQa5ecMm28xvQGCrpyDtL7lJqBl
        4m7nOY6IDie9bSDo7UKhjMbU64mjO97fyAloPxrKcx236Krf2g3yyuA1fQtCNgI0lIP73npePLbM7
        ob5/IqEq55gpp9viuo4Cs37S9snTDPe6VyK3CpAZ0Cp7v+p7Q4K6+cgS0ndKVb0FIwjHunEgbAPdS
        +VxyJ0VfdPZZ4klREtVPPzMUShagY9Vu6etyAyUchmf8dKFza+DJQ/rkIS5B7LIDcMcUR9zf6rKBJ
        9BpC9mOA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q6AUn-00FeYT-1D;
        Mon, 05 Jun 2023 13:43:41 +0000
Date:   Mon, 5 Jun 2023 06:43:41 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Nitesh Shetty <nj.shetty@samsung.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        willy@infradead.org, hare@suse.de, djwong@kernel.org,
        bvanassche@acm.org, ming.lei@redhat.com, dlemoal@kernel.org,
        nitheshshetty@gmail.com, gost.dev@samsung.com,
        Kanchan Joshi <joshi.k@samsung.com>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
        Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v12 5/9] nvme: add copy offload support
Message-ID: <ZH3mjUb+yqI11XD8@infradead.org>
References: <20230605121732.28468-1-nj.shetty@samsung.com>
 <CGME20230605122310epcas5p4aaebfc26fe5377613a36fe50423cf494@epcas5p4.samsung.com>
 <20230605121732.28468-6-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230605121732.28468-6-nj.shetty@samsung.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>  		break;
>  	case REQ_OP_READ:
> -		ret = nvme_setup_rw(ns, req, cmd, nvme_cmd_read);
> +		if (unlikely(req->cmd_flags & REQ_COPY))
> +			nvme_setup_copy_read(ns, req);
> +		else
> +			ret = nvme_setup_rw(ns, req, cmd, nvme_cmd_read);
>  		break;
>  	case REQ_OP_WRITE:
> -		ret = nvme_setup_rw(ns, req, cmd, nvme_cmd_write);
> +		if (unlikely(req->cmd_flags & REQ_COPY))
> +			ret = nvme_setup_copy_write(ns, req, cmd);
> +		else
> +			ret = nvme_setup_rw(ns, req, cmd, nvme_cmd_write);

Yikes.  Overloading REQ_OP_READ and REQ_OP_WRITE with something entirely
different brings us back the horrors of the block layer 15 years ago.
Don't do that.  Please add separate REQ_COPY_IN/OUT (or maybe
SEND/RECEIVE or whatever) methods.

> +	/* setting copy limits */
> +	if (blk_queue_flag_test_and_set(QUEUE_FLAG_COPY, q))

I don't understand this comment.

> +struct nvme_copy_token {
> +	char *subsys;
> +	struct nvme_ns *ns;
> +	sector_t src_sector;
> +	sector_t sectors;
> +};

Why do we need a subsys token?  Inter-namespace copy is pretty crazy,
and not really anything we should aim for.  But this whole token design
is pretty odd anyway.  The only thing we'd need is a sequence number /
idr / etc to find an input and output side match up, as long as we
stick to the proper namespace scope.

> +	if (unlikely((req->cmd_flags & REQ_COPY) &&
> +				(req_op(req) == REQ_OP_READ))) {
> +		blk_mq_start_request(req);
> +		return BLK_STS_OK;
> +	}

This really needs to be hiden inside of nvme_setup_cmd.  And given
that other drivers might need similar handling the best way is probably
to have a new magic BLK_STS_* value for request started but we're
not actually sending it to hardware.
