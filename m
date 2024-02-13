Return-Path: <linux-fsdevel+bounces-11475-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36224853E7D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 23:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B69B1C22D9A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 22:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392EB62167;
	Tue, 13 Feb 2024 22:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HR/ypqY3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC786167E;
	Tue, 13 Feb 2024 22:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707862784; cv=fail; b=mXHOFjMMxsbCIHEqhOlXkJXpUygOpXedlko2xmge3qtr04N88pmTZG8+uOWDPaLeBg4jYT+NKEPA/H0J6MkfXZhdoZ8pIob0/JlBriTgGPwNVosEKVhfVbiBYsdFrmuV5H0mS5wMMANlIzRtNMNsG+UUQGxb3cw9rvilg8TEiZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707862784; c=relaxed/simple;
	bh=KdHS8HBxhf9+9b7GsOaa7cOWwADLRWilpOkvOM598d0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q6DWoZGW3y/qPQfBZHLLbiUEnVxCxX14HBLkwsXQS0Ref1LLvbXe2YVWNmGgisO5hgzoq5ZELo4D9Fi9a7DfYQYlwSj3S4Nwf5MBDKSbNDI43Fbkqyv/3FcGwepw2cSCA1Mlwtz3lOPA+xxM5I6D5WyLmMoQvJcBsftVL23dG0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HR/ypqY3; arc=fail smtp.client-ip=40.107.244.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dR85TS29tSXNwkdzaVAo6x2P9sfZRJbUbjMZqlA6SFzauc8mi+x9+l/87NJdGieXLpRf247Zsu5xikrNSQQXCwDmA5kF++sSMDhwjN9HLsfEbKZcNuCLPx8J8mbx0VvdOYgQAygkg07AWCIPAxnU6Fo2FBjWRvQZccsJitG63RnqD24gIH5HisHPgUq/Vr/snCbR3kBzS4afGO0nqIvbJHsWiH0EWRftJXCQBHFVfpgAOMJldIpxGFLMPTZIh3WgX38Mge05tD53URKmfk5DR2DtO5RIWkCp/W+PvlW6XrcXNY0dgsMm4bhAiAsoKO2EzElhShqtQIh3vlGQDeO8yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g3LyZsJSn7CSq7SwnD0HBPeQTAqzB7WG+sTF+HyI770=;
 b=Exp3v7JtRzD54rAWmkXtl4dVLE97xXHn9k5/aIO7Qy3MyB7zpj3O+xNsqOaM17vMkdCfrrsC+dHKos/mnJA+AbTFriuzc+aY1HSBQFjLYfi5uMjeRdFJ0WLRoHYhxkzkp9yfwZZX3371bTJCe3WQrAVA5LMwDVZxyf0Vt5Jra+zzQG+TTKubcncjHMDUBxm670xnOeUlRZVubFjI1Fa29/MuGLxcmCWP6S45LoUmwnp1OwSsvmNxl1uYAywEXFsFeMOBAKAwKIr8hPsIegGWJqdKYlxgnl8Bfg0BFYiZsO7qMII7lfQxUteDdMu+RTsyJ9it86v6/8YffDdn5hyh7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g3LyZsJSn7CSq7SwnD0HBPeQTAqzB7WG+sTF+HyI770=;
 b=HR/ypqY3R00vBaozFPYuPAsqyB17w3qfegguF63rMDFqQNR8SYhAHyv5vW8vy3/c9tiSF/61e3F8XaFijNZewAIaaHD/cF5Fo4lXiLp+oxES7Xxg11Ep+cKK+Vf1/s8kWeE1mnyLjbJDgz3uxKf02O54ZgjopmBi15rv90pbmiGMfhhqKQvhAKImWwOyQyduVsqd6sy8CGe1Oh/evBoKi3fytAHvOPbFAbJ4+SZxAkrFH+ke2q4Zk0HY0kaO4oNikEtb65Th8VPPspgLoow+Rhx1Vgo3MJQBNRQu0sfcqrvyxIuySkKWbpwXE60Wl7xN8TSuyU9xzdeR4s2u20zKWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 CH3PR12MB9077.namprd12.prod.outlook.com (2603:10b6:610:1a2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Tue, 13 Feb
 2024 22:19:40 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::db3e:28df:adc1:9c15]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::db3e:28df:adc1:9c15%5]) with mapi id 15.20.7292.013; Tue, 13 Feb 2024
 22:19:40 +0000
