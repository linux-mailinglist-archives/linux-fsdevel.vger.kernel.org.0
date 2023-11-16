Return-Path: <linux-fsdevel+bounces-2989-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C07F27EE8E6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 22:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 756BD1F248F6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 21:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1484495CB;
	Thu, 16 Nov 2023 21:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="c1Obrskj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3AF181;
	Thu, 16 Nov 2023 13:46:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XvQwDrXM4+DsqDBChSautY/1ydbhVeAD9n7nEddUASF0n55wlUezHj2uSAOyjiptIY86Sh/fEqEud4R1/6x0yCqyvC7gJFwePHwtgKRqkHy29fj1damlaDIjctJk6XRmsbvJFESOkj0YOjAW9AHXOG3MfThTIn0n33dp2u4l6ftFh4M2qjQpU6cbKxBgEwz5HvewF+t6Ka1TilUMMzd8mHhTzM6D3sI7GC1gxvHF2y9MhtBbnpuD+9C4smw7VtPAKWrREZNPtonSX5ENFfpF2J0mwDSgh5YZlpDpOoSkcdPXfRflAhgy2+yWE4ABGMZAp0c8efySj391C8Y4zBrrVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZMsc1VcHwK7I3JDSnQeSlRkqEZJYIMHSoZfOdgEUWzY=;
 b=dVwonR0PKRTN8R+aOG/A3n2hcRzySpy0onGoPMBHlrkz180SzMLj1yPNdlzLonVTcAAt0EJX72l9JgUE/UD+6FMZwhRhsQVPY1a6mMO24Mc0J4z+p7iLkdis0vHI8t8sueaJ+WdYQe85G0jte3SmS9xiQb+1TNHj0lLxCHq3/KYtQ/yj+R/O8+iy+yuFjpojiM3KvHq+F7WUiHb4zR5TT8LvU6TgDyuPcqSqvC4L29KToo7Q4jDOUKFJRj3vK0Bw2Cv02LPdla/pjh3C1SN8RCoQYWrmI7reN0DVIPGvxxeV85q1/mJF7KhLwkxJA1GZp159V+4A5vyMplx4wdaptA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZMsc1VcHwK7I3JDSnQeSlRkqEZJYIMHSoZfOdgEUWzY=;
 b=c1ObrskjAA6KQ2tAQhh7zaXGqh5N4hM4RSYLUzhDTyhlASwZTZW0PzJd5gx5g+2dQnE6bP+kAclVfeIh+34zMRnJcgMfXPpdLBLRTkaYwBstaFQrwcTgB/DwZ9cT5jDEH68eIcAKFKaxWRZkquGK1lQaJJiufbuW4fir8rEyweI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8403.namprd12.prod.outlook.com (2603:10b6:610:133::14)
 by SJ2PR12MB8875.namprd12.prod.outlook.com (2603:10b6:a03:543::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Thu, 16 Nov
 2023 21:46:03 +0000
Received: from CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::e2:9f06:b82e:9a0f]) by CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::e2:9f06:b82e:9a0f%3]) with mapi id 15.20.7002.019; Thu, 16 Nov 2023
 21:46:03 +0000
Message-ID: <bfa69197-e7c0-4da8-ab1b-342aba8d6430@amd.com>
Date: Thu, 16 Nov 2023 15:46:00 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND v5 2/4] fs: debugfs: Add write functionality to debugfs
 blobs
Content-Language: en-US
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "rafael@kernel.org" <rafael@kernel.org>, "lenb@kernel.org"
 <lenb@kernel.org>, "james.morse@arm.com" <james.morse@arm.com>,
 "bp@alien8.de" <bp@alien8.de>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "alexey.kardashevskiy@amd.com" <alexey.kardashevskiy@amd.com>,
 "yazen.ghannam@amd.com" <yazen.ghannam@amd.com>,
 Avadhut Naik <avadhut.naik@amd.com>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
References: <20231107213647.1405493-1-avadhut.naik@amd.com>
 <20231107213647.1405493-3-avadhut.naik@amd.com>
 <SJ1PR11MB608345F0C62627E7A0520449FCA9A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <71ad8b0e-984b-4739-a940-82c5a1456f50@amd.com>
 <SJ1PR11MB6083BC35F108E319B7C898DAFCB0A@SJ1PR11MB6083.namprd11.prod.outlook.com>
