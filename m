Return-Path: <linux-fsdevel+bounces-37477-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D460C9F2CA4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 10:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 614341889AB1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 09:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F354A200BBD;
	Mon, 16 Dec 2024 09:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sWXuGo9n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9FD200138;
	Mon, 16 Dec 2024 09:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734340341; cv=none; b=DS4XxTQuZx0VthjvngC0CYXF8kZsm7UIi8ziF9uJr7qDOeRuL7TbZ4NAjG9EdaMZBs43Hj2bdZPj14HlDVIL+NspvA2R6tA2AyT3HwPFADJcScFgCQUjbj4N4+TzWhfOLYMBda/W1u1fnXhzx6FWuHvR79b1WIvwouyGxf2SfVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734340341; c=relaxed/simple;
	bh=gyU529X3Uy75HoTyX5bwhVIWDJ8mguiUzuWJhjfiui4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SC6VNEy2Fk9seFfAFovoNOUTBxG/MONAfWJAJWMYEbC78Oa46WLKYNkRxMV8lCf5/aY+uOkl91tllpLaxFOfVwOwlP4iiTcQ0OqkicjtcIklWsJk13adj3p6CeiLCYyULKFSsa9geADd6m4CN7Xn0yOV8ABhHO6UTlkoW2Y/+BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sWXuGo9n; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG3qt5X020245;
	Mon, 16 Dec 2024 09:12:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=f+5xFk
	CVO/8sTzd0VPmLfZ/gpvg6SLZUQZxvY7UWd4Y=; b=sWXuGo9nspF8K5fOKTWccJ
	RL/3AdX1A0tRj+igS3lrj/Obr6ltOPeAEVfN+Uc8aiYB/CsYCumpPQ4D1MzQDERW
	USxc8OSnRViPqXlpz0nn0kbCMNu4phHxWo4tz/kWlu/9I0eQ0UiSM3qv+qkaeu6C
	8Wgxut2bTdxvDFw//pxVMtCXhjHe8zqe+fYMH840daMdr8ZGlY5fzmOuW/lowlWw
	0TiDX4wuaaB1DYBb4Ok1w+ralFwEWLojdlZMHJHwkCVGjA7NShLMcQsn6OlLSnLP
	S7HFnXFC8gLDpSf9iqi7f/MT0z5UqJDjnzirjhBaW1VBXk75AEMwRISwi83GeDsQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43jcpgs98p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 09:12:02 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BG99ihK027165;
	Mon, 16 Dec 2024 09:12:01 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43jcpgs98j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 09:12:01 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG5FODs024047;
	Mon, 16 Dec 2024 09:12:00 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43hnuk54cd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 09:12:00 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BG9BweI56885552
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 09:11:58 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 637462004D;
	Mon, 16 Dec 2024 09:11:58 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F071220040;
	Mon, 16 Dec 2024 09:11:56 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.124.215.36])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 16 Dec 2024 09:11:56 +0000 (GMT)
Date: Mon, 16 Dec 2024 14:41:54 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Baokun Li <libaokun1@huawei.com>
Cc: linux-ext4@vger.kernel.org, Jan Kara <jack@suse.com>,
        Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Yang Erkun <yangerkun@huawei.com>
Subject: Re: [PATCH v2 2/2] ext4: protect ext4_release_dquot against freezing
Message-ID: <Z1/u2jIpSjAxOB6r@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20241121123855.645335-1-ojaswin@linux.ibm.com>
 <20241121123855.645335-3-ojaswin@linux.ibm.com>
 <cc2fcc33-9024-4ce8-bd52-cdcd23f6b455@huawei.com>
 <Z0a1x7yksOE4Jsha@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <8885691f-b977-409f-90f8-b24c41a49de0@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8885691f-b977-409f-90f8-b24c41a49de0@huawei.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5Mu_ixrgx-Xw0m2ui7O2MqOTtaQAv0xJ
X-Proofpoint-ORIG-GUID: ZnURpHL64P98UmdBDfFD5H4oms75qr9X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 mlxscore=0 phishscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 spamscore=0 mlxlogscore=999 malwarescore=0 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412160074