From: Zi Yan <ziy@nvidia.com>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: "\"Pankaj Raghav (Samsung)\"" <kernel@pankajraghav.com>,
 linux-mm@kvack.org, "\"Matthew Wilcox (Oracle)\"" <willy@infradead.org>,
 David Hildenbrand <david@redhat.com>, Yang Shi <shy828301@gmail.com>,
 Yu Zhao <yuzhao@google.com>,
 "\"Kirill A . Shutemov\"" <kirill.shutemov@linux.intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>,
 =?utf-8?q?=22Michal_Koutn=C3=BD=22?= <mkoutny@suse.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 "\"Zach O'Keefe\"" <zokeefe@google.com>, Hugh Dickins <hughd@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 5/7] mm: thp: split huge page to any lower order pages
 (except order-1).
Date: Tue, 13 Feb 2024 17:19:37 -0500
X-Mailer: MailMate (1.14r6018)
Message-ID: <0A9F291F-E6B3-48C0-A2B5-3C893F02AE1D@nvidia.com>
In-Reply-To: <698B47BD-5E5E-4B8F-A998-8692A4918A5D@nvidia.com>
References: <20240213215520.1048625-1-zi.yan@sent.com>
 <20240213215520.1048625-6-zi.yan@sent.com>
 <Zcvns2HCB61cwvgE@bombadil.infradead.org>
 <698B47BD-5E5E-4B8F-A998-8692A4918A5D@nvidia.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_E7E50079-E5A9-4E7A-90BD-6EC1A1BFB8B6_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL0PR02CA0142.namprd02.prod.outlook.com
 (2603:10b6:208:35::47) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|CH3PR12MB9077:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c18e5c2-4837-4adf-5dff-08dc2ce1defd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ptwh2DSUOXiaSkeV3d7fGtF1L/2C7nCb04mDWPpGDUg/ts4gamE3FmsWsOM5c06XVOETpuZMN5XkcCfJqX8iubq0+AMNMDEd104985FwjzCGwlh37UcMj3B/ukiW0YwLhdCT0BFob2acJ5zD/gCihAzdUbmUmOW/yUVVN0NfGtoCnJt9X31rBNRR0z5+g9+p4rdM4L7G1PBF6/FGqLSJuycoX8dXkqNWJ/r2FL+G7sqZr7eB7AeMO66X1AxF8se5RY00Uqw0yGbI7KJnLKcsGboS0Q6eCMBJrGTPOYMFxpq96B7PZFPQwrewRLflnEpKyIryYI5J5IgfPdyAE43aaU+zTSAZVN1ln26cUqPKbBq/hUzAbWgM/fRfVcm7bjop7ml62dtHlMRHqevB+rhcrzGuYIkzbsNeCkTh4P+Jedo1LVMFFguAA3IRlNZuXdTMBFZy4RMQvh36hVj1ldh+VbbytcYA794KJqd2ZO7ZID1vEIlkJFcWoGAX1bpiGo8BO3xnUSen2vfabpGh7hIg9KYFwjkBDd4JwD5DZijpeyYy2roMV2MVNXj35JBKwQAt
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(376002)(136003)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(2906002)(8936002)(4326008)(8676002)(7416002)(5660300002)(235185007)(83380400001)(2616005)(26005)(36756003)(33656002)(38100700002)(86362001)(6506007)(66556008)(66946007)(6916009)(54906003)(316002)(66476007)(53546011)(6666004)(6486002)(478600001)(6512007)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vgx4eiI87o5RTPsjbqvAJkuGc17DN3PqRDzE/WXTMkTpRYfWZd5lMACcdzRG?=
 =?us-ascii?Q?Fa6ZthsZKrI7eqW7dfVgkCCB5cp/1+Bx2osTTVf1NL12/7/e5aS+LEf/xNyv?=
 =?us-ascii?Q?64RjS1Py1M/pgkuu1i6vh0ipN+gvOWb3ZtuuP8NfmuZ/puMT/rr3q1d4LE08?=
 =?us-ascii?Q?0SuEZJNjMoRbh+ImmYAHNNeyFG2LJm5evzLTfhoGA1vU0pnUECmba8G5ysMu?=
 =?us-ascii?Q?+TzcAcUlZ8oD5csTSQs5RR7TeiO9t85raXNVaoY4rW7F9onlfVRLPKCYzcrc?=
 =?us-ascii?Q?uHai0aHXdeTRfATQft3SOXOFt6UURICvGRJTb/Xi8QI/Q0BHvSdpvkxcTy48?=
 =?us-ascii?Q?rqZJYqXLZ9hX3ZDrNl471aVrpeSZAbF46ekmSJrXt3HuFwjNpn6vSlxJf2vE?=
 =?us-ascii?Q?nuMUn2GoBKqsiB8s906js+7GTRvXAglTX5I27ZSAMbAX5EILJ2/k2J04UY1B?=
 =?us-ascii?Q?gar+SE7MtYHkIWUSJF/vBTlyJhf/BxO/PHhji4sju9z8R6sa5ZiRnjGNHhLm?=
 =?us-ascii?Q?oN94nmXyQZO6tTgJz7WSWb9I82a13YpqZQ7el5++HKXjwEAAaby+13oj2vgF?=
 =?us-ascii?Q?GSRjS7D6r8S4wWvjmI1CIpKl6x576gZ0v9PHfjqBvfrwXPz6W9fEt+3LfWol?=
 =?us-ascii?Q?9ZF1JrMOlyKA/r2vy4Rfnhxx089N/JnE0kl2KfyK8+wosy8rw2HIeNY3i5Wr?=
 =?us-ascii?Q?JwNUAa+s9qKjmjPYidhdt5sYvii7mnM9NYkSAebbWUWviREdEX4e4OB14Iw+?=
 =?us-ascii?Q?O2LV4yccj6lq5ykfNau0M6IV6lKmGHxjT4jPaAyth2iFdqkCfEHRXblMDQfB?=
 =?us-ascii?Q?LbyDJ53N1aT0OEbtv3bF4X2DX1rE9xulg9nG3hEwS3QlKuCGAKrPhIH+2wto?=
 =?us-ascii?Q?7ar0zB6DjUfXAjB/RFkZDnGnc2Hx+gBPmzTmDv0uLJyaVkkULs1eND1MUHE4?=
 =?us-ascii?Q?TvAXJlu+42K8+DGnl6+5c5vsdiJkeoMW0zc6lPHjqWGy/eKc4YNkOgBbwXXR?=
 =?us-ascii?Q?yrf6CHHS4T2lpqf2N6YMqYVh85x6c7aFg3BC2Fvm8QrnJ3wKW4KtM71v3kaA?=
 =?us-ascii?Q?85n1xSqi1/j40MJahlfSKf/d/wPKKh3p1FOEfii0Fy8zf9AT/+g2ar1L3CK3?=
 =?us-ascii?Q?AiWKVPcXIoo/zKVOpOTslbx+dtZLCr22yrzob+Atqt+yxXm4yMYQyzrXh5RX?=
 =?us-ascii?Q?q6SbAJF7ijoyzbcB6EzaBFPtc7XRUWpF0P0DFwUPWstW9gWa7l11uqixDYEC?=
 =?us-ascii?Q?oIQFDzOZG+VISMmi89ua3yKreApxzQdSNDi8lhdD/6ihKKWjibXnWzMlaq4x?=
 =?us-ascii?Q?6+kBo2U90QFIWP5fzIpx8DBg7VcOYo0o28Wvr3gtt8ewPeygItNbQKzm+C4z?=
 =?us-ascii?Q?i8GZKjHWpyWmhBhs0HvtK/5fYCYjzqg1axck0GJb0SAbhzrml5qqREGo/GWs?=
 =?us-ascii?Q?zFBSLuZgijn+0mIhYBIr4zQasipe/KbA9Gnob32vw8Va3s+LDLoc3ouIpeRh?=
 =?us-ascii?Q?fXLhmfrPiXyUi/cjvxf2+YuN7izzFqBDnr9mf1L5YcxIwDh1K9Zq2Bk4aR7X?=
 =?us-ascii?Q?yppXoLi4jDLQCvRwI+LSX22xQfKZsadn/opZHy24?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c18e5c2-4837-4adf-5dff-08dc2ce1defd
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 22:19:40.1126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zisfxjdES5ebYHoXp94YmRlAtpNwAwbcDeFDvsRxZk+znwspubJbhcYQn9W8d0fM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9077

