Return-Path: <linux-fsdevel+bounces-11481-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62934853EB6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 23:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEE4E1F29C35
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 22:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C8C62811;
	Tue, 13 Feb 2024 22:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PdFdiQQH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DE064F;
	Tue, 13 Feb 2024 22:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707863469; cv=fail; b=c9KfpyE43XA0oLwTrRNSjXI+u33K18p7rFTwLlHh1yTvlON1zFIjouCDnt6gFG2JdnRpZD8KQKGjnfgRDZ7EDPaJchR5QE/IQqJRSu8T/H8m43iexYNdQZ5h1SAOLKzn/q2JEjQbW9Blyc9PiPUSgDQNWsWJLHraF/etoZsuczw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707863469; c=relaxed/simple;
	bh=cEB9bSn7ipaDs2dQQ9H8ZavraOkM83RryC0qk3Up83M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aw1G0VQmEV1O0SZS7OWn2S5EUt5fHS/Rznfy8KUq8MQJs/rIr055e0IoAfLZdr6cpDiziO+gYAeZzgP+ikThGKsDOumaPlbiKsQreDS+4p+LAi7HwIipNskSvtgE+hAwBfmXF5I7wb4lOy2hbP2Ob96w+xn/4/jzqzlIM61mQgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PdFdiQQH; arc=fail smtp.client-ip=40.107.237.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZUqd/s1bdhrvwmc/Y/8zhj4EGo/a1idponEm0NTMyxm0jT2HZzYXWTzkc+4KL5NQxsQXFzYrwhx0UED7rq5a+kEKNpcgBC6gzeUPDsYxpAoayiQqSaIhe2no6Nk4m+Xjx8S4Cfjm34urHKZVpY47M5VHpvh44Hf4MWRd35vMz6+t6hl42Qz7o2BETZQEffSIQndef215BIVXU6sWjMDkcURBhEQPiXJbSbd0Nt4n7Fok3LSLtCAbZE5pOGgt5NlZpM/fI6K10jPlckkt2wRfF/xCn+nH4Htj5UdIGRLxfgHY9ovD+OU5mvnxdx7fJ1IWc4EjsChDAP4EQFY8t7rThg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cEB9bSn7ipaDs2dQQ9H8ZavraOkM83RryC0qk3Up83M=;
 b=Ed6LMuE5LF89BbYDOxbZrXzZxOdqQwc1atGWRmblryz5bhVGOjHaUU6uvsAud08hirtpO01LYylHw0oJC7JudmAE71TpOhmDhVZWnCNhAt97JX7Lbqzw6oaXQ5cXa0JHoHzoOUMgqog0AfmxVeBIFRkaVBe/zsyvNvqQ+YHpuYV1nioOcnBGy69X6X3ECQUh8HFQvIqycE3+0p8IgWP6hR466H3tWfE8101YMI2ffUozHvBr5Q+goPYEDGrIXWIGQz/xlM2SwjsGR430PXCzZ7pDk1kBfRKEKY49P2bwXRmnTiPevwvXZ/Ials0Jcc8y4Gy2sphHyoQ1yHsLmKghVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cEB9bSn7ipaDs2dQQ9H8ZavraOkM83RryC0qk3Up83M=;
 b=PdFdiQQHWeh7sDyHmecn745R3S/Ni4x8YW2yUuUKDjmK5lBm/SDCwkSzRO0EWvP7eFzN52kLRqzVVSvSKB4Jlg3h6tfkJBHYN5PAFn5S+PSCJn7eGImucX44MvhkDv6yn3zVRldWvYnJE5ig2q3ZsHokfvnE/YotA/vETlrVurrVxqI7U+dEG7vAPRpk4nqIz0NptWmYxpdGM4sfnOX2Bc8VXwE8VuHQLvGoODE0Neh9PW66D3cc1j5UZFnxPOpOfW5uGG7eQLYeCjQw2xpeV8ZDzPEe3D/t8tVnJNEvi3fHZMP+krbP6oux8MG3bz9yEwP9SRL4W0sVN5QjGekF1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 PH7PR12MB5879.namprd12.prod.outlook.com (2603:10b6:510:1d7::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25; Tue, 13 Feb 2024 22:31:04 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::db3e:28df:adc1:9c15]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::db3e:28df:adc1:9c15%5]) with mapi id 15.20.7292.013; Tue, 13 Feb 2024
 22:31:03 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: "\"Pankaj Raghav (Samsung)\"" <kernel@pankajraghav.com>,
 linux-mm@kvack.org, "\"Matthew Wilcox (Oracle)\"" <willy@infradead.org>,
 Yang Shi <shy828301@gmail.com>, Yu Zhao <yuzhao@google.com>,
 "\"Kirill A . Shutemov\"" <kirill.shutemov@linux.intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>,
 =?utf-8?q?=22Michal_Koutn=C3=BD=22?= <mkoutny@suse.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 "\"Zach O'Keefe\"" <zokeefe@google.com>, Hugh Dickins <hughd@google.com>,
 Mcgrof Chamberlain <mcgrof@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 0/7] Split a folio to any lower order folios
