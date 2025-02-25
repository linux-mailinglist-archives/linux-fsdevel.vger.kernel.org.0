Return-Path: <linux-fsdevel+bounces-42572-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9221DA43D11
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 12:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C956D19C3ECC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 11:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B66267708;
	Tue, 25 Feb 2025 11:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZQjkWgVy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="w9vBfEvX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4187E2641C7;
	Tue, 25 Feb 2025 11:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740481924; cv=fail; b=ZyxeG/UbcIkWpgUpuxTfL32Yk7gZDEgnUDZMpPZoBvIH9iofTrowkDHJ+REYgVHKTaEfyWNkPHT0+qLgcG/6sekm62GZbHmHT1iJHVUzPCEOnwIXYw049CCbEl/Gy4ZLmCfyGlopf0MyWxQ7fVz9QdHd1RHvWRTyKjgtHcgaJ1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740481924; c=relaxed/simple;
	bh=ET/GbjVNI6wa4kAfQ08/9Br7P97rFbkLYqHZApBRk9s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rNYw55KQqPK69B+iHKxSAZCqaRbPhDBInPG4VEqtoc+gJRLjAu6SbcOHX+s9wN9NiF/wg4XeWZb11s/StcSBPjeloGsxGWKo700i6KmUWzSq+JJz3w2HSLZttyeNcNnaR97pZ/FTWuCWpnz26EbVm3qUEq4bJS3jaj3NKO9jtcw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZQjkWgVy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=w9vBfEvX; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51PABxri019253;
	Tue, 25 Feb 2025 11:11:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=mMexZQGUajjVrRbAu+3ea/VOocEv6ilcAUDsMf8eahE=; b=
	ZQjkWgVymXzL3vJdQOTDlHK/OlF0RBQkgjAaneOTk3yj684LFo5Xx7NT839E+iEX
	B7ImtLQP7Nnu67G/B8lLn8ivWEnnKKkVk5c8K7zuy8anvz+U0qkoTZfu5NsV+Zka
	2aInqOhgJfOQnGU8yKxUU6Xq5c33UguWroPhcOpPVo0wCx56zB3KzKsbj1Twp9A7
	vz1XoW9rXAqpPs0jjBF7L90y9Df98IaENsCSUECgSx9gIUlHITLzlisrXgvPu3Gi
	FJeF9siLJnHBd42Sh7GcfVTAWWcPWNwKunwI20KHRegoR2vxY28YaYYS2GGF1Mbj
	eowdV7XzYsLilUOUv1BK1g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y66sct3q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 11:11:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51P964hl002867;
	Tue, 25 Feb 2025 11:11:51 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y5197y0f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 11:11:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W+GypdDypJ+4xg3+QisQYj+NZKqwMr4fEaBWdrcZJlSJ5IvGm1DC07oQG6x1RbZlIg0EH4cjPs1B967r2BBJtvqM6cvi/vxD6nROZlo9Xx9DOWTACHVzbX7nQovtdlR6ATJPSTOMqNRniHlKNBYaMogJpMtYZ4WcMz+RHISNiXy8JIBFt8LmIE347C6gugbWcpfXAByKtjhwT+d0YVTarOdo0h00Df/4bd3ln8HYVG9V0Gl+vxidVkBI2vfk3omB9yYAlUqy7X8TF3ZpftAIYFAN80A6iC4MDbNGhrQhQGtYWzJq6YDqgLsEkLVIw0F77xbW1hIoxOhNrLAa6ZkX6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mMexZQGUajjVrRbAu+3ea/VOocEv6ilcAUDsMf8eahE=;
 b=S8AGE34hPDndqLBs6H1XBYnPoTf4ixSd8g3841hYokV0okelBlVMobiRMXUBky7nF9b8T82R77+qa2DnZmPLrR59V0AH85o6KA1r/1PXu73jWYKf+aoxfgJsJl1Pl1u1rboUtgXnUWsk4n6qlEXVI95MBDwj93az94xX6wPliBQbnbS5tIW8JcgnkjDBv9Zv8StCnI7ARXYDHMCHtHiZePrE+YOEalV36HfD7bn3xvkrMGOZ4VwaxoMZ6OuXt9OfCOa14NfbegK8AnnquH6BnFpwgaMOcyKwkRtXQtoi3n8ILyfuOhw8gwKqoxZxKURtg9FY6UaofRbZbLyhP7JmBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mMexZQGUajjVrRbAu+3ea/VOocEv6ilcAUDsMf8eahE=;
 b=w9vBfEvXlEzHTyn7awOY10gkcux2WS7UrPfNugmIadmtsIQrkzf0XDlDP4ZqxYAKJTXgLfDvJybfhKbMKsB4NA+3zdoJaBIFe8AP0UOaBPWoE0yHo6sXnQ4NJX9CykKqVhUZhEuhPxySAhD4ZZExKqhS6temK/dUeOf7rpyZY/c=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MW4PR10MB6321.namprd10.prod.outlook.com (2603:10b6:303:1e1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.22; Tue, 25 Feb
 2025 11:11:48 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8466.020; Tue, 25 Feb 2025
 11:11:48 +0000
Message-ID: <b2ba8b64-be86-474d-874c-273bbeb4df00@oracle.com>
Date: Tue, 25 Feb 2025 11:11:45 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/11] xfs: Commit CoW-based atomic writes atomically
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: brauner@kernel.org, cem@kernel.org, dchinner@redhat.com, hch@lst.de,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org
References: <20250213135619.1148432-1-john.g.garry@oracle.com>
 <20250213135619.1148432-10-john.g.garry@oracle.com>
 <20250224202034.GE21808@frogsfrogsfrogs>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250224202034.GE21808@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0085.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::18) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MW4PR10MB6321:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ff9a20b-3dbc-4093-39b6-08dd558d32a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WU02NGQ2UnFmRlEzN1o4b0tic1lzVFFzVHQyMjZCQVZzOEx6TnJRMThMWTk1?=
 =?utf-8?B?RDFtTDFlQTFPUFhDdmRVRXdWc2tHMlB4RVdEU1h1TVZvVDZmVkFHTG1oa1Jy?=
 =?utf-8?B?Tlo4N0VoQTB0REUwMVhRYjBNREtkNVBDYWRUL1pqTDl3ODRuVDFyUFZNTllr?=
 =?utf-8?B?YkpFWXRrcDhPQWI5UlFCNWFVMVo5L20wSk1xMlNiUk9XZEpDY04xbm1FaTRp?=
 =?utf-8?B?M05FVFJQSit0d1IvMHo5OWtGWmJsRFFFUW9wWEM3N2Q3UkRVZ2oweXVNeGRw?=
 =?utf-8?B?bGRJdmdSMlZvQTFkZDExdC8yMDRNMlpjVE1pczlCUlBKM0h3bXdYWThhY201?=
 =?utf-8?B?TmdiaTBma1BWWExmSitIRC8xdGYvSHA4ODdSN29TTkZmRW9sa3hqL3lUdEl2?=
 =?utf-8?B?TGFCTmZuQ0dubkw3UkVBMUxKK2d1eDZka3JWa1NKcVhjc2VySTlMaEh2aHhK?=
 =?utf-8?B?WldhalZxZmlMZVZyTmd6bVVhMk1PY1VDQkczMEdWRXFKNE43dllSTTRaZ3ha?=
 =?utf-8?B?YlRYWnlPU0dmN2pVd0lCOFFmcUJkaEY0WG1Ua25HaXFxUUZKV3M3YWlNR2Fx?=
 =?utf-8?B?dHdJQXRIZFJBQTdSWTh1dWhNMk0wOFdlOGJJclgrOWFTdml3QnArVTRKN0Zq?=
 =?utf-8?B?V0JoVWl6d0Y3Y3grWGpTYWw3ZHhCOFpvYklmUjl1cUU4YUcyUkZIRGZ4a3ZF?=
 =?utf-8?B?YytIR2JKZHlqanZPdW5sUzZtSHQxVU4wNGdJZ1RVZlB6K0VqdzVHbkNTNFBT?=
 =?utf-8?B?Ri84U1o4MHkyOFNnV0FFK0p5OHM0SGhrT1pqWVJRUTlNWTd1US95RXVkTHhn?=
 =?utf-8?B?elFEQWRFbXFDNUFxYktnbjQ5L1NGdk8vbDIwUWVaeGhCT3hMdXNLZVhxOGVj?=
 =?utf-8?B?bUxwWFFlVFV4azYxL05hc2hMc1ZxaytLUG9ZOTNPKzMycnhOYm1RbXh2N0c0?=
 =?utf-8?B?Rm1ub1diVVJaU0RBdDZDRi9wci9DSlJLRmJMU1I1WUpWUkdGd3hhQy80NUND?=
 =?utf-8?B?UWpNaWZWM2ZuSjB0SnRvNjdQMFhLdmdlVXVrQjhPSFRGWG9RclRuSm9oVDZW?=
 =?utf-8?B?a1JuY2VISUxiekgvbFhOTU9QVk9DYlFJZ1NXL3RIUnZSM1pMcDFBeVdieVg2?=
 =?utf-8?B?U21kbkVmTEJCMDlVWDVkZWxsRENoYWdYYllzWW1hM0NzWW1JWU5YcGJyay9w?=
 =?utf-8?B?ODdlbklhb0U3RE9KZ0lycXM3N3hycVZyOTVFMkdtZ1UxSjVKVzJVbkV0SzVQ?=
 =?utf-8?B?S05CMFBSZHQxREZUUkpNaCs4SW5sVjlraURlanNhNVQ4QUQ5ejdkd3ROT0p6?=
 =?utf-8?B?UitsVTExVHFiNWdab1VzdjJrMGdFM0pQd2NMOHZ1bDRTRUZQVHFXYXVKdDIy?=
 =?utf-8?B?VVVMVytaZENEdzhuR1k2WVNUL0hPVW1xVVQ0WjdJemFMQ1ZkaGZCa2lZSGdP?=
 =?utf-8?B?NVV3OHdUOVdTT09vUCtxczJLVHVqSlprOW1QSFM4TWFobGEweGczOUtVWk9U?=
 =?utf-8?B?dXZpdmNQbWwyTzFWSTU5Vk81RWN3OXVRMHVjY1hEMjV4T0Jpazd4TlU3WUpz?=
 =?utf-8?B?SHpzbDNxdWFBUzB4NllTbGJuTVRPVHBqUHFjVGxIcFREUFBRUUJLTk10NmNI?=
 =?utf-8?B?bEtjaGsySlRrTlV2WVBxczV2eFBmK204YUVKNlRVcmVLS1RGL2s0QnJSN0VN?=
 =?utf-8?B?VG9ybXI3eXk1WDd2RnQxMVAwWE9GRW1EUFY4TTFYM0xVZ2VWWDlIUjJUTjFt?=
 =?utf-8?B?NlBpa3ZWWmNISTAvTEtwWTRVZnMxa0lpT3VtM210QWd5bVdBWnZoZ1ltUE1G?=
 =?utf-8?B?eHRtL3VYN0w1NlpsNXZ4UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YWpwK25DcVoxcmV4OHNQcTQ0WURDRnU2MXFrUUd0V3YyQ2FaMGFzNnBNZDRE?=
 =?utf-8?B?eG44RUNCdUViVWs5VUtVeHFORUtRV3VFc1pYdUJ0RzREVStDRE5nMTdJalc5?=
 =?utf-8?B?c2lyc2RjTmcydVp6YlZUblVUclR0ZkMveGs3NUNseTZzSTlpaUEzWE1DOWtX?=
 =?utf-8?B?ai92SllGZkZ5SXlmaXArWllMWGEwU3NaWTF2UE42WkljYTZKZnpqZ0I2Z3U2?=
 =?utf-8?B?WWJqTjNsNjlraEc1MVBZVUN3aXZmbmR1TS9FOEZnTmpZdlhaSHFPc2RkME1B?=
 =?utf-8?B?R2dkL0ZEcEo1cHhCU1pMeFRhSXpWU1JlN1pKNktYTzBFekFheTVUcDVjdmha?=
 =?utf-8?B?YThQay9ITWNaZDY3OVEwSWlKdUtaT3NnR0xONGdPcUJDT1Ribld0cFlEV2FX?=
 =?utf-8?B?V29VUEFIRXYrdTlORXNsRjlVYm1PMEszME1TZTdnbUUyeFJLMVR4ejNPWHhX?=
 =?utf-8?B?QzVBVW1jWDBLeWh0dkdBR21ndjQ2YjVvNnYxTU9tSzFxbW13bE9ocWdWd1M2?=
 =?utf-8?B?L3lXOFdVZUxlOTFaYitVekcwaXFIcXhJRitYYjkvTWprMXVQRUpVbmVMUUlj?=
 =?utf-8?B?WmZPWDBCSDFnajRaeW9HZ093SXJVZHAwbGxHbmV2WGNjMzFrRk5BVm4wclVt?=
 =?utf-8?B?eDlVOTZwNkwwUTRWZURGbTQrb0RLTDlaQW1CQW9FNFdRVWIvYm9sUFJkcnhP?=
 =?utf-8?B?TGE5VUxZNmsydERxeHFFNG5IZDM4ZlJoU3BvNm5JeXplYi83MCtOR0p0UmxL?=
 =?utf-8?B?eVA0eVRGQ3c0SnJlZXoyVnBPbTExWHZSMkpiRUZqWWxsdnVkQ1BnbElXeXhj?=
 =?utf-8?B?WFA1KzIzRm91Q1Jub2lsaWpZakJZeE5YTGdmSHorTzdhbzYyVDFHQktMaS8r?=
 =?utf-8?B?VmJrMXJaSFBNbld6Q3p3Qk9VU3UzR2FQNzdqaE54YWgvaWVPcFJKSnN1d3ZT?=
 =?utf-8?B?YXVFK3lwV3pUbDN3M0N4SitQd1VVaDV4UTFEeFVHVHovOTEzOEkzRS9tTDV5?=
 =?utf-8?B?MzdjNmNmQkwwRTJRTFRLZ2hZQllmS1BsU25CZ043LzR4QmxEcFNaTU90YzUy?=
 =?utf-8?B?UTB4OHBIK0IzV2hicFJveHFzYmZzaEFpb2pnZW91UkJqemhRSStPRTB4VThC?=
 =?utf-8?B?WVh0blJzcGtqYVk1UUJ4clZ4WUxPbGhCOUNtM1hzd1phVUg0ODJPYWJycUJV?=
 =?utf-8?B?eXhyTWRWWG1DR01RcUwwSEx5V21JY0VJT0U0dzZ3MUdFRmZmSmlyS29MVUV4?=
 =?utf-8?B?ajA3ZzFucTZNT2wzbVZidm1nY3VpUVVrUnFQVXY4eHdRanFQVjk2YW9kcXBS?=
 =?utf-8?B?Z0MvMjZTTjFmaElSaVVsc2hGWC96WEpUekNEWDNjeVhrbzF4STFsMGg5QlNC?=
 =?utf-8?B?UmwrTTdPaExhRDdUdWVtL1FiNHZPRGxHWFBsblF2UFlPVHBvSzhhOTZHa2NY?=
 =?utf-8?B?OUFRY0tUbHU5WmRZUXRFSzVtRnBQNW9XZTQrbnluZkdUeWdDQkhOMThQdEpi?=
 =?utf-8?B?ZGp5NmVtVFRiL3l6dnYxRUlNdFVtWmlJUkJGUW5jT2YrL0UxZzF6WWNYTEJh?=
 =?utf-8?B?a1czeUJOZFhrbktiK08wSiszeUw2ay9SNVBNVkRTMGdyZ0hwMnRhZ2NVSTg2?=
 =?utf-8?B?QVdUWklXcWVkKzd0bFIxU09jMW5OZWlRRUhwR3dwRDhUbWFzU3dUZGVnalNu?=
 =?utf-8?B?TDRPZERyaytkTFVSVEtIVjNnSTZFMytSeUdFOTBFSzVOQ0pPTHFNeG84MG5y?=
 =?utf-8?B?K0tkK1NidkpMWG5EM0xYd3N0ektnWEw1ZmJGV0NIYlZQdnVTS2h2TjhmK1VN?=
 =?utf-8?B?cHluL0dPTGFaS0srSFdYYTdOMDIwTXJzZ3VmUVdCZXF3YzNlRFNuU2hNV1ZH?=
 =?utf-8?B?aUwvQ3ZDMVV0MUdnRkJrYWpkZEVDYkovMTcvZ1RUWFFwdWlXbnRhaXhPL1NC?=
 =?utf-8?B?QW5IQm9wK1Z3VDYrMlJ0VmcycGtKUlovYWFMQURSK0ozVzhEWTh3VjdLTGdX?=
 =?utf-8?B?UWpJN3FrTmZtT1pFbHcxQVpsTzg0cVZDTXJmVkh2aUFuQlo4YTh0WTAyTmNI?=
 =?utf-8?B?RkpqeFpHaTNvMVAyeDhiQWl5UUkxdjhqakhHMnF5cmZEcE5oSlc3L1ppZkZN?=
 =?utf-8?B?eW1mWWxRa29HWHE1NUIzU3M4U0xleFRBS1Z1eWlFd2kvdllqWFQ2YXhBNnpQ?=
 =?utf-8?B?bVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LUdW2WUVLfmV6LxROYYcTS7y3wKrIz1zu9MYYxjJYHarfY4HsYQgAJ2iwpONGOjSfJW4BEC7AnL36LfG9s9neXhq8cHEEZD4jQGzqkBPf9cKbaQT4iMS8jpZ87Uo9cjWkG6c3mTNLfCJvFmm4m5zHp6QSBDTLyEcnDWGfc74a6UqP6eE3vFO/7jolImN+ekfibFJAhAk4tu/cFuEBRGaYKdxlBwYFARSiJA4H89ZBBZogEU8r47a7hc/+wqalwXlPzCXCLcaTUboF9MZHmgMUyIuRjSfM4zARpTtP7ulysla1aenrh4yM16RpTbe/zx75EdPhLDes6gR7bcqsfoYcPzEa0c2WvmSj0Ir2fReYH7FOCWlUfU7EflPBeLtKgdKdQrD3U4LMai0cH08e6qtuOOb+1iqItxtAaLBGgDsvPQuLrzx7uxdDt8HLMeFOKLPiLSGh1asa0yU41AyjsySw+GLnSwB0H7vfP0yhy58hwW8pNRYqbNFqY0gQw2BSG+fuwBoouItXoL3JdQtEcMiL8V7vO2yYLJ+X7Qr/zogLjvcRrlCpp6ECPDfktCKLjrJ/bG+TbbC91g+CKu2a31vI/+HBN0Aj2PKI+zxqU6EuLQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ff9a20b-3dbc-4093-39b6-08dd558d32a0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 11:11:48.6849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vH/YKx0MkG3BPadZ0N2kNX2G0gc2IWA6na04ETqCsuKZcxeDFr/Fw3kqt/4T4ozxqJsGW+ZAcfxCAjg3HxSDTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6321
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_03,2025-02-25_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502250079
X-Proofpoint-GUID: SJIn_I1qrSEm-ycH2Cq59JaV-9Z2lxNV
X-Proofpoint-ORIG-GUID: SJIn_I1qrSEm-ycH2Cq59JaV-9Z2lxNV

