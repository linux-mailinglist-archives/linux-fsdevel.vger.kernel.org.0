Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B6A56B703
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jul 2022 12:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237238AbiGHKKp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jul 2022 06:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237157AbiGHKKo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jul 2022 06:10:44 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0FA83F3C;
        Fri,  8 Jul 2022 03:10:42 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 267KPfDG014010;
        Fri, 8 Jul 2022 03:10:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-id : mime-version;
 s=facebook; bh=ZCf7yjkfb7cmpT+Z7Q+1fDmikXKNlMwYBGALHp99nyI=;
 b=ev0ceic5gT9zAeyZibiKuHBHMo5epNaY9xdPrFqjRGFaLeN4YiVcTWFeZFbzdnC3tAKH
 EtKJWBP6OSAQH5ArCDKtfGrczW2wBm9aY8HxnRw/SO1Il/6576r/3vRL4m4j4XetIcSF
 hcFHAMwVVO03ooV5IBdXYTcN5vfbvlPnN1I= 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by m0089730.ppops.net (PPS) with ESMTPS id 3h65q4c01x-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Jul 2022 03:10:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F8UlsiVwuZfIqVcor8b16JKlKcd47LXkqN2hXojJPJl8RZCNfRYLt3FUpVSVHFYmBA+59nhlfr7402+OJ9shSw4LHt57KvIBM353LeqCRsQLbhNtNrVws0IYfghwLPbAyDm1nliQncSgJxMh2fpqdMq7KwbwYIEUgDa0sRtp6lHGNKIUMbmmOEgfop0aVJNsMwjKiKQcJBqikx5gS0vt9aeL0fHIffZrk7TTLjZmOKHvga3bj9spKx5YtU1jZmwV7egwPM5Hn9RyZry2W4AEoQe4xEVSg9V78ubcG2ku/v85iSVT5ZDt1Siu4lIcrA22B3JnJDwusCpBoTb+bpt0/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZCf7yjkfb7cmpT+Z7Q+1fDmikXKNlMwYBGALHp99nyI=;
 b=DtwRSjCSDfa/Pwx4R3UnOXzs3VFDXuiYPzpUS0eQYBC0N+5zL3slf9N+vK77HgPGnzqfBkiVmrqSAkQxhPQciZOUNuDd+Ayz2pLUEtfQ05cB67jFgmBeWFv7NDjUIOGReHwqw3RUIVhuvofVzoDU18NozRRL8CMsnpL6+7nXLUEora7816skwPQXVv3nCGx+Y3BHx/s1KC8KcvnEsEZTFx9MjcT9TblKmIvvJgazkofMuPuRphWZI/almqs85aCuQ+pwV8XoERKaBIUBanCINIgGxERKjBHOVG4fVhCoikfU2ONGImT0UWVHD/cROfZu6JgZvkU5uQxwmVlxLUxSEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com (2603:10b6:a03:379::12)
 by BYAPR15MB2501.namprd15.prod.outlook.com (2603:10b6:a02:88::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Fri, 8 Jul
 2022 10:10:37 +0000
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::81f9:c21c:c5bf:e174]) by SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::81f9:c21c:c5bf:e174%8]) with mapi id 15.20.5417.017; Fri, 8 Jul 2022
 10:10:32 +0000
From:   Jonathan McDowell <noodles@fb.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>
CC:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Dmitrii Potoskuev <dpotoskuev@fb.com>
Subject: [RFC PATCH 0/7] ima: Support measurement of kexec initramfs
 components
Thread-Topic: [RFC PATCH 0/7] ima: Support measurement of kexec initramfs
 components
