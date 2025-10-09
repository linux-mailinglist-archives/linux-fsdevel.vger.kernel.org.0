Return-Path: <linux-fsdevel+bounces-63659-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E38BC90D2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 09 Oct 2025 14:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 466303C1152
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Oct 2025 12:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F8D2E1F06;
	Thu,  9 Oct 2025 12:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nLEpgEKy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834B934BA5C;
	Thu,  9 Oct 2025 12:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760013420; cv=none; b=UXhnkvWwE6mBvOUbblLL/oKy2udNtoWnTLdIDubDDL1GwMQ8kBPbC8Ob0LxoJnP1UE3PCpXfNkrpw1IhXWUkOXTn0o3ok49ge2586E5qAqkwcBdvzhNJBLGPmWnZ6Wxq2UW6ydRimTBuoH9zD0UEC8U3W8QGlJKpxGDVB91PC5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760013420; c=relaxed/simple;
	bh=HtcxlAMHvl3AHs8Ukce8umJ81Z6QJilyJ7H5Iwrb8N0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tpVIQwfZHr9k/EFTN4OhyBQmGWlUNdzw+ZJjfsK42SpJAYBBWWdLhlicLherU7NQR5KDvqgFZrMwLvADtPCXBqFZboDcYSZUpxcvvVWlJln0t+37VTaWV7spm9Alq/nhOo5r9rrXEG8ywe+QawJnsSevgyeRve7SjgAC/Gce65U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nLEpgEKy; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 599BbHmN031607;
	Thu, 9 Oct 2025 12:36:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=fuH+eToZ/pKB0li5jeNZ0pdZy6yWAo
	Kblp8A9Sc90yQ=; b=nLEpgEKywpDznbLlwXMNi768uZ33XyefVjWuSZrLA7jUR/
	Zt+dS0KrTgzL/E7RsAAWdOFArFJvHv+edz/7YwCVNFobSbO04vV0Jy+Wg+g2w8mE
	sD2oYEDHNP9a4IOz1BQza2qx4Zkrr2gbbU19mEnZ+OedtQXdVT3ymaSmLV22MvQe
	i+fw40YSyD3iOVyF6T59SdKYb6DMSgbGEq4haDP30Zl40ROvhXiv8hqn2c0gaXTn
	CFWI6dtg2SvXhfHbTv6lKPzcAx9AGHIY1xJkWv/zrruXBABJ8XnXoY6MTWAs8cE1
	qNOX7I6gJ5vNCZYSv6NrdBzE28JejqVudzcTitqA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49nv824rkj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Oct 2025 12:36:46 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 599CJPZV008346;
	Thu, 9 Oct 2025 12:36:45 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49nvanvfjc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Oct 2025 12:36:45 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 599CahDM51839424
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Oct 2025 12:36:43 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 53A37200BE;
	Thu,  9 Oct 2025 12:36:43 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 62792200C7;
	Thu,  9 Oct 2025 12:36:41 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.109.219.158])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  9 Oct 2025 12:36:41 +0000 (GMT)
Date: Thu, 9 Oct 2025 18:06:27 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Matt Fleming <matt@readmodwrite.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@cloudflare.com, linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: ext4 writeback performance issue in 6.12
Message-ID: <aOesS6Feov9mrbJh@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <20251006115615.2289526-1-matt@readmodwrite.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006115615.2289526-1-matt@readmodwrite.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KrpAGGWN c=1 sm=1 tr=0 ts=68e7ac5e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=NEAV23lmAAAA:8 a=_QroHv5PzVNJjBY0ZGcA:9
 a=CjuIK1q_8ugA:10 a=HhbK4dLum7pmb74im6QT:22 a=cPQSjfK2_nFv0Q5t_7PE:22
 a=pHzHmUro8NiASowvMSCR:22 a=Ew2E2A-JSTLzCXPT_086:22
X-Proofpoint-GUID: fFBirEcDl9DUQnH80RKPVisryv3nyPv7
X-Proofpoint-ORIG-GUID: fFBirEcDl9DUQnH80RKPVisryv3nyPv7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX8CvsS/B9rMhp
 MPN3EvemBrvC4V1isVD12cVj5mDMrPu2Gd2dgd8MFdAQyWIc5Z+YoOvE8B3IozHvSeYF80vrPH2
 biAKGmw8Jeedus4qd37skLQFkFMfC/8X3KBV0z7oGm76fEkdI/nJZGVJgfv6W2Nzh/g9JKs+6+W
 dxlFrrml51buLflOrGRggKAMmXPdqqGjZTQqobrNmojgHK396JqmOmvkKhxeROKecETG9QeBkiy
 TaayXOOZkNpqZlJpZS+TCtHO4+Zi7VpO/Gy4KwPITwcFY7K1rOlaUUF+70vfAfKHI5lRkQx5uKZ
 ux/9X4XgwPoQKvP0FmLWn1HIWQq2ZPKixn9OLgBJ8jJIAiaCVeu4d4p7lGAJ1mN3/rt0JJCHEGn
 sqOLoBCz+IOmTl6FbfK3gf9/orz/QQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1011
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

