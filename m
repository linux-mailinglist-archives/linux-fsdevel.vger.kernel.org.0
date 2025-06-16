Return-Path: <linux-fsdevel+bounces-51825-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C93ADBD9F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 01:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9E4D1723E5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 23:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219C622FE11;
	Mon, 16 Jun 2025 23:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="S4IDB116"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CA4136358;
	Mon, 16 Jun 2025 23:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750116489; cv=fail; b=Ms/cRXNOoL9VLU8lPZmLSsj4Jxk4qLOkm27ArtkBTojVXcRVoCXGeyXiiVCMRB1+SpBRhihQi/U4qe+wc21H54Dye5IgvnsI9FnTha2pwyLxZtQeFZdA8BznM7BE5bzlQ3U8L1y8kHnCP+keJP+SIaiy8aAchbKrx808f26Qfsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750116489; c=relaxed/simple;
	bh=z9Amuu1cnmnKSZT8EifmRlotqroxM1F93OxqWrhOwZQ=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=cVv1STkRjG/XdMvsqW3/21c6iEpCzvURaNwOORWY4Sk48rDf9hIhRwhUwtyx0k57zzdu0HmAwQQ9hVRT5oiBJ0pUvRvmGUx/BRo12kAb8cLmRs6P5UDvDwMFhIqAUpQjrhIdi4U2HsPyx/YZ5l+YxevbqplkglnIuwauxRSLxhk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=S4IDB116; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55GKmsAs026844;
	Mon, 16 Jun 2025 23:26:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=z9Amuu1cnmnKSZT8EifmRlotqroxM1F93OxqWrhOwZQ=; b=S4IDB116
	5rxfjTBmBJAMXKL0v7nxyI8KS2Z+tCg4L/6L2OrZ/Cn18hWxvsZ95718WPewexvP
	V94QmTe2BmXrVwFbFT7k7jVbv9ac/xUda2sF8XUJYkoEu6mpVfM4hFhDip8foZ2A
	8V4JcNf26gsEyUIKRG9KJHyVGVAEGeP8/oS/xfVqJ7cWggLQZ4V9e5l69pKmhAUd
	+sfArulOoFVH2uz1Uqd4pH5udkTzmC6mWG6ncXycO0BzoCArrMAKDcOzYYGWaNA0
	ubFCTRkjlYUMLYNxU7O+Yv5+P9dZgI65CFZEW+7A2Lnw0T1mVpns+AB+fgZPy2kJ
	vJZZZLOt+FJe2A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 478ygn4qb1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Jun 2025 23:26:45 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55GNQiL3004424;
	Mon, 16 Jun 2025 23:26:44 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 478ygn4qau-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Jun 2025 23:26:44 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A+aqp7AjBPn17rSIhoMDEsUA3tO+vkdkr3eVsAdhhS0VIqhfuS5YdtpChmzFIAgHUtbdmrm/JMBR8B0FPVQbNWv/hNrDLZAdatDkrUvkC+y+e/b7WIlyxb/njHdYULAZCNLkGa0yNBz7thNX/Fx9o+6A1OR4DnMgv/owRYtGO5u8KHyDBaRgwrPGcyJc1dUoMZBXFN7Q/8vKE6qPFXi9q+LAvN9THvL1LYg50hIJR77dF1hg/kMS2B/Sdqe+EiVNqjwlOb1w4w48sLOYl7CLXwlwHFYReBo05GHVAje5zTPI+VGYWEUB2EuJAfp2p7aWisDcbS1i4O8DqAr2O1i4Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z9Amuu1cnmnKSZT8EifmRlotqroxM1F93OxqWrhOwZQ=;
 b=wuCQg96Xbp5uAnKxauCDm10jXAFb09y6pu+woqUun04RejOfrg3Z0wLj5QTJ+PsvX/SdVuCB+Qelegqal2fCpcl5MiG0L1bb4agXoQADdB9r5Ehq7QeoYBWHOJhLH/V/uS6+8RotLNXtzTqVGPI0ndF9BqHZ7hv524/oCurxx9nh17qPlGyJUK0sN3lkDsAxfrHIMVhfi30y8TkBV64vR0L5TAiQNV/t6Ry09x7Dm9xzbnr8VB63CvokRoEIz3fXkn2ZU21EjQKWYlt16psLvCiH99g+dzgdNqSBcsI6C4WhkKO7dWCvSQDM+25qW1BNVc1H1KUZAZIeAQ2k6bU1Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SJ2PR15MB6467.namprd15.prod.outlook.com (2603:10b6:a03:577::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Mon, 16 Jun
 2025 23:26:41 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%7]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 23:26:41 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC: "xiang@kernel.org" <xiang@kernel.org>,
        "codalist@coda.cs.cmu.edu"
	<codalist@coda.cs.cmu.edu>,
        "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>,
        "anna@kernel.org" <anna@kernel.org>, "vbabka@suse.cz" <vbabka@suse.cz>,
        "pfalcato@suse.de" <pfalcato@suse.de>, "jack@suse.cz" <jack@suse.cz>,
        "linux-xfs@vger.kernel.org"
	<linux-xfs@vger.kernel.org>,
        "v9fs@lists.linux.dev" <v9fs@lists.linux.dev>,
        "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "miklos@szeredi.hu" <miklos@szeredi.hu>,
        "linux-unionfs@vger.kernel.org"
	<linux-unionfs@vger.kernel.org>,
        "amir73il@gmail.com" <amir73il@gmail.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        Hans De Goede <hdegoede@redhat.com>,
        "asmadeus@codewreck.org" <asmadeus@codewreck.org>,
        "simona@ffwll.ch"
	<simona@ffwll.ch>,
        "jth@kernel.org" <jth@kernel.org>,
        "shaggy@kernel.org"
	<shaggy@kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>,
        "jaharkes@cs.cmu.edu" <jaharkes@cs.cmu.edu>,
        "tursulin@ursulin.net"
	<tursulin@ursulin.net>,
        "trondmy@kernel.org" <trondmy@kernel.org>,
        "ecryptfs@vger.kernel.org" <ecryptfs@vger.kernel.org>,
        "ericvh@kernel.org"
	<ericvh@kernel.org>,
        "joonas.lahtinen@linux.intel.com"
	<joonas.lahtinen@linux.intel.com>,
        "hirofumi@mail.parknet.co.jp"
	<hirofumi@mail.parknet.co.jp>,
        "linux-nilfs@vger.kernel.org"
	<linux-nilfs@vger.kernel.org>,
        Xiubo Li <xiubli@redhat.com>,
        "aivazian.tigran@gmail.com" <aivazian.tigran@gmail.com>,
        "hubcap@omnibond.com" <hubcap@omnibond.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "intel-gfx@lists.freedesktop.org"
	<intel-gfx@lists.freedesktop.org>,
        "sfrench@samba.org" <sfrench@samba.org>,
        "jfs-discussion@lists.sourceforge.net"
	<jfs-discussion@lists.sourceforge.net>,
        "clm@fb.com" <clm@fb.com>, "jlbec@evilplan.org" <jlbec@evilplan.org>,
        "lihongbo22@huawei.com"
	<lihongbo22@huawei.com>,
        "ronniesahlberg@gmail.com"
	<ronniesahlberg@gmail.com>,
        "lucho@ionkov.net" <lucho@ionkov.net>,
        "anton.ivanov@cambridgegreys.com" <anton.ivanov@cambridgegreys.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "cem@kernel.org"
	<cem@kernel.org>,
        "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "tom@talpey.com" <tom@talpey.com>,
        "mikulas@artax.karlin.mff.cuni.cz"
	<mikulas@artax.karlin.mff.cuni.cz>,
        "bcrl@kvack.org" <bcrl@kvack.org>,
        "linux-afs@lists.infradead.org" <linux-afs@lists.infradead.org>,
        "mark@fasheh.com" <mark@fasheh.com>,
        "linux-mtd@lists.infradead.org"
	<linux-mtd@lists.infradead.org>,
        "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>,
        "bharathsm@microsoft.com"
	<bharathsm@microsoft.com>,
        "linux-ext4@vger.kernel.org"
	<linux-ext4@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net"
	<linux-f2fs-devel@lists.sourceforge.net>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "martin@omnibond.com" <martin@omnibond.com>,
        "jefflexu@linux.alibaba.com"
	<jefflexu@linux.alibaba.com>,
        "naohiro.aota@wdc.com" <naohiro.aota@wdc.com>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "nvdimm@lists.linux.dev"
	<nvdimm@lists.linux.dev>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "pc@manguebit.org" <pc@manguebit.org>,
        "dwmw2@infradead.org"
	<dwmw2@infradead.org>,
        "code@tyhicks.com" <code@tyhicks.com>,
        "ocfs2-devel@lists.linux.dev" <ocfs2-devel@lists.linux.dev>,
        "linux-aio@kvack.org" <linux-aio@kvack.org>,
        "idryomov@gmail.com"
	<idryomov@gmail.com>,
        "dlemoal@kernel.org" <dlemoal@kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "zbestahu@gmail.com"
	<zbestahu@gmail.com>,
        "linux-cifs@vger.kernel.org"
	<linux-cifs@vger.kernel.org>,
        "johannes@sipsolutions.net"
	<johannes@sipsolutions.net>,
        David Howells <dhowells@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>,
        "richard@nod.at"
	<richard@nod.at>,
        "yuezhang.mo@sony.com" <yuezhang.mo@sony.com>,
        "joseph.qi@linux.alibaba.com" <joseph.qi@linux.alibaba.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-karma-devel@lists.sourceforge.net"
	<linux-karma-devel@lists.sourceforge.net>,
        "kent.overstreet@linux.dev"
	<kent.overstreet@linux.dev>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>,
        "samba-technical@lists.samba.org"
	<samba-technical@lists.samba.org>,
        "dhavale@google.com" <dhavale@google.com>,
        "devel@lists.orangefs.org" <devel@lists.orangefs.org>,
        "konishi.ryusuke@gmail.com" <konishi.ryusuke@gmail.com>,
        "linux_oss@crudebyte.com" <linux_oss@crudebyte.com>,
        "jaegeuk@kernel.org"
	<jaegeuk@kernel.org>,
        "sprasad@microsoft.com" <sprasad@microsoft.com>,
        "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
        "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "rodrigo.vivi@intel.com"
	<rodrigo.vivi@intel.com>,
        "adilger.kernel@dilger.ca"
	<adilger.kernel@dilger.ca>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "chao@kernel.org" <chao@kernel.org>,
        "coda@cs.cmu.edu" <coda@cs.cmu.edu>,
        "jannh@google.com" <jannh@google.com>,
        "kees@kernel.org" <kees@kernel.org>,
        "me@bobcopeland.com" <me@bobcopeland.com>,
        "chengzhihao1@huawei.com"
	<chengzhihao1@huawei.com>,
        "linux-bcachefs@vger.kernel.org"
	<linux-bcachefs@vger.kernel.org>,
        "marc.dionne@auristor.com"
	<marc.dionne@auristor.com>,
        "almaz.alexandrovich@paragon-software.com"
	<almaz.alexandrovich@paragon-software.com>,
        "linux-mm@kvack.org"
	<linux-mm@kvack.org>
