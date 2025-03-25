Return-Path: <linux-fsdevel+bounces-45031-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32906A70442
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 15:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAA4A175053
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 14:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9245D25D525;
	Tue, 25 Mar 2025 14:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zTVURv85"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B64525C6FE;
	Tue, 25 Mar 2025 14:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742914182; cv=fail; b=fNWnrNedPxJxWq36Jb57Z9gIfyGPpmQgIcx8/NcMDflJqA9iTMk82F3KSMUNkjDkX1vywCstgpIU1rT3f80rFZ6FzzeJdi5RCdVNvszu9wVGUx2/B72bE3UKyG2mb0HqKo9rIEQ76ruroR9USsz2NPgwIdLOyToaE9/PSA06+fU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742914182; c=relaxed/simple;
	bh=At4rf270B11XonPKBkSIyVVO6KRYNOfozoh7vO3z1HE=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:CC:
	 References:From:In-Reply-To; b=USOHzspHD0v/FhWpKfUv5XW+2FDAVBWtESp0qM1MOFSewoUAeEMNuzjsPghJ1SL/5xBcDuY0TAU5vQjpaa+utZtxkvYSwKn5pby2jC8hueg4XhmqqZJFaidd1dmuYpLgZhcOyXf7FXy9ZYLd2Rur7hIgvLiMK0ei37B3AL3e9WM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zTVURv85; arc=fail smtp.client-ip=40.107.94.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lwAfrYG4HOkVPPOh1c149JGtfCzafbO56BmKjX1gp25k1V+TsFMUANxBUlChzzQFCnKUlfPlmy2qFcblDyAuDCcP+3ckJgPJ5e9I2sCsdoZqDONeUCmvseeS4p6JHQMO6ouZm0fG7ir1NlV+XKLuSPZOy0Uqiklx/+aWY5paCtSqiI+kN/N6N2n1J4SQvydCd/Zm/TEO9SZFsretKx+UnD7TDKypNXeaka/ooyaUnD8jYgbaH6EQE0+AKijksxLJa+8jjrdpVPWh5CpAClpQriUxrq1MICtAzC6osS04ZfKNEbAyBxeOfV9+j2hv/SiMf7+dPPg8gFTYtuR1f+0ddg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uo1WBzwPGiaYz40vt5mZu/LeT76GPTV8v1jMnL9MPKs=;
 b=JtrR/BoJmA/s2hXC6VVohsDJGTWD/jf2BGN6/uwO/3bJ2MjR8THIP1T1dy7LnnZYOe3nIY1yb1YwuxNNNrNcZ6ZgNNdaBO7LKxENsWDaLzZW8Xwzzp48tfOkrnSzSTX0/qYW22Q3jjZAtcZyKLGCKMmqF3miu2saeksK1HWCQPKBZej8T5erKgZ4iPnuWGp4IGKn/FAoGV2flTXlncpTIUqoq3dP5t7uHOkuTIuDBGlmAa1+A9Z24yLpkn6lbnkKJrktO39VMOHzGUPStDG9Hp0m+UhhN2apieg+sY7hO2rh0IAsuh7rw1OYs26z9FU2KAI9obKMgn5HNG3epNfFQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uo1WBzwPGiaYz40vt5mZu/LeT76GPTV8v1jMnL9MPKs=;
 b=zTVURv85mgAoV60lGAo7hfWH0RaeRBGM9Kc4shiFywtJQVeqMih7Zix+6MjPHiMx+EawOm/4N4U6De0pM3zWSEN6ky3SYAIieut4RkOMuygjrACp2D0lwgBWEprb0yW3a24fzYax+vEZDFEOzWLHCDFEUwqU2XcGsVgoMADe61M=
