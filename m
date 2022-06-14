Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F36954A313
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jun 2022 02:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241377AbiFNAKw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jun 2022 20:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235709AbiFNAKv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jun 2022 20:10:51 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBBA11149;
        Mon, 13 Jun 2022 17:10:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IzTQhZQBuwlCcxphWZbiLzzLcD4QcHSJSCvpQEhb2lOys/GJmDxaVAPe+cnSY9kGalZQVMTYax6Iab0zAVvqCen1Q18mbprn5UYGeH9Vigz5oMVklo4AdI93L0san0KcjvElGvQDIUJmqJ3X2SDryA/I1ILcCGElNfOSo8nbcKG+JLwUxbMt2K6fcl8NaLVqfaNmsr6qNoMD+ZvOG2mIemUI5srPNtUZnZ7beuoYFgmPYU/4VLbBZ1Z7QwsjFSQ+jeqnl0fSq3UoYsbmUzrMKTGyajn4Ru8g3f1sQEj+foToKkGYYDKUesaAwji/ERDPPqix2F85NwYYdU2A74fsSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Noc9kvYTgZBMyKl3A+m4N7r6ppPCAYGM7+21QcSNYCQ=;
 b=KFgP4nVuHbuYvBntj9W7ZUwxq5oQzPoG2ZayN8u0z1KY/zXjaP70I14jjYdDnF0EQkDuOqWq+TTcGzIOuOoXFe+CzmGIkp/mC3pPObAWcNgjLrlvCRcugJ54seResuUK4BuVeDRu/zd4Az0DCQrbBwthJPFRS0RwQQeo5DaeB1vIv8VXc4q5gPjpApCPOA7l0A4IyC7/iSGIzJ17TgeA4ADcR8ltK8yoVZylEMe432pbZeujQKyLuoXXwnu9B8FsoRQqhAPWs/TU8i9WFsq25//Z8OUGyXH7q9wquO/Jsnp4R1qLiD46Nn1sgCXROB3NbM/O8GF18ME9txYRvGuwRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Noc9kvYTgZBMyKl3A+m4N7r6ppPCAYGM7+21QcSNYCQ=;
 b=n2GODgY2kls6qZS/vl/Zs45PVy14FsKpSzixoX9+uKEuFXhEbVg+Pxj/mPM1l2AqcM5NZP0ASgtiBfFgOcQbXRBNAQkcJUfm8IXWXsl0EW6wcdKc+WXJ2lfMq4vMoMlN7vpHd3v0lieITDw6Tmoz85OEz6RKIx9Qd3OWf4Zog0s=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by SN6PR05MB4461.namprd05.prod.outlook.com (2603:10b6:805:34::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.6; Tue, 14 Jun
 2022 00:10:48 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::a4f8:718a:b2a0:977f]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::a4f8:718a:b2a0:977f%5]) with mapi id 15.20.5353.011; Tue, 14 Jun 2022
 00:10:47 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
CC:     Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Charan Teja Reddy <charante@codeaurora.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        zhangyi <yi.zhang@huawei.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linuxkselftest <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v3 2/6] userfaultfd: add /dev/userfaultfd for fine grained
 access control
Thread-Topic: [PATCH v3 2/6] userfaultfd: add /dev/userfaultfd for fine
 grained access control
Thread-Index: AQHYdfv3YX54vWzxvUGMIUQ+ms6N9q1N9KwAgAAJcICAAAJmAIAAGdqA
Date:   Tue, 14 Jun 2022 00:10:47 +0000
Message-ID: <C1C5939A-B7D2-49E7-B18B-EE7FEFE9C924@vmware.com>
References: <20220601210951.3916598-1-axelrasmussen@google.com>
 <20220601210951.3916598-3-axelrasmussen@google.com>
 <20220613145540.1c9f7750092911bae1332b92@linux-foundation.org>
 <Yqe6R+XSH+nFc8se@xz-m1.local>
 <CAJHvVchdmV42qCgO6j=zGBi0DeVcvW1OC88rHUP6V66Fg3CSww@mail.gmail.com>
