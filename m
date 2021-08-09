Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BEA63E4916
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Aug 2021 17:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbhHIPp4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Aug 2021 11:45:56 -0400
Received: from mail-dm6nam08on2087.outbound.protection.outlook.com ([40.107.102.87]:31329
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230095AbhHIPp4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Aug 2021 11:45:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QVD5ive2tU2vTb8aF8NtDHDehjE9sL+BMuU6jjfcyARfpxRE0Zj9R74gk6mUhQehDlrCA77rkLh8iMmDTvs1rrtFJMlZOkyrH3etISy0O9aoIWSCnTl89vOcqxMgePDg9RRUYsCUIHF9enuomkNVKLLQ42csgo98nZSehLdjTD1AQrgx6st+2IOXyp/PLcKTxROY88NqdZTG2t8J5rSszpG5ppkB36WnQJe/TwsoH+1I/RzjknUbDti1jX1wj7y0kFVJhevH7QTCq0/V3u8d2A5sO87ekxV9Rvul75UFdQbonDx830wixnKUEC/WHACygsmWPqQeuZcP+ed+Wl/ACQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EbGnmFvFczp3T8t8W77BJAjawMOjrlGb0qXnKU2xSV8=;
 b=CdtUS8pzhKRIJqvrNQDwmu4gVfwt+YxN3p6OG0xom5HYMKqyxYTmmlKUbxI5afYqBdplnwtSYrHwkvTY1nNn8iossvMAjENlwXFdzdAQcxLyWLlqm3NbLAjaTeASfD++y0g+7q5PbZTf1k7D5j2gSarAaoq+9YZVekHUmm+425VFk7mv5tbzlt8b1rbV9T8KeM9pG1ze+NPm/bJC3C7itd4Ma3crrJULCv79NW1PazXeV//wHECLqzqtlwTxFIV84fMH2as0P/LisEbkf9Isa+e4RGyproc+BcHqz1Qi4nBi95cJLCnX0Gbar7azJ9+2csCHQc87nldbTpN6Upt92w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EbGnmFvFczp3T8t8W77BJAjawMOjrlGb0qXnKU2xSV8=;
 b=QOj/AuwLe2PBR5qWZq+I2r6eF6qivZyUWm8aVR/2esbSIVZabXMqepAKjceuHttb24fHXQYtiOkMYZhO5/Sd6wXGXifcM3paBBT8AqSnhcaKiFyviNelSjykelEB26Us/gAzH9eeRmoSnjVXxdadbDQgKbCC/fiPPvUORdoL5zARNOJhB/lG0A2gwtqBJsEbynxjB2q7AejD0X4JQhqJAC4///IFTdZMadElRXqzGSFs4UiqjREJQ/5jqVt9rX79+6m6qgYgnb+E+1TmxJZpthesmG1STIF+eyibM0qmfGUwJuNorS/IexJ+th7r5ipEyhgCVVNybXIwxg0PMnOglA==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by MN2PR12MB3983.namprd12.prod.outlook.com (2603:10b6:208:169::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Mon, 9 Aug
 2021 15:45:33 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::dcee:535c:30e:95f4]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::dcee:535c:30e:95f4%6]) with mapi id 15.20.4394.023; Mon, 9 Aug 2021
 15:45:33 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>,
        Ying Chen <chenying.kernel@bytedance.com>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 08/15] proc: use PAGES_PER_SECTION for page offline checking period.
Date:   Mon, 09 Aug 2021 11:45:27 -0400
X-Mailer: MailMate (1.14r5820)
Message-ID: <BB81E5C9-D796-4952-B4F7-E966FB74EE78@nvidia.com>
In-Reply-To: <YQ5hIFZX02BMS+Yb@kernel.org>
References: <20210805190253.2795604-1-zi.yan@sent.com>
 <20210805190253.2795604-9-zi.yan@sent.com> <YQ5hIFZX02BMS+Yb@kernel.org>
