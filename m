Return-Path: <linux-fsdevel+bounces-11546-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE4185490E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 13:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF3A31F29B7D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 12:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4DD1C290;
	Wed, 14 Feb 2024 12:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="etWxNDJF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AtuUyWH9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE0E1BDD0;
	Wed, 14 Feb 2024 12:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707913180; cv=fail; b=KJn7gn4Luic/Fm4QCE7CNI8ffmQrO3Ikzk2rXUFDrwX4V1Sw34Hy01js0yH+5uY8eAcHPBMvreWir2PcqgDQhqk8bFW5H8nG3q3QFPa9fETJ3jAaxftqOEXF7+16LOdD84/VhHvKjZvt3kXmT6qDZiUDSlyPvPwLstlbLQfbjlE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707913180; c=relaxed/simple;
	bh=stajWrNjutq3xf4F0l6XpZNSOf0VRsTutsLDVpQW1f0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JgfF+ZBPliV5tbC51vKFmJpW+IAThLtZNHf3FdXrfKWMWh3Ar81lOcwf4gLx7z94CQg5iGsDN8O6h+jTyTLm7sFyiteqxJ6FMCIG6hFxoRkrq2jOgHQl3MUCLvVVkJgNo8IrVQmp6P9a0xnBqBj5z6SrPhSuJEAdIqSen5osudc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=etWxNDJF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AtuUyWH9; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41E8iJiC005667;
	Wed, 14 Feb 2024 12:19:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=oXnyA0x7dXSbSjiNAdjHjGgzUgj50MFJEUTm7WyrVpk=;
 b=etWxNDJF35q1A6++rqwRjluGI7UgM260XLNv7Uk2llXGHW5J2Z6n2a/b2fIrqHJA+98p
 G+IMg/OAe5SSVshKZlekI9GJnSUruRnFUqnUrYcwOLLhGv57zjTcfqXdz4bWKasWkWw9
 KG34oIEk53Vje4Ymdd4MggeASXIzexJyJQt91NYx1zVyaBhoBqydIKJSUaF5waXffWEL
 0YMVa0wj+IBXqiMC+kiXRFwTMiBOfN2o+EI9gSG/6CGlXKAPdLL0e14aHkqUFFCdEMwg
 ErP3HiuNNccRDzBN7o/MyyhsSovhY0Gm/qGyqOTvwxyL64S84vqw8HmSYMPXxLewVm1t Rg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w8rtcgpnm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Feb 2024 12:19:19 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41EAjJa5015009;
	Wed, 14 Feb 2024 12:19:18 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk8v314-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Feb 2024 12:19:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gmwaFYxOLmeoRe2zzut1XabirvRwAGJtH9hx9x1s6yFxcpLzoEd+Q7JCLt/dZeuYZroNiZDJhBo2lLuPC2AllHG8gPLX59bODVD/TANyoj4RwLOV0QsIJYcEYZ6mw+3NTURTJqOcHy5Vqd5XA86cAnHiVzGOU+YcZvO/rNTQyAHBx8Lpp3SWuQKprFnJ9sVnV3KcBvtUxql+keFo+krNTotFRf3RiI0JGc6hW1d7HS/JFZfazAvb2ARSfL6jMWIequyouEH+DF7swtJB9e2jSLXPQbF5+X53mVH1mWZnJNRTOvb7/8C4ygoL8NAfxIjhF2d2swHq0KTuIW7LK3ogdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oXnyA0x7dXSbSjiNAdjHjGgzUgj50MFJEUTm7WyrVpk=;
 b=lglbvP1r608WmFUSaPGHcuxDEDgOHcHqlIW4hMHX5RqZdUKWfgzOIZTKUHGApnSV+Bg7VG33gMaLMNqkjBKawx046Bd/7l9+vH9DKvdpWwYje4inP44dEzoGaikq8uC6zYGA5O+phKrveVrGRz3VXoBWdIjo9BV2+50PXZaTB5MSedZglg+t0nw4e3TqH1cdypKvmsB7qsttr51uTsMC854get3YE80PKs8Z2/Yv7TUd+naApeMJcj2nsLCyvBKvKKsVqYWKZovdmZTzMmaBucwPtmBdHT0iNO86gxc2KF88Cm5fDdJDbSbVbFu/HSw+3A4qyJYlRjMX+rEuArv+GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oXnyA0x7dXSbSjiNAdjHjGgzUgj50MFJEUTm7WyrVpk=;
 b=AtuUyWH9DHFrvzlTpa83eLf+g+aLQvUU97tqx/+Iyx6T+0fr06d3oj4+PHQP/Lh/Xeq0ZztTvHZOMl31klr3LE6oRXwefJe2Qyw6XdlMWN79/+hKQpB+lrXe4Xlr2k+cGOU6U5jC6elRw2EJGP6Z6ah6QW2ds/QL5D2Z7m10uTs=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ0PR10MB4798.namprd10.prod.outlook.com (2603:10b6:a03:2df::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.28; Wed, 14 Feb
 2024 12:19:15 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4%4]) with mapi id 15.20.7292.026; Wed, 14 Feb 2024
 12:19:15 +0000
