Return-Path: <linux-fsdevel+bounces-5811-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B52D9810A8C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 07:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6F131C209DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 06:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5648611727;
	Wed, 13 Dec 2023 06:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="r64kdaJG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200C4AD;
	Tue, 12 Dec 2023 22:42:43 -0800 (PST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BD6RlAF022278;
	Wed, 13 Dec 2023 06:42:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=9GUj/Aho7/1TYDtk21H9qY+L2WM+l5YYCwXwZpStc8c=;
 b=r64kdaJG4nS+IPu+vyvPL88pPYTf4wOVarKYxhyEHuln+0bowUEpweWYEXFboKURLtQz
 zX+0XArNnkgTBQxDDil62guVrYrBBdwSz10iwj92JURSxYJ6w8q2SzlUw/vsjAPVtApf
 JrUt3ew+oX4Xck51K1DeX49Q3MS2s995pz2zoNYFX0HCshblY/6R68LoHVL5g0fDwP0y
 ClDkBpaudbhpaTySXhlMfgKukYdXIlvqSaldP8sK09kIgwfqhPLtguqj+opkJa9DlaIQ
 XSC5NxLrdDcV1R3aYZfJWs+Nh590BsYs0LqNBJST/XTbP1JpGL93H54JNSpqRv4EOp7a ig== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uy7c58c9s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Dec 2023 06:42:25 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BD6T0Me025162;
	Wed, 13 Dec 2023 06:42:24 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uy7c58c9b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Dec 2023 06:42:24 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BD5Q3YA013864;
	Wed, 13 Dec 2023 06:42:23 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uw5926bu9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Dec 2023 06:42:23 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BD6gLEi43188908
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Dec 2023 06:42:22 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E13E120040;
	Wed, 13 Dec 2023 06:42:21 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 42A8420043;
	Wed, 13 Dec 2023 06:42:19 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.51.82])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 13 Dec 2023 06:42:19 +0000 (GMT)
Date: Wed, 13 Dec 2023 12:12:15 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: John Garry <john.g.garry@oracle.com>
Cc: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        dchinner@redhat.com
Subject: Re: [RFC 0/7] ext4: Allocator changes for atomic write support with
 DIO
Message-ID: <ZXlSR8CTXjkeKxwk@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <cover.1701339358.git.ojaswin@linux.ibm.com>
 <8c06c139-f994-442b-925e-e177ef2c5adb@oracle.com>
 <ZW3WZ6prrdsPc55Z@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <de90e79b-83f2-428f-bac6-0754708aa4a8@oracle.com>
 <ZXbqVs0TdoDcJ352@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXbqVs0TdoDcJ352@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vAkBMKIFJ8wO00RLRC6t6Gf6QM4RHrja
X-Proofpoint-GUID: Zf8h5KpoaOoIeOwSSmnViO2i-V5AgsRi
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-12_14,2023-12-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxscore=0 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 mlxlogscore=965 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312130047

On Mon, Dec 11, 2023 at 04:24:14PM +0530, Ojaswin Mujoo wrote:
> > > > looks ok so far, then write 4KB at offset 0:
> > > > 
> > > > # /test-pwritev2 -a -d -p 0 -l 4096  /root/mnt/file
> > > > file=/root/mnt/file write_size=4096 offset=0 o_flags=0x4002 wr_flags=0x24
> > 
> > ...
> > 
> > > > Please note that I tested on my own dev branch, which contains changes over
> > > > [1], but I expect it would not make a difference for this test.
> > > Hmm this should not ideally happen, can you please share your test
> > > script with me if possible?
> > 
> > It's doing nothing special, just RWF_ATOMIC flag is set for DIO write:
> > 
> > https://github.com/johnpgarry/linux/blob/236870d48ecb19c1cf89dc439e188182a0524cd4/samples/vfs/test-pwritev2.c
> 
> Thanks for the script, will try to replicate this today and get back to
> you.
> 

Hi John,

So I don't seem to be able to hit the warn on:

$ touch mnt/testfile
$ ./test-pwritev2 -a -d -p 0 -l 4096 mnt/testfile

	file=mnt/testfile write_size=4096 offset=0 o_flags=0x4002 wr_flags=0x24
	main wrote 4096 bytes at offset 0

$ filefrag -v mnt/testfile

	Filesystem type is: ef53
	File size of testfile is 4096 (1 block of 4096 bytes)
	ext:     logical_offset:        physical_offset: length:   expected: flags:
		0:        0..       0:      32900..     32900:      1: last,eof

$ ./test-pwritev2 -a -d -p 8192 -l 8192 mnt/testfile

	file=mnt/testfile write_size=8192 offset=8192 o_flags=0x4002 wr_flags=0x24
	main wrote 8192 bytes at offset 8192

$ filefrag -v mnt/testfile

	Filesystem type is: ef53
	File size of mnt/testfile is 16384 (4 blocks of 4096 bytes)
	 ext:     logical_offset:        physical_offset: length:   expected: flags:
		0:        0..       0:      32900..     32900:      1:
		1:        2..       3:      33288..     33289:      2: 32902: last,eof
	mnt/testfile: 2 extents found

Not sure why you are hitting the WARN_ON. The tree I used is:

Latest ted/dev + your atomic patchset v1 + this patchset

Regards,
ojaswin

