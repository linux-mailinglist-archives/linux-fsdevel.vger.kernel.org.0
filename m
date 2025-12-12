Return-Path: <linux-fsdevel+bounces-71215-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F22CB9D62
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 21:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B084306E017
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 20:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDBE30DD35;
	Fri, 12 Dec 2025 20:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="HjWsIrdS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226F722F388;
	Fri, 12 Dec 2025 20:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765573094; cv=fail; b=PnsVX5lDMMNwgm2CNbDAMGgyN59pwB/NkxhLExQysHoCa6QEmPQQmyqaiWX+pzDyOujXxyzX4DhNHr5th4GpY74M2K7EbntVrhbxzBeHZD7CILTbXt5RrGfZC2NHP7unYDRfA7wmJqamQFv034FzUqro3CUjBu0rRg8xc25+0mA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765573094; c=relaxed/simple;
	bh=tbNkYNaCfs57U6l6yIIT8p9V715Z4+35iLuhCBMIP00=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dp0RbIUsIgsAHgHE0Dh9eNCuytePqyG/hm13QjDWW8pTxfG2TkdyVl5bOIxSQFmksN7XbyTq5edYYLbVFLqVzgVCWYDasZ4vpONGW4ys1x7k2OLPwXG+akq6zn85cWbAKYBteO0BEPtdjfdErRB2Sa/DIAFZ+m1U7zZpWD2TyUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=HjWsIrdS; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BCH0dZA604131;
	Fri, 12 Dec 2025 12:58:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=lBJOf/8TTmRPWwbwvr3uGJFV5HQRfSlrE3ULSqBcLMg=; b=HjWsIrdSluWj
	Fbivsft62xoYOHh4kFNwVISzTo0r3YwwlrpM3mLb2WkrfrBbWbps/m97Wngoiv3f
	XWUzNen3qHO9z6uZo//xHdgmyHcfvQCWFAPDLMjhdd1PfnIhbqLd1r7Tos0MGb8k
	J7QuWwdsp3um8RdeAewK7U0XRC/HhR+9PZ5IX0D++nXv6xdz65eF6W2pWbCiAGpa
	5+lXGjPt7npXScLzf4PoglJmE/3Npzv4GNIF3d+69zL6yVhMBrppoh3gh961MgLF
	g6ucs7fdMoMiHjFvo33oE6m/8d6oaYPyMr9jr+fHz8Fnvm9FfipcJURq1RM2nDgZ
	iIqYE/hfTA==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013063.outbound.protection.outlook.com [40.107.201.63])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4b0q2vswva-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 12 Dec 2025 12:58:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HEiw63JcG6KEFmzsgDwdaKzKrz7ak2PMjFPutO/cFB438p+iVoQRb1pkh7JeeD/aKKZWy45Q45+I/A0Oejno6NUkJLh5SqWD19Ezn9yiRF6sCUy/gz/cFqVHp07HEmjP4TR1Bf/jEPQ+V4GZemI78nzFDvyRs3FISaAmGbIhB1tnpCSX1ToI3Aubj9XPy6UUuJ7lFd10Snc7QQeDQJCVhKvQj7t0imtp+C+FjBi/AR6YfgOM6hSsOpPWeoq8SPiCKs7pEtjLxGUk+s2vVod0OrbaUuoyrUsWn88eKGNZTLp3Bzr/FAGttffmi8y0I2KUjj2rdpVNs60SAHJBfMCkAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lBJOf/8TTmRPWwbwvr3uGJFV5HQRfSlrE3ULSqBcLMg=;
 b=aS4mK2uDaFOwUGHo+cU5yL6FPDXam/0TTc8/w8Lv1lkHBISTUHeG3Rr5jSVmua4hJbR5uP2PPGvolR+lDg1nf7lEOLFB6sgMw7BlOXO3yeGbkljdErtHJrvDlsWniK323ZwzpSeJdBZ5AABc8ReKYah3PGoQ/dG5dBUSlbBsXeuxeZFZiTl7VchbPSpXvcFa0cmoDNH8GCCQnwkUGlWh/QuD3X6hLh3oKuolVVfPWS5DZjh6DuX/uI/dqKlz62xYPyaoyF2/aacZpkAivJ+06Ll5b6rR0nvC4awk4vLx/d1+rUCnvtHPILR8vLOVGK5MtHdQXaRDA/53aagE6BmrXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from LV3PR15MB6455.namprd15.prod.outlook.com (2603:10b6:408:1ad::10)
 by SJ0PR15MB4759.namprd15.prod.outlook.com (2603:10b6:a03:37c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.11; Fri, 12 Dec
 2025 20:58:01 +0000
Received: from LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::8102:bfca:2805:316e]) by LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::8102:bfca:2805:316e%5]) with mapi id 15.20.9412.005; Fri, 12 Dec 2025
 20:58:01 +0000
