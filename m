Return-Path: <linux-fsdevel+bounces-16872-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE5E8A3E67
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Apr 2024 22:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F7141C20AFF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Apr 2024 20:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE3054FB5;
	Sat, 13 Apr 2024 20:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="S1gt+E5s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2423FB1B;
	Sat, 13 Apr 2024 20:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713039561; cv=fail; b=TJryRx/eUV/tWaJjBRsrcL8WKqNUM+kLzH5KRgi4YIc4EVHjJ3clvQzVF8WPtEpyxF7zNbfv9noO4RSbeV5CSSnjcrRSPk/b/9OppkgiveAQ+CF7BHKukUULZhQhlgetBTlA75Rnx5mTCXz+bOoVoJzQ1Wt/ssMkA4JuKzhLnMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713039561; c=relaxed/simple;
	bh=zGZuhCT5BB2nu0Oww5Quh7YbhDxRC7bMaGOi3wj/Pys=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=G+miTS9hKr4mnK9dOBW0DcX4LnZHTqySaUpdvdWGOMETdmdpJvptC0lrxwFJqwefcTdkXQrp/ZQ/IHTG3DJNGj9drJCBcj+oNotVQ5527A6Ilh8JKRYunZvrGl6GJdnABYcc3i0RIUQf7UZ7yPoEC8o5NAQBFpn9Wh6lXM0NgLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=S1gt+E5s; arc=fail smtp.client-ip=40.107.236.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WjyOuacicaImabQUJAX/6YEdWgNtGFMjIhlrq1Qi9Sn/j/S8b0vn9dVdNH7K4XdKSXZvLR4DNVzZm48HcT9wQ+UgRroak27aiPHncMiSCLR7R5hQXTTqIPsKur/qaeDBQQhx9KwvhigXUQP6CYdQUHDhjrMCUjED08X5p5biUaZHHeZCzlYtawCsVBX18Z02WTVddV1tbFU3MkTxgX8L2PTEB5WpltCQ+tO8SqR8PMayI+1I/+JYxm/gffWbSaLUhGW44/6ZmE1wqKg1nF2+Fzqv2+haT1b16epUQahuT60GRV7cfqCNz6N6OBESkAbR7rC+YfmgcFaDapeyo4ZYUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+3zxVzi717mniQ/Q0oMNOWrjnz0YowOHXKweMRWRf2A=;
 b=QvoZUTmxTTkQ7dSKKgSTBsedeACNxSFGVH8g1cCGlwQPvyBkb7k33lqYC/Cw5cv3T0lC2070Q0D9GKGCbx8ibEdKUl3qAVMkL8Y24HrhPh5UpnnJRcqDCiJqQYITkLLGNZ1zpNb0mmyrpKATCgFAisbcq18EsPJoSk8bTXHwLtUHvlQQR5dil+cQBsl6ETzGiDbT1FLFxLgNkcS0Bw9z9Oj3GGCk1vxPEvNCchX+uZ5V8RkR1AnMVIQftibJCRX1QbUunslaunWu5SIIO9PMSatvLskPeKsGQHuUqMnQadyh0uioH3Nis/lCnni6g0j9/RFdLP+MLcHJ8XSciPcGhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+3zxVzi717mniQ/Q0oMNOWrjnz0YowOHXKweMRWRf2A=;
 b=S1gt+E5sjQ0n/mnP9KindQdJwUd4B/5ET3sFiwYbc2pd1o7VGfYubayqC3Wjp/JNLceLKM0yBPwWXxO4+HoRQLG5Ge+zMgXxskzYL1CTHBMf6o+xLZ7R+/T8/trchy1KC45UfZqwMtHMbgKzF/pE2ldUducqhWXnwDhC02XlwG9ah734Adx2nTr8wNMgAQOEbsEKHS+O5yOYpDc7J5eGJy6/MJEJ1KCnlAN7Ob3c4PkGi3V0LORrHtrCAWGirKulT9k2qN7IQvG1tBTmY/muhtSWCakWoGABH8hBXLuYbTjnbvzFhcNJvOskWnigwdWC0lygNeXVHWh0mDW4zqmS1Q==
