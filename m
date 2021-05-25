Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 210DD390A91
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 May 2021 22:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233303AbhEYUhM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 May 2021 16:37:12 -0400
Received: from mail-bn8nam11on2065.outbound.protection.outlook.com ([40.107.236.65]:29569
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230218AbhEYUhK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 May 2021 16:37:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KLiHDWNGW0pi/YCnvNuR016rfDbM0RqrImfQQf51dN4YDkuJt6SIX1Wqp0+jAJS4REiSMNcYCpJAWuuu5ZLrKmIzhTXdLW2TiKgE6Lz3Mcbt1X7lZKlNfv8C129ciJipwWQ0dWgE1d8MHyNWCrmhuEYVWJc9q8F1KNUZY6Hseq55W2ZFsXuNzT/btqJAnpEzPjLq55UBaJtXuuSfQgH+4sTKD39FA4YJhViDxH+BL+pm9qvruC3wRCbuNZ/IhAw1dDfV5VLbDcMJQx3FR4SOlyK+WwnZMJqIPfnbYpBJuYD2L8vnIc/3RqZo73MEhKM65Fegu/lBfof70S6O/Krv6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MyIlcjAF/KXn1Ycw02DC6gRHVU1ZOTRceyRp5JVsuro=;
 b=FEthkEulsHPHvhHJk8CM1mCWkNYgvhTY0/tPeTnZMGwikW8rMK/JxHV33YL7KCyH0lcERwrBDEF640xWarFDpfnT49Fx+KNUXQGlnj2o9x1TcanNWivMlEq9oZC3dhvLGnMo0pSig7/HZw9STrd5CfRLywDcrcD08jJLQqSu4OGwddd3PxMrSpuKBUtUqENwerfuJeGLWAylkFIigBIkE2VxQ4h0hwvBP/3kjTZqB+AkYOpANp+eer97m79ds0j25mhxblOXSWe3BxYF3RszqGzX0Lkx0x6iXMqess/HAP+2JlqqoH8s/qzJdNJ2ghlAW2ONzGgA96RLAgamNwF2Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MyIlcjAF/KXn1Ycw02DC6gRHVU1ZOTRceyRp5JVsuro=;
 b=QM0e88D+NDQkDyG1/BiDHV9o5IckCOUskYH+pbPOCcZ8mUHFRpXYSb4++MjCac2bpHaPkYEIBJK618QrMpMb574w7lEb1iBQM8FrLh2wtQmPfr/prY2Q32E/zvRDkG7ALWM50LoUN0chDC5smBBSFiWkyOmg3tqkvHVSqjoaABWsSH9JTZolvfReskoDJAo/2m/sPZoKgenpM5C0u5X9kDRf66hDYrEuYEjPnW8EyIq3ghvjWb9MJpXR5e+L6PU7vGdRxFydgMnzOOxc8saZRouO5Fq2AL07NAjEvP9pp3A9sZK6FsGroY8K2tmGm+a9jPlZloveudWB98BqANeR4g==
Received: from BYAPR12MB3416.namprd12.prod.outlook.com (2603:10b6:a03:ac::10)
 by BY5PR12MB4068.namprd12.prod.outlook.com (2603:10b6:a03:203::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.25; Tue, 25 May
 2021 20:35:37 +0000
Received: from BYAPR12MB3416.namprd12.prod.outlook.com
 ([fe80::e9aa:71fa:d0fd:1a7f]) by BYAPR12MB3416.namprd12.prod.outlook.com
 ([fe80::e9aa:71fa:d0fd:1a7f%6]) with mapi id 15.20.4150.027; Tue, 25 May 2021
 20:35:37 +0000
From:   Nitin Gupta <nigupta@nvidia.com>
To:     Charan Teja Reddy <charante@codeaurora.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "yzaikin@google.com" <yzaikin@google.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "bhe@redhat.com" <bhe@redhat.com>,
        "mateusznosek0@gmail.com" <mateusznosek0@gmail.com>,
        "sh_def@163.com" <sh_def@163.com>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "vinmenon@codeaurora.org" <vinmenon@codeaurora.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: RE: [PATCH V2] mm: compaction: support triggering of proactive
 compaction by user
Thread-Topic: [PATCH V2] mm: compaction: support triggering of proactive
 compaction by user
Thread-Index: AQHXS+sbP7JG2jAKA0uVYnCsOKlt46r0sTFQ
Date:   Tue, 25 May 2021 20:35:37 +0000
Message-ID: <BYAPR12MB3416727DB2BE2198C324124CD8259@BYAPR12MB3416.namprd12.prod.outlook.com>
References: <1621345058-26676-1-git-send-email-charante@codeaurora.org>
In-Reply-To: <1621345058-26676-1-git-send-email-charante@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: codeaurora.org; dkim=none (message not signed)
 header.d=none;codeaurora.org; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2459213f-bdf5-4a5a-4092-08d91fbca7a8
x-ms-traffictypediagnostic: BY5PR12MB4068:
x-microsoft-antispam-prvs: <BY5PR12MB40680456E9838C475C0EB911D8259@BY5PR12MB4068.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /0aVg1IJp1zk2Gq6JtKYra2JequUGu+n0k2guup25oCzA8D52ea/9htXXsVXcDfln2evlPdsWBT0xZXkaw73xCS6Df0iAf8o6pS1ZS60ATsRM0aTxU7C96NDdDt4bS+/8LLssZkysbnCpQKdKnKkrdsoBmWV+P667iXnNBphvsdnnsHO6rGS5QpWBmYyjMOqB4QChc8qk+k/Y5+UNz7XwAq1a6LIfRrnK8XZZfEFYkT1+0DmDw+71rrMU05TB3yesQQMalObRExGUV/xSTuPnJccoLmcoXzW24eDvsNAy5BsjxRVAH55ggUSNUuxgf8B3vheR+cWNYK/bJyYUHM5ubX7CJK610dXVtRLLSWOYwY6FVTEkpUdvihrQTcZOY+69ccaYksN2BF0k7qlOWckVPiyfAYy3QpBOk513g/im7EQQ4H/IYn8Cc8INMmAgi4aUwToW7aAF+pQkYzuT99vFGtrQFlIHeczF8NlQHgfgPCMP/ZW8mg6oZW2FqDteW18NKRdhbgJg8P5TWalUpD1uLcCLwaEsEgXKESmh0hrfttFtOE1TZtcUEXxs0ZDqNthc8JEg5reexQ1ewvS80O0uzcuH5Uigss7wxxnWysHIzeUhieJH5SmHdrCEcbtBM9V3a01Vdyd+hVaqjVfjp4kKA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3416.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(71200400001)(5660300002)(52536014)(33656002)(7696005)(83380400001)(478600001)(38100700002)(7416002)(76116006)(66476007)(186003)(9686003)(2906002)(66446008)(26005)(4326008)(86362001)(122000001)(66946007)(66556008)(6506007)(110136005)(64756008)(55016002)(54906003)(8676002)(8936002)(53546011)(316002)(921005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?H2Uko9VZluZDXbtj9xtJSXMnh1U1GA3NbZzGvZ+jz1pKxlY3D4sKqnbb2cyf?=
 =?us-ascii?Q?xavHHVm5tlEbsPCBXkr3i6cTBMamqST3RfvOSjBkLLjzMv7OEu92P+Msdysi?=
 =?us-ascii?Q?wwIpghmAVuMfBnIOPs3n0rGHZtu4G6P9BG4BokrtKpJVcYNLiSw0vKZyFkre?=
 =?us-ascii?Q?9v4oPOwkA6dEhA3K4gYPJJJwALtoHena9+8ZpoE90q20zoxNheZWV7tx+jrz?=
 =?us-ascii?Q?LzmRiTueFrWZrzKdmiz4QQT341xnrrPjYdals87Axx8GeDnbh42wG+Tk51TM?=
 =?us-ascii?Q?YXaKpzTUq/zfcs2P3Fex/CVhYVELGPFa6nTURI12IMhVZDYn0YRRwNYN3uxO?=
 =?us-ascii?Q?sKMuRs4w0r6aMbD/zi91eIIqPblRrPKQLu9at+/LK8Sj+jlmBGjkCm68iplk?=
 =?us-ascii?Q?wmjoknacE9dI5CUGEGyER+7GEegsGnNuuTFc9YWlSegffpE6DXKuCMnnKRW8?=
 =?us-ascii?Q?w8Lra57/bF1PLZtMecPJmEbdQ2rs6wXEZiUOoqCqSJ07ARUKImliDppNg8Sg?=
 =?us-ascii?Q?Q+OwIIWZBRh/JU5BY0jWbQewCCyXe+TR5obkuJUOdOgnIDYpqVoJGrANu0Uo?=
 =?us-ascii?Q?fyVtvuxo3FJ2m9OKyJnpirhFw6eqv6qDy+fKN19EJbyyfrO+rwDXu1Kx8Y+x?=
 =?us-ascii?Q?fE6GObeU6xvyKdyHd4V5kqf8L9AMk9zcpEdF1hePMiv6nxeSI5aEIkrEHGxd?=
 =?us-ascii?Q?5PcVDwF5lwGijUSTNF8k0chw+z4le22w4WC5AUHBzOXHlo8IPLet2+593B+k?=
 =?us-ascii?Q?fM4A8Jhnog0XukBNVvqYdv0/ZsUi7Ci5EKCtMC5YGgToffPpWuK5wWBQgvs4?=
 =?us-ascii?Q?JZjDQumTjgmiyBkcoIi3uAVCetqS0EpvXKG/NRAXyBdN33LzS11L8Lu5muw2?=
 =?us-ascii?Q?3Ct5PaWZG0SvfEZNRs/jLWyVX176ctcAii42+TVMNsV8J06cLdErKpm1cGh2?=
 =?us-ascii?Q?dGTtSKQcUcox/f2hvZbxrITshGhfh+GZSU16d7iJnBcWwZpheILvRnB/1+rT?=
 =?us-ascii?Q?Zx8GZXFPIjzt3OrlXeyDj90gRgQu27RD/thexoKGrA0KGWZT/hknOawgPaI6?=
 =?us-ascii?Q?WgpMc1c8ErYpy3fIhrb+sD/ao59faVeFju/Xcw8Vr61SP0fcMjliVD00rXJF?=
 =?us-ascii?Q?03s5hGA/Do+qTPLiKxGkpfiPWFesHygnnN5wJA+MvvRHN9Oy98buXFBYGSoQ?=
 =?us-ascii?Q?2ng/F02+ieBe8PVr73zFT/Le/FXSqVvni6yGMsG42qXqIGOdfnFlDWoeUeKO?=
 =?us-ascii?Q?nqJTSOijr3gangHnw0Zjk0BcTqoXRAlR7/vV7SP3+A3uyS7gIzW7yv40VZFd?=
 =?us-ascii?Q?JS4=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2459213f-bdf5-4a5a-4092-08d91fbca7a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2021 20:35:37.4871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /Ihzdb1WvtHS7N6oh5ASA+sVSPQ3M5gb1+HG9pOTI+KjIuDk++6MqePTd+PanKA7GjYgccqrghoXcFC99P0Xqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4068
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> -----Original Message-----
> From: charante=3Dcodeaurora.org@mg.codeaurora.org
> <charante=3Dcodeaurora.org@mg.codeaurora.org> On Behalf Of Charan Teja
> Reddy
> Sent: Tuesday, May 18, 2021 6:38 AM
> To: akpm@linux-foundation.org; mcgrof@kernel.org;
> keescook@chromium.org; yzaikin@google.com; vbabka@suse.cz; Nitin
> Gupta <nigupta@nvidia.com>; bhe@redhat.com;
> mateusznosek0@gmail.com; sh_def@163.com; iamjoonsoo.kim@lge.com;
> vinmenon@codeaurora.org
> Cc: linux-kernel@vger.kernel.org; linux-mm@kvack.org; linux-
> fsdevel@vger.kernel.org; Charan Teja Reddy <charante@codeaurora.org>
> Subject: [PATCH V2] mm: compaction: support triggering of proactive
> compaction by user
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> The proactive compaction[1] gets triggered for every 500msec and run
> compaction on the node for COMPACTION_HPAGE_ORDER (usually order-9)
> pages based on the value set to sysctl.compaction_proactiveness.
> Triggering the compaction for every 500msec in search of
> COMPACTION_HPAGE_ORDER pages is not needed for all applications,
> especially on the embedded system usecases which may have few MB's of
> RAM. Enabling the proactive compaction in its state will endup in running
> almost always on such systems.
>=20

You can disable proactive compaction by setting sysctl.compaction_proactive=
ness to 0.


> Other side, proactive compaction can still be very much useful for gettin=
g a
> set of higher order pages in some controllable manner(controlled by using
> the sysctl.compaction_proactiveness). Thus on systems where enabling the
> proactive compaction always may proove not required, can trigger the same
> from user space on write to its sysctl interface. As an example, say app
> launcher decide to launch the memory heavy application which can be
> launched fast if it gets more higher order pages thus launcher can prepar=
e
> the system in advance by triggering the proactive compaction from
> userspace.
>=20

You can always do: echo 1 > /proc/sys/vm/compact_memory
On a small system, this should not take much time.

Hijacking proactive compaction for one-off compaction (say, before a large =
app launch)
does not sound right to me.

Thanks,
Nitin
