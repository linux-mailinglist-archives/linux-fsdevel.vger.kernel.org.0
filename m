Return-Path: <linux-fsdevel+bounces-32661-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 068109ACA5A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 14:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FA98B22A24
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 12:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5723A1AC88B;
	Wed, 23 Oct 2024 12:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="U5YYvnab";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="L3R9W9Le"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29D51AB6C7;
	Wed, 23 Oct 2024 12:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729687372; cv=fail; b=lp25LAdM6VNYOc4CPrnHVXnr/IQ95vmv40EvW+y1JWzpbg4IzSHUdRAZo8YiTUMDWBFkTSp6tQKlt21VtBN2ZbbT9EcWDSr1lW22J4EgopSH+zHaC3pArV9w3fsE2d1f5f5WU3wC6zJfeQEyiPx9F/HrFRLjqNUuRLfFHYi0rCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729687372; c=relaxed/simple;
	bh=1dI8OiCyKHBrioP8mrrn6vgUcp2/birivbWqJj4dgQk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=R5UUMVKxVO9bCEgktZEHSwvdcmZbXKyXgAT4pxf/RQtkcRTqIrfH2z3M9xYXJlojHsKRMcrbJ7ufTkfSPrBI7zWylxR8As2ONpV6VqVuAozGpHSUEFKig/XANmdxSROIEG1jOjkMfFI4G59Bpp5rysU5vQ6XgeYwkWGffiWEcX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=U5YYvnab; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=L3R9W9Le; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NBQbjJ030807;
	Wed, 23 Oct 2024 12:42:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=sQCLQVJn1ZziQyauio5qo4VEtKqqiFMvDkAq2lbULO0=; b=
	U5YYvnabauDNv+S2gzw8dnPvwzqko6SB9F6/k8SzalBjM28FGSNhXuFZcZ28eSWv
	vjeILeWrmc0nMMCYirGZ43MP2z8ZchUHnjjFc1uXLBRjD5U5HD3O52tSgHYyPnGV
	8kb2IsFVzr2FclAQnn1LQn6S+Oi4m8W3q7P/pGvSxPzG1gXSPu/xrj+15uiWXBNW
	aXQoEqf6K91DHcTXtbFlDdC3PYUJjAoyaqELEwRGEtuwu8JGJ5/F/Q26t4ONwQv6
	N9VbjyLZvfgKD1WISC2f2O+rKooa2z3DxIM9wADiSjP2Xgk13sXkjdwPsRtJxpXl
	0HzCuDKhjrkL3qNfAj0ifA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c55uyysv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 12:42:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49NCYNfj027393;
	Wed, 23 Oct 2024 12:42:33 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42emh2s2qv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 12:42:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o7Da/HwQgGeFxlnzJVsD0T/ef2Ni0juZOdMfFLA8eRgEuIEXnuL/K/uyd5AJvJxfeAJl+FtItImw1C2sD3Deu24tYZk3TthJNGDTeAbC9IArHMRdSJ4cPYhNnbFcu6sP9ThibCzF6qFqo4fT5rCcIXCz7rtJBftch9Fd2gULruhoz/T6Y/3wzp+IgBWUJKuBADXvJ2cbN3WHkfwpXKg7/cE8udYAhyGoTqD2p0QT966NaHgfuBrksCORX4qhfsRABsyGArYi3WikK3fwMZAjhtYHXJg8N1oPhcqsYRK6y450D4pf3M5GI8rq3h20IxZSIQPyRsyVW/6jKlX/cTw6ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sQCLQVJn1ZziQyauio5qo4VEtKqqiFMvDkAq2lbULO0=;
 b=ZBHRfS4WJBjU7SIdtzwO6bTVQb+0hpg7JfXSChx1AjkNJxIg6OC/8GdXMcf7zW/dasFjRCeQ2/vR42lvoVJy8KMijJfPwZPha8DyNQnsb4os3HJLO5Z1t4ed4L1i2qd4kauL3yhnmBosdzCQD3OsrQWo7ut07fRSGHNOnJeR3IGAQxjQKn33z90vdo0UnQJJpV6QB1pww886tWhLvT845bspwTzPUe46ehsMY01EI85J0RGtwwq+qV8Mu7g83RxMXBawyw2hGsdeJ8Zsc/VV3DjT5/jWP8E8iSSgyFv/z4vNAhxpdEQCQ2x3sY7s3u6DUaAdlLJRFT+xO5VGhSNvGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQCLQVJn1ZziQyauio5qo4VEtKqqiFMvDkAq2lbULO0=;
 b=L3R9W9LeEbwniYFCl8f2oMvwmbgieyJuq/tS1lHgq2+bcm4+xUxFe7epg4W6CkDyj5OYxzmU5+SaN7ndfyhGs8bfdi8AoQkW3D1v3wWwc7nTIdzZTXZ3kYsaV7fAZ5NRv7EXzKq8rGApzfCbyrCbRRXz632jcSP5jfKmSycU1mc=
