Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7799B719517
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jun 2023 10:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbjFAILL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jun 2023 04:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbjFAILL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jun 2023 04:11:11 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5159F;
        Thu,  1 Jun 2023 01:11:10 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7D53867373; Thu,  1 Jun 2023 10:11:06 +0200 (CEST)
Date:   Thu, 1 Jun 2023 10:11:05 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 02/13] block: refactor bd_may_claim
Message-ID: <20230601081105.GA31903@lst.de>
References: <20230518042323.663189-1-hch@lst.de> <20230518042323.663189-3-hch@lst.de> <20230530114148.zobtxdurit24pqev@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530114148.zobtxdurit24pqev@quack3>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 30, 2023 at 01:41:48PM +0200, Jan Kara wrote:
> > +	if (bdev->bd_holder) {
> > +		/*
> > +		 * The same holder can always re-claim.
> > +		 */
> > +		if (bdev->bd_holder == holder)
> > +			return true;
> > +		return false;
> 
> With this simple condition I'd just do:
> 		/* The same holder can always re-claim. */
> 		return bdev->bd_holder == holder;

As of this patch this makes sense, and I did in fact did it that
way first.  But once we start checking the holder ops we need
the eplcicit conditional, so I decided to start out with this more
verbose option to avoid churn later.
