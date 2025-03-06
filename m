Return-Path: <linux-fsdevel+bounces-43316-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EA7A542CA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 07:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C5291893C17
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 06:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E4B1A238F;
	Thu,  6 Mar 2025 06:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QCZq/oGh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F28578F45;
	Thu,  6 Mar 2025 06:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741242673; cv=none; b=I8SYKj8JkTlVF0ZxwnhiADSWuJrJU9iXf0OFeVpxAa5HtXUwWLtoU3Yc12zakOHYK41L/gkfXEo9d7Qf0Y/q0+vQpQFP3HSW34hl/NMIh8XnvaWMTD7T1S1sbo45kC/SzJizMxsmvJxvaqHlCXt4XoCYxx6ZUSqwxWuQ1VWhGlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741242673; c=relaxed/simple;
	bh=1RM+XKiz2InHZKwcemv4fAzqpEQpi7paLLvTAQeR/Og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bRSKHQl8P1NvHn6q7mizO8tOep/enqWqMzr6bJDRkwj0xUw0mdJF0CpLV52GufW6x2sTA3PFzaKK/BrzGSd5QeTd2lmNryiRlkgdOrR9DSuTlX59OcouF6Ra7boTEiP8iLUmMAPmQ5Z4lZAWkUprPC0fb3wiTnsvPYHGceWWUgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QCZq/oGh; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 525KcxsN028695;
	Thu, 6 Mar 2025 06:30:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=7qufjD/TfK5MxuwDXYkHpEzCdUsv3a
	nqlYbsR18my/0=; b=QCZq/oGhIWsV/P0X6bkmtEov1Xv4lzeTcinJ6x4o8BxIfy
	vMjzZB3X+DFrMZ6sC5LXNWXmJYiRUbyNjP7g8JMehPPnWeX06eE7htAHGrvHjmSm
	9uav9ohtkMimKYn09096cfN0dfFhbMEMf3UrD5E4gL/R/FHmRw3lbChGwx03KNSM
	X5eIQgsNqTOBmHPiJLfzOPIEbLFZbX3k00Fj0a4Q+lP1Meka/VL68mwWmoJaAjJ+
	N/04qtTmPa1gd/dHTvygKRCtMMXVpCPL8CDW9QCudqG9OZ434MiP735hEepVPSV5
	QwM2uyYtFUZ2TCFjoHN+VN6kIjfxyUNNoA1gAWCA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 456wu0236j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Mar 2025 06:30:57 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5266Lla2013261;
	Thu, 6 Mar 2025 06:30:57 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 456wu0236e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Mar 2025 06:30:56 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5265HGWu020841;
	Thu, 6 Mar 2025 06:30:56 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 454djnq5pm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Mar 2025 06:30:56 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5266UsaF21037458
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Mar 2025 06:30:54 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 42F982004B;
	Thu,  6 Mar 2025 06:30:54 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A49220040;
	Thu,  6 Mar 2025 06:30:52 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.109.219.249])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  6 Mar 2025 06:30:52 +0000 (GMT)
Date: Thu, 6 Mar 2025 12:00:49 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, Jan Kara <jack@suse.com>, tytso@mit.edu
Cc: Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Baokun Li <libaokun1@huawei.com>,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2 2/2] ext4: protect ext4_release_dquot against freezing
Message-ID: <Z8lBGaJGnM3SZZ-g@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <20241121123855.645335-1-ojaswin@linux.ibm.com>
 <20241121123855.645335-3-ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121123855.645335-3-ojaswin@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lOF2C5IGhBKrbxO3AofFh7cOFvT-pvek
X-Proofpoint-ORIG-GUID: z8x8t88IJ8EpnKqv000xgbHE-aHZbNeS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_03,2025-03-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0
 bulkscore=0 adultscore=0 spamscore=0 mlxlogscore=927 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503060046

On Thu, Nov 21, 2024 at 06:08:55PM +0530, Ojaswin Mujoo wrote:
> Protect ext4_release_dquot against freezing so that we
> don't try to start a transaction when FS is frozen, leading
> to warnings.
> 
> Further, avoid taking the freeze protection if a transaction
> is already running so that we don't need end up in a deadlock
> as described in
> 
>   46e294efc355 ext4: fix deadlock with fs freezing and EA inodes
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Hey Ted,

Just a ping, I think you might have missed this patch. Let me know if
anything else is needed from my side.

Regards,
ojaswin

> ---
>  fs/ext4/super.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 16a4ce704460..f7437a592359 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -6887,12 +6887,25 @@ static int ext4_release_dquot(struct dquot *dquot)
>  {
>  	int ret, err;
>  	handle_t *handle;
> +	bool freeze_protected = false;
> +
> +	/*
> +	 * Trying to sb_start_intwrite() in a running transaction
> +	 * can result in a deadlock. Further, running transactions
> +	 * are already protected from freezing.
> +	 */
> +	if (!ext4_journal_current_handle()) {
> +		sb_start_intwrite(dquot->dq_sb);
> +		freeze_protected = true;
> +	}
>  
>  	handle = ext4_journal_start(dquot_to_inode(dquot), EXT4_HT_QUOTA,
>  				    EXT4_QUOTA_DEL_BLOCKS(dquot->dq_sb));
>  	if (IS_ERR(handle)) {
>  		/* Release dquot anyway to avoid endless cycle in dqput() */
>  		dquot_release(dquot);
> +		if (freeze_protected)
> +			sb_end_intwrite(dquot->dq_sb);
>  		return PTR_ERR(handle);
>  	}
>  	ret = dquot_release(dquot);
> @@ -6903,6 +6916,10 @@ static int ext4_release_dquot(struct dquot *dquot)
>  	err = ext4_journal_stop(handle);
>  	if (!ret)
>  		ret = err;
> +
> +	if (freeze_protected)
> +		sb_end_intwrite(dquot->dq_sb);
> +
>  	return ret;
>  }
>  
> -- 
> 2.43.5
> 

