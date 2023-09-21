Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EAC77A911E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 05:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjIUDA0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 23:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjIUDAZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 23:00:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28006ED;
        Wed, 20 Sep 2023 20:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8sk477uHnFXQ+2aa1pfL1ogkhuR7b7/UGiLtlLYg7XU=; b=v4DQLotivgOEtTMBER7F2GC/ey
        aw4w53dhcQs1T9NHPOcUhJOXji2BQ8kPxwH6X6fekbme8HyyeEEcrlMclPL8kLNKA5pog6TQ58Cp/
        xORS6/gx9kjvTH+SEsQLOhnexmoVn7/iDOA2P26NVIll2qRJWpF8gcL6maYmrNDXjg9xLeWhodiif
        PWHNsat9IdmoroEgZ08RCz2sj051mxgmUqJ6jk3tDM6PX96ygCx5enuNWq0zciM3c7ohNV1lnove+
        IyZKE2/gTBBFEaO2iaShQEZuLGig6l/yktw5Z3LLuRVux3i7YT9bS8/qq2oL6ynRnZcxU3muwpuHB
        QrpuVtRw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qj9vI-004qfG-0U;
        Thu, 21 Sep 2023 03:00:12 +0000
Date:   Wed, 20 Sep 2023 20:00:12 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        Pankaj Raghav <kernel@pankajraghav.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        da.gomez@samsung.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        djwong@kernel.org, linux-mm@kvack.org, chandan.babu@oracle.com,
        gost.dev@samsung.com, riteshh@linux.ibm.com
Subject: Re: [RFC 00/23] Enable block size > page size in XFS
Message-ID: <ZQuxvAd2lxWppyqO@bombadil.infradead.org>
References: <20230915183848.1018717-1-kernel@pankajraghav.com>
 <ZQd4IPeVI+o6M38W@dread.disaster.area>
 <ZQewKIfRYcApEYXt@bombadil.infradead.org>
 <CGME20230918050749eucas1p13c219481b4b08c1d58e90ea70ff7b9c8@eucas1p1.samsung.com>
 <ZQfbHloBUpDh+zCg@dread.disaster.area>
 <806df723-78cf-c7eb-66a6-1442c02126b3@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <806df723-78cf-c7eb-66a6-1442c02126b3@samsung.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 18, 2023 at 02:29:22PM +0200, Pankaj Raghav wrote:
> I think this tree doesn't have some of the last minute changes I did
> before I sent the RFC. I will sync with Luis offline regarding that.

OK, we sorted the small changes, and this patch series posted is now rebased
and available here to Linus' v6.6-rc2, for those that want more
stability than the wild wild linux-next:

https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=large-block-linus-nobdev

If you wanna muck with the coexistence stuff, which you will need if you
want to actually use an LBS device, that is this patch series
and then the coexistence stuff:

https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=large-block-linus

Given this is a fresh rebase, I started running fsx on the nobdev branch
which only has this series and managed to get fsx ops up to over 1 million
for:

512 sector size:
  * 16k block size
  * 32k block size
  * 64k block size
4k sector size:
  * 16k block size
  * 32k block size
  * 64k block size

It's at least enough cursory test to git push it. I haven't tested
yet the second branch I pushed though but it applied without any changes
so it should be good (usual famous last words).

  Luis
