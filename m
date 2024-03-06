Return-Path: <linux-fsdevel+bounces-13675-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 509A1872CB1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 03:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06AD51F24304
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 02:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E92DDAB;
	Wed,  6 Mar 2024 02:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nxQYEVlH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91206117;
	Wed,  6 Mar 2024 02:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709691751; cv=none; b=uNKh8eCFw23D6KNRlGMjlt7NrcOgg4QR/No4pS2MJcnjQcsYxM3vVnPVIHU9el3JP2W6X0wiOCcFPQSgxhQqRVrAL8i8/8RUNoRhoBXrzauJyZqJeu0xUSW2ic3cgC6jBFSwxuiz4919Wn+fT1d77ePRgwuOn7R7RCrRF1h+fyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709691751; c=relaxed/simple;
	bh=BY5cAWwdUufd1lZC7KL4e1CLMCvpDyaykzCDEmw3piE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QWyeH9TLe17tA/S0HWn0Qmp/Yr9TsmrSUx5Mb198d/2OdTwZ/3efK//uadLW2U8HMSRJw+THjaqpZUN+F2fxVnkKO5nVFickSx2QlPJOW65bhGJWFCjdrT8k+10nvIePZc8XVnVd9tU7Rq618g14ZMvkZJPRsp90BYT+4AdXufI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nxQYEVlH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4261v3aj030129;
	Wed, 6 Mar 2024 02:21:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=obieB/aGXWUQxrjkUCIoo5ZBlMGaQ2KaeavDHRbRQLI=;
 b=nxQYEVlHsY8TY9DZ7RvKpc9ICN6yUD3ks/4AjtAMmEQtTmgl7BmRMd2keEOziSpMnbe8
 RM07du1XSbu2YrzoqJnB9dd62sqqwf3d6ttYyyAzcdFQ8Witk711uc/gtgp2qTVKtfsq
 T7j2xnOwKyPniGxCjrik350kSQzK4tHZGQ21i2GRWO79Ezim++Flmr+Kr4r9P8BZa+KL
 OVhCReVGdzPFiArK1tvXfR5zUmgY3KApxixvBSSCTOPdTR0eKhzWUt4M04KdG58X76CS
 TFpcBlpJ37N2behrtvT636E58DI8fivLcL2YPxtKZYwAJYSEo8+yRwgUNOoiA92l4L0K fQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wpf9b0cej-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 02:21:46 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42625tFc019455;
	Wed, 6 Mar 2024 02:21:45 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wpf9b0ccx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 02:21:45 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4261c6Pt020608;
	Wed, 6 Mar 2024 02:17:39 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wmfxkukta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 02:17:39 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4262HaMD43909640
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Mar 2024 02:17:38 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5456558056;
	Wed,  6 Mar 2024 02:17:36 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D3B705804E;
	Wed,  6 Mar 2024 02:17:33 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com (unknown [9.61.10.162])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 Mar 2024 02:17:33 +0000 (GMT)
Message-ID: <10773e5b90ec9378cbc69fa9cfeb61a84273edc2.camel@linux.ibm.com>
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
Date: Tue, 05 Mar 2024 21:17:33 -0500
In-Reply-To: <7058e2f93d16f910336a5380877b14a2e069ee9d.camel@huaweicloud.com>
References: <20240221-idmap-fscap-refactor-v2-0-3039364623bd@kernel.org>
	 <20240221-idmap-fscap-refactor-v2-24-3039364623bd@kernel.org>
	 <dcbd9e7869d2fcce69546b53851d694b8ebad54e.camel@huaweicloud.com>
	 <ZeXpbOsdRTbLsYe9@do-x1extreme>
	 <a7124afa6bed2fcadcb66efa08e256828cd6f8ab.camel@huaweicloud.com>
	 <ZeX9MRhU/EGhHkCY@do-x1extreme>
	 <20240305-fachjargon-abmontieren-75b1d6c67a83@brauner>
	 <3098aef3e5f924e5717b4ba4a34817d9f22ec479.camel@huaweicloud.com>
	 <7058e2f93d16f910336a5380877b14a2e069ee9d.camel@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5d2LP9goU7jdJnNYQKugPWTEZlmFuvLX
X-Proofpoint-ORIG-GUID: 9zv_pGh2oYkeWF_4Thb1moVWjaRCV6Bo
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
 definitions=2024-03-05_20,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 adultscore=0 malwarescore=0 suspectscore=0 impostorscore=0 clxscore=1011
 mlxlogscore=999 spamscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403060018

