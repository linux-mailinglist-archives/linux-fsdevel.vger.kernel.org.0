Return-Path: <linux-fsdevel+bounces-77616-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IsvJdUflmmZagIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77616-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 21:23:49 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7CC159687
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 21:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8C613035278
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 20:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F58349AE1;
	Wed, 18 Feb 2026 20:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jhZQuTZW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E08302176;
	Wed, 18 Feb 2026 20:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771446208; cv=none; b=kJ1bgmkviU7BK9Zi6v0WPN3tFgOibACLiZlZvwmDqL2+QkYDLpjCmLI6J8KcYgioO0ZpcZE4BM5eEWkLzpLb+rtSr84C1HYg4SIDCLSCmxgS7VmOTEhhpNkcIgdnSxK+nffd/xyB9ATnJWZnW4DErmvzC9TzsKLV+9u64o3b3ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771446208; c=relaxed/simple;
	bh=a+EJK4INIn3rrEmeU+8uqf68BGwI08tUjsSp41J2wwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uExVD79BAIsvDxnP4IQSoN4y7WuSvvOYN+zhQ9oT42q4K5m3rauOSMe7X+D2WowGM4w15WOGW7L/GVgiQYlfx9OcZPIP/TjrikRNXSza89IJmAsNEY2TfzguHZNaWifs54vrB9ibIRMCVXV8oxs7zRkxCToJH0wrOf6RLbjnVFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jhZQuTZW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61IEAEB41410265;
	Wed, 18 Feb 2026 20:22:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=E+i1/faGO1lFhzHanw7UXC5RtBSvvF
	1mijuShk8gkfI=; b=jhZQuTZWDC526OZq7bI3InheN/0s1ee1iDdXS7sBdxxWVT
	0vxcEQ+6dr5E3yVw0MQ9DgMKFl6Ww7fr4IPPYiDrkdIqrla7V/eiKL5bfjrHfBOD
	PfPhfTQCzlu1zVfjT5ayvpHPxFcZOiz5JmS+skR1x+SzOvXd7QDC7lmHtn5LKvKD
	U/WNr+5N6QGJpXkYdyMkr6bQAaBUJe1blNUVbKOucrvqMgyM605aPwxmf4q5BldT
	hW0Cg+LfXMUWCgcF3D0nlRzzAeueE/FUkgCi5YnUgx0LJFbQjydT/L9nsXOEotWT
	/bFDlafoTxNKko6P9mkKS6ZUaM3sv+qc0gSFq3WQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj4khwth-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Feb 2026 20:22:52 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61IH03pO012024;
	Wed, 18 Feb 2026 20:22:51 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ccb271eu6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Feb 2026 20:22:51 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61IKMnkv35914068
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Feb 2026 20:22:49 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C5332005A;
	Wed, 18 Feb 2026 20:22:49 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 196BD2004F;
	Wed, 18 Feb 2026 20:22:45 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.25.124])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 18 Feb 2026 20:22:44 +0000 (GMT)