Received: from CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9)
 by IA3PR10MB8066.namprd10.prod.outlook.com (2603:10b6:208:50b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Wed, 23 Oct
 2024 12:42:28 +0000
Received: from CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2]) by CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2%5]) with mapi id 15.20.8093.014; Wed, 23 Oct 2024
 12:42:28 +0000
Message-ID: <e8a3a228-0367-43da-8cad-caaaa207f0e6@oracle.com>
Date: Wed, 23 Oct 2024 13:42:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH v10 0/8] block atomic writes for xfs
To: Jens Axboe <axboe@kernel.dk>, cem@kernel.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, hare@suse.de,
        martin.petersen@oracle.com, catherine.hoang@oracle.com,
        mcgrof@kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
        hch@lst.de, brauner@kernel.org, djwong@kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, dchinner@redhat.com
References: <20241019125113.369994-1-john.g.garry@oracle.com>
 <172937817079.551422.12024377336706116119.b4-ty@kernel.dk>
 <d6d920c6-9a8c-49b7-8d4a-fbeacd6906f0@kernel.dk>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <d6d920c6-9a8c-49b7-8d4a-fbeacd6906f0@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0019.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::13) To CH2PR10MB4312.namprd10.prod.outlook.com
 (2603:10b6:610:7b::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4312:EE_|IA3PR10MB8066:EE_
X-MS-Office365-Filtering-Correlation-Id: dd6dfa6b-f912-4030-7955-08dcf3602774
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MU5wWlNLVjQ0bjQvK1Z1UkFtSnFVZ0UrVXl5Qjk3ZjJ6YitRY2JxVDdpVTBK?=
 =?utf-8?B?ditsL29BZnROSU4wWHVGd2tpeHJRVEdkak5vbGcrWkJvOHBIYmpYVmVCWXJZ?=
 =?utf-8?B?MWo4QlRVU21LTWZrbnp5bTVhTXFLZFhqbmdwQXFzcEFKTUhtNDBJd0UvWmFj?=
 =?utf-8?B?UTJrWmR4US9QTjRKWWlTeG9XRTdKVHdKYjRwWHZGZG5JZ0Nhcnc0N01RSEZ0?=
 =?utf-8?B?V0pTYlFSb1BjeWExbFZzUU9HT09JaFN6WEEyaU5CUC9RSXdqUlVaN0FvVmJQ?=
 =?utf-8?B?Q1YxTEdSVWRGZy91SFZyaDBhTHNCaWdid0JXYmZFeGErcmtqWnBwMFV0Qkov?=
 =?utf-8?B?STYvNXQ2RFJqWmRsQWpzR21mcm9QMURjMmd2UnlsRXFUb1NQT2FQVEZBMVQ0?=
 =?utf-8?B?V0hrQkVOSFVjekJyb25xYVVVNE1LSjNxRXAyc0hNTkNHOHNJZ2wydjRHQTRi?=
 =?utf-8?B?UVU5RC95LzJVR3lnc3VDS01SbktCVE9ubFZUWGxTRWdDVExRMTlLMWRiSS9n?=
 =?utf-8?B?VnRMaldJcnRtdWVVSDVUcnZIMkJ4bStsbmFDc0dHYjZndWFmeDlOcTVyVzRD?=
 =?utf-8?B?RUVKYnE0NkRoM3lkR0V4Rk4wcmZPaFhURys3bTFxakNQWVA4dFMwYWwway9S?=
 =?utf-8?B?WnZJd013QlVUZkg0Y3NuelUzdG00Rm1qM0lZRGZuSDlBakpsaitoQVNBREJw?=
 =?utf-8?B?WTJmc09ibW93cGdsZ2xVT2NzbzVUb0NteTRyVW9LeTdXb0wrbytJU0dHZmN3?=
 =?utf-8?B?ZWQ0UWtZbUJCb25ha0xER1JFYnlsZUd0d3JMNEdUVC9uekJSUXVBWDh4d3dh?=
 =?utf-8?B?QTZqU0hYcW1UQnpHZDZTZkRBWE9ZYmw3akpmdUtSMU1DbUtLQkMxbEpEMWo4?=
 =?utf-8?B?dU5HVk41dmlSdVRocnZEdTdQck1RcFhQdXVEbEc1NFpyTk1RQ3hDUkhaU0dV?=
 =?utf-8?B?cDgrZjJNM3FvNlZOQ1VDSTZhNFhGS1VITmQ3aFRpZVJjRXJPZ1hjSHlZUE5P?=
 =?utf-8?B?Y2tUekVlc3JiY0pMdDRvNDlEMGdFRXRlakxMV2JHQjJJZyt5VjB0THhtQnhr?=
 =?utf-8?B?ZElQWXM3TmwySk1iYWxhT3FlN0hFdUhOaVFzdFNPL2dpb1RKNFIwaTFNWGp2?=
 =?utf-8?B?Y2R2eU8rOUVhbGNnU1I5KzZXZTBtNzAzcmx1TnZYcGJ5N05aME1wdTkrcGoy?=
 =?utf-8?B?N3VIRmpIUjN5Qkd5Ym1xS24rcXdWWFJndWtmV1dtTllXaVcyRS9pYWZRYkNM?=
 =?utf-8?B?aWZHSVlKYnF5bEpLc2QzMWFzQWlUanlvNTYrZnZRQVZac29qeGRpZWdHeE1q?=
 =?utf-8?B?aFNiWWVVU1lBVm1ZZzdkOU9yaTNUMUhyUXYrOGhzelRQY1hyY3VtTDd4NldF?=
 =?utf-8?B?ZXl1NWZTTFNPamdlSkc1RmQvRWZTU2RJalNsdFhUMzhHTlFjTXNycElNQUFC?=
 =?utf-8?B?YmlMZFVIcGkwWmZkc1hORjlxS1BIWUYxU1ZWMW9CNGwzcWxoTThpNWtFcWZh?=
 =?utf-8?B?Szcxd1E5bWlzKzZlNi9iY3FqUktzQ1d2RTZKclBpeDBML2RqUXdtdUxzQzdq?=
 =?utf-8?B?M3dneEhPbi9aWWx6SnU0blpqU3hNTXpiQVMrbUxYV3dWdFhvZjlPYUxXTTFv?=
 =?utf-8?B?TkJCYVUrMDVVRzlHM0tRMEN6RS9KZjR3YllrTnNqalN5a0hCRHVEcGxFeFNi?=
 =?utf-8?B?dTRSeHNZMFRjNmVOM1NUbm1PRmYvT3dudUtTRVNTUnBTdmgwY3ROVzVMYUVr?=
 =?utf-8?Q?kEnd1Kf3n8ZJEL/jmzeHWL3uTearDNE0VbCe7RB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4312.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d01Lc1NRZGVERWg0UjBMekRCUWdJYkxWbmlvQkRmb0JBbTBHYkY2UklMby9V?=
 =?utf-8?B?VmVUbThBa1BoUXpJei9yMDZUS3Zrd01XYzBwditzYnZ6NWc2MXNBSzN3cmZL?=
 =?utf-8?B?Q1FIWkMrRWxmdW83aStWZEhOZXBxMTMxODJaakUrV3ZuaXh2ckJEeHpvWkJG?=
 =?utf-8?B?cWgzQzRMaVdXL1BYSC9UMkxrY1BJc0JSTG43QnlsSDMvT3JPOW41UUU3RTc3?=
 =?utf-8?B?S3lHVys5ZXdXMU9sbE9zWkhlenY1VE50TTM4NDlzYWh2aktiVVdnN2R6bDVz?=
 =?utf-8?B?cWhmcUZZVC9PSkxVOXhzZXF1cVRXVjhNTmxQakRQdHFQOE5MM2dIenNRRzVm?=
 =?utf-8?B?YnYzOHJ6VWR2MnZjQVRRVERVenJLUXhBMUdEWTRUbHgxUlJmRVE1cTlvTlcr?=
 =?utf-8?B?YXUrWDhFY3BRY2NNV29qTjU5YnQ2blEydXkzOVM1Mk1pYVhtR3lCQVZubTRk?=
 =?utf-8?B?d3MvVlV1bmdlOFB6ZFlMV3ViaUgrcVRMbHNTY1h0T2REbXRJaVc1RjZwVUo4?=
 =?utf-8?B?WjFBQk92YnNjbE5Ma1hPU0pOWmtFemZBS05OVEdzNkZKYWRqRDd0NnFNWlNQ?=
 =?utf-8?B?Y0VRd1FDamZIQmRoOVZqUnUwNlFDM2V3b1UweENyYk9qanhuMUZkb001cjFn?=
 =?utf-8?B?ZlBaMzc1eW5Ja015TTF1N0Yzckl1cWlIWHZlY0ZibkpESmlEOFhWVkJ5YmU3?=
 =?utf-8?B?R3puQU9obUswWXFwWXpTYjhVc1E3TFBqY3lsRWJEN0hGYVRTdU11T3ZWWFdP?=
 =?utf-8?B?Vnk5ZVFSdEZxSnhJSkRjR1JGaHkyaFg1TXRoTnlzSXZKT0lZZHpSMEhrb2Vj?=
 =?utf-8?B?YWZaaEJwaytoVzR1T0JBektuRDRXNGRzU1V2ak9wK053ek9Ia1A1OXNkMjhM?=
 =?utf-8?B?ZktQNnIxL2JTZUVIaXQxN0c5S1pPbjBva25DcTQ0M1NQRkJWUmN1SFNLdjdj?=
 =?utf-8?B?cjhrYnZWS2RlbWxKdlhCc1JPdXFGNDdiZFJRZERLVWZsT0E3VTVFd2dvOWtG?=
 =?utf-8?B?VXpJNWFUNHVKeTN6ZTMyOGlic3NQRTY0R3k5SE43c0h1SjFyV1B4TnZqM1lr?=
 =?utf-8?B?VzFYWno3UEt0WkZpUUJtbVpvSHU3YUR5bExidG5UWGhNbU56aCtrVmgxeFhR?=
 =?utf-8?B?b05KbHZ2Wkk2S0Y5d3ZpK2JSeWpSN0F3ek1CUk16aVVuQ3dJYmZIVFpsWmk4?=
 =?utf-8?B?Zm1uREhBR2Q1VElrYXhDcE50SVF2ZEIxUllvMDQ0VEkzV05jVG01bVdRenFs?=
 =?utf-8?B?YVNiTFdEeDRDNC9VYmFZd3daVjg0a1Njcm1JcTlpeU9hUnJ4dWFNSGk5Q0Nz?=
 =?utf-8?B?SXh2VkwzZ2UwLy92cVpFZC9zT1EvZmVkVVNZYUM0UlFBQ2hPblhIbDhYZ0tK?=
 =?utf-8?B?ZTEzSmdTYlFDN2Z4YmVBMkZIOTVabDR6K3dUZWlVOWtEUzlrRlMzK3ZCdWVZ?=
 =?utf-8?B?OUhMUzBBN2JzN0VBVFhRV2Q5WXk4Zk5uZlR2dGo5M1M2SmhrMlo0WWFvZWRS?=
 =?utf-8?B?NWRxdG1Kd1VINUVwRlZ2NC9hcEVSSnNkL3BmU1hMT3p5SGt0eHRBK3ZZT0dQ?=
 =?utf-8?B?eklrd09BR0piUU1WNVhxSkRSak5yd2tXUmRJTFVKVFFhaVEwd2VSZHpsUmUr?=
 =?utf-8?B?TEF4NmtCbUlFYUxXZkFWM2tsMEo4a3pnSHI3SDdyOTRveEhFbXRNK202NXFP?=
 =?utf-8?B?d2hkeDg2Nnlici9pU3ByUEZ0cEsrZ2VYaUk4Y2dpTUswa2xSVld6NHpSNVl5?=
 =?utf-8?B?MDhLZ0x2TzRrTlpobGoxd1dYdWh0VXFLcUxGbDBWdVhoTE5JbndWa0NTSDBw?=
 =?utf-8?B?bTNmWjZkeCtXZSt3MDNYWjBTazFaMExvd3o5UngrcUd4MTJRVHN5Z3NtMEg5?=
 =?utf-8?B?Umw1RGcrYll4MzlNZ2VxdE81enQwVnhCNEtieVQwd3BxaGNKTkhrN2xpdmxp?=
 =?utf-8?B?cE5kQUhLdDUxc08zeGd6RkRIbGFvaHNyM2hOR1h0bWUwMjZTUDY2SUsvd2FM?=
 =?utf-8?B?dndPK2lmUVViQ3dnZ2RZOFdEcFI0OEd6TUZOa3FJNEYvbFAwTTVuNWlsLzFF?=
 =?utf-8?B?M1FtNDAxYlRlZGg5TGpGUTRTODdqUGZJdmd1TjYxZVRHSGhIMDIrRjlISEdh?=
 =?utf-8?B?UjZmR1grNHFHekNvWElSN2tnd0t4anlXOFBWQXcwU2IzQ3lQenJPQzd5bkFa?=
 =?utf-8?B?NGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4Wb/nTJ0borjYeFnWo2dmJcHKMR27cyAq03jBkcxS8W9rVAcXqSsUQGpcug9CAqomzk5ooOHsFnGNdn7rSbBjH+gheiOlaqcAS3suvGRFFtjswOC3TBYfKflEkLE7mDj3l9NfMWOAXzJLUbPGgptbu0Crplbq/YhsMezSHyBqp4yHFS8ERCJ1DPmACmzYxeQMgo5/1IYQ3jRwp4F4c6e9vXONG+unZy2qBpIwSysd2DR83ujuMgezaxNz/+mO3wuu5YPdU/pk5lPfZoDfTQI4vD11B5XwEz+IcWneKhJay/IVZPw/2iGSup6j1DkEfEU+ngK12vatAWvN4gC0QuoUs6nOscCuU2RULni/Rr+PubpRiR6TsMPm1lPnW2zcwRyEgeqk+jKEQOKycbe6nXrS40G+QZhIkgCGIPy8aGXCgzRlpdHPxD1vt/5CxiwRacKumzGajfgnZbkMBvKjv404N+pYXvjxm6erP+i+2grlaRYaCAdet1IBlQqsJht4a0MzY3un/6OS0VWjkCWITmXi5v13pXz01pRvZUDTcYCEHJh1dUsfQy9+37xMK9eg8J3RXduGYVWgJbw4vZbs2CSpugyinOH4Q2GZFGvEaWY4QQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd6dfa6b-f912-4030-7955-08dcf3602774
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4312.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 12:42:28.7747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fvaw4RdV7ik4+dLC4VsHg28TCZKuXdxDl1Sw52Lb1NeNalleiCI2rKo7yHL35QEcWObbedJliLZM4GrVlJ9iCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8066
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-23_10,2024-10-23_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410230075
X-Proofpoint-GUID: 24xA2_mH10DUKHBgLxqK9q15AOS974Bn
X-Proofpoint-ORIG-GUID: 24xA2_mH10DUKHBgLxqK9q15AOS974Bn

On 19/10/2024 23:50, Jens Axboe wrote:
>> On Sat, 19 Oct 2024 12:51:05 +0000, John Garry wrote:
>>> This series expands atomic write support to filesystems, specifically
>>> XFS.
>>>
>>> Initially we will only support writing exactly 1x FS block atomically.
>>>
>>> Since we can now have FS block size > PAGE_SIZE for XFS, we can write
>>> atomically 4K+ blocks on x86.
>>>
>>> [...]
>> Applied, thanks!
>>
>> [1/8] block/fs: Pass an iocb to generic_atomic_write_valid()
>>        commit: 9a8dbdadae509e5717ff6e5aa572ca0974d2101d
>> [2/8] fs/block: Check for IOCB_DIRECT in generic_atomic_write_valid()
>>        commit: c3be7ebbbce5201e151f17e28a6c807602f369c9
>> [3/8] block: Add bdev atomic write limits helpers
>>        commit: 1eadb157947163ca72ba8963b915fdc099ce6cca

Thanks Jens

> These are now sitting in:
> 
> git://git.kernel.dk/linux for-6.13/block-atomic
> 
> and can be pulled in by the fs/xfs people.

Carlos, can you kindly consider merging that branch and picking up the 
iomap + xfs changes?

Cheers


