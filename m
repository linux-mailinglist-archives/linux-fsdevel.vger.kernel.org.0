Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4526A652A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Mar 2023 03:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjCAB76 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Feb 2023 20:59:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjCAB7v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Feb 2023 20:59:51 -0500
Received: from DM4PR02CU001-vft-obe.outbound.protection.outlook.com (mail-centralusazon11012012.outbound.protection.outlook.com [52.101.63.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B346C59F8;
        Tue, 28 Feb 2023 17:59:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OL2/rCrA3+LM7qh9Q32f82eP10rn/RXGYsrjilHAX9G1j3PjHKjWRXL2DG4zHZMuOkNB69rTAfdA0Y6IxQPXtNhzl+iLloLYyhYvDsO0vMdMHx6sE+4FHiZaA2ogx7XyDHlPMXI5lNyru4ulNmWU86Wy256B1k2O8j3WSNnsPdII+KylJv3pdEgVqDpKW0EFFli9WkQrtqvH+70jF59indgARob1Uqle3mqUidTZnaffuXodHoXWK4+rKTv7qsm1vbUt/SHjZy9l0uv8Tx0LuUDbb7QIBrh2mu5oZc6ekDbrhJUhJ+2Ndmv4bw9vQmzmVZ9XnpUPF25V9APfsdZdzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WnIN6hy/k1SoWen0k8YKItmW+p0Kmv6BCccFhJWsfo4=;
 b=KiODm22GiW8gxjH2F6eCeKlsHsbwCcIai7tT1M3S4o/+0stM9UtiIalyaDKo5WD5lKsTjuHUyHOhl0ObTgln2ictrTO6/iM7miwXPZfVBW4llNrNfb6h/CvZYUv0kqKl0NHsQpTBwHxCWmYqqxNzslC5IrAZqrMTT0UXGLLFTDKaRiNlRxOtjeJyDY91fS49CJsrqiYqVOnk9QmgZaQpEqJ9yI/Ut4EH1BzDu1qLqU/5DzfcHkw1MhlTQpYAiTFN1jlCnMTV1jCpbP7rvZyVLqGakIbeKRRo4e65ffu0cdpwYnavRgIE/cOuCypJfAEYIuS/MuYJEiTz8kSBnX+82Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WnIN6hy/k1SoWen0k8YKItmW+p0Kmv6BCccFhJWsfo4=;
 b=oDzctY/SL0mgCFg7LhzP0tVW5Knk1jj0Pde8Ozxd2NDCJ/rkYb4z2aj+rmPRGG7rjm1bRq2SyxgKfrqy+x00UNV7yBSs/zzSN0X2+/aOV7YVOSlgYkyvrtCnWREGc99kWQ5zH8d7lo5kpdw96aY4b1XQS1O4joTI+MSQLrrmhBw=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by BN8PR05MB6386.namprd05.prod.outlook.com (2603:10b6:408:5c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Wed, 1 Mar
 2023 01:59:47 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::e9bd:ef2f:b71:8084]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::e9bd:ef2f:b71:8084%3]) with mapi id 15.20.6134.030; Wed, 1 Mar 2023
 01:59:47 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Peter Xu <peterx@redhat.com>
CC:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Mike Rapoport <rppt@kernel.org>,
        =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <emmir@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "kernel@collabora.com" <kernel@collabora.com>,
        David Hildenbrand <david@redhat.com>,
        Andrei Vagin <avagin@gmail.com>
Subject: Re: [PATCH v10 3/6] fs/proc/task_mmu: Implement IOCTL to get and/or
 the clear info about PTEs
Thread-Topic: [PATCH v10 3/6] fs/proc/task_mmu: Implement IOCTL to get and/or
 the clear info about PTEs
Thread-Index: AQHZNvnMjIrwR8b570Ch3VOm2txWlq7WZLkAgAGKnwCAA4VRAIAAyUIAgACnuwCABo50gIAAHuYAgAEZQgCAABfigIAAJGaAgABsdQA=
Date:   Wed, 1 Mar 2023 01:59:47 +0000
Message-ID: <99887AA3-8023-4462-A870-995A47383175@vmware.com>
References: <20230202112915.867409-4-usama.anjum@collabora.com>
 <cf36b6ea-6268-deff-d9ed-6782de2bd0a7@gmail.com>
 <2fe790e5-89e0-d660-79cb-15160dffd907@collabora.com>
 <751CCD6C-BFD1-42BD-A651-AE8E9568568C@vmware.com>
 <c15446c5-eedd-690f-9dae-2bc12ee9eb78@collabora.com>
 <F73885A1-14AE-4820-876B-A8E6DC6D19CC@vmware.com> <Y/0eIUIh81jK9w2i@x1n>
 <5D5DEEED-55EB-457B-9EB7-C6D5B326FE99@vmware.com> <Y/4j/Nu1vp9sVI7N@x1n>
 <C96B273F-31EE-4784-A614-B03DEE680462@vmware.com> <Y/5WjdXJ+56Kud3u@x1n>
