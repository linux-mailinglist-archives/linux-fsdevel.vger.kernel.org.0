Return-Path: <linux-fsdevel+bounces-50122-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF07AC8621
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 04:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94DB5A24C5A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 02:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C553417A305;
	Fri, 30 May 2025 02:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Iv0Ppu95"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AB98834;
	Fri, 30 May 2025 02:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748570679; cv=fail; b=Z1keIvX+NkQkOViPUtWSGyose5+I0r85EjxY49WBtR+ZHvKTN+/2879eG4paZ27tu0nIobJ2tw/FZ1/PJDuJguiMudbmiKDYSGgMRFHyCBymt1CuM2t12mbI6dacjUwM8dOflihC93hyoKS2rPX43PIlB6k6Xo5iR7zj4JFcmKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748570679; c=relaxed/simple;
	bh=mrTmIPO7E3+RQthN/VSElXK2eeoZK3yRsEmUaleYrec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N82U3eKcifBb+AGS3J/+6BGa1QuldPUbEDlDdwIjjvVEA4xb6OnXkpTUWawDDFx/VmAmnWdAGKIJF4z3beGS0TKabkLOhFh51+5LhIDl+DRe6zFpuCCHnXIMUL9SuRICK8QfnHqvuAZQWwqPgLeqG42ntD4nPr3eX3KB76nRPyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Iv0Ppu95; arc=fail smtp.client-ip=40.107.92.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j2kkbhwK0JYf3dfRlvdBhFw3V08UKSfXqB58/mt7GIeuoOEbDVfNr1lpIUI3/pCPs2wkdNFO9U6a20BsuKs3gtJ5/Fx4feIn5P0QoW/WmX1ja2IwzWtCZqI5utNdc7UJhr4IQ6bEGrcjIv9uhV5ZPRAcYg280DD7ly7xXOteXS1/6jYzpQW3XWTtvh6of4bmjlwIYv2B14ZDcl5uTIVTV8lMerBFN+71+UDz7fqmf7fPOEMGRvZmNTtopOX28PffSHAm+mkVAp+sH5WC0+zGGj2+cTNB1MfkWNxXD1vZjw1aYA4KmGAGL2+7rmjX+KKGNRk9wjNMy+Kd6CV0RiSg9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0/yvvgGCYs6fRr1PZBZdk857dEG0Mg39QIgzF9HHbVo=;
 b=ijO0ZLiQ5olQOOEJL1gn55TYgn9j7ZHuU2qDX8eHnwezqsQJ5tKg13ZXgXK0/tQK5MDXvKJjJiYSBYpr7/tKdtQGR/jL3oSznZB2ThYryR1fVFHc9Zrw5+iNZdso0H7RCEoiydsp/DmgMND6YSm0NnbFKdHd2U1UHngCBfzA7rtdiLZJrUGWRRm9OZglDIkmH4tP6kapNAApdKC01n5TF/vIGpNiS3uXtbLxds/j9WtEBAqp9xhjB3YA8DD+5DORGq3JjHVkvwgeYqiCfHz1uZfDRRD1pxRsQ+Zeea0kDMzANShSW4YD33tMmtWsPJHziSpgK4COQVZBMd7f74BryQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/yvvgGCYs6fRr1PZBZdk857dEG0Mg39QIgzF9HHbVo=;
 b=Iv0Ppu95czHKlL3Uixy4YoyFy++ZF95YXpkvlxzxedxmv67ilVFh0z84TH2P1qc9On+Z3HBbBnlnEtM53rDYDw1iAC9PYmpRVgL9JDDkQe8dtArhyyB8FRDm4CrViBNiciOUGv8mv7E7c3Wh5v4+fOmgsPLUTZV51CVmKZBDR7jwKilhnP99FVwCeekQ9niXUtuo0YOsF7Wsltx+jynclD6haA1KzK3Lg18gT3w4MtbsuAHBa/9ESJOcD16hUVsP44gWPz+pfxcVQugbAYsy4HkqYz2gE79KlNI8kpA2xA5Jf6elcf2iie+5dhGZRzKkZqT7S2rxp41wKT5Vz+Ilpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DS0PR12MB8270.namprd12.prod.outlook.com (2603:10b6:8:fe::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.29; Fri, 30 May 2025 02:04:33 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%4]) with mapi id 15.20.8769.025; Fri, 30 May 2025
 02:04:33 +0000
