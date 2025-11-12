Return-Path: <linux-fsdevel+bounces-68008-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8735DC506FD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 04:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0D9C034C04C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 03:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1DF2C0F6C;
	Wed, 12 Nov 2025 03:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="nWk4y37v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EC835CBA3;
	Wed, 12 Nov 2025 03:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762919160; cv=fail; b=ONyMF9Gvq4u5+cIFSQPLw+/BEPoWJjnQ4a/8VKX0CSzFO6FJxS/8C19G/tXBbkJDIiPQEgPl2aMp5n3gbMDda066H0ezEHjqVs/a5uNSMwcRLGW7t8O0fRiY0i7a4fsFXPVK2J2dKJF8j3KHOrw1xOeli8KdwSjk1eTp2QRGOcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762919160; c=relaxed/simple;
	bh=2t209jREzswk/qRQLHXxP9CCWpkVhp4woD9WpIRgmXc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=P4IbTwHtLJ8DtzSLIDuU1JDPHNhasLRQhxy9ZXf0EK3ki7che12SYiHImOjdAFiJYzvcIU6MvGMmSYsjE2gE1gAtSjV5BCqk7OzpkoichX0Pp+RsJq+MTsfVdn1oUWVLZcpQzxa5YcOfJ4IpfsPOTVGvb/7uKfP3jzCx2glReZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=nWk4y37v; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AC3JXaO1269494;
	Tue, 11 Nov 2025 19:44:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=So+hJ3UrUDUfsWuso8KRfSBuvQDAJS88TQsV3WEBAuQ=; b=nWk4y37vsCtn
	MWTxS9E0wgnrVAVAbpxSG2BukRq+nrHyHriDC6ythghno2Dw6jYwTGUYX3FODz/Q
	HBozXOyFsHIwHxrazYvc2rS2EswBAyIpiZo7gHK7sB5garFTKa527pbwrKIXq7Y8
	TRCQS/kifq+WCiY8lBnvGo6DDQ0jRladFTXdDo78154kyTRKmO5w00oTePPJjzgg
	svG1eMn5mpFrbNUZRUqD7qQqT2c5k5UpkEpvph8P1he6ipEXTubhhdWX3aY59Ux/
	9r938Glr/JYMp3bU66DL0kBBywlhdyYxn0mV4GFKwSkOHFh5yroE7suioJPCH3+z
	l0M2FGvYgQ==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013045.outbound.protection.outlook.com [40.107.201.45])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4acj7t83an-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 11 Nov 2025 19:44:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jPuQpjHlAFhlUgxN8jNnNcHh0yAXBnPi/hvZyhZILcAsi5khVVy3eEAiEeE8Je51eV3U5BeYxeqbIsbwTdv/PzFuI3J5gp06Hz42is1glM+B5wep5Zm03OL1c1jLnJz8knydi66G0YUoGIPiIpSUovNCI46smHkGkDKzJxoAFeb4zWHIBxNNoR15mjGw3Kh62Q1HcUhNewcFA5B10oOo2YapcoFr3PYA0MD9CjGOzF7e8fTsn7F96HsM7CwQiyMV3PKEidFgbk8NTLF3HrpZiOimwx469myLVcU+r+0VDFdnVrAuxMh3DNFwv2BVdRSdzc+qmEKsxxc0jmL3VoJz0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=So+hJ3UrUDUfsWuso8KRfSBuvQDAJS88TQsV3WEBAuQ=;
 b=gih/VpIpgNOdXKTznD8H+nVipC9HCwI+UgF/4kQSA6LefeQAjz08NoeFd2H/EIwaW0WX361dgfe58KSN3U8h97IR5HRcOSAd+h41TFxN9NH/KAmSkU/3Yxc1ZLRXN/ABenIABx8Nv4N0qvog/vbhHfSF2FIyWBUa0b6+mdEEZsfKj41dGzFLBiW6ml69ID2atZJ6/UoaPbaYY3o9/3ySa43aqPWQAtP/qTX7k4jhBLRNPCrafaL5jq8z+uoqSlh/dxUF3xnjXp6586l+LqRMqDU3V1nDf18dKg7rrTSF9dX7axwyz0tRD/X+JZJszM45GPnq94fXCW3Obr+Z/DeEpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from LV3PR15MB6455.namprd15.prod.outlook.com (2603:10b6:408:1ad::10)
 by SA0PR15MB4064.namprd15.prod.outlook.com (2603:10b6:806:89::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 03:44:36 +0000
Received: from LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::8102:bfca:2805:316e]) by LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::8102:bfca:2805:316e%5]) with mapi id 15.20.9298.007; Wed, 12 Nov 2025
 03:44:36 +0000
