Return-Path: <linux-fsdevel+bounces-900-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE257D2AE5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 09:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E155A281465
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 07:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289D479FF;
	Mon, 23 Oct 2023 07:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bOSdL+WD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927B81FAB
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 07:08:52 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A851A8F
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 00:08:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C1J7tIzG/lDASV07vrtPn/OImK2Kj4Kh1ToOd6VCJenB6jFAX0hHWAMZFymeeN/nAcClithgfCBqZ5WCMOpem2bnZIqh5QQomenF+YgNloXjDqyVzxyIT825eeESAT1Ix72eUM4irb7s+FB/ln/0lFl9w9a2APJ3EYPSaTvULS3SP7TgP72MCr60PMhhkkm5ChLjcGllCfT7xTOaFVMnyr2UNdBQaV9vOeGb8HOmcYlK9QgvRRigqdktBcuopmCuHkLkak/Xr0uDUPVCt7vIvVejhF8HYRjlE5CzQKPWBGlz9sEkSlgbyYxxfslKGm9dJ333/4uRgaYOKUgKb+xjaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kOR8bKhHEPgJUGIDOUHG0RFpJ8FZkZRxGh3OOPtk0NE=;
 b=b+6zdiHUS5FraZtj1dAJEHmkA04HOvdh9Y64X53q5kz1d+iBhA+rlzSDV7a8W3VTLDTvFsYrpdjIpA0f5PFJjRcvb0wwP9yZO6ag3Bzu1gsqZ5OPB3XPGS651Z2Owa38Gzh94qiaFj5wjfoBzmQ+WHmnPe4ixCph+ERYaIFWJOHONeeSj+q9iLebG+AbsZH13ExKb2BN31NjZqJAHX9b+WZwL6rEYup/gJ2uxR8y6MFZtaCMWWpXAdI89vyzb7j6eE4lrrON9ChoRNaydMrkC1sawWvB1/25TEAynbIWl1ZMrgRcj1Z/dlhvQ1C8gfjJnkJCMn7k/YXpcxQPB/YMVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kvack.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kOR8bKhHEPgJUGIDOUHG0RFpJ8FZkZRxGh3OOPtk0NE=;
 b=bOSdL+WD1r4wF9ZjV595q1SBBIWW8BcWVQMfBfJ5awHkxkqNC3UiuX8y1oLwIXUa21O8ygCwHPxmANMrPianfBRZxpgOZZhBKYeTdIbczPRafgI7PbKYyNNuj18oQp92CHN4OEzWjdoCgvXQmTQbXAkivfdo8LvMX/hQ6aufOT25S1ggzhTNnG3uQWeUYhTeCUIobQwdV78JagRwlyk1vYA0JQI9ts+Jk/OKrlsEvi0Kn3d6fJDT4LJW27UwHc4hoW4gsJEFrGIhpOpvdycJHyNgvj+c2EWRY2l4CxHnbrnYzL7oo2LMcXq+eC6AU2T4eHHJ5IM11RiW9QUfnq4r7w==
