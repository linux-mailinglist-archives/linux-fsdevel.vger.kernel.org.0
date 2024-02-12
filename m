Return-Path: <linux-fsdevel+bounces-11104-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8F38511A1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 11:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FD291C23CFB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 10:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C721839AF1;
	Mon, 12 Feb 2024 10:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Xu1kwmSu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCB320B2E;
	Mon, 12 Feb 2024 10:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707735321; cv=none; b=lRNnfrptcVE59N6mBuzm/Wcqc97VjM/RXD+I6R886kT1Pf2lZ1c8HMLRkPuDsX/0UT5FUNRiU83fXf4I5y4+fU1cBblZWI6woiVkbMIqwVo6cQkk/5XcefFSw3RIp0DkQ+UTx22DzH22YwMIENjpdkgbwpPhTWAbbt30b+LNfS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707735321; c=relaxed/simple;
	bh=EawNjPbCYcS/tAMoeRo1vOT1H5rphtp7aMvvQEXuLbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MHcp+pnAKTudsme8M9HHXbqYC8ji/akbquOHpjYIeFgKmxhDJOaDAGPPYK3VN6/Kll2Jjotn8P+9px0SLKr68TxVg6OdwMAXuo08W4k3CpyJILOPZgc2LLFcSNkgS9d0spPlEPEChsn+EVetqy6plq56E0WbPQqTd6vqFGcncio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Xu1kwmSu; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41CAgHcb004087;
	Mon, 12 Feb 2024 10:54:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=zoVRmRi8SldJa0D8D0wv+7S4X/v7cfA5ay35VLyY9l4=;
 b=Xu1kwmSu6Aorj1i1sDCBWstHrix6T+AEiVK037yo4yRHX0CITslpJXem8tD1ezVBm4L3
 HnQUueSsPp9naidq8IUXdLJYQooagAzKEUZT7XH0hlUI0mieGpEJPVdVb4s9xF9BcbCu
 ExrxuxvKvNAOPivEVVoKJ9afYDqymfFjwD/K9RwjX6vOSv4Vxx4ZfE9d1hYmTUmzaULm
 UlLF6lbcybPIlA1MycZ79RrgEcw9wO71m9Gd/mnikW/DyWzRmiFc0HYleSSZZO65E9ok
 JZlfW81n1F0GCw1i9ebyfqhanHJeSo0msDhqOSKnjJthsxbmD38DYVqWL85Ge23A7ODR Pw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w7htf8fnd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 10:54:57 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41CAgxmI006433;
	Mon, 12 Feb 2024 10:54:57 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w7htf8fmu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 10:54:57 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41C8j2ov009728;
	Mon, 12 Feb 2024 10:54:55 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w6p62fk2b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 10:54:55 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41CAsom918023054
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Feb 2024 10:54:52 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 16E7F20043;
	Mon, 12 Feb 2024 10:54:50 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C12292004B;
	Mon, 12 Feb 2024 10:54:45 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.187])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Feb 2024 10:54:45 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: john.g.garry@oracle.com
Cc: axboe@kernel.dk, brauner@kernel.org, bvanassche@acm.org,
        dchinner@redhat.com, djwong@kernel.org, hch@lst.de, jack@suse.cz,
        jbongio@google.com, jejb@linux.ibm.com, kbusch@kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
        martin.petersen@oracle.com, ming.lei@redhat.com, ojaswin@linux.ibm.com,
        sagi@grimberg.me, tytso@mit.edu, viro@zeniv.linux.org.uk
Subject: Re:[PATCH v3 09/15] block: Add checks to merging of atomic writes
Date: Mon, 12 Feb 2024 16:24:44 +0530
Message-ID: <20240212105444.43262-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124113841.31824-10-john.g.garry@oracle.com>
References: <20240124113841.31824-10-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: l6UR2kJ2av9VC-Gz59rrtIFBEPbdj0UY
X-Proofpoint-ORIG-GUID: Q0gM8ieRkli4blZ8gcHTGllf5lrbi8pv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_07,2024-02-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 mlxscore=0 mlxlogscore=999 impostorscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402120082

>+static bool rq_straddles_atomic_write_boundary(struct request *rq,=0D
>+					unsigned int front,=0D
>+					unsigned int back)=0D
>+{=0D
>+	unsigned int boundary =3D queue_atomic_write_boundary_bytes(rq->q);=0D
>+	unsigned int mask, imask;=0D
>+	loff_t start, end;=0D
>+=0D
>+	if (!boundary)=0D
>+		return false;=0D
>+=0D
>+	start =3D rq->__sector << SECTOR_SHIFT;=0D
>+	end =3D start + rq->__data_len;=0D
>+=0D
>+	start -=3D front;=0D
>+	end +=3D back;=0D
>+=0D
>+	/* We're longer than the boundary, so must be crossing it */=0D
>+	if (end - start > boundary)=0D
>+		return true;=0D
>+=0D
>+	mask =3D boundary - 1;=0D
>+=0D
>+	/* start/end are boundary-aligned, so cannot be crossing */=0D
>+	if (!(start & mask) || !(end & mask))=0D
>+		return false;=0D
>+=0D
>+	imask =3D ~mask;=0D
>+=0D
>+	/* Top bits are different, so crossed a boundary */=0D
>+	if ((start & imask) !=3D (end & imask))=0D
>+		return true;=0D
>+=0D
>+	return false;=0D
>+}=0D
>+=0D
=0D
Shall we ensure here that we don't cross max limit of atomic write supporte=
d by =0D
device? It seems that if the boundary size is not advertized by the device =
=0D
(in fact, I have one NVMe drive which has boundary size zero i.e. nabo/nabs=
pf/=0D
nawupf are all zero but awupf is non-zero) then we (unconditionally) allow =
=0D
merging. However it may be possible that post merging the total size of the=
 =0D
request may exceed the atomic-write-unit-max-size supported by the device a=
nd =0D
if that happens then most probably we would be able to catch it very late i=
n =0D
the driver code (if the device is NVMe). =0D
=0D
So is it a good idea to validate here whether we could potentially exceed =
=0D
the atomic-write-max-unit-size supported by device before we allow merging?=
 =0D
In case we exceed the atomic-write-max-unit-size post merge then don't allo=
w=0D
merging?=0D
 =0D
Thanks,=0D
--Nilay=0D
=0D

