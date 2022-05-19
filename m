Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3BE52DFFC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 May 2022 00:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245473AbiESWbn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 May 2022 18:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233817AbiESWbm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 May 2022 18:31:42 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2822DB2278;
        Thu, 19 May 2022 15:31:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 751D5CE2342;
        Thu, 19 May 2022 22:31:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD56CC385AA;
        Thu, 19 May 2022 22:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652999496;
        bh=Iaxpi9hTjAW8iCfpRG71IePectgAbW/eCtLlmP4qyK0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IFvIyPHPxqoB6w7qrFLAOkgLYPL+WoxsIPIr2J8LofwbWLLdQYjrbTaUx1Cd5sRRe
         xr+CXAuORJFgmoj8oh8ggViUdxmZ3Ozyb5UatYp/c6m2eH/cZkgitTkQzvaJJt3Gi+
         7LSaTpBrWobaLRe2/2fv/Ype0SzTEYsU2na76LrCe9Pz+2FASDkZk1kGIRTjqDjnyC
         WBCVj3HhyVsOE/F2jqH0NR7UO1/kHJT0oKUBLUZZ3+X9Iv5xxxuInTMCgbCzl0VS9h
         eqNWTQEm47jFKyRtlG2r8gbe8iY0Z+D8yFik3Y2A2uZbwnR7lqzbT3qsVhGG4MeaC8
         fszVaWGJr0yFw==
Date:   Thu, 19 May 2022 16:31:32 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Eric Biggers <ebiggers@kernel.org>, Keith Busch <kbusch@fb.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        axboe@kernel.dk, Kernel Team <Kernel-team@fb.com>,
        bvanassche@acm.org, damien.lemoal@opensource.wdc.com
Subject: Re: [PATCHv2 3/3] block: relax direct io memory alignment
Message-ID: <YobFRH2BCzmQ6lE8@kbusch-mbp.dhcp.thefacebook.com>
References: <20220518171131.3525293-1-kbusch@fb.com>
 <20220518171131.3525293-4-kbusch@fb.com>
 <YoWL+T8JiIO5Ln3h@sol.localdomain>
 <YoWWtwsiKGqoTbVU@kbusch-mbp.dhcp.thefacebook.com>
 <20220519073912.GF22301@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519073912.GF22301@lst.de>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 19, 2022 at 09:39:12AM +0200, Christoph Hellwig wrote:
> On Wed, May 18, 2022 at 07:00:39PM -0600, Keith Busch wrote:
> > How? This patch ensures every segment is block size aligned. We can always
> > split a bio in the middle of a bvec for any lower level hardware constraints,
> > and I'm not finding any splitting criteria that would try to break a bio on a
> > non-block aligned boundary.
> 
> Do you mean bio_vec with segment here?  How do we ensure that?

I may not be understanding what you're asking here, but I'll try to answer.

In this path, we are dealing with ITER_IOVEC type. This patch ensures each
virtually contiguous segment is a block size multiple via the ALIGN_DOWN part
of the patch, and builds the bvec accordingly. An error will occur if the
ALIGN_DOWN ever results in a 0 size, so we will know each segment the user
provided is appropriately sized.

That's not to say each resulting bvec is block sized. Only the sum of all the
bvecs is guaranteed that property.

Consider something like the below userspace snippet reading a 512b sector
crossing a page with an unusual offset. If the two pages are not contiguous:

  bvec[0].bv_offset = 4092
  bvec[0].bv_len = 4

  bvec[1].bv_offset = 0
  bvec[1].bv_len = 508

If they are contiguous, you'd just get 1 bvec with the same bv_offset, but a
512b len.

---
	int ret, fd;
	char *buf;
...
	ret = posix_memalign((void **)&buf, 4096, 8192);
...
	ret = pread(fd, buf + 4092, 512, 0);
--
