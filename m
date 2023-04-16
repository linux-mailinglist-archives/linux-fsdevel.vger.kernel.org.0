Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9686E3557
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Apr 2023 08:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbjDPGG6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Apr 2023 02:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjDPGG5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Apr 2023 02:06:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887571BC0;
        Sat, 15 Apr 2023 23:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=870+ju68AUkL3/ICw4Z6V/MOWACfncjZgY2GQzuwtCw=; b=ExDpi3BVATUPdHlZ6seMw2Iqsk
        9sCYv3O6DKwnCLHyLpQVJ8ijk/2pv1T6DtXfsV0Jyk+8ho/61G52Klxkha0Hm5f+v8d49DVHjQm4y
        T8R6SOJAKi5fZg2s7KELpuUwoD/y9noQczjAFqoS1D+F/0dxWahTrMfA9Z3QWc/5NLOUV5GTz4cTW
        tUgQsF8wvWg499CoZOStihUiw461Ql6bbwePhkbwuT6IWpiJ7ZrmfUOVTx82WkEB9oLeyoCBEy7/3
        uf4w8T4AGdBZjKQ7XAPnpsI1wL4pfNIQrOsC27t5Ut8lGFwFV4cD4PhhLTiDf6cLArckA9tTQzbAo
        MzZPUNQg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pnvWz-00DChS-0J;
        Sun, 16 Apr 2023 06:06:33 +0000
Date:   Sat, 15 Apr 2023 23:06:33 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Sergei Shtepa <sergei.shtepa@veeam.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Donald Buczek <buczek@molgen.mpg.de>, axboe@kernel.dk,
        corbet@lwn.net, snitzer@kernel.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, willy@infradead.org, kch@nvidia.com,
        martin.petersen@oracle.com, vkoul@kernel.org, ming.lei@redhat.com,
        gregkh@linuxfoundation.org, linux-block@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 02/11] block: Block Device Filtering Mechanism
Message-ID: <ZDuQacsbY889iVYH@infradead.org>
References: <20230404140835.25166-1-sergei.shtepa@veeam.com>
 <20230404140835.25166-3-sergei.shtepa@veeam.com>
 <793db44e-9e6d-d118-3f88-cdbffc9ad018@molgen.mpg.de>
 <ZDT9PjLeQgjVA16P@infradead.org>
 <50d131e3-7528-2064-fbe6-65482db46ae4@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50d131e3-7528-2064-fbe6-65482db46ae4@veeam.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 12, 2023 at 12:43:40PM +0200, Sergei Shtepa wrote:
> We can consider a block device as a resource that two actor want to take over.
> There are two possible behavioral strategies:
> 1. If one owner occupies a resource, then for other actors, the ownership
> request will end with a refusal. The owner will not lose his resource.
> 2. Any actor can take away a resource from the owner and inform him about its
> loss using a callback.
> 
> I think the first strategy is safer. When calling ioctl BLKFILTER_ATTACH, the
> kernel informs the actor that the resource is busy.
> Of course, there is still an option to grab someone else's occupied resource.
> To do this, he will have to call ioctl BLKFILTER_DETACH, specifying the name
> of the filter that needs to be detached. It is assumed that such detached
> should be performed by the same actor that attached it there.

Yes.

> If we replace the owner at each ioctl BLKFILTER_ATTACH, then we can get a
> situation of competition between two actors. At the same time, they won't
> even get a message that something is going wrong.

> With the second strategy, both tools will unload each other's filters. In the
> best case, this will lead to disruption of their work. At a minimum, blksnap,
> when detached, will reset the change tracker and each backup will perform a
> full read of the block device. As a result, the user will receive distorted
> data, the system will not work as planned, although there will be no error
> message.

Exactly.  Silent replacement is a bad idea.  Maybe we can stupport
multiple filters, but I'm not entirely sold on that either.  But
silently replacing an existing one is a bad idea.
