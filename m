Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54BAE61699E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Nov 2022 17:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbiKBQr1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Nov 2022 12:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbiKBQrH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:47:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB83323155;
        Wed,  2 Nov 2022 09:43:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6E185B82169;
        Wed,  2 Nov 2022 16:43:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10634C433D6;
        Wed,  2 Nov 2022 16:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667407434;
        bh=+rW0mC7CHnrJODUazH93fdGpEF7HCAT7IVmZXzZpVdM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I5Idj/CaCGumhEl4rvjNgdlRdePciTkQL/N4HDCgxEn6yKVSm56eCyeTb5jYdkhxN
         ZSQt3cWKGE7ZXORYDUPT7NbjTPoGhun5qCD+cK9hQMpy2Grd0wLRKHT6RskpgFWfkq
         /7a/aZGCfyAXz53GJ5SFIP6gMVADusWb7gaPunCBB9CoVCcNuSWHPLS8Gp1LQ3CuNt
         rm2lzGDi+RaRuAnc2TmQgRVDsXatLYUUnnm9W9aDKTsI3iu2Aw/v5O9VOraRHRxs7T
         0PW6qUrv0VRCmChySNeLuH3EX+FXQE0CpLAOpF/51BrpgnAoaURscHFYGfH0AzLD6r
         aLdyuYonWqw6Q==
Date:   Wed, 2 Nov 2022 09:43:53 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 5/7] iomap: write iomap validity checks
Message-ID: <Y2KeSU6w1kMi6Aer@magnolia>
References: <20221101003412.3842572-1-david@fromorbit.com>
 <20221101003412.3842572-6-david@fromorbit.com>
 <Y2IsGbU6bbbAvksP@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2IsGbU6bbbAvksP@infradead.org>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 02, 2022 at 01:36:41AM -0700, Christoph Hellwig wrote:
> On Tue, Nov 01, 2022 at 11:34:10AM +1100, Dave Chinner wrote:
> > +	/*
> > +	 * Now we have a locked folio, before we do anything with it we need to
> > +	 * check that the iomap we have cached is not stale. The inode extent
> > +	 * mapping can change due to concurrent IO in flight (e.g.
> > +	 * IOMAP_UNWRITTEN state can change and memory reclaim could have
> > +	 * reclaimed a previously partially written page at this index after IO
> > +	 * completion before this write reaches this file offset) and hence we
> > +	 * could do the wrong thing here (zero a page range incorrectly or fail
> > +	 * to zero) and corrupt data.
> > +	 */
> > +	if (ops->iomap_valid) {
> > +		bool iomap_valid = ops->iomap_valid(iter->inode, &iter->iomap);
> > +
> > +		if (!iomap_valid) {
> > +			iter->iomap.flags |= IOMAP_F_STALE;
> > +			status = 0;
> > +			goto out_unlock;
> > +		}
> > +	}
> 
> So the design so far has been that everything that applies at a page (or
> now folio) level goes into iomap_page_ops, not iomap_ops which is just
> the generic iteration, and I think we should probably do it that way.

I disagree here -- IMHO the sequence number is an attribute of the
iomapping, not the folio.

> I'm a little disappointed that we need two callout almost next to each
> other, but given that we need to validate with the folio locked, and
> gfs2 wants the callback with the folio unlocked I think we have to do
> it that.

<nod>

--D
