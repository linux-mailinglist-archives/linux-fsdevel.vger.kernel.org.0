Return-Path: <linux-fsdevel+bounces-40538-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE60FA24AD7
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Feb 2025 17:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07BEC7A2D46
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Feb 2025 16:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63BA1C5F3B;
	Sat,  1 Feb 2025 16:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nszgTuo/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6C9208A9;
	Sat,  1 Feb 2025 16:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738428840; cv=none; b=MhSDETU2kE/AjQ4XbZ4pwPOWVTCOeQUa5hCaVZWPSC0nhdCskVc/BIVJ1PsGuldueu4Ib8Ku0bMpDAzzG7dZTw+X5ecUip0ThhYa7EpfvcGrGfJCxm/107wGGQLHnisxfd0pkVN75iVnh8IHQs20DrmM25uIbYiJCbigFQcSpug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738428840; c=relaxed/simple;
	bh=EpQjIwpiqwLbhZDDirRysP8q/HUWGCIYpEHuKsU2DTg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=E5RJMTwUAO7DXr7PBryUxYtjEwvV8NYc/Xns2O0Y+dSRU6aqRJCYYSE8Y3tVnDlMAEbKEA4pXp49KJ2P8ZdO3J0A22cU1D+u0fOOo8mNilQcFDQslvLmE5md+Kns91NNnCC9+zOS9oM6BnQjFCIsyysoUptQD3W9NqCMS4lVKj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nszgTuo/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 511DS93K010152;
	Sat, 1 Feb 2025 16:53:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	pp1; bh=dNGVTebc8on0ImUIEjF3PdUCyfFNtktTD0RQty9whBI=; b=nszgTuo/
	cFjttmP6xB+b6eO1skhflXOG4NCzT3c81T5zXvxZOPqMqY/kvQclxVhT0n5SWtvx
	J+H5fWB8vxAofO6+t2nVMfZyXNM8gm6C8uKKVP6uMhkMpgMsOx2110ShE5QzQQub
	Pc9cciK+xMjIO4M+0LL4LjZU5SNLkXx1uQjj5GuMtMJzzZwMjS0Bt0tGT4trHjdo
	6XinAQ52qkh/bZ7TX0hjYHb4KEt7bkA1S/41PSb/1Kt8x7AqL7rpl3TQIhu7mfDV
	+tph3uqhd9baGQW8dkZyBH41iwpgxbp60cmZ8m8ZI2xT+JhIl0tXeABz/AHJzKdx
	MCNv59/iozaL0w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44hd8k1hyu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 01 Feb 2025 16:53:40 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 511GreP6026762;
	Sat, 1 Feb 2025 16:53:40 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44hd8k1hys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 01 Feb 2025 16:53:39 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 511FwGaW008671;
	Sat, 1 Feb 2025 16:53:38 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44hdawswh7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 01 Feb 2025 16:53:38 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 511Gra7C37749188
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 1 Feb 2025 16:53:36 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8764F2006A;
	Sat,  1 Feb 2025 16:53:36 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B750120067;
	Sat,  1 Feb 2025 16:53:33 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.17.225])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sat,  1 Feb 2025 16:53:33 +0000 (GMT)
Date: Sat, 1 Feb 2025 22:23:29 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: lsf-pc@lists.linux-foundation.org
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        djwong@kernel.org, dchinner@redhat.com, ritesh.list@gmail.com,
        jack@suse.cz, tytso@mit.edu, linux-ext4@vger.kernel.org,
        nirjhar.roy.lists@gmail.com, zlang@kernel.org
Subject: [LSF/MM/BPF TOPIC] xfstests: Centralizing filesystem configs and
 device configs
Message-ID: <Z55RXUKB5O5l8QjM@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gtMQaCfMySc79GNShiqDKBnCXXY9E1Q8
X-Proofpoint-GUID: fk5DmC9NxPP_CQ7sH2pdR8zYwdtJXnCK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-01_07,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 mlxscore=0 clxscore=1015
 malwarescore=0 priorityscore=1501 bulkscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502010143

Greetings,

This proposal is on behalf of Me, Nirjhar and Ritesh. We would like to submit
a proposal on centralizing filesystem and device configurations within xfstests
and maybe a further discussion on some of the open ideas listed by Ted here [3].
More details are mentioned below.

** Background ** 
There was a discussion last year at LSFMM [1] about creating a central fs-config
store, that can then be used by anyone for testing different FS
features/configurations. This can also bring an awareness among other developers
and testers on what is being actively maintained by FS maintainers. We recently
posted an RFC [2] for centralizing filesystem configuration which is under
review. The next step we are considering is to centralize device configurations
within xfstests itself. In line with this, Ted also suggested a similar idea (in
point A) [3], where he proposed specifying the device size for the TEST and
SCRATCH devices to reduce costs (especially when using cloud infrastructure) and
improve the overall runtime of xfstests.

Recently Dave introduced a feature [4] to run the xfs and generic tests in
parallel. This patch creates the TEST and SCRATCH devices at runtime without
requiring them to be specified in any config file. However, at this stage, the
automatic device initialization appears to be somewhat limited. We believe that
centralizing device configuration could help enhance this functionality as well.

** Proposal ** 
We would like to propose a discussion at LSFMM on two key features: central
fsconfig and central device-config within xfstests. We can explore how the
fsconfig feature can be utilized, and by then, we aim to have a PoC for central
device-config feature, which we think can also be discussed in more detail. At
this point, we are hoping to get a PoC working with loop devices by default. It
will be good to hear from other developers, maintainers, and testers about their
thoughts and suggestions on these two features.

Additionally, we would like to thank Ted for listing several features he uses in
his custom kvm-xfstests and gce-xfstests [3]. If there is an interest in further
reducing the burden of maintaining custom test scripts and wrappers around
xfstests, we can also discuss essential features that could be integrated
directly into xfstests, whether from Ted's list or suggestions from others.

Thoughts and suggestions are welcome.

** References **
[1] https://lore.kernel.org/all/87h6h4sopf.fsf@doe.com/
[2] https://lore.kernel.org/all/9a6764237b900f40e563d8dee2853f1430245b74.1736496620.git.nirjhar.roy.lists@gmail.com/
[3] https://lore.kernel.org/all/20250110163859.GB1514771@mit.edu/
[4] https://lore.kernel.org/all/20241127045403.3665299-1-david@fromorbit.com/

