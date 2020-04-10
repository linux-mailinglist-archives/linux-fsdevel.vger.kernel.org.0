Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0741A4296
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Apr 2020 08:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgDJGi5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Apr 2020 02:38:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46070 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbgDJGi5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Apr 2020 02:38:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EDsZPBaYxjmeeSKNba2hHhKrT35+z0X24bnAwnHD/r0=; b=WQ5ujMJ7K7UMWQSL9KRsEsyqpe
        lNtl1RbbjDj9iwGKeF8NekLSN+4leb9L0iNV1Fss09Ju15AEE0HYpk9e1hjCheurNvfEWp+f8LIhq
        b+rnfMBUIPa85/ipsMrWb6AD2DcAi5gnmT2VPwsvIja1/2/qmKf5bwujephvb0T2yXoztTBALmm/R
        7y/wJ0Q6+61+RZ3CBN0AfoSo3fM4n1VQE63JvS3Xr4vGwLspi1SZjsidmL1vEr/RqSUFpdmDbKfZV
        M+SQg+tKw7peUEIUgwZgWwPQAoIePzvp2Fvh4M7FVV/JxEVI+zQ0GD7Fu7TsLm0jlZj/jWy6iJVoL
        ThxraDOg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jMnJX-00012x-1E; Fri, 10 Apr 2020 06:38:55 +0000
Date:   Thu, 9 Apr 2020 23:38:55 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v5 07/10] scsi: sd_zbc: emulate ZONE_APPEND commands
Message-ID: <20200410063855.GC4791@infradead.org>
References: <20200409165352.2126-1-johannes.thumshirn@wdc.com>
 <20200409165352.2126-8-johannes.thumshirn@wdc.com>
 <20200410061822.GB4791@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200410061822.GB4791@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 09, 2020 at 11:18:22PM -0700, Christoph Hellwig wrote:
> On Fri, Apr 10, 2020 at 01:53:49AM +0900, Johannes Thumshirn wrote:
> > +	if (req_op(rq) == REQ_OP_ZONE_APPEND) {
> > +		ret = sd_zbc_prepare_zone_append(cmd, &lba, nr_blocks);
> > +		if (ret) {
> > +			scsi_free_sgtables(cmd);
> > +			return ret;
> > +		}
> > +	}
> 
> So actually.
> 
> I've been trying to understand the lifetime of the sgtables.  Shouldn't
> we free them in the midayer ->init_command returned BLK_STS_*RESOURCE
> instead?  It seems like this just catches one particular error instead
> of the whole category?  The end of scsi_queue_rq seem like a particular
> good place, as that also releases the resources for the "hard" errors.

Looking more the situation seems even worse.  If scsi_mq_prep_fn
isn't successfull we never seem to free the sgtables, even for fatal
errors.  So I think we need a real bug fix here in front of the series.
