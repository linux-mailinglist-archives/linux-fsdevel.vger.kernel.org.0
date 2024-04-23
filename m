Return-Path: <linux-fsdevel+bounces-17515-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E658AE94A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 16:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F5BB1F233E9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 14:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F8513B2AC;
	Tue, 23 Apr 2024 14:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="j2PcqMan";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BSoPADsR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEE0136E2C;
	Tue, 23 Apr 2024 14:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713881943; cv=fail; b=OIvU20R8d6N0Tc37IiNEJ/YZZZoPUx4rr/2nYWSJ0zlzKxnnSTXq3bAUHhIw1OnOUo0sCrY7mfUMqYhG7lKXfw1Z3XOAAl/BREAAeNFJtwQC4zOj6N3efqkE7kCZ4ihiP13QtIkvkSzMQMM5Kmo3MPMvlCe8gLAY+L9UL4aUVms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713881943; c=relaxed/simple;
	bh=iaCbOnFdoLZheL0hQOumYwjzAsoV9mwjBROHDbfFBXc=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=YdsEnm7lK0jG8zDrKOXWcvNRWLKYv3YFPQpAY/ZEZ/wYrPHteTJ8p02QBLJ8x+TtWX7qW42uDAC2mlBk8y7nMxzG9zs5J++inioETOXexNfHx/fB/DoaV8xgLf1+70HNf896Lk06rImxj9jfxCzf0rN/YPBx0ix58oycQ2wX/SU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=j2PcqMan; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BSoPADsR; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43NE0NSZ013000;
	Tue, 23 Apr 2024 14:18:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2023-11-20;
 bh=wfCEEhXBgdZhBuTQiN10cX4YSwg6rXy/xQUKiRGNaoQ=;
 b=j2PcqMan59drADmRaE0A2NX84OFN1BmCIn9Ohwi19EwmZCKYcCE8evZmw1nwCXgMgtBB
 gupjq9VTIOikcEczyDV2FJtFUqvBjK6XG09pjezHSO5j+z7PypkYIGn/GpzUWbo5zg4i
 m6NYfYSr8yujPmepss874TjRyastkiFRkVA4meJQTpqbghwDJZ6bwQ3el8gmuNk9/XAv
 uXI1oxbvNHpUXMaQ+b4TaNlgdb0lJ60HSKE2J5CyeYt0FZm3/voSKPmj0tjxEtBBhVPU
 WtXjcMFKvgzYXBY1ZgIrFwyjwDMYfw7PXLKhTEYlZ06p69hQJ2DR4k2oh3IUCNOAgY9j eA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm4md5vd7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Apr 2024 14:18:42 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43NDnVYq006157;
	Tue, 23 Apr 2024 14:18:40 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xm4579q7j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Apr 2024 14:18:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HMr+47xiqMSmm8riK0FdxfqA9j8KO6TWiE84hbmcbcWkp0sJwrj2oxtuYzxAb1AGaJk7xqcCLe5ITLz/H6cSLoVp6JXnbld8lqJor+921MFv47lMnZB3KNk6bakolAYoGOshk1k5FC5s/vwZZz/3/GChqoqOb6RvYhNIQh1ovKyE7aLw48QsrLMgoETdRR7OMx5INYavQABFqcHZXEkAbyZQtxkG44wWy1ts7gOu6bXq298a8eEKzLmIFImXNr2PQ3aDBveamF/fTrqFJUVG+kRaoIoFIu8Kqb2pGjJ7ftg0lEyCu6/WyO0UsXSqPFB1peGUxcmWM4u1/mn+VbHdZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wfCEEhXBgdZhBuTQiN10cX4YSwg6rXy/xQUKiRGNaoQ=;
 b=UX9ycvkV7alWk6wqM5tNi8dDHyRwu+rtsoXtQsEhV3Q+/zx1E0tAT/jAQlXGdReq/1Tpe+OWVUr2i8K74/z+di06KEXm4aGBF1lPeu0OSpIG5s3pQFkNgvy0GYusVn+ejqM3KMLH0mqPB8rInwdhjTIBCd5gjGqJFEbriegc7BJVTXyvlTRgWnQHrw46+YeeHwUxahMb9pYNYJr8iYD3lnFnLAtjnCjFZeBjnnI/ywIoxKkAfa8skC1k3ebnietvARm6+PJ0VrridVMBU4jr9k1MdTIRwTjAWZx0DVZRwZgOW6/Js4m8Xtu6tedZBspmRrmMNRZq4qbYW5KA3OwQsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfCEEhXBgdZhBuTQiN10cX4YSwg6rXy/xQUKiRGNaoQ=;
 b=BSoPADsRY8+DiXx+aqzJbYjNsCsUvLLbM2Ya+KOxFaBdVA9nBJVe3nInKufMiLaMOhpih5Xfd+Ek9r33cn4poGnJ0V/0uqhWyN17AxdQ8S45yyQ9CH/JBlYJ+uO8hMf5ICARrZDhq4PkHdZdt2gmB2sAR8bn6UhevgzMMdJucPk=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by MW5PR10MB5874.namprd10.prod.outlook.com (2603:10b6:303:19c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.43; Tue, 23 Apr
 2024 14:18:38 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%6]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 14:18:38 +0000
