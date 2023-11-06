Return-Path: <linux-fsdevel+bounces-2114-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35EAD7E29FA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 17:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7311BB20D8B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 16:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C607628E3C;
	Mon,  6 Nov 2023 16:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LJ7uhMlw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6193E249E6;
	Mon,  6 Nov 2023 16:37:45 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7989410DB;
	Mon,  6 Nov 2023 08:37:43 -0800 (PST)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A6GFm5r005417;
	Mon, 6 Nov 2023 16:37:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=H4NlHBTKBFQ1Gv20U3eQViy1SptM4Vrxu8DsL5fD13g=;
 b=LJ7uhMlwHTttnv7iOcSjHi06tOwVtRRSYA2rJCaTR4FRgvSh5D6pjomBLJNhyCoDYTKt
 ulLR0kclaVfHXjTn//iToLqFw4pOmLh2xjndZWQmx5HevVwwzo0f9qd0iNePls37dx3S
 PydiEa/DBcIn7qKhviB0mtO2hGpUwc2CBRRVeZz+BpjvDQw3a8OvGBjFrfZ5/OGd+cAr
 66Av8kZGySY4EDJi7QIIbxTmXDULdHGxowNkIudg//1j98fR2IWRYS0Xqi0VoRRS/S4t
 mWywwWvpOujIf0oyFgnaa8XXQXAYMMVlQDo+LdrD/l4QaKIsPN/BrWmO8kcK0BTxuBEp UQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u73gn0mny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Nov 2023 16:37:09 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A6GSBsr021544;
	Mon, 6 Nov 2023 16:37:09 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u73gn0mn5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Nov 2023 16:37:09 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3A6FcRGd016939;
	Mon, 6 Nov 2023 16:37:07 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u6301j2r0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Nov 2023 16:37:07 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3A6Gb7ej43974954
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Nov 2023 16:37:07 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 079FF58052;
	Mon,  6 Nov 2023 16:37:06 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 95B2658045;
	Mon,  6 Nov 2023 16:37:04 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.58.168])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Nov 2023 16:37:04 +0000 (GMT)
Message-ID: <705011c8c952cfe97093844ab78b8ed4476db579.camel@linux.ibm.com>
Subject: Re: [PATCH v4 00/23] security: Move IMA and EVM to the LSM
 infrastructure
From: Mimi Zohar <zohar@linux.ibm.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, viro@zeniv.linux.org.uk,
        brauner@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org,
        neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        dmitry.kasatkin@gmail.com, dhowells@redhat.com, jarkko@kernel.org,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com, mic@digikod.net
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
Date: Mon, 06 Nov 2023 11:37:03 -0500
In-Reply-To: <20231027083558.484911-1-roberto.sassu@huaweicloud.com>
References: <20231027083558.484911-1-roberto.sassu@huaweicloud.com>
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
X-Proofpoint-ORIG-GUID: XZO7wLDJQ-btd4kEJTWKEqAiNlg5rWPx
X-Proofpoint-GUID: 9pc1zSUp6gPx3E58KO4rVPeBfcFnDP-0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_12,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 impostorscore=0 spamscore=0 mlxscore=0 bulkscore=0
 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311060134

On Fri, 2023-10-27 at 10:35 +0200, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> IMA and EVM are not effectively LSMs, especially due to the fact that in
> the past they could not provide a security blob while there is another LSM
> active.
> 
> That changed in the recent years, the LSM stacking feature now makes it
> possible to stack together multiple LSMs, and allows them to provide a
> security blob for most kernel objects. While the LSM stacking feature has
> some limitations being worked out, it is already suitable to make IMA and
> EVM as LSMs.
> 
> In short, while this patch set is big, it does not make any functional
> change to IMA and EVM. IMA and EVM functions are called by the LSM
> infrastructure in the same places as before (except ima_post_path_mknod()),
> rather being hardcoded calls, and the inode metadata pointer is directly
> stored in the inode security blob rather than in a separate rbtree.
> 
> To avoid functional changes, it was necessary to keep the 'integrity' LSM
> in addition to the newly introduced 'ima' and 'evm' LSMs, despite there is
> no LSM ID assigned to it. There are two reasons: first, IMA and EVM still
> share the same inode metadata, and thus cannot directly reserve space in
> the security blob for it; second, someone needs to initialize 'ima' and
> 'evm' exactly in this order, as the LSM infrastructure cannot guarantee
> that.
> 
> The patch set is organized as follows.
> 
> Patches 1-9 make IMA and EVM functions suitable to be registered to the LSM
> infrastructure, by aligning function parameters.
> 
> Patches 10-18 add new LSM hooks in the same places where IMA and EVM
> functions are called, if there is no LSM hook already.
> 
> Patches 19-22 do the bulk of the work, introduce the new LSMs 'ima' and
> 'evm', and move hardcoded calls to IMA, EVM and integrity functions to
> those LSMs. In addition, they reserve one slot for the 'evm' LSM to supply
> an xattr with the inode_init_security hook.
> 
> Finally, patch 23 removes the rbtree used to bind integrity metadata to the
> inodes, and instead reserves a space in the inode security blob to store
> the pointer to that metadata. This also brings performance improvements due
> to retrieving metadata in constant time, as opposed to logarithmic.
> 
> The patch set applies on top of lsm/next-queue, commit 0310640b00d2 ("lsm:
> don't yet account for IMA in LSM_CONFIG_COUNT calculation"), plus commits
> in linux-integrity/next-integrity-testing up to bc4532e9cd3b ("ima: detect
> changes to the backing overlay file").

Thanks, Roberto!  The patch set looks really good.  I just sent a few
very minor comments.

Mimi


