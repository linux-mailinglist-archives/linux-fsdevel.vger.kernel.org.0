Return-Path: <linux-fsdevel+bounces-51814-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F49ADBB3A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 22:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EE423B3E5A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 20:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8088E2116EE;
	Mon, 16 Jun 2025 20:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GdNnEmI6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AF2207A0C;
	Mon, 16 Jun 2025 20:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750105840; cv=none; b=ucP5E70R0U3Sp/DQo9t0KHHVTZOO29IYW8HhY9KhjhUxrkfYUOdG2x6OY7qsMtZEND/zmhktfDivDmI0jbCwjVv1a/oVZRMeIeO7fVUJY4c7LuzVkNGWpHRvIU6maAmUSPGW5hqQ7gd8uF/SKafYUk+77Jupak1rv45Skq5mrPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750105840; c=relaxed/simple;
	bh=hamgTHtQphfJLg+71cqSsH6LRWS1AgeHRNqRdZHuBZY=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=mA+1mS5bOXftVjqqC/uRe+0FeeYVYgOOfARDzlRjtVtj7HrrFi1DfGxh91mQttsqsepS207IXV8HNtgW3UFQhYgX/P5iHRKlzK/BGH7ifmI1BFqkf18yHTIC6gKkgJo5b7nHrg3CwxbQD5nwyeVq4Zh1UcPSra1uxgNW4dQzak8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GdNnEmI6; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55GErUol009585;
	Mon, 16 Jun 2025 20:30:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=GNzNeE
	Bm+3DzC4Zr9XQJpngwrFW2dVlrFN3SOymuvLU=; b=GdNnEmI6smwbrBlQELGdK9
	HFDgvBvtudUFiz+42H639vtCEnnjQy8k/hBnRMe87jezx3olvu/lbW2Iz5XkdHKN
	FA7+Tt2OaITFj8GhJY37eSbPvwvn42lIAeZtBlg4agpycXyKAkpqPlJvM11pYSKR
	y9m5TMLbata7pBeV6EHfSQPvQy8S9CL0NxRCY7C5F+SZI2wm1sBU/7gCztoxYyuL
	146tlJF8KyT29fWURqJRE6d7hCB97J7Bc247uBGwJm6mNwl4KdKmFSIrY5e3jyBH
	qixBNd+1bRhM8gg+PvKMphw3wro0MO4sfUUtnTl+Jy91QchympJM75RwbUzgyqJA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4790r1usq7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Jun 2025 20:30:09 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55GH1hIe005490;
	Mon, 16 Jun 2025 20:30:08 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 479mwkytv2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Jun 2025 20:30:08 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55GKU7T266716102
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Jun 2025 20:30:07 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 96C4B5805A;
	Mon, 16 Jun 2025 20:30:07 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D9F0B58054;
	Mon, 16 Jun 2025 20:30:05 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.36.235])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Jun 2025 20:30:05 +0000 (GMT)
Message-ID: <0e70574bfae43ce939d67e89c858f303ae7ac204.camel@linux.ibm.com>
Subject: Re: [RFC] Keyrings: How to make them more useful
From: Mimi Zohar <zohar@linux.ibm.com>
To: David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
        Jarkko
 Sakkinen <jarkko@kernel.org>, Steve French <sfrench@samba.org>,
        Chuck Lever
 <chuck.lever@oracle.com>
Cc: Paulo Alcantara <pc@manguebit.org>,
        Herbert Xu
 <herbert@gondor.apana.org.au>,
        Jeffrey Altman <jaltman@auristor.com>, hch@infradead.org,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-crypto@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <462886.1749731810@warthog.procyon.org.uk>
References: <462886.1749731810@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Jun 2025 16:30:05 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wXse2RC_vQ4JRRGq0lWq-Sdm9JDEdfIn
X-Proofpoint-ORIG-GUID: wXse2RC_vQ4JRRGq0lWq-Sdm9JDEdfIn
X-Authority-Analysis: v=2.4 cv=AqTu3P9P c=1 sm=1 tr=0 ts=68507ed1 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=JoNQkPbLKCQ6XZtbux0A:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDE0MCBTYWx0ZWRfX8/cI4/OlrSm1 rTcMmcQSkT8bXAKuvP126Suxa2KoCUma8s02UNrUz3zZlyCMQ6ud9aqKLBUY503LhgsjNJmWAb5 saB9BvFDbbZ73yFlY7B6+2MC/ALyGCllRpPkp2jgLPySBegRPYR4oVrkiQPQk74b6wLB2keWBjM
 +UXEUgejZPd+ToJvVgJ28UPYc80VOc2FiXWsLECTwVuKjwQXTQr6U3UXN9IkUEaZB+zykhiLQyh hm+oRUPk/3K9ribP3YyAFjxcFAjSigrznSnSl1a3Toov0xOPCfoiT7z2LYuhefkVEF/yoRNiqe5 jlGYDjbU+a6jVhOKqrons1sJzGL8iTcb4HJ+dWayPoPUmxF3aahpIW1+P3bgA49mM8iaU6J5Rt4
 mLmZwuf4boQZ/HmZV4rcPzdo3dYbg8rnnFhF5miWYZu9nXKmE4jQwwRgyxM3XK5xDiuuLpgr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_10,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 suspectscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=768 mlxscore=0 spamscore=0
 bulkscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506160140

On Thu, 2025-06-12 at 13:36 +0100, David Howells wrote:

[ ...]

>  (4) I think the keyring ACLs idea need to be revived.  We have a whole b=
unch
>      of different keyrings, each with a specific 'domain' of usage for th=
e
>      keys contained therein for checking signatures on things.  Can we re=
duce
>      this to one keyring and use ACLs to declare the specific purposes fo=
r
>      which a key may be used or the specific tasks that may use it?  Use
>      special subject IDs (ie. not simply UIDs/GIDs) to mark this.

David, which keyrings are you referring to?  What do you mean by 'domain' o=
f
usage?  At what level of granularity are you thinking of?  This needs to be
describe in more detail.

thanks,

Mimi

