Return-Path: <linux-fsdevel+bounces-27979-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C1B96573A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 07:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7B71B22C5C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 05:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60D814F9E1;
	Fri, 30 Aug 2024 05:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="c0oxAE/7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE75214A0B6;
	Fri, 30 Aug 2024 05:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724997468; cv=none; b=ShCNfMppoxTBtZKQzhVznsPhoBmL4V8cHGA0xE1JBviifua8cJGE/mXTeAp7bwVs2leCW8k0NKKwfbpimOaMfwVP7pqI9pa00yo5zWHz1icjpSBhpcxfBYa+V0APout8Ub2vnQCa3xq+8fdYp8S1Wkc9psc/xw/b/0ekE8IPJqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724997468; c=relaxed/simple;
	bh=CDUrk3zMv67XAarUr+2bT8akH1i9sGcWkwQ9HwuJ8Nc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i8kdyB6wceJmpXeXo5PoKupeHr7FZug8mv4bM2IOOYzlOBP90gSUXNRwNYlFl0xRI4MsY6GTbXxvP2ubYfH3xZu2ZTwleAFbP7L+eIjeULL7C3b6fuLhum/kFaN52lD9qqAtep7cI7dcu3i9zfobC55g7t2QvT3jGB28oY1LfVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=c0oxAE/7; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47U3Nt37003367;
	Fri, 30 Aug 2024 05:57:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:in-reply-to:references:date:message-id
	:mime-version:content-type:content-transfer-encoding; s=pp1; bh=
	CDUrk3zMv67XAarUr+2bT8akH1i9sGcWkwQ9HwuJ8Nc=; b=c0oxAE/71OEMLCBm
	OdhefJb6N50Gji1bs7gS9c0c6irY+g7o7IS6C3KA1nR0HDzjbbN+gjjhhGKJofOq
	EhUeFz3wIJ5ooU0N+U3/x6xtzJd+8EIZYYa8np/4W1af93E/PE5zwjDexGcS0+NH
	m5RxeIR5pCTL9PFmja1OalRcj3K752DrM8DPaTRWLO/vBk91m0JXNhNkWhSEb/XR
	QBTbSqsbzBZ1wLPAJdHTQOdd2Aln4MWz1rVYwpDrN27N7Mh9JfFhOcCkVpooRObR
	wJUpr0FVlqe96JFbVpO0mI2hz1mCkl3PorhnK7oX3mDuNBufKi83PGdw2Pk+teqy
	hzTAXQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 419q8qctcp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Aug 2024 05:57:14 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47U5vEai006812;
	Fri, 30 Aug 2024 05:57:14 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 419q8qctcg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Aug 2024 05:57:14 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47U5klqi003111;
	Fri, 30 Aug 2024 05:57:13 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 417tuq9rh3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Aug 2024 05:57:13 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47U5vBib18415966
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 05:57:11 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 25A4B2005A;
	Fri, 30 Aug 2024 05:57:11 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D559D20040;
	Fri, 30 Aug 2024 05:57:10 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 30 Aug 2024 05:57:10 +0000 (GMT)
From: Sven Schnelle <svens@linux.ibm.com>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Zi Yan <ziy@nvidia.com>, Matthew Wilcox <willy@infradead.org>,
        "Pankaj
 Raghav (Samsung)" <kernel@pankajraghav.com>,
        brauner@kernel.org, akpm@linux-foundation.org, chandan.babu@oracle.com,
        linux-fsdevel@vger.kernel.org, djwong@kernel.org, hare@suse.de,
        gost.dev@samsung.com, linux-xfs@vger.kernel.org, hch@lst.de,
        david@fromorbit.com, yang@os.amperecomputing.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        john.g.garry@oracle.com, cl@os.amperecomputing.com,
        p.raghav@samsung.com, ryan.roberts@arm.com,
        David Howells
 <dhowells@redhat.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH v13 04/10] mm: split a folio in minimum folio order chunks
In-Reply-To: <ZtEHPAsIHKxUHBZX@bombadil.infradead.org> (Luis Chamberlain's
	message of "Thu, 29 Aug 2024 16:41:48 -0700")
References: <20240822135018.1931258-1-kernel@pankajraghav.com>
	<20240822135018.1931258-5-kernel@pankajraghav.com>
	<yt9dttf3r49e.fsf@linux.ibm.com>
	<ZtDCErRjh8bC5Y1r@bombadil.infradead.org>
	<ZtDSJuI2hYniMAzv@casper.infradead.org>
	<221FAE59-097C-4D31-A500-B09EDB07C285@nvidia.com>
	<ZtEHPAsIHKxUHBZX@bombadil.infradead.org>
Date: Fri, 30 Aug 2024 07:57:10 +0200
Message-ID: <yt9dle0er1s9.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6OIQVdZSEZ307sReg3lqu_l3a05lWqTn
X-Proofpoint-ORIG-GUID: byezXyY-9GTyTUd_Mq8392plPJ4YcFf7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_02,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 impostorscore=0 suspectscore=0
 adultscore=0 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 mlxlogscore=757 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408300039

Luis Chamberlain <mcgrof@kernel.org> writes:

> On Thu, Aug 29, 2024 at 06:12:26PM -0400, Zi Yan wrote:
>> The issue is that the change to split_huge_page() makes split_huge_page_=
to_list_to_order()
>> unlocks the wrong subpage. split_huge_page() used to pass the =E2=80=9Cp=
age=E2=80=9D pointer
>> to split_huge_page_to_list_to_order(), which keeps that =E2=80=9Cpage=E2=
=80=9D still locked.
>> But this patch changes the =E2=80=9Cpage=E2=80=9D passed into split_huge=
_page_to_list_to_order()
>> always to the head page.
>>=20
>> This fixes the crash on my x86 VM, but it can be improved:

It also fixes the issue on s390x. Thanks!