Received: from SJ0PR13CA0019.namprd13.prod.outlook.com (2603:10b6:a03:2c0::24)
 by IA1PR12MB9061.namprd12.prod.outlook.com (2603:10b6:208:3ab::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Mon, 23 Oct
 2023 07:08:48 +0000
Received: from CO1PEPF000044EE.namprd05.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::70) by SJ0PR13CA0019.outlook.office365.com
 (2603:10b6:a03:2c0::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.14 via Frontend
 Transport; Mon, 23 Oct 2023 07:08:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044EE.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.15 via Frontend Transport; Mon, 23 Oct 2023 07:08:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 23 Oct
 2023 00:08:39 -0700
Received: from fedora.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 23 Oct
 2023 00:08:37 -0700
References: <87y1g9xjre.fsf@nvidia.com>
 <4145D574-0969-4FF2-B5DA-B2170BED1772@oracle.com>
 <87ttqxxi0j.fsf@nvidia.com>
 <366CAE3F-455C-47E2-A98F-F4546779523E@oracle.com>
 <04726AA0-474D-450A-93BC-8BB03AB6C8B3@oracle.com>
User-agent: mu4e 1.8.11; emacs 28.2
From: Vlad Buslov <vladbu@nvidia.com>
To: Chuck Lever III <chuck.lever@oracle.com>
CC: linux-fsdevel <linux-fsdevel@vger.kernel.org>, Christian Brauner
	<brauner@kernel.org>, Gal Pressman <gal@nvidia.com>, Hugh Dickins
	<hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm
	<linux-mm@kvack.org>
Subject: Re: memleak in libfs report
Date: Mon, 23 Oct 2023 10:07:25 +0300
In-Reply-To: <04726AA0-474D-450A-93BC-8BB03AB6C8B3@oracle.com>
Message-ID: <87ttqhq0i7.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EE:EE_|IA1PR12MB9061:EE_
X-MS-Office365-Filtering-Correlation-Id: e9f9d9d0-5b09-4ce0-2028-08dbd396e6db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zch8LgODzCkPavjN+70rCUjDgC9bFJQTB0hk90HASiy4NPtM00KeqtTvPOno6fDX20hrb9t2DfWOUzkG3rlVNzarzxJ1mclJ7aTQXd4WSqKL7tjoaxZyet3cMpLeba+GLa09CRsaiKQv577u/LT+r6RSnBPMKOpdcc+TPlZLiSW7lp282iy6cmSBNRL9J57hmc0XKbRbmV5LKdqH/aUP1B2sVlJj/y0naPXDW3fGpJ8sJleWp6cVPEHXmdEOw9ra600kJ6Uh4hvh4jP+KHVZ6hv0oUlOuH0ln/pywqFT00R8Y3fAlFywIFTumgp6hWvUkAIMp9BcMZdTKs0fJ3gpX5UZkiJen5+uHiBa8eREHYPxcIjzTWAwCWxhdxgpusOWnwPfHnmeR7oEsTLQEnU3oFYHO+w8FJ53Tn7mDYcUY60tyYS6VUQ8I6Wkyak//yQx7Y38J2vrDJKGGJCho2jjTW6q/Z3ijLdmW2pF/Vd9LocjaAxkBExzF7tawSKkSt5O9f+/3YGZaPUnu58yZoY5Wa8OCYYXObJWS4p/BYq6RSVH5ytYtJxUkgJTGiUKjDiRRo3xcZGObmI3aCXpfJups6s8pO/uZoKw8sYxLd3FSWp6evsAa3Kyz/I5bfBxcs4v9lSYsn8v4Rn8hRrEB7gm6Ep32SKtJQavf9aNELV0X9u35psQUJ3L1gP9yFmxKO/WQY+vcoZ7baVxvhEH1qB2azAKFN/xJXHAz6MmxHkuHGo7zu+udXaYucszZ2vHiPL8hoNbnGqXyF5EWcxj2UK7fD7BLk+QA1Evb6QAHjVn2zDCTwFBsdaWeLXvKYGKSr41
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(376002)(136003)(346002)(230922051799003)(82310400011)(1800799009)(451199024)(64100799003)(186009)(40470700004)(46966006)(36840700001)(82740400003)(86362001)(3480700007)(36756003)(40480700001)(6916009)(40460700003)(316002)(7696005)(5660300002)(356005)(41300700001)(966005)(7636003)(8676002)(2906002)(53546011)(47076005)(336012)(6666004)(36860700001)(26005)(70586007)(16526019)(426003)(2616005)(54906003)(8936002)(83380400001)(478600001)(4326008)(70206006)(505234007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 07:08:47.3795
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9f9d9d0-5b09-4ce0-2028-08dbd396e6db
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9061


On Sun 22 Oct 2023 at 23:28, Chuck Lever III <chuck.lever@oracle.com> wrote:
> [ ... adding shmem maintainers ... ]
>
>> On Oct 11, 2023, at 12:06 PM, Chuck Lever III <chuck.lever@oracle.com> wrote:
>> 
>>> On Oct 11, 2023, at 11:52 AM, Vlad Buslov <vladbu@nvidia.com> wrote:
>>> 
>>> On Wed 11 Oct 2023 at 15:34, Chuck Lever III <chuck.lever@oracle.com> wrote:
>>>>> On Oct 11, 2023, at 11:15 AM, Vlad Buslov <vladbu@nvidia.com> wrote:
>>>>> 
>>>>> Hello Chuck,
>>>>> 
>>>>> We have been getting memleaks in offset_ctx->xa in our networking tests:
>>>>> 
>>>>> unreferenced object 0xffff8881004cd080 (size 576):
>>>>> comm "systemd", pid 1, jiffies 4294893373 (age 1992.864s)
>>>>> hex dump (first 32 bytes):
>>>>>  00 00 06 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>>>>  38 5c 7c 02 81 88 ff ff 98 d0 4c 00 81 88 ff ff  8\|.......L.....
>>>>> backtrace:
>>>>>  [<000000000f554608>] xas_alloc+0x306/0x430
>>>>>  [<0000000075537d52>] xas_create+0x4b4/0xc80
>>>>>  [<00000000a927aab2>] xas_store+0x73/0x1680
>>>>>  [<0000000020a61203>] __xa_alloc+0x1d8/0x2d0
>>>>>  [<00000000ae300af2>] __xa_alloc_cyclic+0xf1/0x310
>>>>>  [<000000001032332c>] simple_offset_add+0xd8/0x170
>>>>>  [<0000000073229fad>] shmem_mknod+0xbf/0x180
>>>>>  [<00000000242520ce>] vfs_mknod+0x3b0/0x5c0
>>>>>  [<000000001ef218dd>] unix_bind+0x2c2/0xdb0
>>>>>  [<0000000009b9a8dd>] __sys_bind+0x127/0x1e0
>>>>>  [<000000003c949fbb>] __x64_sys_bind+0x6e/0xb0
>>>>>  [<00000000b8a767c7>] do_syscall_64+0x3d/0x90
>>>>>  [<000000006132ae0d>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
>>>>> 
>>>>> It looks like those may be caused by recent commit 6faddda69f62 ("libfs:
>>>>> Add directory operations for stable offsets")
>>>> 
>>>> That sounds plausible.
>>>> 
>>>> 
>>>>> but we don't have a proper
>>>>> reproduction, just sometimes arbitrary getting the memleak complains
>>>>> during/after the regression run.
>>>> 
>>>> If the leak is a trickle rather than a flood, than can you take
>>>> some time to see if you can narrow down a reproducer? If it's a
>>>> flood, I can look at this immediately.
>>> 
>>> No, it is not a flood, we are not getting setups ran out of memory
>>> during testing or anything. However, I don't have any good idea how to
>>> narrow down the repro since as you can see from memleak trace it is a
>>> result of some syscall performed by systemd and none of our tests do
>>> anything more advanced with it than 'systemctl restart ovs-vswitchd'.
>>> Basically it is a setup with Fedora and an upstream kernel that executes
>>> bunch of network offload tests with Open vSwitch, iproute2 tc, Linux
>>> bridge, etc.
>> 
>> OK, I'll see what I can do for a reproducer. Thank you for the
>> report.
>
> I've had kmemleak enabled on several systems for a week, and there
> have been no tmpfs-related leaks detected. That suggests we don't
> have a problem with normal workloads.
>
> My next step is to go look at the ovs-vswitchd.service unit to
> see if there are any leads there. We might ask Lennart or the
> VSwitch folks if they have any suggestions too.
>
> Meantime, can I ask that you open a bug on bugzilla.kernel.org
> where we can collect troubleshooting information? Looks like
> "Memory Management / Other" is appropriate for shmem, and Hugh
> or Andrew can re-assign ownership to me.

Thanks for investigating this. Bug created:
https://bugzilla.kernel.org/show_bug.cgi?id=218039


