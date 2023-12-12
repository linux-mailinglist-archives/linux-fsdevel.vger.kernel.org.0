Return-Path: <linux-fsdevel+bounces-5708-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 451B680F0F0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 16:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EDF2B216D1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 15:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B297F7A20F;
	Tue, 12 Dec 2023 15:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OV56CZjg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6671706;
	Tue, 12 Dec 2023 07:28:01 -0800 (PST)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BCEPYIZ011633;
	Tue, 12 Dec 2023 15:27:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=6P7xoDilkGWxN+TMBgFKeNe23iVMd0E0n5jMfKeLyZ8=;
 b=OV56CZjglftKG6V7ahCTVFWHhElDr6KcbAmFGf7w59eNeb4ceFY2JCoKLFvQF0bBqput
 wKnE9OBn9kOaoROu+0umf5gw2yg77PO+15Pq9nxuTguVpYv9lwy2ixw8pvJRJqx6HYWR
 4wHJZq1YQ95Lm6LAxtRsAmCTv4QT8mD3CSScuLUoOkHq7Fmd7Al6/1rp84fKKSEXOQ4l
 /J+JZqWohbY3/a/ljaGyL3X4mC/oYsxFnr8kIrlKM6Gnft+W2uaiF6WwYIA2apHbEExc
 KB7w7V4z1EmLN0pcVs0oSwl4HMh6YJWyDKe7vtxJ/OtpM6Tp54W48XjOQnOku75Zk+ZQ Og== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uxnjysg3q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Dec 2023 15:27:09 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BCEtncS031530;
	Tue, 12 Dec 2023 15:27:09 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uxnjysg30-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Dec 2023 15:27:09 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BCETZqH012585;
	Tue, 12 Dec 2023 15:27:08 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uw3jnsw2s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Dec 2023 15:27:08 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BCFR7DA20382378
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Dec 2023 15:27:07 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A3AAA58054;
	Tue, 12 Dec 2023 15:27:07 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 19F845805C;
	Tue, 12 Dec 2023 15:27:06 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.159.221])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 12 Dec 2023 15:27:05 +0000 (GMT)
Message-ID: <a9297cc1bf23e34aba3c7597681e9e71a03b37f9.camel@linux.ibm.com>
Subject: Re: [RFC][PATCH] overlayfs: Redirect xattr ops on security.evm to
 security.evm_overlayfs
From: Mimi Zohar <zohar@linux.ibm.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Amir Goldstein
	 <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
        Seth Forshee
 <sforshee@kernel.org>, miklos@szeredi.hu,
        linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, stefanb@linux.ibm.com, jlayton@kernel.org,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Eric Snowberg
 <eric.snowberg@oracle.com>
Date: Tue, 12 Dec 2023 10:27:05 -0500
In-Reply-To: <59bf3530-2a6e-4caa-ac42-4d0dab9a71d1@huaweicloud.com>
References: <20231208172308.2876481-1-roberto.sassu@huaweicloud.com>
	 <CAOQ4uxivpZ+u0A5kE962XST37-ey2Tv9EtddnZQhk3ohRkcQTw@mail.gmail.com>
	 <20231208-tauziehen-zerfetzt-026e7ee800a0@brauner>
	 <c95b24f27021052209ec6911d2b7e7b20e410f43.camel@huaweicloud.com>
	 <20231211-fortziehen-basen-b8c0639044b8@brauner>
	 <019f134a-6ab4-48ca-991c-5a5c94e042ea@huaweicloud.com>
	 <CAOQ4uxgpNt7qKEF_NEJPsKU7-XhM7N_3eP68FrOpMpcRcHt4rQ@mail.gmail.com>
	 <59bf3530-2a6e-4caa-ac42-4d0dab9a71d1@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uRXCe-o40XxvGBalIy-o0TY5V_4UqA_Z
X-Proofpoint-ORIG-GUID: 7CpOlOBGa5y5k0JZ0iJRCU9QbIPHGwGo
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-12_08,2023-12-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 malwarescore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0 phishscore=0
 mlxscore=0 adultscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312120117

