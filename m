Return-Path: <linux-fsdevel+bounces-45186-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2F3A742E3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 05:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82E7D17B077
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 04:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78EAB1DE3C9;
	Fri, 28 Mar 2025 04:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="11iJK20P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2087.outbound.protection.outlook.com [40.107.212.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F07F17C77;
	Fri, 28 Mar 2025 04:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743134549; cv=fail; b=ftdpqtXbKjFhFN1YoG6P1eA+5zVeIIEu2l++kFonesVmk0r5Y4KB89DtLI8zhK7Z5KQXzxScuO6mMPyEHpIEkYrtUhmsXlHp1ZHhyenVKtn3RLyeCJ+7etYdpH5Tr+R2p2uEHRuQo0oCB/3Z7T70JoIwkk/7FEnlfY33zolo0AY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743134549; c=relaxed/simple;
	bh=ERjAUGZ7XWkYWMs5hlcsHdfSFqu0gZuKG7RgIu3VUlQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bil6JolH/Cdrgiew1BLZawG3o6qms3Hax5eL5gax2hTCpHTYbZdwuEYoVv9eVIO5SlLyyuyJsIk18+tt6Lx9I1M3vGMnsYdzapoNJ4zd3RxRufoLmaPm6PL3FvgyYZW9Auctl2EzY2J247KA3/H55Uim2K2WH2JRujm2zxkKclI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=11iJK20P; arc=fail smtp.client-ip=40.107.212.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XPv3QG2D30udUBjl7J7qJ2+xH1SdEZEMef747nu5AjKq46GWnoo80VdsetOJjuMWY4zD02cbhj6wkrLXyjRdtDrjH5N2OCWcRpjC7VI+v6isfnJI061ZxXLiDe/5k476XGOfwW9swYfsrwEOEIcxlkf7V2DsUpcPZu1UtNQgCTpxSPIVu+xWt6wem1kvl7sEtt0NmpXrjlN8nf7MXMipOSthJV2MLuFpI/d9c0kyH3PH7fFdARu/qBxjtEAcnw1KbGtTYoNMVFhZ3Ywn6CSI110isQoGlG0nXw6i6GuF0ZF1Qf4NKmyf5tWIqlc9vWfqyTB9Pb6wjOsK0JTHCW2HlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yO0NPuuZf93K48yzmtYHAxVy31sOo1GmLPE5QYsvLRQ=;
 b=HSa2hAO/7vsieZCguET18lzXCnqmenBpZmbOWAusaOwFVXURMw+x+IcV8EUYk7Jhb/NKeij8M1mWQIQDo1OAhUGcWl7I16ZvDeHWGegTk+6UxRfWze81aNK9IMUd+A2SidxKUhglyVANxrkC5cVuAAo9dCFuGOKNyLAGLkAG7wRLvMWIEaCP6J39yYR0cfIXQ3FIz9FLnjuak1zyDB7jSpCipd/YlV5/EqjfTJQuZJJYLMcq8E5+ndZYZEZb4/02C7Yq440m/IgABDHa6rxJ/58QiwjAXp1zmOOmnTcI6L6lEW4hLHrSEq8pGr9e1u31zGOJdWOJSo8ODyy7NG37UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=codewreck.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yO0NPuuZf93K48yzmtYHAxVy31sOo1GmLPE5QYsvLRQ=;
 b=11iJK20PG0F+Xf4Ggsohim1lzWek6SRZJKphpysbNnr4RfNCVmAzbV5wrFSikq4C5E+1Jv4l/fWDCedvTJwiaRP3vMMfXLMZFtToO5iu0G7LJrJZ++4qfH9elYOqKouera4m23UEzGGqdziLJaxa0Tjj+KYsYFuYEjfZpaIQOjs=