Thread-Index: AQHYkrL0bI78Vrzdvk2Q1fjMWNCY+A==
Date:   Fri, 8 Jul 2022 10:10:31 +0000
Message-ID: <cover.1657272362.git.noodles@fb.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bccb4a6b-91c6-48b0-d00a-08da60ca177b
x-ms-traffictypediagnostic: BYAPR15MB2501:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vboo52q49f/1MzS2KJBKcYo86uL6jP4uxypqWQZmCFUZR1BZRT8zMCCqDAMF/e1zLZ8Getf6A5JAZfdR/EiQKbaIe9ZA8smI78ONy7mzmVzeUlyYQjhGe5YrSG/68mfEwA6OQjIqTvot9D/iBjBomYiv7rOUwhIQcGVZovzw/OLYNlJqJRR91ZWOvRek21EmGz11SIN8Uqvq+/xsc5gHpWA5CPoU/NUymGgYgzlpSAAki5wcaFq8CezmUYf9ecUDb0pBLuzOC7Qlz/EQney9M7D1C7Cj7j80WJDNwNb1TNuFCRqC39cjtbHSKDlEerpeIdmI58A1/TzlhmMQ/lbkPJbhrgWrryqs7JIeUadBcjK9ViYYi+nzFDEUMlin5KznwcBP5uY0/i9XlZZD25tafOs5+R0XG5KVeJBMBptSUi4xd/woYyQS91R3/LNcqqWPJ0+qr8C0TuoQ2v2+tRXIblAXxs23fCnmgjPu6+2jMcRjn4uTd3NJv6TUiNzYgWwxYVVxs5hzobdVH9e/a8Fo0t6fOLpfTlWvYDQwJhg3Bzaho8RN8WHfNKdEK0maqqtsFLMS/mKqkIgOrvGlhrQppXu1nKW/+vZfFgDceWh4vxx9NIR+JIOgCBQzNvZXqLW2ELbA8Y00x52E2hLA28KsCps7dlVbgSEysqwRF6Njn9IkGlHff/O5OSNPPMLPGJ5yvzCB8o2Ap/vGlNSzbrc6sqK7aOCaJdOyInSsrY7nQQAeh3fxDvWlViW7Yx66bYzwPq0TSKEgvUkMhhss1Q9Tci2gBf7OziBVzM9XLXRkkfuCNTmrS4MVKXtsjjUkFnUH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB4552.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(366004)(396003)(136003)(376002)(76116006)(91956017)(8676002)(4326008)(71200400001)(64756008)(66446008)(66476007)(66556008)(66946007)(38070700005)(6512007)(26005)(186003)(6486002)(478600001)(6506007)(41300700001)(86362001)(54906003)(122000001)(316002)(38100700002)(110136005)(2906002)(36756003)(83380400001)(7416002)(8936002)(2616005)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bA9or70QQ00EOEdVQq8+Z9nHgd2J3ozeGRYutXWrsdCZaKXvQyApoSyPoV70?=
 =?us-ascii?Q?YfjrVTgfppL9blkXInXM4L9FKBY95MeYhjQEvkVXsDfGS924DilDpzr4h5yh?=
 =?us-ascii?Q?AcZ8HjG9b/F8enegQZ1zqlJA3g1xw6X+EbADmVa3oeF7rt122vPPKRFhCPAr?=
 =?us-ascii?Q?pJrrcnUfRDBiPQKbFXOnbF7sDzbSoOd5BNf3O0adjqZOXheItAJtd6Uz7kjj?=
 =?us-ascii?Q?umu3zaWsxlVYli5eqXFzogb8JmBbBI1O2dvsp4sH5T4nfHgfB8Y17UWMLXXi?=
 =?us-ascii?Q?3PX2gflHyAKBfpDS4ouTUuzb8fo1C6fO9rtzKTJ6MVmL3va9wocALOQ2X0Fr?=
 =?us-ascii?Q?SgPleTwB/30iXmQ4a72PpZTqUfT1AVb/eZJvP53LKtUcogeZZQ27pl8M6H3L?=
 =?us-ascii?Q?B/4185wGbBcoOvatAGY+lgUCJd0LfVqoCmbSZ3rADvqkuWJ7cVgtbypZtevK?=
 =?us-ascii?Q?Iu9tHuxTIoULq1pbGA67Bmp6Vii/nRxqO6QdwCV389JQEvKcMr6oUjESt/AL?=
 =?us-ascii?Q?uG/ohk8du0pi+cNZ1zserlRFMezEMW/cuTJHVWGTD9mPUllSSYtzK9V+UtW/?=
 =?us-ascii?Q?SX3Svos0ddnAWhEoVM3zr8GfOm4z2cKxFeta4jptsXIipIjD3NQGhz01G9eW?=
 =?us-ascii?Q?i4FNbVcoXq/t+Uiy+J1m6WzR90bORANFjJ4s80tAuBi5QStpe1wlUsEz6nap?=
 =?us-ascii?Q?m0KlsawOgTfEH5waI9xr4eR3W2yZyCuUdjwdZHsY4yIUpBjpk5XMyT0GuE6K?=
 =?us-ascii?Q?gqIFd0jS56Jkczj6IlfgsYzsNNgFJgbSAGnFu2bfwZH1OkjlU9aO7EaIRKeZ?=
 =?us-ascii?Q?F8hZVmcA5MsAiS90Ei1j0TdAsudSTKuXtr91s706FiEnT0zB77Uvu1lI1TBw?=
 =?us-ascii?Q?8Bh9n5EMzP5p9C86kZDT5yMgMZdsXqJw0Lpro//47B3emtOGLSuwjQvKmxTF?=
 =?us-ascii?Q?fcEWR89e/LQHxUKw792n2Fs2WTTwm/Unxf4CEBmYXfzCQFSrYuSgiVE26g0S?=
 =?us-ascii?Q?TQjtvJpwctpKvC2zVCe2pvhwPs8oZI1E09WWyympJrnk289bY56+RPkWnVP0?=
 =?us-ascii?Q?hwPPSLyXt2ydVBbxpsbUquyzoDKIzZEnBPtIhaYn/HuzIn8NB3i8aUyBj4Ci?=
 =?us-ascii?Q?dDNQwv7c/89QFuXi5dmRwOVF7Mzz3rHv6NQY4cn0Rz6ukbzidtLn4YYjSSXj?=
 =?us-ascii?Q?EXu+Q1KU7pHePyHKdi1WGKSPz6/cTYVW7S3iHJbMpuI9HmgE5K8FjN+nojxD?=
 =?us-ascii?Q?cBGmHnAbDx3Hha/NFnOv3bowAnHhZUkOVaprIL9C/7kBHt+gUwyV8TSt+lBY?=
 =?us-ascii?Q?yEXU/RvV7j2P8+mStdsbkGsqDUhlozdEyGejXldDi1nh7HSOowbL7SRl8WL0?=
 =?us-ascii?Q?wNMHTQW9t9ZuNwNGxu7hlGzXMnnbYNXe0wofpR6BJwHxYeHIAqQiQ+/Z/DT6?=
 =?us-ascii?Q?eHHWuPjivkmZkb+KLouI/MpwsW6DzarkQSkrWzzZjQ/2Fa48TIuF6/Gk7MPO?=
 =?us-ascii?Q?+Ga5xm2iA6PwxW4ktMVFZZaHLDJ+pg1QTN2+/4Oruxzf1DvzhHwIaNH8lkix?=
 =?us-ascii?Q?N81VzTurjeklWCx5VrNLP2R7Jjsg7fKxl2NaOURL?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <32F104F1860A164FB30C6B1FC06767B2@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB4552.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bccb4a6b-91c6-48b0-d00a-08da60ca177b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2022 10:10:31.9371
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s2+PAMesEH3l/H8grBPdmtCYh42kDwXnqRlhhlIzHvTCeQqfvtHkB7bjiWYavhn1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2501
X-Proofpoint-GUID: gmQyIgfJSG6TKYX_Y8nAHSmHAs5HiLUN
X-Proofpoint-ORIG-GUID: gmQyIgfJSG6TKYX_Y8nAHSmHAs5HiLUN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-08_08,2022-06-28_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patchset is not yet complete, but it's already moving around a
bunch of stuff so I am sending it out to get either some agreement that
it's a vaguely sane approach, or some pointers about how I should be
doing this instead.