On Tue, Dec 03, 2024 at 04:29:31PM +0800, Baokun Li wrote:
> On 2024/11/27 14:01, Ojaswin Mujoo wrote:
> > On Tue, Nov 26, 2024 at 10:49:14PM +0800, Baokun Li wrote:
> > > On 2024/11/21 20:38, Ojaswin Mujoo wrote:
> > > > Protect ext4_release_dquot against freezing so that we
> > > > don't try to start a transaction when FS is frozen, leading
> > > > to warnings.
> > > > 
> > > > Further, avoid taking the freeze protection if a transaction
> > > > is already running so that we don't need end up in a deadlock
> > > > as described in
> > > > 
> > > >     46e294efc355 ext4: fix deadlock with fs freezing and EA inodes
> > > > 
> > > > Suggested-by: Jan Kara <jack@suse.cz>
> > > > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > > > ---
> > > >    fs/ext4/super.c | 17 +++++++++++++++++
> > > >    1 file changed, 17 insertions(+)
> > > > 
> > > > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > > > index 16a4ce704460..f7437a592359 100644
> > > > --- a/fs/ext4/super.c
> > > > +++ b/fs/ext4/super.c
> > > > @@ -6887,12 +6887,25 @@ static int ext4_release_dquot(struct dquot *dquot)
> > > >    {
> > > >    	int ret, err;
> > > >    	handle_t *handle;
> > > > +	bool freeze_protected = false;
> > > > +
> > > > +	/*
> > > > +	 * Trying to sb_start_intwrite() in a running transaction
> > > > +	 * can result in a deadlock. Further, running transactions
> > > > +	 * are already protected from freezing.
> > > > +	 */
> > > > +	if (!ext4_journal_current_handle()) {
> > > > +		sb_start_intwrite(dquot->dq_sb);
> > > > +		freeze_protected = true;
> > > > +	}
> > > >    	handle = ext4_journal_start(dquot_to_inode(dquot), EXT4_HT_QUOTA,
> > > >    				    EXT4_QUOTA_DEL_BLOCKS(dquot->dq_sb));
> > > >    	if (IS_ERR(handle)) {
> > > >    		/* Release dquot anyway to avoid endless cycle in dqput() */
> > > >    		dquot_release(dquot);
> > > > +		if (freeze_protected)
> > > > +			sb_end_intwrite(dquot->dq_sb);
> > > >    		return PTR_ERR(handle);
> > > >    	}
> > > >    	ret = dquot_release(dquot);
> > > > @@ -6903,6 +6916,10 @@ static int ext4_release_dquot(struct dquot *dquot)
> > > The `git am` command looks for the following context code from line 6903
> > > to apply the changes. But there are many functions in fs/ext4/super.c that
> > > have similar code, such as ext4_write_dquot() and ext4_acquire_dquot().
> > Oh that's strange, shouldn't it match the complete line like:
> A rough look at the `git am` source code looks like it only focuses on
> line numbers between two ‘@@’.
> 
> am_run
>  run_apply
>   apply_all_patches
>    apply_patch
>     parse_chunk
>      find_header
>       parse_fragment_header
>     check_patch_list
>      check_patch
>       apply_data
>        load_preimage
>        apply_fragments
>         apply_one_fragment
>          find_pos
>           match_fragment
> > > > @@ -6903,6 +6916,10 @@ static int ext4_release_dquot(struct dquot *dquot)
> > That should only have one occurence around line 6903? Or does it try to
> > fuzzy match which ends up matching ext4_write_dquot etc?
> In find_pos(), start from line 6903, compare the hash value of each line
> of code line by line in forward direction, if it can't match, then match
> the hash value of each line of code line by line in reverse direction from
> line 6903. Fuzzy matching is used if some whitespace characters should be
> ignored.

Ahh okay thanks for looking into this Baokun, pretty interesting since
I've never looked at git code :)

Regards,
ojaswin
> 
> 
> Regards,
> Baokun
> 