On Tue, 2023-12-12 at 14:13 +0100, Roberto Sassu wrote:
> On 12.12.23 11:44, Amir Goldstein wrote:
> > On Tue, Dec 12, 2023 at 12:25 PM Roberto Sassu
> > <roberto.sassu@huaweicloud.com> wrote:
> >>
> >> On 11.12.23 19:01, Christian Brauner wrote:
> >>>> The second problem is that one security.evm is not enough. We need two,
> >>>> to store the two different HMACs. And we need both at the same time,
> >>>> since when overlayfs is mounted the lower/upper directories can be
> >>>> still accessible.
> >>>
> >>> "Changes to the underlying filesystems while part of a mounted overlay
> >>> filesystem are not allowed. If the underlying filesystem is changed, the
> >>> behavior of the overlay is undefined, though it will not result in a
> >>> crash or deadlock."
> >>>
> >>> https://docs.kernel.org/filesystems/overlayfs.html#changes-to-underlying-filesystems
> >>>
> >>> So I don't know why this would be a problem.
> >>
> >> + Eric Snowberg
> >>
> >> Ok, that would reduce the surface of attack. However, when looking at:
> >>
> >>        ovl: Always reevaluate the file signature for IMA
> >>
> >>        Commit db1d1e8b9867 ("IMA: use vfs_getattr_nosec to get the
> >> i_version")
> >>        partially closed an IMA integrity issue when directly modifying a file
> >>        on the lower filesystem.  If the overlay file is first opened by a
> >> user
> >>        and later the lower backing file is modified by root, but the extended
> >>        attribute is NOT updated, the signature validation succeeds with
> >> the old
> >>        original signature.
> >>
> >> Ok, so if the behavior of overlayfs is undefined if the lower backing
> >> file is modified by root, do we need to reevaluate? Or instead would be
> >> better to forbid the write from IMA (legitimate, I think, since the
> >> behavior is documented)? I just saw that we have d_real_inode(), we can
> >> use it to determine if the write should be denied.
> >>
> > 
> > There may be several possible legitimate actions in this case, but the
> > overall concept IMO should be the same as I said about EVM -
> > overlayfs does not need an IMA signature of its own, because it
> > can use the IMA signature of the underlying file.
> > 
> > Whether overlayfs reads a file from lower fs or upper fs, it does not
> > matter, the only thing that matters is that the underlying file content
> > is attested when needed.
> > 
> > The only incident that requires special attention is copy-up.
> > This is what the security hooks security_inode_copy_up() and
> > security_inode_copy_up_xattr() are for.
> > 
> > When a file starts in state "lower" and has security.ima,evm xattrs
> > then before a user changes the file, it is copied up to upper fs
> > and suppose that security.ima,evm xattrs are copied as is?

For IMA copying up security.ima is fine.  Other than EVM portable
signatures, security.evm contains filesystem specific metadata. 
Copying security.evm up only works if the metadata is the same on both
filesystems.  Currently the i_generation and i_sb->s_uuid are
different.

> > When later the overlayfs file content is read from the upper copy
> > the security.ima signature should be enough to attest that file content
> > was not tampered with between going from "lower" to "upper".
> > 
> > security.evm may need to be fixed on copy up, but that should be
> > easy to do with the security_inode_copy_up_xattr() hook. No?

Writing security.evm requires the existing security.evm to be valid. 
After each security xattr in the protected list is modified,
security.evm HMAC needs to be updated.  Perhaps calculating and writing
security.evm could be triggered by security_inode_copy_up_xattr(). 
Just copying a non-portable EVM signature wouldn't work, or for that
matter copying an EVM HMAC with different filesystem metadata.

> It is not yet clear to me. EVM will be seeing the creation of a new 
> file, and for new files setting xattrs is already allowed.
> 
> Maybe the security_inode_copy_up*() would be useful for IMA/EVM to 
> authorize writes by overlayfs, which would be otherwise denied to the 
> others (according to my solution).
> 
> Still, would like to hear Mimi's opinion.

Thanks Roberto for all your work and analysis.  I'm still looking at
security_inode_copy_up_xattr().

Mimi