Message-ID: <c0c44bc1-758c-4690-a6e3-d3424dfa7172@oracle.com>
Date: Wed, 14 Feb 2024 12:19:11 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] fs: xfs: Support FS_XFLAG_ATOMICWRITES for rtvol
Content-Language: en-US
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: hch@lst.de, viro@zeniv.linux.org.uk, brauner@kernel.org,
        dchinner@redhat.com, jack@suse.cz, chandan.babu@oracle.com,
        martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com
References: <20240124142645.9334-1-john.g.garry@oracle.com>
 <20240124142645.9334-4-john.g.garry@oracle.com>
 <20240202175225.GH6184@frogsfrogsfrogs>
 <7330574a-edc5-4585-8f1a-367871271786@oracle.com>
 <20240213172205.GA6184@frogsfrogsfrogs>
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240213172205.GA6184@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0018.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::11) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ0PR10MB4798:EE_
X-MS-Office365-Filtering-Correlation-Id: 767d82ab-145e-4381-b12e-08dc2d572935
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	zkVx/Nr4/kSTMLMqgjICYvAQinECkt21pxsHIolcUe/sQE4qOaV+asJpADVUATTTa88U9ILhCpo7Y9UBSC13KXy+NcX+gGL+ukuKSYjHWjCxMi+hnxZ5cCEdLiCeHk8N7Cn8c8PGe4byzSptSeREMOBoJBH0LDI1//EP8ZzGwrV5KefwNjd0GU3r1HRocnNcx7EyRlfNpTZuxDZeeAgkKx6uNDrPPMitpoCBUbJTBc41YOim5mYOzcBHNQuvu4JLa4qj6PbVjnFKDIkQPXHILaeto/tfY0NCSG54YEDa3zpb3yQATXlulFsyAe6nfHknPtyw1w5fzw8UcC8Ymu1QAYjXUQwBLQ8iJtdvdJqjEwZb9IRdf4zkUvH8VTHIa/2GClVQI4+bivaEvm2Tm3prHL1jgjcz+g6aXnh+Pvlpyau8hPYQoBgdm6HNmtffLC00fHISYc35uw+FC9JrcClmWJPJKb/dPE/Okot6AwpCTRAwZHpcoHmsrXSWlCr27ue2kcuM2GocgRBgo8YOxRP/kJaT7MH3a9ipyTUPaRuXg8lUJ7zkB8KyINhRziU0ktYI
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(376002)(346002)(136003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(7416002)(5660300002)(4326008)(8676002)(8936002)(66946007)(6916009)(66476007)(2906002)(66556008)(83380400001)(26005)(36756003)(31696002)(86362001)(38100700002)(316002)(6666004)(41300700001)(2616005)(478600001)(53546011)(36916002)(6506007)(6512007)(6486002)(31686004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eHlYVGdlQldIZWhiOXhsYlZXTmRuM1NaYXlFNWpjdVJqa25kTWd3Y3NNZTUz?=
 =?utf-8?B?SEVURHN4Y0JEVmJBWFhiOER3czljSXZxRmN5eDNNN0hBc2d3VDhyaWQ0TERF?=
 =?utf-8?B?aW5oMlpuQktNdXp1RWVsUGprYkMxSWFCcnlLbTU2dnJEMlcwdTR4ZXhVTzN3?=
 =?utf-8?B?cWxQTC8yREg2YjY0MHJOMDVRcTJlQ0ZhSG8wRVplUzZucE80RlpWZ2toT0l4?=
 =?utf-8?B?VXpaejJ6Tk04blpJamxmdHhoZm1CcjVzUmZTT0xSWTRkWk5lcWpwck50TE9Z?=
 =?utf-8?B?dDQycHBwVWZVVkc2eEVVM2RXT1JRanlpeXdyazBlUTlKK3VkTGFXWmhpOUla?=
 =?utf-8?B?QWw3emFFaWhtRjRQZ1c0eWtvWFA3U21CM2VoeXppK0VmZzJGeEhuRFRkQTFk?=
 =?utf-8?B?dTZsTFo1dzBOV3RML3N1OWZ5bnRqVzQwUyt2Q0JxTFNtUU9KcXNacWNXN0NC?=
 =?utf-8?B?RmQvdzJKQlpLaE5kQTFTYXZDQVBVUlpvSjRjc2lmZm11ek9tckowRjFseEdR?=
 =?utf-8?B?cVQzSkFpbnFkQkx2bTJ1cG05akpUMnVuTEo0Y3huTmowaUJsTlhvNlN0M0JG?=
 =?utf-8?B?QVBNSGpIbHVDM3BSeEhPUzB3aW9hRXZsZUI1OHppbVdNVldydE9VTnBwcldR?=
 =?utf-8?B?ZzFVU1FKdDJYNW9UVDV3Zkg3WW4rYXdFd0xpZVlHVWpDTzhKdWhsaVJDMUo5?=
 =?utf-8?B?bW5Kc3BFVnlyKzZDQ0xwa3FySGZaV2hLME9MUElLcGlyZnZuK2pDZFpsQUhY?=
 =?utf-8?B?YU11L0FibnljOGl5L21nU1lHRFNrMHVKOTdpQ1FRdW5HMmNRNzF0TitpTURR?=
 =?utf-8?B?NE55d05vNDB5QkZkVGdvSmFUY1NuZ1RnU1BLdjM4b2xOZVFveUt2VmcxS0N1?=
 =?utf-8?B?akxoYk80NGJKNGVtZnJobDQ1WGdiT3kzVHFvM1RFWVRWOWxkNmFvb3k1aStC?=
 =?utf-8?B?VG9YQlZjaThJMC8vNllyN3RBRVRLWFlyVXhtYUdsRkk1Nm9XbEhWc0ZSbEZD?=
 =?utf-8?B?YmIrUnFoMTQwMjdSNE5vTUpMZ2psbTRwZ1p6a25QQ2JpS3JmRjFncFk4Y2pk?=
 =?utf-8?B?SDY2SE5xWEVEZmhPSnljYThJNUs5YXAwYzNTTWY0d21GUnYzZ3ZlRnFvZjd5?=
 =?utf-8?B?UHhGeTJSc2lZYlhPandBMGhrNHpXRm1sb2E0dVpyV1REcTBhQnFia2gvNkNM?=
 =?utf-8?B?dFVaSlgzOHZpRitTZ0tmUGo1ZzBYY1BleVVZR1NpVGliTWdJMW1HS3M4ZU92?=
 =?utf-8?B?M2tYb3FNZ2twYngwL1BRSTgzb1M0K2RxRlNjc252S0x6Y2d2SUViY21CNWJk?=
 =?utf-8?B?cUprTFRGcW1sYWNPNnZMWUxrN0ZrQW1FM2QwdTRsb282Yi9WdVZ2amZ3b2Nv?=
 =?utf-8?B?MFdrbnRqaEwzbUJpZWN5aCtGTkJxWitranRFdFN2TFB6VzVvMVNDMEJrQ01k?=
 =?utf-8?B?b0lJdU14QkRBc0ErbXpGdE8rdDhnL01BTkpOVzFoSGRiaU84Q3dOcFoyUkFD?=
 =?utf-8?B?MHNGNU9wQjdBTmN1dCtwMnFDRmNWT3pXd1lYK0h1TEZHczFUK01SbW12NFRl?=
 =?utf-8?B?UGgxZVdxVW5OZFlmYUdIR0VXYzFBL0gyZzRWQkdKaXFMSytFNVBvYnJXdThm?=
 =?utf-8?B?cFd6aXR0WE11czAyV0I1S3lpcUpLWkppbk1DRERpZ0Y0MXo1WldtOEMxbGhU?=
 =?utf-8?B?aHJ4TjVSV0tHb3c4MVRNZGVoR2VrOVpGMzFHNlJHSlVKdDZjTytxNXJoNXdv?=
 =?utf-8?B?bW90S3llODZ0aHdQbHkweVlFZVBHL09Uc0lWSGRWRHZ0K3JLT0xiWTFzQkND?=
 =?utf-8?B?MXZieXFMTEhpeDBiZGtBcm1JRTIvQW1OV01NOXBWQmZHMDVaUUhUU1U5VWYr?=
 =?utf-8?B?L2hvRUpHMGRkcUJOQjhOV01hWFJKcG5Va3pTcG14VkVGRWxnWUdaQzlsSDdj?=
 =?utf-8?B?Mm9XN2tBbXZHTUhOSTFUOExuSkw2OUFzRlZtRFpWajd2MDFwbnNCdXhpd3dM?=
 =?utf-8?B?SlRDbU5mUDh1Njhma29weEY5TG1xZk43eUljYk91M1lCVUZvWFRwNlJYSzk5?=
 =?utf-8?B?K0ovekI1T3h5S2lBeUo0K0Q4N1R5SzJMbklKTGd6TG9QYmhxNEhCT2IwTzF3?=
 =?utf-8?Q?jY//RinYqXvEdpKD7jnSJp4Cb?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Bum3yiLD9ROhew8+FOaim6T+LkcdR36UUXSrAdnEbmziXy4gB4arg38M+UebMSeWjBy6ieEtO7Pp3IoBYFGE9h4Vb6i2NKGniEBomyeNUXDzqJLY/3QVPfE0N82As2ti0PEtY/HxD+0So83bB3fHY2UUkdVueCIOSNLESRLkjImCyslpcX69XH7RU7YJ0DC2SvTNUzDe13L/fgq+uAu/JJLUMPIKyOjsuuqNCyNzwgZWmj3RHWGMI72ccieIeYb6ix4Jkzone2CRYJhi4+wzOhc14nF/IibgOwOPCgsj9zg2Fb+pcNh0sjypKp12T3/W4dDpkZKok1xiWW8MjI9avB+iGlJVpaXI9gs5Jozy2IfQ/bIwuAqSAAnoX/+N0bgUbqTiWqBc0Yx8MiQIEEkD113xkXa4RLd8tW3XtJeckTl7vf5UMPHk9L0xW+Nrhum3lmNs0oIJImGgmgKKVPUXkJwr+U2rhkt6sLPWmsBXtOKLaxbAy7jFLT1/syEv3VSUMkBc1Th/7sgvCQeB+Xa2oSb9uxzgAPEgvFCQoPqoTXSy/Q+cURFEQPfLRXhGcoylViSNJNbg/PZianqy0Q3oexTQ3WXLAFgfssefbXNYiQw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 767d82ab-145e-4381-b12e-08dc2d572935
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 12:19:15.8813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pXWi62LYT0ibNct29EVbiQQ0OIqH9W04plGAApzme12fg9ntpmbYcxfw3pd0+Q2asQT7ifPUdsgALpT3yMRnzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4798
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_04,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 phishscore=0 adultscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402140096
X-Proofpoint-ORIG-GUID: hBGKTxn769fYQP6aMYHgwio6Pss_brZd
X-Proofpoint-GUID: hBGKTxn769fYQP6aMYHgwio6Pss_brZd

On 13/02/2024 17:22, Darrick J. Wong wrote:
>> I am not sure what bdev_validate_atomic_write() would even do. If
>> sb_rextsize exceeded the bdev atomic write unit max, then we just cap
>> reported atomic write unit max in statx to that which the bdev reports and
>> vice-versa.
>>
>> And didn't we previously have a concern that it is possible to change the
>> geometry of the device?
> The thing is, I don't want this logic:
> 
> 	if (!is_power_of_2(mp->m_sb.sb_rextsize))
> 		/* fail */

This is really specific to XFS. Let's see where all this alignment stuff 
goes before trying to unify all these checks.

> 
> to be open-coded inside xfs.  I'd rather have a standard bdev_* helper
> that every filesystem can call, so we don't end up with more generic
> code copy-pasted all over the codebase.
> 
> The awkward part (for me) is the naming, since filesystems usually don't
> have to check with the block layer about their units of space allocation.
> 
> /*
>   * Ensure that a file space allocation unit is congruent with the atomic
>   * write unit capabilities of supported block devices.
>   */
> static inline bool bdev_validate_atomic_write_allocunit(unsigned au)
> {
> 	return is_power_of_2(au);
> }
> 
> 	if (!bdev_validate_atomic_write_allocunit(mp->m-sb.sb_rextsize))
> 		return -EINVAL;

As above, I can try to unify, but this alignment stuff is a bit up in 
the air at the moment.

Thanks,
John