In-Reply-To: <Y/5WjdXJ+56Kud3u@x1n>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.400.51.1.1)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR05MB8531:EE_|BN8PR05MB6386:EE_
x-ms-office365-filtering-correlation-id: 1c21a32c-24de-4cdb-370c-08db19f8a29f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0A70Kwl4XF1TN0FrUedZOoyg5sVQHgsOHIO83fRjz7YDz9tVCEgqCjy083U4/Mcv95rWpnIKjq/hmx+hkyA2igjSqIJVisB8qf6DkbLGaslvVZa10akQyLIDP9JUlZBkHCQrGv7xHhQZrFtYlFGnrJhI106nBZkpiOQjeTopF1YzlyY9fbeyHOahXoN/NdGoKDsVAarUt6wMOiIXdWQF/JaMLvxm23N8e47TrVfkANxVN4Jhtew1wu/lRA5Jl155ARChHosyFfzYCLCTq7miqc5p/nq95BGfD1e2qCFpHmE+uxeEoqxTwLm3o8puL4AX/+TZaChYN8m36khYmxQQhqhTgPUaTDU9HLQ/0OqOPxEyVJ0SCjEBh3I0xWQQ0FJvfTPnaFd64yULpUQiiBHZuefLyG12LwaCIm69U7cwz3i7vwo7Ylh8I55rDH9aErEmC9HhNr6Jw85IvIetdbpg5qvB4KzX6hf92VLuHcVPuFXi9j7B+bpJpLmGMJk+63cV55QhpHm5FvCaEDcuMdltPoJYA5dUdIqYcxDG0mhRliuLA6/pp/H/o98Fw2K6FL+1qFDOxW9GvTEQqoUE9UmPUQU4a/GSngL5N7q/wD5eDLPxK68MWG25Lqy2Ozzrc9Tl4RdZ5fDbprxrU9JmAN6Ou8Fkg3Nk1KLE7wvAKlNp6F9+jRxrYFt0caWC32wfobFIDj+KOmovJ73DMLTtasxpvHiMhV0odQL8nFZORs4YMztWYIGhkVVcIYQIwhS68unXyUm1HXQz+vlNDEad/6kKqg1G05A+iPxDGXDwJuH0KA4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(366004)(376002)(346002)(136003)(451199018)(6506007)(53546011)(6512007)(26005)(186003)(38070700005)(122000001)(86362001)(36756003)(38100700002)(33656002)(2616005)(66946007)(6916009)(76116006)(64756008)(66446008)(8676002)(66556008)(66476007)(2906002)(71200400001)(4326008)(5660300002)(8936002)(4744005)(7416002)(7406005)(478600001)(6486002)(41300700001)(316002)(54906003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?TXdvJdQuZxbX9TqEro3GHy/wNxV2rNvR1YU+WyPLaEBDyxl3mU/yCguFMb?=
 =?iso-8859-2?Q?bV5paKdiQLZEj4wOCMEnYNcqANYeMZtlpxRxvKA1SlT8BflTN/eoQtFhpI?=
 =?iso-8859-2?Q?eRyJP1mlR7w0uF5b3YJigDuzJZQGkAC5wgwRrP0BkyZXtkxN2f/CiVKryq?=
 =?iso-8859-2?Q?5olkpp5qO/0Ccsz0qS27jOvDhPoZs7ZVImT9o8ZWNPeOuWDk/bGTXm6Bcv?=
 =?iso-8859-2?Q?GWhVUeFj6d3XV/36lDl/Oa22J+PxxJBTQL46LGnOU3nG+ziYMPEZyx66uY?=
 =?iso-8859-2?Q?Dy1TigCainQlYTzOK5VNFdUoBrihgm6LW4qGdET6e0lO0HaFG2cWlwHGCa?=
 =?iso-8859-2?Q?WGMuu8To9wT3NJmDJVIOVzqFvvqK96QEnJdPfHnOkwER6XbMDnfzHevEFb?=
 =?iso-8859-2?Q?sD0kxOMumdGd0f4WPBGnt+R4XVc65pTOAoXP8jHSXCYegX6DsjhA6QjvOG?=
 =?iso-8859-2?Q?zUTFHFViP/os6I/Kl5oOHa41CHtXtGnvpWB0B23kIzJsKXIMkfDQYF33tW?=
 =?iso-8859-2?Q?MzareQ+uWhlP1egC3TT8fIpGi/AuCtr+hv1ayhgteDNNsWOX6GGifmwwKy?=
 =?iso-8859-2?Q?8X5rnmCuHOBE8UxT9rVwUaSk+zoQc58wYU7Siw+HM5E8EjDQ6F1sPAMx+d?=
 =?iso-8859-2?Q?La9/viBfzrAWsjHTiLX4cG3dAkkpWVnHE12xYvvy59qNLGm6nBJ3g22P+0?=
 =?iso-8859-2?Q?9cLAfUqEzqsVLIPs3aGvZaGOgxFxgtkDiTDh9+MmnBF6mVbHEA9nPou5b0?=
 =?iso-8859-2?Q?e7aM5cxt2YeJufEaXbfzMVDihF3nR0RIbuhp7ThZ/GMRsiFoTTC2HwYrml?=
 =?iso-8859-2?Q?jyE8EzixHmQ0Sy4ddeRSgIag7u2hmL2XnCl81BBtf/hEdpR1IHeaEGOLrt?=
 =?iso-8859-2?Q?J4G5vFMxuiIge+9TwK3q1v5ovxdk8OIIBFCvlhXNhtWwyT2X+9a8sXoxQx?=
 =?iso-8859-2?Q?hFkH+uR2a2k0In9wfrifkGAaYP8MA1OtHrmXP2vK6zCw/XScV3R+dJmQjR?=
 =?iso-8859-2?Q?3iNSfFDT8juRmbRPHSljeOopasfoqVz7o+CmYav7K655QlOmkgYtmVTMck?=
 =?iso-8859-2?Q?XRxdCOCgpPqzQItlkvLYcENrx9uLgGznXhP8HCjU15QPG4YZE1Tj8O9eAW?=
 =?iso-8859-2?Q?08xNTeF2n0Sp521u6X9fQ6m7pgrzNhD44r7ZGwFyx5cQhrAZNWj3/cr/k2?=
 =?iso-8859-2?Q?wW/OsUeZiStLta6YeLY5kJZDnVr+6c57NwzREOUuaIHGi6U1MeWhh6nna0?=
 =?iso-8859-2?Q?CAL41iVhizObgD2W2Ln0hJPHZEi4uyOb2HoCgziE7kacCS3ZLy1Z2sSVMh?=
 =?iso-8859-2?Q?jnUfH3BN5WpspbkIVNvn1Tr7JE5BZon59gqQN7ae5PjeQ+j+L9+20Gr4aE?=
 =?iso-8859-2?Q?LHIPR7QyDs8AmD9PAC/U1W4dff1ldMgVnxD4aVRjHVE79j1TuY0pUYsxec?=
 =?iso-8859-2?Q?7E6zagwMJdiiy3x2UAW6yO3SgZA6JhcEm0tubR1cDZmoJs/gVMktosSxpM?=
 =?iso-8859-2?Q?eTwODuRuLCuEb+sFvSgOpuUm63M7UI8z2o+I83y/vzZ0WV3XCy+bKH2l0a?=
 =?iso-8859-2?Q?cYpmndWGX31mAYDlq7BOTFyPVnO8MypXUZkMmD4fy/q7+G+oTGOiNAMj2s?=
 =?iso-8859-2?Q?eNzmSRGZCfAlH6822Sg1I0TD0kbHrwzJfR?=
Content-Type: text/plain; charset="iso-8859-2"
Content-ID: <D534370C7D58CE4AA4DD6F0B2AFA0DF8@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c21a32c-24de-4cdb-370c-08db19f8a29f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2023 01:59:47.3515
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uAQGg0ejTCd0NjceXiKDWSDkE0QcAo8L6DBrFuS7Wv6E8j0t05fMzaPkqibTF6CW5CfVJjYkViZ1o+j0AhrwMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR05MB6386
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Feb 28, 2023, at 11:31 AM, Peter Xu <peterx@redhat.com> wrote:
>=20
>> Anyhow, thanks for all the explanations. Eventually, I understand that
>> using bitmaps can be more efficient than a log if the bits are condensed=
.
>=20
> Note that I think what Muhammad (sorry, Muhammad! I think I spelled your
> name wrongly before starting from some email..) proposed is not a bitmap,
> but an array of ranges that can coalesce the result into very condensed
> form.  Pros and cons.
>=20
> Again, I can't comment much on that API, but since there're a bunch of
> other developers looking at that and they're also potential future users,
> I'll trust their judgement and just focus more on the other side of thing=
s.


Thanks Peter for your patience.

I would just note that I understood that Muhammad did not propose a condens=
ed
bitmap, and that was a hint that handling a condensed bitmap (at least on x=
86)
can be done rather efficiently. I am not sure about other representations.

Thanks for your explanations again, Peter.=
