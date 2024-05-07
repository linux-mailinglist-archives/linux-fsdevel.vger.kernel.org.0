Return-Path: <linux-fsdevel+bounces-18915-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 190D58BE7C2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 17:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34AE9B23C0F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 15:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652E1168AF5;
	Tue,  7 May 2024 15:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="deWexsc4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="alLyRV13"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043D01649DA;
	Tue,  7 May 2024 15:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715096965; cv=fail; b=pkD6EjVDRyrYCSGbT6WgjUzRZVS6AHqHFLd/+qipSpeagdfPCsSkE5DYX9NxtUasKexguWLbUJZQux7j3r9A6Tmx6kY+FcE8gR+aSi9gA5HYQ5XdycBGOMJnIuURk3ARPOIt9o8iA1gTQWFgZKpEzt6TZNlYio1l/8vcG6XdXiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715096965; c=relaxed/simple;
	bh=Thius1SfT7VW4yEbb2Mqivu5B824EjJpG8yMPQ+6G9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=flm4aeMyd+b6iES+gNPAlJ9n/Dik1u1Us4pF3r3P9MaUOvKjXgjO/i3z014TOe5a2Y5+++C9+rP7OqHNGxtkPyHf7Ye3rwt4LQRRJdaOrLYA6zVlu60RosEW5o9mRw/gEaadxpKSjQMtOBl2U1PpxhqJ0+AD0wHLnQfSji9ndMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=deWexsc4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=alLyRV13; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44793wWR020827;
	Tue, 7 May 2024 15:49:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-11-20;
 bh=3W8XcQidhSap11ce1pVHrLIG/JO4tFOkJX2ZzjHdjGA=;
 b=deWexsc4PSXO0ltZcG2VDz4RjcKir9JCTdKLAPuHbqbySjfslfvuDwUGeNiX+3ANy/Xn
 OZneHzazImfGBpTOzJ28axDwEOXN+r/KlMCHWIzH1Y4uwjW6/TPVR5/hpG3i4p7n0RjF
 5IFVsAvUDhpoCkfPgFl0CiaRai8ZdhAbDz4Uqxzw9UP3zU4k+MAF8RPji6mAaRXhz1ks
 XQaKeEjpzyAzRJO/uHqoKxd8zBmzfKwRoi2XrB8+rEd6BIc0nOX+sgVSvEdwloIasfQ8
 3kIAPLEROU4HcDbfKBYGLQnK1kGVJJ/FlytJY8YZ0LSNY9yxUbEPrQ4h2FYBEd4rl5dR hw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xwcmvdb61-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 May 2024 15:49:00 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 447FaZM8039374;
	Tue, 7 May 2024 15:48:59 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xwbf76vqx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 May 2024 15:48:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QnUCjLXkDY1VsOL2XDBmdSZ/NlFPRgNEuMFlWrJva1lBXk6p6pDODW/GngGND5mqscaszxpgnGn64DRNsUFrVp8GkoUtcc68U5b0ZPawdFylRKGu47YK7iIp5RS0d2QUPwMpew6GZ3+Uz1O6uytEwmMQY8UkWZOZBhSE8Rjo+keFGYPt5u6MMpWSfIj6+8AxMgfNA+W+dYGXB6A9/2PodlGt4/4tlfk3+uHytAk50sxsY9uYD+DIYQDd0lB82wz3ViotpcEnm/CP3u/DrZ/02zA6bhLVj+tSJ4INdB8mSRy63Ff/EqZJfDdNvu9eRfAnyEq48Jqmixp8KKYr2A7wSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3W8XcQidhSap11ce1pVHrLIG/JO4tFOkJX2ZzjHdjGA=;
 b=JlvcQzcMTus0iAxXY/E0WoNpkfUB8r1lDyOxCiuji+Us5U7IZLyqSBKmXwxrRBDXnqk6PYU11p61VFmPUCTSMfkXBuagZmjsFv60ogV6bNZOwDFdPdreJk3iIHnSJDRcM6IAdDd5D1vV6EvP7DNWuLJlUxAxA4RyM2meJe8KqejUEVbGm7valDHUB/QqdpTppWzdtxrlt7AtIHAOlmirxkWb5oZtISES5yjaeoose6u3y5Xq8/t1T4rgjbund1rpajcvDXrUnB3mC8JHcbPmjXJ8sAODojeYrdJYTegCc5ySkfg8hZxJq2CAFtY7HHnv8dEIoM1YITDFmC6g97XDGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3W8XcQidhSap11ce1pVHrLIG/JO4tFOkJX2ZzjHdjGA=;
 b=alLyRV133wMwvuA2v1Abr3npyJhMmRnyPXezcWoP42zQG0UAiCk7TW7E6mLfVboRUcDxfhmxoCoOaIe3FummgippX7mPGXmuijInop9LNt2SZvMOhFvvQ5MaJuyjGkC1o3Zz+iX5CFulw+XV4Gl+uO3BHlgtat2Omsv9I9ACMOc=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by SJ0PR10MB4477.namprd10.prod.outlook.com (2603:10b6:a03:2df::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43; Tue, 7 May
 2024 15:48:48 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 15:48:48 +0000
Date: Tue, 7 May 2024 11:48:44 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Andrii Nakryiko <andrii@kernel.org>,
        linux-fsdevel@vger.kernel.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org, linux-mm@kvack.org,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 5/5] selftests/bpf: a simple benchmark tool for
 /proc/<pid>/maps APIs
