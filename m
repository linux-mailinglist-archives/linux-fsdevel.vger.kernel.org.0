Return-Path: <linux-fsdevel+bounces-2409-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 167667E5CE4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 19:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65A7EB20DBC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 18:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6726834CEB;
	Wed,  8 Nov 2023 18:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mUsiVsvi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0915C32C78;
	Wed,  8 Nov 2023 18:10:03 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85566186;
	Wed,  8 Nov 2023 10:10:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S61qV+QrVRM83eIfyOKmZKWFf9eaaXDQ6whCDPq6Jhkc/wrTZuxCvs5NkkBt82Z8+w+Uh992rvIMBfQTvJ1dXnwLWMDQlQO1FdPnNg2Jtekb83/gSpPXquPVeFSdzvLn6MBfF4lC80pP18cK/u+X9AN8pLy+Q2z2yCnDTcNa8mNtHaMZ+sZvKT3POAK+ESyEnsXNQMxTLFGiXU9aUyAoGgKEY0NIjKzxPYx1ecdp1VT+CVq1BJoEDffthTS0jXHD7PcYf4xj1XyfyX/tX3Td68FvgCosYhj/skMh22qrd7eTitq8SiQ20hpGcgsZMHcYd4HP7UF/n2oswz9+Z4eSHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7r5/jafKHoNzdHagWNmzPyoHXNDDZ4fRLDCEYPikYvQ=;
 b=eHi2rNoGTcbjyq0I9nZ5yLUl+E04rMDJVY9grywX0bEllWIl/L8tvVxlhR7l3jA1VtCSmbRXKbvJFoBJVdfCKBLpbUrqZED/nOcGzqj8i4Kps5Q8UPgBbTWXQMrvDzaHupJu/t1a5KtDg0BxVSyjMAw9mnu7pXeSPiR1+16PQaIbp8Uc+f/qvjTBEVWezm9uT71T18HKEyNyPPq7RAyKptmaMFpiD/2A37/2/RzXgtsLksH6jCFOFPUo5xwTEv/6uvUy2O0ilFOSEMH0yytFoirlc8vYuxqxO+1IBJpisRvSnZ++VhnoAq0isrFAhkFdh/I4QOpplFPcp3WUUU0wmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7r5/jafKHoNzdHagWNmzPyoHXNDDZ4fRLDCEYPikYvQ=;
 b=mUsiVsvinr8kIaSTDSp45Nziy5EbodOTsGMO2k4WlbSSfPTDaJBQxaFFY0fsBkI4QHF82qRYvP5CNsrlzjK4LLGOWgeCDnnoAM7vOJVY7bNp3iDQXoIAkBoAHjFbRk0RQGzzbxwnjcA9vKta4di5i98PSRHf4JgQWTI/z0OtGIc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8403.namprd12.prod.outlook.com (2603:10b6:610:133::14)
 by PH7PR12MB7986.namprd12.prod.outlook.com (2603:10b6:510:27d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.25; Wed, 8 Nov
 2023 18:09:59 +0000
Received: from CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::51d7:e9ef:b57b:f4f2]) by CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::51d7:e9ef:b57b:f4f2%3]) with mapi id 15.20.6954.028; Wed, 8 Nov 2023
 18:09:59 +0000
Message-ID: <c93e924f-dc0e-4114-b0a1-3e3ed360a37d@amd.com>
Date: Wed, 8 Nov 2023 12:09:55 -0600
User-Agent: Mozilla Thunderbird
Subject: [RESEND v5 2/4] fs: debugfs: Add write functionality to debugfs blobs
Content-Language: en-US
To: "Luck, Tony" <tony.luck@intel.com>, Avadhut Naik <avadhut.naik@amd.com>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Cc: "rafael@kernel.org" <rafael@kernel.org>, "lenb@kernel.org"
 <lenb@kernel.org>, "james.morse@arm.com" <james.morse@arm.com>,
 "bp@alien8.de" <bp@alien8.de>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "alexey.kardashevskiy@amd.com" <alexey.kardashevskiy@amd.com>,
 "yazen.ghannam@amd.com" <yazen.ghannam@amd.com>
References: <20231107213647.1405493-1-avadhut.naik@amd.com>
 <20231107213647.1405493-3-avadhut.naik@amd.com>
 <SJ1PR11MB608345F0C62627E7A0520449FCA9A@SJ1PR11MB6083.namprd11.prod.outlook.com>
