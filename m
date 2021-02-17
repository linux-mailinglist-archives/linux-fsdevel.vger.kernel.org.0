Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC92031D7E9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Feb 2021 12:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbhBQLGi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Feb 2021 06:06:38 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:47514 "EHLO
        mx0b-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231409AbhBQLGK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Feb 2021 06:06:10 -0500
X-Greylist: delayed 1347 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Feb 2021 06:06:08 EST
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11HAbI9h010399;
        Wed, 17 Feb 2021 02:42:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=8epCShBI8pk16f1RxxGWRLemmsB1AT/SO64QUIoG4p4=;
 b=mFTiva+wiN92CZzH0thLgmbn7FK+DqRlMVlGcyGDzXZ94970uZben5Im9VcZmy5bDTJZ
 RyhxoYYo8itlxtJnGOe2+9lqLUg6BpmvsoCwhNQktBgDtuplxgEz1wQZr9D2GVWUyfZv
 lemoMzap26OXTz4w69PSutxmUNgPOv/+MQDE+4rJZd4SVpwNF4U0WivL02g6l287p2HZ
 CBjsgW2iblabq1FJKjx1e6wZq23MGMXdljpMrUqwwzJvO7PvWSqGZ6luby3vkpNC1C8g
 LCRgwn9PBF6ki63aDuHU9LkiFFT/4o9/gXJcBxPUn/LNQdsZP1cgE82T1BQBPUxFQN08 GQ== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by mx0b-002c1b01.pphosted.com with ESMTP id 36pyqkxvgv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Feb 2021 02:42:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RMzqGR+kjyY5RmL0uT4fNMxvfOQw4DQln/g2MNnguNdkom0IR4DuHIUmdBwr1KGEz7vPbD06FkGGHK66g55LFCDX39micyJS6zD0yWciY6O5u3uJdKFdKK4f9Cg/d4tRgi2t/Nk3fkT1dPz2Do9JcXtoDdQOsVDApktHDTaVU3wifsHEJV6NGUwP4sT4ZD+P5gJx4w8xKEuZLUgIL4q2DxWV5N0p4rfjB+qHD/W126B7rOkwA9JJ1HEHp14EPbrhlTq38uyhJod/2/eWvkKNYssGQ2Z3oDBUlOigKgeXpYaBNb0qFcN+GAofMRdSxDIgXdJ2nR9TJhKxASyFCgUspg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8epCShBI8pk16f1RxxGWRLemmsB1AT/SO64QUIoG4p4=;
 b=Yk/cgmKoxbPWtSO6GfBPo1JY8LMisIZVWkalnWDf4CDsFQcQAD+oh342BPWGcHCZ37hrhEcGG6lS5XHlVAhFDp3ITHYfZMWZNBwt+HxtSmW2G6BBQuTUxEG2FUBAzb8g7hTKPvVYR11Ri68sqDyshgSzhIZ0smPyl8gcYvHR+k9n6hiXTQo1rnRJBIN6yE1s6r6zwkuhR7HowwVTcwSx5/hK/8D6QLjA3tdmNMNu5UCel5l0izxGFNTDGNzX+/02pVxv0CUFJJiPi1g2TBFbwsjAlJeW0ohlKKvlL9i6WcRuikhc4EJ0Mvifboyx1wZY4QrVlsqTwVqkC869wKOY1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from DM6PR02MB6250.namprd02.prod.outlook.com (2603:10b6:5:1f5::26)
 by DM5PR02MB3178.namprd02.prod.outlook.com (2603:10b6:4:67::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.30; Wed, 17 Feb
 2021 10:42:24 +0000
Received: from DM6PR02MB6250.namprd02.prod.outlook.com
 ([fe80::6059:b0b7:ce3e:cb7e]) by DM6PR02MB6250.namprd02.prod.outlook.com
 ([fe80::6059:b0b7:ce3e:cb7e%6]) with mapi id 15.20.3846.039; Wed, 17 Feb 2021
 10:42:24 +0000
From:   Eiichi Tsukata <eiichi.tsukata@nutanix.com>
To:     Michal Hocko <mhocko@suse.com>
CC:     Mike Kravetz <mike.kravetz@oracle.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "yzaikin@google.com" <yzaikin@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Felipe Franciosi <felipe@nutanix.com>
Subject: Re: [RFC PATCH] mm, oom: introduce vm.sacrifice_hugepage_on_oom
Thread-Topic: [RFC PATCH] mm, oom: introduce vm.sacrifice_hugepage_on_oom
Thread-Index: AQHXBBDlHFjialWl9UGQ+pFSTaCvrqpabtKAgADvpICAAJ5jgIAALiuA
Date:   Wed, 17 Feb 2021 10:42:24 +0000
Message-ID: <D66DC6A7-C708-4888-8FCF-E4EB0F90ED48@nutanix.com>
References: <20210216030713.79101-1-eiichi.tsukata@nutanix.com>
 <YCt+cVvWPbWvt2rG@dhcp22.suse.cz>
 <bb3508e7-48d1-fa1b-f1a0-7f42be55ed9c@oracle.com>
 <YCzMVa5QSyUtlmnI@dhcp22.suse.cz>
In-Reply-To: <YCzMVa5QSyUtlmnI@dhcp22.suse.cz>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=nutanix.com;
x-originating-ip: [114.159.158.19]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b5c7c9cf-9ff3-414e-a7e2-08d8d330b676
x-ms-traffictypediagnostic: DM5PR02MB3178:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR02MB317843D6CE5914E08B9D698580869@DM5PR02MB3178.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CsHujZieSytLhHjIczj5QpoEx5zwQnOVt9dGrhwNcQakNiuS1rjj09KSvoMjGm3GIsUCZzeR8UZzGxwxc2pfm8wapR+7j65kHkfOz1K3ustOMBaY+yZt5MnbIi2anWID3c3YfuvsPtzhWlli8FD+JrUyCLunawolcJxIFi0Z7wAQnQR53lZ8FdDa8JhN2/NKoZFBZqN+kVfng8lr0WsO5+yLRkNm6SCEtGC0nn5hne8VtfnPj5s9QDZDBNFrNfJjZFi5mvKidUKH5JKYrVfZh4Yuzwh97c+X9vctVf+Xf4vqGpYUJbWgbzv0D9lckV0CuqPZWkXmYRakSstBL/lTG+aylE+0MqrIklfjwiiY/VoahZ/gs4QdGTH6oq+UI/fSiY0FJMd+SoI9+SnHoMGxBjMrxYKt6wDzSa7LP26xkke6ldbq2MYzJ+/IsdoBS6n19G2/pAxS3abnJnDu5CwJvSdGE5dUvzahWxVXhWEHUJokNHmkrw5gqJvNul5l00SkGLjz8SbFyggh3OQ0pKRL5uf9wSUdUZ/xoZyZlBpzPFAGcJ4JJoEH6n4TraPshUv33qhiJIRPT+uwNYwtlVVUlQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR02MB6250.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(366004)(39860400002)(346002)(376002)(53546011)(83380400001)(4326008)(64756008)(6506007)(71200400001)(44832011)(26005)(186003)(8936002)(66446008)(66476007)(66556008)(76116006)(7416002)(66946007)(5660300002)(478600001)(91956017)(2616005)(33656002)(86362001)(8676002)(6486002)(2906002)(54906003)(107886003)(316002)(36756003)(6916009)(6512007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?LLmLfVP5+soHwaUBtB+8PPpz9Dpfm6p+uAA5Miv4ONarSHuKpv9F+YlqTz/8?=
 =?us-ascii?Q?FVxBoUhUJWk7bT8cE6uISWwFrw1y1/S26N4nBVZT39CqAUBOhvbk8QayNT+P?=
 =?us-ascii?Q?veaRuB21CeNbQngPBkIzjvENtHMVxKFJELxqfpft/Di7z47k4G8zm0kxySYS?=
 =?us-ascii?Q?3yCWcALu42d1AnKFxn/TKLvvQphU748kVALF5C2Kl46mWwotrMC53Ahe1eK6?=
 =?us-ascii?Q?7ISrsYrVdpxk29EBcP/PdchdjpzJl0fCJ9jbIGgRx2M/9LnBVKv0uqK05oX9?=
 =?us-ascii?Q?z1fDHW2lZOx7y9s15azIu3q0pyPneouzxUno9FuKtoyE81e5J6vnrkTSCGk/?=
 =?us-ascii?Q?Ppeeigjj9IOVQI0SnhIV8wx6dZhKlHdsWZBtArzXL6vnkEzmkOv9+i1ejBue?=
 =?us-ascii?Q?dJotsifzCa8aynPDqMmq/TwMnKVTdX89LerW5+CJIjpJHRki54SHGlDpDpEk?=
 =?us-ascii?Q?6qJxQYusdYLQCAwdn1/Ni64fU9FgtNDc/UwySp0SIo+b0Y2zbOseb2EKw3aT?=
 =?us-ascii?Q?Zn7hNk3PdlcMuiwLBQSzbaY8emoPRTQW4y7Q+QXSbbLK0fdElDLEH2P7iTYG?=
 =?us-ascii?Q?lqwTAwlmZ28NaJqnpWCYilVaiy3m4dLN7LsDyiW4V6Ah44UwFMammAkjNV8p?=
 =?us-ascii?Q?Kz1yEfoTQolVvlDzX9AYGvaweXFXOTIcpxySGfpzQcYL6MZ1HysMZ7oAR2wk?=
 =?us-ascii?Q?x5PB8HkpFzXcqaQzQNnKXchlO0ZYREjp6ELkWQiW9hC7ohuV9+C2T5fmQCum?=
 =?us-ascii?Q?OijLXxQbKf15wGBmlt/5EB/ErCeEZYscCIXsN8LgnJ0Wvpu8OLwqspfneBf9?=
 =?us-ascii?Q?DFmFLe9JYSf1h5vrmTZO1d+T4YN9L3wZs8p7vMvxp0D1Wyw60WgkUZKMXLwm?=
 =?us-ascii?Q?hI1q7+T8B+lxY2W97BIKiXEIVux4zrhWxrKOu2C309tPS4Fg6LqOCCInbn0t?=
 =?us-ascii?Q?nPs28sKCqbMGofMrd+T/umbKWges2ScvxcFFYSeH665udO5f0xMJa9z3R5uS?=
 =?us-ascii?Q?4li9F8QIejQUvCAyYHxiGiy8MriMOpd1lNueOMMaCffAXFVUelkr5iAzzFuK?=
 =?us-ascii?Q?RWoRJhRNVvsrqwV7ca/1Go9Ku07UO0orieCOAEFtVx0Y3Cep1Qo5h5wMKUnP?=
 =?us-ascii?Q?/Fuafn/es5EFjZwkYXXvUhykMWQ6FJdJ7q+zLBsy0hyd/YcJOV2WECGKjkBj?=
 =?us-ascii?Q?/eje/zlBLoVozqIf5lHOI5TcU3cFr0VeyVUzlcqrbZ9oFfqDRKJA+Z/A1409?=
 =?us-ascii?Q?R56R2k4UwJGV2RJiezNrooyQjyKYB4IdjHuKowMOsyYdBajZq3ds9TVtSNwf?=
 =?us-ascii?Q?EwdGShgx26QzOaGjpnRf4bbB?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A6884F882A1E4F4BA6FF2D00E8703FE8@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB6250.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5c7c9cf-9ff3-414e-a7e2-08d8d330b676
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2021 10:42:24.5595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kNhJ1FnNjjZhwPOVZtergV+9DVSfLl7EIJms48vhL40FJDceYKEgJPKvxdhc+2DCSQGiP28o9e25Yb8oonMu+TR465FkgXrlUhi6ikFGBKY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB3178
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-17_09:2021-02-16,2021-02-17 signatures=0
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi All,

Firstly, thank you for your careful review and attention to my patch
(and apologies for top-posting!).  Let me first explain why our use
case requires hugetlb over THP and then elaborate on the difficulty we
have to maintain the correct number of hugepages in the pool, finally
concluding with why the proposed approach would help us. Hopefully you
can extend it to other use cases and justify the proposal.

We use Linux to operate a KVM-based hypervisor. Using hugepages to
back VM memory significantly increases performance and density. Each
VM incurs a 4k regular page overhead which can vary drastically even
at runtime (eg. depending on network traffic). In addition, the
software doesn't know upfront if users will power on one large VM or
several small VMs.

To manage the varying balance of 4k pages vs. hugepages, we originally
leveraged THP. However, constant fragmentation due to VM power cycles,
the varying overhead I mentioned above, and other operations like
reconfiguration of NIC RX buffers resulted in two problems:
1) There were no guarantees hugepages would be used; and
2) Constant memory compaction incurred a measurable overhead.