From: Avadhut Naik <avadnaik@amd.com>
In-Reply-To: <SJ1PR11MB6083BC35F108E319B7C898DAFCB0A@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR01CA0019.prod.exchangelabs.com (2603:10b6:805:b6::32)
 To CH3PR12MB8403.namprd12.prod.outlook.com (2603:10b6:610:133::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8403:EE_|SJ2PR12MB8875:EE_
X-MS-Office365-Filtering-Correlation-Id: 17f13ddb-3d63-4869-e320-08dbe6ed6ddf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rGiXuQTn53fZL/U7Dqobzblo/M9ElOT4+BEjeXmfmLLpUHOqE3k1VSJ7gp8ST4L3DJPf+FXX7eySU4ewRDfzSDlUhjz43YHNrGf9Ok2Yki7Oy9x4CgWF5knsM2hbSf3YBIXjQwIPc0L/+BS609QA/IuJmYVKZ0mRtIA7xGHxKcYtBQjzmUYNmov4qBGjQVAE3dyMpQivN7AW0FNhh+m7sBhsraRSEWRHpx+o7VLfNd+INj3dxEld/hQQIf4wBF24KaCDBAyu0MhUbtLwM3N0vzZG8yh9y+6q/LN9fswfSrYreG3fZDKV3D/9/nuaHuuGw4d32c0YONaA4wirbsEzmZHTb0SB/tJiDVBzIAX+iDA9bEactfYBtlXDAeZWpkI29Rx6//UpXBoB3l0Ym2lymEAA5O842YB/vl2mUG0NE9KSo9lm125tE6z6/y8wElnt733tQHptgyFH3zf0zmSd3uCQ3jYnmrHLUof3djGy12ZH/mXBwvGkIAf3170AIrE/7xqzguFtJVhvrzd5Nk23bez9AZe4sg4mpUrhXpUyW5Yv0pWaQlqzgrN820aYhirr3n+aOT7tNn5duCmpn91Lo/U3rvVJbKfz4ARYzVhaOHIMNahBukZw3Eo9nMOK05GmZ+ae5I+m04rY3dPB9++lSkg7sKHRQT7G0xckzbr1txDWu10ZyCUNZYagSxM9kX+l
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8403.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(376002)(366004)(346002)(230273577357003)(230173577357003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(54906003)(316002)(31696002)(66556008)(6916009)(66946007)(66476007)(36756003)(8676002)(83380400001)(4326008)(8936002)(2906002)(26005)(41300700001)(53546011)(6512007)(2616005)(6506007)(31686004)(5660300002)(478600001)(6486002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NlllM1ZyUnIvYm1rdjZwYzI0Tkd5cUJYdVpPSkRqZDVFcEZEUTFSelJzb3Rj?=
 =?utf-8?B?Nys2VkU3UkZJSTFTREd2YzB5RmZRSVBQNmZibmZKcFZkVFpjSWFWL0Myemp0?=
 =?utf-8?B?LzJMZmpKREg2clBMa0t6d0F0S1RtYU40V3FCMjN2MFZSZjc2Wnk5dmhKZlVE?=
 =?utf-8?B?K3ZsbFo3SGpiUDhTMW5OTzlBMnVaVmp4Z0ZDNUNTa09sczIvNFA3THhJc0RM?=
 =?utf-8?B?ZlZpK3RSODFFaFkwUjJ3c08wYXlKYjRPcjJsU0JySFBZVGVOeGpDMVppRmtP?=
 =?utf-8?B?M2k3M3BKbC9WUElOMEltd3VQOHZJZjI0ZEZZL29yKzB6bWNTeEhtRjVWeWFn?=
 =?utf-8?B?T2phMGRqZVBYZzhRclNRUE0rMHRWNjlHS1VtemdrVldSNHl2ZXhyaG0xcm1M?=
 =?utf-8?B?Z0tWWFdyZnVDVm5LZHFtYzlOKzd1bmZvcjFGeGFwbXJnVEtSMTNranNXUmNR?=
 =?utf-8?B?cWIveUI5VU5iTlFpdzdjUVhUWXlwOG1DSm8za1lNSzVVRWhNbng4bDdoTUM3?=
 =?utf-8?B?YmVPSEpBTHFEZEJtbVdHcExpUnFsbXpjbXcrWEhLTDJ0WkxDck96WWtpRTBR?=
 =?utf-8?B?WGhmY016Y01TNFVwTCtnVVZNNFhKOUJwaklmV3pkdWFDN0FWOFVlVU1qWEl6?=
 =?utf-8?B?VWtPeElCaE55RjdyYXVZMFFqSkRZVEFFc2FodFdOelltQkZZOEEvWlh5MUtN?=
 =?utf-8?B?V2VkVFZJSFJzcVVHNTZ4NitNenNONWVQNjRQY2ZwRExzY2liZjh1WkFrS0JG?=
 =?utf-8?B?dm1yZEtSWGxuY2t4QkZHSHV6Z0ZDSkJyYlZJekdrVTYzK3k4RG5UazgxOURq?=
 =?utf-8?B?UEVNcXp0dnBiTEhnemZEdE1lNVRrc2dYTkhGNXlCNW0vTEZweE5OSDhRVG5H?=
 =?utf-8?B?NE92RFI3WklnTUdCNm42dkhSeHQvYnIrZWRISkgwLzdqbXhoNk1TSE53cFhG?=
 =?utf-8?B?U2FDc0ZBU0dNOEtMTDErbk9nM2tqL1hXZTFnMlhRTEkzMHhSTnlGMkJaQ3Bl?=
 =?utf-8?B?bzZweTE1cFB3dnM1OWxmdzJPSXYyelVLNi9GSXZOUmd5czFWZ0M4NzYxc3FG?=
 =?utf-8?B?NGxMYUNzQklQT2czdFNEcEJ2dVlKVGJrMUl2bEJQV3RIbWVSeDgyQi9RWFQv?=
 =?utf-8?B?RmpHUEJaM093cG9hZ2Z4VlNLbldPblBJVit0TzRqWml6L3dONURCeWdQQWVU?=
 =?utf-8?B?ZlAzbC8xdk5CeDNiNE1uTjF4TU5xSlZHTmhwNFd6S0lUVHkvL2ZZUERDWmda?=
 =?utf-8?B?WTJxQm5QTnZDOUpOMTdEbVB1TG1NaUNyUXAvSDFmelYzVzZPZTlCU2E5a0hh?=
 =?utf-8?B?NnB5MFZ1SkNUSmY2UnMwbktzY1F2ajVaY1ZIWGhoeHIrMm1oa1ZCZ1JMbmli?=
 =?utf-8?B?ZkpYb0tMUzA2V2FLbzNNWlROeEY0Z0VzNTladjlpNFJBR0hLWVp5VmkwUXdn?=
 =?utf-8?B?V2VtRU5TaEIvM1pXTnBEN21YaTRvaVY5aFMrNVdUQXdrMmpmSHFHTUgyT21l?=
 =?utf-8?B?Qm9jL2QvWEFKR3JWVGpIRkxMR3l3ZWp3b2d4K1JPY2wrbm91S3dXUXdPQVpW?=
 =?utf-8?B?UEpsZWl5amIxUHJzQUswMkVNbXRCWWJ1ZVkvM2JGcVRmdzhFZm50YjFZU1N3?=
 =?utf-8?B?U1Q3N3VxS0l1RWltQ1U3UUljK0gzWExuY0RBZmxQRTZFSVUwZlRhM3NOUzZS?=
 =?utf-8?B?cUxVNzh1dG4rdW9iL05oM3FHMlJpTGVsbm9WcFpiK3NnYTYvSENCd2NBb095?=
 =?utf-8?B?Q1NJSW9QcDhKL2RtN21zQXpNTkR4dWtaVlduemd6MXpFSXNlUnJoOVVHV1Br?=
 =?utf-8?B?T0VidEtZTVh2U2FxaFlXZ21sQ0ttWDUzWExDWGdPZlRrRjQzWXJDRjMvQ3Rh?=
 =?utf-8?B?dFRaZUc0VTdRVmlCMjR4bm9NUlpwdjBoeThhcU1pdUlqSXFKcWhYZU54TFFm?=
 =?utf-8?B?eUZ1a2Y5VGpLQ0JXWDlVUWZ6eldQWjBXUFRNTU9DZUs1bGtJTmxjR2VtSnAw?=
 =?utf-8?B?Z2hKSEtKaW12ZURxTFFnTU1naW9wN3FQZ29sV05vTXJwc05GWCtSTGY1eDQz?=
 =?utf-8?B?TVc1bE1NU01maUhUZjFmalNxR3dTVGFwcDZxQ3FYeFVSK3VPWDBNSW9zSWFq?=
 =?utf-8?Q?wOODJMza3UknRiLV/nNg9L2Jb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17f13ddb-3d63-4869-e320-08dbe6ed6ddf
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8403.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 21:46:03.0412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tom75Gfk+MkYhNSLVE/3yw26OYgFeWxHuSh1UrLywtwwLL9uU8rLqE7oO7QQ3245+aTOnJ6KrM6u2IesxTOkvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8875



On 11/16/2023 12:44, Luck, Tony wrote:
>>> The minimalist change here would be to s/0444/0666/
>>>
>> Just realized that s/0444/0644/ might be an even more minimalist change since you anyways,
>> I think, need to be root for error injection through einj. Does that sound good?
> 
> You need write access. I don't think you need to be root. E.g. a validation system might
> set up an "einj" group and "chmod" all these files to 0664. But that's nitpicking.
> 
>>
>> In any case, using 0666 will result in the below checkpatch warning:
>>
>> [root avadnaik-linux]# ./scripts/checkpatch.pl --strict -g HEAD
>> WARNING: Exporting world writable files is usually an error. Consider more restrictive permissions.
>> #84: FILE: fs/debugfs/file.c:1063:
>> +       return debugfs_create_file_unsafe(name, mode & 0666, parent, blob, &fops_blob);
>>
>> total: 0 errors, 1 warnings, 0 checks, 54 lines checked
> 
> The warning is dubious. This code isn't necessarily exporting a world writeable file. But
> it does allow a caller of this routine to do that.
> 
>>
>> Would you be okay with s/0444/0644/?
> 
>> -       return debugfs_create_file_unsafe(name, mode & 0444, parent, blob, &fops_blob);
>> +       return debugfs_create_file_unsafe(name, mode & 0644, parent, blob, &fops_blob);
> 
> 
> Yes. This is fine (better). Make sure to mention in the commit comment that this allows
> callers to create files writeable by owner.
> 
Will do. Thanks for the confirmation!
> -Tony
> 
> 

-- 
Thanks,
Avadhut Naik

