Return-Path: <linux-fsdevel+bounces-45037-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F18A7083E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 18:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB27318959B5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 17:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5B826159B;
	Tue, 25 Mar 2025 17:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="JTZCAIoG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191a.ess.barracuda.com (outbound-ip191a.ess.barracuda.com [209.222.82.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70062627F9
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Mar 2025 17:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742923812; cv=fail; b=Fvoaix7Zago7VddqHj3sYWB/lb3860/mHMYY6875iNJprDMYqnSHDMi0HBAAwymIKu5fZPse21ipP+jCslFgZzGqlU6UIdGNsEe5JWRSAqMYh6PfRGob5xbI3qdUWq3QmqNyeBHIVjP0hSBGhEW75XPqwdPbBpsdRcMefIIDSqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742923812; c=relaxed/simple;
	bh=kvCsFRDbEHAu0kI0NbiIbsR+6aYgpBGxf1KRCGoiJ88=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jxDsh13ne+Fno1qDRSPyCXUgrcYOELli3fushrZuViQ2b+6x5PHov96B652itQKO8Umt4L8iZCWhLMEbnT70PhiIIg4K2GV5ra33r8/Z26vE6xpH1FE+bQou/kKQHwAXoxiIfoe5dyvn4qNqLMyHY0/SCiEYKTdO6dFPMa+hV44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=JTZCAIoG; arc=fail smtp.client-ip=209.222.82.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2041.outbound.protection.outlook.com [104.47.70.41]) by mx-outbound11-18.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 25 Mar 2025 17:29:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r39ke8YTULUkfGySzL66nD1HaK9ZVzokn7vNKIV+epyStjwCpjFvK6igvOxQ0DFdk0xQ8OzfOY+uQvESZIbzyQ3Yegh2xcpoS0+P3ht/UvkEsgiJ0bDp5H4Gg95gEoIvu3GOKN5V0ojGVEx3r9yElK6vKCIoq+oxnvtjPZmzRnAmInX1T5uEJtBlIoa9faURMPGHuqUkfjOpI2Fw7JTkTnkrFd/TgKC7dvteAmNckWUzb6YNQD98Qf1mX5zTQYBtcZKWmBRf0Re1VqAgYzEmVRGCmW8ICGjKfAKx/5SXiUZIFDZ0T6BD1Yp4hhUC/N/o/RB47ReYgTvAVaMEHD9g2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kjlJoUOPxfx5PNiga6Y2h5lABFn1hYVfOQBa6pvd6GE=;
 b=V+sf/8z1By62/NK2I2eFdR/Nh9/rA/yWAbDE0zUxOSBnZaEXl7e/Jk8ElKcbxhH4fpHi41IUhi4jz1rgm+KV6YT+ht1wnB6cdqTP+iCF3Ru54AE/kPuDV3avAHCWpX7NyejQ70RaLJaEBucOhABM3a/OrasPbbRi4GdaSvs0OuVcXuWN4Cchz0cZVoSVSpbfzDHjlN7KEM1ZNRTcFs0R949ie9XIVgbr1DY9dWx45Kx4LE6SKBNWY6VTqW1jtflMfmUF3dyCKtJcekD94K4Ummgbdvtje1CmRioS3LanbF/rxSexlLMjbODrc7jkBhfMz6NebmNuC2CMo3ennMsmEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kjlJoUOPxfx5PNiga6Y2h5lABFn1hYVfOQBa6pvd6GE=;
 b=JTZCAIoGTY611hkO9slBi+0OVaFjuXhEv9xzo2RMRTNiEilxV7BeNP6k2IUzyMeeEqUHN+CMF7tMR34q0I4QS8mO6PEvsW4roZ/fr6vIvbd8GtKCjPF9XrX33U/964kCvwD/bX0jo9xzhOMwJYjllI2zVccwaxOfuwyfg5Pfc9o=
Received: from CH2PR18CA0049.namprd18.prod.outlook.com (2603:10b6:610:55::29)
 by MW5PR19MB5554.namprd19.prod.outlook.com (2603:10b6:303:193::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 17:29:39 +0000
Received: from CH2PEPF0000013D.namprd02.prod.outlook.com
 (2603:10b6:610:55:cafe::2e) by CH2PR18CA0049.outlook.office365.com
 (2603:10b6:610:55::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.43 via Frontend Transport; Tue,
 25 Mar 2025 17:29:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 CH2PEPF0000013D.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.20
 via Frontend Transport; Tue, 25 Mar 2025 17:29:38 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 8E1EE4A;
	Tue, 25 Mar 2025 17:29:37 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Tue, 25 Mar 2025 18:29:31 +0100
Subject: [PATCH v2] fuse: {io-uring} Fix a possible req cancellation race
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250325-fr_pending-race-v2-1-487945a6c197@ddn.com>
X-B4-Tracking: v=1; b=H4sIAPrn4mcC/x3MQQqAIBBA0avErBN0pKiuEhGio83GYoQIpLsnL
 d/i/wqFhKnA0lUQurnwmRuw78AfLidSHJoBNQ4azaSi7BflwDkpcZ6UJTtiRIzWzNCqSyjy8x/
 X7X0/3VL1wmEAAAA=
X-Change-ID: 20250218-fr_pending-race-3e362f22f319
To: Miklos Szeredi <miklos@szeredi.hu>, Luis Henriques <luis@igalia.com>
Cc: Joanne Koong <joannelkoong@gmail.com>, Jeff Layton <jlayton@kernel.org>, 
 linux-fsdevel@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>, 
 Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742923777; l=7320;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=kvCsFRDbEHAu0kI0NbiIbsR+6aYgpBGxf1KRCGoiJ88=;
 b=poZlBkeZfV8Za2tVsmtG7lGYrv/n0sxS045iX4kZ+OgJJzzo5j1svVDRMoaRmYd++WAphb5/x
 Tk0Ab6im6t4DRvAc6pnLmtF0/m3PN9/+uxt0vo3Ld4iMH59UEP4ipR+
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013D:EE_|MW5PR19MB5554:EE_
X-MS-Office365-Filtering-Correlation-Id: c1f4b704-de63-4a3b-3113-08dd6bc29eb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q20zSGRURjFHQXFObFZzM1lxOXZtZFdvUEV3MGNWVm4yZDE2MzFTaHI3ZmZ0?=
 =?utf-8?B?RFZHaXdEUC9ralJsZGFNUnl3RUFoN0JnaVBCVDRwZFVTaWNrcWhnS3lXc3hD?=
 =?utf-8?B?RmI2VHlsRnUrUjJhOEJKdVFvVHZpTkY0c2VBNWlZT3ZTM1UwdlhxTTFzN0Ri?=
 =?utf-8?B?SUpaS3N0WXJjdlJlLysxMlFWV0dxT2o3MG5mWnJ5NUVadmZPK0ZsT2tDaG9V?=
 =?utf-8?B?SW4vcCtOdWRLM1MxNHE0ZjlxQjRlQlIwcmxpQnJ6WVZDcXdGa2FUU0lhVDJm?=
 =?utf-8?B?NUN0OEo1U0hmcnUrQnI4Yllld3ljaFg0MXZHaTE2anR5Znp3aDVSWjJLTVM2?=
 =?utf-8?B?K1RWMFpBWTRTZFVXQUVsUG1ZeURUT2RVMmlxRUVVTWRYMlFjQ09kOHZDdmV3?=
 =?utf-8?B?a1REQ0IzYmcrQlJoSnZpMDRlKzMrSWx3K3RBK0Q2U0hPVVpGeDdjMVhWQk8r?=
 =?utf-8?B?MzBSUy9HZVBKLzlJUDZSS3h4VEVaUm8xVUs4eXlCS3B1Rk9JNGpFYmpuMnFl?=
 =?utf-8?B?S0NWdENUZkNzTjhNMklPY0dOcEx6WFRSUVMvS3N2ZmxZRUIwUVZEUmZONHI4?=
 =?utf-8?B?eE9BemRpV3NTV0Zmb0tUMGJnYnBrelJIQ0RBdWcwMjh2WXpNdEFFTE5KdUYx?=
 =?utf-8?B?dElaY3NmVFhHK3dUSDlmT0dwWkhFUGFlVTFJZm00WkxreEQ5TWJuNXBRd09X?=
 =?utf-8?B?VzRoQ0RLb3o5VlFML2pWYWtRNFoxay9tSXRVWGtsTmtmU3ovb09ONFM2azRn?=
 =?utf-8?B?V0xBZmtLaE5mUUZZckJnVVV0UldITGlPYTVjdjBCbXpUK1Z4YTgzZ01XNVAz?=
 =?utf-8?B?V1JEK3FQNHJZRHhvVHhBaGtWR3FKaVY4QW9wOC9HSC9rZFAxVTlXbC9XaEhT?=
 =?utf-8?B?WUdKREVVdDZGQmsrUUwxdDVoVHNUMDNSY0E4eWlEbGVWM3VVdzF6cVZPWFQv?=
 =?utf-8?B?UjNrMlFIVk1EN1QrbFI5YXB1bURUd3dpZWx0a2RxeHhaVHJLNyt4ZU4zV1lk?=
 =?utf-8?B?b29xR25ROFEzcGVMZ3hiTEZrWkx2QzQ4Y1FnRVFJb01Bb0Z0WlVxVnd3OEx6?=
 =?utf-8?B?VmtUU3YxYU5FRFFxU2ZzTC9lUjVJVmM1VklrSFhyTjlFZjRuSDJ6eHNFSGNO?=
 =?utf-8?B?ZGhzVmdqQ2l4RFhqTDA5L1NWRXlWT01LclhydGdRcFV1ZHpGVXJWKzF4a1lE?=
 =?utf-8?B?ZXYwZ0xERkp5QlFTMW9MVzVzMVppMGFsRGJwNW1IUWVoQVp4a0F6Z3EvV2p3?=
 =?utf-8?B?TEFodzhRbUYza0w2UHdCMXQ5SnhvUTVDK0czTFJ1MHpabTFYZE9jZ2tpNEx1?=
 =?utf-8?B?R3IxU2JocHRnOVcxeG5GMjVrL0I2VGtUZzQ0a2ZzeVB1WmY3TjBjNTQ5cmtq?=
 =?utf-8?B?QytZMmI2WStWTzVHcG16a1cwVFN6aTJCZ1lodjVtUnJhRU9vK3owMFVHeFlN?=
 =?utf-8?B?cHNMS2ZjUEtJdEkxZno4bzZwdXZWamRoMnplRHBvbkRGTUJEQ01nbW1zNC9L?=
 =?utf-8?B?ODNYVmJwcElHTUVUYUcrWkZObU44R04zNWtwMXhJYnFLdlR0Nlh3MnlUeU4z?=
 =?utf-8?B?T3BuMGw5Zk41bHNETjVVeVZlQjgrWlc3OG4wRHIvV3V6cXVDc3J2M1lvVTkx?=
 =?utf-8?B?UW9UVjRQVjdoQU8zSlhTRktsOVV4Z2dPc1ljVDlhbDJDVWJHUnRxZHJkSEFQ?=
 =?utf-8?B?K0VCajdIazVjcGdBQTF0SjJTRFJZRU1Tb0NwVFR3a0lLSGxCbG5zSTFvcjNx?=
 =?utf-8?B?TU1sQW1Sd2hhU3dBK3h0WWV0ck1GdEFRYURHYTBwNGZsbzlMWUxZS0oxVkFG?=
 =?utf-8?B?MVpCeWJVMmpNTXNidjBtSzV3akxGaVIxdnVYa3J1WVI1T2Rub2NpMjRMVU1r?=
 =?utf-8?B?Z0dnaG4zbnl3RWw5OWpvTDNaV2Q3V1dWUnB6VFBNdkQ5amdOaHcrbjB6dHQ2?=
 =?utf-8?B?TXltcWdXeTVrVEVkenQ4UHZRRjVIMTg2aU1tbWVrWm5zdU9FQkkrc1JndVhC?=
 =?utf-8?Q?bxavnpxCa2vTtDhNYRkB8luvHQdBhY=3D?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0AUtboAXAQQCSpmEBMBKGrC7hykRN80WPb629vEih8qqNqeg/FedfDgfeSWqMZL1ekhmPiuJjjlyupzFNH1KyRCfgVjllo417/TyBSgzw8h/+iPUumZDFNa98Zc1JbNcDWb6OPIHfosjSGclFR7g+UQdQ0XB3wlsKgGu5JFy4fAjYl3FsxFYcekItfWEuj6r5gDmKR/ZIsXxqqIepeQbiGsz9qPLaMxHR2aJdHkUyUb+MSabaWJ+TpTTl8iPEAuaj6OdvcVSUymg7r3E8Dg5kTgCeDv9W1IJ0hXk7phRENu8GVhaF36Xybc1pLcgwIKvlxX4uNJWljKOYOesDYXsZxA005NXgW2IJXGcIndg42i9eNTLhny6sHk8QOSMF5zkn7j0D2WPFvlMPYHucRjAN8p0vXQ+/H2sJY2lGbpwD+iaQ8s3/FhoQJGL7+wIkK3oBeABnUFGasaOiNR0qRMIlate/1b6HldKvoBVDVSYfShBNUBDM30NYByw7rp8KXd5u3dCz5aDEhKyy2t6OtsmXGrk8tm/dt5fXCYQiw1WUQmQautTUW6dUMjgR9JpwA3rXYVFpvcc2qwLRjc1IHTMEhEAXlAi7Igjwm3cmQlJLtgr4HkKUIER7q8z9E94d4y/MeQHlUJBw/3cGvjXcsCdog==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 17:29:38.5080
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1f4b704-de63-4a3b-3113-08dd6bc29eb7
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR19MB5554
X-BESS-ID: 1742923782-102834-8473-9928-1
X-BESS-VER: 2019.1_20250319.1753
X-BESS-Apparent-Source-IP: 104.47.70.41
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVuYGluZAVgZQ0DzJNMkw0cLMMi
	3NzDQ1zSLRyNwkOck8ydgkMdHI2NRcqTYWAMk6XNlBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.263412 [from 
	cloudscan22-57.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

task-A (application) might be in request_wait_answer and
try to remove the request when it has FR_PENDING set.

task-B (a fuse-server io-uring task) might handle this
request with FUSE_IO_URING_CMD_COMMIT_AND_FETCH, when
fetching the next request and accessed the req from
the pending list in fuse_uring_ent_assign_req().
That code path was not protected by fiq->lock and so
might race with task-A.

For scaling reasons we better don't use fiq->lock, but
add a handler to remove canceled requests from the queue.

This also removes usage of fiq->lock from
fuse_uring_add_req_to_ring_ent() altogether, as it was
there just to protect against this race and incomplete.

Also added is a comment why FR_PENDING is not cleared.

Fixes: c090c8abae4b ("fuse: Add io-uring sqe commit and fetch support")
Reported-by: Joanne Koong <joannelkoong@gmail.com>
Closes: https://lore.kernel.org/all/CAJnrk1ZgHNb78dz-yfNTpxmW7wtT88A=m-zF0ZoLXKLUHRjNTw@mail.gmail.com/
Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
Changes in v2:
- Removed patch 1 that unset FR_PENDING
- Added a comment as part of this patch why FR_PENDING
  is not cleared
- Replaced function pointer by direct call of
  fuse_remove_pending_req
---
 fs/fuse/dev.c         | 34 +++++++++++++++++++++++++---------
 fs/fuse/dev_uring.c   | 15 +++++++++++----
 fs/fuse/dev_uring_i.h |  6 ++++++
 fs/fuse/fuse_dev_i.h  |  1 +
 fs/fuse/fuse_i.h      |  3 +++
 5 files changed, 46 insertions(+), 13 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 2c3a4d09e500f98232d5d9412a012235af6bec2e..2645cd8accfd081c518d3e22127e899ad5a09127 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -407,6 +407,24 @@ static int queue_interrupt(struct fuse_req *req)
 	return 0;
 }
 
+bool fuse_remove_pending_req(struct fuse_req *req, spinlock_t *lock)
+{
+	spin_lock(lock);
+	if (test_bit(FR_PENDING, &req->flags)) {
+		/*
+		 * FR_PENDING does not get cleared as the request will end
+		 * up in destruction anyway.
+		 */
+		list_del(&req->list);
+		spin_unlock(lock);
+		__fuse_put_request(req);
+		req->out.h.error = -EINTR;
+		return true;
+	}
+	spin_unlock(lock);
+	return false;
+}
+
 static void request_wait_answer(struct fuse_req *req)
 {
 	struct fuse_conn *fc = req->fm->fc;
@@ -428,22 +446,20 @@ static void request_wait_answer(struct fuse_req *req)
 	}
 
 	if (!test_bit(FR_FORCE, &req->flags)) {
+		bool removed;
+
 		/* Only fatal signals may interrupt this */
 		err = wait_event_killable(req->waitq,
 					test_bit(FR_FINISHED, &req->flags));
 		if (!err)
 			return;
 
-		spin_lock(&fiq->lock);
-		/* Request is not yet in userspace, bail out */
-		if (test_bit(FR_PENDING, &req->flags)) {
-			list_del(&req->list);
-			spin_unlock(&fiq->lock);
-			__fuse_put_request(req);
-			req->out.h.error = -EINTR;
+		if (test_bit(FR_URING, &req->flags))
+			removed = fuse_uring_remove_pending_req(req);
+		else
+			removed = fuse_remove_pending_req(req, &fiq->lock);
+		if (removed)
 			return;
-		}
-		spin_unlock(&fiq->lock);
 	}
 
 	/*
diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index ebd2931b4f2acac461091b6b1f1176cde759e2d1..add7273c8dc4a23a23e50b879db470fc06bd3d20 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -726,8 +726,6 @@ static void fuse_uring_add_req_to_ring_ent(struct fuse_ring_ent *ent,
 					   struct fuse_req *req)
 {
 	struct fuse_ring_queue *queue = ent->queue;
-	struct fuse_conn *fc = req->fm->fc;
-	struct fuse_iqueue *fiq = &fc->iq;
 
 	lockdep_assert_held(&queue->lock);
 
@@ -737,9 +735,7 @@ static void fuse_uring_add_req_to_ring_ent(struct fuse_ring_ent *ent,
 			ent->state);
 	}
 
-	spin_lock(&fiq->lock);
 	clear_bit(FR_PENDING, &req->flags);
-	spin_unlock(&fiq->lock);
 	ent->fuse_req = req;
 	ent->state = FRRS_FUSE_REQ;
 	list_move(&ent->list, &queue->ent_w_req_queue);
@@ -1238,6 +1234,8 @@ void fuse_uring_queue_fuse_req(struct fuse_iqueue *fiq, struct fuse_req *req)
 	if (unlikely(queue->stopped))
 		goto err_unlock;
 
+	set_bit(FR_URING, &req->flags);
+	req->ring_queue = queue;
 	ent = list_first_entry_or_null(&queue->ent_avail_queue,
 				       struct fuse_ring_ent, list);
 	if (ent)
@@ -1276,6 +1274,8 @@ bool fuse_uring_queue_bq_req(struct fuse_req *req)
 		return false;
 	}
 
+	set_bit(FR_URING, &req->flags);
+	req->ring_queue = queue;
 	list_add_tail(&req->list, &queue->fuse_req_bg_queue);
 
 	ent = list_first_entry_or_null(&queue->ent_avail_queue,
@@ -1306,6 +1306,13 @@ bool fuse_uring_queue_bq_req(struct fuse_req *req)
 	return true;
 }
 
+bool fuse_uring_remove_pending_req(struct fuse_req *req)
+{
+	struct fuse_ring_queue *queue = req->ring_queue;
+
+	return fuse_remove_pending_req(req, &queue->lock);
+}
+
 static const struct fuse_iqueue_ops fuse_io_uring_ops = {
 	/* should be send over io-uring as enhancement */
 	.send_forget = fuse_dev_queue_forget,
diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
index 2102b3d0c1aed1105e9c1200c91e1cb497b9a597..e5b39a92b7ca0e371512e8071f15c89bb30caf59 100644
--- a/fs/fuse/dev_uring_i.h
+++ b/fs/fuse/dev_uring_i.h
@@ -142,6 +142,7 @@ void fuse_uring_abort_end_requests(struct fuse_ring *ring);
 int fuse_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags);
 void fuse_uring_queue_fuse_req(struct fuse_iqueue *fiq, struct fuse_req *req);
 bool fuse_uring_queue_bq_req(struct fuse_req *req);
+bool fuse_uring_remove_pending_req(struct fuse_req *req);
 
 static inline void fuse_uring_abort(struct fuse_conn *fc)
 {
@@ -200,6 +201,11 @@ static inline bool fuse_uring_ready(struct fuse_conn *fc)
 	return false;
 }
 
+static inline bool fuse_uring_remove_pending_req(struct fuse_req *req)
+{
+	return false;
+}
+
 #endif /* CONFIG_FUSE_IO_URING */
 
 #endif /* _FS_FUSE_DEV_URING_I_H */
diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
index 3b2bfe1248d3573abe3b144a6d4bf6a502f56a40..2481da3388c5feec944143bfabb8d430a447d322 100644
--- a/fs/fuse/fuse_dev_i.h
+++ b/fs/fuse/fuse_dev_i.h
@@ -61,6 +61,7 @@ int fuse_copy_out_args(struct fuse_copy_state *cs, struct fuse_args *args,
 void fuse_dev_queue_forget(struct fuse_iqueue *fiq,
 			   struct fuse_forget_link *forget);
 void fuse_dev_queue_interrupt(struct fuse_iqueue *fiq, struct fuse_req *req);
+bool fuse_remove_pending_req(struct fuse_req *req, spinlock_t *lock);
 
 #endif
 
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index fee96fe7887b30cd57b8a6bbda11447a228cf446..2086dac7243ba82e1ce6762e2d1406014566aaaa 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -378,6 +378,7 @@ struct fuse_io_priv {
  * FR_FINISHED:		request is finished
  * FR_PRIVATE:		request is on private list
  * FR_ASYNC:		request is asynchronous
+ * FR_URING:		request is handled through fuse-io-uring
  */
 enum fuse_req_flag {
 	FR_ISREPLY,
@@ -392,6 +393,7 @@ enum fuse_req_flag {
 	FR_FINISHED,
 	FR_PRIVATE,
 	FR_ASYNC,
+	FR_URING,
 };
 
 /**
@@ -441,6 +443,7 @@ struct fuse_req {
 
 #ifdef CONFIG_FUSE_IO_URING
 	void *ring_entry;
+	void *ring_queue;
 #endif
 };
 

---
base-commit: 81e4f8d68c66da301bb881862735bd74c6241a19
change-id: 20250218-fr_pending-race-3e362f22f319

Best regards,
-- 
Bernd Schubert <bschubert@ddn.com>


