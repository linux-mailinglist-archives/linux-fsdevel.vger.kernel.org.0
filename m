Return-Path: <linux-fsdevel+bounces-49745-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20172AC1E52
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 10:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C147BA24939
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 08:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA37289378;
	Fri, 23 May 2025 08:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rHqBApDK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7CA28750E;
	Fri, 23 May 2025 08:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747987744; cv=none; b=FOhUWoIvNupveVQuADcuSccGexC0FSlT1/pC81a4Q2qLK2ynjMSOVJfiFkKf/4LqNSav6iW94HGhihAYcPWJ6sh4jHI+8AVU+MgwIgSxGEwv2SMItYiyAYtaxuDItbXOkxBxmRjecJwystEvxhdgoQJkIBgKo5lolJgoze+SAJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747987744; c=relaxed/simple;
	bh=iQJkAMho/SskmJOoIxabfLjlJSg2YputWPqHToAzR9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=APAjqVbPP7zhVgrQkjKHZ1BbX8Rg7n2bT8whysFXbq0KMsaw4T5OgSBBsl36GIGAxHe5F4W5sXL91FZjgUPcAqZrGWD9513okvGa2u7a62ZMVH9EAS/1TwuijYoiJV7YMJRUWFFlmiCeRsr0P9VneCsEqFVRrEx7XrtBkCo3C0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rHqBApDK; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54MNWJv3031163;
	Fri, 23 May 2025 08:08:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=NU+rmUVQZVV30gyYlatAr7+b4HlqB5
	UFbKRrBWUc3Ow=; b=rHqBApDKPtxG23had0TgaFYYUGq9rVsPm68PX8tO56IWrQ
	kOpynvKjXDRPayKFd6//6xHy9Zqj6/YtBb85IMDlt5H6/gK5KSoPiEy+gQPtfI4j
	V2bI7Q4KBKVzsPiEYWpxIVAC+2Z7+Mh+zuRXf19yU6wjy1rnEwKVzbfE06ST7VDz
	xG5wwxm4g1tRoYZAYboQwt2XgndzL6OWNVwkAjFCPuFFxMjWLsxrnrAmbR1tIS6q
	qgwHvcDqrdu7rDTFci2SWClVJ4fHMYfTdMQkxAf8/cD8a5ZPDpr16mlOzJQnUnnY
	qDZIMuA3sw7y9hp+krJqbYHBNNOxtmxn6IrV+u0Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46t669m3g8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 May 2025 08:08:47 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54N86fWG004915;
	Fri, 23 May 2025 08:08:46 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46t669m3g5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 May 2025 08:08:46 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54N6Wcdw031996;
	Fri, 23 May 2025 08:08:45 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46rwmqdmfj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 May 2025 08:08:45 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54N88hcE52035910
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 May 2025 08:08:43 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 958282004E;
	Fri, 23 May 2025 08:08:43 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2AD7320043;
	Fri, 23 May 2025 08:08:42 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.109.219.249])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 23 May 2025 08:08:41 +0000 (GMT)
Date: Fri, 23 May 2025 13:38:39 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-block@vger.kernel.org, John Garry <john.g.garry@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, djwong@kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] traceevent/block: Add REQ_ATOMIC flag to block trace
 events
Message-ID: <aDAtB-lLCDh0C-Fc@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <44317cb2ec4588f6a2c1501a96684e6a1196e8ba.1747921498.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44317cb2ec4588f6a2c1501a96684e6a1196e8ba.1747921498.git.ritesh.list@gmail.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RrPFLDmK c=1 sm=1 tr=0 ts=68302d0f cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=NCqlNMH9hAoYGvFVMsQA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: _LsNRelh7zggaIAP8liKuFWW5UbpRgH8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDA3MyBTYWx0ZWRfXzXQMe12Z5IIH 9YiBpKehal/YHEBGzXjuB0/I8pta9cFZPtI733LeMu+3awJB9z31WskdAynFEspjv4goD6ECQI3 IPr/ydYmtH1+awHAGk9EKKQtunnkliwsYzT9O1pBwFz8PSOhfyvje/KKlXxgmR23QTcwA/Kn46A
 NTBAxnvHecyAK6XJwyHoHETAy3uh/VSSAOHZrB5IsO2SfgOmDUNKxMtiu3j7im6sDFH6RmxJmi4 +1J4vEPTSd2wSQ7a0vlIj7ujQ/JPaS6HDwkeiNhFASIWz/5D5sEHlekfgFUnrHUSAcz5JT9fvVS 5FDXOmzrgmXQiAyETDw2Hk38OMfnFHU3fLQSLjPPeFQfdC9KldC4mWIyK7tO/lq5SnvcZOTouoW
 E0kklOBf0NE+wqvnNNEdaBa4T7Ht0vqT4qflah3KBlCC/lL1mGu4kFZbgip177sWSjnthKNj
X-Proofpoint-GUID: X4OSvc16wZk2wF7mVFh1HjEaI89EyGnK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_02,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 impostorscore=0 mlxlogscore=568 suspectscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 spamscore=0 adultscore=0
 clxscore=1011 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505230073

On Thu, May 22, 2025 at 07:21:10PM +0530, Ritesh Harjani (IBM) wrote:
> Filesystems like XFS can implement atomic write I/O using either
> REQ_ATOMIC flag set in the bio or via CoW operation. It will be useful
> if we have a flag in trace events to distinguish between the two. This
> patch adds char 'U' (Untorn writes) to rwbs field of the trace events
> if REQ_ATOMIC flag is set in the bio.
> 
> <W/ REQ_ATOMIC>
> =================
> xfs_io-4238    [009] .....  4148.126843: block_rq_issue: 259,0 WFSU 16384 () 768 + 32 none,0,0 [xfs_io]
> <idle>-0       [009] d.h1.  4148.129864: block_rq_complete: 259,0 WFSU () 768 + 32 none,0,0 [0]
> 
> <W/O REQ_ATOMIC>
> ===============
> xfs_io-4237    [010] .....  4143.325616: block_rq_issue: 259,0 WS 16384 () 768 + 32 none,0,0 [xfs_io]
> <idle>-0       [010] d.H1.  4143.329138: block_rq_complete: 259,0 WS () 768 + 32 none,0,0 [0]
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
 
 Looks good Ritesh, feel free to add:

 Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

 Regards,
 ojaswin