Received: from CH5PR02CA0011.namprd02.prod.outlook.com (2603:10b6:610:1ed::28)
 by MW4PR12MB5601.namprd12.prod.outlook.com (2603:10b6:303:168::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sat, 13 Apr
 2024 20:19:15 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:1ed:cafe::a5) by CH5PR02CA0011.outlook.office365.com
 (2603:10b6:610:1ed::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.31 via Frontend
 Transport; Sat, 13 Apr 2024 20:19:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Sat, 13 Apr 2024 20:19:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sat, 13 Apr
 2024 13:19:08 -0700
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Sat, 13 Apr
 2024 13:19:08 -0700
Message-ID: <748fb175-3c5b-4571-9278-1580747a746a@nvidia.com>
Date: Sat, 13 Apr 2024 13:19:07 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 05/10] fs/dax: Refactor wait for dax idle page
To: Alistair Popple <apopple@nvidia.com>, <linux-mm@kvack.org>
CC: <david@fromorbit.com>, <dan.j.williams@intel.com>, <rcampbell@nvidia.com>,
	<willy@infradead.org>, <jgg@nvidia.com>, <linux-fsdevel@vger.kernel.org>,
	<jack@suse.cz>, <djwong@kernel.org>, <hch@lst.de>, <david@redhat.com>,
	<ruansy.fnst@fujitsu.com>, <nvdimm@lists.linux.dev>,
	<linux-xfs@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
	<jglisse@redhat.com>
References: <cover.fe275e9819458a4bbb9451b888cafb88af8867d4.1712796818.git-series.apopple@nvidia.com>
 <db13f495fc0addcff12b6b065b7a6b25f09c4be7.1712796818.git-series.apopple@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <db13f495fc0addcff12b6b065b7a6b25f09c4be7.1712796818.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|MW4PR12MB5601:EE_
X-MS-Office365-Filtering-Correlation-Id: df4664b5-8e54-4f1c-aaec-08dc5bf6fc45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JCG8VNVq3BgIUuqErCw/53Eji52ytM24/Md0+CfvPjXUK7QVKMMhdL9wKkim3ucARZ8HwtviCb08624wWXf+G3EHdbzRcbCM8qi0gjD+jjf1ODv+KQNf/Otmgs7gr8EAQKViendJkpC3v/OzQS8UahdoR1jBWz3Rjs8uXFlspusuKr9Vr5/qMuS3qDElfbjenWzCYpYD7Kzn0sKgXvN00WJ9eF7i/ncIVebuP7eVDRcsInpoEqYJvKHp4zzIFIkcIPyUDRXQq6JYdfgW0VWxCBDv6x/Vxv4LIzc8cTsJhY7hSyvheuBIRzOrOBWlTKKuYPlLfbUf+hpUEguEa1ZF9j+FJWy4C6XjFQwPN1CeCtHvZXVQ6p78poVfPmJbBv3xonqTMDn+m8uCWjE4cdosRG2b5vKJJ2n1VUVyoALamx09vAKBVdbpqXlHM4RzSMP8fe1/bqy1IWFnvE77CxgrcdxR1Kpsd1SpanDWCulEgDMekf8TzFH8NakR8e/TKs4jELzeqcB+HPP7MFqS5QhX/S8QeX2/M5wOyn6xL9ui4uLlcEONAD3bkG0APt5eV1hFY45KAoE+h2iVv4mwIj0C7AiaBpIqHk+OCyhCW66NSZYlKGCP6VrCo4yE+qCQvBkAq4Tc+Fq8qpcwkdMQhHqvAc2eg1yOeIET3o5VvzIa6ouQyoi8sdCOEokN3xxmjpuXYj349NnMpnwyZWQsmY+CVfEy0uNezdtiF+PKOUGA4ACJ19wCudIvoHd5Qf0fScQW
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2024 20:19:13.0711
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df4664b5-8e54-4f1c-aaec-08dc5bf6fc45
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5601

On 4/10/24 5:57 PM, Alistair Popple wrote:
...
> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index 22cd990..bced4d4 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -212,6 +212,17 @@ int dax_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
>   int dax_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
>   		const struct iomap_ops *ops);
>   
> +static inline int dax_wait_page_idle(struct page *page,
> +				void (cb)(struct inode *),
> +				struct inode *inode)
> +{
> +	int ret;
> +
> +	ret = ___wait_var_event(page, page_ref_count(page) == 1,
> +				TASK_INTERRUPTIBLE, 0, 0, cb(inode));
> +	return ret;
> +}

Or just:
{
	return ___wait_var_event(page, page_ref_count(page) == 1,
			TASK_INTERRUPTIBLE, 0, 0, cb(inode));
}

...yes?


thanks,
-- 
John Hubbard
NVIDIA


