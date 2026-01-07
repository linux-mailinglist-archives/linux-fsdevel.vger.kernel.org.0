Return-Path: <linux-fsdevel+bounces-72662-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9746CCFEA62
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 16:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DE2D1300503E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 15:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA4838B9A6;
	Wed,  7 Jan 2026 15:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="F0KPsXJr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AQgp9vYk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBA738B981;
	Wed,  7 Jan 2026 15:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767800587; cv=fail; b=ns4XMRbmru/YRr/8mEJlKssv05L5C82rL5eCS6HTk3IDDf+VUCc2IhlRWPeG0BSsCIWcjR1j6eRKvicgJ9MQYAa9CD713q9oS5T30R6IiaFzQMmBo3pau6Tk5IYm5sgv9AKrrb28H85RK4lJT4Jf7yJk+jZJfx6hDYMpSDfVqOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767800587; c=relaxed/simple;
	bh=hEA4rN+o0c0WkGnEjqk+D2N4fI0Mgp8vcC90LA58Xzo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kg2GoF5sessOF9RKyludn7rkkURBQHuyn0MOxcVAl3JttDyg7gMVTfC5jGL8+aApPUos1/I9PJX51sJG4BbmW+lnxig98BEY8glP93Ugr8FXEEsNFsUtDGTBd6t3Km5xd69Atcb+LzSFXeB3kHL05qtdo1CBcyjosX9D8H0Dn0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=F0KPsXJr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AQgp9vYk; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 607CelcS1935176;
	Wed, 7 Jan 2026 15:43:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=GuAtywyJmlLSqMEmy3wIim+anujVT6RDOTOXHR625Qc=; b=
	F0KPsXJr10TQA3QNL4OzCHH75rKxXHLsp8ccR+4TQr9PkyDRF6pR54frHmBWfB7F
	/OLGgeegQThxBQW1GHBoXAl0ac+S/G52Vhr4h9F3atKDa7mPkYxClK9Dph1QKmfb
	OUnclXLJdPlAhdZAGO40B7R74FqYX3AT8TBAyCd7vhk8iCpcXC7Innzg97NLn5Ql
	RuPLik4H6MhqnWt11BuZDs/O4dyB5dg25fURNzBlSXGhGIyOPEBZFu4ZZ6XweyII
	T4huUF+/AoWBep0sdXzs263HGuVXSk3+E1Em0vdjeHYHcz99IvirmgjFKqwkxBm/
	8Qo4hLa87DiFrSPx0Z13CQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bhqpsr8rx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Jan 2026 15:42:59 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 607FKLpS027409;
	Wed, 7 Jan 2026 15:42:58 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011063.outbound.protection.outlook.com [52.101.62.63])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4besj9qxxd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Jan 2026 15:42:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kpzWqK3/1GAjByC9EoNbjoT/pZtkQfN/7WbEcStSZtKPrAwwcB4+wfDDH7vY6gux145NXjbAZ6g4fletfRSzK4FknluKQlntC9qqq1ySjpSu7KLXtTOq74x3Jf2HPuKc82qKmPK9bmhRdi22kNsjQvOS+7WiU/WzeseDManJnojrylXIW3LcCLuRo2WL4Cs3U42QITN8eC9mTTlKdsOkcYBFnmt9XJsjOTRu2ro0zHhmhA1QHlpAAfvzfMos7g6ednfjRwExi6EHOUG8qgJMj3MiGzO3zD3aqUyyyS9NQguPD1xoiNcRCzAHbZehaC+bCdkuXXB59PZbM35V2+vNMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GuAtywyJmlLSqMEmy3wIim+anujVT6RDOTOXHR625Qc=;
 b=gsXJBWBsfmJa48VTIFHohyPLlzAnyRYZ4L1yzfcoiaaSoeKhIu2c/LXzgeayUazAzXisZcW6b3HROPFaSpQDqJLhq0iWcpIkeVtDNrmVRboPICFY66U7HUmGpQG0eMaVqE5fZcFk+pnFjP9Jq2tLHjFGdp6deOpzPFByvGnig8XquEAYpEwiQKCCEVrBIG4wIN3wcNbEdb7FlLpgB15YehawIC52uB32vS0geK5Py+2b4EaYgZdt70y17rets//y/Kfl6GD+Rca+vhPb6fOE9TVPhI640/T1MQGh0+D8hhdOIigv3kwWy9UwxOX83rGjvLLwOMCreGWzd+Et0ivzEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GuAtywyJmlLSqMEmy3wIim+anujVT6RDOTOXHR625Qc=;
 b=AQgp9vYkYXd4A4bFunz+/6Tia+r/KU8i/5Quf2MhIVqX/91GR3e9IZtU6v/b7lv715wkFSDhRjK5TyQCWCRCgKyQkMQ5mozY3V/qaIa2pXHGi5BGTSHdga5jebbkrlITExMAFxNOUbP+tsPfed+bUcGluFY5eBo43WW/a3OYV2g=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by IA1PR10MB6710.namprd10.prod.outlook.com
 (2603:10b6:208:419::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 15:42:55 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::ba87:9589:750c:6861]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::ba87:9589:750c:6861%8]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 15:42:54 +0000
