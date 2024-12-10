Return-Path: <linux-fsdevel+bounces-36923-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2239EB068
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 13:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E8B3169004
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 12:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4D91A4F2D;
	Tue, 10 Dec 2024 12:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oA0m6Cgy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD9C1A3A94;
	Tue, 10 Dec 2024 12:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733832275; cv=none; b=UKMixQzrR90TlkzGeOgoOO5iFDXvn3DUsgOPDJNoJao9zDojZ5CZJJl8OYrdtSvG/4UkCxzrU4GfEbIw1n/m7VhHot9XdM6LLytJJnTGRMlT+v55GzHAtVRlVeJpncija7rzBZaR1Of13iPC9EyYsEkl9wdaLG7y2iiSl1QIxZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733832275; c=relaxed/simple;
	bh=hezpDc+AUcdmYVJPKOASpHJDutPa15Atoqov8smISWA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rftCOnHxWdWcN0t9AwJtwDLmeqfHahDdvUXvLZAVrRIgHGMfDPtOW+pYRw+dGIeS7Oc5euBBsAHf46FTsMEPluFYxYgMhddkgoI+B50S2mT3VqHRvcwVmAYPKaK8ESRXwV/rdv+1lwgOIngDmpRfeUgu1ISeIXODYR4P6Da+nqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oA0m6Cgy; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BA9kEH9001905;
	Tue, 10 Dec 2024 12:04:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vA75UP
	03QsurDGssRpWZcSqFusQkpZzOyF8/hFKVgXg=; b=oA0m6Cgy9j2oxfWXBcvGt4
	PR0YVzpvh6e7ZWu6Qn69v8MRmIFkKHbRNDOZBzljtkhzXUIZEPZay0A2Xtlu0wXP
	LvcVgwh79bsLmUAy/KS0bS7vbBtVz9Xqsgasc767WcnCQ9J3j1A711/akjbUagbq
	eadN3om5/Zgju3Z9DW2zt363tyvDpSMD6RNMswDChvGAmdfxX8fW33HpYscOPEmL
	0//qbjOzUcc5iTSumkQvAXpbCLTEf9azvII6R+AYrs3EbghS+bKGKPRu2ZIE8sGh
	KDVwseaNuywkIo6LzHRrdNIK6GbGnHqvj0kugr5gFhA4nFPS3xbUlM1p1q+Ma22Q
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce0xdrv6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 12:04:25 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BA95Goj023062;
	Tue, 10 Dec 2024 12:04:24 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 43d2wju6sf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 12:04:24 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BAC4MaN50463210
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Dec 2024 12:04:22 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A4E62004B;
	Tue, 10 Dec 2024 12:04:22 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 715D220040;
	Tue, 10 Dec 2024 12:04:22 +0000 (GMT)
Received: from p-imbrenda (unknown [9.152.224.66])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 10 Dec 2024 12:04:22 +0000 (GMT)
Date: Tue, 10 Dec 2024 13:04:20 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-s390@vger.kernel.org
Subject: Re: Removing page->index
Message-ID: <20241210130420.534a6512@p-imbrenda>
In-Reply-To: <023d1c53-783e-4d6d-a5e9-d15b9e068986@redhat.com>
References: <Z09hOy-UY9KC8WMb@casper.infradead.org>
	<cebb44b2-e258-43ff-80a5-6bd19c8edab8@redhat.com>
	<20241209183611.1f15595f@p-imbrenda>
	<023d1c53-783e-4d6d-a5e9-d15b9e068986@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PTMiC_JsSh-uP8nX3mrxpQjELbvawpTI
X-Proofpoint-ORIG-GUID: PTMiC_JsSh-uP8nX3mrxpQjELbvawpTI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 impostorscore=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412100089

On Tue, 10 Dec 2024 12:05:25 +0100
David Hildenbrand <david@redhat.com> wrote:

> On 09.12.24 18:36, Claudio Imbrenda wrote:
> > On Wed, 4 Dec 2024 16:58:52 +0100
> > David Hildenbrand <david@redhat.com> wrote:

[...]

> >> I know that Claudio is working on some changes, but not sure how that
> >> would affect gmap's usage of page->index.  
> > 
> > After I'm done, we won't use page->index anymore.
> > 
> > The changes I'm working on are massive, it's very impractical to push
> > everything at once, so I'm refactoring and splitting smaller and more
> > manageable (and reviewable) series.
> > 
> > This means that it will take some time before I'm done (I'm *hoping*
> > to be done for 6.15)  
> 
> Thanks for the information. So for the time being, we could likely 
> switch to page->private.
> 
> One question may be whether these (not-user-space) page tables should at 
> some point deserve a dedicated memdesc. But likely the question is what 

maybe? but given that everything is changing all the time, I'm avoiding
any magic logic in struct page / struct folio.

> it will all look like after your rework.

but now that you put my attention on it, I'll try to get rid of
page->index rather sooner than later.

