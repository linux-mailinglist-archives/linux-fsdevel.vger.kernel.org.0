Return-Path: <linux-fsdevel+bounces-28334-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F25CB969817
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 11:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABD09286680
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 09:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121091C766B;
	Tue,  3 Sep 2024 08:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="OtMx3czd";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="OtMx3czd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2048.outbound.protection.outlook.com [40.107.247.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA741C7680;
	Tue,  3 Sep 2024 08:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.48
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725353992; cv=fail; b=AIincHmrN3DR6tmO9sePQDXtu02dl1lJCuKxRCiAiU4fSXyXQGp9JpZndjEKDd8d6P5U1sAip6V1xHXT4HqpHCnLLRh61UGtFHM1S/4NnX/TZkRTahb62ychorgWUKCLelnWb+gD00GHUOpo0vdLz0Wp9TbOUadqqSPQ4+NJzzk=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725353992; c=relaxed/simple;
	bh=QVZDicLIIDEh8+UxaII1b9Rmx0hQ2PQ1aPBNmVPVewQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fL7YwdD2L5TtHiofg0Fh36b9GQlAvBpK5hL6OHEt4ASmpAmYrQZEB8z8hZW6u2ix/tNH6KcxUBO7VDUKGSxFaZjU+2VUdoEEBR0VbG8fzqUlfcLPjCw1esuOL9ZH60GAKcrAOm7GmellOULtePmj5nBmiqX+gCiQY/mWibEz5vw=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=OtMx3czd; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=OtMx3czd; arc=fail smtp.client-ip=40.107.247.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=wmERVFj5K8NvifY0fsUeq57E54dVXEc6N6k9JorsqIGxLiznTUXb3zgidUS+bInCytPTPqSH1TrvUzyIjOmMrmqAwUGAqhB7v7H9x8MyI86GHMG95IKusekJCwS3NCirEzROjcoAmFvxt3bpbxg89YdfBsrvRFA6Knjj8nFxBfeOUcxS0QMAOEamdP17gYPL12BgsOVoPgnbOX5SVoGdLOuKp0kMh5ir3edFJahHarU/oWL8y/1i55pte5hw11yrEYXhl6/LpzGSyRH6CRXnuJR4izUN4CheW+xXdbGgOT/bVoMNb85cD/LHdBw9kLVQ+fLLNXTn/4PRF5jo7LnifA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p/SgidYbx5KvfjOVnSHraJQCl9k5fI/hYvTUxgdL9mU=;
 b=ZfBYyvZhCQYNubqx7B3gO7Ug+GBaSq8Zftd2HFS26MufLPDecVws2Iab546jCrI79FO5199n6bb0vBrGOF3GdH/ZMLNa66uvlbYbgij1INgy2xNikkD9htRrDKG4ZgPlwC9vx816Suoart1B8XFd9iKyNKr4dGKrszK05OmdymM/Hlu+GJNyWYwOut8Bdnzc+fegP5sjnASX5INCtKgijKOlA+IVv8g+TVH9UTqTUZ+z4LUO1sszYs+SOzBwJzCxBmPIlqA2BQAYPL7fGboUw5iHzdnk3IRlqUXW66aJXz+bPHH5oc1bjR5DSjgP19yuIN6dkk/L6ZrSNpZyvMOsTQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/SgidYbx5KvfjOVnSHraJQCl9k5fI/hYvTUxgdL9mU=;
 b=OtMx3czdVb2Aw8M0JAM6+ZWAxgIZM6HeSILRpmc9IhLlRCF0o7pZg3V7GUB5gcrdsyNaQIbMW/c2VEimWcGgz5y0M4ndpjqOIRj1rKmYXLLTWU4FsUpxmsSsuFURmc6cN4VVj4MutzEDPguhjus8di8HsgDZMK5SURR+b4DkZPw=
