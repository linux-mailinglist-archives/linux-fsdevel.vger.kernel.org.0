Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACFE57A8B2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jul 2022 22:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239777AbiGSU4n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jul 2022 16:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233195AbiGSU4m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jul 2022 16:56:42 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-centralusazon11013000.outbound.protection.outlook.com [52.101.64.0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3690145F7A;
        Tue, 19 Jul 2022 13:56:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KQxBsgUHgaGva8sIl0ZSY2pXjSP67XJfj01bcKaXtno1Erodoq0IBrvoSvfeSfwxBB9w9JJi5rE+y9BAl/3angeg8iNEVV58UhMeUVMC9aXrmdxsATFXoWwGcQttJSjfN5PvTSejeuY7QzbRr9/yb6sqUgFJ49DErYdl7Bl4GrtBIDuC1kuabbtGy6u4wmThdpSi7i7kZVXaKWFTx0pauwOa8nlXHLlGfyQFFwAyGqrGwEBqUY/KVzZhDCpsNMK5/oBrmqxjNBesOvLF3XEXCOujX+H6qvHRytY4SH4f1dgpzRuM6eOy9JjiepaV5e92T21xhEwC4oNbl48ZO2BmCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aqOpkjN7RcY7etaEejGkajjnIMX8cHSg+MFU2XJzgxo=;
 b=hQAweGeM08aYx4L8Tu0tfNNsWPTtf38k3qBHfnE8RFKDpqSW1Y5edA2Se3RaElB8uNkSfqUgBs7zXPW5QHFm+sE+F/V4Sg6CGEvgRE32GmLRz/ElZ5ema6pGahXogaziAToa3xErfirpjPqZh2cZaNmxdaQz24QEWiiTaSW/8YjqAc9mLN5DLQ9PmV9ongszRkWMVhMVgPbD5aDnBi7yvP6Jwz9Pkx23xTPw6IlCbtMbdfmqZ35So2i1MCkQuwu8pZarCMoSR8rTrWcQ7plbuStXrAecVNlm2WjcL8FYOpgJ9LOO0XS0ufWQygPAhJe+bzoKe30eMDptU8fm+rxGUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aqOpkjN7RcY7etaEejGkajjnIMX8cHSg+MFU2XJzgxo=;
 b=MVLpMi0swlt1p4IXkbOE2B24MLQM5lvswfjTFc0KRxpBlXKnlQYdRMNP0ICQAbT/aa/M6VLqjMVdg+I26HAl6BtcNxJ33Xw6/8S+rJXtxw+rf59ByoLahoA6U//VaFpAiAT83eHmI4ZMltCb0/J/WUkpJt77FnjruYwo0tNnDs0=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by SN6PR05MB4685.namprd05.prod.outlook.com (2603:10b6:805:98::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.11; Tue, 19 Jul
 2022 20:56:36 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::d813:9300:4877:39d0]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::d813:9300:4877:39d0%7]) with mapi id 15.20.5458.018; Tue, 19 Jul 2022
 20:56:36 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
CC:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>, Peter Xu <peterx@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        zhangyi <yi.zhang@huawei.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linuxkselftest <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v4 5/5] selftests: vm: add /dev/userfaultfd test cases to
 run_vmtests.sh
Thread-Topic: [PATCH v4 5/5] selftests: vm: add /dev/userfaultfd test cases to
 run_vmtests.sh
Thread-Index: AQHYm6mvzpF6bpiM90aPwCYm0In9H62GLLyA
Date:   Tue, 19 Jul 2022 20:56:36 +0000
Message-ID: <6B7CAF01-7711-483E-BE57-630150407648@vmware.com>
References: <20220719195628.3415852-1-axelrasmussen@google.com>
 <20220719195628.3415852-6-axelrasmussen@google.com>
