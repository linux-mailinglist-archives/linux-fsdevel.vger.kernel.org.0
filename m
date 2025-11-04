Return-Path: <linux-fsdevel+bounces-67009-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BC1C333E6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 23:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6BA9A34A98D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 22:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB6B313261;
	Tue,  4 Nov 2025 22:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kDOcu/cq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA262D0C99
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Nov 2025 22:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762295662; cv=fail; b=jpZg/CjP5fplpgcdoiaQewLfcKRvPJE82R3S54IHpfVaJ4l2f9uUJQM46op7eC42uFOgWWPlg9cixJ9bvuyC1yXBB2B+4xdVOY/9/UwuYjOJfFEsR9LeHEpadskS/52LLQeANi5Z7nzOLKCK9jeWMbrzhbS1J2V/zBJXfbWTCIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762295662; c=relaxed/simple;
	bh=LhrJjjz0bZJshnsI/CnwVZaIUieg8GAJxcMrvvUAOG4=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=IojFzerXBcnh9aARYzKtz5cTQEKio+AkPq1+gS9DsEtbZxYMYCrIlDgt+WD+Oni7vfXoc8iI4ueo00hNQ6Uiyk7YraWJRZW5UWZSffti3qxCi+yJwlh905PtHRAtredkYzDKf94DwVh90aT5O1Cx1i7UJ/Y6bdAP/xu9eVL8b80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kDOcu/cq; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A4EVnUS002028
	for <linux-fsdevel@vger.kernel.org>; Tue, 4 Nov 2025 22:34:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=OiECmCmvpt44LDwma6nDPP1YpDGogwG5N1FAX0DoAW4=; b=kDOcu/cq
	t/GVX19sPrq7Ws4XbUZrPTh52YgvtD3oU1lMFXs5C+WcbX2b1a4Re2PMBtHJzP+8
	nPN2t9Gr0+KOdXJuGBzci3AsmdJLZr9nOh3Xk9lby5sO6LLtFILNm0tjBHYbZ5J7
	gHN6p7qLnBN7D8ydMelxfqxbFFrsqbXEhBBwKfUoonsWatOABIJSvW6WSJiVbeNx
	hgZCDuRhqSpIL1uo+8gp9sBmJwTctOshqJ/OcQKdyKfZFYzQ52z7HcFwWihXUfqv
	OOQ61Rlm7ZQBlOHaQJ+Y8CSZCpzvsZXFEFK19Scrki6UbiWyY+NAuq4102ikFiAp
	Z5B6u2Iy9jbOYg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59vueaqt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Tue, 04 Nov 2025 22:34:19 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5A4MUQNl029590
	for <linux-fsdevel@vger.kernel.org>; Tue, 4 Nov 2025 22:34:19 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011049.outbound.protection.outlook.com [40.107.208.49])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59vueaqn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Nov 2025 22:34:18 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EIEJfrSYI+ivezPHHnBZdJeGIKFB7XUb6w00jfwqnuMaexZ/vt/ZwjLhYIixy9/+ozTw7MIrY7uxu2Sx5tVnn2R0uT9eTQntHNW9WCazjtCJ8FSsbiJxuRrJXwP4TfvF64J8bAL4DOR2HdjaRZVOf5aTBgUcRxQjlkhJQKFmCYp5fdDer0/6qDrvZmqIbhKZISSzjUKNJvhBiI0+wBIy/9e6r2jQKFhPIxqENhfDAXt9iQ8NOZspxnL+zD27TepDA+ce/jUpKDM342YABntgTTq2bBEoPunTCV+j7BDWJzM18XE131D0Yc748QsdHsuruFkFCy9fG9u6mvccfnopTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DI2MKRyasBeauAu0dKZR+RJ+DneyWe4MqeIcQatJQsE=;
 b=qSL8UpCHPfmBs/ZvcEm76wyKZVGt3jLnCWxz/kL/t4Q+a6m0T6qJFWaQ/yq+9cN3oc+sgCor6ig8dgOlLKzg4k2lJgSm3Uop5U8NAQhzEQPb4oBOGRcv/KM29prQWISuvuRiV3CdsjBqZPYuF+7chBAu8Io498xlC1tqGCgcXuo9Ya4lBhIKzG7Mt+l3CK+t/oQMf8xYWq+nkDFBgowyLw1HKRabJ3PyypnL2zDuwh5UhloFrBnrzOl6svu5kaES28L/u1Ndg3kkyNH2W48tRu1XuE07x0xQCIb60x4gXRFYJvsD1vEQUdcZdOgZUn4KHiu/eZFlTT8N06p0hk/1uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by DS4PPFCF61DF7DB.namprd15.prod.outlook.com (2603:10b6:f:fc00::9bf) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Tue, 4 Nov
 2025 22:34:16 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 22:34:15 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "contact@gvernon.com" <contact@gvernon.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC: "linux-kernel-mentees@lists.linux.dev"
	<linux-kernel-mentees@lists.linux.dev>,
        "penguin-kernel@i-love.sakura.ne.jp"
	<penguin-kernel@i-love.sakura.ne.jp>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com"
	<syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com>
