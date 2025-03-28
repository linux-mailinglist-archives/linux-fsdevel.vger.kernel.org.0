Return-Path: <linux-fsdevel+bounces-45234-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C10A74FFF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 19:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A49923B93B3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 18:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F49B1E1E15;
	Fri, 28 Mar 2025 17:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Rb/ZVXgv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11hn2232.outbound.protection.outlook.com [52.100.173.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BEF1DED6C;
	Fri, 28 Mar 2025 17:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.100.173.232
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743184597; cv=fail; b=f+cofTg+mVyx34EJUzpkWN/KADu+KbMtpQ6ja3o1jnqbkwIqPN3CC6g8rA7b/1N82mbRAjBTe6FGe0RBezlzBZI1PrxRwySBWrUinJpugSuISq+3MkRWyG0VoJRH8VcGRfroTitW/p+xzVjrKnfC54qG3Cbm0y3CqSA6U0XBBmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743184597; c=relaxed/simple;
	bh=T3ASJ2H/SPRM7m/l81hloy8dXIwXWS6TpECHBIDl6DI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Nj+NO1fIl4iLSSKxWKBSBJSOjz/qlH18Dc+LL5LNfGI9eC4JRSJiYyHJemFC48gIcnox1r7giUI+DQRF2KGRxkR7l77g6xGfINE6FlM3az7sM7JfEHgaP9hXwdbUt30YGxo9cGiT3KHxKc1QVhJlBa1qnnz+C2hKG+Y7cvBt8fU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Rb/ZVXgv; arc=fail smtp.client-ip=52.100.173.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qQwqnveL39Ow8xCci+BhTHUntg86v43tydfRY+7aazuULCixZFtS/udqXlaw3uYGs7g5WO4xk30Asyz8w5Jk+95Jsfihu26kF6ScGqDRAviuOBzXbTtMvoX34fY3kWY9H/agKt7Biit4DJ10T4e1usHGi0yBY/wvp0oAddy8iRXDTcvq+L/th1eKBAHzMAHROnTvVqnbriL+UvACwo3RFPLFQG9bniVQoo7tOaJQpOHKX0bk9zCfMambEvjgjJ7DRz4M0ebl+9n7kqq0rNVFxT7/hcIpX1q5nTLpdlRoIRWPP/P1j1WN3D2cEqjKFMTQvLe6FalVb9FIt8Rc4kvggA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PZCPKaQ3i04mC2G9UITYCbKWY8r4PIwRcgJjzkU/eJc=;
 b=wNlvUYIN3AIAICoN1rnnx8w8fibR96Z7nuFB2PrtU5/U2RJsTcTCBmeIYY5wdmcDs/PnFAiq8eDWPNCCPs+rIGj4c8yxzjXNnRQlvCrcL57qVXLL2S4y+8KxjqU0/gzTG7eppUDsZferfQVRI8cULVSq6VxmONaEKFPOi8zjWNUoWZzLKvnY1UrE3hC5VG0+eD0mwW9Hjjp8C8WcA/eEqKOYSOf/KTyPcR750FmTo8ULEDMoYbH/ComXslcS2I4uqYVE+0mTGbT8oblhbSqMfaWXMLO2WCbDLkdyn364TGg5d1N00uyA/K2U3rlVL4blwquUUDOz5M8LNOPhXhN3/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PZCPKaQ3i04mC2G9UITYCbKWY8r4PIwRcgJjzkU/eJc=;
 b=Rb/ZVXgvYQPD1QfS38hwbEbjLF305EmHt/YVYpxOkDVp6BJdtn1cQea3mU5R1c6HRNMBH2peucRPhHnLdiBRe0+1bx+U3dyK/hgRmg/ulZQ0ezHCqsbgIC2r92lTARBOLUuSCCaI6XUV4XwCHBjUhcnNipMnW7x5iEO63sNxigY=
Received: from SJ0PR03CA0081.namprd03.prod.outlook.com (2603:10b6:a03:331::26)
 by SJ2PR12MB8807.namprd12.prod.outlook.com (2603:10b6:a03:4d0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 17:56:32 +0000
Received: from SJ5PEPF000001CF.namprd05.prod.outlook.com
 (2603:10b6:a03:331:cafe::58) by SJ0PR03CA0081.outlook.office365.com
 (2603:10b6:a03:331::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Fri,
 28 Mar 2025 17:56:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CF.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Fri, 28 Mar 2025 17:56:32 +0000
Received: from [10.252.205.52] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Mar
 2025 12:56:27 -0500
Message-ID: <314522ae-05a4-4dfb-af99-6bb3901a5522@amd.com>
Date: Fri, 28 Mar 2025 23:26:20 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [netfs?] INFO: task hung in netfs_unbuffered_write_iter
To: Oleg Nesterov <oleg@redhat.com>, syzbot
	<syzbot+62262fdc0e01d99573fc@syzkaller.appspotmail.com>
CC: <asmadeus@codewreck.org>, <brauner@kernel.org>, <dhowells@redhat.com>,
	<ericvh@kernel.org>, <jack@suse.cz>, <jlayton@kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux_oss@crudebyte.com>, <lucho@ionkov.net>, <mjguzik@gmail.com>,
	<netfs@lists.linux.dev>, <swapnil.sapkal@amd.com>,
	<syzkaller-bugs@googlegroups.com>, <v9fs@lists.linux.dev>,
	<viro@zeniv.linux.org.uk>
References: <20250328144928.GC29527@redhat.com>
 <67e6be9a.050a0220.2f068f.007f.GAE@google.com>
 <20250328170011.GD29527@redhat.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250328170011.GD29527@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CF:EE_|SJ2PR12MB8807:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d475756-4036-4acb-2e15-08dd6e21e01d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|34020700016|82310400026|1800799024|7416014|376014|12100799063;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Qm1rY2w4N2tHRzVKV1liOFBBa2V6cHpFdnRKRjR0a2dOYVZSTHJLYWp1SDNn?=
 =?utf-8?B?b25PWklTM3lJRE5RczZUV2pLU1BZazdtM2JXSitVcUY4cVlQTEFGZ1hmNytn?=
 =?utf-8?B?c3VOYUlIdUlRYk1IM3RGZVRaQ1JBMHFVQzZRaUhZV3dlU1Z6UUJKd25OcXlh?=
 =?utf-8?B?TFZkWDNIRExva1FBQkZmU0ZveG5lVGNNdzYzRTdGcG1FNjJrRmFSU2JNMVl0?=
 =?utf-8?B?a2ZtaC9TcmdOUHgrVGhSVStOMUpyN3lzdUpLNFpGcEFEQWxVQ3pJOGhEK1Jy?=
 =?utf-8?B?WlRtZWh1dDdzZkVUeVJ4dE4yTWVtR01wSGJyay91ZkU0ZGFEY1BVQitNRXBG?=
 =?utf-8?B?d3NjQmpNYXRtN1FZV3pJQ0cwbjJNalRUU0RrdVVYTUczbWZKZEtqME9sVVBF?=
 =?utf-8?B?L2hFMDljTUVaQVVNMzVmQWRoVUJUMjJEQWIwemd1eXFuMUdqQzZTL1Vja2JI?=
 =?utf-8?B?SmozdlJBZHdrT0YyUVIrMm56T2xaRUhqd1dEYXkvZWNDMUdTN0FRdStPZFRF?=
 =?utf-8?B?QVJVTjIxL1pvSEwrZE9QN243R3orc0F1NlRIWnNQVHhIZEo4ckJsMi90czFk?=
 =?utf-8?B?QjR2TS9DdlRMbnlyUCtseGtzWk9zbkJZS2phT0V4N1BIMS9FRnlubDRYaytW?=
 =?utf-8?B?cm92dEFmUG1IYytRU1hVZzF2WjNraWRqaFpsa0RiWnF5amJDUmovYW5kTWRX?=
 =?utf-8?B?dXUwRmdSMjV3a0p6cFhtZWFvUndCbHlpeWw0TTl1ZnRhMjdJWTJiZlo3OFJN?=
 =?utf-8?B?UEk0cDNoQ2k1SWw0S1NQK0RvL3p6VGlhNTV1ZDY3UHBMQ01wSjg5NEpCc2pF?=
 =?utf-8?B?RXViWUY5NFpQeElVS0p4VFNXeFJ4SndTblNsalVHenRDT0c2U0h0OGJCWlhT?=
 =?utf-8?B?NThOVmlBY2xQNXZpdDBqSGN2UnZqd05LbUZjMXpBWW8yczFoQlVwbm5zdXkr?=
 =?utf-8?B?OU1UYlRwQVZYTWRpMit1TWdoM2RBMVREdDRvUTREaHh6bmQzanRVVXV3T1kv?=
 =?utf-8?B?ZXVqNGtVVUZwcVAyV25aSEc0blVlNjk0TlN4VG91UlI2ZmxZekxRWWlBR1lE?=
 =?utf-8?B?Q2VWWkFvTlQ1aVc2TFhNdGRxZU51UForOWF1anFXVHFGVWduSXE4d3U4R0g3?=
 =?utf-8?B?eGJHZjNGR0MwZGJsQkVQT3hURU5mY1F0VW15SC9FUThMajQ0ZHJvbXQ3dmto?=
 =?utf-8?B?STdMeDkvelVZMG11TWZxdGdiS0JiQ2lheVpuQTd5b3FsOFhZaWlldU5Fc2hI?=
 =?utf-8?B?Smoyb05wM2NUQXlJUGtRMVVCWWdwaXdFRmlYelk0QXlQRi9PSENqNEpMSXdI?=
 =?utf-8?B?cTNMWDJBdWx0d0dVRkVHQmFING5jeWI1N2ZWdUVOWnRkQXRqd1FNMllmV3hz?=
 =?utf-8?B?aVlmZkhhMEIveFZpZXlWbWZ2b3Zib1AvOFEzOWRrbFFXd3dJNDJwTENmbEpj?=
 =?utf-8?B?ZUpTWnJObG5Scjc0c1hlVEtxV0ZBMVZhWW5tcUJEaStIWCtKKytnNWJ3NDlo?=
 =?utf-8?B?M3Zzb2UybU51UlNuekVlQjhOejkyeUwyWmc2TjdtWkFnYTVvU2JnRlR0Sldn?=
 =?utf-8?B?eDZwUjd5Y2lpZEFFMzJrdmxIdXBmNzgwTHZTQ0ZTRnNGL08rdWRuKzZsVE9x?=
 =?utf-8?B?Tlh4RW43Um1KZ0dOdXBsR1BMbnJ6U2s4NW11ZGZEbmxaTi9ieXM2SW55SWpk?=
 =?utf-8?B?OWJyT1hGTlB6QUpaKzdjTXE5TUhMaUEwRmdFK29QV0ZaS21FbENTMG1mWWJM?=
 =?utf-8?B?dDZzUnQxY3E2K1VQVVFKM2dESC9uVElPM1E1c2crdGs4c0htUzhwNTlkUkYr?=
 =?utf-8?B?VG1ReTZFRXdVS3djVUpFcDVCdk9DenY4Wkl6bFJzN25NTlEwTDh4WHp0SHpr?=
 =?utf-8?B?WnNReGZMaEY4Mm0wM1luaHB3Si92MVBDNDlxUXF4bkNZL0lTeUlua0pnWjJq?=
 =?utf-8?B?SEZkU2pReE9pU3Jjbkk1L2daWVRkU0NJQnpYczUwd3I4QmVhSjVIWXhxbXEw?=
 =?utf-8?Q?Zpz9EgIDvaIzNfxat6+J04y6g8J7xQ=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(34020700016)(82310400026)(1800799024)(7416014)(376014)(12100799063);DIR:OUT;SFP:1501;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 17:56:32.8057
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d475756-4036-4acb-2e15-08dd6e21e01d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8807

Hello Oleg,

On 3/28/2025 10:30 PM, Oleg Nesterov wrote:
> Dear syzbot,
> 
> On 03/28, syzbot wrote:
>>
>> syzbot has tested the proposed patch and the reproducer did not trigger any issue:
>>
>> Reported-by: syzbot+62262fdc0e01d99573fc@syzkaller.appspotmail.com
>> Tested-by: syzbot+62262fdc0e01d99573fc@syzkaller.appspotmail.com
>

Yours is the right approach. I was searching for p9_poll_mux()
which would wake the read collector to free pipe buffers but I
didn't dig enough and I was too lazy to open code it (guilty!)
If this gets picked, feel free to add:

Reviewed-and-tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
  
> Thanks. so the previous
> 
> 	syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> 	unregister_netdevice: waiting for DEV to become free
> 
> 	unregister_netdevice: waiting for batadv0 to become free. Usage count = 3
> 
> report suggests that upstream/master has another/unrelated issue(s).

I could not reproduce this bit on mainline at commit acb4f33713b9
("Merge tag 'm68knommu-for-v6.15' of
git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu") so I too
second that it is an unrelated issue.

> 
> As for the patches from me or Prateek (thanks again!), I think that
> the maintainers should take a look.
> 
> But at this point I am mostly confident that the bisected commit aaec5a95d5961
> ("pipe_read: don't wake up the writer if the pipe is still full") is innocent,
> it just reveals yet another problem.
> 
> I guess (I hope ;) Prateek agrees.

I agree aaec5a95d5961 is not guilty! (unlike me) :)

> 
> Oleg.
> 

-- 
Thanks and Regards,
Prateek


