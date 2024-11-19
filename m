Return-Path: <linux-fsdevel+bounces-35170-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5049D1FA4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 06:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40149B2228C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 05:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876D41514E4;
	Tue, 19 Nov 2024 05:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="c46usrg1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495A52563;
	Tue, 19 Nov 2024 05:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731994954; cv=none; b=RGHIR3pneHg/pHL17ErUU3biY4V44FmInGAoLjiUnR648xPjnhTcuu0qqWH2e9SiPlntYicHlAzTfkZMgzjC6TSK4kIiDEF4NioiXsRKuD/q8TUFSS+dgzpOxDmqAoGJv9pUVv6sUaLFV1WT+fivN2gz4viLQOLEWnj/EdYsMbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731994954; c=relaxed/simple;
	bh=QM83Udjw77+/uaLRT6uB38EHfkqOk/3v69MSjP6mUe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eXDh3lYlkdunYi6BpbpkVD+J4PTE+WNn/jTLV3scBA7i47cddBdTJApKU1CF5EkeYOVItXApvZpunCwJAH1YIpaT805MyPatJKbifHk5orZBPC+bKHy74pYXReAH5leA7U5R1j7Ejabm0XPk+7/ovTY8DahWTtgIc6dUUUHhCw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=c46usrg1; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AIJU7pV023609;
	Tue, 19 Nov 2024 05:42:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=xjMKWH/qvZ7+Zk58iz3tuyqBC06pzj
	cY8byMy+DmQV4=; b=c46usrg1oK0eiQSxozVUv2mrcIqX+m/17wWhWDRGBjFqDc
	Q78DPrvUKW54ItdbHj1kgsrTB3ZDeQvQAN1PNGEPhVEx9rkPUsRjMsOwRZ54P4oV
	gZZKyYnqGWofrfMQ02a/FGBqt7i4XU1m/vqQ3ITLm3QPoGzz9S+uWjpfzS33JEop
	T3dmCXnboRsz+jqCfFCMg9hakvQb2dNl0B5ebImTnYOQp2SVyivIjAgz/+/oCi/J
	RiYlF72QkNM5WyVvCm46gQqlaVkjtsE3uEjyXmai2bNL6NGaDj2DLzBBW5hsKP1f
	0Wy9aUYgEBVWXUQ1HWCaFs1DiMwV2pqanXpCdqPg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42xk2vx4ac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 05:42:27 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4AJ5gHod020517;
	Tue, 19 Nov 2024 05:42:27 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42xk2vx4a9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 05:42:27 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJ4P6bq000580;
	Tue, 19 Nov 2024 05:42:26 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42y77kuvnm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 05:42:25 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AJ5gNnI22413884
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 05:42:24 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D710020043;
	Tue, 19 Nov 2024 05:42:23 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E458B20040;
	Tue, 19 Nov 2024 05:42:21 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.124.222.17])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 19 Nov 2024 05:42:21 +0000 (GMT)
Date: Tue, 19 Nov 2024 11:12:18 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, Jan Kara <jack@suse.com>,
        Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCH 1/1] quota: flush quota_release_work upon quota writeback
Message-ID: <ZzwlOukMjJtZxxgn@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20241115183449.2058590-1-ojaswin@linux.ibm.com>
 <20241115183449.2058590-2-ojaswin@linux.ibm.com>
 <20241118131512.ku7g7bllelrtkdeo@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118131512.ku7g7bllelrtkdeo@quack3>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Q7-J90OsCGrQ5lGzm0aZVg4Qqe7HrvTk
X-Proofpoint-GUID: pZ0BJ3xh99Pr1Sb1TnvoZWeiRixwEQWW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 phishscore=0 clxscore=1015 suspectscore=0 spamscore=0
 impostorscore=0 bulkscore=0 mlxscore=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411190040

On Mon, Nov 18, 2024 at 02:15:12PM +0100, Jan Kara wrote:
> On Sat 16-11-24 00:04:49, Ojaswin Mujoo wrote:
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
> > 
> > Reported-by: Disha Goel <disgoel@linux.ibm.com>
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> 
> Thanks for debugging this!
> 
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
> 
> I'd rather do this at the start of dquot_writeback_dquots(). Chances are
> this saves some retry loops in the dirty list iterations. That being said I

Hi Jan, thanks for review :)


> don't think this is enough as I'm thinking about it. iput() can be called
> anytime while the filesystem is frozen (just freeze the filesystem and do
> echo 3 >/proc/sys/vm/drop_caches) which will consequently call dquot_drop()
> -> dqput(). This should not be really freeing the dquot on-disk structure
> (the inode itself is still accounted there) but nevertheless it may end up
> dropping the last dquot in-memory reference and ext4_release_dquot() will
> call ext4_journal_start() and complain. So I think on top of this patch
> which makes sense on its own and deals with 99.9% of cases, we also need
> ext4 specific fix which uses sb_start_intwrite() to get freeze protection
> in ext4_release_dquot() (and in principle we always needed this, delayed
> dquot releasing does not influence this particular problem). Some care will
> be needed if the transaction is already started when ext4_release_dquot()
> is called - you can take inspiration in how ext4_evict_inode() handles
> this.

That's a good point Jan, this could indeed happen if we drop caches
destroying an inode pinned in the lru cache. Thanks for the pointers,
I'll try to look into hardening ext4_release_dquot() as you suggested
and send a v2.

Regards,
ojaswin
> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