Received: from MW4P222CA0005.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::10)
 by BL1PR12MB5897.namprd12.prod.outlook.com (2603:10b6:208:395::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 04:02:24 +0000
Received: from SJ5PEPF00000208.namprd05.prod.outlook.com
 (2603:10b6:303:114:cafe::36) by MW4P222CA0005.outlook.office365.com
 (2603:10b6:303:114::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Fri,
 28 Mar 2025 04:02:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000208.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Fri, 28 Mar 2025 04:02:23 +0000
Received: from [10.136.37.166] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Mar
 2025 23:01:40 -0500
Message-ID: <49c26b3c-cab9-4ee6-919d-c734f4de6028@amd.com>
Date: Fri, 28 Mar 2025 09:31:32 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [netfs?] INFO: task hung in netfs_unbuffered_write_iter
To: <asmadeus@codewreck.org>, syzbot
	<syzbot+62262fdc0e01d99573fc@syzkaller.appspotmail.com>
CC: <brauner@kernel.org>, <dhowells@redhat.com>, <ericvh@kernel.org>,
	<jack@suse.cz>, <jlayton@kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux_oss@crudebyte.com>,
	<lucho@ionkov.net>, <mjguzik@gmail.com>, <netfs@lists.linux.dev>,
	<oleg@redhat.com>, <swapnil.sapkal@amd.com>,
	<syzkaller-bugs@googlegroups.com>, <v9fs@lists.linux.dev>,
	<viro@zeniv.linux.org.uk>
References: <377fbe51-2e56-4538-89c5-eb91c13a2559@amd.com>
 <67e5c0c7.050a0220.2f068f.004c.GAE@google.com>
 <Z-XOvkE-i2fEtRZS@codewreck.org>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <Z-XOvkE-i2fEtRZS@codewreck.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000208:EE_|BL1PR12MB5897:EE_
X-MS-Office365-Filtering-Correlation-Id: bbeed5cf-8db7-4d4a-461d-08dd6dad5830
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aU9seGZqQ2xSYUFFWkZqSXBYQkNTNEhnV3JXOURPa0M5K1dvMkNUdGdKbUIy?=
 =?utf-8?B?cEhJRTVBZVpZczVrWGlxVDNJTnZwVjJBNmRoRGhMRTc1ckVkUlVwaTRPNGJu?=
 =?utf-8?B?MUhZS2R2YWVnWWVrVXpleXBjWVlNOVdGNlhzZHhFZjlzMVVFYjUyNzZKUkFR?=
 =?utf-8?B?dGhSNVlQZmtkZjVvYmdVZHZHRmVXdGhnQWh4dEVtMXRXc3UvOXNBUnBCeDF6?=
 =?utf-8?B?elVxMStpWnpNSlRyUjI5b1pEajlLU3RoSTRQclB2b05FakRuZk9henc1cHEx?=
 =?utf-8?B?T1ByblNvSE00bGlmNklFSm55OTAyMEFGb3ZJNWJlK2RFRXVTNWVEdWN2UER3?=
 =?utf-8?B?aWpEdXJqSmRoT0ROTXVsOURzUjBxSkdhQjRnRTl3NkptRWI3eTVOQTYwZk11?=
 =?utf-8?B?SjR0Rzl5ZndLdjVyNVJrZmx3dVBmWDdZcW9jRll0NEVzYVlaTnU5NkI1WjlE?=
 =?utf-8?B?S0JpTkIyVURHYnlTdlZRYnVnSVdVeTVVZjh6UGFta2pVYVVHRG1JQXAyOHFs?=
 =?utf-8?B?cmg5VnhPQ0p3WkFwOUJITFJKTEs3YjdaamFuWVRDeXRuTzFOU2NNc1lwbDdB?=
 =?utf-8?B?OU9qMFlWdmZ3WWUzSkl3ejJGczdNUWZFQmVWNEt4bkhJVlhSVXNKZko0YzRW?=
 =?utf-8?B?RDNNdXN2TjFidW4wOEx5NVVXR1JsaVVMY2Z3SGJoOEVhMk4wQW5Gc2ovbW9n?=
 =?utf-8?B?am1ZbWg0Uys1dk05WHY5Z1l6SVhvc1Ezbzl5Z0d5bExSSkx3MVc5d0RDbDkv?=
 =?utf-8?B?clg3T2VDcEMvMjkxZmVqWnluWktGTmFtL0JOV2xQMkhuZ1Q0ZUVyb0cwQVpi?=
 =?utf-8?B?dXAwRUlrSGhSSk5rOFR0RFVQSmlzVWE3c0FjTkhMRkRKM3pPSUV6RmVOSzlv?=
 =?utf-8?B?cWhxcy9UU0loRGpyaXJBbkR5NnRmeCtQV0wvcmNzUjFQeWJnOWFpS015d0xy?=
 =?utf-8?B?RUh5dGo0UzVBWkxjdUY3Yk1tVXg4RlQ3ZGtFSFV0NitVRDNsS2tZTmU5NERB?=
 =?utf-8?B?SWkzZzJ5OVJxRGlnbCtTUEJLcjd2Z051bEVOOGFUT2lqZUQ3amJJcFYvbGs0?=
 =?utf-8?B?YWhUbGZoOU1HMzBpbHpiQ3V2WXNNN2FWa3cxU24xQnpINFRMNzNmT1V4eDg4?=
 =?utf-8?B?TDRUM0NJemFQUU5HM0d3aWtZZjdoTlRUNzc5Z0crKzVCbkMzcEh2YnJCMkNp?=
 =?utf-8?B?L2Nma0tmRGM1WTNJSFNPeVdCcHFvNU53ajE3cmUwYnFWOFM0b2xKSzJMaEVl?=
 =?utf-8?B?cDlXZ3NlZVplSkxzcDhKNGpDT2VNN3dWMlN5Mjg0aTdYWmNubXU0ZHdaUW9k?=
 =?utf-8?B?b0hhdEpoVVUxL1gwOFMwR3dDOWF0QVlucXhiM0tjTUhvYlZxSkFBOWQrQ3dR?=
 =?utf-8?B?RUlNUnBmcFVZOXU3NXZscFllYUhYcTNYV040TmRzM3U3dk95QmE3b3laL3lK?=
 =?utf-8?B?YlliQ0lOTlk4cktiNm81M3RjM3c3RFpTc2k0U2pCM1JnM2F0ZENtc1FSOXhn?=
 =?utf-8?B?YklDdGk2Z3d1Vk1sdDdic0p3OHhEU29nZXBybjBEQ3VJazFvdENpYXhYanY1?=
 =?utf-8?B?VGpZTnpuLzdqd3dNNXNNaXZGM2l0OWRDeEJUL0ZoRy9RaWNQSzE5ak9peEg1?=
 =?utf-8?B?YjlSaWtVd3dKUzNwdjAyK1hXdkUzWTI3MXJpYU82aFdxSTNFK29saFdIb0Yz?=
 =?utf-8?B?b0FLTDRlbHZ1SHh4bkVHQnVIaFVyN1dpY2orSHVmSlBTVDdLcnllQVZvWHkz?=
 =?utf-8?B?a2NLTTFUelV1d2hEWjZ5QXlyOFk1K3Q5L05vU0NFU1RSNnA5OHdxK3VZK3B6?=
 =?utf-8?B?WUQ3bG5TYkhieEpnZkNTTXF5ZnQrYWhFRUxadGI2SDN4dmZ4WGFWdXNIY0cv?=
 =?utf-8?B?bjY4TS94djhYSXBST3paWlgwZGxXUGtFdTNRNE9mM3orTjlEWWJLbFhOOFdW?=
 =?utf-8?B?QTMrQlAwZVV2VG5JL3YwYk0zM2J0bFoyQms5TzhHN3VRb2R2V0s4R2lFMVB3?=
 =?utf-8?Q?he7YMiFMaDvgLZ/5XH931TnJycgVtQ=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 04:02:23.1400
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbeed5cf-8db7-4d4a-461d-08dd6dad5830
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000208.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5897

Hello Dominique,

On 3/28/2025 3:48 AM, asmadeus@codewreck.org wrote:
> syzbot wrote on Thu, Mar 27, 2025 at 02:19:03PM -0700:
>> BUG: KASAN: slab-use-after-free in p9_conn_cancel+0x900/0x910 net/9p/trans_fd.c:205
>> Read of size 8 at addr ffff88807b19ea50 by task syz-executor/6595

Woops! Should have tested with KASAN enabled. This time I did.

> 
> Ugh, why...
> Ah, if ->request() fails p9_client_rpc assumes the request was not
> written (e.g. write error), so you can't return an error after the
> list_add_tail call in p9_fd_request.
> 
> I think you can call p9_conn_cancel with the error and return 0 anyway,
> and this paticular workaround will probably work, regardless of whether
> it's the correct thing to do here (still haven't had time to look at the
> patch here)

That works too! Thank you for the pointer.

> 
> Sorry for this mess (even if most of it predates me...)

And I'm sorry for the noise from hacking on stuff that I don't fully
understand.

Fingers crossed (and thank you syzbot)

#syz test: upstream aaec5a95d59615523db03dd53c2052f0a87beea7

diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index 196060dc6138..dab7f02dc243 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -687,7 +687,13 @@ static int p9_fd_request(struct p9_client *client, struct p9_req_t *req)
  	else
  		n = p9_fd_poll(m->client, NULL, NULL);
  
-	if (n & EPOLLOUT && !test_and_set_bit(Wworksched, &m->wsched))
+	/* Failed to send request */
+	if (!(n & EPOLLOUT)) {
+		p9_conn_cancel(m, -EIO);
+		return 0;
+	}
+
+	if (!test_and_set_bit(Wworksched, &m->wsched))
  		schedule_work(&m->wq);
  
  	return 0;


