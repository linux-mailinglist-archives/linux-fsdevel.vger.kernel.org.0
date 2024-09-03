Return-Path: <linux-fsdevel+bounces-28332-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C399697FD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 10:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BF9FB228F1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 08:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B001C7684;
	Tue,  3 Sep 2024 08:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="YBQngHgI";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="YBQngHgI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2053.outbound.protection.outlook.com [40.107.22.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253701C7670;
	Tue,  3 Sep 2024 08:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.53
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725353799; cv=fail; b=RaN8nLBrr+MnG+4dauDlzEk17P7PEbGIc4FSsro/gS2j0F6PDTQRPmfldhigRfkV3H9ggld9s12y33Zi0YDVsTxtKaQoD118SlMYoyeVB3IxfTwjRG84AQp4lPJzi8snXS/dfp8UMc62wbELyHHEeXVMvfxSYsIYtxU95gglLws=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725353799; c=relaxed/simple;
	bh=w+Z4AuWBwiXVU7/TscIC/vNdySX4+kUNGk90bha181w=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ybt8mwEAtQc7yRNmXwOtX0Iof3gmqnasMm4mT4nQnqMzUm+FkrsLeu2pbFWHFqb3uboL20fBz9CUIbtXujgJGHTD5daLdsBh0C/MhTM6cpnMoXpOImWS3T3ZtUIHpUD2ucs7JlUSo6W1rKZN/MPBLJjcXklPF1ReLdsaDn9ZRfw=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=YBQngHgI; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=YBQngHgI; arc=fail smtp.client-ip=40.107.22.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=fcpQ1049Hf76a+XjR9u7LlX3iUV6NKgD8TV7SAnlcmzLd0HuXNE52RrB/iagv9Kn2LfMEk1Bv0U0YtjRSpQSWNTsIxls7mobcYrVXKKrEhYE/ZFAwcXobeh1T2um66v1oUh2UCTYT11JY4Ayign4gRXSBMiufpxWB+w4jUyw1QkouMsotWr72sYcaUvcuXSD4PLsobJ1PM5IsMQ9kS5dQFGaSaTDufT7uwbZzf1BDD7bk7Bj/85yWYW/s5zpEC7/HxypEz9kzdBpjl3/9dcW//o9uCex7j0SWggjSctZvydv5hn2UU4RlrBsxEpfq+w6eqQ8T/yAmWwyHrNoz9UZXw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TM+K5DRWzHoiqfO0tTg1VWEWcBkNhd6Y7Xi2knCUkTQ=;
 b=vwwhULFr+Ou0uUwSUzAsJxrKwDvCeLCM4JO02qBk/YqYC36FFjFRcrGDPnUgXgM5O2tkAeoDN9ejNKXtkUkEvuwqBHsdQABYsKVHO9gDXRgcdFh1DiOImAp04VaKzL0AMKSOWxTJKzhkCRWQODSKARqlh/BRh3s+QKV+gm6ahchaWX1M/Mlxu1eWQ6ZHVl+dG86ypgGqKUVCOxd6wzylVptfqjMIMWxIr6036z8s3KIg40UXjLuDuaG+R4+T1VvauiANwY254V8VbG/cdcfUTflKfUf0HSZfc/egGD/aaZHjQ/xa+n1KTfrFhEUAOhNbuAflTjeshTfiEDUDXJOWPQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TM+K5DRWzHoiqfO0tTg1VWEWcBkNhd6Y7Xi2knCUkTQ=;
 b=YBQngHgII9FLkOhfJfxCEwIsD4S+CNC6qmmmwAJYr1jixrjnncu0+1amT2XujNfG+sj0OxAtqBw993wR1lmHN2YXeVnLOZc4xyLD/zvDTXE2sFWcFXaEy7AF7mkEGWTw78xYvhbYDAw03XXAp7kryma0RlY0Unp/D+kKoeQIHBQ=
