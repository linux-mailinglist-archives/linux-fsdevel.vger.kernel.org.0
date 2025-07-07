Return-Path: <linux-fsdevel+bounces-54110-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C90AFB572
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 15:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8810B3AAF63
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 13:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E722BD5A1;
	Mon,  7 Jul 2025 13:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZydXeAik"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562DC19D880
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Jul 2025 13:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751896609; cv=none; b=EEF7Q2Hs/qakWg5GvEJnCMT77Q1WvAso78OLqBTFEnHlH55Bu9B+pWRvjl6z+kFm90qie2evY28GYRNo77+ySUhWIwmz1HUBdUuYDPRvcEBRM3MDBeBsyCS23fL2mwn4U/4yGsd3c3MnkV2jbBlvdeYgwyVovVTZmI342KirWUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751896609; c=relaxed/simple;
	bh=ZATC/+FhJgzjlFxxqMKrnL3O6Is7fUT9k6SZQ666z9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g6hdLbIBIms0oqQYmC4xAingdujNb20KennxzoIEbcy5w/Oo4ns861XKOqaUn0GPJ7pscLFt3MVg7BPQYHExRSUWU9NQoSgrtsNG6Hv4vH8ennb2u52yQvx1nu5plFbOqhUHPCoN9K5GaQPF1wGGQDwmFnmOWzSTlQMxQjtrGVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZydXeAik; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 567B4q4t024638;
	Mon, 7 Jul 2025 13:56:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=QRv8azdTzXmsiZyUWDcIW/MRUGghOC
	v0OaLdvpwkm3g=; b=ZydXeAike+8XgGCpNN16ZeZqpDT2QCBOGlTl9N3dgO+LxD
	ZyexYUxeMvi+V6BnKuGrKvLA0Eyrru6HypbRgqjzMDzaTRnGX9j+2p5f7RO5nRHo
	bhq8M/TP+bjFsOSU75TNKZDZC5g3RNA0QyEZiSvTbkjjlPHrzmE+8o5Njr2Vvpb7
	nDr+E4U0pxIQxszY4IA4vK/VSHwGa1CexIPB9wM6pbb4NS7ifpx66yx78Z//58XS
	cM+t3THdDGZVSEgHmZs1QW6bBIKtepZnexLXRWVqxvdw4q6e2WVlO3wD/Zdgg8xh
	JtnGmAG709eC3SCWfn4KRIvuOupshKU8Dit9NnzA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ptfyhmrh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Jul 2025 13:56:44 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 567D2tcs025586;
	Mon, 7 Jul 2025 13:56:44 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47qfcnxaps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Jul 2025 13:56:44 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 567DugrK22544772
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 7 Jul 2025 13:56:42 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 148E820043;
	Mon,  7 Jul 2025 13:56:42 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D0D8D20040;
	Mon,  7 Jul 2025 13:56:41 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com (unknown [9.87.129.26])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  7 Jul 2025 13:56:41 +0000 (GMT)
Date: Mon, 7 Jul 2025 15:56:40 +0200
From: Jan Polensky <japo@linux.ibm.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [BUG] linux-next: Signal handling and coredump regression in LTP
 coredump_pipe()
Message-ID: <aGvSGP8zQZDUH1_l@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
References: <20250707095539.820317-1-japo@linux.ibm.com>
 <20250707-irrtum-aufblasbar-5226d9d544ea@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707-irrtum-aufblasbar-5226d9d544ea@brauner>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=crubk04i c=1 sm=1 tr=0 ts=686bd21c cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=dWKVyG3mCClnsUYDCHcA:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-ORIG-GUID: KMbsXM_yb25jXu7893vfyMYXKqro7Ubl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA3MDA4MCBTYWx0ZWRfX34inArj5qDGZ ExK7as2tzU/VXkBjRRvgiVkbybooDO3HoP6xeA2y9ICtDFfYllZEVM/jv2sDOaUIUlBl1zAiHTW eTVtfQ3iYTg+JPAicZ94SxyKYqwAqOy3csUXvvUKfj65npo9iIrgK+RvRcFW8sUKj4CzsN6VY1F
 0ns9CZ622g5qu3JKoFNTDqEwr3BzsFasqwN8zvhEaSWW8IdusKokd5vNV0Na/KL0LzyYUsoNaMz UajuOMwjDZPZu/jtuLJ/rUUEzD8iLnki0qFEHmqgbCPMAH6vC1L0y3ksAcNusycJEcXQ8fzh11x cXYRemVi7uCwr19vwF9nUqJf1a4FliJ8TIszrdFX+yaLwFdZAJHlzxCF54Qjj2sAj09jCSXuwXv
 Dnn5vkwF/4WZ8YpUFwf9NOcq2TyWz9pR3fPkc5FYxDe6x7ExpBZPXhMKJDtvZzIVGeM+Q7rb
X-Proofpoint-GUID: KMbsXM_yb25jXu7893vfyMYXKqro7Ubl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-07_03,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 adultscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507070080

On Mon, Jul 07, 2025 at 12:20:36PM +0200, Christian Brauner wrote:
> On Mon, Jul 07, 2025 at 11:55:39AM +0200, Jan Polensky wrote:
> > Hi all,
[skip]
> > ---
>
> Very odd because I run the coredump tests. Can you please give me the
> exact LTP command so I can make sure I'm running those tests?
I ran them without kirk to avoid testing overhead, e.g.:

    runltp -f syscalls
    runltp -f syscalls -s kill11
    ltp-bin/testcases/bin/kill11

Some tests may be skipped depending on kernel config, system capabilities, and
installed software.
Let me know if you'd prefer a kirk run for comparison.

[skip]

