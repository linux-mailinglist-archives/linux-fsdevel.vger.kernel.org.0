Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1699D32C563
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 01:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359035AbhCDAUY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Mar 2021 19:20:24 -0500
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:57260 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1573367AbhCCQ33 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Mar 2021 11:29:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1614788899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4POyBygAAEdivD7vBDyHGO6sL3uA4fGnEJdAQOJcB2w=;
        b=bZ9Q5VKbELjx2qHYPJ1c39RxZLT7HDdYpyfODLJxIj34MUpyWqBcYsn0N7xjU6HuyUIplt
        xnGnpQEvP+bEd4rfva2Bvs/Nvz2irt/Mw3RQFq4loeLoE6H/FPJc/NJiqE9m4zSkBwsiD7
        pnrYiNKTdEwRG3rJewvxzWofo1mIPp4=
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur03lp2057.outbound.protection.outlook.com [104.47.10.57]) (Using
 TLS) by relay.mimecast.com with ESMTP id de-mta-4-5MJK2UTXNNimQhiCjnG1yA-1;
 Wed, 03 Mar 2021 17:28:17 +0100
X-MC-Unique: 5MJK2UTXNNimQhiCjnG1yA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bg37hD6U67N6r3l2I4cNntbN2TKkxoHp3c0FIcHnsEf6fa68T1yrGBx0/HGmVA2m2nD+B8IcFlzbn25QpJDGEoh0Jxeo4gl6fQV76PifT67Yw/RXqydGGdo6Ci5qML7PCPfV989Y1ywaIoci1971lsxkBCorqXiJiFDZUN3blh5fvFJ+4mOfnMVp7acmKnKlqV9KwGYUWStm+489D13qjfENcskwmLm/wA9Tn8Z6dOa6EPbq03QOCjoN0VfaiG1PW4qEU2Er4jDtGXDbW5eGUmUWYUJF1rp1xvqp8fU8reYnHz5V5Pjm6paaRMdIcWRHH0l35U+IjP+dUSgHbVx0SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4POyBygAAEdivD7vBDyHGO6sL3uA4fGnEJdAQOJcB2w=;
 b=aHlevAPfKRuPSUv/pNwiNPOJ4y1/4Ve9rlwsOpAfApwyLulxbjm71nKD3dIYujuVZxeeLUWfb3f9x5VHOS9OMv2tLHZhCjSvd+/ncnNsm0aei54rmGORv4vdVbNFKAJIUEqCQ+onUgrEaYmnpRyu7+Lk6hAOQwKlRxDrzleeUmSg2KGLFIIutkFy3p7lzspW3JzeK1WALTiwvPCWKHRNL6cmKbTfoXPDB7udgraEMHHya3sX6CR8EXcT66Naq7Wbw+ryGfFlbgc4WYZgT0o/QMVIKDSdZH5vlHUsRIO0NxGKyqm5d8BlatjSK8oyLKmszlBm6qMbnXHwOVby+KcSSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: talpey.com; dkim=none (message not signed)
 header.d=none;talpey.com; dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3359.eurprd04.prod.outlook.com (2603:10a6:803:3::28)
 by VE1PR04MB7456.eurprd04.prod.outlook.com (2603:10a6:800:1ac::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Wed, 3 Mar
 2021 16:28:16 +0000
Received: from VI1PR0402MB3359.eurprd04.prod.outlook.com
 ([fe80::9c1d:89de:a08e:ccc9]) by VI1PR0402MB3359.eurprd04.prod.outlook.com
 ([fe80::9c1d:89de:a08e:ccc9%4]) with mapi id 15.20.3890.028; Wed, 3 Mar 2021
 16:28:15 +0000
From:   =?utf-8?Q?Aur=C3=A9lien?= Aptel <aaptel@suse.com>
To:     Tom Talpey <tom@talpey.com>, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-man@vger.kernel.org,
        mtk.manpages@gmail.com
Cc:     smfrench@gmail.com
Subject: Re: [man-pages][PATCH v1] flock.2: add CIFS details
In-Reply-To: <5ae02f1f-af45-25aa-71b1-4f8782286158@talpey.com>
References: <20210302154831.17000-1-aaptel@suse.com>
 <5ae02f1f-af45-25aa-71b1-4f8782286158@talpey.com>
Date:   Wed, 03 Mar 2021 17:28:14 +0100
Message-ID: <8735xcxkv5.fsf@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [2003:fa:70b:4a22:792c:d376:dd41:4ec2]
X-ClientProxiedBy: ZR0P278CA0012.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::22) To VI1PR0402MB3359.eurprd04.prod.outlook.com
 (2603:10a6:803:3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2003:fa:70b:4a22:792c:d376:dd41:4ec2) by ZR0P278CA0012.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:16::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Wed, 3 Mar 2021 16:28:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9aa4b853-01fe-43ea-d03c-08d8de6158d0
X-MS-TrafficTypeDiagnostic: VE1PR04MB7456:
X-Microsoft-Antispam-PRVS: <VE1PR04MB745680962769826ECB85E7ACA8989@VE1PR04MB7456.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0+DpNO2jV0kSBqmAbr02ejQajTdJgnIFAo4Yk6IMksbcVOmOWdxnjP9OTxfilSmGnrZWFOuhOsqWRodR702lRfTQIP7339qrGn9HHpRzrbGfXGTfyEwUZerwXIhbtO9NLOnz69OoaOfHCfiZKAxN0YQhWTQxCf4KGQsN9elwK17mb9zXjYrKmSJcLOE4eXFSdgkS004PiHexfnA5KmnjPSnEJ2PZdg9krmnb6CIYcf+NyIS6GSOCyHMraYRuqVJSqPQOiDaxtnfynYo5yT95NFxjNQegjJx0xe6+reof/rRcRXK2S4YJdi77AKsiJES5NlrjBGLJquT2TtkwZN5a+kvuqVy+Fhb4mXLjxN20y/NKoxU3nfxuJYusEzLxfNRWP8OObxPekurU3CAsnRPWCt5xmNmvX03MZdO+Dj9dk7WZF+JTaPyrwATvRMDUfbn6yXLTlLuygQ1iWUlH88o+eHpdoTKpGePPIw3jbYK3R2rHJVE/ZDZwsV2dQf46o7QE7pkfrKPHFu+LKEGDfQXxaA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3359.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(396003)(39840400004)(136003)(376002)(83380400001)(53546011)(2616005)(4326008)(16526019)(86362001)(66574015)(186003)(52116002)(6496006)(36756003)(8936002)(66556008)(66476007)(66946007)(8676002)(478600001)(5660300002)(316002)(2906002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NERzRmVSKzhwbDNYM05NVjladHc1RWFrM1hGdThmam5SWHBINGo0ME9DWjBV?=
 =?utf-8?B?Y090RUlTMDAyRisvUkhlS1hkNWZlTjVOK3JDd1BkYjNmOTBUbWQ4RGo4dFZl?=
 =?utf-8?B?WERLMkJRSHJHRWRhVHovSDNYUDRkUnNGWWhzT1JCTFhZa2dBQTlkQ0xVazdj?=
 =?utf-8?B?VkJoang3YlJWQU1BdVIyYStOUHRWYU9weDlnL296WWplcGhPeEoxMEJTQWlT?=
 =?utf-8?B?SEVvMWRsNEJXN1hwbEo5WWUvN0h0R0ZDSmpJb1JBQW5HMnUwaTIvWEo5QVBl?=
 =?utf-8?B?R3QrYXU4K0p5a0xobTlZK0VOakZsUnhuNjdOOFByN1ArbkxkaTJIUDNCQlJI?=
 =?utf-8?B?cHFyaVdqc0QyNmg0VUtZbUdFalRSWmU3bmlGRlRvSGNLcUYyQmRtbFo1MWlp?=
 =?utf-8?B?Zm4rMlpReDNMSkczRGg5ejkySTNhVXgycmphUmtmNTV5YzZJZHhERFhyMm81?=
 =?utf-8?B?bXVQU0xPL0RVbzlEcFRsQTFUN0ZVR3UvODNyTXpHMDRCUzY0Z0h2M1hBdXlt?=
 =?utf-8?B?UnFKb1Jsd3JybUYyMUx3bkNiNlBvd1UzTnFIN0dtRDdoZXRrL1NhS0JxN2Yx?=
 =?utf-8?B?bURqdDBHQXM4MEM0N0RlZndyNi9nYmJjNVA2ZEg4ZUphMElkSW5FaWF5WFRI?=
 =?utf-8?B?NUlrZXhVdmQrOFJxeTRMRWIwU2RwZ0lJOUtSVjQ3RVB4djFsVTBmc2JuSE5l?=
 =?utf-8?B?bS80RURqQ1RjdVVOQ1ZHcmtaZk1Cc2tVM2UvcUw4WDV4N3lJWE5ocG9nazVs?=
 =?utf-8?B?ZDF1TEJvRjA4eFlvRVVxWjZwckdMQzNNSlJjQWdMNVltZW13L3kxVG5qTlRX?=
 =?utf-8?B?Y09hazJJQXUvQ1ExVVdkNElDa2t5dUhTdjVQWlNNdXpUcHV0VjFkd3d1dG9s?=
 =?utf-8?B?L1U5MWNWSHJwNWxXOU9QOWkzSkNWbGhIbXBkcm9Ockd1eDJ5b2ZOc3A3b05w?=
 =?utf-8?B?VDBTekNYRm9rbHkvR3Q0cHBNWUxic0l1TGpkclk3aTRGbnBYNnVHVGxyNmE3?=
 =?utf-8?B?dFYzWWViMTRyRHRiOXE3eHFwL2lIY2JnZFJ5SXNEZXVyNFNGeXFTN0tsc0FZ?=
 =?utf-8?B?WE9BVEU2Y2lMalVmUXlBYm85L3U2bklpZlIxUFk0KzBQVHhCS3BHbWRNaEFv?=
 =?utf-8?B?ZVlOR3hVNEpjS091Ujl2SUR0bk45NDhldGY5a01oMUJMazhudWhDR1FhMmJp?=
 =?utf-8?B?ano4Q05aNXZrUW9pUXNWNUljQnlNanNnRnBSOGJFTlBCOEpXVUUrZGh3NTk4?=
 =?utf-8?B?b21wQmdaR29IMGxqMVU0b24xQ29lMVF4My90U2J3Wk1VTk5ZMUJndzAvQzVL?=
 =?utf-8?B?NnN2SU1HUVNiSnFDUVpXSXRlMTdaeFlPSzg2MFEwOS96dmNtVFNlUjUxMGdq?=
 =?utf-8?B?em1jWDN4TEptU2h3N0tPUXZDS3JHUlQ0aXhLUy9Hd1hhb2t1YzRGaGk3UHdm?=
 =?utf-8?B?aWRKVmQ5OFhkT3MzT3ZCZTdNMzlsUlM2N2JnTTV0YWk5dkhhQmhWTWNtbmU1?=
 =?utf-8?B?WWhVQWs0ZmZJZklrWTZ5R3oxQmk0NFJjVmFuYnphK2xxU0g3aE1hTU0vK0ZU?=
 =?utf-8?B?UmloTG56Uy9UQWd1N0NPV0FCRG5malMwZHh4bnpCOXdLSXZVdi8rUmRXSC82?=
 =?utf-8?B?QUM4LzRwZlpCRllMS2w2UldOQzZnYlozZmVaQ1UxNkhUUVpDSTJkN1haSTVW?=
 =?utf-8?B?ZVJFdWFQTkJEMk9RVU94OXUwb1YxeXZCbldtSCszYU8rT3h0cFRUQ21xb2lK?=
 =?utf-8?B?cHFvdjFRNVpmd25Ja29ZbWExTWs0OTJmelRyNjY5ejZZZUFtTm1acTVpL1Ux?=
 =?utf-8?B?bWZTNFdRYUJodFgxNkl4dDlmRWoxcDk3OEx6dmg1WnBJMDJybW4yRzhkdHVw?=
 =?utf-8?Q?relb+ER4RBwxM?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aa4b853-01fe-43ea-d03c-08d8de6158d0
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3359.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2021 16:28:15.7418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2QU/EMEKj7Zl6dz7J4GiYVzCTKoDTAnK4OGYWhaL/mcD0XMcIrbVEAWnFOt6iMIL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7456
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Tom,

Thanks for taking a look.

Tom Talpey <tom@talpey.com> writes:
> On 3/2/2021 10:48 AM, Aur=C3=A9lien Aptel wrote:
> I'd suggest removing this sentence. It doesn't really add anything to
> the definition.

OK.

> This is discussing the scenario where a process on the server performs
> an flock(), right? That's perhaps confusingly special. How about

This is about clients. Let's say the same app is running on 2 different
Linux system that have the same Windows Server share mounted.

The scenario is those 2 app instances use the same file on the share and
are trying to synchronize access using flock().

Pre-5.5, CIFS flock() is using the generic flock() implementation from
the Linux VFS layer which only knows about syscall made by local apps
and isn't aware that the file can be accessed under its feet from the
network.

In 5.5 and above, CIFS flock() is implemented using SMB locks, which
have different semantics than what POSIX defines, i.e. you cannot ignore
the locks and write, write() will fail with EPERM. So this version can
be used for file sync with other clients but works slightly
differently. It is a best-effort attempt.

Does this clarification changes anything to your suggestions?

> "In Linux kernels up to 5.4, flock() is not propagated over SMB. A file
> with such locks will not appear locked for remote clients."


> "protocol, which provides mandatory locking semantics."

OK. As it turns out, there is actually a 'nobrl' mount option to get back
pre-5.5 behavior. I'll mention it and use your suggestions in v2.

Cheers,
--=20
Aur=C3=A9lien Aptel / SUSE Labs Samba Team
GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, D=
E
GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah HRB 247165 (AG M=C3=BC=
nchen)