In-Reply-To: <20220719195628.3415852-6-axelrasmussen@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6fcc13f5-dfb3-4341-048a-08da69c92ba0
x-ms-traffictypediagnostic: SN6PR05MB4685:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?us-ascii?Q?J/2lqxkI9f+/uhw2BKqfya4BrqW35A6O4JTrex+eP27cC/a63igeQdP9t6P7?=
 =?us-ascii?Q?+qU2nyjuBlKiiJzGBa2rJ2x1Sa0cbHqLrvfHRQi+E5bOPNjyv5oanJ/v8/H2?=
 =?us-ascii?Q?CmRV5/qH7BAymYfDdAZ7UzkgI8bmvEI++c0ZTOBG1jfZ7FOCBJG2yBc3aANY?=
 =?us-ascii?Q?XHhIG8KZ6MttquHRimyc6iDaSnWcB543/a80OYj8zYSJ4RKco0o7al5rFJTS?=
 =?us-ascii?Q?+nfKR7BJ2NsbxXUSIGssn7pnGHmZ33s4IIuPJWr6Q/5Qp1K0d3ay9XgAeRfd?=
 =?us-ascii?Q?nub0hWu5fz8Vv0+TT4vZneXjpTqf7DiLJnJRDViuYdDvnRkhRShKzfXMTzMV?=
 =?us-ascii?Q?mN/OW0+2/pDRAN7IccTJXjmDJQZw96XVTiRKiAZuXbQOVmuYzym3Jh88eaTb?=
 =?us-ascii?Q?vUoerPn2YgSUJnPkoM9PVInFfVwXeCM5FNMyX55gXJ1X9PkuaqZ04hLkeE3g?=
 =?us-ascii?Q?thZMclIaZ9FbgCDeLhv1Vpf6ukdiJnUgbZQcAXofx1E86qqc9kuvuGoMETGn?=
 =?us-ascii?Q?NxgfrNgixjtPongB4UPkPQN789WmQBwgDAIv7IBflfnxXaa3kuFtlpMfp1vO?=
 =?us-ascii?Q?f5pGmuOjeBnvYsq+HMCUKOFsLRNul5ZPsysyC2WnjlucvFpRnTbveT+jpvwA?=
 =?us-ascii?Q?av+5DyZedfw8U2gXF/Ah7qrZOaM7Cobf4T3DjCYssoXnsnJEEkbyyQWCzNkY?=
 =?us-ascii?Q?ktzssglMzwMrJD163q0WJPtN8Q3UD61KeqYeRnhQvZ8x8p11TIOwrgEuyyqu?=
 =?us-ascii?Q?Yd7Qh6FZH/ZDSDcV3l9vGrJMpf6dM9OE4rkImLD/amUzV8jIQa19DbjWvUjd?=
 =?us-ascii?Q?GgzWYVYAJ3Mp8fKLcdY8Ip1tBxJrlAQXPmZfP+axO2xtfmkm2Z1XGcoaWIN/?=
 =?us-ascii?Q?jTg9Wp5IcgRNQPz7x+TdB9CIzs7TwXcVB2kQgJBKVmOCnOp4TpQkxEyKD9xf?=
 =?us-ascii?Q?v3tTX/yLonZ5EQA4vQaO+A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(5660300002)(316002)(41300700001)(36756003)(186003)(6486002)(66556008)(54906003)(6916009)(53546011)(6512007)(2616005)(478600001)(2906002)(966005)(76116006)(4326008)(86362001)(64756008)(8676002)(38100700002)(66446008)(122000001)(66946007)(71200400001)(26005)(8936002)(38070700005)(83380400001)(6506007)(7416002)(33656002)(66476007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tHYjYGf7Z49zZFFu6IVspLrsuDYOXtNS/KM/baS7NfArK+RZM+s+qM7qD+7S?=
 =?us-ascii?Q?gfIlh1QYXSiJ2b+WS8M4UBsGMBi9yz1Wc/tt7P5ML6QVpIvT49VdzaElXT9n?=
 =?us-ascii?Q?CK3JO2YchSX7fhltRcKjgWIaivqfxa+JpnSD6H2spH6Px16Sm3s6lb6Mey9w?=
 =?us-ascii?Q?qK9O2op89kjVZU/2rb6QmCoisulz1q5B2Vws74a3GFO28zILF17tp7+qL2Be?=
 =?us-ascii?Q?FOq9WjFkdBqxxsgkN3xEAgLA1/sYQV/Mk+/IBimdC61Zm05XRK/RNvNVloUH?=
 =?us-ascii?Q?b9DSKN+88yVMywsWnEBmnfYQN0lYdQjbstHWW1cH/+1pFVeR7pjX+TznKalU?=
 =?us-ascii?Q?DA61a8LjJHD8Cw5HutZMpqWZI7EyqstItauQNWnm1a59bxYwXGL/BhnEKZV0?=
 =?us-ascii?Q?h1/AnxDJpAioVqVyAbvqw+hhzYofJ4yXLwwDct2c5gdWwkC1u97rFI2Fsjjw?=
 =?us-ascii?Q?XOdJhBTQ9DJs24laDHgpTcIYUl8BpOCaUL/pp8ynKpq/wKMVX7gkWiwb0I8I?=
 =?us-ascii?Q?sFUf6/QrGsQZWOICjLxCWqEvTvXbTfOH3pzcQZSy6C6Y/Xd1SBsTZBac8nJV?=
 =?us-ascii?Q?g6wTLLAJ6RuJlmNW3u2CazseHDG4zW8gAZmX/8fWRfEljgzkK0ZNFE0U9Tbx?=
 =?us-ascii?Q?oRfk+KygoNHrVRjZDt5HkOgejxbiGZlKIjBrR3Ne3zZois9aBKYcTb4IP4Ny?=
 =?us-ascii?Q?Ep/3LMJBmoAx+7JQ3rF/phXmwfAPDM4g4RPV1uN8wz90l6043c1SOsEjky5p?=
 =?us-ascii?Q?MBNn54qYfOmajHkl8y6m/uiwp0UoSTzyWDIDljXjvRGPdY7VFgtZQa2Gq5QM?=
 =?us-ascii?Q?NrXlAjtoOIicQg1NozmFRBBNMVhszaomFMCTC12qXTwG6H8+bqrx2duDKuYl?=
 =?us-ascii?Q?+xqhmUtIQvz3iwR28LVFuFp26xj3jKTwAYHbZRem+vR4SylC1iO7Y7wYswyW?=
 =?us-ascii?Q?9KPNTtpoKAZB26J8DuczqvzOxz2BM1zKBE5vDC/GFiijJIMHhXrfWnRDVVRC?=
 =?us-ascii?Q?JIMnqFKrZzK03wg320QY4BVoQXx/oaFuzEvAS9KeIYELlmNhSbWFFRv6/9Zf?=
 =?us-ascii?Q?Q9bSS+xOWaxyY6J24xZv4yk0OGygu1oXXGfFI7j36oCWoo8SnFAyQV0+p7NB?=
 =?us-ascii?Q?yoqDLOVgU+FZbSliB/3z8k5q24EAUe7DJxwd0NR/Wfz9bjLbhkjnZU3IODFG?=
 =?us-ascii?Q?RxdTPecQXL5VCyx1T5qtzeTBzQVg1kcPZAQGUBjZ834twqHMohkBN1MAbo24?=
 =?us-ascii?Q?yCsS+EwuX/1hnQ4VLF3MFaHMrTsMMiTFzDE68gNbNszDbQdDTQ0cCRNiEdG0?=
 =?us-ascii?Q?V5lOqC+iuL+VmQUqpZCfIvyoH7oCNnmvcji1Gclt3v+nyGEVE1IXrjFMUFPm?=
 =?us-ascii?Q?lKvgbkwKuGydqtplWoBucI34QtbZa9qHOw2NzHOTLv8+x/gubY9MXUY9Qi13?=
 =?us-ascii?Q?4cS799Vu16kguYzVEolo3OBFlDZo3O1SmJokFo2aQdCh20rohoFBJPh1sjXF?=
 =?us-ascii?Q?mw0RGuijbGGKwDr+4RSF0OAHtkPMuna8+5HLhT8d0V9ApOoXRU5ebBNDBc1P?=
 =?us-ascii?Q?u+F36pt4fzqs1vOtMteo1L/csJZHdzKKVY2glXsp?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AED34CA9925D9C48967DC7A4E99266EB@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fcc13f5-dfb3-4341-048a-08da69c92ba0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2022 20:56:36.6971
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K0OD650ubvU4U/2uuNR9WksovmHmiv2ClbV4oi3QYqEiYtS7JdUZVgPaUD8BRvg8wmgh3VhI798G0KX9kPWWOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR05MB4685
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Jul 19, 2022, at 12:56 PM, Axel Rasmussen <axelrasmussen@google.com> wro=
te:

> This new mode was recently added to the userfaultfd selftest. We want to
> exercise both userfaultfd(2) as well as /dev/userfaultfd, so add both
> test cases to the script.
>=20
> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
> Acked-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> ---
> tools/testing/selftests/vm/run_vmtests.sh | 5 +++++
> 1 file changed, 5 insertions(+)
>=20
> diff --git a/tools/testing/selftests/vm/run_vmtests.sh b/tools/testing/se=
lftests/vm/run_vmtests.sh
> index e70ae0f3aaf6..156f864030fc 100755
> --- a/tools/testing/selftests/vm/run_vmtests.sh
> +++ b/tools/testing/selftests/vm/run_vmtests.sh
> @@ -121,12 +121,17 @@ run_test ./gup_test -a
> run_test ./gup_test -ct -F 0x1 0 19 0x1000
>=20
> run_test ./userfaultfd anon 20 16
> +run_test ./userfaultfd anon:dev 20 16
> # Hugetlb tests require source and destination huge pages. Pass in half t=
he
> # size ($half_ufd_size_MB), which is used for *each*.
> run_test ./userfaultfd hugetlb "$half_ufd_size_MB" 32
> +run_test ./userfaultfd hugetlb:dev "$half_ufd_size_MB" 32
> run_test ./userfaultfd hugetlb_shared "$half_ufd_size_MB" 32 "$mnt"/uffd-=
test
> rm -f "$mnt"/uffd-test
> +run_test ./userfaultfd hugetlb_shared:dev "$half_ufd_size_MB" 32 "$mnt"/=
uffd-test
> +rm -f "$mnt"/uffd-test
> run_test ./userfaultfd shmem 20 16
> +run_test ./userfaultfd shmem:dev 20 16

Do not do it if it would require another version of the patche-set, but
otherwise, consider using a loop as I did in [1].

[1] https://lore.kernel.org/linux-mm/20220718114748.2623-6-namit@vmware.com=
/

