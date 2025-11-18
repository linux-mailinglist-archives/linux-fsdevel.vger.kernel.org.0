Return-Path: <linux-fsdevel+bounces-68953-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C81E9C6A56E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 16:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 821B92B789
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 15:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3AA436403A;
	Tue, 18 Nov 2025 15:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dXVdE+mt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012046.outbound.protection.outlook.com [40.93.195.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE21325739;
	Tue, 18 Nov 2025 15:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763480200; cv=fail; b=nq1BgcuEi+h2rIjBSiBttohRgcDzOXdnOHTozcWqB3C0NnZVNsAbD6ix/NkfeHg5KlYzt+x3oXbSSBC3wvGYs5Z8F4P8CYl6FKs8AmCqVkqehGB0en5fevVYyqjLdpD7I2ISVO4WdQxdz53+qPhSFPupvwXuOoAr7tP7eThZB8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763480200; c=relaxed/simple;
	bh=nxh1BxiveFZuiGYazJnuEaP8LBFDK9k3Xjw1Vra6vw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=m9I+fpflpjbHF9OO0RLtNhiCE1nxHQc+R6KPrIvT2Pn6CPiiIy6X4+/VCj7RZYjoFUQVresOt5Qegow6ZZmmAZPnJSX1uxpo22bFsDIRc5Up2XtUcTDUV48khTIKxcZtB7Lwics934c0PsEFXDZ6IWLtP9ZEoH3PNSOl4YogGTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dXVdE+mt; arc=fail smtp.client-ip=40.93.195.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zWENFUcjzMBsEuxMNKam4kHH4/UAx4vB8pfVZ3VY+W2OvSZ1ZeISbsQkG+pmc0xUvoD9FjHzPtFVY2o8pcoJJkIrm5qQPsMB5GXwUQcb36X9BijDKdIYCmuVxQyjiyGDUOImMN97Bsdhm12lNJwsNeoSUAdEv7ecKfUps/wnkQn+PMiaReXwCWFNECItWin3/vE51F7X5rpSEveno8Jj2GTXkH1OVeseYgH6GmHd5/vBDHsMQIuRT4CCbw0RKw/bqMHBXcmNCOHwjqVlT5h0+aihQEpnIU0qBhcXyTM5g9t9IveAJ175k3z6g7n+w3TUzF27Vz+oyHRR4D+zJm7wOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7DsIk7JJTNL97u+RbXnaGoawXt0SKpKpPZJl+UdNlDU=;
 b=QKZoLV3vRP+c52h3pOcOtwh4aVMnZaPyZKRxbRX0qdJT/3UEw/0PIowxhKwGMMDncckzpfKUc8WOKvAy5nuozJsCuHmlgdvT0IdWZa9BWjFlSdvCgI4PpKScVlohpBGD/7mMTxY4b+aGsh7T+GuykJtTptFYOwXDX8vxiDZjSdDQKfvKwwu56unxxXAzegReuIxXDcYGvn5RGZvVoBapqBMquj8KO9RMB7by3JRY4TgCDygwecLAQOYlFiOzk8IXIvaEZAw1yCpJcuQl8MuAPuErix0CpemE0r+6doaORzoWfnBykbYdpoi/2B8SCuPrzEN7xjaS1sjFoWHBg6dP1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7DsIk7JJTNL97u+RbXnaGoawXt0SKpKpPZJl+UdNlDU=;
 b=dXVdE+mtHkcCAMO1YOKlgGO8hEYa1zG8jJVB1KmdwV6mDOY23rapeE7KZ4PD6O5RohzS4MdR1gnXlJxu3Quvw9LB6dTEV/RVXC4HuWbEzim1aOfMBoX17Wp/pYD4mPJjode3ml8nT0+UNjy+sMMS0vAoUkIhKKPrs/EpGeJCij5/bHERHZi2P+B+aYmxNSKToZ4tt+tTUyw5YxjOcefZnwB3rJnAuNdoR5L51brxsXN8oJGh8/ucS8O7avrxnop2146Wx+iVyxXhXd04z7BoM8hZaQ+ojE0rIs+7tghQBmzj8RIqLN+Tu9TrbxaLcbVY6d+sv/9nrj9tT2manjAsaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by PH7PR12MB5808.namprd12.prod.outlook.com (2603:10b6:510:1d4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 18 Nov
 2025 15:36:33 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9343.009; Tue, 18 Nov 2025
 15:36:33 +0000
Date: Tue, 18 Nov 2025 11:36:31 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Mike Rapoport <rppt@kernel.org>, pratyush@kernel.org,
	jasonmiu@google.com, graf@amazon.com, dmatlack@google.com,
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com,
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org,
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr,
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com,
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com,
	vincent.guittot@linaro.org, hannes@cmpxchg.org,
	dan.j.williams@intel.com, david@redhat.com,
	joel.granados@kernel.org, rostedt@goodmis.org,
	anna.schumaker@oracle.com, song@kernel.org, linux@weissschuh.net,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, gregkh@linuxfoundation.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, rafael@kernel.org, dakr@kernel.org,
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com,
	myungjoo.ham@samsung.com, yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com, ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de,
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com,
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net,
	brauner@kernel.org, linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, saeedm@nvidia.com,
	ajayachandra@nvidia.com, parav@nvidia.com, leonro@nvidia.com,
	witu@nvidia.com, hughd@google.com, skhawaja@google.com,
	chrisl@kernel.org
Subject: Re: [PATCH v6 02/20] liveupdate: luo_core: integrate with KHO
Message-ID: <20251118153631.GB90703@nvidia.com>
References: <aRnG8wDSSAtkEI_z@kernel.org>
 <CA+CK2bDu2FdzyotSwBpGwQtiisv=3f6gC7DzOpebPCxmmpwMYw@mail.gmail.com>
 <aRoi-Pb8jnjaZp0X@kernel.org>
 <CA+CK2bBEs2nr0TmsaV18S-xJTULkobYgv0sU9=RCdReiS0CbPQ@mail.gmail.com>
 <aRuODFfqP-qsxa-j@kernel.org>
 <CA+CK2bAEdNE0Rs1i7GdHz8Q3DK9Npozm8sRL8Epa+o50NOMY7A@mail.gmail.com>
 <aRxWvsdv1dQz8oZ4@kernel.org>
 <20251118140300.GK10864@nvidia.com>
 <aRyLbB8yoQwUJ3dh@kernel.org>
 <CA+CK2bBFtG3LWmCtLs-5vfS8FYm_r24v=jJra9gOGPKKcs=55g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bBFtG3LWmCtLs-5vfS8FYm_r24v=jJra9gOGPKKcs=55g@mail.gmail.com>
X-ClientProxiedBy: BL0PR02CA0071.namprd02.prod.outlook.com
 (2603:10b6:207:3d::48) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|PH7PR12MB5808:EE_
X-MS-Office365-Filtering-Correlation-Id: 87e3b23c-b43b-4c7d-a42c-08de26b84004
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QUU3WitqVUZiZlNocGdYRHQzeUhBK2lnc2ltdVlqYXBNdVpnazNRRG52Nlpq?=
 =?utf-8?B?RWJubjJ1cXA3M0VoOTU1YTNyYk10aFVHWStMODRBNnJJQ1BxWGxsTVZxSGRJ?=
 =?utf-8?B?TDdHZG9qVGwwMGVxQVpGa05OczVlSE1CR2NVU0c4eHVpWkw4a1BvN3haSm44?=
 =?utf-8?B?QVFDTHNKSjBNdHZKSlZQV0tDN0JMUUFvTS9rb3ZOM1J1ejloMkJTQ2pjWXlU?=
 =?utf-8?B?dEdPZ2ExY1FTNWh5STJuMExCL0cxMGVzTHZxNnVNNkZzeXJXSTJhZTJPV1hh?=
 =?utf-8?B?eGVpSi9CZ3VobTFGODBIT0R0cGRpTUM0akZXU2FMM3FMMEd4Vy8xM201TFRX?=
 =?utf-8?B?NVVjT3ltc0Y3UEE2Z1Q4NDlocURkbklEaW1jOFVmaWFsM2pSQzc2SnhGdlhl?=
 =?utf-8?B?eUR1ZzRFU1pTYVd3VUxqb1ZtaWRwdmpIN0lvMUtHVDVaamRWYmZvaFFLMktm?=
 =?utf-8?B?OWFVWVRMbnZ4cFJBNmNwUFRnamp2OFJHM3BvRlFPczJPcEtEWFRNQndHNWJm?=
 =?utf-8?B?dXpwM2dqWUhsZy9hZVBNZFJMTG1WQk4xVXBNUkQ4UGVkZGU0OUp1SFNCNS82?=
 =?utf-8?B?UGE0Y0xTajY2c2xtWHhLLy81K1RUaVl2T1ptTG4xWFAvcWRpQTlIR01XaTd2?=
 =?utf-8?B?TXQydVo0V2lXTkRLZHc0aURxK2dUdEVOMlMyUHFSMnYrcGdsU0ZBWDV3MXFt?=
 =?utf-8?B?Nys5ZGhzNXdqY3lFcGNkNm5wdHl0V1Y5VDBnRGZaR0I4UFVzZmJtL243cWxG?=
 =?utf-8?B?dTV6YXhiNEFVeHdXUEFvY0k2bFlJaVorVjdZOVpNUEEyQ0xCS0FHZWNXTTha?=
 =?utf-8?B?eHF3dXBvYWRCOVJuY1NFbU5GR0c0N0tuSXJWSTJjT0M5NlhMck5OdzNlMEc2?=
 =?utf-8?B?SUEzQzBjQUp2SjJNNmwycjNLeU9pZ1pOR1VMVHhFYlJSZUhpV3NsSmk2RUpt?=
 =?utf-8?B?U3JydVo0eG9RMVNlK2xFalRtdnlYS0dnc0p1V20zRnU1OU1FUE1Qd0JlS2t5?=
 =?utf-8?B?OXZ6REpJakFzbTVJQWpjNi9aeE5lbkdRYXBlWVg5cFRCWGgvYk9qd3dlMDNS?=
 =?utf-8?B?OGZLK3A3cWZ3QWtUMzdFOWZvK3g0TWJQbmVpa3Rrc3FxcU9pU2VVOVdiYkc2?=
 =?utf-8?B?QlFLcUt5d1dENEZPc3F3MGxXQXRnTFZwZFlCOU50OFRYTzc3TWpNTlV6TFRl?=
 =?utf-8?B?elpaQjRPUHcxd0Y5aC9vczVUaWU5anVFZ2FiZncxNjU0MHB4SjM4UU5nU01m?=
 =?utf-8?B?dVU0MWNTRlFFTXZRdGVCcU0wbGxFb3R3NWt3dDRFNGkzdTNNTWJmVWlReThC?=
 =?utf-8?B?eDdGMWpOQkx4ajc2TEJibE45RjlQazFCMGt6cWhSUG1yM3FJS2ZUUm5OWDlm?=
 =?utf-8?B?LzNrQXkvd1JjSldxZzZvY1o3ZVpsRXFPYklDOGIyOVdscndrbW50OTBIUTNa?=
 =?utf-8?B?ZHNteU4wYVM1K2lKSkVyZnRUYnpzK1AvUW4wbGxSUmNzTzRMbnpuWlJacHlW?=
 =?utf-8?B?S2pNVWgyWHJQU3lMQXBXSDhITUJDTEk1WG8wdytBUnVqMjZselRvSmNtRGE1?=
 =?utf-8?B?WWJOelhOOURpbU1pcHQrVWxZMjB0L2JocFhlUFZlcHVzT2dWOWVibTF6ODVU?=
 =?utf-8?B?Y3FBdHRZckhxdFRKanNxR1hJNDlsa09hdzM2U3dpTXErazlnR1NtNFEwNU9w?=
 =?utf-8?B?V1dtYjNXS0pzYk50a2hUNElXK3pWbG5KVWNFR28xUjYwemZWYVVwZWp0dnJT?=
 =?utf-8?B?Rm54a0tQaFZxVkovdnA3NS9PbytHRjE3L0F4VlAwTStjVW1uUDlxZkNOM1FB?=
 =?utf-8?B?K0tzbENSZnFTTXo5T2d3OHJSbDdmRWlZWVE3SDhkeXdGR3dsWEZLcFBEbUdm?=
 =?utf-8?B?VnQvTHpyQ2dSUS9Ma2lXeFpiNGN1TnpsZ3NFYXVNb3hDNWhML0REakIxRm9a?=
 =?utf-8?Q?qsEqq/EPKDMNsyCbODt+znYZ90G++AMq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MkliNEhTS2xHZGg2YlIwYzdib1g4NExENFVvbHhDNmVZTHUzTGdMV2wwNzND?=
 =?utf-8?B?eVB1YnM3empCdjVSaW9NdDBJamwrUjFLUUpZVVp6ZkZKNGxLNlJOTFR0dlhP?=
 =?utf-8?B?VXhXSU1XalRCelE2dGdPVXlvdGF2bkF6T2hKR0tWWXdpWXNqRDcvdlVHVXZk?=
 =?utf-8?B?UnZQckVjcVdKZHY1UFRodWh1aVhadWpaWFordXFOdG9YVTNvMGQ4bDVuUzZz?=
 =?utf-8?B?MmkvM0lVUFhCbHBxaFF3cHVSU1pzYzFxbDZHTG5nOVQ5czNqL2lvKzFYYlhJ?=
 =?utf-8?B?NXRTUlVEODFHZzB5MDdkR1BxWmVscTNZTEJZeWVZK3o1U01JdXRmNkM3RWov?=
 =?utf-8?B?SzBVYUR5RHBINGQ4MDM2VkNvcFJEaVQvK2dxSm0xYmZGTlVjYTMvUkhTU2Ro?=
 =?utf-8?B?NEZrQzBaTEpGYmJYOWlTN2hHaDlsMC8vWXNzNVFLSWZsazBsNUlxRGNxcCtW?=
 =?utf-8?B?K1BEZUVBK01mNWs3QUdHNlcvRFB5MXlHaGh2V25lbUV1ZDBGR3daZzhSQmI3?=
 =?utf-8?B?L2pEbjV3clBKaWpLbWVhU1hxL1JCOG9vRERDeDUyYUJNYW9zZmhScE5oQ1U3?=
 =?utf-8?B?M0lnYVZIdkhiU3luN0VpUDVsaEJyMyt6ZDE5UXMvZlVaS2tlNnBEVnl0dFlp?=
 =?utf-8?B?K2hiZ1F6d2lnSnE4UXZqcWU0TXRISzdnRkNUYlNYWUwzRkk5emJ4dTJPSUhq?=
 =?utf-8?B?U2RaWUIvcEtjdnNydHdIQnVQalhVWmZnR2k3TGQrWVgzTVQ5ZTN2QlV3MHFx?=
 =?utf-8?B?MzFkZmh0djRkL3B5L0JYQjZ4T3FNU0I3UVNLVWszTWwxdlF3bVJibDBVSzR1?=
 =?utf-8?B?Q1NuQ0hoRUlYVEswOHUvUFV5eW1PQ1FUaFpwWlhmM1FxZUVuOVRINmdNK3R0?=
 =?utf-8?B?RVM5Zys0RTlKS0diVmlSZnlROFN6NjVWR0pnSWpZNlF2Ymh5NEEvYjhGQjhS?=
 =?utf-8?B?L2UvVEFZeWg1aVFRWDBvRjZFbGZHYXlxVU12R2laYi9MSnBUUzU5azhJeEJ4?=
 =?utf-8?B?aEdoN2pqaWU1bzJTeCtpZUlOVC91OEtRTkI4b0k0WkxTWDEyd1doRnNzdGpD?=
 =?utf-8?B?bVpuR2xTbGlPT0RSNTQyVWt0WGNSOWxQdG1ZRmNvNkhlKzZGT0RibTJwOVRt?=
 =?utf-8?B?b1BIVW9mSWdNSmNaTWoya2p6M0VaUHpkYXR3ZEtQTC9tWUFhcHMwWUhvdUFa?=
 =?utf-8?B?ZmRtNHZMQy9QSk91Sm1UUFlESERDckZ5WTRGK3RRRlZFN25UZGVCVFgvRlhH?=
 =?utf-8?B?WVBXb280MlZJMG5xYThibmlleVVPa2Y2djBBVFRkdG5uQzlyeEdwc2o3NXpY?=
 =?utf-8?B?UVd3WjErajdJZXV2TnpiMm5zQkkzYmllL3FNYlg5Q0szVnpDeHRoRUpCZm5w?=
 =?utf-8?B?VkpRbklYK2dyUlVFZEoyWGFDVjc0UmV0a0twejJpRnQ1RkhlbHBlZEhUM1Vi?=
 =?utf-8?B?VFlvNVN4ckg4YzZKaFEvMUNGMzVQNzJqMDB5dmhFV0czeUgzUzdWcGs2MW8v?=
 =?utf-8?B?VC9ZSXhVSStjZjRMV1pRNXo2ckx6WTNGM2p3T244WmpjMEE5OU02MkVXSmhm?=
 =?utf-8?B?ZGVVbFhLWGplT3VRVWhuRTdyWFZSL0NZWllMY2EvTmQzdHYzY0N6VDhwWFR3?=
 =?utf-8?B?SXhJYzNacDhvK3N0c0RwRUdaUkxNek5VWGFnNmZIUmJNTzdUOUFnQXAza1Zp?=
 =?utf-8?B?aHc0MVU2Snc3MjNnTFN1VW9VbkxleTRJSGxNYzhnL0tZZFZMdU8vZk42bUZH?=
 =?utf-8?B?SjBkR21HK2hqRnNsc2dYWVZpQUxrelg5MHRJYnM3WEc5aVpkcVdJaDZxOFZr?=
 =?utf-8?B?dzQ0NDNtZUtSNzNXS0poVDNWYWh0RXNiZGQrWGFGTUNGZ09EUENFMGNFZytW?=
 =?utf-8?B?d3VKUnZLUFJxMVpYM1dFSEYxOHF2c0VRbGJoM2IwSitsZEFmTlBZK2c3c2xQ?=
 =?utf-8?B?eUhlb21pS0NXNDQxUmw3bjhHUHRRRkR3aWpDY0IzMTBlUkpLMEozMldwWkxM?=
 =?utf-8?B?SkRrZDNCMS9iWnppdEowVTA3R3c4U0pLLzFUZ21yR0IwL0VFMFU0UGlKdWVt?=
 =?utf-8?B?R2JCRldueE5LNUI4MmI3eWwzQ0J0aVlZdTFXRVRhekNDeE8wY0htcEFoRjN0?=
 =?utf-8?Q?Xt5M=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87e3b23c-b43b-4c7d-a42c-08de26b84004
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 15:36:33.5041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J7qfNKN0IdHQLz5kfZyZ1z4Nqv/HZ6SZtgvKatxYloe6HXHKX8inwrZs13b08+Fo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5808

On Tue, Nov 18, 2025 at 10:18:28AM -0500, Pasha Tatashin wrote:
> On Tue, Nov 18, 2025 at 10:06 AM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > On Tue, Nov 18, 2025 at 10:03:00AM -0400, Jason Gunthorpe wrote:
> > > On Tue, Nov 18, 2025 at 01:21:34PM +0200, Mike Rapoport wrote:
> > > > On Mon, Nov 17, 2025 at 11:22:54PM -0500, Pasha Tatashin wrote:
> > > > > > You can avoid that complexity if you register the device with a different
> > > > > > fops, but that's technicality.
> > > > > >
> > > > > > Your point about treating the incoming FDT as an underlying resource that
> > > > > > failed to initialize makes sense, but nevertheless userspace needs a
> > > > > > reliable way to detect it and parsing dmesg is not something we should rely
> > > > > > on.
> > > > >
> > > > > I see two solutions:
> > > > >
> > > > > 1. LUO fails to retrieve the preserved data, the user gets informed by
> > > > > not finding /dev/liveupdate, and studying the dmesg for what has
> > > > > happened (in reality in fleets version mismatches should not be
> > > > > happening, those should be detected in quals).
> > > > > 2. Create a zombie device to return some errno on open, and still
> > > > > study dmesg to understand what really happened.
> > > >
> > > > User should not study dmesg. We need another solution.
> > > > What's wrong with e.g. ioctl()?
> > >
> > > It seems very dangerous to even boot at all if the next kernel doesn't
> > > understand the serialization information..
> > >
> > > IMHO I think we should not even be thinking about this, it is up to
> > > the predecessor environment to prevent it from happening. The ideas to
> > > use ELF metadata/etc to allow a pre-flight validation are the right
> > > solution.
> 
> 100% agreed, this is the goal.
> 
> > > If we get into the next kernel and it receives information it cannot
> > > process it should just BUG_ON and die, or some broad equivalent.
> 
> I initially had a panic() that would kill the kernel, but after
> further consideration, I realized that we can still boot into
> "maintenance" mode and allow the user to decide when and how to reboot
> the machine back to a normal state.
 
> This won't leak data, as /dev/liveupdate is completely disabled, so
> nothing preserved in memory will be recoverable.

This seems reasonable, but it is still dangerous.

At the minimum the KHO startup either needs to succeed, panic, or fail
to online most of the memory (ie run from the safe region only)

The above approach works better for things like VFIO or memfd where
you can boot significantly safely. Not sure about iommu though, if
iommu doesn't deserialize properly then it probably corrupts all
memory too.

Jason

