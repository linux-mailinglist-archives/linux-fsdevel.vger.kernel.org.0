Return-Path: <linux-fsdevel+bounces-41387-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22808A2EB38
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 12:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14D6818883AA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 11:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693AC1C5F26;
	Mon, 10 Feb 2025 11:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="ZBepmqF0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191b.ess.barracuda.com (outbound-ip191b.ess.barracuda.com [209.222.82.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCEE1957FF
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Feb 2025 11:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739187222; cv=fail; b=CTjpdo2FgpQrgX1lj4KAYCayvm96iVyeIKL8mtk4SFI8P4NPkI+s3YU9lhaHLqLIUdZxr6dIDUuuTRyCyil8gSA0xXqamFJ5T5VuR5XTlCg+VLjofP4wM8T1k6o7NrtH377di0c+ljfbCJNJ8rhuunPZBq1wEY0KUo3lnNHFtmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739187222; c=relaxed/simple;
	bh=0qt2HmyKH/L0mouV6Hsluf+vl4oWvXVjebbCjvja7DQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g2TYXWKCPgHftpIyBnWHY2Uauc6CR3pAjhVCTAzMTmQoh+0b2Qjc9YJeJLgeXnDjUrHNiFN4xvugZEcEH6XQe+1iX9mgFys8PgnFB0mnvX0i0Mq8agdt+kCEIt9IZweAZ62fngvgzzGmYhEvDOu9t0iWogE1gCo49fpITUHboso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=ZBepmqF0; arc=fail smtp.client-ip=209.222.82.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169]) by mx-outbound18-5.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 10 Feb 2025 11:33:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RiGBEoJxICFKOa0+9AKakz5E5UK6I7y2xSk8MjgeaFZa6b9fj6XsPAhVCUzmhaxreq2faypdoD/QqJimFLeES9trX56G5pN6I1lfoxtgTRy/g3a75HDC6U81DSA8btMu06tkYvCnTKmhNm6HWeiXJ9b7RZsDFKimsWFI0obxxFMCdYsJ2Xh5eGchBD42aKy3KC9pWaERFnyIUbAVLECAJ5WKZyZCxuFQQRc3XkNRWr4v0r785i653zi8p+BtJlyelppPdfW5b/jczD/frl0gU3baeJf9etaJRjoNJnZJCmfbDVG4bVTSbQPQtwLKTHAFzHAssUuKCrNcRHsuGuCX3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0qt2HmyKH/L0mouV6Hsluf+vl4oWvXVjebbCjvja7DQ=;
 b=icXqmLT8Vqz4UMm0ZP6pPlWV1dbT0x/Vh8c8PBEZ/QSehL+0oHrXgsdFyqYxjGld6S01O1GlXO1tQhN/d4fFlQFmQnjnrmwrBSoWsJoNxh6GaKgWQS4RzcyfyMEnWARnbfhXJTZ5PFt+M4xvG0nd+pRCWkNWVt7i5NeBYsbiAfI1vrO5dCn9C+cfwqPOUBXc29DyTWnboAfC/cwBehgA5Oa46i0/GD5r2jEsIEoVhue/70MLxIAQm/CGGkhzCanVK3NfESzedvVSeUkTU4XGjYqh/DSJXniSPlyPXSWPoQkWvWe+nZnbPkmkZdpTbTgYgX3SIhEmZ3njDh5GCN9ufQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0qt2HmyKH/L0mouV6Hsluf+vl4oWvXVjebbCjvja7DQ=;
 b=ZBepmqF0gPnChHJ88hbSCCazGEKlnjMpNVkG9Wx7kEbQD3SvSpWgfhd0zZuQA/uGCRUoEiXcjrbY3/iX18bX23M2vDsKEtrsVw2yyDtZ6QU0xZsSgbtLA6fMymbhbPOvooTcxqMJKBq3qlIA9QyllMgwLrpmQbbiE2eZMlLvh4I=
Received: from CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
 by IA3PR19MB8687.namprd19.prod.outlook.com (2603:10b6:208:528::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.13; Mon, 10 Feb
 2025 09:58:21 +0000
Received: from CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03]) by CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03%6]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 09:58:21 +0000
From: Bernd Schubert <bschubert@ddn.com>
To: Luis Henriques <luis@igalia.com>, Miklos Szeredi <miklos@szeredi.hu>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2] fuse: add new function to invalidate cache for all
 inodes