Received: from AM0PR05CA0073.eurprd05.prod.outlook.com (2603:10a6:208:136::13)
 by PAWPR08MB10240.eurprd08.prod.outlook.com (2603:10a6:102:366::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.12; Tue, 3 Sep
 2024 08:59:44 +0000
Received: from AM2PEPF0001C712.eurprd05.prod.outlook.com
 (2603:10a6:208:136:cafe::db) by AM0PR05CA0073.outlook.office365.com
 (2603:10a6:208:136::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.26 via Frontend
 Transport; Tue, 3 Sep 2024 08:59:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM2PEPF0001C712.mail.protection.outlook.com (10.167.16.182) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7918.13
 via Frontend Transport; Tue, 3 Sep 2024 08:59:44 +0000
Received: ("Tessian outbound bc251c670828:v403"); Tue, 03 Sep 2024 08:59:43 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 3658db58a5709976
X-CR-MTA-TID: 64aa7808
Received: from Lf3bdea9c928f.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id C0D68F0C-EBEB-4E1A-BD63-AA6D48D2C02F.1;
	Tue, 03 Sep 2024 08:59:38 +0000
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Lf3bdea9c928f.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 03 Sep 2024 08:59:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yJAO6HjuZvBj0WhuuQQLFo5LrBmkPWJNuMR4wBGTkk8xD1vvA4kDWzniShXAKjAg6Ly+Y5EgKfO+6/We8XLjFUwrWPv9I7ZmJiwylPUIvQtl+CZrH+2EHYxaAzYww4D/DRjevhkryptYcRnWwu7ioUpS4fcMHa88wvHp8xNSRf/QWJq3pq6d9iDAsaML5UjbfKhuMyC+H7yDNBYmVfA+9ilXysrI6+unWCvaPgS9OWKd4vjhf52T7YzW4rZJ48zUwrVU47+OpkjulVG7oAQ+C8cNc+oXUjIAxtyIO+7pI7ChRnno7wxXEubCGZ0HMikcDGMhayJaUhcXXBz47Jv/dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p/SgidYbx5KvfjOVnSHraJQCl9k5fI/hYvTUxgdL9mU=;
 b=trlX37pqjgsg2d/zJczs4er33StYZgec7hC/KfpQ55lSy/MI5io4OIQIagtAXxH5UrggZYcn4Rt/A27B9ni08ZtrTMbOoH8jjwEaqQaVv1R+AgtpiudJrlgQQ/L4vTs0t0LuyeDKr1IVyBdxl8o1+YOdGp/2FwJDtmFsr0HKgYI+rho4U9n4BeKhdJX+F26sGfS+PHjTLFurC/dCqb2AKIquC7YzzPPqUP0I7X0x/nqnCkRKQweSQ7R7pS4RztPZlpH53r1G6JFqs4arUOFdjjdaKwGpafyPqhDoUdEYGG97oyNmv5dkbitSQM/7TrRmsqvGqJE6Erk6OceAu1ZODA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.67.248.234) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/SgidYbx5KvfjOVnSHraJQCl9k5fI/hYvTUxgdL9mU=;
 b=OtMx3czdVb2Aw8M0JAM6+ZWAxgIZM6HeSILRpmc9IhLlRCF0o7pZg3V7GUB5gcrdsyNaQIbMW/c2VEimWcGgz5y0M4ndpjqOIRj1rKmYXLLTWU4FsUpxmsSsuFURmc6cN4VVj4MutzEDPguhjus8di8HsgDZMK5SURR+b4DkZPw=
Received: from AS4P192CA0036.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:658::29)
 by AS4PR08MB7506.eurprd08.prod.outlook.com (2603:10a6:20b:4f8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Tue, 3 Sep
 2024 08:59:30 +0000
Received: from AM1PEPF000252E1.eurprd07.prod.outlook.com
 (2603:10a6:20b:658:cafe::74) by AS4P192CA0036.outlook.office365.com
 (2603:10a6:20b:658::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.26 via Frontend
 Transport; Tue, 3 Sep 2024 08:59:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.67.248.234)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 40.67.248.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.67.248.234; helo=nebula.arm.com; pr=C
Received: from nebula.arm.com (40.67.248.234) by
 AM1PEPF000252E1.mail.protection.outlook.com (10.167.16.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 3 Sep 2024 08:59:30 +0000
Received: from AZ-NEU-EX03.Arm.com (10.251.24.31) by AZ-NEU-EX04.Arm.com
 (10.251.24.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Sep
 2024 08:59:30 +0000
Received: from arm.com (10.1.28.157) by mail.arm.com (10.251.24.31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 3 Sep 2024 08:59:29 +0000
Date: Tue, 3 Sep 2024 09:59:28 +0100
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
Subject: Re: [PATCH v12 6/39] arm64/gcs: Document the ABI for Guarded Control
 Stacks
Message-ID: <ZtbP8CAOPDanw6-o@arm.com>
References: <20240829-arm64-gcs-v12-6-42fec947436a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240829-arm64-gcs-v12-6-42fec947436a@kernel.org>
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic:
	AM1PEPF000252E1:EE_|AS4PR08MB7506:EE_|AM2PEPF0001C712:EE_|PAWPR08MB10240:EE_
X-MS-Office365-Filtering-Correlation-Id: 2baf24b4-ddff-4722-a8fe-08dccbf6c165
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?w7uhcZb5zn+2LXSvvsvj+/E7Z22yrs8NNEKAVHq4yKJKs1guieTgBIGjpulO?=
 =?us-ascii?Q?rvHV4ceJ4Ihmg22eG+NK4vPhxyxhE8dbcia/yu2Vt15ORtsPzeRu6A4535eN?=
 =?us-ascii?Q?QssdCgUnuAvFpk4vFAcAQ2pyDb4bmwnPELaNOT2lZywGL2Abx/LaYOHGlFzE?=
 =?us-ascii?Q?4yJUnsJdNz3MzQz1M9gn4EYGkmpV4MaDGyfLijphu80ckMfCnqrYVFZiSK/J?=
 =?us-ascii?Q?hr/jhXPuww+392aO/d+ZN2qp9IFYHoJ5MzQ04o7OQKc2jHwhYf7Dhro48OVK?=
 =?us-ascii?Q?uLhb/4hzVzAFK0msteuZ+6VP/sDTeGMLNwwDT5gcor0rVBzsRtWlKDUc2+A+?=
 =?us-ascii?Q?asCRxwFmjvQ0FuTm7wvJn1S9DIyY4AQDtRVTyIPW7WfUL7UXXYf2vUGQqU7f?=
 =?us-ascii?Q?Cbe+VVh6smpQQ6XfxtyudNMVUfLtNTlOUTCZMcOMP1ci+knk5RSnsG0faFij?=
 =?us-ascii?Q?IC7VUjdtUtHMytA1y22dVWaePT2BdD4WzlLrAkfKzNM6Tp4jUpbuqP5X2Qc/?=
 =?us-ascii?Q?KkMm/bCdpM90ftTckZz4S9aipk+/ExDmAZf+woOK5udCDv/gaoPDkFBuufow?=
 =?us-ascii?Q?gjG+o1Wom+aGah8BDrEucFsoiY6/LG/W1kYeZvAZGrXVA/VrNuS6T0x5miwY?=
 =?us-ascii?Q?EicsO3EIkoAsTEcpJHN3WshRYVFJ89erCsxXt13LnNlzg97R2a7cDDcTf1KW?=
 =?us-ascii?Q?ERhllegIU8XVKeeoWmxhlrZ8ripA50Y/gjaoDuHeu9Wdd47XFf3+CEcZLdI/?=
 =?us-ascii?Q?NKZlcjpyTz4/ZjxVZjWjx4EM0joyPXcDmHhxfTh/eC88/iT8+ldDM8iR367P?=
 =?us-ascii?Q?wYR1/7yVy+isPGU9Wmcimnz6J3jgKsPZ/JmK/5o0I3oixa7n8sB15KDxBVpq?=
 =?us-ascii?Q?/fe7uZP6TDq2OW0ZKlk23LGrIVGvogwdGqMVbOtJSMJScW67lgRLiLrnUoUV?=
 =?us-ascii?Q?3JJqyc3WH//EiFa4vpDquK+Ea98jFvZOpXlPowQnYDQe36Br0XXAkNA+Kmyc?=
 =?us-ascii?Q?anoOcShnEKHozDQKh2r8RyuubbsmiOzZm3Cyy72shmIuZX3vzVOdlvt1q6p4?=
 =?us-ascii?Q?qEIasn70Ae1nkImpMDv45EuoW529pGAJkIQTXdI2wL0XdFStOYHxgF4PO5z8?=
 =?us-ascii?Q?1rrq2Jn14Eczl0wOPzqdSOZyevXv1BYhoXki6WwwTIZ9Fip1sl7HG3db+S84?=
 =?us-ascii?Q?1NbJxe5RNtbs+6Erk2mV/TMXI96VXurlHUayCjNdWlem+9EQmAyN+6iWO0dJ?=
 =?us-ascii?Q?srqbCy8PG4pxWKlbIE3IjzNwNGBVfgv1RM3nVN3aB3+QEx/pFuv4TDJ6cMQO?=
 =?us-ascii?Q?oPCdex33MuvjVxcYAOobV0BOMVxy0Zu01KgMj00CQlLrSygrc4+hv/tSsw11?=
 =?us-ascii?Q?Hanis2BGdUKqnMaUJI1DTkcazc8Xv4uRQ8QLUzFIufws8c06iYbPvAVZWryt?=
 =?us-ascii?Q?pladoRTL4Jc+F3NH2j9Vwr4+H13ggXgB?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:40.67.248.234;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7506
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:20b:658::29];domain=AS4P192CA0036.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM2PEPF0001C712.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	0f4d5341-ad86-43b8-ac0f-08dccbf6b919
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m8n3CfevakAGs3rk06C7jlHseM0uqalmPgHstKKJ6VDy077DREVy3j4TA/y6?=
 =?us-ascii?Q?C9h6+ilgq9Z0/JSAmR8sdMrFy0p5qwLiE7RuuqGo2apNAyG76vqU+/8amkLc?=
 =?us-ascii?Q?V3xyP+wVMnL4t6fIRguRZufiyUm+nIjHhW0mbJojXPyYeVU4ylMKf7U/40dz?=
 =?us-ascii?Q?CWjQneOwdkpGDB1IV9GPIGFcR528o+IFME1JDQ2zsmCR/Lf2oE1xz3xfXEsQ?=
 =?us-ascii?Q?9cnjFdj3zrolnFc7cal/Pu3k3zlhzJCjma7gF9rXbr3e1HX0nTilvTt6gn/P?=
 =?us-ascii?Q?KGg2DmYQG/p59jL5ftCsxpOETnMfaWiSVj+WR6Ou1pTIUbfR18/UYuifRD22?=
 =?us-ascii?Q?lOJFzvoQZnj3h5SUkq01EChMmJ4x2liA06ZMOHdEs+q8FJN1n0OpWhaMszd1?=
 =?us-ascii?Q?jFyPWIxJx/r7i41pUq3UbVhqdILLurUQzEoTV3Q5OUqaXbzb3nQhljbcj5Nj?=
 =?us-ascii?Q?jVipfnwMDTC14PN686+gJ09HsF9SLl8VFA+yt3b4gjcnjDNEESbpJh9Eg0+w?=
 =?us-ascii?Q?FpvCTEw/r8K5iASQ7xcfMeGSY3KLicAEoxH0RMcSpo9WCV2uyWBqCddjst/u?=
 =?us-ascii?Q?MAKUVrUzHnQ2fPEDF9iHYpzEGbUNNayHvOOKJgIGmtZG8g7lIgBtIY94tFiz?=
 =?us-ascii?Q?KQQGpK7iHR+iGG/saYQ5U77HzbHfdf5R8kXlyq0VmrZX46Psz615AKhrGUSb?=
 =?us-ascii?Q?Wey/COmKMcxRIFNTHHfB3+JSX+ckgWTLrwLLDyKSL2v5t5vqbtYD9U6uewvQ?=
 =?us-ascii?Q?ohzcZf63Go3mwYk+pQYRzFS5LTfjBfBp1NvpaLqLTBBpzuFzDutmO0lfyJkN?=
 =?us-ascii?Q?tx0RN6KCNjVx/PSTTH2ZLiafMoCZVCXkkktizJpKqPIg79Pl/zTcBcVsBFWo?=
 =?us-ascii?Q?laV6G6tFo1UnIo8sarx+AjJ++HUgzWz+j0hqvaC+3IdGdNxC9tFdrWOgpWEb?=
 =?us-ascii?Q?wuqaQ/axCq+cr0aEzTFGfpW89t4yOiqzv2Rx6WyjmWCzH5IuIZ5WM07nl7Co?=
 =?us-ascii?Q?1FurD/ba4MUQvMii83gtf+Kmym3v7I+48mgsk3bshri/MAgdCPOfAeaD7LPv?=
 =?us-ascii?Q?kfe74ahx6vMHgLvIMOUjKyFVBHDtFqduPMyr+cArbcYhIiR5cFsxmGadykjd?=
 =?us-ascii?Q?rNcHf1XUuEyUvoOCT7FtzBqyzFff1gD0Uj/kPsWXfoDiIF+7GwFUA5GML0bt?=
 =?us-ascii?Q?aseV/S/kbhuFwpnQxee7pmnMeATa6EnQ+JQFWMIW6bEuZ/ltGbKJ0hOetjdo?=
 =?us-ascii?Q?YW+ezAo/vOuF3VycMrQAiKylnsB7GIIIMjSZx4k4cZ/b6s5aCSX40TBFubw6?=
 =?us-ascii?Q?VerTW3lzcSqXodI42hEyWtNYVWIq/mGdKGejVYz9pzWd9qwkQ85Qf+1OTLbW?=
 =?us-ascii?Q?CfUWzF+u9eBdtBd/TywzRb3gDUbwlxDV2KpF9sqn5tTUMrdsOQbdtELdAf09?=
 =?us-ascii?Q?V2Y2/MqZzgZjTeMLPU3KIZCZnlb62pQW?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(35042699022);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 08:59:44.5576
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2baf24b4-ddff-4722-a8fe-08dccbf6c165
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C712.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB10240

On Thu, Aug 29, 2024 at 12:27:22AM +0100, Mark Brown wrote:
> Add some documentation of the userspace ABI for Guarded Control Stacks.
> 
> Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>

Acked-by: Yury Khrustalev <yury.khrustalev@arm.com>



