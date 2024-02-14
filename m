Return-Path: <linux-fsdevel+bounces-11545-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A0C8548FA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 13:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10C1C28182C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 12:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770151B966;
	Wed, 14 Feb 2024 12:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="giJaR+Oq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="i8gdw5Xp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF96F1B5AA;
	Wed, 14 Feb 2024 12:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707912841; cv=fail; b=HjnENPurYemMCkAEs/mkHBBE6thUQhx9vabOiAkUD7yVh3Dr/niFFaT2ycVlCobuPhbbe4A+mvSp9tanWYrlSKfSYnVggI+ij2NIsge1e8eoi8QAR71cJuoAdCdU/4r0Ue61uY6gwpQTvvi1Ya/KiNiLL6/NY7hniBWWyN0p4MA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707912841; c=relaxed/simple;
	bh=LaqSJ2pLp9oeZ8c1MxNFSPTweeRYgo/l2ncr/lB86Ls=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oMPV14Jzl688C8DiqRwzqvbsWLJj7pcg2/QZyWc/KkyjDWSZMoD4wUsNHSfHiQ+xfQQh6vp9iMEhKOwAnIoiKNkDAoy4mKGN7P4zwyZsWmEh8LJ7UJmJ9xP+3PxXfHC39c+jN+O7RUQe3yvQl+pATjve1BHzdRqL1dpKXSUq77I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=giJaR+Oq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=i8gdw5Xp; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41EAZXgZ008755;
	Wed, 14 Feb 2024 12:13:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=9JjzVNjuDwCXahYXsVXVrgNAIGh+G3t19iXyY1HYcFA=;
 b=giJaR+OqdGO2FbXC8MoUOAm5l3DxdLR21R/VFV7Czx74pKM7ulNhsv0LFBNY5ryReIYE
 MRHpxC6k9HwiMjbuNJ6Ja1UvgvyQBqH/UJMEtU24LYfz+rA1LFPRMNF3t8MOj4lED1Ea
 b8/38G8Ja8LgCPEr/YOXYfx8u73sT8YGQFYHnaQu0o/Y560OJjzUFx81v6vjWS0eiCuu
 DDLClaq+4jrmUyhWlVLxHKtqPp6Y92DrAwp2WBTL8+oL78iv970GITLsPkh2rzdQVGv0
 KPtd28U5J1WV0J/0oN/8z8yK65xyyLcNO+sdydOz9ztTZIJG0iaO/3+EhQ3vp5uBmSwm Ig== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w8uvyr6s1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Feb 2024 12:13:34 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41EBdJlP024563;
	Wed, 14 Feb 2024 12:13:33 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5ykf4yh7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Feb 2024 12:13:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZIq5enQo1lTC26/BYbvHDYoij9SnRL+JGF3UlodK2jTARq+iyvP7i8sCOhnyPLWCfKUU9BKsNJlLUE2oBotr1spf90dYwelBfz04JU5WkQX1Alsx3PRl7qzqO1ZBMlNgCuNpQQlAV74d0oXhqkNwgE/Gs54MwHC9F9s07Bm26YF8nv4gmBQBE8uO+3wfgNWl75mJ5HAlI4lgnzPytgZQzHn1hn4usGrylYPBeBVvz7fpbEnw1p0iq+HCEnDVHZ1WhrkiLsKkIg75kpaUWeXVG4VTEy0jY9kuM/OIX+yAIWBN0a3K3DCtP2eOPpbzVhhmJ3MhrRFBf4/9KhpJDa8j0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9JjzVNjuDwCXahYXsVXVrgNAIGh+G3t19iXyY1HYcFA=;
 b=ItCLc9Dcd3XUdtoeqnBob0cWHhXFjRJ0ubWxdWQl29hGgwCxa7L124Pxr2HlYNeL6AU9Imfnhipsu/PfKMExs9oLrfKnff7e3AX6/vz3sT0ONAOyB85Qem2paiI1W3PVjjR2BPE5g5IpZb4oyPSoe4xo/OIucXfwiXtsWAO7b3R9CaKwtnhYn1I0H7Yccv+puIPb1/WOJcht10pOUUymwsgZmLMISf52XA/iVpsOTjY5QH8cK3arcuCuNlp1lUVOUsDVq2/Hf4vlWPyddF97MkTpZqELbLP059IPjEwvc9tSYHlVH/21qvKiuAa7+ta3aWrPsQ2D/OBDLtWFkqQifQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9JjzVNjuDwCXahYXsVXVrgNAIGh+G3t19iXyY1HYcFA=;
 b=i8gdw5Xpk6OBxejP2MoYxjNzkWAZe52wjo9dor7Rq5V7lRKbj0zZODtANn4TB5JAsQOu+FmT3WcUy6rDvW27wFul/U20H4gMvRgxDEB7L3UzTMBdW8gAlyIWO+PwDmE9K3p/TqMjkbPtHF81kxwLYwaCEHYyGPkyv2bDUMymkUY=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM6PR10MB4393.namprd10.prod.outlook.com (2603:10b6:5:223::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.40; Wed, 14 Feb
 2024 12:13:31 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4%4]) with mapi id 15.20.7292.026; Wed, 14 Feb 2024
 12:13:31 +0000
