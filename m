Return-Path: <linux-fsdevel+bounces-10368-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFA284A8E5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 23:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 347AA1C28370
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 22:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B591D5F84E;
	Mon,  5 Feb 2024 21:59:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2132.outbound.protection.outlook.com [40.107.102.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA8C5F577;
	Mon,  5 Feb 2024 21:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707170367; cv=fail; b=RTZ7zTpbR93DePaRALGUjZSPKQsHt1D0gQnNB99S95uW6yJf77qdwk7niPhluEz8Cq0ISejmSbOGQkmOEwNfqCFIoWLUQgYqCbUQEIXZIT87Z8bRiiFH9E/HUU3FuQiQZUd5rkuKm4aEVgczMAPjOyPz4L1eh7jeVeJmxQzPa/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707170367; c=relaxed/simple;
	bh=hWe1eYndVvRUPlwUiCrLDPVGlaCHEgMh5IC9r8erm/g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VUnf6+2dOuqLzQlxTWUYaP1KsvYkYTeWfrO1HlnPFVSCxbG+GBhKJ1u2Q9rAE9Xh4M9Qtgjh+hhJutwW6HGqbTXbcc0rxuqYF1Otb6g2QvzRTyq3Yi+YcnI9wWDO+OFjv/55rsqHZ2mIG4PPqQOXmkOpQvmmO7blgUsdHbwL2Qo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com; spf=pass smtp.mailfrom=talpey.com; arc=fail smtp.client-ip=40.107.102.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=talpey.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fVj8yv3KQydFlOTfD93Uq0mGiIX2XGp9Ouz8Yq/k7IQoYX0O8MRZBNyIxcyxp89PRxfCZU/Sa5ne3IjAO7gFhfMSErPe5/RG2IBG6/ba0g1EflEPbAdaklUsuGF872jtG8eDzKDIrLV4qVDrHurdVYFwe5NGogXKvTNVF/xJFQsqr0AJQuENa9Jw2Tdk9hCJvoc1rRVBp2TTRxsNmFW7x7zEyX3YGW536C0pwUDy7//QuZIOTuj8i9JJWuG/PyzhF6ThGYaYKxqPhCQ14nsFLNF5/YlZ2l8gorU+yZ5SM0BSfl2e8UesAVOPS5jau316YFue4IdgQ0aJW6oJyxcNLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b6z+rgxW9iQCRxRnvBMB8Q9OmGP0bqAL31xd90jaucE=;
 b=O843ji/FIiJDbEyVOR46wHZXrDCLt7zGwvtVKz2nVsGLVYVZIclll7aIszUqV7Aegu9FHy8CqFJ6vRSoZUzh5V9TqTN0UPU1PQ9I2IS4nQpBFTFtCsmjhjQX9kQE4A6u4iMnLuVAhi9fHsg2I44p2bJl0sY/QuoBrWGO0iInV3IlEwjf5Pf7pNZ47PHMFzGckml8bBKCr2BLLULsgIjzOclGo6EOSuCxtZXuk6dxf+oGqtr4J5smuF4l4vErDw6kZyCJ2DAEUL3qSR96FiQFE4SOGpzZ38Rh1QYGfjqKFTzpG9UiSMOVNXXRX+RVrbewOjgzaX1LEphMWFNw+/m/VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from DM6PR01MB4666.prod.exchangelabs.com (2603:10b6:5:6a::23) by
 BL1PR01MB7745.prod.exchangelabs.com (2603:10b6:208:398::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.36; Mon, 5 Feb 2024 21:59:21 +0000
Received: from DM6PR01MB4666.prod.exchangelabs.com
 ([fe80::fa7e:911b:9238:fd72]) by DM6PR01MB4666.prod.exchangelabs.com
 ([fe80::fa7e:911b:9238:fd72%6]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 21:59:21 +0000
Message-ID: <97f969c3-5ce7-4a60-9056-be42cb0c1888@talpey.com>
Date: Mon, 5 Feb 2024 16:59:18 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] filelock: don't do security checks on nfsd setlease calls
Content-Language: en-US
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neilb@suse.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Chuck Lever <chuck.lever@oracle.com>, Olga Kornievskaia <kolga@netapp.com>,
 Dai Ngo <Dai.Ngo@oracle.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
 =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>,
 Zdenek Pytela <zpytela@redhat.com>,
 "linux-cifs@kernel.org" <linux-cifs@kernel.org>
References: <20240205-bz2248830-v1-1-d0ec0daecba1@kernel.org>
 <170716318935.13976.13465352731929804157@noble.neil.brown.name>
 <cd3f8b0d2d0c0a58472b9a83b9c89dbbc6ad4e5c.camel@kernel.org>
From: Tom Talpey <tom@talpey.com>
In-Reply-To: <cd3f8b0d2d0c0a58472b9a83b9c89dbbc6ad4e5c.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR13CA0033.namprd13.prod.outlook.com
 (2603:10b6:208:160::46) To DM6PR01MB4666.prod.exchangelabs.com
 (2603:10b6:5:6a::23)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR01MB4666:EE_|BL1PR01MB7745:EE_
X-MS-Office365-Filtering-Correlation-Id: 778cccfc-dead-41d9-ed89-08dc2695b4e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Mp2Io17AoO6xVySzA21V6GIFFElTCxoiqCYHQEHhiLjSs6ekyoekek80o2+T4nPugM3SEnxcLN7MbzU0UpduyX9obRRoGm4+HBYABHiSN20m5DAAxa9VxnIbcRl9k+y0z19jvS9bbypHCPY1OEH+2vtOkGiFmDkxCujnH2Qe13FwDmLSsl7l7/oIL0Nuf9Cf0HJ/zx+E9ndsjGOP11bOB4ilcdLcYpN51jGrq1qBohp/IFXs7myJyG6jkyk5izyPvsW2RsSuSawaH+bZbKlAs4EiGNn+r1v1pvsXQ8PziMIBihwz2Px+3gguYT8QO86jljaEyKsNfVW8t4/LqZcs/g1anIhkB4FzivlVmxJ1DRA8IXcDzPG6auY159ubZ/f7Q0mgI05qiO/uWtoJ3+gPqWizcTWduF5cWdDtIn+8zGo97t86sfVM7NV6EesnMwvnMZ9DIuqf+VnIIQMdWe5Yu8NzX6c/3Hmdunx3UaX6wfzbpk8kV6Z4LjTa3Z8iz5sh1/de4Cgqo40g12bir9BLHP8bzyU7csMJHDKaFduOPhkUPD3d/rymTfWDZ6OX7XDhDzG5CzwAs7NWKe5vAvGnSaWumtBVZqNNAM0PT4gx3ok=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR01MB4666.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(376002)(366004)(346002)(136003)(396003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(41300700001)(2616005)(26005)(86362001)(7416002)(966005)(6486002)(15650500001)(5660300002)(2906002)(478600001)(110136005)(54906003)(66476007)(66556008)(66946007)(8936002)(4326008)(8676002)(6512007)(36756003)(6506007)(53546011)(6666004)(316002)(31686004)(31696002)(38100700002)(83380400001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YzErWUdpK3VuM085clRkaDh0cExOZVh5cEdvYXovRmNlSmgvU3FFL3dHSUtM?=
 =?utf-8?B?UVFyN0wySW5VT2F1NVA2OHVYM1dBbU5JU1VueDhqZFo5b21TcHFNby9mZWVq?=
 =?utf-8?B?a3NJR2ZOZ2l2VEZTTW8wWGE5TlU2anhwclFyTit6YS9mK2hRSjFXYXUrUzBi?=
 =?utf-8?B?S1hEOFZCdkpnUnQ4OGhtK0xNUWtEWTlaMStUNFYvOTlEeDY5UE5OSm1yY21E?=
 =?utf-8?B?NGxkellCM3RyeEkyY0ZvSFFMTTE1R1YvOFYyZkQ3QmE0ekNtem5xWlZHY3po?=
 =?utf-8?B?MlRrRzdGTTRZeWZhekNyNWlGTG9VWWRUTHgxMlNTTUJOWG1aVzJ6ZXNMWDE4?=
 =?utf-8?B?em5aNWZmdEJOUk1RS2RvRTlVYVQ3YTF6dHRpdHAzaWhUMm5MUzY4RGdYU2tF?=
 =?utf-8?B?RE53ZllmSXQ4ZFFjM2R6SExENGQ4T1hZUzc1aVJDYTkxaEp6c2NDMnMrR0JC?=
 =?utf-8?B?UWdzWElQeisxdHdYckdWMjhGWnptcXpVaTYva3JlTzVuOUlsdUExODZ2RjBX?=
 =?utf-8?B?M3Q0UUlBU3YzMWVtYkpObmM1STRhZm8wbWkzYTV4T0JKRkJUdUxrdE5pNEVq?=
 =?utf-8?B?T1pGZUg1WEhyeWZPZkMwYWZzQTFKclA1TFQvUVJZY1FzSnRSNlVPcjR2YzN6?=
 =?utf-8?B?NXlrZ2tqajhrUW5PN1IzQmNscldaNHA1aUMrdUdCT1dhOHkwQkxGcFp2cHA0?=
 =?utf-8?B?elpMbWVwWGFrSm5vMkd2d1U3MVVLcXI3WWxTeUxvU2p0Qm1CYjFCcDdxMDN0?=
 =?utf-8?B?Zi81eDIrbkNGRlhWVnFublkrZHhRSDU3cStLWmZjaUllTWVZcHJyd012NGlu?=
 =?utf-8?B?MnNnY0hnbXh4aGhLTEJIb3p3R3YwRm1ydnhjQksxZCt1SW5WZ0hkRjlvS0di?=
 =?utf-8?B?TDljSTR6OUtMYXlBVU81Vlp4c2F3ZXRpc1VWbjBxNkRkQ0ovenhCZUFsNFNV?=
 =?utf-8?B?UFgyZWRvTXdyWW54a244N2EzWFl2UUE4U0JBWHhYQ29JdFNyRXdqdU5pVjFw?=
 =?utf-8?B?dHRXSkZ4NXRQZ2lkZEJ0aXVyaEVCNEVySXhWVlZIWjZ6MWx2SW1mWGJGLy9l?=
 =?utf-8?B?R1lybkExY3BMd3B5QjNZbk5yM1BUQSs1Q2hNRGt6VVowdmx4MEFxbnRlTkk3?=
 =?utf-8?B?cExCcTF1eXRINFQzaGZ2ZnFGV1VVNXpta3dLcnJaTzNCdCtRTDA5SkhDakJY?=
 =?utf-8?B?SDB0L1ZJdElHcmVKMkFFOHh4VndkYXZ2WDNCMlNhYVU0dWtoVU9OT1d2WHdq?=
 =?utf-8?B?clRGa3RyOE9FbS8xUFhJRnlBL2tubGNBS3Z0NlBlcSttK1B5WVJlRGk3K3VO?=
 =?utf-8?B?cFdPb3QxaCtmRDV1UG1WRS9uNDJDNTQ3VjY4MEEzU2lza2k2MG04ZHJodWU1?=
 =?utf-8?B?QWxaK2tadTkwaUtrTmtEWEZXQkxBNnN0NzVCR3hkbFBKMjB1Wms4akNXZ2F4?=
 =?utf-8?B?a1FVTDZab0hFVm1jdyt3SG5VbXREVnF4ZmdEQ3JGc2U5YzJIbk41Vi9xWGls?=
 =?utf-8?B?VDdZcWxxU3VBNTFjWHVhN2pqbFMxa0JmKzhjek1XVEI4U25vQS9sditDdjdO?=
 =?utf-8?B?c3R4WWYxd0c0VDJvU1hFQ3ZTMithYnVKTkp6UEFwWVpraGVmMjh2UUs4QzI0?=
 =?utf-8?B?cnpjRVhhK1g0Q0VtTDBnR05sZGZkNEJvYjg2ZVVTaitkQ1RIbi9mUXNmbDVo?=
 =?utf-8?B?V3BFaUJEWVdDaVBNcW9Ba213YnQ3Y0tFeHNWcnNtdVZmdDBLUFpaQTlMdnV1?=
 =?utf-8?B?K2oxbVE3d2Vxb0x6Q0Y5ZGZXbWowSlRWRGFKakcvclZVTk93eElCYXh0RVVt?=
 =?utf-8?B?Rm8yWExrVEZ5OE5nS2xrcmpFNlhUNjhobVFSLy9HMUtoQ1lQUmk3eGdWbFAr?=
 =?utf-8?B?M3hhblBDbjZ6dHFSa3lkd1BhbEZtYVZ1UVh6TmprRTc5azR3TGd5UUMrdjZi?=
 =?utf-8?B?R2VHbUFreWtKNDhzMTlCTUFBa2VPc09WSHdSd1dta0NTN3YycU94ekNZUmhH?=
 =?utf-8?B?bVpOV09kNk9uUmVpdk5HRy9pNHZXREJST2R1U0Nhb2VjbWpNYnRtVXljUER5?=
 =?utf-8?B?bldrRmx2VXVNZWp4WGxVY2NDTzAxOFNZbTNPbG9JWUJpaGt6N3RKYnU3T3Ur?=
 =?utf-8?Q?iyv9UGNTFM3VXwJHpbstOYFVu?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 778cccfc-dead-41d9-ed89-08dc2695b4e0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR01MB4666.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 21:59:20.8232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 93Cu9aSQvxR4IFFsCXb0DyAetOr3Z/grmncOdwXjZG+nt4OUcmX9R3Dx6UYHx4mJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR01MB7745

On 2/5/2024 3:16 PM, Jeff Layton wrote:
> On Tue, 2024-02-06 at 06:59 +1100, NeilBrown wrote:
>> On Mon, 05 Feb 2024, Jeff Layton wrote:
>>> Zdenek reported seeing some AVC denials due to nfsd trying to set
>>> delegations:
>>>
>>>      type=AVC msg=audit(09.11.2023 09:03:46.411:496) : avc:  denied  { lease } for  pid=5127 comm=rpc.nfsd capability=lease  scontext=system_u:system_r:nfsd_t:s0 tcontext=system_u:system_r:nfsd_t:s0 tclass=capability permissive=0
>>>
>>> When setting delegations on behalf of nfsd, we don't want to do all of
>>> the normal capabilty and LSM checks. nfsd is a kernel thread and runs
>>> with CAP_LEASE set, so the uid checks end up being a no-op in most cases
>>> anyway.
>>>
>>> Some nfsd functions can end up running in normal process context when
>>> tearing down the server. At that point, the CAP_LEASE check can fail and
>>> cause the client to not tear down delegations when expected.
>>>
>>> Also, the way the per-fs ->setlease handlers work today is a little
>>> convoluted. The non-trivial ones are wrappers around generic_setlease,
>>> so when they fail due to permission problems they usually they end up
>>> doing a little extra work only to determine that they can't set the
>>> lease anyway. It would be more efficient to do those checks earlier.
>>>
>>> Transplant the permission checking from generic_setlease to
>>> vfs_setlease, which will make the permission checking happen earlier on
>>> filesystems that have a ->setlease operation. Add a new kernel_setlease
>>> function that bypasses these checks, and switch nfsd to use that instead
>>> of vfs_setlease.
>>>
>>> There is one behavioral change here: prior this patch the
>>> setlease_notifier would fire even if the lease attempt was going to fail
>>> the security checks later. With this change, it doesn't fire until the
>>> caller has passed them. I think this is a desirable change overall. nfsd
>>> is the only user of the setlease_notifier and it doesn't benefit from
>>> being notified about failed attempts.
>>>
>>> Cc: Ondrej Mosnáček <omosnacek@gmail.com>
>>> Reported-by: Zdenek Pytela <zpytela@redhat.com>
>>> Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2248830
>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>
>> Reviewed-by: NeilBrown <neilb@suse.de>
>>
>> It definitely nice to move all the security and sanity check early.
>> This patch allows a minor clean-up in cifs which could possibly be
>> included:
>> diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
>> index 2a4a4e3a8751..0f142d1ec64f 100644
>>
>> --- a/fs/smb/client/cifsfs.c
>> +++ b/fs/smb/client/cifsfs.c
>> @@ -1094,9 +1094,6 @@ cifs_setlease(struct file *file, int arg, struct file_lock **lease, void **priv)
>>   	struct inode *inode = file_inode(file);
>>   	struct cifsFileInfo *cfile = file->private_data;
>>   
>> -	if (!(S_ISREG(inode->i_mode)))
>> -		return -EINVAL;
>> -
>>   	/* Check if file is oplocked if this is request for new lease */
>>   	if (arg == F_UNLCK ||
>>   	    ((arg == F_RDLCK) && CIFS_CACHE_READ(CIFS_I(inode))) ||
>>
>>
>> as ->setlease() is now never called for non-ISREG files.
>>
>> NeilBrown
>>
>>
> 
> Ahh yeah. Good point. I'm fine with including that if Christian wants to
> fold it in.
> 
> Thanks for the review!

cifsfs.c is a new file being added to the change, cc-ing linux-cifs
for awareness. The SMB3 protocol does support leases on directories, so
this vfs change might be important to note in the future.

In the meantime, for cifsfs.c:

Acked-by: Tom Talpey <tom@talpey.com>

Tom.


>>> This patch is based on top of a merge of Christian's vfs.file branch
>>> (which has the file_lock/lease split). There is a small merge confict
>>> with Chuck's nfsd-next patch, but it should be fairly simple to resolve.
>>> ---
>>>   fs/locks.c               | 43 +++++++++++++++++++++++++------------------
>>>   fs/nfsd/nfs4layouts.c    |  5 ++---
>>>   fs/nfsd/nfs4state.c      |  8 ++++----
>>>   include/linux/filelock.h |  7 +++++++
>>>   4 files changed, 38 insertions(+), 25 deletions(-)
>>>
>>> diff --git a/fs/locks.c b/fs/locks.c
>>> index 33c7f4a8c729..26d52ef5314a 100644
>>> --- a/fs/locks.c
>>> +++ b/fs/locks.c
>>> @@ -1925,18 +1925,6 @@ static int generic_delete_lease(struct file *filp, void *owner)
>>>   int generic_setlease(struct file *filp, int arg, struct file_lease **flp,
>>>   			void **priv)
>>>   {
>>> -	struct inode *inode = file_inode(filp);
>>> -	vfsuid_t vfsuid = i_uid_into_vfsuid(file_mnt_idmap(filp), inode);
>>> -	int error;
>>> -
>>> -	if ((!vfsuid_eq_kuid(vfsuid, current_fsuid())) && !capable(CAP_LEASE))
>>> -		return -EACCES;
>>> -	if (!S_ISREG(inode->i_mode))
>>> -		return -EINVAL;
>>> -	error = security_file_lock(filp, arg);
>>> -	if (error)
>>> -		return error;
>>> -
>>>   	switch (arg) {
>>>   	case F_UNLCK:
>>>   		return generic_delete_lease(filp, *priv);
>>> @@ -1987,6 +1975,19 @@ void lease_unregister_notifier(struct notifier_block *nb)
>>>   }
>>>   EXPORT_SYMBOL_GPL(lease_unregister_notifier);
>>>   
>>> +
>>> +int
>>> +kernel_setlease(struct file *filp, int arg, struct file_lease **lease, void **priv)
>>> +{
>>> +	if (lease)
>>> +		setlease_notifier(arg, *lease);
>>> +	if (filp->f_op->setlease)
>>> +		return filp->f_op->setlease(filp, arg, lease, priv);
>>> +	else
>>> +		return generic_setlease(filp, arg, lease, priv);
>>> +}
>>> +EXPORT_SYMBOL_GPL(kernel_setlease);
>>> +
>>>   /**
>>>    * vfs_setlease        -       sets a lease on an open file
>>>    * @filp:	file pointer
>>> @@ -2007,12 +2008,18 @@ EXPORT_SYMBOL_GPL(lease_unregister_notifier);
>>>   int
>>>   vfs_setlease(struct file *filp, int arg, struct file_lease **lease, void **priv)
>>>   {
>>> -	if (lease)
>>> -		setlease_notifier(arg, *lease);
>>> -	if (filp->f_op->setlease)
>>> -		return filp->f_op->setlease(filp, arg, lease, priv);
>>> -	else
>>> -		return generic_setlease(filp, arg, lease, priv);
>>> +	struct inode *inode = file_inode(filp);
>>> +	vfsuid_t vfsuid = i_uid_into_vfsuid(file_mnt_idmap(filp), inode);
>>> +	int error;
>>> +
>>> +	if ((!vfsuid_eq_kuid(vfsuid, current_fsuid())) && !capable(CAP_LEASE))
>>> +		return -EACCES;
>>> +	if (!S_ISREG(inode->i_mode))
>>> +		return -EINVAL;
>>> +	error = security_file_lock(filp, arg);
>>> +	if (error)
>>> +		return error;
>>> +	return kernel_setlease(filp, arg, lease, priv);
>>>   }
>>>   EXPORT_SYMBOL_GPL(vfs_setlease);
>>>   
>>> diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
>>> index 4fa21b74a981..4c0d00bdfbb1 100644
>>> --- a/fs/nfsd/nfs4layouts.c
>>> +++ b/fs/nfsd/nfs4layouts.c
>>> @@ -170,7 +170,7 @@ nfsd4_free_layout_stateid(struct nfs4_stid *stid)
>>>   	spin_unlock(&fp->fi_lock);
>>>   
>>>   	if (!nfsd4_layout_ops[ls->ls_layout_type]->disable_recalls)
>>> -		vfs_setlease(ls->ls_file->nf_file, F_UNLCK, NULL, (void **)&ls);
>>> +		kernel_setlease(ls->ls_file->nf_file, F_UNLCK, NULL, (void **)&ls);
>>>   	nfsd_file_put(ls->ls_file);
>>>   
>>>   	if (ls->ls_recalled)
>>> @@ -199,8 +199,7 @@ nfsd4_layout_setlease(struct nfs4_layout_stateid *ls)
>>>   	fl->c.flc_pid = current->tgid;
>>>   	fl->c.flc_file = ls->ls_file->nf_file;
>>>   
>>> -	status = vfs_setlease(fl->c.flc_file, fl->c.flc_type, &fl,
>>> -			      NULL);
>>> +	status = kernel_setlease(fl->c.flc_file, fl->c.flc_type, &fl, NULL);
>>>   	if (status) {
>>>   		locks_free_lease(fl);
>>>   		return status;
>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>> index b2c8efb5f793..6d52ecba8e9c 100644
>>> --- a/fs/nfsd/nfs4state.c
>>> +++ b/fs/nfsd/nfs4state.c
>>> @@ -1249,7 +1249,7 @@ static void nfs4_unlock_deleg_lease(struct nfs4_delegation *dp)
>>>   
>>>   	WARN_ON_ONCE(!fp->fi_delegees);
>>>   
>>> -	vfs_setlease(nf->nf_file, F_UNLCK, NULL, (void **)&dp);
>>> +	kernel_setlease(nf->nf_file, F_UNLCK, NULL, (void **)&dp);
>>>   	put_deleg_file(fp);
>>>   }
>>>   
>>> @@ -5532,8 +5532,8 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>>>   	if (!fl)
>>>   		goto out_clnt_odstate;
>>>   
>>> -	status = vfs_setlease(fp->fi_deleg_file->nf_file,
>>> -			      fl->c.flc_type, &fl, NULL);
>>> +	status = kernel_setlease(fp->fi_deleg_file->nf_file,
>>> +				      fl->c.flc_type, &fl, NULL);
>>>   	if (fl)
>>>   		locks_free_lease(fl);
>>>   	if (status)
>>> @@ -5571,7 +5571,7 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>>>   
>>>   	return dp;
>>>   out_unlock:
>>> -	vfs_setlease(fp->fi_deleg_file->nf_file, F_UNLCK, NULL, (void **)&dp);
>>> +	kernel_setlease(fp->fi_deleg_file->nf_file, F_UNLCK, NULL, (void **)&dp);
>>>   out_clnt_odstate:
>>>   	put_clnt_odstate(dp->dl_clnt_odstate);
>>>   	nfs4_put_stid(&dp->dl_stid);
>>> diff --git a/include/linux/filelock.h b/include/linux/filelock.h
>>> index 4a5ad26962c1..cd6c1c291de9 100644
>>> --- a/include/linux/filelock.h
>>> +++ b/include/linux/filelock.h
>>> @@ -208,6 +208,7 @@ struct file_lease *locks_alloc_lease(void);
>>>   int __break_lease(struct inode *inode, unsigned int flags, unsigned int type);
>>>   void lease_get_mtime(struct inode *, struct timespec64 *time);
>>>   int generic_setlease(struct file *, int, struct file_lease **, void **priv);
>>> +int kernel_setlease(struct file *, int, struct file_lease **, void **);
>>>   int vfs_setlease(struct file *, int, struct file_lease **, void **);
>>>   int lease_modify(struct file_lease *, int, struct list_head *);
>>>   
>>> @@ -357,6 +358,12 @@ static inline int generic_setlease(struct file *filp, int arg,
>>>   	return -EINVAL;
>>>   }
>>>   
>>> +static inline int kernel_setlease(struct file *filp, int arg,
>>> +			       struct file_lease **lease, void **priv)
>>> +{
>>> +	return -EINVAL;
>>> +}
>>> +
>>>   static inline int vfs_setlease(struct file *filp, int arg,
>>>   			       struct file_lease **lease, void **priv)
>>>   {
>>>
>>> ---
>>> base-commit: 1499e59af376949b062cdc039257f811f6c1697f
>>> change-id: 20240202-bz2248830-03e6c7506705
>>>
>>> Best regards,
>>> -- 
>>> Jeff Layton <jlayton@kernel.org>
>>>
>>>
>>>
>>
> 

