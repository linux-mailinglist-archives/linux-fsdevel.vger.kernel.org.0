Return-Path: <linux-fsdevel+bounces-35025-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8C39D0061
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Nov 2024 19:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EF7D1F230D3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Nov 2024 18:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482E81957E4;
	Sat, 16 Nov 2024 18:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HwUjZ4ED"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE98318E050;
	Sat, 16 Nov 2024 18:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731780292; cv=none; b=L+6NVxsUBLhU8cV4frhja2ca2sPh6SXQmEv8B9K/Gr2NR4usIbGZC1GcqS6izyz26bGAMn3+r4/WNL5DWxPqrOOoF6XvMafmyBcdipWxh41SYOI0Q72oOPLz8NvuVR/bVpEG8sXPce4HEBd/7tOxSSs3He/ztUt0owXH1x73n0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731780292; c=relaxed/simple;
	bh=2UW1oyhj/5fXyt7dy8CizliT7tVNM9uz1CiHknlAg60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hqhoqSUuZlRTBQekcPcXjqjq2bUJ/HK3SjMwQCwNr9dIWuVYhGDOhkfpJ2tSzegEWIoOXOS86g9387hJ4BnNY45jGh/n9qj1OrMhZ5I1DNQiqfn4WfKZYvZqapMfzQxerOHOfRpE1TLBXJMd/aY9axeyrPQCbwk4qzKLCcvMj/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HwUjZ4ED; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AG9FFSM010223;
	Sat, 16 Nov 2024 17:59:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=Z0QfZ8696wqjKtXYeQtjOtRDnHmp6C
	x9y9ByhIPMbg0=; b=HwUjZ4EDhW08tkQSXoKjF+dgpcTJadPGb0nQNkxLGVmmpE
	EAdJ1B6Vetav4GsLuYb2ThtE92FyqMk5wHxmvpL/hXjSAw0CJuZFy2R7zelslbuI
	ErfVdwa9pMhlDl8SCx03xirtVLgEr2pVMS2oAfeiYhlS/tkJU+9NnlJ8Xtlcz7cu
	0QkpQ8JoqtwLiPET8TsWUcs7i+lBDv9/SH8Cobo/C/E2pEM6rZhTDZGzS8LWRrmp
	EY0uuubmPZ2hOA9mUTZT+7kBueVXbJVebAstXMGl8XxSeKGYM7f3ubJJAVuylfvt
	SvwoKUFKOAwm8x/UvbreNFitt9WWy4pdXGYj7oGw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42xk20j86j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Nov 2024 17:59:39 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4AGHxcP0021318;
	Sat, 16 Nov 2024 17:59:38 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42xk20j86h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Nov 2024 17:59:38 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AGHjc98008243;
	Sat, 16 Nov 2024 17:59:38 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42tjf0xgp1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Nov 2024 17:59:38 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AGHxaO316646434
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 Nov 2024 17:59:36 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1241620043;
	Sat, 16 Nov 2024 17:59:36 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B4A8820040;
	Sat, 16 Nov 2024 17:59:34 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.39.27.238])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sat, 16 Nov 2024 17:59:34 +0000 (GMT)
Date: Sat, 16 Nov 2024 23:29:30 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: linux-ext4@vger.kernel.org, Jan Kara <jack@suse.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Disha Goel <disgoel@linux.ibm.com>, Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH 1/1] quota: flush quota_release_work upon quota writeback
Message-ID: <ZzjdggicyuGqaVs8@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20241115183449.2058590-1-ojaswin@linux.ibm.com>
 <20241115183449.2058590-2-ojaswin@linux.ibm.com>
 <87plmwcjcd.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87plmwcjcd.fsf@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MN_jCb_wmg8aw1tZ8P52oUg1Hijx2hyM
X-Proofpoint-GUID: JYv-_k6ck9lkUefTOi1SpU9UtLlPw0rn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 clxscore=1011 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411160156

On Sat, Nov 16, 2024 at 02:20:26AM +0530, Ritesh Harjani wrote:
> Ojaswin Mujoo <ojaswin@linux.ibm.com> writes:
> 
> > One of the paths quota writeback is called from is:
> >
> > freeze_super()
> >   sync_filesystem()
> >     ext4_sync_fs()
> >       dquot_writeback_dquots()
> >
> > Since we currently don't always flush the quota_release_work queue in
> > this path, we can end up with the following race:
> >
> >  1. dquot are added to releasing_dquots list during regular operations.
> >  2. FS freeze starts, however, this does not flush the quota_release_work queue.
> >  3. Freeze completes.
> >  4. Kernel eventually tries to flush the workqueue while FS is frozen which
> >     hits a WARN_ON since transaction gets started during frozen state:
> >
> >   ext4_journal_check_start+0x28/0x110 [ext4] (unreliable)
> >   __ext4_journal_start_sb+0x64/0x1c0 [ext4]
> >   ext4_release_dquot+0x90/0x1d0 [ext4]
> >   quota_release_workfn+0x43c/0x4d0
> >
> > Which is the following line:
> >
> >   WARN_ON(sb->s_writers.frozen == SB_FREEZE_COMPLETE);
> >
> > Which ultimately results in generic/390 failing due to dmesg
> > noise. This was detected on powerpc machine 15 cores.
> >
> > To avoid this, make sure to flush the workqueue during
> > dquot_writeback_dquots() so we dont have any pending workitems after
> > freeze.
> 
> Not just that, sync_filesystem can also be called from other places and
> quota_release_workfn() could write out and and release the dquot
> structures if such are found during processing of releasing_dquots list. 
> IIUC, this was earlier done in the same dqput() context but had races
> with dquot_mark_dquot_dirty(). Hence the final dqput() will now add the
> dquot structures to releasing_dquots list and will schedule a delayed
> workfn which will process the releasing_dquots list. 
Hi Ritesh,

Ohh right, thanks for the context. I see this was done here:

  dabc8b207566 quota: fix dqput() to follow the guarantees dquot_srcu
  should provide

Which went in v6.5. Let me cc Baokun as well.
> 
> And so after the final dqput and before the release_workfn gets
> scheduled, if dquot gets marked as dirty or dquot_transfer gets called -
> then I am suspecting that it could lead to a dirty or an active dquot.
> 
> Hence, flushing the delayed quota_release_work at the end of
> dquot_writeback_dquots() looks like the right thing to do IMO.
> 
> But I can give another look as this part of the code is not that well
> known to me. 
> 
> >
> > Reported-by: Disha Goel <disgoel@linux.ibm.com>
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > ---
> 
> Maybe a fixes tag as well?

Right, I'll add that in the next revision. I believe it would be:

Fixes: dabc8b207566 ("quota: fix dqput() to follow the guarantees dquot_srcu should provide")

Regards,
ojaswin

> 
> >  fs/quota/dquot.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
> > index 3dd8d6f27725..2782cfc8c302 100644
> > --- a/fs/quota/dquot.c
> > +++ b/fs/quota/dquot.c
> > @@ -729,6 +729,8 @@ int dquot_writeback_dquots(struct super_block *sb, int type)
> >  			sb->dq_op->write_info(sb, cnt);
> >  	dqstats_inc(DQST_SYNCS);
> >  
> > +	flush_delayed_work(&quota_release_work);
> > +
> >  	return ret;
> >  }
> >  EXPORT_SYMBOL(dquot_writeback_dquots);
> > -- 
> > 2.43.5

