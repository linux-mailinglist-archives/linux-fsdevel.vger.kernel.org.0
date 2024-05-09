Return-Path: <linux-fsdevel+bounces-19224-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E89C68C19DC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 01:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60F7E1F23030
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 23:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05CA12E1E5;
	Thu,  9 May 2024 23:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H2X7NnAr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D1A86245;
	Thu,  9 May 2024 23:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715296636; cv=fail; b=sLID+R5SOaLj2Ba7Q0BeX7W0sGvgx2FRmYXQq3KPfPnAie52AmrdeIppG8G2YX+XxRtxU5ZIF1L34DapGlG2cfhsjiqzsy6wThkd3MuYu2DYSTxlpoj08120XwaQUhksPQE+0VQGlFYhIjrxeDyHhDepmiAi9LViuWH2OLUWrRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715296636; c=relaxed/simple;
	bh=UXA0JCyv8OMytZ0H4i06/TD8Z1/xe+Qc6wWGl7au9tk=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=alAt+GOhFt6dO7sAJoCGxOpubvx+QNsnN5rzw95tm/5qSr8dqEfwW/WRfDMViS9DpWziQyvvpnyfFY81rYnofALGs70ZkpY1A2hQq0w3uaQdgpeCw1pNNdsh7Hbqs3zG5i4q7QKYDZqtNuCLlOnVNrNsG1D1KHoeWPC+OE/Svg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H2X7NnAr; arc=fail smtp.client-ip=40.107.220.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mv+S4oT5btdaf5NTZadCO5czyKKH9CnUvHSw+u2wuEVqsK2dHTBulOYv6M67KoQwnj1KOnqMJFfMSTMhvdIIUOqTK7KVATe+07mznM3la/bkJQ+YAsVN2CWW4ZyrNeyEVX2DjRCuVd8bnhSFcews4d1a3SUPb5vOno5cJaxc5gFDXAkzRL34kguq32R0Nadx9c9F/EVjy/lH2RjM8UWJwAEvgxmRA55p+h96Gx7TlxWoNO6rVauv+x0SwDNsFXA6MEYeYo0DzSrqf0hiargCaIL0ZDE8BI7v9tK46HlwL3lodeAtY11SI5YFnWtzkVjivfbQjg49lRrvbgn0CVNU5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e/Y5qOLxo/jkhM4Q+Nn05n7/V2zeCTIldtJW8h/fXAE=;
 b=h4A7E+icJ5sJuuNXwtxVJBSl3I/murR/DNkCPoBQekq00+tZjq88PzHE0oaJQldGaVM4TUQHBP8PwN5RXjoK0I03SucNTiJuA+E9DJmdeeYBupLjS13fK9m9l5PTZJ8L71HkG9k3BsmEe7F99cNgjmMWvKfHb3V/iGrBW8/s+FutZncSPyrSsaiMkgasC9Id+HgtBfAvI7r13gVjGPvN5mgGDb2bVlbn9HFWo76zi0Unrw9Xf77igC/IPPwEbtxF4rUDHRT3Bqgk/Xl3rcJLi8UNqjqfeC7yqA9XPqNFVXgsmyEBGwp7+rZQYrRprS+BDFMdQkCOFk4AIY+EOBSbCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/Y5qOLxo/jkhM4Q+Nn05n7/V2zeCTIldtJW8h/fXAE=;
 b=H2X7NnArYlDnzbGwzi5WOGGVX65zMi0Q9462d4EGXv0jKfOyZclar1K1UwXH6VWsZ/scl/+eEYMih6mWxmP232koKHIkyc8YzLB1ybq0d4vGCoczA9nPV4a9kazjMEnmnndnI0fWwRTubgRMnQmruBUtMWgWuIDy0Xv6g9LtH2+/hJ2cJ1D+uEZsYnobfIsr7TV69/64Mmzc/ZoeggyfWthLyRz9APi/FLuJM1FT4p2B+vRL1Ollx8b8ZlVEbuwG7kSlRFC9Vnw+26wHtGc1t3KVErDfZ5iMORK/72ibE2Fby4deaGPjdbRLIOsykphS+qNlCC7NFscVmbM8IqpZYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CH3PR12MB9343.namprd12.prod.outlook.com (2603:10b6:610:1c0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Thu, 9 May
 2024 23:17:11 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::80b6:af9b:3a9a:9309]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::80b6:af9b:3a9a:9309%7]) with mapi id 15.20.7544.045; Thu, 9 May 2024
 23:17:10 +0000
