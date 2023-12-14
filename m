Return-Path: <linux-fsdevel+bounces-6136-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE43B813ADB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 20:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52BF2B2101F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 19:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC65697AF;
	Thu, 14 Dec 2023 19:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DUCMYBMZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC006A022;
	Thu, 14 Dec 2023 19:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BEHl9MB002355;
	Thu, 14 Dec 2023 19:36:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=648FpWoGQTh0F4qS2G595ah/1s7QGvexGIs/fpCIhd0=;
 b=DUCMYBMZon4C6qX4YWkQ7nu2rxB0b4iTUuHyiEBSmAkKP44+sr0U+0Ma9BJeDZ7SWdNT
 htC1K40iquvmNmr1tcjrQRtqaA3cDmS7OrfeKWIwAdP9BdPZZDvv7NbYuovS3kdGKlBG
 xvs9u2yw+G0khTBtxpYDr9FVS/3cPZ0/tq+ykJDOcsqFEGKSuzj9AfEgm9ijSNDOapZv
 8OT0gEE+u6MQNtAbKHcUimfMJnrEXqyXBreIELiLugTtlnTN3L9lh4QSo+JniCw/2xT3
 bFjcLV5ET0dqVvUka2+HtlT2jYZbKDQ1NhiltKuXOrn8eXmHoQ+SIajCF84dALo3Bs9D YQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v06dmtw3s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Dec 2023 19:36:58 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BEJXCeB027654;
	Thu, 14 Dec 2023 19:36:58 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v06dmtw3d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Dec 2023 19:36:58 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BEIueoM013869;
	Thu, 14 Dec 2023 19:36:57 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uw592jhv7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Dec 2023 19:36:57 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BEJaudc57737562
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Dec 2023 19:36:56 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D8BC5805A;
	Thu, 14 Dec 2023 19:36:56 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5AC9058056;
	Thu, 14 Dec 2023 19:36:55 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.watson.ibm.com (unknown [9.31.99.90])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 14 Dec 2023 19:36:55 +0000 (GMT)
Message-ID: <a9e016feca137d05dc1f4ead72b24992ac2017be.camel@linux.ibm.com>
Subject: Re: [RFC][PATCH] overlayfs: Redirect xattr ops on security.evm to
 security.evm_overlayfs
From: Mimi Zohar <zohar@linux.ibm.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Christian Brauner
 <brauner@kernel.org>,
        Seth Forshee <sforshee@kernel.org>, miklos@szeredi.hu,
        linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, stefanb@linux.ibm.com, jlayton@kernel.org,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Eric Snowberg
 <eric.snowberg@oracle.com>
Date: Thu, 14 Dec 2023 14:36:54 -0500
In-Reply-To: <CAOQ4uxgra3KNthC_Od8r3fYDPO4AiVUF3u=aUfpUpQzOeeCFvg@mail.gmail.com>
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
	 <579803fe4750b2ac1cbf31f4d38929c9ec901a41.camel@linux.ibm.com>
	 <CAOQ4uxgra3KNthC_Od8r3fYDPO4AiVUF3u=aUfpUpQzOeeCFvg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ggj4mU_b608FLM25Ikwv48nU1lvWZpYX
X-Proofpoint-GUID: KABTHRkSl2zOTBNnk2Saec0xKkfCfZ8k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-14_13,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 mlxscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312140140

