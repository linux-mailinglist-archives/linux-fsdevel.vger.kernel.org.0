Return-Path: <linux-fsdevel+bounces-10372-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DAD84A93E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 23:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45D9EB287D8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 22:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910051AB7F6;
	Mon,  5 Feb 2024 22:22:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11022010.outbound.protection.outlook.com [52.101.51.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5881EB31;
	Mon,  5 Feb 2024 22:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.51.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707171754; cv=fail; b=I0MLwwyz2XeEaA7AEXWx6rsXqPmcYCJA92s1l0HQ7WTBXvCowRYxQsXzJvlXv8JZ+m0/2+XZgZCPyAFtetuAEag3ox0KobK4VsgMK+ZJIxbzkNhPrhacWw5hft5m9EvYrJ2ZAcS/hLrNnoG4Q2M6My4kTXcSY52Taj2Tdw2J+VA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707171754; c=relaxed/simple;
	bh=+5qMa3Y+RgiWJNIDv2FFRO6t6bnbWmffvVQjeb+vJv4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JwsQJ1iNYinZwg5y+2c8aGOOfl3jR9TWdSrnswk3cuUxGT5w9SwIWEZmwawXEH65hy+ZKZ222e0CDvvF7vO3wR/f8dEz2ZPOMXP33qX4p95X7eCyjybi1ryR3isoTPRle4ChjTfY6HaTn+PrfS+94FIxFkHZ/cUiPGfSTRl0izk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com; spf=pass smtp.mailfrom=talpey.com; arc=fail smtp.client-ip=52.101.51.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=talpey.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SKECXzmoLM4TCm1G36VEODIa4TFX/QLy0aOC5uO472QmkVUM4dEXUb1ppSNLsa0Oxvia2fqWnH8OOAmErErSqexf1XHvu5esePnIG0Nrxgg2+VazQJ4JExyeGNdgX5aw2hNmFLAHwXewkVQiurcu2+wEVY/YhlHXlRW7MDQf3J+FJDV0Av8RWl2QhRxhQ2aYMxV63zZcnzoX7y5D8tsyPxdzFoWHx5D2I+zyEjARxb4MddAqbWcUIM7SPlc588qKgReYEVSLBrtzB/px6eBJ947XnlGFm7x81fC1W4fjptLIjeRW6csOEVyFmCRyoEhl8VQqAFFix3SViDtHZT/w6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9FqIaAWc7e2A2z1jg4r8vIYL1gLh1uUHXfIG3P8dydE=;
 b=UVXSappLb5HbZ9eCKyqN7PWRzLFSwNXDRbumc/Q+yxl0SjmtDYkC5Z+Img2LWyiYBqo76GG9mraYZXUn9hxK1hbZ7eN8bE/rP4jm8Tc2OxosDZ6x/YL90t9EIaC2A/Rql/rxZBG44j9/ubMzzGB68e1NOCOuH7jDpctmDMUmW5kM/SHcOck5uqkU/2b24zsYj/iPfkIz9xRlFgOu9UkEmAbm4Nyrb/BpvyP/a+7PEGpVz2WXYj8zEcljoaVsfJSj/ce/s7LoCIUokl21+p3KJWqIDNymqAx4ji3eGk0HCkJwrrUYilcUqZAzqjrkkHh8olN+5IRxEPgCavd64RIRYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from DM6PR01MB4666.prod.exchangelabs.com (2603:10b6:5:6a::23) by
 PH7PR01MB8073.prod.exchangelabs.com (2603:10b6:510:2b7::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.31; Mon, 5 Feb 2024 22:22:28 +0000
Received: from DM6PR01MB4666.prod.exchangelabs.com
 ([fe80::fa7e:911b:9238:fd72]) by DM6PR01MB4666.prod.exchangelabs.com
 ([fe80::fa7e:911b:9238:fd72%6]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 22:22:27 +0000
Message-ID: <a2eb89ca-8ce4-4bd7-a638-1e5ea1a4e966@talpey.com>
Date: Mon, 5 Feb 2024 17:22:26 -0500
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
 Zdenek Pytela <zpytela@redhat.com>, CIFS <linux-cifs@vger.kernel.org>
References: <20240205-bz2248830-v1-1-d0ec0daecba1@kernel.org>
 <170716318935.13976.13465352731929804157@noble.neil.brown.name>
 <cd3f8b0d2d0c0a58472b9a83b9c89dbbc6ad4e5c.camel@kernel.org>
From: Tom Talpey <tom@talpey.com>
In-Reply-To: <cd3f8b0d2d0c0a58472b9a83b9c89dbbc6ad4e5c.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR17CA0011.namprd17.prod.outlook.com
 (2603:10b6:208:15e::24) To DM6PR01MB4666.prod.exchangelabs.com
 (2603:10b6:5:6a::23)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR01MB4666:EE_|PH7PR01MB8073:EE_
X-MS-Office365-Filtering-Correlation-Id: faebc0d7-3c14-4765-47a7-08dc2698ef83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0XkCMeghIngkyPBOe5OotqczWxBpqV7RbjZRTTuFcGJbjIvJNPk3kM686QZTpq4fy5Qr47+HSHZwsN3sDRvVTrDQ3jGnPrRZFQdc/qUDCHuMVKOW24OBagRIsTz2arPgq2wUvZcIaWW62qr+XodvLLBX6GGt9RD3C7qNOHMxGh3pKyWcGe/pW1Ss3cN0ueoas7XQLA+kEhsVWXzNc+OoGyPoVIs3NlvMXJNaE61OMgbVIjsrujoRQhupE0n7uIG4gI9W80YqV1kDOeUfCGffwC0jU+y5cEEyvlYs2QoUqzwnr488sme3NVzBf0cVS1S0EN1xMo2VLA5FtzQccAJZuDVuPBrOWSkwJ5497XhZBF9Ymzitm4XWfj8/E0NDxzbp8HLL5DGTBTXH240HmpYT5rffWhHbaPJPUze/OFLZBQOUG4QDrlWPNDIiBd16db1lE+4trFJ+Yq8ERRuRGOPG3nHpMwZoku0AyBY+2X6LOTiXnYvv+dVp7IEY9EAZqYyLi7RhuvS/XyVj17t3B5hles++/kd7GwqMb2PeEof825aMTAPgdVboQTt8FFVUTAKChbzg2vAHBJzovjU05+4FeIgqamSNBjkL1cFP6PnMN34=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR01MB4666.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(346002)(366004)(39830400003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(31686004)(41300700001)(36756003)(2616005)(6506007)(38100700002)(26005)(478600001)(53546011)(86362001)(966005)(83380400001)(6512007)(8936002)(66476007)(15650500001)(66556008)(316002)(110136005)(2906002)(7416002)(66946007)(54906003)(31696002)(8676002)(6486002)(4326008)(5660300002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZTJmMkZWUVJkZ3lMZGVzUy9BM0pOZkh4QWd4TWNudVhHWXZuanNqNHFXWnVQ?=
 =?utf-8?B?WHp4VDBuOXEzbWFJY1BTUUY1TTdFcnFVZzc4TVVBNWNzL290QUtLdTVpV2h1?=
 =?utf-8?B?NHJQc3l1RjQ1dC9oZmVsRi84b3l4RUNWT0dNUnlNUzA0N0s0YkxTK3BHUGNW?=
 =?utf-8?B?Tm5EMmlxWW1SR3JaZTNFUXIzZUNETmc2ZjhEVnk4YUtGY2Y2cUUycnJ1NFV2?=
 =?utf-8?B?ay9xSFlxcmVMVmppL2JJSVFEUy94Vm13UkQ3UmYxOCtDbzg4S1ZtNitNaVpn?=
 =?utf-8?B?KytLellabzVhbzQ3RitvdCs3WENrdG5qRElXRFdNTXlPakczaktNZEJaY3Jx?=
 =?utf-8?B?MlZjNm9YNUZsYUt0TGpYcVNOODlnSHN1ZDhGQldXeldhbFdFcmkxSlhMUlJ2?=
 =?utf-8?B?VjdKSTYxeTAyeEJqdytkeG91WGFzWVFoams5YVJ5Y1BORW1zM0tHdXpZNnha?=
 =?utf-8?B?OGFXZVVMamkzV1E0QjIvQ1JFSjJGalBDUzZnQm90UE0vbG1RUDdJclVLQjBS?=
 =?utf-8?B?K0xpRUhCVVY0dEl4UjlFZEtISTRLN2Q4d2JvT1pOMDA4UDg3Wk0vSzkzdVAv?=
 =?utf-8?B?WlNwcWRrZ3k5emcrcGd5NGdqaWxZcy9mVHE4WVFDVTkxaHJFSlZwdWpRSWJs?=
 =?utf-8?B?Tm5rcDZtQWlHZGlML2RsbTNxdmpZL1FOaHFHZk4ycmUvUHJLODVaTUZPdURu?=
 =?utf-8?B?RG9MQ1RBOVFONG1mdW9lamYwTStmVlBRY1M1RHFOdG90a0RMZEZmMnNlemZW?=
 =?utf-8?B?YVo5cjl0YXJTem5BSkI0c0ZjZ1h0dEE4dm5RdjJxbmRVamtnYW93NWNRQmxF?=
 =?utf-8?B?c3ROSUl1dE5SQm5iVFZSQXZJNmZIaGhBM1JneFBLSHR4NU9qZTdObnhKMnZP?=
 =?utf-8?B?NE9VT1BxZDBlZEhjditVcjRhZnpOSXBDcENzK2g3NmpFUUUweFBIY0NEQyt2?=
 =?utf-8?B?ODZZV2VNc0VFUW5lRDEybFdxaWtLSWpvaEhVNndlYUtpOVB1L3dMc0wrcVpp?=
 =?utf-8?B?bXh2bC8zWXc4S2xUd050L1A2dFNaVlNRQU95RzVNWWIwaHVEZDdmZFV5QklN?=
 =?utf-8?B?WnVRSUo5Z3hrdnVtWEVZTFBqeFhqTGVOaFJwbXdKVkhOYmlwN29Kc2FjdTk0?=
 =?utf-8?B?YS91eXZsaG8zTVI0ZjBoSzU5MFNuSElUbnJtTnViZGp0RGYyVS84SVpKVThm?=
 =?utf-8?B?Z1EvcFZxalJ5NWxtVGFFdG90LzB5VGpqNjJhWkZUMGtLQ25hck9XdG40Ykpk?=
 =?utf-8?B?bHJ5VElYVXNXdlVhakZDVjExVEdaQTZMYkJ4Rkw1L0VKT3VWWk1NQ2dMVUY3?=
 =?utf-8?B?NE0wRTZUcWUxeUF3NGJob0ZwOHdldVFaU0tRMWJPYjRpWTd4TW5BNVFLK1oz?=
 =?utf-8?B?bDg0YThKWVYzYzFhV05UZ25Qa3pWbUJHa2R6TjNWS2phN2NIUG1Ebk1wckJL?=
 =?utf-8?B?R1pVRDZGalZtYVVBS0psMVdPNjhBRWxhdlBvb0tkdXlIa1VmVmZDZ2JHd1pv?=
 =?utf-8?B?S0xXRlIzNzVjYzIrWmVFVmJwK0dSZ2E4am13cGZuVFNGclFFSmZnSWl3c3Yw?=
 =?utf-8?B?SFBUREs2OEJwRkFFV3VCYkJGcFN6OGdTYXIrdjlsd3l5ekg4ZWRkSW5sRWZE?=
 =?utf-8?B?amV5d1lNakRkQXZmYllHOVA5bElvOWZsUXBheG45OVc5cE1SMmJOeHpUZ0Fa?=
 =?utf-8?B?bU9Sb2ZnV1dRdzhGTldnTnZ3N3NiSWN1ekJwNlR0M3VsNjNPQXRONEU0ZExQ?=
 =?utf-8?B?b3hWNnFDZUVDV0tDTXNNS2Ztdys0RkM4WXI5VVl0SVU1aW5LVlRIdWlzVTAw?=
 =?utf-8?B?YUg4OWZTK0kzdWlNNWZRQm5HY0RNaHlWRHAwK1o0aFhUYTM4UWJLSVVCUUNL?=
 =?utf-8?B?L0lBTytoZnE2SGhMSVVSY2hLUm4zQ0xTNTE0YitiNkVZdGg2cHNjc1FhbWJW?=
 =?utf-8?B?ZGhXYWJIRjZxSldFaEFFRThlem95S1ZOTG1LWGFGNGlSeXB6SEVlbTFwQlJj?=
 =?utf-8?B?MVRuZ29DU3dLK2ZRbVB0b3lUc0NLWkJ4QzdLcjFSMENQbGZFTXpBZEpvc2Fr?=
 =?utf-8?B?ZEpKOEhYVktsTUtQV3liRk53RmFKVXg3eExtRExPTnpxTTVtWGJzd2RHczFM?=
 =?utf-8?Q?v2oLrEW46zHvDv6rXw/Lj5tL5?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faebc0d7-3c14-4765-47a7-08dc2698ef83
X-MS-Exchange-CrossTenant-AuthSource: DM6PR01MB4666.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 22:22:27.6324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BzDqOGduQEC6vZbwdOxjZY3MBEUFu9CDV8oLZJBWQzk7wqrE45HLBB9BVniZDHuy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR01MB8073

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

[re-replying to fix cc linux-cifs@ /vger/. kernel.org ...]

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

