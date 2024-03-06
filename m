Return-Path: <linux-fsdevel+bounces-13758-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F88087371B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 13:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 735621C21A1D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 12:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E781130AD5;
	Wed,  6 Mar 2024 12:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Kv+721DW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C00578B43;
	Wed,  6 Mar 2024 12:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709729812; cv=none; b=J4roJNEK+d2i9VDfkv5w2Cl9m5ZE3qCcaQcdoG+B/3TQqPfcj8bd0pp4jD4N12RnghlIGUdZjH06sc0iDBWd0mRwO7e5DC9HlFVBnlJyLLIxWCUWgkLmtADoNHA3/VyA/g9/Zb+zvdrLB81lxBqesBccLzpca9/T2XfDkvvZkdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709729812; c=relaxed/simple;
	bh=K+4T1t1fYlm3bHNZus2J5bKmrA/rIRHnPXRpNPk2kdw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ClrvxDjMcrWGGIPENGYL6WOX5YyNmrKdOWgzGVDHKfWcBQOfAx9zWqUPB6hhPZnyIwJmOZppyTFkYm+QhwN/vsPut8OsxUsfXRRwFblZ/3vBqQCZDgJTJD2zXZYDFiO87olzQIhWyJ7Bn/Qzs/ak2kDw0YTRelHiqPCsb+iXUEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Kv+721DW; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 426CbNqQ023639;
	Wed, 6 Mar 2024 12:56:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=TIC8QxWYz2/20GTl1RuwrLMGb//tdSoQQWTLa00LA50=;
 b=Kv+721DWzkixjrNTWyEw8mweoVcjXE+6Ow3tv30mh1Mw9JWNTjzyH74F/Uzko94nRGX7
 xUOoVgH0CSqA8TPCt0deAYmWzFX+xsLQ9Rj3Ur2vF3eEGOSaXw1XX4l6KiDIE4u0p3mb
 ZiIkz+Xh3rrO8DW4QlInR4URU8SB04vu0mmc9Qs6SN6wfnSAI4gUoof+j+yygEqjDTNs
 KCRoeTemlCQ/ogAHM2sC0bpsU4yWsN2oS/j8fGi5T91Lml7dtJ+z7ep6GTZFYXV4ClEO
 YLXt0zm4rjT0qjUuVRHfFHhQwkMc0KfpSUkW9a8aQ0h4dxSylAnSLnPCujk69J1tc4F5 hA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wprna0d00-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 12:56:17 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 426Csk1S010054;
	Wed, 6 Mar 2024 12:56:16 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wprna0ct6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 12:56:16 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 426ChIah006073;
	Wed, 6 Mar 2024 12:56:10 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wmeet6ygw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 12:56:10 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 426Cu7ox35783124
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Mar 2024 12:56:09 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0501A58051;
	Wed,  6 Mar 2024 12:56:07 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 807F65805A;
	Wed,  6 Mar 2024 12:56:05 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com (unknown [9.61.175.142])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 Mar 2024 12:56:05 +0000 (GMT)
Message-ID: <da450fd44278913fda27542f6e9c0d26b0148829.camel@linux.ibm.com>
Subject: Re: [PATCH v2 24/25] commoncap: use vfs fscaps interfaces
From: Mimi Zohar <zohar@linux.ibm.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Christian Brauner
	 <brauner@kernel.org>,
        "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
Cc: Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>,
        Eric
 Paris <eparis@redhat.com>, James Morris <jmorris@namei.org>,
        Alexander Viro
 <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Stephen Smalley
 <stephen.smalley.work@gmail.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Roberto Sassu
 <roberto.sassu@huawei.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        "Matthew Wilcox (Oracle)"
 <willy@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, Miklos Szeredi
 <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org,
        audit@vger.kernel.org, selinux@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Date: Wed, 06 Mar 2024 07:56:05 -0500