References: <cover.fe275e9819458a4bbb9451b888cafb88af8867d4.1712796818.git-series.apopple@nvidia.com>
 <a443974e64917824e078485d4e755ef04c89d73f.1712796818.git-series.apopple@nvidia.com>
 <4393e0d9-28c5-4b85-b603-40e457c9beba@deltatee.com>
User-agent: mu4e 1.10.8; emacs 29.1
From: Alistair Popple <apopple@nvidia.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-mm@kvack.org, david@fromorbit.com, dan.j.williams@intel.com,
 jhubbard@nvidia.com, rcampbell@nvidia.com, willy@infradead.org,
 jgg@nvidia.com, linux-fsdevel@vger.kernel.org, jack@suse.cz,
 djwong@kernel.org, hch@lst.de, david@redhat.com, ruansy.fnst@fujitsu.com,
 nvdimm@lists.linux.dev, linux-xfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, jglisse@redhat.com
Subject: Re: [RFC 03/10] pci/p2pdma: Don't initialise page refcount to one
Date: Thu, 09 May 2024 16:14:32 -0700
In-reply-to: <4393e0d9-28c5-4b85-b603-40e457c9beba@deltatee.com>
Message-ID: <878r0ivamq.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0109.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:20b::17) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CH3PR12MB9343:EE_
X-MS-Office365-Filtering-Correlation-Id: 5175b1aa-c00f-40eb-60c4-08dc707e270a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JewIp9HoBv1Dv5gQsltACQFTfrUxP2II8z5L401H+oHRC2Zreq2+ByR+H1Qp?=
 =?us-ascii?Q?VS2cWa8YOo/0mYJLlqtk3kSeMtX1gSvfDrmJfsUY/8UPfAyVnp3tEwTTFkbI?=
 =?us-ascii?Q?xq6yYzz6ded+yNDokjdOnW0FVWSfATdxMkXHgyEXRcIjZSju1swdpmE9gwIn?=
 =?us-ascii?Q?F9JsIVriIJN/6UGW47LlQFWFo6HXV6BaxGL98HDUfYnQCxl9Q7oPMk4tgNQD?=
 =?us-ascii?Q?xGNXvJe0CcFFeCSSzsyX9A+jPZMFW+gwb/5WCB0qecIVuxe2CX7miKTcp+LH?=
 =?us-ascii?Q?cv7Zd+x9r+QmmFBRUkKYi1jofSeAOmAIsTxvlJe/rvf298rAgCFoIBGqHNx3?=
 =?us-ascii?Q?COffjbuknN8ONKXsIE8KZd7IG2xEPg00iG9qWseHFtcwOc2/WsH4e1heHQOS?=
 =?us-ascii?Q?BPUpB0PaBqLQMct17J6BueaO+5WTD45KjxuDfUnjF3W+uJstbv5zS7uFvzxr?=
 =?us-ascii?Q?azLfc7dUzSqNI8Tkoa88OgTCvke0kLPxb7PWb7mi0bJibrgnWdK4dDawQ38z?=
 =?us-ascii?Q?7BH/FwaEG86zoJ8NKWF+zbsPM2kS/HMmNVggx+SSbGmXm5zoCxAk23g55oFQ?=
 =?us-ascii?Q?Q2Te/CKL1/sHr96vshTfRAHHHJ1TsfsdLhLcfW68jo7uS6NJvdRAFJInq6kE?=
 =?us-ascii?Q?fxbzpe9Jsa0uScfgX0hAR/xE85WfxONBGsyvmXuqI68SiiDIzDQdHY4/IQ3R?=
 =?us-ascii?Q?jCD8D29E/yvgETnLgqCKLHUWX+BgKj8G5CIYxCAsGIgDdNhhLSobP0+4gDT9?=
 =?us-ascii?Q?w99hrMqBVU2fIb2FX2AoxwnzNdnEykvff6QMoI9op6a0YNONyj5V3RYkRCd2?=
 =?us-ascii?Q?JArIc2f12WDSEEFvjJoo8HbwnK5WKuI22PPmhL1GnHWKMYpnsHmYBA3+Ip1z?=
 =?us-ascii?Q?3mZaGHo7O4EK9JWw5JEmk537wMzeUq+O45tNo6g0AhWak2FVeBKXevi4wx3d?=
 =?us-ascii?Q?7eFPvP6hHtMv2OEXuF85s1lHdIykv75d2JAO2q9nS3FXeUPyyKUQ+9a54XMB?=
 =?us-ascii?Q?wEKE3EsWCwfxV13bNzvTVKY9E7pdWw7OKG9ZTFcoSYCpjh6mBN9ssNqp6GgO?=
 =?us-ascii?Q?jQU403Vh9nRWeSB9cjai6D6uJ2za78ZdapQvPXof/wvXLEV3u1N1Qe+lEZtv?=
 =?us-ascii?Q?DVQZ+67AF9q8JYt2/gWXqQ9vzzwCa1+Eq8l0S6iYHeeHPVds4i5EohVIjPkA?=
 =?us-ascii?Q?1GfvbGibJn1F0U/I+VotNEw+u5k6a9rY/8dcEsSktho+uQxX3tq12kZICiLO?=
 =?us-ascii?Q?YAfmzhgj7rEreuj9RtSLeLe8wxpHTJiRfJo1g5YtTQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zMWkF/hsQPKaZmh832wf/RlFtcGW3dYm8B8bh36PnBK01mrUkBE/RbKZQe88?=
 =?us-ascii?Q?vWROHZVinsGPgoKsWE2W312GVapB7v+04RXtHuwAIennd4MqjA5+/5AbugR+?=
 =?us-ascii?Q?1eytwh8iB6zp4BCvybMcvTfrXkR77SZdahFibpfKE8/bsMs6XXGBZr+qucjs?=
 =?us-ascii?Q?w0bntH5jtE8jlJAmbOit4jgysTfaNJa+x0W9gu/gqsctycX0jc5GGV7vFuE6?=
 =?us-ascii?Q?t2HBd9cqCTaEznatKGCqNm5UlECJq/9u+Xp/bPTOAdoKqqx6++sUrnX31kwj?=
 =?us-ascii?Q?+pVzYK16gH9NalNhwcRQjapE9N+SQL4imjRUF0WkVHkrvw3KCmt0XCJ+SjBU?=
 =?us-ascii?Q?fDBoOyvEvGNaOoQZoGScttWQSWxUxIR0FIzLNzSdoEGso96vqSsyYcLONaMD?=
 =?us-ascii?Q?gx9AKZMNWuNj7vU3JC3Rw6CYzydugXqmdbLHE6AZqLWzNcujdsD4sks086Yn?=
 =?us-ascii?Q?Y3DeDzBrTTneiA1BRYcVsGjBM9QQ2hdO5z1SMPOjc6Tjjids/ZQKEs1eMZc6?=
 =?us-ascii?Q?fjy7R+nemNFbX/ItIgQBD7PszprCOQ5+uoG+IMMnIGRhwjmZkkZvnfeBUvT6?=
 =?us-ascii?Q?vUDHKXaWA43FdNP1hS3XEPw6xDfvUEfet/Tt9an40/BKCv35EPffHdLq73oF?=
 =?us-ascii?Q?TNzg2/KCmCOWHW/zXZyQuDRIrThlFet+JmF6vGLAkR+PNhBmjb7Du9nAEDc0?=
 =?us-ascii?Q?hFZWVra6e8CvzqT+ApAu/y6IB2baBTMvwmAcZflrcVHCucshiRp62TWtBXhf?=
 =?us-ascii?Q?Q5vKvrOouSy9V5vjMMmci4k15bKuEV4dc/hGdbzGzDwOEBCtZQfpM8Ds+pRM?=
 =?us-ascii?Q?5o5ll23Kiul1s8UJl+yVnHIcXtX1ufuhFNIBwMxDvZCCnq9BhcrMgcDuHOWN?=
 =?us-ascii?Q?IjUR6v2UBLbRw6SUqomcnGRVCRx/wgr5X2cO57Z40czRG6ivcv+Ap2z4fWGP?=
 =?us-ascii?Q?Ah/RHCOyMzJI1a/s1bAj2T6LAqkOyrHzUslvpIeFG3pDSaqTOE8oRIFXyl45?=
 =?us-ascii?Q?Bkser+3WgwF70GUo47CiDqwxwvyNmAP9tER7kfMFv+LHe1pH7rDyFKs2LpgU?=
 =?us-ascii?Q?zMWB+scq1eOnf9GCcrLHxielZwOPRSukr9ug0+Nv+MztklOErXcPwTvCCsPY?=
 =?us-ascii?Q?WhjNyAbFeqJ0AU91AM+sitWi4c9qpZUGVF5F0b/Dmm+QT50CP+5EZG1gRa0r?=
 =?us-ascii?Q?EFkQ0YqppO0sZRnpBVigPxKEv1A5k+U3EMWg34w858KY+VjdXOFdQ4dqIG7w?=
 =?us-ascii?Q?rZWMTznPR6ew6rkyYQng840HVMy86gOgYMwolbkxaYj4Yrj11xpvBB+fPua1?=
 =?us-ascii?Q?Xdpw6MyEmsx/QHEn7NZV5jOVOOuU9+j+LFYiGc5OdQw+17oYnzZCPLYmLDGi?=
 =?us-ascii?Q?tGHivxfKNP1gU2Od0isu2FlyF9tss2Okvm9unG71p3yxyhYIIE/QBg8iBUPv?=
 =?us-ascii?Q?7sBEIS8Fof2ALcMxQBR4IUxqBnnGiLZr46uqW8VH71trWhJ4/xlEbBdMbqqQ?=
 =?us-ascii?Q?gcOQ6AijsN+T1rdOe1Mof7p3HE93RV/Db71uDvA32Vl+SjwhyIt2IfP2iS0u?=
 =?us-ascii?Q?rc/aVVj+btTvHLG/WVNOsEoegyqGWJdZJ057JXYJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5175b1aa-c00f-40eb-60c4-08dc707e270a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 23:17:10.5071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O7Kr7ufd8utlvWeAZTDxRUq6fOYV1BGqrI09i9yR/C5HG2I23iqrRibKZo7KX63VAmFgYEdeBbKxb6GqFhVUdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9343


