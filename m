Return-Path: <linux-fsdevel+bounces-76066-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIv3CS7agGnMBwMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76066-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 18:09:02 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC1ACF63F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 18:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3EE1F308E57B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Feb 2026 17:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E559F238C03;
	Mon,  2 Feb 2026 17:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QxygLPEf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012068.outbound.protection.outlook.com [52.101.43.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7707B3816E9;
	Mon,  2 Feb 2026 17:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770051769; cv=fail; b=WR3zquS8w8BJhl4wdo8Eat50yJbwUE2sChipkFRdLYoyaJl5fIwIipzs9spT/A5s61YtqTmZG8u/G92sykzzvaDCuZub9x2ll/sAFGVlvIQZQl1PktGe1V0CgrbuPKVLAh3mOO5bfEdZWXWylWWCAIbSQ/8ZXIQcLfx1TrNvBsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770051769; c=relaxed/simple;
	bh=XGUjRo2jojA1AFM1b9X8DUD21Bh0bb8nywNqsEjKYAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=C6Z5+hYYtndG/Tslkm+JUw2bXvBZuJ//kFas4gSNp2SGgEbLvhTQfQJ3OKkR2jGV3XOCaqTmDjJ+ge795W3u3HPewUy1FQ2fG+E6JCWUXomr9KAMKnwXNd5dCoM4KtrbW34EbXItksXbtZvSFzy8v+Dw0urul1KiwCWJfIWnqoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QxygLPEf; arc=fail smtp.client-ip=52.101.43.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cq/iM1g1wg1rqiMoKEGEjB6AzrwG+n2ZanMSLHEu5D+XkouikfH6Aht3jULJoRbcKT5g5gpx70w1JdzJXUtKRktsEsSWlINzuBBHzAudrgWIuGmtbERbh9fv71YhAseq2URrKWpHd+8pKeWpP+Bf1xYbwORMhiyOCUispi84MUHwDLTZEJr7u8hA2+3N54cwkbodBvXFYXlDttSKay9e+RYj1K2iSVJcJv+eEOEkYGddX2yLwMP/tUJVxyeC1ab6UBzz30Wb6y2dzux0xpK7kNu8noyjZd0I7hmsHZYDSEazdBH0Gx+NcZBJCVknjH2mJjIuJ8sg7/F5ZfzTF4qDzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZS3wNG1ZQrNPgkiWVP7CWSgc1UurS5y2H0Vo1LQEZrs=;
 b=BFThIP9CFOapv28LrmNaYl7MD6AsMRcYgPH4wJ+Ip5zPMVeladse92JzyaRPG54xbePDygB0FztkaTVnzeZ7VV/nr53rOn3rg0ldDhaYJWWC7gYAKz4BHh2f0YZTvkVgNFci+ZyfmBkqGkvO92TitKRyxIhntcpGKD4hdWhyXyQsFL+h3RQuiy888bR2nNLmqUAlnmtQ2zTWgg4g2aok1ghly/yY9Em/h3zun3M+L7Bkio4EUuk0TXFU7776IWKP5tZKlBNgLfm9ayWtUtm1RG3c8KtUGZzlQhZP9ZbO2KcLH/9u3JWMyq/TlrhtTiH4MGocoivgyX6Zo443q5mBSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gourry.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZS3wNG1ZQrNPgkiWVP7CWSgc1UurS5y2H0Vo1LQEZrs=;
 b=QxygLPEf+Y6DOQ9bKI39D0hhwnpU6zm9aAZ+wrSxImddBHB5jP3lAi4sqk69CTdsC6qk/I4rPu6zfRtb1pkFD/DLcZsyWvTIPsoC72ou7RB9tHFz9A9Crmxqcwi7MQa4gdOOcd8tNzq6Mo06F2S/qzN20NSntR5vUZiGh0F8JqE=
Received: from BN0PR04CA0173.namprd04.prod.outlook.com (2603:10b6:408:eb::28)
 by PH7PR12MB8123.namprd12.prod.outlook.com (2603:10b6:510:2bb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 17:02:42 +0000
Received: from BN1PEPF00006000.namprd05.prod.outlook.com
 (2603:10b6:408:eb:cafe::c0) by BN0PR04CA0173.outlook.office365.com
 (2603:10b6:408:eb::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Mon,
 2 Feb 2026 17:02:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF00006000.mail.protection.outlook.com (10.167.243.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 2 Feb 2026 17:02:41 +0000
Received: from [10.254.59.95] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 2 Feb
 2026 11:02:39 -0600
Message-ID: <9652a424-6eb1-462f-8cbd-181af880f98b@amd.com>
Date: Mon, 2 Feb 2026 11:02:37 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] cxl/core: Add dax_kmem_region and sysram_region
 drivers
To: Gregory Price <gourry@gourry.net>
CC: <linux-mm@kvack.org>, <linux-cxl@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<kernel-team@meta.com>, <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <willy@infradead.org>, <jack@suse.cz>,
	<terry.bowman@amd.com>, <john@jagalactic.com>
References: <20260129210442.3951412-1-gourry@gourry.net>
 <20260129210442.3951412-9-gourry@gourry.net>
 <c1d7d137-b7c2-4713-8ca4-33b6bc2bea2b@amd.com>
 <aX0s4i5OqFhHkEUp@gourry-fedora-PF4VCD3F>
Content-Language: en-US
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
In-Reply-To: <aX0s4i5OqFhHkEUp@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb08.amd.com
 (10.181.42.217)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006000:EE_|PH7PR12MB8123:EE_
X-MS-Office365-Filtering-Correlation-Id: 0da34349-4baa-4f6a-27a6-08de627ce0ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|36860700013|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OHVQcGM1blNWWEl0dFJuVW5PVGtyVDViRHNSTzNyK0RacCt1bUVHcjBtUEtz?=
 =?utf-8?B?d0RBNVlRWFNTcVg3cU5qTVQzV29BelY3c1Rsd3BoTjdSNFRRbWYyUHVhK0xY?=
 =?utf-8?B?S3RIRzduZ2Q4aWlaTWdaTnRLVDc3SkRsTGJYM1NQVmtTbi9yakdwS3NmU0J0?=
 =?utf-8?B?RnArMlJVcHpMU0FXMHhLTC9ZK1VkNXVLanVkZyt5VG9zdFltZ0JDaUJTV3oz?=
 =?utf-8?B?S0FFKzA2U1dMdjFqU2YzMk96Wi84VGQydFdaU2ZmcUVtL0RTWnBXeHlFV2Z2?=
 =?utf-8?B?RTQzWkY3ZHVNZlZ2SWJ5V2o5dzMwYlMzQ09JTW1INTFYbGt3WGZyM1F3aXAx?=
 =?utf-8?B?d0ZUU0FaNHNPaGN6bDdpWXNtNC9RRDZnbmRBZTRISzBPZTducnVYMWM4N1ZE?=
 =?utf-8?B?a0d3QU90VzRHMjNXT2hJREh1M0tHQjRleHZZYlUxTSs2V3ZyVVZCSGxOQjJx?=
 =?utf-8?B?aU1zVFBxUSttNlNzV0NHS202MTJqMUoxdVl0d3o5eDVNTU4xRGFCc3VsVEJJ?=
 =?utf-8?B?ZFhaeHFVcHg1ZUg0em9jTm4yUzVvZ2tSMzZCV3ErU2dtZzhndzA0MUZPWmt6?=
 =?utf-8?B?N2RUNDA2bHhWd3hZWTJnK0YyZ2NDcmdCQTl5b29JVzB2UmZ5eUdJcDJmT2wr?=
 =?utf-8?B?QUpOdDRnbjVkTHg5UnVEbllDeEJLaVZyTFR3YXNxZ1dvdytPckNXdnlCUi9x?=
 =?utf-8?B?dVdDSmdXU2gyWTV0dGJKdFkybUZlUlpKajllTUtiMktiRWl3OGRnaXVEUDFM?=
 =?utf-8?B?aUVCNGZWbzFISVNKVEd5aDRyL0pBS3dqREo2dDVLZk5xSDlETTQxaWFWSlNM?=
 =?utf-8?B?VmJsYi9CR2FmRVVtbEZmbU1zQ1I4MDJ6YytoNmpxeHpMb3VxTWtUZWJFYTZa?=
 =?utf-8?B?S1hZS0FPRzh6V0UyYkZkVU12QzZFN21POWZ4L3E1cnVVQXZ5K1hMdlVTWWJa?=
 =?utf-8?B?dnNDZFdoZmoyQXNlTjM5a01IQnVkM1d6akw3emQwMm9qMFFlRzQrWFlTNFdk?=
 =?utf-8?B?d0lkM3lzdFJYa2dWREx3a3doTDhtNmo0dUdhdHl4aDFZdjRrVmlMQlZ2cndF?=
 =?utf-8?B?SzlVMEVHekZwVDI3akRhN25SMVl2SStrR2RJOU92clFTZjNWc0JmdmFoaEpm?=
 =?utf-8?B?dW55RkJxMnZOMUNVUWQzKzhuMnhyUHVDMUdmbWdzZHpyL2hjRFdFd0U3ek1F?=
 =?utf-8?B?RTEzWEMyU0dkOFRYYWMvUDh5SlRrK1U1b24wRUU0bG1rNDBxV2FudUpmOTJn?=
 =?utf-8?B?YkdCSmxaR1FSOFRkcGFMdm5xeGxXejVIZDVHSk5zb3pjTkNVcU9IcGw4cmVt?=
 =?utf-8?B?YTBFSHRHSnFMWDhncEZDaTVyWXpCUzhBNTdEeG04M3hqYXlqc0dmSzVIMk5F?=
 =?utf-8?B?bXlObkY1alZJbk15enl2eHRvWW9RSkREQUZGQW9rd2J4bWNkR2J5WExpa01t?=
 =?utf-8?B?YlJrSzg3T3Q5T3dSY0RCaHN3M1Z6cW5waHYzK05qZ2xxbGFQN2d1YnhKbU94?=
 =?utf-8?B?VzlpSktCd2VGTFkybVlLNEFFVVlYU3EvREY3ZjUycFJQdXVaWlBydU00QnVE?=
 =?utf-8?B?c3J3aENTVkFYdzhGRVRzVGcremoybEFKWmo2cWhPWEpPdUVVK0poRm9XSkI2?=
 =?utf-8?B?dlRHRUF3TGFjdXAyK2pZTVIyYTljaXB6bWRlenN4SnhvM1M3dGx5U3pMMCt5?=
 =?utf-8?B?WURoZkxCTzlYdy9SNC9VUS90OWFucE1kWWhYY3NaSFgrSVoyUVdlWHFKYWk4?=
 =?utf-8?B?ZTdVdmF0K2t2dFg2ZWZueEN6Vm1GR0pndDBkVk1qRWJHZUpwQmlyNXptaGk4?=
 =?utf-8?B?ZjRWU2pZeFhrN2JqaERJeGJzR0crK3I5ME1oRWNPKys4dEhQR0Y3WEJLVEdO?=
 =?utf-8?B?NGJucDBzMWtEbFVPZll5NnlJYVRwakREVnIxdFlPY1JIbHRIU0dqY3ZTRVpt?=
 =?utf-8?B?aEdQd1pkWXRoRUJub1ZLUFUxYzhIMGFURjk2MjFxZHlEOVU3dFJQT2haSVZz?=
 =?utf-8?B?elBCVk5nVzgzSlZtMGtXelFXZEdlVjFCa1VGMEZBWU5ubG5tUi9BTjlTK3ZP?=
 =?utf-8?B?R3ZzMzYydnNMdmNLaGMwUTYwQTBZTGxpMGNnMzBHbjBUcXN0M2puc0JGenNG?=
 =?utf-8?B?U0ZPZWMxTUtTZVY4QStXU3Y1YmoxZ1krMFNraTNFdVg2a0ZWVFcydXhBTjha?=
 =?utf-8?B?clYyYXZLZlNybFQ1anBtdXRWaDVlVklsRHRpRDJpZmVUT1M3dExmclc3dm1N?=
 =?utf-8?B?MGVmeVpFRlgrVDBtSGM4SkUxbFZBPT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(36860700013)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	HChHCTy9IZFNnyPpZ3/DN8VKjfsgI+ZECtRztZIIvo0RLrCC4WImtgCzPsQI2nXbrqTJRgbyVtQmx1cmWWe/4monJPMnDnKIPbiWriHMwQRPkbvVD+18cLrqVU4cpwrg+EKOS3hWPDF6BPbLCb3nuwIv4ZhN6qPdPkJ8flyG8mk4tlimwqOhQjydR+4sjXU2kaUv/49cXKVR9WZyjYJUZbyRlGGUuR0drxHj0qqXnbEI4ysYiTRy/OIz8S5JeNkTUSGLJbkwG64D1FAU22xTnlO25cPFrCzMdJnKJEWnfq9KhuuXYTHr93A1wkOZQyI+Jvt7LMo6syS/ChQQmTih4AYGAzuai9LS73/Wl+CkFg1CvCCAQGFNS+bUwis8tRNCyJ2qebZUGdRQ2nQUTmYVGvUHWnBZw9CDGEwMhXps0al5PJZmiuxo9ft0huwk+Jbd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 17:02:41.7586
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0da34349-4baa-4f6a-27a6-08de627ce0ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006000.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8123
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76066-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amd.com:mid,amd.com:dkim];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benjamin.cheatham@amd.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8CC1ACF63F
X-Rspamd-Action: no action

On 1/30/2026 4:12 PM, Gregory Price wrote:
> On Fri, Jan 30, 2026 at 03:27:12PM -0600, Cheatham, Benjamin wrote:
>> On 1/29/2026 3:04 PM, Gregory Price wrote:
>>> In the current kmem driver binding process, the only way for users
>>> to define hotplug policy is via a build-time option, or by not
>>> onlining memory by default and setting each individual memory block
>>> online after hotplug occurs.  We can solve this with a configuration
>>> step between region-probe and dax-probe.
>>>
>>> Add the infrastructure for a two-stage driver binding for kmem-mode
>>> dax regions. The cxl_dax_kmem_region driver probes cxl_sysram_region
>>> devices and creates cxl_dax_region with dax_driver=kmem.
>>>
>>> This creates an interposition step where users can configure policy.
>>>
>>> Device hierarchy:
>>>   region0 -> sysram_region0 -> dax_region0 -> dax0.0
>>
>> This technically comes up in the devdax_region driver patch first, but I noticed it here
>> so this is where I'm putting it:
>>
>> I like the idea here, but the implementation is all off. Firstly, devm_cxl_add_sysram_region()
>> is never called outside of sysram_region_driver::probe(), so I'm not sure how they ever get
>> added to the system (same with devdax regions).
>>
>> Second, there's this weird pattern of adding sub-region (sysram, devdax, etc.) devices being added
>> inside of the sub-region driver probe. I would expect the devices are added then the probe function
>> is called. 
> 
> I originally tried doing with region0/region_driver, but that design
> pattern is also confusing - and it creates differently bad patterns.
> 
>     echo region0 > decoder0.0/create_ram_region   -> creates region0
> 
>     # Current pattern
>     echo region > driver/region/probe  /* auto-region behavior */
> 
>     # region_driver attribute pattern
>     echo "sysram" > region0/region_driver
>     echo region0 > driver/region/probe   /* uses sysram region driver */
> 
> https://lore.kernel.org/linux-cxl/20260113202138.3021093-1-gourry@gourry.net/
> 
> Ira pointed out that this design makes the "implicit" design of the
> driver worse.  The user doesn't actually know what driver is being used
> under the hood - it just knows something is being used.
> 
> This at least makes it explicit which driver is being used - and splits
> the uses-case logic up into discrete drivers (dax users don't have to
> worry about sysram users breaking their stuff).
> 
> If it makes more sense, you could swap the ordering of the names
> 
>     echo region0 > region/bind
>     echo region0 > region_sysram/bind
>     echo region0 > region_daxdev/bind
>     echo region0 > region_dax_kmem/bind
>     echo region0 > region_pony/bind
> 
> --- 
> 
> The  underlying issue is that region::probe() is trying to be a
> god-function for every possible use case, and hiding the use case
> behind an attribute vs a driver is not good.
> 
> (also the default behavior for region::probe() in an otherwise
>  unconfigured region is required for backwards compatibility)

Ok, that makes sense. I think I just got lost in the sauce while looking at this last
week and this explanation helped a lot.> 
>> What I think should be going on here (and correct me if I'm wrong) is:
>> 	1. a cxl_region device is added to the system
>> 	2. cxl_region::probe() is called on said device (one in cxl/core/region.c)
>> 	3. Said probe function figures out the device is a dax_region or whatever else and creates that type of region device
>> 	(i.e. cxl_region::probe() -> device_add(&cxl_sysram_device))
>> 	4. if the device's dax driver type is DAXDRV_DEVICE_TYPE it gets sent to the daxdev_region driver
>> 	5a. if the device's dax driver type is DAXDRV_KMEM_TYPE it gets sent to the sysram_region driver which holds it until
>> 	the online_type is set
>> 	5b. Once the online_type is set, the device is forwarded to the dax_kmem_region driver? Not sure on this part
>>
>> What seems to be happening is that the cxl_region is added, all of these region drivers try
>> to bind to it since they all use the same device id (CXL_DEVICE_REGION) and the correct one is
>> figured out by magic? I'm somewhat confused at this point :/.
>>
> 
> For auto-regions:
>    region_probe() eats it and you get the default behavior.
> 
> For non-auto regions:
>    create_x_region generates an un-configured region and fails to probe
>    until the user commits it and probes it.

I think this was the source of my misunderstanding. I was trying to understand how it
works for auto regions when it's never meant to apply to them.

Sorry if this is a stupid question, but what stops auto regions from binding to the
sysram/dax region drivers? They all bind to region devices, so I assume there's something
keeping them from binding before the core region driver gets a chance.

Thanks,
Ben
> 
> auto-regions are evil and should be discouraged.
> 
> ~Gregory


