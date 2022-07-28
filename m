Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D129584097
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jul 2022 16:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbiG1OJK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jul 2022 10:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiG1OJJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jul 2022 10:09:09 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A10B4AD;
        Thu, 28 Jul 2022 07:09:07 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26SBfNSR026048;
        Thu, 28 Jul 2022 07:09:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=TUNw5zJBo+D+6S6jCo//5BOxwe3AcSs5i68gEHBonwk=;
 b=kp374D4Pvhyfa1pzd+gA7ryA4Uu6zrahHIzeyEq9wRpZ++k/ClVhWPDpCAA6maD0YarO
 6zugnMxbdksxmq6LGAre5azuZomA38LIOWWbvQXQLC7vWw8tmxBQ9e3ddgdsRCBaWfKo
 +4LLM3FlwVLdGYMqPwcKZLeqhHP9rC30Un0= 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hkst10u9j-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Jul 2022 07:09:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oAdpoif116G927S6ossoMq0c9c1ko6KjocHhUMMnTkUyxvz4bgWOTCqv0GxHTRtW3aE8CNDMChD+PkUby7aCAKqD0qavk/Zs9gpbmv/0XI7tw7wvG6uW+Bmj34trKA/R9OxAh5xZ62ciTAnBUGjyUxBOeLF502nezeJsdc0wwp00CyZI0YZFDTBtuVHYU+sw4z7asjFvdZk9ZvdZwcqW+HPV6Ht0OVUfgGAwYGYUd40+8WDJEQTdGFZ1FkgnyOAgkPwd1t4jNOvHHznKNB/xFsWrcJkHcquAxYouADdaKw9VvVnCj8iSmAH6mI17rCs8R9CzTjb9BspZSVdEeUn3ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TUNw5zJBo+D+6S6jCo//5BOxwe3AcSs5i68gEHBonwk=;
 b=JUDfo/X0JNqrtmGZ5Zv1acVZNYBoT0SZGwYIzUEXQZ0hLMh+KMDk+hujI6/IBEohu6unBiOfH+MwPdHfWaJr560I2L7JZHkAA2L5hXFhaqnV9dIxONp9ePi9j7XADonKe3H11Jnh1YTu03wjS5qXE+NT1IBgI390JyHx7O3CtOgoAkTyRjU8p3SLFzF01Umk6HO/LnXLFKdz1MPJfD9mJlzm8yqJ8RbpYF3oxTP+k1qcpIqFMSZ19qpe5+RlMSiBbHadbDcorBeBokJPZYSibHRcYJ1Cr9yNARpo8GDYuZfjfsSauRtRZAkQ6pOcl2n3AjUQvNlHA2iahZ+gdSSQqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com (2603:10b6:a03:379::12)
 by MN2PR15MB4256.namprd15.prod.outlook.com (2603:10b6:208:fe::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.25; Thu, 28 Jul
 2022 14:08:53 +0000
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::81f9:c21c:c5bf:e174]) by SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::81f9:c21c:c5bf:e174%8]) with mapi id 15.20.5458.025; Thu, 28 Jul 2022
 14:08:53 +0000
From:   Jonathan McDowell <noodles@fb.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
CC:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Dmitrii Potoskuev <dpotoskuev@fb.com>
Subject: [RFC PATCH v2 0/7] ima: Support measurement of kexec initramfs
 components
Thread-Topic: [RFC PATCH v2 0/7] ima: Support measurement of kexec initramfs
 components