Date: Tue, 23 Apr 2024 10:18:36 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: mcgrof@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, hare@suse.com, p.raghav@samsung.com,
        da.gomez@samsung.com, djwong@kernel.org, david@fromorbit.com,
        mcgrof@kernel.org, willy@infradead.org, akpm@linux-foundation.org
Subject: Broken xarray testing in v6.9-rc1
Message-ID: <vm5b7c2jwmvptcnpgofwunjg4supq3snn63xqklidudnzlnhuv@kanproehzmdr>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	mcgrof@kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, hare@suse.com, p.raghav@samsung.com, da.gomez@samsung.com, 
	djwong@kernel.org, david@fromorbit.com, willy@infradead.org, 
	akpm@linux-foundation.org
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT4PR01CA0488.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10c::18) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|MW5PR10MB5874:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d987111-b112-465b-2fc0-08dc63a044cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?dnozV0ZXVjBIdlZ4WEI0K09EQlpaSHdXSjVIV29IZzBJbC9QeWZpK013elFX?=
 =?utf-8?B?TlczeEdjNmlWTEhCbUJ5Q2xTL01tRnpJRFUyT2YyMno1Z1JJbHlqaFBmTUFE?=
 =?utf-8?B?NGx2cUI1ZytqY2MrbWJlV3Z1OEtCWHdPMmx5Y0w3NThqK0VrU0FPbUR1ZDFG?=
 =?utf-8?B?SkpSWEl0NDBVUGNCZXdrSWdhVWl4b3VqU1JqRHhQTFIvdzZUNnQvRHBjMmNy?=
 =?utf-8?B?MWRxcEM2cXB2ZjdxZzVFZEY0RHFLNjQvMXZDZXkxa1NvK1d0TXd6dDE0Szl2?=
 =?utf-8?B?Wk4zMUZNRVg0TUFHQjRGSUhkajVWakdoYkQyTnI2T3VjZFlwc1QraWNHUkY4?=
 =?utf-8?B?eVI2RGN3UWFxQWV4S1hBMGdtWUMxRkd1aFoxQzIvbk11cXhnS1BGMU0zT3RK?=
 =?utf-8?B?bWlPdkVyRWR0TnpGSGw3U0N5YkVHQlJGaTVHZHlZSFIwclRMRk0zT3RBdkdJ?=
 =?utf-8?B?a3VGcE4xR0tSeE4vQVNBY05Qai9WL3Jwdk00ZTY3MUdaYzBLeEdhaE9USXA1?=
 =?utf-8?B?Qk5KcXpEV0c0TnY5LzN3VC9OZENjWncwb01tbVd2c2F5bUpubUNWREI2bXNL?=
 =?utf-8?B?ZjV5MW5UVExBWXpYM2duYmVEYjA0NFhOS1A3WnNXWFBvVGVxaXYzSGtscnk3?=
 =?utf-8?B?aTZwd09MVy9WOFAyUXB4cWJpeDNabzI5NHNBNVBkUEVMVk1xRStPMG9rSGhI?=
 =?utf-8?B?VFovMy9FRk5YQzFSa1BLWXpvM3F5c2lvTVBDRDh4eWNFK2JoTWV3NXZnRnAz?=
 =?utf-8?B?N2RnUldtUEY1Sy9SeitBQXNFWDVKcStuQm5ReVVkNU82VDR1V2Z3RENEcUNw?=
 =?utf-8?B?dUlqcHAwaHN1dVdJWWRucjJkTTNOdXNCTVpGTWZPS3JnUVBDU2Q5VmR3NEJl?=
 =?utf-8?B?WUJxY0ZXUFAzQTBvWjhrYlVaTVZaYmtxcW40ME5TZ3BVUkFpenRTZG03SWlX?=
 =?utf-8?B?OXJwODY0L3Z6NEZEVTA0K1J5ZDN0TUFNQ3oydi9SZ055NUQrOUlnNnUvWFlK?=
 =?utf-8?B?amdoRmdQdFlwb09GeHFRRUh0YXBBOXlxbjRmak9ybkRYbi83bEl1TkxWVEpp?=
 =?utf-8?B?ajZvN0ZDL1pmWVdIRG1JbTNCdURjZzBKVDYzeDNzaW43RU9hK21uTEhoZDBa?=
 =?utf-8?B?dDQwSFhFVng3MWRHMFpWRldWVGlBa2xmNE9Lek11aHdlbXk3Z2dDMnppOS8w?=
 =?utf-8?B?YUprRHRubGRRenNGaWNPNnAvT3UzQ0cwbFpUbkxibkd4OHVvQWhwZmlTUXhz?=
 =?utf-8?B?TFJxSHEwM3cwa05BMC9QUkVWTndrajM1K3NDbUMveUxxcmNMaEx2M05DZWw1?=
 =?utf-8?B?SnVYRmtBZlA4TTNBMGZXRmtXbG9hUDRiTDMrcEdVUjRZSFppSXRzQ2o1eGEx?=
 =?utf-8?B?TmZBbEprS2w5SHRjaU5SSkJGYjltUW1Ed1J1MnR4TGxTeU8vRG1WT2l4cDY3?=
 =?utf-8?B?YmtqUVJOc0tKZk4xam5XZytmVVg0SjVvZ1FuaElwUFNLWVNTR2FmWFVEa0hE?=
 =?utf-8?B?SS9yUXAvTEtkanNKdWxiWmgvQWdFdWJyL2FHM2dMM0pCa1p0NTVtMWloYWN4?=
 =?utf-8?B?ekhZblZpNzdtT3BkUzVyQ1M5RjM1Vzc1SzM0ZUdka20rWUw1Mk4yaDlFeUJR?=
 =?utf-8?B?ZTVWSFhJeUFzb05FL1IxQVZReU9PWTYxckhUdVJJTHl3Nmh4QkZJUkszN05D?=
 =?utf-8?B?RGVWbFkybXZlRmJ6bUJwS1c5RSswbWMrbE1ZVHRld3lCNmlhZkxIbGRwZldm?=
 =?utf-8?Q?Vi9uCZG4xWcr4s8kS9vpuj/WrA5UKheH5M2QNji?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(7416005)(27256008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SXVlaHVuYU1zZ3BSLzN6WjFwZFg5M2VhNDgxblkwVzNvSmtFZjNsRkFtbHhu?=
 =?utf-8?B?WlZCcEs3cTNIVWliaGhZMXd6bmNrZ0Voa3ZNa1RTaVdZaDJwWk9jQk5zY25J?=
 =?utf-8?B?VEpYNVVPZWJqWjB2ckpTYmJwWDZlUU12SWI5cDUrcE5nQXJrYWMvdHZWMVha?=
 =?utf-8?B?cWErYmxXNWZ2cnQ4QWNYQ2NacFNyTEh4RmlFYjl4cjZlZnZyRmVnTUttczRa?=
 =?utf-8?B?cDB5bUpxeE1MekIvd2EvUzkzTktWR2ZJMFZVa0NNWmFjNXpvMWhLNzhmcmVw?=
 =?utf-8?B?WUpxSlVqR25WdmZSd3E5QVF5Z0N5L2FCRUhUM0hsdEhQNHRyU1JuOFBDd3Ir?=
 =?utf-8?B?d2hrNE1LdE53RGl0R0ppdGxQSG1yY1RIMXdWRHFZTWxLTDdsc3JGc0lzdldJ?=
 =?utf-8?B?cWdYRnlNeVkxMjk5OE5oSkFJc2p0QXpLZXplY0tBUjNKY3l0bXhURHd2eW9l?=
 =?utf-8?B?OVNoK0pVQkNGRG5mU0VDRUxuRVZ3bnZ3V3E4SWd3T0pza1NvVFNEV0QzVGxD?=
 =?utf-8?B?d1kyWHJDMlI5alo5YmhLTFZ1cytlSXFHWkg3cDltK3pvNWVCK0JZcSt3UWM2?=
 =?utf-8?B?OUFEUkI0ZnVRWmJnN0pvTGVsUUFYNE5lcTR3bTJsVjJheDJBZmpaeEhxLzVD?=
 =?utf-8?B?cmxmTlUwcUIvVy94bnFDVXR1czRDQ084dVZFUFo2aDRXMVRrQlRybWFDak1o?=
 =?utf-8?B?MS9qeG92QWowNzltU1FvczV0cEk3cjVRM0k5NGpCek1kRi9yRGFJcFMzUFRN?=
 =?utf-8?B?bkgzNXhkc2Q2bjFXL09nbERYejg4WHM5Wk4yYXhCKzdpbzA0L1VBS2l4eEJo?=
 =?utf-8?B?VXlhd0Q5ZGJBTkd6Yy9WaS9lN0xCOURZc3lnV0Z6Y1c2TGkycmZzQndHT1pZ?=
 =?utf-8?B?YjZXT1N3R3YrSjBFR3ZVVG40SEsrczlTRzZpQkNESWllc21RbHpGSFlBb2lr?=
 =?utf-8?B?Z2cwR0RacUFsemhSTXZxZG56bU53b2tFMHdjQmFzUlB0cGlpUmh4aHcweE5a?=
 =?utf-8?B?K0Z4WFRmSkZsRktMbWtBd25TdWlnNVUxM216Nm41Q1UyODVXUzUyekJJR2Fr?=
 =?utf-8?B?ZFp5SklqbkxFRmVlTGx4anZsWmhKdWRCOVBlZkdWS1JKN1M3U3NvYUJvYXVK?=
 =?utf-8?B?NFd4NHZwTjc0OUlOV2hyQnlPTks1UndqbEZoT25ZOFp1LzQzWi9pNXBOM2E1?=
 =?utf-8?B?dFhOTFVhc0VLS1FnQnNsQUZkNlBSUllzTndUdkpHeXd0S3ZvVUJWOVluQ3R5?=
 =?utf-8?B?ZTR1c04zc0pTNDRsb3ZSSXZKWUVna1dnMkcrT092RlhrRFR0OXVTN3V6amVB?=
 =?utf-8?B?SCtWMkxIYmFoNjhuOU40ODFxUWw3Vk1RdWVZeFBFZjlxM2MvbVQyU2ExV24r?=
 =?utf-8?B?TEN3YWZ3NWpDUGJUVkJuSVFYTG5qejBCSEdFdDZlTFZsRVVVVEpTNkZQNFo1?=
 =?utf-8?B?SXJJM1VSWUp6d3c1TFRLRkhVRjc2S0d4WkcwREkxSHRPL1EwbWlDM3l0c2dO?=
 =?utf-8?B?U3ltOGcxWFdaUS9pSk1HWFM4cmFMaUwzTkdQQVlXSGltNmtINWRPcE9SR0U0?=
 =?utf-8?B?Rjh4NHdNZ2N3dmNSSHhnc25pK3BJL0Vya28zNitibGdabDFjSzlUVjZnMkR6?=
 =?utf-8?B?V3kzWjdRQlBicUpuNjNWaHdCYlBYTEdSWGZYanFVYzJiUy9jTlRYM1ZDK2xo?=
 =?utf-8?B?SktGanl1WkxVSUZPcGpTWGtyRFUwU01OUklBNzdsUVlxbkZaRjJiMWJHWlR6?=
 =?utf-8?B?WU8wR242dlk2R3pVWlZZRHFMMDI2cThzQnYvcnJzUFBveXNJUFJySUhnZndi?=
 =?utf-8?B?ZTZnRWRJZ0RrU09qc2hoK1VDZUU1S1ZuQkNQUXJzSlNmY1hVOWNQTjZqQVZI?=
 =?utf-8?B?bVN4R1IwVlEvbmgvSStVc1ovbFdPREp0TkdCQVpTcDZ1K2dHNkJhaHVSbGNC?=
 =?utf-8?B?bmx2Z2RGNzNZaVRod09HbHZGT1JwSW4yWWM0UHhtaTRvaTdFYld3N3UvMDRE?=
 =?utf-8?B?NUlNaDFVUUdpTFVjZndma2ZrOWZhTTV6ZVJMZ1pXRGpyditLT01sU3F4WHB1?=
 =?utf-8?B?b1UrK2dYdUEwZVUyandWVlJ1Vlkvc1Z5YWJWWWJreFF0NkkyR3pqaTV5WGVZ?=
 =?utf-8?Q?PsKaJYoFHKCGJvXKqhWuz0HK/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	y+PpFtc/J8MwvDhU7YV/MBvYF2eWJYBxXFj1zBWyu7lFo2CFpEWHogxIkkJsyXR6Ns/7UQRXlqj5jV9LbluiDmXdLHWuGmCql1G8wNGf/ceCcaftMCz+7gp4Y7MzVg0Qxs2aR68UfKbmWJNS8METeRQdPZ5OAmF6BcZwIRo+U2N2duLeab5CU7AdTMLmJH4bbjNxMcYFGNOkVr7vVFclv0l0fNhsha25UvABMkzNFKns0o2UkNho2bmxqVNeYOfeudYWpUzoqlCrG1BrHaOyqwil8MhN0ZfRlydiByn6Lh+UhqqH2qAw31pf6/4Cr0cgVHNHvtFhkdg0kaBmb18QqPMF5hKPse/kpX058k8oprgw8xPOWngNGUnEumAOnlXzyokshBkutx3C3+JNL3wOxB/Dn0pIOiHQT3jxynxNMl6/ClAFKqUmpbbw46skOeY+7tZLjeFtfvz09dEMnPXuX404+KdfNy3ZJjyc8fBCxcvv/SJ0SHU61rnrJEHMI0tecC2HHHlasFUly6QAgcLkhfmBDaS6lM9LhwVcQ67UwktXR9vf73alIdkT2ESoNjva35i+oXpfAf0bY/Jqmf3zF/xW6oIvtgbmIxe0+7zfgTE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d987111-b112-465b-2fc0-08dc63a044cb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 14:18:38.0856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cx5eCuVmrgLCkTy0OGcY1jaii48ejEcPeZCav2aKx9j05/hqz7oELJl/9VogrA8llRvT9I6fOgsdNRk/7ZKdLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5874
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-23_12,2024-04-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404230035
X-Proofpoint-ORIG-GUID: Fr5aA_Uhehie24djdubfVyWgNLAUH_MV
X-Proofpoint-GUID: Fr5aA_Uhehie24djdubfVyWgNLAUH_MV

Hello,

Testing of the xarray using the radix tree test suite is currently
broken in v6.9-rc1 and beyond.  A bisect resulted in your commit failing
to build:

a60cc288a1a2604bd86d3df129f269887018c3cb is the first bad commit
commit a60cc288a1a2604bd86d3df129f269887018c3cb
Author: Luis Chamberlain <mcgrof@kernel.org>

...

Building in the test suite now fails in linux/tools/testing/radix-tree:

{bisect/bad(bisect)//radix-tree} $ make
cc  -O2 -g -Wall -I. -I../../include -I../../../lib -g -Og -Wall -D_LGPL_SO=
URCE -fsanitize=3Daddress -fsanitize=3Dundefined   -c -o xarray.o xarray.c
In file included from xarray.c:18:
../../../lib/test_xarray.c: In function =E2=80=98test_get_entry=E2=80=99:
../../../lib/test_xarray.c:750:17: warning: implicit declaration of functio=
n =E2=80=98schedule=E2=80=99 [-Wimplicit-function-declaration]
  750 |                 schedule();
      |                 ^~~~~~~~
../../../lib/test_xarray.c: In function =E2=80=98check_xa_multi_store_adv=
=E2=80=99:
../../../lib/test_xarray.c:767:24: error: =E2=80=98PAGE_SHIFT=E2=80=99 unde=
clared (first use in this function)
  767 |         index =3D pos >> PAGE_SHIFT;
      |                        ^~~~~~~~~~
../../../lib/test_xarray.c:767:24: note: each undeclared identifier is repo=
rted only once for each function it appears in
make: *** [<builtin>: xarray.o] Error 1

Can you please have a look?

Thanks,
Liam

