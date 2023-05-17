Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFB77064C3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 May 2023 11:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjEQJ6r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 May 2023 05:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjEQJ6q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 May 2023 05:58:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72BA468B;
        Wed, 17 May 2023 02:58:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C7A263EE1;
        Wed, 17 May 2023 09:58:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09549C4339B;
        Wed, 17 May 2023 09:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684317519;
        bh=mdvgMjxEgSNhZgKM2X2vQGsXllXF+XTarnc4LgRl04A=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=CEy1ZoOW04ULFl1Snt/ohfPj+PnDo19paj2EgjxdshfncUxd7cYJIil/dimFsQ0gQ
         7m0XgJW13m17cReDatsQWKzxq6jssyN9ULt54QqHqseh7OzWPSBx3oXCk+QopU8RPw
         jWsL4lbs9QChO5Xr7DP9HRO9mQVRoWG11xq2zTjhPnOQ6Ah45+GRafCwU13/oxXnkw
         PLJ+eDqdLgm8MMXEiMNvrdMWBTvUDKf6rxWlRIAFnZ7YZP2WBANs5t4qTO/rBBoUQj
         spk8hrWBr/aiavH0SAVXgj1PKHBGqxUo27yG0SpBblF+QQSr7JIek6ExezG9X//3D1
         CkygKMcyjUXbA==
Message-ID: <579da980fa02682522e7e4ada5be36fc972ea838.camel@kernel.org>
Subject: Re: A pass-through support for NFSv4 style ACL
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Ondrej Valousek <ondrej.valousek.xm@renesas.com>,
        "trondmy@hammerspace.com" <trondmy@hammerspace.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andreas Gruenbacher <agruenba@redhat.com>
Date:   Wed, 17 May 2023 05:58:37 -0400
In-Reply-To: <20230517-herstellen-zitat-21eeccd36558@brauner>
References: <20230516124655.82283-1-jlayton@kernel.org>
         <20230516-notorisch-geblickt-6b591fbd77c1@brauner>
         <TYXPR01MB18549D3A5B0BE777D7F6B284D9799@TYXPR01MB1854.jpnprd01.prod.outlook.com>
         <cc4317d9cb8f10aa0b3750bdb6db8b4e77ff26f8.camel@kernel.org>
         <20230517-herstellen-zitat-21eeccd36558@brauner>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2023-05-17 at 09:42 +0200, Christian Brauner wrote:
> On Tue, May 16, 2023 at 05:22:30PM -0400, Jeff Layton wrote:
> > On Tue, 2023-05-16 at 20:50 +0000, Ondrej Valousek wrote:
> > >=20
> > > Hi Christian,
> > >=20
> > > Would it be possible to patch kernel the way it accepts native (i.e n=
o
> > > conversion to Posix ACL) NFSv4 style ACLs for filesystems that can
> > > support them?
> > > I.E. OpenZFS, NTFS, could be also interesting for Microsofts WSL2=A0 =
or
> > > Samba right?
> > >=20
> > > I mean, I am not trying to push richacl again knowing they have been
> > > rejected, but just NFS4 style Acls as they are so similar to Windows
> > > ACLs.
> > >=20
> >=20
> > Erm, except you kind of are if you want to do this. I don't see how thi=
s
> > idea works unless you resurrect RichACLs or something like them.
>=20
> I have no idea about the original flame war that ended RichACLs in
> additition to having no clear clue what RichACLs are supposed to
> achieve. My current knowledge extends to "Christoph didn't like them".
>=20
> >=20
> > > The idea here would be that we could
> > > - mount NTFS/ZFS filesystem and inspect ACLs using existing tools
> > > (nfs4_getacl)
> > > - share with NFSv4 in a pass through mode
> > > - in Windows WSL2 we could inspect local filesystem ACLs using the
> > > same tools
> > >=20
> > > Does it make any sense or it would require lot of changes to VFS
> > > subsystem or its a nonsense altogether?
>=20
> Yes, very likely.
>=20
> We'd either have to change the current inode operations for getting and
> setting acls to take a new struct acl that can contain either posix acls
> or rich acls or add new ones just for these new fangled ones.
>=20
> Choosing the first - more sensible - of these two options will mean
> updating each filesystem's acl inode operations. Might turn out to not
> be invasive code as it might boil down to struct posix_acl *acl =3D
> acl->posix at the beginning of each method but still.
>=20
> Then we'd probably also need to:
>=20
> * handle permission checking (see Jeff's comment below)
> * change/update the ACL caching layer
> * if the past hast taught me anything then overlayfs would probably need
>   some additional logic as well
>=20

Yeah, it's a significant project.

> > >=20
> >=20
> > Eventually you have to actually enforce the ACL. Do NTFS/ZFS already
> > have code to do this? If not then someone would need to write it.
> >=20
> > Also windows and nfs acls do have some differences, so you'll need a
> > translation layer too.
>=20
> Jeff, I know you have some knowledge in this area you probably are
> better equipped to judge the sanity and feasibility of this.

I know a bit, but Andreas (cc'ed) is the undisputed expert. If you're
looking to resurrect this effort, then you should definitely loop him
in.

--=20
Jeff Layton <jlayton@kernel.org>
