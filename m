Return-Path: <linux-fsdevel+bounces-89-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3207F7C58D2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 18:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60DF81C20F28
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 16:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E330D321A0;
	Wed, 11 Oct 2023 16:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rqBJgNEX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D46D10951
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 16:04:55 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2044.outbound.protection.outlook.com [40.107.96.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394B78F
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 09:04:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AlbkaPLcfUPpualeAV+x1+1qlwKNu/sYxLJxboCjrDGgoixSaUZgPg/KCG/GldCtiHsCrBAc1KkoM+hX7gcMeGBdx+ooHIA283VeJGD9GzjYg+NfE+xZCKZ8P01zKEUiH4RfhUnN1nluZjvktgMVrCQ9KJD26pZQ4+ICglN/UrPC22i45BbyrXde0/cgfrDA3L8AMZ2XOAKnvMctLdWh0JlAvKAKHOyz2uzYJJdPHIHV2GTWWierF/xx7I5jsyOXYhYDyx3sTQjvALecGlEW7MouV98AtAgKcGjkeD9S2rSqXLHdqB/pq6DTl8rsb+9w/3iMV6HCwAQbdXtcmmj8mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fGkMXD7ArKJzNkxSAwjUUycd3+Fhmuan83YAeQCrbYo=;
 b=RB5o2lr+BF/CAfvS/nwGJ1xBoN1psMm2Sx4+RGXq6LcNAU4/Ef9XAF1YOK7iOT1Oo0lVqq97xBSs4FhXiPAtMSQ6Mndu3qKSmoF4DP4fJwrs3ii8JaWnXx0m+0eJyOGs3eXpIHLnz0axwBSHTI8MSTRsMZhaR5o94/ALosxJZOC7TzP+Fx7Nf7DJPhhadhS5rZ2CJnng7LQNuTLuCd2ZhtJ3AdFSDKDala8pfbntpz4vsQ1Ka4cj3RAN+sPlWbNDnKkY/gffZP4fL6IUjjcj5GsqCrXNPBKc184GBGvqN3IzdEGuAiNaxecsARhmBNWxDetxEpZC0IliupXB1t1iaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fGkMXD7ArKJzNkxSAwjUUycd3+Fhmuan83YAeQCrbYo=;
 b=rqBJgNEXCffCBzDujtKVtqekKVerjx8/QoKvNRCYdGaQczxR+pOteLBAWHDPefWaxnvKGojUCRwQ+lHY30v+LYQ8WBDBOsVjvk+cfu2uCZdVKetpmRgyfahLMO5JFRoq73O41lmCDVLCaH3Qm3C2Qlb0xb/pif5z6jjcLmbK0MvWzt9ZIdebunmgdla9EjmjBgSA77nOraYzo6ziCxdAkiWUeuipXNH5txhQRf+IuqeUYA77razT4beZo4guls4RVqc+kRt6++rolF3TMw0dknosmR5FQqAn4jOnmz+4C7e0sgPFV5FHuUR+Cog6qd8zq5FD5XTs1SdQP93W67FdvQ==
Received: from BL1P223CA0029.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::34)
 by PH0PR12MB8151.namprd12.prod.outlook.com (2603:10b6:510:299::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Wed, 11 Oct
 2023 16:04:52 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:208:2c4:cafe::89) by BL1P223CA0029.outlook.office365.com
 (2603:10b6:208:2c4::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37 via Frontend
 Transport; Wed, 11 Oct 2023 16:04:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Wed, 11 Oct 2023 16:04:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 11 Oct
 2023 09:04:31 -0700
Received: from fedora.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 11 Oct
 2023 09:04:30 -0700
References: <87y1g9xjre.fsf@nvidia.com>
 <4145D574-0969-4FF2-B5DA-B2170BED1772@oracle.com>
User-agent: mu4e 1.8.11; emacs 28.2
From: Vlad Buslov <vladbu@nvidia.com>
To: Chuck Lever III <chuck.lever@oracle.com>
CC: linux-fsdevel <linux-fsdevel@vger.kernel.org>, Christian Brauner
	<brauner@kernel.org>, Gal Pressman <gal@nvidia.com>
Subject: Re: memleak in libfs report
Date: Wed, 11 Oct 2023 18:52:16 +0300
In-Reply-To: <4145D574-0969-4FF2-B5DA-B2170BED1772@oracle.com>
Message-ID: <87ttqxxi0j.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|PH0PR12MB8151:EE_
X-MS-Office365-Filtering-Correlation-Id: 85cccbb0-9990-47b7-1f3b-08dbca73cd41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	x3f+RyH4ATqTg3pa9IXRDqYimg12a3m1O3dZId3HoAPAQ7z0a0SeJ91zr+kgmfrCA9C8anAs64zgIoDdG6hj/nkmnf8EV2CnOwUx4mv3Oz2VkzB4m2bRVy5yiv2GdnOVdRSvIKoiJpfmVNPc92FS7Jh9H9DNkJ2MypV5n3KJyYCcV2FLNEeBYEq7EWO9ZIgU8P/T0AhVjMZ8XTJuioRPuTsEaErzmelfvL6TcyesyfhEYzjUEnil1P4uAPXnkK42TRP2IxtkMLE8voFdMDrcsf3BLk3bn3XZi4WCqElBCgB5Ss6l/0G1su+RLxsiNR6POkKb8mYHamSWduFrGdI+ZYy9PmsSh/gQEqAjkFiUCrFTpjwTHUDZDLaXhde5uutYTWjTKKGERBgHfGX2+IaYcW3n/VU4Yh3LvmdCMZ2sgDY4G8enW55rqmFsRN9xioKypNhCKxS+WHCEbblCljV4ikxyYIyU9pTt2K5TIapOEW0XCXPs4FiAoTQ2RNFxkmrcYfa2Jb/r68/Lwm3dnMyqVLoeBg+9HA3ZBHb6KZhMCFuLSuCc1l6GMOeg+k3F8T4lmskGwUX0KJrkp9PhkO3nN2iptPBDHE4M7KfY0S8ILt5+INHRiK7EUzBNYgQjveYtW4PvOEBLB/TG7W8a1TGwwiwWSXjZtwoyJBP4K2HtwsAqUQdJIftr30eXKozkei5md+Nx7PARGEi3AMrGXdFgVnCtKSwyegVaS0ZwCrOkPiFHTxoXBSdLAXiVXnkgUAMuSPHmaqCN+YRWd5Bzl72Ywg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(376002)(396003)(346002)(230922051799003)(1800799009)(82310400011)(186009)(451199024)(64100799003)(46966006)(36840700001)(40470700004)(83380400001)(40460700003)(40480700001)(107886003)(16526019)(336012)(2616005)(426003)(53546011)(26005)(82740400003)(316002)(70206006)(6916009)(356005)(41300700001)(47076005)(70586007)(3480700007)(54906003)(2906002)(8936002)(4326008)(8676002)(7636003)(5660300002)(6666004)(36756003)(86362001)(478600001)(7696005)(36860700001)(505234007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 16:04:51.4047
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85cccbb0-9990-47b7-1f3b-08dbca73cd41
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8151
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed 11 Oct 2023 at 15:34, Chuck Lever III <chuck.lever@oracle.com> wrote:
>> On Oct 11, 2023, at 11:15 AM, Vlad Buslov <vladbu@nvidia.com> wrote:
>> 
>> Hello Chuck,
>> 
>> We have been getting memleaks in offset_ctx->xa in our networking tests:
>> 
>> unreferenced object 0xffff8881004cd080 (size 576):
>>  comm "systemd", pid 1, jiffies 4294893373 (age 1992.864s)
>>  hex dump (first 32 bytes):
>>    00 00 06 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>    38 5c 7c 02 81 88 ff ff 98 d0 4c 00 81 88 ff ff  8\|.......L.....
>>  backtrace:
>>    [<000000000f554608>] xas_alloc+0x306/0x430
>>    [<0000000075537d52>] xas_create+0x4b4/0xc80
>>    [<00000000a927aab2>] xas_store+0x73/0x1680
>>    [<0000000020a61203>] __xa_alloc+0x1d8/0x2d0
>>    [<00000000ae300af2>] __xa_alloc_cyclic+0xf1/0x310
>>    [<000000001032332c>] simple_offset_add+0xd8/0x170
>>    [<0000000073229fad>] shmem_mknod+0xbf/0x180
>>    [<00000000242520ce>] vfs_mknod+0x3b0/0x5c0
>>    [<000000001ef218dd>] unix_bind+0x2c2/0xdb0
>>    [<0000000009b9a8dd>] __sys_bind+0x127/0x1e0
>>    [<000000003c949fbb>] __x64_sys_bind+0x6e/0xb0
>>    [<00000000b8a767c7>] do_syscall_64+0x3d/0x90
>>    [<000000006132ae0d>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
>> 
>> It looks like those may be caused by recent commit 6faddda69f62 ("libfs:
>> Add directory operations for stable offsets")
>
> That sounds plausible.
>
>
>> but we don't have a proper
>> reproduction, just sometimes arbitrary getting the memleak complains
>> during/after the regression run.
>
> If the leak is a trickle rather than a flood, than can you take
> some time to see if you can narrow down a reproducer? If it's a
> flood, I can look at this immediately.

No, it is not a flood, we are not getting setups ran out of memory
during testing or anything. However, I don't have any good idea how to
narrow down the repro since as you can see from memleak trace it is a
result of some syscall performed by systemd and none of our tests do
anything more advanced with it than 'systemctl restart ovs-vswitchd'.
Basically it is a setup with Fedora and an upstream kernel that executes
bunch of network offload tests with Open vSwitch, iproute2 tc, Linux
bridge, etc.


