Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAE5932C567
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 01:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353394AbhCDAUc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Mar 2021 19:20:32 -0500
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:57302 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1452927AbhCCQ6c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Mar 2021 11:58:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1614790643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bxKMgy15VerpeKkJ0kYjXWZ8SKlevDZRBv8JPFRJPfA=;
        b=XSGQZh2QMF4u4r3/5Da5Ap9nQgXVB9TmiL94UUYtYrP0xvDMQBTDT/eEoZwG68De4j0Ns5
        YAtNAdOpI6smLczu0352t/CW/U4jW3YN54PJDQbqCMAtHGa8NmuhC9N/YLYZ4T4uYIddCq
        fVRjNdoE6C9FjrrfOrhY8G1y1qrsiWw=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2058.outbound.protection.outlook.com [104.47.12.58]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-30-Jur5-lFKPXKrlqcQuHqPrQ-1; Wed, 03 Mar 2021 17:57:21 +0100
X-MC-Unique: Jur5-lFKPXKrlqcQuHqPrQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I1LJxaMw84rDs+B+guWNdFZX4cciZ6lEyx8z0BSlw198afNpWlI98dfF0z5IGjslqnK0fXUqxaNGrDg/1YP83/tSgPbsNn9JFTuda7VU04VOtjqZ/P+dScpMco//5ZiOTAjjyqaSPAMf2wAuRGNECYj8gmil4w4ZBcg3UuIa3zv6fAlXfKjzqP5zQKsTZCF5Wzw6mFAYaZDLU1YtqZ46a39+/ki60iMmmOi/k0V9E9Iihv6nsYnoBo94NlrVY6KhF6v1KXa8ZNfFeQbbqf0kMXDowqVQ7UULpgHGSXx9EGqkfpQ5nOXq+M8ggqUrMy2NNnZvOPaR0aTvfmxmJSeVJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bxKMgy15VerpeKkJ0kYjXWZ8SKlevDZRBv8JPFRJPfA=;
 b=ANaij277sNG73qNIzIZTyNplGbF7YiukEzj6vATIs6ON5rkTTF2aiQxs6y/BhwLfHONAWjdnfbd7VjTXLt7tFa9aB7gYGTCSqaZyH/4W0vo2hUWBcG8r3tgbpxGGDGTI2gnj7m95gjkOV7PUiuAo5sNTjeY/FRicz4M6BrMQkoNkDPP961WLt6KBoQpg28dAm+Xi6YnkUr+zFb0n6BjX8sbiWkY8b4TShMPWctOxMGN8JuLGTfVf828KmTf17Q04y3ggGwpbDL9syghXANrkRZEgI0VQixMo1J/WiFNnAF4/DGkL32F5h5fnS6nAsyuYqfwQ24x1rplTeYFr3QOgJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: talpey.com; dkim=none (message not signed)
 header.d=none;talpey.com; dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3359.eurprd04.prod.outlook.com (2603:10a6:803:3::28)
 by VI1PR04MB4751.eurprd04.prod.outlook.com (2603:10a6:803:53::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Wed, 3 Mar
 2021 16:57:18 +0000
Received: from VI1PR0402MB3359.eurprd04.prod.outlook.com
 ([fe80::9c1d:89de:a08e:ccc9]) by VI1PR0402MB3359.eurprd04.prod.outlook.com
 ([fe80::9c1d:89de:a08e:ccc9%4]) with mapi id 15.20.3890.028; Wed, 3 Mar 2021
 16:57:18 +0000
From:   =?utf-8?Q?Aur=C3=A9lien?= Aptel <aaptel@suse.com>
To:     Tom Talpey <tom@talpey.com>, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-man@vger.kernel.org,
        mtk.manpages@gmail.com
Cc:     smfrench@gmail.com
Subject: Re: [man-pages][PATCH v1] flock.2: add CIFS details
In-Reply-To: <f1beb7c8-1f73-0ea7-7052-13b6516b5f6c@talpey.com>
References: <20210302154831.17000-1-aaptel@suse.com>
 <5ae02f1f-af45-25aa-71b1-4f8782286158@talpey.com>
 <8735xcxkv5.fsf@suse.com>
 <f1beb7c8-1f73-0ea7-7052-13b6516b5f6c@talpey.com>
Date:   Wed, 03 Mar 2021 17:57:17 +0100
Message-ID: <87zgzkw4ya.fsf@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [2003:fa:70b:4a22:792c:d376:dd41:4ec2]
X-ClientProxiedBy: ZR0P278CA0143.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::22) To VI1PR0402MB3359.eurprd04.prod.outlook.com
 (2603:10a6:803:3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2003:fa:70b:4a22:792c:d376:dd41:4ec2) by ZR0P278CA0143.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:40::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Wed, 3 Mar 2021 16:57:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa329994-b133-46b4-3471-08d8de656753
X-MS-TrafficTypeDiagnostic: VI1PR04MB4751:
X-Microsoft-Antispam-PRVS: <VI1PR04MB4751607532927C36A71478B9A8989@VI1PR04MB4751.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z7eReaL92OfUHCPAEPLm5Zd1KBCrlgAHawWJqJbHH/3O9KcPZ30wyaaDdIseKOT/DqK/qJHQecciUkOUl4htP84n9o5dJj8migN+yrf3RJM8qg1A5bPuw1trQMWvuqmkxVdZ6SDxP/StYEn6eoNJCB5ilYdwG+2RDDvW0iLWv+cftmZLs5Rih8rXPy/R9rsD6xy+WdmkEx/U+mBCqG421GHlz+TaBlZn34nTd+bRfhJMsmONPAjDW2opIOuxH/GWwpSlW434H3ndRLMNHzhVKk+CG2QVtmXYzPe5tcygF0WWtPhCy1280OJVIjj3r7KmFHFnOvaWBttVDkugWi9IN15RaeQYLuFZow4NGLMq+rTj/GacuWwg/SU/uvcVro4OJz/JtlUbzi1jvWOBI8U6WoZLhogvbeeVancFwis70WkzmWISkP+YdzztVDiTdNCiOdZmNdMwQdBhP3BL4bm53+hLEav1M9fMNNAxMIU7s1hLXo3mNYQ8cevTCiBtN4MnMCSgEgcJcY/mHvYedsh2Fg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3359.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(136003)(366004)(376002)(39850400004)(66476007)(6496006)(36756003)(186003)(316002)(83380400001)(8676002)(4326008)(52116002)(478600001)(6486002)(2616005)(4744005)(66946007)(5660300002)(2906002)(66556008)(8936002)(86362001)(16526019);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WEJiWUxraXJCMSttZXdXcHBiaGtiek4zc2o2L3FGdWZkUzhKMUt4eTBobWxW?=
 =?utf-8?B?NVg0cXE4OVAvVlBtT093TXZvbUNtaHZUTXlyem1BY3lmQzNVTVQwcWRrMVYz?=
 =?utf-8?B?MzE4WE1TUWdGY2tpT1FTMXh3VkZPcDZVZUx4UHZIbUdBVjd4ZituMm05aUIr?=
 =?utf-8?B?VlI1UVlRcHJzeXFId2NvR1VrbFNjbktqbHF5TFhmRU9pdUxRVHFFWm5rSFBS?=
 =?utf-8?B?VlQ5T2ZCSmdvQk9zOU9DQ3JzckMrakRvQm9VK2JrNDNLOVViVWpERjdTWWRx?=
 =?utf-8?B?N2NWakUwcFR3U1FJYkFVVXNidDFxdERSVDZiQThEWXhiQVhnckVnajRvSjFJ?=
 =?utf-8?B?WTlRMEM5SXUxdVlWNmxSK09lWlNhajRDMlpqVWJ5dXUwUDdWOGJHVzhxSVZ6?=
 =?utf-8?B?WVpTSm5zL05CRkNEOFYxV1JhOVZ4eWZwSTlTckh5Y005Q0puZStsWE5qTVQw?=
 =?utf-8?B?SXlyRHBPTkpxT25Sb0JWQnpEbVpJVGpjeGllWVhodlpqc0cvQ1FPL1pEcXhv?=
 =?utf-8?B?WHhkcmV4RE1naVNvUjhzTEhHYmtZMkc0Y0lrcWRuZGc1QmZTenh3Uklncmp3?=
 =?utf-8?B?cEFpSGVSQk5keHZLblRSaUdIL2ZtZ1FQSHd5Mitpb1dDT0hVOE9rV1AyQWla?=
 =?utf-8?B?YVQ5VjFocUU4YzZUUHV6ZXBIbitFTXphcmtqd0NuckVSVXlCNVFhZXRNeEVQ?=
 =?utf-8?B?ZjBhMVkyRlhWdmJ6UVBOdVM5RndNMHBYbmpOdHdYYVpoUThoR1VydlRuU2hW?=
 =?utf-8?B?ZUViVGRJcHJoRW1WOUEzY2U1d3JlYXR3ODNYYXo5dTV4amFGUWZ0THVjOTFV?=
 =?utf-8?B?S1krS2laOXlwb0E1ZWp2QUJCbENFZ0x2SFFMb0JiaWpLbmF0QmF5NExLbDZa?=
 =?utf-8?B?Q3o0elhGak9wUU5oMTJ2NXlPbExSUGhWMzNidk5HQ2pTVXBXT2NPMURjRHNa?=
 =?utf-8?B?MjVYT2IzQk1xUi9EQlVsaHhwVTNoc1hIZ25QMHlkcVorZ3dHYXdpOWFKWnNH?=
 =?utf-8?B?SXpTd0JMM0RpRVpvL2hpN3VaSjR5N1lDczVtUVpESFlOVWZTRVhvMzRtRU4z?=
 =?utf-8?B?QkRKaWFTd1V6bnBCKzJLSVBzbk0xSEZDaVVjYmN2KzE4eXBZQkRrVlVXV1Jz?=
 =?utf-8?B?cXB6VEFyemZ2VzRPa3o1aTVjOE10UXVucC9VQzdtb3FYeE1QK3FxWWFmajdZ?=
 =?utf-8?B?ekFsSDFPbVZhNnEySXNMZzBhRnphLzJ6YnVHTCtaYnU0K1pHSGxXRWVGRmZv?=
 =?utf-8?B?Y1NOcWRWT3dDYTVRcngzWEJJQVEzSHJvb2Q1R0NNQ3Y4Skc5VUwybndCR1NM?=
 =?utf-8?B?bSt5KzllWXNlaDZya1V5Mk5qbUxjR2NITXpndnEvR3BkcW13ZjlocFdGOW1R?=
 =?utf-8?B?cHNkZkk0YWFCYkExWXNVWEtRTjhzTlhXVzZFbEY3WnRyZ3JxT1g5bjlERFdw?=
 =?utf-8?B?OWprSkpiSklNYS83VzdkTmExL3VHbFkvakFRQmhTTEJONjE3ek5ZUTM5SXNv?=
 =?utf-8?B?TE1abTBLR0tneDRIUGZYOW5GTVdUTHZyMGt5VFlxRXBIUkYxRGk5WWFnYWdi?=
 =?utf-8?B?ZkxCekJLVXQ3TkpFVTRZTXhDK3JpcENpUXRjMDNnSzRWYVZPamR4RGlFc1Vx?=
 =?utf-8?B?Q0dPaklUa2xKSTVwSnRrWmtENGVKUXIwU0JuRnRIcHpqNTl2Q0tkNFRVVzU5?=
 =?utf-8?B?RG5hY0J3Mm1Lai9aL2t3RnJBV2kvL0ZOODZyM1FRVjlJMjhYOFZSenFXclFm?=
 =?utf-8?B?SXUzVEpYZE4vTHhjbFl0MzZOdUczMTI0VVFrYzZEVHJGWXBESDk3ZVR6M21R?=
 =?utf-8?B?QThDeGtwR1Mzc2hWeWdxaEtTZnE0TjhVTC9aQ25CV1NLOW83QXY4Vm5YVGJO?=
 =?utf-8?Q?8i6e7dHTCik96?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa329994-b133-46b4-3471-08d8de656753
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3359.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2021 16:57:18.0653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ex4Gp5IE6YsrLuTNgrQkuxFg/LEmc51ex6xAHIEBdF7CgE4w9M+jG725Vb9BhDhG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4751
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Tom Talpey <tom@talpey.com> writes:
> I don't fully understand your response. What does "knows about syscall
> from local apps" mean, from a practical perspective? That it never
> forwards any flock() call to the server? Or that it somehow caches
> the flock() results, and never checks if the server has a conflict
> from another client?

Yes that's what I'm trying to say. Locking never goes on the
wire. Server is not aware of locking, and thus neither are any other
clients.

Cheers,
--=20
Aur=C3=A9lien Aptel / SUSE Labs Samba Team
GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, D=
E
GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah HRB 247165 (AG M=C3=BC=
nchen)

