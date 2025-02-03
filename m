Return-Path: <linux-fsdevel+bounces-40577-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E37A25576
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 10:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 883DE1883B0A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 09:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7DC1FF7BE;
	Mon,  3 Feb 2025 09:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xthkJw7c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3631FFC51;
	Mon,  3 Feb 2025 09:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738573674; cv=fail; b=RkJqHVCe/gBs9KAHJfV1xiWcWgoBnbEFU0CeoyZgVXPv4kNNJesrX7MqjmTVsdW0XxqSKIBchox/TlnzulXmTiDaiIBg3Xx+IOeAHVtHF3pOxFR+lFrBG17t4bxvkIvGbjzU8gWmJAc67QDbATYTk2kDcx+5ykVYytIyJFNring=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738573674; c=relaxed/simple;
	bh=0AAnxyGocOcbkrHw3SErWIvm9ueHXzi1yWfI49h8aSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=D6yhjCzNrpWXr/X/WpX4JtsAb9Ag62AZTW7vdKt1szl9E0IneFkoCFHP0M26W/NY+COmVm/3gxtLBKkuPYoDAPNiHSBI2efOuRNASy7GSBnokjuJKGDZSqijw0L0tYmJSk7UHInhwz1MOFhrPWyfGPiPayOZmKfG5p8m2HHYWUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xthkJw7c; arc=fail smtp.client-ip=40.107.94.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xu3HQZgC9e+O/rDztjMFgsU7YbnuIJQrYks3B20shntlY95mESz2q3yfHuleNUuB0KLbqQcrooYnFBmdHvBd/tcB8OgkXVwOlaRsO0Ho7E/rEsJcNKminDb6MIwMpSGFeCJHqodO47Lpr7ab1T4wK2uJwgq1oK7TVQqLfWd/F0nRIyu/QChfzxFfhQmAFJsX1l2kLDgbQQWp11WcwekJzm0jkuSHGCC/EEGMUETGLSRPrdmKD4Zqx3mX+CImeYTxhEZuPEVJLn/3UM3OqfUy6UByzhV9BA77EBnNB1iC6ODENxF0H4Tn4NPES+GTCng8NTFSEsrXuFYu9J/AUYg+sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z3AvA3qdT2XglCVAAU1mSstoLaxX3mMxyLRgUW7He10=;
 b=DTRXjx85PAPt1re5NXqhkHcNOwp2kJC2OItF9NF2Enj05QD+cVBTV0oM2jDg6tSlEXAvVufLZ2+fQrq7ZcbQ1knGhcLphvGtUHqRpo2CEsAX/D8YNB6KYUe79ISFX1QMN7hnKCsUFSKMqerX10jF5f+FCHZuy8+8Dxm5TKT0eVvyu8JdX1G/iX1PivlDBO5RkVp2oycFk7sVlKZDHoZZ5ekSWBzbQ5Z7AG8UEuQCk5aaaP8hr23VRPN7XbVVpu1dRKd2oFf/ixxmrWpEqrS9r9kRNkOTk8jgFqbqbdlx/1JkfmxaHyREx/oI47Xa4laBOi/G4mT32ArNgTeJbMOktw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z3AvA3qdT2XglCVAAU1mSstoLaxX3mMxyLRgUW7He10=;
 b=xthkJw7cBaYpiMvC1/U8hkLoa9X+RX2tLPc8Ck2b0BAE/W9owEuRuUzXxWpehoHv0/dHkcQWF4hPx/EdxllET5Wak9KR+92E8F8EJqODsjGvvRXGSlS7A4kuKFpITMmLC0giO1z7xExzJrywN0qsdikeNaeM1NmwOBfB6Uu8SrY=
