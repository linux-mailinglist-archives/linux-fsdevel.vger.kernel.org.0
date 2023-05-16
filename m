Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 432147052FC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 May 2023 18:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234310AbjEPQAN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 May 2023 12:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234044AbjEPQAM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 May 2023 12:00:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E8B55A6;
        Tue, 16 May 2023 09:00:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69249633B5;
        Tue, 16 May 2023 16:00:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BF87C433D2;
        Tue, 16 May 2023 16:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684252809;
        bh=uJj8Ytes18zQpjDajAthUUiDgcG/rn69GAIJBpkQwfg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PdfocuoUZfOEDA94Q7wiblgas2RVggIOCtwPuY/YlzdSNFf8HVme6vy4wza4DAkoC
         xog4tKAzVV/NfKdS7FAoOR9XchtrPlRKLbYRiKantCDQJlsd+CkN8CI6C9A5XXyA2X
         /h1+UUtMyuUurSy7w1EFSDHh9uVOyBm/0piKznnsud+OyVKnnwc/TAPpqd/pG6valQ
         aW8VgW0Vh/RYRoKbbmIYmWdtrauLU/8ds+iPwo+h1HifVc+5f1kd03SUXrAllPKko8
         UMzoxAuRRrOkccAoz8d9DvbEDAx98/sgP7UWYS71P1QRc0Im2Eqmvmmxe+S6ULprvO
         C0tP+IsMqweoA==
Date:   Tue, 16 May 2023 18:00:05 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 5/9] block: introduce holder ops
Message-ID: <20230516-kommode-weizen-4c410968c1f6@brauner>
References: <20230505175132.2236632-1-hch@lst.de>
 <20230505175132.2236632-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230505175132.2236632-6-hch@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 05, 2023 at 01:51:28PM -0400, Christoph Hellwig wrote:
> Add a new blk_holder_ops structure, which is passed to blkdev_get_by_* and
> installed in the block_device for exclusive claims.  It will be used to
> allow the block layer to call back into the user of the block device for
> thing like notification of a removed device or a device resize.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>

Looking at this code reminds me that we'll need a block dev lookup
function that takes a diskseq argument so we can lookup a block device
and check it against the diskseq number we provided so we can detect
"media" changes (images on a loop device etc). Idea being to pass
diskseq numbers via fsconfig().
