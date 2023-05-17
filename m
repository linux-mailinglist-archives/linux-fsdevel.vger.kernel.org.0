Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11B57061E3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 May 2023 09:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjEQH6M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 May 2023 03:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjEQH6K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 May 2023 03:58:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69D5E4;
        Wed, 17 May 2023 00:58:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72AF464325;
        Wed, 17 May 2023 07:58:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C02DC433EF;
        Wed, 17 May 2023 07:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684310279;
        bh=4m6hHJf40GRbN5HCjWD4MOb/dEzGFKivI6C1OSkBMEI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qh3AVd26rU5eC1E2AEnUgenTvpPLvlwi4DRcXbIc8e8C8i/CHO+wOLNGkBFoAstnI
         7O0Wvk1Rfssf8r0nprsW8gIOj4AKwMKuznlB/YzORrjcVis33vQ0v5Tr5ogFQZbAHy
         B53AHU/7dtumotak9XHwgk9JBZWYiSF7DKdui19zTEnw/XAcKeFp8MO1fF9NVfwhNN
         nyjJd6sTJpj0NMQW7L1cjgYYI+aaPRhQBvqUHFleVVOFtU30A+Ci9p/frXlxOmCTEd
         HVokudSGKzdg10SeSsLbmWQnoomqRLrZs160IQ+BxR/E7hYegmicVDuersLG2Pd2g3
         J2WbvdNfTOhbg==
Date:   Wed, 17 May 2023 09:57:55 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 5/9] block: introduce holder ops
Message-ID: <20230517-einreden-dermatologisch-9c6a3327a689@brauner>
References: <20230505175132.2236632-1-hch@lst.de>
 <20230505175132.2236632-6-hch@lst.de>
 <20230516-kommode-weizen-4c410968c1f6@brauner>
 <20230517073031.GF27026@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230517073031.GF27026@lst.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 17, 2023 at 09:30:31AM +0200, Christoph Hellwig wrote:
> On Tue, May 16, 2023 at 06:00:05PM +0200, Christian Brauner wrote:
> > Looking at this code reminds me that we'll need a block dev lookup
> > function that takes a diskseq argument so we can lookup a block device
> > and check it against the diskseq number we provided so we can detect
> > "media" changes (images on a loop device etc). Idea being to pass
> > diskseq numbers via fsconfig().
> 
> You can already do this by checking right after opening but before
> using it.  In theory we could pass the seq down, and handle it further
> down, but I'm not sure this really solves anything.

BTW, why is there no code to lookup a bdev by O_PATH fd? It seems weird
that a lot of ioctls pass the device path to the kernel (btrfs comes to
mind). I can see certain things that would make this potentially a bit
tricky e.g., you'd not have access to the path/name of the device if you
want to show it somewhere such as in mountinfo but nothing that makes it
impossible afaict.

> 
> The main work here really is in the mount code.

Yeah, I'll get to this soon. Josef has mentioned that he'll convert
btrfs to the new mount api this cycle and we have that recorded on
video. And I think that otherwise all block device based filesystems
might have already been converted.