Thread-Topic: [RFC PATCH v2] fuse: add new function to invalidate cache for
 all inodes
Thread-Index: AQHbe6D9eu9E0+cPYUiJt6eeramEurNATV4A
Date: Mon, 10 Feb 2025 09:58:21 +0000
Message-ID: <b5db41a7-1b26-4d12-b99f-c630f3054585@ddn.com>
References: <20250210094840.5627-1-luis@igalia.com>
In-Reply-To: <20250210094840.5627-1-luis@igalia.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR19MB3864:EE_|IA3PR19MB8687:EE_
x-ms-office365-filtering-correlation-id: d5531f93-69e7-4dee-6721-08dd49b973a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?U212RFc1OEplT0FWRG1ybGs4WWRmVGtFcWYrd2FJNk84STgwYk05UUh6RXFi?=
 =?utf-8?B?V042d0NRd1FOdkRRTmlTZkRSc0dUNGNGNFJmMU50UlRUMGh0NXhKbmp0SW5K?=
 =?utf-8?B?TmltZGFxbDFrOXdsTHRrRjNIS05mTk5ZZThQUG1UcUt5eWF5eGw0MGNDL01L?=
 =?utf-8?B?REx0WUxheWo0aDRYeHI4eDkvMzFpbFQxMFlpV1RyZ1Z0WHNIME45WlhzS25H?=
 =?utf-8?B?cGJQSTJGNUMxM2RCWUdkWm9wZ1ZIdVAycjVPM1JkeENNeVRoOHcvQVF5Rnlv?=
 =?utf-8?B?U1dKREQ0Y1JSVm1EcFEyTTZmUVQ1Kzc3QVNuYmtmZWI3Wk9YM3l6cG5VbmxS?=
 =?utf-8?B?QWw3emp4amlQUEg2N0xMMVNjYTF6ei95anpsY3BQclJCRkUzazNsUkp5MjJs?=
 =?utf-8?B?d0dtS05YVWJwa01pNW9iT2RtQm1ZaWQzWlNTS2VmZ0VFN2pWc1FDRG9vMGFT?=
 =?utf-8?B?MHF0cS9WWmFnbnlZeGlNQXc0aFJqbVE0dGJXUTcrdVFnRmxSajZQV3NVTU1X?=
 =?utf-8?B?YUIzSVlnSWlyUG42c0t5SjhBeFZlU2w5aU0xekRMWXJ3M1loTUlTcnRUeGl0?=
 =?utf-8?B?UDBzbzFqRGxoaGlrSTFFZ3BVaG9RNmFPNVYzNWRZRkptTkRycnU3T1dPSUpm?=
 =?utf-8?B?enZjc2kwVDMxKzVFaHpqZWoybVZtVitPMGY4bGlEL0J5VHVNbWRrK3lrMFoy?=
 =?utf-8?B?YlNCR05MZGVTS1N3L3VqQ0NZNVBtMU4ybTRCUzhlbmg4Q3ZOdmR2eFZ4SG51?=
 =?utf-8?B?bW56OFZ5RmtjU2FoYllZRmhNckNudUZRNFQwYTlGT3Y2NU0rbzNMdXdkZlpY?=
 =?utf-8?B?SktHOEZUS3NEeEJuUWNpY0NLVFA3cDZ6Z3A4MjhVTDkxOStSc0huZHFiaTRB?=
 =?utf-8?B?MTFWU1RGRm9wYmc3TDhPVXdlNnpMOHNTWUpPU3FIemlGUi8xVkxUNkk2RnEw?=
 =?utf-8?B?ZHZoK2hIQW9zUUlxOXp2a3hHZVZsM1NoWmVhZDViUkZvSVcydU5HajdzNVpF?=
 =?utf-8?B?Wi9YNTl5VFBXNjdScmpnRkJVL2JJR0dqSWtBWjdUc0dYRFZEK21CVTJZZU0z?=
 =?utf-8?B?Mlk1SkVxVWhHVFhyNzd3aU91cS85ZjV4SE5tVU9QSXNNZnphUUFFNXBCRjVp?=
 =?utf-8?B?S0hRV2VaQmZ3bTFtdEdlNEd6VVMwT3BOUkI2RUdKWklPdXA3MmNjd0lMa1hD?=
 =?utf-8?B?cHE1empydndSeW1WWVdvcUVCU3NqQnphUjdyZG5qWWdFVjBxYm9uTjBESEE2?=
 =?utf-8?B?VGJXYi9uUFVUZFdlN0Zqd3piSzAzQlBvMDNyUEhyYkdWWndtODVCNHdpUHhx?=
 =?utf-8?B?YmZaZ2hTTk9ldEZnOUkvZWlnSTJaWFFLZllIUldEYkRaeExwb3Q4VlBsRDZm?=
 =?utf-8?B?cE85VThBSTNoNmhGbW9VaU5EcHJ1bnlER3RYK245aUtCYXp1NkRJdWRVb0Y2?=
 =?utf-8?B?bHhxL1FTNGVLUzJWUjBycXh2N3pLUGtXamY1WTVrSXQ5YjlIUEJqSllneUs1?=
 =?utf-8?B?ZlVzRW1JTFVrVDBIdkhUc21QZDIyVVBXRnVyL2ZmOVVicWcyYnR5OFdmNTNY?=
 =?utf-8?B?aHB5T2toMk1pSTI0YnlybzQwcUZ3RXN3SSsvSUxwR1FsYVpqVXY5Q256T1da?=
 =?utf-8?B?Wm9OZnltMnhTcUpPaEpWamZ4WmN3SGR5UmVtMnhiczVyZ2ExandmU1lCQnB1?=
 =?utf-8?B?eUl6Y2JwMStHREFheDFpY1lTd09zYnczMnNDVDVFRWQrRUdaOVlyYTFOOEdI?=
 =?utf-8?B?djFlZDNFNHU2cHQwSW1XZ3BVZDNTVUkxSTJnZkw5eURKZ3M4cjVsbk9BZTUx?=
 =?utf-8?B?dk1Mb1k4VUxJZmN3ZjZEVWoxNXBLOWptVS9UOXpDQjFSUlNOaE9hNWM4b3Ny?=
 =?utf-8?B?dEVTZ016aElRYlkrYUwxL0VCZ0QxdVRWTm1KdE5uOG9pNW1hTWwzbTgvWE10?=
 =?utf-8?Q?70L2LC+TK8QL7JsBsKC7pRzCtuYcFe/h?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB3864.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NkVrSG44NC9FY0FVeHFWcDkrSmRIdXR1ekQ2RmJzQVcrM3JVYzdEWFMrK3N6?=
 =?utf-8?B?WGNnSG13cEFFYmFKNGtGelIvQjMrRTNCSUk5aDViMFVrSWdLUFc4S0ZyeXZu?=
 =?utf-8?B?TFNvbVF0dkp5Y1VkeXgvckdPK29sck9iV1luNFUzRERpV2VPR202Rzk2K3dI?=
 =?utf-8?B?YkNFbmpRaE1kY0NLZzZZMXZYUitRWlFVbExUSTRtdmg1NVhKd2o3Z0xLanlT?=
 =?utf-8?B?M2h5NFFRQ2VNU2wrUGtyMlY5UC9WNVFUVklnSXpJWVZXYzRlZ2kyZFZqYnQz?=
 =?utf-8?B?N3BFZVpZWDdGOXppZGxrKzNySWxkc2NPOERVeUF3YnBtRWJBTnJzR3luV0l3?=
 =?utf-8?B?MXpqbnJIUjRXMHVBWEV2RzBoMXJiOU1oR1l5bnQrdk9mcnUvcmRKT0d1QjVn?=
 =?utf-8?B?M0pKZE0waDlRN2VFNWZVd1Y5UldIVXlFZkhNVGdpLzlvWk1hYTRLTzQyTlNl?=
 =?utf-8?B?dFlzaDRxSWFKNGpuYm5tb2dBU2R5QUt6VHY1VkxURHk4clFJRlRsaVVUanM3?=
 =?utf-8?B?SWpaYXM0WkpZL25LMFVpVFJSeFljWVVCSVdFcEZYUy9wWUVHT3ZHK0xOSXZo?=
 =?utf-8?B?Nm1oQ1R0QkVBYlR5RHFaa3hwaGpSQkhXRzJuT0FSOElBMnFoeWxZSkZOZ25P?=
 =?utf-8?B?c0czSkU4KzdnbjhzTmhNWGVObXkyem1nZW91NFZoMmdIRlhOWFA3S0RsNGFq?=
 =?utf-8?B?TlVVcStsOHhDemhtcHdRQnY3QlpvSFVmUDlCUWtqd2ZSbEFJSi9sdnlwUU5y?=
 =?utf-8?B?VzZtNm5wa0NuN3ljUForRUNPWUN6QWMrYi9lZ0Q2Vmx3Ym5nTkYyTGZqdzli?=
 =?utf-8?B?Z21aeTd6b0tCQWJSN0RSVUpMakpnOTNwNmRQZlFIUXd3Ui9adUE0WHk5bnNX?=
 =?utf-8?B?VlAyMXgzRFQ1c1hDN2lqMDZJaVUwNG1OQ3NFdHF0TE5Sb3c1M0Fva0VHVDVl?=
 =?utf-8?B?dUpaUFpxOWZ2RktBb2pVRTNYSlg5Q0JhVyt0WklaWWQ0MUxsSUVTQkQ3UW50?=
 =?utf-8?B?d3NkdGhLanRXZEZPWEVBUHFiVDZqQXc3SGJzaGZiTDd6Yi9wQVc0YWVVOFFs?=
 =?utf-8?B?cVlvdVpaaExyeGhqY3p1eUhSSUo3UjNpaWxwMkM2cmkwSFlETVpOL2VVZnlE?=
 =?utf-8?B?V2NjZnZidmFpOVFjUWFEWFFHcEZRTGtrMmFseSt6ZGhSbzlRdVdZd3FnMzVv?=
 =?utf-8?B?bkt3enp2NmhVYUhqeDgwMkY1cmFRRFpQdjBZQjZGdTkzekpMRFNncGFtTEtW?=
 =?utf-8?B?L2FSTmVzRkwrdWhJT05WUWVKVHJoeTYrVlZiNVk5R0t0WklpL0tmVzJ6Q0Rt?=
 =?utf-8?B?TURMcVNOQUFxNC8wWVdHclpSVGdidHdTaDNGdWoxTGlXdWJRV2hmSVpzVjZs?=
 =?utf-8?B?Vk8vTzVVbDlYaGkvdVZMYSsraWRwU041SkN3WEdCQ1luM1ZvQ0hBeEtEd0FJ?=
 =?utf-8?B?RU53RUtLc09HTnVjMVU3NlFVdGh2WmdtZkoxMEhCdUhFcGNEdnIyU0VXTStK?=
 =?utf-8?B?WUJJSHJ2Z0RCdmlYRnZRbG5yY1A4elZZbk93dG5Sa0NtSG1jWTl4UCtNeVc5?=
 =?utf-8?B?ang3MVJQNmVPQnd2Mm5CSGhZRC9GVkovOFRaUFU2QzIwWWFuSE1DZEcyQzlR?=
 =?utf-8?B?V3JyYVR2OGZnTnZNa01iYTdXWm5FanB4dFJMaDRvTVAvOG1EOEloYkRoRzVr?=
 =?utf-8?B?YnVTMEdsK25TM09CSmY2eUxLV1N1Q3lZMjNlUWlITHFSQXB0MFpMVXV4RVRw?=
 =?utf-8?B?akhnSjloRjdwc1BNa280K2Z4UUtPUm1XZVl1NjdyUE9oNksydGM1MmVPTFo2?=
 =?utf-8?B?YkhYZlUyTkp1TkpMVno4R2JYbjFYYXlGRC9uQ3J0NDJkZzJoUWhXMzFBYzBV?=
 =?utf-8?B?SlRSSU51VDIvbmJHRWo5UWpTN1poZ1piUmpOZ0h6U1dQOFNnaEtLSGFXQjBR?=
 =?utf-8?B?RURLRDBISnRuV292T1lRK0NudHE5VGZsWFVYZW10bmRBNXcwVFk2Y2dzQ3Q1?=
 =?utf-8?B?ZU03MzBITzZuV0cvTFVVZVd5dUg3WXNXTkZ3Y3cvK2o2YXh0SnpmdlZyaGxY?=
 =?utf-8?B?K2JOcGR2Y1ZudkVha2lzbGFtc0N3NG5NRThhRWVneGZMaThnN0FnSFUzaDlx?=
 =?utf-8?B?V1pkdm9nZHVjNVdlZlZzdjRQZ3pOVmYxZ0ZsWkpoaXBUNi9hemRmTFFBSStI?=
 =?utf-8?Q?0Q9hNUmJ1UjBFSElJIIWLwI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <41A135D1C51885448A7E745458E9E1BD@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7ghA/QS4v6VtITXzW/qmrYR9EuFrl7/ngD+XDjd5HgOYU8o9y8U04xoEyVlmnzlpM3Je0aYlzsho8rZiMYl4P5lYByHoFq0FqAmpuRDK/8JMeFQZVxvNwGIxwI2ntj7z/o2TiTCMlFERwNpheJ2EOt66+NMoXnVorAt/BaNUyhLM2qasre6HtPIKF9Wa9Rlq6GDeVSLJIPeYAkA6KJafHpQkTlEcOqldH0pC7kn/MkV+mfTAn1GmCTyB1qgBSQrrY1nONnpxvGJg+u9WDG6uE2dZG5oxnHoUyFz4iSolg/2xibTe25P3iO9gwMglfZjZNpTDU8IN9/EfRUo9Om6wI+RUt17opZ0kjtlGefzK+q1SA/ODGCHUCOzUxhH2AKLqFjYY9cnMQPJ2Gac6tAgVQNOqvl3SSLWx03uXsrtGVOAnFpoyg+pk1k48d3uuXHwQCWAf2U34x5GYlgCZpu/EVL60GM9BJdX6Mkobyid0/+Fpgeqa8DET52ExyVtx9038KCj29+VrZS0FjROXgmahAG+GlUgOlAi9HxlXnh6okLrXFkx8fLCcjzjLC+9hXdy3Tf2khJdNQQED1JFt1TSxuN5BYnn+QNczpk4/PLzmZyElLogaWI25qQrKGQpizQEOXOgnwMgYzSZI/BDt60uXeg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB3864.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5531f93-69e7-4dee-6721-08dd49b973a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2025 09:58:21.4027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +DKa7RIpr1tC2P1KtssHAdQPgyVr9c8Xn59VMokh+KUbGvqIJllx+A4zCkxsCItxBvNwMnFG1h0+/g9cGm5otQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR19MB8687
