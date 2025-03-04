Return-Path: <linux-fsdevel+bounces-43034-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 481DBA4D2FF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 06:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66DB1172A01
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 05:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1E71F4264;
	Tue,  4 Mar 2025 05:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="B6/bHiLd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4142905;
	Tue,  4 Mar 2025 05:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741066293; cv=fail; b=gzzCT/W3DfLDnGk4wQ4OQj7PnzQcSU0LeC4cSS0Kz/FBDxDOI/K4d7C5xzfaHUwZEOyM8fDYFvPvgIvIwTgbPOUOEOX1KDqjATnI/T/GXOWA5M1N94JPat5C9vw0Q96A2Y6H7QuU1ayOV+zabNdB9o/pOa9brdXMNlTRtk5O3rc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741066293; c=relaxed/simple;
	bh=t8g2h0nQr0Vp0/dDSTR1mNnvrWhCZJKM1EDlX2aBB7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sWbR4WjC82dwU/AVnMSSwRlXByB2rVohlpxj34HnWeb0Q5t+to2v/pHQhAJhgfDoZsI9RCFKasti23lg9zPfJmM2DFBLZ3DQxCrjkjZDjF5XE/PbQ29hLyYaS7CvbJHf9dulFpUPKzFNLW6jc6L7DHpSj2tEZjMTgXVg2Ug3p7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=B6/bHiLd; arc=fail smtp.client-ip=40.107.93.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t3+xaQLWg855TdrGX6eRc3vVaC3kjRqZYYVtYFqwDIRMSM6OdC2wfiZBm8IiLBw9hpvU+YjdYLZ38O8pV4y33x7UJ2D+U7pPQuuF0QVnI/CS7MKjtSoDTus9Htaa6HrgnkurvNXZMBQWwQpRrPu5ypqYZwfirv3cMwvgI4Rt+OVgvUOtn4N2Uyo1NYQnlWuHmMOKYqRWUtC6g7TkIQP/yKXuL6gVVFqSm87MQ/z0y1dSeq/4qZnViMZqNMkK6fehKygnz6rLtxSIKDgcU8Xbb9FB2a+wGsc/mLwVG72/s/iGp85BAb3U9SETzFCOfUr4A1nWf0MbHeTWVgzhhNw3LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tI/n8dS5Meg4FNcUPzX1uWdubv5fzZcbWWi72f+C23Y=;
 b=i4haWMmBw43K6nhkQu1tVaGc/H1iddJvZtoWn1EMCWdHX6+1EEIgHxzKQL0oPqI7775Zh4V9+iOkHDjTSnNMYp6o0v7+b1YSNUTmRAMKx4NM4DCkr59QhiU2XW3GylYuqAjV80Q/dbjnAarF0e7NDsB84RgpOrBtG/LyCP1tFKDE/bN8K9NrTr8t5HcDMxqAzFxvEdY5INpnpsFfZv3e9I4fIg2rj/sCohuP04ZUgb0ufV4Rz0O+n53rv5mgATfmve++IAsULIMSGG1w0HHBNxDKfA5pYE6jKAAW3mVkkfT8AuprFSy7b3hWaj94GqUvt6hbGuTc+J0IpnJhUnuGrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tI/n8dS5Meg4FNcUPzX1uWdubv5fzZcbWWi72f+C23Y=;
 b=B6/bHiLdxDY5l/q39dJt6USBxehkS7nqaXjaykSblHEvT6bBavyGy/uifjAsoi4V0xgUF7AqQ08G32sUAolyB8m62OyRXwsYw3YV9qWujD/vzzt3nSW7kn6AwU/gOp4Bp00liq1AEtu61lcGXcD6HlvN157oPuGHwoCLEhwPpOY=
