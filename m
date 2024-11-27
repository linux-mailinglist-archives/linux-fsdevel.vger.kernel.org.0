Return-Path: <linux-fsdevel+bounces-35955-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0589DA1F4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 07:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DA16B25254
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 06:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4229A1494D9;
	Wed, 27 Nov 2024 06:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tRcMe2OE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF3F1494A8;
	Wed, 27 Nov 2024 06:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732687337; cv=none; b=VTWTTffTTJLz0OwIWqK9DFD0mrlpJvc9UFzHeKN9Qu3vmkuKnq9NjEsdqZoJka6WAj5bCx3riAS8TYgblvMN804mUBIOALwLgLyGDQ/2tPwtfXNFlCt4TRNqiGmTtNMkYGY/rO9wcrD8p67Ggend2jWin0ntBL7FSF9fsRtWC0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732687337; c=relaxed/simple;
	bh=uQMGWqVTJqjQQWzVswtQz3zjEjLqDGeAktSQRm+f8Fc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jVIVD/VSRTIzTIWa+PmUrgRMT5x4PIk+MZuPctr5jECjoykI9NdDPYBHNLUg0lMik+O5Pgz4l49T2jO0OzHlsscM+IUvbYvcCrb6uBcZU2bffZmsWXgctAJ/JFJNFUQ/nL+5hXoZCY1ks5V0KLedtMWEShRBewOB2B74V55nSno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tRcMe2OE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AR1hSuX004613;
	Wed, 27 Nov 2024 06:01:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=XJ6LzKjtN2bLHXbwSg28WI93OyPeUO
	hhYjzJZY/BJHw=; b=tRcMe2OEolxS0cnhxne3kbAC7V7rxR6j1HExDEH0F7vCd6
	R7K27YF7fso/SHRgdyFB5Vu749Z8JsfBtgZqfa/0VpOft6wj50VFyuJMEs5rmGz3
	nj1pqDiioRv115bg3InPN04PgxgIB5aZ5OTJdt+502zzR5eMdBrzuQ0vRAmh1gqp
	av5z68gfW+RzJYrYHQbEoHSv/7JEQ86z5cUSQnIYkW/9myvId0j2YNhHnnw6AXyH
	5nakWEzGnZ6uvY+7LMRSkQPKuTm9BuUcB4qyHfWfoTEdI4HysehKhw6907oAq/2l
	72oEUBa9WkEjAb4Qb1/qhQuZ8pPecLtoBPZmUY8g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4350rhqgjt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2024 06:01:56 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4AR5ltSY031242;
	Wed, 27 Nov 2024 06:01:56 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4350rhqgjp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2024 06:01:56 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AR5ARhC024910;
	Wed, 27 Nov 2024 06:01:55 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 433tvkjraa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2024 06:01:55 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AR61rso17891620
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Nov 2024 06:01:53 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 84AB320040;
	Wed, 27 Nov 2024 06:01:53 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 99F8B2004B;
	Wed, 27 Nov 2024 06:01:51 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.39.21.251])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 27 Nov 2024 06:01:51 +0000 (GMT)
Date: Wed, 27 Nov 2024 11:31:43 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Baokun Li <libaokun1@huawei.com>
Cc: linux-ext4@vger.kernel.org, Jan Kara <jack@suse.com>,
        Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Yang Erkun <yangerkun@huawei.com>
Subject: Re: [PATCH v2 2/2] ext4: protect ext4_release_dquot against freezing
Message-ID: <Z0a1x7yksOE4Jsha@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20241121123855.645335-1-ojaswin@linux.ibm.com>
 <20241121123855.645335-3-ojaswin@linux.ibm.com>
 <cc2fcc33-9024-4ce8-bd52-cdcd23f6b455@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc2fcc33-9024-4ce8-bd52-cdcd23f6b455@huawei.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cWYwE0OfKJvpEkLNsCzp0p6KH-lQBOae
X-Proofpoint-ORIG-GUID: twrRtpAhTi5S9HXIl5QCrYnDCy4En_F8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999 bulkscore=0
 spamscore=0 impostorscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 adultscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411270048

On Tue, Nov 26, 2024 at 10:49:14PM +0800, Baokun Li wrote:
> On 2024/11/21 20:38, Ojaswin Mujoo wrote:
> > Protect ext4_release_dquot against freezing so that we
> > don't try to start a transaction when FS is frozen, leading
> > to warnings.
> > 
> > Further, avoid taking the freeze protection if a transaction
> > is already running so that we don't need end up in a deadlock
> > as described in
> > 
> >    46e294efc355 ext4: fix deadlock with fs freezing and EA inodes
> > 
> > Suggested-by: Jan Kara <jack@suse.cz>
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > ---
> >   fs/ext4/super.c | 17 +++++++++++++++++
> >   1 file changed, 17 insertions(+)
> > 
> > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > index 16a4ce704460..f7437a592359 100644
> > --- a/fs/ext4/super.c
> > +++ b/fs/ext4/super.c
> > @@ -6887,12 +6887,25 @@ static int ext4_release_dquot(struct dquot *dquot)
> >   {
> >   	int ret, err;
> >   	handle_t *handle;
> > +	bool freeze_protected = false;
> > +
> > +	/*
> > +	 * Trying to sb_start_intwrite() in a running transaction
> > +	 * can result in a deadlock. Further, running transactions
> > +	 * are already protected from freezing.
> > +	 */
> > +	if (!ext4_journal_current_handle()) {
> > +		sb_start_intwrite(dquot->dq_sb);
> > +		freeze_protected = true;
> > +	}
> >   	handle = ext4_journal_start(dquot_to_inode(dquot), EXT4_HT_QUOTA,
> >   				    EXT4_QUOTA_DEL_BLOCKS(dquot->dq_sb));
> >   	if (IS_ERR(handle)) {
> >   		/* Release dquot anyway to avoid endless cycle in dqput() */
> >   		dquot_release(dquot);
> > +		if (freeze_protected)
> > +			sb_end_intwrite(dquot->dq_sb);
> >   		return PTR_ERR(handle);
> >   	}
> >   	ret = dquot_release(dquot);
> > @@ -6903,6 +6916,10 @@ static int ext4_release_dquot(struct dquot *dquot)
> The `git am` command looks for the following context code from line 6903
> to apply the changes. But there are many functions in fs/ext4/super.c that
> have similar code, such as ext4_write_dquot() and ext4_acquire_dquot().

Oh that's strange, shouldn't it match the complete line like:

> > @@ -6903,6 +6916,10 @@ static int ext4_release_dquot(struct dquot *dquot)

That should only have one occurence around line 6903? Or does it try to
fuzzy match which ends up matching ext4_write_dquot etc?

> 
> So when the code before ext4_release_dquot() is added, the first matching
> context found could be in ext4_write_dquot() or ext4_acquire_dquot().
> >   	err = ext4_journal_stop(handle);
> >   	if (!ret)
> >   		ret = err;
> > +
> > +	if (freeze_protected)
> > +		sb_end_intwrite(dquot->dq_sb);
> > +
> >   	return ret;
> >   }
> 
> Thus this is actually a bug in `git am`, which can be avoided by increasing
> the number of context lines with `git format-patch -U8 -1`.
> 
> Otherwise it looks good. Feel free to add:
> 
> Reviewed-by: Baokun Li <libaokun1@huawei.com>

Thanks Baokun!

Regards,
ojaswin
> 

