Return-Path: <linux-fsdevel+bounces-43000-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A5DA4CB05
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 19:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E79163A924E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 18:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA7D1F4C83;
	Mon,  3 Mar 2025 18:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iDzdYh4z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED23C1D89E3;
	Mon,  3 Mar 2025 18:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741026794; cv=fail; b=jsf7tvwbfTrcHfPIo8ehY1JiojHBWwPwc1/n2xirDPcSy0fj4T/5ML2DLglRFh0qx9qHrWWVr2jEXWSi5PeZP0ckaAq/plNwfwYms9xnToLc1ORBzXeQBtIAfd92tI5WlS24eN3nOfJFBOwePyNb6izXhFfo9KZrheyNBN94Rf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741026794; c=relaxed/simple;
	bh=yJU+MJWqNGMGOLfY0K5Qt9r6Md7AmcMqxooB53YonLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lVSgqd41dQ2XZMmcRnF4YvQXJkNykxqksF6X3Zg+nsxOD6LN2yl+KYdorBLRvuM1sekwTsDzPQAmv4ctLvU9DpPvhMqSKg5Zporzr2PlJ/X5eNjNGl0OdvuOVU5ZxBOSyIgF9k/BujxpKtyzjBH+UCPcI++ZyXLcDwGejMTzEKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iDzdYh4z; arc=fail smtp.client-ip=40.107.220.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N1JoEXF0LD2uBxaLDQdfR67fb5nvdkytyyZnQDjabq8QYEUW+lKwYI8DfTYA6zPm0oqVSpAe9TU+EIxyELDg29J2nItzRSiKEwO0wNshaIKdW4n1FW5b3k8s9JDRxOrJhZBp/wUDoICJ5cAZzfZtUq37lbHgqlqL4hfRPyqWGgP1GBSx9LCKQe4LNC+XsC1NXykcBPpOIKZ+pKUENFUNgbPsj+v8W1D63pJoixI2ljrqkVkTipXgjZ7uIKwPCd2Lzu5GRI5Yd2bZWWybeLc04rgDY+E/p3c20UDp6hHSBqzhfKWp0XVQlqGXK3YIog/0NFLLw+xQx03rj3JEyke7qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GbSgRwUvpgqgUshGRW84OiBe3GgtJLryHN+biZwgZCQ=;
 b=tSu0V3gWmGHWZMO/N7GLGvNBP15XwLVc5igfwuQhiGQVPsw4hMyDPFweM4GJyVB/euqGgmra8W8bnX58EyEiR3lyEQv5AVhiL8PEVnFPhtrrRx6gu26Z7+THkduGUrXXYJUuEzGxFCr71343puvb/NxJZIc5iB8z/4DGtoFG5CHP1BVBJwxNAt3SVUCvbrKOdodVF5evLYyBXsnY3cET+MrXZbmilX0Uwko2WJClCX5qBB5nr8fa2PGpYFK0svqE5IPhQ0mBo5cIWNtaxsJpSXqDKQW8hvuK4B0+VtFMNUYGeyHvZzeZkyLY83ud8RRoWa5M1/djmfAZK/g+IElgoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GbSgRwUvpgqgUshGRW84OiBe3GgtJLryHN+biZwgZCQ=;
 b=iDzdYh4zhNe4Y1LPiD7eiyGG9BAkvpzwh7EH7tlVmaIfON3snsMtNTqwLX3BRadO+YiZt0h+PAuQNPIm2HSo2RemTu5LE/cVjv/uORvSDibw3fcPYHj1aqKGMGoVq/cuI1Bt/Whwu2rwasp5gYuNHYvct6yvuhmjNAgOgR1a+e0=
