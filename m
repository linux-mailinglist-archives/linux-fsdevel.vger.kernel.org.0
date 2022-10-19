Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78110605163
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Oct 2022 22:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbiJSUg4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Oct 2022 16:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbiJSUgy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Oct 2022 16:36:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF0B18BE22;
        Wed, 19 Oct 2022 13:36:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1584AB825E3;
        Wed, 19 Oct 2022 20:36:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1D42C433D6;
        Wed, 19 Oct 2022 20:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666211810;
        bh=QNWrT4BNA+f3DUSflq7rEklmV7uTmyKRkZdYeFH1rWA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=imWCyvFmM+m5SFXX1nMp/YvOzsVzar0qgjvdpeIZAlfcEPP76kruPCbbxoOo//q2H
         sNl7clm1oVEZXJFtuw18oWvDPa6A8Il+ETr3YlpYFidrm7KkvSg5U2anEiqUB09QRc
         a9wp0KZzk36JV4SZn/QgRGikwvpACJK2Iq4FHrQF2G+Wcf6hl70xAps8Qi455HjbXZ
         L3lek3pRbyGIYwzbWx8tQuhHbX1iQQQ+Z3qyc2fEgq1gga9tYjISjmuvQtvw+e3Fqb
         ZIkvU1LMbOYsk38kQq3rKMqAN79/O/U55cQ1OujGhDJvTrdbHz8YoRLPvzjqyKTVVi
         WN9Mbm4Q0DowQ==
Message-ID: <3fa8e13be8d75e694e8360a8e9552a92a4c14803.camel@kernel.org>
Subject: Re: [PATCH v7 0/9] fs: clean up handling of i_version counter
From:   Jeff Layton <jlayton@kernel.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>, tytso@mit.edu,
        adilger.kernel@dilger.ca, david@fromorbit.com,
        trondmy@hammerspace.com, neilb@suse.de, viro@zeniv.linux.org.uk,
        zohar@linux.ibm.com, xiubli@redhat.com, chuck.lever@oracle.com,
        lczerner@redhat.com, jack@suse.cz, bfields@fieldses.org,
        fweimer@redhat.com, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org
Date:   Wed, 19 Oct 2022 16:36:47 -0400
In-Reply-To: <Y1AbmIYEhUwfFHDx@magnolia>
References: <20221017105709.10830-1-jlayton@kernel.org>
         <20221019111315.hpilifogyvf3bixh@wittgenstein>
         <2b167dd9bda17f1324e9c526d868cc0d995dc660.camel@kernel.org>
         <Y1AbmIYEhUwfFHDx@magnolia>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2022-10-19 at 08:45 -0700, Darrick J. Wong wrote:
> On Wed, Oct 19, 2022 at 08:18:15AM -0400, Jeff Layton wrote:
> > On Wed, 2022-10-19 at 13:13 +0200, Christian Brauner wrote:
> > > On Mon, Oct 17, 2022 at 06:57:00AM -0400, Jeff Layton wrote:
> > > > This patchset is intended to clean up the handling of the i_version
> > > > counter by nfsd. Most of the changes are to internal interfaces.
> > > >=20
> > > > This set is not intended to address crash resilience, or the fact t=
hat
> > > > the counter is bumped before a change and not after. I intend to ta=
ckle
> > > > those in follow-on patchsets.
> > > >=20
> > > > My intention is to get this series included into linux-next soon, w=
ith
> > > > an eye toward merging most of it during the v6.2 merge window. The =
last
> > > > patch in the series is probably not suitable for merge as-is, at le=
ast
> > > > until we sort out the semantics we want to present to userland for =
it.
> > >=20
> > > Over the course of the series I struggled a bit - and sorry for losin=
g
> > > focus - with what i_version is supposed to represent for userspace. S=
o I
> > > would support not exposing it to userspace before that. But that
> > > shouldn't affect your other changes iiuc.
> >=20
> > Thanks Christian,
> >=20
> > It has been a real struggle to nail this down, and yeah I too am not
> > planning to expose this to userland until we have this much better
> > defined.=A0Patch #9 is just to give you an idea of what this would
> > ultimately look like. I intend to re-post the first 8 patches with an
> > eye toward merge in v6.2, once we've settled on the naming. On that
> > note...
> >=20
> > I believe you had mentioned that you didn't like STATX_CHANGE_ATTR for
> > the name, and suggested STATX_I_VERSION (or something similar), which I
> > later shortened to STATX_VERSION.
> >=20
> > Dave C. objected to STATX_VERSION, as "version" fields in a struct
> > usually refer to the version of the struct itself rather than the
> > version of the thing it describes. It also sort of implies a monotonic
> > counter, and I'm not ready to require that just yet.
> >=20
> > What about STATX_CHANGE for the name (with corresponding names for the
> > field and other flags)? That drops the redundant "_ATTR" postfix, while
> > being sufficiently vague to allow for alternative implementations in th=
e
> > future.
> >=20
> > Do you (or anyone else) have other suggestions for a name?
>=20
> Welllll it's really a u32 whose value doesn't have any intrinsic meaning
> other than "if (value_now !=3D value_before) flush_cache();" right?
> I think it really only tracks changes to file data, right?
>=20

It's a u64, but yeah, you're not supposed to assign any intrinsic
meaning to the value itself.

> STATX_CHANGE_COOKIE	(wait, does this cookie augment i_ctime?)
>=20
> STATX_MOD_COOKIE	(...or just file modifications/i_mtime?)
>=20
> STATX_MONITOR_COOKIE	(...what are we monitoring??)
>=20
> STATX_MON_COOKIE
>=20
> STATX_COOKIE_MON
>=20
> STATX_COOKIE_MONSTER
>=20
> There we go. ;)
>=20
> In seriousness, I'd probably go with one of the first two.  I wouldn't
> be opposed to the last one, either, but others may disagree. ;)
>=20
> --D
>=20
>=20

STATX_CHANGE_COOKIE is probably the best one. I'll plan to go with that
unless someone has a better idea. Thanks for the suggestions!

Cheers,
--=20
Jeff Layton <jlayton@kernel.org>