It aims to add an option to IMA to measure the individual components
that make up an initramfs that is being used for kexec, rather than the
entire initramfs blob. For example in the situation where the initramfs
blob contains some uncompressed early firmware and then a compressed
filesystem there will be 2 measurements folded into the TPM, and logged
into the IMA log.

Why is this useful? Consider the situation where images have been split
out to a set of firmware, an initial userspace image that does the usual
piece of finding the right root device and switching into it, and an
image that contains the necessary kernel modules.

For a given machine the firmware + userspace images are unlikely to
change often, while the kernel modules change with each upgrade. If we
measure the concatenated image as a single blob then it is necessary to
calculate all the permutations of images that result, which means
building and hashing the combinations. By measuring each piece
individually a hash can be calculated for each component up front
allowing for easier analysis of whether the running state is an expected
one.

The KEXEC_FILE_LOAD syscall only allows a single initramfs image to be
passed in; one option would be to add a new syscall that supports
multiple initramfs fds and read each in kimage_file_prepare_segments().

Instead I've taken a more complicated approach that doesn't involve a
new syscall or altering the kexec userspace, building on top of the way
the boot process parses the initramfs and using that same technique
within the IMA measurement for the READING_KEXEC_INITRAMFS path.

To that end I've pulled the cpio handling code out of init/initramfs.c
and into lib/ and made it usable outside of __init when required. That's
involved having to pull some of the init_syscall file handling routines
into the cpio code (and cleaning them up when the cpio code is the only
user). I think there's the potential for a bit more code clean up here,
but I've tried to keep it limited to providing the functionality I need
and making checkpatch happy for the moment.

