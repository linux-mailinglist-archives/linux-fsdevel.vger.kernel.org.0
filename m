Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D5F67CA6F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 13:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237143AbjAZMCi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 07:02:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233130AbjAZMCh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 07:02:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2FA62263;
        Thu, 26 Jan 2023 04:02:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75DEF617AD;
        Thu, 26 Jan 2023 12:02:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8E8FC433EF;
        Thu, 26 Jan 2023 12:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674734554;
        bh=83fTWvpaEiAzVDaeYFz2GUb2OOww4EG+o2MOVi11zGU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=lnaSaz9xP7pd9evixsmXaWhTU8ZegXDyqUAlmc8ci4N4ldJSkHKUm/LDiv76C+wI/
         VAZcsfEFGwsZ7vEiZl7uaRPzO4iAwPwrHIZbX/B7SQmFvkXiIJHI2aFoAgPKXhYVOV
         vbNYMAKf938rfJ8pPRRdumhaz4o+o8XZXZSRdgSokJWNywdMWrSlJLCRLlbyTT9MiJ
         MR4EaTs+0pGmTGeZniK12fbJ9Pdob1oQpmaAtdAsEskRxnKSAxlng8HJjseWLnEsGY
         gfh2g5MSiUQvE/W+va/0RqGUOImd7/r/EVeGwOSNHaNTcJFAUmBSiNg++yhOB+WonH
         uT5l6ovxjVpeA==
Message-ID: <5f27d8b64ad64905ada344e299cf00e55b8ac895.camel@kernel.org>
Subject: Re: [PATCH v8 RESEND 2/8] fs: clarify when the i_version counter
 must be updated
From:   Jeff Layton <jlayton@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, djwong@kernel.org,
        david@fromorbit.com, trondmy@hammerspace.com, neilb@suse.de,
        viro@zeniv.linux.org.uk, zohar@linux.ibm.com, xiubli@redhat.com,
        chuck.lever@oracle.com, lczerner@redhat.com, bfields@fieldses.org,
        brauner@kernel.org, fweimer@redhat.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-xfs@vger.kernel.org, Colin Walters <walters@verbum.org>
Date:   Thu, 26 Jan 2023 07:02:31 -0500
In-Reply-To: <20230126113642.eenghs2wvfrlnlak@quack3>
References: <20230124193025.185781-1-jlayton@kernel.org>
         <20230124193025.185781-3-jlayton@kernel.org>
         <20230125160625.zenzybjgie224jf6@quack3>
         <3c5cf7c7f9e206a3d7c4253de52015dda97ef41e.camel@kernel.org>
         <20230126113642.eenghs2wvfrlnlak@quack3>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2023-01-26 at 12:36 +0100, Jan Kara wrote:
> On Thu 26-01-23 05:54:16, Jeff Layton wrote:
> > On Wed, 2023-01-25 at 17:06 +0100, Jan Kara wrote:
> > > On Tue 24-01-23 14:30:19, Jeff Layton wrote:
> > > > The i_version field in the kernel has had different semantics over
> > > > the decades, but NFSv4 has certain expectations. Update the comment=
s
> > > > in iversion.h to describe when the i_version must change.
> > > >=20
> > > > Cc: Colin Walters <walters@verbum.org>
> > > > Cc: NeilBrown <neilb@suse.de>
> > > > Cc: Trond Myklebust <trondmy@hammerspace.com>
> > > > Cc: Dave Chinner <david@fromorbit.com>
> > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > >=20
> > > Looks good to me. But one note below:
> > >=20
> > > > diff --git a/include/linux/iversion.h b/include/linux/iversion.h
> > > > index 6755d8b4f20b..fced8115a5f4 100644
> > > > --- a/include/linux/iversion.h
> > > > +++ b/include/linux/iversion.h
> > > > @@ -9,8 +9,25 @@
> > > >   * ---------------------------
> > > >   * The change attribute (i_version) is mandated by NFSv4 and is mo=
stly for
> > > >   * knfsd, but is also used for other purposes (e.g. IMA). The i_ve=
rsion must
> > > > - * appear different to observers if there was a change to the inod=
e's data or
> > > > - * metadata since it was last queried.
> > > > + * appear larger to observers if there was an explicit change to t=
he inode's
> > > > + * data or metadata since it was last queried.
> > > > + *
> > > > + * An explicit change is one that would ordinarily result in a cha=
nge to the
> > > > + * inode status change time (aka ctime). i_version must appear to =
change, even
> > > > + * if the ctime does not (since the whole point is to avoid missin=
g updates due
> > > > + * to timestamp granularity). If POSIX or other relevant spec mand=
ates that the
> > > > + * ctime must change due to an operation, then the i_version count=
er must be
> > > > + * incremented as well.
> > > > + *
> > > > + * Making the i_version update completely atomic with the operatio=
n itself would
> > > > + * be prohibitively expensive. Traditionally the kernel has update=
d the times on
> > > > + * directories after an operation that changes its contents. For r=
egular files,
> > > > + * the ctime is usually updated before the data is copied into the=
 cache for a
> > > > + * write. This means that there is a window of time when an observ=
er can
> > > > + * associate a new timestamp with old file contents. Since the pur=
pose of the
> > > > + * i_version is to allow for better cache coherency, the i_version=
 must always
> > > > + * be updated after the results of the operation are visible. Upda=
ting it before
> > > > + * and after a change is also permitted.
> > >=20
> > > This sounds good but it is not the case for any of the current filesy=
stems, is
> > > it? Perhaps the documentation should mention this so that people are =
not
> > > confused?
> >=20
> > Correct. Currently, all filesystems change the times and version before
> > a write instead of after. I'm hoping that situation will change soon
> > though, as I've been working on a patchset to fix this for tmpfs, ext4
> > and btrfs.
>=20
> That is good but we'll see how long it takes to get merged. AFAIR it is n=
ot
> a complete nobrainer ;)
>=20
> > If you still want to see something for this though, what would you
> > suggest for verbiage?
>=20
> Sure:
>=20
> ... the i_version must a be updated after the results of the operation ar=
e
> visible (note that none of the filesystems currently do this, it is a wor=
k
> in progress to fix this).
>=20
> And once your patches are merged, you can also delete this note :).
>=20
> 								Honza

Sounds good, I folded something similar to that into the patch and
pushed it into the branch I'm feeding into linux-next.=A0I won't bother
re-posting for just that though:

diff --git a/include/linux/iversion.h b/include/linux/iversion.h
index fced8115a5f4..f174ff1b59ee 100644
--- a/include/linux/iversion.h
+++ b/include/linux/iversion.h
@@ -27,7 +27,8 @@
  * associate a new timestamp with old file contents. Since the purpose of =
the
  * i_version is to allow for better cache coherency, the i_version must al=
ways
  * be updated after the results of the operation are visible. Updating it =
before
- * and after a change is also permitted.
+ * and after a change is also permitted. (Note that no filesystems current=
ly do
+ * this. Fixing that is a work-in-progress).
  *
  * Observers see the i_version as a 64-bit number that never decreases. If=
 it
  * remains the same since it was last checked, then nothing has changed in=
 the

Thanks!
--=20
Jeff Layton <jlayton@kernel.org>