Date: Tue, 13 Feb 2024 17:31:00 -0500
X-Mailer: MailMate (1.14r6018)
Message-ID: <F4470D3A-DC2C-4A6A-B65C-1C94D732A60E@nvidia.com>
In-Reply-To: <659e1abb-40d0-42ba-ba0a-8256d7eb1c5a@redhat.com>
References: <20240213215520.1048625-1-zi.yan@sent.com>
 <659e1abb-40d0-42ba-ba0a-8256d7eb1c5a@redhat.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_13390F71-957B-4974-917E-22BA13AE02CE_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL0PR02CA0123.namprd02.prod.outlook.com
 (2603:10b6:208:35::28) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|PH7PR12MB5879:EE_
X-MS-Office365-Filtering-Correlation-Id: 8493b2a8-e25d-4f15-1a78-08dc2ce37681
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FrGqSgo8+fdHk5yGN6ZQHtICgd3kTAUwjzfjb8ZcfQvOjeRSMw/lXjET1+c5O4w0pNLcuX2EyadATlt9YtJvTNNVvIdLPTMvnXmtGMUSZMCjEECo02M6kdUsnScIWMZmm7JLlG2hwI6Xn9bCCK7Sc3xPong/36tM0fM62oNp4eBj8iNnFOBZTsaR1kQALapItpXDKNIVO2yElahdS0vUBCf7hdpMQvZKWCM29ql2cl86fH03PwW9gXBqJhK5tnFpB35ArJcBSnE4rRe2z51PJQKoB/jeXmXt2ZuG2D9w45/mLXVk+lzSypWCmPjw0CD411uQ5wFkuzf3DPE+g+suxopw0/wGupegirafFGLhCFyY6VeSIR0+Wz8I5UZq+rHGovB54La3hlW454njkeHt7dd8K2ygKw4wHH2o9EQrjASoe3qQMBYwzBQnv7VKOVzzVrchKe8UWiqh2bhhdNwQgl7zHRx18pUWqhtVjOAHYABDFcv43uNK2esdnXXg7DZ3JmtQP40zfoIPe2xLCjw/89RIG36Lg1LRuJdhsT1Y3Ip56RpdPAODU+m4zf/NZinJ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(376002)(136003)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(2906002)(5660300002)(7416002)(235185007)(2616005)(26005)(41300700001)(4326008)(8936002)(6916009)(66946007)(6506007)(53546011)(66556008)(66476007)(8676002)(6486002)(83380400001)(6512007)(33656002)(478600001)(54906003)(316002)(86362001)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vsl03gJ+pL2Xh7Hdb/heTWcLxed4dq++Jh8KLuGcGgd5ZpKsPp2L4Oe1xEYH?=
 =?us-ascii?Q?RKUkBNwinnP/XtFCEZTLeSpJZTnaoDuj0aqfUHmMc0EoLw9mg/nzZe6zNUIq?=
 =?us-ascii?Q?y65o1453cNWOBF2voeY/AE5arF+WfYwC7qx4sL7FafAsEELDHEsGUacJLsOh?=
 =?us-ascii?Q?cz+GjhQr2beuoEySjpEWgU9VLhJMPVA0zW9nU4e8M52O9eHpYn1R/Ab/eLjH?=
 =?us-ascii?Q?RpLNvl8mAyS9v4N6F4RDIre7L2fpGj7t9rquOQIn7mVwLrASw5/+V4Alf/Lh?=
 =?us-ascii?Q?JTX4rPbHa6yWxQRa4mj9RUl86rBbMM4HKDxZh670MKVkc9bZ4RgOhGxOQiFM?=
 =?us-ascii?Q?GM2CpxbC/u2T0WbOXYGWVUxgRnyFmPTj9m5JHMDXF40d0ZP6mUtQQz+7XSkn?=
 =?us-ascii?Q?UylV1mmoQJn0aA8KMysa5CCq/3N7BWyMa38ZHD/mCGJMlyHXebgwv4aHCxOC?=
 =?us-ascii?Q?kRiFIoEl3epoX0KK6jP0j0hNmWYWtOe/wWxNkhqXfZsLg+/Oq02HMufRB+s7?=
 =?us-ascii?Q?awfXlNmVJ8mHiTsbP+qhOZexZLiV00O6fHi/A6Zvhr2C0dDQxekYrfsHNYJZ?=
 =?us-ascii?Q?k11l74dMM2nKdHwna+pywUYEbXalFdpsxHJMZZZxQ0rsSP6kGy9fBxUg1tMD?=
 =?us-ascii?Q?8dFptufYpCVt+I+qe8MhRVSLAHfZZBGzYa76Sh+fwDyXBdF55pY6BXvgOUSl?=
 =?us-ascii?Q?wbWh1l/+wsCvG3o25i6027qozxHaRLerCDA2QUNAGjuwgm3KbRyaaIx2TFyH?=
 =?us-ascii?Q?F5MmTbljUtoAI/rq3nBmKU/TmRV7ESjubLX9LdE70tOJSjzd8+H02W4QLF3H?=
 =?us-ascii?Q?6EREWpfMzGVKbU/1MeaDnybPDBsKYIgTFOZ0kdJRpEOiEALQIT2He4ctLenT?=
 =?us-ascii?Q?L/TZsrw0eZ8NGF+GVVrjSK6xO+cNVRLziAnKGNLYzyEUrqHmxEM30+tINhi4?=
 =?us-ascii?Q?GMBgJ1lGAvdqvnDX9W6yEGoYQqKt7AsldTDIrk6rAgWYTpcSgtrbxhERblxY?=
 =?us-ascii?Q?He2HMJOR4GF3c3TJMrPHboQV8acfFaFZZWXCAK0Uaz88OwrzhpJVrTVZ3hmp?=
 =?us-ascii?Q?P1gnFLUnNNLufX4X0zFLxZz3VH8yRAIzcHADOzYT2ZuKSjxrIXXu+gfg8f/4?=
 =?us-ascii?Q?52K3CaBb5BN7/SKhGiEAwy4RhUwFFSsz0UeVBPa3cAtXltlIpFyHCUxv9b9B?=
 =?us-ascii?Q?Iw58JKwzmD4/qQ5JEpFIioJ0+D24OV45Z0Dq+A5kObYzWEKfFwUq6xIFGutr?=
 =?us-ascii?Q?N+HVnYqhuUM3EKPfP7sUCnjK1X0RALRW5YIh+3FfOr328mUOjIOw9aPZl0dA?=
 =?us-ascii?Q?I2rLgpOv4g3l+ZSiz43iVDAUEjlxDH/CQAzYZv0pdFRPkwEp1uQixzFJVdVn?=
 =?us-ascii?Q?RnRPouApvn3xJbNudYPRyM8zvnISPcuV5dTooc7c1Tw+Lw5IUhgIdlHAVvUd?=
 =?us-ascii?Q?NRO2vM4047tUSXgnPvRov44LIqczwmp3z4+OJrNvJ3jdABP4llLQOzdSOQ1m?=
 =?us-ascii?Q?YxAbCVMdzJQEhtkIUKHIHh52BEICmUV1fDRgKtO0imHjViLiWWfgTnyssj5Z?=
 =?us-ascii?Q?+NfI8E42i3Azf0F011DZT2U6DIVc/G2sX8JN31Ox?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8493b2a8-e25d-4f15-1a78-08dc2ce37681
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 22:31:03.8212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rZLe1NDUgfQfXW79CVvTeans8itLZuZjTWdFWMTiaPp14yNFBaVoY1ntHOI/GkzE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5879

