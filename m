Return-Path: <linux-fsdevel+bounces-19143-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC178C09EE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 04:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBECF1C2102B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 02:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4190813BC35;
	Thu,  9 May 2024 02:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pe1v3MBy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2084.outbound.protection.outlook.com [40.107.212.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828D51482F1;
	Thu,  9 May 2024 02:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715223273; cv=fail; b=YVAxAL/pRWjtH76ApTA9n93s49TXSvG/e31mKmeGoanKPxIp4MW9BqUJtWcYbFF3Er02QHxaD4UPVQDQzqXuhajFgHDE7kVz5Bqi/N8fApNF1CSURRBMeAMA3R4IFSs533s+BUttaDNbz0WU8862UweQbxd68ds64wtKxU7TEB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715223273; c=relaxed/simple;
	bh=Af0bwK8jDAyjKo+KfQIKG+gby3rSizSZL0i++b5E8X4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IXosMVSgMuw7PYjiwSGeBbpdYP56+T7CmrE85LG8Feh+VYN0IQUROoLmmtvvZo3ufBN3UgXAxgLGC89/dwsgfmUUlrN4vyHBmZyRxUoUbmHOqa+UzFmm6x4A2OZbR8LnJY1RWQZ2p5zebeA856oBWMlWGfUgTDvs+jaHy2FftAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pe1v3MBy; arc=fail smtp.client-ip=40.107.212.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RjYRQZO/OLbG6plIbeEUBAoNG1FL3BwnYsTYVUlv3TXMFweLJMWMUXvmT3cZW5NlebEdhdNsDR1VPAbxCyxEUyL2FPPxRoGiBQNYvy6/AUb+jcLeYilyxT34YxfVQQ5M7/6F1b14B/tUrXmjrooJeOuWRMhZTmz3fzF7X2gU/G2l1iqxpHnRU9Bzg4KUZDVGIzY77vVJTK7b/voYlqEcjDjQBWhOdI8aV0YWef+qLnolWXj+a6zxYJ5J1Ktrpr9AI7ef7pjmuezUZVn+gXNpHWZtqN/QZ8ws+kqx/9415MGmvdXELwEoq2r9UOL2MdVMhoEIViheGMmiJWtLj1apmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KMu85E1vFEhnjajfeuf65Ax23QX5IWrFZs/9KkQ99DY=;
 b=h0f4P0cAXRu8wP1IgBmINzdkb8w9t/BdLijib3NvP/mboqgmroWbQ/Ne2FI9YdL/alwKZFWY2g/5++WSrNU+08jUIaehwUNI8b/3vEDQ8/XIiJKBCr2cioA22GH2SAsh0Ilg7W6xRzA6ru2zpbR0wnDYsFW8xIC4MxXolzfPc3XomhPRTE1xVpB0LONzmbVZlyPKPb2RVdfBoutppm2Tyzcz/Z+x0zhhXXPjSk9JuSY7Le1+LKXdAQSgzsuUmc7+vVhZvt/jDBiWMYgn5SjWb87PmYV3gkN/cAUUXH8/DiP7XTM4Lcnl4xMshH3icW9dXzcz1bApmUDU7idkJpKv2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=chromium.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KMu85E1vFEhnjajfeuf65Ax23QX5IWrFZs/9KkQ99DY=;
 b=pe1v3MByDN6YWKxcP6QxaFzR/5yBuAhATDLzU33BWvjQRB1Ac5CR+jfQwvjNk3UM48z6yDGrlQtBgvgpk4lFOUYTwa1WIKRym3CfUsDnvUO9M+x969KzadxwdLLlGFJptRxMm1Zy1KT9I5xaiTek/2cH1H7ef+sRjc2mFHr1IxGT6dvzVW7WOymHGrjwtY17CiLbFaI19WnT070m3K+r/cBUgSFigLG3OjM0YAFVmDFIQ/Xbx5pIZC+/0SYSxK5C2iFIpxDr+Sl6odk+nqpeUEksODniej5GSCib9AXrgD1kzOYlTuCQNssAgifaMKz28dorsbUn1UFE0AvIgPJvGQ==
Received: from BL1PR13CA0269.namprd13.prod.outlook.com (2603:10b6:208:2ba::34)
 by SJ2PR12MB8184.namprd12.prod.outlook.com (2603:10b6:a03:4f2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46; Thu, 9 May
 2024 02:54:27 +0000
Received: from BL02EPF00021F68.namprd02.prod.outlook.com
 (2603:10b6:208:2ba:cafe::4f) by BL1PR13CA0269.outlook.office365.com
 (2603:10b6:208:2ba::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45 via Frontend
 Transport; Thu, 9 May 2024 02:54:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF00021F68.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Thu, 9 May 2024 02:54:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 8 May 2024
 19:54:14 -0700
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 8 May 2024
 19:54:13 -0700
Message-ID: <1f6a2905-395d-4f81-9ee0-57c541fb2486@nvidia.com>
Date: Wed, 8 May 2024 19:54:13 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] selftests/exec: Build both static and non-static
 load_address tests
To: Kees Cook <keescook@chromium.org>, "H . J . Lu" <hjl.tools@gmail.com>
CC: Chris Kennelly <ckennelly@google.com>, Eric Biederman
	<ebiederm@xmission.com>, Shuah Khan <shuah@kernel.org>, Muhammad Usama Anjum
	<usama.anjum@collabora.com>, Fangrui Song <maskray@google.com>, Andrew Morton
	<akpm@linux-foundation.org>, Yang Yingliang <yangyingliang@huawei.com>,
	<linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>, Mike Rapoport
	<rppt@kernel.org>, Rui Salvaterra <rsalvaterra@gmail.com>, Victor Stinner
	<vstinner@redhat.com>, Jan Palus <jpalus@fastmail.com>, Al Viro
	<viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
	<jack@suse.cz>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-hardening@vger.kernel.org>
References: <20240508172848.work.131-kees@kernel.org>
 <20240508173149.677910-1-keescook@chromium.org>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20240508173149.677910-1-keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F68:EE_|SJ2PR12MB8184:EE_
X-MS-Office365-Filtering-Correlation-Id: 670477d3-a4bf-438b-e61c-08dc6fd3577e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|1800799015|36860700004|82310400017|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TVJSK1VIMlJPUVNsaWs5YVNZdEpHODQ1aVpOZGJJaEMybG9abDdiOHN3cHg3?=
 =?utf-8?B?MERUZTAzcG5UWDUwbC9iVnhwU1lmdHpHT0lTazJZaDN4SzQ5RGtlTytvWjBq?=
 =?utf-8?B?N1J1UHdaQWZzQU84Z0xleU1xWWpsMU5XaERaak1OTGFnTEgrSmtEM3I4WFJN?=
 =?utf-8?B?VUM3VWZyNDJldGZScTNMOTRvTXpnQ1YwMHI3VFVKVzdVZjc1RlB0SWpMQ1F1?=
 =?utf-8?B?VDVYazV5Q1NuNU9ieEE0SkdtaXFldFNlekNad3l4R0FLMGhUUW1GWkpKNVRE?=
 =?utf-8?B?RUJKMDRNaS9VS0JiNmd6TjU1S2h5ZE1NZEl2eHl3MVdmQWVwajBwWFNCbHlD?=
 =?utf-8?B?ZU1uL21yd3J6THZYWENGZFZ1NUpXNklnWlZiNGUxYXhEdTFWVHBuRWNBQmwx?=
 =?utf-8?B?ZjJDR1EyVFVHU2tJYXNXTldwTHFmNnFGWEFyRGcrUUllL2xKb0E4V0svUlNP?=
 =?utf-8?B?U2o2V1ZEcHE1Ym5pTkRtTXpOZlR4RlVGU1NiT3R0MTN3c0RxTWtPWTVoTlRS?=
 =?utf-8?B?VXVac3dCK09LYWxWWjFqY0ozcm80UzlwLzltcFY2TEc3TVdYTHpjM2tuTHla?=
 =?utf-8?B?Uk9VS29ZalJDMGlhL2wvT3NmVkN0dm5sY3pVYzcyeXcxQ01CRFY3bWo1V0Fx?=
 =?utf-8?B?UjB0YUhNR0RScjZsdUk4N1BiWDFiRTJETnZZTHl5TElYYnQ2cU5qRlAvbWND?=
 =?utf-8?B?UHBCNGFRdE41Z3d0QU9KbE1leHQ0RXBhcDYzTXMxUjdEa0ZmazRCUEw5TE42?=
 =?utf-8?B?WGtlS0xEQldDUG5rc0JiVnRsV3dPVXFBVDJkNWp2RVhnTlFNV24wVTJJWWgv?=
 =?utf-8?B?K1E5d2lxMkpiNXAwL1hYbHVFQnU4T1Z1Z01JM2dRcW5FN2J0SDJTdSszZG1m?=
 =?utf-8?B?R3kxMTZhVm1YWDFPSDJyOVJ6Z3ZPL2JwemJSUFNKNUlZaEJ4Z3VWTVB6WEZT?=
 =?utf-8?B?QXJZejh2dFBvM3dJcEpNcDR6QzlKWk5QZTlnYkp0aHUwb0N4dFZ5eHB3MlJJ?=
 =?utf-8?B?bnhFYVREbTIrV2h4eG1NWjJvSzE3TmZnRDJ4b092c0dvSUI1MGluM0tXelM3?=
 =?utf-8?B?dnNXRTlVM3pmMW8xNWhlcUJjdGZuL2t5Z3lmR1daQzVNS2JBaW9ZaWZmbkxY?=
 =?utf-8?B?cUtma1NJNE9GdklMc3JMV2xjaTNXbEVyM3J1VTkzOWRnYXJOaHNhS0VrR3FC?=
 =?utf-8?B?NnFZRDZmT3VDZ1FEODhFWllhTkppTGhja013SURGRmh0K2lSUU1nZmt6SW1z?=
 =?utf-8?B?MFZwT0I1R0lBTXFiSXlNZnk4a1h2bUpBV3NLNzFFWFo1SE02d2cyQVVjVWkx?=
 =?utf-8?B?UE8wMmFWcndSZGIyd1B3QlRqb20ydy9DczVlM3RYK3IzREZRNzA5QmQ1eFdH?=
 =?utf-8?B?VXVtaU9IVENuc2pHQUxldHVQNWtxUERSTjY1eGVyb0ludVlvMGFUaDgvYk9Y?=
 =?utf-8?B?RzZWbVE0czJ1VEd6UUhjMU14SGZzU2RnQi80NkZlaE9tcW92RUVnanErVUJU?=
 =?utf-8?B?bmRCVmwrNFNkekNwMFVWbWhmM3BJcC9sVDdzTnYrN0pPUzlRYnM4a2xCdjJL?=
 =?utf-8?B?bjB1YnNiZjc1dDhQYXhVWUdCMk1lNWRHVnJ4cXJqOGJWdUE4UC9RYytTaDUv?=
 =?utf-8?B?RmpPV3I1MUNRZTNTUjlWcGRxK3JjZmlFN200QnI3R29CWFhqQXU3WVJFN3BR?=
 =?utf-8?B?UzJya0xUdmFveThKOU9uSUZZbjFPN0szR1NoR1IvT24wWkZiNE9FSWU2T1Jx?=
 =?utf-8?B?UWUwYVlQRUlERnRIa1h5VHFqWCtFTGZTRDAzdDlLQlFpZjFZbUtaTGFCYmpn?=
 =?utf-8?B?d3FYZDE0UVRDaTRJYzRyZlhHdi91SWU4eC9VWHg4bndLY1RMaHhIek9kVGxO?=
 =?utf-8?Q?E5G37BLkweuM1?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(36860700004)(82310400017)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 02:54:27.4453
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 670477d3-a4bf-438b-e61c-08dc6fd3577e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F68.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8184

On 5/8/24 10:31 AM, Kees Cook wrote:
> After commit 4d1cd3b2c5c1 ("tools/testing/selftests/exec: fix link
> error"), the load address alignment tests tried to build statically.
> This was silently ignored in some cases. However, after attempting to
> further fix the build by switching to "-static-pie", the test started
> failing. This appears to be due to non-PT_INTERP ET_DYN execs ("static
> PIE") not doing alignment correctly, which remains unfixed[1]. See commit
> aeb7923733d1 ("revert "fs/binfmt_elf: use PT_LOAD p_align values for
> static PIE"") for more details.
> 
> Provide rules to build both static and non-static PIE binaries, improve
> debug reporting, and perform several test steps instead of a single
> all-or-nothing test. However, do not actually enable static-pie tests;
> alignment specification is only supported for ET_DYN with PT_INTERP
> ("regular PIE").
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=215275 [1]
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> Cc: Chris Kennelly <ckennelly@google.com>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Fangrui Song <maskray@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Yang Yingliang <yangyingliang@huawei.com>
> Cc: linux-mm@kvack.org
> Cc: linux-kselftest@vger.kernel.org
> ---
>   tools/testing/selftests/exec/Makefile       | 19 +++---
>   tools/testing/selftests/exec/load_address.c | 67 +++++++++++++++++----
>   2 files changed, 66 insertions(+), 20 deletions(-)
> 
> diff --git a/tools/testing/selftests/exec/Makefile b/tools/testing/selftests/exec/Makefile
> index fb4472ddffd8..619cff81d796 100644
> --- a/tools/testing/selftests/exec/Makefile
> +++ b/tools/testing/selftests/exec/Makefile
> @@ -3,8 +3,13 @@ CFLAGS = -Wall
>   CFLAGS += -Wno-nonnull
>   CFLAGS += -D_GNU_SOURCE
>   
> +ALIGNS := 0x1000 0x200000 0x1000000
> +ALIGN_PIES        := $(patsubst %,load_address.%,$(ALIGNS))
> +ALIGN_STATIC_PIES := $(patsubst %,load_address.static.%,$(ALIGNS))
> +ALIGNMENT_TESTS   := $(ALIGN_PIES)
> +
>   TEST_PROGS := binfmt_script.py
> -TEST_GEN_PROGS := execveat load_address_4096 load_address_2097152 load_address_16777216 non-regular
> +TEST_GEN_PROGS := execveat non-regular $(ALIGNMENT_TESTS)
>   TEST_GEN_FILES := execveat.symlink execveat.denatured script subdir
>   # Makefile is a run-time dependency, since it's accessed by the execveat test
>   TEST_FILES := Makefile
> @@ -28,9 +33,9 @@ $(OUTPUT)/execveat.symlink: $(OUTPUT)/execveat
>   $(OUTPUT)/execveat.denatured: $(OUTPUT)/execveat
>   	cp $< $@
>   	chmod -x $@
> -$(OUTPUT)/load_address_4096: load_address.c
> -	$(CC) $(CFLAGS) $(LDFLAGS) -Wl,-z,max-page-size=0x1000 -pie -static $< -o $@
> -$(OUTPUT)/load_address_2097152: load_address.c
> -	$(CC) $(CFLAGS) $(LDFLAGS) -Wl,-z,max-page-size=0x200000 -pie -static $< -o $@
> -$(OUTPUT)/load_address_16777216: load_address.c
> -	$(CC) $(CFLAGS) $(LDFLAGS) -Wl,-z,max-page-size=0x1000000 -pie -static $< -o $@
> +$(OUTPUT)/load_address.0x%: load_address.c
> +	$(CC) $(CFLAGS) $(LDFLAGS) -Wl,-z,max-page-size=$(lastword $(subst ., ,$@)) \
> +		-fPIE -pie $< -o $@
> +$(OUTPUT)/load_address.static.0x%: load_address.c
> +	$(CC) $(CFLAGS) $(LDFLAGS) -Wl,-z,max-page-size=$(lastword $(subst ., ,$@)) \
> +		-fPIE -static-pie $< -o $@

Hi Kees,

Didn't we learn recently, though, that -static-pie is gcc 8.1+, while the
kernel's minimum gcc version is 5?

thanks,
-- 
John Hubbard
NVIDIA

> diff --git a/tools/testing/selftests/exec/load_address.c b/tools/testing/selftests/exec/load_address.c
> index 17e3207d34ae..8257fddba8c8 100644
> --- a/tools/testing/selftests/exec/load_address.c
> +++ b/tools/testing/selftests/exec/load_address.c
> @@ -5,11 +5,13 @@
>   #include <link.h>
>   #include <stdio.h>
>   #include <stdlib.h>
> +#include <stdbool.h>
>   #include "../kselftest.h"
>   
>   struct Statistics {
>   	unsigned long long load_address;
>   	unsigned long long alignment;
> +	bool interp;
>   };
>   
>   int ExtractStatistics(struct dl_phdr_info *info, size_t size, void *data)
> @@ -26,11 +28,20 @@ int ExtractStatistics(struct dl_phdr_info *info, size_t size, void *data)
>   	stats->alignment = 0;
>   
>   	for (i = 0; i < info->dlpi_phnum; i++) {
> +		unsigned long long align;
> +
> +		if (info->dlpi_phdr[i].p_type == PT_INTERP) {
> +			stats->interp = true;
> +			continue;
> +		}
> +
>   		if (info->dlpi_phdr[i].p_type != PT_LOAD)
>   			continue;
>   
> -		if (info->dlpi_phdr[i].p_align > stats->alignment)
> -			stats->alignment = info->dlpi_phdr[i].p_align;
> +		align = info->dlpi_phdr[i].p_align;
> +
> +		if (align > stats->alignment)
> +			stats->alignment = align;
>   	}
>   
>   	return 1;  // Terminate dl_iterate_phdr.
> @@ -38,27 +49,57 @@ int ExtractStatistics(struct dl_phdr_info *info, size_t size, void *data)
>   
>   int main(int argc, char **argv)
>   {
> -	struct Statistics extracted;
> -	unsigned long long misalign;
> +	struct Statistics extracted = { };
> +	unsigned long long misalign, pow2;
> +	bool interp_needed;
> +	char buf[1024];
> +	FILE *maps;
>   	int ret;
>   
>   	ksft_print_header();
> -	ksft_set_plan(1);
> +	ksft_set_plan(4);
> +
> +	/* Dump maps file for debugging reference. */
> +	maps = fopen("/proc/self/maps", "r");
> +	if (!maps)
> +		ksft_exit_fail_msg("FAILED: /proc/self/maps: %s\n", strerror(errno));
> +	while (fgets(buf, sizeof(buf), maps)) {
> +		ksft_print_msg("%s", buf);
> +	}
> +	fclose(maps);
>   
> +	/* Walk the program headers. */
>   	ret = dl_iterate_phdr(ExtractStatistics, &extracted);
>   	if (ret != 1)
>   		ksft_exit_fail_msg("FAILED: dl_iterate_phdr\n");
>   
> -	if (extracted.alignment == 0)
> -		ksft_exit_fail_msg("FAILED: No alignment found\n");
> -	else if (extracted.alignment & (extracted.alignment - 1))
> -		ksft_exit_fail_msg("FAILED: Alignment is not a power of 2\n");
> +	/* Report our findings. */
> +	ksft_print_msg("load_address=%#llx alignment=%#llx\n",
> +		       extracted.load_address, extracted.alignment);
> +
> +	/* If we're named with ".static." we expect no INTERP. */
> +	interp_needed = strstr(argv[0], ".static.") == NULL;
> +
> +	/* Were we built as expected? */
> +	ksft_test_result(interp_needed == extracted.interp,
> +			 "%s INTERP program header %s\n",
> +			 interp_needed ? "Wanted" : "Unwanted",
> +			 extracted.interp ? "seen" : "missing");
> +
> +	/* Did we find an alignment? */
> +	ksft_test_result(extracted.alignment != 0,
> +			 "Alignment%s found\n", extracted.alignment ? "" : " NOT");
> +
> +	/* Is the alignment sane? */
> +	pow2 = extracted.alignment & (extracted.alignment - 1);
> +	ksft_test_result(pow2 == 0,
> +			 "Alignment is%s a power of 2: %#llx\n",
> +			 pow2 == 0 ? "" : " NOT", extracted.alignment);
>   
> +	/* Is the load address aligned? */
>   	misalign = extracted.load_address & (extracted.alignment - 1);
> -	if (misalign)
> -		ksft_exit_fail_msg("FAILED: alignment = %llu, load_address = %llu\n",
> -				   extracted.alignment, extracted.load_address);
> +	ksft_test_result(misalign == 0, "Load Address is %saligned (%#llx)\n",
> +			 misalign ? "MIS" : "", misalign);
>   
> -	ksft_test_result_pass("Completed\n");
>   	ksft_finished();
>   }