Content-Type: multipart/signed;
 boundary="=_MailMate_A1071AEF-FC11-40B9-B1D5-A34E13B9806A_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0068.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::13) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.2.60.152] (216.228.112.21) by BL1PR13CA0068.namprd13.prod.outlook.com (2603:10b6:208:2b8::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.4 via Frontend Transport; Mon, 9 Aug 2021 15:45:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fba73166-e65f-4bf0-3343-08d95b4cb915
X-MS-TrafficTypeDiagnostic: MN2PR12MB3983:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3983A3DCB51C8980F6DFFB73C2F69@MN2PR12MB3983.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lHcyyeLHa/68NBnduECaHesfy74kngsbS6JZscac+2PgWuez/cZbiEemGqPIGFhhYGlf010tYIuoQK4tW0enA3lmXTCbgrvFbQh2nNytoNY+ra2v2hjXSdpWKzCqtsI2RPaavpJ1IwPeejvyKj4cigGPnX5UB9N+EH1UjyU3a1/9zFoS2f7PPvSpwZjgA0Fpj0lQhelLFuGBvlfX791tOYXTFAtQUgOSUDQXmsrFgoUIjAPN8a48/+RWuAuPxE3jS5sGo+SI7ryvdBPhV7H4IitYtnCRMeq9FgXDQ8s9yGpb63iiCdo30hEA5Mdog1bsx+pizy/AFm8ZgqioHfyB5OnF5fBWei+FVCH7DWprYh49NwZ1fAZp66yzaqW+Ld7Ph/rsHmJvFhauPWmjAo+IWUldYwRP3ELaAeffJVPxSxSgWw4yZZPuiipfawV9e0O5A3pTAqjQbZ7R8Em3G9DnADbXFukDz2jIPDg3DiIRVYx5u34I9KuScPdIy8BFB5tHSwdcImR+b37hpTZ1GHJZ2tXoqnN+v+0ESErv4PGHkChf3gL+0CJH3K4INtZIo0e4ACYjcOX2ng2uW5fcVKO1F0H5XQMSc9mMDAo0bgJnaW27LFkRBh/R2zL7+gdZAWy7KkkvYfFTR6EiVh/jBr142pCz62FibHxWLM078ivJ3TXMRVnE++x5K+ttTvAtzYzSlZWD7RRGYFeQdh3pzqa0uU9OJPZihH5cKNlRowTcrlU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(136003)(396003)(366004)(376002)(2906002)(478600001)(16576012)(36756003)(5660300002)(83380400001)(54906003)(6666004)(38100700002)(956004)(86362001)(7416002)(316002)(2616005)(33964004)(33656002)(8676002)(66946007)(66476007)(26005)(235185007)(21480400003)(6486002)(4326008)(53546011)(6916009)(8936002)(66556008)(186003)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bCs2N0VmR2NKQmdubVZXZ2l0dUJFc0dvVGtZdjc0bmFBUTRSNlVwdU0xMGlo?=
 =?utf-8?B?cHNXOXNsQ3h3YWdsdldYelRPZU9VU3V5eW5rMFpvY2dYUUZJYWZGRkdJc1RJ?=
 =?utf-8?B?WFgxaENsT2tuMHNKc3lTNmlLNlFlUnJPMkhncllHVDhVbUlTV0gzL2NWUHc3?=
 =?utf-8?B?RzFFSHBBV1lzRmpMUk9HcmNsK1RyY2VlYU5lckhzS1NteTNsWjI1dUhITCsz?=
 =?utf-8?B?WkdjZkZKaGhlTnlkQktkVUZYSE1HTncwU0hpZkVFQzZBRUVlY1k0Z1VZOXpo?=
 =?utf-8?B?a0M2bjIzTjJ5Z2NTK1FOeFo0R2tVdjlZS2kvVFVUZDJxVmV4WGw1VWhhOW1Y?=
 =?utf-8?B?eitTNm5jK1VtSXNmQkxreXBXdlhiMG1NTzFDV1d0Y0xhbkVzVFpoYWpudE9Q?=
 =?utf-8?B?dk5sTFFoQWxXV2QwK1lOYmpXR3BKZGVCSnVnWTB0STBnK3c4b3NpelRScUFR?=
 =?utf-8?B?eDVKbEpTOHZVZCtqR2RYL2xRcFprTElNc283NjdGUlJEcGFFaWhVdEdNbU9t?=
 =?utf-8?B?RzZXU210REZuYkdVaW9xaUhVMzFiNXB6TlV5aHFjbytrVitlM2NMa0RVTEtL?=
 =?utf-8?B?S1VBNStMMkl4RW5TMStCR3cxYy9LZWZwZUJyNTY2RFBJWldXeWp2MHZ1Q3NI?=
 =?utf-8?B?aGExVk9pUEQ0Zm56SFlGNzYzMElDUG93OGhyQ2pDN0FKbUlST1dKQXFEVEJQ?=
 =?utf-8?B?RGJ3MldhdSs0NXZnc3VaK2dzTUNNVU80TnA1UGtMMkdPaVdXOFU5VkdqRjNB?=
 =?utf-8?B?UE1sSmJYb0FLQ2JweE1EeUN3ZlU3UWRIa0hQdmwvUVB2T1hRMm9sYkQ4cVB1?=
 =?utf-8?B?MUxybmZwNkx5THdsU1d3NUZWa3d4M24zakxGREtvZUZub0NwUjBBSm1nSXpx?=
 =?utf-8?B?RGFVYk90dXlNRFBiK3Q1dy80M2l4RGFLUUtjTTdyazkreStLK2RHVDgxb080?=
 =?utf-8?B?L0dHOEo4NUVmYlY2WUc4ZmxyY05HakZodGJOY1JFQVdSSFNBcFhESXlnMTc4?=
 =?utf-8?B?SzhObzBEK0NBTUt2TzNDVHMza0FHYXowOTBHc2NDU2NKME82RmJjYm1Vb1ha?=
 =?utf-8?B?c3llenJEZlF2RmNCbGNQVkJYZThiYkJIcVR6S2pOUk9XMnhhSmxSWjlERG9x?=
 =?utf-8?B?V1VFek4rOHZQZFduWW5jdzhKMXA1VkJ5K2pUQmNVRkJDeVBWMkFvU1M5REEx?=
 =?utf-8?B?MTdJTld2eGFrODZqV2VHTXQyQi81eURxTUVXM0cwU3daaEFHLzFnWEh4dHFK?=
 =?utf-8?B?Z2c1NE14YTRXV0VUWk1RMklpTm5YSlBHS05QZHVOZEY2VGJHMDhxNHFXeUgr?=
 =?utf-8?B?VkQ3am5Yb0E4Q1d0RmRvZEhCS0xINTFHRWptb1l3NVptblFEck1zY05Wajcx?=
 =?utf-8?B?cyttekFNa3EyeFdDYjd6NU5pWFA1Rk5hVmtNVDNxc2puRGM4MHh2Tk5sNFJT?=
 =?utf-8?B?OGI3OWlyN2ozN1JWTi9PT2JMUVJRdmRQeUFzczdRL3p4SzhnRUZnek5qV1Ew?=
 =?utf-8?B?Y2lRVUx2d0hyYmd2VFRFekFseXQrQi9GVXU4azF2aU5jT3hBeVlvZDV3MzFa?=
 =?utf-8?B?bzhwWmpEWUNLd1VybVoxb1NKSnFJZnZCd0pRYmlxTlJ2bUZhcGpmd2tBc0Jv?=
 =?utf-8?B?OEV5QlNRNG9MdnF3UzBIbHhhTUtVZ0pHcGpzcERORjN5S0dva0k3Yk1UUHRH?=
 =?utf-8?B?V2d2TmYwajI0dzFmSTVKK29Kbkd3amswL0RVOGJMUzFnV2xDelNOZmhUMktp?=
 =?utf-8?Q?4rL+kCPgFaf4MyaA694Gaf7cP87SRRL9ORcU3d8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fba73166-e65f-4bf0-3343-08d95b4cb915
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2021 15:45:33.2561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wpe4NJ09tqi5Rxhx8RnJ1pY+NYBFIw2+B1X08JlQzRn/jKqSSfKqJq6hY+Xl1F5W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3983
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--=_MailMate_A1071AEF-FC11-40B9-B1D5-A34E13B9806A_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 7 Aug 2021, at 6:32, Mike Rapoport wrote:

