Return-Path: <linux-fsdevel+bounces-30981-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E16499038B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 15:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 439BB2836E2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 13:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C78210190;
	Fri,  4 Oct 2024 13:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jbsfMxPm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HzF7gD0+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B2B210180;
	Fri,  4 Oct 2024 13:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728047262; cv=fail; b=AdmgytuR2CtCrODwgItAzEqQ5bmwbVqQeadtYuGucMVenxXQvM1ICNVaHxIDLwGCeXHktPFkC7Ck0QSh2a2dFob4iJRlza41PjwtsqTpnjCkTruYU8+4kjVKvPzm2TGi4fQ/NTsPGu+UestELB3Dd3DT85bCV9tHLv5hSFw8dkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728047262; c=relaxed/simple;
	bh=se+KO1+WnkDpDCJuuH2D/mgk3gd5JyySFoh7120GktU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=vFCmhtVJmhv3w5Rf7qXEjcblM+VUWVfW5gRHzbdkNYVWkyy4ho/ZWot6SHXVy5nDl6NoydNsPX+rIOfA59eJyy3k0bwzlR95Dn17ubxlT75oFAt5umwQpPVeSj6y7g/X5Crs4PpO1XlSGk/HnfDWrDJ7qixiMEsdmffmxgJ9a6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jbsfMxPm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HzF7gD0+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 494CMXQG005633;
	Fri, 4 Oct 2024 13:07:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=4+MUecNKIC28dP78VgEX4gOlD3WWQ9xvsh/4HgXLst0=; b=
	jbsfMxPmHRxREUK25lv4m35mWfLrEGFenWsEzFu0Qq8DNw/X1faqFl/ksmpbAIcW
	fV934CZj2VI3/ikQZRrIpWVf3f/CedPNubTDZ/LFYYf4sOHsTJm+RCqKS1R4V+Z8
	1jGiQaVbI5F/pMXuHqXaaX5Hz1nU95DbMCCpft/pp3cpu7G/5rcW6+D4Lw2c2c+N
	cMChUnE1gt+foQ2nEzclGPQk8gClAvIR0Dkz3JHwvrHdM2F+OeLG+f72WThp1Bpv
	L0mqXtEmnxXZYjvENzKiDVJR5yhwGe4RVo+0S2mrrNfk1QVoLV9cX3V9LNXbFVwl
	ctvCHTmnjPq86awfHzHq0Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42206m1hba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 13:07:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 494BbHoc038180;
	Fri, 4 Oct 2024 13:07:12 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4220578ard-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 13:07:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AABohpYnUhWfgDKywGRi6dP+WUioNXCbnHmwNXisiY/IBlAbZFlVCpmUUFsmTPHUVd6T/P/3olfMb/tfQnzNmBtHofisS48+1Ne0KWRwfrx30jGgbcdX9IYnOlMDGs7dwkvpOd+KaFuNRsOa3w+d2M1UcQVEbBwizUYro7oABpBLAiwplodLeFC7Kkb8i05JM3fWR1fPoIQtWiCNB8m2m1eQuRg2oFQq0IgNZSpAOiYkr1n/zQYCeXZ/Q3aV5oWTrxzQKpNQxeCL1CVwPj7S81y6em4b7EowG+whSsNXuVn7R8Qba7u/MN02GBCCs97iiuCnssOerfGusqhzifNpCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4+MUecNKIC28dP78VgEX4gOlD3WWQ9xvsh/4HgXLst0=;
 b=cQEUpZoKU+WRbaUiE4LEA/8v06TPAufJ1XHZ6YQ88gO15gyjcxA5YiL87yQ/DIGnK0O/bc4pxmSfatA4BJwuf4RpDQoDB1OErQ9bFtjqldfbQ6Qv6lK2m35U5A2UhDdTcBOCFfQ4uvNWnwbAcp5eSDzCBL9w68KVbIeNhc0az9tJ/7dm8A3i2Rsea0Dhxp54WLJASD5PFCmf/q05E9/YG5+V7qjMCJh+DDRdWCRakyonCUIZur4fVKtVS8yQWadCfUYAqEeD/USnnjVbldDhlhj+QLQsqLA4ES9WoEErIHAIa7UrblCse25RLohsTB8U8A7Q/Xh5cYaynJNEwJj6gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4+MUecNKIC28dP78VgEX4gOlD3WWQ9xvsh/4HgXLst0=;
 b=HzF7gD0+LrCZCJ1jv531EjyHnNlrbC8LQMjlmwwROhCxtVKsTmT1c71UsbfjlvoNABELE1th0Ha9TTzrpRqymwT/yQp1icAtLaZjjlTyGzi2ZRkHY5jWgWpoq1iKPnfiMLAXvpUnXJqfCEi6buI42P5Rcv7H/Eu+AvkrVEubOkA=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM4PR10MB6885.namprd10.prod.outlook.com (2603:10b6:8:103::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.19; Fri, 4 Oct
 2024 13:07:09 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%3]) with mapi id 15.20.8026.016; Fri, 4 Oct 2024
 13:07:09 +0000
