Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E88C16F03D3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Apr 2023 11:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243001AbjD0J54 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Apr 2023 05:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243439AbjD0J5v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Apr 2023 05:57:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D86644A9;
        Thu, 27 Apr 2023 02:57:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37DF763C17;
        Thu, 27 Apr 2023 09:57:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FD41C433EF;
        Thu, 27 Apr 2023 09:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682589467;
        bh=USht+Uhb9xZz9unMUb+D4xBAM+5FX4XpLOVJcmQLh1U=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=byAFePc0ODsjd5aiGO9OPca7OVWAZDPXzpeqUTYbMwvg/LgHb+Nd89oeLryh1Vjs7
         mNs4G0c5xvx9hPHhbPbqqb2wXnfj0hssVe3TfUDySJVnk2oJxTiOy1qYOe+28ZFoqc
         soDJQVIvZDzswir043Ask61bZCvd8O0/7HPCwsjVW+HkiRya/gKcqEv4o7uWYbYNfD
         UFEJ/AOiPH0ZipnF2tb1U57ShzE0LtqnRotiitK+rYq9zfecX+cG91iThdn1CtqbFB
         XyDR5aNQJoGNXTu40yuMplZ/vbGv5gH/JngiDbHisrJKKedk7MZ8io8BRU6s3H7C65
         Nu/DjCcXdQYug==
Message-ID: <0f504cb85005676fdae06d00b276518b6b983986.camel@kernel.org>
Subject: Re: [PATCH v2 1/3] fs: add infrastructure for multigrain inode
 i_m/ctime
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org
Date:   Thu, 27 Apr 2023 05:57:44 -0400
In-Reply-To: <20230427-rebel-vergibt-99cf6a7838a2@brauner>
References: <20230424151104.175456-1-jlayton@kernel.org>
         <20230424151104.175456-2-jlayton@kernel.org>
         <20230426-bahnanlagen-ausmusterung-4877cbf40d4c@brauner>
         <03e91ee4c56829995c08f4f8fb1052d3c6cc40c4.camel@kernel.org>
         <20230427-rebel-vergibt-99cf6a7838a2@brauner>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2023-04-27 at 11:51 +0200, Christian Brauner wrote:
> On Wed, Apr 26, 2023 at 05:48:38AM -0400, Jeff Layton wrote:
> > On Wed, 2023-04-26 at 09:07 +0200, Christian Brauner wrote:
> > > On Mon, Apr 24, 2023 at 11:11:02AM -0400, Jeff Layton wrote:
> > > > The VFS always uses coarse-grained timestamp updates for filling ou=
t the
> > > > ctime and mtime after a change. This has the benefit of allowing
> > > > filesystems to optimize away a lot metaupdates, to around once per
> > > > jiffy, even when a file is under heavy writes.
> > > >=20
> > > > Unfortunately, this has always been an issue when we're exporting v=
ia
> > > > NFSv3, which relies on timestamps to validate caches. Even with NFS=
v4, a
> > > > lot of exported filesystems don't properly support a change attribu=
te
> > > > and are subject to the same problems with timestamp granularity. Ot=
her
> > > > applications have similar issues (e.g backup applications).
> > > >=20
> > > > Switching to always using fine-grained timestamps would improve the
> > > > situation for NFS, but that becomes rather expensive, as the underl=
ying
> > > > filesystem will have to log a lot more metadata updates.
> > > >=20
> > > > What we need is a way to only use fine-grained timestamps when they=
 are
> > > > being actively queried:
> > > >=20
> > > > Whenever the mtime changes, the ctime must also change since we're
> > > > changing the metadata. When a superblock has a s_time_gran >1, we c=
an
> > > > use the lowest-order bit of the inode->i_ctime as a flag to indicat=
e
> > > > that the value has been queried. Then on the next write, we'll fetc=
h a
> > > > fine-grained timestamp instead of the usual coarse-grained one.
> > > >=20
> > > > We could enable this for any filesystem that has a s_time_gran >1, =
but
> > > > for now, this patch adds a new SB_MULTIGRAIN_TS flag to allow files=
ystems
> > > > to opt-in to this behavior.
> > >=20
> > > Hm, the patch raises the flag in s_flags. Please at least move this t=
o
> > > s_iflags as SB_I_MULTIGRAIN and treat this as an internal flag. There=
's
> > > no need to give the impression that this will become a mount option.
> > >=20
> > > Also, this looks like it's a filesystem property not a superblock
> > > property as the granularity isn't changeable. So shouldn't this be an
> > > FS_* flag instead?
> >=20
> > It could be a per-sb thing if there was some filesystem that wanted to
> > do that, but I'm hoping that most will not want to do that.
>=20
> Yeah, I'd really hope this isn't an sb thing.
>=20
> >=20
> > My initial patches for this actually did use a FS_* flag, but I figured
>=20
> Oh, I might've just missed that.
>=20

Sorry, I didn't actually post that set. But I did go with a FS_* flag
before I made it a SB_* flag.

> > that was one more pointer to chase when you wanted to check the flag.
>=20
> Hm, unless you have reasons to think that it would be noticable in terms
> of perf I'd rather do the correct thing and have it be an FS_* flag.

Sure. I'll make the switch before the next posting.

Thanks for the review!
--=20
Jeff Layton <jlayton@kernel.org>
