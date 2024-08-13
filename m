Return-Path: <linux-fsdevel+bounces-25795-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FDF950A46
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 18:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA9EE2834D9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 16:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAEF51A2C02;
	Tue, 13 Aug 2024 16:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="if/IUaIK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fq8w75e8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FEA1A2556;
	Tue, 13 Aug 2024 16:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723567023; cv=fail; b=Os3Er8iXsWMf4UHCaQToqWzZd8eR6Hv7kv+9M9kG4aC87PDTuHgc8s33n/2BxA5BA3FcwOPmYYtgXBya8L4DuzIP0t0XFqZEyFpTm0rD4eyaD0cDoAJZoU393SMjLct2OEyU49gBEWbYpWVdJ42Sf0Sp4GhoaD+bvSBh0GkR0M8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723567023; c=relaxed/simple;
	bh=3d0NAqismK1oHxyZsbPGHkoTG01Z3JS438mo/jksfq4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UR2OhIMkA8plaRtL1NfwN3hh2WOygTQ/693zFHqq+1m8UAbK7nUCqc0/eFz/fkulgoWXo2JoyhJ13sOfl5WmO4GQMXrp/sXUPpDJqmOonNmo8/FyMj3tgPm61QjAMDwn5jVARthYih+8csHhsmUntZOMcJLQ463wGv8ViCgd1eY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=if/IUaIK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fq8w75e8; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47DGBSMU009718;
	Tue, 13 Aug 2024 16:36:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=DVAFJDnrzrSAvCrZzveWH0484OJH9pv30i1p8PpGPbw=; b=
	if/IUaIKoPcFwnH3MFCYTMonO69BjPiOkybPS4yXvA8fBJfLfyGApOJUTEfEn5bZ
	D7nh/FfjjxDqJaGBmjxOz4fXdkHrN2A8Fje29rpSt0F5yAwHW/1BY1+jir2lF5Bh
	HxiFisZhAfNkF1ufDXun8DGe33zoOOlIIgfV4Na+rJi/e35Acm8/euzjU8lsCHEP
	KM5Ur5WraSB9uklj8NRJo+PM23mukBnP5QvlQjWDfymhvsoWX3xs/55Eo7YBcLVN
	EVdd0f1KEtK+bx7/AqXLDDNA+vLFSIlGZ+RimQzUsIKRCiYDXdfw+Q9v2FzZVo+g
	kP2wjRp8KB95lAma9kqiMg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40wy02xg0a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Aug 2024 16:36:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47DFeTNp017662;
	Tue, 13 Aug 2024 16:36:50 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40wxn9pd6n-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Aug 2024 16:36:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aAnYJt6OU9HDrMTZtwz/u5ytiarc6QoI38lZ3JEZmnA/azfJ/WOk7XDSnVJm7aGQPXbg+iZNFzCsEIdxqq0mH8KA2f+tmW0f8mhOT2EGsDHiV77zJdVWE6ObcXNp46XpcHovGFUoaiXZg8hRPhVz2oLvP9+oEz729Rs3p4rDcVeoX3DEaP16E3VI6nmGoOAt/ggpEVJhakLf1/6zZ35zoSAL8ypJNZrCn3xZfUgj42A8wD2n/HtiWmsos6Sq41SXOcOgS8xYbROWiikkrHc9wtgyWc+QeACgpUtb9gSzixYMM/7DjVpJ/Q7ffDTbqQefpZDRPGK5u6bHUv0pfAEVqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DVAFJDnrzrSAvCrZzveWH0484OJH9pv30i1p8PpGPbw=;
 b=wCnhjA+/X/LozG71F4PDbJ9yS8tqXgWsQ50zj7Cnc1KZTEVmRFj6gKNY4QM5nh2XVspQ9wfGqbG9kwV47FKwHfstmh8Y7aLaztmBYzPF6GfTHuhMcvoUjYPRlDaipStDeNtpWhiEJafYku7ZmRipxhuAksP8F3grAtSS2HU5KcBmLknA5VsKz2D+CGyKa+Bxikt72Pzl7ToN6sMOA6noNUmJ2vi3zPvloa+L+nzTbQT5TEdOJPnyl1ICDEosGEZ0AW4B8sVnfxehNp7OGzSHWyEgQNBRIpbZdYA3kvJZlQE7VPO0lc7biMeafWBxZF+0NiXnV7YTmGS+OEeyzzYnxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DVAFJDnrzrSAvCrZzveWH0484OJH9pv30i1p8PpGPbw=;
 b=fq8w75e8GVyIMuc9wIcY8U81e1nhbGnglqcw0Lde1R+MKSoE1BKuRUPTb5rwDiUV5OZIPHL87piFat4k4YOYb6UVNtfCBUBo6J08R8D1vaiq35eQLpLs6jL3BurSKiX1pQMcyOu94G5opJ1RqXfJvivs+9L4I+BTzY/zw2KtB3s=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB6354.namprd10.prod.outlook.com (2603:10b6:510:1b5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.8; Tue, 13 Aug
 2024 16:36:48 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.7875.015; Tue, 13 Aug 2024
 16:36:48 +0000
From: John Garry <john.g.garry@oracle.com>
To: chandan.babu@oracle.com, djwong@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v4 01/14] xfs: only allow minlen allocations when near ENOSPC
Date: Tue, 13 Aug 2024 16:36:25 +0000
Message-Id: <20240813163638.3751939-2-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240813163638.3751939-1-john.g.garry@oracle.com>
References: <20240813163638.3751939-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0018.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::31) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB6354:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bb7caf6-f74f-4574-fb16-08dcbbb6207b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xbcmhv80oHu7Q05S/9MGmehpHKnkvJ2+cBTvJcSHRIakYYfASDHxYqQrgCNb?=
 =?us-ascii?Q?upDoAI6UtP1xcaDV4p0fAU+W4/2C0XxUjbXDBUmtJOAHjbzLJu8wKjejSYOS?=
 =?us-ascii?Q?Tpb1rMC9GFMzEn6NoOo2opujDM3h3I62obIcJML1rhWGq/4Kd3Jow5KMYYj/?=
 =?us-ascii?Q?+VWBrdjnjUd+kTvmAP49pY6l5/0r9uR9xDLEFkm42uiwWPn7XsMoUBtfH7Aq?=
 =?us-ascii?Q?EJdFO+MJf+IoSriBwCr1pU/gzo7tOz85tvaO42bc9FxNU3kFIr32LKbj5JUx?=
 =?us-ascii?Q?H2FseLpklSnJb3LGWryRBB8bWuwdklDBlrIoWnLW9mOQ4WEdg8WBZMO3DPyc?=
 =?us-ascii?Q?LsmKLjq1LbDdryio74px9Z//w72saaaAngt0/ouzbEnfXIEVQRuHENQxY6n7?=
 =?us-ascii?Q?yC8OeyCYHOpB2fahYRjPBxqM5JXI1CV9d8+MWHj4siXp4DThtH/eQ6qXiO0e?=
 =?us-ascii?Q?I50AsPxHnR6Wiv78T6lbbfgOn/cZTpfxUOjPFFdtLSozoeLSFLTUCS/jduVu?=
 =?us-ascii?Q?h/SWydvCfZUoYQYu3KtW/+1rF3GIdrqrwwZVpu/spKIDhaLYSSQ2+ViescY7?=
 =?us-ascii?Q?PmJCQuQ8sJSevbuRiMHyqdsxDomvzO6XnIKCxh+AcZsrHwzLFz11idjdcu7y?=
 =?us-ascii?Q?/aHPGGAYpg38qR+vCn98dIHfpOraBMmTkdViVxe4X2SUOWFT95TadaHycPH3?=
 =?us-ascii?Q?iqPI3WLOndsleE+yxI2TlFz8ygBesHti2+G2QPR1y88e5rNEmNFGqkWLjkYa?=
 =?us-ascii?Q?BLv/m2F3532YuvKJu8Uva0lKVcqrv4myBIXSZn1tw8ylOzikzFCHlvZiDmem?=
 =?us-ascii?Q?oPCz83UI8Ep3CjpnECnRfdkBgIjclb5VGZDA0b8JP6x9uQtIG6tquZ+DqRKR?=
 =?us-ascii?Q?4G0Tg6USuonauZAJ2G2oXN4dMvCLWezcGm1d0zUdlUdH1qqRD1ah8M/8lUaB?=
 =?us-ascii?Q?92OC7PEYkmafDooZJNMkuGy7JwW4YrE/gU/PdtK/YJ20cwzOqgsy5q9ijRUx?=
 =?us-ascii?Q?8OdAu97tRDRWH0fMtqULKy2m1/IeKMlbWtvECdTMn6redICohBnGV+9IY2wJ?=
 =?us-ascii?Q?o4U/CblWA8X25ulT24tYdGJidiDioxjm3LwDfQvxuViLYfVZQ27YksYU776V?=
 =?us-ascii?Q?R8M6ipQsH0ebfVkuV767L6BR0DUnDB10f3E+qRRn3WdbMA8F3b0Wy4za3MMC?=
 =?us-ascii?Q?9TUBV32zt9STydrp4XdwI83Y8F1ng6NjbbpfG+xfb9sOnnqK6+N5gkSOmhqQ?=
 =?us-ascii?Q?siYzGyP5eCJmG4RoQyMybEiLjEDzdT7y7ysQiPTXSlr9I/9QuNL8Z7oWFdOz?=
 =?us-ascii?Q?NE4otcbzVSv/CwgADUkBoCGfVjlRClAhLc0VtCc2S0ZTLg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4NEey2LNvjulxOIxT1Ohl9HWViJiFq3fc9J/kI2QokHYm+J9tFv5AgDqQW34?=
 =?us-ascii?Q?KOiziIA5vvErqWXk+clo6b+25UDsTqSZWQqmk21QlOyG/IbB5GACdftspCgn?=
 =?us-ascii?Q?4bZ4UXDgqsxrAIZ5DBypsobj64Y1hzQvSV26qNktfIBIvK2iBJGO+kxJR8TQ?=
 =?us-ascii?Q?gSKFDrD7BAPlXbxVINihWQc0+7jKLLUULmbLk8oTeOTQAMmPCPfsdlAVIcHO?=
 =?us-ascii?Q?Zinvj7/tcwcI8C2B1Okk6MhG/dwyoUO4gUGabCre1T2RSOeAnWQu5yuuB76D?=
 =?us-ascii?Q?gBnh7PFdpQZAwElWcNinc9SliQT1A3DEus51OgtC9tpgroG15x1Uq7ED6m3x?=
 =?us-ascii?Q?bXvpNVtkVBcQTbNvrZpIU2ptNTiuVlQfrSFRUxu7hlwhW1Ar4Ocsb6elDTIn?=
 =?us-ascii?Q?LIupXwNwL9CjqRdx/4eRk5H8WsPGDdMHg+xLy94LQ9G5oh7uB71Ux0PaT48x?=
 =?us-ascii?Q?SXYLMYfmSKIn8VecWeYziK4VMqHhe13lUJI3OxSXnqqp5tY4aH1wQvwfhMra?=
 =?us-ascii?Q?1n0/S0Ns9EJI/XzciVP18X5EAPSmijTsaN4tWY5uT60czX3JI2OhLgQtmEkP?=
 =?us-ascii?Q?iYq8wm12moc2aXJwUCreq6fCnvRaCYvhtoiVi4Y+/GaivHDeU5fUmPQ0y6bG?=
 =?us-ascii?Q?IyuXsfu1zkYnnBXR3SVOsuZEw2Da/wZQUUDbG0MX1e/6CHkEa5hYmiuPMYuT?=
 =?us-ascii?Q?6iOGfRLolgfpJhnXI/nfJycQMxwUhOdWC09NrT3ekNkuG2DJTcszACEmzXN7?=
 =?us-ascii?Q?sQXSR0tzJVbaUM2S71ksebnwnU4qJiooGDV+YJm8gBX8ZAjioC6cjz8XMxoj?=
 =?us-ascii?Q?lVI/c9qOO+3Ymi4yD0ncRG7/b4ZORSovQ5d90fv+NMhpEJ+y+w5qoecGk2sC?=
 =?us-ascii?Q?qe4vrTGlZ426k/8zIk6MJ2HxwqrGrxratxFdN0ZEoiWh33ZCxXvtPPu9b6Ja?=
 =?us-ascii?Q?LSUl697snr/gWyKV2UKJSlO5IBkfanVIH6u4AhSBETtefTboD4203v1LvbDZ?=
 =?us-ascii?Q?lvw4n18QwV1oGRW+SRtLx4OzYoY6BdoMOluRBgTV4AHmJEI8ofgu6jdepCEr?=
 =?us-ascii?Q?JgjNID8xpxXl6Xr4brC6i2C0ZscAAQBI1VkM99roYI4u/zdnVKi4XGHfWksP?=
 =?us-ascii?Q?AxEhYXGIogs1BNF78PkrmX4dUB2Erz2Fz1iGB5zV7o2S8oSvdD/2rMJCyQuV?=
 =?us-ascii?Q?xFE2R6eBhli29vcRxO1Jlt2UHNGwpAZw80owYEjX5/73kdE/DiwO3WuvdJli?=
 =?us-ascii?Q?GmIoZyKDRNaXJadQ1a/2nU7K2MQRLobQXDyKULGRAs5iHX5ErGFyKKly61tV?=
 =?us-ascii?Q?NPuywaCtWZfd2agsi1XBDeDjHSysZoVoqzvTRw90vwBJ9b4R2KC3jw//qgji?=
 =?us-ascii?Q?CdM8IoWxBmC1LsloJM75jZJySyvg4YZmZ1tzvkpiNE8b55SD8MiqlV29fG27?=
 =?us-ascii?Q?1zlMzELO62sEEytiVTz30pfArcveeZGWWl0i7109Udfq0qHagqc9Bf1Aclm7?=
 =?us-ascii?Q?cgI6Ap45habS8Z6QXUenp3MpiAlyAuPx6o0fdE6B2wjMhCWBSAenpPdLsYIb?=
 =?us-ascii?Q?XSvjd5O/a15jYVyYbjDZUU6Fh7sljTEpa0x1lc5oW2chfWzFwObgZsHBqX6M?=
 =?us-ascii?Q?YA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0CF0Ytb+VbQre1viLXx8rEdRLGmNzxZLQjfMRDSBMvwSo8cZYelLTbQ08HnoIjdDQp1dovEI3C0OU7hl0WymFVsWZmiq5iYN3iBE6gel4g31GHW4mXXyUB6DbCktmeKiDLNWGaWzPxok+PTKnDo+JVAqe0CgSIGeITh2P+1qpY22TxFCY+DesjdQAmPNv8c/cD53Uba4a5OmLpK/QD8toSAt6Xume+JtTzPtWF2Wb8IgOMjGI+Dd88/dcLgpfeia1pUCmCeNoxrk+OKLnKwMv2U13kmK8w5yGWSWDacBIiPvOv2ovYc5WtJEfD2XugRc73vCg/3yzYCJbDdnzEnRnuYCf2i8I27ngEEnT7xmSzX8R9OCUO/zhb75VAz8Fm4lQopCq3Lk2KKWuQvtjQzKSH3Fmn+AF0N+pIMsOvq8aoIIwx7SefzpvYovRcqw+SqjdZX1AFX3ycXhZ23c/9bTbNlE4f1e/YgamQ0wOr/fCTBb86zILNuIXCFq4c1/W8ksEDnSHgxNo0aI7481R+SX3ewLF0mJfkuoPT6d4lFTaVfgT9VgPWPVBQ5N7tL58PoY7TeE3k5b2/JZMzFEv21dQ91X8C5NKUlwZBSAYga/v4U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bb7caf6-f74f-4574-fb16-08dcbbb6207b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 16:36:48.4049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ayZsT7MrQWJPkNzQAJg5BJnPX0i7+8zev9KcwgbJKK7Q1gFSnve0jd939hd2shfXcTDozhcddSp3VXOnjrYjGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6354
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-13_07,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 spamscore=0
 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408130120
