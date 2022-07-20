Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDE857BBB6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jul 2022 18:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233188AbiGTQqG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jul 2022 12:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233067AbiGTQqF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jul 2022 12:46:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A28343E79;
        Wed, 20 Jul 2022 09:46:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9BD361DB5;
        Wed, 20 Jul 2022 16:46:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7303AC3411E;
        Wed, 20 Jul 2022 16:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658335564;
        bh=bO/72wAs9HIZh7WXwkr34dOo62ZEdL5rFbqhoO2fP7c=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=uOnLo8FXZZtBjV8LmyAn8IA7rXsobB34IdKFGAni47kX2wGF7tdkC8gsushaGGBuK
         2sSJlHoxQQjKB3SrnoaOnRCVMmXSXxktu8FIhrh1Aj+OnZBg9D4M2QN7nTvWfQ/ikZ
         xhX4Lvpek5FGEkFIhbLTcwTN3+jP8MU3tNh7GUbRb3UeXfB5vSwC2SE7uzvTQjTFUO
         2L0Z2TEwRY2u6cObazkl9/JGUDd0YIDK/J8OFF+4qj3lk9PDEGSNDCm+vcvkOitBYW
         lshGAoI+lCizz0KLw7++Kk0o72pauors5p8ShtXERAmtDiDBeLsF3tLnnEFTqbWmIX
         nSKW5zvyXnHQA==
Message-ID: <ee6a9606c17bd8952504ac4502ccfd46bcfb4343.camel@kernel.org>
Subject: Re: should we make "-o iversion" the default on ext4 ?
From:   Jeff Layton <jlayton@kernel.org>
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     Lukas Czerner <lczerner@redhat.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Date:   Wed, 20 Jul 2022 12:46:01 -0400
In-Reply-To: <7F6417C7-1261-4C98-96B1-CB15744C04C1@redhat.com>
References: <69ac1d3ef0f63b309204a570ef4922d2684ed7f9.camel@kernel.org>
         <20220720141546.46l2d7bxwukjhtl7@fedora>
         <ad7218a41fa8ac26911a9ccb79c87609d4279fea.camel@kernel.org>
         <BAFC8295-B629-49DB-A381-DD592182055D@redhat.com>
         <e84b9caf376a9b958a95ca4e0d088808c482f109.camel@kernel.org>
         <7F6417C7-1261-4C98-96B1-CB15744C04C1@redhat.com>
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

On Wed, 2022-07-20 at 12:29 -0400, Benjamin Coddington wrote:
> On 20 Jul 2022, at 12:15, Jeff Layton wrote:
>=20
> > On Wed, 2022-07-20 at 11:56 -0400, Benjamin Coddington wrote:
> > > On 20 Jul 2022, at 10:38, Jeff Layton wrote:
> > > > On Wed, 2022-07-20 at 16:15 +0200, Lukas Czerner wrote:
> > > > >=20
> > > > > Is there a different way I am not seeing?
> > > > >=20
> > > >=20
> > > > Right, implementing this is the difficult bit actually since this u=
ses a
> > > > MS_* flag.=A0If we do make this the default, we'd definitely want t=
o
> > > > continue allowing "-o noiversion" to disable it.
> > > >=20
> > > > Could we just reverse the default in libmount? It might cause this =
to
> > > > suddenly be enabled in some deployments, but in most cases, people
> > > > wouldn't even notice and they could still specify -o noiversion to =
turn
> > > > it off.
> > > >=20
> > > > Another idea would be to introduce new mount options for this, but
> > > > that's kind of nasty from a UI standpoint.
> > >=20
> > > Is it safe to set SB_I_VERSION at export time?  If so, export_operati=
ons
> > > could grow an ->enable_iversion().
> > >=20
> >=20
> > That sounds like it might be problematic.
> >=20
> > Consider the case where a NFSv4 client has cached file data and the
> > change attribute for the file. Server then reboots, but before the
> > export happens a local user makes a change to the file and it doesn't
> > update the i_version.
>=20
> Nfsd currently uses both ctime and i_version if its available, I'd expect
> that eliminates this case.
>=20

Good point, that probably would. Still, I'd rather we just enable this
wholesale if we can get away with it. There's still some interest in
exposing i_version to userland via statx or the like, so I'd rather not
assume that only nfsd will care about it.
--=20
Jeff Layton <jlayton@kernel.org>
