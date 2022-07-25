Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480E5580290
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Jul 2022 18:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235986AbiGYQW2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Jul 2022 12:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236003AbiGYQW1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jul 2022 12:22:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F57817AA4;
        Mon, 25 Jul 2022 09:22:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E00B9B81028;
        Mon, 25 Jul 2022 16:22:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E31A9C341C6;
        Mon, 25 Jul 2022 16:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658766143;
        bh=IOTwnII+NVaJQaT2cuPRVp55oSbZX/q32do6Vju8igY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=FrI6Hm7w5nuBzAVNkNpxMygvTe0yxcYK0FdhH/tuzDWWGb2BIOzGAaeANmnQGcRiR
         zKN1u6vqFxQn9+8yH6cF3Bz+zTqLjEaqEueO8ehaAvds4tsiWaBGY4PvzRuDoBoft7
         sbO2eyFduu/Qi8bdcq5Qo7v1wwaHrH6f0OaAAPoGg6iM2s+blg52vK9LwStxKgvI0H
         0L3tggsuX07QI9iiiVOtFYGXQT4AIi9EzcoxxBxulih2xosUeX+bMqs5qgCi0wBqy7
         kZraKLMULBJEDWDoHFerZsJTumh/aOnZur+LPFXC/3C/dcS3McvydMMEmG8vTFS+eE
         c6yDPvLnWz7Vw==
Message-ID: <7ae8a678f59a49ffeaaa39265d5108135911eeb3.camel@kernel.org>
Subject: Re: should we make "-o iversion" the default on ext4 ?
From:   Jeff Layton <jlayton@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lczerner@redhat.com, Benjamin Coddington <bcodding@redhat.com>
Date:   Mon, 25 Jul 2022 12:22:21 -0400
In-Reply-To: <20220721223244.GP3600936@dread.disaster.area>
References: <69ac1d3ef0f63b309204a570ef4922d2684ed7f9.camel@kernel.org>
         <20220721223244.GP3600936@dread.disaster.area>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2022-07-22 at 08:32 +1000, Dave Chinner wrote:
> On Tue, Jul 19, 2022 at 09:51:33AM -0400, Jeff Layton wrote:
> > Back in 2018, I did a patchset [1] to rework the inode->i_version
> > counter handling to be much less expensive, particularly when no-one is
> > querying for it.
>=20
> Yup, there's zero additional overhead for maintaining i_version in
> XFS when nothing is monitoring it. Updating it comes for free in any
> transaction that modifies the inode, so when writes
> occur i_version gets bumped if timestamps change or allocation is
> required.
>=20
> And when something is monitoring it, the overhead is effectively a
> single "timestamp" update for each peek at i_version the monitoring
> agent makes. This is also largely noise....
>=20
> > Testing at the time showed that the cost of enabling i_version on ext4
> > was close to 0 when nothing is querying it, but I stopped short of
> > trying to make it the default at the time (mostly out of an abundance o=
f
> > caution). Since then, we still see a steady stream of cache-coherency
> > problems with NFSv4 on ext4 when this option is disabled (e.g. [2]).
> >=20
> > Is it time to go ahead and make this option the default on ext4? I don'=
t
> > see a real downside to doing so, though I'm unclear on how we should
> > approach this. Currently the option is twiddled using MS_I_VERSION flag=
,
> > and it's unclear to me how we can reverse the sense of such a flag.
>=20
> XFS only enables SB_I_VERSION based on an on disk format flag - you
> can't turn it on or off by mount options, so it completely ignores
> MS_I_VERSION.
>=20
> > Thoughts?
>=20
> My 2c is to behave like XFS: ignore the mount option and always turn
> it on.

I'd be fine with that, personally.

They could also couple that with a tune2fs flag or something, so you
could still disable it if it were a problem for some reason.

It's unlikely that anyone will really notice however, so turning it on
unconditionally may be the best place to start.
--=20
Jeff Layton <jlayton@kernel.org>