Received: from BYAPR21CA0012.namprd21.prod.outlook.com (2603:10b6:a03:114::22)
 by DM4PR12MB5915.namprd12.prod.outlook.com (2603:10b6:8:68::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.43; Tue, 25 Mar
 2025 14:49:36 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:a03:114:cafe::a0) by BYAPR21CA0012.outlook.office365.com
 (2603:10b6:a03:114::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.7 via Frontend Transport; Tue,
 25 Mar 2025 14:49:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Tue, 25 Mar 2025 14:49:36 +0000
Received: from [10.252.205.52] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Mar
 2025 09:49:29 -0500
Content-Type: multipart/mixed;
	boundary="------------ZCaTySQsp0bFEWvY1eIkL6Sh"
Message-ID: <f855a988-d5e9-4f5a-8b49-891828367ed7@amd.com>
Date: Tue, 25 Mar 2025 20:19:26 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [netfs?] INFO: task hung in netfs_unbuffered_write_iter
To: Oleg Nesterov <oleg@redhat.com>, Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>, Dominique Martinet
	<asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>
CC: Mateusz Guzik <mjguzik@gmail.com>, syzbot
	<syzbot+62262fdc0e01d99573fc@syzkaller.appspotmail.com>,
	<brauner@kernel.org>, <dhowells@redhat.com>, <jack@suse.cz>,
	<jlayton@kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <netfs@lists.linux.dev>,
	<swapnil.sapkal@amd.com>, <syzkaller-bugs@googlegroups.com>,
	<viro@zeniv.linux.org.uk>, <v9fs@lists.linux.dev>
References: <67e05e30.050a0220.21942d.0003.GAE@google.com>
 <20250323194701.GC14883@redhat.com>
 <CAGudoHHmvU54MU8dsZy422A4+ZzWTVs7LFevP7NpKzwZ1YOqgg@mail.gmail.com>
 <20250323210251.GD14883@redhat.com>
 <af0134a7-6f2a-46e1-85aa-c97477bd6ed8@amd.com>
 <CAGudoHH9w8VO8069iKf_TsAjnfuRSrgiJ2e2D9-NGEDgXW+Lcw@mail.gmail.com>
 <7e377feb-a78b-4055-88cc-2c20f924bf82@amd.com>
 <f7585a27-aaef-4334-a1de-5e081f10c901@amd.com>
 <ff294b3c-cd24-4aa6-9d03-718ff7087158@amd.com>
 <20250325121526.GA7904@redhat.com> <20250325130410.GA10828@redhat.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250325130410.GA10828@redhat.com>
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|DM4PR12MB5915:EE_
X-MS-Office365-Filtering-Correlation-Id: d2326a6b-1e62-4a9f-7c5c-08dd6bac4337
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013|4053099003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VVlXR1RjU3pZYTNOS0lvZnJFYU56WmtFdUxYaTR5TzRZdDlFcUxQdVRpa2Vs?=
 =?utf-8?B?cUJ2VTBka2dIRUxUUFRtRHF6WlI1ZFl5OGwwZllVZFZpdGk3TERoTWJFRWVR?=
 =?utf-8?B?dFdrMkJlT2tqRDdIUU1FMDVXOUdZQkI5UUFjblhMaWlUS09XelVpeThWYnpJ?=
 =?utf-8?B?UTlLV3FpYmxwL0VTVTR5K1ZNMzBMYzF0QlkwRXg3RlFpQmhIdkFZaFAwR3JR?=
 =?utf-8?B?QXBlMFlaSkd6Q1JkaGZXQ0FsWHNYMEJ3VUthMm4zWndjRGpyZkdQMVVqcmxi?=
 =?utf-8?B?NmFtSDVyTk9qUTM2STdrNHJaaEt6N284Y3VYOFl4bXNPOFZhV0R2KzVZTXBF?=
 =?utf-8?B?ZnlQTHRudzRWaDdObnZCdmFTb21GVkZINU5QcENVWU9TRDFyNFNoTTk1NmZL?=
 =?utf-8?B?Sjc1cmcrQWhGOStpK2J2aWt4TW5JMkt3b1ZtNXhWZDZTUXB1R2xqNEJaRWxB?=
 =?utf-8?B?Znc1aC9MMEVTTVNVQTArOVY5Y28vQVVoNW96R1lpRVplaHE2SGk0cXpyZ1NR?=
 =?utf-8?B?b1B0b3BTcEptUWVVZndiOTZrRkVzdms3N043VER4dDJWdkFTSEMxUnhqOVFK?=
 =?utf-8?B?UHdWTmVTRG5rWUs3MDNiSkl2QTRUWUZHaXg1Y2FhSjlJRGJ4NFcvVEg3QUZ5?=
 =?utf-8?B?QW12OUJtRFBtK1BBY1ZiWjYrNCt2SVI3RkVEaXBoWS9wVE1iWXZnZWc5VHFQ?=
 =?utf-8?B?L01IdWk5ZTUrNVFMK0pPWUdrQ1VIOUd5RXVpWHE2SnphbUZBUFF2VTVXU3ov?=
 =?utf-8?B?cEdDcDJVVVZCZjk2VE9CZjNiRVErSnJDTFlidzN4ZHJtRG52VEZ6emZoWUE0?=
 =?utf-8?B?WkwrU0xla2llU2U1QnBvNzA0SlpBQ0NTN2tJcDkra20rUFZKeHV1L2hUNlZk?=
 =?utf-8?B?VTNPOGpKWWFxaG1GZzZvYXJzUlNHQWRNdDk1MVhKMnhGVUZUV1hHUmpYWXE0?=
 =?utf-8?B?OVoraVhHeSszamdTeUtoNnB5TXp2T2ExUWlSRFVoM2luRUI5aURGVTl6Z0I2?=
 =?utf-8?B?bHdzR0NxU2pZdWI5Z1VzaThZN0xxSFBXcG5oY2tPYlRuZjVLZWlzRWRyR2dO?=
 =?utf-8?B?b1UxcUdIOWpLWFhWWGRLcTJ6aEFvYmNpV0hhOVp5azViSEplWnlNSVc5RFlE?=
 =?utf-8?B?VG5wSFJjM2F5bUNjazg4UkZwQnJFT3JaRWVBYTFESWY4WFMyTDNDc0ZmR20z?=
 =?utf-8?B?T3BRVnJKMVh6WDZXdjVUbm1UV2txeUhSbDhiMjZSMHY5RXNTbG81UjdEQTJl?=
 =?utf-8?B?NXF6ZFM4c1lXS0EzcG1BNG5VS1dJYkc2YmdXcmNrWVVFdmttMFlGT1dNRjJs?=
 =?utf-8?B?V1BSMUR2ZUJCODBVS0lKakRhakxNakRXMklaOVRBWk1CN0dkZER3RUVXSTls?=
 =?utf-8?B?OFdvQjQxMkMxemFEZ1Y3RXVEZ3RXYnF3VUgvSGxRQUsvcTdMUktaaWZjRzhw?=
 =?utf-8?B?ZkVndS9SZUlnWGJzazJxNnp1QU9YRVRJSWNzY040UmtKdmdGZUVuVmFaS3Z5?=
 =?utf-8?B?T1N3NWJsb3E2SHdSYm5GeHFLQmVzSnNnQnRTa3plTWl2QlRNWlhrV2h1ZEdZ?=
 =?utf-8?B?NWowSm8zRnVidi92VlJ4aGJCM2E1b0NNdlZuUG16T1JQODZYVDEyTXZNVkZh?=
 =?utf-8?B?Mmdtd3NNaUowRzJ2ZXo1RDk3WVZMdTJjd1JmdEV6TTJsbE8vay9wQ09vQVFi?=
 =?utf-8?B?THJuNHRNcjBZK1o1K0ZWTWkwYWlWaVpuNy8wVnYyMk1RRkxsYU5JSnhySG4z?=
 =?utf-8?B?YzZJL2NaOG4zaE45SEwweGRTT3pkbXJQeWliQzBzRUNMSkM4d0RtTnBtMC8r?=
 =?utf-8?B?WlA1WWpPL0NEOWN3RU12WjFkZ1lyZWJFMmo1SHduaHV5Q1R2SUh0NC9zYTgr?=
 =?utf-8?B?dTlBV2hxaFVzVkNVYktneDdrVlFNOFNTbFgxVEhWQkszL3hhZUI3cEZ0Qm11?=
 =?utf-8?B?Q0NnYXdob1B2UlVmdDBWdzVCTENsLzlCeHlEalhESFpLU3pGTEpXdkhWcEtT?=
 =?utf-8?Q?6zXR2tfBP6t4cqGoyr9FcftGGXqwKo=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013)(4053099003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 14:49:36.1172
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2326a6b-1e62-4a9f-7c5c-08dd6bac4337
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5915

--------------ZCaTySQsp0bFEWvY1eIkL6Sh
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

Hello Oleg, Dominique,

On 3/25/2025 6:34 PM, Oleg Nesterov wrote:
> On 03/25, K Prateek Nayak wrote:
>>
>> I chased this down to p9_client_rpc() net/9p/client.c specifically:
>>
>>          err = c->trans_mod->request(c, req);
>>          if (err < 0) {
>>                  /* write won't happen */
>>                  p9_req_put(c, req);
>>                  if (err != -ERESTARTSYS && err != -EFAULT)
>>                          c->status = Disconnected;
>>                  goto recalc_sigpending;
>>          }
>>
>> c->trans_mod->request() calls p9_fd_request() in net/9p/trans_fd.c
>> which basically does a p9_fd_poll().
> 
> Again, I know nothing about 9p... but if p9_fd_request() returns
> an err < 0, then it comes from p9_conn->err and p9_fd_request()
> does nothing else.
> 
>> Previously, the above would fail with err as -EIO which would
>> cause the client to "Disconnect" and the retry logic would make
>> progress. Now however, the err returned is -ERESTARTSYS
> 
> OK... So p9_conn->err = -ERESTARTSYS was set by p9_conn_cancel()
> called by p9_write_work() because pipe_write() returns ERESTARTSYS?
> 
> But I don't understand -EIO with the reverted commit aaec5a95d59615

Okay it is a long explanation. These are the relevant bits of
traces with aaec5a95d59615 reverted on mainline and I'll break it
down to the best of my abilities:

    kworker/100:1-1803    [100] .....   286.618784: p9_write_work: Data write wait 32770
    kworker/100:1-1803    [100] .....   286.618792: p9_write_work: Data written 28672
    kworker/100:1-1803    [100] .....   286.618793: p9_fd_poll: p9_fd_poll rd poll
    kworker/100:1-1803    [100] .....   286.618793: p9_fd_poll: p9_fd_request wr poll
    kworker/100:1-1803    [100] .....   286.618793: p9_fd_poll: p9_fd_poll rd poll
    kworker/100:1-1803    [100] .....   286.618793: p9_fd_poll: p9_fd_request wr poll
    kworker/100:1-1803    [100] .....   286.618795: p9_read_work: Data read wait 7
    kworker/100:1-1803    [100] .....   286.618796: p9_read_work: Data read 7
    kworker/100:1-1803    [100] .....   286.618796: p9_fd_poll: p9_fd_poll rd poll
    kworker/100:1-1803    [100] .....   286.618796: p9_fd_poll: p9_fd_request wr poll
    kworker/100:1-1803    [100] .....   286.618797: p9_fd_poll: p9_fd_poll rd poll
    kworker/100:1-1803    [100] .....   286.618797: p9_fd_poll: p9_fd_request wr poll
    kworker/100:1-1803    [100] .....   286.618797: p9_read_work: Data read wait 55
    kworker/100:1-1803    [100] .....   286.618798: p9_read_work: Data read 55
            repro-4102    [100] .....   286.618802: p9_client_write: p9_client_rpc done
            repro-4102    [100] .....   286.618804: p9_client_write: p9_pdup
            repro-4102    [100] .....   286.618804: p9_client_write: iter revert

   ==== the above bits are common between the two ===

            repro-4102    [100] .....   286.618805: p9_client_write: p9_client_rpc
            repro-4102    [100] .....   286.618817: p9_fd_request: p9_fd_request
            repro-4102    [100] .....   286.618818: p9_fd_request: p9_fd_request EPOLL
            repro-4102    [100] .....   286.618818: p9_fd_poll: p9_fd_poll rd poll
            repro-4102    [100] .....   286.618818: p9_fd_poll: p9_fd_request wr poll
    kworker/100:1-1803    [100] .....   286.618822: p9_fd_poll: p9_fd_poll rd poll
    kworker/100:1-1803    [100] .....   286.618822: p9_fd_poll: p9_fd_request wr poll
    kworker/100:1-1803    [100] .....   286.618823: p9_read_work: Data read wait 7
    kworker/100:1-1803    [100] .....   286.618825: p9_read_work: Data read 7
    kworker/100:1-1803    [100] .....   286.618825: p9_read_work: p9_tag_lookup error

                                                                  ^^^^^^^^^^^^^^^^^^^
   ==== In this case the  read succeeds but p9_tag_lookup() later will error out ====
   ==== Connection is cancelled with m->err as -EIO                              ====

    kworker/100:1-1803    [100] .....   286.618825: p9_read_work: Connection cancel
    kworker/100:1-1803    [100] ...1.   286.618826: p9_conn_cancel: Connection cancelled (-5)
            repro-4102    [100] .....   286.618831: p9_client_write: p9_client_rpc done
            repro-4102    [100] .....   286.618832: p9_client_write: p9_client_rpc error (-5)

                                                                                          ^^^
   ==== This error from kworker/100 is received by the reproducer                         ====

            repro-4102    [100] .....   286.618833: v9fs_issue_write: Issue write done 2 err(-5)
            repro-4102    [100] .....   286.618833: netfs_write_subrequest_terminated: Collector woken up from netfs_write_subrequest_terminated
            repro-4102    [100] .....   286.618834: netfs_wake_write_collector: Wake collector
            repro-4102    [100] .....   286.618834: netfs_wake_write_collector: Queuing collector work
            repro-4102    [100] .....   286.618837: v9fs_issue_write: Issue write subrequest terminated 2
            repro-4102    [100] .....   286.618838: netfs_unbuffered_write: netfs_unbuffered_write
            repro-4102    [100] .....   286.618838: netfs_end_issue_write: netfs_end_issue_write
            repro-4102    [100] .....   286.618838: netfs_end_issue_write: Write collector need poke 0
            repro-4102    [100] .....   286.618839: netfs_unbuffered_write_iter_locked: Waiting on NETFS_RREQ_IN_PROGRESS!

   ==== A reissue mechanism triggers below ====

  kworker/u1037:2-3232    [096] .....   286.618845: netfs_retry_writes: netfs_reissue_write 1
  kworker/u1037:2-3232    [096] .....   286.618846: v9fs_issue_write: v9fs_issue_write
  kworker/u1037:2-3232    [096] .....   286.618847: p9_client_write: p9_client_rpc
  kworker/u1037:2-3232    [096] .....   286.618873: p9_fd_request: p9_fd_request
  kworker/u1037:2-3232    [096] ...1.   286.618874: p9_fd_request: p9_fd_request error
  kworker/u1037:2-3232    [096] .....   286.618874: p9_client_rpc: Client disconnected (no write)

   ==== Connection with client is disconnected ====

  kworker/u1037:2-3232    [096] .....   286.618877: p9_client_write: p9_client_rpc done
  kworker/u1037:2-3232    [096] .....   286.618880: p9_client_write: p9_client_rpc error (-5)
  kworker/u1037:2-3232    [096] .....   286.618881: v9fs_issue_write: Issue write done 0 err(-5)
  kworker/u1037:2-3232    [096] .....   286.618882: netfs_write_subrequest_terminated: Collector woken up from netfs_write_subrequest_terminated
  kworker/u1037:2-3232    [096] .....   286.618882: netfs_wake_write_collector: Wake collector
  kworker/u1037:2-3232    [096] .....   286.618882: netfs_wake_write_collector: Queuing collector work
  kworker/u1037:2-3232    [096] .....   286.618887: v9fs_issue_write: Issue write subrequest terminated 0
  kworker/u1037:2-3232    [096] .....   286.618890: netfs_write_collection_worker: Write collect clearing and waking up!

   ==== The retry worker will clear the NETFS_RREQ_IN_PROGRESS bit and issue a wakeup ====

            repro-4102    [100] .....   286.619051: p9_client_prepare_req: p9_client_prepare_req eio 1
            repro-4102    [100] .....   286.619052: p9_client_rpc: p9_client_rpc early err return
            repro-4108    [240] .....   286.621325: p9_fd_create: Client connected

   ==== The reproducer will then re-establish the connection and the pattern repeats ====

---

So the pattern is with the optimization reverted is:

o The RPC thread reads "7" bytes.
o p9_tag_lookup() fails giving -EIO.
o connection is cancelled from rpc thread.

o The reproducer thread receives the packet and finds -EIO.
o The reproducer starts a Disconnect.
o The reproducer wakes up collector and sleeps on bit
   NETFS_RREQ_IN_PROGRESS

o A retry worker wakes up.
o Finds connection has been disconnected
o Wakes up the reproducer thread.

o Reproducer wakes up and establishes connection.

I don't know 9p bits enough to understand the intermediates steps but
this is the rough flow.

---

Now for the traces on vanilla mainline:

     kworker/31:1-1723    [031] .....    95.011362: p9_write_work: Data write wait 32770
     kworker/31:1-1723    [031] .....    95.011372: p9_write_work: Data written 28672
     kworker/31:1-1723    [031] .....    95.011373: p9_fd_poll: p9_fd_poll rd poll
     kworker/31:1-1723    [031] .....    95.011373: p9_fd_poll: p9_fd_request wr poll
     kworker/31:1-1723    [031] .....    95.011374: p9_fd_poll: p9_fd_poll rd poll
     kworker/31:1-1723    [031] .....    95.011374: p9_fd_poll: p9_fd_request wr poll
     kworker/31:1-1723    [031] .....    95.011374: p9_read_work: Data read wait 7
     kworker/31:1-1723    [031] .....    95.011375: p9_read_work: Data read 7
     kworker/31:1-1723    [031] .....    95.011375: p9_fd_poll: p9_fd_poll rd poll
     kworker/31:1-1723    [031] .....    95.011375: p9_fd_poll: p9_fd_request wr poll
     kworker/31:1-1723    [031] .....    95.011376: p9_read_work: Data read wait 55
     kworker/31:1-1723    [031] .....    95.011376: p9_read_work: Data read 55
            repro-4076    [031] .....    95.011381: p9_client_rpc: Wait event killable (0)
            repro-4076    [031] .....    95.011382: p9_client_rpc: Check error (0)
            repro-4076    [031] .....    95.011382: p9_client_write: p9_client_rpc done
            repro-4076    [031] .....    95.011382: p9_client_write: p9_pdup
            repro-4076    [031] .....    95.011382: p9_client_write: iter revert

   ==== Above bits are same as the previous traces ====

            repro-4076    [031] .....    95.011383: p9_client_write: p9_client_rpc
            repro-4076    [031] .....    95.011393: p9_fd_request: p9_fd_request
            repro-4076    [031] .....    95.011394: p9_fd_request: p9_fd_request EPOLL
            repro-4076    [031] .....    95.011394: p9_fd_poll: p9_fd_poll rd poll
            repro-4076    [031] .....    95.011394: p9_fd_poll: p9_fd_request wr poll
            repro-4076    [031] .....    99.731970: p9_client_rpc: Wait event killable (-512)

   ==== The wait event here fails with -ERESTARTSYS ====

            repro-4076    [031] .....    99.731979: p9_client_rpc: Flushed (-512)
            repro-4076    [031] .....    99.731983: p9_client_rpc: Final error (-512)
            repro-4076    [031] .....    99.731983: p9_client_write: p9_client_rpc done
            repro-4076    [031] .....    99.731984: p9_client_write: p9_client_rpc error (-512)
            repro-4076    [031] .....    99.731985: v9fs_issue_write: Issue write done 2 err(-512)
            repro-4076    [031] .....    99.731987: netfs_write_subrequest_terminated: Collector woken up from netfs_write_subrequest_terminated
            repro-4076    [031] .....    99.731987: netfs_wake_write_collector: Wake collector
            repro-4076    [031] .....    99.731988: netfs_wake_write_collector: Queuing collector work
            repro-4076    [031] .....    99.731991: v9fs_issue_write: Issue write subrequest terminated 2
            repro-4076    [031] .....    99.731991: netfs_unbuffered_write: netfs_unbuffered_write
            repro-4076    [031] .....    99.731991: netfs_end_issue_write: netfs_end_issue_write
            repro-4076    [031] .....    99.731992: netfs_end_issue_write: Write collector need poke 0
            repro-4076    [031] .....    99.731993: netfs_unbuffered_write_iter_locked: Waiting on NETFS_RREQ_IN_PROGRESS!

   ==== The reproducer waits on bit NETFS_RREQ_IN_PROGRESS ====

  kworker/u1028:3-3860    [030] .....    99.732028: netfs_retry_writes: netfs_reissue_write 1
  kworker/u1028:3-3860    [030] .....    99.732030: v9fs_issue_write: v9fs_issue_write
  kworker/u1028:3-3860    [030] .....    99.732031: p9_client_write: p9_client_rpc
  kworker/u1028:3-3860    [030] .....    99.732051: p9_fd_request: p9_fd_request
  kworker/u1028:3-3860    [030] .....    99.732052: p9_fd_request: p9_fd_request EPOLL
  kworker/u1028:3-3860    [030] .....    99.732052: p9_fd_poll: p9_fd_poll rd poll
  kworker/u1028:3-3860    [030] .....    99.732053: p9_fd_poll: p9_fd_request wr poll

   ==== The retry worker seemingly gets stuck post p9_fd_poll() waiting for wakeup ====

---

That is my analysis so far.

> 
> Oleg.
> 

-- 
Thanks and Regards,
Prateek

--------------ZCaTySQsp0bFEWvY1eIkL6Sh
Content-Type: text/plain; charset="UTF-8"; name="debug.diff"
Content-Disposition: attachment; filename="debug.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2ZzLzlwL3Zmc19hZGRyLmMgYi9mcy85cC92ZnNfYWRkci5jCmluZGV4
IDMyNjE5ZDE0NmNiYy4uM2ZiZmM2ODgyYzM1IDEwMDY0NAotLS0gYS9mcy85cC92ZnNfYWRk
ci5jCisrKyBiL2ZzLzlwL3Zmc19hZGRyLmMKQEAgLTU2LDEwICs1NiwxMyBAQCBzdGF0aWMg
dm9pZCB2OWZzX2lzc3VlX3dyaXRlKHN0cnVjdCBuZXRmc19pb19zdWJyZXF1ZXN0ICpzdWJy
ZXEpCiAJc3RydWN0IHA5X2ZpZCAqZmlkID0gc3VicmVxLT5ycmVxLT5uZXRmc19wcml2Owog
CWludCBlcnIsIGxlbjsKIAorCXRyYWNlX3ByaW50aygidjlmc19pc3N1ZV93cml0ZVxuIik7
CiAJbGVuID0gcDlfY2xpZW50X3dyaXRlKGZpZCwgc3VicmVxLT5zdGFydCwgJnN1YnJlcS0+
aW9faXRlciwgJmVycik7CisJdHJhY2VfcHJpbnRrKCJJc3N1ZSB3cml0ZSBkb25lICVkIGVy
ciglZClcbiIsIGxlbiwgZXJyKTsKIAlpZiAobGVuID4gMCkKIAkJX19zZXRfYml0KE5FVEZT
X1NSRVFfTUFERV9QUk9HUkVTUywgJnN1YnJlcS0+ZmxhZ3MpOwogCW5ldGZzX3dyaXRlX3N1
YnJlcXVlc3RfdGVybWluYXRlZChzdWJyZXEsIGxlbiA/OiBlcnIsIGZhbHNlKTsKKwl0cmFj
ZV9wcmludGsoIklzc3VlIHdyaXRlIHN1YnJlcXVlc3QgdGVybWluYXRlZCAlZFxuIiwgbGVu
KTsKIH0KIAogLyoqCkBAIC03NCw2ICs3Nyw3IEBAIHN0YXRpYyB2b2lkIHY5ZnNfaXNzdWVf
cmVhZChzdHJ1Y3QgbmV0ZnNfaW9fc3VicmVxdWVzdCAqc3VicmVxKQogCWludCB0b3RhbCwg
ZXJyOwogCiAJdG90YWwgPSBwOV9jbGllbnRfcmVhZChmaWQsIHBvcywgJnN1YnJlcS0+aW9f
aXRlciwgJmVycik7CisJdHJhY2VfcHJpbnRrKCJ2OWZzX2lzc3VlX3JlYWQgJWQgZXJyKCVk
KVxuIiwgdG90YWwsIGVycik7CiAKIAkvKiBpZiB3ZSBqdXN0IGV4dGVuZGVkIHRoZSBmaWxl
IHNpemUsIGFueSBwb3J0aW9uIG5vdCBpbgogCSAqIGNhY2hlIHdvbid0IGJlIG9uIHNlcnZl
ciBhbmQgaXMgemVyb2VzICovCmRpZmYgLS1naXQgYS9mcy9uZXRmcy9kaXJlY3Rfd3JpdGUu
YyBiL2ZzL25ldGZzL2RpcmVjdF93cml0ZS5jCmluZGV4IDQyY2U1M2NjMjE2ZS4uNjMzM2I4
YmI0MDA4IDEwMDY0NAotLS0gYS9mcy9uZXRmcy9kaXJlY3Rfd3JpdGUuYworKysgYi9mcy9u
ZXRmcy9kaXJlY3Rfd3JpdGUuYwpAQCAtMTA1LDYgKzEwNSw3IEBAIHNzaXplX3QgbmV0ZnNf
dW5idWZmZXJlZF93cml0ZV9pdGVyX2xvY2tlZChzdHJ1Y3Qga2lvY2IgKmlvY2IsIHN0cnVj
dCBpb3ZfaXRlciAqCiAKIAlpZiAoIWFzeW5jKSB7CiAJCXRyYWNlX25ldGZzX3JyZXEod3Jl
cSwgbmV0ZnNfcnJlcV90cmFjZV93YWl0X2lwKTsKKwkJdHJhY2VfcHJpbnRrKCJXYWl0aW5n
IG9uIE5FVEZTX1JSRVFfSU5fUFJPR1JFU1MhXG4iKTsKIAkJd2FpdF9vbl9iaXQoJndyZXEt
PmZsYWdzLCBORVRGU19SUkVRX0lOX1BST0dSRVNTLAogCQkJICAgIFRBU0tfVU5JTlRFUlJV
UFRJQkxFKTsKIAkJcmV0ID0gd3JlcS0+ZXJyb3I7CmRpZmYgLS1naXQgYS9mcy9uZXRmcy9y
ZWFkX2NvbGxlY3QuYyBiL2ZzL25ldGZzL3JlYWRfY29sbGVjdC5jCmluZGV4IDIzYzc1NzU1
YWQ0ZS4uYTYwOTA2M2RiOGE3IDEwMDY0NAotLS0gYS9mcy9uZXRmcy9yZWFkX2NvbGxlY3Qu
YworKysgYi9mcy9uZXRmcy9yZWFkX2NvbGxlY3QuYwpAQCAtNDQ2LDYgKzQ0Niw3IEBAIHN0
YXRpYyB2b2lkIG5ldGZzX3JlYWRfY29sbGVjdGlvbihzdHJ1Y3QgbmV0ZnNfaW9fcmVxdWVz
dCAqcnJlcSkKIAl0YXNrX2lvX2FjY291bnRfcmVhZChycmVxLT50cmFuc2ZlcnJlZCk7CiAK
IAl0cmFjZV9uZXRmc19ycmVxKHJyZXEsIG5ldGZzX3JyZXFfdHJhY2Vfd2FrZV9pcCk7CisJ
dHJhY2VfcHJpbnRrKCJSZWFkIGNvbGxlY3QgY2xlYXJpbmcgYW5kIHdha2luZyB1cCFcbiIp
OwogCWNsZWFyX2FuZF93YWtlX3VwX2JpdChORVRGU19SUkVRX0lOX1BST0dSRVNTLCAmcnJl
cS0+ZmxhZ3MpOwogCiAJdHJhY2VfbmV0ZnNfcnJlcShycmVxLCBuZXRmc19ycmVxX3RyYWNl
X2RvbmUpOwpkaWZmIC0tZ2l0IGEvZnMvbmV0ZnMvd3JpdGVfY29sbGVjdC5jIGIvZnMvbmV0
ZnMvd3JpdGVfY29sbGVjdC5jCmluZGV4IDNmY2E1OWU2NDc1ZC4uYTU0YWEyYmNjNzg2IDEw
MDY0NAotLS0gYS9mcy9uZXRmcy93cml0ZV9jb2xsZWN0LmMKKysrIGIvZnMvbmV0ZnMvd3Jp
dGVfY29sbGVjdC5jCkBAIC00MjksNiArNDI5LDcgQEAgdm9pZCBuZXRmc193cml0ZV9jb2xs
ZWN0aW9uX3dvcmtlcihzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspCiAKIAlfZGVidWcoImZp
bmlzaGVkIik7CiAJdHJhY2VfbmV0ZnNfcnJlcSh3cmVxLCBuZXRmc19ycmVxX3RyYWNlX3dh
a2VfaXApOworCXRyYWNlX3ByaW50aygiV3JpdGUgY29sbGVjdCBjbGVhcmluZyBhbmQgd2Fr
aW5nIHVwIVxuIik7CiAJY2xlYXJfYW5kX3dha2VfdXBfYml0KE5FVEZTX1JSRVFfSU5fUFJP
R1JFU1MsICZ3cmVxLT5mbGFncyk7CiAKIAlpZiAod3JlcS0+aW9jYikgewpAQCAtNDQ5LDEw
ICs0NTAsMTQgQEAgdm9pZCBuZXRmc193cml0ZV9jb2xsZWN0aW9uX3dvcmtlcihzdHJ1Y3Qg
d29ya19zdHJ1Y3QgKndvcmspCiAgKi8KIHZvaWQgbmV0ZnNfd2FrZV93cml0ZV9jb2xsZWN0
b3Ioc3RydWN0IG5ldGZzX2lvX3JlcXVlc3QgKndyZXEsIGJvb2wgd2FzX2FzeW5jKQogewor
CXRyYWNlX3ByaW50aygiV2FrZSBjb2xsZWN0b3JcbiIpOwogCWlmICghd29ya19wZW5kaW5n
KCZ3cmVxLT53b3JrKSkgewogCQluZXRmc19nZXRfcmVxdWVzdCh3cmVxLCBuZXRmc19ycmVx
X3RyYWNlX2dldF93b3JrKTsKLQkJaWYgKCFxdWV1ZV93b3JrKHN5c3RlbV91bmJvdW5kX3dx
LCAmd3JlcS0+d29yaykpCisJCXRyYWNlX3ByaW50aygiUXVldWluZyBjb2xsZWN0b3Igd29y
a1xuIik7CisJCWlmICghcXVldWVfd29yayhzeXN0ZW1fdW5ib3VuZF93cSwgJndyZXEtPndv
cmspKSB7CisJCQl0cmFjZV9wcmludGsoIlB1dCByZXF1ZXN0XG4iKTsKIAkJCW5ldGZzX3B1
dF9yZXF1ZXN0KHdyZXEsIHdhc19hc3luYywgbmV0ZnNfcnJlcV90cmFjZV9wdXRfd29ya19u
cSk7CisJCX0KIAl9CiB9CiAKQEAgLTU0Miw4ICs1NDcsMTAgQEAgdm9pZCBuZXRmc193cml0
ZV9zdWJyZXF1ZXN0X3Rlcm1pbmF0ZWQodm9pZCAqX29wLCBzc2l6ZV90IHRyYW5zZmVycmVk
X29yX2Vycm9yLAogCS8qIElmIHdlIGFyZSBhdCB0aGUgaGVhZCBvZiB0aGUgcXVldWUsIHdh
a2UgdXAgdGhlIGNvbGxlY3RvciwKIAkgKiB0cmFuc2ZlcnJpbmcgYSByZWYgdG8gaXQgaWYg
d2Ugd2VyZSB0aGUgb25lcyB0byBkbyBzby4KIAkgKi8KLQlpZiAobGlzdF9pc19maXJzdCgm
c3VicmVxLT5ycmVxX2xpbmssICZzdHJlYW0tPnN1YnJlcXVlc3RzKSkKKwlpZiAobGlzdF9p
c19maXJzdCgmc3VicmVxLT5ycmVxX2xpbmssICZzdHJlYW0tPnN1YnJlcXVlc3RzKSkgewor
CQl0cmFjZV9wcmludGsoIkNvbGxlY3RvciB3b2tlbiB1cCBmcm9tIG5ldGZzX3dyaXRlX3N1
YnJlcXVlc3RfdGVybWluYXRlZFxuIik7CiAJCW5ldGZzX3dha2Vfd3JpdGVfY29sbGVjdG9y
KHdyZXEsIHdhc19hc3luYyk7CisJfQogCiAJbmV0ZnNfcHV0X3N1YnJlcXVlc3Qoc3VicmVx
LCB3YXNfYXN5bmMsIG5ldGZzX3NyZXFfdHJhY2VfcHV0X3Rlcm1pbmF0ZWQpOwogfQpkaWZm
IC0tZ2l0IGEvZnMvbmV0ZnMvd3JpdGVfaXNzdWUuYyBiL2ZzL25ldGZzL3dyaXRlX2lzc3Vl
LmMKaW5kZXggNzcyNzlmYzViNWE3Li4yMmE0Yjc5M2U3ODkgMTAwNjQ0Ci0tLSBhL2ZzL25l
dGZzL3dyaXRlX2lzc3VlLmMKKysrIGIvZnMvbmV0ZnMvd3JpdGVfaXNzdWUuYwpAQCAtMjMy
LDggKzIzMiwxMCBAQCBzdGF0aWMgdm9pZCBuZXRmc19kb19pc3N1ZV93cml0ZShzdHJ1Y3Qg
bmV0ZnNfaW9fc3RyZWFtICpzdHJlYW0sCiAKIAlfZW50ZXIoIlI9JXhbJXhdLCV6eCIsIHdy
ZXEtPmRlYnVnX2lkLCBzdWJyZXEtPmRlYnVnX2luZGV4LCBzdWJyZXEtPmxlbik7CiAKLQlp
ZiAodGVzdF9iaXQoTkVURlNfU1JFUV9GQUlMRUQsICZzdWJyZXEtPmZsYWdzKSkKKwlpZiAo
dGVzdF9iaXQoTkVURlNfU1JFUV9GQUlMRUQsICZzdWJyZXEtPmZsYWdzKSkgeworCQl0cmFj
ZV9wcmludGsoIm5ldGZzX2RvX2lzc3VlX3dyaXRlIGZhaWxlZCFcbiIpOwogCQlyZXR1cm4g
bmV0ZnNfd3JpdGVfc3VicmVxdWVzdF90ZXJtaW5hdGVkKHN1YnJlcSwgc3VicmVxLT5lcnJv
ciwgZmFsc2UpOworCX0KIAogCXRyYWNlX25ldGZzX3NyZXEoc3VicmVxLCBuZXRmc19zcmVx
X3RyYWNlX3N1Ym1pdCk7CiAJc3RyZWFtLT5pc3N1ZV93cml0ZShzdWJyZXEpOwpAQCAtMjY0
LDYgKzI2Niw3IEBAIHZvaWQgbmV0ZnNfaXNzdWVfd3JpdGUoc3RydWN0IG5ldGZzX2lvX3Jl
cXVlc3QgKndyZXEsCiAKIAlpZiAoIXN1YnJlcSkKIAkJcmV0dXJuOworCXRyYWNlX3ByaW50
aygibmV0ZnNfaXNzdWVfd3JpdGUhXG4iKTsKIAlzdHJlYW0tPmNvbnN0cnVjdCA9IE5VTEw7
CiAJc3VicmVxLT5pb19pdGVyLmNvdW50ID0gc3VicmVxLT5sZW47CiAJbmV0ZnNfZG9faXNz
dWVfd3JpdGUoc3RyZWFtLCBzdWJyZXEpOwpAQCAtMjkwLDYgKzI5Myw3IEBAIHNpemVfdCBu
ZXRmc19hZHZhbmNlX3dyaXRlKHN0cnVjdCBuZXRmc19pb19yZXF1ZXN0ICp3cmVxLAogCV9l
bnRlcigiUj0leFsleF0iLCB3cmVxLT5kZWJ1Z19pZCwgc3VicmVxID8gc3VicmVxLT5kZWJ1
Z19pbmRleCA6IDApOwogCiAJaWYgKHN1YnJlcSAmJiBzdGFydCAhPSBzdWJyZXEtPnN0YXJ0
ICsgc3VicmVxLT5sZW4pIHsKKwkJdHJhY2VfcHJpbnRrKCJuZXRmc19pc3N1ZV93cml0ZSBm
cm9tIGFkdmFuY2Ugd3JpdGUhXG4iKTsKIAkJbmV0ZnNfaXNzdWVfd3JpdGUod3JlcSwgc3Ry
ZWFtKTsKIAkJc3VicmVxID0gTlVMTDsKIAl9CkBAIC0zMDcsNiArMzExLDcgQEAgc2l6ZV90
IG5ldGZzX2FkdmFuY2Vfd3JpdGUoc3RydWN0IG5ldGZzX2lvX3JlcXVlc3QgKndyZXEsCiAJ
aWYgKHN1YnJlcS0+bGVuID49IHN0cmVhbS0+c3JlcV9tYXhfbGVuIHx8CiAJICAgIHN1YnJl
cS0+bnJfc2VncyA+PSBzdHJlYW0tPnNyZXFfbWF4X3NlZ3MgfHwKIAkgICAgdG9fZW9mKSB7
CisJCXRyYWNlX3ByaW50aygibmV0ZnNfaXNzdWVfd3JpdGUgZnJvbSBhZHZhbmNlIHdyaXRl
ISAyXG4iKTsKIAkJbmV0ZnNfaXNzdWVfd3JpdGUod3JlcSwgc3RyZWFtKTsKIAkJc3VicmVx
ID0gTlVMTDsKIAl9CkBAIC0zOTcsNiArNDAyLDcgQEAgc3RhdGljIGludCBuZXRmc193cml0
ZV9mb2xpbyhzdHJ1Y3QgbmV0ZnNfaW9fcmVxdWVzdCAqd3JlcSwKIAkgKiAgICAgd2hlbiB0
aGV5IHdlcmUgcmVhZC4gIE5vdGUgdGhhdCB0aGVzZSBhcHBlYXIgYXMgYSBzcGVjaWFsCiAJ
ICogICAgIHdyaXRlLWJhY2sgZ3JvdXAuCiAJICovCisJdHJhY2VfcHJpbnRrKCJuZXRmc19p
c3N1ZV93cml0ZSBpbiBmb2xpbyBjb3B5XG4iKTsKIAlpZiAoZmdyb3VwID09IE5FVEZTX0ZP
TElPX0NPUFlfVE9fQ0FDSEUpIHsKIAkJbmV0ZnNfaXNzdWVfd3JpdGUod3JlcSwgdXBsb2Fk
KTsKIAl9IGVsc2UgaWYgKGZncm91cCAhPSB3cmVxLT5ncm91cCkgewpAQCAtNTI2LDYgKzUz
Miw3IEBAIHN0YXRpYyBpbnQgbmV0ZnNfd3JpdGVfZm9saW8oc3RydWN0IG5ldGZzX2lvX3Jl
cXVlc3QgKndyZXEsCiAgKi8KIHN0YXRpYyB2b2lkIG5ldGZzX2VuZF9pc3N1ZV93cml0ZShz
dHJ1Y3QgbmV0ZnNfaW9fcmVxdWVzdCAqd3JlcSkKIHsKKwl0cmFjZV9wcmludGsoIm5ldGZz
X2VuZF9pc3N1ZV93cml0ZVxuIik7CiAJYm9vbCBuZWVkc19wb2tlID0gdHJ1ZTsKIAogCXNt
cF93bWIoKTsgLyogV3JpdGUgc3VicmVxIGxpc3RzIGJlZm9yZSBBTExfUVVFVUVELiAqLwpA
QCAtNTQxLDYgKzU0OCw3IEBAIHN0YXRpYyB2b2lkIG5ldGZzX2VuZF9pc3N1ZV93cml0ZShz
dHJ1Y3QgbmV0ZnNfaW9fcmVxdWVzdCAqd3JlcSkKIAkJbmV0ZnNfaXNzdWVfd3JpdGUod3Jl
cSwgc3RyZWFtKTsKIAl9CiAKKwl0cmFjZV9wcmludGsoIldyaXRlIGNvbGxlY3RvciBuZWVk
IHBva2UgJWRcbiIsIG5lZWRzX3Bva2UpOwogCWlmIChuZWVkc19wb2tlKQogCQluZXRmc193
YWtlX3dyaXRlX2NvbGxlY3Rvcih3cmVxLCBmYWxzZSk7CiB9CkBAIC03MzAsNiArNzM4LDcg
QEAgaW50IG5ldGZzX3VuYnVmZmVyZWRfd3JpdGUoc3RydWN0IG5ldGZzX2lvX3JlcXVlc3Qg
KndyZXEsIGJvb2wgbWF5X3dhaXQsIHNpemVfdAogCQkJYnJlYWs7CiAJfQogCisJdHJhY2Vf
cHJpbnRrKCJuZXRmc191bmJ1ZmZlcmVkX3dyaXRlXG4iKTsKIAluZXRmc19lbmRfaXNzdWVf
d3JpdGUod3JlcSk7CiAJX2xlYXZlKCIgPSAlZCIsIGVycm9yKTsKIAlyZXR1cm4gZXJyb3I7
CkBAIC05MDgsNiArOTE3LDcgQEAgaW50IG5ldGZzX3dyaXRlYmFja19zaW5nbGUoc3RydWN0
IGFkZHJlc3Nfc3BhY2UgKm1hcHBpbmcsCiAJfQogCiBzdG9wOgorCXRyYWNlX3ByaW50aygi
bmV0ZnNfaXNzdWVfd3JpdGUgd3JpdGViYWNrIHNpbmdsZVxuIik7CiAJZm9yIChpbnQgcyA9
IDA7IHMgPCBOUl9JT19TVFJFQU1TOyBzKyspCiAJCW5ldGZzX2lzc3VlX3dyaXRlKHdyZXEs
ICZ3cmVxLT5pb19zdHJlYW1zW3NdKTsKIAlzbXBfd21iKCk7IC8qIFdyaXRlIGxpc3RzIGJl
Zm9yZSBBTExfUVVFVUVELiAqLwpkaWZmIC0tZ2l0IGEvZnMvbmV0ZnMvd3JpdGVfcmV0cnku
YyBiL2ZzL25ldGZzL3dyaXRlX3JldHJ5LmMKaW5kZXggNTQ1ZDMzMDc5YTc3Li42MGEwMzA3
OTc2NmIgMTAwNjQ0Ci0tLSBhL2ZzL25ldGZzL3dyaXRlX3JldHJ5LmMKKysrIGIvZnMvbmV0
ZnMvd3JpdGVfcmV0cnkuYwpAQCAtNDMsNiArNDMsNyBAQCBzdGF0aWMgdm9pZCBuZXRmc19y
ZXRyeV93cml0ZV9zdHJlYW0oc3RydWN0IG5ldGZzX2lvX3JlcXVlc3QgKndyZXEsCiAKIAkJ
CQlpb3ZfaXRlcl9yZXZlcnQoJnNvdXJjZSwgc3VicmVxLT5sZW4gLSBzb3VyY2UuY291bnQp
OwogCQkJCW5ldGZzX2dldF9zdWJyZXF1ZXN0KHN1YnJlcSwgbmV0ZnNfc3JlcV90cmFjZV9n
ZXRfcmVzdWJtaXQpOworCQkJCXRyYWNlX3ByaW50aygibmV0ZnNfcmVpc3N1ZV93cml0ZSAx
XG4iKTsKIAkJCQluZXRmc19yZWlzc3VlX3dyaXRlKHN0cmVhbSwgc3VicmVxLCAmc291cmNl
KTsKIAkJCX0KIAkJfQpAQCAtMTE2LDYgKzExNyw3IEBAIHN0YXRpYyB2b2lkIG5ldGZzX3Jl
dHJ5X3dyaXRlX3N0cmVhbShzdHJ1Y3QgbmV0ZnNfaW9fcmVxdWVzdCAqd3JlcSwKIAkJCQli
b3VuZGFyeSA9IHRydWU7CiAKIAkJCW5ldGZzX2dldF9zdWJyZXF1ZXN0KHN1YnJlcSwgbmV0
ZnNfc3JlcV90cmFjZV9nZXRfcmVzdWJtaXQpOworCQkJdHJhY2VfcHJpbnRrKCJuZXRmc19y
ZWlzc3VlX3dyaXRlIDJcbiIpOwogCQkJbmV0ZnNfcmVpc3N1ZV93cml0ZShzdHJlYW0sIHN1
YnJlcSwgJnNvdXJjZSk7CiAJCQlpZiAoc3VicmVxID09IHRvKQogCQkJCWJyZWFrOwpAQCAt
MTgzLDYgKzE4NSw3IEBAIHN0YXRpYyB2b2lkIG5ldGZzX3JldHJ5X3dyaXRlX3N0cmVhbShz
dHJ1Y3QgbmV0ZnNfaW9fcmVxdWVzdCAqd3JlcSwKIAkJCQlib3VuZGFyeSA9IGZhbHNlOwog
CQkJfQogCisJCQl0cmFjZV9wcmludGsoIm5ldGZzX3JlaXNzdWVfd3JpdGUgM1xuIik7CiAJ
CQluZXRmc19yZWlzc3VlX3dyaXRlKHN0cmVhbSwgc3VicmVxLCAmc291cmNlKTsKIAkJCWlm
ICghbGVuKQogCQkJCWJyZWFrOwpkaWZmIC0tZ2l0IGEvbmV0LzlwL2NsaWVudC5jIGIvbmV0
LzlwL2NsaWVudC5jCmluZGV4IDA5ZjhjZWQ5ZjhiYi4uOTA5YzgzYjBlMDE1IDEwMDY0NAot
LS0gYS9uZXQvOXAvY2xpZW50LmMKKysrIGIvbmV0LzlwL2NsaWVudC5jCkBAIC02MzMsMTIg
KzYzMywxNiBAQCBzdGF0aWMgc3RydWN0IHA5X3JlcV90ICpwOV9jbGllbnRfcHJlcGFyZV9y
ZXEoc3RydWN0IHA5X2NsaWVudCAqYywKIAlwOV9kZWJ1ZyhQOV9ERUJVR19NVVgsICJjbGll
bnQgJXAgb3AgJWRcbiIsIGMsIHR5cGUpOwogCiAJLyogd2UgYWxsb3cgZm9yIGFueSBzdGF0
dXMgb3RoZXIgdGhhbiBkaXNjb25uZWN0ZWQgKi8KLQlpZiAoYy0+c3RhdHVzID09IERpc2Nv
bm5lY3RlZCkKKwlpZiAoYy0+c3RhdHVzID09IERpc2Nvbm5lY3RlZCkgeworCQl0cmFjZV9w
cmludGsoInA5X2NsaWVudF9wcmVwYXJlX3JlcSBlaW8gMVxuIik7CiAJCXJldHVybiBFUlJf
UFRSKC1FSU8pOworCX0KIAogCS8qIGlmIHN0YXR1cyBpcyBiZWdpbl9kaXNjb25uZWN0ZWQg
d2UgYWxsb3cgb25seSBjbHVuayByZXF1ZXN0ICovCi0JaWYgKGMtPnN0YXR1cyA9PSBCZWdp
bkRpc2Nvbm5lY3QgJiYgdHlwZSAhPSBQOV9UQ0xVTkspCisJaWYgKGMtPnN0YXR1cyA9PSBC
ZWdpbkRpc2Nvbm5lY3QgJiYgdHlwZSAhPSBQOV9UQ0xVTkspIHsKKwkJdHJhY2VfcHJpbnRr
KCJwOV9jbGllbnRfcHJlcGFyZV9yZXEgZWlvIDJcbiIpOwogCQlyZXR1cm4gRVJSX1BUUigt
RUlPKTsKKwl9CiAKIAl2YV9jb3B5KGFwYywgYXApOwogCXJlcSA9IHA5X3RhZ19hbGxvYyhj
LCB0eXBlLCB0X3NpemUsIHJfc2l6ZSwgZm10LCBhcGMpOwpAQCAtNjkwLDggKzY5NCwxMCBA
QCBwOV9jbGllbnRfcnBjKHN0cnVjdCBwOV9jbGllbnQgKmMsIGludDhfdCB0eXBlLCBjb25z
dCBjaGFyICpmbXQsIC4uLikKIAl2YV9zdGFydChhcCwgZm10KTsKIAlyZXEgPSBwOV9jbGll
bnRfcHJlcGFyZV9yZXEoYywgdHlwZSwgdHNpemUsIHJzaXplLCBmbXQsIGFwKTsKIAl2YV9l
bmQoYXApOwotCWlmIChJU19FUlIocmVxKSkKKwlpZiAoSVNfRVJSKHJlcSkpIHsKKwkJdHJh
Y2VfcHJpbnRrKCJwOV9jbGllbnRfcnBjIGVhcmx5IGVyciByZXR1cm5cbiIpOwogCQlyZXR1
cm4gcmVxOworCX0KIAogCXJlcS0+dGMuemMgPSBmYWxzZTsKIAlyZXEtPnJjLnpjID0gZmFs
c2U7CkBAIC03MDYsOSArNzEyLDEyIEBAIHA5X2NsaWVudF9ycGMoc3RydWN0IHA5X2NsaWVu
dCAqYywgaW50OF90IHR5cGUsIGNvbnN0IGNoYXIgKmZtdCwgLi4uKQogCWVyciA9IGMtPnRy
YW5zX21vZC0+cmVxdWVzdChjLCByZXEpOwogCWlmIChlcnIgPCAwKSB7CiAJCS8qIHdyaXRl
IHdvbid0IGhhcHBlbiAqLworCQl0cmFjZV9wcmludGsoIndyaXRlIHdvbid0IGhhcHBuZW4g
KCVkKVxuIiwgZXJyKTsKIAkJcDlfcmVxX3B1dChjLCByZXEpOwotCQlpZiAoZXJyICE9IC1F
UkVTVEFSVFNZUyAmJiBlcnIgIT0gLUVGQVVMVCkKKwkJaWYgKGVyciAhPSAtRVJFU1RBUlRT
WVMgJiYgZXJyICE9IC1FRkFVTFQpIHsKKwkJCXRyYWNlX3ByaW50aygiQ2xpZW50IGRpc2Nv
bm5lY3RlZCAobm8gd3JpdGUpXG4iKTsKIAkJCWMtPnN0YXR1cyA9IERpc2Nvbm5lY3RlZDsK
KwkJfQogCQlnb3RvIHJlY2FsY19zaWdwZW5kaW5nOwogCX0KIGFnYWluOgpAQCAtNzIxLDYg
KzczMCw3IEBAIHA5X2NsaWVudF9ycGMoc3RydWN0IHA5X2NsaWVudCAqYywgaW50OF90IHR5
cGUsIGNvbnN0IGNoYXIgKmZtdCwgLi4uKQogCSAqLwogCXNtcF9ybWIoKTsKIAorCXRyYWNl
X3ByaW50aygiV2FpdCBldmVudCBraWxsYWJsZSAoJWQpICglZCkgKCVkKSAoJWQpXG4iLCBl
cnIsIFJFQURfT05DRShyZXEtPnN0YXR1cyksIGMtPnN0YXR1cywgdHlwZSk7CiAJaWYgKGVy
ciA9PSAtRVJFU1RBUlRTWVMgJiYgYy0+c3RhdHVzID09IENvbm5lY3RlZCAmJgogCSAgICB0
eXBlID09IFA5X1RGTFVTSCkgewogCQlzaWdwZW5kaW5nID0gMTsKQEAgLTczMSw2ICs3NDEs
NyBAQCBwOV9jbGllbnRfcnBjKHN0cnVjdCBwOV9jbGllbnQgKmMsIGludDhfdCB0eXBlLCBj
b25zdCBjaGFyICpmbXQsIC4uLikKIAlpZiAoUkVBRF9PTkNFKHJlcS0+c3RhdHVzKSA9PSBS
RVFfU1RBVFVTX0VSUk9SKSB7CiAJCXA5X2RlYnVnKFA5X0RFQlVHX0VSUk9SLCAicmVxX3N0
YXR1cyBlcnJvciAlZFxuIiwgcmVxLT50X2Vycik7CiAJCWVyciA9IHJlcS0+dF9lcnI7CisJ
CXRyYWNlX3ByaW50aygiUkVRX1NUQVRVU19FUlJPUiAoJWQpXG4iLCBlcnIpOwogCX0KIAlp
ZiAoZXJyID09IC1FUkVTVEFSVFNZUyAmJiBjLT5zdGF0dXMgPT0gQ29ubmVjdGVkKSB7CiAJ
CXA5X2RlYnVnKFA5X0RFQlVHX01VWCwgImZsdXNoaW5nXG4iKTsKQEAgLTc0Myw2ICs3NTQs
OCBAQCBwOV9jbGllbnRfcnBjKHN0cnVjdCBwOV9jbGllbnQgKmMsIGludDhfdCB0eXBlLCBj
b25zdCBjaGFyICpmbXQsIC4uLikKIAkJLyogaWYgd2UgcmVjZWl2ZWQgdGhlIHJlc3BvbnNl
IGFueXdheSwgZG9uJ3Qgc2lnbmFsIGVycm9yICovCiAJCWlmIChSRUFEX09OQ0UocmVxLT5z
dGF0dXMpID09IFJFUV9TVEFUVVNfUkNWRCkKIAkJCWVyciA9IDA7CisKKwkJdHJhY2VfcHJp
bnRrKCJGbHVzaGVkICglZClcbiIsIGVycik7CiAJfQogcmVjYWxjX3NpZ3BlbmRpbmc6CiAJ
aWYgKHNpZ3BlbmRpbmcpIHsKQEAgLTc1NCwxMSArNzY3LDEzIEBAIHA5X2NsaWVudF9ycGMo
c3RydWN0IHA5X2NsaWVudCAqYywgaW50OF90IHR5cGUsIGNvbnN0IGNoYXIgKmZtdCwgLi4u
KQogCQlnb3RvIHJldGVycjsKIAogCWVyciA9IHA5X2NoZWNrX2Vycm9ycyhjLCByZXEpOwor
CXRyYWNlX3ByaW50aygiQ2hlY2sgZXJyb3IgKCVkKVxuIiwgZXJyKTsKIAl0cmFjZV85cF9j
bGllbnRfcmVzKGMsIHR5cGUsIHJlcS0+cmMudGFnLCBlcnIpOwogCWlmICghZXJyKQogCQly
ZXR1cm4gcmVxOwogcmV0ZXJyOgogCXA5X3JlcV9wdXQoYywgcmVxKTsKKwl0cmFjZV9wcmlu
dGsoIkZpbmFsIGVycm9yICglZClcbiIsIGVycik7CiAJcmV0dXJuIEVSUl9QVFIoc2FmZV9l
cnJubyhlcnIpKTsKIH0KIApAQCAtODA4LDggKzgyMywxMCBAQCBzdGF0aWMgc3RydWN0IHA5
X3JlcV90ICpwOV9jbGllbnRfemNfcnBjKHN0cnVjdCBwOV9jbGllbnQgKmMsIGludDhfdCB0
eXBlLAogCWVyciA9IGMtPnRyYW5zX21vZC0+emNfcmVxdWVzdChjLCByZXEsIHVpZGF0YSwg
dW9kYXRhLAogCQkJCSAgICAgICBpbmxlbiwgb2xlbiwgaW5faGRybGVuKTsKIAlpZiAoZXJy
IDwgMCkgewotCQlpZiAoZXJyID09IC1FSU8pCisJCWlmIChlcnIgPT0gLUVJTykgeworCQkJ
dHJhY2VfcHJpbnRrKCJDbGllbnQgZGlzY29ubmVjdGVkICh6ZXJvX2NvcHkpXG4iKTsKIAkJ
CWMtPnN0YXR1cyA9IERpc2Nvbm5lY3RlZDsKKwkJfQogCQlpZiAoZXJyICE9IC1FUkVTVEFS
VFNZUykKIAkJCWdvdG8gcmVjYWxjX3NpZ3BlbmRpbmc7CiAJfQpAQCAtMTA5Myw2ICsxMTEw
LDcgQEAgRVhQT1JUX1NZTUJPTChwOV9jbGllbnRfZGVzdHJveSk7CiB2b2lkIHA5X2NsaWVu
dF9kaXNjb25uZWN0KHN0cnVjdCBwOV9jbGllbnQgKmNsbnQpCiB7CiAJcDlfZGVidWcoUDlf
REVCVUdfOVAsICJjbG50ICVwXG4iLCBjbG50KTsKKwl0cmFjZV9wcmludGsoIkNsaWVudCBk
aXNjb25uZWN0ZWRcbiIpOwogCWNsbnQtPnN0YXR1cyA9IERpc2Nvbm5lY3RlZDsKIH0KIEVY
UE9SVF9TWU1CT0wocDlfY2xpZW50X2Rpc2Nvbm5lY3QpOwpAQCAtMTEwMCw2ICsxMTE4LDcg
QEAgRVhQT1JUX1NZTUJPTChwOV9jbGllbnRfZGlzY29ubmVjdCk7CiB2b2lkIHA5X2NsaWVu
dF9iZWdpbl9kaXNjb25uZWN0KHN0cnVjdCBwOV9jbGllbnQgKmNsbnQpCiB7CiAJcDlfZGVi
dWcoUDlfREVCVUdfOVAsICJjbG50ICVwXG4iLCBjbG50KTsKKwl0cmFjZV9wcmludGsoIkNs
aWVudCBiZWdpbiBkaXNjb25uZWN0XG4iKTsKIAljbG50LT5zdGF0dXMgPSBCZWdpbkRpc2Nv
bm5lY3Q7CiB9CiBFWFBPUlRfU1lNQk9MKHA5X2NsaWVudF9iZWdpbl9kaXNjb25uZWN0KTsK
QEAgLTE1NzIsMTEgKzE1OTEsMTMgQEAgcDlfY2xpZW50X3JlYWRfb25jZShzdHJ1Y3QgcDlf
ZmlkICpmaWQsIHU2NCBvZmZzZXQsIHN0cnVjdCBpb3ZfaXRlciAqdG8sCiAJCQkJICAgICAg
IG9mZnNldCwgcnNpemUpOwogCX0gZWxzZSB7CiAJCW5vbl96YyA9IDE7CisJCXRyYWNlX3By
aW50aygiUlBDIGlzc3VlXG4iKTsKIAkJcmVxID0gcDlfY2xpZW50X3JwYyhjbG50LCBQOV9U
UkVBRCwgImRxZCIsIGZpZC0+ZmlkLCBvZmZzZXQsCiAJCQkJICAgIHJzaXplKTsKIAl9CiAJ
aWYgKElTX0VSUihyZXEpKSB7CiAJCSplcnIgPSBQVFJfRVJSKHJlcSk7CisJCXRyYWNlX3By
aW50aygicmVhZCBSUEMgaXNzdWUgZXJyb3IoJWQpXG4iLCAqZXJyKTsKIAkJaWYgKCFub25f
emMpCiAJCQlpb3ZfaXRlcl9yZXZlcnQodG8sIGNvdW50IC0gaW92X2l0ZXJfY291bnQodG8p
KTsKIAkJcmV0dXJuIDA7CkBAIC0xNTg3LDEyICsxNjA4LDE0IEBAIHA5X2NsaWVudF9yZWFk
X29uY2Uoc3RydWN0IHA5X2ZpZCAqZmlkLCB1NjQgb2Zmc2V0LCBzdHJ1Y3QgaW92X2l0ZXIg
KnRvLAogCWlmICgqZXJyKSB7CiAJCWlmICghbm9uX3pjKQogCQkJaW92X2l0ZXJfcmV2ZXJ0
KHRvLCBjb3VudCAtIGlvdl9pdGVyX2NvdW50KHRvKSk7CisJCXRyYWNlX3ByaW50aygicDlw
ZHVfcmVhZGYgZXJyb3IoJWQpXG4iLCAqZXJyKTsKIAkJdHJhY2VfOXBfcHJvdG9jb2xfZHVt
cChjbG50LCAmcmVxLT5yYyk7CiAJCXA5X3JlcV9wdXQoY2xudCwgcmVxKTsKIAkJcmV0dXJu
IDA7CiAJfQogCWlmIChyc2l6ZSA8IHJlY2VpdmVkKSB7CiAJCXByX2VycigiYm9ndXMgUlJF
QUQgY291bnQgKCVkID4gJWQpXG4iLCByZWNlaXZlZCwgcnNpemUpOworCQl0cmFjZV9wcmlu
dGsoImJvZ3VzIHJlYWRcbiIpOwogCQlyZWNlaXZlZCA9IHJzaXplOwogCX0KIApAQCAtMTYw
Miw2ICsxNjI1LDcgQEAgcDlfY2xpZW50X3JlYWRfb25jZShzdHJ1Y3QgcDlfZmlkICpmaWQs
IHU2NCBvZmZzZXQsIHN0cnVjdCBpb3ZfaXRlciAqdG8sCiAJCWludCBuID0gY29weV90b19p
dGVyKGRhdGFwdHIsIHJlY2VpdmVkLCB0byk7CiAKIAkJaWYgKG4gIT0gcmVjZWl2ZWQpIHsK
KwkJCXRyYWNlX3ByaW50aygiY29weV90b19pdGVyIGZhdWx0XG4iKTsKIAkJCSplcnIgPSAt
RUZBVUxUOwogCQkJcDlfcmVxX3B1dChjbG50LCByZXEpOwogCQkJcmV0dXJuIG47CkBAIC0x
NjQyLDIzICsxNjY2LDI5IEBAIHA5X2NsaWVudF93cml0ZShzdHJ1Y3QgcDlfZmlkICpmaWQs
IHU2NCBvZmZzZXQsIHN0cnVjdCBpb3ZfaXRlciAqZnJvbSwgaW50ICplcnIpCiAJCQkJCSAg
ICAgICByc2l6ZSwgUDlfWkNfSERSX1NaLCAiZHFkIiwKIAkJCQkJICAgICAgIGZpZC0+Zmlk
LCBvZmZzZXQsIHJzaXplKTsKIAkJfSBlbHNlIHsKKwkJCXRyYWNlX3ByaW50aygicDlfY2xp
ZW50X3JwY1xuIik7CiAJCQlyZXEgPSBwOV9jbGllbnRfcnBjKGNsbnQsIFA5X1RXUklURSwg
ImRxViIsIGZpZC0+ZmlkLAogCQkJCQkgICAgb2Zmc2V0LCByc2l6ZSwgZnJvbSk7CisJCQl0
cmFjZV9wcmludGsoInA5X2NsaWVudF9ycGMgZG9uZVxuIik7CiAJCX0KIAkJaWYgKElTX0VS
UihyZXEpKSB7CiAJCQlpb3ZfaXRlcl9yZXZlcnQoZnJvbSwgY291bnQgLSBpb3ZfaXRlcl9j
b3VudChmcm9tKSk7CiAJCQkqZXJyID0gUFRSX0VSUihyZXEpOworCQkJdHJhY2VfcHJpbnRr
KCJwOV9jbGllbnRfcnBjIGVycm9yICglZClcbiIsICplcnIpOwogCQkJYnJlYWs7CiAJCX0K
IAorCQl0cmFjZV9wcmludGsoInA5X3BkdXBcbiIpOwogCQkqZXJyID0gcDlwZHVfcmVhZGYo
JnJlcS0+cmMsIGNsbnQtPnByb3RvX3ZlcnNpb24sICJkIiwgJndyaXR0ZW4pOwogCQlpZiAo
KmVycikgeworCQkJdHJhY2VfcHJpbnRrKCJwOV9wZHVwIGVyciglZClcbiIsICplcnIpOwog
CQkJaW92X2l0ZXJfcmV2ZXJ0KGZyb20sIGNvdW50IC0gaW92X2l0ZXJfY291bnQoZnJvbSkp
OwogCQkJdHJhY2VfOXBfcHJvdG9jb2xfZHVtcChjbG50LCAmcmVxLT5yYyk7CiAJCQlwOV9y
ZXFfcHV0KGNsbnQsIHJlcSk7CiAJCQlicmVhazsKIAkJfQogCQlpZiAocnNpemUgPCB3cml0
dGVuKSB7CisJCQl0cmFjZV9wcmludGsoInA5X3BkdXAgYm9ndXMgJWQgJWRcbiIsIHdyaXR0
ZW4sIHJzaXplKTsKIAkJCXByX2VycigiYm9ndXMgUldSSVRFIGNvdW50ICglZCA+ICVkKVxu
Iiwgd3JpdHRlbiwgcnNpemUpOwogCQkJd3JpdHRlbiA9IHJzaXplOwogCQl9CkBAIC0xNjY2
LDYgKzE2OTYsNyBAQCBwOV9jbGllbnRfd3JpdGUoc3RydWN0IHA5X2ZpZCAqZmlkLCB1NjQg
b2Zmc2V0LCBzdHJ1Y3QgaW92X2l0ZXIgKmZyb20sIGludCAqZXJyKQogCQlwOV9kZWJ1ZyhQ
OV9ERUJVR185UCwgIjw8PCBSV1JJVEUgY291bnQgJWRcbiIsIHdyaXR0ZW4pOwogCiAJCXA5
X3JlcV9wdXQoY2xudCwgcmVxKTsKKwkJdHJhY2VfcHJpbnRrKCJpdGVyIHJldmVydFxuIik7
CiAJCWlvdl9pdGVyX3JldmVydChmcm9tLCBjb3VudCAtIHdyaXR0ZW4gLSBpb3ZfaXRlcl9j
b3VudChmcm9tKSk7CiAJCXRvdGFsICs9IHdyaXR0ZW47CiAJCW9mZnNldCArPSB3cml0dGVu
OwpkaWZmIC0tZ2l0IGEvbmV0LzlwL3RyYW5zX2ZkLmMgYi9uZXQvOXAvdHJhbnNfZmQuYwpp
bmRleCAxOTYwNjBkYzYxMzguLjNjODNiMzg1NWU4MiAxMDA2NDQKLS0tIGEvbmV0LzlwL3Ry
YW5zX2ZkLmMKKysrIGIvbmV0LzlwL3RyYW5zX2ZkLmMKQEAgLTE5Niw2ICsxOTYsNyBAQCBz
dGF0aWMgdm9pZCBwOV9jb25uX2NhbmNlbChzdHJ1Y3QgcDlfY29ubiAqbSwgaW50IGVycikK
IAkJcmV0dXJuOwogCX0KIAorCXRyYWNlX3ByaW50aygiQ29ubmVjdGlvbiBjYW5jZWxsZWQg
KCVkKVxuIiwgZXJyKTsKIAltLT5lcnIgPSBlcnI7CiAKIAlsaXN0X2Zvcl9lYWNoX2VudHJ5
X3NhZmUocmVxLCBydG1wLCAmbS0+cmVxX2xpc3QsIHJlcV9saXN0KSB7CkBAIC0yMzMsOSAr
MjM0LDEyIEBAIHA5X2ZkX3BvbGwoc3RydWN0IHA5X2NsaWVudCAqY2xpZW50LCBzdHJ1Y3Qg
cG9sbF90YWJsZV9zdHJ1Y3QgKnB0LCBpbnQgKmVycikKIAkJcmV0dXJuIEVQT0xMRVJSOwog
CX0KIAorCXRyYWNlX3ByaW50aygicDlfZmRfcG9sbCByZCBwb2xsXG4iKTsKIAlyZXQgPSB2
ZnNfcG9sbCh0cy0+cmQsIHB0KTsKLQlpZiAodHMtPnJkICE9IHRzLT53cikKKwlpZiAodHMt
PnJkICE9IHRzLT53cikgeworCQl0cmFjZV9wcmludGsoInA5X2ZkX3JlcXVlc3Qgd3IgcG9s
bFxuIik7CiAJCXJldCA9IChyZXQgJiB+RVBPTExPVVQpIHwgKHZmc19wb2xsKHRzLT53ciwg
cHQpICYgfkVQT0xMSU4pOworCX0KIAlyZXR1cm4gcmV0OwogfQogCkBAIC0yNjMsOSArMjY3
LDEzIEBAIHN0YXRpYyBpbnQgcDlfZmRfcmVhZChzdHJ1Y3QgcDlfY2xpZW50ICpjbGllbnQs
IHZvaWQgKnYsIGludCBsZW4pCiAJCXA5X2RlYnVnKFA5X0RFQlVHX0VSUk9SLCAiYmxvY2tp
bmcgcmVhZCAuLi5cbiIpOwogCiAJcG9zID0gdHMtPnJkLT5mX3BvczsKKwl0cmFjZV9wcmlu
dGsoIkRhdGEgcmVhZCB3YWl0ICVkXG4iLCBsZW4pOwogCXJldCA9IGtlcm5lbF9yZWFkKHRz
LT5yZCwgdiwgbGVuLCAmcG9zKTsKLQlpZiAocmV0IDw9IDAgJiYgcmV0ICE9IC1FUkVTVEFS
VFNZUyAmJiByZXQgIT0gLUVBR0FJTikKKwl0cmFjZV9wcmludGsoIkRhdGEgcmVhZCAlZFxu
IiwgcmV0KTsKKwlpZiAocmV0IDw9IDAgJiYgcmV0ICE9IC1FUkVTVEFSVFNZUyAmJiByZXQg
IT0gLUVBR0FJTikgeworCQl0cmFjZV9wcmludGsoIkNsaWVudCBkaXNjb25uZWN0ZWQgKGZk
X3JlYWQpXG4iKTsKIAkJY2xpZW50LT5zdGF0dXMgPSBEaXNjb25uZWN0ZWQ7CisJfQogCXJl
dHVybiByZXQ7CiB9CiAKQEAgLTMzMCw2ICszMzgsNyBAQCBzdGF0aWMgdm9pZCBwOV9yZWFk
X3dvcmsoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQogCQlpZiAoIW0tPnJyZXEgfHwgKG0t
PnJyZXEtPnN0YXR1cyAhPSBSRVFfU1RBVFVTX1NFTlQpKSB7CiAJCQlwOV9kZWJ1ZyhQOV9E
RUJVR19FUlJPUiwgIlVuZXhwZWN0ZWQgcGFja2V0IHRhZyAlZFxuIiwKIAkJCQkgbS0+cmMu
dGFnKTsKKwkJCXRyYWNlX3ByaW50aygicDlfdGFnX2xvb2t1cCBlcnJvclxuIik7CiAJCQll
cnIgPSAtRUlPOwogCQkJZ290byBlcnJvcjsKIAkJfQpAQCAtMzM4LDYgKzM0Nyw3IEBAIHN0
YXRpYyB2b2lkIHA5X3JlYWRfd29yayhzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspCiAJCQlw
OV9kZWJ1ZyhQOV9ERUJVR19FUlJPUiwKIAkJCQkgInJlcXVlc3RlZCBwYWNrZXQgc2l6ZSB0
b28gYmlnOiAlZCBmb3IgdGFnICVkIHdpdGggY2FwYWNpdHkgJXpkXG4iLAogCQkJCSBtLT5y
Yy5zaXplLCBtLT5yYy50YWcsIG0tPnJyZXEtPnJjLmNhcGFjaXR5KTsKKwkJCXRyYWNlX3By
aW50aygiY2FwYWNpdHkgZXJyb3JcbiIpOwogCQkJZXJyID0gLUVJTzsKIAkJCWdvdG8gZXJy
b3I7CiAJCX0KQEAgLTM0OCw2ICszNTgsNyBAQCBzdGF0aWMgdm9pZCBwOV9yZWFkX3dvcmso
c3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQogCQkJCSBtLT5yYy50YWcsIG0tPnJyZXEpOwog
CQkJcDlfcmVxX3B1dChtLT5jbGllbnQsIG0tPnJyZXEpOwogCQkJbS0+cnJlcSA9IE5VTEw7
CisJCQl0cmFjZV9wcmludGsoInNkYXRhIGVycm9yXG4iKTsKIAkJCWVyciA9IC1FSU87CiAJ
CQlnb3RvIGVycm9yOwogCQl9CkBAIC0zNzUsNiArMzg2LDcgQEAgc3RhdGljIHZvaWQgcDlf
cmVhZF93b3JrKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykKIAkJCXA5X2RlYnVnKFA5X0RF
QlVHX0VSUk9SLAogCQkJCSAiUmVxdWVzdCB0YWcgJWQgZXJyb3JlZCBvdXQgd2hpbGUgd2Ug
d2VyZSByZWFkaW5nIHRoZSByZXBseVxuIiwKIAkJCQkgbS0+cmMudGFnKTsKKwkJCXRyYWNl
X3ByaW50aygicmVxdWVzdCB0YWcgZXJyb3IgJWQgc3RhdHVzKCVkKVxuIiwgbS0+cmMudGFn
LCBtLT5ycmVxLT5zdGF0dXMpOwogCQkJZXJyID0gLUVJTzsKIAkJCWdvdG8gZXJyb3I7CiAJ
CX0KQEAgLTQwMyw2ICs0MTUsNyBAQCBzdGF0aWMgdm9pZCBwOV9yZWFkX3dvcmsoc3RydWN0
IHdvcmtfc3RydWN0ICp3b3JrKQogCiAJcmV0dXJuOwogZXJyb3I6CisJdHJhY2VfcHJpbnRr
KCJDb25uZWN0aW9uIGNhbmNlbFxuIik7CiAJcDlfY29ubl9jYW5jZWwobSwgZXJyKTsKIAlj
bGVhcl9iaXQoUndvcmtzY2hlZCwgJm0tPndzY2hlZCk7CiB9CkBAIC00MjksOSArNDQyLDEz
IEBAIHN0YXRpYyBpbnQgcDlfZmRfd3JpdGUoc3RydWN0IHA5X2NsaWVudCAqY2xpZW50LCB2
b2lkICp2LCBpbnQgbGVuKQogCWlmICghKHRzLT53ci0+Zl9mbGFncyAmIE9fTk9OQkxPQ0sp
KQogCQlwOV9kZWJ1ZyhQOV9ERUJVR19FUlJPUiwgImJsb2NraW5nIHdyaXRlIC4uLlxuIik7
CiAKKwl0cmFjZV9wcmludGsoIkRhdGEgd3JpdGUgd2FpdCAlZFxuIixsZW4pOwogCXJldCA9
IGtlcm5lbF93cml0ZSh0cy0+d3IsIHYsIGxlbiwgJnRzLT53ci0+Zl9wb3MpOwotCWlmIChy
ZXQgPD0gMCAmJiByZXQgIT0gLUVSRVNUQVJUU1lTICYmIHJldCAhPSAtRUFHQUlOKQorCXRy
YWNlX3ByaW50aygiRGF0YSB3cml0dGVuICVsZFxuIiwgcmV0KTsKKwlpZiAocmV0IDw9IDAg
JiYgcmV0ICE9IC1FUkVTVEFSVFNZUyAmJiByZXQgIT0gLUVBR0FJTikgeworCQl0cmFjZV9w
cmludGsoIkNsaWVudCBkaXNjb25uZWN0ZWQgKGZkX3dyaXRlKVxuIik7CiAJCWNsaWVudC0+
c3RhdHVzID0gRGlzY29ubmVjdGVkOworCX0KIAlyZXR1cm4gcmV0OwogfQogCkBAIC01MTks
NiArNTM2LDcgQEAgc3RhdGljIHZvaWQgcDlfd3JpdGVfd29yayhzdHJ1Y3Qgd29ya19zdHJ1
Y3QgKndvcmspCiAJcmV0dXJuOwogCiBlcnJvcjoKKwl0cmFjZV9wcmludGsoIkNvbm5lY3Rp
b24gY2FuY2VsXG4iKTsKIAlwOV9jb25uX2NhbmNlbChtLCBlcnIpOwogCWNsZWFyX2JpdChX
d29ya3NjaGVkLCAmbS0+d3NjaGVkKTsKIH0KQEAgLTYyOCw2ICs2NDYsNyBAQCBzdGF0aWMg
dm9pZCBwOV9wb2xsX211eChzdHJ1Y3QgcDlfY29ubiAqbSkKIAluID0gcDlfZmRfcG9sbCht
LT5jbGllbnQsIE5VTEwsICZlcnIpOwogCWlmIChuICYgKEVQT0xMRVJSIHwgRVBPTExIVVAg
fCBFUE9MTE5WQUwpKSB7CiAJCXA5X2RlYnVnKFA5X0RFQlVHX1RSQU5TLCAiZXJyb3IgbXV4
ICVwIGVyciAlZFxuIiwgbSwgbik7CisJCXRyYWNlX3ByaW50aygiQ29ubmVjdGlvbiBjYW5j
ZWxcbiIpOwogCQlwOV9jb25uX2NhbmNlbChtLCBlcnIpOwogCX0KIApAQCAtNjY4LDEyICs2
ODcsMTQgQEAgc3RhdGljIGludCBwOV9mZF9yZXF1ZXN0KHN0cnVjdCBwOV9jbGllbnQgKmNs
aWVudCwgc3RydWN0IHA5X3JlcV90ICpyZXEpCiAJc3RydWN0IHA5X3RyYW5zX2ZkICp0cyA9
IGNsaWVudC0+dHJhbnM7CiAJc3RydWN0IHA5X2Nvbm4gKm0gPSAmdHMtPmNvbm47CiAKKwl0
cmFjZV9wcmludGsoInA5X2ZkX3JlcXVlc3RcbiIpOwogCXA5X2RlYnVnKFA5X0RFQlVHX1RS
QU5TLCAibXV4ICVwIHRhc2sgJXAgdGNhbGwgJXAgaWQgJWRcbiIsCiAJCSBtLCBjdXJyZW50
LCAmcmVxLT50YywgcmVxLT50Yy5pZCk7CiAKIAlzcGluX2xvY2soJm0tPnJlcV9sb2NrKTsK
IAogCWlmIChtLT5lcnIgPCAwKSB7CisJCXRyYWNlX3ByaW50aygicDlfZmRfcmVxdWVzdCBl
cnJvclxuIik7CiAJCXNwaW5fdW5sb2NrKCZtLT5yZXFfbG9jayk7CiAJCXJldHVybiBtLT5l
cnI7CiAJfQpAQCAtNjgyLDEzICs3MDMsMTYgQEAgc3RhdGljIGludCBwOV9mZF9yZXF1ZXN0
KHN0cnVjdCBwOV9jbGllbnQgKmNsaWVudCwgc3RydWN0IHA5X3JlcV90ICpyZXEpCiAJbGlz
dF9hZGRfdGFpbCgmcmVxLT5yZXFfbGlzdCwgJm0tPnVuc2VudF9yZXFfbGlzdCk7CiAJc3Bp
bl91bmxvY2soJm0tPnJlcV9sb2NrKTsKIAorCXRyYWNlX3ByaW50aygicDlfZmRfcmVxdWVz
dCBFUE9MTFxuIik7CiAJaWYgKHRlc3RfYW5kX2NsZWFyX2JpdChXcGVuZGluZywgJm0tPndz
Y2hlZCkpCiAJCW4gPSBFUE9MTE9VVDsKIAllbHNlCiAJCW4gPSBwOV9mZF9wb2xsKG0tPmNs
aWVudCwgTlVMTCwgTlVMTCk7CiAKLQlpZiAobiAmIEVQT0xMT1VUICYmICF0ZXN0X2FuZF9z
ZXRfYml0KFd3b3Jrc2NoZWQsICZtLT53c2NoZWQpKQorCWlmIChuICYgRVBPTExPVVQgJiYg
IXRlc3RfYW5kX3NldF9iaXQoV3dvcmtzY2hlZCwgJm0tPndzY2hlZCkpIHsKKwkJdHJhY2Vf
cHJpbnRrKCJwOV9mZF9yZXF1ZXN0IHNjaGVkdWxlIHdvcmtcbiIpOwogCQlzY2hlZHVsZV93
b3JrKCZtLT53cSk7CisJfQogCiAJcmV0dXJuIDA7CiB9CkBAIC04NTIsNiArODc2LDcgQEAg
c3RhdGljIGludCBwOV9mZF9vcGVuKHN0cnVjdCBwOV9jbGllbnQgKmNsaWVudCwgaW50IHJm
ZCwgaW50IHdmZCkKIAlkYXRhX3JhY2UodHMtPndyLT5mX2ZsYWdzIHw9IE9fTk9OQkxPQ0sp
OwogCiAJY2xpZW50LT50cmFucyA9IHRzOworCXRyYWNlX3ByaW50aygiQ2xpZW50IGNvbm5l
Y3RlZFxuIik7CiAJY2xpZW50LT5zdGF0dXMgPSBDb25uZWN0ZWQ7CiAKIAlyZXR1cm4gMDsK
QEAgLTg4OSw2ICs5MTQsNyBAQCBzdGF0aWMgaW50IHA5X3NvY2tldF9vcGVuKHN0cnVjdCBw
OV9jbGllbnQgKmNsaWVudCwgc3RydWN0IHNvY2tldCAqY3NvY2tldCkKIAlnZXRfZmlsZShm
aWxlKTsKIAlwLT53ciA9IHAtPnJkID0gZmlsZTsKIAljbGllbnQtPnRyYW5zID0gcDsKKwl0
cmFjZV9wcmludGsoIkNsaWVudCBjb25uZWN0ZWRcbiIpOwogCWNsaWVudC0+c3RhdHVzID0g
Q29ubmVjdGVkOwogCiAJcC0+cmQtPmZfZmxhZ3MgfD0gT19OT05CTE9DSzsKQEAgLTkyMCw2
ICs5NDYsNyBAQCBzdGF0aWMgdm9pZCBwOV9jb25uX2Rlc3Ryb3koc3RydWN0IHA5X2Nvbm4g
Km0pCiAJCW0tPndyZXEgPSBOVUxMOwogCX0KIAorCXRyYWNlX3ByaW50aygiQ29ubmVjdGlv
biBkZXN0cm95XG4iKTsKIAlwOV9jb25uX2NhbmNlbChtLCAtRUNPTk5SRVNFVCk7CiAKIAlt
LT5jbGllbnQgPSBOVUxMOwpAQCAtOTQyLDYgKzk2OSw3IEBAIHN0YXRpYyB2b2lkIHA5X2Zk
X2Nsb3NlKHN0cnVjdCBwOV9jbGllbnQgKmNsaWVudCkKIAlpZiAoIXRzKQogCQlyZXR1cm47
CiAKKwl0cmFjZV9wcmludGsoIkNsaWVudCBkaXNjb25uZWN0ZWQgKGZkX2Nsb3NlKVxuIik7
CiAJY2xpZW50LT5zdGF0dXMgPSBEaXNjb25uZWN0ZWQ7CiAKIAlwOV9jb25uX2Rlc3Ryb3ko
JnRzLT5jb25uKTsK

--------------ZCaTySQsp0bFEWvY1eIkL6Sh--

