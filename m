Return-Path: <linux-fsdevel+bounces-51963-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A17ADDB97
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 20:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EFA33ABAEE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 18:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CEC2EF9B0;
	Tue, 17 Jun 2025 18:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tWU+Yr/W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E612EF9AB;
	Tue, 17 Jun 2025 18:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750185779; cv=none; b=RoM0pFPGo9dKa7CYzkY4vlt3JDnoBqpnEmpXbhKuWVhKeobmlI8T4I1UQx8//gESpyVwV9eUAvP+dTQAuQ6D4WKeSfDxlzz7ID2M5UNXCz4jONW7Z2fCCCk6Qd0ksck9s3Cbd0gPitdCNIKwtmrzBKFLfGg1hPLofGTf9opuu04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750185779; c=relaxed/simple;
	bh=HJpQeF1vW1yjrdQssOc5z3xBHR1I+8cAUCILHyaitNo=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=BODsEEsO3Yj2IDUSMjDQvrZYBM6vDJkd6ULLp0qj7VvZF8CwOXud2vd7fU8JMIMe9+qtuHS5AOdIOIJhibwn9xZ5Ka8FG9G2kWECASx407XrYc+VqDL8wrkvAdR+9ypwhL2mbeR6+y/0wK99VwVHw31xzjQQ/V8qxtYq14pV9ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tWU+Yr/W; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55HGKIcZ003387;
	Tue, 17 Jun 2025 18:42:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=HJpQeF
	1vW1yjrdQssOc5z3xBHR1I+8cAUCILHyaitNo=; b=tWU+Yr/WCmTlwZ2qspcnKH
	CIRA1ziMdguUundU0v66gIkEeuOyTdBM5mcdKe0/Bs5D73SoKJGqSErwuyQ4y6Iw
	ne+yG2ahCZCzdZcOv5in6reEH3gHbDmA4qjYtx0AljFgNrg7uxKJHMd7IG+6Vifp
	XgE6oGIO3iA3VvbygiDNFWvVxd/JxajznvP8cNT1SMwO4oRu4hyYR7WeP7uIR9co
	bUyd0+qPpjIBu5XOLStmP3yR34ZIJgehhqY1KlCRtni6ouT8foDsSg3T4vPXR0mD
	lgwIAQUNOMPtSBrjfKO2pwcU6BShbz5W4o/Hy48hbKtYgHMsYDG+ZtcHQCU27jig
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4794qp94y9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Jun 2025 18:42:56 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55HFUNAZ000875;
	Tue, 17 Jun 2025 18:42:56 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 479mdp50mu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Jun 2025 18:42:56 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55HIgtZk15008342
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Jun 2025 18:42:55 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D0D95805B;
	Tue, 17 Jun 2025 18:42:55 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 86AAC5804B;
	Tue, 17 Jun 2025 18:42:54 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.31.96.173])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Jun 2025 18:42:54 +0000 (GMT)
Message-ID: <6bac287bab8b64865393805523a561111718c632.camel@linux.ibm.com>
Subject: Re: [PATCH 06/10] ima_fs: don't bother with removal of files in
 directory we'll be removing
From: Mimi Zohar <zohar@linux.ibm.com>
To: Al Viro <viro@zeniv.linux.org.uk>, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc: linux-integrity@vger.kernel.org
In-Reply-To: <20250612031154.2308915-6-viro@zeniv.linux.org.uk>
References: <20250612030951.GC1647736@ZenIV>
	 <20250612031154.2308915-1-viro@zeniv.linux.org.uk>
	 <20250612031154.2308915-6-viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Jun 2025 14:42:54 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cHmzsrHbGLGTPrMPufJsNu0nMblhhOel
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDE0NiBTYWx0ZWRfX41/kmNb2LWHc LzdavrXrrOwFvRDziQX0Xu5OP52SUphRZaB0g1kILjcXWUnWW/YEbuCEFWaG8OwiHgyti5aj2tg 2ZyNdrzc/KcsYsTVswOebnFiBopttur9lxhV5FCOZse5355aVz2Q7O2KwKn++4GN7/fwI9XPTst
 k9bPv5V+A5iWtmv5iGahMsNnJ3UcQM50PWM7vxh4o/EaggHvRcqg3W/VbC+BxkESrQp2zqNnBtG Lp2n4djX3b+c86zmZP/JL6FBs3spfMjE3SfJrTW3xhatKbjP715h/iQUAIVuGvOZEYMF/N2H5i8 1YiCtahs0JJFDoHuKxk619lVwpjsqzereMtFlQ1POkfXPd12bBd3HPlU7Lj27K3AiCKdWljZN78
 hJwNOLpAFdBNJ0Hu6D5RmwDRMwjkoSMWH4CLjnL/QnZdH/ogXI9Vdj6y17YPDsUZxWfKT0Uv
X-Authority-Analysis: v=2.4 cv=NYfm13D4 c=1 sm=1 tr=0 ts=6851b730 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=drOt6m5kAAAA:8 a=VnNF1IyMAAAA:8 a=aSVpHF6hEU9aBlr88qQA:9 a=QEXdDO2ut3YA:10
 a=RMMjzBEyIzXRtoq5n5K6:22
X-Proofpoint-ORIG-GUID: cHmzsrHbGLGTPrMPufJsNu0nMblhhOel
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_08,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 suspectscore=0 mlxlogscore=591 mlxscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506170146

On Thu, 2025-06-12 at 04:11 +0100, Al Viro wrote:
> removal of parent takes all children out
>=20
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Acked-by: Mimi Zohar <zohar@linux.ibm.com>


