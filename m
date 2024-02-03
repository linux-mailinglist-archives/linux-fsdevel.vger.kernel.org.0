Return-Path: <linux-fsdevel+bounces-10138-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2895184845C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 08:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6534228B66B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 07:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490E94EB44;
	Sat,  3 Feb 2024 07:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XQvPCMWM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850E04EB29;
	Sat,  3 Feb 2024 07:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706946039; cv=none; b=bGNbSYEf43w4n0u72R7xJDOc/RN0yr3ibY+SzE/vfN2QkNorPE6ui2iLEkMo+SY0VHK9xvpa58vmY1Ji0YTwE38LAW/7qPEt4Aco0Ardyt5ASWbxeiN6W5Iig+tCDzERpbjvazi0ZTd3qYCi3L7sJz5nXp/gbeIr/N/YVX36+H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706946039; c=relaxed/simple;
	bh=O6IR3Ohx1gxbiRH4iz1wccxQM4uRavZDHUTkmoHsdl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CDp6UOvN3tOAPee3RRQw/s5ApG668yuBIe7qouz0qCRv4DcETuffdEZddKSWKW4cR7KKWhZVGWvpLU0X12I5j3BbQJoD7+O/W09Gc/jontSnfcU69+14riDPLjrVCkCxtOJbLMolq5Wgn9S0TIJZBrNG9/GIyQFhtq/6EFzPHCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XQvPCMWM; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4135a9RO004995;
	Sat, 3 Feb 2024 07:40:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=ccOT3hk1NexIyVmbqMjfKnwzvO4hxurpIMTsxDIM3Qw=;
 b=XQvPCMWMmmbKjGhIs/yW66R9FGdKoKqYzPa/WZHmRd78RD2H87Tujb3vjGZEhcmONZbh
 wP5aPDC+tDTQyMuDSxDyiuVn4WsssbMceZg0T5/RgUrPDgPcpNu0klXoAjUiSVjSSHdx
 mFr07tC/kO2qPfPFTpXkpx2qczmFVfCuFrMQrm3FW6ji+1v+5v3PgdGcfRPRH1ZpobqG
 PLBtW7rvymPPufcW0o0BP+kSne7dFwtgorcrZmYtSHnS3oay6PeF+//simZ9W97mrbtm
 xO63AH8W904y4AVQz33K/282E+dbb6GyQo4M5ZU0VGIg3ENZTXU6Gx37ZHVN62m350F5 qw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w1fbp9qj8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 03 Feb 2024 07:40:24 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4137eIQk019713;
	Sat, 3 Feb 2024 07:40:23 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w1fbp9qj1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 03 Feb 2024 07:40:23 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41374Uoo007168;
	Sat, 3 Feb 2024 07:40:22 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vwev2yyqj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 03 Feb 2024 07:40:22 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4137eK5Y16974452
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 3 Feb 2024 07:40:21 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D2C2520049;
	Sat,  3 Feb 2024 07:40:20 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C10C20040;
	Sat,  3 Feb 2024 07:40:18 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.35.236])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sat,  3 Feb 2024 07:40:17 +0000 (GMT)
Date: Sat, 3 Feb 2024 13:10:15 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: John Garry <john.g.garry@oracle.com>, hch@lst.de, viro@zeniv.linux.org.uk,
        brauner@kernel.org, dchinner@redhat.com, jack@suse.cz,
        chandan.babu@oracle.com, martin.petersen@oracle.com,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com
Subject: Re: [PATCH 3/6] fs: xfs: Support FS_XFLAG_ATOMICWRITES for rtvol
Message-ID: <Zb3t38pzLmoRAbbz@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20240124142645.9334-1-john.g.garry@oracle.com>
 <20240124142645.9334-4-john.g.garry@oracle.com>
 <20240202175225.GH6184@frogsfrogsfrogs>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202175225.GH6184@frogsfrogsfrogs>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Ut9OntH1oSy0lAS_x8qFVIMO-mfFi7qw
X-Proofpoint-ORIG-GUID: kqVxo2DIvZUeRV1A5neUcjN79OJY_F-d
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-03_03,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 suspectscore=0 mlxlogscore=999 clxscore=1011 spamscore=0
 phishscore=0 mlxscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402030052