On 24/02/2025 20:20, Darrick J. Wong wrote:
> On Thu, Feb 13, 2025 at 01:56:17PM +0000, John Garry wrote:
>> When completing a CoW-based write, each extent range mapping update is
>> covered by a separate transaction.
>>
>> For a CoW-based atomic write, all mappings must be changed at once, so
>> change to use a single transaction.
>>
>> Signed-off-by: John Garry <john.g.garry@oracle.com>
>> ---
>>   fs/xfs/xfs_file.c    |  5 ++++-
>>   fs/xfs/xfs_reflink.c | 45 ++++++++++++++++++++++++++++++++++++++++++++
>>   fs/xfs/xfs_reflink.h |  3 +++
>>   3 files changed, 52 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
>> index 9762fa503a41..243640fe4874 100644
>> --- a/fs/xfs/xfs_file.c
>> +++ b/fs/xfs/xfs_file.c
>> @@ -527,7 +527,10 @@ xfs_dio_write_end_io(
>>   	nofs_flag = memalloc_nofs_save();
>>   
>>   	if (flags & IOMAP_DIO_COW) {
>> -		error = xfs_reflink_end_cow(ip, offset, size);
>> +		if (iocb->ki_flags & IOCB_ATOMIC)
>> +			error = xfs_reflink_end_atomic_cow(ip, offset, size);
>> +		else
>> +			error = xfs_reflink_end_cow(ip, offset, size);
>>   		if (error)
>>   			goto out;
>>   	}
>> diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
>> index 3dab3ba900a3..d097d33dc000 100644
>> --- a/fs/xfs/xfs_reflink.c
>> +++ b/fs/xfs/xfs_reflink.c
>> @@ -986,6 +986,51 @@ xfs_reflink_end_cow(
>>   		trace_xfs_reflink_end_cow_error(ip, error, _RET_IP_);
>>   	return error;
>>   }
>> +int
>> +xfs_reflink_end_atomic_cow(
>> +	struct xfs_inode		*ip,
>> +	xfs_off_t			offset,
>> +	xfs_off_t			count)
>> +{
>> +	xfs_fileoff_t			offset_fsb;
>> +	xfs_fileoff_t			end_fsb;
>> +	int				error = 0;
>> +	struct xfs_mount		*mp = ip->i_mount;
>> +	struct xfs_trans		*tp;
>> +	unsigned int			resblks;
>> +
>> +	trace_xfs_reflink_end_cow(ip, offset, count);
>> +
>> +	offset_fsb = XFS_B_TO_FSBT(ip->i_mount, offset);
>> +	end_fsb = XFS_B_TO_FSB(ip->i_mount, offset + count);
> 
> Use @mp here instead of walking the pointer.

Yes

> 
>> +
>> +	resblks = (end_fsb - offset_fsb) *
>> +			XFS_NEXTENTADD_SPACE_RES(mp, 1, XFS_DATA_FORK);
> 
> How did you arrive at this computation? 

hmmm... you suggested this, but maybe I picked it up incorrectly :)

> The "b" parameter to
> XFS_NEXTENTADD_SPACE_RES is usually the worst case number of mappings
> that you're going to change on this file.  I think that quantity is
> (end_fsb - offset_fsb)?

Can you please check this versus what you suggested in 
https://lore.kernel.org/linux-xfs/20250206215014.GX21808@frogsfrogsfrogs/#t

> 
>> +
>> +	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_write, resblks, 0,
>> +			XFS_TRANS_RESERVE, &tp);
>> +	if (error)
>> +		return error;
>> +
>> +	xfs_ilock(ip, XFS_ILOCK_EXCL);
>> +	xfs_trans_ijoin(tp, ip, 0);
>> +
>> +	while (end_fsb > offset_fsb && !error)
>> +		error = xfs_reflink_end_cow_extent_locked(tp, ip, &offset_fsb,
>> +							end_fsb);
> 
> Overly long line, and the continuation line only needs to be indented
> two more tabs.

ok

> 
>> +
>> +	if (error) {
>> +		trace_xfs_reflink_end_cow_error(ip, error, _RET_IP_);
>> +		goto out_cancel;
>> +	}
>> +	error = xfs_trans_commit(tp);
>> +	xfs_iunlock(ip, XFS_ILOCK_EXCL);
>> +	return 0;
> 
> Why is it ok to drop @error here?  Shouldn't a transaction commit error
> should be reported to the writer thread?
>

I can fix that, as I should not ignore errors from xfs_trans_commit()

Thanks,
John

