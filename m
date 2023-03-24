Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF4E6C8117
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 16:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbjCXPXC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Mar 2023 11:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbjCXPXB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Mar 2023 11:23:01 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2085.outbound.protection.outlook.com [40.107.101.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E29530E4;
        Fri, 24 Mar 2023 08:22:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KUhyVI5Hr0tmL74kFJplMFYTMK9CtLNaU2eLjVsEBoloKnz9ehuMdrHRM8/wN1E947sTtJzVJXATL1nylI7YVcYyiTUk7kxsfnBKpA8krCzpryHLShb8AKvlmleK0Qex0MdTNcD9a/Jf5PtWmrrByugWoigVIsDJlG7R5EcA57bgIDt8iQffruC6g3/xYdvzBm3abJ4ZSEqnzD9OC67zrbwvAEIpd2fGS07B/QjxJQL91lbayQdhmluxroSRimHgI8szrWz7ZlI18hOaToAYTpBzV14hRCCVw4civLOGitxcOnVDoOwEkg5JeZuLeDHZ/3jKOmV6tX7Y6dAKliMhhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fX8aoEReh56mVPCfMTd25zu48cTdsYFik2GorUxwwks=;
 b=Ml+PxYS88N956NoWRBG2FuBNIFhfc7IDGth59PhRgLuPP3VIZY/CgV+ug964r2wbX3LPesFdeqwmNgHZc294taZZrM7YCPdsqVrr6UJ/3HuLXg8XB0S51K1brbVZr9C7ksd3XVqbrKM1x5zFlblPNFwMv4pPbJuxeIZ/IjxaN/9XFesw4SbvvGtxEBohGA1PNisnsXrHJT0hYgYDpD03cu2KCKoPU/S0glZTterqfn4vSdcxvb9UHl2Gx6p5qQHK1Qm+zDXE/CSV3WVRz4SNoxwWCVmZxslC4QOfaK0hUAuZwbpUcgO1BYM0Hzh3LQA5ARvUDT7M/tomtMurbSngZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fX8aoEReh56mVPCfMTd25zu48cTdsYFik2GorUxwwks=;
 b=q5SqxuIm9uHt2nAQuW+INhwurEWuZYliwa7QJOdEAGmwmvUmwb5Kv8s+TA5T28cVi8Laz3g5d9YsJsbfI4gEjDnDOkxjwcg/4J6ulrrabcOZbSgiSS/6w0N4TG/vCx/fHGphb/VFMQHwX707YnNORNmemBInB8CoBSybbQ3b6rt8p7A9V3OdewV2V20qZVIH/inl83/bT12e7IcxBtqGXNEx3h5VnOWslnuj5LVC9IMQpRXkC0LksGxVc7w5D2H9B6hscMNXMrrn1m6sHrQNHfIueIRWbcAj09dlFtfshHTsbdjdaR1PNaCyNIv3SyrUapeBV44mKw71nkSCgXm26A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 IA1PR12MB8408.namprd12.prod.outlook.com (2603:10b6:208:3db::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 15:22:55 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::bb0b:f14a:c49a:9cd7]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::bb0b:f14a:c49a:9cd7%4]) with mapi id 15.20.6178.037; Fri, 24 Mar 2023
 15:22:55 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>, Yu Zhao <yuzhao@google.com>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/5] mm: page_owner: add support for splitting to any
 order in split page_owner.
Date:   Fri, 24 Mar 2023 11:22:52 -0400
X-Mailer: MailMate (1.14r5937)
Message-ID: <59100CE6-1A77-4620-81AC-535A6A68A98F@nvidia.com>
In-Reply-To: <20230324151717.hawuy5gs6cnxql55@blackpad>
References: <20230321004829.2012847-1-zi.yan@sent.com>
 <20230321004829.2012847-3-zi.yan@sent.com>
 <20230324151717.hawuy5gs6cnxql55@blackpad>
Content-Type: multipart/signed;
 boundary="=_MailMate_291A2FA6-08B8-4B22-B21B-51B4FB6037B5_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL0PR02CA0092.namprd02.prod.outlook.com
 (2603:10b6:208:51::33) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|IA1PR12MB8408:EE_
