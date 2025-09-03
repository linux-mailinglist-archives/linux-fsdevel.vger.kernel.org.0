Return-Path: <linux-fsdevel+bounces-60176-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23138B42715
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 18:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4BFC583A45
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 16:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78891307AFC;
	Wed,  3 Sep 2025 16:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C/8N4OHP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2073.outbound.protection.outlook.com [40.107.100.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC4A29B77C;
	Wed,  3 Sep 2025 16:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756917649; cv=fail; b=PsZlkPZykAwpzN9uWTZ6Fe5RZNEPaxHqMCMoGmeTQpFHFfDldSrnBWpXOrmBd9A/U3irLi3MA1evSSwRtZsLzY/kZumRj527SY8aJDz5MdNiFrFhDPFbHY2Bhb6kCgwPs3/2V62JCrlDpq7RcaEzTVrssFNBcBuQ06rd8t2XnUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756917649; c=relaxed/simple;
	bh=avLePlBm5KxQSsuRfsl6G7H8sXx7VNF80jLTChR0HPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jdSD4ymky8w5KmrB8Njx/K/S3oGFDD8a5wz+gNK2Tw4MNUKfxCRaFGhcctD/+OtwPN2d8m0fg2SrTDpY20ZE/A3ZOwvB/KS2QMSQwQKg1P9i9+J0IBu3zOVPlU2/z8DA1yGT3vghSYN8lxwjPIdYVuknRyA4SfwtHb0qXt8Yi/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C/8N4OHP; arc=fail smtp.client-ip=40.107.100.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lf/HKKGZtGrQ6xmRd9Ghp4Zj2zFuX+aupAvrGFHRr/SvY/Zts/LvqzlMRM6yoxqZEkDgAWFD/Y7ZqgwetzpanJ1Y6T7zc5dNAbnpx8+5WGdaWmMn+ZKBM3Q/AbjFwlk90eo5awqGtu7T9pAdlWDBD+Xoa8R9Tzs101kisKMuJYuBBgPa10YBv97xTXSreHX50l2uK6tyaOjgjyX5oCGFbvFoP3mRMPs5KDQfP9frFRrJbXRQrUiI97d6hbny9Hz8dRN4tILz2ptjdJ8o5xJqvA0sSx4ZT3yUi6Y/DbH0Agww4NiNmTwo6CFprAGTi7UGpBTDh6gI89cxXfE6+HOy9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iPFzQ9JdzDYqsk9c1ou9gST5eyP0KXfXNIp3tPEVDPE=;
 b=lBHhbzOm94HRD4+XFaaZkEEqhZD57TdjaMKx5ErxeKQhdOvMUYzEnVyk4dqP2MUR7Kaze7Zx4wDs0FYdN4Of04QljXVj5M0cn8dSu3DVDrjNoeyIJ9DXPLz10DNP+Eq9XnPgAPz5Lc4vt3m+KLianJttLgxOsJLYeDWZC7gKoiuOF3DzwJq4HIO8qbbX9cmEE0e5B4o9rkpUgrEw4J38Qu2mKz1ftotHruP5LzXvQlLn3xq8TUi65aPkWl0QVIACBDljbGL5PvedZ70D9xLtHgA9JpTA0PGrTo5TfYcflcKT1Kn9jDXPT8fu5PVKmRO+YEK8lqpH8Tsh8rPhHPfQFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iPFzQ9JdzDYqsk9c1ou9gST5eyP0KXfXNIp3tPEVDPE=;
 b=C/8N4OHPR7E4dtrcaapFePc1QjSZtAKklnm0SOGo0qZIhYDq57d6C6XnXQJASj1oT2tnHHpgNgry12ohsv1/sRyq3+34UUfSG8+oS48yn2gQtvm69nllBJL4wP8xkaiqtXyTZfjql+ON8P+vvCxD5ODWof6gKFTlQqIeKTotz0wbVb1LbHFoeoetvu2VbkgNvaq7mucnjKYpxAv6QZJGkY6UrxGy0b6upYf8IJMpuzs3yXsrbdrtrk2g7lT4mSP3ewMRuq04+8yvXQKAWnvdv2podl1003ORx800SZiu8GQKpcqYuNOxVck+eHSbN0re6kinZZmWnGshknoQnpW2uQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by MW6PR12MB8915.namprd12.prod.outlook.com (2603:10b6:303:23e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 16:40:44 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 16:40:44 +0000
Date: Wed, 3 Sep 2025 13:40:39 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, Mike Rapoport <rppt@kernel.org>,
	jasonmiu@google.com, graf@amazon.com, changyuanl@google.com,
	dmatlack@google.com, rientjes@google.com, corbet@lwn.net,
	rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com,
	kanie@linux.alibaba.com, ojeda@kernel.org, aliceryhl@google.com,
	masahiroy@kernel.org, akpm@linux-foundation.org, tj@kernel.org,
	yoann.congal@smile.fr, mmaurer@google.com, roman.gushchin@linux.dev,
	chenridong@huawei.com, axboe@kernel.dk, mark.rutland@arm.com,
	jannh@google.com, vincent.guittot@linaro.org, hannes@cmpxchg.org,
	dan.j.williams@intel.com, david@redhat.com,
	joel.granados@kernel.org, rostedt@goodmis.org,
	anna.schumaker@oracle.com, song@kernel.org, zhangguopeng@kylinos.cn,
	linux@weissschuh.net, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org,
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, rafael@kernel.org, dakr@kernel.org,
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com,
	myungjoo.ham@samsung.com, yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com, ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de,
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com,
	stuart.w.hayes@gmail.com, lennart@poettering.net,
	brauner@kernel.org, linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, saeedm@nvidia.com,
	ajayachandra@nvidia.com, parav@nvidia.com, leonro@nvidia.com,
	witu@nvidia.com
Subject: Re: [PATCH v3 29/30] luo: allow preserving memfd
Message-ID: <20250903164039.GI470103@nvidia.com>
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <20250807014442.3829950-30-pasha.tatashin@soleen.com>
 <20250826162019.GD2130239@nvidia.com>
 <aLXIcUwt0HVzRpYW@kernel.org>
 <CA+CK2bC96fxHBb78DvNhyfdjsDfPCLY5J5cN8W0hUDt9KAPBJQ@mail.gmail.com>
 <mafs03496w0kk.fsf@kernel.org>
 <CA+CK2bAb6s=gUTCNjMrOqptZ3a_nj3teuVSZs86AvVymvaURQA@mail.gmail.com>
 <20250902113857.GB186519@nvidia.com>
 <CA+CK2bB-CaEdvzxt9=c1SZwXBfy-nE202Q2mfHL_2K7spjf8rw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bB-CaEdvzxt9=c1SZwXBfy-nE202Q2mfHL_2K7spjf8rw@mail.gmail.com>
X-ClientProxiedBy: YT1P288CA0006.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01::19)
 To PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|MW6PR12MB8915:EE_
X-MS-Office365-Filtering-Correlation-Id: ba81d41b-bf1d-4aa8-16b9-08ddeb089eaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+x2KECLvf0eyJpQ/H0a8sqmXfu6hXQdNEBl0fopVKvfeYSQBYh66Jx2NGyDE?=
 =?us-ascii?Q?ZV6mFdSS4ZXhz+DQhBZKJ/fFscIFzU50Kz1BQMdiuI/E5qygs0aUZ9duAQF1?=
 =?us-ascii?Q?myKouL851D90Y6mzgGar6/LssbI3nxK7qZxpEOd9RfqnQ/gOi3VyXy9h6UXc?=
 =?us-ascii?Q?hdeJGBEXYml2RHLdUzGlcbUyJsipJw0b8wdQH7fNj6anBIQTKObO7XfjwX64?=
 =?us-ascii?Q?eT7KCPHIwC7BpyjmzNBBsIJlNOp8z3cN4k09r9FoNPZ298wapeNvPGp298LC?=
 =?us-ascii?Q?la4WM2ao2QCiorrhkB0Jc0BR2toWfcX/llBrnKZaIgwfsDI3+LwCIqk7gfTC?=
 =?us-ascii?Q?VMcLJhkR5wl3S32Dqhiu13vOojrIx/edtKeDupVub2BfRowRy8ZXSPmWeI78?=
 =?us-ascii?Q?Fku3g6qgVL/WyAGYucv8PuBhaG20tkUTmDk86/2BLuV4MiBjSnpYmJ/Rgqh4?=
 =?us-ascii?Q?UKTIzhkb8bXrWw1bfs3IJVx+clZHtgullkT1CpfZWupfsmIpwnrfxXnsov+f?=
 =?us-ascii?Q?E/J5e3ODOE6qXN90UlJz/8buONY9za/WAOZxzG+4hwM55z9D4/y8i34rrhgu?=
 =?us-ascii?Q?kQEZVJBlNy9n8GhnnxX0VowbMK2nwtfc+WNnX47mJ753/AA1sFREDW/BW6A5?=
 =?us-ascii?Q?Rn7knTtidifXnpgYKP6rQKEEr2ejh0dM2anwVnTeCBWX1w6fadzHBHwDUtvv?=
 =?us-ascii?Q?KrwH/q5lWblhLLOglJpdoCIcr6FozEpqyQye8r+w9rqvF3pE09/sHtR64lRN?=
 =?us-ascii?Q?Xpg/akwNX91nAPUHwmLSgDvdWlhVxePlZkER9IOYIDvbDmSuWorflmxoso+Z?=
 =?us-ascii?Q?tudbA1dBnLYOaXGyWydt3eQ+weU6v4pJ/RP2+tqWCzC0wxYYd7TZf0WmGl4i?=
 =?us-ascii?Q?adbXHpejgkszqynlqaMEdOx5S1/5YX6p/Rc6mwWzzX+46L7WmdnrKg1HWQs3?=
 =?us-ascii?Q?IzjCgPb5Vltv9bpxlb2zThNvqGdwHNNF9j1To8bGjAp8IyFm9DP0fV2hv8W+?=
 =?us-ascii?Q?cJRn2VY616a1qf5k/oifUfzllL/494rCzvu4njSRdojPMPrgBbtC0te7h33E?=
 =?us-ascii?Q?8AKq9NkXM0zQgnUU6TR9KE39ORiyEWG6n4PEu4qAIV235C9T+QI3/h8k6edb?=
 =?us-ascii?Q?73Jiap3Y2htIBUlTD3tSMOdSpK7rLtWUUan/N0+UVG5vEkhKLRztWzd0nezY?=
 =?us-ascii?Q?fDa30T/VKroVQrPb6c3MkV2stae3gq6rYdiNf5vqjtDTytmBuoIaEwSsYhCO?=
 =?us-ascii?Q?5OnlNffvCYB94Abnt/bkr7LNCcvugyy8NK36OsXIlZD6kE1PNiAL1vT7utH0?=
 =?us-ascii?Q?kWPb5soYVZ27b2s3Pg1nbPK+arfa/Iwt0wbKhqSWxY5WtnrI3J7NfPz6IeGA?=
 =?us-ascii?Q?7ClLQMKVTnHwo7yFbLAyT22rs+E7fTK1ZDNO9EMm9rsQM4olvGMBGAZwN8jm?=
 =?us-ascii?Q?/e0+qFYOWj4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?plQH5D+D4x4yYi5E0DPKIsII530sl9oevaYi+x+MHUrqOXejw4HV7KChdzpa?=
 =?us-ascii?Q?Hb6K+jTfjxdvboIpzAX8Pv/ca/YRILXvASltk4wEXnCPMipM+YeY8OJTkuvw?=
 =?us-ascii?Q?Y3njtSsnSOODP2Q/FXiPHO06ELbLC6dsW4tehxwn+/xmqz3fFupE4T89DSio?=
 =?us-ascii?Q?p2jFTt9Ejrn9FynBU9CyGbOOXkfcVV61AICZNIl18sldQhYFfRZwbtbf9yyR?=
 =?us-ascii?Q?x7opvzunRZ77sOeUcLsLiZb1lbqCcYjUqapNWO4k22SG5HMRUey1efh923bJ?=
 =?us-ascii?Q?jrId8utA9dOSoSzohYFBqzt7eYv6t3ZPFtuyvVj83ER4+zi/2XSXyxgTO2zK?=
 =?us-ascii?Q?WTAI3b3n+p1I2ima7QiKBuJpPCjRJEjtCZkTqydFQV1P9f0a3SNkDEWqEe4c?=
 =?us-ascii?Q?YE4fX7rSBBKRyJAev7OlW6WS/IcRyZZeNMzfqO7ILcRu6oW40nBtoffJMCt7?=
 =?us-ascii?Q?efiNA+MiNazHw5P3MtI35uJBt2Zno8jqHW1pPgFUqJ8q6V5Y8jtk6yg2m4W/?=
 =?us-ascii?Q?WCRZ2fpa8ub7Kpdi6LQkJ31bjv92XTpPpFS0jo2U/Y3i1gddhabifANaLMbP?=
 =?us-ascii?Q?if1e1lfiLHUDF3wDNza/bK+fd+odZBZOn/k1PltbewBgs7cotuUI73quMYpC?=
 =?us-ascii?Q?RS6hYPzhN8mYjnaMJ/s7nli4RZ1k/hGVP9snR5k7kwNlFhZTLyWaHtDAKwuG?=
 =?us-ascii?Q?RWLAhXYSOerGFlwB0uTB4ziVeWLvo0R5ToQFnQT9Qec/78Rebs7LyKgsyTx6?=
 =?us-ascii?Q?uGGOmz4l7UiNgpyUrni1b8+fQ1AEBFhcWlMhOQQ5HNHbQrD+9FTLR3bMITfQ?=
 =?us-ascii?Q?CWzU/9rgTfTzeSuBr9q80WBBYQE5mZ0qooPDPF9jDAdJ3HyMYiMGqTlc/Ov/?=
 =?us-ascii?Q?yq1zRcGy4mAcDt4AWMcNOpXCvAwciv6hhN2pGgbUhjDFyx7NgYtO7s1FXogH?=
 =?us-ascii?Q?3FhVjYsSckDEVL1KsUCZ8LK5LDwMKtGShAQV8xFqsE0Xj1RosYnhqmyBZTDR?=
 =?us-ascii?Q?UsB7T+Ip2mkIWkJCUdsB6OK9hTzLqlk6GdQWxY/XkrQs/xc851uDo9mofR2p?=
 =?us-ascii?Q?HBUKAEMF3+utxMeNzid2+nzcwkDp3cLNPKpclEQwJYn56fD1pJyp7HkcF8FL?=
 =?us-ascii?Q?GlaJJiwUIJvFUqxfwPbc4wXrEshMl0rrlAfKz2NeduJspRDBImiMe7lN9ypv?=
 =?us-ascii?Q?QPBZ8KA/k7lIj3vAaNwHjhiHTYi0H0CI/nVnhYwqlsGEei0FPZEEcnevZA8o?=
 =?us-ascii?Q?Sh+/9Z3lRwfKSjZWYo11PQrIjI4nRIoNk2hiwzXzdnAJKf34wK04r86Cn5rd?=
 =?us-ascii?Q?FnTjY8hTi9JFlP1gJ0I9CXpz5onuC9SejNRU/9k+knur1ka8jQOQzztnvVAV?=
 =?us-ascii?Q?hdIwdMoz103me2aPzrdQWGCwSIR51nsb04oLw35l+aDIvVSf/0TXE94mNs/9?=
 =?us-ascii?Q?whWNvh5DWTfA9kS4DxCvoQuyHLJdyz8+tkiLq9wY833R0lgNsTw5pf7Kb7S1?=
 =?us-ascii?Q?b6lB6wZdsJhj5Z8t3ifHViAz4GXDjuHBoEXlNsAcPzPXDDdct/m6/iSnc8Sa?=
 =?us-ascii?Q?ENJABymj8QUO2ZfOuSw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba81d41b-bf1d-4aa8-16b9-08ddeb089eaa
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 16:40:41.2272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 00cDOnzryGYO5/Zp7JTq1kq0G3CQ0iMSKqO1264C2PpyCTNDmx+p1C54914gKu4D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8915

On Wed, Sep 03, 2025 at 03:59:40PM +0000, Pasha Tatashin wrote:

> vmalloc is always fully populated, but if we add support for
> preserving an area with holes, it can also be used for preserving
> vmalloc. 

Why? If you can't create it with vmap what is the point?

> By the way, I don't like calling it *vmalloc* preservation
> because we aren't preserving the original virtual addresses; we are
> preserving a list of pages that are reassembled into a virtually
> contiguous area. Maybe kho map, or kho page map, not sure, but vmalloc
> does not sound right to me.

No preservation retains the virtual address, that is pretty much
universal.

It is vmalloc preservation because the flow is

 x = vmalloc()
 kho_preserve_vmalloc(x, &preserved)
 [..]
 x = kho_restore_vmalloc(preserved)
 vfree(x)

It is the same naming as folio preservation. Upon restore you get a
vmalloc() back.

> > And again in real systems we expect memfd to be fully populated too.
> 
> I thought so too, but we already have a use case for slightly sparse
> memfd, unfortunately, that becomes *very* inefficient when fully
> populated.

Really? Why not use multiple memfds :(

So maybe you need to do optimized sparseness in memfd :(

Jason

