Return-Path: <linux-fsdevel+bounces-64007-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B20BD5C20
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 20:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9B666351079
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 18:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B07D2D6620;
	Mon, 13 Oct 2025 18:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="SpfP3bH8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191a.ess.barracuda.com (outbound-ip191a.ess.barracuda.com [209.222.82.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED634C81
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 18:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760381033; cv=fail; b=P4++bLPmeIZKt26/Hk9+XpECFZYnUTyJcNM0zQLtIH+VxCmJDgE9OC/lshOnGkXOtOthYYaBbdWD62NFc5iyI/QyC09xLpR7Oo7XfqKB/iMk/6tKqapwvwkzhkU50WSJfaymD2F/z2+wdPNUToM98HL4Aq4jo5y844oMy8+KAXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760381033; c=relaxed/simple;
	bh=LZdskcYM6cxtXJ2p4P1MB4LoCzlUVayumyHD7QcNHhw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ot+x1hBZIy6JtG5dl5Ce6xi7PqIfeorfi/HbcK+gut9Fck4XWlsDN/9e3VSp9YCPvl/AhQXtFiLonO1Tc+spQ2idZ2eQ4nnOtprWMolKy9WbEsFnLP6JlgsgiZF5IZBXhrWdaMJM24vmyIi/2rBxOFhcoVO9XK4kkqKAwkKgEUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=SpfP3bH8; arc=fail smtp.client-ip=209.222.82.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022100.outbound.protection.outlook.com [40.107.200.100]) by mx-outbound14-6.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 13 Oct 2025 18:43:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FV7aITIzciOWgce1jtbARusH+waXK+YgQRqlIeybAUWF4O3STWO2NpXPBFgqXJOl2lU2tMvHmu2r+nBgSjrN1V09GHcL2sQITR3YeDa980rUDjuf7WVWoAwyOmxoR40hQ1KrPHhTRN+2XDog8/s1B9OlXQ+qHLCyRyV8vVRwTzHrzvEqltmkA8b2j7kLmI3v4iUODMiaLMqSm0UWPfjyaMBia149ol8uLLtT1YUg6Z7n8VUTRJ+HP4NJSKVnzRuBDKqbByJK8WcuGn+bawBmJqnazScvbN8mMJBLHk/1nK0RZGW15yKcQOL41Pe1cdOJhEn4sM+jmK97dw9r3QdqzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tu+IyE3hY0OULylwgdAa6D6Zx0x+DR6ia1C/pWWxuE8=;
 b=cOozfdrlq6K9lDeS9HHLQBSXr1J8zd2QKzEOgQQu20vEK3e/JGSGiAi4lRMWthMpaZKgiuNcwTcjJ8Q+6B7/U4BVVG/7GzVxPnqjpNWOSv2IzoIsYGngU62PXQxdzRolLCscT1aurzs6hp/Dsf3Jof91EWiF68Lv1PrEGE+NATy0CfrxNKO5saCU0+krdIGJbWSMnzy0NotGQ1kwSK8EC/IB8azBWqDkdohqKHSLha/+BMQhNXcGKtQvFtNtnN1mx/3eq+Qpbduok94iyj5yqOxbEGfddj9F72VmLiiemUA1MEO8UgrJn8zGS+zc0JzBCFKp7/L7cZQY+1Zj2bBu0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tu+IyE3hY0OULylwgdAa6D6Zx0x+DR6ia1C/pWWxuE8=;
 b=SpfP3bH82toEkoHRs/coZtjseKOf9QmYKYNBh6je2gohIDnigVS72lc+akM1S9B5nMAzQVPyvQWi3SMyqybHfhana9HKrzYWqHaPbMdzJKHFs59rR8uNSL3hsERcphnxsHnrfl2XNbXrD89lwsCKxO9ct7QKBERMPaZ8bpbvFLA=