Message-ID: <02c255b8-2ddb-43bd-9bfd-4946ef065463@oracle.com>
Date: Wed, 7 Jan 2026 15:42:51 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: remove power of 2 and length boundary atomic write
 restrictions
To: Vitaliy Filippov <vitalifster@gmail.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org
References: <20251224115312.27036-1-vitalifster@gmail.com>
 <cc83c3fa-1bee-48b0-bfda-3a807c0b46bd@oracle.com>
 <CAPqjcqqEAb9cUTU3QrmgZ7J-wc_b7Ai_8fi17q5OQAyRZ8RfwQ@mail.gmail.com>
 <492a0427-2b84-47aa-b70c-a4355a7566f2@oracle.com>
 <CAPqjcqpPQMhTOd3hHTsZxKuLwZB-QJdHqOyac2vyZ+AeDYWC6g@mail.gmail.com>
 <6cd50989-2cae-4535-9581-63b6a297d183@oracle.com>
 <CAPqjcqo=A45mK01h+o3avOUaSSSX6g_y3FfvCFLRoO7YEwUddw@mail.gmail.com>
 <58a89dc4-1bc9-4b38-a8cc-d0097ee74b29@oracle.com>
 <CAPqjcqq+DFc4TwAPDZodZ61b5pRrt4i+moy3K1dkzGhH9r-2Rw@mail.gmail.com>
 <704e5d2a-1b37-43c5-8ad6-bda47a4e7fc6@oracle.com>
 <CAPqjcqqhFWz0eNGJRW-_PoJhdM7f-yxr=pWN2_AfGSP=-VpyMg@mail.gmail.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAPqjcqqhFWz0eNGJRW-_PoJhdM7f-yxr=pWN2_AfGSP=-VpyMg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0127.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::15) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|IA1PR10MB6710:EE_