--=_MailMate_E7E50079-E5A9-4E7A-90BD-6EC1A1BFB8B6_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 13 Feb 2024, at 17:15, Zi Yan wrote:

> On 13 Feb 2024, at 17:05, Luis Chamberlain wrote:
>
>> On Tue, Feb 13, 2024 at 04:55:18PM -0500, Zi Yan wrote:
>>> From: Zi Yan <ziy@nvidia.com>
>>> Order-1 folio is not supported because _deferred_list, which is used =
by
>>> partially mapped folios, is stored in subpage 2 and an order-1 folio =
only
>>> has subpage 0 and 1.
>>
>> The LBS patches has the patch from Matthew which enables and allowed u=
s
>> to successfully test order 1. So this restriction could be dropped if
>> that gets merged.
>
> OK. But it only applies to file-backed folios IIUC. Anonymous folios st=
ill
> cannot be split to order-1.

Something like this would lift the restriction:

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 0564b007cbd1..7ee7f1906617 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3045,9 +3045,9 @@ int split_huge_page_to_list_to_order(struct page *p=
age, struct list_head *list,
        VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
        VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);

-       /* Cannot split THP to order-1 (no order-1 THPs) */
-       if (new_order =3D=3D 1) {
-               VM_WARN_ONCE(1, "Cannot split to order-1 folio");
+       /* Cannot split anonymous folios to order-1 (no order-1 anon foli=
os) */
+       if (new_order =3D=3D 1 && folio_test_anon(folio)) {
+               VM_WARN_ONCE(1, "Cannot split to order-1 anonymous folio"=
);
                return -EINVAL;
        }

--
Best Regards,
Yan, Zi

--=_MailMate_E7E50079-E5A9-4E7A-90BD-6EC1A1BFB8B6_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmXL6vkPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUd6oQAJzdSR3VAMsWoEIRz8oo2WtMMC86LrCQMhC+
/A8p4iIUrYs9SjsLABTaH8cVzKouxkC1TiFtJjXkWF3nKUAinwZizq/0FwdsK8fy
T/nGTxVXqe68iUE66ZFv1WJ8TWi3guMgnIqL1UQPnI5Grnr+uN9LYFYY6VZwR+qX
H537YioJ3gtYni2hKWhAo3QtiA2/JYghRPIG6DxRDZsopo+IQZYwgmoIA10LuONA
icsDZ2EJShGSz4cGzpwznLk0MkdW7i7XExIKMqBv4jXL8HS0nxnUpvdiVbEWcX+p
K0jaVWDoF2p9qfIKzJC7MHqhdd/R2phBqyLxMO9GuSXr4N+huxSTKhRjhf7Nf+lR
zyvdsxh3nXNsgfnhBnOGYA1lE2XblEyXxqQZOfmBPQR9wTceqoXVnXxcmN5DU24Z
i3KwOxyE9ZwoAvZbqyx+aQ5als2JORSHEm0Kr+SQHrVTtvGiSeBLqv71pcCDMlR0
e9XlkKUu5uZwTc4iWq1hC18120GZAOI1hVDk4mY8H0gL8hokwnPRXyREOy/Pbfhy
UVWS1vW/SNclBKj3OO73qAThL5enN/46C2iPqEnDl9hZ4cVyZCVb2NoMeB1Ra+On
aiOiwZeNpCX2LeARFWmZ83PnhcAD8Kl+bnas5RZWNuibcl4AtPDVM4wUEmLO2KHX
K3YdElpw
=5S1E
-----END PGP SIGNATURE-----

--=_MailMate_E7E50079-E5A9-4E7A-90BD-6EC1A1BFB8B6_=--