On Thu, 2023-12-14 at 20:06 +0200, Amir Goldstein wrote:
> > > > There is another problem, when delayed copy is used. The content comes
> > > > from one source, metadata from another.
> > > >
> > > > I initially created test-file-lower on the lower directory
> > > > (overlayfs/data), before mounting overlayfs. After mount on
> > > > overlayfs/mnt:
> > > >
> > > > # getfattr -m - -e hex -d overlayfs/mnt/test-file-lower
> > > > # file: overlayfs/mnt/test-file-lower
> > > > security.evm=0x02c86ec91a4c0cf024537fd24347b780b90973402e
> > > > security.ima=0x0404f2ca1bb6c7e907d06dafe4687e579fce76b37e4e93b7605022da52e6ccc26fd2
> > > > security.selinux=0x73797374656d5f753a6f626a6563745f723a756e6c6162656c65645f743a733000
> > > >
> > > > # chcon -t unconfined_t overlayfs/mnt/test-file-lower
> > > >
> > > > After this, IMA creates an empty file in the upper directory
> > > > (overlayfs/root/data), and writes security.ima at file close.
> > > > Unfortunately, this is what is presented from overlayfs, which is not
> > > > in sync with the content.
> > > >
> > > > # getfattr -m - -e hex -d overlayfs/mnt/test-file-lower
> > > > # file: overlayfs/mnt/test-file-lower
> > > > security.evm=0x021d71e7df78c36745e3b651ce29cb9f47dc301248
> > > > security.ima=0x04048855508aade16ec573d21e6a485dfd0a7624085c1a14b5ecdd6485de0c6839a4
> > > > security.selinux=0x73797374656d5f753a6f626a6563745f723a756e636f6e66696e65645f743a733000
> > > >
> > > > # sha256sum overlayfs/mnt/test-file-lower
> > > > f2ca1bb6c7e907d06dafe4687e579fce76b37e4e93b7605022da52e6ccc26fd2  overlayfs/mnt/test-file-lower
> > > >
> > > > # sha256sum overlayfs/root/data/test-file-lower
> > > > 8855508aade16ec573d21e6a485dfd0a7624085c1a14b5ecdd6485de0c6839a4  overlayfs/root/data/test-file-lower (upperdir)
> > > >
> > > > We would need to use the lower security.ima until the copy is made, but
> > > > at the same time we need to keep the upper valid (with all xattrs) so
> > > > that IMA can update the next time overlayfs requests that.
> > > >
> > >
> > > Yap.
> > >
> > > As Seth wrote, overlayfs is a combination of upper and lower.
> > > The information that IMA needs should be accessible from either lower
> > > or upper, but sometimes we will need to make the right choice.
> > >
> > > The case of security.ima is similar to that of st_blocks -
> > > it is a data-related metadata, so it needs to be taken from the lowerdata inode
> > > (not even the lower inode). See example of getting STATX_BLOCKS
> > > in ovl_getattr().
> > >
> > > I would accept a patch that special cases security.ima in ovl_xattr_get()
> > > and gets it from ovl_i_path_lowerdata(), which would need to be
> > > factored out of ovl_path_lowerdata().
> > >
> > > I would also accept filtering out security.{ima,evm} from
> > >
> > > But I would only accept it if I know that IMA is not trying to write the
> > > security.ima xattr when closing an overlayfs file, only when closing the
> > > real underlying upper file.
> >
> > I don't see how that would be possible.  As far as I'm aware, the
> > correlation is between the overlay and the underlying lower/uppper
> > file, not the other way around.  How could a close on the underlying
> > file trigger IMA on an overlay file?
> >
> 
> Well, you are right. it cannot.
> 
> What I meant is that close of overlayfs file should NOT open and read
> the overlayfs file and recalculate security.ima to store in overlayfs inode
> because close of overlayfs file will follow a close of the upper file that
> should recalculate and store security.ima in the upper inode.
> 
> It is possible that a close of an overlayfs file will update the security
> state of the overlayfs inode by copying the security state from the
> upper inode.

Thank you for the explanation.

Basically IMA should differentiate between file close on the underlying
upper/lower file and the overlay file.  Since IMA doesn't define
inode_copy_up_xattr, security.ima will be copied up.  Re-calculating
security.ima on the overlay is unnecessary.

> But then again, I could be misunderstanding the IMA workflows
> and it could be more complicated than I try to present it.
> This is the reason that I requested the documentation of how
> IMA+overlayfs is *expected* to work.

Ok

Mimi