X-MS-Office365-Filtering-Correlation-Id: 729affd0-e296-40c0-76a6-08db2c7ba44e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rurNPqjFU01lrvfOJGfSL2quKG4k823W/jVF8ttmOAId93Du5yl7dEj5QMcke8O4WdAckPBGaS0hLgCQO9X98+pvaDOfjxaeWOx+zyy7BWLOIeE4NRaqiRBin8TU5e3CpoAc2EA1+rRbOTajSRb8KjfK+hTr+N+mPeAFHsJkbTkxxbtggV5BgTSr0lcpK6bFQkf1wEAtZ0UvV6o4P21p0kEZrnJ7B8mWNzYAflQS87yx49BAA5yUSE+l+GzFJGCQfFzNSGXl0PEraHJ5a0Svt7HbkyAuhA19EyoTjnfhLiRMYp8iFUrGrK9hkHoI739nlPQgNSp7IHqr9Q9d8qXEftUE8d8Vs16HXGnK63b/ZUybrG9x+DA0d5wAi0xXjS/BjPG2/t7yAvtMODiC/PAQVBt/iwbWOP5yZwqeEp7V+ZnifJK/wiWGRbw/OT1cBX18OkKiAmOWEJj2vaPfMRW12fOU0rtS9Olxm4Ke7RdvWvUKSMpPuBnra9er3nVPp+Mra8IwGhnEq8WWqIga/FVfWvvKyQ2ujKzPtC6dA0r5RslNzKX7q+bOim6Zi815h+aQuSjfPuCg651piES3cfJZKHdsX5VHpPv1r6L6aDX1KqxXea5Lf6338+TLqzKIN9v7F87gopcnzL6VwxPFk2dvjalGkP1yyLv5Km1eYAnVWMT6mFoj+AncJ/3vPhLio043jdF6YTkcM/Gsn7jMT6581H5XUfAWXQrSKeRd1TLywYY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(396003)(376002)(136003)(366004)(451199018)(4326008)(66556008)(8936002)(66476007)(41300700001)(66946007)(8676002)(6916009)(86362001)(36756003)(33656002)(316002)(33964004)(53546011)(6506007)(26005)(6512007)(2616005)(6666004)(186003)(83380400001)(6486002)(478600001)(54906003)(38100700002)(235185007)(2906002)(5660300002)(7416002)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHVFcjgvZlNrMGlVdW5lTTVWOHdkMWNqcndHWWEzRThzMHROODkwOW9MSVdO?=
 =?utf-8?B?akhQd3JmelkwUVd4Mm9XOEFob2VLMlRtbTBlM0hIRlpZUlB1U29EdzVWVmYy?=
 =?utf-8?B?MnBPMzlGNThrUGZtTXhEK0xDd1orUGpjaHgxYVR1MlQ0VFpOT3g4MmNEQllQ?=
 =?utf-8?B?N3RnRUVQU24rQzhlQ0M3K25KZllBcnRydEx3d1Fad3d3bVA5WTU4NUJRUjlw?=
 =?utf-8?B?WmZmRDMzdEJjd2VUb3NCYkZYUWlPd3A5SVV2SEpoL2xReTBQNE5HYUJhYStL?=
 =?utf-8?B?RTZWcU82OFNXaS9ML1hobFFNTVJOTTJLVEo0ekhFd2Qyd21lbFdkQzdSS01Q?=
 =?utf-8?B?WHJCZ0FqcXRLRnZ3ZlFuNDh5MklXQ0pSK3FXTWphci9lS0Z0YUQrdVZqRGdZ?=
 =?utf-8?B?SStsaHNzbktsUS8xeGUyNnZLeW1zM0hYMzJBRjRBZ0QrMW45UmV2SUI1dStB?=
 =?utf-8?B?TUJuTWhzUWY4N1dMZ29XOUNQUWgrbS9Sc081QmVyb0FIR21kcFpXNUI4Tklo?=
 =?utf-8?B?L2JSSUdZclkxK2VVSjVzOGpSZFY2eVlmNXJOTmRvODhoWlBIRUY4NE9kL3pv?=
 =?utf-8?B?c1VoNC8zTVFUSzFOTS9TOU1XZ0JtNTY4T0xkQXdYYnVXR3crMlpJOFFxNHJh?=
 =?utf-8?B?Qkd1cVJBeFRDQnpiN1d1Rno1cWIrVVIwc0lKMkQ0VWl4U3ZTZ010V0dsQ3Vt?=
 =?utf-8?B?NldBeVdVdU9WTDk4dTMwdVg3UG1kYTRqc2lPcVhVRHpXTVMwbEdDcVdYa0Y5?=
 =?utf-8?B?MUExaHhveDhYZjRCUWo0S1l5a0ZvWk0vUzJTZzlxeC95aHFYY1MxeEFQSWtn?=
 =?utf-8?B?SnA3dXVneEptMnZqbGo3Y1pENkZHRmNQL0Zic2JXQXdkSVFwK0F1alFrc1lE?=
 =?utf-8?B?RTdCL0FzWjcyWWtnSHEyRStjM0tzQmcyQ3dFT2ZEZFBaMFY4c204Z0pCbXQv?=
 =?utf-8?B?ZGhoTGpWaERuYlgzM0NwNTZuWmZUcFVtMFAzLzliODZuY2JnMnR2RHlOL0dv?=
 =?utf-8?B?Smd1amlMbnFtVitFS0NRQ3FsbkYrcFM0SEtRYnduay9UKzVvd0hxZUdZUUR2?=
 =?utf-8?B?QVRjbnphL3ZlQzVKMyt2UURBUGpHTWNYUFRlOHJ3bVV6S283eWt1ckxKZmo4?=
 =?utf-8?B?Uk5aKzFWb2oyT0syOTBpY2p1Wi80VCtuZmxJanpBNUd2T0FRQmNaUS81L0E4?=
 =?utf-8?B?djB2Y1FaWXJVZjdPK3JGYVJnQ1U1eCttNy8xV2U0Zy9yYVFqbEo1WEdycDhu?=
 =?utf-8?B?cFhtZ2pHQXh1ajBDNE5LbFFqQWVRRThBMGg3cTQ5akk0MzY3cU9FMGlDUEFz?=
 =?utf-8?B?SU9PTU9wbmFqTHRmVDlBdzR1bUFqY3EvbGVMQjdTQS9HMHVFbEVSVWd1ektz?=
 =?utf-8?B?TjRsTnF4dG1wLzV2UDFobHdYUHZ3dGNrbjV5MFhhRXBRNWxhS2ZJN241R3Zm?=
 =?utf-8?B?YjQ4aFJHR2F4NmNDVEVvcnRzVDNTbG1wT1RwLzhjVkhoQVk1elU3dC9ESTB5?=
 =?utf-8?B?cXpoNE52OS9OeEJCaERRN1VxQ2UyYTduU1QxVzNmYjlYdU5JYVUyY1dFRngz?=
 =?utf-8?B?aUdFNzFCU0NnQ1Q5akJJVUMzdzNRODduMGRqUmJXNVJMWW9sNkorbVc3NlRl?=
 =?utf-8?B?dytRcFNxWUk4dldKNkRQaXFyR2gzQ1JlYnJOc2hXWHgrMThzbXFkT1ZETFFQ?=
 =?utf-8?B?TlNlZk95Y0NFak5tWjl3dEx6b1RnT081UVZabThDMEZEN2lBVEVHQ1FGMTlE?=
 =?utf-8?B?N1o3L1VNRC9PTUFtalBhNkptRy9VbkdyZnBVbjRyWHV0UllKVUlnb0FtOUI4?=
 =?utf-8?B?bGt2bXludGRmSFZGcWNXZmVnenJTK05oaGk0U1lKRExZK2VZNjNIdkVwczBU?=
 =?utf-8?B?ekdDTTVidHdId2hUeHRLWHNlcWs3V1B0d1ovZnkwSEtmRmxSWmtqOEd3ZXUr?=
 =?utf-8?B?WWNMRnNRSEZMK3pXTE85LzVTZzVMV1JaL2tiOHJWN2lxQmxtRy90YzN2RUpu?=
 =?utf-8?B?MjFhZTMzelR0U1ljUjE2d05laVBrdFZQMDRNZ0ppTmsvYk92U1d6d29EalFk?=
 =?utf-8?B?Y3Q3djhSN00yVWdYNFpJMTgrWFgzL3Jma3o0ZkZ1dHh4dzdnSTYwQXJqbTdW?=
 =?utf-8?Q?j3MbZmM2vTxD5eV30hwYrNgF0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 729affd0-e296-40c0-76a6-08db2c7ba44e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 15:22:55.3824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XC0OoipHPn8wnFrKCA4mK1pqCPsw9r3PECofm+Q+1qgGfPzrnHo9jnnxWvIrixKz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8408
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--=_MailMate_291A2FA6-08B8-4B22-B21B-51B4FB6037B5_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 24 Mar 2023, at 11:17, Michal Koutn=C3=BD wrote:

> Hello.
>
> On Mon, Mar 20, 2023 at 08:48:26PM -0400, Zi Yan <zi.yan@sent.com> wrot=
e:
>> @@ -5746,8 +5746,8 @@ static void *make_alloc_exact(unsigned long addr=
, unsigned int order,
>>  		struct page *page =3D virt_to_page((void *)addr);
>>  		struct page *last =3D page + nr;
>>
>> -		split_page_owner(page, 1 << order);
>> -		split_page_memcg(page, 1 << order);
>> +		split_page_owner(page, 1 << order, 1);
>> +		split_page_memcg(page, 1 << order, 1);
>
> I think here should be
>
>> +		split_page_owner(page, order, 0);
>> +		split_page_memcg(page, 1 << order, 1);
>
> because I was wondering why split_page_memcg() doesn't use orders too?
> (E.g. it wouldn't work well if nr % new_new !=3D 0).

Thanks. Good point. I will make both use orders instead in next version.


--
Best Regards,
Yan, Zi

--=_MailMate_291A2FA6-08B8-4B22-B21B-51B4FB6037B5_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmQdwE0PHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUFBAP/iQy5jdypuF3netacIiwbM4k47H0M1hBEdnJ
WA5WsdVOmPQlOx+vd+tk4gbQwSv4BxyBVyJK8QZqtt9v8fH0XpjfaL5mC3Ctsn1A
9SP/60Yc3HXSM78da8vjNh1W2mqEr0d38sSGDbD23ZJ1f/pu0OnVafPT9YbRCnC+
Kv+6tABCWFGbuCMuGY/e7ohB8j6tNqSO5OnT8ANJl0mFYLg+Yvn8DZAI+dm1DkyP
4179scBvYI4o/8EFqA6dUNtszbPf1nGJm9avt/0wEhDSxmOAti/uJ07vH2Kujb0C
PYrS0ahTSulhs7gquYVxI78ydmOExBlMV/AoJgDBmFcGzCzp/cSZyVHjq/4tkrqa
qKAfN0BsR52uvSYp576kJR24qq2GTqA3Q+bskX5Jz7Qbf5EKstSbT+UqXlm9PXpV
nWD5AfOPDR2O3lZHz8XDWFvlHwcxFjnRPi75cqfOamhldwqH7mq41qWJyirH5d6W
u/L8GZ2XB3eUcsmmwthWJZHvPeNMTxTin4bdkFeMrL+jMv+wA/YtpDNKkcP+w704
18AF9XTjRBBcEWJr+nH2MThTwkChXj2dWjyDoBJihvFXUZ5W2hdsfOTT9uGwp5Xj
uXtPtpZe6H8tU15yCgbFv1f0AVZRH3TZuvuzL/ErcIxViLGysTZRl3Tf3Gq73Txk
ViRIlt8f
=pKKC
-----END PGP SIGNATURE-----

--=_MailMate_291A2FA6-08B8-4B22-B21B-51B4FB6037B5_=--