X-OriginatorOrg: ddn.com
X-BESS-ID: 1739187218-104613-7566-2162-1
X-BESS-VER: 2019.1_20250205.2128
X-BESS-Apparent-Source-IP: 104.47.57.169
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYWZhZAVgZQ0CglLdU8Ldkw1d
	giNdHcJNnC0szAMDXRwNzUyCIpNdFMqTYWABd0KmhBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.262417 [from 
	cloudscan15-60.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_SC0_MISMATCH_TO, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

T24gMi8xMC8yNSAxMDo0OCwgTHVpcyBIZW5yaXF1ZXMgd3JvdGU6DQo+IEN1cnJlbnRseSB1c2Vy
c3BhY2UgaXMgYWJsZSB0byBub3RpZnkgdGhlIGtlcm5lbCB0byBpbnZhbGlkYXRlIHRoZSBjYWNo
ZSBmb3INCj4gYW4gaW5vZGUuICBUaGlzIG1lYW5zIHRoYXQsIGlmIGFsbCB0aGUgaW5vZGVzIGlu
IGEgZmlsZXN5c3RlbSBuZWVkIHRvIGJlDQo+IGludmFsaWRhdGVkLCB0aGVuIHVzZXJzcGFjZSBu
ZWVkcyB0byBpdGVyYXRlIHRocm91Z2ggYWxsIG9mIHRoZW0gYW5kIGRvIHRoaXMNCj4ga2VybmVs
IG5vdGlmaWNhdGlvbiBzZXBhcmF0ZWx5Lg0KPiANCj4gVGhpcyBwYXRjaCBhZGRzIGEgbmV3IG9w
dGlvbiB0aGF0IGFsbG93cyB1c2Vyc3BhY2UgdG8gaW52YWxpZGF0ZSBhbGwgdGhlDQo+IGlub2Rl
cyB3aXRoIGEgc2luZ2xlIG5vdGlmaWNhdGlvbiBvcGVyYXRpb24uICBJbiBhZGRpdGlvbiB0byBp
bnZhbGlkYXRlIGFsbA0KPiB0aGUgaW5vZGVzLCBpdCBhbHNvIHNocmlua3MgdGhlIHNiIGRjYWNo
ZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEx1aXMgSGVucmlxdWVzIDxsdWlzQGlnYWxpYS5jb20+
DQo+IC0tLQ0KPiBIaSENCj4gDQo+IEFzIHN1Z2dlc3RlZCBieSBCZXJuZCwgdGhpcyBwYXRjaCB2
MiBzaW1wbHkgYWRkcyBhbiBoZWxwZXIgZnVuY3Rpb24gdGhhdA0KPiB3aWxsIG1ha2UgaXQgZWFz
aWVyIHRvIHJlcGxhY2UgbW9zdCBvZiBpdCdzIGNvZGUgYnkgYSBjYWxsIHRvIGZ1bmN0aW9uDQo+
IHN1cGVyX2l0ZXJfaW5vZGVzKCkgd2hlbiBEYXZlIENoaW5uZXIncyBwYXRjaFsxXSBldmVudHVh
bGx5IGdldHMgbWVyZ2VkLg0KPiANCj4gWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAy
NDEwMDIwMTQwMTcuMzgwMTg5OS0zLWRhdmlkQGZyb21vcmJpdC5jb20NCj4gDQo+ICBmcy9mdXNl
L2lub2RlLmMgICAgICAgICAgIHwgNTkgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrDQo+ICBpbmNsdWRlL3VhcGkvbGludXgvZnVzZS5oIHwgIDMgKysNCj4gIDIgZmlsZXMg
Y2hhbmdlZCwgNjIgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2ZzL2Z1c2UvaW5v
ZGUuYyBiL2ZzL2Z1c2UvaW5vZGUuYw0KPiBpbmRleCBlOWRiMmNiOGMxNTAuLmJlNTFiNTMwMDZk
OCAxMDA2NDQNCj4gLS0tIGEvZnMvZnVzZS9pbm9kZS5jDQo+ICsrKyBiL2ZzL2Z1c2UvaW5vZGUu
Yw0KPiBAQCAtNTQ3LDYgKzU0Nyw2MiBAQCBzdHJ1Y3QgaW5vZGUgKmZ1c2VfaWxvb2t1cChzdHJ1
Y3QgZnVzZV9jb25uICpmYywgdTY0IG5vZGVpZCwNCj4gIAlyZXR1cm4gTlVMTDsNCj4gIH0NCj4g
IA0KPiArc3RhdGljIHZvaWQgaW52YWxfc2luZ2xlX2lub2RlKHN0cnVjdCBpbm9kZSAqaW5vZGUs
IHN0cnVjdCBmdXNlX2Nvbm4gKmZjKQ0KPiArew0KPiArCXN0cnVjdCBmdXNlX2lub2RlICpmaTsN
Cj4gKw0KPiArCWZpID0gZ2V0X2Z1c2VfaW5vZGUoaW5vZGUpOw0KPiArCXNwaW5fbG9jaygmZmkt
PmxvY2spOw0KPiArCWZpLT5hdHRyX3ZlcnNpb24gPSBhdG9taWM2NF9pbmNfcmV0dXJuKCZmYy0+
YXR0cl92ZXJzaW9uKTsNCj4gKwlzcGluX3VubG9jaygmZmktPmxvY2spOw0KPiArCWZ1c2VfaW52
YWxpZGF0ZV9hdHRyKGlub2RlKTsNCj4gKwlmb3JnZXRfYWxsX2NhY2hlZF9hY2xzKGlub2RlKTsN
Cg0KDQpUaGFuayB5b3UsIG11Y2ggZWFzaWVyIHRvIHJlYWQuDQoNCkNvdWxkIGZ1c2VfcmV2ZXJz
ZV9pbnZhbF9pbm9kZSgpIGNhbGwgaW50byB0aGlzPyBXaGF0IGFyZSB0aGUgc2VtYW50aWNzIA0K
Zm9yICBpbnZhbGlkYXRlX2lub2RlX3BhZ2VzMl9yYW5nZSgpIGluIHRoaXMgY2FzZT8gVG90YWxs
eSBpbnZhbGlkYXRlPw0KTm8gcGFnZSBjYWNoZSBpbnZhbGlkYXRpb24gYXQgYWxsIGFzIHJpZ2h0
IG5vdz8gSWYgc28sIHdoeT8NCg0KDQoNClRoYW5rcywNCkJlcm5kDQo=