Received: from BYAPR21CA0029.namprd21.prod.outlook.com (2603:10b6:a03:114::39)
 by PH0PR12MB7885.namprd12.prod.outlook.com (2603:10b6:510:28f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Tue, 4 Mar
 2025 05:31:26 +0000
Received: from SJ1PEPF000026C5.namprd04.prod.outlook.com
 (2603:10b6:a03:114:cafe::2a) by BYAPR21CA0029.outlook.office365.com
 (2603:10b6:a03:114::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.8 via Frontend Transport; Tue, 4
 Mar 2025 05:31:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000026C5.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Tue, 4 Mar 2025 05:31:25 +0000
Received: from [10.136.44.144] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 3 Mar
 2025 23:31:09 -0600
Message-ID: <1a969884-8245-4bea-b4cc-d1727348bf50@amd.com>
Date: Tue, 4 Mar 2025 11:01:07 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still
 full
To: Linus Torvalds <torvalds@linux-foundation.org>, Oleg Nesterov
	<oleg@redhat.com>
CC: Mateusz Guzik <mjguzik@gmail.com>, "Sapkal, Swapnil"
	<swapnil.sapkal@amd.com>, Manfred Spraul <manfred@colorfullife.com>,
	Christian Brauner <brauner@kernel.org>, David Howells <dhowells@redhat.com>,
	WangYuli <wangyuli@uniontech.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, "Shenoy, Gautham Ranjal"
	<gautham.shenoy@amd.com>, <Neeraj.Upadhyay@amd.com>, <Ananth.narayan@amd.com>
References: <20250228143049.GA17761@redhat.com>
 <20250228163347.GB17761@redhat.com>
 <03a1f4af-47e0-459d-b2bf-9f65536fc2ab@amd.com>
 <CAGudoHHA7uAVUmBWMy4L50DXb4uhi72iU+nHad=Soy17Xvf8yw@mail.gmail.com>
 <CAGudoHE_M2MUOpqhYXHtGvvWAL4Z7=u36dcs0jh3PxCDwqMf+w@mail.gmail.com>
 <741fe214-d534-4484-9cf3-122aabe6281e@amd.com>
 <3jnnhipk2at3f7r23qb7fvznqg6dqw4rfrhajc7h6j2nu7twi2@wc3g5sdlfewt>
 <CAHk-=whuLzj37umjCN9CEgOrZkOL=bQPFWA36cpb24Mnm3mgBw@mail.gmail.com>
 <CAGudoHG2PuhHte91BqrnZi0VbhLBfZVsrFYmYDVrmx4gaLUX3A@mail.gmail.com>
 <CAHk-=whVfFhEq=Hw4boXXqpnKxPz96TguTU5OfnKtCXo0hWgVw@mail.gmail.com>
 <20250303202735.GD9870@redhat.com>
 <CAHk-=wiA-7pdaQm2nV0iv-fihyhWX-=KjZwQTHNKoDqid46F0w@mail.gmail.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <CAHk-=wiA-7pdaQm2nV0iv-fihyhWX-=KjZwQTHNKoDqid46F0w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C5:EE_|PH0PR12MB7885:EE_
X-MS-Office365-Filtering-Correlation-Id: 66b20459-02a1-4848-5217-08dd5addcee2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Zm9aZUFoRWFXZW5WKzRvKzlaNWYxRG5zRWpySitKdEw3bDZ5M0VvVTFvUmFN?=
 =?utf-8?B?M1hCQjhlM3pqTllQNE1YTlpyS2ZOWCtzc1NUZjAwVDAwRm8xNHoxd0MxK0xu?=
 =?utf-8?B?VnlBWmVYNis0UGJkU1dQNHdVWjltTnUrekJKV20xWTg2dHRoOHF5TS9lY1JE?=
 =?utf-8?B?cEQ5enFGMjdFVUZES0Q0dHZlRUZUWEwrMjBQVG9ZUXlnT1J3REhlb0pneE4v?=
 =?utf-8?B?QVdlZXpxRTVLdFNRMmVUMmZocGVVWm5yam9jTFJWdGZPSFZMSlNpTmNFUmx1?=
 =?utf-8?B?RmU2cTdxVDJYS0gyVURQT2tMZElMUkd1ZFV1ZlZ0eXBQSm1iNVRuTGgwR1hk?=
 =?utf-8?B?dDJ5emJiQ1psZXJCajN1YjNyV1owN3d3STVSZ1VhSGdsTlphTzk0RXgwZTVB?=
 =?utf-8?B?QVJwQ0xmcUpDTGV1bHNBRE9vRUtXd0ZqektLR3AyWFltdWpTVjVVL1JVRU8r?=
 =?utf-8?B?ZUNiNHNrMlhCVjB1RlBDUWVyVXNUNUFXMkZZWmVVa0tJTUpvUTFROCtQVjVw?=
 =?utf-8?B?TTA4NnVYQml5Wk5seUxxVmVhdzRiT0M5STVGdEppRXJ5cEVkTjNNREF0RlJn?=
 =?utf-8?B?MG5xQUd0UFR4bm1EV2E4ZTFhWnlPcEk1Mm5wKzVrb3daa0ZGQUlXTmxtRlQ5?=
 =?utf-8?B?endTR1cvblk1R0QzTlpmWGNyclYrUmo5WXcrUCs5ZlVzOUw2MWIweWZLM2RF?=
 =?utf-8?B?ZDI0K1B4R2RHNmsyRmM2RTE5MTMvb0wwVzRlQmRMU2tVNytveWhNU3BWNnBF?=
 =?utf-8?B?cG0vdlJRa3A2aWZ5b2pNbWxjdHlLTW0rQmZRRnk5b25YYVI0RWRhOWxTaVJk?=
 =?utf-8?B?bzh3a3R1VXBsNWt6WGtCdjltektMNG1iVk1hSkJqd2NvRGdMb1IybFNJZTcy?=
 =?utf-8?B?NTB6K2ZPREJ0OFJlZGxwcmR4RDZ4V1prY0VMN3dQQUxsaEFlUUJNRWo1MVpi?=
 =?utf-8?B?N1VBWXFQY0xUc3dKMHhSN0k1KzRDd0Q4cU1qTnp6d1o2TzJBYWRydHpLeWpH?=
 =?utf-8?B?eDJaV1hmb2lrbGFtdVlNR1pQNVFzYmZQMnkxbDY2L0UwOHJBNDlXYjUxR2ZO?=
 =?utf-8?B?YW9nTlA2aEZxd0tVUnlJcXl6a2dHQTQvOWVUNlRMS0ZYN1V2UkIvMHdLZDBZ?=
 =?utf-8?B?a1FlSXBQaUxMSWttL2k1dVprWjcxZjgzN3lmdk94MVNvSEhZRG5UbXNzSCsz?=
 =?utf-8?B?RmRxNjE2bFFWQlEzc0ZkYndhNWlOcGtDQzhja0ZrT1FkaWJweTdQSkx1Yndu?=
 =?utf-8?B?bFc5cjhhQ1lPQWVTTndiMkdnNHM3S1A0V25mTXJLd1hsQVhXcFRGZ2Fqckd3?=
 =?utf-8?B?ZENJSXVnM3VtR2kzYVZiZkRhOVhxUGRPWWdOaDJ2NjFDRlBuOTUxUjBERU93?=
 =?utf-8?B?eks5ZUd2NGU3YjcxT3hxNlZQV2Fta0dpOW9MNDB4L3h6cU15MVZ0TDhDSCtQ?=
 =?utf-8?B?QWRGQ1Blb2ZWNmxPNVNJQWh4eHl5NVA3cm8ybkZJK3pSODhFZVZxM1dWZHl2?=
 =?utf-8?B?T1hBWW54bkg3UjYwTTNsQXhCUjFmWmUwTTQ2bWxiQmNkQkowSTJpS2RYME9G?=
 =?utf-8?B?K3Y0eXpKZFUwRUFONnNsSnZ0bjZXblpnSnVUSFlhbDZwUWMwZUZ4V2lZTUJR?=
 =?utf-8?B?bDRCZW01RWF0OUlUOXcwdEN5OU1zWVhQVUNhL0gyeE85eWIxWGVQR05ic201?=
 =?utf-8?B?VUFzT3FHdDRKbzFxek03NXF5ZHU5eG9hbGowWjhDZkpOajYwR2R2SW1IQ3lG?=
 =?utf-8?B?ZzEvam9sQU9tYUVZMUI3NnRFMnQ1UHpKdkZHSUF3eGUrcHYwaHVKQWNYNm1S?=
 =?utf-8?B?WkVaUnFtUG5HUndxeXV0anlSbUVUU24vZVVhN2c3OVJ5aTZUK0xTalFuYi91?=
 =?utf-8?B?Y1lKTGttbjNCV2I5RHNyV2hubjZWVFdtUXlLTkdRSHBzbFZtZ1Y3dGtuazhj?=
 =?utf-8?B?NnNva2xhUnhUNVplRXR3c2FXVUcxWGhRcnk2WjhFbzFkejd6ZHJnckdRQlZG?=
 =?utf-8?Q?iGhOgzy6f3hETBhPnKvkY3aQbVbM3M=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 05:31:25.9970
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66b20459-02a1-4848-5217-08dd5addcee2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7885

Hello Linus,

On 3/4/2025 2:16 AM, Linus Torvalds wrote:
> On Mon, 3 Mar 2025 at 10:28, Oleg Nesterov <oleg@redhat.com> wrote:
>>
>> Stupid question... but do we really need to change the code which update
>> tail/head if we pack them into a single word?
> 
> No. It's only the READ_ONCE() parts that need changing.
> 
> See this suggested patch, which does something very similar to what
> you were thinking of.
> 
> ENTIRELY UNTESTED, but it seems to generate ok code. It might even
> generate better code than what we have now.

With the patch on top of commit aaec5a95d596 ("pipe_read: don't wake up
the writer if the pipe is still full"), we've not seen any hangs yet
with a few thousand iterations of short loops, and a few hundred
iterations of larger loop sizes with hackbench.

If you can provide you S-o-b, we can send out an official patch with a
commit log. We'll wait for Oleg's response in case he has any concerns.

> 
>                 Linus

-- 
Thanks and Regards,
Prateek


