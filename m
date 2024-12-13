Return-Path: <linux-fsdevel+bounces-37353-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB519F150E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 19:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8361284523
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 18:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFAB21E8855;
	Fri, 13 Dec 2024 18:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="H4kwTkYS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34321E47C6;
	Fri, 13 Dec 2024 18:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734115077; cv=none; b=nRJS0pTVk5FysgcMBKC/AeUJ26Qvlvzpq+fdQWQS2AmHI5OHT5i799KyGJlOgUdym52ZbUOHc+fybfTum470mtkHHasB1C8e4b/sMfak20P2cW7htzP/HPg4pkJojRRRcggg2ZOnXAv6289raWqMvGiFmKSu1wULiL7RSYkxyi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734115077; c=relaxed/simple;
	bh=GHTiDWQ8l4MxxvcvQ5JO/nbQiqmxWMhbioeYCSiAbSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jMKeHGggz2wcyZo0qRRYhHn/araC7RtXgkwv7tbqVy2EM4p6xEmA19aCKUVLb2plJuGXC0wUslrIY47yGgB2VHBqGTUtgIDO4qXOdn9f/4PzF56D3YMYvAKotXvjMEUwa/2lQIVN2wjD22IngQ/r8naXuysuaOTk0r7OIpkZ/yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=H4kwTkYS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDGfGof026690;
	Fri, 13 Dec 2024 18:37:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=9Z0MgH4z+vMSBlxd6M2ZdPOrf2+eCd
	04Vtl+EOjzvsc=; b=H4kwTkYSJlkCTB2dR6fEOUeOVL9LGA9Lu7WoOhacnKNjzk
	UhRObfEA/l2hhJmH0WERi0nPFCA3MFS6c47KqCvmmmdDdG3xjBPUivTl/EYry6Lk
	PvmyD/eOChmtHevsVeZfmM1SgHlbyoyJo1z/Q0oYVBj+8A2cmVB8ZTwsJLSDRglH
	Dda4UpHZFvoPOZbQAEhreUe4LESIwR8vqxZ82uGiFgBmhpKEgYxykT/+ZapaItpa
	FDDOnUTfg7GzV/2e5dj+Zq2RYhcJ3LAsLcXI5Ps1db5AybBN0o4F5XQdfFxMWNMw
	gcSA2OfJZ9pMPMvWwG+eAKuMBmhJPsn5t4PGvYPg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43g9yhmsv1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 18:37:42 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BDIbfV7021297;
	Fri, 13 Dec 2024 18:37:41 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43g9yhmsuv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 18:37:41 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDHOBkr018605;
	Fri, 13 Dec 2024 18:37:40 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43d26ky4qc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 18:37:40 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BDIbc1b64160092
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 18:37:38 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 158EA20040;
	Fri, 13 Dec 2024 18:37:38 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 630F62004B;
	Fri, 13 Dec 2024 18:37:36 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.39.19.196])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 13 Dec 2024 18:37:36 +0000 (GMT)
Date: Sat, 14 Dec 2024 00:07:34 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrey Albershteyn <aalbersh@kernel.org>,
        John Garry <john.g.garry@oracle.com>
Subject: Re: [RFC 1/3] include/linux.h: Factor out generic
 platform_test_fs_fd() helper
Message-ID: <Z1x+7gtJkfl8Q+pT@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <cover.1733902742.git.ojaswin@linux.ibm.com>
 <5996d6854a16852daca5977063af6f2af2f0f4ca.1733902742.git.ojaswin@linux.ibm.com>
 <20241211180902.GA6678@frogsfrogsfrogs>
 <Z1vMrUqBWcarQ6_s@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1vMrUqBWcarQ6_s@infradead.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: oayEPtbgvi9cwSkrCfMqqmwC7WKDdmkg
X-Proofpoint-ORIG-GUID: nted5Q_0tVeyOS31R5PW7AYjWIbCBc0I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 bulkscore=0 mlxlogscore=571
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130131

On Thu, Dec 12, 2024 at 09:57:01PM -0800, Christoph Hellwig wrote:
> On Wed, Dec 11, 2024 at 10:09:02AM -0800, Darrick J. Wong wrote:
> > > +
> > > +static __inline__ int platform_test_ext4_fd(int fd)
> > > +{
> > > +	return platform_test_fs_fd(fd, 0xef53); /* EXT4 magic number */
> > 
> > Should this be pulling EXT4_SUPER_MAGIC from linux/magic.h?
> 
> I think we can just drop adding platform_test_ext4_fd with the
> suggested patches later in the series?  Having ext4-specific code
> in xfsprogs would seem pretty odd in xfsprogs anyway over our previous
> categories of xfs only or generic.
> 

Oh right, xfs_io is so widely used across FSes that I missed to consider it 
might not be okay to add special code specific to ext4 :)

Anyways, I agree we don't need to separately handle ext4 anymore.  I'll
drop this patch. (Maybe still get XFS_SUPER_MAGIC from linux/magic.h as
that seems like the right thing to do)

Regards,
ojaswin

