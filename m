Return-Path: <linux-fsdevel+bounces-59976-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5933EB3FDEF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 13:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 213022C4DCC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 11:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7312F83C1;
	Tue,  2 Sep 2025 11:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="A8JBAoky"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2059.outbound.protection.outlook.com [40.107.96.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56911279DA6;
	Tue,  2 Sep 2025 11:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756813145; cv=fail; b=mtaVZm/g91wSZv5FeqAuRgk2QPk4d5ssY1Dgd89TQryVkyYCue+XlJjpgJp+d0WG7S7NV2cES6IxwZzU/O1bbveiuYnpdXG7a6Fq7Hg4HrI9WSWqfn4yNjx1pWrLJphDCExFvmfcqW6gw+Mq1F1Y0MzDtnwN1XCm8QqRByOu9uk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756813145; c=relaxed/simple;
	bh=mREmTgxl9jsR+zX4QPmp0KgoHG9n00PGr7N241RdKGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oeRpi2jhmpW5DBpRAFY9F+45WGn/E3Yo5/J22NMnrWwSaJ87zoZ5vychsqOaOH/23jn4POH9Rw2AX+Xg52FEcdrZNJrLhsFOiJPCzQr+06i/kvurytY/UKEGsv6e1teRCWE+5qJO/MOwAp2wZYa5KSvKpH/sIAFkUtPVfOBqGrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=A8JBAoky; arc=fail smtp.client-ip=40.107.96.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t6MjIAP6Vy2IzN38m4dOQaBALI0dlomU4eDlICg4vEesCwhaoM9PZML3tI5eZuunbiD5k4zQwck0hwf2HVY6jUT/vSUKfomUIma0mrVV4DGEgx+r4HUNiZguuDEkzuP8vM5KeMPiuhZoTyejcz3OUzb2sMAENmQejz2GG7vnUgnTGixlxT0ED2fKX5o1Z0aiXG96Q49vvMHL63Om5jK6KTtcKoQ7iZj0oCfsmpMW7OGoAuacO4MzqyIXwcVRVVxrlXF90yXXk8dS8tAQV0/VqXbRhuAyQQPKKi915gz1jnvw9cc6ZZ/Kxr0fqIGu9M8tmv9CtecE+eDiY3m417ezfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ORV78OTOYk5Vk6E3gOVbBtYwVq8tL+jzgjhIq48yue8=;
 b=AHjQdqZeqEGfa+Lhyd1MnaBTUqk2B+ydS4+aLxQ3bOl2ngGOHcFaO9/CFHjd8wmijEzXEfhTW4GlX6cWsMQ7VkoNkpbFcfCML6hwFfuaqxzW1QQBg2zfdYyb2Rxq7pYvOyBUjrqBqVMsjwefDgPriEonF4hxEH/TK//vTXkzeXQnIGn8f/ix0qUqJy2vxL6nKnT3sQFJGXURx4xLSZkkJTr8W12yNaJ1ScENHXGaeHQxJeuu6K8hSBvY9WEaOE5sNgfBfN2zemvdKeCDZZmj0GdAaiuRjGi4xlb48cRZFg85yd2tlhctOt+++AF+ejNMBV8kUmnaclzL0y7KJvMJeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ORV78OTOYk5Vk6E3gOVbBtYwVq8tL+jzgjhIq48yue8=;
 b=A8JBAokyTBDzjNj7uJ06120o2BSrUJ02vqIjzrmHLvWuq8oMTsKj8om6BKeSB41QSILXt9m7/BfbUkQrMon+9KVgUDUySi7Gy/6Q2nMnQTu6rmKhHwZcIEV8lYhjEJZEEastY4UZMFBcDyLGPhL1VhERE07NAK0JlwgZ/vEMCSW2rdmXQcVibPX3gz9ztXfhngKdn6XKHZcn4SvQoggQFUnwSLwVu8fzhiGA3g5rU5RFJ7UGnr2qJA8OOo/nbYVGY8+P0lRCQ0YvJbgb2PWSYZnEsimSQv5fNGpxA/MiaFvG22HkHQNz4e55R4q33Gmt5hohAL0Q28dhQw+saatJjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by LV8PR12MB9715.namprd12.prod.outlook.com (2603:10b6:408:2a0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 11:38:59 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 11:38:59 +0000
Date: Tue, 2 Sep 2025 08:38:57 -0300
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
Message-ID: <20250902113857.GB186519@nvidia.com>
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <20250807014442.3829950-30-pasha.tatashin@soleen.com>
 <20250826162019.GD2130239@nvidia.com>
 <aLXIcUwt0HVzRpYW@kernel.org>
 <CA+CK2bC96fxHBb78DvNhyfdjsDfPCLY5J5cN8W0hUDt9KAPBJQ@mail.gmail.com>
 <mafs03496w0kk.fsf@kernel.org>
 <CA+CK2bAb6s=gUTCNjMrOqptZ3a_nj3teuVSZs86AvVymvaURQA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bAb6s=gUTCNjMrOqptZ3a_nj3teuVSZs86AvVymvaURQA@mail.gmail.com>
X-ClientProxiedBy: YT2PR01CA0010.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::15) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|LV8PR12MB9715:EE_
X-MS-Office365-Filtering-Correlation-Id: 700006c6-e4f8-41af-dc23-08ddea154ea7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MZB8wzgTp+HaJjOHzvIZaWdXM7w1hQa9/EKf67tlRsrhmg2UmzxqA5VV06v5?=
 =?us-ascii?Q?ezJrIPwFi70gQ8U042Rfb7vMawORKOPRblBkz3OfukUcz/3Vn8fSDO3xJiou?=
 =?us-ascii?Q?WkPwdtSv4cCP9X4RQJKh65pZ5WYvMQ9tt6WKnf8j7o6ClUpR1Ijrb9s33gog?=
 =?us-ascii?Q?MepswWZ5g/YPEWyu/vVzLvuQReBUp+M2NadrZ0MlG0/l6sMLwRnpBDMNVB6K?=
 =?us-ascii?Q?E9xmk4OmzXlzOaEJf2cgV6wjI+z+p8MHL+V9OwwpZ+y40V/f5IFEQpIgrcHw?=
 =?us-ascii?Q?cAwpUQRJZD6Oyb6FkuW9FKhnUe8pdIS+Hwglz+0wb+5d+gVIeC/dHgS32ekU?=
 =?us-ascii?Q?FwBLwWrviQ8iOyil7eQ5qqme3xBVQFMFf8GhD2paH5pyHDb6DC2qDk/CP1So?=
 =?us-ascii?Q?H6c96MIDLcovDatXJYy68CWuENqpKcUrFP57MziaBj7nsyeemhx4I87PTFpK?=
 =?us-ascii?Q?skslzSWkCJ+ZezknS0/CReY9UgnCtP9qLF26Zsz53inFCkGFNTD5BdlRI00v?=
 =?us-ascii?Q?0uC6Xgj5tfsXD8gA1kpMxejXBHnVewSLembSHjmxmtCqdmEBjWZDy9XQDEuC?=
 =?us-ascii?Q?8OuOiBapwB4c3jxOjjxHvc3S5gI14k8ZwU/f5SBO/OscS67mvntNmp5LVmjA?=
 =?us-ascii?Q?BfWbiKel0gTZ7zz1sVi5QpNv0dNdwNJ6fgVCih/IVKX/0PSfV0pQ3PKTxTwT?=
 =?us-ascii?Q?Uc0fhPl078mtr6lsXwnFmgtHbF1jMhrtouRZK64lT8UMwjshdM+ehRxnVv2R?=
 =?us-ascii?Q?tY7tPbYSgerffK8BLCeHXUb2ICblrVLtrkW6Ii/rnJjmcdNADIeDp28lGnFZ?=
 =?us-ascii?Q?TXjj5ceEKJCR7ODZ28zDG3/TONC7RTHly+XbZ25qo0qrUzCHcSrW6rXGqsCq?=
 =?us-ascii?Q?N6qF3v2Gr/54pTUoS1tafPdpstrYLH5uR91Nf4eC5lqKv6k4Mmp+XaeOQlBJ?=
 =?us-ascii?Q?SBAvvPUIjY2Zbpt/xglzFqCyADGqpNR63MWhvrRT7VsPdo2hUBHRrcaxSk7a?=
 =?us-ascii?Q?5rdqWHReOCtzdaptkCmoe0HQ7bwEuMt3dO2shBMHMgIUOqcJeTNRQQAPNee+?=
 =?us-ascii?Q?d7CnVjBm6TllcaV5AhQz0FfJtlCbU6mWWa5AhFZnR7AjWhlG/vBksFHTaK/z?=
 =?us-ascii?Q?2HFSSUM3364pNNg4u4wTQBOhBwSserieZRZC3UrSBKeudc4bhlbG64lukOM7?=
 =?us-ascii?Q?Fgr6DN/zX/4tVIO/si+dED2yTn7SsbG6rCqWUyrdNV8730r6INc/1VVG2SsI?=
 =?us-ascii?Q?vv/KwfYhZi1Y1Y4Y0clX//+kglHMrz+RKTYr6Qbh/PjTJ6FxK7KU1pbWNduk?=
 =?us-ascii?Q?MgqeLo79+qn0nptY3fBxjZ5ne/q/8IwQKyCn1jtyBPPs+n8idKnCniZyDYvj?=
 =?us-ascii?Q?4ALL4N03Q2Lznv7pJxgFq/b/U92GlYWkiRn1auyl7BhR6U7wOvFufxOWhxN4?=
 =?us-ascii?Q?n1ePpuhESyI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EzQs3pYOBRU5ncLLvxb+2V6TPLpZpfmoSbSIlHGmRilpX54XwcIgxoWlzwmM?=
 =?us-ascii?Q?upnnFR7X24/zahdSEkY6yk/vJv6bEb11GoaSSxlnwElxWvFes8AkC8SSGnVe?=
 =?us-ascii?Q?eMmma43O7Q7KSZEAGNwPv6B+c8ZLS9vCZFTxLJy50ryoE0eScMmOywjTFRsP?=
 =?us-ascii?Q?3ha5siZ6vKn7aCaDBMiiPCoqjSbrq1BdPD+6en56vQlmetJFKEkmYBrAeakC?=
 =?us-ascii?Q?uJ6JHe+PLdb1WXXtAgNNmu2ntNMwPIOTMds7AawPSmj9AxdYqM6spZLsNaQX?=
 =?us-ascii?Q?rXw+LuVCqS7T2I1QEY5089G82bGktGpNEUBW8u5FawIYveTOqtIM7WAvNwn5?=
 =?us-ascii?Q?XU9kn9O0UbdLO4ddTFpz5tixdagLMueji8+nF6idEZfMzQqxmxq5AD82jntK?=
 =?us-ascii?Q?7SQo7OXQxHTeC2+rMzYA7zAOmykCawzSXNjL2alWBp07ysMngyZgQGYaWV2/?=
 =?us-ascii?Q?W7ZTwx97ywxQgQObuIJKLm92oq9PB+Xg+Z81BsnFis5TIUqkk/vm53e8tO4c?=
 =?us-ascii?Q?Qbv0isz3Rq5y2+ZZ1QePCiod9UR+31avolfSHQsjMSNOoVXMILDgOurSKgEC?=
 =?us-ascii?Q?Py48pawnYucjBpUo5DHd5zudg8tHFg2T07mPpHQeRIoMZTzV3NksOmPkZRqh?=
 =?us-ascii?Q?z88eWDb+7WVmjSpXG8WW3Et7fQzCYtNDisEhadss+kRsNTzXrrg7l71OzmeA?=
 =?us-ascii?Q?OSL58OyMnw+SOymX3udi04OlHxf/0yWzLFM9m4RP9cEuX1nsaOlAltE7G2iH?=
 =?us-ascii?Q?p8wF0bZxl6LblQc44HnZB2WEdaOkuzM5PyCPunzN1/20yeKmkke4P3saVaFV?=
 =?us-ascii?Q?iqyFUzncuqBtbgBxifCqrM+6EJKQ/SiEAwenT5HvCm4HJzNBBQQK5x66jac8?=
 =?us-ascii?Q?PFCB3QtwQJB62POVMhXfSf19VH2Ljm+ZCHrm9uEvhLvY9CUE/GyPti28qyfY?=
 =?us-ascii?Q?GfNp/2XC2eKmDiHJANItBt3OPH/xA+xrRpA4dxlOP5ZJdzogOGyo7YC51Omt?=
 =?us-ascii?Q?l7GQMQexy6t2UQJOQRZFvDsy06azahfxIqNxwGoLdDQHeQb7MLWhI9qV0O2d?=
 =?us-ascii?Q?4a9zsJkqlOs32bgwtJj+uWGwcAaL2nh0vW2c0QrzHMzlU/srK5fA22+cN7Od?=
 =?us-ascii?Q?NacpBxRKLHqbcCGh6qPiD8HuP7PWTKVR59Aixc0pfgJf0RQ0Ds6YeyUREES5?=
 =?us-ascii?Q?BaX91dK+ydbu+31DXK9BO1ezFnjYsK2YSnoKFZ8hx1yd3BE+DMJ8bw8InJiT?=
 =?us-ascii?Q?ME0fUuSXbt5H7F1Kqy8KEFw8h7n8/Lktsa7u4HDXbbHI6BH0w+tlxpAC7mOY?=
 =?us-ascii?Q?RqyN9T1z3+N/GB2x644t33aRfF+K3sy7GLj60uo39s7mgyjlkazFJ5EKoAjs?=
 =?us-ascii?Q?dyTQJndAjRXTAdZcpL/BHetmHWEIRgW00iAfsFwe2LNvut5I09ejFYBO9d1O?=
 =?us-ascii?Q?RBHtSrES6it8Yv5NoiyBQYmhmAwXRFyZT1ZEfqwOCjvQrqCcwChJh4QL90HK?=
 =?us-ascii?Q?jPGbwtObFIKjeKxKH0iHORmCRLWSubOZGBIvBhdEU7mwdnHiV+uOIaPOHC5Q?=
 =?us-ascii?Q?ELAM9+BrLARKyNzC6II=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 700006c6-e4f8-41af-dc23-08ddea154ea7
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 11:38:59.4645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kMLxNQaA5I7Gz4NLo99WFSqx0fHJ0xs8HEAKtaMKSQasNg2uIfUTbhP+dyPZ/cKQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9715

On Mon, Sep 01, 2025 at 07:02:46PM +0000, Pasha Tatashin wrote:
> > >> > This really wants some luo helper
> > >> >
> > >> > 'luo alloc array'
> > >> > 'luo restore array'
> > >> > 'luo free array'
> > >>
> > >> We can just add kho_{preserve,restore}_vmalloc(). I've drafted it here:
> > >> https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git/log/?h=kho/vmalloc/v1
> > >
> > > The patch looks okay to me, but it doesn't support holes in vmap
> > > areas. While that is likely acceptable for vmalloc, it could be a
> > > problem if we want to preserve memfd with holes and using vmap
> > > preservation as a method, which would require a different approach.
> > > Still, this would help with preserving memfd.
> >
> > I agree. I think we should do it the other way round. Build a sparse
> > array first, and then use that to build vmap preservation. Our emails
> 
> Yes, sparse array support would help both: vmalloc and memfd preservation.

Why? vmalloc is always full popoulated, no sparseness..

And again in real systems we expect memfd to be fully populated too.

I wouldn't invest any time in something like this right now. Just be
inefficient if there is sparseness for some reason.

Jason

