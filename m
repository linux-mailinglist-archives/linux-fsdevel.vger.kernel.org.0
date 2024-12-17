Return-Path: <linux-fsdevel+bounces-37601-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 232459F430E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 06:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0559D7A1AE9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 05:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EC9156227;
	Tue, 17 Dec 2024 05:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LFNCykbv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6A61361;
	Tue, 17 Dec 2024 05:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734414009; cv=none; b=hBqOc6JCQhAbTOdZpH1q5QPjQBc9rGxR5Qcj/ANKkKFY5iCTNhqvklxkkz77FnJdD6IR1OCDDzWgaq9PCWNRvgf1Km/K6CZG53jiKBhszGMZtmVAa31DyeirhULJJTb6sdKVw5r5XKpw8YWQJbsrCg6kUfLY5aXT3eGwA4V+lUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734414009; c=relaxed/simple;
	bh=eAvkA/BKFEuxIJVRuYk60z0Nu1+Awdcch4g0c1+fVrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tMRMFd42LqXSsqGyX9T8jNhZvKOWTUEVaTJsz7fZftqbtqm6Inuzlb4c4XIs6cmPJtl6vn0D2sKGOXVT4fd7DOytngUyxzU4MFmyVkZmogCW00UnLmdmrPOgGV/j7UKsTnqIQTlOZChcyPhM49ZOj1df35YPYpd4XzDmfuIK2JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LFNCykbv; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BH3qEY0022880;
	Tue, 17 Dec 2024 05:39:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=plGWMUnKaQnCgXwhn7ZsXHAgo3T1hF
	qPpSJX1B0fFqI=; b=LFNCykbveeTr3EpmGBKD8y+LSmumtrLOHkep2cAbNIJfgN
	FYBVqK8n3PpX/3z9taUvjvi2krGMFV5Zz8WTk9zQ5bq7Ql+heVdk55tvS/k49tdD
	p4AQafOtpq8w75bgANlVKfZxhAD5QU1rQPxTspH8OqDSVoAW9N2nwEMvxPWfp9Pa
	klnptBLcTzk8QeUK+nk3U1bnb0b66kY6BX3YI/dXkYXhZhQbM0ARa6MBWONauRUv
	JZ4Sd+f3qDDlLsd91mYPPwnr5AEpQjaVQw+fEqNPAVUcsp/woH1/Ph/XzqY3R4Hk
	QOIxF7wh48hjAx6a0I6cV0NoaZjo9hlAOK9EJyNw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43k1sb0aqm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 05:39:58 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BH5dwhe007110;
	Tue, 17 Dec 2024 05:39:58 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43k1sb0aqg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 05:39:57 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BH3ZutB011267;
	Tue, 17 Dec 2024 05:39:57 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 43hpjk15a6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 05:39:57 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BH5dtkK11403754
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Dec 2024 05:39:55 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5602B2004B;
	Tue, 17 Dec 2024 05:39:55 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6569920040;
	Tue, 17 Dec 2024 05:39:53 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.124.215.237])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 17 Dec 2024 05:39:53 +0000 (GMT)
Date: Tue, 17 Dec 2024 11:09:49 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrey Albershteyn <aalbersh@kernel.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH 1/3] include/linux.h: use linux/magic.h to get
 XFS_SUPER_MAGIC
Message-ID: <Z2EOpTVkTvetGRvh@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <cover.1734253505.git.ojaswin@linux.ibm.com>
 <713c4e61358b95bbdf95daca094abc73a230e52f.1734253505.git.ojaswin@linux.ibm.com>
 <Z1_kkCNX9dL0hwPf@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1_kkCNX9dL0hwPf@infradead.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: K1yeoxxSm06yBWsbIjKYNrJf3LsfC4pk
X-Proofpoint-ORIG-GUID: F8scgoH9LzH5Z-BVtrOJvrissbrFpzKr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 suspectscore=0 mlxlogscore=429 spamscore=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 malwarescore=0 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412170044

On Mon, Dec 16, 2024 at 12:28:00AM -0800, Christoph Hellwig wrote:
> On Sun, Dec 15, 2024 at 02:47:15PM +0530, Ojaswin Mujoo wrote:
> > -	return (statfsbuf.f_type == 0x58465342);	/* XFSB */
> > +	return (statfsbuf.f_type == XFS_SUPER_MAGIC);
> 
> Might be worth dropping the superfluous braces here while you're at it.

Thanks for the review Christoph, I will fix the braces here.

regards,
ojaswin
> 
> Otherwise looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 

