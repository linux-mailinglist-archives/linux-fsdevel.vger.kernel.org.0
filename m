Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F2159BDB2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Aug 2022 12:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbiHVKkj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Aug 2022 06:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233192AbiHVKkW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Aug 2022 06:40:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6F72E6BF;
        Mon, 22 Aug 2022 03:40:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 14623B81032;
        Mon, 22 Aug 2022 10:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEAC5C433C1;
        Mon, 22 Aug 2022 10:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661164818;
        bh=yHtb/QXG0SOmjXqK03h8WGKXY6avHJktJO7EkQ7DU58=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Toyz5EJmLbKH9iqh3AVKjQo69eVx7aTUhE3XlgRi4yhf9+oF5/dyfUHE3rp9OmV+Y
         Lv0TIoTGQ2/gAW/kNQOsLZ0g3HbgYCucp1TI6p7wGbXcEm0PDauzX/fdpxEf+pfzjZ
         neR+XO2Uo5sN1nLVrEr+Mt1mBkJ44CsB8M+LblwcZKWsFlLbHkqmcZyT6iL5pNMv9u
         h9bnSbXo3bLZ6zAJY5rRo+cWbfGS4M+v+GDzUgpqyHXTguDCD+lWxiD64Ldxdfey/1
         tUg2YOfv4blj+J8elmnmoarawbSFRDZb6Qtn1U/Iu9Xld7AFeB6yulZG/PzoPo5tGb
         Ng4Eul0Ewcftw==
Message-ID: <fc87931a003d7a911ba1ab7088e559e6b46f6299.camel@kernel.org>
Subject: Re: [PATCH] xfs: don't bump the i_version on an atime update in
 xfs_vn_update_time
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>
Cc:     "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        David Wysochanski <dwysocha@redhat.com>
Date:   Mon, 22 Aug 2022 06:40:16 -0400
In-Reply-To: <166112626820.23264.11718948914253988812@noble.neil.brown.name>
References: <20220819113450.11885-1-jlayton@kernel.org>
         <166112626820.23264.11718948914253988812@noble.neil.brown.name>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2022-08-22 at 09:57 +1000, NeilBrown wrote:
> On Fri, 19 Aug 2022, Jeff Layton wrote:
> > xfs will update the i_version when updating only the atime value, which
> > is not desirable for any of the current consumers of i_version. Doing s=
o
> > leads to unnecessary cache invalidations on NFS and extra measurement
> > activity in IMA.
> >=20
> > Add a new XFS_ILOG_NOIVER flag, and use that to indicate that the
> > transaction should not update the i_version. Set that value in
> > xfs_vn_update_time if we're only updating the atime.
> >=20
> > Cc: Dave Chinner <david@fromorbit.com>
> > Cc: NeilBrown <neilb@suse.de>
> > Cc: Trond Myklebust <trondmy@hammerspace.com>
> > Cc: David Wysochanski <dwysocha@redhat.com>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/xfs/libxfs/xfs_log_format.h  |  2 +-
> >  fs/xfs/libxfs/xfs_trans_inode.c |  2 +-
> >  fs/xfs/xfs_iops.c               | 10 +++++++---
> >  3 files changed, 9 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/fs/xfs/libxfs/xfs_log_format.h b/fs/xfs/libxfs/xfs_log_for=
mat.h
> > index b351b9dc6561..866a4c5cf70c 100644
> > --- a/fs/xfs/libxfs/xfs_log_format.h
> > +++ b/fs/xfs/libxfs/xfs_log_format.h
> > @@ -323,7 +323,7 @@ struct xfs_inode_log_format_32 {
> >  #define	XFS_ILOG_ABROOT	0x100	/* log i_af.i_broot */
> >  #define XFS_ILOG_DOWNER	0x200	/* change the data fork owner on replay =
*/
> >  #define XFS_ILOG_AOWNER	0x400	/* change the attr fork owner on replay =
*/
> > -
> > +#define XFS_ILOG_NOIVER	0x800	/* don't bump i_version */
> > =20
> >  /*
> >   * The timestamps are dirty, but not necessarily anything else in the =
inode
> > diff --git a/fs/xfs/libxfs/xfs_trans_inode.c b/fs/xfs/libxfs/xfs_trans_=
inode.c
> > index 8b5547073379..ffe6d296e7f9 100644
> > --- a/fs/xfs/libxfs/xfs_trans_inode.c
> > +++ b/fs/xfs/libxfs/xfs_trans_inode.c
> > @@ -126,7 +126,7 @@ xfs_trans_log_inode(
> >  	 * unconditionally.
> >  	 */
> >  	if (!test_and_set_bit(XFS_LI_DIRTY, &iip->ili_item.li_flags)) {
> > -		if (IS_I_VERSION(inode) &&
> > +		if (!(flags & XFS_ILOG_NOIVER) && IS_I_VERSION(inode) &&
> >  		    inode_maybe_inc_iversion(inode, flags & XFS_ILOG_CORE))
> >  			iversion_flags =3D XFS_ILOG_CORE;
> >  	}
> > diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> > index 45518b8c613c..54db85a43dfb 100644
> > --- a/fs/xfs/xfs_iops.c
> > +++ b/fs/xfs/xfs_iops.c
> > @@ -1021,7 +1021,7 @@ xfs_vn_update_time(
> >  {
> >  	struct xfs_inode	*ip =3D XFS_I(inode);
> >  	struct xfs_mount	*mp =3D ip->i_mount;
> > -	int			log_flags =3D XFS_ILOG_TIMESTAMP;
> > +	int			log_flags =3D XFS_ILOG_TIMESTAMP|XFS_ILOG_NOIVER;
> >  	struct xfs_trans	*tp;
> >  	int			error;
> > =20
> > @@ -1041,10 +1041,14 @@ xfs_vn_update_time(
> >  		return error;
> > =20
> >  	xfs_ilock(ip, XFS_ILOCK_EXCL);
> > -	if (flags & S_CTIME)
> > +	if (flags & S_CTIME) {
> >  		inode->i_ctime =3D *now;
> > -	if (flags & S_MTIME)
> > +		log_flags &=3D ~XFS_ILOG_NOIVER;
> > +	}
> > +	if (flags & S_MTIME) {
> >  		inode->i_mtime =3D *now;
> > +		log_flags &=3D ~XFS_ILOG_NOIVER;
> > +	}
> >  	if (flags & S_ATIME)
> >  		inode->i_atime =3D *now;
>=20
> I think you should also clear XFS_ILOG_NOIVER is S_VERSION is set, but
> otherwise this looks sane to me.
>=20
> Thanks,
> NeilBrown

Good point. I'll spin up a v2.

Thanks,
--=20
Jeff Layton <jlayton@kernel.org>