Message-ID: <a1876205-5473-4f44-9439-a7b3c534be4d@oracle.com>
Date: Wed, 14 Feb 2024 12:13:25 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 5/6] fs: xfs: iomap atomic write support
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: hch@lst.de, viro@zeniv.linux.org.uk, brauner@kernel.org,
        dchinner@redhat.com, jack@suse.cz, chandan.babu@oracle.com,
        martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com
References: <20240124142645.9334-1-john.g.garry@oracle.com>
 <20240124142645.9334-6-john.g.garry@oracle.com>
 <20240202184758.GA6226@frogsfrogsfrogs>
 <e61cf382-66bd-4091-b49c-afbb5ce67d8f@oracle.com>
 <20240213175030.GC6184@frogsfrogsfrogs>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240213175030.GC6184@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P250CA0022.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e3::12) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM6PR10MB4393:EE_
X-MS-Office365-Filtering-Correlation-Id: 3489631e-d6ea-41b8-91c6-08dc2d565bf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	8p8W4F6jbvhHl8jH4dS0kKTlkazj7u4eSrJsWvQ2d+dkWEqq6m0rRoIHsGIbHjv29bUPImSKqbjFkhiLgH9UizxYjdSl06xUtyBDgGE/zasWXyOFhZKmv0mFJod7euZ8xgb62qasS2ryYkzKh4Lq1pwACLjBoAnb0WjgI7g4VAljwqyfMTqlsk0U+ZYT7pBXBQR2GSFBriDzS5K/76aRx66Msemx6Q1Lcw+T28hf90eMlYjg5ZGwpt01aBxIsJtfbu6tMLtceHzdlqL87Vq7emIy+ih9Uf6KR1y2KYLN+emnG0kJLj3oRZpsZnr+vKsY4inuHnfXh9Dv06FFTRAak/dQzwj4+7Fk9IitSm9OuaseT4rz17074oq061U878sB2tfMnjR3ng4JZYsgQeKadjzFp861GGrO3MAx65bZbeyf/SaKlal6csH8EwJb5eVJYPFWOvRsTG90W5Blcb8HJOKadtUnOLDvVQhMsVxb0KWmCgxpS6baJ5/LOy0B7JuexlcTle3wvIARJfe8unYA7gdwenvJCye9uYSpbgA+C3kakcqKarn27+ZoAz2gybZm
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(39860400002)(346002)(366004)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(7416002)(8676002)(8936002)(66476007)(66556008)(66946007)(5660300002)(2906002)(6916009)(4326008)(36756003)(31696002)(86362001)(83380400001)(38100700002)(316002)(478600001)(36916002)(6506007)(6666004)(6512007)(6486002)(26005)(2616005)(41300700001)(31686004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Ujc0NE8zT0UrZ1FqQW5zVWUyZEhkWHhPanRyZStuSkowSUg2R044Vjg2Z3Rq?=
 =?utf-8?B?aE9XZ3pGMGZjUXJVcnNZVmFFWUdXeVl2eUNPQzc3UlAxRVd3NUNzNnBtMExL?=
 =?utf-8?B?SnJuSExremNSd2RQSFJGdVp3TFJDWVRUQXV0U2Z5N0wwbytZUGtiZXlhM1J1?=
 =?utf-8?B?bjh0S0FKSXNGaytMYWkvMHU2RGJUTFQ5QjJDdmJodmk1dzVYNUFyZmpNUDJs?=
 =?utf-8?B?K0FtTTJmVzUva2wvRHFkZUVxSTZUZ0tXVmNNaG9temg3RGtFT0Y3VlhieFY5?=
 =?utf-8?B?WmpqeU44NTRVeG5tajdEazlPbjdwUDZ0N3laRHN4N0p6STlEejNsR3J2Y2kz?=
 =?utf-8?B?Ukc5ejEwQjhHeG13aTBoQVg4V21DaXkvdWx5VFN0NklYaG1RVTNqZE80RjRx?=
 =?utf-8?B?cVRaS2V2eFJLbnRyaGc0QUhwTWE1YzhuTlJxQTk0MWh1TDlkZHBobkpGb1ZO?=
 =?utf-8?B?K3ZLZlpQalN1Y3hzZVBLRmZTNG9jWlg5SkgxMzB5YkZDMktJZG9qVWVHbzUz?=
 =?utf-8?B?cmIzY0M5UTNlTkNlenJMTmZNNFlXNXg5RXZLVmdBelFRS25oUUZtcndoSWZr?=
 =?utf-8?B?OW9ZdWdlOUFCeU5VcGhPRXJzeFJOakV3UzgyQ0hKSDNiS3FsTmd0L1pvRGFF?=
 =?utf-8?B?NXBkWklnM09qRkYzbHlia0lTcGFvN1hmNXBkNnc1TmZoaXBzRU11NnRYaGI5?=
 =?utf-8?B?WHN0RG1JM0RjVExLcnJnak5CNVNzVTAvTGlDNXY1SzFPZlNYMjJjTTNtVytE?=
 =?utf-8?B?NzdPR0ZvdEZ4dWc5T2RJRHlQOVUybENqMnV4dHA1Sks3bGJMQjV3WmRTVzVv?=
 =?utf-8?B?bWxqbEJOd2xDQU1IYVo2ZHNVdmFybnJBRGl4aFpmazlybTlQYUdXaDZCTGlx?=
 =?utf-8?B?NFlEeTkzUkNENEEvYk1Qb3NsNjdTSG51RVNybFZyZTZlZ1IremRJU0F5VmJZ?=
 =?utf-8?B?bzFVU1d2YWN5TGpUUHBNcVJnaVM0UG5xN21WL2RKU1AyNHBtY0pGWW5uVG1Y?=
 =?utf-8?B?ZXJFM216RWhSbHFSRnM0YXdGcVd5Skd6ZlJEdzUzSDRLbUhYQ1laZVo0NzRZ?=
 =?utf-8?B?ZjZLenZ2aUcxZWxJZnJsRm5UajRrWkhPUmQxRjZiYWtBeHJMN25ZOElnait4?=
 =?utf-8?B?U1FLUGEveC9BV3hrSjBSK21oK08xOXJyOVBSbzBPQlgwQ1MwUHdHZkZIQWQ1?=
 =?utf-8?B?Y2t5K2VvQ0VJWWRqTTI3Q1BsT3BpRm8vQ3Q2NTN0QmkrblpxVlRBcGYxeDBL?=
 =?utf-8?B?TGluYllOVFBlaDN4cG1BVjVPelBFM0VWZkp0Nys4blN1Z1lVVmQ3UlZraDBv?=
 =?utf-8?B?aVBIRjl4TjRScGw4aHV2dk82TlMwenBYZFFoT3ArRkUzT3JrYnRienR6OWVS?=
 =?utf-8?B?YWN5TzdsVHRNdkNQN1QwQTlwNmdJTk44aVVvYnZLaGtXV0JnYnNOajBpVElI?=
 =?utf-8?B?SmZRYmpsZUxkYzJwMHpuMit2VkFsME9jeWVFZTFXUmFVeGNBRTN2TnJXTXBK?=
 =?utf-8?B?RXNpdy9GSlc4d255M3I0MkdNZUFkenJ1RTZIVDF0bmFDai9aU09SVWtTL1Zj?=
 =?utf-8?B?V1ErbWR5SmJWZ0FDbW9vRi9PbHU2dDJzSzhTaUFRclZLQ1lFNE0vK01HdVFD?=
 =?utf-8?B?aS9JeVZUemxoTnF5cGdnZXFZaGZyWXBqbExrNU5pUGJiY0RUaDgzNjVrdWcz?=
 =?utf-8?B?T2NGNjlIOUV0ZTUwMjVwZHBNQU5uTFpMV3NqazFhOGc1emlKYWlDMGlxMnpE?=
 =?utf-8?B?b1pHVnU2ZGdVMlN5bGlIOEVPS1VPNjRGa2dRQzgyUFVtL3lkeGJ1WFVNU3NG?=
 =?utf-8?B?OVhTMFN5TStROTJEMkVHN3p3bGZOb1ArR05EUi94elRBZDBxUVhST1o5akIx?=
 =?utf-8?B?djRpcGtpWDQwdEduRFdXKzVQUG8vdEpSY21XNk5SV2lXdkluNVN4VlRDNVZp?=
 =?utf-8?B?RzBLZGt6eUVCOWxJdXRXQjFrb0paV25vdkFIUzJjSlJ2a1dmaDJWS1liNmVt?=
 =?utf-8?B?U2VxWWRSeStzWUFpdHJRejF0cUxWYXIweThZVVg4VHFock9oM0lueXlnZUpT?=
 =?utf-8?B?Z05YdmMrVUVuVFdYR3pwT3IvbmovS05rdDVpNnRYSHlucDBoMEdnd3dmMGhx?=
 =?utf-8?B?Sm1pWjcyaERkUU5HUjRoUmVyLzhKRjJyWE92dzN0YnVtWTUyeGt2RkJNdmln?=
 =?utf-8?B?NUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	/Fm6WI1A/lkesP0MuK3z63NgXl1BKsqn6K4dK3mG6Vub2PAApRxWgJthoJmS//I3YNPFV+0aIQMUAJMq3osu9c7diUYxPjH+3ss/MhIpV5q6GPiQY1iHTIJrLdt9x9DoyCEI21tSq5MUOT7a3R0Ppp5qoKCUb9JzDoFGNnfQE33a6B8SEmhBwVQuurQ+pOupQfU0IUh3MMosUIkzwzoUw94L8MKLofYZJgWuG593GqC65Rs+X6WScBeNS8JajOywP23BkQmB7a4boWAlgl0DjVpZGgOhB01KMQMvTT1jMVxWGJvm9Nt+hLGLDewBvNpWiJzYQ+7YPooicHXSfekUVkSYIzNsOk8lpJ7uQLK9fREp4HO7j3PI1RE6v41TGRq7QMpLdgi8B6wJ1oarASw6zwL9NabkRSP/oULTXahvOArz/F8E/NDqi9RUz0pegILksYUUYaqEMmLj+cC370XVPXV9JFoii8HOf2BcKAw9Dv2CwCAXzPsSpipIuOLInt/QhlWihMR8gktaI97XiNbYZ6aFkmYKbRrqpq71qwWO/mr51Gu1V1xeC4MQy57WD8MHdeLRff6OO5vE/mpt8D29c+2iJLkD/TNjS3HvBJ6sl18=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3489631e-d6ea-41b8-91c6-08dc2d565bf4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 12:13:31.4924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2lSyFrx3k3JQPPqR+HTRDa4cFHjFO886cXpRQKHioqQslURoTTrTKyZqPtYlz1AkPcrXfoYA4npXD52IdCxAlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4393
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_04,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402140096
X-Proofpoint-ORIG-GUID: 7WlmiLv0XSc_W2pl7N3znUSx_YaViRem
X-Proofpoint-GUID: 7WlmiLv0XSc_W2pl7N3znUSx_YaViRem


>>>
>>> Not sure why we care about the file position, it's br_startblock that
>>> gets passed into the bio, not br_startoff.
>>
>> We just want to ensure that the length of the write is valid w.r.t. to the
>> offset within the extent, and br_startoff would be the offset within the
>> aligned extent.
> 
> Yes, I understand what br_startoff is, but this doesn't help me
> understand why this code is necessary.  Let's say you have a device that
> supports untorn writes of 16k in length provided the LBA of the write
> command is also aligned to 16k, and the fs has 4k blocks.
> 
> Userspace issues an 16k untorn write at offset 13k in the file, and gets
> this mapping:
> 
> [startoff: 13k, startblock: 16k, blockcount: 16k]
> 
> Why should this IO be rejected? 

It's rejected as it does not follow the rules.

> The physical space extent satisfies the
> alignment requirements of the underlying device, and the logical file
> space extent does not need aligning at all.

Sure. In this case, we can produce a single BIO and the underlying HW 
may be able to handle this atomically.

The point really is that we want a consistent userspace experience. We 
say that the write 'must' be naturally aligned, not 'should' be.

It's not really useful to the user if sometimes a write passes and 
sometimes it fails by chance of how the extents happen to be laid out.

Furthermore, in this case, what should the user do if this write at 13K 
offset fails as the 16K of data straddles 2x extents? They asked for 16K 
written at offset 13K and they want it done atomically - there is 
nothing which the FS can do to help. If they don't really need 16K 
written atomically, then better just do a regular write, or write 
individual chunks atomically.

Thanks,
John

