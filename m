Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52AD257BB2B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jul 2022 18:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbiGTQPK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jul 2022 12:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbiGTQPJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jul 2022 12:15:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D50AF0E;
        Wed, 20 Jul 2022 09:15:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE02061D1D;
        Wed, 20 Jul 2022 16:15:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82EEDC3411E;
        Wed, 20 Jul 2022 16:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658333707;
        bh=rxI3LP4BmU7HyWe6RwKURqMvWZyaTCQ8VTqau3Ip4A0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=IadZMCr4r4xWpHT68Qd7cVCjAuQlf8gaWXcAiY/WbaOJMhO2KBDsKbpadNXO6PNTK
         10SYVBq3qnGg085OBTaCnjZF8FXRVOijm0VUUZ14v1cCUA3PnnpJ7GI878ur2BodIH
         r1DFzYXdckUSnhDQ8pMd3KCQWv9UGufp1rPdAkT4kawrgCAiIj+f/GSKV1B9q2iiAp
         wy40jDfezknP4k5+qqSK5G8YhDgGoTamiNTLHjPCd/cwNBDyz1TVkK3l3wfDrsT9re
         HEAot+EmBKb5gemV3SNYa0DlgAAiwq8P95yOa5gByh1QEOSbL4YF68E333ybzSf/mJ
         w/HyY/jZy3gOA==
Message-ID: <e84b9caf376a9b958a95ca4e0d088808c482f109.camel@kernel.org>
Subject: Re: should we make "-o iversion" the default on ext4 ?
From:   Jeff Layton <jlayton@kernel.org>
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     Lukas Czerner <lczerner@redhat.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Date:   Wed, 20 Jul 2022 12:15:05 -0400
In-Reply-To: <BAFC8295-B629-49DB-A381-DD592182055D@redhat.com>
References: <69ac1d3ef0f63b309204a570ef4922d2684ed7f9.camel@kernel.org>
         <20220720141546.46l2d7bxwukjhtl7@fedora>
         <ad7218a41fa8ac26911a9ccb79c87609d4279fea.camel@kernel.org>
         <BAFC8295-B629-49DB-A381-DD592182055D@redhat.com>
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

On Wed, 2022-07-20 at 11:56 -0400, Benjamin Coddington wrote:
> On 20 Jul 2022, at 10:38, Jeff Layton wrote:
> > On Wed, 2022-07-20 at 16:15 +0200, Lukas Czerner wrote:
> > >=20
> > > Is there a different way I am not seeing?
> > >=20
> >=20
> > Right, implementing this is the difficult bit actually since this uses =
a
> > MS_* flag.=A0If we do make this the default, we'd definitely want to
> > continue allowing "-o noiversion" to disable it.
> >=20
> > Could we just reverse the default in libmount? It might cause this to
> > suddenly be enabled in some deployments, but in most cases, people
> > wouldn't even notice and they could still specify -o noiversion to turn
> > it off.
> >=20
> > Another idea would be to introduce new mount options for this, but
> > that's kind of nasty from a UI standpoint.
>=20
> Is it safe to set SB_I_VERSION at export time?  If so, export_operations
> could grow an ->enable_iversion().
>=20

That sounds like it might be problematic.

Consider the case where a NFSv4 client has cached file data and the
change attribute for the file. Server then reboots, but before the
export happens a local user makes a change to the file and it doesn't
update the i_version.
--=20
Jeff Layton <jlayton@kernel.org>
