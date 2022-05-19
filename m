Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A877F52C8F1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 02:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbiESAvu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 May 2022 20:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbiESAvs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 May 2022 20:51:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62508340E4;
        Wed, 18 May 2022 17:51:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1BEB4B82280;
        Thu, 19 May 2022 00:51:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8CF5C385A9;
        Thu, 19 May 2022 00:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652921504;
        bh=fwVc+6Xc0iUbXyELkwMo9i9DOVpVDqMPtAxdUfp2NWA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lFCMo8ZCd+I3eZTRU+GEd0Xd9U/0Ru5wqasInnoIq8WylHmP0A6/LLPh817DrOYRL
         oOBFyv6bcGarFAe+lkspi5dCXb/+cGPUSNTx3Yj0J3KBFRZfD8WjeFgn7I0V1ZoAbm
         64MMwc2xPMM0FUf4fxy10+E3fZZIBWgn5KejVRX8OQtg6kic+YHKMs1fPCmjowRnxN
         OfAsZpFqRwc0IxIOyFTRezvZwihbIhDM6Wi+NRU/5WNJiBztC8+ITGmvtRSkkQC+aW
         DD9KcX3DpgFhBmIadesAeyi38Ax7ZdXjdV54QZdn1YzPq0gTVxEOkpXZAfPN1j5RQE
         qqosu7dcq7yjg==
Date:   Wed, 18 May 2022 18:51:41 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Keith Busch <kbusch@fb.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, axboe@kernel.dk,
        Kernel Team <Kernel-team@fb.com>, hch@lst.de,
        bvanassche@acm.org, damien.lemoal@opensource.wdc.com
Subject: Re: [PATCHv2 0/3] direct io alignment relax
Message-ID: <YoWUnTxag7TsCBwa@kbusch-mbp.dhcp.thefacebook.com>
References: <20220518171131.3525293-1-kbusch@fb.com>
 <YoWAnDR/XOwegQNZ@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoWAnDR/XOwegQNZ@gmail.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 18, 2022 at 11:26:20PM +0000, Eric Biggers wrote:
> On Wed, May 18, 2022 at 10:11:28AM -0700, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > Including the fs list this time.
> > 
> > I am still working on a better interface to report the dio alignment to
> > an application. The most recent suggestion of using statx is proving to
> > be less straight forward than I thought, but I don't want to hold this
> > series up for that.
> > 
> 
> Note that I already implemented the statx support and sent it out for review:
> https://lore.kernel.org/linux-fsdevel/20220211061158.227688-1-ebiggers@kernel.org/T/#u
> However, the patch series only received one comment.  I can send it out again if
> people have become interested in it again...

Thanks, I didn't see that the first time around, but I'll be sure to look at
your new version. It sounds like you encountered the same problem I did
regarding block device handles: the devtmpfs inodes for the raw block device
handles are not the bdev inodes. I do think it's useful the alignment
attributes are accessible through the block device files, though.