Thread-Topic: [EXTERNAL] [PATCH v2 1/2] hfs: Validate CNIDs in hfs_read_inode
Thread-Index: AQHcTS1Wu1aZP52wqEO5BJ3i0w5jk7TjG/AA
Date: Tue, 4 Nov 2025 22:34:15 +0000
Message-ID: <e13da4581ff5e8230fa5488f6e5d97695fc349b0.camel@ibm.com>
References: <d2b28f73-49c8-4e30-9913-01702da4dfe4@I-love.SAKURA.ne.jp>
	 <20251104014738.131872-3-contact@gvernon.com>
In-Reply-To: <20251104014738.131872-3-contact@gvernon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|DS4PPFCF61DF7DB:EE_
x-ms-office365-filtering-correlation-id: 019677c4-a403-4f27-964d-08de1bf24946
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|10070799003|7416014|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?MmZFcjBIVUEvUHRJRE9qcnBETFZPUjBxZWpOSmJqU3dEMHNqc3I0S2RZcWxI?=
 =?utf-8?B?VkZ0cU50c0tyM3JaNVJDdTh0ZXF4THU1RWl3eG9ReGoxSnl6aUdEZ08xbFVN?=
 =?utf-8?B?RDdickVhUW1LemROTjR2dXpoSnc0NXlWa0w5ZUV6cGlXdzMyaklZd0NRZXJZ?=
 =?utf-8?B?OWpubHoxOXJBM1FyRlljUVo2Mll3YzBudGlFcXpmK3pvekVDVUI5TzNWWGQz?=
 =?utf-8?B?bFl3Zml1REJsdXZNcHN6YzJSQ1BOL2xNdDFxKzNVSDhGRG5tdnZDTkIzRENZ?=
 =?utf-8?B?cEdMSXNJU0xKamtGck9oYStvd2ltemsyM1c4RTV0aWhRWTdHR1dtb3pNZm0r?=
 =?utf-8?B?VU9uWTJVd0d0emljeGVScG1nYlBUR2RXY1lmVStYdm11Z3hVWEN5V2ZHMDcx?=
 =?utf-8?B?aGZuZVJiK1ZUMmRqdUxnL2xkWXh6SnpLWEVUT2FwY1B1YmVIWXFqT1RQK3RF?=
 =?utf-8?B?OUpMVVMzcWdaM1pySHc2eHBESnZmU0dFN3lFbGpSeU5PZE5OZm1kdEkxWG1k?=
 =?utf-8?B?OW1oekRvVkhDQVdEbFllNm9vMHFGQ0ZJTHBHWXgwRTN2cE95emdJbGxBb0F3?=
 =?utf-8?B?K1BSMTFXZHFIZnVrVU4wQkl1K2MyRGN4aXRvdFJOcjZ6ZzdQeWNEUUtGWHRq?=
 =?utf-8?B?MDB6MEtTQmFub25qVjhBSU5rUGR6R0lJeDVGTURtMjl4TFdaL2RYRzdSejR5?=
 =?utf-8?B?WmdMZW42dWkzUlZCUkltemJ0RTJldVVaVU4rYlFKWUhUMjRZL0gwL3l0dHpM?=
 =?utf-8?B?ME14RjlEWmNMN1FQTGV1cHBubmpZcW0zSWxyRG8yTHZYZVJDZ1JKYWlOS2Vp?=
 =?utf-8?B?VGlQVll5WWVubmdwN3RPMlYwTjluWnlYY2QzeklxdjNLUW5rc1UxWHd5bG45?=
 =?utf-8?B?UE9VaFBxN3BPbkJvZ3p0U2k0RTFvcHh0b1F5UW9WZmFOaVJPRzZ3UGVraW5Y?=
 =?utf-8?B?Z0RpWk1JcVh5VDJHQXlsdFgxdFB1MS9YMVlSaHFFSVQydE54Z24wdHk4QWU1?=
 =?utf-8?B?b1FGRlFkVUxMbEF1SnNPM2ZNc1dmUGh3c2VOdU52SmVlMHNMRXN0VjNoOEF3?=
 =?utf-8?B?SmdBTEFHaGM3MjZpemVra01haGRmM0I5L2JqOW5DeDR1d0RraWN3bC9TRm5o?=
 =?utf-8?B?bnltYUxUbnFoa3RLT1VtelFZeDd4UURBa2tnY2pYRFc0MFBFcWcwcHVtdjRW?=
 =?utf-8?B?cWUwb2ZMVlEvRmlJeGxObXp6M1M1bUpIc281ZWRheFdFTjJKRW1oS0F2RS9U?=
 =?utf-8?B?WDZtTkZrbWpjV3F1cExjOVJCQ0F1WDFhYTh5RmJBSHZYSUV0ZnNFS0c0Rjk3?=
 =?utf-8?B?dUZPTnE2VGsxbHNKS3JFL1NVdkc5QVBOK1NmamYvb0psdi9TdDhRdjduQnRm?=
 =?utf-8?B?TU1nNVlBUXgvVmd5MC8zS3ByR1h4TmVwcm9CcmRTVk5uRGtPZkJJdDlOZ0hT?=
 =?utf-8?B?b0t3VSswR2hIU2Nra055QjJEbVpKTmwxUElpQzd4VFVNU0kzc0RHZ3MwSlFK?=
 =?utf-8?B?MmpSeTR1TzRUWmhtWEFEa2VhNEtZMGs2MHZyRTJLZVpYWWp2MDVFdHQyYU9U?=
 =?utf-8?B?aHVaWENES3JIYkFuQUNQNmNzaHphSVlYR2ZrUlJGYzBtNXFjaDJwakluVUlV?=
 =?utf-8?B?QnFCclNxTHQwdmZwWnZrdDBxdjRmdXNvTngvVkErRStXQkwvUEM5ZkVyVHBx?=
 =?utf-8?B?dHlITW5GdUlMcVN5RlNQQWNWQmlkUWluTk9UVjh3ZHFWNDYwSWlKK2xNNzFF?=
 =?utf-8?B?NndXY2plZlZnamhGQTUwVVBXTkNyQUVlcmU2MnZXQUlGYk0zTlNIc0tYckYz?=
 =?utf-8?B?bytmUVh6Yis2RzlEY2hOcDVkclJLQ3hBbGFXMGRzc0RQTXZvNzl6UUovQkpu?=
 =?utf-8?B?YmFaZ0pabE11V0o4clR5VWVrZjBuYkdZd0lIU0xsYnB0SFhXaUw3TGhUOHlF?=
 =?utf-8?B?SDBER0hHeTlpUVBtTUNGdktlNEpscGRsZXl5bFd4ODJZRXI3NndMTndSc1Av?=
 =?utf-8?B?cEdvNzNPdDh3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c0Y2K1hXbGdDK1kxdjByMlprTlFrTnIvM3EwWVI0TmNJTWh4SEVydjlyNzky?=
 =?utf-8?B?eHNoUDR2dU1UVUxkNjRvWVIxbVlVMUxVK1IvUWVMcWJRQTFZVVQrRk8rZ2tO?=
 =?utf-8?B?Rjh2a0Q1dkVsUEFSQityY3poTTIzK3orSXNlTWtBK2owRXdnaEVHZXJqbUlz?=
 =?utf-8?B?WDZlQ0s4dWRhV080VG9WbFQzNjY1VVkrKzFsRFhFb0RRRnBmZENYS1NvbGFv?=
 =?utf-8?B?RnlBWElneTVoSG90YXpWeWY2SWVtZ3Y2RzlvempkcFAvcWF5MnZ2SnRMalhJ?=
 =?utf-8?B?bHdjTEhEbzVDcHRJZFJLOG81YXJwWTdwaG5pc3VDZUFNN1ZhcFF3NzJzY0tJ?=
 =?utf-8?B?VDZFT1drZXV5UEhEY1lYcnhQM0p6QUR2M0pPR3QrdCs1Y2VRelkwQ2RyWEhK?=
 =?utf-8?B?b2FiRnhHTGgvWUJ4cnZXQWxLRGROV1dmcSs0d3dWWUlESVVWV3ltT2hnSEhI?=
 =?utf-8?B?dHJDUWwrcVMxUmdjSEZyZmIwMWgzYzdwYkswanVuMEVwdnlraWpWZVpmV0hJ?=
 =?utf-8?B?TTMyNGt5T3dQcVNtbFZvVERCSUJxaDN3a2x0WHQySnBpU0JPTXpMNGd6TzUx?=
 =?utf-8?B?OGZ0TXAySDhmZ3U0YlpVSXRtVmJjQVU5S3U4WXVPeFNvakt6dVJqc3VRNWtj?=
 =?utf-8?B?dUZpd0hoc3RuWGxLeTJSeVBGUjhJeUh3bCtxWUdVQytNSmllY0czbWxtL3hl?=
 =?utf-8?B?eU80WEZFTWQvckhlL0NCUExJbGxIRTYyakx5SHg3aWlaSURzMFZMVFdmclQ1?=
 =?utf-8?B?Z01rUGxPZENlN3huZDdmb2VBRkoyWWVBZEdEWUhWV082eDhzZnU4SXp2aTRJ?=
 =?utf-8?B?Q3JOWmFhNExpakJjZTlzbURkN0Y1R1lTcXJBR0Iwb1pQb0w4VnBQOWNHMlda?=
 =?utf-8?B?SFJrOGppcUs0MW4zd1lSZVdkM3ZPYXNQZC94bGd4alBpOE9JNkdZM1drcS9y?=
 =?utf-8?B?WW96ZTBYWjF1ZS9tYXRYcWFsdkNyV2w1dXFlQnNTRkhTTzcyK0pPeCtwU0Ev?=
 =?utf-8?B?UDB3eUtEcDFRbEJMNlRhMTl4ZkhxYXNLUzllN1BpWmloUDRYOXA5S2lzSEpW?=
 =?utf-8?B?NWdvOE93WDBNd2Vla0xiaHZpZ0hGallUd3N5M2JHdktjaC9xUFk2QzNuNHUr?=
 =?utf-8?B?a3prejlTUFVLMUxsSHByV3dEeHFvNkN1cnlDKzQrVEYvL2lMS3lBTVhlV2tT?=
 =?utf-8?B?dlV4dmhjMTNUVEJsaE9TZmNvN1psd2hQTCtmUTl3eWI1RGN6SHNySDRJTlF1?=
 =?utf-8?B?Szg1dE9PcUl2SDdBV2lJd2ZaWEcwVzBkTDV2NUtGZngyQi92cG9vaFhUNzZS?=
 =?utf-8?B?ekhmRS9xUnIxSnRUV0RMNWdMSHM1K1gzNUI3b0E5NGQ5dERXZjVpdDBqV3gv?=
 =?utf-8?B?Q2lYZXp4aklaeFc4azBnOEZZZE0wUVZKc0NBY0NrZzRGblNXK2xWSmdEY2Rq?=
 =?utf-8?B?MWFnTWVFT01uZWg0eW8yMkQxRWtXOEtJNitjYlZPMm01bWI3UW1ZalVRelFV?=
 =?utf-8?B?TjQwR1hCQ3pCV24yamx5dS9tbEk2Zys4bk5ka0JPQ0RuNUVHZFhrQzZVcGgr?=
 =?utf-8?B?YXJ0ckRsVzY0UzJncDMzeHlvR2RBUXQwNTZRbEdHRmNsUmQ5YU03dVJQelJZ?=
 =?utf-8?B?UXo1NVB0VTdBYTQwazJqRk13dkx6dCtGT1JKNGVLbG9tb1RCL2w1Zkl0U25B?=
 =?utf-8?B?dnU4VnBURFgybVQzWkVWSWtMVi9EbGFxWFdTOWx2VXJkQzVzKzU5b0tRQy9R?=
 =?utf-8?B?Z1FxWnJoWUU2NnFqcERkMmI1T0R1OGhoZitZZWlVUHF6K1FCT2VVUmZGaThr?=
 =?utf-8?B?enJVN21ZZVBjdkE5YW9UcklBQStQSDZvVWRnUStNVWxSZ2FkMmhYWkxYay9h?=
 =?utf-8?B?d0p5K09MUUtMUkthMWIyS0xPemlnNGpwS01USFM3QkZpcCs1ZTF2cmNUQStn?=
 =?utf-8?B?K3U5QXdPMWZsK21tL2ZXeVBtSVhQdlZiYyt0ZERPWmRqK1Q2ZGtpejgvQmJo?=
 =?utf-8?B?ZVBMc05FVGVkMUJDQm1XSUh1dTlJUUdFdHEyRnhUWHZNWHBnYjdxR1pTc1FE?=
 =?utf-8?B?eU9TUnkwdXFJUVpGNmRBMUVJYkhGTlJ3NW5ZWnQxVTFyTzFpUFVxR2VPSkdu?=
 =?utf-8?B?Rko0Nm9wTytlZVgrd2dEaTlDdnpORG8vU1FDOEl0aGdTTDFod1VBSzBvQWkv?=
 =?utf-8?Q?VIOgnPaIl/dw5Fb/2AHHwfw=3D?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 019677c4-a403-4f27-964d-08de1bf24946
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2025 22:34:15.8319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LWwzPV5ySGulzUT3UaxCgi1ghAo3UB/NJLrhTSWv8V9w+s/4L/9MJos3JBujji8yjvx9rc0Nih7akB6OfhjYdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFCF61DF7DB
X-Proofpoint-ORIG-GUID: SYMQ-0UW2q6b19tRagBiG2Bim8XXQfjk
X-Proofpoint-GUID: SYMQ-0UW2q6b19tRagBiG2Bim8XXQfjk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAyMSBTYWx0ZWRfX70pWhr/tLUHk
 a7pTOa+jsoj2QnOW+LfLYuqKsoKZy0ktZ6x4VMREh8QvFQAnSuIvnPdmN+1LFCVw8KFCJvNdAs1
 iwM4CpErzV9hbkPJyP5xv9QS4JMbtEIC24yi9Pk1YVRlmP567CmmngT6ery/71MumV6nPab4Iur
 MfkeoG/nVUZ8OCrLjSm/rrWkF6L4I8r4MebXju4vAqN4qMJD9r0fhoIYQe1SbJodHAYhpKZdo8Y
 9O5eU+1DBn2NScNBv7kOHPenmF+ARDMYp5SgTscfHTfYdeexFD55q+4Qmu8bYmK8RyYwaunQwRa
 PyPBldJnonHYMZ6JIGpIReyvM9yoZ98ZJZS7mAaJ3vS4kyreytmpRFIJ8XcpGcaQG3/WhDAsV+0
 6aX06yWYv0de0IECZ2ZhKBCdiMIEgg==