Message-ID: <b36a8812-e2ce-46a8-b24f-022e6c4d62d3@meta.com>
Date: Sat, 13 Dec 2025 05:57:49 +0900
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] fs: add predicts based on nd->depth
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20251119142954.2909394-1-mjguzik@gmail.com>
 <20251212012236.3231369-1-clm@meta.com>
 <CAGudoHFus8zBCmF=vS_HNQimQfTUwqUqohZ-gNzZ2T7TOfNbPw@mail.gmail.com>
From: Chris Mason <clm@meta.com>
Content-Language: en-US
In-Reply-To: <CAGudoHFus8zBCmF=vS_HNQimQfTUwqUqohZ-gNzZ2T7TOfNbPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0238.namprd04.prod.outlook.com
 (2603:10b6:303:87::33) To LV3PR15MB6455.namprd15.prod.outlook.com
 (2603:10b6:408:1ad::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR15MB6455:EE_|SJ0PR15MB4759:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ea45794-400f-4ea1-8591-08de39c122c7
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cHFXWXB0M0hIRVZuUVV4VWtnZmdkUGhiR0ErQk1waUV2YzN5UUgzTys2eDhx?=
 =?utf-8?B?RlZIekhHbGVWNVpoNjBDcEtFa00xdE9iQVVDYkNPeHpDSjB2NVNtZUZiSTVz?=
 =?utf-8?B?WkJvN3hUZEJFZ2hGWmlMSUJmcGp1akZocFRqQlJUSXJoNTlxN2xXNW5rK1lZ?=
 =?utf-8?B?NjlsYTZTcmhhUXRtbjV0U0JremRFWVpDVnRCckJYb3kwTzFmblZ1aGRQYVNY?=
 =?utf-8?B?R0J6Z084VjUvVWNudXJMQXRoZUM1THZjdlBVZjFXdFVpQnQ1RnFnN1JZaFR4?=
 =?utf-8?B?R3RteVNnQWdxM09nMGRFV3NMMjZRQUtqKzdUM21tMzR4R283TEpaaCsvUmZq?=
 =?utf-8?B?QktXSVpPMkkxTGM3bzFidlBaRVFDL0JsMkVJZktkK0hZRENWWTdGSTZGd3NS?=
 =?utf-8?B?V3ZjR014ZytIMkdkczhsV3hRSU5aam1DaGRyTURZUEtMRUJMODlsaGFTempa?=
 =?utf-8?B?M0VwdXpMbGZUdjNyZXp5OGl2R3VPQzdwVDgyd0tqOW1mWDdPWVIrcDhSalJ0?=
 =?utf-8?B?dTRKQ3RoUGxjeVpXU29DNE9Nb0VNczNUMGxnNEN1b2gzaStKTDhrd3Rjb2ZC?=
 =?utf-8?B?QURuWlMyMzJ3Y3pUMnI5Y1VlOE9mTU4rNWJMZTdNbGRINXhhbmcwNDJodjkx?=
 =?utf-8?B?RVBaVDE2UUtIeFA1UTlDUE94bVlpR1ROYjVRcFlldDQrdzBDbkI0VlRlbGRn?=
 =?utf-8?B?VmE0UEs1MnFGblNwdldaNUtmc0p5Y3pRNkpjVktUcFJvV1JFc1J1TUhsdmZo?=
 =?utf-8?B?VHBlbFZTaXZRakZENUxEUXVWUzZ0cGFndDhrdzBBeFYzaytoVVBBV3QyeXNS?=
 =?utf-8?B?TGxRRUJOeE10T1lRQStEa2wwMGRUcU1xSmdQeDlGQjF3aXJiSTlQWTRINWx6?=
 =?utf-8?B?aGJHTkNna3RjeENnaUtpanV0SlN5WnRTUlA4K1VxRjYyUTh3RE9mUmVhYmty?=
 =?utf-8?B?SWp5SnNtT1E0aFpRMWhlZnBoajAvcGgyTnVlT2JDVm80S3N4b2s0ak85SkRH?=
 =?utf-8?B?dzl1aWtJUXZSeDRRQlVKRHo2U1FXMVRWd3dzdkd2VHRqWUZCQkhRcGtpZXJS?=
 =?utf-8?B?dW5LNVdCbnlJdjlzbDlFQnYvWUJXUytQUHc3RkpSSGRBZUZtbHRGZHlvTDJn?=
 =?utf-8?B?RUpWUlh3VHE1alB2NElYamRLaDVjdHZoUzJPdHFsSm82L1JtR081aTFRVklt?=
 =?utf-8?B?SjFPaDVzMUI3SHQvN3RQdjF2SUhMM1JIWkdjTTBtTVQ5T3RCSEFiQ1hYMmd2?=
 =?utf-8?B?Z3Q3cms0TW9aenE1MFpCTzVMYVBXTHk2Mlkrc1p5bTRmVkJHamlGV0JBMmlT?=
 =?utf-8?B?VGtuTFQrOXpaMmY5ckVHaGtRUGxkeEI5S3p1aC9uR0VaY0lCQ1pEYVdWVGdG?=
 =?utf-8?B?c0lXMTBlcjRHMnJ0RVVBUks4VE00emwxWVJSc3Zlcy85ZTlqV2NiTTkzajZ1?=
 =?utf-8?B?TVVjMFpXbVNrRGIrbFVHdEovS1haamVoY2hydG02SjJmK0dKWUd1TGpYRzdh?=
 =?utf-8?B?RkRBUE9YaWpCNEVaM3hENjVqWUU2R3dsV2ppWnRuVFFjOFRCaVRObFJUTEFY?=
 =?utf-8?B?RUFkNFNyMGt1WkMyc0ZLWFYzYW5lTS9vVmhaQnVrb1FXOWN5bHRtRnRIcUNW?=
 =?utf-8?B?Zm9hVHZud2xRYVcvYkZZbWtpRW8xVWFCYXBPVXlHUHg5VG5sRTNqMFdGK1N1?=
 =?utf-8?B?TElwNE9xdGU1NE9FQ0lBUWY4a29YeC9HT1B2THZBcStkbW0zN3psYVoyTkVw?=
 =?utf-8?B?U2hHcHpJaXpSUnFycDNGVDRUVSsxYldXK2dIQ0ZYR0ZOakZoMEtSTEJHaWNH?=
 =?utf-8?B?VHZtRG5nOXlaSDFzZ2w1dmQzUVF1ekNSbUYyRThyMlI2N3JEL081YllzdUo2?=
 =?utf-8?B?S1BNVmhaVTNxTHVvRFJHVjNnNVFLeUpycWVrR0t1SXRzY3ozaGdCa05KbGVa?=
 =?utf-8?Q?ZkYH6ALbehur71FY4fETTK9pySAF8/FU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR15MB6455.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TGkvZU8yTmpxUEJUQnZwV3FkQmN3N214RnQ5MjNWQkMxR3RNMHJDeWx3bVY1?=
 =?utf-8?B?QWR3REhEa0pLclg4c2xHdWRrbnR5NWxZK0VnRnIrcnFra3Z1bXVPVWdWZmVM?=
 =?utf-8?B?UFZZNlhocXIzWDM0UVQzQmp4TTh0bTFUNnJDMlFBN0dIMzU5MnUvWXJZNEVG?=
 =?utf-8?B?d2xkRlZCeWdFNTBnWXhXcFhyOVBNSXIxV1drVmZiU3FnNy9Xd0JmeW1NVXRr?=
 =?utf-8?B?clAzczZ1ZDVwY2hlalg1MTVEMEFMYTdITnAzMTcyZFNJcE56UVNpbWw0ZVY1?=
 =?utf-8?B?emRkTU9Gc0pQa0NkeXd3ZkZSZlYvNFdxQkwzUko0ak1od3E1aExReUppOTdt?=
 =?utf-8?B?Q0MzbEk1ZkF3TVJweHFQUXRHRXlwdXRhWk1BMjZZVCs2akpMN3ZMbjkwSjdI?=
 =?utf-8?B?SVBHa0pUYTd6a1gxd01YTDFGN3NZOFU5S29NUjk1NkI2WGlKZE0wUVlsaUlw?=
 =?utf-8?B?cUJ0eVgwU3FQS1NZalp3aWVSNTh1Q1VPSGxPSGFMYWczaEpBcjdaWW5ESVRs?=
 =?utf-8?B?Z3FaVkoyYkxmQk50end1VEJEQnBVMHc1MUJPc21DL0dlVS93bXNQbG9RL1Yz?=
 =?utf-8?B?L1Eya3FWK3ZxdVBvazVPakoyWm9TSUtXTmtVTUNrSlcvUnFVSDhFdnpnZDgr?=
 =?utf-8?B?YkJQd21IUzNuaWM1UEVlK2VUYzBtQnZNcHRjckdzMlphK3cvbU4xdmt5bmtY?=
 =?utf-8?B?b0lHNnA2UFRhQUlURFhDblJvbHlva2duL1JQVnUzOHY2dm9WOW9EaWFQd0Jn?=
 =?utf-8?B?UzFxU2VxOVJyMm92QW8wYzVPLzZoWmkvV2F0c25QdWNrL2xyTDVVNTB4Y0l2?=
 =?utf-8?B?d2dkSlBlSnlGcFE0M1JrdnZvREFNNUxNakR5NERBN21kRGNjOC9xTExjOFNH?=
 =?utf-8?B?VEdkb0FESm56YklrbXRQVG9mRHVHYU9Fa3FNZUZpMUhyblRJdUY4TTVqUEo3?=
 =?utf-8?B?UVc0Q01PQkpxdkdHK0c4NFNCbVcyeFVQT0w2czhhc1RyenFWSk9CMDVXZGJ4?=
 =?utf-8?B?RGNKZkllMEYxUUNCOUozWWdOQ01yNHZ3K3NqNEtOak51VmQ0alZtVnh6RTdS?=
 =?utf-8?B?bCs5WGRJeGJzSFFDa09IN3gwQnpMcXBsN29BWkRaczlxc3RJT2xPZXgxNkhY?=
 =?utf-8?B?c3UwWUNYdUVMUlpSSldSazJacFJWOFZaL2dmcHBPK1NqdjdsOE90U3pqb0Ry?=
 =?utf-8?B?c28rQUZqcGExalZ4clFXN2NWYzFiMFBEWllpQXdSV3JnUnFRcFViN3hWTlo2?=
 =?utf-8?B?QUJrVldxMzZ4WnRSbjM2dDFMNjdxdHI4TEpabURmeWJXU1N0RXM3SWxFS0Rj?=
 =?utf-8?B?VXlacmNDTXNEbnh1bS9DNVg0eTg1dGMvMjhoWDRIWkRaRzV4V01tYkZBSVI3?=
 =?utf-8?B?STRRV3duNHNwaDFNWG04MElUQ2RTNmFHV3A0eXBwczVHTjV2RVhuQXBPbDJD?=
 =?utf-8?B?R2IzaGp3RG5meHJnd3lIZ2xBWFEycGZwK00weWRzd0g1bDBaYnFDazl3Y2VB?=
 =?utf-8?B?T0lZS3hocW1jblAxZ3pPanV4YlhVdGp1cGpXZ0ZrakgvV0JLK09jRUxCazZl?=
 =?utf-8?B?R3VJRCt1cUFFKzZ6a0lqS21JWlkzZndiL3hvNEJmNzg5bVhGc2ZKT3d4S0k3?=
 =?utf-8?B?c1hnbjJ1ZE5vV3JpT244bElOSjRmSEtxZDBFWnNEWTZsbW45Q0dseURORExs?=
 =?utf-8?B?ZGU5bHZZQ1NXeDlOYkxmb2NnWGJtK21McnBKOXJKOTZYdU9OSW82ZUJPbXha?=
 =?utf-8?B?cWZ4TDFHVFdKK1RrOWFGU2tYSEcvVklCL3ZDbEk4QVd4dVhQcVphYWFYVCt2?=
 =?utf-8?B?dW96VndPWDZlOEV4ZnhwNjN5L0JYRGxXU3VqeVNTNzRmT0NKcFZ6LzN2SzYy?=
 =?utf-8?B?SFQ1azdLaTFBZzlXcktXdDFmZ2M4Vkpha0ZaYWxQTkhaZ0hhbU90bjFrdDJZ?=
 =?utf-8?B?ejV0dE1NczM2eVd5N3VBaGxTNzM2MGhXL3luQVA5Mm56cmJCa0lpTlIxSCti?=
 =?utf-8?B?d0JRZ0RnMkZndk9VZXJmS0xhbzVkQWpiMlhOblg3UU40R3pjRzRSQTk1Um5m?=
 =?utf-8?B?OW9GbGYwcWIzZVhtbFBSSE5pcnlOb28wbG9WT3dUY1FJV3NDSXZkbnpkQVlt?=
 =?utf-8?Q?HWsc=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ea45794-400f-4ea1-8591-08de39c122c7
X-MS-Exchange-CrossTenant-AuthSource: LV3PR15MB6455.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 20:58:00.9979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mOcRkmkvoNmKqYHqB3gDjxnStsz7NnkVhf2hp49KsH5sE3ke7jqX3JYPYotdCidL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4759
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEyMDE2OCBTYWx0ZWRfX6TNfBVNL6+yo
 UTvUAW8ofdri9bBH2ub1O5Yqm/R4Ta1Orlbe9CbGZwfk+sPjLXbnWSAocEG09gPjcOHYgntYupc
 MHpvrQezv0wS5ePb0/UIbkjaDythhVVzoEd7GZDuBvjDxO5RXugjBlEtN9yL3SIXtZh715y4t2t
 +YJINbqXLZbD+EhkY6QUmcDBo+iwHDGJY1PcRP0AwvklKoccC9WY0zRRIRq4jm5gnxySMdPcMEL
 5M0lHOG5k5HbHklrfHqiVywSeisyqTGT1nNPnuQHDBRA2CZ5epZYhtcJRA9zOH2e1RY5pjZ8dbz
 cXxQrhua3JkpBuj1oy8JeI7tJ9NjPDrtVdgVP2L+6Trj/pBY/rKYyXOnJw1CVE16s+M3dF106SU
 blvK9El+YR18ZEG5lvuHYV8DYAgcmw==
X-Proofpoint-ORIG-GUID: av5K2K2jVvYKwEtRpvJkUtyyPMGTEhZ6
X-Proofpoint-GUID: av5K2K2jVvYKwEtRpvJkUtyyPMGTEhZ6
X-Authority-Analysis: v=2.4 cv=e/MLiKp/ c=1 sm=1 tr=0 ts=693c81db cx=c_pps
 a=42Ag0VRmng1YD8CjqzuPTQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VabnemYjAAAA:8 a=pGLkceISAAAA:8
 a=V5WLGbV9U73nnlfGKQEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-12_06,2025-12-11_01,2025-10-01_01

On 12/12/25 6:55 AM, Mateusz Guzik wrote:
> On Fri, Dec 12, 2025 at 2:22 AM Chris Mason <clm@meta.com> wrote:
>>
>> On Wed, 19 Nov 2025 15:29:54 +0100 Mateusz Guzik <mjguzik@gmail.com> wrote:
>>
>> Hi everyone,
>>
>> I ran some of the recent commits through the AI review prompts and it
>> flagged this one.  The comments look right to me:
>>
>> [ ... ]
>>
>>> diff --git a/fs/namei.c b/fs/namei.c
>>> index a5bffc2a29f6c..5fbb05fb96b75 100644
>>> --- a/fs/namei.c
>>> +++ b/fs/namei.c
>>
>> [ ... ]
>>
>>> @@ -882,7 +883,7 @@ static bool try_to_unlazy(struct nameidata *nd)
>>>
>>>       BUG_ON(!(nd->flags & LOOKUP_RCU));
>>>
>>> -     if (unlikely(!legitimize_links(nd)))
>>> +     if (unlikely(nd->depth && !legitimize_links(nd)))
>>>               goto out1;
>>
>> When nd->depth is 0, this short-circuits and never calls legitimize_links().
>> However, legitimize_links() contains a LOOKUP_CACHED check that was moved
>> there in commit b93a6e389bdc7 ("fix handling of nd->depth on LOOKUP_CACHED
>> failures in try_to_unlazy*"):
>>
>>     static bool legitimize_links(struct nameidata *nd)
>>     {
>>         if (unlikely(nd->flags & LOOKUP_CACHED)) {
>>             drop_links(nd);
>>             nd->depth = 0;
>>             return false;
>>         }
>>         ...
>>     }
>>
>> Before that commit, the LOOKUP_CACHED check was done directly in
>> try_to_unlazy() before calling legitimize_links(). It was moved into
>> legitimize_links() for consolidation, not because it's semantically
>> related to having links.
>>
>> With LOOKUP_CACHED set (used by io_uring for non-blocking opens) and
>> nd->depth == 0, try_to_unlazy() now proceeds to legitimize_path() and may
>> succeed, when previously it would have failed. This can cause
>> lookup_fast()->try_to_unlazy() to succeed, leading the caller to call
>> lookup_slow() which takes inode_lock_shared() and blocks - violating
>> LOOKUP_CACHED semantics.
>>
>> Should the LOOKUP_CACHED check be moved back to try_to_unlazy() before
>> the depth check, like:
>>
>>     if (unlikely(nd->flags & LOOKUP_CACHED))
>>         goto out1;
>>     if (unlikely(nd->depth && !legitimize_links(nd)))
>>         goto out1;
>>
> 
> Thanks for the report. This is indeed a bug on my end, in my defense
> the current behavior is... interesting -- why would it the routine
> fail when it had nothing to do?

These corners are the best use case for the AI reviews. I never would
have found this bug without a test case and a bisection.

> 
> The commit hash you referenced does not exist in master, I found this
> instead: eacd9aa8cedeb412842c7b339adbaa0477fdd5ad

Sorry about that, the tree I was working on had a bunch of backports to
the fb kernels in different branches.

> 
> That said, the proposed patch does not do the trick as it fails to
> clean up links if nd->depth && nd->flags & LOOKUP_CACHED. The check
> however can be planted *after* if (unlikely(nd->depth &&
> !legitimize_links(nd)))

Oh yeah, I missed that part.  It looks like that's exactly what Al's
eacd9aa8c was fixing.

> 
> This would clean up the bug but retain the weird (for me anyway)
> state. Perhaps this is good enough as a fixup for the release and some
> clean up is -next material

Thanks,
Chris

