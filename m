Return-Path: <linux-fsdevel+bounces-56055-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C4BB12505
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 22:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F3271898598
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 20:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E552528E1;
	Fri, 25 Jul 2025 20:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PZngs05/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UDQQs4Bh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6341D2E36E7;
	Fri, 25 Jul 2025 20:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753473633; cv=fail; b=K8iJ+z1GjNl82plHzCld0UfurtfT5OlQJWVFqCE7Fu8r+AgB4wd00rJeekw9NtOHK96EK444vGYzscMkvSArajEU0uAlbo+y3ixJFRVaG/1WYk9u76+F2YVoXb8Y2Yvd//oxjsDxdThm/Ol9wjbNhoADXw9DeOH0U6DjEhV3oas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753473633; c=relaxed/simple;
	bh=YaCxEioUvJIu4bIsf9QezNqWgz2bMsW/y4svpTz3nNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gJjteZ3jaYa1GkLmnx0OsKB12iLCVtukNPiUjNUvAlB4HdCuhFlNcw9r8ZWcbDz82zSO+KuSw1U4oa6iU0NUTQW/eIIfwgCneg74+hdECfL0VgGB28FtjiOoLazY/7TlK03Yrq8VgWikArXslTEbkTJc9kAqcQ1qqhV81u/WqHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PZngs05/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UDQQs4Bh; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56PGCAh5012286;
	Fri, 25 Jul 2025 19:59:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=YaCxEioUvJIu4bIsf9QezNqWgz2bMsW/y4svpTz3nNs=; b=
	PZngs05/WDNizll4XvpLXqSMTdfTMb95cxM8PmozHpV+hdzkwFjgbB8tKHXAEt+N
	Z3ig8Pj/gvoDxCGiahqCjcIJtBd4WCq+4+72cDbGKh2fKAL71xcni+U6NwSL0ASa
	F/Bmc4aeUOJgydkjJ+vcJe1sXxNlz5mNJp+qvetRuqaX9C7sb6WpN5uAqT1cpca6
	M9AFEiyBvTrPLU8g5WIj4OVDwUOnDj+PkSZhtpVPzmWfYlNx4K6dlN84opLyrTFW
	m1mtWtuDhquTMYA71CJgrHzqo2aBQ3473K+jVOPaPwKBiaIEarlrhdRcF+h0F6px
	OiKbtQzoEdzk7y1/uLRMqQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 483w3whsas-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jul 2025 19:59:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56PIsuh4031497;
	Fri, 25 Jul 2025 19:59:51 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801tktspb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jul 2025 19:59:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yKwtjCCep6yJLMy601zF4k9AMQOs+kRIB4Lq+4i9YXs0N9J+eIcUq9bRWImYT9XHDYVZES5xBTwMKNsNd3XHPxGmPM2/YuCAKlr34m8HsvozoXHOLFi/QGFaMGY7nmqsSFEoxNcQz6R5Df/dleI1/A+wTr0f1uevnzyPU6dOB3ivhF6wPiX9tZHHO9/HNvD3LJzfHGUyyxhyrhzzUiNr2rcXpyc++NHj2uzCDv2ZOepx2DyvqnO77iutn/6UUMUNcRngOMb38bii0dtTjNlCW6Bz4O+JG4GhMxWFM6Z9dCab9Jp2wipA1RF9kgvIaUDodgiOLFJUBdRE35T3wz6pKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YaCxEioUvJIu4bIsf9QezNqWgz2bMsW/y4svpTz3nNs=;
 b=thY6E0Hoqkh90YAB0SCSZ2ABF5qm3XEUaWf5SKmUooV9+IQkpeyOdqPWbTCttnLzPf3vxYrEocVV1pyWX4941bQnOAh3bqUHZlUJbCN21WMIJ+bGM7oUNJMITZGlDFmtkyYeVwomeHTI6Y2dBbfgJb5kB7FgNFxTzy7R9GxBRi6QJoe5DdglQszM6HTOLYpyZ0Pwp5EHrT6zGvTvhd5O9g5cA5NLWQpeoNreOuDiIvw0MMVTPD1Kof7RwVPGXCbcvwrwzYyhbrb4ON67hlSSDm2re23zk5J6Jq9zSVB4Y3V/nMUNBh5lGFlkMiq7gjk7uEUbVOIU4MNBc3kYFs8/tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YaCxEioUvJIu4bIsf9QezNqWgz2bMsW/y4svpTz3nNs=;
 b=UDQQs4BhXvMGSsnIyKPUGIj+BbAiEL7TEPPaIJusaIFVeCvT5BKEjzG1rxjxRcj/a+TJJjYq9zGRzPOEWhZKi2+m41GB2Sie5A9XCVFuKIZvFsMtMv1fWEc8G+DW3rgQTAs2vYhhTLPiNW4h7eu9UCmDgMPsl+ZXYoMK8AtP6Z0=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS0PR10MB7978.namprd10.prod.outlook.com (2603:10b6:8:1aa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Fri, 25 Jul
 2025 19:59:43 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8964.023; Fri, 25 Jul 2025
 19:59:43 +0000
Date: Fri, 25 Jul 2025 20:59:41 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jann Horn <jannh@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Pedro Falcato <pfalcato@suse.de>,
        Rik van Riel <riel@surriel.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH v3 09/10] mm/mremap: permit mremap() move of multiple VMAs