From: Avadhut Naik <avadnaik@amd.com>
In-Reply-To: <SJ1PR11MB608345F0C62627E7A0520449FCA9A@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0158.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::18) To CH3PR12MB8403.namprd12.prod.outlook.com
 (2603:10b6:610:133::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8403:EE_|PH7PR12MB7986:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b6e2cbe-81b8-49e4-3b10-08dbe085eb6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pVIae/jgqt0whQE4YBsoFs/J8SP5Mn0mVmnQ4SzS5rJOi/DCja5Uof/ZeyZkmU6/Uzc1rSKicwY1SZONLXdMr2Ud6SfaVoVOQCvz5W6EO7yb3r08O8pD0qtWca/XR4fU+vzf3w/JchlKe2x0gjfBZjbcMXzpi7hd07K9h+PkH5kTKqppcGK3lTMgprAcNsrlf0rTJDWjK4hAh9g/e5SgktEtxmtA8mtNoSB5rmFrTMDMY6scpDOR9abCKCAetN7CKZjASbbx9e+a4elf0pVS7U11oljwHCRendluWPYjBoNFwXKVBtqc+xj7/rt0vGnnSjhkiRCGCQBnvJGBVayldt+a4jciadCN+c0e62G8P6Jk8XmFZJybBiy8A8b+5mDuHQAUwp7yS7fXosLSvECRbu1rUuLaJnwFk2l6xTcDByKpIFGxBaxvlKxG4pL7M1jNVmZKLva+zRFLQ87oSxiYhPIMlLGZBa97tIJ3m/EfQ2BzuF1Z76QStT1nK9OHDTEuu3Dvxf85dDj/BMSYzFbST1elM/GOvyabbfDSj4ynV7SuBgaSBlSX7bqa9WQF8EEQ+m91Z1aR48aeFog0Jv1/7gMVnCe5uFlOPe3z7EVLdt29M4WD1lhkHV1BIBo1IJjgE6SSL6gaju0Cdx1SnaEdbw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8403.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(136003)(396003)(376002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(2616005)(6506007)(6486002)(6666004)(6512007)(478600001)(66946007)(4744005)(5660300002)(2906002)(316002)(110136005)(8676002)(66556008)(66476007)(4326008)(8936002)(36756003)(53546011)(38100700002)(31696002)(54906003)(41300700001)(26005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QndReThJWWsxTkN3T1phVzZNcWRUVVhlMmM1ejc3ZGp4V3R4OTloVFA1Ykcz?=
 =?utf-8?B?bWx5RUIraS9sYWM4d1RXOHF5eTgvalkxcVROaVZndGJ1OTgvZDJCZENGVzVN?=
 =?utf-8?B?TUhrYXBQdlFvZHNQQlBNUjAzek42UzJZZWsydUVTNndxc1hHUXZSMlFNYTVF?=
 =?utf-8?B?VTJTYUFEbjFMOEpoT0xyT09aRnQxa2wyTTlCd0QxOG5CNzBpYXVUajBkYkJl?=
 =?utf-8?B?a0VLUzcyS0xWakIreEh6MUZBMDRSV0RXd254Qmt4Yk5wV2xXbU5zVEpyTys1?=
 =?utf-8?B?TnppVTBkaVdCWjNnWHZ1TXJCVERJRktMWkVEK3dKR0ZUME9iMTFvNWVhWitX?=
 =?utf-8?B?TzdndzNnclZXL0tFVUVvSitxRDRzTmo3NWNCWXgzZllFUmFxcENKZFFrVERz?=
 =?utf-8?B?Z3ZoQkh4bXJJZW0vQldQM3pncUVPUFNjM0RIaXo3bURSdWtaL1Q2VVVCU2dt?=
 =?utf-8?B?Q0Z5RFJLRmJWSHBlQ0hwVVJ3a2R0SXpCZzFhcitURC9YYnRhRW8yK0ZpV2ZO?=
 =?utf-8?B?b1owQm9mcW9NWEs2TVEzOFEzUTliT0VTQkE4NDNFbEdpRHFVQlVDenc3aFpN?=
 =?utf-8?B?cTJWQUZrZWhjb2E4RFlHVCsvKys2OTFhS3NlbFVEUDE4NDRXczJzV3AzOWhw?=
 =?utf-8?B?WXVJd3JxclFxVjVTNGF4SGMxRjhMUU1WMjRNOG1mUnBHYTlXNS9JMHQzc1h6?=
 =?utf-8?B?emJ6Vkg2VUwzanZjM3R4bE1EOTNTeGFSbFlQZllhVG5NSDJ2RVREMzk0bHpy?=
 =?utf-8?B?QmpGNGVWdmhha2EvR1RyNGJkWXdobXVONG5yZHJQaVR2YVpJRmRIVExMQVcw?=
 =?utf-8?B?bUcrSHlnSGRhUHlmUW9ESFMreTFIWXBPOHFjaENKUDlFQStnYUo4M0Uvamgy?=
 =?utf-8?B?WmVDMlhXSXZEL1h3ZlNPSzR1NW9Ed2xrZjFGdmZ2NTZFSXo2a2w1eGU0NGRK?=
 =?utf-8?B?aVY0eE5yTC8yeGJCWHpTeDl3R0dSM1ZEVDA0b1lXdzdtbVFjN1Z2Y0R5ZHlh?=
 =?utf-8?B?QjN4REptWUd1OG42OHBFZGhsQk1MSWEwL0s5QnNIS3BOSTZlN2FKeWJMT2lu?=
 =?utf-8?B?UThkVFdWc1JMZVpBNHNFWmZIZ1pJdWd3UFhDWG1jQkVOenU2Ti82RkdmMWpq?=
 =?utf-8?B?MWIxZDM0dHMrTll1dGllL3NDY0tBbDdpdXlDNmg1enV1eE0vVGFNZlVWT2F3?=
 =?utf-8?B?aXczdVg0Y3piZTdzSXpTbUtZWnRNNHFxTW0rL1czbHBveHVCelBoODQxcnM4?=
 =?utf-8?B?cTQ0NHpDLzQ2amowZ0ZPeS9ycDBvbDJiMVZYS1BOS3M2YUp2dS9hT0hhRy9E?=
 =?utf-8?B?WmNvVnpqOHVGOGxqWE44UXNmK2p2MGUwalN2Qm5DelM1YmhQcnI0d3QvOEZG?=
 =?utf-8?B?MDV3OUl3UEhMVUVMSThHRS94MjF5cEhIRFJRaGxxa2NjaFJYZjIveWZGN3Z0?=
 =?utf-8?B?dGJneTkvWmtoRkFrTVdWWGpydEVIQTE1NWRHaHNLWDRlcVZ0NXkzQzY3M2tD?=
 =?utf-8?B?WXNSM2sxcytQWkN3c1dxS0EvUUEzdkRkWHZFZG5qTml6STRUa3JlNGdSQjEv?=
 =?utf-8?B?MWNIME9JVjVheDZ2NVRPamdETlNyV1pwbWRja1NsWlcwUlpXTE80b2FTVXcy?=
 =?utf-8?B?UHptTDl2VzZ0UFE1bjRCTC9IM09QM1pWQVdQREdtNmZTelpPRktTR1NoWTlN?=
 =?utf-8?B?MG02RnNZckNMbDkyRnc4eWFFcGJlaEdkb3NSbFJwQVMrS1JyMDVlbzJkZjEy?=
 =?utf-8?B?eHdzK2lmQTJ0b2VLRzRSL2NyN253c2RBMGg0eXpoNVRGbWhKbnJhS0pqQjhx?=
 =?utf-8?B?SiswbHhqNHBic0VsV1IyUUlZZzBKcTdtdmtPVEdBYkFJUllhZ2NJZkR3YXZI?=
 =?utf-8?B?Z1duelNBV2RqcFg2ZHBlWjh1bEhnVjNMVFM2TGhadmlhV05OSlVtb0E0NHdF?=
 =?utf-8?B?b1JEWUp6UC8xRnZVdVBXQTZPbHdjWjg1N1gzSXZyOTAxTHorUTl0V2NDcVAy?=
 =?utf-8?B?czVVK1RDMzhQSnQxT2Mzd2w1bXMrbEpjU0xWZnFQT3JDbWk4R2dEUVgwTkxp?=
 =?utf-8?B?ZitXaWxGZ29hRkR2aUFtdkVYdnBWYm40R0JXZmlIR0RLWlFDT3IydGJYRlpH?=
 =?utf-8?Q?QbxvVOkBYVCM8dlkNcwSWaefW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b6e2cbe-81b8-49e4-3b10-08dbe085eb6a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8403.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 18:09:58.9671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oyfAR43p6P13LIiHQY46lqh093WCIIBY8fB9IQpnyIhfVVqgJkYh3GvpXoEO7MIJzVncUBWSjDBpGZkEQCKSSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7986

Hi,

On 11/7/2023 16:28, Luck, Tony wrote:
>> @@ -1042,7 +1060,7 @@ struct dentry *debugfs_create_blob(const char *name, umode_t mode,
>> 				   struct dentry *parent,
>> 				   struct debugfs_blob_wrapper *blob)
>> {
>> -	return debugfs_create_file_unsafe(name, mode & 0444, parent, blob, &fops_blob);
>> +	return debugfs_create_file_unsafe(name, mode, parent, blob, &fops_blob);
>> }
> 
> The minimalist change here would be to s/0444/0666/
> 
> That would just allow callers to ask for writeable files without letting them
> add execute permission, or exotic modes like setuid etc.
> 
Noted. Thanks for the clarification. Will change to something like below:

	return debugfs_create_file_unsafe(name, mode & 0666, parent, blob, &fops_blob);

> -Tony

-- 
Thanks,
Avadhut Naik