Received: from BN8PR07CA0021.namprd07.prod.outlook.com (2603:10b6:408:ac::34)
 by DS0PR12MB8272.namprd12.prod.outlook.com (2603:10b6:8:fc::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.25; Mon, 3 Feb 2025 09:07:47 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:408:ac:cafe::56) by BN8PR07CA0021.outlook.office365.com
 (2603:10b6:408:ac::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.21 via Frontend Transport; Mon,
 3 Feb 2025 09:07:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Mon, 3 Feb 2025 09:07:47 +0000
Received: from [10.136.39.79] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 3 Feb
 2025 03:05:26 -0600
Message-ID: <7ace642f-e269-49ad-9d32-53c7ffa00681@amd.com>
Date: Mon, 3 Feb 2025 14:35:11 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still
 full
To: Oleg Nesterov <oleg@redhat.com>, Linus Torvalds
	<torvalds@linux-foundation.org>
CC: Manfred Spraul <manfred@colorfullife.com>, Christian Brauner
	<brauner@kernel.org>, David Howells <dhowells@redhat.com>, WangYuli
	<wangyuli@uniontech.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>, Neeraj Upadhyay
	<Neeraj.Upadhyay@amd.com>
References: <20250102140715.GA7091@redhat.com>
 <3170d16e-eb67-4db8-a327-eb8188397fdb@amd.com>
 <CAHk-=wioaHG2P0KH=1zP0Zy=CcQb_JxZrksSS2+-FwcptHtntw@mail.gmail.com>
 <20250202170131.GA6507@redhat.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250202170131.GA6507@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|DS0PR12MB8272:EE_
X-MS-Office365-Filtering-Correlation-Id: dae6c56e-67ad-4a50-849b-08dd44323a93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M2Y5amVyUVh6azZrRDF0dGRVMGVreEZBTW5aWTZqSllMdFY5OUM5NXU1Sitz?=
 =?utf-8?B?Z0FzSE12amZsNWNETGJFcHR3dlArV2dXeUNqdURMTFJ3c01nZExuanBLYjVo?=
 =?utf-8?B?R01ZMzYzanNYZE9FY3d5NUJMTFBSZFlab1IvWk5XaUo4UEVLaTdEQ3hDYUVK?=
 =?utf-8?B?TGpRTnlxb0wvVHJtSFArYVhGdUN3aFRpSG55enZzMWNUeFBuaEdUeVh6UW5R?=
 =?utf-8?B?ZXBhOHdZWEtxWDlVSUloRk1CL0Zmb0FtZFBkeU5wejZSaUVYcHJrbzloNFda?=
 =?utf-8?B?RXFCalE1azdCUFRUZG5SbHY1WjROSWE0cmpnd0tuRXhFT2dyQVp6Vng2TUk4?=
 =?utf-8?B?YmZ0ekduYlVEOW9XdVU3eStnQWR0RU9vYld0aUdPcFBNd05lSTR6cXRCSkVs?=
 =?utf-8?B?ejFhWlJsSmZGZk1kbSswdVhGbUt3aS9wdW52TE1KdzU4eU5PL2pndVVLanla?=
 =?utf-8?B?dGk2VlAxdEh0SzVOS1luVWZ3eFd4VUVyOHZoanlPTEQ5Z0NCSjNhYStid2xx?=
 =?utf-8?B?elJSaW9XeHFZT3hsQm5WenlhZDRYUzdlVHYxc1BETFlBNy9HS2lNRUQxRzlM?=
 =?utf-8?B?eTFOa0lNWEhEaXRuZEgwWTBJWno2THorelNnTU5LREE2cHlWVTh3WGc1czlQ?=
 =?utf-8?B?TEdYTzlkQTIxS3BqR1J6cUQyYUdkQ2hvVFdHb0FmRGNoWnB4L0kwTTdmL3hq?=
 =?utf-8?B?UVg0bjhEWjJFbmVsMXZ0L0paVVVSaGpMeXM1b090aXVXMFZHQ1YxWGxnalBO?=
 =?utf-8?B?UFVtZ2pNOWFBQmlGcS9hSVcwQm05bkhoN3NZV2hHU2R5Q0xma2ZsM3Q4VnJW?=
 =?utf-8?B?MFJtcnpia3RBWnV3VnhZM2U2NmpnSERuL1JwejJubXJkamtWejN6K3dBc1Fx?=
 =?utf-8?B?YWxZNjlPWE1uMVJSdGpPRHFOZlphMjBaTmc5dFkwei9uam4xVXh4eWQ2TTND?=
 =?utf-8?B?dnJaMndaWUZNaUlLU0Q3RmZvQ1ZWNThLSzJndGU4Uk5lUy92dHJVTzYvWGg2?=
 =?utf-8?B?b0VQMXVpekJGTXhhbm90RXpEVTQrUlFLeDIvWWd4WjRMQnhBRmFCUEZraGd4?=
 =?utf-8?B?M2xud0Q5cGFVZWhDMEdtaXV6ZkVhYW81bjZqa1AwOHlMdEJnZnlJRlYyaDNi?=
 =?utf-8?B?S3k1UXdkZXF3eVo5a0EzelJSc0x4eUxRa1NnMnFLbnd4N0g0QUZ4THdlNFV4?=
 =?utf-8?B?bHpsdzBTKzNybk5GSzdIbTBYRzQ0b2ZrK0t4c0xMMEtuSXZ5TElPK3Q5MFg1?=
 =?utf-8?B?eGwvRzAwZ05WTjZUM2NQZ2NKU0F6bXFlS25HT3IxV3NNWEt2Um5UWUY5VnV4?=
 =?utf-8?B?OE5XYytsaXNEQjdQQ25SZGFJQkV4V0tiTDBvN25TZFRSZ1V2VmZ5MGl5cjIr?=
 =?utf-8?B?V0ZNZER2WThlVnVkWTQ5cXlqSDBrZkgwZ0lhZkQ4SjI1bmRRbFhYZWlaUUMv?=
 =?utf-8?B?enBicmZBMlVzSnBWdFpJelMvWEkzRjNvZ3R2UmpiRklUWnV1dTJqdVp2cUEz?=
 =?utf-8?B?MStxbjhocjl4b2xGQWRxYXAreTM1a1IvMzlLYVMwcERDZ0xhY1hpMkJNbEt1?=
 =?utf-8?B?QUpEK1J5QW05L1JOOXNpVEMwdG5mTUV6YmJHL05VaXBPVkVNMVNFNzdGMS8z?=
 =?utf-8?B?c2xLMEREOTJQcFlOdFpkOElEZU9BK0MrajE1emVFYjl4M2M1QkVpMDVrYk56?=
 =?utf-8?B?TGprYXh3OEloTjNsSThOQTJMUWFoMEluVVNLWGxJc0VPaXlvTkJrV3RhMkhp?=
 =?utf-8?B?ekhQTTZDRVNVclVqU25lMXJPQXdkWERHWGJMcStRUU5GRHpISzZRVFltWkVp?=
 =?utf-8?B?Yk9ZUEtzTzlFUG5ycVhFelhFODZmRGROZzdQR0N1aVBmSDB1eWNzaS9Ddlpa?=
 =?utf-8?B?ZjJCeW84aTlqSTVUcTJyVGVsZUFDWFFyUTkyQk9RYTVRdmhHOFI2UGgwNXNS?=
 =?utf-8?B?cGZqb2J0TDh4SXl3eUoybjBCNkQraHhWQnAxZ2dLeHMwVU8vMjJhbld0QTZm?=
 =?utf-8?Q?WgfUgDVddr2yDTfBc4o/cyTPTnXi44=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 09:07:47.7653
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dae6c56e-67ad-4a50-849b-08dd44323a93
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8272

Hello Oleg,

Thank you for pointing me to the regression reports and the relevant
upstream discussions on the parallel thread.

On 2/2/2025 10:31 PM, Oleg Nesterov wrote:
> On 01/31, Linus Torvalds wrote:
>>
>> On Fri, 31 Jan 2025 at 01:50, K Prateek Nayak <kprateek.nayak@amd.com> wrote:
>>>
>>> On my 3rd Generation EPYC system (2 x 64C/128T), I see that on reverting
>>> the changes on the above mentioned commit, sched-messaging sees a
>>> regression up until the 8 group case which contains 320 tasks, however
>>> with 16 groups (640 tasks), the revert helps with performance.
>>
>> I suspect that the extra wakeups just end up perturbing timing, and
>> then you just randomly get better performance on that particular
>> test-case and machine.
>>
>> I'm not sure this is worth worrying about, unless there's a real load
>> somewhere that shows this regression.
> 
> Well yes, but the problem is that people seem to believe that hackbench
> is the "real" workload, even in the "overloaded" case...
> 
> And if we do care about performance... Could you look at the trivial patch
> at the end? I don't think {a,c,m}time make any sense in the !fifo case, but
> as you explained before they are visible to fstat() so we probably shouldn't
> remove file_accessed/file_update_time unconditionally.
> 
> This patch does help if I change hackbench to uses pipe2(O_NOATIME) instead
> of pipe(). And in fact it helps even in the simplest case:
> 
> 	static char buf[17 * 4096];
> 
> 	static struct timeval TW, TR;
> 
> 	int wr(int fd, int size)
> 	{
> 		int c, r;
> 		struct timeval t0, t1;
> 
> 		gettimeofday(&t0, NULL);
> 		for (c = 0; (r = write(fd, buf, size)) > 0; c += r);
> 		gettimeofday(&t1, NULL);
> 		timeradd(&TW, &t1, &TW);
> 		timersub(&TW, &t0, &TW);
> 
> 		return c;
> 	}
> 
> 	int rd(int fd, int size)
> 	{
> 		int c, r;
> 		struct timeval t0, t1;
> 
> 		gettimeofday(&t0, NULL);
> 		for (c = 0; (r = read(fd, buf, size)) > 0; c += r);
> 		gettimeofday(&t1, NULL);
> 		timeradd(&TR, &t1, &TR);
> 		timersub(&TR, &t0, &TR);
> 
> 		return c;
> 	}
> 
> 	int main(int argc, const char *argv[])
> 	{
> 		int fd[2], nb = 1, noat, loop, size;
> 
> 		assert(argc == 4);
> 		noat = atoi(argv[1]) ? O_NOATIME : 0;
> 		loop = atoi(argv[2]);
> 		size = atoi(argv[3]);
> 
> 		assert(pipe2(fd, noat) == 0);
> 		assert(ioctl(fd[0], FIONBIO, &nb) == 0);
> 		assert(ioctl(fd[1], FIONBIO, &nb) == 0);
> 
> 		assert(size <= sizeof(buf));
> 		while (loop--)
> 			assert(wr(fd[1], size) == rd(fd[0], size));
> 
> 		printf("TW = %lu.%03lu\n", TW.tv_sec, TW.tv_usec/1000);
> 		printf("TR = %lu.%03lu\n", TR.tv_sec, TR.tv_usec/1000);
> 
> 		return 0;
> 	}
> 
> 
> Now,
> 
> 	/# for i in 1 2 3; do /host/tmp/test 0 10000 100; done
> 	TW = 7.692
> 	TR = 5.704
> 	TW = 7.930
> 	TR = 5.858
> 	TW = 7.685
> 	TR = 5.697
> 	/#
> 	/# for i in 1 2 3; do /host/tmp/test 1 10000 100; done
> 	TW = 6.432
> 	TR = 4.533
> 	TW = 6.612
> 	TR = 4.638
> 	TW = 6.409
> 	TR = 4.523
> 
> Oleg.
> ---
> 

With the below patch on mainline, I see more improvements for a
modified version of sched-messaging (sched-messaging is same as
hackbench as you noted on the parallel thread) that uses
pipe2(O_NOATIME)

The original regression is still noticeable despite the improvements
but if folks believe this is a corner case with the original changes
exhibited by sched-messaging, I'll just continue further testing with
the new baseline.

That said, following are the results for the below patch:

    ==================================================================
     Test          : sched-messaging
     cmdline       : perf bench sched messaging -p -t -l 100000 -g <groups>
     Units         : Normalized time in seconds
     Interpretation: Lower is better
     Statistic     : AMean
     ==================================================================
     Case:         mainline[pct imp](CV)    patched[pct imp](CV)
      1-groups     1.00 [ -0.00](12.29)     0.94 [  6.76]( 12.59)
      2-groups     1.00 [ -0.00]( 3.64)     0.95 [  5.16](  5.99)
      4-groups     1.00 [ -0.00]( 3.33)     0.99 [  1.03](  1.89)
      8-groups     1.00 [ -0.00]( 2.90)     1.00 [  0.16](  1.23)
     16-groups     1.00 [ -0.00]( 1.46)     0.98 [  2.01](  0.98)

Please feel free to add:

Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>

I'll give your generalized optimization a spin too when it comes out.
Meanwhile, I'll go run a bunch of benchmarks to see if the original
change has affected any other workload in my test bed.

Thank you for looking into this.

-- 
Thanks and Regards,
Prateek

> diff --git a/fs/pipe.c b/fs/pipe.c
> index a3f5fd7256e9..14b2c0f8b616 100644
> --- a/fs/pipe.c
> +++ b/fs/pipe.c
> @@ -1122,6 +1122,9 @@ int create_pipe_files(struct file **res, int flags)
>   		}
>   	}
>   
> +	if (flags & O_NOATIME)
> +		inode->i_flags |= S_NOCMTIME;
> +
>   	f = alloc_file_pseudo(inode, pipe_mnt, "",
>   				O_WRONLY | (flags & (O_NONBLOCK | O_DIRECT)),
>   				&pipefifo_fops);
> @@ -1134,7 +1137,7 @@ int create_pipe_files(struct file **res, int flags)
>   	f->private_data = inode->i_pipe;
>   	f->f_pipe = 0;
>   
> -	res[0] = alloc_file_clone(f, O_RDONLY | (flags & O_NONBLOCK),
> +	res[0] = alloc_file_clone(f, O_RDONLY | (flags & (O_NONBLOCK | O_NOATIME)),
>   				  &pipefifo_fops);
>   	if (IS_ERR(res[0])) {
>   		put_pipe_info(inode, inode->i_pipe);
> @@ -1154,7 +1157,7 @@ static int __do_pipe_flags(int *fd, struct file **files, int flags)
>   	int error;
>   	int fdw, fdr;
>   
> -	if (flags & ~(O_CLOEXEC | O_NONBLOCK | O_DIRECT | O_NOTIFICATION_PIPE))
> +	if (flags & ~(O_CLOEXEC | O_NONBLOCK | O_DIRECT | O_NOATIME | O_NOTIFICATION_PIPE))
>   		return -EINVAL;
>   
>   	error = create_pipe_files(files, flags);
> 