Message-ID: <655f696f-d748-43bb-8d3f-4bef6faf6385@lucifer.local>
References: <cover.1752232673.git.lorenzo.stoakes@oracle.com>
 <8f41e72b0543953d277e96d5e67a52f287cdbac3.1752232673.git.lorenzo.stoakes@oracle.com>
 <CAG48ez0KjHHAWsJo76GuuYYaFCH=3n7axN2ryxy7-Vabp5JA-Q@mail.gmail.com>
 <892e3e49-dbcd-4c1f-9966-c004d63f52df@lucifer.local>
 <CAG48ez3qB7W3JqjrkkQ3SRdQNza3Q9noqkgmBg=3F_8vhwQ4gQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez3qB7W3JqjrkkQ3SRdQNza3Q9noqkgmBg=3F_8vhwQ4gQ@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::7) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS0PR10MB7978:EE_
X-MS-Office365-Filtering-Correlation-Id: 241093cd-8d15-4e30-195c-08ddcbb5cc1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?LzNKZEx2d3RlM3dvbFhLcUV0VW15NjhoU2xxcm1EOUk2eFRNRlRPRGNnaThP?=
 =?utf-8?B?WFNZR0E1WUtvZDkzVm93YWlmWWlZbE96NGRXOXJKUld4MmNZSTN1c1dZQmJ2?=
 =?utf-8?B?RGl4TUFXQ3plZ0tXalIzMGNtUFFZQ09nSjV6K0tNZ2JDejhIOXhGNTA5Wkxv?=
 =?utf-8?B?ODM5Zmpjc0tWYXd5RXVSQU80eVdrV0gvK0l5RDVGRWpjMHVob1dIbkp3ZUMy?=
 =?utf-8?B?ZFdTWmUwWnAvQmxtMjFVYWlNby9OZ1lPOEVyaDB5L3lKTmtxOUlXYXlKd01J?=
 =?utf-8?B?KzhzQUJvYkJKUFhsRGs2SjBoUGlvRFdDeWhnSDZ4SXoxRVlEQXJIVzc4M1pS?=
 =?utf-8?B?ZHI0cWlrZ01WaklnVDJSekUxOHJGOSt6amNxMXZyUWQ4a0RvclhzZWhSTWFZ?=
 =?utf-8?B?TVlUMTBWRXl5UTZTUXVSZEdqcm03SzdwdHMzZkFOK0N0RGNHKzlvUFdQMmF6?=
 =?utf-8?B?YytDMFRINTBLb3NOM1ZjQ0xoaFdPblBubzhQM05kZHhnb1ZNL2V2a2YxWU5m?=
 =?utf-8?B?Z2Q2V2pYeW1DSmpabWNQY2VoOGJxVHcyb0t6VWdVdUJyVnFMZXluZ3BqWklN?=
 =?utf-8?B?a09GZG43SE45TlFuc003WUkzUFhNOVEzZHhyYWltYU5qUHRKR2NOZDd1MGc0?=
 =?utf-8?B?U1ZXdWhyUGs4aDVMNEZNbzh3Y1A3STBSaGtrOGlqMkNXaGJZSVI0RVowck1X?=
 =?utf-8?B?Y1EwTXJhay8wc1hwY3dISDlBTlRjR2JnbXhTUkVJMDVieVNNQ0RZeDlEbG1w?=
 =?utf-8?B?a21sSGRldjhhTHlkaUFPQjVYT3pXZE5pRDFnaFlib001c3BXVEZWSUE2cW9y?=
 =?utf-8?B?U3ZzdGJqZER0eFBIaWRtU25yZEVGNlV1cGYvdkxRa0NGV0t0VEljK0ZuTWU5?=
 =?utf-8?B?aE5Xc04wbklRdFVlM2VzSEJDQVNWRlhYVURiS1NLYlJob1hZSkFDZHJ0VWhp?=
 =?utf-8?B?S1l6dkJkTXlQWlJwa3plbU1ERm5zVVpMY3ZGOGZWY1dxMEdLeTMrdytSRnhE?=
 =?utf-8?B?dVBzOHdVUXAvazJ3dkl6c3R1aXdaT3lXZEFSYVJRWFQxNlBTOVdXZ01xbS9y?=
 =?utf-8?B?VkpaYU9qQ0tpazBVanpwL2RsTE1oL1I2Qmg5U2orYm5ybU4zL2U1Y1Q3SFVh?=
 =?utf-8?B?cEwzTDJ3Uzk1VUpDYVowb0VvRnVwUkJ5bXBNR2FOWVV1VTJrT1pBVnVDVXFa?=
 =?utf-8?B?d2Zjc2NlTlR6eTZpQ0hsU2JaRlcxeEhhbWk1cHJkK3hhL0EydkxMbWpxNVNG?=
 =?utf-8?B?aGpBU0NrNlBKVVo5WEJCVWpWcHhFY3dhcHNnN2RhZ09YdFBSQ1dqQnRKWWg5?=
 =?utf-8?B?ZGFZSmJOUzd0ZEI1d0tDMlllbzB4UW10VlZlakxIbFpTNGU2MHRHYmJOTDJV?=
 =?utf-8?B?MzBLQTJTajJQYnRGek5kcjZEbW03UGhtV1owRnpQY2Y1SzNyRUd1TE9Tangr?=
 =?utf-8?B?UUp4bnA1QXVzQjZ4SzVHcmxsR2R5QjlpMWFsVm1nMlpHWFhvcWg4SVRIREND?=
 =?utf-8?B?bFBEQjkzaEdJQjhKdU1JMDNPc0RUR05DL1Nna2xVZk1zV2ZTMXNzam9HcnVT?=
 =?utf-8?B?dWJpSzRKRmFhMWhqdmlIMlNHRThjRkwyU2lMK2hkUkNUQ0hXQ0wrSjVVa0Fw?=
 =?utf-8?B?VFNKV0lGRHd0NTRsK2ZZK2RzaXlBeVlaNG5yeU5JVVMvR0owaTRDNG1NSVll?=
 =?utf-8?B?bHF4L2VkMUpBZWdYdGRzc3FBd3h6ME4xdHhaNk5ZL0VNbXlaN3MxL1hFNTl6?=
 =?utf-8?B?RU9JZi91bFpjQldNaDBRTmZ3Mzk3ZmYvSVpUY25uUUhFUVY4M1g3a0pVQUhy?=
 =?utf-8?B?eW1TMnZBTEhnbld5bFA1T3hPOW1OVG9zOUphSDdKU0RxdXdsdzJRUmQralVn?=
 =?utf-8?B?TWNnOW1GRlQwQlNLK1BMRDFpZkVORmQyV0xBWFhoZmt6Yk1GME1GUXRMV1dQ?=
 =?utf-8?Q?v/St2ovOOc0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qk9LaHdjMEtCOXVtM0Z6LzRkYW9kUVlBaHMyclc4endrL3Q3NnRyNDMxSXgw?=
 =?utf-8?B?c3IrVnN3T2NiZEhZRm9xcE9RVklMdTFFNlN2YTBaRmVZdDZncWlLQ2M1c3Fy?=
 =?utf-8?B?V2s2UnNFaVZHTWZyNFFPNUZmVWJpQjlNRlNNc0lJQWdRWFZEMWlLd2pVR0Iw?=
 =?utf-8?B?MndBaFJJMlM5OEt5Z09kOS9SRW1lWGtXOGFFQ3dnV1FpTVhIQVJ4VXloMWFV?=
 =?utf-8?B?a25FbW1Jb0FmYVdvTEJKai9CU2h2S1BDb0h6QWRJaTMra0ozaVJ2bE41N1FP?=
 =?utf-8?B?bXExYk9kbEdac1Z6ZVN6UDMvckJtZlZtNlRkVmNkbEsrLzBEM0lQWGdzbjcx?=
 =?utf-8?B?U09UVisyVzgySmwxRWdrMnJTa3lCWHVWVkdnaDZKdkJUZjFhVlEyRHNYTUpX?=
 =?utf-8?B?b001RFJkQm5UbXZKYkM3WmJCVEZrOUZaR0huREQwb1hpMGtOSFlUV20zM2pK?=
 =?utf-8?B?c2VpTmtZVXo3NjlEYlJ1RU50NE92V3Vzbml5QVJXSEU0YkhkWk91NkRSMDUz?=
 =?utf-8?B?VksvbjNoVVZRT2V2VFplWVdJV2xwNWM1UTc1UDF0Q21GZ1ZrK3UyQTVVeE1k?=
 =?utf-8?B?RnJERzQ3L1AycTB2WlBQWm5SWVlrWXNYNWYwUWFmdjJZWTFlb0pHNG1iVjhF?=
 =?utf-8?B?T1JuQ1pjS2F4M0ZVTzB1Uy9wMTVwc0tVbFo0cFd5Q3NWamozTU5YUEl1M0hD?=
 =?utf-8?B?K1Y5SkFhVmZxRVVNTGZZY0J6Mjd4NWh2SUdnY2VHeTNxZ1N3b0xFeHNLQ0dF?=
 =?utf-8?B?U1ZMZmJLaDAxcVlXU2p0VU0wbDFxS1RnYkNaYjhmYmI5MlY3MUZhSllEREdr?=
 =?utf-8?B?TkNmQ0hMZHJXTkp6dVpPNnhNSG1RTWJ5NWlpYm1zUE5WaEZZYnM4TVkxaXEy?=
 =?utf-8?B?SkNqYjJSNmo4eUtsYUZScmtHL21peDdKcTJ4MkdIa3kzbVplTjF5bUMrNHJM?=
 =?utf-8?B?bXhMOS9QUVQ3cGJiSThTRzJwczBZQ09ZdmFoVDN2VUdRY3ZVTVh3RGxYcE1Q?=
 =?utf-8?B?YzMxTndVR1h5cmxXQzlSaWFFSiszS0xpbHp5R3lqQkZkMmxEZ0E5anV6WVN2?=
 =?utf-8?B?ZTc4Yk43OENmU1FYMEdKekpTWU8waEZwcFJKMG5CYWViMml0ZVc3MERNZHJM?=
 =?utf-8?B?SHd3QlV0MlJ3L25lMWh0R3lXdzJwVWxTcGQ2dU1Ec01HVk9YM2YxbnBuL21N?=
 =?utf-8?B?RllqV1hhMnNPMEF0cUtBNm1BUjIwWWRveFB1aDZvSW16NXdxMERBSEpoVWZ1?=
 =?utf-8?B?cmtJZ3lJWU11N0MyanFFVStNZmlNa1l0dUxIS1M0a1BIcklicVlBSFRsZ2hC?=
 =?utf-8?B?VkI5VXlNbFVjblgwdTVtTFV1NXFqZzVmZENsUUVhb0ROaTF5cHhVU1NJMStU?=
 =?utf-8?B?RTVqLzlqRkJXSXdiRzR0RTFZU1ZxbEVrdTBsVzBtT3FjVURxUHZtUzFMK3V0?=
 =?utf-8?B?VG9aam1wY1pZYTExMzRwbzdnUHhuNkhtZjhaQ1ZJY1pnUjdmSSsxaWZZMVhY?=
 =?utf-8?B?c1UxSEt6bnA0bVVTZjFRdTN3M0gwakMyaGk1RHUwa1hEREJNNVVvWDUwSXRi?=
 =?utf-8?B?SWtUMkFmekdFNlFIR2VWVXdlQ21jMFhhQ2FPdHY2UXVCVUE2cTJWWlY2WHZM?=
 =?utf-8?B?N21tYVNxWlV6MmNBOEZPZStWNUFJSkZ5eUtPUVQ3WHBhVEEyUEZ2dW5UbVJJ?=
 =?utf-8?B?MEN3akRBaXZxeHZaZWtjcDVBa3I5U0F4RFFYUzdSekJHUk44YkIwR0xrWHFo?=
 =?utf-8?B?UzVGUzk3S0Q5NFlBYnhXRC9BcEdLbGxKbkFDWkh0eWFLU3hTcjZrMkR1MVhU?=
 =?utf-8?B?c05DUjFrRVdlb0l4QXlXWEdSY1I5NVVjQkJnYVUwTHdmcWtsV1VqOVZLaDdn?=
 =?utf-8?B?dHZFcko2MzljWGRRK09MdjZLUURCcTIyTGlqeGJaS3VDWENBYVBLWXBBZm5x?=
 =?utf-8?B?SWRiQkR5OHh4ZjBWNHBCbDUyMFFPckFlTmcyRVp4SExXSDhkVVRDYWxXVFdY?=
 =?utf-8?B?OFhBQVBKK1UrUXh5T25NUnB3TGlWZmpQU0VhQ2RkV21VdmE3emd5VXBuczBI?=
 =?utf-8?B?RHA4WTI5V21vNDhZTG84ZWJ5NDhvbkRENGpKZHM1bHM5MVgvdW13NCt1N0Js?=
 =?utf-8?B?aWs4YUUvM2RjcjFUK05qQnlBeG1FREVYTnJIK1FtWk93dDM5ek9vWWFScVB1?=
 =?utf-8?B?WGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Ldxg9HHQcOecUile+y3NlaJ0x0Gobn9hzxd6Sc2lsbFbsVqjDsAS8p2LQbHXk0tGfIiXfmZLvwrMWLOCIWZMmz5rum34iaE6oqHI0EqiLSY4kIOgixtxVFRpdWdLcpt4a/Ra0pxNPhwNUeGmQjAhZMyJ0XXVyfuInZvLNhGOP2l5MxR8D/KfH7uP6O7muBXmqKvunbrjWqE0DWyFuRKsgvsHRrG9rZ6MIFR3+c9Dpx7yMZR1pVwXBoihFSVUPMy+9PteRE7ZnKxTTGBf5hZdVXwSSACIkeZiV7ElPwjVRYkAs8IGHAjzJ4XhTqOndN4Jt5aPOq2CI6dm1FmKZi4RuCc1bg7XDQLWD1pUDWde4LAyQEBwJsz/e9SkGGocFAw2ylM0II2rZwTbq6BA1BeuFzGLVXweVUWItfS/gl8nPeGDSCu1BLGEIrd9FEtJGMsTlcIitZPD/JvKWBJ+2xVfQv7S1KCL4ARAeqjXioolSIl7M3egXXbuOuyIHhVQK9f6CQ9XJYWJzUS8EhRQKMrZ4tMeFiYvwv+PiGdF6tuE6NzX4riGoYy0rf4NWvWiuAzHEgWJ3qHpEf8L/K2xG8HYJ4rieH9YPOlGeZSpqJAdCz4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 241093cd-8d15-4e30-195c-08ddcbb5cc1b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 19:59:43.1135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H7pc8lscAZs2Trja77A7+zqnJLR6LolVOTQFhEEM6Gi/Zom91sf7DK44epjlL7ftVpBtR030NDh6n+GY+NcNtOWCX9obJTD/C0Q0HBYRz2c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7978
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_05,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507250171
X-Proofpoint-ORIG-GUID: MxrBCqINjcZEunNAxC8AIlnGi2VOwmoL
X-Proofpoint-GUID: MxrBCqINjcZEunNAxC8AIlnGi2VOwmoL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDE3MSBTYWx0ZWRfXxVmp8fgzT4BD
 HOC3YbJLXxHNIYG0UIf6mvu6oBZP1L/m4aJubc3CchYRA5unwTig3BqtzDF0vRef7qWN2weJ8M9
 J0votQBU5FDqPDigy1IssgKQGIrR+f9Jo1EJk0oY6VbjsQDO7aNsgeJjgZFPgmoNKJ7+RsxzP7G
 cjFSfA8n0M5+g9QFszsBvfbg5q+Z+v+kAJEvN8dvFz3NoX4GGCZg12j0eX+X2DQwyLFCdc52khn
 RLzmq2U8Lvt6rzcfl1iKiwnRZet5fC9NnSLvEt80LeZ3YwHshtOQXoyyCjunEY4s4045/9ij14z
 RHL3Vt9tSGftiDnhzSSMExa/skWZZq2X0GaCRt59lkPJnM4AZIhusYN8J+Y/nCmsNEJKkxyz1ZJ
 UxRw8xNBLCtVjRWmyJLcj+rdIF8PE/fFimlTWDuV5Qg51h6Q3mmLErtl+8SOWvc8r5ERhK5w
