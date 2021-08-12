Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5C43E9C2C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 04:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233456AbhHLCSL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Aug 2021 22:18:11 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:23352 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229729AbhHLCSK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Aug 2021 22:18:10 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17C2B7YN031562;
        Thu, 12 Aug 2021 02:17:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=MjZyemJTt9EE2Aqs4CopyfVADNKpH/pMRK3W8xT6G1Q=;
 b=kbWrsL+XGHsNDf0JIIFyqdEeI+7fFaKJcFCPmKnVPcGgrCihc5IEQZweyzCrdOnu/ilZ
 9u28od5qz+4yvklIxGK2Mr0AFNsWNQCJA27m9pvteAnw9UwhuDItF86CdNa1X5glwDX1
 95+AcnkETjuQvc4pM47Y0bwiMDPK/bJ+aqqUQBuIdayQiHXPEbv8M/OmWrPKDDw9uw9z
 cobh0oF2s/9GVpRYdBCfAJVGDWwD7WcpeX03jUlcQ4Nehz305e3Ci3kK8oicqiSzo6Ls
 8+eG3+2lqdkHDDZVPe9gr3pSG8StkS5mqalBTNG/qXfzvYLa8zPASrjVtWufrGSQPyE3 iQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=MjZyemJTt9EE2Aqs4CopyfVADNKpH/pMRK3W8xT6G1Q=;
 b=Ymz9gVESLlCYSkR01f9AlzAFb/Y77rl9ML//RNANh4yHcNgr1mTNnWcPH6noQz+HmVb5
 eUKua47KaJsCtx7psF1mSsiMxDdsyp696xhqo7xa0XpSglUMhKyN80bLyrbdQLFTqLgU
 xEtxL5RQpM7fQmYUegfG8ht/vLMsaNDmgMr7QZqsp4lgV0nmlHGHnAvVTs6sO0+7O4p/
 qgZe/ChuDxJOOAi77OYMvQ6jBhF3uJQxtva8KgnHVv7VfklUGrjD5xdY0y3kBOqW6adv
 f3I+pw3BCNGmlSzEQEev+0W48dwh9yVoUlIhKlsbcJkVJtcdAjkEItDOa7cMV5oUwpGX jA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3acd649ux9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Aug 2021 02:17:32 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17C2GTua117945;
        Thu, 12 Aug 2021 02:17:31 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by aserp3020.oracle.com with ESMTP id 3accrb4kwe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Aug 2021 02:17:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AJDYTJht2JlwuUHCrh3pBAmh6EzB3ubk8W0RSW/FptR80rNTXzQvJpWWE3I67/5dPFSqWbgGO2Z2hRoeYbpz6U7SFeaeC0mW+Iis03JQ/O/VgqyAV9rK6jRcZQ7WJ266fXllgdFeRhWCH6uYSmEh7vGpGM0Tz2Nsn7xvNKxVIjwteF5e2FpNwTgsrJB4ItGKuzyMGBUKdHNe+m+IM9Pm9/srzFOQMKBgyskzrAR7TqgP524ir7Dww2dK6pvYLncFqaRY+cI269/hKxgLLRT6kYNLc4u5kg36dB1rzNq2lr1E4aB2n/WLjG7MM5tFmB7f3En1Cbcq7Dy6qDej/b62Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MjZyemJTt9EE2Aqs4CopyfVADNKpH/pMRK3W8xT6G1Q=;
 b=Xqp2GjjwJ0T3Fb8sF1T0xxh8iKcEwJ1QIyqU1Au4V7sG8b6i5J0vTZOZr3Y/AIEripcFpqyU7DGW6voGt2IqXBPS4kj1N4WCjmnXLDc5H6VBD9JiM3SbZDP/wqSVS1FT0oPqN0A06SVXlBSj+o0nxQ8ATVU29Mger1J6Y57Ro5KbfC7Q+JyF0GMtjHXEUfumnItmTi48Vm9l7OdetkGUbd9dqiOdvZfF5mg35g/KJpJ9y5a7fy+HszG6UCVjxLadK2X5MXdGaBKk/yRIetIyE6QgCNrNKrO/NZsWXj2k/md0zH6dQ7+3kTv98GY6d1eYDXoX1pEEQQzbDTEvlQkbWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MjZyemJTt9EE2Aqs4CopyfVADNKpH/pMRK3W8xT6G1Q=;
 b=kDzxdohEeHzRHbp+5IgHIXQ0mWPnOPJ4tNwBdiJwBcNOXRTVw2kpSx3qSvkPrq4VJ2w0zuTPNCWJpqDZkq4IgY0lcasFONMAjjwGxbjSfxJyaQgSYTnc5zMKIRtgk3Ekhb0pdBDAUVhPkUWuDJ/FgBwa5J6UyMkWZuqFE3SxVNw=