Message-ID: <cgpi2vaxveiytrtywsd4qynxnm3qqur3xlmbzcqqgoap6oxcjv@wjxukapfjowc>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, 
	Andrii Nakryiko <andrii@kernel.org>, linux-fsdevel@vger.kernel.org, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-mm@kvack.org, Suren Baghdasaryan <surenb@google.com>, 
	Matthew Wilcox <willy@infradead.org>
References: <20240504003006.3303334-1-andrii@kernel.org>
 <20240504003006.3303334-6-andrii@kernel.org>
 <2024050425-setting-enhance-3bcd@gregkh>
 <CAEf4BzbiTQk6pLPQj=p9d18YW4fgn9k2V=zk6nUYAOK975J=xg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAEf4BzbiTQk6pLPQj=p9d18YW4fgn9k2V=zk6nUYAOK975J=xg@mail.gmail.com>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: BN9PR03CA0761.namprd03.prod.outlook.com
 (2603:10b6:408:13a::16) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|SJ0PR10MB4477:EE_
X-MS-Office365-Filtering-Correlation-Id: 5acedd43-cecf-42a7-7965-08dc6ead2f1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230031|7416005|1800799015|366007|376005|27256008;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?d1BmdDZBcDkyd3ZVb0NIaW5EZ3lPTHRYM3R0d1NXN01BT3h2Zjh2NkdSajdO?=
 =?utf-8?B?aEw3d2E0d3BLUEdUMmtTNEluRUlZbzk4NTNrMUhmV2lYaUFxczJyQ2ZMZXJj?=
 =?utf-8?B?MDBJaVhnR05uajR0aG95RldwbU5QM0ZIYWh6WVVkQThXMlRBMS82aEczdzhZ?=
 =?utf-8?B?MlR1VUZkRU5LbXJzcUpEUy84ZWVtNzZZTlVtZ2tNMjhVczJjTHUxZWFrUHZm?=
 =?utf-8?B?UWdTNEZnQ25DbXlGSmdPdGhYd3o5dXl5UHRYSUE5V2hqZEF4MkN0aE9FYVBt?=
 =?utf-8?B?QlRJbCs3eUJxM2YyeWd5SVRJVUdMMlBiZFl3djRXQW9KWnJWUE9PRDZJKzRh?=
 =?utf-8?B?NE1qbDU4eCtWSWZ3aE5ubjQyZHB1SmFUUFhEV3dZNTRFM0E3eXJEMHVYdTMz?=
 =?utf-8?B?V1lFdlZqaUxyQkRsVE51WjJnK2NXU285YUV1VDNDZXZhZkVsSzhXQ3JyT0RU?=
 =?utf-8?B?ZDFoTWFNem5SaytpVDFseHNDQzFMTFNLRU9iS2FuSDNoUzhmSEhwS3YxWWk4?=
 =?utf-8?B?YjVZeHUxUXNWalB6WDYzUlIydjFyNng5bnQ2dUhBTnZLdmc2Qjg5K0NxTUxw?=
 =?utf-8?B?eCswcWNYUEd4WWZta3J4UG8rMWhTRVRKSjIzWWEzOThzdWNXK0NuejBwNWVp?=
 =?utf-8?B?Q3NmemtsSDZ5d2czMlFTNzRXSmZLNTBkMldDUldPMU5naGE1MjQ5ejNWSXRm?=
 =?utf-8?B?ZUtId0JWbGhreFFKUGNSRDFNTnhHQlFWVUk0aFYzZW9OOWIzWEV5THZLblpn?=
 =?utf-8?B?Rk80NjJNcXBnRk42MzlNMXBsOUJaRitpZ1pkTkgwdFI4ZkJJczIyaE5Rd0dS?=
 =?utf-8?B?NzU5elRZVU41bnZDSDg0N3FnbzhyVG5XUzdlRG1LdnJ6MVB5cmRRVDlYTzNw?=
 =?utf-8?B?ZmtrTFJHQVYwb09qVlR4cHJnbVUzVDJIdmtocS9iNmR1T0JMKzNrbFkzelA0?=
 =?utf-8?B?eWZRZjl6ZndrallMUkRPdklsTWNIQ2MzMTVEY3B2OWVaYXphRklWZjlqSjVV?=
 =?utf-8?B?d1VoYVJFWHJoUWVydDRQQUZNTXFaYlVXUldpZmxvUnBSMWRacFpQbjlzemdo?=
 =?utf-8?B?SU5YeUtZTTZqWjMvR1FGTlZLNk5RcGUzbUxTbCtkTVErckVmeVJacEpYRVM3?=
 =?utf-8?B?VnZJVlloVWFIVTBCYW14ODZ4MjRqOGQ2amJtU2wzdG01ejlLUzZxbDl0SmtM?=
 =?utf-8?B?SXdwUTlFbC9Oanh5YnlLUUxqZzQ3UGpYRzdYSHdwc1VIdG5DbVV6bXIzN2xE?=
 =?utf-8?B?UmFVaEF4TEZsb2NHS3BGNm5CdTh6Sk5rSkZhV29RakFxWks3K3REck1vRUZ6?=
 =?utf-8?B?TU9UdzZUWmtIWmJPSzUxQjNlVzZEYUhRTkRHdm84RXpWcGFnWklpOVBQZUV6?=
 =?utf-8?B?Si9KcEVORU02QzJ1aUtRZUlSUlNUdTA1ZXE4TE54OFNZanIxZU8yb1o5MFVi?=
 =?utf-8?B?aWxETmxPbWpuR1NIRDU2RGQ0aE9EbmpReE9lZ0RwZHNHY2x6UC9VNVNtSjhM?=
 =?utf-8?B?SW5DK0YxRVRsaDBXd0VOdldUWWFzSkk2dVdxUnVQd0VtS21OeEhjempVbU1z?=
 =?utf-8?B?bnoza2duL1QwV3JDWWFGSEFDb2tRTnc2Zy9Cdlp1Z3NVVFRoWkpsdmRNd1k4?=
 =?utf-8?B?WDA1WmUwTkkzakMvMlNqSFpuR2RqenYwS0JFaGMxZUY2a2x5QXZxaFpybUR5?=
 =?utf-8?B?NmhMWlRsY3NkL21EYTRnSGlTZVBURk5XUmJ0THF2SEdpd3ByRXl4RUwrN3JZ?=
 =?utf-8?B?eFJ5Q2RhcXFjdFN3c3dJOWhqTkN2aThhajBxUW5hRGlCeE50eVc5MUM1ay9r?=
 =?utf-8?B?bithVmZGWEFFdS9RVGxaQT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(376005)(27256008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ek8zZzhUVWY2SjhTWCtFdWw5VGVETGYyU0JuVXpuWSs0QklaYU5KMFlTb005?=
 =?utf-8?B?Z1dKZ2N5c1JraXg1OWlKSk9JSEpuTXNGZG5wbnRIL3hDMERKZlZOaEFuQXpU?=
 =?utf-8?B?OEsvK3kzL2RRc2hEZThJOXlSTVZhOXVQazAyOG00cml6emo5YkJ2N0ZpZkdz?=
 =?utf-8?B?MWVva21WcmxKQ3pjcER2UjNOL1BUVEwreE5EYUdzbWlYRE4yakZ0a3Y2bnBR?=
 =?utf-8?B?OXM5NHlXQ1BuYWVNVFdIS3BxS3QxYUFibkdYUnlidmZMWkdZT1FGTndEWnJO?=
 =?utf-8?B?WkJkdzkvYW1ZdTJiNlZ5TTJMcDhMcEhZcU5WRWxUYWxWOENIWUdWRjl3MmEv?=
 =?utf-8?B?dGgxNnFMTms1dTZUNVcxdzBnRUh2cFRxbEhNZkdXc1MzTTA0aXZ5OXVPWjZU?=
 =?utf-8?B?UVlYWG9QakVqVXBWd2cwZUNSZkRiN3c3c0xIcEE1UzhzdmVtQzZSY2Raczhk?=
 =?utf-8?B?UnczMDY4U2paRktTL25YYXh4QUxWSzByWFl5cmNsT29hcjRmanJNM3k4TVlm?=
 =?utf-8?B?aGVrcHJjbmNIaE44anlzVEpMUGY5ZVk4dnlaUTZ3SE5kQUloR010Y0dLK0RG?=
 =?utf-8?B?am1GRG9vQ3FGSXZvTTV4T2N4Z0kzRXNacW01eU1uTlZrNW5QdjRBQXp5c09S?=
 =?utf-8?B?Z0FZWXJrbFl4MURNUkdCNjZxbHpOaFNjT01nZ0dFanFYR1JPNEN5ekY2RnRt?=
 =?utf-8?B?bnBVUGg2dUFlUHoxRzlnK2t5Lzh3ZG1sZkJEdmdvZXFpUDgxSVBBdDFkd0ZV?=
 =?utf-8?B?T2krdFNoV3lkbkl2a0UvMmdZWjg1RHNRbm9ZWGFtTFJyV09ZdXJFN3ovd1lm?=
 =?utf-8?B?VWFxOHViM1FZVm1jcVAwTEx6SG5uUXlJaVAyYmpBcDg4OHpuNWNRV1NlTElm?=
 =?utf-8?B?cGpkcUIrbkM5bFVCUWVlS0F6RDFDRUtNWHRuMnl1Y3dtSnNaOXU4dDJrcFB2?=
 =?utf-8?B?WmFibFZiaU5EYW5kdkxQT3ZnZ1J1eGN3YVVvVjhmNUdGcDQyRWY1eDJPM1Bl?=
 =?utf-8?B?WXZCVUpXZVA5R0JGZ2ZkY2tZSXlYbnlSSy8yMDB0cTdMYTdjSi9TZGJpT20r?=
 =?utf-8?B?Qjl1M0kycEovMGJIKzg5N2wwUDhCY1NyeWFmSE9nQWFuRnBRTTlsSzlqNVNQ?=
 =?utf-8?B?UEZ2bnlsZE9TMDZQTGZjVjF1aXE5YVRBc2hoUlg2TERET3E1MnAxMEZZc2Zu?=
 =?utf-8?B?Sm10eExBcWUwcDQ5QTdTUThYQWljb3BOTm1mVUt3d2tLNVdHK2M4UzZqTE9D?=
 =?utf-8?B?Qk1aZTh2OUkxckIrL3J3UHpLT0NmZThCN28xWkprNVhnYjNnUlUxSGNnMWor?=
 =?utf-8?B?bXZITDFPSmZRUGZtMEswQ3Z4ZkYzZWxmYUpsOFJUMEpicDBnNmtYL1Z4R00r?=
 =?utf-8?B?WTYzbk1mZHZuRkpJWkg4RnFITTl2VkpBVTZiUW5VUG5JY0NJM0VBRHp6QzBj?=
 =?utf-8?B?Z0RmMVQwVi9DZHRTOWxYajI5T1hpWTdZVkR4Nk1JWkRBaGphRFJuRDhCNjI0?=
 =?utf-8?B?aWN0M2grM2FtUkFNTGl2ZTlFMXdLc3VFenZxdzNTOWoxcVQ1TEY4TnRYUGdz?=
 =?utf-8?B?NzVwVzJFUXNML0lPL0R2M2FCZTN3NEtZUTArWGlnSytxVk9FZitoVjNzeEZ5?=
 =?utf-8?B?UW5WZjFLTE5KNGhoaFpRcEF5MHlrczJjTXFrRjc0ZElFVVVQNk4rbEFGUHpU?=
 =?utf-8?B?bkdGYUk1VkNoSWRjb2JiaWdWQWU2K0tIZityYkdZd295STcyL01SMks0RFVI?=
 =?utf-8?B?dFV4RzVUanZuUUcrRkVsUlFGeVFaMDQ3MzNQWEFyTUJ2bzlUZ3VIeThqbTMr?=
 =?utf-8?B?Q3B4MFFXSmhORFZFUWtTeDk4NjVkNTZ2L3ZRZG40ekF2VU1FTUozSFo0cU8w?=
 =?utf-8?B?L3dCaXlPYW82cnpSUVI4YUplVUN5RWxsWVBWWnhoY3kydWt2NEdnbGYweVpr?=
 =?utf-8?B?Yi85R0plUjRlRnZXMlFydXBocXhNcWR5N0F0SDk4YkpRbXZQU1E4WEtwM1hi?=
 =?utf-8?B?T3hHUDRqK2FGMnhjai9sQ21qdEI3RE5ZdytEM0RTdUt1Wmk1QzBWNHhYUGdE?=
 =?utf-8?B?eXRvQnI1REJnVThMWlZCYlFoU214a1VyemFsWGVXZTAwVnRIODdJUTFXc1Y1?=
 =?utf-8?B?dkdGS0EzRzR1UTBrS0tIV0lPQ0VqRHpEWitiZzFveTNXcUh3a3MvaDJzWUxS?=
 =?utf-8?B?N2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	lhfufBFwNIYQQPkiv+noQe5wOULkNgNz7TWX0eIzgmCiwVnobCoj1dDL/RDM54vBG6hYF9TGv+V65QNoCQ8YnCYTheDZ1QFKZacP012nWUv7VqqIir86H6cSTyflNqYuuCtE57xbc/EQPRykAGn4XM49qe7mglvuBmRhxXHt2fX4hAUVif2DLVSz+e7yF7+Ya5MeZ9K3teSwqyBxyAMRiJz5lkwsXYHi3/2ny2yAj7P1D8jpp58osIakotxcAVqq++6lDirS57P/ORm+AoqX0ygDknsP0bEn3ihIdhxN1bOTqWBh9ZOs4uIxzpFiFQOac36pAtVses2nWWJyYp9aa7Kfidq8qkEDOKVX8m9fHNrO6izzbObUGcJbuZcRnmcbCaKsmsat2mu0wDA1mzqviG/GA7EGSiWsJtCUx9K8IiyVoEtNuTsCJJVp2RYOVq8VDkUCOz1+mFh+9GruellFFU43Tnzo2tKdY26w+Xc4sWgxdP8lDUt+XRLJfn2/mdDFU/24tbOi470pjwFaAWpMhWSsrmd3Fn52zrNjocOeBy0si9wHPQ60GJazbwjDvYNj8A6gVJSrqIu6dIIFUV/9nFOTWlKONblm3ZnWflfyI8A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5acedd43-cecf-42a7-7965-08dc6ead2f1b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 15:48:48.0461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bGggUrZ91/rRY7LBMXNxqqN6d8MdyUahwI0NAtjxFhUnwPv1hVdWUS/HM9JZSVyj2keTKmK+ppTXH/SS/SUuEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4477
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_09,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=769
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405070110
X-Proofpoint-GUID: OgVLpUgyFtXr9rRsPimLNJFBmYYw7BpS
X-Proofpoint-ORIG-GUID: OgVLpUgyFtXr9rRsPimLNJFBmYYw7BpS

.. Adding Suren & Willy to the Cc

* Andrii Nakryiko <andrii.nakryiko@gmail.com> [240504 18:14]:
> On Sat, May 4, 2024 at 8:32=E2=80=AFAM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
> >
> > On Fri, May 03, 2024 at 05:30:06PM -0700, Andrii Nakryiko wrote:
> > > I also did an strace run of both cases. In text-based one the tool di=
d
> > > 68 read() syscalls, fetching up to 4KB of data in one go.
> >
> > Why not fetch more at once?
> >
>=20
> I didn't expect to be interrogated so much on the performance of the
> text parsing front, sorry. :) You can probably tune this, but where is
> the reasonable limit? 64KB? 256KB? 1MB? See below for some more
> production numbers.