In-Reply-To: <1217017cc1928842abfdb40a7fa50bad8ae5e99f.camel@huaweicloud.com>
References: <20240221-idmap-fscap-refactor-v2-0-3039364623bd@kernel.org>
	 <20240221-idmap-fscap-refactor-v2-24-3039364623bd@kernel.org>
	 <dcbd9e7869d2fcce69546b53851d694b8ebad54e.camel@huaweicloud.com>
	 <ZeXpbOsdRTbLsYe9@do-x1extreme>
	 <a7124afa6bed2fcadcb66efa08e256828cd6f8ab.camel@huaweicloud.com>
	 <ZeX9MRhU/EGhHkCY@do-x1extreme>
	 <20240305-fachjargon-abmontieren-75b1d6c67a83@brauner>
	 <3098aef3e5f924e5717b4ba4a34817d9f22ec479.camel@huaweicloud.com>
	 <7058e2f93d16f910336a5380877b14a2e069ee9d.camel@huaweicloud.com>
	 <10773e5b90ec9378cbc69fa9cfeb61a84273edc2.camel@linux.ibm.com>
	 <1217017cc1928842abfdb40a7fa50bad8ae5e99f.camel@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: E5j-kc7WvevmTwvKk7T6_RIK4OIKy8vW
X-Proofpoint-GUID: uSeR4qO7CSvtOXS7HNLBLLt_jgvGmJpS
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_08,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 mlxscore=0 suspectscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 mlxlogscore=999
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403060104