X-Proofpoint-GUID: jnp5KPw8xU6wet_PtmX0QRaDjEVr0zSo
X-Proofpoint-ORIG-GUID: jnp5KPw8xU6wet_PtmX0QRaDjEVr0zSo

From: Dave Chinner <dchinner@redhat.com>

When we are near ENOSPC and don't have enough free
space for an args->maxlen allocation, xfs_alloc_space_available()
will trim args->maxlen to equal the available space. However, this
function has only checked that there is enough contiguous free space
for an aligned args->minlen allocation to succeed. Hence there is no
guarantee that an args->maxlen allocation will succeed, nor that the
available space will allow for correct alignment of an args->maxlen
allocation.

Further, by trimming args->maxlen arbitrarily, it breaks an
assumption made in xfs_alloc_fix_len() that if the caller wants
aligned allocation, then args->maxlen will be set to an aligned
value. It then skips the tail alignment and so we end up with
extents that aren't aligned to extent size hint boundaries as we
approach ENOSPC.

To avoid this problem, don't reduce args->maxlen by some random,
arbitrary amount. If args->maxlen is too large for the available
space, reduce the allocation to a minlen allocation as we know we
have contiguous free space available for this to succeed and always
be correctly aligned.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_alloc.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_alloc.c b/fs/xfs/libxfs/xfs_alloc.c
index 59326f84f6a5..d559d992c6ef 100644
--- a/fs/xfs/libxfs/xfs_alloc.c
+++ b/fs/xfs/libxfs/xfs_alloc.c
@@ -2524,14 +2524,23 @@ xfs_alloc_space_available(
 	if (available < (int)max(args->total, alloc_len))
 		return false;
 
+	if (flags & XFS_ALLOC_FLAG_CHECK)
+		return true;
+
 	/*
-	 * Clamp maxlen to the amount of free space available for the actual
-	 * extent allocation.
+	 * If we can't do a maxlen allocation, then we must reduce the size of
+	 * the allocation to match the available free space. We know how big
+	 * the largest contiguous free space we can allocate is, so that's our
+	 * upper bound. However, we don't exaclty know what alignment/size
+	 * constraints have been placed on the allocation, so we can't
+	 * arbitrarily select some new max size. Hence make this a minlen
+	 * allocation as we know that will definitely succeed and match the
+	 * callers alignment constraints.
 	 */
-	if (available < (int)args->maxlen && !(flags & XFS_ALLOC_FLAG_CHECK)) {
-		args->maxlen = available;
+	alloc_len = args->maxlen + (args->alignment - 1) + args->minalignslop;
+	if (longest < alloc_len) {
+		args->maxlen = args->minlen;
 		ASSERT(args->maxlen > 0);
-		ASSERT(args->maxlen >= args->minlen);
 	}
 
 	return true;
-- 
2.31.1