X-MS-Office365-Filtering-Correlation-Id: 713e4c8f-0c5e-4ee7-055e-08de4e036c7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aGxudllFR3ZWcE5NZ0FrZVFvRUdFTTNBODRtZlZ3a0ZtL0d4Tm54SzNLcHdT?=
 =?utf-8?B?VFgvMjZLRTExRWE4N2FhcHVGTXY4bSthNFAzMXFvTVg3aXBpVjdwa3liOGxT?=
 =?utf-8?B?RTFMK0VHSDYwUk1KbE9SeFFPdVhmV0dMb1EvV1EyQ0NVeU0yOElhRUVoOXVi?=
 =?utf-8?B?RlB2N3ZmZHE5KzJ5ZG1GNTRJR1hyaExpd3dzVGJ6MnJ1S0RDZjJzY3hNWGFG?=
 =?utf-8?B?bW4vWmdqU0UxR0V1UlJDSXdrazhoMUdxK0pRRjdaMjZ0Qi9VOHNRZmpFM0Vi?=
 =?utf-8?B?dmpqcC92Mm5QSDBQRTE0NU5YMVE4WGVTZDhFdWx3RGsvNnVxdmZkS1RDSUp0?=
 =?utf-8?B?cGcxbnNUMDA4OWZFcVJLdlhPVVBRMllSOXdwOERUWnpBT0hxWHBremlJMzUw?=
 =?utf-8?B?ZVlCLzNESnpQYm1ZMTlocWtWemhZVU5ZVTgzMEtYYXpzYTVvYit0M3F4TnBG?=
 =?utf-8?B?S0NScHVaR0I3OUZWMklNdmtFaDZqVG9NYWo4d2NBMkJrZkJmS2VOSytEdEtL?=
 =?utf-8?B?THhVeUlRNVJEbTJNTG1iMXJxeGlyTGtwOUFZaUpUMDM0M0RwdDJLUVNVdUZj?=
 =?utf-8?B?ZGZVSys3SHRsaEtaVkd2UU1kQnYyUnRMOXFNb2NTbUw4Z0FZZFNFa0o5SHVO?=
 =?utf-8?B?STJKa2Q0K1A2b0UvaUVRa2JBVnNIYVE4TUFaUVBFWEh1c0JLMWtUTXhVYXNC?=
 =?utf-8?B?b0J4R3R6b3hNYWtwbkc2bTN3eDlrYlA2RjFWaHJGQzkrVys1T2MzeGRNcVU4?=
 =?utf-8?B?VGJMSWVseEZLZnNLVlNiOHgrZmd6RW91Ti9qSzZSaFJnc05Sd2lXRWY1c3Fr?=
 =?utf-8?B?T3ZHNmxkTXNxWGQ3SEtEOWVaV3R3dTVPUWlNaG9zZjdxZEgyZmFCbU81SVd2?=
 =?utf-8?B?MmRHYmhHNGZzOW5leEhXNFA1UUJBb1V3VG54aStINnlUdkN1UXFucVA0YVJU?=
 =?utf-8?B?bHNSYlpSZE5sMnJJS2poSnV6MjREU2syVDEyRUx3ZDFiTzdSdzE0ckM0V2ow?=
 =?utf-8?B?VlhGeHVCT2NsNmVBRm5tVi9yQzdaTG1ySmw5WGxna0tyMXhpd1V2Qkh5RkRz?=
 =?utf-8?B?RGhlSWxnU2cyMXJ1dk5OTVNVdUJwdkJNaWY4NGczMjV2a2FoZHZrb2NLRUoz?=
 =?utf-8?B?eXBlVWwzSDdlekhGRENtUnFYYTJzNzh5eDROdCtYaGhUZGlwbEkvOUpoYlYr?=
 =?utf-8?B?elZsRUd3aUwrWGtaeCswSTZTMTJQR3VlajNCakdkS0xtaU1PaHJDT1JramQx?=
 =?utf-8?B?YlV1Ny91Si9NQ2o1K3BzWm5Kd2cwbVZzOVgvejZjNUFsTjFpR3JVWnVkeU54?=
 =?utf-8?B?cTNmeDBMeDcydFlUZXl4ckpwd2RzWGh2Qnhyellkd1hWRlorREp1VktxZDNO?=
 =?utf-8?B?KzBLSjFLY2dIdDBySzB1SGswbFNDeHB1a2pEVkpSaU5xVDFkaEd2UTllSDJz?=
 =?utf-8?B?bU95UTJhM0tzLy9OY3UySnNpVDZIbUpvZ2lYNHpScDVBZTFXOGh1UDVJNUd1?=
 =?utf-8?B?cFVLd0h5RlJlV0NVQmtCako1ZjhqaUpmVjlYNTZucDUvQm9FWmY0NmQ2WmFV?=
 =?utf-8?B?UFJiYTJSZFcvbE93cEZrY3BDRzZtenRWTFM4NXRudFFnQ1J0STVZQTBMWE5r?=
 =?utf-8?B?cEVxTUtiZjVwMVJLazhqdUJjQlRUNXlrVFhVNk9tcmdEVzFMY3VhOHRnUVY2?=
 =?utf-8?B?T2tmbWNscDBzSkVwQWpOOWtWK2J2NGJVdDJscU5MK2lXVmU2c1UxdWFxWDls?=
 =?utf-8?B?djg2M0hidFRhdmUyeDNjY1N0dTM4NEZVMkdnVmIwMUthRC9ZN1VjSHFqektQ?=
 =?utf-8?B?ZFJUREYxeFAzbzE5WWdRcjhONlg2bndXeW50U3pGSzQ4OStTbVI2VGJ6dC9V?=
 =?utf-8?B?QUUrVllXYVVDblcrY3hEalU2ZkxxSSsxQmZGdHZ4U3Bvc0cwbVNRMndHOVNR?=
 =?utf-8?Q?kYpPwIYp/vX1kO4ckkwKYMRvAajaHh6O?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YS9KWFVlcEJrV3RtREhPZjFETEZQbGFGQ3MzUzAvTU50bXgyczN1T2NpZHl3?=
 =?utf-8?B?aHArZkQ5bElldHRiZmFHS01SRjJ4MlVaSWFPVkMyU3hSTjZobzNBUWFtbkJE?=
 =?utf-8?B?MFRGK001ODE2VW4rMTdxU3RBWFl1MytYbUUrUnBxV210UDBwSGhEUDJCVEJl?=
 =?utf-8?B?U2JVcm84cW52SUxMMlZQUktLYlVYQXFKUkZub3U1Z0M3a2tXRDhpU0xFeStQ?=
 =?utf-8?B?VzBLY1l1MG5FVTVLV0ExeCtKM1hkS2tHb251R1l6NHAzUUp5L0tST085dzdC?=
 =?utf-8?B?NnoxYktwN1U4dmFQWHliaXF3RGk3TFl5TXJnYWlybnlrL0dSeG9PTTROeER3?=
 =?utf-8?B?MENqT0plM1pXbS9zVlJoM1lOZjYzcURwanQvczkxR1lhNDltbytKTS93VVps?=
 =?utf-8?B?U0RldjFnQUdRK051VmlWUjRZR3R2bzdZN0ZkYUIzNmx5R1J4TjNmeVg4SUow?=
 =?utf-8?B?bzVTbXorLzJNdU1nY1hUV3FPK0U5bFZwcVpROVFNMjhwSmVoQ2xtem5FQ054?=
 =?utf-8?B?NTU2RDFlM2k4VE5jS1YrSGNIbkNpSGU3Sm5VTzlOenZ2cGhqYkNteG1Yb3Fy?=
 =?utf-8?B?NjlHeFZPN3ZzdXZxUkxUS2hyZk1xSEtFOFF5cHZKNGhHaXFoUG9YTW5MbE9a?=
 =?utf-8?B?bFpKbmplN2p3alZDNGEyUTF4TXFuVjh4N0VUQVkzaXJXTDJ1ZmtXRXU2V0kr?=
 =?utf-8?B?V2tldXRjTm9ORDFQSUVvejdSblFTV1Q3Mi95Y0YxMnFEcHhvRURyalRrRjQ3?=
 =?utf-8?B?clVRK1ZIN1hlNjV0NXhVMkJnZGRETkw4Y1c0dHhFSGg2dUxEU2h2S01FZ3NF?=
 =?utf-8?B?WWgrOTNXZDJKdys2S0xCUncyYlB6UnRPc2g4M1JQSnBFQ3NkSGk0eGxBMnd6?=
 =?utf-8?B?NXBsdmg5cjJwUUR6bkRmMjdOU0pkRW5vQ0Jvd0p5K3dBODJlSXNyeEo5SjNx?=
 =?utf-8?B?RXpTelVFbERadjg3YmVpWWdCYzFUQlY5dkJZYW1qaGh6WXk4aDNQYkp4L2ti?=
 =?utf-8?B?aXIyc2JrOXV5b0hhd3NWemlYQjVxdzhOTXBFRW1XSitXUnRiZ2RXL0lMNTFR?=
 =?utf-8?B?VEl6TFVXVmpXcGo1ZnkyOXRhRlNOL1pnR0xOYUIvdFltWEdnRC9rTjkwZFRq?=
 =?utf-8?B?MW8vU2hLNDdpMnNETkZ1bFd4RmV5VlgzRENjNENpSVpVOHZibVV4ODdFUita?=
 =?utf-8?B?QVNSWVVQR2xYdzZybWQ2eWx5TzFLajA0QUJiTnZ2RDdWTFNLRldHQ21JTTMv?=
 =?utf-8?B?ZGdYUGVsbDk1WitCSG5LbnFSS1Z3MWVOSGhXNlh0OGJBQzNxdlh2TFIxTnZr?=
 =?utf-8?B?K1Y5c1dRUlNKNUJiSFVWUVQ1T0tMcDVIUzNMVWgwSXVzNmxxU1NHelBDS2ov?=
 =?utf-8?B?cFZYSEw3RVE4eit3alN6RlM5MzkxeSt5emNuSmpqV0JPSTJMajdEbnZ4ODhP?=
 =?utf-8?B?akIvd3ZFVlFqQjVidTVTVlZUREp0Zk1xYUdjYW93cFJSTzMvMnhXZDZpSXNF?=
 =?utf-8?B?MmNSa0JudW5NaTYxYkJZR0lRT0dQSlZudG9BUTJwSnIwQ0MxUzNDUzdHck9j?=
 =?utf-8?B?NU9qSjR5S3lVNWhXdG5sZDhSZ3U2L1RhaHVYU1ZpNzBmaThmam02T05oU0Nx?=
 =?utf-8?B?eDJhVmNBODR5WjIxMVo4TlRibkF1aEFwK1dEa3NwK0hocnBMd2lvQ1lsSURS?=
 =?utf-8?B?djB4V2x5elZnWjBDVGZ6YUtRdHREUzg5MzREL2NGSjdaclBseFlDTjJJSkdM?=
 =?utf-8?B?U29IZ2ZaWkM5WjlOcXZzZVN3Yi9aSUhSSFh5VkFKRWE3c29BWDRqZEFmS0lX?=
 =?utf-8?B?MS9jSWhwK0VaQkZGcHROcFZNZ0RrbW9uTkZLeWFJaUJta0xxTTZ5ZXRnWEpP?=
 =?utf-8?B?blhpWGFPYTI5T3RISFhCUkJBWHFEUkxPYW1ySzlxV1ArNEJhZmZtVFF4WWtz?=
 =?utf-8?B?OWsrNmlGcTN1ZG9MZWFCaHBUaWtJOHN0T2ZDKzEyaUlnMTRSN0N0L1ZKTEgx?=
 =?utf-8?B?ekROMTZTZmhMRDZCRjNyQnRtRTBRcEpKRGRxWUtlU2c0cDJYUFBCcC82UXVo?=
 =?utf-8?B?MUxIZUQ5WFE0STdFZE01Z2NuUE5XRFdoUG9ISkxKRlFUTXAxL2Y1dmcwdXZV?=
 =?utf-8?B?UE9tSmNRQm5SdGJHL3hDTEo5d3c1VDZmdFp6bitFbnRLSDYvTmlPSml5VzRv?=
 =?utf-8?B?S1dGR3NLZHRlSVQxU0RDZmJlS21ZVEhnQ29ZSElMUTRBYnlVZ0d0VmxuSkQy?=
 =?utf-8?B?RFhZNm5OclRNZTdjRlo0RnRnUlNyVmhCdmlNUEZFY3RVdkh2ejdBYW5zVjNS?=
 =?utf-8?B?WEFERkNiSVNqeHh2S3NrYWlvemxkd0RkTXFRNG9iR1BEcWdobzZBRnhIc1Ux?=
 =?utf-8?Q?l50VhY65RR/sv5kA=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Umh9en74USolwFNUVDPJpcKqv+S7yQdYFjPAjygjfsOnzR6vnx85b69o2FWFpn7sHYg51wlMWR+qrZmOJ6z6D6xFFu2r9Vfi9TN7cIzXXcrPdWVfIIuq+Xv7LNFnJACxwn70PxURRtFn3MBsqRr0vyx9SABUeaqyq+H7GiK6U6k/7o6mY8Pef9EcqoJoIs0nxi+OgWPYYJuzkMpAYnraxyEVl2iBmf6TfwMbqYM+ma8DC1qll44u0VOnWXi+iXCenYMYa8hj1/qApmWhf+i37YAch8Tgml5KQD0fvpbVTJQna0P70IKzHIEc40aPyxfqYeBSt0o+IdcStBs+XcMYUbeMa7Y56rCV7K05uCJ9SLQfaX4iab3IZUExNC7UTdKRScrOSk14exr6M39bQPjufzY7nvxSI47htwHAIOojAUyID+yKtmPwR8zBZKXqC4INrdPaS2AW3D+eEhUsv1pM7XivOWk2pPFCUrhwntXaetSZMkqUyt/kgh3T5Z7cUH2PFEeGLJzMEH5dm5yzruz3tn5hZLTPtcbkekUJwhEHYElWusZb6rJqbgv/RI92bZ4opNCVU34QypcBm7Nn8JvECK/0mYamyuAZQPHJ1P3SiFo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 713e4c8f-0c5e-4ee7-055e-08de4e036c7d
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 15:42:54.7803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PZETx0YXoS9V2B4mP3R5OV+KH/Og/rKrDbXH9oi/G8AXaUX2esZohW7XezX2l6ZD7gYLh0VWe8w+6Im3IezsjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6710
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-07_02,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601070122
X-Proofpoint-ORIG-GUID: buv-_NmVEtJdNhNO-IE1Efm2YOJLAM9O
X-Proofpoint-GUID: buv-_NmVEtJdNhNO-IE1Efm2YOJLAM9O
X-Authority-Analysis: v=2.4 cv=bp1BxUai c=1 sm=1 tr=0 ts=695e7f03 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bIhTPgojmzeo10_hBdUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDEyMiBTYWx0ZWRfX2ixmYHFH/UIP
 5y5ehxDx1DYrScd8YXPyXcxzysjSliLCRUGQEvbF7T+/VK4SwZh+dhglKWVaSq60o4VMrkBK/o9
 JvUpc6CDSagTW6Er7M94Sw1k+OFFc3I1xTJrmLnfevyYr0lADLfMDyaephGVT+VpGIx6nc/Qjhk
 ug9BGOGopwUDrrI4VWfzSdVL5r81zHpnv1v0v6WPiRqDvzeF/MQk3CxYefSGRsNNXlwhxBGdojW
 i6jI603xXyYNux+nw+IvDYjwMf3u7eYls0Bzl93JtYMuDqNsu6OocHgXT1+wmnENQMQvYPHimYr
 cycm3YAbnTneXsbwiNployl5bIpisUzWX331ziIK0DL2eB+e0e0Xa22aZeDxyZqJIM9L2OaOHQo
 1QRoNDkLCt4TVOfQnTbzDzAtfrGVuG0vuFaFzZwaqUMmsFsjsY/KFym8hDsw3htEeZBvWIB+01h
 y2nlZTKWU6nExx4SbSw==