Received: from BY3PR03CA0014.namprd03.prod.outlook.com (2603:10b6:a03:39a::19)
 by DM4PR12MB6494.namprd12.prod.outlook.com (2603:10b6:8:ba::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 18:33:08 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:a03:39a:cafe::e8) by BY3PR03CA0014.outlook.office365.com
 (2603:10b6:a03:39a::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.23 via Frontend Transport; Mon,
 3 Mar 2025 18:33:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Mon, 3 Mar 2025 18:33:07 +0000
Received: from [10.252.205.52] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 3 Mar
 2025 12:33:02 -0600
Message-ID: <da2b1976-b392-4b3e-973b-3029a1ca1d72@amd.com>
Date: Tue, 4 Mar 2025 00:02:59 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still
 full
To: Mateusz Guzik <mjguzik@gmail.com>
CC: "Sapkal, Swapnil" <swapnil.sapkal@amd.com>, Oleg Nesterov
	<oleg@redhat.com>, Manfred Spraul <manfred@colorfullife.com>, Linus Torvalds
	<torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>, WangYuli <wangyuli@uniontech.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Shenoy,
 Gautham Ranjal" <gautham.shenoy@amd.com>, <Neeraj.Upadhyay@amd.com>,
	<Ananth.narayan@amd.com>
References: <qsehsgqnti4csvsg2xrrsof4qm4smhdhv6s4v4twspf76bp3jo@2mpz5xtqhmgt>
 <c63cc8e8-424f-43e2-834f-fc449b24787e@amd.com>
 <20250227211229.GD25639@redhat.com>
 <06ae9c0e-ba5c-4f25-a9b9-a34f3290f3fe@amd.com>
 <20250228143049.GA17761@redhat.com> <20250228163347.GB17761@redhat.com>
 <03a1f4af-47e0-459d-b2bf-9f65536fc2ab@amd.com>
 <CAGudoHHA7uAVUmBWMy4L50DXb4uhi72iU+nHad=Soy17Xvf8yw@mail.gmail.com>
 <CAGudoHE_M2MUOpqhYXHtGvvWAL4Z7=u36dcs0jh3PxCDwqMf+w@mail.gmail.com>
 <741fe214-d534-4484-9cf3-122aabe6281e@amd.com>
 <3jnnhipk2at3f7r23qb7fvznqg6dqw4rfrhajc7h6j2nu7twi2@wc3g5sdlfewt>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <3jnnhipk2at3f7r23qb7fvznqg6dqw4rfrhajc7h6j2nu7twi2@wc3g5sdlfewt>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|DM4PR12MB6494:EE_
X-MS-Office365-Filtering-Correlation-Id: 8701b36e-1d9b-40a0-6d29-08dd5a81d81d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SlJ1c1FNcTB5QXNhNzhCY05xS2VKM3p4ZmdyZERSQjNuOEsrcVpKWEtNSWgw?=
 =?utf-8?B?NWVzOEw2d2xzTk9YWUh2OVNOUk9jTmxBcjZrdDJjQy8vSDE0N09jMGZRSmFH?=
 =?utf-8?B?R0dqbzA5WkV4MWNQSHUrUWoyN0FINUZPWUNlbUdhbCtiamlqcHlneW9VTXNX?=
 =?utf-8?B?MkNaaHNhZ2pVS3JYYW52OEZjNWVBMnJYQ1NEY3NUcnlYVExNMXpCRTFNbm5r?=
 =?utf-8?B?UGgvZVV0cWw5UzBCQTJNL3BST241V253MWtGY0hDQ0JDZ0xMdTJMUDZnUWNR?=
 =?utf-8?B?cnVvVjJwbS90VE84bkpBS2ZoazBFZDlqUnZRYW1VVGVycG9NOHAwSnNwMnRU?=
 =?utf-8?B?YlZ2Vng3M3l4WVBwek5BenhYay9lZU12a3IyN1g1a2E0bWpoaEw0L1A4TlFI?=
 =?utf-8?B?RkJEUkY0dW5QRkw1TW96c1YxdlM3dGdldFF4UkpSbStmVUlVUXo5S3FHWWFH?=
 =?utf-8?B?MGFkM3c1NUdySm5XQTN0TEdRSmVQRVREL0ZXTVlRUTV1aXE5UFUwOTVBenAv?=
 =?utf-8?B?cnBxWmQ2YnFMOHJqZFA1bEZQZ0xqSENqbytFVkUvMTJMZlhTbXcydGM1akJZ?=
 =?utf-8?B?VjJOZFA1NDBoYkhQQXhLU3F5ZG5UNHlCT2R2azVFKzhteFNzdDVFT01hUHVy?=
 =?utf-8?B?U3JRN2s3RGVhVEdyYUlQbVFhS3NQUFo4M29zL2JMZ214bUVYT0MwMFQyS25z?=
 =?utf-8?B?aG82WXRrWVUxQnMxSkh5YUx6OTJ4V3pFTHNIVWFUU2MvUEFaSlZteGRPR1pn?=
 =?utf-8?B?Zys3elRoVlk4ZlpGQVZSS0NmRHRGQWtRZG9zR1lnOTJ0d1NiNXc3SU5iS0o3?=
 =?utf-8?B?Vy9pSG56SVR4SW9QeHpqekJSc3FKQmRGbytqdFBMRFkwc0hsVktuUndtM04w?=
 =?utf-8?B?RmQveDBmTzV6bXlaY00rcXYza3pyQmcvZHJBNnN0bnNpWXpFZDl5UEFxRVpl?=
 =?utf-8?B?VVNnOG0vajZqOVUvbXFMakNoVkNIaDgrTEgxcUZuLzROMHRzdDVzQmxLSThv?=
 =?utf-8?B?ZW1DNHg2ZFhIbkNKZDBzMnRvbnRCa2tBOFJYc3UrUG1VWVRvMnViaU9JaFJY?=
 =?utf-8?B?VjR6bWVSam1PYWN0aWlZWUFaRXNNNTBjN3JnL0VZcXlpMVVEdXJrY2VTa29L?=
 =?utf-8?B?N0c3RER4bS9GQzQwQTFZYmlWejdna0IreE8xN3JodDBLZ0lhOUpFb05BQm9D?=
 =?utf-8?B?UVdEQy95MjZmcmxtWVBLZHYyZHc3YWpEM0NLZ3FhQ0xhVWVvQ0QvOUord24z?=
 =?utf-8?B?NnJnQkk3cm5NWWV5TTFzYm8rcG9tMVpMNUgrNFlkNEJOdUpmRGJTZjJvYjht?=
 =?utf-8?B?QVRka0QyUzVscUdNYzNFWkJTZzFFTWQ5VnRrSkVOVEc1TU0za1dYd3krOEtE?=
 =?utf-8?B?eC9zYlZCbVlVUUJkYWhFZnFrcHhwQXBjaWlOdzY0dU11cFhmTnV4VUZrSTBv?=
 =?utf-8?B?VTM5NGZJWnk5V0xJTHJ6NmRrZzRkdElWSEl2SXhZMmNhMlRSRkF6QWEzdjZX?=
 =?utf-8?B?WTUzL0JqTHFEdy9OMmRIYUp4cDVGUmpNaklzMjJQOTZ0cTRvQ2tEdk1xNDN1?=
 =?utf-8?B?TVlyRWJ6bWlFK0tiUk5jNnBZM2VySWNwSHVueldnNDg1RlVDckdxRDVIdStF?=
 =?utf-8?B?NjBHcWozMlhza3gyOWR6S2M1OEVJbWRiL3VNL0pISW5XbDA2djBxbk1nM1pz?=
 =?utf-8?B?REZpZU0weUUzZGQ2Qkw3Wit4cW5BZ0pKeFdJNHNzTGNQUGRKYktzOGk3Smta?=
 =?utf-8?B?d09pMjVHYVVTa3hORDlQTzMyNWhMUHdadno2UFB6TlhSMUJjQjdIODJDb1gw?=
 =?utf-8?B?NzBDMUtkQm9wTkwyS2VKY1hiM0x3aUYyVVhhdTBHK2RCT2Fyem5FajVPdDRZ?=
 =?utf-8?B?K2h3QjJpWU13Z3BDb3Vxc3VIQzhXL2t5NFpXaXNOOEpPQXhzNHRvcG9nYVIw?=
 =?utf-8?B?dWtqemVrZXhKd1pYWHpvTUpCeW16VHhRUEZwSVVtUEpTeitUU0VmUGJEdHpI?=
 =?utf-8?Q?sOZYNfx8xvPwJ4e2dVUcQLmLEnHGks=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(7053199007)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 18:33:07.8004
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8701b36e-1d9b-40a0-6d29-08dd5a81d81d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6494

Hello Mateusz,

On 3/3/2025 11:24 PM, Mateusz Guzik wrote:
> Can you guys try out the patch below?
> 
> It changes things up so that there is no need to read 2 different vars.
> 
> It is not the final version and I don't claim to be able to fully
> justify the thing at the moment either, but I would like to know if it
> fixes the problem.

Happy to help! We've queued the below patch for an overnight run, will
report back once it is done.

Full disclaimer: We're testing on top of commit aaec5a95d596
("pipe_read: don't wake up the writer if the pipe is still full") where the
issue is more reproducible. I've replaced the VFS_BUG_ON() with a plain
BUG_ON() based on [1] since v6.14-rc1 did not include the CONFIG_DEBUG_VFS
bits. Hope that is alright.

[1] https://lore.kernel.org/lkml/20250209185523.745956-2-mjguzik@gmail.com/

/off to get some shut eyes/

-- 
Thanks and Regards,
Prateek

> 
> If you don't have time that's fine, this is a quick jab. While I can't
> reproduce the bug myself even after inserting a delay by hand with
> msleep between the loads, I verified it does not outright break either.
> :P
> 
> diff --git a/fs/pipe.c b/fs/pipe.c
> index 19a7948ab234..e61ad589fc2c 100644
> --- a/fs/pipe.c
> +++ b/fs/pipe.c
> @@ -210,11 +210,21 @@ static const struct pipe_buf_operations anon_pipe_buf_ops = {
>   /* Done while waiting without holding the pipe lock - thus the READ_ONCE() */
>   static inline bool pipe_readable(const struct pipe_inode_info *pipe)
>   {
> -	unsigned int head = READ_ONCE(pipe->head);
> -	unsigned int tail = READ_ONCE(pipe->tail);
> -	unsigned int writers = READ_ONCE(pipe->writers);
> +	return !READ_ONCE(pipe->isempty) || !READ_ONCE(pipe->writers);
> +}
> +
> +static inline void pipe_recalc_state(struct pipe_inode_info *pipe)
> +{
> +	pipe->isempty = pipe_empty(pipe->head, pipe->tail);
> +	pipe->isfull = pipe_full(pipe->head, pipe->tail, pipe->max_usage);
> +	VFS_BUG_ON(pipe->isempty && pipe->isfull);
> +}
>   
> -	return !pipe_empty(head, tail) || !writers;
> +static inline void pipe_update_head(struct pipe_inode_info *pipe,
> +				    unsigned int head)
> +{
> +	pipe->head = ++head;
> +	pipe_recalc_state(pipe);
>   }
>   
>   static inline unsigned int pipe_update_tail(struct pipe_inode_info *pipe,
> @@ -244,6 +254,7 @@ static inline unsigned int pipe_update_tail(struct pipe_inode_info *pipe,
>   	 * without the spinlock - the mutex is enough.
>   	 */
>   	pipe->tail = ++tail;
> +	pipe_recalc_state(pipe);
>   	return tail;
>   }
>   
> @@ -403,12 +414,7 @@ static inline int is_packetized(struct file *file)
>   /* Done while waiting without holding the pipe lock - thus the READ_ONCE() */
>   static inline bool pipe_writable(const struct pipe_inode_info *pipe)
>   {
> -	unsigned int head = READ_ONCE(pipe->head);
> -	unsigned int tail = READ_ONCE(pipe->tail);
> -	unsigned int max_usage = READ_ONCE(pipe->max_usage);
> -
> -	return !pipe_full(head, tail, max_usage) ||
> -		!READ_ONCE(pipe->readers);
> +	return !READ_ONCE(pipe->isfull) || !READ_ONCE(pipe->readers);
>   }
>   
>   static ssize_t
> @@ -512,7 +518,7 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *from)
>   				break;
>   			}
>   
> -			pipe->head = head + 1;
> +			pipe_update_head(pipe, head);
>   			pipe->tmp_page = NULL;
>   			/* Insert it into the buffer array */
>   			buf = &pipe->bufs[head & mask];
> @@ -529,10 +535,9 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *from)
>   
>   			if (!iov_iter_count(from))
>   				break;
> -		}
>   
> -		if (!pipe_full(head, pipe->tail, pipe->max_usage))
>   			continue;
> +		}
>   
>   		/* Wait for buffer space to become available. */
>   		if ((filp->f_flags & O_NONBLOCK) ||
> diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
> index 8ff23bf5a819..d4b7539399b5 100644
> --- a/include/linux/pipe_fs_i.h
> +++ b/include/linux/pipe_fs_i.h
> @@ -69,6 +69,8 @@ struct pipe_inode_info {
>   	unsigned int r_counter;
>   	unsigned int w_counter;
>   	bool poll_usage;
> +	bool isempty;
> +	bool isfull;
>   #ifdef CONFIG_WATCH_QUEUE
>   	bool note_loss;
>   #endif