The reason the file reads are limited to 4KB is because this file is
used for monitoring processes.  We have a significant number of
organisations polling this file so frequently that the mmap lock
contention becomes an issue. (reading a file is free, right?)  People
also tend to try to figure out why a process is slow by reading this
file - which amplifies the lock contention.

What happens today is that the lock is yielded after 4KB to allow time
for mmap writes to happen.  This also means your data may be
inconsistent from one 4KB block to the next (the write may be around
this boundary).

This new interface also takes the lock in do_procmap_query() and does
the 4kb blocks as well.  Extending this size means more time spent
blocking mmap writes, but a more consistent view of the world (less
"tearing" of the addresses).

We are working to reduce these issues by switching the /proc/<pid>/maps
file to use rcu lookup.  I would recommend we do not proceed with this
interface using the old method and instead, implement it using rcu from
the start - if it fits your use case (or we can make it fit your use
case).

At least, for most page faults, we can work around the lock contention
(since v6.6), but not all and not on all archs.

...

>=20
> > > In comparison,
> > > ioctl-based implementation had to do only 6 ioctl() calls to fetch al=
l
> > > relevant VMAs.
> > >
> > > It is projected that savings from processing big production applicati=
ons
> > > would only widen the gap in favor of binary-based querying ioctl API,=
 as