Logan Gunthorpe <logang@deltatee.com> writes:

> Hi Alistair,
>
> I was working on testing your patch set, however I'm dealing with some
> hardware issues at the moment so I haven't fully tested everything yet.

Oh great. I haven't extensively tested the p2pdma setup yet because I
rely on a pretty janky qemu setup to do so.

> I managed to find one issue though:
>
> On 2024-04-10 18:57, Alistair Popple wrote:
>> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
>> index fa7370f..ab7ef18 100644
>> --- a/drivers/pci/p2pdma.c
>> +++ b/drivers/pci/p2pdma.c
>> @@ -128,6 +128,8 @@ static int p2pmem_alloc_mmap(struct file *filp, struct kobject *kobj,
>>  		goto out;
>>  	}
>>  
>> +	get_page(virt_to_page(kaddr));
>> +
>
> kaddr may represent more than one page, so this will fail to map
> anything if the mapping size is greater than 4KB. There is a loop just
> below this that calls vm_insert_page(). Moving a set_page_count() call
> just before vm_insert_page() fixes the issue.

Good point. I'm in the middle of respinning this (I was hoping to get it
done before LSF/MM but I suspect my travel will preempt it) so will add
this fix.

Note that there are problems with both fs-dax and device-dax in this
version which the next one fixes, but any p2p dma testing would be
appreciated. Thanks!

> Thanks!
>
> Logan