--=_MailMate_13390F71-957B-4974-917E-22BA13AE02CE_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 13 Feb 2024, at 17:21, David Hildenbrand wrote:

> On 13.02.24 22:55, Zi Yan wrote:
>> From: Zi Yan <ziy@nvidia.com>
>>
>> Hi all,
>>
>> File folio supports any order and multi-size THP is upstreamed[1], so =
both
>> file and anonymous folios can be >0 order. Currently, split_huge_page(=
)
>> only splits a huge page to order-0 pages, but splitting to orders high=
er than
>> 0 is going to better utilize large folios. In addition, Large Block
>> Sizes in XFS support would benefit from it[2]. This patchset adds supp=
ort for
>> splitting a large folio to any lower order folios and uses it during f=
ile
>> folio truncate operations.
>>
>> For Patch 6, Hugh did not like my approach to minimize the number of
>> folios for truncate[3]. I would like to get more feedback, especially
>> from FS people, on it to decide whether to keep it or not.
>
> I'm curious, would it make sense to exclude the "more" controversial pa=
rts (i.e., patch #6) for now, and focus on the XFS use case only?

Sure. Patch 6 was there to make use of split_huge_page_to_list_to_order()=
=2E
Now we have multi-size THP and XFS use cases, it can be dropped.

--
Best Regards,
Yan, Zi

--=_MailMate_13390F71-957B-4974-917E-22BA13AE02CE_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmXL7aUPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUeQwP/RMkvJ3oGo5mYQVh6hBkj0FlEK/gFyX8fcRt
rFIYgrthGL0H3efj6259sLXczM4YRzvfZKyu2bAFLphQOwtgIa++Lez3lPMXRhbw
8rz4ni/uDhYmeQyNR78piZ6Zruyl3iuIAR/zfTWzhZtcv4nTsTdpvaLyDkL4Jpay
U7AnpJggZrRfkVmfXK9l40Y8rHqtFoRKFxzy8ZfYj/cNC+IDTxxXu08f1XoStunQ
VQAbMC0ycxQchZFC19GV20HlyxmIKX3Oq6AYUt3q1WMHiZ0yh6FEMTs5HXh2oZHU
UTWjAeK2txDkVhm+EJyrmjKYSHaPvIDME/nEVdSOBMUVtSoKB5xiEObsgGoCCdPw
UKnFafcsU65DtYvFQB7lvQ8uUtl8DGTDY8U451q4Z+BHErne9Iy6yCGv+Xb0+Ws6
JMrSlhfCyxnpSANDtvGUJOUOH+MUpKzScacl1M+M/0LBD8eXYfWVron9tVy57r4+
9sc3IDq2hr/DsuFD65MfTFzyP9wj56CxrF1HXIVahO5Vb9eTACNM06Vo3Jk38AOX
oA8z2PTdPytQMMmh/rQIoOv/lkQUOV+eYY0pi0Q86ui/gO+nyjJFUvTa5AfRqT3m
kObA5KBQF9yaBllmOU32zGadXyYSQaO3gTksr/ENk55wFUGNd7VNuQl/cJBz8GjW
wt3yFp4s
=UQBV
-----END PGP SIGNATURE-----

--=_MailMate_13390F71-957B-4974-917E-22BA13AE02CE_=--