Message-ID: <e6b90909-fdd7-4c4d-b96e-df27ea9f39c4@meta.com>
Date: Tue, 11 Nov 2025 22:44:26 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 36/50] functionfs: switch to simple_remove_by_name()
To: Al Viro <viro@zeniv.linux.org.uk>, bot+bpf-ci@kernel.org
Cc: linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
        brauner@kernel.org, jack@suse.cz, raven@themaw.net, miklos@szeredi.hu,
        neil@brown.name, a.hindborg@kernel.org, linux-mm@kvack.org,
        linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev,
        kees@kernel.org, rostedt@goodmis.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, paul@paul-moore.com, casey@schaufler-ca.com,
        linuxppc-dev@lists.ozlabs.org, john.johansen@canonical.com,
        selinux@vger.kernel.org, borntraeger@linux.ibm.com,
        bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
        yonghong.song@linux.dev, ihor.solodrai@linux.dev
References: <20251111065520.2847791-37-viro@zeniv.linux.org.uk>
 <20754dba9be498daeda5fe856e7276c9c91c271999320ae32331adb25a47cd4f@mail.kernel.org>
 <20251111092244.GS2441659@ZenIV>
From: Chris Mason <clm@meta.com>
Content-Language: en-US
In-Reply-To: <20251111092244.GS2441659@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR08CA0001.namprd08.prod.outlook.com
 (2603:10b6:208:239::6) To LV3PR15MB6455.namprd15.prod.outlook.com
 (2603:10b6:408:1ad::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR15MB6455:EE_|SA0PR15MB4064:EE_
X-MS-Office365-Filtering-Correlation-Id: b1758d09-fa50-4319-7288-08de219dcc8c
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VWk4bU1CZE1sUHVJbWxzM3l2c05iMTRpUzRQYk9iUDdRZ01YSm5vVkpHZFFs?=
 =?utf-8?B?anpkRm9hSndtWTN2bk1hK0lpRENuU1lQK0EyckFNeGVhVkNuOFJycU81Z2FO?=
 =?utf-8?B?TGVRVGhXa0lyeDRjWU1KbHpXeHEwTWlpc0J5bHRUREhFQ093bXFHQm1IWVZn?=
 =?utf-8?B?Ykp0VTcwamF0NVQvMHFZb2xrODAyVWVhWWZ5TjQ1Y2o1aHVwU1VJNmdxQVJM?=
 =?utf-8?B?WWdweUErVHBMOTVIWU1oRGtabzVVaXd0aERVQ0FzU1FHRnpmK3EwL0tkOU1E?=
 =?utf-8?B?bWpUNzdJcFVsUmR1S1JzRGlESisxN3pKYlBISUU2cWl4ck8rWmdsdkFBYXdR?=
 =?utf-8?B?a2F0WU9oa3hkWkRxWndCN3RXSzgxcnloV05aelh6VXRrSEFzcTR6UWVVdG5l?=
 =?utf-8?B?NklaQ1RIaFJmUVhGM1dIVVBWYUVyWHg5YzhoNDZHczlOYkNtOVQ2SWRhU3pp?=
 =?utf-8?B?ckxEeTAybGdtSkM5YWIxWjAvNkhURTZFaWdlV2FzOXN2dEhnYTVJNDQzb0dK?=
 =?utf-8?B?cmh1b0hMc3EyK0RuR1p4MWNWMmFuUElaWHUrdlJVQTAvYVJsbmVPdEFESFVS?=
 =?utf-8?B?Y252WVpSdUZKSE93cnYycWh4T2VWVHBpZEdUMC9sK1pkSGFUU05JR2p2WUxq?=
 =?utf-8?B?VjFwRFhxajlkSS9xbWJKa1RNWjRoVTd6bUMwbzJ6OGFZN0FCbTdtMDFjM2t4?=
 =?utf-8?B?aU9CU0VyZmlxZ2c2M2FXYkt3U0V1VEhYd2dXWXY5a3JmL0MzZm14K3laRFN6?=
 =?utf-8?B?MEYraXJvS2plNEFvNlNkSzUxdUZuZFU5djRsYlc2dWwzVGJTd2xiY0JiZlVs?=
 =?utf-8?B?NUw3TjkxYWE5cnd6WC9rT1ZNUklDRmN1TDFUUFU1RExsSFppWHZnL0hPbUNY?=
 =?utf-8?B?TThrdWhtNlAzMmlpYXhSYWFGNTFPTlNnVEsxVS9RZHJhU0ZNVmVWYUZFdXlK?=
 =?utf-8?B?VkJmTGtjMTdNYnVZMWYzVlZuWW45Mnl6S092eFdCOVFCUkNjSzNpZGNrNEtn?=
 =?utf-8?B?Y2hoc2NoVWRrV01maVRSK1ViVS9IMU9qalF1dzRIcy9HTDhaM1ZBUEZTS0pL?=
 =?utf-8?B?L3hqc1lPZ09jQ0xVaFlhVFBONm53THdOV0x3a0o1WE5CSHkxMjBXWTEzYXpQ?=
 =?utf-8?B?b25tZmN3T0sxVzFEL2xhNHl4U2FpbnpiS012SUsxd2dsRjFhbytOazVFYUV6?=
 =?utf-8?B?QU1PY1MvMW1xNWI5cVN6SCtkRXZUQmVBY0xhOFFSeElwYkxwazBUMUNDVWw5?=
 =?utf-8?B?ZHNmVjhCVWkwNWlNc2lIeUVhZFV6eURDUUFvK3BqNTdYc3krZ1lXU3pubXEx?=
 =?utf-8?B?UVFXY3pBaUN5VWo5VHdWS09lb1ZuRjhIWWVZRXhiSXpvMnowS0ZrMHJYU0Fj?=
 =?utf-8?B?YnJONXZyd0pQc1I0RjQ3clFlZVU1WFBrOE53aDJrZUNBUFFjcVhkMEJGZXdh?=
 =?utf-8?B?bFhQcEhlOEp3NFR3S0xHWkZBSVhDTHRTVjlvdDBTZzMxYXRlZWxMYkJtRExu?=
 =?utf-8?B?eUZIZmJvalczc1FVY2EvazBXS295OHI3V096OUFaVmpFRTR2bDUrZzZBWWVM?=
 =?utf-8?B?WGUyY1hJVUZ4ZjBRVFNMakdYUDBZWGhISzF3Q09zbVQ1Z2ZURlJBdUlQWm1i?=
 =?utf-8?B?d0lCYktuS1VLOHNZK2dITWFPVStydFJYUzlHa0hrcU81R0FFYlh3djhCZzEz?=
 =?utf-8?B?aXZSV0RCYU5FS1kvSVVNemQ2VWJtb0FvczdTNWxGenJ4SWN2TnRWVTVrQk1v?=
 =?utf-8?B?alc3SDBaNHpzWTFPNG81Um1ydFZQRzhKbHQ5V2hPd0wzWnpqZ2owanBtVzVx?=
 =?utf-8?B?bjF2Kzc0V01ETkJMWUx2c1VsYnRHOGRRNDd4eDNoMFJ1UytwcFlyNXRINFp1?=
 =?utf-8?B?MWRNT1QyZmtNcXh3SldtYTh1YWlmaFpUVzBZZjkrVmFZY2VFL3I3Unc2QWNp?=
 =?utf-8?Q?REYaM6L2aPZkMgMPGGyc9tVsw3yfmThu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR15MB6455.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VUxkQnU5WjNVbHFxWFMrK2VFYkFUc2paYkJxYTY3MWFxaTU4UkNmOHFNQndq?=
 =?utf-8?B?ZkFPekNqSE01T1JDanBlUnVnNjJhbDhXWVFyaHo2U3BFc2JYZHhoSmdFbVBk?=
 =?utf-8?B?bWxiRS9rcTNTRUtqSEJUeVZuZkQyRVp3dldaUVRHWlM5dnRJdytLRXY2QW94?=
 =?utf-8?B?MEJaZkhsUUhrVGdlTVZGUW42MkNvOHNhSlhmUEdXVWl6S1RaaFExVG5BZFJD?=
 =?utf-8?B?S25VSkJRbjBhaDVJVEdJN2ZnTDFSaWlIaWRtMUgxdERWNUlyY0FPQnN1UkZS?=
 =?utf-8?B?aUJTcjBJRjlzaGtKUWFMNDVsZERsWlBlYXRBdUI4V0c0YXdoN0tlZmYxZkRD?=
 =?utf-8?B?Q01MZ2lYem80em9IamZ1bldyOFdScGZWYnhLaWJxVXVsQXlvOUhDb3p0VzVy?=
 =?utf-8?B?VlBFc2NOUnJEUCtheGR0c09uUnVreTVRaXRyczgwUXA5bTBteEc3RFllOE42?=
 =?utf-8?B?SHdTMzlJY3gyYThka01FbjNtZVVYT2tOd3ZBd0dlSlVzdGJXNDZJU0pkMnJK?=
 =?utf-8?B?eUpLMWg0YVNkV0YrWmY1c1V0ZG11RnBxR2cxdWdERHRubHV2emFJeEJHcitl?=
 =?utf-8?B?bm0wYU9MblVlSmRqY2JQWGQyWm0wSzVXQzF6OVpKaEhHL0FvVEQ3TEZHNUh1?=
 =?utf-8?B?VXh1MDlzRnl6ZjBrMnc4bEN6YjRVNWFHaGRFaEM3bFpLZnlIbGJVTjBxdWYv?=
 =?utf-8?B?MlRIUlYybHUrUnM5YjlMOVJxcis2WTkrOHpCT1dTczFEeFVDWmJHOGRXTEVC?=
 =?utf-8?B?NXR5NmZDT3ZVL3BKdnZ5b1NxUldRTFRzQU1MaklpOHpWc0Nnb3VzdU5PQlRq?=
 =?utf-8?B?bmZkRjNYUGNLZmYyUWhNMlVydXczajliQXJremliRjZoVXArOEtwUE5iQzIr?=
 =?utf-8?B?L3BhbEJBU1NvcDFrTXh5U1JBblNRaEN3RkFwbXRESjhoVVNuUGFKZmlESXZv?=
 =?utf-8?B?WWpRblY3Q0VKR1o2NUd6RFFVbCtQR2R6YUhUbzVwcnhEYjhtWnY1cHJvTlEv?=
 =?utf-8?B?aHdvbHRXejkwdzVjZ2FCQkRvVElVaGhWTExaVUdDZWZRTS9adVdscStpOTBj?=
 =?utf-8?B?aUdzNllGUWVEb1k1TUE4M2RVUjhyVGc5b0lQSTE4Y251Nkx4eHZmclhkeHY0?=
 =?utf-8?B?SjQyNXlWaEc4Y0NrMU5QZWtSSTRwc2loSjhGWjRUVDlTa25FOUljNVZURHhz?=
 =?utf-8?B?WE1MTk1udjgxdVo4bTR4Wm1JZSs0YWRUazUxdEs1cnFRN0tQb3ZaUVFkNjRW?=
 =?utf-8?B?L0o5dURzMkF4R2hoR3FqOWV6aXdHU1h5a0NnM1JUS0Rwd0l3MExGT1VyZll3?=
 =?utf-8?B?QytLWXgyOSsyd2xaRmlIb252UENnU2hrbkcvQzNma2RTdkxpWjNqY3JJSGNL?=
 =?utf-8?B?V0syUHl3MGJFSXZWcXNSVUhOVjdiTVpUcEFjTEFFd29zUGlWdDJPUHlMS0xD?=
 =?utf-8?B?Z25MREtBRzNmMUwrUHdtSVZNenF0aHBiVFdQYk9qOGFLbEFuS1h6aDMrWTRV?=
 =?utf-8?B?ODBudDlyOGZVdldtY1J1RWZ6WjBMWUlkQVRRcmdWQ29KS24wMDREUm9yZ3RF?=
 =?utf-8?B?YUNUWmJvb2NrU1dnVzk0M3JWUURyQ1ZMeFRWZEhyYllhKzJYTVQ1N25NY0gv?=
 =?utf-8?B?MkRKRXNWdnZJaHZ6d055ejVGaUtDSzZWcXUwT21uNHhRdHVraGozeC9tYVlu?=
 =?utf-8?B?MzVURFNOb2pGa05ySjRnMWpGeFpvaDRmb0lERU9memk3d2grNU5PNDFyLzNI?=
 =?utf-8?B?dlVGQTE5aS9TNDJVUStIM3BrVC84Q29Kczh4dVRHZHVnWE1aWlUydXpWMmw5?=
 =?utf-8?B?R2FjTUVYc3A1SFhUTXdXWHlQRzNsMlBodWlPYmIzWkwxRUhjRkFNUG8xcW5G?=
 =?utf-8?B?WXhrZDBOR3dCb25ocHVMZzVoVGpBY05zdWdDTUhkb3dubk41QWs4Qy9LU0Ux?=
 =?utf-8?B?RHpQNkg1dW9EdXovSEdaTm1UZmRMZHBIWC9YMWNiaWpKSTBTczdVcGZJS3dz?=
 =?utf-8?B?OUR5b1R5WFBIS1FkVDNOZUt5dmE3cHFVQ3d3YkRIQktsRTlkaGI3cDZxSXpy?=
 =?utf-8?B?MEU5ZmNpSXZXVjErdVZSRFcvdnF1SllUNU1VaUhuQVNoc2NOTjdVMjMvNEtT?=
 =?utf-8?Q?1wa8=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1758d09-fa50-4319-7288-08de219dcc8c
X-MS-Exchange-CrossTenant-AuthSource: LV3PR15MB6455.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 03:44:35.9906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 30wlE+G0iFqZg7YP77hESYVabKebrpAC6BIDrT6Ri/JwgpgMnRKyI13G+7xJIou3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB4064
X-Proofpoint-ORIG-GUID: kDZpPp3STOext23uSPrYVjkQb44YOY1E
X-Proofpoint-GUID: kDZpPp3STOext23uSPrYVjkQb44YOY1E
X-Authority-Analysis: v=2.4 cv=Wb4BqkhX c=1 sm=1 tr=0 ts=691402a5 cx=c_pps
 a=IhFJ2QRitvxj7yHj5jvJkw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=_3bh-1Pi-ry9tbEdrMgA:9
 a=QEXdDO2ut3YA:10 a=DXsff8QfwkrTrK3sU8N1:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22
 a=bWyr8ysk75zN3GCy5bjg:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDAyNyBTYWx0ZWRfX4vS7V7wdzrvn
 Qy7Mq/5grhTspsYbWLvBFUKc8TsRggUN0NPCSJiRxOmrG8MflNGqc3SN5sPPSaXohtB4OI6ESXh
 XxsqMGBS2UvAfSHngWXRGZOJsCAotC7GmdvGjmj2+WftcVouoHmI2bd3Fi5JSmaDWOxyqinPSOt
 jUcjmWyv6TQ57AcNU4w8Kr3qGYozQO1CeaKe0fhTgO8ureG5XCBEF2iZouhEzdRGgi1QB6qdS2l
 oNioed6IARsr859zjqDJCV71yQxWxQ2YIxtueCH6kGx+o2kc7etklizNDQYWI0lS1vmoVzfYTe5
 IkWyOhxeF7dHMS3H13eeUYdA/rU32Haa1tk/CPSa8o4DgNZrMIjD/Rs8aXlSu4aSEpvF3MN3Quo
 qfz6NKg+pJUAp5Rs2keTyr8wUXXLOg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_01,2025-11-11_03,2025-10-01_01

On 11/11/25 4:22 AM, Al Viro wrote:
> On Tue, Nov 11, 2025 at 07:53:16AM +0000, bot+bpf-ci@kernel.org wrote:
> 
>> When ffs_epfiles_create() calls ffs_epfiles_destroy(epfiles, i - 1) after
>> the first ffs_sb_create_file() call fails (when i=1), it passes count=0.
>> The initialization loop starts at i=1, so epfiles[0].ffs is never
>> initialized.
> 
> Incorrect.  The loop in question is
> 
> 	epfile = epfiles;
> 	for (i = 1; i <= count; ++i, ++epfile) {
> 		epfile->ffs = ffs;
> 		mutex_init(&epfile->mutex);
> 		mutex_init(&epfile->dmabufs_mutex);
> 		INIT_LIST_HEAD(&epfile->dmabufs);
> 		if (ffs->user_flags & FUNCTIONFS_VIRTUAL_ADDR)
> 			sprintf(epfile->name, "ep%02x", ffs->eps_addrmap[i]);
> 		else   
> 			sprintf(epfile->name, "ep%u", i);
> 		err = ffs_sb_create_file(ffs->sb, epfile->name,
> 					 epfile, &ffs_epfile_operations);
> 		if (err) {
> 			ffs_epfiles_destroy(epfiles, i - 1);
> 			return err;
> 		}
> 	}
> 
> and invariant maintained through the loop is epfile == epfiles + (i - 1).
> We start with i == 1 and epfile == epfiles, modify neither variable in
> the loop body and increment both i and epfile by the same amount in
> the step.
> 
> In other words, on the first pass through the loop we access epfiles[0],
> not epfiles[1].  Granted, the loop could've been more idiomatic, but
> it is actually correct.

AI was getting confused about epfile vs epfiles and didn't realize they
were pointing to the same memory.  So I put some changes into the prompt
to sort that out, and it found a different variation on this same
complaint.

We're wandering into fuzzing territory here, and I honestly have no idea
if this is a valid use of any of this code, but AI managed to make a
repro that crashes only after your patch.  So, I'll let you decide.

The new review:

Can this dereference ZERO_SIZE_PTR when eps_count is 0?

When ffs->eps_count is 0, ffs_epfiles_create() calls kcalloc(0, ...) which
returns ZERO_SIZE_PTR (0x10). The loop never executes so epfiles[0].ffs is
never initialized. Later, cleanup paths (ffs_data_closed and ffs_data_clear)
check if (epfiles) which is true for ZERO_SIZE_PTR, and call
ffs_epfiles_destroy(epfiles, 0).

In the old code, the for loop condition prevented any dereferences when
count=0. In the new code, "root = epfile->ffs->sb->s_root" dereferences
epfile before checking count, which would fault on ZERO_SIZE_PTR.

And the crash:

[   21.714645] BUG: kernel NULL pointer dereference, address: 0000000000000030
[   21.714764] #PF: supervisor read access in kernel mode
[   21.714851] #PF: error_code(0x0000) - not-present page
[   21.714968] PGD 10abe6067 P4D 10c0fa067 PUD 10864e067 PMD 0 
[   21.715155] Oops: Oops: 0000 [#1] SMP
[   21.715226] CPU: 15 UID: 0 PID: 1071 Comm: test_ffs_crash Tainted: G            E       6.18.0-rc4-g2b3cd169d144 #9 NONE 
[   21.715404] Tainted: [E]=UNSIGNED_MODULE
[   21.715468] Hardware name: Red Hat KVM, BIOS 1.16.3-4.el9 04/01/2014
[   21.715583] RIP: 0010:ffs_epfiles_destroy+0xe/0x70
[   21.715681] Code: 4d ff ff ff 31 ff b8 01 00 00 00 eb 97 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 0f 1f 44 00 00 41 55 41 54 49 89 fc 55 53 <48> 8b 47 20 48 8b 80 50 01 00 00 48 8b 68 68 85 f6 74 3a 89 f6 48
[   21.716055] RSP: 0018:ffa00000024cbe60 EFLAGS: 00010202
[   21.716167] RAX: 0000000000000246 RBX: ff1100011ae81a00 RCX: ff11000117810540
[   21.716286] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000000000010
[   21.716461] RBP: ff1100011ae81a28 R08: ff1100010c1f7ac0 R09: ff11000111499ea0
[   21.716568] R10: 0000000000000008 R11: 0000000000000000 R12: 0000000000000010
[   21.716697] R13: ff11000111499ea0 R14: ff1100010ca5d260 R15: 0000000000000000
[   21.716828] FS:  00007fdb2dbd6740(0000) GS:ff1100089ae74000(0000) knlGS:0000000000000000
[   21.716992] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   21.717149] CR2: 0000000000000030 CR3: 000000010a2bb004 CR4: 0000000000771ef0
[   21.717296] PKRU: 55555554
[   21.717347] Call Trace:
[   21.717390]  <TASK>
[   21.717434]  ffs_data_clear+0xbb/0x140
[   21.717496]  ffs_data_closed+0x8e/0x1d0
[   21.717565]  ffs_ep0_release+0xe/0x20
[   21.717639]  __fput+0xdd/0x2a0
[   21.717702]  __x64_sys_close+0x39/0x70
[   21.717768]  do_syscall_64+0x5d/0x920
[   21.717873]  entry_SYSCALL_64_after_hwframe+0x4b/0x53

And the repro/fuzzer:

/*
 * Test program to reproduce FunctionFS crash with eps_count=0
 *
 * This program creates a USB gadget with no endpoints (only EP0),
 * which triggers the ZERO_SIZE_PTR dereference bug in ffs_epfiles_destroy().
 *
 * Setup:
 *   mount -t configfs none /sys/kernel/config
 *   cd /sys/kernel/config/usb_gadget
 *   mkdir g1 && cd g1
 *   echo 0x1d6b > idVendor
 *   echo 0x0104 > idProduct
 *   mkdir strings/0x409
 *   echo "1234567890" > strings/0x409/serialnumber
 *   echo "Manufacturer" > strings/0x409/manufacturer
 *   echo "Product" > strings/0x409/product
 *   mkdir configs/c.1
 *   mkdir configs/c.1/strings/0x409
 *   echo "Config 1" > configs/c.1/strings/0x409/configuration
 *   mkdir functions/ffs.test
 *   mkdir -p /dev/usb-ffs/test
 *   mount -t functionfs test /dev/usb-ffs/test
 *
 * Run:
 *   gcc -o test_ffs_crash test_ffs_crash.c
 *   ./test_ffs_crash
 *
 * Expected result on buggy kernel:
 *   Kernel crash when the program exits (cleanup calls ffs_epfiles_destroy
 *   with count=0, dereferences ZERO_SIZE_PTR)
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <stdint.h>
#include <errno.h>

#define FUNCTIONFS_DESCRIPTORS_MAGIC_V2 3
#define FUNCTIONFS_STRINGS_MAGIC 2

/* FunctionFS flags */
#define FUNCTIONFS_HAS_FS_DESC  (1 << 0)
#define FUNCTIONFS_HAS_HS_DESC  (1 << 1)

/* USB descriptor types */
#define USB_DT_INTERFACE 0x04

struct usb_interface_descriptor {
	uint8_t  bLength;
	uint8_t  bDescriptorType;
	uint8_t  bInterfaceNumber;
	uint8_t  bAlternateSetting;
	uint8_t  bNumEndpoints;        /* 0 - no endpoints! */
	uint8_t  bInterfaceClass;
	uint8_t  bInterfaceSubClass;
	uint8_t  bInterfaceProtocol;
	uint8_t  iInterface;
} __attribute__((packed));

struct ffs_descriptors {
	uint32_t magic;
	uint32_t length;
	uint32_t flags;
	uint32_t fs_count;  /* Count of FS descriptors */
	uint32_t hs_count;  /* Count of HS descriptors */
	/* Followed by descriptors */
} __attribute__((packed));

struct ffs_strings {
	uint32_t magic;
	uint32_t length;
	uint32_t str_count;
	uint32_t lang_count;
} __attribute__((packed));

int main(void)
{
	int ep0_fd;
	struct {
		struct ffs_descriptors header;
		struct usb_interface_descriptor fs_intf;
		struct usb_interface_descriptor hs_intf;
	} __attribute__((packed)) descs;
	int ret;

	printf("Opening /dev/usb-ffs/test/ep0...\n");
	ep0_fd = open("/dev/usb-ffs/test/ep0", O_RDWR);
	if (ep0_fd < 0) {
		perror("open");
		fprintf(stderr, "\nMake sure to setup configfs first:\n");
		fprintf(stderr, "See comments at top of source file\n");
		return 1;
	}

	printf("Writing descriptors with interface but NO endpoints (eps_count=0)...\n");

	/* Build descriptor structure with interface descriptor but no endpoint descriptors */
	memset(&descs, 0, sizeof(descs));

	/* Header */
	descs.header.magic = FUNCTIONFS_DESCRIPTORS_MAGIC_V2;
	descs.header.length = sizeof(descs);
	descs.header.flags = FUNCTIONFS_HAS_FS_DESC | FUNCTIONFS_HAS_HS_DESC;
	descs.header.fs_count = 1;  /* 1 descriptor for full-speed */
	descs.header.hs_count = 1;  /* 1 descriptor for high-speed */

	/* Full-speed interface descriptor - NO endpoints! */
	descs.fs_intf.bLength = sizeof(struct usb_interface_descriptor);
	descs.fs_intf.bDescriptorType = USB_DT_INTERFACE;
	descs.fs_intf.bInterfaceNumber = 0;
	descs.fs_intf.bAlternateSetting = 0;
	descs.fs_intf.bNumEndpoints = 0;  /* KEY: No endpoints! */
	descs.fs_intf.bInterfaceClass = 0xff;    /* Vendor specific */
	descs.fs_intf.bInterfaceSubClass = 0;
	descs.fs_intf.bInterfaceProtocol = 0;
	descs.fs_intf.iInterface = 0;  /* No string descriptor */

	/* High-speed interface descriptor - also NO endpoints! */
	descs.hs_intf = descs.fs_intf;

	ret = write(ep0_fd, &descs, sizeof(descs));
	if (ret < 0) {
		perror("write descriptors");
		close(ep0_fd);
		return 1;
	}
	printf("Wrote %d bytes of descriptors (interface with bNumEndpoints=0)\n", ret);

	printf("Writing strings...\n");

	/* Write strings with 1 language, 1 empty string  */
	struct {
		struct ffs_strings header;
		uint16_t lang;
		char str1[1];  /* Empty string (just null terminator) */
	} __attribute__((packed)) strings_data;

	memset(&strings_data, 0, sizeof(strings_data));
	strings_data.header.magic = FUNCTIONFS_STRINGS_MAGIC;
	strings_data.header.length = sizeof(strings_data);
	strings_data.header.str_count = 1;   /* 1 string */
	strings_data.header.lang_count = 1;  /* 1 language */
	strings_data.lang = 0x0409;  /* English */
	strings_data.str1[0] = '\0';  /* Empty string */

	ret = write(ep0_fd, &strings_data, sizeof(strings_data));
	if (ret < 0) {
		perror("write strings");
		close(ep0_fd);
		return 1;
	}
	printf("Wrote %d bytes of strings\n", ret);

	/* Closing the file will trigger cleanup path which calls
	 * ffs_data_closed() -> ffs_epfiles_destroy(ZERO_SIZE_PTR, 0) and crashes */
	close(ep0_fd);

	return 0;
}


