Return-Path: <linux-fsdevel+bounces-32442-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 018719A53A9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Oct 2024 13:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3822EB2211C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Oct 2024 11:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42EAD191F67;
	Sun, 20 Oct 2024 11:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cD1xUJE9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mt22V4dY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F07746E;
	Sun, 20 Oct 2024 11:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729422594; cv=fail; b=F+puBU6KQ98rFUa2x1Iyt1VBW4/7ElwE8MsGHLbSefRkZFpvEXQT/UetA9MAZLDphp40WEDT4WF3kU72H13rwNLldKIPZuOMsj4oVJk3PZEL0WwGsq69ZtqlpZOURKfT+Hol1TY5aPCF8WqbxSf+yNUtT89X/7M/2NZPC/6vgf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729422594; c=relaxed/simple;
	bh=hl8O+7r1AH3kxppB+vr7/MO2HqH/yW37LXaAWlMQg/c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rKO8+q5THTiSeSjZ0V39P0FBzPSYQgZB3Xw9/+Ybdk0rfwYiQ3ImW3TiQ9rYgHLR5UuV81dzPryh6BunqE++obfU0K1oqa/4xe6MazKByberh1f2pkTKJOkyLSEmEcs8qqo441Tfbma+7WGaDncJzyexVvYob+LVADAUbo7J8i0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cD1xUJE9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mt22V4dY; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49K5YcYd018603;
	Sun, 20 Oct 2024 11:09:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=3sPehvAMLtpgZlJX9hA5/HnZFhx4Xkq+xLw+LnWO038=; b=
	cD1xUJE9ZWBnuIC1BCt5HSCqjO2XUJ0KqkJ65jU9H0bLgeV7JkNSmaCX5VeVOVCN
	KWBUkyANzVWYrwi5RLVNou/2+pG9yfGLqW8GDgh4nhokbGSMxEZ9i9V35v0VGfG3
	bq9qVdz9bAhOu0Qy/3EnU5pg0QKKwpeg3jD8em4Oovj/3wwYA197SicUIO9iP8fl
	pmj8S6ci0vm7RHhYb5Xgehy7USAmAMLYqBZvud+ybPWkixIkt5PT+Avg735sPBLQ
	VXRlu+X1OpEtcPlJF4xF/Ssvnnfj3DT35MGYKZa0M2+h+xD7cVVUmWEyWiTaJMg3
	I2vR9l4NOnVPfapqXWoVdQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c57q9cwk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 20 Oct 2024 11:09:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49K8UpMo035408;
	Sun, 20 Oct 2024 11:09:37 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42c37642a4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 20 Oct 2024 11:09:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WvGW7K+48tiOMhirPW7bOpcUJfFKi7aihfTH6pIiPfkG2z5tTH9+OXHZnvfNsNskEf0hkzCwbrt4no2Sts/Br44AEfKbN+mBILXmKiDAPO5oKN9b8+H28c96HPhu2Qav6a45bTU/NfSIbI0H89G3J0kRrPLriCyHluRJoMX9ILWs0Qo8olHZ3d59oAQRbJo62FOdjZmcq3Mad5nWBlanPtOOlgnlcacGV/UgCGwgRzj6qstytmHMbcYuFX+VXwqIjpjSA1NQKrpa0sfkjhbVfqlCfmXTY8x2Zf+JogoHvUr40BReT4OZVRS2tfcs7uPJtliBh/p24U2xvavq3rc20Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3sPehvAMLtpgZlJX9hA5/HnZFhx4Xkq+xLw+LnWO038=;
 b=yQQZ/wkP4PVbcXja8lT/ZV4KKgayoxtnMCg4Uqgg66F3aY1isjRdTB5VTCiYTA7naDsxB5Dmv8u21mvJGc7OJ6JsQxSJKHecR0w+12TCImXeEqESGrWd4rea1rh9YQ2uN49GU0H7zKkm4VJe59YNLL6VofRkp+x5KXsCtuksYOfkSU3coR1J80G/H/z68kXoeUd6X5dDYSCd9ttpThzgUPE0BFpabDCRAkL+CYGoPKW7k6mSsmUAuEdfD4Aenz1PZKH7NrbkbSKlLkMS6fXxi3Oq3oXskXkznRohI/9jj8tRzzbTP20WyaxpCRbB1RRFzZVzpISoWfPIK2Pc9MdcHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3sPehvAMLtpgZlJX9hA5/HnZFhx4Xkq+xLw+LnWO038=;
 b=mt22V4dYOVgLApx6Rjcg9nKYWVQ82wr20jNjkZAfVLF1eq73iCJVrmVb5cXKiBf37uP78GCzwAczTWH909dZ5G9sxAfy5QmdHHraqGBmQbFS2emb5el4fTu8gmERAd4iHgT2W/W8A9fch2Xa2IzdNyr1dx2xpXL3X0r2MpJsq4c=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by LV3PR10MB7939.namprd10.prod.outlook.com (2603:10b6:408:219::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Sun, 20 Oct
 2024 11:09:35 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8069.024; Sun, 20 Oct 2024
 11:09:34 +0000
Message-ID: <c4edb568-6fac-4c30-9ca3-12fbefc761e2@oracle.com>
Date: Sun, 20 Oct 2024 12:09:31 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 7/8] xfs: Validate atomic writes
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, axboe@kernel.dk,
        brauner@kernel.org, djwong@kernel.org, viro@zeniv.linux.org.uk,
        jack@suse.cz, dchinner@redhat.com, hch@lst.de, cem@kernel.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, hare@suse.de,
        martin.petersen@oracle.com, catherine.hoang@oracle.com,
        mcgrof@kernel.org, ojaswin@linux.ibm.com