Message-ID: <f4d2180a-8baa-4636-a0a1-36e474fcd157@oracle.com>
Date: Fri, 4 Oct 2024 14:07:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/8] xfs: Support FS_XFLAG_ATOMICWRITES
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, dchinner@redhat.com,
        cem@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, hare@suse.de,
        martin.petersen@oracle.com, catherine.hoang@oracle.com,
        mcgrof@kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com
References: <20241004092254.3759210-1-john.g.garry@oracle.com>
 <20241004092254.3759210-6-john.g.garry@oracle.com>
 <20241004123520.GB19295@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20241004123520.GB19295@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0201.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::8) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM4PR10MB6885:EE_
X-MS-Office365-Filtering-Correlation-Id: 7adf0de5-a28c-4ae3-0169-08dce4757473
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OXZqeVN2TzRML1REU2JpeUh4blJlQklLeHowaWhTWmhnejBvTDZONVFQcFUy?=
 =?utf-8?B?eVhIVFlUckhic1E5V2FCdG1NUi9VRFRUc0R4MHlDZW5ya00zMk4wc1lZMWtO?=
 =?utf-8?B?MnJaa2JOVSttVDVHd09sUndpREp6MjNROTRmTWx0aHdoNVRValcwMm1HSE9U?=
 =?utf-8?B?MDZPVVhsVWlmeGw1OFBQdEo3ZTd0eUpxQWtudEt3WWF1QlRLWWxNbXUvUGhT?=
 =?utf-8?B?YWUwZjdiazNTV0NQVkVMa3RmVEh2STRPOUM2bFBqRUJKelRhSG1pWkx1Sjdw?=
 =?utf-8?B?emlQVXNFeU9WeSs2SlR0SVZ0TzRieWdITEN4cXdiRG5BK01wWnp0R2FQbTlS?=
 =?utf-8?B?RndzR2kvZUowcGdtNzB1MXlOcENxc0FWSG54TGRLMnFFMFc2aW9FWDQ2TU5q?=
 =?utf-8?B?UHV4dE9wTnBka0tCVGg0bWI0MEQyYlJIaVRJMm1ka3NMNWRWTTZPN2c3UTdl?=
 =?utf-8?B?ZnZQZGhMYzk1cUsvUGJJdmtvd3pxUWtueTJyN2NDZWI3c3N3a3FUcTJYQ2Yx?=
 =?utf-8?B?eVVlb2lHcGQrbTVWVm8xTWlCUy9NdUlxSlJucy9PWEVZQ3A1QWEyRDI5Sm9m?=
 =?utf-8?B?OWFzYkZYNkdWSDVxMFhPckRvOU1OaWE1Q1Eyd0t3R04yby9pNTJWTmtSMDRY?=
 =?utf-8?B?aHJXVC9PTG1FSVRFNlEzZ0hZNk53cDR0Vk1rNGxJdGM4N1g4UmFidi9zS3JP?=
 =?utf-8?B?RnA0RFlrbk5VdFRLbCtxTUN2dmd2UUJtYUhzTXZmZzhlRlI4OUwvUUtCUTNN?=
 =?utf-8?B?aUQwK1dVTnVNRmtSZjBiS1VDSGR6blEyM1VyRm1nM1VNNWduZkE5UloxaE9h?=
 =?utf-8?B?eWwyZno1RjNpdUh1Um5reVJvYVY0S2JDbDRONEU5TTErOU9MZnZjdlppOGpF?=
 =?utf-8?B?N09LOTQ2c09JcXdicjY0c1NYMFArYVlCdE1MeW5tdTRkNGxFTitoT3Nka1Bu?=
 =?utf-8?B?K09rVi92OEw4SzFMSGo0NHpZYk9wNmlBMXFLTVNFRW9vQit0THphZ1EreHRU?=
 =?utf-8?B?UGNycmtOVzhBb09QNEdhbjE4QVdzQmVjZnJnN3hoV0l5YVhqQVdKNDZPNmRW?=
 =?utf-8?B?MHhGL2dIcExRa0FFWkMwbkM2d3pIcTFqN0hkT3NrU3p6eDFLWi9OVytqMjY3?=
 =?utf-8?B?UDZ5SXF6djlLVnU0S3V6RytHRGgyNGhEeVNpdU8yd2pkN1JmTmtuMHFZMC9D?=
 =?utf-8?B?UXk2MVFPYzc2NE5ER1NMOThlUzcyRGRYWHZ2USs5NWhpTFRIM0NRcksvQ0F0?=
 =?utf-8?B?Z2JJVVlLMGhJM3pOdXZCTHladStxT3hrYnFVd0htcjdWOXNqeDJsZWFEQlVu?=
 =?utf-8?B?ZkkzSHg2QTg4cXJjdVNheTE1TzFhKzR4WU9jNkFES0lnRUxKNk5QTCtxRGhG?=
 =?utf-8?B?UndpZXFoTzdwVno5ZlBaM2FkK1hZUCtnbGFXU1lZcU5uRUU4b1pFelZKcXhu?=
 =?utf-8?B?bkJLam5iQjBVTFNjV3NrU0dYeUZKMGV2UkQ2TzdsajRwa29sOGpMTDJxN2Fu?=
 =?utf-8?B?ZGpVZWVvSkJkb09rMmJIUFBsWG1mQkE5aUJ5ZHFTNEpFOUNpSS9teTRhYWkr?=
 =?utf-8?B?eVE0bmFvN2pNMCs4K0svaENTYXk0VWNvbDFnQUdGUlJxa0xhem5JamR1eFJj?=
 =?utf-8?B?a01BTUxsbjNVM3ZDK21mUzNVTVZVbnF4Wkt6ZGZrYU1GeVFUY21pckFpQlVB?=
 =?utf-8?B?Qk1GMUE3bXNQSjcwSDlQNll5QzFPTlFmVzgrOXNmSFZzMUtTa3ZGa2lBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VjBCSWdpTnR4QVdscy83Tno0MThoS0h0THVSY3FnTlVuUGo1amxpcTF1dFFh?=
 =?utf-8?B?WjRFa3JTaW5zd0dIL1pDc1B3UDlCN05UWm0vOUVzZm5LbVlYOVdWUDNvZmNW?=
 =?utf-8?B?d05BeUsrSVUvbGZrenBRSXJiK0pFUnhLci9jZEdRN2gyVzQvQStVSTFCcnRj?=
 =?utf-8?B?VFFocFlwazhLNlhtNGp6TmRiajVXcnNqTkVKWWtnUFFOVXcrdVdZa0FtL0VG?=
 =?utf-8?B?YTlWSWVtVTMrbk5DUndHMndKZThpNGdrWXFUaTNxbEhiVUxPTXBqU2owTGk1?=
 =?utf-8?B?NFhSNFdiR3pCdHpwTkhkbFhaMFQ2dVJYdkx5UGlLRm44Q2JBQUI2UWJCSmp4?=
 =?utf-8?B?ZERCOHpraU00YTZnRklQSFI4UktDalRhaFhWdXJjUTZvTUtRek01MXFFMTd1?=
 =?utf-8?B?UU9CNnFJdjYxcDNVWkF2NkNzUS84TXVEUDJZaE9RcjllazhwbEpCL1lzVmh5?=
 =?utf-8?B?THg3dzM5RC9WTnNEK3dFV1d4SEpIK1A1aDJpa0NOc0I2Zlk0aWtMYXprOTVR?=
 =?utf-8?B?cVFiOGZhVWhTNElEMVR2cTVLeEpOMFVLOUZPMWpjaGRTZm1HblE3aUtFWkJW?=
 =?utf-8?B?V2lRVXAwalhHS012VHVaQTNBdnkxcDZrTSs0cnl1SEw4ODBQdVRMb2ZZeW9S?=
 =?utf-8?B?R3Nrejc0NmZ4SGN4bTUrbjVnNFpwNXFxZjVNRVRiWkc2WnlIR0hJbXNSUUgx?=
 =?utf-8?B?SmNRUkd2Q2NIMXIwQjdMRXprS0hMQi8zY3d5R3l0K0t5cGlsZ0oyNlRQNW8y?=
 =?utf-8?B?WjJncHlFVGluZ0dPeFVRWk1ia1BUMDhqRzFBSUNiZkp2MlI3NlJ2RW5ybXBq?=
 =?utf-8?B?NG0waE5OQTdPZ3FLZHZDRUdjRnFPWXc3SEtSUzBnTTVjQUIrQ3BCa21iOUZs?=
 =?utf-8?B?cU9RUGcrTm5JVXZBN0ZxQklYUXRRT1NvNVpnNVJBMzVEQStEaDc2RWxndjNl?=
 =?utf-8?B?dmxJUjErbm42b3V0Z0NjNFRqTEVCMDlYWEtnZFNjb3dzY2xlQm8zZXNzN24z?=
 =?utf-8?B?OU94QUdoQ3JhUVZPSkg1WUlZY3E3TCtZUk0zNFI3OUFsVjNiVzhtTUpmcUdQ?=
 =?utf-8?B?NW1Semg1VU1KUCtCNVFPWmxYQWFpaGJPNjNPMEZvajcxYm5oUG9ZbHV3dmJu?=
 =?utf-8?B?N3NoQlZQMmdZaUc2a1BlN2tJTkE2VkMwVUdhcTJxWVVSd3VwaEN3OUMvd1dG?=
 =?utf-8?B?azZNMklxWERVSmhwWkM2LzdtTlpLdHBBclJKZXpqdG1valRSb01PZXh5cU5T?=
 =?utf-8?B?YjQ4TXB0R0V5MUVxSVprMlZ3YklEZUUxS0FROEo2NURtVk95a1liSnpSQmNv?=
 =?utf-8?B?MHJrbFN1UkgwN09SdzRvWS9qOTdqZnBjTVZhdzNIdkhlMXFDeThZalNZdk1K?=
 =?utf-8?B?L0hMRW14YzlCaVpBOVZFc3pMU3JNNkt1dEZick1wK0QxczU0L001c1JNeGJ4?=
 =?utf-8?B?a0VkRHJITHVTMTBTWkFZbXo4Vk5VeUh3czM5V1p4QzlGemtQSjlLOWFaVGdU?=
 =?utf-8?B?anVQVE9vL0d6dkE4bGdMYWZNWHYwSWJISkZOMTFtRXNBM2RuVXFySTR2cGpk?=
 =?utf-8?B?WHFJNS8rdXZBanU4VVFPekFtakNSS3c0RVZzclRzeHl3cm81YjlGV2R2aDJ4?=
 =?utf-8?B?VnRsMGNSZ1gzZmI2M1VnSWZWOVN6bGN5WlZzUmQrb2FBN3A4emhrZGNmTmM0?=
 =?utf-8?B?T1AxU28wUzFaQzNqc3lJTDlyVUJhajNGeXRlbGpWWExPZFZsNDduQ1A1OTRr?=
 =?utf-8?B?NkIzclNyejkwUW9MR1J4R3hFK3U2dHBJcDJiZzhlZGtmRUhhaXlxd0pva2lB?=
 =?utf-8?B?SkhuNm1LV2wwNGh6WFpqek51Uk5xYjJ2clN1SU9sUTZUeG1UMDcwdGZsQ0hL?=
 =?utf-8?B?bXo0R0hnR3RiNVduVGxodzBqc3ZrZ3VRbkZQRGFMR21mWXl3UXkrZlBSdnlQ?=
 =?utf-8?B?ZE9WTW15cWpaUXVQb0w3cEs5U2JVNEhNZmg4UmRkOERURjB5K1dPNWx3Tkxj?=
 =?utf-8?B?dkZuOWJnTkpwYi9Qc3FzRlZjSXkzV20vV3Vqb0duK1R0YUFVTmJzdDZPZmVm?=
 =?utf-8?B?em41RWhBbmV5R0JwcTJEOHRCdWtSQng1UmxsNGgzOTFrNDFlcGNHaXV6bTIr?=
 =?utf-8?B?cUx2SVlzaThEY3E3K1Z5WjY1TUFZM2F6Tml1cVlMN0FhdXBSWnBvdGNybVNZ?=
 =?utf-8?B?akE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7B6kM2Md06JRoll9PsugayAegF2a9LgZFRo1IU+owQJ32fM0yPQnhf/DLxPQ4p3DkdhEgzc1QgIQsdMJGSq6S3IU8KfGvIcdL8sMhPIFdBh3iDqj+0tl7XbpYSM6y+ylAlAl8xJjx9ejT+ho+d0H1zjvK4WHXuv8A8CtdBqNQ/Pp1I5alQC1rIiedyvHcsiq7GSe/+MpnWda9O8pfeJIWn9y7AhGLgfZwuAK56Aut+Q4fO4E+PQppzuxU2vqY0LPa55fwgWhIfYpI4fLEQUVdSo7ozKp01kvckPNF4FcaRrtbY3G5dJ+69gOTe3LokscZoHTKAWZUxXJStonN8ZTkZTpHLvB48Dtz1ADHud9HWVBqlyCvY2FyO7KJqeK1Zxrc5RnCXYLjeWCBMVvFKEYGumI1J1pPPSC3krfe4pm3DVYiqfCNPtrkDVkdubB1EViJu/Av7i/TCB4Zp42Zj3Viv0eOJ5qQkocyAHm5rtRzV7Di2yRvXjpwC0aNtuvLOFUtOOaJTxt0vSG291qHSUrXDk62TbNKtLG4RZHV0KknTMGm5z9Krwz3mcCxZhHPiGB+9VQY6Stw3Py2OIW9MKmlGTze+69IYayerK/cVU0Yug=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7adf0de5-a28c-4ae3-0169-08dce4757473
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 13:07:09.7878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4y2j/WkcQnQ6BT88g8E99n66faKKOwe+OGczjpE5/n/Hsei0y6p5lKqy7xhrHnZyYH1bDRbypkaUKwAmxdF19Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6885
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-04_10,2024-10-03_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410040094
X-Proofpoint-GUID: otMuD0fI3vR90p9O3aw5yAdyiqlhVzSn
X-Proofpoint-ORIG-GUID: otMuD0fI3vR90p9O3aw5yAdyiqlhVzSn

On 04/10/2024 13:35, Christoph Hellwig wrote:
> On Fri, Oct 04, 2024 at 09:22:51AM +0000, John Garry wrote:
>> Add initial support for new flag FS_XFLAG_ATOMICWRITES.
>>
>> This flag is a file attribute that mirrors an ondisk inode flag.  Actual
>> support for untorn file writes (for now) depends on both the iflag and the
>> underlying storage devices, which we can only really check at statx and
>> pwritev2() time.  This is the same story as FS_XFLAG_DAX, which signals to
>> the fs that we should try to enable the fsdax IO path on the file (instead
>> of the regular page cache), but applications have to query STAT_ATTR_DAX to
>> find out if they really got that IO path.
>>
>> Current kernel support for atomic writes is based on HW support (for atomic
>> writes). Since for regular files XFS has no way to specify extent alignment
>> or granularity, atomic write size is limited to the FS block size.
> 
> I'm still confused why this flag is needed for the current version
> of this patch set. 


> We should always be able to support atomic writes
> <= block size if support by the block device.
> 

Sure, that is true (about being able to atomically write 1x FS block if 
the bdev support it).

But if we are going to add forcealign or similar later, then it would 
make sense (to me) to have FS_XFLAG_ATOMICWRITES (and its other flags) 
from the beginning. I mean, for example, if FS_XFLAG_FORCEALIGN were 
enabled and we want atomic writes, setting FS_XFLAG_ATOMICWRITES would 
be rejected if AG count is not aligned with extsize, or extsize is not a 
power-of-2, or extsize exceeds bdev limits. So FS_XFLAG_ATOMICWRITES 
could have some value there.

As such, it makes sense to have a consistent user experience and require 
FS_XFLAG_ATOMICWRITES from the beginning.

Cheers,
John

