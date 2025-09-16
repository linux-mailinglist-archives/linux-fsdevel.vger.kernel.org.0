Return-Path: <linux-fsdevel+bounces-61717-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF68AB59463
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 12:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66F251BC8236
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 10:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745082D063D;
	Tue, 16 Sep 2025 10:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AbLSsMHN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3F82877D3;
	Tue, 16 Sep 2025 10:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758019894; cv=none; b=dZtWuA/SOPSca4/AsYzSGEEtPXUZIMqBCCBmGU+CrWwJjgAV2GLgHI2AkmTNOd0VTNGICfMnMw19PGePrv2xKGlJpli1H95mtpuIYAlvLfTCSMpwXJSPHTyYAB7347jCFe6PA21pA2gYlA1uIE2pMtqQ5GmB4s9cvppfEyqPjCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758019894; c=relaxed/simple;
	bh=nGtXyRb3El3m6A0XnwTidWGk9rdKsvA5L58wZQPcKTY=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=lHjrjMNfnvVB4sYUJHzttMSvzlMZUHJzG7GVwSKI8+O+0tOYp1pKbFKmitqyYANhxB5q6/Y8D/x2/MjxtSnGaaqn6RfTJJAyu9zpVDuJlJkWjHYgUbhY1PXxC7jY2UfeOfGnY7HHEmbudniH1h6imN1b0MvOGqSw66ANumxJ32I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AbLSsMHN; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58G7VubJ017774;
	Tue, 16 Sep 2025 10:51:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=6tiMzpFySb6QheQKIvDTH6bfs6J9A1FW2+JoAuxFTeI=; b=AbLSsMHN4/7x
	K1xNMtFDrE+TOYW1iIsk4Mpi83HqtjESBjZwkWHJ8kKIL6P1kWFgRbg5RHL/Vc3/
	3gNiaqucIq+Hh51NRfzWX0tQi6l43nWNKIrpYWsuJRM6WFMkpMIumQPjbiBNolvo
	Y5C7x/SgZ+Lg+AIaq8uXUg7N+k5h9pT/2jo/OiBPLGzNJmqVQ/uNJdo/uDuDiSBq
	WEnHzpMxwUc0R/63Kg2X/G4mqzS8whBtZo73nJ9nqat9v/gFpoDFgpa6HdDBi/35
	ZZtv0zCsk+pBvAE/vE0jbXVqaj9ApqBocZnQJNjhIpUknqNLYl+7NU0hbSMUKozo
	aSRGgR2Zog==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 496g536k9u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Sep 2025 10:51:09 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58GAp8j4018605;
	Tue, 16 Sep 2025 10:51:08 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 496g536k9s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Sep 2025 10:51:08 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58G85k50009486;
	Tue, 16 Sep 2025 10:51:07 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 495nn3b4fg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Sep 2025 10:51:07 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58GAp6EK11011482
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Sep 2025 10:51:06 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6406D5803F;
	Tue, 16 Sep 2025 10:51:06 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4345B58055;
	Tue, 16 Sep 2025 10:51:04 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 16 Sep 2025 10:51:04 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 16 Sep 2025 12:51:03 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: pengdonglin <dolinux.peng@gmail.com>
Cc: tj@kernel.org, tony.luck@intel.com, jani.nikula@linux.intel.com,
        ap420073@gmail.com, jv@jvosburgh.net, bcrl@kvack.org,
        trondmy@kernel.org, longman@redhat.com, kees@kernel.org,
        bigeasy@linutronix.de, hdanton@sina.com, paulmck@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        linux-nfs@vger.kernel.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org,
        netdev@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-wireless@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-s390@vger.kernel.org, cgroups@vger.kernel.org,
        Holger Dengler <dengler@linux.ibm.com>,
        Vasily
 Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        pengdonglin <pengdonglin@xiaomi.com>
