Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A66EC70DAB7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 12:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236276AbjEWKkP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 06:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbjEWKkO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 06:40:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEFFDFD;
        Tue, 23 May 2023 03:40:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F7C06219F;
        Tue, 23 May 2023 10:40:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F7F9C433EF;
        Tue, 23 May 2023 10:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684838411;
        bh=f+/n/9W9MacCWlrNjnZKe/E6DzkMjzPffGVpxIef21E=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=naSNA1XFwG9CeYtFUGdoyCDPN0GnjUTdJONT+mHHEvcv2xzo3h3Yx16pnmCsSF52U
         55aLjhUCdBxOqhsLIVNEUAvHsF1CBch2wRDRYUOr3VXMGdtpaVQaRnftwRAOFci9Am
         WAYubeAizm5YWbee7BuXWhRZrvsyL4ZRbwzFx9i195dvdmrTt8GB1FnvGvBthicEVy
         1m6bH21UxEqPLoywrcxw+RpxS5IkUnNeH94vG0YDMXLeb/4Te7x/qiqKzuXYMiY8Z5
         1o9wSTfPaExM/OCZFhWJBu2vgkFMXQV0P4/ke+/1rFvYBPmxRW/ipUeE6REJdJvNlr
         HudUpVyNM4nzg==
Message-ID: <bf0065f2c9895edb66faeacc6cf77bd257088348.camel@kernel.org>
Subject: Re: [PATCH v4 2/9] fs: add infrastructure for multigrain inode
 i_m/ctime
From:   Jeff Layton <jlayton@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Neil Brown <neilb@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Theodore T'so <tytso@mit.edu>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <sfrench@samba.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Tom Talpey <tom@talpey.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org
Date:   Tue, 23 May 2023 06:40:08 -0400
In-Reply-To: <20230523100240.mgeu4y46friv7hau@quack3>
References: <20230518114742.128950-1-jlayton@kernel.org>
         <20230518114742.128950-3-jlayton@kernel.org>
         <20230523100240.mgeu4y46friv7hau@quack3>
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

On Tue, 2023-05-23 at 12:02 +0200, Jan Kara wrote:
> On Thu 18-05-23 07:47:35, Jeff Layton wrote:
> > The VFS always uses coarse-grained timestamp updates for filling out th=
e
> > ctime and mtime after a change. This has the benefit of allowing
> > filesystems to optimize away a lot metadata updates, down to around 1
> > per jiffy, even when a file is under heavy writes.
> >=20
> > Unfortunately, this has always been an issue when we're exporting via
> > NFSv3, which relies on timestamps to validate caches. Even with NFSv4, =
a
> > lot of exported filesystems don't properly support a change attribute
> > and are subject to the same problems with timestamp granularity. Other
> > applications have similar issues (e.g backup applications).
> >=20
> > Switching to always using fine-grained timestamps would improve the
> > situation, but that becomes rather expensive, as the underlying
> > filesystem will have to log a lot more metadata updates.
> >=20
> > What we need is a way to only use fine-grained timestamps when they are
> > being actively queried.
> >=20
> > The kernel always stores normalized ctime values, so only the first 30
> > bits of the tv_nsec field are ever used. Whenever the mtime changes, th=
e
> > ctime must also change.
> >=20
> > Use the 31st bit of the ctime tv_nsec field to indicate that something
> > has queried the inode for the i_mtime or i_ctime. When this flag is set=
,
> > on the next timestamp update, the kernel can fetch a fine-grained
> > timestamp instead of the usual coarse-grained one.
> >=20
> > This patch adds the infrastructure this scheme. Filesytems can opt
> > into it by setting the FS_MULTIGRAIN_TS flag in the fstype.
> >=20
> > Later patches will convert individual filesystems over to use it.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
>=20
> So there are two things I dislike about this series because I think they
> are fragile:
>=20
> 1) If we have a filesystem supporting multigrain ts and someone
> accidentally directly uses the value of inode->i_ctime, he can get bogus
> value (with QUERIED flag). This mistake is very easy to do. So I think we
> should rename i_ctime to something like __i_ctime and always use accessor
> function for it.
>=20

We could do this, but it'll be quite invasive. We'd have to change any
place that touches i_ctime (and there are a lot of them), even on
filesystems that are not being converted.

