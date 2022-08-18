Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E745981DC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Aug 2022 13:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243617AbiHRLBG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Aug 2022 07:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240270AbiHRLBF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Aug 2022 07:01:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2CF97D64;
        Thu, 18 Aug 2022 04:01:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 28632B8214A;
        Thu, 18 Aug 2022 11:01:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FD3DC433C1;
        Thu, 18 Aug 2022 11:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660820458;
        bh=BJ9jTJMSUZzXkT+DShf3+Vd6Whwr/ZEx748U0LZgPQ8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=qy3yjV6lCpwWA0WKIPLxfSe7qgVUn95t+nHcrj6OEr4CFtmS2MkHcRgEe54X3eG+x
         3cr6G6Hd+NweXZ43gxA4KXnn1b8YUdZwuh8BQhN/+aA+m5/fVOaIkqRIseecDd3IyQ
         yEvAraJktMoqlorBj6QJB1+Q0X4pqNODCqMC2v0AOHUSEVcSJO2uPe6EQVlDV1/eCp
         xbjxjT0H77Dejz/s1OC/1QDm1JL0EYLpvLQs4R2c4rq+Bqpg3sT5KjOPxevjYdLLLD
         OUlKuDJ+voQNwqDOUlJVmrYQcdT5tsO2HTcAGYJQia2FH0/oPdqSAbVPCujB/CfoiW
         szqz0Z3201s9w==
Message-ID: <ae80e71722385a85bb0949540bb4bd0a796a2e34.camel@kernel.org>
Subject: Re: [PATCH] xfs: fix i_version handling in xfs
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>, Dave Chinner <david@fromorbit.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Date:   Thu, 18 Aug 2022 07:00:56 -0400
In-Reply-To: <166078288043.5425.8131814891435481157@noble.neil.brown.name>
References: <20220816131736.42615-1-jlayton@kernel.org>
        , <Yvu7DHDWl4g1KsI5@magnolia>
        , <e77fd4d19815fd661dbdb04ab27e687ff7e727eb.camel@kernel.org>
        , <20220816224257.GV3600936@dread.disaster.area>
         <166078288043.5425.8131814891435481157@noble.neil.brown.name>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2022-08-18 at 10:34 +1000, NeilBrown wrote:
> On Wed, 17 Aug 2022, Dave Chinner wrote:
> >=20
> > In XFS, we've defined the on-disk i_version field to mean
> > "increments with any persistent inode data or metadata change",
> > regardless of what the high level applications that use i_version
> > might actually require.
> >=20
> > That some network filesystem might only need a subset of the
> > metadata to be covered by i_version is largely irrelevant - if we
> > don't cover every persistent inode metadata change with i_version,
> > then applications that *need* stuff like atime change notification
> > can't be supported.
>=20
> So what you are saying is that the i_version provided by XFS does not
> match the changeid semantics required by NFSv4.  Fair enough.  I guess
> we shouldn't use the one to implement the other then.
>=20
> Maybe we should just go back to using ctime.  ctime is *exactly* what
> NFSv4 wants, as long as its granularity is sufficient to catch every
> single change.  Presumably XFS doesn't try to ensure this.  How hard
> would it be to get any ctime update to add at least one nanosecond?
> This would be enabled by a mount option, or possibly be a direct request
> from nfsd.
>=20

I think that would be an unfortunate outcome, but if we can't stop xfs
from bumping the i_version on atime updates, then we may have no choice
but to do so. I suppose we could add a fetch_iversion for xfs that takes
it back to using the ctime.

> <rant>NFSv4 changeid is really one of the more horrible parts of the
> design</rant>
>=20

Hah! I was telling Tom Talpey yesterday that I thought that the change
counter was one of the best ideas in NFSv4 and that we should be trying
to get all filesystems to implement it correctly.

The part that does suck about the design is that the original specs
weren't specific enough about its behavior. I think that's been somewhat
remedied in more recent RFCs though.
--=20
Jeff Layton <jlayton@kernel.org>