X-Authority-Analysis: v=2.4 cv=U6qfzOru c=1 sm=1 tr=0 ts=690a7f6a cx=c_pps
 a=9TxNVFKjsEmGPsTOmRxrqw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=edf1wS77AAAA:8
 a=hSkVLCK3AAAA:8 a=3HEcARKfAAAA:8 a=7DOuw9-pm6xThIrnlSkA:9 a=QEXdDO2ut3YA:10
 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22 a=fDn2Ip2BYFVysN9zRZLy:22
 a=poXaRoVlC6wW9_mwW8W4:22 a=cPQSjfK2_nFv0Q5t_7PE:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22
 a=SsAZrZ5W_gNWK9tOzrEV:22
Content-Type: text/plain; charset="utf-8"
Content-ID: <19948407894EF9419735EDE8FA696288@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re:  [PATCH v2 1/2] hfs: Validate CNIDs in hfs_read_inode
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-04_04,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 spamscore=0 phishscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=2 engine=8.19.0-2510240000
 definitions=main-2511010021

On Tue, 2025-11-04 at 01:47 +0000, George Anthony Vernon wrote:
> hfs_read_inode previously did not validate CNIDs read from disk, thereby
> allowing inodes to be constructed with disallowed CNIDs and placed on
> the dirty list, eventually hitting a bug on writeback.
>=20
> Validate reserved CNIDs according to Apple technical note TN1150.

The TN1150 technical note describes HFS+ file system and it needs to take i=
nto
account the difference between HFS and HFS+. So, it is not completely corre=
ct
for the case of HFS to follow to the TN1150 technical note as it is.

>=20
> This issue was discussed at length on LKML previously, the discussion
> is linked below.
>=20
> Syzbot tested this patch on mainline and the bug did not replicate.
> This patch was regression tested by issuing various system calls on a
> mounted HFS filesystem and validating that file creation, deletion,
> reads and writes all work.
>=20
> Link: https://lore.kernel.org/all/427fcb57-8424-4e52-9f21-7041b2c4ae5b@ =
=20
> I-love.SAKURA.ne.jp/T/
> Reported-by: syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D97e301b4b82ae803d21b =20
> Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
> Tested-by: syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
> Signed-off-by: George Anthony Vernon <contact@gvernon.com>
> ---
>  fs/hfs/inode.c | 67 +++++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 53 insertions(+), 14 deletions(-)
>=20
> diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
> index 9cd449913dc8..bc346693941d 100644
> --- a/fs/hfs/inode.c
> +++ b/fs/hfs/inode.c
> @@ -321,6 +321,38 @@ static int hfs_test_inode(struct inode *inode, void =
*data)
>  	}
>  }
> =20
> +/*
> + * is_valid_cnid
> + *
> + * Validate the CNID of a catalog record
> + */
> +static inline
> +bool is_valid_cnid(u32 cnid, u8 type)
> +{
> +	if (likely(cnid >=3D HFS_FIRSTUSER_CNID))
> +		return true;
> +
> +	switch (cnid) {
> +	case HFS_ROOT_CNID:
> +		return type =3D=3D HFS_CDR_DIR;
> +	case HFS_EXT_CNID:
> +	case HFS_CAT_CNID:
> +		return type =3D=3D HFS_CDR_FIL;
> +	case HFS_POR_CNID:
> +		/* No valid record with this CNID */
> +		break;
> +	case HFS_BAD_CNID:

HFS is ancient file system that was needed to work with floppy disks. And b=
ad
sectors management was regular task and responsibility of HFS for the case =
of
floppy disks (HDD was also not very reliable at that times). So, HFS implem=
ents
the bad block management. It means that, potentially, Linux kernel could ne=
ed to
mount a file system volume that created by ancient Mac OS.

I don't think that it's correct management of HFS_BAD_CNID. We must to expe=
ct to
have such CNID for the case of HFS.

> +	case HFS_EXCH_CNID:
> +		/* Not implemented */
> +		break;
> +	default:
> +		/* Invalid reserved CNID */
> +		break;
> +	}
> +
> +	return false;
> +}
> +
>  /*
>   * hfs_read_inode
>   */
> @@ -350,6 +382,8 @@ static int hfs_read_inode(struct inode *inode, void *=
data)
>  	rec =3D idata->rec;
>  	switch (rec->type) {
>  	case HFS_CDR_FIL:
> +		if (!is_valid_cnid(rec->file.FlNum, HFS_CDR_FIL))
> +			goto make_bad_inode;
>  		if (!HFS_IS_RSRC(inode)) {
>  			hfs_inode_read_fork(inode, rec->file.ExtRec, rec->file.LgLen,
>  					    rec->file.PyLen, be16_to_cpu(rec->file.ClpSize));
> @@ -371,6 +405,8 @@ static int hfs_read_inode(struct inode *inode, void *=
data)
>  		inode->i_mapping->a_ops =3D &hfs_aops;
>  		break;
>  	case HFS_CDR_DIR:
> +		if (!is_valid_cnid(rec->dir.DirID, HFS_CDR_DIR))
> +			goto make_bad_inode;
>  		inode->i_ino =3D be32_to_cpu(rec->dir.DirID);
>  		inode->i_size =3D be16_to_cpu(rec->dir.Val) + 2;
>  		HFS_I(inode)->fs_blocks =3D 0;
> @@ -380,8 +416,12 @@ static int hfs_read_inode(struct inode *inode, void =
*data)
>  		inode->i_op =3D &hfs_dir_inode_operations;
>  		inode->i_fop =3D &hfs_dir_operations;
>  		break;
> +	make_bad_inode:
> +		pr_warn("rejected cnid %lu. Volume is probably corrupted, try performi=
ng fsck.\n", inode->i_ino);

The "invalid cnid" could sound more relevant than "rejected cnid" for my ta=
ste.

The whole message is too long. What's about to have two messages here?

pr_warn("invalid cnid %lu\n", inode->i_ino);
pr_warn("Volume is probably corrupted, try performing fsck.\n");


> +		fallthrough;
>  	default:
>  		make_bad_inode(inode);
> +		break;
>  	}
>  	return 0;
>  }
> @@ -441,20 +481,19 @@ int hfs_write_inode(struct inode *inode, struct wri=
teback_control *wbc)
>  	if (res)
>  		return res;
> =20
> -	if (inode->i_ino < HFS_FIRSTUSER_CNID) {
> -		switch (inode->i_ino) {
> -		case HFS_ROOT_CNID:
> -			break;
> -		case HFS_EXT_CNID:
> -			hfs_btree_write(HFS_SB(inode->i_sb)->ext_tree);
> -			return 0;
> -		case HFS_CAT_CNID:
> -			hfs_btree_write(HFS_SB(inode->i_sb)->cat_tree);
> -			return 0;
> -		default:
> -			BUG();
> -			return -EIO;
> -		}
> +	if (!is_valid_cnid(inode->i_ino,
> +			   S_ISDIR(inode->i_mode) ? HFS_CDR_DIR : HFS_CDR_FIL))

What's about to introduce static inline function or local variable for
S_ISDIR(inode->i_mode) ? HFS_CDR_DIR : HFS_CDR_FIL? I don't like this two l=
ine
implementation.

> +		BUG();

I am completely against of leaving BUG() here. Several fixes of syzbot issu=
es
were the exchanging BUG() on returning error code. I don't want to investig=
ate
the another syzbot issue that will involve this BUG() here. Let's return er=
ror
code here.

Usually, it makes sense to have BUG() for debug mode and to return error co=
de
for the case of release mode. But we don't have the debug mode for HFS code.

Thanks,
Slava.

> +
> +	switch (inode->i_ino) {
> +	case HFS_EXT_CNID:
> +		hfs_btree_write(HFS_SB(inode->i_sb)->ext_tree);
> +		return 0;
> +	case HFS_CAT_CNID:
> +		hfs_btree_write(HFS_SB(inode->i_sb)->cat_tree);
> +		return 0;
> +	default:
> +		break;
>  	}
> =20
>  	if (HFS_IS_RSRC(inode))

