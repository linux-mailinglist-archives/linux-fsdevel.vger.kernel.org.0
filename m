Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D86DA74920B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 01:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbjGEXtD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 19:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbjGEXtB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 19:49:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084AA10F5;
        Wed,  5 Jul 2023 16:49:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 86E19616D6;
        Wed,  5 Jul 2023 23:49:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0ED6C433C8;
        Wed,  5 Jul 2023 23:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688600939;
        bh=6DP+UIUGnos6zRt5nWNRf2nJb77uRi/aVfw+fuuR72g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o/iQlmXNsGwyfEygBWpfh/gmBtVYjQIL61c7KHLv6YQ0cZyyH4DQc8LqxM5SZh1ob
         dxNd6UcsRPsIPc+U45reWwAHq7KjACwk0SpM8bBP68ItwX9CxfuRDOV3dgaPE1U7dd
         yeWdVchGwXnw7jSLUv6hKmemhT98C6LD/5Fc8RaRGOPuZ6J8yiKPqMXTVyLLDt/mtm
         wdL14gFEi+oH/2bNgSqomTf+m3ij25EBx1TpwE4DMFVEIt3f4G4l6GwLk4ok6OzmVz
         zgAyGFEukHXOnD7q3QE2owbVgHaUotOkOXQ5IDmj9Ogn5i7mAIYMv7AAy+CiJMaciH
         thhJiIbE0M1/Q==
Date:   Wed, 5 Jul 2023 16:48:59 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        linux-xfs@vger.kernel.org, willy@infradead.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/7] xfs: create a big array data structure
Message-ID: <20230705234859.GV11441@frogsfrogsfrogs>
References: <168506056447.3729324.13624212283929857624.stgit@frogsfrogsfrogs>
 <168506056469.3729324.10116553858401440150.stgit@frogsfrogsfrogs>
 <ZJO4L56mB5o3BJ06@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJO4L56mB5o3BJ06@dread.disaster.area>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 22, 2023 at 12:55:43PM +1000, Dave Chinner wrote:
> On Thu, May 25, 2023 at 05:47:08PM -0700, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > Create a simple 'big array' data structure for storage of fixed-size
> > metadata records that will be used to reconstruct a btree index.  For
> > repair operations, the most important operations are append, iterate,
> > and sort.
> ....
> > +/*
> > + * Initialize a big memory array.  Array records cannot be larger than a
> > + * page, and the array cannot span more bytes than the page cache supports.
> > + * If @required_capacity is nonzero, the maximum array size will be set to this
> > + * quantity and the array creation will fail if the underlying storage cannot
> > + * support that many records.
> > + */
> > +int
> > +xfarray_create(
> > +	struct xfs_mount	*mp,
> > +	const char		*description,
> > +	unsigned long long	required_capacity,
> > +	size_t			obj_size,
> > +	struct xfarray		**arrayp)
> > +{
> > +	struct xfarray		*array;
> > +	struct xfile		*xfile;
> > +	int			error;
> > +
> > +	ASSERT(obj_size < PAGE_SIZE);
> > +
> > +	error = xfile_create(mp, description, 0, &xfile);
> > +	if (error)
> > +		return error;
> 
> The xfarray and xfile can be completely independent of anything XFS
> at all by passing the full xfile "filename" that is to be used here
> rather than having xfile_create prefix the description with a string
> like "XFS (devname):".

Ok, I'll shift the "XFS (devname)" part into the callers for the next
round.

--D

> .....
> 
> Otherwise this is all fine.
> 
> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
