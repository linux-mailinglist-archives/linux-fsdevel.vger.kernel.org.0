Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8736D66DB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Apr 2023 17:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233419AbjDDPKi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Apr 2023 11:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjDDPKh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Apr 2023 11:10:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D100B359F;
        Tue,  4 Apr 2023 08:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cHuev+laSziwM6gdDJJLMMaZ0GcoHaV1uuy1JEfyFtc=; b=uky0j7p+uWkVvEltGHje+zBvuO
        kQbp4NB8YRI6wz4uhmKAmwNXlIqIv5Dw0ID0havkpzNnYFJBuw7ukyiMWCfLGzuy3EtsOWiPk5kXq
        9ulBSJ/BDfxNvcpzxfc5kSDU2s0rFXwyyxSh+eedLMsLQaK01K8Dij8DG2bnVfQvnvKn+HN04NObd
        C8ucFJAz+e6MyJDoTgPiuojD+U+zPIpAMTkgxdjH65pzECkdpMitUEB5uosoISC2cuAi6fr0rfBqw
        2/Pcgdne+lXRPJrSTj5HY9Zsz06qTVzDuU3W6piYfRBEmAMMNdbRVz9w2JwVmr1J7KvS0Dd+d03Lg
        +lC69xrg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pjiIp-001wQV-1c;
        Tue, 04 Apr 2023 15:10:31 +0000
Date:   Tue, 4 Apr 2023 08:10:31 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     axboe@kernel.dk, minchan@kernel.org, martin@omnibond.com,
        hubcap@omnibond.com, brauner@kernel.org, viro@zeniv.linux.org.uk,
        senozhatsky@chromium.org, akpm@linux-foundation.org,
        willy@infradead.org, hch@lst.de, devel@lists.orangefs.org,
        mcgrof@kernel.org, linux-block@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, gost.dev@samsung.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] mpage: use folios in bio end_io handler
Message-ID: <ZCw950vAgKCaV00d@infradead.org>
References: <20230403132221.94921-1-p.raghav@samsung.com>
 <CGME20230403132225eucas1p15848db3c850e950b21b339d5861080e1@eucas1p1.samsung.com>
 <20230403132221.94921-5-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403132221.94921-5-p.raghav@samsung.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +	bio_for_each_folio_all(fi, bio) {
> +		if (!err)
> +			folio_mark_uptodate(fi.folio);
> +		else
> +			folio_set_error(fi.folio);
> +		folio_unlock(fi.folio);

Super nitpicky, but I'd avoid inverted conditions unless there is a
very clear benefit.  I.e. I'd rather write this as:

		if (err)
			folio_set_error(fi.folio);
		else
			folio_mark_uptodate(fi.folio);

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