Received: from AS4PR10CA0028.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5d8::13)
 by GV2PR08MB9325.eurprd08.prod.outlook.com (2603:10a6:150:d5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Tue, 3 Sep
 2024 08:56:23 +0000
Received: from AM3PEPF0000A78E.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d8:cafe::a7) by AS4PR10CA0028.outlook.office365.com
 (2603:10a6:20b:5d8::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Tue, 3 Sep 2024 08:56:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM3PEPF0000A78E.mail.protection.outlook.com (10.167.16.117) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7918.13
 via Frontend Transport; Tue, 3 Sep 2024 08:56:23 +0000
Received: ("Tessian outbound 8e666bd17457:v403"); Tue, 03 Sep 2024 08:56:22 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 32ff17592a3243b7
X-CR-MTA-TID: 64aa7808
Received: from L8d328dd1823b.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id DB430137-BE5C-4F79-A001-D03D74F67951.1;
	Tue, 03 Sep 2024 08:56:15 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L8d328dd1823b.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 03 Sep 2024 08:56:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SSrtVscTQY02DJViQNUf75xpm8w09NR2oHbCfw8s6hpy8Vekjh7e/IbpZ3oA4Y0YHWgZ2qrdfb5Lz13MLuWfBf52S8GkRtL0ybPosiN5T9omgnfaKCTI7ufHBhoRsTPNg/G65DDSd6RJ5V7OxUzdFYbYqlpsHm5gGcq6/8xD1rU7wrUUxRkmSFMm0fQ7vTj0h3Yqa/xpEIDGfMl//1Z8eZeYG74lfDEdcnT2v/DK02HUygFsotV/f4X77Oijlq0FRH5J5WjTYNXuJadIru7/WyWyGe7nLYd/oH7omnDhqqcd7Z9jZi+Hs/MjM5dGFYF1ubfVZzS17odilhJxI6jYVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TM+K5DRWzHoiqfO0tTg1VWEWcBkNhd6Y7Xi2knCUkTQ=;
 b=OizT8FpQV7aBLKuBmbcbK818lubCMQkb//OJt/UE/NhjPqYnE6k8Jg1mumpaQ6Z5JZhE7Fn1k9HVBK6X2c08BDq2VAde7+FVLl58aDfW5PD8xeYmrRyZZjNECmfuNGOiLbAa1MJkDVZrOuFNLJim27ig4rgh+HDACLx3/Sp4dU3BLDch40TSlOzi2+jTEVv+SMuh8IEWjxbb6THt2VmvUg/6SCDUBXyb01QXBUoPdXNmybRE+Y7HTz3qUIZcfSp6ViXmOF1nLgxL8OXyHAa8uPLwXgNGQ3ehYx4PG1catj+n7uFLQeCT3Pdbw5/7gpV5TVa5lK0k0T/N30XJasO0UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.67.248.234) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TM+K5DRWzHoiqfO0tTg1VWEWcBkNhd6Y7Xi2knCUkTQ=;
 b=YBQngHgII9FLkOhfJfxCEwIsD4S+CNC6qmmmwAJYr1jixrjnncu0+1amT2XujNfG+sj0OxAtqBw993wR1lmHN2YXeVnLOZc4xyLD/zvDTXE2sFWcFXaEy7AF7mkEGWTw78xYvhbYDAw03XXAp7kryma0RlY0Unp/D+kKoeQIHBQ=
Received: from DB7PR05CA0015.eurprd05.prod.outlook.com (2603:10a6:10:36::28)
 by DU0PR08MB9276.eurprd08.prod.outlook.com (2603:10a6:10:41c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Tue, 3 Sep
 2024 08:56:10 +0000
Received: from DB1PEPF000509FC.eurprd03.prod.outlook.com
 (2603:10a6:10:36:cafe::4f) by DB7PR05CA0015.outlook.office365.com
 (2603:10a6:10:36::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25 via Frontend
 Transport; Tue, 3 Sep 2024 08:56:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.67.248.234)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 40.67.248.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.67.248.234; helo=nebula.arm.com; pr=C
Received: from nebula.arm.com (40.67.248.234) by
 DB1PEPF000509FC.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 3 Sep 2024 08:56:10 +0000
Received: from AZ-NEU-EX02.Emea.Arm.com (10.251.26.5) by AZ-NEU-EX04.Arm.com
 (10.251.24.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Sep
 2024 08:55:40 +0000
Received: from AZ-NEU-EX03.Arm.com (10.251.24.31) by AZ-NEU-EX02.Emea.Arm.com
 (10.251.26.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Sep
 2024 08:55:39 +0000
Received: from arm.com (10.1.28.157) by mail.arm.com (10.251.24.31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 3 Sep 2024 08:55:38 +0000
Date: Tue, 3 Sep 2024 09:55:37 +0100
From: Yury Khrustalev <yury.khrustalev@arm.com>
To: Mark Brown <broonie@kernel.org>
CC: <Szabolcs.Nagy@arm.com>, <akpm@linux-foundation.org>,
	<aou@eecs.berkeley.edu>, <ardb@kernel.org>, <arnd@arndb.de>,
	<brauner@kernel.org>, <catalin.marinas@arm.com>, <corbet@lwn.net>,
	<debug@rivosinc.com>, <ebiederm@xmission.com>, <fweimer@redhat.com>,
	<hjl.tools@gmail.com>, <james.morse@arm.com>, <kees@kernel.org>,
	<kvmarm@lists.linux.dev>, <linux-arch@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-doc@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-riscv@lists.infradead.org>, <maz@kernel.org>, <oleg@redhat.com>,
	<oliver.upton@linux.dev>, <palmer@dabbelt.com>, <paul.walmsley@sifive.com>,
	<rick.p.edgecombe@intel.com>, <ross.burton@arm.com>, <shuah@kernel.org>,
	<suzuki.poulose@arm.com>, <thiago.bauermann@linaro.org>,
	<wilco.dijkstra@arm.com>, <will@kernel.org>, <yury.khrustalev@arm.com>
Subject: Re: [PATCH v12 3/39] prctl: arch-agnostic prctl for shadow stack
Message-ID: <ZtbPCcpuXS1M25Xn@arm.com>
References: <20240829-arm64-gcs-v12-3-42fec947436a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240829-arm64-gcs-v12-3-42fec947436a@kernel.org>
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic:
	DB1PEPF000509FC:EE_|DU0PR08MB9276:EE_|AM3PEPF0000A78E:EE_|GV2PR08MB9325:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b11e8be-691b-4707-3b9a-08dccbf64963
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?HcnvkdfnCN+k1CeAXFIy4lL6cFCmGR+jNUGaEvjUb19Uf0q5NBLX+IJ1qYKR?=
 =?us-ascii?Q?KE9ks/5nHqLPygShmSas0JNol7NYWn/W1tVMTYO/jEmwBH9Ykplr1w7JEPS7?=
 =?us-ascii?Q?dhc51Rv+9amfuogbY90UJceqNy3FCgkdSt8fY3tP5iUGq8CLrYlHEtJiv6ID?=
 =?us-ascii?Q?J1shMIxm4JBTv8drBfG8b2g5Tce4w9pNVW67C8H6TjVfOPF0VRNGUXTMoEbu?=
 =?us-ascii?Q?kHyvBfJCs+tbqE9gidboOrO6jBP7PUQbVfJwozWqoS8agD46YoQ/ZNTgwLec?=
 =?us-ascii?Q?hOJ6w/je9qH6frbWZJElKdP0j9mhBGahG7GXrGoIkAyVtukekfvsCZ1Z+zt+?=
 =?us-ascii?Q?+3afuDGtA+p6LSBlyF0hteW2FmSVrhryyj7XH8kUmaTTqEFJNcVrNveEALnS?=
 =?us-ascii?Q?utksKrEA5XqEEKD3g7n0qoA4kdp4mR1Qq5MHRmnUMVkslhgxdchAc1Kkbz04?=
 =?us-ascii?Q?WDxoJ0Pki2BPTe15CqUL2hHYOdYKC+7wVbZ3pyHtH6YEH2IGZpZSLE72cm+K?=
 =?us-ascii?Q?3MqKS3+9gNKlpoVnxZluE/kZflURjSRoCFSN6xd2qa/ykHZVzPlHakadpaYK?=
 =?us-ascii?Q?iIPNEw/mAa9H24tkQZXd5p/QowVYbQZqSbMD7ivOm2jKGQTKrYLEw4LVB17g?=
 =?us-ascii?Q?vEdKFjc6PfClipYSgN92BLxpj25y5LXcDhhQPbBvBUmoaRCHB+awcODKDrkk?=
 =?us-ascii?Q?i4uxfnk+M60qBta2K8E0/xY6Iq6bxJXilZUQxI6/+Rw46hbcoAOOQRAg6MEy?=
 =?us-ascii?Q?au2OK9hyI2nvtntgj2n37sZ4c2BG8udqfwRi7uuaH2uGWmdppxXVQRotwfGi?=
 =?us-ascii?Q?dahLOof4mR+dViLrwdzXa7C+QA8b7NnMhwM2BTkZSLcb06V5oiAH7BEasF6r?=
 =?us-ascii?Q?0NWPYVHjoRCLF9wxWknTtcW53CU6tUA63xxs+O4V4j/cqHAasqvkuABnEL4U?=
 =?us-ascii?Q?6DUEf5vsQdvyVFkLsfdzHH/IWG8lESB+OYWvlxSVnRK8x64+QGCrCXTBWlQT?=
 =?us-ascii?Q?8zi62+Z/GXBaBwYvxd/sW9u0LvsN7iAqRciPRuhBGfNI6okir5hDqWzl8ItM?=
 =?us-ascii?Q?osWbkd48IVENHDye+eAViZxnbHBgLJUA+HYo/AJu0JWcjKqBjo7u1LLP93Pk?=
 =?us-ascii?Q?nz3sBFl/ymI+OSa2ZGBXDi3a7hYdOwxVAGHqIRHj4aRJvblss8qzGjvw0lsr?=
 =?us-ascii?Q?pS0BkSWnTzS34QCXD6XFT7sAhrs/1R5eT1uEm1+VvLb77sCGhsJZemy0wVR0?=
 =?us-ascii?Q?ECEK7JrUVXKMqAwGIRR9ui/6L6P0Yz73vQ7HuwXgi7lwpkrYTUlwJEdM5qlY?=
 =?us-ascii?Q?zFKwIU7bOidrGt+3hae8o9dLjKPRUa1KbF19IYBIkDsCxsg53hLEVZOIb0M0?=
 =?us-ascii?Q?e3RuB8X67yU5yOuTFQyrTLmstCcobJ+7dxl1CQ6IqL/7FcvHScBYw1oTy4+s?=
 =?us-ascii?Q?OFAN6m8/SioqzfYfmiBbJc3pezrun2DI?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:40.67.248.234;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9276
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:10:36::28];domain=DB7PR05CA0015.eurprd05.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF0000A78E.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	ecf60331-41cd-4e9f-ad58-08dccbf641cc
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GQTDfMtUMeExquI47vzqd3BpqakpYcY9qDMJ6GYgLaXZthRU9mW+m7UjGMnR?=
 =?us-ascii?Q?agf1NdOFTsp3UIIccXfn8blI0YqdPiX6YNkgXOLuSst5InGbAdVOEDRRM9AN?=
 =?us-ascii?Q?Lxy71uL3DBZxn7ZjW0AV2q6lmldZJFq6I4Vkf0ZEm35EWSS3EZ+22Oaw7RYD?=
 =?us-ascii?Q?P1tvpopO6gf3p5cixWao5PyklactZQ1Jq4Go/VdjWlO2RWmVX6VL3ybQgxzz?=
 =?us-ascii?Q?9axYDJyYseSLODTROJy0PHPUkF7p1HP8NDSPuG3+woGajeNmseoa9sEiDgFX?=
 =?us-ascii?Q?66iDhX0Pc3Von+M09L74HN6asIcxjr6DoO2Oqf8uuRvkneDOiYIuJpCoInrf?=
 =?us-ascii?Q?Qqpfsy6PKK1E1wvmZklC8uM+H+mMxDPqm7kZBG+detSjHkotC3eNZoMFI9X8?=
 =?us-ascii?Q?6r+391NlOELmBy8Jf/UQjupUDdKfULYqPi/n0abT1Kcr6Wg8tkyU3Zd4dfEM?=
 =?us-ascii?Q?D5GOBfEVTb98R/p9QQ2jwtjFfxK4uL9bDk68J5rp4yuK+MpvRRps39XHm5K1?=
 =?us-ascii?Q?kQKB44OwAUF1IdERbaiZ4VtLqhIULMk3rSossiAGi2BjXQpzYiYY9MpcXPIO?=
 =?us-ascii?Q?bZbR3jBWIqmwO9u2Y++fjsfwoY3QsAJCypgPoqV0nLm30t89MJE966bvynrA?=
 =?us-ascii?Q?aWzVCrKYzU2Qjo7N3ztsHLOph0ETCYHl4DM8l4W1SPhpj6Vh1iPTI9JrLyKd?=
 =?us-ascii?Q?yQq46+9MB7DXTwjcLrhAFBgBfFRlYBPTEnyEfPc26Nh7YpiFeCS2dkuNavYM?=
 =?us-ascii?Q?ACZLh0Z9euSLg+W+g8mIBvM4smpna3cyss+kfhQ8c9RHtQIsmO5P9dAyTKqh?=
 =?us-ascii?Q?NAohCHek84uMOmME3E75ichuhMIcm1Zl992bzRlQ7z2FKk30CWWjfsM2lDWv?=
 =?us-ascii?Q?gj5coCtn7OhbymL1AAvsEHphVqN1ocrdzewRwCyyZGxwf4aqnB4Umxqk40FA?=
 =?us-ascii?Q?YwbNkUKLbXsIBxQA5dNIMExove8OasvcX7gQt9OhLLxKo/is/EAYSTNPxH1S?=
 =?us-ascii?Q?F0UT1u+UomB6c5on8KkgdJA0a+KxFkptuD4USXy+6pKVr/2XvpHkkejJ5xQ4?=
 =?us-ascii?Q?g5e+zicBPpzJYzZzPEt34i3LvKqdS3uBxn9f3SVJulNV9qSEw4czxxfTY9yJ?=
 =?us-ascii?Q?JSezhk8HMOQtzmGrAnJIr+zte3KNFQt0EY5+hxgFMTHh3SnTa70VnJg6yj8z?=
 =?us-ascii?Q?6JDaK/AxdTznDEjm8ozeXKYjiblfbxtCwBJU3LOkqnMp6QdfTJxxdYwcLzuG?=
 =?us-ascii?Q?X+HrLEO9GkKc1TR7n8xzeJouUixEvGziJL9E/SibiAciBl9WgPs7V8sWa5b0?=
 =?us-ascii?Q?jRN7DXMRqdjurwsjNKqO42Pf8Aspf+nZAmG0w9TSyX4tJij/Yq0HCqcv5gUD?=
 =?us-ascii?Q?HrycmMLIWJk1A0XuXd6jjZ0IjoSJZb6FGTfSjbIziufaIoAc6sWVRwjhcvtu?=
 =?us-ascii?Q?HWkVS1wuDSEwywvhHSi4oUebKYezk917?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(35042699022);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 08:56:23.2152
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b11e8be-691b-4707-3b9a-08dccbf64963
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A78E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB9325

On Thu, Aug 29, 2024 at 12:27:19AM +0100, Mark Brown wrote:
> Three architectures (x86, aarch64, riscv) have announced support for
> shadow stacks with fairly similar functionality.  While x86 is using
> arch_prctl() to control the functionality neither arm64 nor riscv uses
> that interface so this patch adds arch-agnostic prctl() support to
> get and set status of shadow stacks and lock the current configuation to
> prevent further changes, with support for turning on and off individual
> subfeatures so applications can limit their exposure to features that
> they do not need.  The features are:
> 
>   - PR_SHADOW_STACK_ENABLE: Tracking and enforcement of shadow stacks,
>     including allocation of a shadow stack if one is not already
>     allocated.
>   - PR_SHADOW_STACK_WRITE: Writes to specific addresses in the shadow
>     stack.
>   - PR_SHADOW_STACK_PUSH: Push additional values onto the shadow stack.
> 
> These features are expected to be inherited by new threads and cleared
> on exec(), unknown features should be rejected for enable but accepted
> for locking (in order to allow for future proofing).
> 
> This is based on a patch originally written by Deepak Gupta but modified
> fairly heavily, support for indirect landing pads is removed, additional
> modes added and the locking interface reworked.  The set status prctl()
> is also reworked to just set flags, if setting/reading the shadow stack
> pointer is required this could be a separate prctl.
> 
> Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>

Acked-by: Yury Khrustalev <yury.khrustalev@arm.com>