On 07/01/2026 13:05, Vitaliy Filippov wrote:
>> What is the actual usecase you are trying to solve? You mentioned "avoid
>> journaling", which does not explain what you want to achieve.
>>
>> You could arrange your data so that it suits the rules.
> 
> I can't. My usecase is a distributed ceph-like SDS based on atomic
> writes. Writes on a virtual block device have arbitrary length &
> offset of course,

Note that the alignment rule is not just for atomic HW boundaries. We 
also support atomic writes on stacked devices, where this is relevant - 
specifically striped devices, like raid0. Doing an unaligned atomic 
write on a striped device may result in trying to issue an atomic write 
which straddles 2x separate devices, which would obviously be broken.

> nothing like 2^N, like on a regular block device.
> Atomicity is implemented through journaling (double-write) on disks
> without hardware atomic write support.
> 
> Then I found the new atomic write feature and SSDs with support for it
> and implemented a new storage layer which can take advantage of it. My
> new storage layer has write amplification about ~1.0 with atomic
> writes (i.e. almost zero overhead). It's a huge improvement for me -
> the old storage layer has WA from 3 to 4.
> 
> And everything was fine until I finally deployed it with enabled
> RWF_ATOMIC (production setups should use safety features) and stumbled
> upon the 2^N restriction... It was a big surprise, I never thought
> that such a limitation could exist. It's absolutely irrational - the
> device doesn't have that limitation and I'm just using the raw device.

This is all described in the man pages.

> 
> It's normal and expected in the context of simple file systems like
> ext4 and xfs. But for the raw device... I only discovered it after
> several days of investigation with bpftrace and after reading the
> kernel code. It's really unexpected. I think anyone expects the raw
> NVMe disk to have the same requirements as it's described in the NVMe
> spec.
It seems that you just want to take advantage of the block layer code to 
handle submission of an atomic write bio, i.e. reject anything which 
cannot be atomically written. In essence, that would be to just set 
REQ_ATOMIC. Maybe that could be done as a passthrough command, I'm not sure.