Received: from CY4PR1001MB2357.namprd10.prod.outlook.com
 (2603:10b6:910:42::14) by CY4PR1001MB2053.namprd10.prod.outlook.com
 (2603:10b6:910:3f::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.21; Thu, 12 Aug
 2021 02:17:29 +0000
Received: from CY4PR1001MB2357.namprd10.prod.outlook.com
 ([fe80::e4de:77e7:9d08:9f5f]) by CY4PR1001MB2357.namprd10.prod.outlook.com
 ([fe80::e4de:77e7:9d08:9f5f%6]) with mapi id 15.20.4394.023; Thu, 12 Aug 2021
 02:17:29 +0000
From:   William Kucharski <william.kucharski@oracle.com>
To:     John Hubbard <jhubbard@nvidia.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 3/3] mm/gup: Remove try_get_page(), call
 try_get_compound_head() directly
Thread-Topic: [PATCH v2 3/3] mm/gup: Remove try_get_page(), call
 try_get_compound_head() directly
Thread-Index: AQHXjvBdcLHj6CuNF0ypEXBwDT9dtqtu3JwAgABF6AA=
Date:   Thu, 12 Aug 2021 02:17:28 +0000
Message-ID: <1BBAB7A1-6334-4462-8E2C-A878B3E902A1@oracle.com>
References: <20210811070542.3403116-1-jhubbard@nvidia.com>
 <20210811070542.3403116-4-jhubbard@nvidia.com>
 <20FB1F52-61FB-47DB-8777-E7C880FD875E@oracle.com>
 <0253d7e6-8377-a197-f131-e73249d8dbe8@nvidia.com>