On Mon, Oct 06, 2025 at 12:56:15PM +0100, Matt Fleming wrote:
> Hi,
> 
> We're seeing writeback take a long time and triggering blocked task
> warnings on some of our database nodes, e.g.
> 
>   INFO: task kworker/34:2:243325 blocked for more than 225 seconds.
>         Tainted: G           O       6.12.41-cloudflare-2025.8.2 #1
>   "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>   task:kworker/34:2    state:D stack:0     pid:243325 tgid:243325 ppid:2      task_flags:0x4208060 flags:0x00004000
>   Workqueue: cgroup_destroy css_free_rwork_fn
>   Call Trace:
>    <TASK>
>    __schedule+0x4fb/0xbf0
>    schedule+0x27/0xf0
>    wb_wait_for_completion+0x5d/0x90
>    ? __pfx_autoremove_wake_function+0x10/0x10
>    mem_cgroup_css_free+0x19/0xb0
>    css_free_rwork_fn+0x4e/0x430
>    process_one_work+0x17e/0x330
>    worker_thread+0x2ce/0x3f0
>    ? __pfx_worker_thread+0x10/0x10
>    kthread+0xd2/0x100
>    ? __pfx_kthread+0x10/0x10
>    ret_from_fork+0x34/0x50
>    ? __pfx_kthread+0x10/0x10
>    ret_from_fork_asm+0x1a/0x30
>    </TASK>
> 
> A large chunk of system time (4.43%) is being spent in the following
> code path:
> 
>    ext4_get_group_info+9
>    ext4_mb_good_group+41
>    ext4_mb_find_good_group_avg_frag_lists+136
>    ext4_mb_regular_allocator+2748
>    ext4_mb_new_blocks+2373
>    ext4_ext_map_blocks+2149
>    ext4_map_blocks+294
>    ext4_do_writepages+2031
>    ext4_writepages+173
>    do_writepages+229
>    __writeback_single_inode+65
>    writeback_sb_inodes+544
>    __writeback_inodes_wb+76
>    wb_writeback+413
>    wb_workfn+196
>    process_one_work+382
>    worker_thread+718
>    kthread+210
>    ret_from_fork+52
>    ret_from_fork_asm+26
> 
> That's the path through the CR_GOAL_LEN_FAST allocator.
> 
> The primary reason for all these cycles looks to be that we're spending
> a lot of time in ext4_mb_find_good_group_avg_frag_lists(). The fragment
> lists seem quite big and the function fails to find a suitable group
> pretty much every time it's called either because the frag list is empty
> (orders 10-13) or the average size is < 1280 (order 9). I'm assuming it
> falls back to a linear scan at that point.
> 
>   https://gist.github.com/mfleming/5b16ee4cf598e361faf54f795a98c0a8
> 
> $ sudo cat /proc/fs/ext4/md127/mb_structs_summary
> optimize_scan: 1
> max_free_order_lists:
> 	list_order_0_groups: 0
> 	list_order_1_groups: 1
> 	list_order_2_groups: 6
> 	list_order_3_groups: 42
> 	list_order_4_groups: 513
> 	list_order_5_groups: 62
> 	list_order_6_groups: 434
> 	list_order_7_groups: 2602
> 	list_order_8_groups: 10951
> 	list_order_9_groups: 44883
> 	list_order_10_groups: 152357
> 	list_order_11_groups: 24899
> 	list_order_12_groups: 30461
> 	list_order_13_groups: 18756
> avg_fragment_size_lists:
> 	list_order_0_groups: 108
> 	list_order_1_groups: 411
> 	list_order_2_groups: 1640
> 	list_order_3_groups: 5809
> 	list_order_4_groups: 14909
> 	list_order_5_groups: 31345
> 	list_order_6_groups: 54132
> 	list_order_7_groups: 90294
> 	list_order_8_groups: 77322
> 	list_order_9_groups: 10096
> 	list_order_10_groups: 0
> 	list_order_11_groups: 0
> 	list_order_12_groups: 0
> 	list_order_13_groups: 0
> 
> These machines are striped and are using noatime:

Hi Matt,

Thanks for the details, we have had issues in past where the allocator
gets stuck in a loop trying too hard to find blocks that are aligned to
the stripe size [1] but this particular issue was patched in an pre 6.12
kernel.

Coming to the above details, ext4_mb_find_good_group_avg_frag_list()
exits early if there are no groups of the needed so if we do have many
order 9+ allocations we shouldn't have been spending more time there.
The issue I think are the order 9 allocations, which allocator thinks it
can satisfy but it ends up not being able to find the space easily.
If ext4_mb_find_group_avg_frag_list() is indeed a bottleneck, there
are 2 places where it could be getting called from:

- ext4_mb_choose_next_group_goal_fast (criteria =
	EXT4_MB_CR_GOAL_LEN_FAST)
- ext4_mb_choose_next_group_best_avail (criteria =
	EXT4_MB_CR_BEST_AVAIL_LEN)

Will it be possible for you to use bpf to try to figure out which one of
the callers is actually the one bottlenecking (mihgt be tricky since
they will mostly get inlined) and a sample of values for ac_g_ex->fe_len
and ac_b_ex->fe_len if possible.

Also, can you share the ext4 mb stats by enabling it via:

 echo 1 > /sys/fs/ext4/vda2/mb_stats

And then once you are able to replicate it for a few mins: 

  cat /proc/fs/ext4/vda2/mb_stats

This will also give some idea on where the allocator is spending more
time.

Also, as Ted suggested, switching stripe off might also help here.

Regards,
Ojaswin
> 
> $ grep ext4 /proc/mounts
> /dev/md127 /state ext4 rw,noatime,stripe=1280 0 0
> 
> Is there some tunable or configuration option that I'm missing that
> could help here to avoid wasting time in
> ext4_mb_find_good_group_avg_frag_lists() when it's most likely going to
> fail an order 9 allocation anyway?
> 
> I'm happy to provide any more details that might help.
> 
> Thanks,
> Matt

