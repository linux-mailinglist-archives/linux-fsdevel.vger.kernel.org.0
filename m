Return-Path: <linux-fsdevel+bounces-35901-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 265779D975C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 13:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D23FA2855E6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 12:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460071D27B2;
	Tue, 26 Nov 2024 12:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aGmmZvTk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0601327442;
	Tue, 26 Nov 2024 12:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732624893; cv=none; b=N0OBmAttwardYfsScDN+SDXQBYyK0ZG1BU/Yr78+u7NyFkbdHeZYvC/FxeYuOzhk7dj1Km3qe7/3vGxAMU+guTgiQOzQ9bQ9Nkf2FD2DJEamVeFBRdjKM7xI+qXTOHP8IpIRbI+MzFsUZphO5BuukSS3N1TBcz/bIQgXcaIkUMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732624893; c=relaxed/simple;
	bh=3++F0CPGlSPV7VHDSu5UkQCDjvkmtFv4Il2HnX9bZow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HfUjxrwnKYportvkN11gBCUec35kr72OSMK7R3/YQRih0+m7BfwyhPbyqGw6Z5KzePb6BPMWN//bIrOYlQc8Bug+8oQra9A72UIwigiRzbfpUywZk+49GJkCtUim7vX6zI54/+oawsO5i4XGPgGvM8+ZR9qih4xtUdMU4fs7Stg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aGmmZvTk; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AQ8eBha018106;
	Tue, 26 Nov 2024 12:41:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=gI7lf1d2YuHEgZ8p/4OjqQ4L7QiJ9z
	JUd/FwFOMA2p4=; b=aGmmZvTkHQ3RUf99D8ivAqhfnNj/XKEP1pBfJJplCLW0WC
	8bG2e/0J3GC5mMhobFMpQWtCtNnedwwC77iMkmw6YQiBA3iiiz3dlxlYZp2ebhpX
	/pJIWwrfJd2KCmhm9Yup/ts3tS65OJuPbuAXF4PcaZYxqUtfrJMMAuVYd0sex+Hd
	SV8P4bj8gthDhHebz5ys/WzjVuRt1cRDYvjzvvvPaKYJOsNDfrDTmn1z4K17UjhF
	dYMUElBvYicTHEbsLb/aI240PW8urn0GR9hcBZNWnYT4Z7Er0dTsP6B3CRYyMpNv
	YBXC9c5Oqo36Ptss2QEmHRmPaRokXEW7EuV5INqA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43386jwje3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Nov 2024 12:41:21 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4AQCZ0Yo028031;
	Tue, 26 Nov 2024 12:41:21 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43386jwjdx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Nov 2024 12:41:21 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AQ79qF9012370;
	Tue, 26 Nov 2024 12:41:20 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 433scrvg77-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Nov 2024 12:41:20 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AQCfJmk17170736
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Nov 2024 12:41:19 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 15A7D2004E;
	Tue, 26 Nov 2024 12:41:19 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A44AC2005A;
	Tue, 26 Nov 2024 12:41:17 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.109.253.82])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 26 Nov 2024 12:41:17 +0000 (GMT)
Date: Tue, 26 Nov 2024 18:11:14 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, Jan Kara <jack@suse.com>,
        Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH v2 2/2] ext4: protect ext4_release_dquot against freezing
Message-ID: <Z0XB6uLUkwDWLV8E@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20241121123855.645335-1-ojaswin@linux.ibm.com>
 <20241121123855.645335-3-ojaswin@linux.ibm.com>
 <20241126090452.ohggr3daqskllxjk@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241126090452.ohggr3daqskllxjk@quack3>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1nRQjSqdA0HDfy838ABRw0pKv6Qm4RYg
X-Proofpoint-GUID: SZz5FBwk32IcPVu-fs9KsAnJtaIjJpxp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 mlxlogscore=817 spamscore=0 suspectscore=0 phishscore=0 clxscore=1015
 mlxscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411260101

On Tue, Nov 26, 2024 at 10:04:52AM +0100, Jan Kara wrote:
> On Thu 21-11-24 18:08:55, Ojaswin Mujoo wrote:
> > Protect ext4_release_dquot against freezing so that we
> > don't try to start a transaction when FS is frozen, leading
> > to warnings.
> > 
> > Further, avoid taking the freeze protection if a transaction
> > is already running so that we don't need end up in a deadlock
> > as described in
> > 
> >   46e294efc355 ext4: fix deadlock with fs freezing and EA inodes
> > 
> > Suggested-by: Jan Kara <jack@suse.cz>
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> 
> Looks good to me (the 0-day reports seem to be due to wrong merge). Feel
> free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> 								Honza

Thanks Jan, yes it does seem like an incorrect merge.

> 
> > ---
> >  fs/ext4/super.c | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> > 
> > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > index 16a4ce704460..f7437a592359 100644
> > --- a/fs/ext4/super.c
> > +++ b/fs/ext4/super.c
> > @@ -6887,12 +6887,25 @@ static int ext4_release_dquot(struct dquot *dquot)
> >  {
> >  	int ret, err;
> >  	handle_t *handle;
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
> >  
> >  	handle = ext4_journal_start(dquot_to_inode(dquot), EXT4_HT_QUOTA,
> >  				    EXT4_QUOTA_DEL_BLOCKS(dquot->dq_sb));
> >  	if (IS_ERR(handle)) {
> >  		/* Release dquot anyway to avoid endless cycle in dqput() */
> >  		dquot_release(dquot);
> > +		if (freeze_protected)
> > +			sb_end_intwrite(dquot->dq_sb);
> >  		return PTR_ERR(handle);
> >  	}
> >  	ret = dquot_release(dquot);
> > @@ -6903,6 +6916,10 @@ static int ext4_release_dquot(struct dquot *dquot)
> >  	err = ext4_journal_stop(handle);
> >  	if (!ret)
> >  		ret = err;
> > +
> > +	if (freeze_protected)
> > +		sb_end_intwrite(dquot->dq_sb);
> > +
> >  	return ret;
> >  }
> >  
> > -- 
> > 2.43.5
> > 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