Thread-Topic: [EXTERNAL] [PATCH 08/10] fs: convert simple use of
 generic_file_*_mmap() to .mmap_prepare()
Thread-Index: AQHb3vY1k2m1+nMh1EGyW6lb2yGgIrQGbkwA
Date: Mon, 16 Jun 2025 23:26:40 +0000
Message-ID: <bbd4300abcd1ba128e593779a87a8c6133dfbfc4.camel@ibm.com>
References: <cover.1750099179.git.lorenzo.stoakes@oracle.com>
	 <c7dc90e44a9e75e750939ea369290d6e441a18e6.1750099179.git.lorenzo.stoakes@oracle.com>
In-Reply-To:
 <c7dc90e44a9e75e750939ea369290d6e441a18e6.1750099179.git.lorenzo.stoakes@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SJ2PR15MB6467:EE_
x-ms-office365-filtering-correlation-id: 895cefc4-5da3-4e76-7a4d-08ddad2d3fb7
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cDRPZVp1aTFkV3RqY3liUjROUndQdzcybS90enZsTXRuWHJVd3VjUGN5bmRl?=
 =?utf-8?B?b2FUclNtSW5oazZqQ1ZvT3Y2N2drZ1BXTTRUTUxuK2hoeXBUMFZjTUFKU0lF?=
 =?utf-8?B?TUhSVXZiNGFJSHo5d042OENRQU04YnpQeWhaVS92U2s5S01tZUphYWQzYnE0?=
 =?utf-8?B?ci9VNGUrQjgyRTEzQVVTci9mN0g3NjMyYVJ0bm91K0lreWROTFR4WURjUzE0?=
 =?utf-8?B?RDdLYUVUVXM4Sjlod2xUS2VMZVlYVVRVeFlLS3c0aHhjNFhHeWhNdFlsSlk4?=
 =?utf-8?B?NXJuNUFSZ0E4TDEvVXdSTGlaZVJWT0hvM2Iya29qSCsycDB6RUkzdXI2QkVt?=
 =?utf-8?B?NFlVQlhaZW53eW1PODlUN0tIcHQ2L3JudFFuUkxSeVpmdFNVeU56em9NdFR0?=
 =?utf-8?B?clZyT1B0YTgvNkVBSWJqTTFrSmZCQURwekZLeVY1Q3JiVFQwVXRyd0JSajhG?=
 =?utf-8?B?ejdzYmttOEltV01MS1ZjZlJzczQ1d3hWV2hDRnhpUUxaSXJFK1lRTVFMQVJG?=
 =?utf-8?B?bzB2azAxSXdJc21PUHhrR0kyRnRaNll2TGFKTjI5RElIdGF1V0FPSFp2ZGxB?=
 =?utf-8?B?cEg2dTZFYUN4M2xmS2dNRjRBUS9rVDV4TUdkNDVwUjRvY2xWRWl6YXpick1K?=
 =?utf-8?B?RmNwUGt1RTMwSGFjOEdybzBzcVVhdnIzYWltalVZSU5Xbm1zV0M4ejNUdDRp?=
 =?utf-8?B?SnNLdThNUm5tQzdyUjZXMko1Yk1YV0pETStwdzJ3VitJdEFJWWZWNnNhUzli?=
 =?utf-8?B?YklXeUpGUkdrdis4b0UrTWgzTkxFeFdMU254Zk0wTXZmdkZpKzZZdUVCbWxh?=
 =?utf-8?B?c3VGTlBmN0paQ1BZU0tCaW5jNjRtV1pyTndPQng5RHJQNDZ6b2c3a2t5THVV?=
 =?utf-8?B?V2tiOFdSeTZjVDgzNEVXbFMwZytMTDdtTGNhRUlWdCtheHQ2UHhvQ1UwMGZ6?=
 =?utf-8?B?ZHp5NnJPYmlmM1o4c3dZRnorTmRUQTJnWFAyTDkzWGx6aWFLUjZ2Tmx0dVNl?=
 =?utf-8?B?TTlRdTVkNW1LY3lZaGF2UUVnVlBnbFhDaFNBQW1laDFkZGpVZVEvRThUUU96?=
 =?utf-8?B?dlowczlZSDlMYk1jUnp0WlZoR0hpQTlDSldhUkM3ektiNEtRV2E4VlZCSHVp?=
 =?utf-8?B?ZVdNbzB6ODVxMnVwNTlRMDBYQkYvNDkvd1dmZnhYdjRPRmltWHZBZmxXRVpm?=
 =?utf-8?B?bDJ4b1NYRFhJUk1RRVVXdGpPTFdxQzVaTjlyYlh6QWdpTWQ5UFVjZjNudHpE?=
 =?utf-8?B?dENKMFhsWmFxMTJaczczT01lRWxZcnh0ZURoUk0wNmhFQ1Y4bVd0bjNOU1JG?=
 =?utf-8?B?WU1jUFd3djFqdm1QRWV3YzAveW9sYmdYVm01QTZ1YWFKNmlQOVZtN1Fhbmxv?=
 =?utf-8?B?YmpMSFkvOGEySGJMV042M2lRbzBuOGg5Z0VxUm5makFYOVE3TmRFZWFXNjdL?=
 =?utf-8?B?eXgyZ01MNzQwOE82MXUwUWRHcTRVc1BINlRRUEE0WFZnRVArcDBhdG1NUVcy?=
 =?utf-8?B?dFU0dUdSUGlMTkd5SWp5Q0ZCT1NLZDBPdktyaDNpMnk4a0ovMTNoSVRZZDVn?=
 =?utf-8?B?eWJONVRLU0JRY29TYnZjZ0VHSi9GR0FoZ2VvM1R2Q3lOOGxlVXNRSFJsM2R2?=
 =?utf-8?B?ZFgra3lndW9RTmpwLzlXMUlJOFVzN3ZCVjVTUWlSZmRDTDE2WGs4YUx5aW1U?=
 =?utf-8?B?TXhmc3pSaGdwa1Y2aEVFc1Vrc3RVRnhqeXYxRU41ajBiSHlJY0tDYWliTkR3?=
 =?utf-8?B?Yi8wdzlSQ1F0Z0RaSEZaZ2s3bjhRWW5GVWtTWVFtK1l6WTlDV3lSUWJrcXVO?=
 =?utf-8?B?K0E1TmtNdEYycFRSb3ZJaDEzN2lWRkFhd1VFZS83OWZtanovTGVUclNyYU51?=
 =?utf-8?B?RDJVdnh6TUZJZnVxRzNxSGpibWZ6cC9nYmUvRjFFaWN5M0tEV1R6OEZCSG03?=
 =?utf-8?B?OFdpTW00Y3hIMkxZdFE2Q0pUQzU2NGl0M1VBeENia2U0aTMwaGE5cmU2cytK?=
 =?utf-8?B?TnhaSlNXNk1BPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eWYzNG92UDBybG9ydm0zY05VK29US0FyV241OTJTak01QjJhNXZFM1g1b0JD?=
 =?utf-8?B?OXpVRzVMUWxxNUZ6SnZuSjlzNzI2TG5EaG5ZdjlDdWpFYXNYNXI2bHAwbUhD?=
 =?utf-8?B?SkgvYkEzc0ZicW9HYitrRkxFckN2UWNKQmFZV2pkQWpIL3lsd2RpK25aSDcv?=
 =?utf-8?B?c3Vadis0ZzAwSksvNWphTkxVdEFPOXFIN0h4S3IvVHR4bEI4eW9ma1NoRTAw?=
 =?utf-8?B?TnZXRUlUeXpqREtkTjNDd0hQTWlWQlVITmVNVGdwSkxRUThRUTJLYUVCM2RJ?=
 =?utf-8?B?dmVHcHUwVmc0ZFF3b0NGVkxGU2hVV0dTb0g4cWZyR0YwQlFZVXBDa3U0d0hq?=
 =?utf-8?B?UEJ5TnJ5NWUrN040Uzh4dVFWUkJ2MXFjT2NndWloWWVTSUY2NFlOWmV6ZStZ?=
 =?utf-8?B?Yk5uSHFaaXU2U255QnV6MHg0eVhuOUZLV0R1Y2dNbVJsWi8vWFpDWXcxZnJ5?=
 =?utf-8?B?WTEwd2VROEljR0ZITHloYlBqRk85a2laVCszWi9SS1c3enZxbWh0LzhQYlFR?=
 =?utf-8?B?MmxCOGZuUEFVSWg0QWMzNkRNY01IbEZBcUUxY3lXTHM3eVZLOFo1Z2ZQYnZ2?=
 =?utf-8?B?dHRHcjFrQkcvQnRxSCtlUUtjalhJY2dPblFCK2RFa2lwWHJnQWUvcWsyTldP?=
 =?utf-8?B?elROMjVVQTkxREJMMmNBeFlRUVdVeUNvdVcrV0lmK2l2YWdKck1xRFFKemRr?=
 =?utf-8?B?S0JKSmxlTy8zcTdYbllMMG5xQUQ3QUNqNEsxUXprZ0dDazVIOS8yR2htK09K?=
 =?utf-8?B?K1BYcnNTTnBsd3lTdFRZMi92UmUrdlo2RzVWckxoOFJVZkdRbnpBLzhpbXhs?=
 =?utf-8?B?M2Q1a2xHQmRJa3l2WUpNM3RtcW9peU5Cakw0ZVZlNlhQYlY3SlFUYmdKWlo5?=
 =?utf-8?B?V2I2R24vbUEzMmNYSXQ4d2ttNHQwTkdSdkl2ZTZ4M29maGlyejdaOHJpNFNh?=
 =?utf-8?B?YytjUVZBdytGNVg1NE81M2dwa2lBdGM0eCtlblhrUlY3RjZWMXZsbDhUM3I4?=
 =?utf-8?B?QnkzY2xZSnQyREVYSExLMzdWN1pQUSswOTN5cmNpYzNHa3pQelVjVExRUXRz?=
 =?utf-8?B?VytjTE1QT3V0cUprbnd3eVFhWVZLbnQxaFR0WW0reVU5Zlgyd1k4YUxjNWlK?=
 =?utf-8?B?Rld3Vnp2akNZbGwzMkdsY0pDcDVvblVBeEVUTFFuODFyY2dMWmo2VDFQUXA3?=
 =?utf-8?B?a0dtYTczRUV3WXNwbUI1SmNzZjNWRTFpelNHNVFsbVU0OEI1anF6S0lGRjBL?=
 =?utf-8?B?U1dDaEJNWnVzK01mTFFGb2F0SkYyZ3k1cDY4RC9Rb0xsWFVJU2ZhVDZnTWwz?=
 =?utf-8?B?OHhCNFJqSzNFL0JXWlZJVTRjaXBqWGIxYW5wTEE4U1Awa1hSZys1dFl5dUQ0?=
 =?utf-8?B?cFFyZUsxYngzbTcrWU5lb2s3MGdoaytQK1p6Qkk1dTJBSG5LUklDM1Y5Nkxu?=
 =?utf-8?B?LzhFVmpYTUhSTDhwRFg2SGh0MmgzUC9RSnVvZ3ZrSTFWOTFBVExJcFVUTDRn?=
 =?utf-8?B?cXd5UVhpSmNySUNyT216MG50K2JLTXNpMTVpenE4OXhFR1lGRWZyZWtpRmN6?=
 =?utf-8?B?UStScTJFU1FVZHVITFlzVDcyK3kvVnVMaWZGdHR4UnVac3JVSXlKOEFLQXpp?=
 =?utf-8?B?RkwyZFYrZzRjYk9zWEF6MEVwTGFPVnMwcXlIem1xZkxGUm44aXAxU0E3aUhN?=
 =?utf-8?B?UXkwNGNjMHhYUGRDb1pmSFRXcGVlMENLNWp5ckFsU09wTCtiMTVhUzJOeExW?=
 =?utf-8?B?VmlNR2JaaHZTandNaHBSdEcybkVxWGR0cmlvaE16U0VTem9Uc05RN3Z2ajJw?=
 =?utf-8?B?cXE1WTdka0x4bTFqZk9tYUdSd2tqdXRTVHFBQlN1M09qMTRBZnNNdTRzQ3hh?=
 =?utf-8?B?M0lZSU8wQXlTdmZSci9jZ3lYU2JSNFVPYWsySzhCSUZuU3QvTUlLblNyQUpo?=
 =?utf-8?B?SDRvOFJmSDlSME9UU2dnY2NleW5GZVJNY245S0t1QlA1Y2FXbzN5RVI5aDFC?=
 =?utf-8?B?RWlqbjhmenJhOWlJYzZISGNEUTBZUVQ0K3lzNW9hVUtxSjZYV2UzTVVOYy9B?=
 =?utf-8?B?aTU1WjlHQmhuRFdHNmJwdXFnRUxObkFRSnZXR2FDWEdZaTFSU25XQmxteTZX?=
 =?utf-8?B?RUpwaHc4dnE0RmVpSXYzMk5xNkR3QklvQytjeWtPTXZhTThRYTYxTlZHS0dI?=
 =?utf-8?Q?kFFA3DnX27jMIY0oKaNCRa4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FA3FB1ADED5FE64C8292420FED48C5F9@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 895cefc4-5da3-4e76-7a4d-08ddad2d3fb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2025 23:26:41.0237
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZjF1CBw5RXllMs/RYt+a9Gv9bomgV4jRG8Qt+ozphS11ojAXSWA5YAL1IObm8Sv04GfqYQY8sUadQoupVIWcIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR15MB6467
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDE2NyBTYWx0ZWRfX/yhSa7IcwJh+ cqFFJX0yS10YGGB/QRREdUTBaB79BSkJrycMRoNLRZFwmGEVKN4D/YcqrvIEQWijFoio8f1nbZ5 Imw1+Eflqlstan/c1OOhNdfBSvHbQksYbAjFo6Pep8lYhGZim3GvB4OJLBghNa9mILMGyzLXYCW
 O1v4v6S5OXDvuMudcwa7fMzcXRzQVKQhmvXuNjhSPRGHnBcTJA8O74jGjwK34wgb0V2560BtIRz AhBQYMHyr+K65MATkgBpSOpJoTXkX2h62vCzAK0tKwGtN+7+UUrs+q0KsaJMNi7vLDNvSmAqWlT bG1hbCm3lyJTbB+knpp/9p18ZfNEzZrYZ85lFjd0aIDQY6NLLT5utqjfJaYRITk0ukEEbOy0IrG
 iliydSEGumOaxc1M4S+39aXkElHo0WOGNmvRAYp7ZNHcDSj8mTQex75u6dt9Vq4ja+3T5hKb