Received: from PH8P221CA0056.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:349::11)
 by PH0PR19MB4808.namprd19.prod.outlook.com (2603:10b6:510:23::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Mon, 13 Oct
 2025 17:10:10 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:510:349:cafe::9) by PH8P221CA0056.outlook.office365.com
 (2603:10b6:510:349::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.13 via Frontend Transport; Mon,
 13 Oct 2025 17:10:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Mon, 13 Oct 2025 17:10:08 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id D5DF22D5;
	Mon, 13 Oct 2025 17:10:07 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Mon, 13 Oct 2025 19:10:02 +0200
Subject: [PATCH v3 6/6] fuse: {io-uring} Queue background requests on a
 different core
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-reduced-nr-ring-queues_3-v3-6-6d87c8aa31ae@ddn.com>
References: <20251013-reduced-nr-ring-queues_3-v3-0-6d87c8aa31ae@ddn.com>
In-Reply-To: <20251013-reduced-nr-ring-queues_3-v3-0-6d87c8aa31ae@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org, 
 Luis Henriques <luis@igalia.com>, Gang He <dchg2000@gmail.com>, 
 Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760375401; l=6573;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=LZdskcYM6cxtXJ2p4P1MB4LoCzlUVayumyHD7QcNHhw=;
 b=po/35EKe4gePdj5MiWIvP1q18QMPw8YsKv93LOWDfkOAliHO6zxZ89Gl5Wz3wbVa1iZIF8o25
 JtTRMNkPX+cDIR17yqz7qS8jCNOTcaEcqu4W1vZNVynYQcsUuVN0AYY
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|PH0PR19MB4808:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bb9003c-d067-4e66-5fc7-08de0a7b5cc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|19092799006|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QmxyWFdrbWtsZlBoZVlKSXlhTzcyZTNmTTBHY2pRc0FUekxmU3N1ZkpUcUJj?=
 =?utf-8?B?UytzSlkvZVBzK2ROcmZURklDNWhqZHh1ellJL1RNK3pQcVZTS3dub1FHRXRk?=
 =?utf-8?B?WnQ1T0V6S2w0VU1Rd05mYzBnTHBqL0ZHcUUxbzhqaGwzNFRzYjhZQjRORDZ2?=
 =?utf-8?B?R0J4Zy8yNXBOSDltKzdsQWpOK1l3SUx6VXZLOUpDVk42OUFXRytSVnRPT0s1?=
 =?utf-8?B?ajhxL2V6UWJPTkJUOVY3TnFhSGtQdTM3dXBxcWRZR1ozVUhXeVBIZGZ5VHNW?=
 =?utf-8?B?S1VhVmtNR1J0UzhNVWM2ZUtnVEdCSmpCRnhBSUMvODlvRHZwOUJSUDBsWGo2?=
 =?utf-8?B?bDNDK3ExNENnVElPcStOcjFuRExkQVlpMjJSUXZaTFJNdEJDVHkyT011ajRx?=
 =?utf-8?B?Zk05aXZuN0xiWGFKekZBU2VtMHRvNlRUbUpyMHFJdVh3T21wSzV5R2FXaFkv?=
 =?utf-8?B?MjRpWklOaHhjSkV3WllzV3A4VkxLbDAwYXhSMjNaWEk5V3YyYnl5S1g3aEcz?=
 =?utf-8?B?Q0RDRTVObHNDc2V3bHlNenZqc3BlUHhzYTVjaEJCaUkyTWhWZ2ZLUEJYTW1Q?=
 =?utf-8?B?c3I4UkgycU5zSFU3TmQ5UHVFTjZyTDI0ajBxYTVOek10QXp2Z3BHVEFJT216?=
 =?utf-8?B?Rlk5UncxUUYwWFJ2VitlUzdKdHVHRVovR3cyaHdEM3ZwMDFGUlFzTGpBVmdU?=
 =?utf-8?B?dTVnYWxqY09yWStxZ1ExU2dvYlJYbElPK2o5MlJiOWYyNTRDMkpaeDExZTZF?=
 =?utf-8?B?L3laSHRmQUExdEYvVUhsazBuN0xZQ3lLdnNITGY4c1doMzJtd2dFbFhpaDl2?=
 =?utf-8?B?N1dYTVQvU0o4b3BldE1OT3RIZWV1d2Erc3FnN3JPWUJUS0QrTmNUV0xYd0Zo?=
 =?utf-8?B?UDRhelZoSEF2SU5NTmhQeTFYcUJYVTNmbVVkOXZVbGppMks3TjBIcGpXTThx?=
 =?utf-8?B?TU1xWW5vbDNXN05sQ2kxeVo5U09VRUw3bU5ucUVyWStDOVJQbzhKMFBGayt4?=
 =?utf-8?B?SlRWV1dLUXNUb0w2M0plZVBGUVhBd29xVGhXRnBZRDRjemVrVC93d3NHc0ph?=
 =?utf-8?B?NThQTEF3TkdxT3VtMmluSGJZMmJpb2UwUlNlcWFOTnZ3aTFUUWI3ZGhHZGg5?=
 =?utf-8?B?akpkZFFHRjQyS0ZyUTd4TURxam5XR1VHUXdlY3gzUHBKY0hZOTRNb2VuNVA5?=
 =?utf-8?B?UHR2TUd0K3gzN2Rrbk4rajZUZ0gzRFRoWkQ1QkdkaWs0T0huMVJlYWU0NEwz?=
 =?utf-8?B?djEzSkRvZkhBZkYvWnR3eFlCV1crQmxFbHNOaDJ2aXNlNjdiR3ZxY3E1ZC9p?=
 =?utf-8?B?a25wY0hzNU91cnhyc0JEVWE5LzNmSktWczJMaXd1bVhjRmxLcGVkYTdDV2M3?=
 =?utf-8?B?T1VlVnluMDdtZ210SXRSQ2YzK25ZSkR0aGhhRFdSNmV3cDg4d0NPUkFLb0RY?=
 =?utf-8?B?UkJ0MmZVZVZlQ2pJM296S0RDNWo0c0Z4aWxiZ21wVUk3dC83M2l4RFdxUEJU?=
 =?utf-8?B?MlZsVzkrblpJS0czSWtqU2RMRTdaYmsyMjlUTGtNdFRTKytOY1owUUJxZENN?=
 =?utf-8?B?Qk5LZlhTQXJ4amhmcmIvdnFiMHpKT3NONW1HbHNWVlBXY1RxOG1lYkp5b2FH?=
 =?utf-8?B?OXVoU0IxbnBuc0RidzhPcGkrYlNFUnRqZGlXTytVUXBQZkxvS0hSeXpWcHhX?=
 =?utf-8?B?MGRVRksybzFsYWlaYXEyL0xFRUpDTlF3QXFZZGdUeExnU3paelpROGZIenpQ?=
 =?utf-8?B?NldmYlVheWRKVWFIVU52VXJoUnFDY0pmOUJ1UU15ekVFUk5WMzdkQ2lBajNz?=
 =?utf-8?B?c012amVRVllGazFDSXFyMjBGM3VpZnZiVWhCZ2J0bTUwS0RSVjZTVWloSUhz?=
 =?utf-8?B?clByM0ZrSWhFUERQYzAvL2pBYWoxZzV0amNLNXhFdmFYaE1Vb1U3KzlaOTRw?=
 =?utf-8?B?N3Q3Y2dIVExXRUZoNlRyVHV4bTZwcW13aVdlVWNoMmdnN3I3dk5IOFpIY1NE?=
 =?utf-8?B?TDlvUTZ5YkJZRjJiblY5RFNCb3B2VGRrYnoyMnRTMER5aUpyZXhLSnV0U3FP?=
 =?utf-8?B?Z3ZFd1JsQlFlRjdZTllHZXZrTG9hcnp4UUlDN001c3UvOWxxSlVCQmJHcVps?=
 =?utf-8?Q?aZA8=3D?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(19092799006)(82310400026);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	a5rRAws6BQszvAhLlaDtgfIskrhVOmiu3CYmZSlIUCifYdjUQgtZD0Bd9OeedaLhgabd5qsUfBGOkq6kUb/XHRwBYWjLgJ5bCrvMwCWU+rJDuLEBCWSZIXs6eWgKEP9TRbA/GpmP3oNg9FiN4YRhKQo05rNtyv57sxoETGZavn04+SKN5KLZgTStVD/+ifW2kfqa3V87UPVc1X0Oc6dCuF3AV7arN/Ld+UVQC3/OLdP8wXrCBJ7OIoLQ9TglOii5OLg3oiFF3zcEOIMs0bdsYoxvoBrUbQL7KcLUxQQalM6pKCr0KOqaIJdhqyOEpy88DuNajnwe17bQmTGhIsbrcA9pq+d7b1S8oKtuU1RsAyq6hwtZeFypiOQ96XwVt6YuGsOhpDOHFE5bQGr9Jhs9g7j3X6bGR9wKxDUYFYcvZJog3uxTjGCq/j4wVrZ6To4q1McLoHsJ1N1owhCxbEgjvkYQGGVocU8RF5o4d4STrxWqSMJNJuqce/Wy+elxmUKNy6QAuxRFlaDYhalS0vaurP/8vbCgWJ6Nd1D0nK3+pGfjVd2Yhtm6q0vK/+cB7/ljjJakePmxQEP+VYGbw9SPjtgqrTQUHWK6tvJQ658GcjiXbaLSr6ct/OqaTD6sXXG9nW9xhNNfJWuYvPkstPCaoA==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 17:10:08.6109
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bb9003c-d067-4e66-5fc7-08de0a7b5cc6
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR19MB4808
X-OriginatorOrg: ddn.com
X-BESS-ID: 1760381027-103590-7705-10712-1
X-BESS-VER: 2019.1_20251001.1803
X-BESS-Apparent-Source-IP: 40.107.200.100
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVmbG5hZAVgZQ0Mww1TApKdU41d
	zMNDXVMtHAwszYKNXENDnJzNIyydREqTYWAMpl1q1BAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.268183 [from 
	cloudscan12-73.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
	0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC0_MISMATCH_TO
X-BESS-BRTS-Status:1

Running background IO on a different core makes quite a difference.

fio --directory=/tmp/dest --name=iops.\$jobnum --rw=randread \
--bs=4k --size=1G --numjobs=1 --iodepth=4 --time_based\
--runtime=30s --group_reporting --ioengine=io_uring\
 --direct=1

unpatched
   READ: bw=272MiB/s (285MB/s), 272MiB/s-272MiB/s ...
patched
   READ: bw=760MiB/s (797MB/s), 760MiB/s-760MiB/s ...

With --iodepth=8

unpatched
   READ: bw=466MiB/s (489MB/s), 466MiB/s-466MiB/s ...
patched
   READ: bw=966MiB/s (1013MB/s), 966MiB/s-966MiB/s ...
2nd run:
   READ: bw=1014MiB/s (1064MB/s), 1014MiB/s-1014MiB/s ...

Without io-uring (--iodepth=8)
   READ: bw=729MiB/s (764MB/s), 729MiB/s-729MiB/s ...

Without fuse (--iodepth=8)
   READ: bw=2199MiB/s (2306MB/s), 2199MiB/s-2199MiB/s ...

(Test were done with
<libfuse>/example/passthrough_hp -o allow_other --nopassthrough  \
[-o io_uring] /tmp/source /tmp/dest
)

Additional notes:

With FURING_NEXT_QUEUE_RETRIES=0 (--iodepth=8)
   READ: bw=903MiB/s (946MB/s), 903MiB/s-903MiB/s ...

With just a random qid (--iodepth=8)
   READ: bw=429MiB/s (450MB/s), 429MiB/s-429MiB/s ...

With --iodepth=1
unpatched
   READ: bw=195MiB/s (204MB/s), 195MiB/s-195MiB/s ...
patched
   READ: bw=232MiB/s (243MB/s), 232MiB/s-232MiB/s ...

With --iodepth=1 --numjobs=2
unpatched
   READ: bw=966MiB/s (1013MB/s), 966MiB/s-966MiB/s ...
patched
   READ: bw=1821MiB/s (1909MB/s), 1821MiB/s-1821MiB/s ...

With --iodepth=1 --numjobs=8
unpatched
   READ: bw=1138MiB/s (1193MB/s), 1138MiB/s-1138MiB/s ...
patched
   READ: bw=1650MiB/s (1730MB/s), 1650MiB/s-1650MiB/s ...
fuse without io-uring
   READ: bw=1314MiB/s (1378MB/s), 1314MiB/s-1314MiB/s ...
no-fuse
   READ: bw=2566MiB/s (2690MB/s), 2566MiB/s-2566MiB/s ...

In summary, for async requests the core doing application IO is busy
sending requests and processing IOs should be done on a different core.
Spreading the load on random cores is also not desirable, as the core
might be frequency scaled down and/or in C1 sleep states. Not shown here,
but differnces are much smaller when the system uses performance govenor
instead of schedutil (ubuntu default). Obviously at the cost of higher
system power consumption for performance govenor - not desirable either.

Results without io-uring (which uses fixed libfuse threads per queue)
heavily depend on the current number of active threads. Libfuse uses
default of max 10 threads, but actual nr max threads is a parameter.
Also, no-fuse-io-uring results heavily depend on, if there was already
running another workload before, as libfuse starts these threads
dynamically - i.e. the more threads are active, the worse the
performance.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/dev_uring.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 46 insertions(+), 7 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index aca71ce5632efd1d80e3ac0ad4e81ac1536dbc47..f35dd98abfe6407849fec55847c6b3d186383803 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -23,6 +23,7 @@ MODULE_PARM_DESC(enable_uring,
 #define FURING_Q_LOCAL_THRESHOLD 2
 #define FURING_Q_NUMA_THRESHOLD (FURING_Q_LOCAL_THRESHOLD + 1)
 #define FURING_Q_GLOBAL_THRESHOLD (FURING_Q_LOCAL_THRESHOLD * 2)
+#define FURING_NEXT_QUEUE_RETRIES 2
 
 bool fuse_uring_enabled(void)
 {
@@ -1302,12 +1303,15 @@ static struct fuse_ring_queue *fuse_uring_best_queue(const struct cpumask *mask,
 /*
  * Get the best queue for the current CPU
  */
-static struct fuse_ring_queue *fuse_uring_get_queue(struct fuse_ring *ring)
+static struct fuse_ring_queue *fuse_uring_get_queue(struct fuse_ring *ring,
+						    bool background)
 {
 	unsigned int qid;
 	struct fuse_ring_queue *local_queue, *best_numa, *best_global;
 	int local_node;
 	const struct cpumask *numa_mask, *global_mask;
+	int retries = 0;
+	int weight = -1;
 
 	qid = task_cpu(current);
 	if (WARN_ONCE(qid >= ring->max_nr_queues,
@@ -1315,16 +1319,50 @@ static struct fuse_ring_queue *fuse_uring_get_queue(struct fuse_ring *ring)
 		      ring->max_nr_queues))
 		qid = 0;
 
-	local_queue = READ_ONCE(ring->queues[qid]);
 	local_node = cpu_to_node(qid);
 	if (WARN_ON_ONCE(local_node > ring->nr_numa_nodes))
 		local_node = 0;
 
-	/* Fast path: if local queue exists and is not overloaded, use it */
-	if (local_queue &&
-	    READ_ONCE(local_queue->nr_reqs) <= FURING_Q_LOCAL_THRESHOLD)
+	local_queue = READ_ONCE(ring->queues[qid]);
+
+retry:
+	/*
+	 * For background requests, try next CPU in same NUMA domain.
+	 * I.e. cpu-0 creates async requests, cpu-1 io processes.
+	 * Similar for foreground requests, when the local queue does not
+	 * exist - still better to always wake the same cpu id.
+	 */
+	if (background || !local_queue) {
+		numa_mask = ring->numa_registered_q_mask[local_node];
+
+		if (weight == -1)
+			weight = cpumask_weight(numa_mask);
+
+		if (weight == 0)
+			goto global;
+
+		if (weight > 1) {
+			int idx = (qid + 1) % weight;
+
+			qid = cpumask_nth(idx, numa_mask);
+		} else {
+			qid = cpumask_first(numa_mask);
+		}
+
+		local_queue = READ_ONCE(ring->queues[qid]);
+		if (WARN_ON_ONCE(!local_queue))
+			return NULL;
+	}
+
+	if (READ_ONCE(local_queue->nr_reqs) <= FURING_Q_NUMA_THRESHOLD)
 		return local_queue;
 
+	if (retries < FURING_NEXT_QUEUE_RETRIES && weight > retries + 1) {
+		retries++;
+		local_queue = NULL;
+		goto retry;
+	}
+
 	/* Find best NUMA-local queue */
 	numa_mask = ring->numa_registered_q_mask[local_node];
 	best_numa = fuse_uring_best_queue(numa_mask, ring);
@@ -1334,6 +1372,7 @@ static struct fuse_ring_queue *fuse_uring_get_queue(struct fuse_ring *ring)
 	    READ_ONCE(best_numa->nr_reqs) <= FURING_Q_NUMA_THRESHOLD)
 		return best_numa;
 
+global:
 	/* NUMA queues above threshold, try global queues */
 	global_mask = ring->registered_q_mask;
 	best_global = fuse_uring_best_queue(global_mask, ring);
@@ -1368,7 +1407,7 @@ void fuse_uring_queue_fuse_req(struct fuse_iqueue *fiq, struct fuse_req *req)
 	int err;
 
 	err = -EINVAL;
-	queue = fuse_uring_get_queue(ring);
+	queue = fuse_uring_get_queue(ring, false);
 	if (!queue)
 		goto err;
 
@@ -1412,7 +1451,7 @@ bool fuse_uring_queue_bq_req(struct fuse_req *req)
 	struct fuse_ring_queue *queue;
 	struct fuse_ring_ent *ent = NULL;
 
-	queue = fuse_uring_get_queue(ring);
+	queue = fuse_uring_get_queue(ring, true);
 	if (!queue)
 		return false;
 

-- 
2.43.0