In-Reply-To: <CAJHvVchdmV42qCgO6j=zGBi0DeVcvW1OC88rHUP6V66Fg3CSww@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4db6a6e2-0847-4265-d7bb-08da4d9a5559
x-ms-traffictypediagnostic: SN6PR05MB4461:EE_
x-microsoft-antispam-prvs: <SN6PR05MB4461FEC8726CF3ACB176679BD0AA9@SN6PR05MB4461.namprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XnqURZaax2Z8gswo3mr/g1fBLjeLetnCdd0hmEUYA6mmpNGHHiEziCfyZ7ttTZTXevlG1ZhiAo6tojczPA6gQBpzGCICgAvYJK0OaXQrJjZVMJqn3n9nOg63MLYaXNVatqxnQVDtIKiEZYCZXUoOPhrBvqWsQX4HfJVdsF+Xk/WKm9KBR6vcE4eWXq9tHPLLPvPfZaPIiVpY3RuQaeqj23WT/XdgI6BEBEDCOm8HIwHtxBRSB4iSHeABBNZFf4hdCzhcECZagUaiXwslLf967Skxq0dR7iC+/K2XZB334hEizqcBKbnTXdknPqVawTiOebx6dhIyLURsv9yoOezdpcoCuXwFx8j2zwclydmdZwpfG3NbyiWYbXd/NI2NtvqTGsdHeZVk7PN+keRqtvyQnYd1m2QZK5j32QWtH6Lnn+0DnP2S/UwmmXTBtfoxT+Vx1chdsQJbrrYwl77pTT2tXWGtHH3f7jtPBfuE6UunBA4aiXdNBhz85LFjSExAQWG4oTEvcF/s22QcvhAOVANdFqXJz/fRwwQPUrX2EZX8whkkqXWJfgeF+ZzIR1k8bCeWeDlXEcHiZF2AxuV5MxtauDqJ5nZTh/HJ7+L4PRIDiEX0EBTt/Grbn4LDjtOdYwC2Xwednf6i1/Rs/pmN6axxFCrCgL6/Up2ZvAR60qLwimnsOeUtugrai2LE7EZ6nmpahQWJpr4PTQwdHwYz0KUX0Ewls8JfjhZmVaUdgaKhhBqVTZn9pTKGFmag1+2mcWhm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(186003)(38070700005)(66556008)(86362001)(53546011)(26005)(6506007)(6512007)(83380400001)(38100700002)(54906003)(122000001)(66446008)(4326008)(6916009)(76116006)(8676002)(66476007)(64756008)(316002)(36756003)(8936002)(71200400001)(7416002)(66946007)(5660300002)(33656002)(508600001)(2616005)(6486002)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jOaEi/IC8dag2HzzwJv61zoOQccJpJJmFuPnB7FILa1sJNju4tbYSJBG0yn3?=
 =?us-ascii?Q?0hnZu5XaokvSxv00GJsM2jclN9O8rh5d3kjQ/YrA0mb6XPoFO2to2d63bztn?=
 =?us-ascii?Q?7KxmDWT95zbuguSnS9MZJhyyfLqRlAy930v65dMbeZ1hC90HE9hPILUPi4wQ?=
 =?us-ascii?Q?/jecLW5MNNXofWg2cU1dQnTpezgxg2Qk03Xsq/g6gsZCFmmPrvKYYSEk9mn0?=
 =?us-ascii?Q?x+hO3xZ6JW0MEIuolZ4w5Muby+b0jbDoDV9g1pQgzjnkTZOJj2bQCbfAJOGW?=
 =?us-ascii?Q?5CmSH4k6tJhaYAYShMYhefT3WSW71cTiff9a0VtawIItRYFORboEQghf9m+9?=
 =?us-ascii?Q?iyj//XZaT7Rt98b8HqrXbMsu0xFQ8Jwr6l4g2Egm0SYIdAH146hlWF2+Q4/M?=
 =?us-ascii?Q?jUvITZBj3c/lCrqOBwAXEQdhGZMQ2wb2v2CgdRZDdoKdInQBj0M2h+Chw/t/?=
 =?us-ascii?Q?t9zS7tSRChjv7pAGijsJ5ON6hOm9zKzD+fKTCJnHcmd8eM6YRGoxoVy8Ihnc?=
 =?us-ascii?Q?Bh/5AHSR6jaJab3xTcArl4WBGqg2klSCs2bLlK+DIBonnZo4lDzOcFHohNEW?=
 =?us-ascii?Q?YLnilBCDmpRlNsxmjnznB/vVrmX3r+Dnva12TKQreHuIj8MGkJpRKFvgOlwA?=
 =?us-ascii?Q?3KxNz4BmUc1cAkXgPSTeVKZU42Rn0srcUGA8nGhrh/2kgmCnnP8NhVgCGB4z?=
 =?us-ascii?Q?cy2a9retzctOpFdUThVnM3XUUmsbWDs0vu2YHi4F/UtSTVTb5Os7Sb0Hd8fK?=
 =?us-ascii?Q?9p6mkTqDQb8mauzSDbUrHttuqxtqLwSuYDS+tgZimL0LbiPg45WSUq/FiyMz?=
 =?us-ascii?Q?SkmlHD6AC9fnLc972KdydqMVnWDP855jvClG7o+QemzC4XqIo0ydXkBT/u3I?=
 =?us-ascii?Q?CehnqLrPkfDxvPzsRKBFyVh9Q5Z2OjB6kPWR7UFQL711iFX6SZ0RHdMHYTCS?=
 =?us-ascii?Q?pSZHV8nDfPot6sotR7AygCQU+S7uXaLNY+m6/Av+8/fev9BZt1sIPX1k+tr8?=
 =?us-ascii?Q?rFwAJHFb4xy9qwxmj0IirZsU3yXJ7x3O2vfmK3x7Fwwpp3iiseO1AoH8npHx?=
 =?us-ascii?Q?0gs+T0yxIRXBgaX5ra4uUmGiLf3YsLPIGe/A3vuoRyN/d3MKqdLgkUzSoxw8?=
 =?us-ascii?Q?Wsr5Hiq8dMpNn+Lp/OA1xM9FySbkGQ8f9or02UpYvouGOC9og5HD4WUSGhZL?=
 =?us-ascii?Q?S8w8iFj/YFXlBz7MMCykzTr0x1XbDf8WS+nkC4s9jg4jVlGPNtJpNDNHfrSH?=
 =?us-ascii?Q?8eW9UTEhbnK1cvfOwMyMq4b8NxyfSYzyFVx6RMS/nybDYg1I+F+7lGCiJj9x?=
 =?us-ascii?Q?CrFrH8FGXLk/0Auakgch4Cc4AjaCBbc0zt/y3Gh6+cjPlUpdOxL90tQ4op7n?=
 =?us-ascii?Q?CdojQ5POAKYDnGtp3umVGe7WE+oqoJSzzWdCpMHQMLXFlWpWWGGXbG+cI9Qf?=
 =?us-ascii?Q?fDZ306jwMr64pmmO8yIy/Ph5HNpPjB1w9lyWdc1QXecozkt/HLHPQwY+7B8x?=
 =?us-ascii?Q?Spyijjhkkh3bVHqG0k94R/rpRtiicDDnCR+vTLPHEJZUg2lq3Ms8LDQTBm0C?=
 =?us-ascii?Q?sYNzH0E81ZKAqmaADlOBU647+yLDZJWNlajXNwoluEO7jMsxjSTL666Pr9oj?=
 =?us-ascii?Q?la5cHoshH+K8J0zp9xItE0rq6X3K2l+ASo9nf8omvr6awB0Kwa90CFAztXFJ?=
 =?us-ascii?Q?fa3VLRN9wXrkv3lwrP7vDaSp4t9wIcwpVzUuDwNEfio/TBy6PhWMaIUcMajn?=
 =?us-ascii?Q?S+V1gIp45Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6E9DB0CA7AD5BA459210110F7FA70A93@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4db6a6e2-0847-4265-d7bb-08da4d9a5559
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2022 00:10:47.8443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZwG7iAPSn+3LcELBF5YuwXmjRofnFaZomK7AZ0WQSC4sLNdJKKVVk7wwq4AqrOJSiqWiTUEaNf/jXynhc0fulA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR05MB4461
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Jun 13, 2022, at 3:38 PM, Axel Rasmussen <axelrasmussen@google.com> wrot=
e:

> On Mon, Jun 13, 2022 at 3:29 PM Peter Xu <peterx@redhat.com> wrote:
>> On Mon, Jun 13, 2022 at 02:55:40PM -0700, Andrew Morton wrote:
>>> On Wed,  1 Jun 2022 14:09:47 -0700 Axel Rasmussen <axelrasmussen@google=
.com> wrote:
>>>=20
>>>> To achieve this, add a /dev/userfaultfd misc device. This device
>>>> provides an alternative to the userfaultfd(2) syscall for the creation
>>>> of new userfaultfds. The idea is, any userfaultfds created this way wi=
ll
>>>> be able to handle kernel faults, without the caller having any special
>>>> capabilities. Access to this mechanism is instead restricted using e.g=
.
>>>> standard filesystem permissions.
>>>=20
>>> The use of a /dev node isn't pretty.  Why can't this be done by
>>> tweaking sys_userfaultfd() or by adding a sys_userfaultfd2()?
>=20
> I think for any approach involving syscalls, we need to be able to
> control access to who can call a syscall. Maybe there's another way
> I'm not aware of, but I think today the only mechanism to do this is
> capabilities. I proposed adding a CAP_USERFAULTFD for this purpose,
> but that approach was rejected [1]. So, I'm not sure of another way
> besides using a device node.
>=20
> One thing that could potentially make this cleaner is, as one LWN
> commenter pointed out, we could have open() on /dev/userfaultfd just
> return a new userfaultfd directly, instead of this multi-step process
> of open /dev/userfaultfd, NEW ioctl, then you get a userfaultfd. When
> I wrote this originally it wasn't clear to me how to get that to
> happen - open() doesn't directly return the result of our custom open
> function pointer, as far as I can tell - but it could be investigated.

If this direction is pursued, I think that it would be better to set it as
/proc/[pid]/userfaultfd, which would allow remote monitors (processes) to
hook into userfaultfd of remote processes. I have a patch for that which
extends userfaultfd syscall, but /proc/[pid]/userfaultfd may be cleaner.