> On Thu, Aug 05, 2021 at 03:02:46PM -0400, Zi Yan wrote:
>> From: Zi Yan <ziy@nvidia.com>
>>
>> It keeps the existing behavior after MAX_ORDER is increased beyond
>> a section size.
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> Cc: Mike Rapoport <rppt@kernel.org>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Oscar Salvador <osalvador@suse.de>
>> Cc: Ying Chen <chenying.kernel@bytedance.com>
>> Cc: Feng Zhou <zhoufeng.zf@bytedance.com>
>> Cc: linux-fsdevel@vger.kernel.org
>> Cc: linux-mm@kvack.org
>> Cc: linux-kernel@vger.kernel.org
>> ---
>>  fs/proc/kcore.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
>> index 3f148759a5fd..77b7ba48fb44 100644
>> --- a/fs/proc/kcore.c
>> +++ b/fs/proc/kcore.c
>> @@ -486,7 +486,7 @@ read_kcore(struct file *file, char __user *buffer,=
 size_t buflen, loff_t *fpos)
>>  			}
>>  		}
>>
>> -		if (page_offline_frozen++ % MAX_ORDER_NR_PAGES =3D=3D 0) {
>> +		if (page_offline_frozen++ % PAGES_PER_SECTION =3D=3D 0) {
>
> The behavior changes here. E.g. with default configuration on x86 inste=
ad
> of cond_resched() every 2M we get cond_resched() every 128M.
>
> I'm not saying it's wrong but at least it deserves an explanation why.

Sure. I will also think about whether I should use PAGES_PER_SECTION or p=
ageblock_nr_pages
to replace MAX_ORDER in this and other patches. pageblock_nr_pages will b=
e unchanged,
so at least in x86_64, using pageblock_nr_pages would not change code beh=
aviors.

=E2=80=94
Best Regards,
Yan, Zi

--=_MailMate_A1071AEF-FC11-40B9-B1D5-A34E13B9806A_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmERTZcPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqK34UP/2Vdi/I68b30BgMz92FCkPVfisz7T0iMPSWB
SW9O+Z5Gsc3ISVpnFh1uLirf9ix0pq2RdbnC3r2qIxPbenwdv6bEitnXyj48Syfj
slQ1FupRoZrJfpamH6JSpHqZGVBP04YeWIxG1n5LUSPMbIWDLEgWdXUNt/xXgKRV
KevgNY/vYQ8qXLjIrBe0ALeoyzMTm5BOYzin8HYd/OmYhwwZSbe5Z35S2eQRrA2J
nEBIHy3KEMGXtd1EB2SoFng6vn/wFApx98DYoRkn3YSt0tDTknTlsZMqdhQE7dZq
Rd8hGXVxWNxJpoaTSNoayVlJw/5aIoVf7guI0bPKLltX+h4SltPdsqWKWBu9hQWd
QD/Gy8xOHXvEqL6O9w2RYrTPOjiX74lXwNvcfxJVYapYdsQQIwEdd9htg9aHCTfZ
gu1+FRRhgO7CVcFuHsl+NvnhaP7ZVIv+qHK06PoDObWuwLUzP8AKiurExLYtlGV8
gHWLE4uWQcjONJLF5fkS8PFcVudqK5i7woIdF40qcFB/quYc2+RC/CePTQQW03i+
RbJN7cdM1Uvch5Uxs41etS6Tq+Y+s/osSQ1Lkr7D3xNcWzQLrRxk6DjUhnNuX13u
xZmKh80bljwFYVmA5tc0Q0BOJENw32wNIIhM1zsQsNr8Ia4X89/dhO2cksI3plUa
FwxxFMfo
=Knk8
-----END PGP SIGNATURE-----

--=_MailMate_A1071AEF-FC11-40B9-B1D5-A34E13B9806A_=--
