Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC716F09FA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Apr 2023 18:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244248AbjD0Qgh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Apr 2023 12:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243284AbjD0Qgf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Apr 2023 12:36:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221244C03;
        Thu, 27 Apr 2023 09:36:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A162B60C11;
        Thu, 27 Apr 2023 16:36:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52C78C433EF;
        Thu, 27 Apr 2023 16:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682613393;
        bh=NK9ShzjIwWFJFvl4S+tgaxQhD/QPtKHv3Jo+GnfBb+U=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=UjDFpJZoT48prhNYEjw5dEOwMhWF7S44SIUuN4OmLrtQ0Wp4Xo+JCZwTZjytFWli+
         xOcJUGLITZqsrbXF1DpI+rhTDKL7eZke9o6MfdOlrkI1bG+T1fW/gU9/iK/wFK5500
         mhMimazuDWJ4QFkg7Ru7ITEtrOtL9lQ5Zj6koermvzLx4TgaAbbNuXcShfskfaIq05
         k8NmaaZs/G7mHADteyOhZNvfVBx9x0Glp4/Ti3KZBBazdjyrvoWO1b7B4uxKe8Hoe5
         18AcDllwtR61V01N1DaY1eCWcN8SzAZ4vt2Q8hkwHe0nxlu4KryIPcgr8qPAe5iIo2
         63vdsPh6KReaw==
Message-ID: <df31058f662fe9ec9ad1cc59838f288b8aff10f0.camel@kernel.org>
Subject: Re: [RFC][PATCH 0/4] Prepare for supporting more filesystems with
 fanotify
From:   Jeff Layton <jlayton@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Date:   Thu, 27 Apr 2023 12:36:30 -0400
In-Reply-To: <CAOQ4uxjR0cdjW1Pr1DWAn+dkTd3SbV7CUqeGRh2FeDVBGAdtRw@mail.gmail.com>
References: <20230425130105.2606684-1-amir73il@gmail.com>
         <dafbff6baa201b8af862ee3faf7fe948d2a026ab.camel@kernel.org>
         <CAOQ4uxjR0cdjW1Pr1DWAn+dkTd3SbV7CUqeGRh2FeDVBGAdtRw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2023-04-27 at 18:52 +0300, Amir Goldstein wrote:
> On Thu, Apr 27, 2023 at 6:13=E2=80=AFPM Jeff Layton <jlayton@kernel.org> =
wrote:
> >=20
> > On Tue, 2023-04-25 at 16:01 +0300, Amir Goldstein wrote:
> > > Jan,
> > >=20
> > > Following up on the FAN_REPORT_ANY_FID proposal [1], here is a shot a=
t an
> > > alternative proposal to seamlessly support more filesystems.
> > >=20
> > > While fanotify relaxes the requirements for filesystems to support
> > > reporting fid to require only the ->encode_fh() operation, there are
> > > currently no new filesystems that meet the relaxed requirements.
> > >=20
> > > I will shortly post patches that allow overlayfs to meet the new
> > > requirements with default overlay configurations.
> > >=20
> > > The overlay and vfs/fanotify patch sets are completely independent.
> > > The are both available on my github branch [2] and there is a simple
> > > LTP test variant that tests reporting fid from overlayfs [3], which
> > > also demonstrates the minor UAPI change of name_to_handle_at(2) for
> > > requesting a non-decodeable file handle by userspace.
> > >=20
> > > Thanks,
> > > Amir.
> > >=20
> > > [1] https://lore.kernel.org/linux-fsdevel/20230417162721.ouzs33oh6mb7=
vtft@quack3/
> > > [2] https://github.com/amir73il/linux/commits/exportfs_encode_fid
> > > [3] https://github.com/amir73il/ltp/commits/exportfs_encode_fid
> > >=20
> > > Amir Goldstein (4):
> > >   exportfs: change connectable argument to bit flags
> > >   exportfs: add explicit flag to request non-decodeable file handles
> > >   exportfs: allow exporting non-decodeable file handles to userspace
> > >   fanotify: support reporting non-decodeable file handles
> > >=20
> > >  Documentation/filesystems/nfs/exporting.rst |  4 +--
> > >  fs/exportfs/expfs.c                         | 29 ++++++++++++++++++-=
--
> > >  fs/fhandle.c                                | 20 ++++++++------
> > >  fs/nfsd/nfsfh.c                             |  5 ++--
> > >  fs/notify/fanotify/fanotify.c               |  4 +--
> > >  fs/notify/fanotify/fanotify_user.c          |  6 ++---
> > >  fs/notify/fdinfo.c                          |  2 +-
> > >  include/linux/exportfs.h                    | 18 ++++++++++---
> > >  include/uapi/linux/fcntl.h                  |  5 ++++
> > >  9 files changed, 67 insertions(+), 26 deletions(-)
> > >=20
> >=20
> > This set looks fairly benign to me, so ACK on the general concept.
>=20
> Thanks!
>=20
> >=20
> > I am starting to dislike how the AT_* flags are turning into a bunch of
> > flags that only have meanings on certain syscalls. I don't see a cleane=
r
> > way to handle it though.
>=20
> Yeh, it's not great.
>=20
> There is also a way to extend the existing API with:
>=20
> Perhstruct file_handle {
>         unsigned int handle_bytes:8;
>         unsigned int handle_flags:24;
>         int handle_type;
>         unsigned char f_handle[];
> };
>=20
> AFAICT, this is guaranteed to be backward compat
> with old kernels and old applications.
>=20

That could work. It would probably look cleaner as a union though.
Something like this maybe?

union {
	unsigned int legacy_handle_bytes;
	struct {
		u8	handle_bytes;
		u8	__reserved;
		u16	handle_flags;
	};
}

__reserved must be zeroed (for now). You could consider using it for
some other purpose later.

It's a little ugly as an API but it would be backward compatible, given
that we never use the high bits today anyway.

Callers might need to deal with an -EINVAL when they try to pass non-
zero handle_flags to existing kernels, since you'd trip the
MAX_HANDLE_SZ check that's there today.

> It also may not be a bad idea that the handle_flags could
> be used to request specific fh properties (FID) and can also
> describe the properties of the returned fh (i.e. non-decodeable)
> that could also be respected by open_by_handle_at().
>=20
> For backward compact, kernel will only set handle_flags in
> response if new flags were set in the request.
>=20
> Do you consider this extension better than AT_HANDLE_FID
> or worse? At least it is an API change that is contained within the
> exportfs subsystem, without polluting the AT_ flags global namespace.
>=20

Personally, yes. I think adding a struct file_handle_v2 would be cleaner
and allows for expanding the API later through new flags.
--=20
Jeff Layton <jlayton@kernel.org>