On Wed, 2024-03-06 at 09:25 +0100, Roberto Sassu wrote:
> On Tue, 2024-03-05 at 21:17 -0500, Mimi Zohar wrote:
> > On Tue, 2024-03-05 at 18:11 +0100, Roberto Sassu wrote:
> > > On Tue, 2024-03-05 at 13:46 +0100, Roberto Sassu wrote:
> > > > On Tue, 2024-03-05 at 10:12 +0100, Christian Brauner wrote:
> > > > > On Mon, Mar 04, 2024 at 10:56:17AM -0600, Seth Forshee (DigitalOcean)
> > > > > wrote:
> > > > > > On Mon, Mar 04, 2024 at 05:17:57PM +0100, Roberto Sassu wrote:
> > > > > > > On Mon, 2024-03-04 at 09:31 -0600, Seth Forshee (DigitalOcean)
> > > > > > > wrote:
> > > > > > > > On Mon, Mar 04, 2024 at 11:19:54AM +0100, Roberto Sassu wrote:
> > > > > > > > > On Wed, 2024-02-21 at 15:24 -0600, Seth Forshee (DigitalOcean)
> > > > > > > > > wrote:
> > > > > > > > > > Use the vfs interfaces for fetching file capabilities for
> > > > > > > > > > killpriv
> > > > > > > > > > checks and from get_vfs_caps_from_disk(). While there,
> > > > > > > > > > update
> > > > > > > > > > the
> > > > > > > > > > kerneldoc for get_vfs_caps_from_disk() to explain how it is
> > > > > > > > > > different
> > > > > > > > > > from vfs_get_fscaps_nosec().
> > > > > > > > > > 
> > > > > > > > > > Signed-off-by: Seth Forshee (DigitalOcean) <
> > > > > > > > > > sforshee@kernel.org>
> > > > > > > > > > ---
> > > > > > > > > >  security/commoncap.c | 30 +++++++++++++-----------------
> > > > > > > > > >  1 file changed, 13 insertions(+), 17 deletions(-)
> > > > > > > > > > 
> > > > > > > > > > diff --git a/security/commoncap.c b/security/commoncap.c
> > > > > > > > > > index a0ff7e6092e0..751bb26a06a6 100644
> > > > > > > > > > --- a/security/commoncap.c
> > > > > > > > > > +++ b/security/commoncap.c
> > > > > > > > > > @@ -296,11 +296,12 @@ int cap_capset(struct cred *new,
> > > > > > > > > >   */
> > > > > > > > > >  int cap_inode_need_killpriv(struct dentry *dentry)
> > > > > > > > > >  {
> > > > > > > > > > -	struct inode *inode = d_backing_inode(dentry);
> > > > > > > > > > +	struct vfs_caps caps;
> > > > > > > > > >  	int error;
> > > > > > > > > >  
> > > > > > > > > > -	error = __vfs_getxattr(dentry, inode, XATTR_NAME_CAPS,
> > > > > > > > > > NULL, 0);
> > > > > > > > > > -	return error > 0;
> > > > > > > > > > +	/* Use nop_mnt_idmap for no mapping here as mapping is
> > > > > > > > > > unimportant */
> > > > > > > > > > +	error = vfs_get_fscaps_nosec(&nop_mnt_idmap, dentry,
> > > > > > > > > > &caps);
> > > > > > > > > > +	return error == 0;
> > > > > > > > > >  }
> > > > > > > > > >  
> > > > > > > > > >  /**
> > > > > > > > > > @@ -323,7 +324,7 @@ int cap_inode_killpriv(struct mnt_idmap
> > > > > > > > > > *idmap, struct dentry *dentry)
> > > > > > > > > >  {
> > > > > > > > > >  	int error;
> > > > > > > > > >  
> > > > > > > > > > -	error = __vfs_removexattr(idmap, dentry,
> > > > > > > > > > XATTR_NAME_CAPS);
> > > > > > > > > > +	error = vfs_remove_fscaps_nosec(idmap, dentry);
> > > > > > > > > 
> > > > > > > > > Uhm, I see that the change is logically correct... but the
> > > > > > > > > original
> > > > > > > > > code was not correct, since the EVM post hook is not called
> > > > > > > > > (thus
> > > > > > > > > the
> > > > > > > > > HMAC is broken, or an xattr change is allowed on a portable
> > > > > > > > > signature
> > > > > > > > > which should be not).
> > > > > > > > > 
> > > > > > > > > For completeness, the xattr change on a portable signature
> > > > > > > > > should
> > > > > > > > > not
> > > > > > > > > happen in the first place, so cap_inode_killpriv() would not
> > > > > > > > > be
> > > > > > > > > called.
> > > > > > > > > However, since EVM allows same value change, we are here.
> > > > > > > > 
> > > > > > > > I really don't understand EVM that well and am pretty hesitant
> > > > > > > > to
> > > > > > > > try an
> > > > > > > > change any of the logic around it. But I'll hazard a thought:
> > > > > > > > should
> > > > > > > > EVM
> > > > > > > > have a inode_need_killpriv hook which returns an error in this
> > > > > > > > situation?
> > > > > > > 
> > > > > > > Uhm, I think it would not work without modifying
> > > > > > > security_inode_need_killpriv() and the hook definition.
> > > > > > > 
> > > > > > > Since cap_inode_need_killpriv() returns 1, the loop stops and EVM
> > > > > > > would
> > > > > > > not be invoked. We would need to continue the loop and let EVM
> > > > > > > know
> > > > > > > what is the current return value. Then EVM can reject the change.
> > > > > > > 
> > > > > > > An alternative way would be to detect that actually we are setting
> > > > > > > the
> > > > > > > same value for inode metadata, and maybe not returning 1 from
> > > > > > > cap_inode_need_killpriv().
> > > > > > > 
> > > > > > > I would prefer the second, since EVM allows same value change and
> > > > > > > we
> > > > > > > would have an exception if there are fscaps.
> > > > > > > 
> > > > > > > This solves only the case of portable signatures. We would need to
> > > > > > > change cap_inode_need_killpriv() anyway to update the HMAC for
> > > > > > > mutable
> > > > > > > files.
> > > > > > 
> > > > > > I see. In any case this sounds like a matter for a separate patch
> > > > > > series.
> > > > > 
> > > > > Agreed.
> > > > 
> > > > Christian, how realistic is that we don't kill priv if we are setting
> > > > the same owner?
> > > > 
> > > > Serge, would we be able to replace __vfs_removexattr() (or now
> > > > vfs_get_fscaps_nosec()) with a security-equivalent alternative?
> > > 
> > > It seems it is not necessary.
> > > 
> > > security.capability removal occurs between evm_inode_setattr() and
> > > evm_inode_post_setattr(), after the HMAC has been verified and before
> > > the new HMAC is recalculated (without security.capability).
> > > 
> > > So, all good.
> > > 
> > > Christian, Seth, I pushed the kernel and the updated tests (all patches
> > > are WIP):
> > > 
> > > https://github.com/robertosassu/linux/commits/evm-fscaps-v2/
> > 
> > Resetting the IMA status flag is insufficient.  The EVM status needs to be
> > reset
> > as well.  Stefan's "ima: re-evaluate file integrity on file metadata change"
> > patch does something similar for overlay.
> 
> Both the IMA and EVM status are reset. The IMA one is reset based on
> the evm_revalidate_status() call, similarly to ACLs.

Agreed. Oh, evm_status is being reset in evm_inode_post_set_fscaps().

> 
> 
> > https://lore.kernel.org/linux-integrity/20240223172513.4049959-8-stefanb@linux.ibm.com/
> > 
> > > https://github.com/robertosassu/ima-evm-utils/commits/evm-fscaps-v2/
> > > 
> > > 
> > > The tests are passing:
> > > 
> > > https://github.com/robertosassu/ima-evm-utils/actions/runs/8159877004/job/22305521359
> > > 
> > > Roberto
> > > 
> > > 
> 
> 