References: <20241019125113.369994-1-john.g.garry@oracle.com>
 <20241019125113.369994-8-john.g.garry@oracle.com> <87plnvglck.fsf@gmail.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <87plnvglck.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0084.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::17) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|LV3PR10MB7939:EE_
X-MS-Office365-Filtering-Correlation-Id: 41ab06d4-f935-4b18-9df4-08dcf0f7adf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bUJwbXRnaUJSTENxc3BMaFFjWTZPRVhhb09Lbngxb3hZNFFTRjY2Z3hzU052?=
 =?utf-8?B?VWVMUGt5dDlycXljb3FZM0dJbUtoMVBOZnBNY0dxVTJzUlh6MTVUVm13WHB4?=
 =?utf-8?B?TUc3T1I3TTFDSDRpdFl1S1VCRUdQK3Nva2p0WFd4QW5sZUsyQjVPWDViWXVk?=
 =?utf-8?B?M29sejRGV1FicXpWd2VObnBuWU5TUTJOTUZnakpMUFI4S1pvVXRxWklYTG1t?=
 =?utf-8?B?NnJEdkFFeXd3M0YyMWhXOVdGSDdqa0J3S0dlWmI5WlhGaEJBVU04eVNMamxV?=
 =?utf-8?B?VXJMcU4vTXUyK2JMUHBRVmxGYmdVRkRRTzA2MHVPRExSUFNhOG9xKytKUWZO?=
 =?utf-8?B?OXl3bVdSeEhFRTBjT3lEY3A3cDllbkh3bWlyNGpQbDMxbTdzTzl0SzRkL2ln?=
 =?utf-8?B?MWh5bVRSN0QwcGppaFNUdEZFbHJNT3o0dXpOYTJ5aWltVzVMOHdxMWVOL3VL?=
 =?utf-8?B?T2FKKzUxT1VtTWRqcFdiaFZWbmVuK0xncnVsMTdsVHNSa1VDQlYxdFV5MW1R?=
 =?utf-8?B?YTV6dEZIL2ZGZVRveUcxNnd4enAwNld5UEcwb1ppYVcyOUo4WFhJSEM5UGhV?=
 =?utf-8?B?dlJmWW0zQ2FNSDd1NitHQjJ0OGhuaHFXbDZWSzBiS3EyWXZiNExYV3cyclZK?=
 =?utf-8?B?SlhxNmNQbmR2UFkxQ2Fvc1d6eVIzU2ZlVDdNQXQ4QnExUU56OGdVV3dvVC9Y?=
 =?utf-8?B?bDJLTFJpQi9kYlYvbG9JekxXU3pnYktSbVppRHUyMEQxenhDT2dGQXFNVm5J?=
 =?utf-8?B?ZnVia1ZDY3V5UU1SbVo4WUJEN2F4cHBIblBrQU9LdTVQQmk1dS9OV0RqYm1L?=
 =?utf-8?B?bHdaZloxWlMrYTJrOEgrcXBqdkthSUxPTWRCV3ZwQkNqbDJmUTQvVHJaellq?=
 =?utf-8?B?OGU2cjg4VHYwSysrakZnM2VwektSbUdaS1BLb0JjNm01U2FBaTBFanhNUGd0?=
 =?utf-8?B?Y1ZBNVNrMnRmWmJwMnFmcWlqUDdpNU0wamdKZnI5T2F3Q2wvaXd5UHR2aWNO?=
 =?utf-8?B?S0J1MktwTGFHVmgzZXlEeURqa0c1UHFNU0NIZk1VWXhDNGNsRndkdWdjbE1t?=
 =?utf-8?B?azZoTEN2OVZNMXMvVlN0MUdMVVhwT1laS0FxcHBNRWtudThkRVY1NDZBUU81?=
 =?utf-8?B?eHhMa1JZQVRpWWdxd0NkYUZzUXYzaTZWNFlaeU5vc3VoZm5OOFJNbmh3cUl4?=
 =?utf-8?B?N1ZHSHhZVU5hOGI3U0lyY2pSNnRYYkdRVFFOc253Snp6eUk0Z01yV1NBazRU?=
 =?utf-8?B?STdOVGd4MEFSV1hBSFN4VkZhZ2VlZlJZem1YWDA1UDdsV011akFRbjVGNU13?=
 =?utf-8?B?a09lR2lKUVU2UDV1Vy9XMlRiRlNndkx0eGZ2MUYrdlJFWkQvQWpUaXdHbHNt?=
 =?utf-8?B?MERBU1dCWi9lOXZXSGxrSjhGdkttMGNTVDd1WHkzRlA4Q3M4WU9kbjVDTmJ3?=
 =?utf-8?B?aEI1d3IzaGtpbjRXTkRSb3ZjMmtuWEZmU1V1WlBQaVBmS1lhazVjQ0xFeG53?=
 =?utf-8?B?bzQzNU1XY04yOU1ZVDF2MnpDc3M3MU04aG8ydTRNdFpnTTV3c1pRWGZ1U0Jw?=
 =?utf-8?B?a0NWdE1lTE1kYWhtT2licUZRaHJKR3Qvalk2Zm5CTHAxaE9zbHpaQ0p0Uk0y?=
 =?utf-8?B?YXd0azB2dllVMDlLV1NFTmcxczFDZ1ZFUitrUXZGYTBaQ1g3TDkrUXkzTEkw?=
 =?utf-8?B?dy9GdnpaVTFQWUlKZ3NUbTZEUXk5UE1sT1B5MWFlNkN2aVVVb1BIVVdERk9s?=
 =?utf-8?Q?TGs+iYVTDX8G3at58/eycCai7HLzm7YPGtS1k2+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aFBsUkd0K3YralNzOWh1VG9QNFcyNDlES0p4ZW43WGpwZVpKWWdoeVJ1R29w?=
 =?utf-8?B?a0gvSUhrWDFNMjNjQWVLa2I2ZUJFS0pEc3lzNHVGRmtjK1Q4SUpGSEhSaXRx?=
 =?utf-8?B?RzlOU3UxQVdtRzlGUnN6Yi9PcGE4OXZhR2RHRGZDMDM2cjc5VXYraW9NbHNX?=
 =?utf-8?B?K00vSXp4bmk1Si9OY0xzQURrUVQrOGNlV3R4OFA1ZnkrbDlLd3VFTTMvMzAx?=
 =?utf-8?B?UWhacmkwRFZsTzh5SWt1UDYvUlZNRElOd0pmdDBhT3gvTWJrNlNNZnNzcU1q?=
 =?utf-8?B?NENPRDlsMDNVQzhOcEFWK2lIbXRkSWxkMkJrYUJPQUs2QXNUWm1BS0srTGFF?=
 =?utf-8?B?THN3OHFqRFh0OXFwYzEyOTZRTWtsNEhtOXhNTEg0bHBTOS95UjJ5SFV5V0ZE?=
 =?utf-8?B?alZqY00rblBVME9JYlA1TTV6MEtJSUQ1eXExZXBiK0JkTlRmbDZQbVlFVTZK?=
 =?utf-8?B?N2VxZ2JYTnk1c2FCeitmb1poSHpTNC9FcVdRQnJBamlJeERJN2RBaVU3Snp5?=
 =?utf-8?B?U25zMGprckdyaE1RbG9CVllpU2E4VzlZVVZIayt6cG9xN0J0NC9lcGZ5U0I3?=
 =?utf-8?B?L085TkFZNXNzcmZYTHJNdGRhekJsTGY3SzI0b1N4dFZlbGRhNVR5TFN1eXc2?=
 =?utf-8?B?L3FVMkk5d0NiQjBFc3F3cmtGQXd5bGNyRUFMTE5hRGhUN2c3S0dEZXZCSCtq?=
 =?utf-8?B?UkEyS3lSZjBDNkZTSmdRU3BFbnVwSmQ5bDFaRzNWMFloTUZHbW13VTl6Sy8z?=
 =?utf-8?B?VXNJOHV5YndJNXRpMEljRkMvWjYxcFBUY3NwRXBqSElxRGtjYXByMVNURWVv?=
 =?utf-8?B?Q2JiWStEQzhXNXRmdXRDOG9PQmd6dFRiMUloMDRsZW9waTM1aFd5YzlQdXlP?=
 =?utf-8?B?SldlVTRzT1JTVGZoWXIyWWFBdlhERTFjZml0blEwMmpqNVhOeVJ2VjQ0MWpN?=
 =?utf-8?B?MFJVMFBxWFl1dnVhaXFVRFNvM0FBTUppM3NCQ0JrME1jTE94RmttZS84TEcx?=
 =?utf-8?B?WXFaQ1JSS0VGL2NCUllMcjQrb0swdnZjQWFrZWwvR1I2K2orbjBuL3I2SnQz?=
 =?utf-8?B?d0tSSW8ybVZzQk1aVlBqaXNjQTYvY2ltZnB5Q3doMXN0M0hxeDFOVnd5MkV5?=
 =?utf-8?B?UHFPMDVpeDJ6MDdNZ2hZdmtISWwxYmlUcFIvMUtSQmprOVZsMVpCYitrMlB0?=
 =?utf-8?B?aHlDUnlxR1lJSWZqbzZCYk1UZ3U4bDNRUjZNSHAzcDFhSmtVZXJLSWIrWGpO?=
 =?utf-8?B?TkVHRUc5QjNxdVhlbkw0b2dkMDJ4Mm5MK2YxdU44ZVZ4SzhWWTgxdTZRYUt2?=
 =?utf-8?B?cjJrVFNJZHd2NkF3cVcrbEVtZDRTWmtCVXNlQjQ3STlHYk5lejdBOTFIdzNx?=
 =?utf-8?B?QnpGT3ZnbHZaenBGZm12Sk1jV0xSWHpZcFpibHBmbFBxd3NjNWxIaGdPdDNB?=
 =?utf-8?B?Rm0vVUtQMFhiQ3ZMcDBCSFJrdWV0MTMwclhyUGlxaFRqRkpmUkROWnhGR0k0?=
 =?utf-8?B?bjhuRDYvMi9BMXRHZFVrajRDTmNGTThKTUtzT1FpZ0pJTHVOVVhRdXM1aVZZ?=
 =?utf-8?B?aHdaM0MyL0dqcHFDRHl5MFVzazBueERxRE9QNWczKzRzRUg3d2Y2c0QxS1hw?=
 =?utf-8?B?eldVaHZlL1crKzZiWUFwMkxIaTlLNWFaVm8zNGpkbFFLMzB0TFJmMlEzY0w5?=
 =?utf-8?B?NkR6RUUxek1ESGx6NWhTRVVhV3EvV1lzZGdNTklTa2t5ZjR6aGhkSy9mRXFu?=
 =?utf-8?B?dXAxSGlEa1ZqazNBNE1rdEVWMXpOOGxaTlltQVIyNSt1dlBramtOYmpnYUor?=
 =?utf-8?B?c0VTRlZlbUtYanZsdlVRZ3g1d0pRRHN2aVY0VHMraFBKWlRpQk1yMEFwWVNK?=
 =?utf-8?B?V1l3N3ZOYlkvZjRxcmQ5NjFVQkY4WTgwZFRJSnFGL1RyWUN2ZlhNRld6dVE4?=
 =?utf-8?B?QUdIQVk0TVV5aEx4YTRRS0xwT1Q2WGNqQzJUelZyNFJTRmVQN290L3M3dFBo?=
 =?utf-8?B?L0hXT2YrdjBUTEhFQ2NMTFRPUmpFYStHSjhwYlUxb2dpaFBvYVd4djhVZ1cw?=
 =?utf-8?B?RVdQVkJQQll3UHhtM1hnVElXRHN0S1hqSVdBajJrS2VVdGw0RmdaWGJ0WWZV?=
 =?utf-8?B?V3NvcjZpcEVST0k1QkQwK0w5aGt5NFE0Q3I2NnVrQjdqSmExdXJleGtQRnZ1?=
 =?utf-8?B?dkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kR2qe39wu5x9Rq5IN5gjeTGlrR8zUTH6b4nT+cky2FK/+bOAHEDK7NLzdkfk2AUnGATMtIkhahxitu+TeQCmkKM/zyLlLjSoZSS+rok7YTz93+oBddNiF+viJmBOJ5yA/7wP3TOkF3Z0gCq5QltorwM3NrG7N2yF4aDa3W26mGOSspAJ5dtjGsShCNXCop1WRbjjowhS4OoIKLUHI6lHIBbi2Jt2ceCbPp4WcPz01VE3s6eE9WNFbxpzyedm++w068JS57QMmGAxifJILwu+FMD6SdY5+7WserVys/yNef86M5g0CVPDf2py6J5BfbLWb9ZGQcu2hwC3Z1WwDLuWBOpt36kJzTqpbgW1TXGrhiM9iPnEu13OxZs0rWZhq5BqtG5J3mHt/ooWdKRZ8AtZrDRysC6sGUyzHrFveNqVohaaaBk66/n40KP1RAlB1c4UnWCJ5NHqsgefP0yVnI0WKXTDc8jJvKLyaBJUv+ENEjd+TqPSVrKKTspX6WqTqGQa/i+NdNjmf6U9PWDtRKhusGu+OL/tXxVkWoqkDE68XyNE1FjwCWABUSo2sDGK+7tI88SRoBLhKAqLjtn5U9Sdm2ycS86PKbxz2WyE3Q/VllE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41ab06d4-f935-4b18-9df4-08dcf0f7adf7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2024 11:09:34.8841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3TZ3P8N0kOroSPab36/GVhYKW/HUaViyAATxLFgK4OSlQND40Vt1XxA2yfc0EIUFTuDtLBd+PN2xAa/AlDw38w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7939
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-20_08,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410200075
X-Proofpoint-ORIG-GUID: rZe5i2-odcb__i00Mq9quZFAR8sm6bD1
X-Proofpoint-GUID: rZe5i2-odcb__i00Mq9quZFAR8sm6bD1

On 20/10/2024 10:44, Ritesh Harjani (IBM) wrote:
>> +	if (iocb->ki_flags & IOCB_ATOMIC) {
>> +		/*
>> +		 * Currently only atomic writing of a single FS block is
>> +		 * supported. It would be possible to atomic write smaller than
>> +		 * a FS block, but there is no requirement to support this.
>> +		 * Note that iomap also does not support this yet.
>> +		 */
>> +		if (ocount != ip->i_mount->m_sb.sb_blocksize)
>> +			return -EINVAL;
> Shouldn't we "return -ENOTSUPP" ?
> Given we are later going to add support for ocount > sb_blocksize.

So far we have been reporting -EINVAL for an invalid atomic write size 
(according to atomic write unit min and max reported for that inode).

-ENOTSUPP is used for times when we just don't support atomic writes, 
like non-DIO.

Thanks,
John