On Fri, Feb 02, 2024 at 09:52:25AM -0800, Darrick J. Wong wrote:
> On Wed, Jan 24, 2024 at 02:26:42PM +0000, John Garry wrote:
> > Add initial support for FS_XFLAG_ATOMICWRITES in rtvol.
> > 
> > Current kernel support for atomic writes is based on HW support (for atomic
> > writes). As such, it is required to ensure extent alignment with
> > atomic_write_unit_max so that an atomic write can result in a single
> > HW-compliant IO operation.
> > 
> > rtvol already guarantees extent alignment, so initially add support there.
> > 
> > Signed-off-by: John Garry <john.g.garry@oracle.com>
> > ---
> >  fs/xfs/libxfs/xfs_format.h |  8 ++++++--
> >  fs/xfs/libxfs/xfs_sb.c     |  2 ++
> >  fs/xfs/xfs_inode.c         | 22 ++++++++++++++++++++++
> >  fs/xfs/xfs_inode.h         |  7 +++++++
> >  fs/xfs/xfs_ioctl.c         | 19 +++++++++++++++++--
> >  fs/xfs/xfs_mount.h         |  2 ++
> >  fs/xfs/xfs_super.c         |  4 ++++
> >  7 files changed, 60 insertions(+), 4 deletions(-)
> > 
> > diff --git a/fs/xfs/libxfs/xfs_format.h b/fs/xfs/libxfs/xfs_format.h
> > index 382ab1e71c0b..79fb0d4adeda 100644
> > --- a/fs/xfs/libxfs/xfs_format.h
> > +++ b/fs/xfs/libxfs/xfs_format.h
> > @@ -353,11 +353,13 @@ xfs_sb_has_compat_feature(
> >  #define XFS_SB_FEAT_RO_COMPAT_RMAPBT   (1 << 1)		/* reverse map btree */
> >  #define XFS_SB_FEAT_RO_COMPAT_REFLINK  (1 << 2)		/* reflinked files */
> >  #define XFS_SB_FEAT_RO_COMPAT_INOBTCNT (1 << 3)		/* inobt block counts */
> > +#define XFS_SB_FEAT_RO_COMPAT_ATOMICWRITES (1 << 29)	/* aligned file data extents */
> 
> I thought FORCEALIGN was going to signal aligned file data extent
> allocations being mandatory?
> 
> This flag (AFAICT) simply marks the inode as something that gets
> FMODE_CAN_ATOMIC_WRITES, right?
> 
> >  #define XFS_SB_FEAT_RO_COMPAT_ALL \
> >  		(XFS_SB_FEAT_RO_COMPAT_FINOBT | \
> >  		 XFS_SB_FEAT_RO_COMPAT_RMAPBT | \
> >  		 XFS_SB_FEAT_RO_COMPAT_REFLINK| \
> > -		 XFS_SB_FEAT_RO_COMPAT_INOBTCNT)
> > +		 XFS_SB_FEAT_RO_COMPAT_INOBTCNT | \
> > +		 XFS_SB_FEAT_RO_COMPAT_ATOMICWRITES)
> >  #define XFS_SB_FEAT_RO_COMPAT_UNKNOWN	~XFS_SB_FEAT_RO_COMPAT_ALL
> >  static inline bool
> >  xfs_sb_has_ro_compat_feature(
> > @@ -1085,16 +1087,18 @@ static inline void xfs_dinode_put_rdev(struct xfs_dinode *dip, xfs_dev_t rdev)
> >  #define XFS_DIFLAG2_COWEXTSIZE_BIT   2  /* copy on write extent size hint */
> >  #define XFS_DIFLAG2_BIGTIME_BIT	3	/* big timestamps */
> >  #define XFS_DIFLAG2_NREXT64_BIT 4	/* large extent counters */
> > +#define XFS_DIFLAG2_ATOMICWRITES_BIT 6
> 
> Needs a comment here ("files flagged for atomic writes").  Also not sure
> why you skipped bit 5, though I'm guessing it's because the forcealign
> series is/was using it?
> 
> >  #define XFS_DIFLAG2_DAX		(1 << XFS_DIFLAG2_DAX_BIT)
> >  #define XFS_DIFLAG2_REFLINK     (1 << XFS_DIFLAG2_REFLINK_BIT)
> >  #define XFS_DIFLAG2_COWEXTSIZE  (1 << XFS_DIFLAG2_COWEXTSIZE_BIT)
> >  #define XFS_DIFLAG2_BIGTIME	(1 << XFS_DIFLAG2_BIGTIME_BIT)
> >  #define XFS_DIFLAG2_NREXT64	(1 << XFS_DIFLAG2_NREXT64_BIT)
> > +#define XFS_DIFLAG2_ATOMICWRITES	(1 << XFS_DIFLAG2_ATOMICWRITES_BIT)
> >  
> >  #define XFS_DIFLAG2_ANY \
> >  	(XFS_DIFLAG2_DAX | XFS_DIFLAG2_REFLINK | XFS_DIFLAG2_COWEXTSIZE | \
> > -	 XFS_DIFLAG2_BIGTIME | XFS_DIFLAG2_NREXT64)
> > +	 XFS_DIFLAG2_BIGTIME | XFS_DIFLAG2_NREXT64 | XFS_DIFLAG2_ATOMICWRITES)
> >  
> >  static inline bool xfs_dinode_has_bigtime(const struct xfs_dinode *dip)
> >  {
> > diff --git a/fs/xfs/libxfs/xfs_sb.c b/fs/xfs/libxfs/xfs_sb.c
> > index 4a9e8588f4c9..28a98130a56d 100644
> > --- a/fs/xfs/libxfs/xfs_sb.c
> > +++ b/fs/xfs/libxfs/xfs_sb.c
> > @@ -163,6 +163,8 @@ xfs_sb_version_to_features(
> >  		features |= XFS_FEAT_REFLINK;
> >  	if (sbp->sb_features_ro_compat & XFS_SB_FEAT_RO_COMPAT_INOBTCNT)
> >  		features |= XFS_FEAT_INOBTCNT;
> > +	if (sbp->sb_features_ro_compat & XFS_SB_FEAT_RO_COMPAT_ATOMICWRITES)
> > +		features |= XFS_FEAT_ATOMICWRITES;
> >  	if (sbp->sb_features_incompat & XFS_SB_FEAT_INCOMPAT_FTYPE)
> >  		features |= XFS_FEAT_FTYPE;
> >  	if (sbp->sb_features_incompat & XFS_SB_FEAT_INCOMPAT_SPINODES)
> > diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> > index 1fd94958aa97..0b0f525fd043 100644
> > --- a/fs/xfs/xfs_inode.c
> > +++ b/fs/xfs/xfs_inode.c
> > @@ -65,6 +65,26 @@ xfs_get_extsz_hint(
> >  	return 0;
> >  }
> >  
> > +/*
> > + * helper function to extract extent size
> 
> How does that differ from xfs_get_extsz_hint?
> 
> > + */
> > +xfs_extlen_t
> > +xfs_get_extsz(
> > +	struct xfs_inode	*ip)
> > +{
> > +	/*
> > +	 * No point in aligning allocations if we need to COW to actually
> > +	 * write to them.
> 
> What does alwayscow have to do with untorn writes?
> 
> > +	 */
> > +	if (xfs_is_always_cow_inode(ip))
> > +		return 0;
> > +
> > +	if (XFS_IS_REALTIME_INODE(ip))
> > +		return ip->i_mount->m_sb.sb_rextsize;
> > +
> > +	return 1;
> > +}
> 
> Does this function exist to return the allocation unit for a given file?
> https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/commit/?h=djwong-wtf&id=b8ddcef3df8da02ed2c4aacbed1d811e60372006
> 
> > +
> >  /*
> >   * Helper function to extract CoW extent size hint from inode.
> >   * Between the extent size hint and the CoW extent size hint, we
> > @@ -629,6 +649,8 @@ xfs_ip2xflags(
> >  			flags |= FS_XFLAG_DAX;
> >  		if (ip->i_diflags2 & XFS_DIFLAG2_COWEXTSIZE)
> >  			flags |= FS_XFLAG_COWEXTSIZE;
> > +		if (ip->i_diflags2 & XFS_DIFLAG2_ATOMICWRITES)
> > +			flags |= FS_XFLAG_ATOMICWRITES;
> >  	}
> >  
> >  	if (xfs_inode_has_attr_fork(ip))
> > diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
> > index 97f63bacd4c2..0e0a21d9d30f 100644
> > --- a/fs/xfs/xfs_inode.h
> > +++ b/fs/xfs/xfs_inode.h
> > @@ -305,6 +305,11 @@ static inline bool xfs_inode_has_large_extent_counts(struct xfs_inode *ip)
> >  	return ip->i_diflags2 & XFS_DIFLAG2_NREXT64;
> >  }
> >  
> > +static inline bool xfs_inode_atomicwrites(struct xfs_inode *ip)
> 
> I think this predicate wants a verb in its name, the rest of them have
> "is" or "has" somewhere:
> 
> "xfs_inode_has_atomicwrites"
> 
> > +{
> > +	return ip->i_diflags2 & XFS_DIFLAG2_ATOMICWRITES;
> > +}
> > +
> >  /*
> >   * Return the buftarg used for data allocations on a given inode.
> >   */
> > @@ -542,7 +547,9 @@ void		xfs_lock_two_inodes(struct xfs_inode *ip0, uint ip0_mode,
> >  				struct xfs_inode *ip1, uint ip1_mode);
> >  
> >  xfs_extlen_t	xfs_get_extsz_hint(struct xfs_inode *ip);
> > +xfs_extlen_t	xfs_get_extsz(struct xfs_inode *ip);
> >  xfs_extlen_t	xfs_get_cowextsz_hint(struct xfs_inode *ip);
> > +xfs_extlen_t	xfs_get_atomicwrites_size(struct xfs_inode *ip);
> >  
> >  int xfs_init_new_inode(struct mnt_idmap *idmap, struct xfs_trans *tp,
> >  		struct xfs_inode *pip, xfs_ino_t ino, umode_t mode,
> > diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
> > index f02b6e558af5..c380a3055be7 100644
> > --- a/fs/xfs/xfs_ioctl.c
> > +++ b/fs/xfs/xfs_ioctl.c
> > @@ -1110,6 +1110,8 @@ xfs_flags2diflags2(
> >  		di_flags2 |= XFS_DIFLAG2_DAX;
> >  	if (xflags & FS_XFLAG_COWEXTSIZE)
> >  		di_flags2 |= XFS_DIFLAG2_COWEXTSIZE;
> > +	if (xflags & FS_XFLAG_ATOMICWRITES)
> > +		di_flags2 |= XFS_DIFLAG2_ATOMICWRITES;
> >  
> >  	return di_flags2;
> >  }
> > @@ -1122,10 +1124,12 @@ xfs_ioctl_setattr_xflags(
> >  {
> >  	struct xfs_mount	*mp = ip->i_mount;
> >  	bool			rtflag = (fa->fsx_xflags & FS_XFLAG_REALTIME);
> > +	bool			atomic_writes = fa->fsx_xflags & FS_XFLAG_ATOMICWRITES;
> >  	uint64_t		i_flags2;
> >  
> > -	if (rtflag != XFS_IS_REALTIME_INODE(ip)) {
> > -		/* Can't change realtime flag if any extents are allocated. */
> 
> Please augment this comment ("Can't change realtime or atomicwrites
> flags if any extents are allocated") instead of deleting it.  This is
> validation code, the requirements should be spelled out in English.
> 
> > +
> > +	if (rtflag != XFS_IS_REALTIME_INODE(ip) ||
> > +	    atomic_writes != xfs_inode_atomicwrites(ip)) {
> >  		if (ip->i_df.if_nextents || ip->i_delayed_blks)
> >  			return -EINVAL;
> >  	}
> > @@ -1146,6 +1150,17 @@ xfs_ioctl_setattr_xflags(
> >  	if (i_flags2 && !xfs_has_v3inodes(mp))
> >  		return -EINVAL;
> >  
> > +	if (atomic_writes) {
> > +		if (!xfs_has_atomicwrites(mp))
> > +			return -EINVAL;
> > +
> > +		if (!rtflag)
> > +			return -EINVAL;
> > +
> > +		if (!is_power_of_2(mp->m_sb.sb_rextsize))
> > +			return -EINVAL;
> 
> Shouldn't we check sb_rextsize w.r.t. the actual block device queue
> limits here?  I keep seeing similar validation logic open-coded
> throughout both atomic write patchsets:
> 
> 	if (l < queue_atomic_write_unit_min_bytes())
> 		/* fail */
> 	if (l > queue_atomic_write_unit_max_bytes())
> 		/* fail */
> 	if (!is_power_of_2(l))
> 		/* fail */
> 	/* ok */
> 
> which really should be a common helper somewhere.
> 
> 		/*
> 		 * Don't set atomic write if the allocation unit doesn't
> 		 * align with the device requirements.
> 		 */
> 		if (!bdev_validate_atomic_write(<target blockdev>,
> 				XFS_FSB_TO_B(mp, mp->m_sb.sb_rextsize))
> 			return -EINVAL;
> 
> Too bad we have to figure out the target blockdev and file allocation
> unit based on the ioctl in-params and can't use the xfs_inode helpers
> here.
> 
> --D

Hey John, Darrick,

I agree that we should have a common helper to validate block device
limits. I tried to do so by exporting blkdev_atomic_write_valid() in the
ext4 series [1].

There was also some discussion on moving this to VFS, where we can check
against the len and off of the write and then we can make fs specific
checks (eg if off,len align with rt extsize/bigalloc size) later in the
fs layer.

[1]
https://lore.kernel.org/linux-ext4/b53609d0d4b97eb9355987ac5ec03d4e89293b43.1701339358.git.ojaswin@linux.ibm.com/