Subject: Re: [PATCH v3 05/14] s390/pkey: Remove redundant
 rcu_read_lock/unlock() in spin_lock
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <20250916044735.2316171-6-dolinux.peng@gmail.com>
References: <20250916044735.2316171-1-dolinux.peng@gmail.com>
 <20250916044735.2316171-6-dolinux.peng@gmail.com>
Message-ID: <31be6bb6541bb3e338e3025ac9e8fce5@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dUB5GxZDVKC_6J2Ylb023C_3mzK49UHc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE1MDA4NiBTYWx0ZWRfX5K5HvLPe748s
 1a0iccxe5DzHqpq2HHVExtQN3K3dDZAHmx+plczsOrZBuez8PS/bGeKlwxmdko1vp27MiJETJTG
 rWBkahKjm6E+Lehe9W5AsUAlfhXLzBCKZl91u4s5pKGLTilBgre1vFNiCO4KLvO9XrWU1Caav6A
 LP5y7FEjU/NnADi5ucPQYwViKT2GmRSmRBhcRXXpZEfspZ5l5uxEmXVcbW4As4eHjzGuflsj31H
 fsacgfENVa2S7hh4yS1XXPBx2rL5+dQv2gYhPIFTz7huQ8NQh9IyA9t8ZyRl7UxTDbk1vmK6jmT
 k/dl/Zv55pKlRrfw9Ym17kI1XWuEyzglymXJjQwZlfbaExngRAMTnR8i/K+0vtUxACA7W2YSZzh
 NNpGuSjP
X-Proofpoint-ORIG-GUID: okqK8s0OaduvH8SS01anEhfn0Ac3dkSd
X-Authority-Analysis: v=2.4 cv=UJ7dHDfy c=1 sm=1 tr=0 ts=68c9411d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=IeNN-m2dAAAA:8 a=VnNF1IyMAAAA:8
 a=pGLkceISAAAA:8 a=6zuzY4jPHNdFWWqqfRgA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 clxscore=1011 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509150086

On 2025-09-16 06:47, pengdonglin wrote:
> From: pengdonglin <pengdonglin@xiaomi.com>
> 
> Since commit a8bb74acd8efe ("rcu: Consolidate RCU-sched update-side
> function definitions")
> there is no difference between rcu_read_lock(), rcu_read_lock_bh() and
> rcu_read_lock_sched() in terms of RCU read section and the relevant 
> grace
> period. That means that spin_lock(), which implies 
> rcu_read_lock_sched(),
> also implies rcu_read_lock().
> 
> There is no need no explicitly start a RCU read section if one has 
> already
> been started implicitly by spin_lock().
> 
> Simplify the code and remove the inner rcu_read_lock() invocation.
> 
> Cc: Harald Freudenberger <freude@linux.ibm.com>
> Cc: Holger Dengler <dengler@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> Signed-off-by: pengdonglin <dolinux.peng@gmail.com>
> ---
>  drivers/s390/crypto/pkey_base.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/s390/crypto/pkey_base.c 
> b/drivers/s390/crypto/pkey_base.c
> index b15741461a63..4c4a9feecccc 100644
> --- a/drivers/s390/crypto/pkey_base.c
> +++ b/drivers/s390/crypto/pkey_base.c
> @@ -48,16 +48,13 @@ int pkey_handler_register(struct pkey_handler 
> *handler)
> 
>  	spin_lock(&handler_list_write_lock);
> 
> -	rcu_read_lock();
>  	list_for_each_entry_rcu(h, &handler_list, list) {
>  		if (h == handler) {
> -			rcu_read_unlock();
>  			spin_unlock(&handler_list_write_lock);
>  			module_put(handler->module);
>  			return -EEXIST;
>  		}
>  	}
> -	rcu_read_unlock();
> 
>  	list_add_rcu(&handler->list, &handler_list);
>  	spin_unlock(&handler_list_write_lock);

Acked-by: Harald Freudenberger <freude@linux.ibm.com>