Thread-Index: AQHYoouRiq7n37hqNE+boJLrxD1VXA==
Date:   Thu, 28 Jul 2022 14:08:53 +0000
Message-ID: <cover.1659003817.git.noodles@fb.com>
References: <cover.1657272362.git.noodles@fb.com>
In-Reply-To: <cover.1657272362.git.noodles@fb.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 82f52c7f-b3fb-4683-e8af-08da70a2b3ed
x-ms-traffictypediagnostic: MN2PR15MB4256:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f4UC9fky+tmQZ4KhEtHN9d0leTzBCm2LQmbHjgLjySfepccnjjxmNN/FRpQ0qtJPl25jg2OSlJpEs5EXMxXazugb8iUfndf4GfG49ZhaEj21ObSqOb/J6GkXVWrdxymqIXQvbVuTgb91GyTLS3W52RT+u+IYL7A6xXtecfWDOb5L6tvV4FimJmQJlJJ2JNighQzJTO0kWyAYU1iDRglBHaew3o+No7a7MT1VGalMRnIEKQm72neDZ2bPi+hHZHBxZNAOBOoqCR95B+vWUi7tDAjPswLiTCBAAlNVSJDCg/mYtziUZ4sMRkno+TMnNJC7sAQOeshexcFEJXbCO6ZPuHH10ymwNXjoRFCznfLRUX6jdpUBw/fIqS134CwZy6SOyzvHFNKMp3osqZetSLbk4JNtLcEsrrtSOKyQlRatRK4YmG7gjMjiYlrAfEhzn56Ho/YQ2NJVT/zBkxYg6i40VAtdgJ8KoKW+OCCP3SWzGBPviBB/2AGbc7nNOqrV9tAIzpR/63b99hWb+tQo7FRipEFgoowIqBtCpWQXQMHcau4sNnvsOKDjtPc4RbIf/4yhZ441qCTwG/PgjP4nbH0VG3fcNTJIVVFInt//Bjj4NeSUyIr4k/4wB/HuTPHsvTLHmlGPGIXV+uuXSOYUpPGMXANT2kgs7RxC0ABWA2rFgF6/Jogh2rkn/nukE/1wFln/RePEVNnOx9dLoW1YkCcWRCkc1sAWNUuZyrahKK7wGnIXZe2JSvfMeROTwAUYe+IhlzIBFRhZUvitKpDAQ4AEmzJ+t1tx0NaEjS7ayW7MzqU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB4552.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(366004)(136003)(39860400002)(396003)(7416002)(2616005)(2906002)(478600001)(122000001)(41300700001)(6506007)(86362001)(316002)(36756003)(186003)(5660300002)(38070700005)(38100700002)(66476007)(4326008)(83380400001)(6486002)(6512007)(91956017)(110136005)(54906003)(26005)(71200400001)(76116006)(66946007)(8676002)(8936002)(64756008)(66556008)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sIJAcPQbD7VBcVaJ9hMKFJhvdpD/aqdB8zAvrJK0u/N8xySZ2dd2RjtfOz23?=
 =?us-ascii?Q?6cDRY+ezoosEADUFyB/8I+klZuks1/xXz+ICy/LhZK+WXV5WlefrVnhWZCqm?=
 =?us-ascii?Q?PEVsgbflzpyWLaKUh3AAYafLOSTqaRLF2XTsryasmnfzBrFUXr9jO2t1DSvr?=
 =?us-ascii?Q?xUr67alXSXj3seLHdmKazQBgKVh4SRjFqy+pvfpiPeNsRcXXNXV2ci6yo0wZ?=
 =?us-ascii?Q?OvdulSYYy/7FKGQ6PV5M7l571sap+ById9hgGSbS8ck8q0GJdFXgcU1ASYUL?=
 =?us-ascii?Q?s3nDbiCdRRaIjELrw4RyhZizf73uxJUCP1YFGKbRIMeld4a8/XWwWb1tvSmA?=
 =?us-ascii?Q?YOvme4GR4czwZCen/WXLJuDjhDJuqCHYqFkFaWwyNeopMtTtB1sM6FK1Ndw+?=
 =?us-ascii?Q?9xA7fE6rtoEvJG/s7ZD/WNhjgrLc+bwzgVxck5RHnHDhXyVG0Hb+cu886eQV?=
 =?us-ascii?Q?2HIi+5eqlOpDdDXYamWS42OfgS3VDmFe8tqZi3zOSPmmDw9DRS4tWiXcsNkm?=
 =?us-ascii?Q?S6j6Dfcr64Y7iugVBacmBOg5PmCGlyFlWGeuDFK3hJjT5bFMXpSHTUnbAKGP?=
 =?us-ascii?Q?95QwT+3Ndm/ewrrlHlRcHpAaiK30byOGH6AsYhSMAd9SvJQc1EWPZX3oxyzU?=
 =?us-ascii?Q?7nqnJy565Zn8m09kB+nfrx8BAFo+WyPP41YWN1ey78sKlWakQENFY/NmbgEn?=
 =?us-ascii?Q?2Tw8W3bHeLl5sSV0W+2Qn9v8vR0a9NJSknuazdeaknB5USziDA620YQLD/xR?=
 =?us-ascii?Q?OEWT5AQ4jNPmMiPAIUwa0b3blfWmvEULBBW+GHSI5lBr+hwllJcS+88+ui8F?=
 =?us-ascii?Q?Tsn9kAySyJtuQgYhdbC86y3lk423oavabeqxq0lKsCJRMddVwc82UIXsL0fT?=
 =?us-ascii?Q?Ov9p+R2ccZehcvM5tmvu8BKfyEdI2alvC87Mp+RitVBaq2UOPqh4sgTpW+cA?=
 =?us-ascii?Q?XS7eyoMTR2JmQC9LL0xHVWHKpPXYpGpdG00QpyZ4tQUIlbvaFJlgB+WRFIo/?=
 =?us-ascii?Q?Ob66fnuGLms68q3ME22uXQnmbrgMnlioF89YtFQBUyhpZf/IgmTapjdGpBzg?=
 =?us-ascii?Q?rwrRIEtSbgEAEYSn4xc3BUWvum1R8w4wSMXtHjixyNVTFGoThD84HyFZ0pWr?=
 =?us-ascii?Q?7IzgxzI9oddX6zGqIh/RhI9dHq+5LXWiGcXVU2SzJE3hx0v/rkYxyAzjWjCe?=
 =?us-ascii?Q?gJVdrOfT9sw5qvOXZMpjNrYd4C3ntAHpb+Ou+8FHPhKLzacf5GTPaSkMQB9x?=
 =?us-ascii?Q?wYUsdzsS5QbUPUmmcWMTw8DOOZsXTPJGZpH66ioteY048GxHXvY7kWiGCSmg?=
 =?us-ascii?Q?cbKAF+MtR3F3BQqPITQapegydSL9RS6C+HdPpvOKqnNSOYrBUZybAz39ylei?=
 =?us-ascii?Q?lDiEEU5kZG3qdRW5mNgxC4Wxdh0V4ZF+i3AG/b7770Pm0nNyjBNnGSq3mKHd?=
 =?us-ascii?Q?6PmC+YNSRewpM49nYXIysc8NmIVZHHWniupPn4oHX/UA6+DaQPXolmzdSwh/?=
 =?us-ascii?Q?6uJ7Yuqs57fVRUcgyqaaPSyrJloM7rNWTo3zEnSsNIoxJPU7oPBHbZsI3J3H?=
 =?us-ascii?Q?9P+Nebisd0kiziy+LkMBWIEuAJLk3QSGMnH9RXUq?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DC3AC7FDEE49AB4B8375AB8FF63C7268@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB4552.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82f52c7f-b3fb-4683-e8af-08da70a2b3ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2022 14:08:53.1603
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ouEdU8IIEw+XmQrz6ZbktwzlmBUykkCEicXu1JneIMCQwQrBkMnVCf+2bCXyZxHI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB4256
X-Proofpoint-GUID: z8w3XXy1vMl9fWHlSjhZwvZdhhVNl7J1
X-Proofpoint-ORIG-GUID: z8w3XXy1vMl9fWHlSjhZwvZdhhVNl7J1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-28_05,2022-07-28_02,2022-06-22_01
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patchset is not yet complete, but it's already moving around a
bunch of stuff so I am sending it out to get either some agreement that
it's a vaguely sane approach, or some pointers about how I should be
doing this instead. I've not had a lot of feedback from v1 but the
kernel test robot threw up a couple of compile failures and a boot
failure so this is a revised patch set with those fixed.

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

v2:

Fix printf format string in populate_initrd_image (kernel test robot, i386 build)
Include <linux/limits.h> in cpio.h (kernel test robot, uml build)
Fix EEXIST checking for device nodes (kernel test robot, boot attempt)


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
 include/linux/cpio.h              |  92 +++++
 include/linux/fs.h                |   4 +
 include/linux/init_syscalls.h     |   6 -
 init/initramfs.c                  | 524 +++----------------------
 lib/Kconfig                       |   3 +
 lib/Makefile                      |   2 +-
 lib/cpio.c                        | 609 ++++++++++++++++++++++++++++++
 lib/decompress.c                  |   4 +-
 lib/decompress_inflate.c          |   4 +
 security/integrity/ima/Kconfig    |  16 +
 security/integrity/ima/ima_main.c | 191 +++++++++-
 13 files changed, 965 insertions(+), 595 deletions(-)
 create mode 100644 include/linux/cpio.h
 create mode 100644 lib/cpio.c

-- 
2.30.2