From: Zi Yan <ziy@nvidia.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, hughd@google.com, david@redhat.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: huge_memory: disallow hugepages if the
 system-wide THP sysfs settings are disabled
Date: Thu, 29 May 2025 22:04:30 -0400
X-Mailer: MailMate (2.0r6255)
Message-ID: <E330B371-C7DC-4E79-9043-56F4AA9BBE54@nvidia.com>
In-Reply-To: <5acbfc5f-81b6-40e2-b87b-ac50423172f0@linux.alibaba.com>
References: <cover.1748506520.git.baolin.wang@linux.alibaba.com>
 <d97a9e359ae914e788867b263bb9737afcd3d59d.1748506520.git.baolin.wang@linux.alibaba.com>
 <33577DDE-D88E-44F9-9B91-7AA46EACCCE8@nvidia.com>
 <5acbfc5f-81b6-40e2-b87b-ac50423172f0@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL1PR13CA0376.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::21) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DS0PR12MB8270:EE_
X-MS-Office365-Filtering-Correlation-Id: ec3a6f6b-7211-42c0-ea0c-08dd9f1e521c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YXA1OGtHYXhtczk4MnRlVG1VOVhZalRHcWp5aUJsM1Vld3llaG1tNU5zcmxh?=
 =?utf-8?B?WHdtR2JqV014a1hmVGI1NGJ3S3hyZEVsRGh0akg1eDBLNzB3Z0hTSE5sQmpO?=
 =?utf-8?B?TjdZblkxcHQ2UVRPZTcxU01KcWdpNUpzYThLN3VLclUwbUNXbVY0czNiNXEz?=
 =?utf-8?B?TXR1UjZWU0dwck1lSXhaQjlrcndQSmRtdEZ6VVRITE4rUWM3UUFteFYrMUZP?=
 =?utf-8?B?cDJ4MkhiY1hUWWR3Uzd5eWJRNlJzbnE0TytDZjJEcEhHODAwRU9xSDhGdTZB?=
 =?utf-8?B?eW80UzRxTXVKMElEMmJjNElRK2JYeUR4dnlzTkV3RUJwL2JXSXVKMWZTYzcx?=
 =?utf-8?B?QlJnYWw5Q1BiaWlpVzlSR3lpZWpCS2JVLzZXbG1PYU1rWE03OWMvQjhjMkhm?=
 =?utf-8?B?SkNzRVorLzlIOEhvQlRxaWR2RUxHcEdnMVRMLzVWTlZiSkcySHdBT2RMR1ZM?=
 =?utf-8?B?UDEvQXRCa2xOSlBtblBydWVQV0xNWEFQTUNPSmFrWDRLL1ByY2JWV3VXRTlo?=
 =?utf-8?B?eFhoTTBwNFdCSlhiWWQrKzJteGFyUlBrYWJjRy9yWUJlNXlsdDgybW9GeXpC?=
 =?utf-8?B?d2tVNmpEditEMGoxejlnbjVQSFNvWm54MGt3OHJuUkhYaEQzL1VFSVpEWTlj?=
 =?utf-8?B?TmtFLzh6eFE0SjNUeXRTMnlUWmFDenEvVTFZYTFOODc2VWVQUlhVdGExQnZZ?=
 =?utf-8?B?ekhQWE5aYTlQMW1jMmhDdnM3Uy8za3NwaERPU3BJRTFHejl2bmpMaVdJMUlv?=
 =?utf-8?B?MDd3bWR0bjUvSWRPNFVHWDN5azJTME0wY2ViaE9XblN1bnJSdG1KajRwTnVo?=
 =?utf-8?B?cmVzNTRhODEwQmIyaGNmcDRBUGZRTGhCQkNHRE5PbXVGWXRLYkJPdkNwTUZ3?=
 =?utf-8?B?dFlONlN5ejgrS3VxMU5RcXFZY3d6aXRHS3dHUEUzSk9pUkVRbkczYW9CTFpq?=
 =?utf-8?B?WEUyYTA3S3hHRW5UWHRvUVlOT0pCYVd3YjVOS0taanJJbUh3aHJTSnJjbVJ5?=
 =?utf-8?B?SzVTTG5HRmozZVNuTWdhZUpMeHNLcnU1bCtPV1d6TjZnVjluR2trYmRhOHNr?=
 =?utf-8?B?YTVaY2NiU0IrSkE1aTZ3U3Y3b1NScGdQUWFGQzUwbnZTWENyTGh2a0htTXNZ?=
 =?utf-8?B?ZkliRjFwSGNFOFhhN3g2bUxzd0lKa2VoNGtqVWkrb0lrakpKQUdmcTF5MGFa?=
 =?utf-8?B?aVZNeXphRzVkNHloU3RjcG5YVGJRYzAwS2VTRUZFWFdsTUF5eVR1SEZoNHNl?=
 =?utf-8?B?bythNll1U0FmeEdRUzVtSnFWakUxZjFwREQ3clZyV1pDU01KaGZvNWNpcnhH?=
 =?utf-8?B?Ykc0dHMya3cwV1pNaHMzUXFjZ1FGd3Y0c0M3bFFhS3FXL0taMVFXc3o1VEVw?=
 =?utf-8?B?emFpaU1JU2NjVUZEeEFYVmpUTzM4WHhGanBzaFU2MUZLNWcxa0huS2RzWSs3?=
 =?utf-8?B?d1A1YXZLSmRKdWNuN0F5TXQveUJmcTVhdUNsOFpWc200NmtJT3dvS3VGeElh?=
 =?utf-8?B?YWpBYW1XM0ozcE90RUZheE8wWW0yaFh6cDlPK2RKRlpJdUI2VExJajlqeFFY?=
 =?utf-8?B?bnRyb28xNXBOOStzakx6d0puUHowTkNXZjJFZm91WVRkWUttcU50ZmM3UUtv?=
 =?utf-8?B?TXRqQitFY1YxbW1WVG1EQmJneXNJSllyaDhXc2ZwaEhtcnJsOGFERDNVL2RO?=
 =?utf-8?B?QWtLYnlld2M0bWphRXk0YzJtRithcldEdlUrWFNJVmNZQjVzUnZ1ZzF1RGFx?=
 =?utf-8?B?NE1EbC9tWmhuQkFCbXNoaWVxaDhCL2hQTGFDWnEvTEtuUHY4ZFpiMUtXY3FT?=
 =?utf-8?B?MmU4TTRpQ3ZqRlB2czkwWTk3MEtaeDlLVkYrYlZrUFBmb2NiUDBaSXlSeGNB?=
 =?utf-8?B?eE85RFhhMzlaUHNYRWliVWJQOXBYb2hENnVOSFJtWlpYOXh4VFhQeTMweHdV?=
 =?utf-8?Q?I+gotsxk2B0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NlNhSkdWdVErUkRXZ2tZSGM0V0ZOclhuOVNzSDVvejYzVlNaVGhLNWZReldZ?=
 =?utf-8?B?NFFUN0YwaXBCbEk5anU4by9RZmdGV3hJWVJRS09HTmY2eTYyZWFDelMxUmo1?=
 =?utf-8?B?bDNYVkM2cDRWS0xrcXRaTWFlNmFrY1FVSm5zeWVMTTd2YjVNMVZoQm15TlQy?=
 =?utf-8?B?Y2FZRlpzZEJndTRXUkE0UHFydXJxb3lQT3dUUm1sN2YvLytaWGptV1FHc0c0?=
 =?utf-8?B?azdSMitEMFRqNWNoUFBBcmUza0hzKzYyeUpmSTNlNjZnK2VXSUMwbkRRK1NF?=
 =?utf-8?B?QWM4aG0remFTancvdDU0Q3lDS0ZYRHZrWVZidjY1RHc0cmJId0VZSElHR21K?=
 =?utf-8?B?aUE1aDJ6RENZMDZkN0MxaTVZWTkzc1RLNVl1VUo5alVPMDlLQnJmQjlKdkp0?=
 =?utf-8?B?bUhZSk9rOE9TWVBUdHNhMUdZeE4xYlRRVzVKMVRXdFQ3dDloeVdPckxJMy8y?=
 =?utf-8?B?Sm02V3ViYm0yNUUybmFpRzlIVjlNMGRSU21YbS8zNlZkZGtVbFQxMUd6WmdX?=
 =?utf-8?B?WUR6V2ozODlaRXIyZlVPbldTeDBBemF5MFRIZDBCZFgwUDE5M0N0VDhBRWFh?=
 =?utf-8?B?K3hRTTlBSmRibkJTczhURllseEpOOHBWQXYvZDhBRzlXV1Q3dmd3QUcvd3Av?=
 =?utf-8?B?SjcxRStaNC96Mi90L1Z2TnhHWUtTTjBkamVYYW9sYkVvWXlvTXdjOXBORkE5?=
 =?utf-8?B?ZFNTT2RtS2FIR213MXZKcFdTY2N4Y2ViTVpOeUtWZ1hkVUFxVEFIM2c0OVFO?=
 =?utf-8?B?TjBibEZOWDRza01WU043d2w4bXdOVjNDV0ZnVUlVaXNpV01SYUtZSnBiRjln?=
 =?utf-8?B?SSttSVhwTXJlejFLYnlLZjFVQjRibkp2VU1Ma3ZGWU1MNTlRT3d2RmowdytH?=
 =?utf-8?B?NlBzbUN0QTVsTDQwaTR4R0phSE0yZHZrbmluQzRDTFBocGhab2ZQNnVHNTF1?=
 =?utf-8?B?S2V6b2tMbmNidytHcXUxeTFYRUxKQjNDbE1xNUFoRVkzN1FEVmdGcWVpWlZG?=
 =?utf-8?B?OHJqaXFsc3lzNkNsYWV4TkZBV05TcFBsSHRsUVFuamNVelhxQXhVeTY3cGc5?=
 =?utf-8?B?cEVYRGJlNjBMMkl1N2RLTWFvUGY4MVcrcXRRbmtJd3NiQWRmcDlZRGh6SXkx?=
 =?utf-8?B?aFFhQktXME1zZTBES0VvVS9SUmkwcW5nRXJsYjB0NnBaMjM1NGRpbEhrWDlX?=
 =?utf-8?B?aHFGK0huNGVIQUpFdWx3TUg0NGpzckR4SHk5TGpGYmxMRTBneWVnMHZsczJE?=
 =?utf-8?B?YjNTNENBZTQzSzhxMUF4VkhrUzgvUkgwUEpBYWh2Z3pLV2VQU3BVQUNjK2p3?=
 =?utf-8?B?MlZscXlKcFFodVNzOWI1cUJ2UzJMdHdHTWRmdzFlWk9VZHJuWVVpNm91RWxJ?=
 =?utf-8?B?dUFDbXNsTHVzSG5ZOWZPaE1UZ0JEcTd3OGhqTUh3TTY0eHc1UUp0S1VFY1Yr?=
 =?utf-8?B?VVczdXBPMTNUUCttOGJBMERxblpvTEFkRmdmSkZNYkFOcitrdkVqSHZEdWZn?=
 =?utf-8?B?Z3JoSFNnOGhWeXN3ek5PQUhUSjJ1WEhzMVBCZnppNUFvQ2Z6Wk43ZGN2Mkoy?=
 =?utf-8?B?MmVZUDV0dE9sdmVxL2F6R0pQNHZtL29ZbkQ2UitDVHhnSW9wRElkRDdtS21F?=
 =?utf-8?B?WEtMcXQxNU4wcytwU3FJeldmUE0vYVdlaFdYZFNmc0doZktERUV6aUh2dGlY?=
 =?utf-8?B?ekZEQjNSV1Q4QWg1MWxKWW1vRlFDYVphMlM0VDcwNy9NdmRRdFlvekFzeEJC?=
 =?utf-8?B?MXV5VGVWT0hVTUwvK2NGMUdWZCt5RmRBMHlia2JmQTBQUDZSR2xTNm1OKytB?=
 =?utf-8?B?YmZaYWZoUlJlMDM3cUVjVEdFbWlpMGFMNjZiVkN2UERuR21LRFBMVlEvM3Rm?=
 =?utf-8?B?cE5JelcrOCt1YmVad2U4VmpNTjJJMS9LM0x6ekZ3MVgxSCsybTU0RXdhdXhC?=
 =?utf-8?B?WUNPaUlnZTFYWUVCMStxODNOcFdBYjFwQUZvSHJFMWNRWThEaTdteEdvYjdm?=
 =?utf-8?B?dGVJZGNkQkJBS2txNHdYRHJFblNPSDhCZk9XZnBzcEFWZlp0S29NMDVTUFBK?=
 =?utf-8?B?ZTRvS3dsM1dUb3VQUndXQUtCZTZ6WElqTWhaSzVWYjlDai9Dbkk0WEpmRmgv?=
 =?utf-8?Q?XpBIL96YW+l4nFPuGu6P/YVGr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec3a6f6b-7211-42c0-ea0c-08dd9f1e521c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 02:04:33.3489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 828baghO0fWUw14CKQerVE/1K5BHQArWg7Vp7vhVEyBY1fTh/e8jLYO/RHWeDavF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8270