> 2) As I already commented in a previous version of the series, the scheme
> with just one flag for both ctime and mtime and flag getting cleared in
> current_time() relies on the fact that filesystems always do an equivalen=
t
> of:
>=20
> 	inode->i_mtime =3D inode->i_ctime =3D current_time();
>=20
> Otherwise we can do coarse grained update where we should have done a fin=
e
> grained one. Filesystems often update timestamps like this but not
> universally. Grepping shows some instances where only inode->i_mtime is s=
et
> from current_time() e.g. in autofs or bfs. Again a mistake that is rather
> easy to make and results in subtle issues. I think this would be also
> nicely solved by renaming i_ctime to __i_ctime and using a function to se=
t
> ctime. Mtime could then be updated with inode->i_mtime =3D ctime_peek().
>
> I understand this is quite some churn but a very mechanical one that coul=
d
> be just done with Coccinelle and a few manual fixups. So IMHO it is worth
> the more robust result.

AFAICT, under POSIX, you must _always_ set the ctime when you set the
mtime, but the reverse is not true. That's why keeping the flag in the
ctime makes sense. If we're updating the mtime, then we necessarily must
update the ctime.

> Some more nits below.
>=20
> > +/**
> > + * current_mg_time - Return FS time (possibly fine-grained)
> > + * @inode: inode.
> > + *
> > + * Return the current time truncated to the time granularity supported=
 by
> > + * the fs, as suitable for a ctime/mtime change. If the ctime is flagg=
ed
> > + * as having been QUERIED, get a fine-grained timestamp.
> > + */
>=20
> The comment should also mention that QUERIED flag is cleared from the cti=
me.
>=20

Fair point. I can fix that up.

> > +static struct timespec64 current_mg_time(struct inode *inode)
> > +{
> > +	struct timespec64 now;
> > +	atomic_long_t *pnsec =3D (atomic_long_t *)&inode->i_ctime.tv_nsec;
> > +	long nsec =3D atomic_long_fetch_andnot(I_CTIME_QUERIED, pnsec);
> > +
> > +	if (nsec & I_CTIME_QUERIED) {
> > +		ktime_get_real_ts64(&now);
> > +	} else {
> > +		struct timespec64 ctime;
> > +
> > +		ktime_get_coarse_real_ts64(&now);
> > +
> > +		/*
> > +		 * If we've recently fetched a fine-grained timestamp
> > +		 * then the coarse-grained one may still be earlier than the
> > +		 * existing one. Just keep the existing ctime if so.
> > +		 */
> > +		ctime =3D ctime_peek(inode);
> > +		if (timespec64_compare(&ctime, &now) > 0)
> > +			now =3D ctime;
> > +	}
> > +
> > +	return now;
> > +}
> > +
>=20
> ...
>=20
> > +/**
> > + * ctime_nsec_peek - peek at (but don't query) the ctime tv_nsec field
> > + * @inode: inode to fetch the ctime from
> > + *
> > + * Grab the current ctime tv_nsec field from the inode, mask off the
> > + * I_CTIME_QUERIED flag and return it. This is mostly intended for use=
 by
> > + * internal consumers of the ctime that aren't concerned with ensuring=
 a
> > + * fine-grained update on the next change (e.g. when preparing to stor=
e
> > + * the value in the backing store for later retrieval).
> > + *
> > + * This is safe to call regardless of whether the underlying filesyste=
m
> > + * is using multigrain timestamps.
> > + */
> > +static inline long ctime_nsec_peek(const struct inode *inode)
> > +{
> > +	return inode->i_ctime.tv_nsec &~ I_CTIME_QUERIED;
>=20
> This is somewhat unusual spacing. I'd use:
>=20
> 	inode->i_ctime.tv_nsec & ~I_CTIME_QUERIED
>=20

Yeah, I don't know what happened there. I'll fix that up.

> > +}
> > +
> > +/**
> > + * ctime_peek - peek at (but don't query) the ctime
> > + * @inode: inode to fetch the ctime from
> > + *
> > + * Grab the current ctime from the inode, sans I_CTIME_QUERIED flag. F=
or
> > + * use by internal consumers that don't require a fine-grained update =
on
> > + * the next change.
> > + *
> > + * This is safe to call regardless of whether the underlying filesyste=
m
> > + * is using multigrain timestamps.
> > + */
> > +static inline struct timespec64 ctime_peek(const struct inode *inode)
> > +{
> > +	struct timespec64 ctime;
> > +
> > +	ctime.tv_sec =3D inode->i_ctime.tv_sec;
> > +	ctime.tv_nsec =3D ctime_nsec_peek(inode);
> > +
> > +	return ctime;
> > +}
>=20
> Given this is in a header that gets included in a lot of places, maybe we
> should call it like inode_ctime_peek() or inode_ctime_get() to reduce
> chances of a name clash?

I'd be fine with that, but "ctime" sort of implies inode->i_ctime to me.
We don't really use that nomenclature elsewhere.

--=20
Jeff Layton <jlayton@kernel.org>
