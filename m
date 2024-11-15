Return-Path: <linux-fsdevel+bounces-34926-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E23419CEEEE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 16:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CF9F1F26A48
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 15:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42C21D47C8;
	Fri, 15 Nov 2024 15:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="M1M/cFA7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8031D460E;
	Fri, 15 Nov 2024 15:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731684137; cv=none; b=pbaqAjSjqSfRg0PTwQEHo0fHYKALs3f4soeSP4kEMLaCOnRzTftcR+F5k5Xodn1QlTK8vC/yfgsoYpy5CQbaCxeeqBOiKjEqjn99TjiJEMwafd++mEjeH1BPx3zmfzTvLhU+Aa2u6xOe+j+vigTrDIq4fMIGetAAPdXkbBIoWFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731684137; c=relaxed/simple;
	bh=hsxQVSYBjthGVSOK7NyoEeMCrOJxe28981prnKvfeTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lxecaPeIS9uDwLGIPn/q6c5nxT85q3LNaVzQM7zPdMH1WzSdO244Uk8uKR7seX1H3gLnL6wZBvy5WlE213CumLksxTELb5QyLy7NktibmOQKN/YRnwu/KOwYBWjINROk7EnJmAwmpXTg0cpeUnLUreRtdSU5+b3ajkqZk2FxvOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=M1M/cFA7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFAYlo2004138;
	Fri, 15 Nov 2024 15:22:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=SW/XRQkAzjFGSj3ouQZLIw7IH0ArI5
	IWd+lFiJd5eF8=; b=M1M/cFA7zG5Fn81q+yO9tcxqAr8ncetMOu1LmxhAT4ViD7
	uq6DgTfiHbvplajEXvvTnb+6PwMZu2hLh9yCsEPuwd4m/Pn4B93XkjVah0Dm46ze
	8OnrXT/SDzFiwua88gobFp9Hb8elZO7RWk9SwaJFWPB14+eBMdO6+wHLBF8l9b+q
	OqrLoVIZLlrTaBmXiTm14N9TCHjdcpei8dyCxkA8C4LDrGU9V2ftXbRx58/rlT+w
	q0+B/q42Vu4GGH4Du7YBo5kBgDGSghjOaWHqBsgoWvfAxPwRGpyYj3NymFWEkMjC
	P/xtz1qSXq0Xz/D62V74MCIS3EvCwfol57JXpZKA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42wuy1kujk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 15:22:08 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4AFFFJFs000713;
	Fri, 15 Nov 2024 15:22:07 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42wuy1kujg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 15:22:07 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFDu6ZH029753;
	Fri, 15 Nov 2024 15:22:06 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42tkjmtxwh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 15:22:06 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AFFM4L459965698
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 15:22:04 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8BE3320049;
	Fri, 15 Nov 2024 15:22:04 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 34DF020040;
	Fri, 15 Nov 2024 15:22:03 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.124.219.93])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 15 Nov 2024 15:22:03 +0000 (GMT)
Date: Fri, 15 Nov 2024 20:51:57 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Christian Brauner <brauner@kernel.org>,
        Linux Filesystem Development List <linux-fsdevel@vger.kernel.org>,
        fstests@vger.kernel.org, stable@vger.kernel.org,
        Leah Rumancik <leah.rumancik@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: generic/645 failing on ext4, xfs (probably others) on all LTS
 kernels
Message-ID: <ZzdnFeR/dE/w5wan@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20241110180533.GA200429@mit.edu>
 <20241111-tragik-busfahren-483825df1c00@brauner>
 <20241115133407.GB582565@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115133407.GB582565@mit.edu>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XuZh_QlhMl6wZdrF1se3BiPXIgh52ooP
X-Proofpoint-GUID: KHdTY0Xs6-PZkxXd4UrC5171n2pm4zfy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 mlxscore=0 impostorscore=0
 clxscore=1011 adultscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411150128

On Fri, Nov 15, 2024 at 08:34:07AM -0500, Theodore Ts'o wrote:
> On Mon, Nov 11, 2024 at 09:52:07AM +0100, Christian Brauner wrote:
> 
> > behavior would be well-specified so the patch changed that quite some
> > time ago.
> > 
> > Backporting this to older LTS kernels isn't difficult. We just need
> > custom patches for the LTS kernels but they should all be very simple.
> > 
> > Alternatively, you can just ignore the test on older kernels.
> 
> Well, what the custom patch to look like wasn't obvious to me, but
> that's because I'm not sufficiently familiar with the id mapping code.
> 
> So I'll just ignore the test on older kernels.  If someone wants to
> create the custom patch, I'll revert the versioned exclude for
> {kvm,gce}-xfsteests.
> 
> Thanks,
> 
> 						- Ted
> 

Hi,

We did notice this as well during our internal testing. I'm unfamiliar
with the code but after spending some time I came up with the
following patch that did fix it for us (it's a rough patch, might not
apply cleanly to any stable kernel). Again, I'm not 100% sure if this is
the right place to patch it but if it looks good to peopel more familiar with
the area then I can try to send the backports to the stable.

---
 fs/namespace.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/namespace.c b/fs/namespace.c
index 7906c5327f4f..368a60e48861 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3995,6 +3995,12 @@ static int can_idmap_mount(const struct mount_kattr *kattr, struct mount *mnt)
 	if (!kattr->mnt_idmap)
 		return 0;
 
+	/* Don't allow idmaps with no mapping defined */
+	if (kattr->mnt_userns->uid_map.nr_extents == 0 ||
+	    kattr->mnt_userns->gid_map.nr_extents == 0)
+		return -EINVAL;
+
+
 	/*
 	 * Creating an idmapped mount with the filesystem wide idmapping
 	 * doesn't make sense so block that. We don't allow mushy semantics.
-- 
2.43.0

Regards,
ojaswin