On 29 May 2025, at 21:51, Baolin Wang wrote:

> On 2025/5/29 23:10, Zi Yan wrote:
>> On 29 May 2025, at 4:23, Baolin Wang wrote:
>>
>>> The MADV_COLLAPSE will ignore the system-wide Anon THP sysfs settings, =
which
>>> means that even though we have disabled the Anon THP configuration, MAD=
V_COLLAPSE
>>> will still attempt to collapse into a Anon THP. This violates the rule =
we have
>>> agreed upon: never means never.
>>>
>>> To address this issue, should check whether the Anon THP configuration =
is disabled
>>> in thp_vma_allowable_orders(), even when the TVA_ENFORCE_SYSFS flag is =
set.
>>>
>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>> ---
>>>   include/linux/huge_mm.h | 23 +++++++++++++++++++----
>>>   1 file changed, 19 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>>> index 2f190c90192d..199ddc9f04a1 100644
>>> --- a/include/linux/huge_mm.h
>>> +++ b/include/linux/huge_mm.h
>>> @@ -287,20 +287,35 @@ unsigned long thp_vma_allowable_orders(struct vm_=
area_struct *vma,
>>>   				       unsigned long orders)
>>>   {
>>>   	/* Optimization to check if required orders are enabled early. */
>>> -	if ((tva_flags & TVA_ENFORCE_SYSFS) && vma_is_anonymous(vma)) {
>>> -		unsigned long mask =3D READ_ONCE(huge_anon_orders_always);
>>> +	if (vma_is_anonymous(vma)) {
>>> +		unsigned long always =3D READ_ONCE(huge_anon_orders_always);
>>> +		unsigned long madvise =3D READ_ONCE(huge_anon_orders_madvise);
>>> +		unsigned long inherit =3D READ_ONCE(huge_anon_orders_inherit);
>>> +		unsigned long mask =3D always | madvise;
>>> +
>>> +		/*
>>> +		 * If the system-wide THP/mTHP sysfs settings are disabled,
>>> +		 * then we should never allow hugepages.
>>> +		 */
>>> +		if (!(mask & orders) && !(hugepage_global_enabled() && (inherit & or=
ders)))
>>
>> Can you explain the logic here? Is it equivalent to:
>> 1. if THP is set to always, always_mask & orders =3D=3D 0, or
>> 2. if THP if set to madvise, madvise_mask & order =3D=3D 0, or
>> 3. if THP is set to inherit, inherit_mask & order =3D=3D 0?
>>
>> I cannot figure out why (always | madvise) & orders does not check
>> THP enablement case, but inherit & orders checks hugepage_global_enabled=
().
>
> Sorry for not being clear. Let me try again:
>
> Now we can control per-sized mTHP through =E2=80=98huge_anon_orders_alway=
s=E2=80=99, so always does not need to rely on the check of hugepage_global=
_enabled().
>
> For madvise, referring to David's suggestion: =E2=80=9Callowing for colla=
psing in a VM without VM_HUGEPAGE in the "madvise" mode would be fine", so =
we can just check 'huge_anon_orders_madvise' without relying on hugepage_gl=
obal_enabled().

Got it. Setting always or madvise knob in per-size mTHP means user wants to
enable that size, so their orders are not limited by the global config.
Setting inherit means user wants to follow the global config.
Now it makes sense to me. I wonder if renaming inherit to inherit_global
and huge_anon_orders_inherit to huge_anon_orders_inherit_global
could make code more clear (We cannot change sysfs names, but changing
kernel variable names should be fine?).

>
> In the case where hugepage_global_enabled() is enabled, we need to check =
whether the 'inherit' has enabled the corresponding orders.
>
> In summary, the current strategy is:
>
> 1. If always & orders =3D=3D 0, and madvise & orders =3D=3D 0, and hugepa=
ge_global_enabled() =3D=3D false (global THP settings are not enabled), it =
means mTHP of the orders are prohibited from being used, then madvise_colla=
pse() is forbidden.
>
> 2. If always & orders =3D=3D 0, and madvise & orders =3D=3D 0, and hugepa=
ge_global_enabled() =3D=3D true (global THP settings are enabled), and inhe=
rit & orders =3D=3D 0, it means mTHP of the orders are still prohibited fro=
m being used, and thus madvise_collapse() is not allowed.

Putting the summary in the comment might be very helpful. WDYT?

Otherwise, the patch looks good to me. Thanks.

Reviewed-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi

