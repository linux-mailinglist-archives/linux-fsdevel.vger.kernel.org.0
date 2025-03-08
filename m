Return-Path: <linux-fsdevel+bounces-43522-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D99ABA57CCA
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Mar 2025 19:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C30E23B18BD
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Mar 2025 18:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2F01E832D;
	Sat,  8 Mar 2025 18:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RAPBl59c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65792744E;
	Sat,  8 Mar 2025 18:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741458733; cv=fail; b=EAmrQvjvVfrPSPWp9zwFnZiTmHFfDFZRSkQxa/g8sHxggeREjm1wAvMiYOi8ZRZl/2G1zN9oPOXjrILeW48lyvZ0SQqfiUVeC6GbBrVb3a4qFyfwggU6pvuhnvTkw969W2NBsG0r2M1qRbPbYCCgNIv+SnMJzAwj2p8O/IsxgZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741458733; c=relaxed/simple;
	bh=VbrX6WNnr1ILKJBryIFUfpENaNmBXiNYAjXqSM1WAOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EDDnStMSl9JBJ1Tctsoqx86PzyCn2vRiDNrowzku0N7B46YGTN6Ees6lLmVjLieW9qtFrQE1HUOrUo2OB8So4EBUFiF0Wt44lA/7vKkmsvLyWQxCOkOXc2jqHAxMYI1QqQqH4t9+bQGhZRNWJlnj58xa2oWwWOw8z5JtIy/saBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RAPBl59c; arc=fail smtp.client-ip=40.107.237.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xlk1E88mgzfgwiaA3179AfPV952ZuZMExxKO1r/rMFnGikAzyOrEJYDk9sDIjurf4i1IqEXa/9uOFhX9ggGiHJg0Jyya+nx5u9pdFMcVfhqPhcBwKkeIjF0SUUGRK/PMjaOyWFmhkM1bpjcG4+8bKhT7hjItLflgrlIe2+L2XBaq/qfAeQuyKDQustF4Ono3V0dC4gTZ72eo0El5AMKqeQG8SB8sbWTg5Cm3Az+kzMH/TnmEHBXsZlTn8ZEjjFtP/jvWTSC6+dNXktDYRLGy7wggy8U4LxPUDv8B5awwtdwS3WkI0AVGy2nQDSRgo92x9V44w37YDIgLiNBDGLatTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z9w+6rHgFcZv4j2bPPW24Ze/CBGNeXBtGYkKKESjXAE=;
 b=bfSDq0effgOm/GYBUOLrLxqAyG7Mbxz90NAokg9sHM00QxBAU6RB5gx4nYs8m+PjypsRKFs3U6p6tspoqlyASN1w9XfyZE9PV3GiMuYJLdkl6yo8C8C3kipZ3JJr7E/qXumuvnYTfZqEq9VeALUVFsdM2riCkXJVEQy/CiXZgYF/MlplbCQ8bWwpcc2UWrDSA7uRC5zk6ybt9jvDDz+X7ipqDQqTaVrh49lvHUa9VrBtKax1zu7smu+pIm7UlRbV/MlC0yfVBxBWyysFrNE8Um354QdAcPkbOagW7tBPd9rTr+eaTFQ/Fp2HgUJflVVZtKutmQMGt9a0E0dt6TnSHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9w+6rHgFcZv4j2bPPW24Ze/CBGNeXBtGYkKKESjXAE=;
 b=RAPBl59cfC5d1BOxu3dz6SB4oPN0LcdYoaPGLINU6JGcKOY0puNP70tWS79wuA3cz7HUTnIy4oV/TO1S5YVmalnhyWtUENbduymMD9wMDmXXBswjEmhMODYWN0/gjf8LfxcfahxmcheQ3WJkpv0m6Zot9nUZijLafcpTunKRaHeI1baRVIABR/BXugaa9e4n0OJw7qQYrBdvc2NRqJZPDJbu8cnBTuhAYdOkEPEAzVM45gIR6pMHQkOzJ2rhhax1CqiLAucVZrJmOhH+VvDndvPGztmtAZd5j/hKMpImFsnD0S+3ILp12dSavaCb3jN9ydScbMn4DcPHirNMDkRBpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 IA1PR12MB6138.namprd12.prod.outlook.com (2603:10b6:208:3ea::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.23; Sat, 8 Mar
 2025 18:32:06 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8511.020; Sat, 8 Mar 2025
 18:32:06 +0000
From: Zi Yan <ziy@nvidia.com>
To: SeongJae Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>,
 Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, Hugh Dickins <hughd@google.com>,
 Kairui Song <kasong@tencent.com>, Miaohe Lin <linmiaohe@huawei.com>,
 linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
 John Hubbard <jhubbard@nvidia.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 "Kirill A. Shuemov" <kirill.shutemov@linux.intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Yang Shi <yang@os.amperecomputing.com>,
 Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH v3 1/2] mm/filemap: use xas_try_split() in
 __filemap_add_folio()
Date: Sat, 08 Mar 2025 13:32:02 -0500
X-Mailer: MailMate (2.0r6222)
Message-ID: <20A1553F-C30A-4D93-8A43-011163A22C60@nvidia.com>
In-Reply-To: <20250308181402.95667-1-sj@kernel.org>
References: <20250308181402.95667-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BLAPR03CA0149.namprd03.prod.outlook.com
 (2603:10b6:208:32e::34) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|IA1PR12MB6138:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d34d850-59e3-4a4e-a2b4-08dd5e6f8722
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TzZkcFZ3QjlvY2ZZbDk5M3U1VmtBYlJLRWhEMjNieEFEU3VwTUF6NHlhVC9P?=
 =?utf-8?B?T3lWQmZUSnQ3MTlnRU8wZ256LytMOHJTYWlTb3h6a2Y1ZVhJK05jYlhTYnFx?=
 =?utf-8?B?a2ExZmw0M0l0UmNCczc1ZnVHT0hUODlKTGtkSHI3SjdJZUdjSURLM1BKSlpl?=
 =?utf-8?B?QlFwZ01BbVU0cFpndzN1M3F0aXhpRVllLzdxV3A5ck41T3lJbVpCVTEwVFZy?=
 =?utf-8?B?NEJvR3BvQWdDejFiZkVSeVdvNnMwL1FER0ljM2pZN05Yd1RabStacnRSdjNC?=
 =?utf-8?B?L3BqdlRNQ3BZTjBwd0U1OVd6QVBiV1ViYlFUVlFiZjhVTEhzZ0pMOTFCQ0NT?=
 =?utf-8?B?TXI0WkFMek9kNUlXTjR4YkpMeVVoWjIvUWNTV3VHeEN6WFlHang0clR5YzNB?=
 =?utf-8?B?M0h3dS82Z01FVTFOdDlTUVkvSnBYam9hcFV3ektSLzUvQWhvWm1hczlLbVNI?=
 =?utf-8?B?YXJxbTVoKzVzSXlKOTMvYlhOcXY3bmNBOXpVQkFIOUlobEtFZGVJUmdwcXZh?=
 =?utf-8?B?eEUzcm1VV2FYakVUWmlmYUZ4anJSTWtGRENDT01ZNDJQSWpWTlRGdTMwS0ky?=
 =?utf-8?B?cUwwSFpGM0tPdnhvWW9JNnlyOS9BMWR1U2pPSld4Z0dzaTBqaVhFemhrZTUr?=
 =?utf-8?B?eTZQNlZOcFNLQUl2b0wzaU0xMGQwdzZEcU9sZDRpSXRNN2RpeGh3TURZdk4r?=
 =?utf-8?B?V21kNVA1TzVObkZIb2xKY0FzdEttUnY2LzkrQThCT0NMY3FiMGFCOUdTTW1J?=
 =?utf-8?B?VmdrUmI2amllNWhJaG5OSkVsMEpkcTJpNGZZcjkrMVpCSHA5NkZTOUpPUStx?=
 =?utf-8?B?eWxleHpGZEh3RzJoZnA4eFNwSDRjeXUwcFF5bnNVYWJ4Y0JnakRRMWN4OEFD?=
 =?utf-8?B?UUdiVnV0QVcwVUE2cVd5SDNRVlA4WXN1c0dQWFN4a0xCMHZBcGtWSks3TWx4?=
 =?utf-8?B?dFQ2bHkzNzVIbnZJL3VSTEFTQzB2RXV2ODhreXVLejFheU1hK0pWcEN0K3VD?=
 =?utf-8?B?d1ZXajF5NmwyVFJxRUNVQ1RQblRMT2Z1cFcwMjN5eXo4WGp6ZUhwOTZEay9W?=
 =?utf-8?B?bXQrSlVEUk42ZVhpWFAvZ3dhQ2dJakxNclc5RGtLMHc1YloxZU1ndHhzZG1O?=
 =?utf-8?B?Z0JORmk0dW9OVFhVb05JUTNMd0RYQnowSUdlMHQwYXA0N0JyNVBOSTVXeFhJ?=
 =?utf-8?B?UHgrRzdweE1sZlIxNlhObi94engvV0lDdDN6N2w3ak1iUkZsSk1FTTUwV3ov?=
 =?utf-8?B?eEpJZklpeWNJQUoxMko1aGc4bmJWK1d5SkE5OG95cERSRjd2K0JiM01wdE5o?=
 =?utf-8?B?a1pLUkpQSFZuZjJLSTdWWG1wczlCNmdwNTF5M1V4ZW1CRFg5ZDRHdkZKaW84?=
 =?utf-8?B?OWtuczhBVk5USHlidGN0SUZHZjVjOHgxenZpY3JSUlJicGR4Q0hkWXVmNjcv?=
 =?utf-8?B?cHo2ek92TU1iVGUrcGRwZDB0TU0zQkg5a2dsVFJXUmRqb0F2WkJQZXFlWjhP?=
 =?utf-8?B?Z2FQUGVLOXdCWDVINGkxOS9NQ3VuVCtrZldoZXFUa1VwRDRIcXdadVllWWpY?=
 =?utf-8?B?WGRlQVZzRVhsNC9GbEZVci80UExzUnQwTWJuNzJZMFdNUGp4VzRWN2lsY25H?=
 =?utf-8?B?dXZyMU9WY24wTmQ3RDJrVnFIOFFrano5QWhIUXZZeUt2aW5HbEpsZzRkUW9u?=
 =?utf-8?B?STJsUUVmSmRXcXF5YUJMallEb1dTb0MvdEMrNGhTZm9VKzNPVno3RU91Kytn?=
 =?utf-8?B?KzFkUHB0dHRpK0x3c1NFaXFCV3IrWHpDYTM4dVhJck53NEJraFB1V3F6T2tz?=
 =?utf-8?B?NktzU3hoMmQ1QjJZdWZCZWwycGlKNzVmdll0VkZ3QW1jNkkzRGEvR2t0N08r?=
 =?utf-8?Q?Ejlm8O5dZh4L3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ekxVekpybXVWMms4cGJJRytYMVNWSmtsQzJKekplVmV6bFE5TUJ5a0U3UVVI?=
 =?utf-8?B?OU51T3UvekVtdW02Z0NLek1CS1dNd1NjT0lnazBZSFltSndKOEpJUEhiai84?=
 =?utf-8?B?UVNSSWx1dGxVSlJGZWkybWE3WVE2M0x1RnhuV1RLRlFQZHg2WFRMRENkMjJq?=
 =?utf-8?B?aks4Nzd6TkEvUkVEaFdjazhjeG12aHdBdG9WemVaT3VsUTF6Y0k3bVdUL0xp?=
 =?utf-8?B?TDBBUVc1Z2VIMGtEWFRjRk5GbXdkVm5zRExOZGxmMEp6UUhUcTFSWU1FdFY1?=
 =?utf-8?B?ZWJ0c0RVa252VUFzWUNNSVg2ZjhXNElDTWVxNDhkZENaZEJpa29SMEV0d1VO?=
 =?utf-8?B?OFlzdHN1RkMrNGV2K1Axb0ZQZXJRUys0RkZ6YjNRR3dDTEFyaHkwSFJ0Q3d3?=
 =?utf-8?B?U0hERHJvRStrU0JHaENNU1k0WGVyNmtDQm0xcGZTaWgzRUtsUTdIOENXQXZO?=
 =?utf-8?B?aWdlMDQ4ZlFQTkVXRHlYNVR0ZGN0MElEZGwwMXVwWCtLY3FDaFl2M0RqMnNF?=
 =?utf-8?B?ZU1QekxUZVJxU0Q4L3kyejdwVVltSmRib29ZL1hwdk12eklFSkxBcTNNZW16?=
 =?utf-8?B?MkRGcXEyRnVpakdnTE9sZ3B2UXo4TDBHRHMzSVJDOUoyY1paOHh2NkRCOURk?=
 =?utf-8?B?VzFBYXdjYTlhS3dZQ2xXTzRnNnRMek1BVzVyc3ppejUwckFMdXZOTFdxRzlT?=
 =?utf-8?B?Mk5mdFF2STZKNXByYzJ4RFhhd0VHc0FmcTJZcnRWTlBrYjR4cVJHSGtGVHNJ?=
 =?utf-8?B?NUluYWd3OS9kWlE2Zkp0cTFmRHBWLzVDV2xScjhNQWhvR0YyOG5XQ1QyRVFi?=
 =?utf-8?B?dUlNSlJLd21uU1hYcEFxMkMwaU9NeXJCOW1BNUZaMGx2dHRCT1hZNXdmZFRp?=
 =?utf-8?B?Z3BJUXd4V3ZzaHVMa1ZMS01kT3RlUnhLUi9jOUxsMXFiMmtTcTlDYkV5MERq?=
 =?utf-8?B?eTNZcmxZZzRGOWRKNUZVOHV5UG9HQ21kaDB2UGczVFhNNFlreXFJcVRTN2Fr?=
 =?utf-8?B?UmM4NmJlMGIrMmdQZkcvRmgxMTVjdVhPdGlWRGc3YWtKVHJsQzUvbjMrUEhZ?=
 =?utf-8?B?OFV3OUh4b0NDWHFaQTlYa0NyK1ErSFBzNlhyRTRQbFhhcEIwZjgrdDlBK0ZP?=
 =?utf-8?B?RkVjbFlmMGdnUEh6eitZY2RYYzNISzlsd2tocExBTGI3eTBGWEo2aVQxQlNC?=
 =?utf-8?B?ZncxcklCQjEvSzU1ZzYxK0syVjBiRXY5YjVLRUtucVNaWGlndWhDUmtvL0M1?=
 =?utf-8?B?VXpVRmY5RTcxdUI2aklXVE5mbG9QQzVGR0NXcE52VWF5dFF1YWdhWGVwVnJD?=
 =?utf-8?B?emR3OUZiV0VXaUxCbjh3VUZubUJwWEIxUkJtUW1UeC9XZjgvVE9kRFdkT29v?=
 =?utf-8?B?YU91YTNxcERCTEx6VVJ3NFNuTWt4M3pkUXZTc085T2h5YndXUlJ1M0tlUTU5?=
 =?utf-8?B?VlFBbUI1YkVBY2JkR1FYZFJ2cSs5d0RSL2dkVTllamRJZ1NxMEtqUE1hS0t5?=
 =?utf-8?B?RE5YdmFBRks1S1ZLd3pJYW12cGx4MEhSWVF0WDB2Y2Y0dmcyVnpydGc1dWs3?=
 =?utf-8?B?V0RrWkJ4c1kvSHl0S1ZWNkFSN2lUejRFbjFIZzFsZlpPV2VLNWU3TG0rYm42?=
 =?utf-8?B?ZHR1cXRzLzkwMTdNMGVkTTRoYTZuKy9jRTdLenhmYktYYU1YK1FRMHovZUNW?=
 =?utf-8?B?OURkcjA2Um1rTk5UQnozRjM5OTN4SlpBL3ZuY2xRMStJOUg2R1pTeFNRWThl?=
 =?utf-8?B?bE9NV21hamNsdkpPeWoxM0pDZDRCS0x3OGFzcitncDZORFl3Z3J2Z0NoNDZ4?=
 =?utf-8?B?RDJvYU1nQmNaSjNvcjBiVzNWRGNna2NOMjJOYWtpK0NzMUlnL2tzRW0vWmMy?=
 =?utf-8?B?cE53QUF6RW0wMWpwbnMzYzU1MUxKSzFjNlRBQlpEQjhCZ3RiOWJCd1EwYjRY?=
 =?utf-8?B?QlR2TjVJRWxXK1g0ZHlsYUsrK29TZGRua3hlUzF1VGlBZWVVbEZuYVoxbGRn?=
 =?utf-8?B?RjJCREkrY09nKzE1aXkwdk5jbm8yKzFwWThjd3dvcmJqOXZMeW4zVGNQVjll?=
 =?utf-8?B?cGFPYmtLNHhzZ3p2V2JtZzVBQjNlNE15NCtjYzFyNzNleFpnNWF5Nkg0NVBr?=
 =?utf-8?Q?47lo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d34d850-59e3-4a4e-a2b4-08dd5e6f8722
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2025 18:32:05.9456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ifTymGwp6XFaw1wSQrmy5ecolZJKOtHsoZ8aqPmXKNO9rFXJgEBCm4Rs9RKa0nqT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6138

