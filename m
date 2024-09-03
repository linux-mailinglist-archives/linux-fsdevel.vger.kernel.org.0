Return-Path: <linux-fsdevel+bounces-28333-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B93F996980C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 10:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E79F0B24507
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 08:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803F61C768F;
	Tue,  3 Sep 2024 08:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="hAAXfIWH";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="hAAXfIWH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2069.outbound.protection.outlook.com [40.107.22.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE70C1C766F;
	Tue,  3 Sep 2024 08:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.69
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725353914; cv=fail; b=HTrm5dgu4AVqnbXuWugYck9JJxos6LWS9IA4hY6gShwVJhI2KxjiRp/h6aWOOsK60mRJow3DYIr/86x4vvZZfwkqMAsG08fOMqwtQia6y1MnbfEFmPjurIuqXb39yRFHos6G15rv24yuLGvb+fNunznCCk3vHzF32aq+r/jSsG4=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725353914; c=relaxed/simple;
	bh=TQ7DFScFh0MIWGA3e03XKMWPEzT8cpmJVsvC4tKOetw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NnZyq9NOoch8I+u+9I4hGn30F8qzQm4PzorhmrXuYxKENZfSMRq6uMFB4SEj7dKn4UA+/8LqYchL6Y0CnOCHDZnr7UT+zEru97RWrR3wqN0ORZV/BGW9Zxn+5TxpbIMMSpNchkNeP3BKBuooeWJ7vUzaOSNp9/VU6AGXRIM5bX0=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=hAAXfIWH; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=hAAXfIWH; arc=fail smtp.client-ip=40.107.22.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=hllZIyNeO4GHFBBWsVSMqjylcYXQ3zSXUsB3jgEHJVV+k5mWhJGRFexKzV3fD+lqvEYcg9j1lexB3eH01pcoi1qSZjmL483rGe+q/lCRs4DPTQl/39uB0Z2GLxMges2kHb2ruMThAf8f+7i60+fFN1bCh81QbInXNVevWklyqs+Tl9GaqMAJtNNlX48SZJLY5ciT54todE512boXylslbp2yENnp1VtU6PFMHMN99iIlo+84qO9XeAQxwdYOKlsJGGIf+BSa+6rDqCYqGrk+Sy7Jqx7tkudQngelR+PHNa5pPv68wxTt5mEjPR/ABp6OszQzRPQGbbaavQpX6w6l/w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rDPnBQ5WQExdmdTq2J+jt8c83OWFnlkbUSI3uxGQlRI=;
 b=N6h/O4r4UL2XPQyFbB6HKuTFwYj7bsvXbHMiT3lx3qfTyqrBPGfP7zCneP9vwMmItccHdI9go6UIj0QVbFgiaI+T+bdxij3UxEO8AKrGj53llacQ3Tf1/emz8nhT5Rq1VzZTz4Gfi84Nm948RqEEWhb7YV00EUONhNr7SoJ9GZMzzRjOP8lgHZRMwDxnQYnO///fLSP1mNNOfJ9K1y2xHfm5+EySVk/6lHH8Rr0I7wboCJklt8QW0rs2nvfoilL/a3GgZz30Anp38Gm2HzmgyL6lubnvGIvm0NU409QE1W+YJW+m1DsDCSVSv+DYNharVLhJSY4l351gAUpwnHISHA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rDPnBQ5WQExdmdTq2J+jt8c83OWFnlkbUSI3uxGQlRI=;
 b=hAAXfIWH3PMoljOa5RffWnP05U+m1WrNEPX0Z+8SRJjBNSfZwJGVsg5s0R3tTKWYQ003BiUmisRTV89hzAlkM2Cbfw2YxAq7jSUyHQXFKJrq5LFgeNXesBL4GsQAOGLKYi7chaTC6v6hWPqEa5KgvH4BKIilqdWCOoRA95bqQmE=
Received: from AM8P251CA0028.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:21b::33)
 by GV1PR08MB10749.eurprd08.prod.outlook.com (2603:10a6:150:16b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 3 Sep
 2024 08:58:21 +0000
Received: from AM4PEPF00027A69.eurprd04.prod.outlook.com
 (2603:10a6:20b:21b:cafe::c4) by AM8P251CA0028.outlook.office365.com
 (2603:10a6:20b:21b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.26 via Frontend
 Transport; Tue, 3 Sep 2024 08:58:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM4PEPF00027A69.mail.protection.outlook.com (10.167.16.87) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7918.13
 via Frontend Transport; Tue, 3 Sep 2024 08:58:21 +0000
Received: ("Tessian outbound 22f8cf4ed816:v403"); Tue, 03 Sep 2024 08:58:20 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 115f304ca2b5859b
X-CR-MTA-TID: 64aa7808
Received: from L189e57c3c988.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 77C2C8A8-FA91-4518-A25D-E5AA8E83FC95.1;
	Tue, 03 Sep 2024 08:58:14 +0000
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L189e57c3c988.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 03 Sep 2024 08:58:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NnERChSZEnshZMnz8CLMKYYPzJEWh0k0rwlQmK/IJwsCHFnie5Qs3mCZtKmRejlOHT3fOgDQxXMbla+aLv8Lgs/qnFGsyqBFgAsWmRWFPMVTpZfLfPrKu0GFmPcMeICRiAMCMjO6pH3Ityv+jIiy5djg/l8z318bAE5IJk2QlYN5LXD9jaDdBuzImlX0oNeIXwO1PV7lRczYYUyEKI75XYdQaHU/8i2H3eub5KI4exuu2Sd32ESf6ZVeqRvSrdVmJL0lI0FVPQwaY8102ei53UVvFUKlkzkgg+ZKQdnIQDMmBJKbziNzMS9YTviy/w8jPw6wUCmIMHImTnmlQdNiMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rDPnBQ5WQExdmdTq2J+jt8c83OWFnlkbUSI3uxGQlRI=;
 b=xIOHHW9IlnIHPKndTl45gSGLgAiEopFaKlXXzvhawUCxGp8bOaoMyTYAxtPSBvotq3zpnV55h6UaU3TtLkUN48ndMdJ8EeYQSH09fmPpfquYPevYqITQgvjAnMy8SkSl8xzcfdoOBws2BQ8msDpkXbE5nVwBI9zwBqG0piRq3KYhm2ds5H7WKGQRW29koi62GanjEcj9i9Yr7yBmEuZ2kxs2KYLSdNPz0+XFMEIm+UKRu6HKjm78dUgBNgu3T/r8newFEvb7wCHb61dNcOY5mZ8Kjn4DQ7ouL+dmm6u5cDSHs4YDZnvYVqqIl0R9GstAc4smnGaxYsR8QwaHfSZrMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.67.248.234) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rDPnBQ5WQExdmdTq2J+jt8c83OWFnlkbUSI3uxGQlRI=;
 b=hAAXfIWH3PMoljOa5RffWnP05U+m1WrNEPX0Z+8SRJjBNSfZwJGVsg5s0R3tTKWYQ003BiUmisRTV89hzAlkM2Cbfw2YxAq7jSUyHQXFKJrq5LFgeNXesBL4GsQAOGLKYi7chaTC6v6hWPqEa5KgvH4BKIilqdWCOoRA95bqQmE=
Received: from DU7PR01CA0048.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::17) by AS8PR08MB5880.eurprd08.prod.outlook.com
 (2603:10a6:20b:29f::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Tue, 3 Sep
 2024 08:58:07 +0000
Received: from DB1PEPF000509FB.eurprd03.prod.outlook.com
 (2603:10a6:10:50e:cafe::c2) by DU7PR01CA0048.outlook.office365.com
 (2603:10a6:10:50e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25 via Frontend
 Transport; Tue, 3 Sep 2024 08:58:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.67.248.234)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 40.67.248.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.67.248.234; helo=nebula.arm.com; pr=C
Received: from nebula.arm.com (40.67.248.234) by
 DB1PEPF000509FB.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 3 Sep 2024 08:58:07 +0000
Received: from AZ-NEU-EXJ01.Arm.com (10.240.25.132) by AZ-NEU-EX04.Arm.com
 (10.251.24.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Sep
 2024 08:57:57 +0000
Received: from AZ-NEU-EX03.Arm.com (10.251.24.31) by AZ-NEU-EXJ01.Arm.com
 (10.240.25.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Sep
 2024 08:57:56 +0000
Received: from arm.com (10.1.28.157) by mail.arm.com (10.251.24.31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 3 Sep 2024 08:57:55 +0000
Date: Tue, 3 Sep 2024 09:57:54 +0100
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
Subject: Re: [PATCH v12 4/39] mman: Add map_shadow_stack() flags
Message-ID: <ZtbPksgBZiXd0iHc@arm.com>
References: <20240829-arm64-gcs-v12-4-42fec947436a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240829-arm64-gcs-v12-4-42fec947436a@kernel.org>
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic:
	DB1PEPF000509FB:EE_|AS8PR08MB5880:EE_|AM4PEPF00027A69:EE_|GV1PR08MB10749:EE_
X-MS-Office365-Filtering-Correlation-Id: 14c9ef3d-e537-4ef7-cfbe-08dccbf68fd4
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?AhWSXm2VMT89PlasFXxfEkqWzcQVzNPzU6TuGUi6CoQeWUavy2igqIikgJhr?=
 =?us-ascii?Q?u5RFOsRYe5Kfd0HDw4Xv8b9LDTPKwHvA2R+mN2PpGlr3/0WAndxDhpK6hAIa?=
 =?us-ascii?Q?Iy740HbcrQX/uMuTpr8azefe3a1n8xDcS2PMgACMpeHFOUC3Kn7l4cUM8Knv?=
 =?us-ascii?Q?M4U6rkA6QRC0XKGFAp16K3QlgSxhIea5qPjGn9lajbmzX/HHYxa7v5aHK6BM?=
 =?us-ascii?Q?m7fni/lnxBYNHSclK7B6OyjogexUv5itFyT14mobSgjEhoe3T8vKDbwT47nY?=
 =?us-ascii?Q?0xlRp1Q8oNOuXjY9RnWI25A8aEj3pa5obQ7QlykztHljtDDRIX0Mv4GNNRmd?=
 =?us-ascii?Q?Nt1o5NI2QkVD1EmhssSPjfGRzQN1CW80DQR/8WGpbDgHh2P4GoYJocD1MKEq?=
 =?us-ascii?Q?oyyRjjQm2zc7pksBQnenQeF14v4Ot//DmVIO813GuO8hlRUsYbIihPg6neXM?=
 =?us-ascii?Q?jQaPot+GxO2Ou07OuPaBNGGv9sud3c6h4uzgNEaXCksbk51+DXFytMYT2mGk?=
 =?us-ascii?Q?KHSQ1dBrIGuq0Ws2XkMLXIeRq9oMJgYilrkMu0HW4bbZjCMAuJS69veqwChX?=
 =?us-ascii?Q?nP7apqSyvcLj9dexjAllHmIP8EFpr3RBlcqPQjUnv+WIIAavSEU3TKO+1Fgq?=
 =?us-ascii?Q?UiZoIh4Hn775+0UiB6Oto2JiE/LDaujjXSGRWW0m21sKLtULCvsX/8YlXhQq?=
 =?us-ascii?Q?QaKGKLv13G5lw6Gf6jPo9oZPW1cdsdVY8kDERk9BT4k7tWXqUjadgyLJeDHr?=
 =?us-ascii?Q?nsbu6mCI2026oEhDCzaSzJ5MITEOHQEwl20A0y018zNXyiW1j48kvi/S+Q84?=
 =?us-ascii?Q?QreapbT9hJf8ZfR0eqgJch9ECfvt6+uzW9XwgcCJApqxNOJjEynUDftCiv6N?=
 =?us-ascii?Q?Ue2JZEhZ1uJZK+Mfjq+/iJGdOsLSEocSiNUEV7aKrR5Hxer8TmAF68i9NwpZ?=
 =?us-ascii?Q?/7btE0mJyxxeLllVRcz9cPLLB+wsRSsDz2HQLEEDFvL9cjGXMJEUQgN5msSS?=
 =?us-ascii?Q?A0C3wgUO8iCGeWm1c2Cv4KhNqIolaFqJoopISPlGpipo5iu2Fr/JWu5B64Ci?=
 =?us-ascii?Q?GuCOsAbdXB5wlvStLjK8vSpQh9W/VVTME7sSqdzefTT26g4Z9DTsIRtRyKQT?=
 =?us-ascii?Q?UH4PswSHTH33HWq8tTRn7mmK7E5COlHX6MU9PpUlTCuUZ/1NdgrqRVCTostw?=
 =?us-ascii?Q?JHLdZ5AJtXQ4nNyWN7pKxafO0EfrKtMYmeTdj0XjfPz/kVVYdzwDZqjqGGxc?=
 =?us-ascii?Q?vAygHNqERUQ4L/DhzKsVjepALyJkUya0lcbHnC9sjh8YMl+3nt/nfEMTD7Eq?=
 =?us-ascii?Q?HTeLAo9LYmZmdt+H5tALWRemuus5CXwSZmSmHtMJE0YZHBCLZNH6YieVccvT?=
 =?us-ascii?Q?93jNaLD2SUjLJhhDp6Ruv41EA50vxlHSg/RB0VBZfn8AmSeET9SjrhSOzkr9?=
 =?us-ascii?Q?rCcv/HRg4+17Qiv0oijVLMGKaJe4YbrJ?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:40.67.248.234;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB5880
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:10:50e::17];domain=DU7PR01CA0048.eurprd01.prod.exchangelabs.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00027A69.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	56e0afe5-b2d1-4cb1-dd43-08dccbf68783
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|35042699022|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mGDiXdxBCVQk+McmOXZotkxaVPKY31jDmZ1uJxqvMcv3SyVVjvEdjyJ2T5As?=
 =?us-ascii?Q?RkyFn+oUYnDryFGM1vECJAxtzKGnU8aEY+D3fmACdRWMczenhLBdRxiSRZZV?=
 =?us-ascii?Q?OjP+RwF0uuyysGTsDDQ7WQiAS3JHbs6Lxm+2gAUTrPMeMr6QnPWfoulV3cjP?=
 =?us-ascii?Q?4BRY0XPK4/2AmYqR5kkppmVxTs+Y5t0JAPGN26VzTGaOKpirrqX4a60QjIaT?=
 =?us-ascii?Q?Vsxe4C43kl30BTeEESVOnfxuSTv6xgb9c9prFWCfFvrzPFp+XsgG7xJ8cQs4?=
 =?us-ascii?Q?OtPISjhFPBrmBinf35o2Y3VCaTEzzIveWJgOc9MqmyGNdAxJYTt5qnvmoNgm?=
 =?us-ascii?Q?21dM6VzbD/RW48ppdNC9hW2YFi4AL+39Am/T9zxWjrPwS7dwG9RjuSfZCjhx?=
 =?us-ascii?Q?GL47CqK00L6EWK3rVme7LIb2Tx7k4AVIK+GFxK6+HrFsvfGX6YILRvs5xL6H?=
 =?us-ascii?Q?10mJJ8j2vsQgm+tZB3loz0ZelZzYkJq3QsjaOPoCRMtTps+bKevgJQjzineo?=
 =?us-ascii?Q?NEg0a/zyi4CfjYrDpche++xsLAbbGsqr5YomYx1Ictkykgjbv6vDXImLn9X8?=
 =?us-ascii?Q?YXDq9u/tNVKJbDYjxfvitOxtB0eoWvH092n1ys9uhldrbh8inZhttVT5UvAV?=
 =?us-ascii?Q?99t4eI8SpC1BOzK7ujvyY+XRNP4e4LTWCfqWchGPpE5C6ngmgR9lKKeKZ499?=
 =?us-ascii?Q?Gg4hz5TkNBVhNH05UfXhbJk2F0mnyWlC9+7XudF2Q41BwioTAMBXqRJYCOJ/?=
 =?us-ascii?Q?VYfS5HHgykw6YoUqPESRd+9UOMh/YMEErCup1bLvfOGzlvzV8usy8KogXsXT?=
 =?us-ascii?Q?Ot4/140/ZUfgbs+WB6HTwsaittvWSsFAT10uorDu2St7COpZoyxp382PF+Gs?=
 =?us-ascii?Q?4eHNdXfo2Iex/YePfgTEgeh8q2aBj7z7JgKl0ljFE2alBXNhMmmHwBlG3pp5?=
 =?us-ascii?Q?Ur/vxgh2U7m/1R4shyERNfydu/g30Lb0VxtFKZimSWAwPaapp2Qj4YW0BbRY?=
 =?us-ascii?Q?CxHdgQm+tMdL3fLInqca/Ul9cigcXuXwOEdRqKQbem5U1ZcfISB9XEclONVx?=
 =?us-ascii?Q?Au5Iyv+chfeIiOFLUP7zGuG+oi5VDPkDSrc0juNrCgbenCmUgChF5yh4Iize?=
 =?us-ascii?Q?2NNaFPMKED87Zlw71CpuNMjY5ssu8qa5Jk2nrV06A1pn3YxLUUeIFzhL1RvZ?=
 =?us-ascii?Q?8jTIBgP6wIFrcyVUdMJL4BoxnLEVGigQCUtsGWOhL4lt/R7J+xMtVAt1j6MB?=
 =?us-ascii?Q?mHgnerK3SMwn8KNrSFG2jksE30tvXYIesqj37nmGnc/nInfELlACCniyUlAJ?=
 =?us-ascii?Q?LwOrO5/pg4NQXQ12TwTthr4EGQkuxl02njQyplI61cjBvQl02s1dn4yqOx8Y?=
 =?us-ascii?Q?FgoiblT9eTq9GfsqZSMYah36mbdhxZhnaIJssLl5rqRvyatpXClURp2FTPVc?=
 =?us-ascii?Q?mO9xIQm24UCdm8tMAoQxt5AWolCIugod?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(35042699022)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 08:58:21.3687
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14c9ef3d-e537-4ef7-cfbe-08dccbf68fd4
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A69.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB10749

On Thu, Aug 29, 2024 at 12:27:20AM +0100, Mark Brown wrote:
> In preparation for adding arm64 GCS support make the map_shadow_stack()
> SHADOW_STACK_SET_TOKEN flag generic and add _SET_MARKER. The existing
> flag indicates that a token usable for stack switch should be added to
> the top of the newly mapped GCS region while the new flag indicates that
> a top of stack marker suitable for use by unwinders should be added
> above that.
> 
> For arm64 the top of stack marker is all bits 0.
> 
> Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>

Acked-by: Yury Khrustalev <yury.khrustalev@arm.com>


