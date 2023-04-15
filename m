Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C14176E314E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Apr 2023 14:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjDOMN0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 15 Apr 2023 08:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjDOMNZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 15 Apr 2023 08:13:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F570AD;
        Sat, 15 Apr 2023 05:13:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D70C6615B9;
        Sat, 15 Apr 2023 12:13:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D93C6C433EF;
        Sat, 15 Apr 2023 12:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681560801;
        bh=vISxtwgPDbbPk2EBE4+0qWc3uawfwrv6lg/w51U7c6M=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=TIZnNaCcjQcrtSjP8IynjFI1zOZE3ioOSGp+Xn3NEVkUwUEXcrwHvksQ98DP4NHpW
         9Zx2SJ/mlVxxXSTmIGv/qSCXlFMtBnImrVbhnUv0Ur+hMnqUkmhE0Ks0XdjxDTc9uf
         ceCXE1LxO4OkhkFijr5SUnlAgCAcvKjIsPnx0C4nU1OQDh+fnp1vd6vJ+0WCpvOXiC
         3XGbuoH61TENPu8kv3jwKXweUll2mdc/qmkkIq1eUwOZr8dAAnvX7x6Xb2G+K9Qh5F
         ZNn+GAhUJrngGxyhRHEc154VKiYwXivaxryFgHhYxlWV+B1QI2v2ivKCbTs6PASN7F
         IhmSdcNSSglqQ==
Message-ID: <e03485c02c6f9fefdaf76e93724978e4874d5442.camel@kernel.org>
Subject: Re: [RFC PATCH 0/3][RESEND] fs: opportunistic high-res file
 timestamps
From:   Jeff Layton <jlayton@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>,
        Dave Chinner <david@fromorbit.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Date:   Sat, 15 Apr 2023 08:13:18 -0400
In-Reply-To: <CAOQ4uxi9rz1GFP+jMJm482axyAPtAcB+jnZ5jCR++EYKA_iRpw@mail.gmail.com>
References: <20230411143702.64495-1-jlayton@kernel.org>
         <CAOQ4uxi9rz1GFP+jMJm482axyAPtAcB+jnZ5jCR++EYKA_iRpw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 2023-04-15 at 14:35 +0300, Amir Goldstein wrote:
> On Tue, Apr 11, 2023 at 5:38=E2=80=AFPM Jeff Layton <jlayton@kernel.org> =
wrote:
> >=20
> > (Apologies for the resend, but I didn't send this with a wide enough
> > distribution list originally).
> >=20
> > A few weeks ago, during one of the discussions around i_version, Dave
> > Chinner wrote this:
> >=20
> > "You've missed the part where I suggested lifting the "nfsd sampled
> > i_version" state into an inode state flag rather than hiding it in
> > the i_version field. At that point, we could optimise away the
> > secondary ctime updates just like you are proposing we do with the
> > i_version updates.  Further, we could also use that state it to
> > decide whether we need to use high resolution timestamps when
> > recording ctime updates - if the nfsd has not sampled the
> > ctime/i_version, we don't need high res timestamps to be recorded
> > for ctime...."
> >=20
> > While I don't think we can practically optimize away ctime updates
> > like we do with i_version, I do like the idea of using this scheme to
> > indicate when we need to use a high-res timestamp.
> >=20
> > This patchset is a first stab at a scheme to do this. It declares a new
> > i_state flag for this purpose and adds two new vfs-layer functions to
> > implement conditional high-res timestamp fetching. It then converts bot=
h
> > tmpfs and xfs to use it.
> >=20
> > This seems to behave fine under xfstests, but I haven't yet done
> > any performance testing with it. I wouldn't expect it to create huge
> > regressions though since we're only grabbing high res timestamps after
> > each query.
> >=20
> > I like this scheme because we can potentially convert any filesystem to
> > use it. No special storage requirements like with i_version field.  I
> > think it'd potentially improve NFS cache coherency with a whole swath o=
f
> > exportable filesystems, and helps out NFSv3 too.
> >=20
> > This is really just a proof-of-concept. There are a number of things we
> > could change:
> >=20
> > 1/ We could use the top bit in the tv_sec field as the flag. That'd giv=
e
> >    us different flags for ctime and mtime. We also wouldn't need to use
> >    a spinlock.
> >=20
> > 2/ We could probably optimize away the high-res timestamp fetch in more
> >    cases. Basically, always do a coarse-grained ts fetch and only fetch
> >    the high-res ts when the QUERIED flag is set and the existing time
> >    hasn't changed.
> >=20
> > If this approach looks reasonable, I'll plan to start working on
> > converting more filesystems.
> >=20
> > One thing I'm not clear on is how widely available high res timestamps
> > are. Is this something we need to gate on particular CONFIG_* options?
> >=20
> > Thoughts?
>=20
> Jeff,
>=20
> Considering that this proposal is pretty uncontroversial,
> do you still want to discuss/lead a session on i_version changes in LSF/M=
M?
>=20
> I noticed that Chuck listed "timespamt resolution and i_version" as part
> of his NFSD BoF topic proposal [1], but I do not think all of these topic=
s
> can fit in one 30 minute session.
>=20

Agreed. I think we'll need an hour for the nfsd BoF.

I probably don't need a full 30 min slot for this topic, between the
nfsd BoF and hallway track.

I've started a TOPIC email for this about 5 times now, and keep deleting
it. I think most of the more controversial bits are pretty much settled
at this point, and the rest (crash resilience) is still too embryonic
for discussion.

I might want a lightning talk at some point about what I'd _really_ like
to do long term with the i_version counter (basically: I want to be able
to do a write that is gated on the i_version not having changed).


> Dave,
>=20
> I would like to use this opportunity to invite you and any developers tha=
t
> are involved in fs development and not going to attend LSF/MM in-person,
> to join LSF/MM virtually for some sessions that you may be interested in.
> See this lore query [2] for TOPICs proposed this year.
>=20
> You can let me know privately which sessions you are interested in
> attending and your time zone and I will do my best to schedule those
> sessions in time slots that would be more convenient for your time zone.
>=20
> Obviously, I am referring to FS track sessions.
> Cross track sessions are going to be harder to accommodate,
> but I can try.
>=20
> Thanks,
> Amir.
>=20
> [1] https://lore.kernel.org/linux-fsdevel/FF0202C3-7500-4BB3-914B-DBAA3E0=
EA3D7@oracle.com/
> [2] https://lore.kernel.org/linux-fsdevel/?q=3DLSF+TOPIC+-re+d%3A4.months=
.ago..

--=20
Jeff Layton <jlayton@kernel.org>