> > > bigger applications will tend to have even more non-executable VMA
> > > mappings relative to executable ones.
> >
> > Define "bigger applications" please.  Is this some "large database
> > company workload" type of thing, or something else?
>=20
> I don't have a definition. But I had in mind, as one example, an
> ads-serving service we use internally (it's a pretty large application
> by pretty much any metric you can come up with). I just randomly
> picked one of the production hosts, found one instance of that
> service, and looked at its /proc/<pid>/maps file. Hopefully it will
> satisfy your need for specifics.
>=20
> # cat /proc/1126243/maps | wc -c
> 1570178
> # cat /proc/1126243/maps | wc -l
> 28875
> # cat /proc/1126243/maps | grep ' ..x. ' | wc -l
> 7347

We have distributions increasing the map_count to an insane number to
allow games to work [1].  It is, unfortunately, only a matter of time until
this is regularly an issue as it is being normalised and allowed by an
increased number of distributions (fedora, arch, ubuntu).  So, despite
my email address, I am not talking about large database companies here.

Also, note that applications that use guard VMAs double the number for
the guards.  Fun stuff.

We are really doing a lot in the VMA area to reduce the mmap locking
contention and it seems you have a use case for a new interface that can
leverage these changes.

We have at least two talks around this area at LSF if you are attending.

Thanks,
Liam

[1] https://lore.kernel.org/linux-mm/8f6e2d69-b4df-45f3-aed4-5190966e2dea@v=
alvesoftware.com/


