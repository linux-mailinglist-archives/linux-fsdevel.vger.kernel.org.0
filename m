Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C85BBD5C79
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2019 09:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730279AbfJNH2w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Oct 2019 03:28:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55528 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728811AbfJNH2v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Oct 2019 03:28:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QJ5EW5ff7pmcGUbSLwYEYEOoJqNr7X6VvllZr/eSBh0=; b=IR4Q83C+T53loqKsaRD0rTPlD
        q/GSVzxCVVDhfLlq4L7E1crnpazbnftDQw3Tvl7PP1S/ddKVYB4Ua1WLtdnaMqy6rMAgpB1trQuXH
        CQh/CMB2omkADp8AV+cXNrslK+jx2DK982kECm439o9OxPuh+eGLSt2ayPM8f904jkuj2RfzdtVBe
        L7UEV/QZZc+CTFEzFQDQFOVPdlxI/w3q/xxxiccJ1GJJ+gfm4asduoeqmT0fp4gpg2ygKU5EUmxjE
        BLuV1k1s4QseuY5XZFV0unWN+PDN1b24usAzgmP9uncW6p4bS9JGxRMV1Xeauph0+GoylljapH01h
        u5NQzK8+Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iJumf-0005oY-N6; Mon, 14 Oct 2019 07:28:49 +0000
Date:   Mon, 14 Oct 2019 00:28:49 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH v2] loop: fix no-unmap write-zeroes request behavior
Message-ID: <20191014072849.GA11648@infradead.org>
References: <20191010170239.GC13098@magnolia>
 <20191011160545.GD13098@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011160545.GD13098@magnolia>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

While this looks generally good to me, I have another nitpick to avoid
code duplication.  What about just renaming lo_discard to lo_fallocate
and pass the mode (possibly minus the FALLOC_FL_KEEP_SIZE flag) to it?

The in the do_req_filebacked we could further simplify it down to:

  	case REQ_OP_WRITE_ZEROES:
		/*
		 * If the caller doesn't want deallocation, call zeroout to
		 * write zeroes the range.  Otherwise, punch them out.
		 */
		return lo_fallocate(lo, rq, pos,
			(rq->cmd_flags & REQ_NOUNMAP) ?
				FALLOC_FL_ZERO_RANGE : FALLOC_FL_PUNCH_HOLE);
		break;
	case REQ_OP_DISCARD:
		return lo_fallocate(lo, rq, pos, FALLOC_FL_PUNCH_HOLE);