Having a userspace service managing hugetlb gave us significant
performance advantages and much needed determinism. It chooses when to
try and create more hugepages as well as how many hugepages to go
after. Elements like how many hugepages it actually gets, combined
with what operations are happening on the host, allow our service to
make educated decisions about when to compact memory, drop caches, and
retry growing (or shrinking) the pool.

But that comes with a challenge: despite listening on cgroup for
pressure notifications (which happen from those runtime events we do
not control), the service is not guaranteed to sacrifice hugepages
fast enough and that causes an OOM. The killer will normally take out
a VM even if there are plenty of unused hugepages and that's obviously
disruptive for users. For us, free hugepages are almost always expendable.

For the bloat cases which are predictable, a memory management service
can adjust the hugepage pool size ahead of time. But it can be hard to
anticipate all scenarios, and some can be very volatile. Having a
failsafe mechanism as proposed in this patch offers invaluable
protection when things are missed.

The proposal solves this problem by sacrificing hugepages inline even
when the pressure comes from kernel allocations. The userspace service
can later readjust the pool size without being under pressure. Given
this is configurable, and defaults to being off, we thought it would
be a nice addition to the kernel and appreciated by other users that
may have similar requirements.

I welcome your comments and thank you again for your time!

Eiichi

> On Feb 17, 2021, at 16:57, Michal Hocko <mhocko@suse.com> wrote:
>=20
> On Tue 16-02-21 14:30:15, Mike Kravetz wrote:
> [...]
>> However, this is an 'opt in' feature.  So, I would not expect anyone who
>> carefully plans the size of their hugetlb pool to enable such a feature.
>> If there is a use case where hugetlb pages are used in a non-essential
>> application, this might be of use.
>=20
> I would really like to hear about the specific usecase. Because it
> smells more like a misconfiguration. What would be non-essential hugetlb
> pages? This is not a resource to be pre-allocated just in case, right?
>=20
> --=20
> Michal Hocko
> SUSE Labs