X-Authority-Analysis: v=2.4 cv=fYSty1QF c=1 sm=1 tr=0 ts=6850a835 cx=c_pps a=5CpET3F+obEq8wTakKEnog==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=yPCof4ZbAAAA:8 a=VnNF1IyMAAAA:8 a=K5pBiBE3vNJVv6Kx_kgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: lFgfPd5bXuX2bHn5bu1yiz-3Dvll88E_
X-Proofpoint-GUID: 0vBUP36GTObHu2Khyp7kdVmOwnFgAqAa
Subject: Re:  [PATCH 08/10] fs: convert simple use of generic_file_*_mmap() to
 .mmap_prepare()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_11,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0 mlxscore=0
 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506160167

T24gTW9uLCAyMDI1LTA2LTE2IGF0IDIwOjMzICswMTAwLCBMb3JlbnpvIFN0b2FrZXMgd3JvdGU6
DQo+IFNpbmNlIGNvbW1pdCBjODRiZjZkZDJiODMgKCJtbTogaW50cm9kdWNlIG5ldyAubW1hcF9w
cmVwYXJlKCkgZmlsZQ0KPiBjYWxsYmFjayIpLCB0aGUgZl9vcC0+bW1hcCgpIGhvb2sgaGFzIGJl
ZW4gZGVwcmVjYXRlZCBpbiBmYXZvdXIgb2YNCj4gZl9vcC0+bW1hcF9wcmVwYXJlKCkuDQo+IA0K
PiBXZSBoYXZlIHByb3ZpZGVkIGdlbmVyaWMgLm1tYXBfcHJlcGFyZSgpIGVxdWl2YWxlbnRzLCBz
byB1cGRhdGUgYWxsIGZpbGUNCj4gc3lzdGVtcyB0aGF0IHNwZWNpZnkgdGhlc2UgZGlyZWN0bHkg
aW4gdGhlaXIgZmlsZV9vcGVyYXRpb25zIHN0cnVjdHVyZXMuDQo+IA0KPiBUaGlzIHVwZGF0ZXMg
OXAsIGFkZnMsIGFmZnMsIGJmcywgZmF0LCBoZnMsIGhmc3BsdXMsIGhvc3RmcywgaHBmcywgamZm
czIsDQo+IGpmcywgbWluaXgsIG9tZnMsIHJhbWZzIGFuZCB1ZnMgZmlsZSBzeXN0ZW1zIGRpcmVj
dGx5Lg0KPiANCj4gSXQgdXBkYXRlcyBnZW5lcmljX3JvX2ZvcHMgd2hpY2ggaW1wYWN0cyBxbng0
LCBjcmFtZnMsIGJlZnMsIHNxdWFzaGZzLA0KPiBmcmVieGZzLCBxbng2LCBlZnMsIHJvbWZzLCBl
cm9mcyBhbmQgaXNvZnMgZmlsZSBzeXN0ZW1zLg0KPiANCj4gVGhlcmUgYXJlIHJlbWFpbmluZyBm
aWxlIHN5c3RlbXMgd2hpY2ggdXNlIGdlbmVyaWMgaG9va3MgaW4gYSBsZXNzIGRpcmVjdA0KPiB3
YXkgd2hpY2ggd2UgYWRkcmVzcyBpbiBhIHN1YnNlcXVlbnQgY29tbWl0Lg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogTG9yZW56byBTdG9ha2VzIDxsb3JlbnpvLnN0b2FrZXNAb3JhY2xlLmNvbT4NCj4g
LS0tDQo+ICBmcy85cC92ZnNfZmlsZS5jICAgICAgICB8IDIgKy0NCj4gIGZzL2FkZnMvZmlsZS5j
ICAgICAgICAgIHwgMiArLQ0KPiAgZnMvYWZmcy9maWxlLmMgICAgICAgICAgfCAyICstDQo+ICBm
cy9iZnMvZmlsZS5jICAgICAgICAgICB8IDIgKy0NCj4gIGZzL2ZhdC9maWxlLmMgICAgICAgICAg
IHwgMiArLQ0KPiAgZnMvaGZzL2lub2RlLmMgICAgICAgICAgfCAyICstDQo+ICBmcy9oZnNwbHVz
L2lub2RlLmMgICAgICB8IDIgKy0NCj4gIGZzL2hvc3Rmcy9ob3N0ZnNfa2Vybi5jIHwgMiArLQ0K
PiAgZnMvaHBmcy9maWxlLmMgICAgICAgICAgfCAyICstDQo+ICBmcy9qZmZzMi9maWxlLmMgICAg
ICAgICB8IDIgKy0NCj4gIGZzL2pmcy9maWxlLmMgICAgICAgICAgIHwgMiArLQ0KPiAgZnMvbWlu
aXgvZmlsZS5jICAgICAgICAgfCAyICstDQo+ICBmcy9vbWZzL2ZpbGUuYyAgICAgICAgICB8IDIg
Ky0NCj4gIGZzL3JhbWZzL2ZpbGUtbW11LmMgICAgIHwgMiArLQ0KPiAgZnMvcmVhZF93cml0ZS5j
ICAgICAgICAgfCAyICstDQo+ICBmcy91ZnMvZmlsZS5jICAgICAgICAgICB8IDIgKy0NCj4gIDE2
IGZpbGVzIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDE2IGRlbGV0aW9ucygtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2ZzLzlwL3Zmc19maWxlLmMgYi9mcy85cC92ZnNfZmlsZS5jDQo+IGluZGV4
IDM0OGNjOTBiZjljNS4uMmZmM2UwYWM3MjY2IDEwMDY0NA0KPiAtLS0gYS9mcy85cC92ZnNfZmls
ZS5jDQo+ICsrKyBiL2ZzLzlwL3Zmc19maWxlLmMNCj4gQEAgLTUxNiw3ICs1MTYsNyBAQCBjb25z
dCBzdHJ1Y3QgZmlsZV9vcGVyYXRpb25zIHY5ZnNfZmlsZV9vcGVyYXRpb25zID0gew0KPiAgCS5v
cGVuID0gdjlmc19maWxlX29wZW4sDQo+ICAJLnJlbGVhc2UgPSB2OWZzX2Rpcl9yZWxlYXNlLA0K
PiAgCS5sb2NrID0gdjlmc19maWxlX2xvY2ssDQo+IC0JLm1tYXAgPSBnZW5lcmljX2ZpbGVfcmVh
ZG9ubHlfbW1hcCwNCj4gKwkubW1hcF9wcmVwYXJlID0gZ2VuZXJpY19maWxlX3JlYWRvbmx5X21t
YXBfcHJlcGFyZSwNCj4gIAkuc3BsaWNlX3JlYWQgPSB2OWZzX2ZpbGVfc3BsaWNlX3JlYWQsDQo+
ICAJLnNwbGljZV93cml0ZSA9IGl0ZXJfZmlsZV9zcGxpY2Vfd3JpdGUsDQo+ICAJLmZzeW5jID0g
djlmc19maWxlX2ZzeW5jLA0KPiBkaWZmIC0tZ2l0IGEvZnMvYWRmcy9maWxlLmMgYi9mcy9hZGZz
L2ZpbGUuYw0KPiBpbmRleCBlZTgwNzE4YWFlZWMuLmNkMTMxNjVmZDkwNCAxMDA2NDQNCj4gLS0t
IGEvZnMvYWRmcy9maWxlLmMNCj4gKysrIGIvZnMvYWRmcy9maWxlLmMNCj4gQEAgLTI1LDcgKzI1
LDcgQEANCj4gIGNvbnN0IHN0cnVjdCBmaWxlX29wZXJhdGlvbnMgYWRmc19maWxlX29wZXJhdGlv
bnMgPSB7DQo+ICAJLmxsc2VlawkJPSBnZW5lcmljX2ZpbGVfbGxzZWVrLA0KPiAgCS5yZWFkX2l0
ZXIJPSBnZW5lcmljX2ZpbGVfcmVhZF9pdGVyLA0KPiAtCS5tbWFwCQk9IGdlbmVyaWNfZmlsZV9t
bWFwLA0KPiArCS5tbWFwX3ByZXBhcmUJPSBnZW5lcmljX2ZpbGVfbW1hcF9wcmVwYXJlLA0KPiAg
CS5mc3luYwkJPSBnZW5lcmljX2ZpbGVfZnN5bmMsDQo+ICAJLndyaXRlX2l0ZXIJPSBnZW5lcmlj
X2ZpbGVfd3JpdGVfaXRlciwNCj4gIAkuc3BsaWNlX3JlYWQJPSBmaWxlbWFwX3NwbGljZV9yZWFk
LA0KPiBkaWZmIC0tZ2l0IGEvZnMvYWZmcy9maWxlLmMgYi9mcy9hZmZzL2ZpbGUuYw0KPiBpbmRl
eCA3YTcxMDE4ZTNmNjcuLmZiYWMyMDRiNzA1NSAxMDA2NDQNCj4gLS0tIGEvZnMvYWZmcy9maWxl
LmMNCj4gKysrIGIvZnMvYWZmcy9maWxlLmMNCj4gQEAgLTk5OSw3ICs5OTksNyBAQCBjb25zdCBz
dHJ1Y3QgZmlsZV9vcGVyYXRpb25zIGFmZnNfZmlsZV9vcGVyYXRpb25zID0gew0KPiAgCS5sbHNl
ZWsJCT0gZ2VuZXJpY19maWxlX2xsc2VlaywNCj4gIAkucmVhZF9pdGVyCT0gZ2VuZXJpY19maWxl
X3JlYWRfaXRlciwNCj4gIAkud3JpdGVfaXRlcgk9IGdlbmVyaWNfZmlsZV93cml0ZV9pdGVyLA0K
PiAtCS5tbWFwCQk9IGdlbmVyaWNfZmlsZV9tbWFwLA0KPiArCS5tbWFwX3ByZXBhcmUJPSBnZW5l
cmljX2ZpbGVfbW1hcF9wcmVwYXJlLA0KPiAgCS5vcGVuCQk9IGFmZnNfZmlsZV9vcGVuLA0KPiAg
CS5yZWxlYXNlCT0gYWZmc19maWxlX3JlbGVhc2UsDQo+ICAJLmZzeW5jCQk9IGFmZnNfZmlsZV9m
c3luYywNCj4gZGlmZiAtLWdpdCBhL2ZzL2Jmcy9maWxlLmMgYi9mcy9iZnMvZmlsZS5jDQo+IGlu
ZGV4IGZhNjZhMDllNDk2YS4uNjY4NWMzNDExZmU3IDEwMDY0NA0KPiAtLS0gYS9mcy9iZnMvZmls
ZS5jDQo+ICsrKyBiL2ZzL2Jmcy9maWxlLmMNCj4gQEAgLTI3LDcgKzI3LDcgQEAgY29uc3Qgc3Ry
dWN0IGZpbGVfb3BlcmF0aW9ucyBiZnNfZmlsZV9vcGVyYXRpb25zID0gew0KPiAgCS5sbHNlZWsg
CT0gZ2VuZXJpY19maWxlX2xsc2VlaywNCj4gIAkucmVhZF9pdGVyCT0gZ2VuZXJpY19maWxlX3Jl
YWRfaXRlciwNCj4gIAkud3JpdGVfaXRlcgk9IGdlbmVyaWNfZmlsZV93cml0ZV9pdGVyLA0KPiAt
CS5tbWFwCQk9IGdlbmVyaWNfZmlsZV9tbWFwLA0KPiArCS5tbWFwX3ByZXBhcmUJPSBnZW5lcmlj
X2ZpbGVfbW1hcF9wcmVwYXJlLA0KPiAgCS5zcGxpY2VfcmVhZAk9IGZpbGVtYXBfc3BsaWNlX3Jl
YWQsDQo+ICB9Ow0KPiAgDQo+IGRpZmYgLS1naXQgYS9mcy9mYXQvZmlsZS5jIGIvZnMvZmF0L2Zp
bGUuYw0KPiBpbmRleCBlODg3ZTlhYjc0NzIuLjRmYzQ5YTYxNGZiOCAxMDA2NDQNCj4gLS0tIGEv
ZnMvZmF0L2ZpbGUuYw0KPiArKysgYi9mcy9mYXQvZmlsZS5jDQo+IEBAIC0yMDQsNyArMjA0LDcg
QEAgY29uc3Qgc3RydWN0IGZpbGVfb3BlcmF0aW9ucyBmYXRfZmlsZV9vcGVyYXRpb25zID0gew0K
PiAgCS5sbHNlZWsJCT0gZ2VuZXJpY19maWxlX2xsc2VlaywNCj4gIAkucmVhZF9pdGVyCT0gZ2Vu
ZXJpY19maWxlX3JlYWRfaXRlciwNCj4gIAkud3JpdGVfaXRlcgk9IGdlbmVyaWNfZmlsZV93cml0
ZV9pdGVyLA0KPiAtCS5tbWFwCQk9IGdlbmVyaWNfZmlsZV9tbWFwLA0KPiArCS5tbWFwX3ByZXBh
cmUJPSBnZW5lcmljX2ZpbGVfbW1hcF9wcmVwYXJlLA0KPiAgCS5yZWxlYXNlCT0gZmF0X2ZpbGVf
cmVsZWFzZSwNCj4gIAkudW5sb2NrZWRfaW9jdGwJPSBmYXRfZ2VuZXJpY19pb2N0bCwNCj4gIAku
Y29tcGF0X2lvY3RsCT0gY29tcGF0X3B0cl9pb2N0bCwNCj4gZGlmZiAtLWdpdCBhL2ZzL2hmcy9p
bm9kZS5jIGIvZnMvaGZzL2lub2RlLmMNCj4gaW5kZXggYTgxY2U3YTc0MGI5Li5kNDE5NTg2ZDY2
OGQgMTAwNjQ0DQo+IC0tLSBhL2ZzL2hmcy9pbm9kZS5jDQo+ICsrKyBiL2ZzL2hmcy9pbm9kZS5j
DQo+IEBAIC02OTAsNyArNjkwLDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBmaWxlX29wZXJhdGlv
bnMgaGZzX2ZpbGVfb3BlcmF0aW9ucyA9IHsNCj4gIAkubGxzZWVrCQk9IGdlbmVyaWNfZmlsZV9s
bHNlZWssDQo+ICAJLnJlYWRfaXRlcgk9IGdlbmVyaWNfZmlsZV9yZWFkX2l0ZXIsDQo+ICAJLndy
aXRlX2l0ZXIJPSBnZW5lcmljX2ZpbGVfd3JpdGVfaXRlciwNCj4gLQkubW1hcAkJPSBnZW5lcmlj
X2ZpbGVfbW1hcCwNCj4gKwkubW1hcF9wcmVwYXJlCT0gZ2VuZXJpY19maWxlX21tYXBfcHJlcGFy
ZSwNCj4gIAkuc3BsaWNlX3JlYWQJPSBmaWxlbWFwX3NwbGljZV9yZWFkLA0KPiAgCS5mc3luYwkJ
PSBoZnNfZmlsZV9mc3luYywNCj4gIAkub3BlbgkJPSBoZnNfZmlsZV9vcGVuLA0KPiBkaWZmIC0t
Z2l0IGEvZnMvaGZzcGx1cy9pbm9kZS5jIGIvZnMvaGZzcGx1cy9pbm9kZS5jDQo+IGluZGV4IGYz
MzFlOTU3NDIxNy4uMGFmN2UzMDI3MzBjIDEwMDY0NA0KPiAtLS0gYS9mcy9oZnNwbHVzL2lub2Rl
LmMNCj4gKysrIGIvZnMvaGZzcGx1cy9pbm9kZS5jDQo+IEBAIC0zNjYsNyArMzY2LDcgQEAgc3Rh
dGljIGNvbnN0IHN0cnVjdCBmaWxlX29wZXJhdGlvbnMgaGZzcGx1c19maWxlX29wZXJhdGlvbnMg
PSB7DQo+ICAJLmxsc2VlawkJPSBnZW5lcmljX2ZpbGVfbGxzZWVrLA0KPiAgCS5yZWFkX2l0ZXIJ
PSBnZW5lcmljX2ZpbGVfcmVhZF9pdGVyLA0KPiAgCS53cml0ZV9pdGVyCT0gZ2VuZXJpY19maWxl
X3dyaXRlX2l0ZXIsDQo+IC0JLm1tYXAJCT0gZ2VuZXJpY19maWxlX21tYXAsDQo+ICsJLm1tYXBf
cHJlcGFyZQk9IGdlbmVyaWNfZmlsZV9tbWFwX3ByZXBhcmUsDQo+ICAJLnNwbGljZV9yZWFkCT0g
ZmlsZW1hcF9zcGxpY2VfcmVhZCwNCj4gIAkuZnN5bmMJCT0gaGZzcGx1c19maWxlX2ZzeW5jLA0K
PiAgCS5vcGVuCQk9IGhmc3BsdXNfZmlsZV9vcGVuLA0KDQpMb29rcyBnb29kIGZvciBIRlMvSEZT
Ky4NCg0KUmV2aWV3ZWQtYnk6IFZpYWNoZXNsYXYgRHViZXlrbyA8U2xhdmEuRHViZXlrb0BpYm0u
Y29tPg0KDQpUaGFua3MsDQpTbGF2YS4NCg0KPiBkaWZmIC0tZ2l0IGEvZnMvaG9zdGZzL2hvc3Rm
c19rZXJuLmMgYi9mcy9ob3N0ZnMvaG9zdGZzX2tlcm4uYw0KPiBpbmRleCA3MDJjNDEzMTc1ODku
LmJjMjJiNmNjNzJhZiAxMDA2NDQNCj4gLS0tIGEvZnMvaG9zdGZzL2hvc3Rmc19rZXJuLmMNCj4g
KysrIGIvZnMvaG9zdGZzL2hvc3Rmc19rZXJuLmMNCj4gQEAgLTM4Miw3ICszODIsNyBAQCBzdGF0
aWMgY29uc3Qgc3RydWN0IGZpbGVfb3BlcmF0aW9ucyBob3N0ZnNfZmlsZV9mb3BzID0gew0KPiAg
CS5zcGxpY2Vfd3JpdGUJPSBpdGVyX2ZpbGVfc3BsaWNlX3dyaXRlLA0KPiAgCS5yZWFkX2l0ZXIJ
PSBnZW5lcmljX2ZpbGVfcmVhZF9pdGVyLA0KPiAgCS53cml0ZV9pdGVyCT0gZ2VuZXJpY19maWxl
X3dyaXRlX2l0ZXIsDQo+IC0JLm1tYXAJCT0gZ2VuZXJpY19maWxlX21tYXAsDQo+ICsJLm1tYXBf
cHJlcGFyZQk9IGdlbmVyaWNfZmlsZV9tbWFwX3ByZXBhcmUsDQo+ICAJLm9wZW4JCT0gaG9zdGZz
X29wZW4sDQo+ICAJLnJlbGVhc2UJPSBob3N0ZnNfZmlsZV9yZWxlYXNlLA0KPiAgCS5mc3luYwkJ
PSBob3N0ZnNfZnN5bmMsDQo+IGRpZmYgLS1naXQgYS9mcy9ocGZzL2ZpbGUuYyBiL2ZzL2hwZnMv
ZmlsZS5jDQo+IGluZGV4IDQ0OWEzZmMxYjhkOS4uYTFhNDRlM2VkYjE5IDEwMDY0NA0KPiAtLS0g
YS9mcy9ocGZzL2ZpbGUuYw0KPiArKysgYi9mcy9ocGZzL2ZpbGUuYw0KPiBAQCAtMjU1LDcgKzI1
NSw3IEBAIGNvbnN0IHN0cnVjdCBmaWxlX29wZXJhdGlvbnMgaHBmc19maWxlX29wcyA9DQo+ICAJ
Lmxsc2VlawkJPSBnZW5lcmljX2ZpbGVfbGxzZWVrLA0KPiAgCS5yZWFkX2l0ZXIJPSBnZW5lcmlj
X2ZpbGVfcmVhZF9pdGVyLA0KPiAgCS53cml0ZV9pdGVyCT0gZ2VuZXJpY19maWxlX3dyaXRlX2l0
ZXIsDQo+IC0JLm1tYXAJCT0gZ2VuZXJpY19maWxlX21tYXAsDQo+ICsJLm1tYXBfcHJlcGFyZQk9
IGdlbmVyaWNfZmlsZV9tbWFwX3ByZXBhcmUsDQo+ICAJLnJlbGVhc2UJPSBocGZzX2ZpbGVfcmVs
ZWFzZSwNCj4gIAkuZnN5bmMJCT0gaHBmc19maWxlX2ZzeW5jLA0KPiAgCS5zcGxpY2VfcmVhZAk9
IGZpbGVtYXBfc3BsaWNlX3JlYWQsDQo+IGRpZmYgLS1naXQgYS9mcy9qZmZzMi9maWxlLmMgYi9m
cy9qZmZzMi9maWxlLmMNCj4gaW5kZXggMTNjMThjY2MxM2IwLi4xZTA1ZjdmZTVkZDQgMTAwNjQ0
DQo+IC0tLSBhL2ZzL2pmZnMyL2ZpbGUuYw0KPiArKysgYi9mcy9qZmZzMi9maWxlLmMNCj4gQEAg
LTU0LDcgKzU0LDcgQEAgY29uc3Qgc3RydWN0IGZpbGVfb3BlcmF0aW9ucyBqZmZzMl9maWxlX29w
ZXJhdGlvbnMgPQ0KPiAgIAkucmVhZF9pdGVyID0JZ2VuZXJpY19maWxlX3JlYWRfaXRlciwNCj4g
ICAJLndyaXRlX2l0ZXIgPQlnZW5lcmljX2ZpbGVfd3JpdGVfaXRlciwNCj4gIAkudW5sb2NrZWRf
aW9jdGw9amZmczJfaW9jdGwsDQo+IC0JLm1tYXAgPQkJZ2VuZXJpY19maWxlX3JlYWRvbmx5X21t
YXAsDQo+ICsJLm1tYXBfcHJlcGFyZSA9CWdlbmVyaWNfZmlsZV9yZWFkb25seV9tbWFwX3ByZXBh
cmUsDQo+ICAJLmZzeW5jID0JamZmczJfZnN5bmMsDQo+ICAJLnNwbGljZV9yZWFkID0JZmlsZW1h
cF9zcGxpY2VfcmVhZCwNCj4gIAkuc3BsaWNlX3dyaXRlID0gaXRlcl9maWxlX3NwbGljZV93cml0
ZSwNCj4gZGlmZiAtLWdpdCBhL2ZzL2pmcy9maWxlLmMgYi9mcy9qZnMvZmlsZS5jDQo+IGluZGV4
IDAxYjY5MTJlNjBmOC4uNWU0Nzk1MWRiNjMwIDEwMDY0NA0KPiAtLS0gYS9mcy9qZnMvZmlsZS5j
DQo+ICsrKyBiL2ZzL2pmcy9maWxlLmMNCj4gQEAgLTE0Myw3ICsxNDMsNyBAQCBjb25zdCBzdHJ1
Y3QgZmlsZV9vcGVyYXRpb25zIGpmc19maWxlX29wZXJhdGlvbnMgPSB7DQo+ICAJLmxsc2VlawkJ
PSBnZW5lcmljX2ZpbGVfbGxzZWVrLA0KPiAgCS5yZWFkX2l0ZXIJPSBnZW5lcmljX2ZpbGVfcmVh
ZF9pdGVyLA0KPiAgCS53cml0ZV9pdGVyCT0gZ2VuZXJpY19maWxlX3dyaXRlX2l0ZXIsDQo+IC0J
Lm1tYXAJCT0gZ2VuZXJpY19maWxlX21tYXAsDQo+ICsJLm1tYXBfcHJlcGFyZQk9IGdlbmVyaWNf
ZmlsZV9tbWFwX3ByZXBhcmUsDQo+ICAJLnNwbGljZV9yZWFkCT0gZmlsZW1hcF9zcGxpY2VfcmVh
ZCwNCj4gIAkuc3BsaWNlX3dyaXRlCT0gaXRlcl9maWxlX3NwbGljZV93cml0ZSwNCj4gIAkuZnN5
bmMJCT0gamZzX2ZzeW5jLA0KPiBkaWZmIC0tZ2l0IGEvZnMvbWluaXgvZmlsZS5jIGIvZnMvbWlu
aXgvZmlsZS5jDQo+IGluZGV4IDkwNmQxOTJhYjdmMy4uZGNhN2FjNzFmMDQ5IDEwMDY0NA0KPiAt
LS0gYS9mcy9taW5peC9maWxlLmMNCj4gKysrIGIvZnMvbWluaXgvZmlsZS5jDQo+IEBAIC0xNyw3
ICsxNyw3IEBAIGNvbnN0IHN0cnVjdCBmaWxlX29wZXJhdGlvbnMgbWluaXhfZmlsZV9vcGVyYXRp
b25zID0gew0KPiAgCS5sbHNlZWsJCT0gZ2VuZXJpY19maWxlX2xsc2VlaywNCj4gIAkucmVhZF9p
dGVyCT0gZ2VuZXJpY19maWxlX3JlYWRfaXRlciwNCj4gIAkud3JpdGVfaXRlcgk9IGdlbmVyaWNf
ZmlsZV93cml0ZV9pdGVyLA0KPiAtCS5tbWFwCQk9IGdlbmVyaWNfZmlsZV9tbWFwLA0KPiArCS5t
bWFwX3ByZXBhcmUJPSBnZW5lcmljX2ZpbGVfbW1hcF9wcmVwYXJlLA0KPiAgCS5mc3luYwkJPSBn
ZW5lcmljX2ZpbGVfZnN5bmMsDQo+ICAJLnNwbGljZV9yZWFkCT0gZmlsZW1hcF9zcGxpY2VfcmVh
ZCwNCj4gIH07DQo+IGRpZmYgLS1naXQgYS9mcy9vbWZzL2ZpbGUuYyBiL2ZzL29tZnMvZmlsZS5j
DQo+IGluZGV4IDk4MzU4ZDQwNWI2YS4uMzE5YzA0ZTYzOTY0IDEwMDY0NA0KPiAtLS0gYS9mcy9v
bWZzL2ZpbGUuYw0KPiArKysgYi9mcy9vbWZzL2ZpbGUuYw0KPiBAQCAtMzMyLDcgKzMzMiw3IEBA
IGNvbnN0IHN0cnVjdCBmaWxlX29wZXJhdGlvbnMgb21mc19maWxlX29wZXJhdGlvbnMgPSB7DQo+
ICAJLmxsc2VlayA9IGdlbmVyaWNfZmlsZV9sbHNlZWssDQo+ICAJLnJlYWRfaXRlciA9IGdlbmVy
aWNfZmlsZV9yZWFkX2l0ZXIsDQo+ICAJLndyaXRlX2l0ZXIgPSBnZW5lcmljX2ZpbGVfd3JpdGVf
aXRlciwNCj4gLQkubW1hcCA9IGdlbmVyaWNfZmlsZV9tbWFwLA0KPiArCS5tbWFwX3ByZXBhcmUg
PSBnZW5lcmljX2ZpbGVfbW1hcF9wcmVwYXJlLA0KPiAgCS5mc3luYyA9IGdlbmVyaWNfZmlsZV9m
c3luYywNCj4gIAkuc3BsaWNlX3JlYWQgPSBmaWxlbWFwX3NwbGljZV9yZWFkLA0KPiAgfTsNCj4g
ZGlmZiAtLWdpdCBhL2ZzL3JhbWZzL2ZpbGUtbW11LmMgYi9mcy9yYW1mcy9maWxlLW1tdS5jDQo+
IGluZGV4IGI0NWM3ZWRjMzIyNS4uYjExZjViMjBiNzhiIDEwMDY0NA0KPiAtLS0gYS9mcy9yYW1m
cy9maWxlLW1tdS5jDQo+ICsrKyBiL2ZzL3JhbWZzL2ZpbGUtbW11LmMNCj4gQEAgLTQxLDcgKzQx
LDcgQEAgc3RhdGljIHVuc2lnbmVkIGxvbmcgcmFtZnNfbW11X2dldF91bm1hcHBlZF9hcmVhKHN0
cnVjdCBmaWxlICpmaWxlLA0KPiAgY29uc3Qgc3RydWN0IGZpbGVfb3BlcmF0aW9ucyByYW1mc19m
aWxlX29wZXJhdGlvbnMgPSB7DQo+ICAJLnJlYWRfaXRlcgk9IGdlbmVyaWNfZmlsZV9yZWFkX2l0
ZXIsDQo+ICAJLndyaXRlX2l0ZXIJPSBnZW5lcmljX2ZpbGVfd3JpdGVfaXRlciwNCj4gLQkubW1h
cAkJPSBnZW5lcmljX2ZpbGVfbW1hcCwNCj4gKwkubW1hcF9wcmVwYXJlCT0gZ2VuZXJpY19maWxl
X21tYXBfcHJlcGFyZSwNCj4gIAkuZnN5bmMJCT0gbm9vcF9mc3luYywNCj4gIAkuc3BsaWNlX3Jl
YWQJPSBmaWxlbWFwX3NwbGljZV9yZWFkLA0KPiAgCS5zcGxpY2Vfd3JpdGUJPSBpdGVyX2ZpbGVf
c3BsaWNlX3dyaXRlLA0KPiBkaWZmIC0tZ2l0IGEvZnMvcmVhZF93cml0ZS5jIGIvZnMvcmVhZF93
cml0ZS5jDQo+IGluZGV4IDBlZjcwZTEyOGM0YS4uODBmZGFiOTlmOWU0IDEwMDY0NA0KPiAtLS0g
YS9mcy9yZWFkX3dyaXRlLmMNCj4gKysrIGIvZnMvcmVhZF93cml0ZS5jDQo+IEBAIC0yOCw3ICsy
OCw3IEBADQo+ICBjb25zdCBzdHJ1Y3QgZmlsZV9vcGVyYXRpb25zIGdlbmVyaWNfcm9fZm9wcyA9
IHsNCj4gIAkubGxzZWVrCQk9IGdlbmVyaWNfZmlsZV9sbHNlZWssDQo+ICAJLnJlYWRfaXRlcgk9
IGdlbmVyaWNfZmlsZV9yZWFkX2l0ZXIsDQo+IC0JLm1tYXAJCT0gZ2VuZXJpY19maWxlX3JlYWRv
bmx5X21tYXAsDQo+ICsJLm1tYXBfcHJlcGFyZQk9IGdlbmVyaWNfZmlsZV9yZWFkb25seV9tbWFw
X3ByZXBhcmUsDQo+ICAJLnNwbGljZV9yZWFkCT0gZmlsZW1hcF9zcGxpY2VfcmVhZCwNCj4gIH07
DQo+ICANCj4gZGlmZiAtLWdpdCBhL2ZzL3Vmcy9maWxlLmMgYi9mcy91ZnMvZmlsZS5jDQo+IGlu
ZGV4IDQ4N2FkMWZjMmRlNi4uYzJhMzkxYzE3ZGY3IDEwMDY0NA0KPiAtLS0gYS9mcy91ZnMvZmls
ZS5jDQo+ICsrKyBiL2ZzL3Vmcy9maWxlLmMNCj4gQEAgLTM4LDcgKzM4LDcgQEAgY29uc3Qgc3Ry
dWN0IGZpbGVfb3BlcmF0aW9ucyB1ZnNfZmlsZV9vcGVyYXRpb25zID0gew0KPiAgCS5sbHNlZWsJ
CT0gZ2VuZXJpY19maWxlX2xsc2VlaywNCj4gIAkucmVhZF9pdGVyCT0gZ2VuZXJpY19maWxlX3Jl
YWRfaXRlciwNCj4gIAkud3JpdGVfaXRlcgk9IGdlbmVyaWNfZmlsZV93cml0ZV9pdGVyLA0KPiAt
CS5tbWFwCQk9IGdlbmVyaWNfZmlsZV9tbWFwLA0KPiArCS5tbWFwX3ByZXBhcmUJPSBnZW5lcmlj
X2ZpbGVfbW1hcF9wcmVwYXJlLA0KPiAgCS5vcGVuICAgICAgICAgICA9IGdlbmVyaWNfZmlsZV9v
cGVuLA0KPiAgCS5mc3luYwkJPSBnZW5lcmljX2ZpbGVfZnN5bmMsDQo+ICAJLnNwbGljZV9yZWFk
CT0gZmlsZW1hcF9zcGxpY2VfcmVhZCwNCg0KLS0gDQpWaWFjaGVzbGF2IER1YmV5a28gPFNsYXZh
LkR1YmV5a29AaWJtLmNvbT4NCg==

