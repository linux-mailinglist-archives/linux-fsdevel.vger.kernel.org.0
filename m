Return-Path: <linux-fsdevel+bounces-6084-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9438135CB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 17:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 402F31F216F2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 16:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1573A5F1D5;
	Thu, 14 Dec 2023 16:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TClWSD6Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC083115;
	Thu, 14 Dec 2023 08:10:13 -0800 (PST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BEFW6Fa010339;
	Thu, 14 Dec 2023 16:09:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=65zoArfKlAIKj+jHAyVvOkf//7nWNHHCKZamla+kz0Y=;
 b=TClWSD6Qx0RGjGrbdNeLoCsTdrhG4E5pK6b975v+r8iHZ7BuVhFIam8BVLKja0EV8RdM
 O7PZ9S3ZQP/dPbFUzi6qSNo2rmQR8LR16aCFphHL5Mamla5kShsoyD6dry7ewjqVxhbk
 Dn/k1z70RerMnxPIs9QNmHLw3PrM8w8TtKhCZnmFoqjwA/7Bk8hoVAw1w/O+kX8jwTcX
 xO73n+FvpGh/SSbRrI/a2lhJ4xL+uGBWxLSaxnV9+JGQDQoNbuPRAa3zB7nNNcxmF4nI
 2LOc7RttJcPjZV2PnGX75MKJQ4ilfQFpWGJy6r7Hi1E7cHaef0gt4h/n64nXq1CAh/gZ UA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v04ea94sk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Dec 2023 16:09:48 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BEFWCPH010489;
	Thu, 14 Dec 2023 16:09:47 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v04ea94s3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Dec 2023 16:09:47 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BEEFE4g013874;
	Thu, 14 Dec 2023 16:09:46 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uw592h39a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Dec 2023 16:09:46 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BEG9jV618612888
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Dec 2023 16:09:45 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4CF5458068;
	Thu, 14 Dec 2023 16:09:45 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7297B58065;
	Thu, 14 Dec 2023 16:09:42 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.watson.ibm.com (unknown [9.31.99.90])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 14 Dec 2023 16:09:42 +0000 (GMT)
Message-ID: <579803fe4750b2ac1cbf31f4d38929c9ec901a41.camel@linux.ibm.com>
Subject: Re: [RFC][PATCH] overlayfs: Redirect xattr ops on security.evm to
 security.evm_overlayfs
From: Mimi Zohar <zohar@linux.ibm.com>
To: Amir Goldstein <amir73il@gmail.com>,
        Roberto Sassu
	 <roberto.sassu@huaweicloud.com>
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
Date: Thu, 14 Dec 2023 11:09:41 -0500
In-Reply-To: <CAOQ4uxhwHgj-bE7N5SNcRZfnVHn9yCdY_=LFuOxEBkVBbrZKiw@mail.gmail.com>
References: <20231208172308.2876481-1-roberto.sassu@huaweicloud.com>
	 <CAOQ4uxivpZ+u0A5kE962XST37-ey2Tv9EtddnZQhk3ohRkcQTw@mail.gmail.com>
	 <20231208-tauziehen-zerfetzt-026e7ee800a0@brauner>
	 <c95b24f27021052209ec6911d2b7e7b20e410f43.camel@huaweicloud.com>
	 <20231211-fortziehen-basen-b8c0639044b8@brauner>
	 <019f134a-6ab4-48ca-991c-5a5c94e042ea@huaweicloud.com>
	 <CAOQ4uxgpNt7qKEF_NEJPsKU7-XhM7N_3eP68FrOpMpcRcHt4rQ@mail.gmail.com>
	 <59bf3530-2a6e-4caa-ac42-4d0dab9a71d1@huaweicloud.com>
	 <a9297cc1bf23e34aba3c7597681e9e71a03b37f9.camel@linux.ibm.com>
	 <d6b43b5780770637a724d129c22d5212860f494a.camel@huaweicloud.com>
	 <CAOQ4uxhwHgj-bE7N5SNcRZfnVHn9yCdY_=LFuOxEBkVBbrZKiw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xcpWVQEhxlE-8galbqQJSAxdGFwLi2Nv
X-Proofpoint-ORIG-GUID: EUrIUsu8j469rbUs2Joh63Hlbwdqbz-X
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
 definitions=2023-12-14_11,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 spamscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312140114

On Thu, 2023-12-14 at 17:09 +0200, Amir Goldstein wrote:
> On Thu, Dec 14, 2023 at 3:43 PM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
> >
> > On Tue, 2023-12-12 at 10:27 -0500, Mimi Zohar wrote:
> > > On Tue, 2023-12-12 at 14:13 +0100, Roberto Sassu wrote:
> > > > On 12.12.23 11:44, Amir Goldstein wrote:
> > > > > On Tue, Dec 12, 2023 at 12:25 PM Roberto Sassu
> > > > > <roberto.sassu@huaweicloud.com> wrote:
> > > > > >
> > > > > > On 11.12.23 19:01, Christian Brauner wrote:
> > > > > > > > The second problem is that one security.evm is not enough. We need two,
> > > > > > > > to store the two different HMACs. And we need both at the same time,
> > > > > > > > since when overlayfs is mounted the lower/upper directories can be
> > > > > > > > still accessible.
> > > > > > >
> > > > > > > "Changes to the underlying filesystems while part of a mounted overlay
> > > > > > > filesystem are not allowed. If the underlying filesystem is changed, the
> > > > > > > behavior of the overlay is undefined, though it will not result in a
> > > > > > > crash or deadlock."
> > > > > > >
> > > > > > > https://docs.kernel.org/filesystems/overlayfs.html#changes-to-underlying-filesystems
> > > > > > >
> > > > > > > So I don't know why this would be a problem.
> > > > > >
> > > > > > + Eric Snowberg
> > > > > >
> > > > > > Ok, that would reduce the surface of attack. However, when looking at:
> > > > > >
> > > > > >        ovl: Always reevaluate the file signature for IMA
> > > > > >
> > > > > >        Commit db1d1e8b9867 ("IMA: use vfs_getattr_nosec to get the
> > > > > > i_version")
> > > > > >        partially closed an IMA integrity issue when directly modifying a file
> > > > > >        on the lower filesystem.  If the overlay file is first opened by a
> > > > > > user
> > > > > >        and later the lower backing file is modified by root, but the extended
> > > > > >        attribute is NOT updated, the signature validation succeeds with
> > > > > > the old
> > > > > >        original signature.
> > > > > >
> > > > > > Ok, so if the behavior of overlayfs is undefined if the lower backing
> > > > > > file is modified by root, do we need to reevaluate? Or instead would be
> > > > > > better to forbid the write from IMA (legitimate, I think, since the
> > > > > > behavior is documented)? I just saw that we have d_real_inode(), we can
> > > > > > use it to determine if the write should be denied.
> > > > > >
> > > > >
> > > > > There may be several possible legitimate actions in this case, but the
> > > > > overall concept IMO should be the same as I said about EVM -
> > > > > overlayfs does not need an IMA signature of its own, because it
> > > > > can use the IMA signature of the underlying file.
> > > > >
> > > > > Whether overlayfs reads a file from lower fs or upper fs, it does not
> > > > > matter, the only thing that matters is that the underlying file content
> > > > > is attested when needed.
> > > > >
> > > > > The only incident that requires special attention is copy-up.
> > > > > This is what the security hooks security_inode_copy_up() and
> > > > > security_inode_copy_up_xattr() are for.
> > > > >
> > > > > When a file starts in state "lower" and has security.ima,evm xattrs
> > > > > then before a user changes the file, it is copied up to upper fs
> > > > > and suppose that security.ima,evm xattrs are copied as is?
> > >
> > > For IMA copying up security.ima is fine.  Other than EVM portable
> > > signatures, security.evm contains filesystem specific metadata.
> > > Copying security.evm up only works if the metadata is the same on both
> > > filesystems.  Currently the i_generation and i_sb->s_uuid are
> > > different.
> > >
> > > > > When later the overlayfs file content is read from the upper copy
> > > > > the security.ima signature should be enough to attest that file content
> > > > > was not tampered with between going from "lower" to "upper".
> > > > >
> > > > > security.evm may need to be fixed on copy up, but that should be
> > > > > easy to do with the security_inode_copy_up_xattr() hook. No?
> > >
> > > Writing security.evm requires the existing security.evm to be valid.
> > > After each security xattr in the protected list is modified,
> > > security.evm HMAC needs to be updated.  Perhaps calculating and writing
> > > security.evm could be triggered by security_inode_copy_up_xattr().
> > > Just copying a non-portable EVM signature wouldn't work, or for that
> > > matter copying an EVM HMAC with different filesystem metadata.
> >
> > There is another problem, when delayed copy is used. The content comes
> > from one source, metadata from another.
> >
> > I initially created test-file-lower on the lower directory
> > (overlayfs/data), before mounting overlayfs. After mount on
> > overlayfs/mnt:
> >
> > # getfattr -m - -e hex -d overlayfs/mnt/test-file-lower
> > # file: overlayfs/mnt/test-file-lower
> > security.evm=0x02c86ec91a4c0cf024537fd24347b780b90973402e
> > security.ima=0x0404f2ca1bb6c7e907d06dafe4687e579fce76b37e4e93b7605022da52e6ccc26fd2
> > security.selinux=0x73797374656d5f753a6f626a6563745f723a756e6c6162656c65645f743a733000
> >
> > # chcon -t unconfined_t overlayfs/mnt/test-file-lower
> >
> > After this, IMA creates an empty file in the upper directory
> > (overlayfs/root/data), and writes security.ima at file close.
> > Unfortunately, this is what is presented from overlayfs, which is not
> > in sync with the content.
> >
> > # getfattr -m - -e hex -d overlayfs/mnt/test-file-lower
> > # file: overlayfs/mnt/test-file-lower
> > security.evm=0x021d71e7df78c36745e3b651ce29cb9f47dc301248
> > security.ima=0x04048855508aade16ec573d21e6a485dfd0a7624085c1a14b5ecdd6485de0c6839a4
> > security.selinux=0x73797374656d5f753a6f626a6563745f723a756e636f6e66696e65645f743a733000
> >
> > # sha256sum overlayfs/mnt/test-file-lower
> > f2ca1bb6c7e907d06dafe4687e579fce76b37e4e93b7605022da52e6ccc26fd2  overlayfs/mnt/test-file-lower
> >
> > # sha256sum overlayfs/root/data/test-file-lower
> > 8855508aade16ec573d21e6a485dfd0a7624085c1a14b5ecdd6485de0c6839a4  overlayfs/root/data/test-file-lower (upperdir)
> >
> > We would need to use the lower security.ima until the copy is made, but
> > at the same time we need to keep the upper valid (with all xattrs) so
> > that IMA can update the next time overlayfs requests that.
> >
> 
> Yap.
> 
> As Seth wrote, overlayfs is a combination of upper and lower.
> The information that IMA needs should be accessible from either lower
> or upper, but sometimes we will need to make the right choice.
> 
> The case of security.ima is similar to that of st_blocks -
> it is a data-related metadata, so it needs to be taken from the lowerdata inode
> (not even the lower inode). See example of getting STATX_BLOCKS
> in ovl_getattr().
> 
> I would accept a patch that special cases security.ima in ovl_xattr_get()
> and gets it from ovl_i_path_lowerdata(), which would need to be
> factored out of ovl_path_lowerdata().
> 
> I would also accept filtering out security.{ima,evm} from
> 
> But I would only accept it if I know that IMA is not trying to write the
> security.ima xattr when closing an overlayfs file, only when closing the
> real underlying upper file.

I don't see how that would be possible.  As far as I'm aware, the
correlation is between the overlay and the underlying lower/uppper
file, not the other way around.  How could a close on the underlying
file trigger IMA on an overlay file?

> 
> I would also expect IMA to filter out security.{ima,evm} xattrs in
> security_inode_copy_up_xattr() (i.e. return 1).
> and most importantly, a documentation of the model of IMA/EVM
> and overlayfs.

Ok.

Mimi