On Tue, 2024-03-05 at 18:11 +0100, Roberto Sassu wrote:
> On Tue, 2024-03-05 at 13:46 +0100, Roberto Sassu wrote:
> > On Tue, 2024-03-05 at 10:12 +0100, Christian Brauner wrote:
> > > On Mon, Mar 04, 2024 at 10:56:17AM -0600, Seth Forshee (DigitalOcean)
> > > wrote:
> > > > On Mon, Mar 04, 2024 at 05:17:57PM +0100, Roberto Sassu wrote:
> > > > > On Mon, 2024-03-04 at 09:31 -0600, Seth Forshee (DigitalOcean) wrote:
> > > > > > On Mon, Mar 04, 2024 at 11:19:54AM +0100, Roberto Sassu wrote:
> > > > > > > On Wed, 2024-02-21 at 15:24 -0600, Seth Forshee (DigitalOcean)
> > > > > > > wrote:
> > > > > > > > Use the vfs interfaces for fetching file capabilities for
> > > > > > > > killpriv
> > > > > > > > checks and from get_vfs_caps_from_disk(). While there, update
> > > > > > > > the
> > > > > > > > kerneldoc for get_vfs_caps_from_disk() to explain how it is
> > > > > > > > different
> > > > > > > > from vfs_get_fscaps_nosec().
> > > > > > > > 
> > > > > > > > Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
> > > > > > > > ---
> > > > > > > >  security/commoncap.c | 30 +++++++++++++-----------------
> > > > > > > >  1 file changed, 13 insertions(+), 17 deletions(-)
> > > > > > > > 
> > > > > > > > diff --git a/security/commoncap.c b/security/commoncap.c
> > > > > > > > index a0ff7e6092e0..751bb26a06a6 100644
> > > > > > > > --- a/security/commoncap.c
> > > > > > > > +++ b/security/commoncap.c
> > > > > > > > @@ -296,11 +296,12 @@ int cap_capset(struct cred *new,
> > > > > > > >   */
> > > > > > > >  int cap_inode_need_killpriv(struct dentry *dentry)
> > > > > > > >  {
> > > > > > > > -	struct inode *inode = d_backing_inode(dentry);
> > > > > > > > +	struct vfs_caps caps;
> > > > > > > >  	int error;
> > > > > > > >  
> > > > > > > > -	error = __vfs_getxattr(dentry, inode, XATTR_NAME_CAPS,
> > > > > > > > NULL, 0);
> > > > > > > > -	return error > 0;
> > > > > > > > +	/* Use nop_mnt_idmap for no mapping here as mapping is
> > > > > > > > unimportant */
> > > > > > > > +	error = vfs_get_fscaps_nosec(&nop_mnt_idmap, dentry,
> > > > > > > > &caps);
> > > > > > > > +	return error == 0;
> > > > > > > >  }
> > > > > > > >  
> > > > > > > >  /**
> > > > > > > > @@ -323,7 +324,7 @@ int cap_inode_killpriv(struct mnt_idmap
> > > > > > > > *idmap, struct dentry *dentry)
> > > > > > > >  {
> > > > > > > >  	int error;
> > > > > > > >  
> > > > > > > > -	error = __vfs_removexattr(idmap, dentry,
> > > > > > > > XATTR_NAME_CAPS);
> > > > > > > > +	error = vfs_remove_fscaps_nosec(idmap, dentry);
> > > > > > > 
> > > > > > > Uhm, I see that the change is logically correct... but the
> > > > > > > original
> > > > > > > code was not correct, since the EVM post hook is not called (thus
> > > > > > > the
> > > > > > > HMAC is broken, or an xattr change is allowed on a portable
> > > > > > > signature
> > > > > > > which should be not).
> > > > > > > 
> > > > > > > For completeness, the xattr change on a portable signature should
> > > > > > > not
> > > > > > > happen in the first place, so cap_inode_killpriv() would not be
> > > > > > > called.
> > > > > > > However, since EVM allows same value change, we are here.
> > > > > > 
> > > > > > I really don't understand EVM that well and am pretty hesitant to
> > > > > > try an
> > > > > > change any of the logic around it. But I'll hazard a thought: should
> > > > > > EVM
> > > > > > have a inode_need_killpriv hook which returns an error in this
> > > > > > situation?
> > > > > 
> > > > > Uhm, I think it would not work without modifying
> > > > > security_inode_need_killpriv() and the hook definition.
> > > > > 
> > > > > Since cap_inode_need_killpriv() returns 1, the loop stops and EVM
> > > > > would
> > > > > not be invoked. We would need to continue the loop and let EVM know
> > > > > what is the current return value. Then EVM can reject the change.
> > > > > 
> > > > > An alternative way would be to detect that actually we are setting the
> > > > > same value for inode metadata, and maybe not returning 1 from
> > > > > cap_inode_need_killpriv().
> > > > > 
> > > > > I would prefer the second, since EVM allows same value change and we
> > > > > would have an exception if there are fscaps.
> > > > > 
> > > > > This solves only the case of portable signatures. We would need to
> > > > > change cap_inode_need_killpriv() anyway to update the HMAC for mutable
> > > > > files.
> > > > 
> > > > I see. In any case this sounds like a matter for a separate patch
> > > > series.
> > > 
> > > Agreed.
> > 
> > Christian, how realistic is that we don't kill priv if we are setting
> > the same owner?
> > 
> > Serge, would we be able to replace __vfs_removexattr() (or now
> > vfs_get_fscaps_nosec()) with a security-equivalent alternative?
> 
> It seems it is not necessary.
> 
> security.capability removal occurs between evm_inode_setattr() and
> evm_inode_post_setattr(), after the HMAC has been verified and before
> the new HMAC is recalculated (without security.capability).
> 
> So, all good.
> 
> Christian, Seth, I pushed the kernel and the updated tests (all patches
> are WIP):
> 
> https://github.com/robertosassu/linux/commits/evm-fscaps-v2/

Resetting the IMA status flag is insufficient.  The EVM status needs to be reset
as well.  Stefan's "ima: re-evaluate file integrity on file metadata change"
patch does something similar for overlay.

Mimi

https://lore.kernel.org/linux-integrity/20240223172513.4049959-8-stefanb@linux.ibm.com/

> 
> https://github.com/robertosassu/ima-evm-utils/commits/evm-fscaps-v2/
> 
> 
> The tests are passing:
> 
> https://github.com/robertosassu/ima-evm-utils/actions/runs/8159877004/job/22305521359
> 
> Roberto
> 
> 


