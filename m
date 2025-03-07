Return-Path: <linux-fsdevel+bounces-43456-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA57A56D56
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 17:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 790203A3BDB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 16:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8972B23959A;
	Fri,  7 Mar 2025 16:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5E5NQcJo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA4A2376E0;
	Fri,  7 Mar 2025 16:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741364178; cv=fail; b=iL1ke3u4LmDKZDelj/I+K6dp0JxORZknIvuKTUe8zkQlzQ8kv8EiFLicD6yeDhN182PtWdqHupRhlqFYqnCnaEZt1xm3WAU4ybeBgaNLYwMY3XIlmiRsd3gqxwktDi98q6Cj+dAYueeMbbK+kCgJK8okHc1GXkRJ253EzCrvDFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741364178; c=relaxed/simple;
	bh=1zjE8cy60Cf0zdGqvH2lIJqfEcqwj+b/kU6/tFo0rXQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rDPl9n1DNkOG6QR4iqPvx1/TA1zwH/bVH6qCGMKnkY0kLqjKUDVKqx1XU1YDnt4mTNMxrxzDZBVZ+CdG5tcIP41RamdBakH2paBhLVA9fxCDd0utJULArS2++dagKNAguHe8xSCPulKFXzYjRacGRdQT6bwAVO55BcFmNC2kA1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5E5NQcJo; arc=fail smtp.client-ip=40.107.237.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xNwiHoL502xd7QwvG8J6uBv91ZmpeXv6c174ToPT0Uk5FYSThdc+YrKnO/e8kysOsJihBHHiUGZ1s80fFJWbZxUrQsGRPayg5h6beqf/FDqHXX/lvxeZKiYAMUK1ZG7BjkeCq30ZD+5dP2lFFeqxbJt+cfIC/eckPJ/E9I4+YXhQAypRqauNZQJvhniFyEP8CEAozfs4WSF6y6gMmX3b9Xnpy0c5wJemizE3R801NrzJ5+tpDOXkdAvmOCZVB7ijkAXSoQiwgFRRDJ1nVjtp3jcH4Pz1FN5IQ0mswmFnR7t09u7JLm0qvRp411AagfcdwpJh2V4dwMsC5c+xnejlRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tOQWH9bTw9Pg92y/4/EplfmCIrmkF2crpH070F/W95Y=;
 b=qOjKEWiqPy0+iJ68J8P3MNEocItHtzkwDV+vebptvfPOCM9yK28+CYHpb8r580GIUwU27fiYUIALFGfWMIJeWWS2ggXQJM3vdA5um38GDnQ7PJO3+34McnBEjeHtdow+WKEi7oYHNzbzucD8avOyH8KZqHJm0B0kIuiJtcNT7UpKsTZfouGi2bwhUdktzh3djm+KtHgGAHd1B+8E0r3Q1hZ+sZLp2I70cFXoNNVIuI+L00yeMHL4ckOAD+UkIAXNI2ttqIbyoqnxeFWTMqNaCU/RzF2vD6Nl2ku9ystS1aJruXEbyAzaW57VjqIf4/exR1hwLYlRfT/Cm4mo8wBSWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tOQWH9bTw9Pg92y/4/EplfmCIrmkF2crpH070F/W95Y=;
 b=5E5NQcJoGJrkAa9BRBukayA5LGYBiEdrQQ324zKW1tBFCXK99eETK+FkV6wGsfniVR1QYxOXx5fRm0VcyOEnf3NYLBm8r368mNd/xYFox2NuQzvaJ+w5CbPUQWsV1QBeEukLjcxF3LCac6zO/qlLDBzLy5IoxprWpPiRO5UP364=