In-Reply-To: <0253d7e6-8377-a197-f131-e73249d8dbe8@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3691.0.3)
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4de715c9-bbae-4f3e-cce0-08d95d3755a7
x-ms-traffictypediagnostic: CY4PR1001MB2053:
x-microsoft-antispam-prvs: <CY4PR1001MB20532AA1B06C86DCE4D4E1A281F99@CY4PR1001MB2053.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ru+0Ls4mqF/2HJwf5a+fEsfyvny7v9FzZd8WQEO6FWCllT77Ipp8PUKmvyJoEvMBtekiFdpGyupiAzuO+yjWIcVNiQxoxGEQ0pFNBYkYHpU0O7rpBUtPPYJ2X+Q+diPSpgcnE+RzcSzqJ3T0EFZJb6frQKZVWATXHk6DPgzrR4WLgo9t/YlDGHOte/P5YNLpaqjizRc1AMoR1GLQ+jmCbob1F5Nl2Ep+zLdCeBJ4xyQhZh41zJnt6na52DgQPuqT1Py56HYFkOWXdPq1G9FaLu94rOeg4Tp6xl2qbVdwABFyGCoZ3TTw8EPtrX5D3svFDQ+MRDLCXfoKwl6Le8fjUX/I77QCslZ8T9aQ+/3HLYX7w0kPAoMvxoybrQ1Rzao6AH4+QHZIsEXq+sCiS9iR0SDUM6mAnIZNmfLOGVIoDis5dlS0VrZDouX5qjhaFdaOKq51rO0FlD+QzuA9+TU3nPShp01qBD1ygzvOViBd6Je1TiMxkgPLIM/BH9cpVpv4vYThc7eLQijLYHLHXnU98NlF+1zi5FnaJY2ioMRweci0PFiXaHH7D2r4bL1MY616ezeM/Tmqq7y8OxMzDvt0RRRwVqoOvj5oxYLWPBnSxQAqx33KLAxgboNQc8d7FXjqIPNWBMKCj3XemAe1p7OiAtDNZmKfgkG34jwWTDTd/OsNM7h3v6YXnsa6Y3aw3k2ie6zWYS+wY1pdRaeU38APGPTokRu2D+cclH4+VKULw94=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2357.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(376002)(396003)(136003)(346002)(186003)(5660300002)(122000001)(316002)(6486002)(4744005)(86362001)(36756003)(478600001)(44832011)(33656002)(54906003)(53546011)(66556008)(66476007)(71200400001)(4326008)(8676002)(6512007)(38100700002)(76116006)(66446008)(64756008)(2616005)(2906002)(66946007)(6506007)(7416002)(6916009)(38070700005)(8936002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zfjHjQd3x5AuQqT66EPXDo6mpfSvMOe37l+0wbr5sq61oOhcg69N50Y7V38R?=
 =?us-ascii?Q?KR5TE3Bc35VN6EkoUDan8MsN0y6ip+/cwExrLwyaXH8uwfhYs6Lhbw4rGTg/?=
 =?us-ascii?Q?EhC5Uq613XkSMEYJtq3R/msIQ8UxxXqR5yo97T+U2Vb4v8ATLeFTU+bPvtzc?=
 =?us-ascii?Q?BQ+26sMQTSnS6eEhmewbgpNsGerOCSseSMZIwgo1ASli1KKfK/CCwE1GkooQ?=
 =?us-ascii?Q?U/XuyCHstCEploEJwegMUwWvIHZL4r9mXyaf6KBAXPRWgWvRDdk3snoJoMXB?=
 =?us-ascii?Q?W23xMErDB5wEyz8VdSG7zA4VvhoFER8Z/L1YBUZJXUGwXllBcc0cCOeNGoUC?=
 =?us-ascii?Q?NPOUzWZDenzn/nIrb+XeZN3+wWRibjv88ven0QUkQ23rhR0DUmBtz2BBMcqb?=
 =?us-ascii?Q?Xn+eVqC+4hq+80/hPOJQe2SQcLPlA5adgi0pWLI++tmtm9mR7cGMSCbmhh3Z?=
 =?us-ascii?Q?OS6q3uvmj7VPiJ47RjljZY9KTMAmYw6jkfgTCkIFX4fqujnTfnzTsCn36lHG?=
 =?us-ascii?Q?PluDSJQoau1D/x/vDrovr4VWZepv810mALjTPOjk0yM2Wz/tbNmzsG/YvTeH?=
 =?us-ascii?Q?C9kTwNxFOpyJXDcpQlajbL4pa0Zft7COIe6ltBpdj25sKmCmQDuvSFnpeF5D?=
 =?us-ascii?Q?W/p/Y+MTt+8bsQlSqVDZaLm8c/ZlmgeHCEAg3f42PDVnyg6G6VqHJyUGFq/W?=
 =?us-ascii?Q?K8R0RQjn+ldz8faDPoeVjEiIV0kv+xVilWbqvJZXA6TO84ZWdq4kAM/ko7Wp?=
 =?us-ascii?Q?XGSSX3SDE1gbF+W4FCbQoFxkFEHriPteWEbV1l1WoK+VrtvNaV47hkKmxew/?=
 =?us-ascii?Q?4OMgJwfqhAyQ7Nu5GZMIoJlty2ybaFaWgP9U0QR+fWbM24dQFvM8REFQGbuo?=
 =?us-ascii?Q?uZZWioGh4N1cnwcc1urVuteM7Wtgfd2Irv6uXwrOp9JloscGmONG9uXSikri?=
 =?us-ascii?Q?sYwAtQUf88Lsq+JptpD35JjianMi8VdVOlfubiS107aGqoX28fPNCT84/eiT?=
 =?us-ascii?Q?SZahumjMllOCySSkfHNZOIWNbnsrA24GmyP3WTZIsHIF8uqGnXNizvEi3PIk?=
 =?us-ascii?Q?wl/RWDC0jY2fvfo8McGHANhWbItqkiDQOrtF58so/qe18pNSbCrajEY5ScRg?=
 =?us-ascii?Q?HCn88X1CPp8lj2ti0VS2kx8znkXoCqOPdmhAksuW4l6qSkW2bCO9kpmcrm94?=
 =?us-ascii?Q?No1x/k2990cn+cmdRwmaDv0paT7trFlfwcOWVwEc55uHWayR7SEgeHsvy2rd?=
 =?us-ascii?Q?anxZkYvdR+cS/4kRvMRuy9b//D3+OrQ4p2HgAnI60938PzOC2wwrLRJFPaqC?=
 =?us-ascii?Q?YUQMi+c25RBqzdt/d3hZgcTfMSHXgdldpWhKTM6tvoXOF/54c1McvnHVRZxb?=
 =?us-ascii?Q?meQUlswjyrn4JHqmrSVI6IfKXK+w?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6FFA5E276807E341862A1A32AFA339E0@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2357.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4de715c9-bbae-4f3e-cce0-08d95d3755a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2021 02:17:28.9771
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TcjhUuIdcOxAv4otQ/fWGSi3OuMHvzH1gYUPgeBhnWh91wfRDPsiWlKy8JLAfw8U30vgGxNs3xSKq/erVuxUCghSd+L/vamenb9k67ll1gU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2053
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10073 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=919
 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108120013
X-Proofpoint-GUID: Buq3OJzll9nODs8oFoS690urc94q_SFv
X-Proofpoint-ORIG-GUID: Buq3OJzll9nODs8oFoS690urc94q_SFv
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Aug 11, 2021, at 4:07 PM, John Hubbard <jhubbard@nvidia.com> wrote:
>=20
> On 8/11/21 1:35 PM, William Kucharski wrote:
>> I agree that try_get_page() should probably be removed entirely; is ther=
e
>> a reason you didn't in v2 of the patch?
>=20
> Hi William,
>=20
> This patch *does* remove try_get_page() entirely! Look below. I'll reply
> inline, below, to show where that happens.

Ah, my bad.  I was conflating it with try_grab_page() in patch 2/3, which
also seems like it should be an inline, but given your explanation re:
try_get_compound_head() it makes perfect sense.
=20
For the series:

Reviewed-by: William Kucharski <william.kucharski@oracle.com>