Date: Thu, 19 Feb 2026 01:52:42 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Jan Kara <jack@suse.cz>
Cc: Pankaj Raghav <pankaj.raghav@linux.dev>, linux-xfs@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        lsf-pc@lists.linux-foundation.org, Andres Freund <andres@anarazel.de>,
        djwong@kernel.org, john.g.garry@oracle.com, willy@infradead.org,
        hch@lst.de, ritesh.list@gmail.com,
        Luis Chamberlain <mcgrof@kernel.org>, dchinner@redhat.com,
        Javier Gonzalez <javier.gonz@samsung.com>, gost.dev@samsung.com,
        tytso@mit.edu, p.raghav@samsung.com, vi.shah@samsung.com
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Buffered atomic writes
Message-ID: <aZYfkuueWpMxEiHl@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <d0c4d95b-8064-4a7e-996d-7ad40eb4976b@linux.dev>
 <aY8n97G_hXzA5MMn@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <7cf3f249-453d-423a-91d1-dfb45c474b78@linux.dev>
 <aZSjUWBkUFeJNEL6@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <bf6eek2jagskkgu3isixqjjg3ftrkp5juf6lge3rjjutzzhbdd@vkliyqpsmrry>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf6eek2jagskkgu3isixqjjg3ftrkp5juf6lge3rjjutzzhbdd@vkliyqpsmrry>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE4MDE3MiBTYWx0ZWRfX9FLEzf7jtPZJ
 gxRIrZ/x2mb/H3n910wOIdSzPtIrGUlfYxuofg56lSK0ItA0AyNFv8Kzn3TXJzZIrATwkusRCcG
 0Xu9sAKUIAo4niQIgJvB/rhGZ5z2sx70baKRjeCDv8ftTvGZth3eNx29448fjestSwgOHQpMKSz
 4EN8nz/qwWeVBGNI4PdG1jb8D4u50HpSPy6rPZvZ8AjixQDFsf+vXCnV9zBe9im2jSNVZLEeZ8D
 65VdPgdMP4yUsBDEWzmUtzHEAMdbrtHHG7x7WA8P0WNP3A6cKPh338RkH2592PRkf7PYbrixmft
 5xkKlIwNzF2cRpAscDzy90MLh+/F0Pgwb7rOsLImee/n4n/AUqN7bUtfV2wYRxp0FNR13VG8TnR
 zDFTGH23MCWaerUBCCb2lX9bse28g1p3GVo1g0wE8xxC91oeWvkMkSPe+E80ZmuKjhmmm53rCep
 /HZoD0qSHwr9ojMEJbA==
X-Proofpoint-ORIG-GUID: Wn6Xsq6wTeBZ9-DdGXuQDbfw6exEBFXj
X-Proofpoint-GUID: K4HPm-rnhFQtBUYE8FvRoE8HPd9myNYa
X-Authority-Analysis: v=2.4 cv=M7hA6iws c=1 sm=1 tr=0 ts=69961f9c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=iox4zFpeAAAA:8
 a=NybPXLiR-Eq3wr7rucQA:9 a=CjuIK1q_8ugA:10 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-18_04,2026-02-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602180172
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.dev,vger.kernel.org,kvack.org,lists.linux-foundation.org,anarazel.de,kernel.org,oracle.com,infradead.org,lst.de,gmail.com,redhat.com,samsung.com,mit.edu];
	TAGGED_FROM(0.00)[bounces-77616-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ibm.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ojaswin@linux.ibm.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: EE7CC159687
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 06:42:05PM +0100, Jan Kara wrote:
> On Tue 17-02-26 22:50:17, Ojaswin Mujoo wrote:
> > On Mon, Feb 16, 2026 at 10:52:35AM +0100, Pankaj Raghav wrote:
> > > Hmm, IIUC, postgres will write their dirty buffer cache by combining multiple DB
> > > pages based on `io_combine_limit` (typically 128kb). So immediately writing them
> > > might be ok as long as we don't remove those pages from the page cache like we do in
> > > RWF_UNCACHED.
> > 
> > Yep, and Ive not looked at the code path much but I think if we really
> > care about the user not changing the data b/w write and writeback then
> > we will probably need to start the writeback while holding the folio
> > lock, which is currently not done in RWF_UNCACHED.
> 
> That isn't enough. submit_bio() returning isn't enough to guaranteed DMA
> to the device has happened. And until it happens, modifying the pagecache
> page means modifying the data the disk will get. The best is probably to
> transition pages to writeback state and deal with it as with any other
> requirement for stable pages.

Yes true, looking at the code, it does seem like we would also need to
depend on the stable page mechanism to ensure nobody changes the buffers
till the IO has actually finished.

I think the right way to go would be to first start with an
implementation of RWF_WRITETHOUGH and then utilize that and stable pages
to enable RWF_ATOMIC for buffered IO.

Regards,
ojaswin

> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