Received: from SN1PR12CA0051.namprd12.prod.outlook.com (2603:10b6:802:20::22)
 by SA3PR12MB8045.namprd12.prod.outlook.com (2603:10b6:806:31d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 16:16:08 +0000
Received: from SA2PEPF00003F62.namprd04.prod.outlook.com
 (2603:10b6:802:20:cafe::c1) by SN1PR12CA0051.outlook.office365.com
 (2603:10b6:802:20::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.18 via Frontend Transport; Fri,
 7 Mar 2025 16:16:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F62.mail.protection.outlook.com (10.167.248.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Fri, 7 Mar 2025 16:16:07 +0000
Received: from [172.31.188.187] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Mar
 2025 10:16:03 -0600
Message-ID: <7cbc5845-e890-4bf5-9488-cd2496642f7e@amd.com>
Date: Fri, 7 Mar 2025 21:46:01 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] fs/pipe: Limit the slots in pipe_resize_ring()
To: Oleg Nesterov <oleg@redhat.com>
CC: Linus Torvalds <torvalds@linux-foundation.org>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Jan Kara
	<jack@suse.cz>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, "Mateusz
 Guzik" <mjguzik@gmail.com>, Rasmus Villemoes <ravi@prevas.dk>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>, <Neeraj.Upadhyay@amd.com>,
	<Ananth.narayan@amd.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>
References: <20250307052919.34542-1-kprateek.nayak@amd.com>
 <20250307052919.34542-2-kprateek.nayak@amd.com>
 <20250307145125.GE5963@redhat.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250307145125.GE5963@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F62:EE_|SA3PR12MB8045:EE_
X-MS-Office365-Filtering-Correlation-Id: 38eb8e50-7f03-4f5b-c4dc-08dd5d935e52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Um5jT2xmNWUvU1NvMi9GS2g5Ri8xUFoyVVJNNHAwNzBsMDY5c0pjcVFxZWpP?=
 =?utf-8?B?WThOTVg2SThrMndBNFZXdzZjVVMwSjdOR3JvV2RiaTl6S0lvQWViZHpSWnhI?=
 =?utf-8?B?dEpHSmhzOWdDekhBYTV2Z1U5NkUrbWxZcWtUZzdBL0hyRU9Od1dCWFR3M2V2?=
 =?utf-8?B?UDlhTm16ZU5HbER2NTVKZEFtUkpZL2dLckNrT2RpQjRzZW9wQXllQW5nNFVD?=
 =?utf-8?B?WElETjRXVDVzaXk5VzBZSFNFNEtiZS9uU1FMUjg5TjVQQ1dzM3lZbVU5aGli?=
 =?utf-8?B?dlpOVm1rcFQ5ZjlON09vYW0wbUJ1RWJwdG5QazUyRmdnMHVVU0dJeXY5S3pR?=
 =?utf-8?B?bDlsSmYyS2tHS3ZWNlZJNk1PeVduOG0wa3htbTBUNFczUGFLNUgwRUhtaVZJ?=
 =?utf-8?B?UllleFR6WHViZWhycW1DTHEwS2NmNWVLYkdwN1Nobk1GZUpZUVhIdE5OcUtO?=
 =?utf-8?B?UE5ZTFdlM0dLV3c5b2pyQVdNWTBSZ0lYTFRYVUFaZFlPV1Q2Ni85Umdhek1V?=
 =?utf-8?B?eE9VL3lHWmpVUWY4UGFaTis0aVhGM1RDVmd2blhFVzJPSDhrNnBwcHVzcWNY?=
 =?utf-8?B?RVJUOUo3d0h2WmdmcXE5ZUUxb213eGhJamxMdzV5aDA2VDhkUDNibVNocS91?=
 =?utf-8?B?MEd6cDd0dWU0b2xmQjNWTmRTb2s0cE5lNnI5YXRtUjRzZWxlZUdBRXFDWmhJ?=
 =?utf-8?B?Zi9acXFOMVRyN1JEem9IUEFRVDVyK2kyS2o0TjRRbnRORU8zUnUwZ2xXYTgy?=
 =?utf-8?B?TFRiY0ZIY2tVRWwzdnBVR3hRZnRlNUZneGIxTlh6b1owcnJLcktlb3dWa25U?=
 =?utf-8?B?UEVOR1Z1NHVTeHNJcytldnhOU3ZHVXV4SWlxSWtYTWk1c3lJOENuZHJVQnM4?=
 =?utf-8?B?MGRmcTFaY0NldC8zbjRMcERHSVhka3ZZRDh6a1U1dTBpUWJSY3FhWWtOTWR4?=
 =?utf-8?B?bHE4dCsreXR0cG5WVkY0c3gxaDdCTitpK1RBNjNVVk4zcTdCRzlSbTZQdHdW?=
 =?utf-8?B?S3ZkMk50OUF4M3lWUEdLVXo3OFBPTC9mMGF0ZHdVeDVLbkZrMUdzTkZhNlNV?=
 =?utf-8?B?bks0UkJ4Z1UzblhtRmRVbjBzem8rSGxCTm9pZHJMdHhBMEdTTVBvM0lOQ2Er?=
 =?utf-8?B?b1M4Wk9qM3dHcFRiM3V2bWxSOXRVQVlOT1VUbHZsTzdkMlgvMDVEanNvcWUw?=
 =?utf-8?B?bkNkTGhoNWZTV3BiQ3ZrQTVNZThPdXJoalNVS2s5WXRkdjlYVXlYUGlpa0tC?=
 =?utf-8?B?bzNFdWZjUTY0MjRZNVZNVGNvTWJwWUFXem8wYWhLTnorYnVNRWRBeUt4bGVx?=
 =?utf-8?B?OTBnbExvaVpWbDBCOUxWYlpJcG5lMHNybjI5MWpGYXVEOC94UWdGRzVHZVRm?=
 =?utf-8?B?NXIyWE5neS9IWkFOSWE2T284a0lLc1ZWbTZwSjIxTTVKQ05IL2F0U3F2eERS?=
 =?utf-8?B?SXU2QWJTSGQrTzhsNFVNejlySzJRTDVqcStRdmhZN2svMnpHdFpCOGhrT1VY?=
 =?utf-8?B?ZjZtd09FcFA2cmV0SlZnNDduVVp4Vmd4Ni8zK3NIYXRPc2cvTEVWbHBiOVZr?=
 =?utf-8?B?RWxsWWFxOXNOL2ZCTHRWUGl5bW1SLzU3Ukw2dVJmeTZIbnZsRTJiaTNEVTNu?=
 =?utf-8?B?MHJ0eGVheUppTjR4S01HNHRjTWZYeENlTmcweExDOEtsNWlFb0wxOFB4NndS?=
 =?utf-8?B?bUJzY2hkNTdQME80cHhHYkF6bXh5eDhOTmM0SG03WUQ3VGp3L1ZlMFBValZI?=
 =?utf-8?B?MFFuSXNZYmZETC96YnhDTmhqOVlJS0svaDdLQmpsa0hXU2JQRlFSbk5sRHZT?=
 =?utf-8?B?WGJLY0kzYlJCaHl3SFF3MHNEa2hXWHpuY3huYnFSbVk3M1pqdmplMmhwRU5U?=
 =?utf-8?B?c2lnUjFEV0h0WWdnbm5jakE2ek8xZU8rT2RBZVp6eUdZZlF1UkQ0dXpJWUhR?=
 =?utf-8?B?UTZHNzY4M2VuUlRrNHFXVXpaaFZnbmlPdVNSbXM2WWdIWHlZSFJESG5pVUN5?=
 =?utf-8?Q?x5gAAGu08s96pW7H3VFRZrk0Ckmo3E=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 16:16:07.9599
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38eb8e50-7f03-4f5b-c4dc-08dd5d935e52
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8045

Hello Oleg,

Thank you for the review.

On 3/7/2025 8:21 PM, Oleg Nesterov wrote:
> On 03/07, K Prateek Nayak wrote:
>>
>> --- a/fs/pipe.c
>> +++ b/fs/pipe.c
>> @@ -1271,6 +1271,10 @@ int pipe_resize_ring(struct pipe_inode_info *pipe, unsigned int nr_slots)
>>   	struct pipe_buffer *bufs;
>>   	unsigned int head, tail, mask, n;
>>
>> +	/* nr_slots larger than limits of pipe->{head,tail} */
>> +	if (unlikely(nr_slots > (pipe_index_t)-1u))
>> +		return -EINVAL;
> 
> The whole series look "obviously" good to me,
> 
> Reviewed-by: Oleg Nesterov <oleg@redhat.com>
> 
> -------------------------------------------------------------------------------
> But damn ;) lets look at round_pipe_size(),
> 
> 	unsigned int round_pipe_size(unsigned int size)
> 	{
> 		if (size > (1U << 31))
> 			return 0;
> 
> 		/* Minimum pipe size, as required by POSIX */
> 		if (size < PAGE_SIZE)
> 			return PAGE_SIZE;
> 
> 		return roundup_pow_of_two(size);
> 	}
> 
> it is a bit silly to allow the maximum size == 1U << 31 in pipe_set_size()
> or (more importantly) in /proc/sys/fs/pipe-max-size, and then nack nr_slots
> in pipe_resize_ring().
> 
> So perhaps this check should go into round_pipe_size() ? Although I can't
> suggest a simple/clear check without unnecesary restrictions for the case
> when pipe_index_t is u16.
> 
> pipe_resize_ring() has another caller, watch_queue_set_size(), but it has
> its own hard limits...

"nr_notes" for watch queues cannot cross 512 so we should be covered there.
As for round_pipe_size(), we can do:

diff --git a/fs/pipe.c b/fs/pipe.c
index ce1af7592780..f82098aaa510 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -1253,6 +1253,8 @@ const struct file_operations pipefifo_fops = {
   */
  unsigned int round_pipe_size(unsigned int size)
  {
+	unsigned int max_slots;
+
  	if (size > (1U << 31))
  		return 0;
  
@@ -1260,7 +1262,14 @@ unsigned int round_pipe_size(unsigned int size)
  	if (size < PAGE_SIZE)
  		return PAGE_SIZE;
  
-	return roundup_pow_of_two(size);
+	size = roundup_pow_of_two(size);
+	max_slots = size >> PAGE_SHIFT;
+
+	/* Max slots cannot be covered pipe->{head,tail} limits */
+	if (max_slots > (pipe_index_t)-1U)
+		return 0;
+
+	return size;
  }
  
  /*
--

Since pipe_resize_ring() can be called without actually looking at
"pipe_max_size" as is the case with watch queues, we can either keep the
check in pipe_resize_ring() as well out of paranoia or get rid of it
since the current users are within the bounds.

Thoughts?

> 
> Oleg.
> 

-- 
Thanks and Regards,
Prateek


