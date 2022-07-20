Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C304C57B89B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jul 2022 16:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbiGTOif (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jul 2022 10:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiGTOif (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jul 2022 10:38:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA9122298;
        Wed, 20 Jul 2022 07:38:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2579061A59;
        Wed, 20 Jul 2022 14:38:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB1F1C3411E;
        Wed, 20 Jul 2022 14:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658327913;
        bh=EdVnBgwJm4ZOmBl1kVWjnuugcysfSqGPCoS7zTlgmWk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=NsoplAas1FTYHMtyl50MzeaA5zcp0/NgkJqOuhJpfQGqEeZC3BeiIlGXOXuJDrSUB
         3BR769FZ6lj7cw0QzA7zhKFaopJmHNyRhtSznugqA1A/P2vPX/oXajGNhAeERjdLEm
         jdIhFdNaPRX3U5V07QVhCR8JLFzGEaQq0pvfMye1xQr2l+L2XXDAiq0O6ATruLjRfc
         ZLMww3X9Bx1JPijCtf5cywDi/iZKxd44mPQ1iz07Ep7UbjKEEnGsMIcyzg3QW2y+pQ
         yui8z8wjLqEe8o97JAhCWaACc1OQgTUiXasw2EOC+MCnTGYA/kJd4GVZy4NMikNGIA
         EUOxQ5zIm5UJQ==
Message-ID: <ad7218a41fa8ac26911a9ccb79c87609d4279fea.camel@kernel.org>
Subject: Re: should we make "-o iversion" the default on ext4 ?
From:   Jeff Layton <jlayton@kernel.org>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Benjamin Coddington <bcodding@redhat.com>
Date:   Wed, 20 Jul 2022 10:38:31 -0400
In-Reply-To: <20220720141546.46l2d7bxwukjhtl7@fedora>
References: <69ac1d3ef0f63b309204a570ef4922d2684ed7f9.camel@kernel.org>
         <20220720141546.46l2d7bxwukjhtl7@fedora>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2022-07-20 at 16:15 +0200, Lukas Czerner wrote:
> On Tue, Jul 19, 2022 at 09:51:33AM -0400, Jeff Layton wrote:
> > Back in 2018, I did a patchset [1] to rework the inode->i_version
> > counter handling to be much less expensive, particularly when no-one is
> > querying for it.
> >=20
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
> >=20
> > Thoughts?
> >=20
> > [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git=
/commit/?id=3Da4b7fd7d34de5765dece2dd08060d2e1f7be3b39
> > [2]: https://bugzilla.redhat.com/show_bug.cgi?id=3D2107587
>=20
> Hi,
>=20
> I don't have the results myself yet, but a quick look at how it is done
> suggests that indeed the impact should be low. But not zero, at least
> every time the inode is loaded from disk it is scheduled for i_version
> update on the next attempted increment. Could that have an effect on
> some particular common workload you can think of?
>=20

Yeah, it's not zero, but hopefully any performance hit would end up
amortized over the long term use of the inode. In the common situation
where the i_version flag hasn't been queried, this just ends up being an
extra atomic fetch to look at i_version and detect that.

> How would we approach making iversion a default? libmount is passing
> this option to the kernel as just a MS_I_VERSION flag that is set when
> -o iversion is used and left empty when the -o noiversion is used. This
> means that while we could make it a default in ext4, we don't have any
> way of knowing whether the user asked for -o noiversion. So that's not
> really an option.
>=20
> Updating the mke2fs/tune2fs to allow setting iversion as a default mount
> option I think has the same problem.
>=20
> So the only way I can see ATM would be to introduce another mountflag
> for libmount to indicate -o noiversion. This way we can make iversion a
> default on ext4 without loosing the information about user provided -o
> noiversion option.
>=20
> Is there a different way I am not seeing?
>=20

Right, implementing this is the difficult bit actually since this uses a
MS_* flag.=A0If we do make this the default, we'd definitely want to
continue allowing "-o noiversion" to disable it.

Could we just reverse the default in libmount? It might cause this to
suddenly be enabled in some deployments, but in most cases, people
wouldn't even notice and they could still specify -o noiversion to turn
it off.

Another idea would be to introduce new mount options for this, but
that's kind of nasty from a UI standpoint.

>=20
> If we can do reasonably extensive testing that will indeed show
> negligible impact when nothing is querying i_version, then I would be in
> favor of the change.
>=20

Excellent! I think that would be best if we can get away with it. A lot
of people are currently running ext4-backed nfs servers and aren't using
that mount option.
--=20
Jeff Layton <jlayton@kernel.org>