On 8 Mar 2025, at 13:14, SeongJae Park wrote:

> Hello,
>
> On Wed, 26 Feb 2025 16:08:53 -0500 Zi Yan <ziy@nvidia.com> wrote:
>
>> During __filemap_add_folio(), a shadow entry is covering n slots and a
>> folio covers m slots with m < n is to be added.  Instead of splitting al=
l
>> n slots, only the m slots covered by the folio need to be split and the
>> remaining n-m shadow entries can be retained with orders ranging from m =
to
>> n-1.  This method only requires
>>
>> 	(n/XA_CHUNK_SHIFT) - (m/XA_CHUNK_SHIFT)
>>
>> new xa_nodes instead of
>> 	(n % XA_CHUNK_SHIFT) * ((n/XA_CHUNK_SHIFT) - (m/XA_CHUNK_SHIFT))
>>
>> new xa_nodes, compared to the original xas_split_alloc() + xas_split()
>> one.  For example, to insert an order-0 folio when an order-9 shadow ent=
ry
>> is present (assuming XA_CHUNK_SHIFT is 6), 1 xa_node is needed instead o=
f
>> 8.
>>
>> xas_try_split_min_order() is introduced to reduce the number of calls to
>> xas_try_split() during split.
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Cc: Hugh Dickins <hughd@google.com>
>> Cc: Kairui Song <kasong@tencent.com>
>> Cc: Miaohe Lin <linmiaohe@huawei.com>
>> Cc: Mattew Wilcox <willy@infradead.org>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: John Hubbard <jhubbard@nvidia.com>
>> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
>> Cc: Kirill A. Shuemov <kirill.shutemov@linux.intel.com>
>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>> Cc: Yang Shi <yang@os.amperecomputing.com>
>> Cc: Yu Zhao <yuzhao@google.com>
>> ---
>>  include/linux/xarray.h |  7 +++++++
>>  lib/xarray.c           | 25 +++++++++++++++++++++++
>>  mm/filemap.c           | 45 +++++++++++++++++-------------------------
>>  3 files changed, 50 insertions(+), 27 deletions(-)
>>
>> diff --git a/include/linux/xarray.h b/include/linux/xarray.h
>> index 4010195201c9..78eede109b1a 100644
>> --- a/include/linux/xarray.h
>> +++ b/include/linux/xarray.h
>> @@ -1556,6 +1556,7 @@ int xas_get_order(struct xa_state *xas);
>>  void xas_split(struct xa_state *, void *entry, unsigned int order);
>>  void xas_split_alloc(struct xa_state *, void *entry, unsigned int order=
, gfp_t);
>>  void xas_try_split(struct xa_state *xas, void *entry, unsigned int orde=
r);
>> +unsigned int xas_try_split_min_order(unsigned int order);
>>  #else
>>  static inline int xa_get_order(struct xarray *xa, unsigned long index)
>>  {
>> @@ -1582,6 +1583,12 @@ static inline void xas_try_split(struct xa_state =
*xas, void *entry,
>>  		unsigned int order)
>>  {
>>  }
>> +
>> +static inline unsigned int xas_try_split_min_order(unsigned int order)
>> +{
>> +	return 0;
>> +}
>> +
>>  #endif
>>
>>  /**
>> diff --git a/lib/xarray.c b/lib/xarray.c
>> index bc197c96d171..8067182d3e43 100644
>> --- a/lib/xarray.c
>> +++ b/lib/xarray.c
>> @@ -1133,6 +1133,28 @@ void xas_split(struct xa_state *xas, void *entry,=
 unsigned int order)
>>  }
>>  EXPORT_SYMBOL_GPL(xas_split);
>>
>> +/**
>> + * xas_try_split_min_order() - Minimal split order xas_try_split() can =
accept
>> + * @order: Current entry order.
>> + *
>> + * xas_try_split() can split a multi-index entry to smaller than @order=
 - 1 if
>> + * no new xa_node is needed. This function provides the minimal order
>> + * xas_try_split() supports.
>> + *
>> + * Return: the minimal order xas_try_split() supports
>> + *
>> + * Context: Any context.
>> + *
>> + */
>> +unsigned int xas_try_split_min_order(unsigned int order)
>> +{
>> +	if (order % XA_CHUNK_SHIFT =3D=3D 0)
>> +		return order =3D=3D 0 ? 0 : order - 1;
>> +
>> +	return order - (order % XA_CHUNK_SHIFT);
>> +}
>> +EXPORT_SYMBOL_GPL(xas_try_split_min_order);
>> +
>
> I found this makes build fails when CONFIG_XARRAY_MULTI is unset, like be=
low.
>
>     /linux/lib/xarray.c:1251:14: error: redefinition of =E2=80=98xas_try_=
split_min_order=E2=80=99
>      1251 | unsigned int xas_try_split_min_order(unsigned int order)
>           |              ^~~~~~~~~~~~~~~~~~~~~~~
>     In file included from /linux/lib/xarray.c:13:
>     /linux/include/linux/xarray.h:1587:28: note: previous definition of =
=E2=80=98xas_try_split_min_order=E2=80=99 with type =E2=80=98unsigned int(u=
nsigned int)=E2=80=99
>      1587 | static inline unsigned int xas_try_split_min_order(unsigned i=
nt order)
>           |                            ^~~~~~~~~~~~~~~~~~~~~~~
>
> I think we should have the definition only when CONFIG_XARRAY_MULTI?

I think it might be a merge issue, since my original patch[1] places
xas_try_split_min_order() above xas_try_split(), both of which are
in #ifdef CONFIG_XARRAY_MULTI #endif. But mm-everything-2025-03-08-00-43
seems to move xas_try_split_min_order() below xas_try_split() and
out of CONFIG_XARRAY_MULTI guard.

[1] https://lore.kernel.org/linux-mm/20250226210854.2045816-2-ziy@nvidia.co=
m/

--
Best Regards,
Yan, Zi

