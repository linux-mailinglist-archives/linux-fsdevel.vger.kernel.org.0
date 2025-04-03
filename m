Return-Path: <linux-fsdevel+bounces-45615-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9690FA79ED0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 10:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59D6A1739B9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 08:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3D1241CB2;
	Thu,  3 Apr 2025 08:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TzQR9vUm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="u9jlOdP5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F0219E7D1;
	Thu,  3 Apr 2025 08:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743670712; cv=fail; b=m+w7S4WQTKOzhIv/meGcO43H4dz4cFvYLi7rEQ5MQDm6U5zgs4hPHadpr7OlpSFy3BX7tM+/CJR5g8O5ZKLkyP/DQjhF6exAF40nJ0a2ZJ3O5H2for/+coz3CQ/dKH2z9xgTX7i5yFeQKLz1XdaTBPlx6cEitbbjNE6AvXfJT+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743670712; c=relaxed/simple;
	bh=w2JOycXzVT5Vi/kEOTo8Eva3A8ROen1U0cyGbXSMYxk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b7QFhm9FYhLUb/+wHWMPG31LYK25dzp/O8HCX5ouZgjBBb2XRBjKqqkYBFmw52RhckXfCspRJ9WBbs1IGPzLwfPwOw6+YW75h1b90wESiT6PNp+dhkBmICXV0V//6YtrFdhdYObvnCT/O+9/IO1dy7JY2+zuH8nTod85nN0XTLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TzQR9vUm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=u9jlOdP5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5338trwO007790;
	Thu, 3 Apr 2025 08:58:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=pKpVYIpVaiPJw7wNQXRU+6kMop6tf3c3yw03g+P2xkc=; b=
	TzQR9vUm/ykt0Q52TvMUkz4YHwi7cvGHSM0iOqrvgbEa0V7X+2TTwvrfSCcCjxYE
	jmB3kKPdO+ZPfMR022D4R8jQaANgmRuSWJKL9OHsMPStQIr/5PwfFDaGC7i28C42
	NueE0w4Wg0eZcAwUrOeCt6ULjd+1J9yl343XEZU7WS3iMH+GiwBLqzn4QlEhvK4S
	NXyG3BJYKfdAS4rpmBOGM5u4HSceDDnminw65+5SxDSmSmRJ9Ziz+B15+Bz2H4I1
	5Tk8PbyJ5VbE+0lVWK4btVGf5YIVjPzDdngAY0BfsP5zOgdKS9TuE7Mc2qYxarE/
	i/BQLyrh8cJDysCAPpIG/Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45p8wcmuk8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Apr 2025 08:58:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5337RBWA033541;
	Thu, 3 Apr 2025 08:58:22 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45p7ac10k3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Apr 2025 08:58:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g3B5SPNfSwyLyiMN26O/hwKj5/t1IM8Vnpw7r10DVVsoa5yFTDScqdOEu/jgwW4IP2rolmkmCwytzRJnZ+hSyt6v0qVsZt6ugECKBjG1+ow97so8SJsO71kvSHWspXcQNYOU28MU1YJOOBmxd0I4lUK3XlmtVmc+IE3aXuXdDR1/a8aUgdMinQkTtB6B298YpfKsyGuPym3Nr3SNH3N/dvG1yrBEvUWeVJjolK4oW4iH6+6fauRIH0hwPp2DMQIHgWG1sygI4IIZ1UbUypx50GfrGqgnK/NNBNLNLjhFMMZuMujrpHG8TAhnF8YSVIvx8TfzJ4w87f2zlRoXqYB2Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pKpVYIpVaiPJw7wNQXRU+6kMop6tf3c3yw03g+P2xkc=;
 b=i1x2W7LUs64tr3bKBp733B+S8ClSgYrm6xBN2JrL5sW+C+S8ApZpg4+3nT2cQKT60aslNaOY0O6/pvMp35Vd9f/sYhdE0JvFAAwTfqjsiVtY8Mq7PZ7NWUtO3V4Vhw7BGWsgBfN5xrDd9aFcY5Md9uj4PO1YFozmTHFMHhgy3dusXz7jMI1i8YD6GRoHXcjfvaUEBZKNzpEYrhVTNWAzj+BtdP4LyCpb1z82ZT6k9fygeowF7+EqR+MdipVEGCAMpfMofDuDE7ZUkroKAhNxZDiyvxKQHJUbauITTOed6ufjIt7GeWcP2rgI0vP0y9hDGEQquD0vcfhOYjzs8BBBOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pKpVYIpVaiPJw7wNQXRU+6kMop6tf3c3yw03g+P2xkc=;
 b=u9jlOdP5/lQeyhmu6M8YDmRVeyCTlvsmvjYncdG2072/T69pK3/vEfJFIym/1vo223vxdgL3nkoAQaQAec6CTxO7B0+md+JhFGlrjyz28G8G35hN/Mh89vgP/aLctxkvFp25/n7ADbevmDjUocdjOu40VCCh+tHIEjo6ju2kzBs=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ5PPF1A1B8C819.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::78f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.36; Thu, 3 Apr
 2025 08:58:20 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8583.038; Thu, 3 Apr 2025
 08:58:19 +0000
Message-ID: <cad0a39d-32d2-4e66-b12b-2969026ece37@oracle.com>
Date: Thu, 3 Apr 2025 09:58:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] traceevent/block: Add REQ_ATOMIC flag to block trace events
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        linux-block@vger.kernel.org
Cc: axboe@kernel.dk, djwong@kernel.org, ojaswin@linux.ibm.com,
        linux-fsdevel@vger.kernel.org
References: <1cbcee1a6a39abb41768a6b1c69ec8751ed0215a.1743656654.git.ritesh.list@gmail.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1cbcee1a6a39abb41768a6b1c69ec8751ed0215a.1743656654.git.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0042.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::7) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ5PPF1A1B8C819:EE_
X-MS-Office365-Filtering-Correlation-Id: 95ff6db4-f9c4-415d-8c44-08dd728dae3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RGNCVTR1eXVJVGdQUTZsdXFUY253NXJJOC9peVdWV09uSU1sczRJaHUxQnda?=
 =?utf-8?B?N0FFaExmSkRucnVUWk4vQ0pEVjhJaFZvai9zNkFEYzdwUUw0Mjl6bmIvVlVq?=
 =?utf-8?B?Qy9qTTBHaTZsVndTYjNGSXM3YVNKM2lGVEtnUDJSWFZpU1NqbTlXUmE3NllC?=
 =?utf-8?B?RW8yaTVuZkYyRVk4RS9WYi9RZ2lwaUZiVjBzSy9hSWJCWWVrNXdQSjNNeTFM?=
 =?utf-8?B?Zkx0ejVWOUdkcDM0SFp6MFRNaE1icGlvN3A5bUhLNWFiLzhScGF5Q0c2UFpm?=
 =?utf-8?B?VWtPSW9mS0s0ZnBxUmVKaURhdHhVZStIRlkrS2RjWHBMazNodTRmcHVpd1lK?=
 =?utf-8?B?ekRUZTZxUWdnS0JTcHRHdit1V2JHSTFxU3JRSXVGc3dkUGdlS0dxM3FpbXdO?=
 =?utf-8?B?N21PZkxTd1VDc05JSUNZYSs4eEl2bjFnbjNLUExLUWtRb2xuN2IvOGxJeUQ3?=
 =?utf-8?B?UXdnVjRCVHlzcEJhdHNhNURjb3RQSEFtTVJUc2RmaXpxSFhUNk9Ra2xSSnl3?=
 =?utf-8?B?U2dJZWxXcThwell5d0lxa1A4L3dXUktJejdSL3pkN1FyL2Jjd2NtK2ZxL05U?=
 =?utf-8?B?WVRYaWxJVU96T1dhQnQ1cUEvRXUxRUwzTTZBUGN0aENEM0tSOHp1VTliZHVC?=
 =?utf-8?B?bVlqRUxaRTFjbTFsUW03WkJZaWFEVVQwSW8ycThIelUvQ1pOQndocC9FcGJm?=
 =?utf-8?B?SU5YYWw1RG82U0J3WFZpZnZTVlFNOGZBVStFQ2h6TWZEb0FjSjJoMHZMOE9B?=
 =?utf-8?B?N3hiWjFaSTFTcG05c0ZPdHFBaUVuQzhIeHEzS29nYmNxcDhTbWp0enYxTnhh?=
 =?utf-8?B?aWZpUGRubno4eVpOSXgyRGlEaTJsN3FxVHUxaWxEU2h2M3kwazU4Y3JlRlZB?=
 =?utf-8?B?bElXUHRPVFlGYVJmSHF5cEtIMzMraVNTSmV6S1A0YzN3SG5RbnN1Z0FNOUtF?=
 =?utf-8?B?ajdFTWg0ZkVmZlI3N1F4a3NRa3VoRG1xNlh5M1k4aTVra3NNWGpEa0REL3lj?=
 =?utf-8?B?Yi9DQ0tvYVE3UmxscHZhVWZSdXpQVjRaUXpUNlY1bGlUaWRIa0o4aGtaaFJo?=
 =?utf-8?B?Y2RSWWdqVjdVMG5LZllrZGRLQXNTTzIwRGxEVnYyVko5Z0pkbm1sY3ZDUktp?=
 =?utf-8?B?UmtCMSs1alovTGdudklRR0xtV1VtajIwZzMwb3piczcrelJjNGl3STJzS3ov?=
 =?utf-8?B?a3VjelJnaitqdzNqc0hOanZqUFAvREo1dHhnTHlpTmNQUzBXNUVUclVGMDhY?=
 =?utf-8?B?SHhuSTh5bVFhdEY1Z01IeGJ1NjQrTDlzYVVVUnMzVEx3T3kzWFBaZ0JieXBy?=
 =?utf-8?B?ODZMaFhMTEMzdEFOVEEzaHJNMnEyclBmRlFUN3V1VUFWcnkyYlQ5dm5xYzZi?=
 =?utf-8?B?eHBlMHpEd0ZJcVNBOWZTcEFIaXFKNExVQUFINi9HcTA2TDVad3BrUlY4dndS?=
 =?utf-8?B?bjNIcUEyZXE4T1J6d29EbHczTWFyd25KdkcwdVJHMGdPVkdYRGZzbzd4MDZ1?=
 =?utf-8?B?MXc2bzB5R25peFJxVlROVGdyZmw4QXdnWFFDcFgwVkg1M2JPeWZBM2xTY0JZ?=
 =?utf-8?B?bjc5NXBlVUZpYUxpMERoRW91eFZMcTM0L1I2NFdSK2sxbjZsVWZkczliMlNv?=
 =?utf-8?B?NnpZa25peCtHdWljd2RWZWlkV1JZeTRrYjRPckZtQmxNMkdHSzE1NjZJSG9F?=
 =?utf-8?B?NHgzMG1obVpEdEF5djNCZDdqTDMrTHpLYzF0SzQyVWIwZmhJS1lXdlNHeU5W?=
 =?utf-8?B?YjNjK09iUlpWVVhBZnVjL25oU2FiVDlYY255U0NWT2N6Wm9UakRBMHBZVCs5?=
 =?utf-8?B?cWJpOHN1UkVYRzFKbGdTbU1iOGdRakJ3bU1iTUFzQVdZbjZ3bldMZmIvSmZm?=
 =?utf-8?Q?aGGx8Zr57k1a+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UnNwNTJGV1djdGZ6M21NV0hlYVArZzRBSHpoSXFuWjNXU3JNcGNQbUg0eWp2?=
 =?utf-8?B?Vyt2UE8vUi9qemh2R3ZTNGxDTFU5SHRGb1JVaWVaTEVRTmd1Z3V6bWIvN3Rw?=
 =?utf-8?B?Q1RXRFJqdTQrVTNFUys5U3pjMzBYZkFrY1QvdXJmWTlaanFnWlFOYVIxYzRV?=
 =?utf-8?B?RGV2L1pldHZQb2wyWDFwVEVabHpxdGE0eUl6b29Vbm1GRnY0QU11LzJBN1RW?=
 =?utf-8?B?aHc4bWZ3RFFBZHVlcWJiRGMxNkFrb2hFeS9QM2phVGFmYjRtd0t3bitQMlJC?=
 =?utf-8?B?TjcvNTU0by80R2ZQK0U3TUg5M1l2R3BaZ255U0NaQ3JrczRPSytuYk9hZTJt?=
 =?utf-8?B?U0s4eTdUVGtCMkxzNG54Vk51QWVtZVQxN2xsbEdtRUNiY09lcFl3T2M3TFBl?=
 =?utf-8?B?SnZENjV4eFY3N1RiZm5ERUozaUV2VXdnbWFnbmROZGdFbWVOU2hSQ3RNdXlw?=
 =?utf-8?B?RVIzVithQllSK2w3dlhRcE5aQkdxa2t0NE5BcU1EaDhwaXUyTWlSSmJFb3RF?=
 =?utf-8?B?ZldiV1VqWFBPSjc5eU9mQVZseCtqdVpXOXYvTG9SbDNPMWFlTzVWOTdXbHRy?=
 =?utf-8?B?S25rSDE4QmhKWVhOaGdIYldzRHR5TWQ1MlFsTkc0TmJiWFk0ZHp4dmwyTmZN?=
 =?utf-8?B?ZXVLTFdCTTAxSTExS1FPTE5iRm5Ed2NSMnJRNENIVnJJYTVKMU82SlBnNE51?=
 =?utf-8?B?MXVNbWwzbEN0YTkxSHVXakRsZWpyVlpwVjE1YjFLbHVyWG9BWkJDbnAydVJ6?=
 =?utf-8?B?QkxCNFN1RTd4SGMrd3orVzl3MW5qMXp2dmdWRnVRVnNmQ0U4cEJLOWdIZlYr?=
 =?utf-8?B?RXdsSGIwd0lIUFRFRDZRNS9jdjJuZklhM3NmWmdlamJETzBKQ083dERzSTlS?=
 =?utf-8?B?QytQSmN5WTgySEhKc0F0OVVpMXF1THE4UjBoN0F1VGx3QkNHK1dkZk80NEtC?=
 =?utf-8?B?RjRZRUlMblhmZTQ1Q3ZMRmJxN1NpRmpkSFJ4NCtIQ0h1ektiOHBXRm0xVU91?=
 =?utf-8?B?UHFYVnRxOVB1aFJFYVhYa2RHS0VXWXZxL3lEeFBhdE9NZ21TR2N1OUZVVkRo?=
 =?utf-8?B?Z3hkSU9Nb2FhMjRxc052RnBselpaRjRHRzh4YTVNSWZoL0EwYUIrNDdDVE9N?=
 =?utf-8?B?MmlzTVpXTHR5QndUV205NlJIbXVvNnIyWGdwVW1EUll4c3Y4TS9OcVF6SDQw?=
 =?utf-8?B?Q2pJTUZEaEpFdEpnL1plSGtQdHR0ZE1YcjUraVloRFZncDcwZ3lqbjhmYjIz?=
 =?utf-8?B?d2lYV1dOSzhvTFgvSmwzQXNCSVhwVjZ5dE9SN3BFRmYyaEtkNFI0cm1mdlJk?=
 =?utf-8?B?bFZXOStTQ3VjR1BKa3djSENNNTZRbmtVanlPU3dNNnZSRFJyclpJREdmT2pT?=
 =?utf-8?B?YjB1VUlHK00ySC9OMFRNV2NBUlk3YmJMT3pOTFVnQWtFemZtS05TekVxWEZv?=
 =?utf-8?B?RFVXMUxudHhCbGZEWndSYmx6QmRGYS9pMS82d2twYkRlN0l1aW1HNlM4SEZM?=
 =?utf-8?B?cW1udWU5Z0VtRUFybUwzMVdwU29ycC95anFwNVd1Zm90VWhmZ0xPbXR6eU1r?=
 =?utf-8?B?K052dDBFb1EvUDY4RnU4bEF1U3Y5aXQyTHg1bXg1WHVTQXUzaUdQK2pCRkt5?=
 =?utf-8?B?eFlvemd1WUtDaDJYaFFRei85NEgwU0xoNXo2RnFPN2NEYUt2bjVkMjNab20y?=
 =?utf-8?B?Y2Nrb05ONkxLQ01xWFZuQk9CR1NUalFNS2pKakxmQ2s4UmtYQ05kS0ZOc2w2?=
 =?utf-8?B?WEhkVTYxZGJ0TEYzcXJiTmlCeTkzTFZJOEFGUU1zdkhyTWFxam5PM1J3TUdi?=
 =?utf-8?B?dEU3elZMQjhoYWlsOTIxMEVhYmhCd05GRjlEd2lPZVNjZ1pzeTEybW1VZC9B?=
 =?utf-8?B?czh0TlYzRUVNck96SHFsV3h3N1F0NXE0V0Yrb2RNdlh3d2J4YmswZzZRbThx?=
 =?utf-8?B?b2VPSE9UVWRTYzBYUktndHYrcGNHUEN0b2h2SVJRdkNCMk9ldXc4SXZZMG5a?=
 =?utf-8?B?MXc1ejU5dWl3cjlicHNKampVTHRMTHEyYmxYSm1nM3ZnTms1Um5hd0draklo?=
 =?utf-8?B?RU15bkh4YkxSYk0ySDJieUhGeHZEL2ZPa0hqb1ZzNWVkdHhtVTFObkZUa0hi?=
 =?utf-8?B?ZFd0NkhJOUYxL1BROTJqRFUrNHRvQUlDVFFQSHZ0dE1sRUlWdHRPVUQySWMw?=
 =?utf-8?B?d3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NvuLzQW5je9YLKRuSYJbT7yqIZYY6oweL6atmQEJbhRqC76FF0R/ZSN/neC0o75cn36k9O52aA0aP6ZSYbD51/S+u1Yfjo9DaIMFfaChE9mEPu5KHGpMHFKeFiV0CD4IizDVF5Iq3fgxQ+kGInjOXxZj3pqQ7Audg2REm4WlWHce/38dqaYDhxhfr+scaWqZuLPpVhy8IBx8FOTKiCNJPxRIaCagEeBOvMwOLXZzqT4EvpAlRxCIysIHeDZUmcG4XqLLP2WukniDS2jVBOusWh0xMowtZdTYurqFFbQuxnCnV9T1qA9+3PE9JRkDVW4wGLYo1Ch7UNkWY5fEpuajmb0fl+ueVKfehBAy3t6Ffk6wkmJ93ZT+UM7Sx/BfVhe8wzzsZUFDPuZJb+4G9emESaNli++97j8fLbupYcA3oTZTNktMlYN2mCi6UyWb2ujkBN3/BeJZM6BPftgztF6lP9s2LlwxqvLit/Jgt1XwHYuYpzviq9Ar2ZSXynlvO8YFxmfuLZG8MmN9DlMYAAQWCL6ttEKaSYwTQhXyF1gBxMx6Aj5flXZz5N0xzHrjmbHlW3lE+tyQG1oG/CoFoaP1NvGAr/0a8hZQCoQ8I6q7hAU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95ff6db4-f9c4-415d-8c44-08dd728dae3d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 08:58:19.7940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: STctYjS/92WjmTC2JY21fp+FDt2MSd3GFSCDbz6dzOY+HKv+9weJ4AGEACX2+w51KRNyhnp3SW90HlEWchjj3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF1A1B8C819
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-03_02,2025-04-02_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504030033
X-Proofpoint-GUID: sVGkAMQFPVjuFHSx1RA-S3JjHDIn8dZs
X-Proofpoint-ORIG-GUID: sVGkAMQFPVjuFHSx1RA-S3JjHDIn8dZs

On 03/04/2025 06:28, Ritesh Harjani (IBM) wrote:
> Filesystems like XFS can implement atomic write I/O using either REQ_ATOMIC
> flag set in the bio or via CoW operation. It will be useful if we have a
> flag in trace events to distinguish between the two. 

I suppose that this could be useful. So far I test with block driver 
traces, i.e. NVMe or SCSI internal traces, just to ensure that we see 
the requests sent as expected

This patch adds
> char 'a' to rwbs field of the trace events if REQ_ATOMIC flag is set in
> the bio.

All others use uppercase characters, so I suggest that you continue to 
use that. Since 'A' is already used, how about 'U' for untorn? Or 'T' 
for aTOMic :)

> 
> <W/ REQ_ATOMIC>
> =================
> xfs_io-1107    [002] .....   406.206441: block_rq_issue: 8,48 WSa 16384 () 768 + 32 none,0,0 [xfs_io]
> <idle>-0       [002] ..s1.   406.209918: block_rq_complete: 8,48 WSa () 768 + 32 none,0,0 [0]
> 
> <W/O REQ_ATOMIC>
> ===============
> xfs_io-1108    [002] .....   411.212317: block_rq_issue: 8,48 WS 16384 () 1024 + 32 none,0,0 [xfs_io]
> <idle>-0       [002] ..s1.   411.215842: block_rq_complete: 8,48 WS () 1024 + 32 none,0,0 [0]
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>   include/trace/events/block.h | 2 +-
>   kernel/trace/blktrace.c      | 2 ++
>   2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/include/trace/events/block.h b/include/trace/events/block.h
> index bd0ea07338eb..de538b110ea1 100644
> --- a/include/trace/events/block.h
> +++ b/include/trace/events/block.h
> @@ -11,7 +11,7 @@
>   #include <linux/tracepoint.h>
>   #include <uapi/linux/ioprio.h>
> 
> -#define RWBS_LEN	8
> +#define RWBS_LEN	9
> 
>   #define IOPRIO_CLASS_STRINGS \
>   	{ IOPRIO_CLASS_NONE,	"none" }, \
> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> index 3679a6d18934..6badf296ab2b 100644
> --- a/kernel/trace/blktrace.c
> +++ b/kernel/trace/blktrace.c
> @@ -1896,6 +1896,8 @@ void blk_fill_rwbs(char *rwbs, blk_opf_t opf)
>   		rwbs[i++] = 'S';
>   	if (opf & REQ_META)
>   		rwbs[i++] = 'M';
> +	if (opf & REQ_ATOMIC)
> +		rwbs[i++] = 'a';
> 
>   	rwbs[i] = '\0';
>   }
> --
> 2.48.1
> 