Patch 1 pulls the code out to lib/ and moves the global static variables
that hold the state into a single context structure.

Patch 2 does some minimal error path improvements so we're not just
passing a string around to indicate there's been an error.

Patch 3 is where I pull the file handling routines into the cpio code.
It didn't seem worth moving this to somewhere other code could continue
to use them when only the cpio code was doing so, but it did involve a
few extra exported functions from fs/

Patch 4 actually allows the use of the cpio code outside of __init when
CONFIG_CPIO is selected.

Patch 5 is a hack so I can use the generic decompress + gzip outside of
__init. If this overall approach is acceptable then I'll do some work to
make this generically available in the same manner as the cpio code
before actually submitting for inclusion.

Patch 6 is the actual piece I'm interested in; doing individual
measurements for each component within IMA.

Jonathan McDowell (7):
  initramfs: Move cpio handling routines into lib/
  lib/cpio: Improve error handling
  lib/cpio: use non __init filesystem related functions
  lib/cpio: Allow use outside of initramfs creation
  lib/cpio: Add a parse-only option that doesn't extract any files
  HACK: Allow the use of generic decompress with gzip outside __init
  ima: Support measurement of kexec initramfs components

 fs/init.c                         | 101 -----
 fs/internal.h                     |   4 -
 include/linux/cpio.h              |  91 +++++
 include/linux/fs.h                |   4 +
 include/linux/init_syscalls.h     |   6 -
 init/initramfs.c                  | 522 +++----------------------
 lib/Kconfig                       |   3 +
 lib/Makefile                      |   2 +-
 lib/cpio.c                        | 607 ++++++++++++++++++++++++++++++
 lib/decompress.c                  |   4 +-
 lib/decompress_inflate.c          |   4 +
 security/integrity/ima/Kconfig    |  16 +
 security/integrity/ima/ima_main.c | 191 +++++++++-
 13 files changed, 961 insertions(+), 594 deletions(-)
 create mode 100644 include/linux/cpio.h
 create mode 100644 lib/cpio.c

-- 
2.36.1