X-Authority-Analysis: v=2.4 cv=Jt7xrN4C c=1 sm=1 tr=0 ts=6883e238 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=yPCof4ZbAAAA:8 a=ikl7R7fmHqXH9aiMwqwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:13600

On Fri, Jul 25, 2025 at 09:10:25PM +0200, Jann Horn wrote:
> On Fri, Jul 25, 2025 at 7:28 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> > On Fri, Jul 25, 2025 at 07:11:49PM +0200, Jann Horn wrote:
> > > On Fri, Jul 11, 2025 at 1:38 PM Lorenzo Stoakes
> > > <lorenzo.stoakes@oracle.com> wrote:
> > > > Note that any failures encountered will result in a partial move. Since an
> > > > mremap() can fail at any time, this might result in only some of the VMAs
> > > > being moved.
> > > >
> > > > Note that failures are very rare and typically require an out of a memory
> > > > condition or a mapping limit condition to be hit, assuming the VMAs being
> > > > moved are valid.
> > >
> > > Hrm. So if userspace tries to move a series of VMAs with mremap(), and
> > > the operation fails, and userspace assumes the old syscall semantics,
> > > userspace could assume that its memory is still at the old address,
> > > when that's actually not true; and if userspace tries to access it
> > > there, userspace UAF happens?
> >
> > At 6pm on the last day of the cycle? :) dude :) this long week gets ever
> > longer...
>
> To be clear, I very much do not expect you to instantly reply to
> random patch review mail I send you late on a Friday evening. :P

Haha sure, just keen to clarify things on this!

>
> > Otherwise for mapping limit we likely hit it right away. I moved all the
> > checks up front for standard VMA/param errors.
>
> Ah, I missed that part.

Yeah the refactoring part of the series prior to this patch goes to great
lengths to prepare for this (including in moving tests earlier - all of
which I confirmed were good to be done earlier).

:)

