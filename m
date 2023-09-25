Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D127ADC62
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Sep 2023 17:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbjIYPxy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Sep 2023 11:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbjIYPxw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Sep 2023 11:53:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D123BB6;
        Mon, 25 Sep 2023 08:53:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE69C433C7;
        Mon, 25 Sep 2023 15:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695657225;
        bh=09qfPPw0Ihsl3Yn+GLcEGbSzfunt9RjssKtlTN6fS8o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tCtYFOgPt9kskmmCJx09JvCJCuTnZ9RMrV6+CBmF2Jud9/76hRlEcO3uvTy3lNOJR
         dd32MwEadx6RUtVCGWJ0iOtOhpMLymO2/iaIqR6fN1k0y2ZrE3Ni4Dnx7CXpRqJo0N
         oCFzU4UvfmgUgmpA7gR5G35qYLZPeM6OAAcMDDEouvYHZfJFC8DprAeQJvw4DCjHLV
         Atjzjm6f80qK2Cr2vASTrVcJwk6NlG7AN41W0TdZ2AUVSIyNM8ocbGCPYs33sI+F6T
         JMWG2Yu7THxwxQdF5pxhv6ArjrB4LPEXIq5G263G0CZ28FGZM33D6OkGxFreDikPjc
         ZGG3dqKZooLIw==
Date:   Mon, 25 Sep 2023 08:53:44 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        brauner@kernel.org,
        syzbot+1fa947e7f09e136925b8@syzkaller.appspotmail.com
Subject: Re: [PATCH] iomap: add a workaround for racy i_size updates on block
 devices
Message-ID: <20230925155344.GA11439@frogsfrogsfrogs>
References: <20230925095133.311224-1-hch@lst.de>
 <20230925150902.GA11456@frogsfrogsfrogs>
 <20230925151816.GA444@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925151816.GA444@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 25, 2023 at 05:18:16PM +0200, Christoph Hellwig wrote:
> On Mon, Sep 25, 2023 at 08:09:02AM -0700, Darrick J. Wong wrote:
> > > +			/*
> > > +			 * This can happen if truncating the block device races
> > > +			 * with the check in the caller as i_size updates on
> > > +			 * block devices aren't synchronized by i_rwsem for
> > > +			 * block devices.
> > 
> > Why /are/ bdevs special like this (not holding i_rwsem during a
> > truncate) anyway?  Is it because we require the sysadmin to coordinate
> > device shrink vs. running programs?
> 
> It's not just truncate, they also don't hold a lock on write.

Oh!  So they don't.  Heh.

> I think the reason is that there is no such things as the block allocator
> and block truncation that happens for block devices, they historically
> had a fixed size, and at some point we allowed to change that size
> by various crude means that are only slowly becoming more standardized
> and formal.  Real block device size changes are about 100% growing of
> the device, as that is an actually useful feature.  Shrinks OTOH are
> usuall a "cute" hack: block drivers set the size to 0 stop I/O when they
> are shut down.  I've been wanting to replace that with an actual check
> in the bdev fd I/O path for a while, but that would also mean the
> shrinking case would still be around, just exercised a lot less.

You call bdev shrink a cute hack, cloud tenants call it a cost-reducing
activity, and cloud vendors call it a revenue opportunity because
shrinking filesystems is un***** expensive in terms of CPU time and IO
usage. ;)

Anyway, I'm not going to argue with longstanding blockdev precedent.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D
