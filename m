Return-Path: <linux-fsdevel+bounces-51824-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 755EEADBD94
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 01:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 090373B1C4C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 23:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D94233156;
	Mon, 16 Jun 2025 23:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ahc5gu2x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E390921FF5E;
	Mon, 16 Jun 2025 23:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750116384; cv=fail; b=dYoKlAQs1lxOVAE93y563NWJi6JxM8PdgXcGKjuccMxuQtk0x/O9qicoWo+z8vLBXof83IpbYohyVGZf4BOkxnx6M+oVRsC1WLco5DyWnPThDKP8MHWJ2oCisa/l7MC074TQshFwksgXy0S/qK6millv9RruQOL4iNDfsUpjlUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750116384; c=relaxed/simple;
	bh=1ehfBeMGlLVdajdgi7FaAvbnd2MoSbY04G9HjPScQNw=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=o+m8TNBsFGa5atIpsCLky3o2Q/YePMeXDuXHZghGQIKL73pKVq0BtuQASWEp/oTLnrTzzDFT+Pr9Fb6QSa9nkcN3wJWHfM7Brevic4Y9bIselS7pB7Ie6MFHzS22zwu28x3g8iPxkXrupqo6M4pDd3gqWobEWv1qtji9Q3ymSnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ahc5gu2x; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55GGkTwO032543;
	Mon, 16 Jun 2025 23:24:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=1ehfBeMGlLVdajdgi7FaAvbnd2MoSbY04G9HjPScQNw=; b=Ahc5gu2x
	OcmLA1MoGDvEtUjNvD/zKTD6y1NrD7YLqkpBWQCV5JlD6PXqkHmfAuM9E45CPgkS
	NvkufXBzanpDQgCYXPR5fyxCC6zfYUJ+7CpFJj7xwXhwkY1NpWunjdQ97Dl3tvc7
	w4xmzorTDsAcFskSU41ud3ofzmHTBx1Nk7yuhSstxblq/J+m4OAiBwWHmQvGSgSu
	22wzo413+Lez2v4P6Zb4A7cylMkaoLnvjy4O0DvzqzGpwAa74RzjcvCELxRbOMVU
	rMcZBlgUYWJL8ypntTm7hmzRsbshA9QLW718A9/o7XQrcllV1iwPbh3MoggoUdZN
	mHnEbxsEDH4pKg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4790ktcxmt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Jun 2025 23:24:37 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55GNOZbI002374;
	Mon, 16 Jun 2025 23:24:35 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4790ktcxmg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Jun 2025 23:24:35 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PW6rHPijhiWt2lKsHVAonrIuYA0/xuV1MoH/X8ydY5ACCTKAiD1a5KbK+865WaeLSUWeCl+13KPQfs78lWC9xRCFC6CkJF8DjZeZDKTCqGcQP2MLXl8F0o2ctsE+zbqic0UhzT/+jcztnYnLLq9oVuC6hVikZ2fyUk8btl1/0TeE69KC+13gDbBUpmnEScxh+Ow0xI4diTxQ2Wh3W6L4cF7yqUjc1F8KYDbFhmiFYnARnfh97KQxR8wUQM3I9o/jqUkuvhvIuCJUNw7MYnRLJLzL4CDkdB28sgocI6Y6yTuLVlab2bDPwRvtbZbgTmV0G1w8qyQKSmvlTKiVnrV44w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ehfBeMGlLVdajdgi7FaAvbnd2MoSbY04G9HjPScQNw=;
 b=RZ+JA5TUw0vHtUuvUyeq0OZHSSYrhjHjUrfpr+/KmZ32VWq43ZobMoPayZcMu7YImqC82WZgmA7L1M15fSSK2i8I1+lO+DNCUcanp+A0+IHB5fbQvJUzdZcA2cQD1Bo8rkJlOd0TH8TUEvLlwZlY4metLG1OVPL8r2FVJYqvJ4Buj58cEmxzfRu7Go+zWByZUr+6LUy8Pp4cymukuw53faz6jx7zBIR6tW7mZtFFtdf/+7S27+AKnSSvoNdCd6Rsts+v/ZeC4pPqTLOX20tylnEp3UFZtvFRL+rAQhUq3a/qEEMEoPUY3e0n+ebCbJ4lalNxugNuunaUilWBmGhRmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SJ2PR15MB6467.namprd15.prod.outlook.com (2603:10b6:a03:577::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Mon, 16 Jun
 2025 23:24:32 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%7]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 23:24:32 +0000
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
Thread-Topic: [EXTERNAL] [PATCH 10/10] fs: replace mmap hook with
 .mmap_prepare for simple mappings
Thread-Index: AQHb3vZx8Uzd4BPYl06lrWB3xbhAlLQGbbKA
Date: Mon, 16 Jun 2025 23:24:31 +0000
Message-ID: <30a9d9f8870478d50310f52fb14c8ea91dc1a692.camel@ibm.com>
References: <cover.1750099179.git.lorenzo.stoakes@oracle.com>
	 <f528ac4f35b9378931bd800920fee53fc0c5c74d.1750099179.git.lorenzo.stoakes@oracle.com>
In-Reply-To:
 <f528ac4f35b9378931bd800920fee53fc0c5c74d.1750099179.git.lorenzo.stoakes@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SJ2PR15MB6467:EE_
x-ms-office365-filtering-correlation-id: 2752ec89-5b88-42f6-dbc5-08ddad2cf2dc
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dFNPK0hiMmdvRW91d2NmN0JTQlh6TVYzdXFpTExzSnVicWRpTHJuWndobm11?=
 =?utf-8?B?TWU1Y1pJeDFaQkYrSjZKNGgzTG8xQm0zeWJjamQ0L0JmMm1MQmJWZCtzV0lT?=
 =?utf-8?B?NnpzQmtuZkE3Uy8vOHVqbXhPUHFvblo5amFCZnZBRzdVakJtNHNtM3pZMW1C?=
 =?utf-8?B?UkkyM1VhY0xDK3BXbkkyU1pGdlgwSGRyRjdNSUZxT0tvVU9SaW1GLzhhYitS?=
 =?utf-8?B?eEdtSGxtN1JUc2plM0pvWkhWTytBbTVnRlN5OFpzL0twYmxGTkZtb3dKSHdP?=
 =?utf-8?B?Y3dObWloWXpkOG1UcTMzYTdva05vOHRYZGhmNVJPMzFDUndHN3VHVG9MalpZ?=
 =?utf-8?B?UEpnT0duekl3UzVzNG0razBPeG1NbFcxbitKQ3ppYjB6TVlFTVB0d3ZoVzBI?=
 =?utf-8?B?RFFUdHh5aWN2YWZKV0k3eldxbUpTampIWTdXRXVUTjBFM2JqQzRjYlY2d0Jm?=
 =?utf-8?B?QVVsMXc0ZVZrUDFwQVdKSnhaZ1BUSE80dElLd3FwOWEvbzNDbUYwRFV2eWYw?=
 =?utf-8?B?SG4wNDM4VTlvWHdZYUc3eE01Ty91cUg4TjFRYXRiL0RNOGs3Zm0vTnJOUVlO?=
 =?utf-8?B?VmlTalg0V2pmeUdJOUVjdE5oc2hWWDl4VUd3WW9CM1BDNWlxbkFLQzM2cEls?=
 =?utf-8?B?MXRXYUNObWg2YkNyeS9zSGxhTE9TMkpZdTJ3MlRmZDFPLzFHWVFmeVRvTGRi?=
 =?utf-8?B?ekJncWxzOU9LT1A0dFpEMWo0QzhORVUxampTdTF5RVhZWk42LzRCU1NnQjcy?=
 =?utf-8?B?bCt1NEpKb0NuTS9QODRURWk4eUYyczBMRkxlbEdscTZsWm5pT2NPSUNzaks5?=
 =?utf-8?B?NW5vZkM5KzVvZmNLVGpMNGRQckpTTVZVTWVCa2R0c0wva1A1a3k5b2UvQ3d5?=
 =?utf-8?B?eWpwWURjQ1FIb0Z2M0E3czZrcHpjcTV2cjhQeXh0eXhBd2h4WlFxdDJOMVo5?=
 =?utf-8?B?UUQ4OUEvUXM3Y0tGR3VlczNNYTQrN2lXd3RZVmhXNWpLSHpNeTZrbDZESzRN?=
 =?utf-8?B?ZnQxcU9ROGU3VWxQYUQ1SzROQnJkNjFJLytpYWZ6MGF4eG9US3FRMDBibzcw?=
 =?utf-8?B?ektvNHcyaWRuLytOQjh0U2drMkVHdU9IVm13ZHkzSENpbFBnU0JvVkVpUm9K?=
 =?utf-8?B?MXRJOVl5eU52N3VZSlZpZVNZTlFuYWJxVGxZWlRkMUlkajJPb1pYUUg4K2N6?=
 =?utf-8?B?V2xicy9YWGk5bGN0VE51L2t1S2pZVkxhZVl5eVF3OURicHBPSVRMV3ArWU82?=
 =?utf-8?B?N3VndWVpd2x5eHV1bmVZYlM5cEUrTGZDNXVQRlVhRHgwK1NGMmkrYVpkd1NG?=
 =?utf-8?B?Ukw3ckRnRXREQ0JkZVVSdTliaEFHQjV5VmFPZ1YwOVVLNkc4enVxU1hTc3JL?=
 =?utf-8?B?TWNxUlMzQTIzN2NHN2c0NWlwTjRwam1JRUpjcGg2WG9QWnZMTWJ6TEJ3LzRs?=
 =?utf-8?B?RmhTdEdtamhYcytmd0RUdHVCbElxcmp1ZDZsd3ZqdjJZa2JZbGdsODJNTitl?=
 =?utf-8?B?NTVDN045aDZOSjVrRlJyNHB5RTVrMzEyTDM5TTNEQXBiVkhibEY4OU5veVRG?=
 =?utf-8?B?UUhuK0Rab2hnNVF5L0lGaE5NQXAyUk1xOFZGT2M5ZG9SYlBBZWFqa0JCQzZG?=
 =?utf-8?B?Z3pHakZBRzBFOE5IS2wvLzZoSWZZYWZHZFN6ZjRTcjBrdzY0QzhFN3ZvcGtC?=
 =?utf-8?B?cmNuWkFFOTdvRzlMRk0zaW80Qi9GMW9OeVBQUVdwWlRGYU5vZndqNVlUd2dj?=
 =?utf-8?B?U0pVaTV3M0N2alljTGV0N2wyZzI2L0h1SE5RNzVaZkNIMFhKT3dzb01aOGZh?=
 =?utf-8?B?b0dzK0xON20zVEk0NVlSNUR3ZG9nMEVrVWhzZlpqYWIrM2t1aXA0T05ydUZj?=
 =?utf-8?B?YXgyMGMwc0ZobnBOOUNSWUlWaXNubWFSWG5IQ083WFA2SEora3Q5TjVoNGRh?=
 =?utf-8?B?OG8zVFJpbHBiRUh5OUdxMlAzZjdCQml2dmZ4SFBQb1h6Nm9RclBOOGRBMEI1?=
 =?utf-8?B?OTBtTW1HRm1nPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cDJJVDBrN1JabmJRWTY0cDZ2QzF1QmRTQm5mVmhxRGxLZG1kZktPUlNqUFlx?=
 =?utf-8?B?VVZWa2J6aXlqMUh5dDBhTU1wNUsxL2Zrckk4bzNzMFpTUnUybEZyaVUvclBI?=
 =?utf-8?B?ekhJdkRyUTIxRUFuRGRuRTcvTFlEK0JmMlE3cU1kTUZoRkxvYU9lZkRqNSs1?=
 =?utf-8?B?NTd4T2FieEUydGNkTE4xSmZnSTFZSzUyaWFrTVB4Q1lJVDBDWWdtU1Q1b1Fa?=
 =?utf-8?B?VWpRUnA4KzhIaEdOME1QeDJvMzV2dDd4aGlNU25XMmQwYXViN2VadVhTQ3U1?=
 =?utf-8?B?MUpZVnlVeXdPbEs4cUlsdUhZbitiUEtRSjhHQUZvL2ZvQUdRWnNKR2ZFUjJz?=
 =?utf-8?B?SzZQNjlLdmlpR1d0UVgza0hIZjNuRHE0YjgvU2xNTEJjTW91Tlg4clpMZm1t?=
 =?utf-8?B?T0VXaEIxTHhHeXcxYWlYbk9ZRDBmTmZZdW53UXRmWnJnYncra3J0RGNURFdR?=
 =?utf-8?B?RC9VaGRHZzM4emlkQ0dzVlB3WFJSL1pCVUhBN1d0ZEhtNnltZmR3QTUxbCt2?=
 =?utf-8?B?MGxBUUJKKzdvNHdBNG9WRGhxRHR0T2cyaEN6anExKytONXB0emcyNjNHSzhW?=
 =?utf-8?B?M3BFWTFyQTUwUktUVEJzYy9TQnJ5czlkK21oZTNLTmVERHRGNnBKUmh1VFEw?=
 =?utf-8?B?UVNHUTZORm1tQWNjV3lSRks5V2I0bEVRTGN6dlg0cDYyNEswL2tPZUp2eFRj?=
 =?utf-8?B?VWwwWThLYklHbEIxUmN2eXRMYSt5K0ZuZW1UMjR3aDh2Uzk0VUxQL2E3VFdE?=
 =?utf-8?B?TE0yTWVHZmZBakdjQ1E2bnkrZGl0YWlIRlY0N1h2MGIzbStQR09PYmR0V2dL?=
 =?utf-8?B?MUFMWU90ODkwd0JaNTJFL1ZBckZvK0RsMDRydktqZkpUSjEvQnB2V05IMjdX?=
 =?utf-8?B?NWN6UlU1WHkrRjVheXN6eGRYM2tQOU5wZkF2Q3Q3bjVIUUFMajNCbWpob2w3?=
 =?utf-8?B?SFBPQ0NYVGdLSFY2WHVFR0lNS0VnTzNDeEhENmZJY3Fqamppb2xXbFVQRGJj?=
 =?utf-8?B?NjRjbU5YVkszK2FYT2V3aGJzSWdEQ05LOFNnTndwUTFnQURJZmNJdXNHSGdk?=
 =?utf-8?B?SE9zaThXam13STBBQ1ByaUhYTTRBaElaL01ZU3dmdlg0Y21ZZUdrMkRpNUcr?=
 =?utf-8?B?Qm1XWk81VFc4ZGhrellyYVFKSTNucGptWDdJUDF1amE3K3ZWTHdLTWhsVUVC?=
 =?utf-8?B?NWRFY29jVGd3eXUvQlh6MnZWODBuQ1VYS002aW1sQi8rRFdUS2xMS1lSSmJt?=
 =?utf-8?B?SHJkcHZzUjRNMFE5Uml3UWRFTmI5UWE3YlE5aHVCdkFLbWRXeGFFWmJPcEJv?=
 =?utf-8?B?cnpuUFYxaHo1TWwvUmhBTThjQTVGaXF0cllGOThBWGRudGQ2MEgxNk1ZUURv?=
 =?utf-8?B?UHZSdnIxR2g3YUVPZTVIc0pxMG9aSU0rNmJQNGJCTkJPZUExU2xqbndaY3d6?=
 =?utf-8?B?Zlo2SGU3Q3Yrc1FXUStuOTdSK0lxZjJ0OGEwL2ZuZnJWOWVBRWxFbS8wR0dh?=
 =?utf-8?B?OUpLU0FJc2wwYU1RSzhzOVZDYTFxa3JENHJBMHpheFdzS2ppY3ZwN1BlWlg2?=
 =?utf-8?B?aE1JaXFyeGdKV2d2L1hOM05kSm42Y3hQMXRxTU9jajRnam9wbUxiWHR4Wjh2?=
 =?utf-8?B?MGxUMWt4VkdoU1ZkRzVJYmxUdkRkMjVUQ1NtYVZUUndPcUdTbjE0L0lwRUhU?=
 =?utf-8?B?aEs2TEFoemJWaC9seDFRQW5ES2RBUlN4U2x3UHJ0UC9OU0U3WkhUSEFrQ08v?=
 =?utf-8?B?dldQemYyUkxLcWQ1b2Jzelh4R1lTcnhLb2R2RExXR0hwRnhKNE1hcWRqcGs0?=
 =?utf-8?B?dEJPdlpRM0JYbHpOTGdBR2lNT1VRaFFsRFpiMnE4MmlkSHZRQU1PRGI2cFFV?=
 =?utf-8?B?TVhnU0ZxS0hmNVB3dXlsM3hvN3RPWVZ2b3VsWHBIRjM5QktadWdYM2pZb2hw?=
 =?utf-8?B?WGJSK2tuOHpEbWRMUDB6ZFZNeFlrcnlwekhlTHRkdXplZDNZMDlkK09Kc2p6?=
 =?utf-8?B?b3FrMllOSVYrM0FPYXROM0dsVFdLTHIvd2svd0NOcVlhSWRmTzB0ZWNiYW8z?=
 =?utf-8?B?ZlNMM0F3d0ZvZW9NWHV5azErcEZkWE1JaGpPQkx1N0wvUEkxTWpreW9MMCtn?=
 =?utf-8?B?NG0wdEs3cDUzcHpqUDVmNHNodjZGazlEdzRTSEtwWFVud2lxcy8xUjdreTB6?=
 =?utf-8?Q?eyt4qxWMntQxUeaEQJCLC9Q=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B5795FE82260E94297DB17965CE801DF@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2752ec89-5b88-42f6-dbc5-08ddad2cf2dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2025 23:24:32.1131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5Jum9vKtwnBAxAWWFqDlX5G/xHqex02gkdP02dr1u1fpVK4tSlvUjOZBb/BBwmq3BrmFd0XiJSB8daZGAe7KHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR15MB6467
X-Proofpoint-GUID: JyS97h1wgNmqS7gN_LSF2yV2TKPXyXu-
X-Proofpoint-ORIG-GUID: 8-wFMIWcG2SCBC29fJ3gCFyOQlo-zVUp
X-Authority-Analysis: v=2.4 cv=KaDSsRYD c=1 sm=1 tr=0 ts=6850a7b5 cx=c_pps a=5RZAJXZTQAV0bSSsSFVBEw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=yPCof4ZbAAAA:8 a=VnNF1IyMAAAA:8 a=rzsLNOH3-ueIZzOSRkoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDE2NyBTYWx0ZWRfX8QEySNkSA+q3 gI8DlNstmVn16Tto7YtyWBU9xyslnmRsv0UF/O3v9NRPXCmeXB3KSr6TLCIrzhw/wpBDr1ZL5EG cYZ1jkCeQ1W+XaEG5uobViZLa1is5pocrRi6/WrOpM0faw7NVbzfT//I52SMbTOV7c4F9tsgePN
 vgfQk7S58xFsdGvA44sogUsbcdJbOCtK/5H8RTZbr2BQa/4YmcxBfJY1s3QHdlGm4B2fYlpx7vs ZNBCfH34YZqrp6Gkrlladxvq4+qujgPpLgrauilnxJsV1szcyQJIYXG917SnMKjg3Hwsrg0dACP wEhcUtEzcz5AkN+OdKqA2KxH3ENozrn1EGkCWyqGTitc+1oGmWpAHNhKXaIaenVxt13Z50V++0z
 GPAsrhnGB9Ttp0YRG54iCnlgax0bBGG/Z3CnD7dAPns5bnHDDy20HJ9uZTEMJW15DKt69wPV
Subject: Re:  [PATCH 10/10] fs: replace mmap hook with .mmap_prepare for simple
 mappings
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_11,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 spamscore=0 clxscore=1011 malwarescore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506160167

T24gTW9uLCAyMDI1LTA2LTE2IGF0IDIwOjMzICswMTAwLCBMb3JlbnpvIFN0b2FrZXMgd3JvdGU6
DQo+IFNpbmNlIGNvbW1pdCBjODRiZjZkZDJiODMgKCJtbTogaW50cm9kdWNlIG5ldyAubW1hcF9w
cmVwYXJlKCkgZmlsZQ0KPiBjYWxsYmFjayIpLCB0aGUgZl9vcC0+bW1hcCgpIGhvb2sgaGFzIGJl
ZW4gZGVwcmVjYXRlZCBpbiBmYXZvdXIgb2YNCj4gZl9vcC0+bW1hcF9wcmVwYXJlKCkuDQo+IA0K
PiBUaGlzIGNhbGxiYWNrIGlzIGludm9rZWQgaW4gdGhlIG1tYXAoKSBsb2dpYyBmYXIgZWFybGll
ciwgc28gZXJyb3IgaGFuZGxpbmcNCj4gY2FuIGJlIHBlcmZvcm1lZCBtb3JlIHNhZmVseSB3aXRo
b3V0IGNvbXBsaWNhdGVkIGFuZCBidWctcHJvbmUgc3RhdGUNCj4gdW53aW5kaW5nIHJlcXVpcmVk
IHNob3VsZCBhbiBlcnJvciBhcmlzZS4NCj4gDQo+IFRoaXMgaG9vayBhbHNvIGF2b2lkcyBwYXNz
aW5nIGEgcG9pbnRlciB0byBhIG5vdC15ZXQtY29ycmVjdGx5LWVzdGFibGlzaGVkDQo+IFZNQSBh
dm9pZGluZyBhbnkgaXNzdWVzIHdpdGggcmVmZXJlbmNpbmcgdGhpcyBkYXRhIHN0cnVjdHVyZS4N
Cj4gDQo+IEl0IHJhdGhlciBwcm92aWRlcyBhIHBvaW50ZXIgdG8gdGhlIG5ldyBzdHJ1Y3Qgdm1f
YXJlYV9kZXNjIGRlc2NyaXB0b3IgdHlwZQ0KPiB3aGljaCBjb250YWlucyBhbGwgcmVxdWlyZWQg
c3RhdGUgYW5kIGFsbG93cyBlYXN5IHNldHRpbmcgb2YgcmVxdWlyZWQNCj4gcGFyYW1ldGVycyB3
aXRob3V0IGFueSBjb25zaWRlcmF0aW9uIG5lZWRpbmcgdG8gYmUgcGFpZCB0byBsb2NraW5nIG9y
DQo+IHJlZmVyZW5jZSBjb3VudHMuDQo+IA0KPiBOb3RlIHRoYXQgbmVzdGVkIGZpbGVzeXN0ZW1z
IGxpa2Ugb3ZlcmxheWZzIGFyZSBjb21wYXRpYmxlIHdpdGggYW4NCj4gLm1tYXBfcHJlcGFyZSgp
IGNhbGxiYWNrIHNpbmNlIGNvbW1pdCBiYjY2NmI3YzI3MDcgKCJtbTogYWRkIG1tYXBfcHJlcGFy
ZSgpDQo+IGNvbXBhdGliaWxpdHkgbGF5ZXIgZm9yIG5lc3RlZCBmaWxlIHN5c3RlbXMiKS4NCj4g
DQo+IEluIHRoaXMgcGF0Y2ggd2UgYXBwbHkgdGhpcyBjaGFuZ2UgdG8gZmlsZSBzeXN0ZW1zIHdp
dGggcmVsYXRpdmVseSBzaW1wbGUNCj4gbW1hcCgpIGhvb2sgbG9naWMgLSBleGZhdCwgY2VwaCwg
ZjJmcywgYmNhY2hlZnMsIHpvbmVmcywgYnRyZnMsIG9jZnMyLA0KPiBvcmFuZ2VmcywgbmlsZnMy
LCByb21mcywgcmFtZnMgYW5kIGFpby4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IExvcmVuem8gU3Rv
YWtlcyA8bG9yZW56by5zdG9ha2VzQG9yYWNsZS5jb20+DQo+IC0tLQ0KPiAgZnMvYWlvLmMgICAg
ICAgICAgICAgIHwgIDggKysrKy0tLS0NCj4gIGZzL2JjYWNoZWZzL2ZzLmMgICAgICB8ICA4ICsr
KystLS0tDQo+ICBmcy9idHJmcy9maWxlLmMgICAgICAgfCAgNyArKysrLS0tDQo+ICBmcy9jZXBo
L2FkZHIuYyAgICAgICAgfCAgNSArKystLQ0KPiAgZnMvY2VwaC9maWxlLmMgICAgICAgIHwgIDIg
Ky0NCj4gIGZzL2NlcGgvc3VwZXIuaCAgICAgICB8ICAyICstDQo+ICBmcy9leGZhdC9maWxlLmMg
ICAgICAgfCAgNyArKysrLS0tDQo+ICBmcy9mMmZzL2ZpbGUuYyAgICAgICAgfCAgNyArKysrLS0t
DQo+ICBmcy9uaWxmczIvZmlsZS5jICAgICAgfCAgOCArKysrLS0tLQ0KPiAgZnMvb2NmczIvZmls
ZS5jICAgICAgIHwgIDQgKystLQ0KPiAgZnMvb2NmczIvbW1hcC5jICAgICAgIHwgIDUgKysrLS0N
Cj4gIGZzL29jZnMyL21tYXAuaCAgICAgICB8ICAyICstDQo+ICBmcy9vcmFuZ2Vmcy9maWxlLmMg
ICAgfCAxMCArKysrKystLS0tDQo+ICBmcy9yYW1mcy9maWxlLW5vbW11LmMgfCAxMiArKysrKyst
LS0tLS0NCj4gIGZzL3JvbWZzL21tYXAtbm9tbXUuYyB8ICA2ICsrKy0tLQ0KPiAgZnMvem9uZWZz
L2ZpbGUuYyAgICAgIHwgMTAgKysrKysrLS0tLQ0KPiAgMTYgZmlsZXMgY2hhbmdlZCwgNTYgaW5z
ZXJ0aW9ucygrKSwgNDcgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZnMvYWlvLmMg
Yi9mcy9haW8uYw0KPiBpbmRleCA3OTNiN2IxNWVjNGIuLjdmYzdiNjIyMTMxMiAxMDA2NDQNCj4g
LS0tIGEvZnMvYWlvLmMNCj4gKysrIGIvZnMvYWlvLmMNCj4gQEAgLTM5MiwxNSArMzkyLDE1IEBA
IHN0YXRpYyBjb25zdCBzdHJ1Y3Qgdm1fb3BlcmF0aW9uc19zdHJ1Y3QgYWlvX3Jpbmdfdm1fb3Bz
ID0gew0KPiAgI2VuZGlmDQo+ICB9Ow0KPiAgDQo+IC1zdGF0aWMgaW50IGFpb19yaW5nX21tYXAo
c3RydWN0IGZpbGUgKmZpbGUsIHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hKQ0KPiArc3RhdGlj
IGludCBhaW9fcmluZ19tbWFwX3ByZXBhcmUoc3RydWN0IHZtX2FyZWFfZGVzYyAqZGVzYykNCj4g
IHsNCj4gLQl2bV9mbGFnc19zZXQodm1hLCBWTV9ET05URVhQQU5EKTsNCj4gLQl2bWEtPnZtX29w
cyA9ICZhaW9fcmluZ192bV9vcHM7DQo+ICsJZGVzYy0+dm1fZmxhZ3MgfD0gVk1fRE9OVEVYUEFO
RDsNCj4gKwlkZXNjLT52bV9vcHMgPSAmYWlvX3Jpbmdfdm1fb3BzOw0KPiAgCXJldHVybiAwOw0K
PiAgfQ0KPiAgDQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IGZpbGVfb3BlcmF0aW9ucyBhaW9fcmlu
Z19mb3BzID0gew0KPiAtCS5tbWFwID0gYWlvX3JpbmdfbW1hcCwNCj4gKwkubW1hcF9wcmVwYXJl
ID0gYWlvX3JpbmdfbW1hcF9wcmVwYXJlLA0KPiAgfTsNCj4gIA0KPiAgI2lmIElTX0VOQUJMRUQo
Q09ORklHX01JR1JBVElPTikNCj4gZGlmZiAtLWdpdCBhL2ZzL2JjYWNoZWZzL2ZzLmMgYi9mcy9i
Y2FjaGVmcy9mcy5jDQo+IGluZGV4IDMwNjNhOGRkYzJkZi4uOWMyMjM4ZWRjMGUzIDEwMDY0NA0K
PiAtLS0gYS9mcy9iY2FjaGVmcy9mcy5jDQo+ICsrKyBiL2ZzL2JjYWNoZWZzL2ZzLmMNCj4gQEAg
LTE1NTMsMTEgKzE1NTMsMTEgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCB2bV9vcGVyYXRpb25zX3N0
cnVjdCBiY2hfdm1fb3BzID0gew0KPiAgCS5wYWdlX21rd3JpdGUgICA9IGJjaDJfcGFnZV9ta3dy
aXRlLA0KPiAgfTsNCj4gIA0KPiAtc3RhdGljIGludCBiY2gyX21tYXAoc3RydWN0IGZpbGUgKmZp
bGUsIHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hKQ0KPiArc3RhdGljIGludCBiY2gyX21tYXBf
cHJlcGFyZShzdHJ1Y3Qgdm1fYXJlYV9kZXNjICpkZXNjKQ0KPiAgew0KPiAtCWZpbGVfYWNjZXNz
ZWQoZmlsZSk7DQo+ICsJZmlsZV9hY2Nlc3NlZChkZXNjLT5maWxlKTsNCj4gIA0KPiAtCXZtYS0+
dm1fb3BzID0gJmJjaF92bV9vcHM7DQo+ICsJZGVzYy0+dm1fb3BzID0gJmJjaF92bV9vcHM7DQo+
ICAJcmV0dXJuIDA7DQo+ICB9DQo+ICANCj4gQEAgLTE3NDAsNyArMTc0MCw3IEBAIHN0YXRpYyBj
b25zdCBzdHJ1Y3QgZmlsZV9vcGVyYXRpb25zIGJjaF9maWxlX29wZXJhdGlvbnMgPSB7DQo+ICAJ
Lmxsc2VlawkJPSBiY2gyX2xsc2VlaywNCj4gIAkucmVhZF9pdGVyCT0gYmNoMl9yZWFkX2l0ZXIs
DQo+ICAJLndyaXRlX2l0ZXIJPSBiY2gyX3dyaXRlX2l0ZXIsDQo+IC0JLm1tYXAJCT0gYmNoMl9t
bWFwLA0KPiArCS5tbWFwX3ByZXBhcmUJPSBiY2gyX21tYXBfcHJlcGFyZSwNCj4gIAkuZ2V0X3Vu
bWFwcGVkX2FyZWEgPSB0aHBfZ2V0X3VubWFwcGVkX2FyZWEsDQo+ICAJLmZzeW5jCQk9IGJjaDJf
ZnN5bmMsDQo+ICAJLnNwbGljZV9yZWFkCT0gZmlsZW1hcF9zcGxpY2VfcmVhZCwNCj4gZGlmZiAt
LWdpdCBhL2ZzL2J0cmZzL2ZpbGUuYyBiL2ZzL2J0cmZzL2ZpbGUuYw0KPiBpbmRleCA4Y2U2ZjQ1
ZjQ1ZTAuLjA2YmQzMGIzNWI5NSAxMDA2NDQNCj4gLS0tIGEvZnMvYnRyZnMvZmlsZS5jDQo+ICsr
KyBiL2ZzL2J0cmZzL2ZpbGUuYw0KPiBAQCAtMTk3OCwxNSArMTk3OCwxNiBAQCBzdGF0aWMgY29u
c3Qgc3RydWN0IHZtX29wZXJhdGlvbnNfc3RydWN0IGJ0cmZzX2ZpbGVfdm1fb3BzID0gew0KPiAg
CS5wYWdlX21rd3JpdGUJPSBidHJmc19wYWdlX21rd3JpdGUsDQo+ICB9Ow0KPiAgDQo+IC1zdGF0
aWMgaW50IGJ0cmZzX2ZpbGVfbW1hcChzdHJ1Y3QgZmlsZQkqZmlscCwgc3RydWN0IHZtX2FyZWFf
c3RydWN0ICp2bWEpDQo+ICtzdGF0aWMgaW50IGJ0cmZzX2ZpbGVfbW1hcF9wcmVwYXJlKHN0cnVj
dCB2bV9hcmVhX2Rlc2MgKmRlc2MpDQo+ICB7DQo+ICsJc3RydWN0IGZpbGUgKmZpbHAgPSBkZXNj
LT5maWxlOw0KPiAgCXN0cnVjdCBhZGRyZXNzX3NwYWNlICptYXBwaW5nID0gZmlscC0+Zl9tYXBw
aW5nOw0KPiAgDQo+ICAJaWYgKCFtYXBwaW5nLT5hX29wcy0+cmVhZF9mb2xpbykNCj4gIAkJcmV0
dXJuIC1FTk9FWEVDOw0KPiAgDQo+ICAJZmlsZV9hY2Nlc3NlZChmaWxwKTsNCj4gLQl2bWEtPnZt
X29wcyA9ICZidHJmc19maWxlX3ZtX29wczsNCj4gKwlkZXNjLT52bV9vcHMgPSAmYnRyZnNfZmls
ZV92bV9vcHM7DQo+ICANCj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4gQEAgLTM3NjUsNyArMzc2Niw3
IEBAIGNvbnN0IHN0cnVjdCBmaWxlX29wZXJhdGlvbnMgYnRyZnNfZmlsZV9vcGVyYXRpb25zID0g
ew0KPiAgCS5zcGxpY2VfcmVhZAk9IGZpbGVtYXBfc3BsaWNlX3JlYWQsDQo+ICAJLndyaXRlX2l0
ZXIJPSBidHJmc19maWxlX3dyaXRlX2l0ZXIsDQo+ICAJLnNwbGljZV93cml0ZQk9IGl0ZXJfZmls
ZV9zcGxpY2Vfd3JpdGUsDQo+IC0JLm1tYXAJCT0gYnRyZnNfZmlsZV9tbWFwLA0KPiArCS5tbWFw
X3ByZXBhcmUJPSBidHJmc19maWxlX21tYXBfcHJlcGFyZSwNCj4gIAkub3BlbgkJPSBidHJmc19m
aWxlX29wZW4sDQo+ICAJLnJlbGVhc2UJPSBidHJmc19yZWxlYXNlX2ZpbGUsDQo+ICAJLmdldF91
bm1hcHBlZF9hcmVhID0gdGhwX2dldF91bm1hcHBlZF9hcmVhLA0KPiBkaWZmIC0tZ2l0IGEvZnMv
Y2VwaC9hZGRyLmMgYi9mcy9jZXBoL2FkZHIuYw0KPiBpbmRleCA2MGE2MjFiMDBjNjUuLjM3NTIy
MTM3YzM4MCAxMDA2NDQNCj4gLS0tIGEvZnMvY2VwaC9hZGRyLmMNCj4gKysrIGIvZnMvY2VwaC9h
ZGRyLmMNCj4gQEAgLTIzMzAsMTMgKzIzMzAsMTQgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCB2bV9v
cGVyYXRpb25zX3N0cnVjdCBjZXBoX3Ztb3BzID0gew0KPiAgCS5wYWdlX21rd3JpdGUJPSBjZXBo
X3BhZ2VfbWt3cml0ZSwNCj4gIH07DQo+ICANCj4gLWludCBjZXBoX21tYXAoc3RydWN0IGZpbGUg
KmZpbGUsIHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hKQ0KPiAraW50IGNlcGhfbW1hcF9wcmVw
YXJlKHN0cnVjdCB2bV9hcmVhX2Rlc2MgKmRlc2MpDQo+ICB7DQo+ICsJc3RydWN0IGZpbGUgKmZp
bGUgPSBkZXNjLT5maWxlOw0KPiAgCXN0cnVjdCBhZGRyZXNzX3NwYWNlICptYXBwaW5nID0gZmls
ZS0+Zl9tYXBwaW5nOw0KPiAgDQo+ICAJaWYgKCFtYXBwaW5nLT5hX29wcy0+cmVhZF9mb2xpbykN
Cj4gIAkJcmV0dXJuIC1FTk9FWEVDOw0KPiAtCXZtYS0+dm1fb3BzID0gJmNlcGhfdm1vcHM7DQo+
ICsJZGVzYy0+dm1fb3BzID0gJmNlcGhfdm1vcHM7DQo+ICAJcmV0dXJuIDA7DQo+ICB9DQo+ICAN
Cj4gZGlmZiAtLWdpdCBhL2ZzL2NlcGgvZmlsZS5jIGIvZnMvY2VwaC9maWxlLmMNCj4gaW5kZXgg
ZDVjNjc0ZDJiYThhLi40MWI4ZWMzM2U4NjQgMTAwNjQ0DQo+IC0tLSBhL2ZzL2NlcGgvZmlsZS5j
DQo+ICsrKyBiL2ZzL2NlcGgvZmlsZS5jDQo+IEBAIC0zMTcwLDcgKzMxNzAsNyBAQCBjb25zdCBz
dHJ1Y3QgZmlsZV9vcGVyYXRpb25zIGNlcGhfZmlsZV9mb3BzID0gew0KPiAgCS5sbHNlZWsgPSBj
ZXBoX2xsc2VlaywNCj4gIAkucmVhZF9pdGVyID0gY2VwaF9yZWFkX2l0ZXIsDQo+ICAJLndyaXRl
X2l0ZXIgPSBjZXBoX3dyaXRlX2l0ZXIsDQo+IC0JLm1tYXAgPSBjZXBoX21tYXAsDQo+ICsJLm1t
YXBfcHJlcGFyZSA9IGNlcGhfbW1hcF9wcmVwYXJlLA0KPiAgCS5mc3luYyA9IGNlcGhfZnN5bmMs
DQo+ICAJLmxvY2sgPSBjZXBoX2xvY2ssDQo+ICAJLnNldGxlYXNlID0gc2ltcGxlX25vc2V0bGVh
c2UsDQo+IGRpZmYgLS1naXQgYS9mcy9jZXBoL3N1cGVyLmggYi9mcy9jZXBoL3N1cGVyLmgNCj4g
aW5kZXggYmIwZGIwY2M4MDAzLi5jZjE3NmFhYjBmODIgMTAwNjQ0DQo+IC0tLSBhL2ZzL2NlcGgv
c3VwZXIuaA0KPiArKysgYi9mcy9jZXBoL3N1cGVyLmgNCj4gQEAgLTEyODYsNyArMTI4Niw3IEBA
IGV4dGVybiB2b2lkIF9fY2VwaF90b3VjaF9mbW9kZShzdHJ1Y3QgY2VwaF9pbm9kZV9pbmZvICpj
aSwNCj4gIC8qIGFkZHIuYyAqLw0KPiAgZXh0ZXJuIGNvbnN0IHN0cnVjdCBhZGRyZXNzX3NwYWNl
X29wZXJhdGlvbnMgY2VwaF9hb3BzOw0KPiAgZXh0ZXJuIGNvbnN0IHN0cnVjdCBuZXRmc19yZXF1
ZXN0X29wcyBjZXBoX25ldGZzX29wczsNCj4gLWV4dGVybiBpbnQgY2VwaF9tbWFwKHN0cnVjdCBm
aWxlICpmaWxlLCBzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSk7DQo+ICtpbnQgY2VwaF9tbWFw
X3ByZXBhcmUoc3RydWN0IHZtX2FyZWFfZGVzYyAqZGVzYyk7DQo+ICBleHRlcm4gaW50IGNlcGhf
dW5pbmxpbmVfZGF0YShzdHJ1Y3QgZmlsZSAqZmlsZSk7DQo+ICBleHRlcm4gaW50IGNlcGhfcG9v
bF9wZXJtX2NoZWNrKHN0cnVjdCBpbm9kZSAqaW5vZGUsIGludCBuZWVkKTsNCj4gIGV4dGVybiB2
b2lkIGNlcGhfcG9vbF9wZXJtX2Rlc3Ryb3koc3RydWN0IGNlcGhfbWRzX2NsaWVudCogbWRzYyk7
DQoNCkxvb2tzIGdvb2QgZm9yIENlcGhGUy4NCg0KUmV2aWV3ZWQtYnk6IFZpYWNoZXNsYXYgRHVi
ZXlrbyA8U2xhdmEuRHViZXlrb0BpYm0uY29tPg0KDQpUaGFua3MsDQpTbGF2YS4NCg0KPiBkaWZm
IC0tZ2l0IGEvZnMvZXhmYXQvZmlsZS5jIGIvZnMvZXhmYXQvZmlsZS5jDQo+IGluZGV4IDg0MWE1
YjE4ZTNkZi4uZDYzMjEzYzhhODIzIDEwMDY0NA0KPiAtLS0gYS9mcy9leGZhdC9maWxlLmMNCj4g
KysrIGIvZnMvZXhmYXQvZmlsZS5jDQo+IEBAIC02ODMsMTMgKzY4MywxNCBAQCBzdGF0aWMgY29u
c3Qgc3RydWN0IHZtX29wZXJhdGlvbnNfc3RydWN0IGV4ZmF0X2ZpbGVfdm1fb3BzID0gew0KPiAg
CS5wYWdlX21rd3JpdGUJPSBleGZhdF9wYWdlX21rd3JpdGUsDQo+ICB9Ow0KPiAgDQo+IC1zdGF0
aWMgaW50IGV4ZmF0X2ZpbGVfbW1hcChzdHJ1Y3QgZmlsZSAqZmlsZSwgc3RydWN0IHZtX2FyZWFf
c3RydWN0ICp2bWEpDQo+ICtzdGF0aWMgaW50IGV4ZmF0X2ZpbGVfbW1hcF9wcmVwYXJlKHN0cnVj
dCB2bV9hcmVhX2Rlc2MgKmRlc2MpDQo+ICB7DQo+ICsJc3RydWN0IGZpbGUgKmZpbGUgPSBkZXNj
LT5maWxlOw0KPiAgCWlmICh1bmxpa2VseShleGZhdF9mb3JjZWRfc2h1dGRvd24oZmlsZV9pbm9k
ZShmaWxlKS0+aV9zYikpKQ0KPiAgCQlyZXR1cm4gLUVJTzsNCj4gIA0KPiAgCWZpbGVfYWNjZXNz
ZWQoZmlsZSk7DQo+IC0Jdm1hLT52bV9vcHMgPSAmZXhmYXRfZmlsZV92bV9vcHM7DQo+ICsJZGVz
Yy0+dm1fb3BzID0gJmV4ZmF0X2ZpbGVfdm1fb3BzOw0KPiAgCXJldHVybiAwOw0KPiAgfQ0KPiAg
DQo+IEBAIC03MTAsNyArNzExLDcgQEAgY29uc3Qgc3RydWN0IGZpbGVfb3BlcmF0aW9ucyBleGZh
dF9maWxlX29wZXJhdGlvbnMgPSB7DQo+ICAjaWZkZWYgQ09ORklHX0NPTVBBVA0KPiAgCS5jb21w
YXRfaW9jdGwgPSBleGZhdF9jb21wYXRfaW9jdGwsDQo+ICAjZW5kaWYNCj4gLQkubW1hcAkJPSBl
eGZhdF9maWxlX21tYXAsDQo+ICsJLm1tYXBfcHJlcGFyZQk9IGV4ZmF0X2ZpbGVfbW1hcF9wcmVw
YXJlLA0KPiAgCS5mc3luYwkJPSBleGZhdF9maWxlX2ZzeW5jLA0KPiAgCS5zcGxpY2VfcmVhZAk9
IGV4ZmF0X3NwbGljZV9yZWFkLA0KPiAgCS5zcGxpY2Vfd3JpdGUJPSBpdGVyX2ZpbGVfc3BsaWNl
X3dyaXRlLA0KPiBkaWZmIC0tZ2l0IGEvZnMvZjJmcy9maWxlLmMgYi9mcy9mMmZzL2ZpbGUuYw0K
PiBpbmRleCA2YmQzZGU2NGYyYTguLjdhZjJiNDliN2U4YSAxMDA2NDQNCj4gLS0tIGEvZnMvZjJm
cy9maWxlLmMNCj4gKysrIGIvZnMvZjJmcy9maWxlLmMNCj4gQEAgLTUzMiw4ICs1MzIsOSBAQCBz
dGF0aWMgbG9mZl90IGYyZnNfbGxzZWVrKHN0cnVjdCBmaWxlICpmaWxlLCBsb2ZmX3Qgb2Zmc2V0
LCBpbnQgd2hlbmNlKQ0KPiAgCXJldHVybiAtRUlOVkFMOw0KPiAgfQ0KPiAgDQo+IC1zdGF0aWMg
aW50IGYyZnNfZmlsZV9tbWFwKHN0cnVjdCBmaWxlICpmaWxlLCBzdHJ1Y3Qgdm1fYXJlYV9zdHJ1
Y3QgKnZtYSkNCj4gK3N0YXRpYyBpbnQgZjJmc19maWxlX21tYXBfcHJlcGFyZShzdHJ1Y3Qgdm1f
YXJlYV9kZXNjICpkZXNjKQ0KPiAgew0KPiArCXN0cnVjdCBmaWxlICpmaWxlID0gZGVzYy0+Zmls
ZTsNCj4gIAlzdHJ1Y3QgaW5vZGUgKmlub2RlID0gZmlsZV9pbm9kZShmaWxlKTsNCj4gIA0KPiAg
CWlmICh1bmxpa2VseShmMmZzX2NwX2Vycm9yKEYyRlNfSV9TQihpbm9kZSkpKSkNCj4gQEAgLTU0
Myw3ICs1NDQsNyBAQCBzdGF0aWMgaW50IGYyZnNfZmlsZV9tbWFwKHN0cnVjdCBmaWxlICpmaWxl
LCBzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSkNCj4gIAkJcmV0dXJuIC1FT1BOT1RTVVBQOw0K
PiAgDQo+ICAJZmlsZV9hY2Nlc3NlZChmaWxlKTsNCj4gLQl2bWEtPnZtX29wcyA9ICZmMmZzX2Zp
bGVfdm1fb3BzOw0KPiArCWRlc2MtPnZtX29wcyA9ICZmMmZzX2ZpbGVfdm1fb3BzOw0KPiAgDQo+
ICAJZjJmc19kb3duX3JlYWQoJkYyRlNfSShpbm9kZSktPmlfc2VtKTsNCj4gIAlzZXRfaW5vZGVf
ZmxhZyhpbm9kZSwgRklfTU1BUF9GSUxFKTsNCj4gQEAgLTUzNzYsNyArNTM3Nyw3IEBAIGNvbnN0
IHN0cnVjdCBmaWxlX29wZXJhdGlvbnMgZjJmc19maWxlX29wZXJhdGlvbnMgPSB7DQo+ICAJLmlv
cG9sbAkJPSBpb2NiX2Jpb19pb3BvbGwsDQo+ICAJLm9wZW4JCT0gZjJmc19maWxlX29wZW4sDQo+
ICAJLnJlbGVhc2UJPSBmMmZzX3JlbGVhc2VfZmlsZSwNCj4gLQkubW1hcAkJPSBmMmZzX2ZpbGVf
bW1hcCwNCj4gKwkubW1hcF9wcmVwYXJlCT0gZjJmc19maWxlX21tYXBfcHJlcGFyZSwNCj4gIAku
Zmx1c2gJCT0gZjJmc19maWxlX2ZsdXNoLA0KPiAgCS5mc3luYwkJPSBmMmZzX3N5bmNfZmlsZSwN
Cj4gIAkuZmFsbG9jYXRlCT0gZjJmc19mYWxsb2NhdGUsDQo+IGRpZmYgLS1naXQgYS9mcy9uaWxm
czIvZmlsZS5jIGIvZnMvbmlsZnMyL2ZpbGUuYw0KPiBpbmRleCAwZTNmYzViYTMzYzcuLjFiOGQ3
NTRkYjQ0ZCAxMDA2NDQNCj4gLS0tIGEvZnMvbmlsZnMyL2ZpbGUuYw0KPiArKysgYi9mcy9uaWxm
czIvZmlsZS5jDQo+IEBAIC0xMjUsMTAgKzEyNSwxMCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHZt
X29wZXJhdGlvbnNfc3RydWN0IG5pbGZzX2ZpbGVfdm1fb3BzID0gew0KPiAgCS5wYWdlX21rd3Jp
dGUJPSBuaWxmc19wYWdlX21rd3JpdGUsDQo+ICB9Ow0KPiAgDQo+IC1zdGF0aWMgaW50IG5pbGZz
X2ZpbGVfbW1hcChzdHJ1Y3QgZmlsZSAqZmlsZSwgc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEp
DQo+ICtzdGF0aWMgaW50IG5pbGZzX2ZpbGVfbW1hcF9wcmVwYXJlKHN0cnVjdCB2bV9hcmVhX2Rl
c2MgKmRlc2MpDQo+ICB7DQo+IC0JZmlsZV9hY2Nlc3NlZChmaWxlKTsNCj4gLQl2bWEtPnZtX29w
cyA9ICZuaWxmc19maWxlX3ZtX29wczsNCj4gKwlmaWxlX2FjY2Vzc2VkKGRlc2MtPmZpbGUpOw0K
PiArCWRlc2MtPnZtX29wcyA9ICZuaWxmc19maWxlX3ZtX29wczsNCj4gIAlyZXR1cm4gMDsNCj4g
IH0NCj4gIA0KPiBAQCAtMTQ0LDcgKzE0NCw3IEBAIGNvbnN0IHN0cnVjdCBmaWxlX29wZXJhdGlv
bnMgbmlsZnNfZmlsZV9vcGVyYXRpb25zID0gew0KPiAgI2lmZGVmIENPTkZJR19DT01QQVQNCj4g
IAkuY29tcGF0X2lvY3RsCT0gbmlsZnNfY29tcGF0X2lvY3RsLA0KPiAgI2VuZGlmCS8qIENPTkZJ
R19DT01QQVQgKi8NCj4gLQkubW1hcAkJPSBuaWxmc19maWxlX21tYXAsDQo+ICsJLm1tYXBfcHJl
cGFyZQk9IG5pbGZzX2ZpbGVfbW1hcF9wcmVwYXJlLA0KPiAgCS5vcGVuCQk9IGdlbmVyaWNfZmls
ZV9vcGVuLA0KPiAgCS8qIC5yZWxlYXNlCT0gbmlsZnNfcmVsZWFzZV9maWxlLCAqLw0KPiAgCS5m
c3luYwkJPSBuaWxmc19zeW5jX2ZpbGUsDQo+IGRpZmYgLS1naXQgYS9mcy9vY2ZzMi9maWxlLmMg
Yi9mcy9vY2ZzMi9maWxlLmMNCj4gaW5kZXggMjA1NmNmMDhhYzFlLi4yMWQ3OTdjY2NjZDAgMTAw
NjQ0DQo+IC0tLSBhL2ZzL29jZnMyL2ZpbGUuYw0KPiArKysgYi9mcy9vY2ZzMi9maWxlLmMNCj4g
QEAgLTI4MDAsNyArMjgwMCw3IEBAIGNvbnN0IHN0cnVjdCBpbm9kZV9vcGVyYXRpb25zIG9jZnMy
X3NwZWNpYWxfZmlsZV9pb3BzID0gew0KPiAgICovDQo+ICBjb25zdCBzdHJ1Y3QgZmlsZV9vcGVy
YXRpb25zIG9jZnMyX2ZvcHMgPSB7DQo+ICAJLmxsc2VlawkJPSBvY2ZzMl9maWxlX2xsc2VlaywN
Cj4gLQkubW1hcAkJPSBvY2ZzMl9tbWFwLA0KPiArCS5tbWFwX3ByZXBhcmUJPSBvY2ZzMl9tbWFw
X3ByZXBhcmUsDQo+ICAJLmZzeW5jCQk9IG9jZnMyX3N5bmNfZmlsZSwNCj4gIAkucmVsZWFzZQk9
IG9jZnMyX2ZpbGVfcmVsZWFzZSwNCj4gIAkub3BlbgkJPSBvY2ZzMl9maWxlX29wZW4sDQo+IEBA
IC0yODUwLDcgKzI4NTAsNyBAQCBjb25zdCBzdHJ1Y3QgZmlsZV9vcGVyYXRpb25zIG9jZnMyX2Rv
cHMgPSB7DQo+ICAgKi8NCj4gIGNvbnN0IHN0cnVjdCBmaWxlX29wZXJhdGlvbnMgb2NmczJfZm9w
c19ub19wbG9ja3MgPSB7DQo+ICAJLmxsc2VlawkJPSBvY2ZzMl9maWxlX2xsc2VlaywNCj4gLQku
bW1hcAkJPSBvY2ZzMl9tbWFwLA0KPiArCS5tbWFwX3ByZXBhcmUJPSBvY2ZzMl9tbWFwX3ByZXBh
cmUsDQo+ICAJLmZzeW5jCQk9IG9jZnMyX3N5bmNfZmlsZSwNCj4gIAkucmVsZWFzZQk9IG9jZnMy
X2ZpbGVfcmVsZWFzZSwNCj4gIAkub3BlbgkJPSBvY2ZzMl9maWxlX29wZW4sDQo+IGRpZmYgLS1n
aXQgYS9mcy9vY2ZzMi9tbWFwLmMgYi9mcy9vY2ZzMi9tbWFwLmMNCj4gaW5kZXggNmEzMTRlOWYy
YjQ5Li41MGUyZmFmNjRjMTkgMTAwNjQ0DQo+IC0tLSBhL2ZzL29jZnMyL21tYXAuYw0KPiArKysg
Yi9mcy9vY2ZzMi9tbWFwLmMNCj4gQEAgLTE1OSw4ICsxNTksOSBAQCBzdGF0aWMgY29uc3Qgc3Ry
dWN0IHZtX29wZXJhdGlvbnNfc3RydWN0IG9jZnMyX2ZpbGVfdm1fb3BzID0gew0KPiAgCS5wYWdl
X21rd3JpdGUJPSBvY2ZzMl9wYWdlX21rd3JpdGUsDQo+ICB9Ow0KPiAgDQo+IC1pbnQgb2NmczJf
bW1hcChzdHJ1Y3QgZmlsZSAqZmlsZSwgc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEpDQo+ICtp
bnQgb2NmczJfbW1hcF9wcmVwYXJlKHN0cnVjdCB2bV9hcmVhX2Rlc2MgKmRlc2MpDQo+ICB7DQo+
ICsJc3RydWN0IGZpbGUgKmZpbGUgPSBkZXNjLT5maWxlOw0KPiAgCWludCByZXQgPSAwLCBsb2Nr
X2xldmVsID0gMDsNCj4gIA0KPiAgCXJldCA9IG9jZnMyX2lub2RlX2xvY2tfYXRpbWUoZmlsZV9p
bm9kZShmaWxlKSwNCj4gQEAgLTE3MSw3ICsxNzIsNyBAQCBpbnQgb2NmczJfbW1hcChzdHJ1Y3Qg
ZmlsZSAqZmlsZSwgc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEpDQo+ICAJfQ0KPiAgCW9jZnMy
X2lub2RlX3VubG9jayhmaWxlX2lub2RlKGZpbGUpLCBsb2NrX2xldmVsKTsNCj4gIG91dDoNCj4g
LQl2bWEtPnZtX29wcyA9ICZvY2ZzMl9maWxlX3ZtX29wczsNCj4gKwlkZXNjLT52bV9vcHMgPSAm
b2NmczJfZmlsZV92bV9vcHM7DQo+ICAJcmV0dXJuIDA7DQo+ICB9DQo+ICANCj4gZGlmZiAtLWdp
dCBhL2ZzL29jZnMyL21tYXAuaCBiL2ZzL29jZnMyL21tYXAuaA0KPiBpbmRleCAxMDUxNTA3Y2M2
ODQuLmQyMWMzMGRlNmI4YyAxMDA2NDQNCj4gLS0tIGEvZnMvb2NmczIvbW1hcC5oDQo+ICsrKyBi
L2ZzL29jZnMyL21tYXAuaA0KPiBAQCAtMiw2ICsyLDYgQEANCj4gICNpZm5kZWYgT0NGUzJfTU1B
UF9IDQo+ICAjZGVmaW5lIE9DRlMyX01NQVBfSA0KPiAgDQo+IC1pbnQgb2NmczJfbW1hcChzdHJ1
Y3QgZmlsZSAqZmlsZSwgc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEpOw0KPiAraW50IG9jZnMy
X21tYXBfcHJlcGFyZShzdHJ1Y3Qgdm1fYXJlYV9kZXNjICpkZXNjKTsNCj4gIA0KPiAgI2VuZGlm
ICAvKiBPQ0ZTMl9NTUFQX0ggKi8NCj4gZGlmZiAtLWdpdCBhL2ZzL29yYW5nZWZzL2ZpbGUuYyBi
L2ZzL29yYW5nZWZzL2ZpbGUuYw0KPiBpbmRleCA5MGM0OWMwZGUyNDMuLjkxOWY5OWIxNjgzNCAx
MDA2NDQNCj4gLS0tIGEvZnMvb3JhbmdlZnMvZmlsZS5jDQo+ICsrKyBiL2ZzL29yYW5nZWZzL2Zp
bGUuYw0KPiBAQCAtMzk4LDggKzM5OCw5IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgdm1fb3BlcmF0
aW9uc19zdHJ1Y3Qgb3JhbmdlZnNfZmlsZV92bV9vcHMgPSB7DQo+ICAvKg0KPiAgICogTWVtb3J5
IG1hcCBhIHJlZ2lvbiBvZiBhIGZpbGUuDQo+ICAgKi8NCj4gLXN0YXRpYyBpbnQgb3JhbmdlZnNf
ZmlsZV9tbWFwKHN0cnVjdCBmaWxlICpmaWxlLCBzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSkN
Cj4gK3N0YXRpYyBpbnQgb3JhbmdlZnNfZmlsZV9tbWFwX3ByZXBhcmUoc3RydWN0IHZtX2FyZWFf
ZGVzYyAqZGVzYykNCj4gIHsNCj4gKwlzdHJ1Y3QgZmlsZSAqZmlsZSA9IGRlc2MtPmZpbGU7DQo+
ICAJaW50IHJldDsNCj4gIA0KPiAgCXJldCA9IG9yYW5nZWZzX3JldmFsaWRhdGVfbWFwcGluZyhm
aWxlX2lub2RlKGZpbGUpKTsNCj4gQEAgLTQxMCwxMCArNDExLDExIEBAIHN0YXRpYyBpbnQgb3Jh
bmdlZnNfZmlsZV9tbWFwKHN0cnVjdCBmaWxlICpmaWxlLCBzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3Qg
KnZtYSkNCj4gIAkJICAgICAib3JhbmdlZnNfZmlsZV9tbWFwOiBjYWxsZWQgb24gJXBEXG4iLCBm
aWxlKTsNCj4gIA0KPiAgCS8qIHNldCB0aGUgc2VxdWVudGlhbCByZWFkYWhlYWQgaGludCAqLw0K
PiAtCXZtX2ZsYWdzX21vZCh2bWEsIFZNX1NFUV9SRUFELCBWTV9SQU5EX1JFQUQpOw0KPiArCWRl
c2MtPnZtX2ZsYWdzIHw9IFZNX1NFUV9SRUFEOw0KPiArCWRlc2MtPnZtX2ZsYWdzICY9IH5WTV9S
QU5EX1JFQUQ7DQo+ICANCj4gIAlmaWxlX2FjY2Vzc2VkKGZpbGUpOw0KPiAtCXZtYS0+dm1fb3Bz
ID0gJm9yYW5nZWZzX2ZpbGVfdm1fb3BzOw0KPiArCWRlc2MtPnZtX29wcyA9ICZvcmFuZ2Vmc19m
aWxlX3ZtX29wczsNCj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4gIA0KPiBAQCAtNTc0LDcgKzU3Niw3
IEBAIGNvbnN0IHN0cnVjdCBmaWxlX29wZXJhdGlvbnMgb3JhbmdlZnNfZmlsZV9vcGVyYXRpb25z
ID0gew0KPiAgCS5yZWFkX2l0ZXIJPSBvcmFuZ2Vmc19maWxlX3JlYWRfaXRlciwNCj4gIAkud3Jp
dGVfaXRlcgk9IG9yYW5nZWZzX2ZpbGVfd3JpdGVfaXRlciwNCj4gIAkubG9jawkJPSBvcmFuZ2Vm
c19sb2NrLA0KPiAtCS5tbWFwCQk9IG9yYW5nZWZzX2ZpbGVfbW1hcCwNCj4gKwkubW1hcF9wcmVw
YXJlCT0gb3JhbmdlZnNfZmlsZV9tbWFwX3ByZXBhcmUsDQo+ICAJLm9wZW4JCT0gZ2VuZXJpY19m
aWxlX29wZW4sDQo+ICAJLnNwbGljZV9yZWFkICAgID0gb3JhbmdlZnNfZmlsZV9zcGxpY2VfcmVh
ZCwNCj4gIAkuc3BsaWNlX3dyaXRlICAgPSBpdGVyX2ZpbGVfc3BsaWNlX3dyaXRlLA0KPiBkaWZm
IC0tZ2l0IGEvZnMvcmFtZnMvZmlsZS1ub21tdS5jIGIvZnMvcmFtZnMvZmlsZS1ub21tdS5jDQo+
IGluZGV4IDdhNmQ5ODBlNjE0ZC4uNzdiOGNhMjc1N2UwIDEwMDY0NA0KPiAtLS0gYS9mcy9yYW1m
cy9maWxlLW5vbW11LmMNCj4gKysrIGIvZnMvcmFtZnMvZmlsZS1ub21tdS5jDQo+IEBAIC0yOCw3
ICsyOCw3IEBAIHN0YXRpYyB1bnNpZ25lZCBsb25nIHJhbWZzX25vbW11X2dldF91bm1hcHBlZF9h
cmVhKHN0cnVjdCBmaWxlICpmaWxlLA0KPiAgCQkJCQkJICAgdW5zaWduZWQgbG9uZyBsZW4sDQo+
ICAJCQkJCQkgICB1bnNpZ25lZCBsb25nIHBnb2ZmLA0KPiAgCQkJCQkJICAgdW5zaWduZWQgbG9u
ZyBmbGFncyk7DQo+IC1zdGF0aWMgaW50IHJhbWZzX25vbW11X21tYXAoc3RydWN0IGZpbGUgKmZp
bGUsIHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hKTsNCj4gK3N0YXRpYyBpbnQgcmFtZnNfbm9t
bXVfbW1hcF9wcmVwYXJlKHN0cnVjdCB2bV9hcmVhX2Rlc2MgKmRlc2MpOw0KPiAgDQo+ICBzdGF0
aWMgdW5zaWduZWQgcmFtZnNfbW1hcF9jYXBhYmlsaXRpZXMoc3RydWN0IGZpbGUgKmZpbGUpDQo+
ICB7DQo+IEBAIC0zOCw3ICszOCw3IEBAIHN0YXRpYyB1bnNpZ25lZCByYW1mc19tbWFwX2NhcGFi
aWxpdGllcyhzdHJ1Y3QgZmlsZSAqZmlsZSkNCj4gIA0KPiAgY29uc3Qgc3RydWN0IGZpbGVfb3Bl
cmF0aW9ucyByYW1mc19maWxlX29wZXJhdGlvbnMgPSB7DQo+ICAJLm1tYXBfY2FwYWJpbGl0aWVz
CT0gcmFtZnNfbW1hcF9jYXBhYmlsaXRpZXMsDQo+IC0JLm1tYXAJCQk9IHJhbWZzX25vbW11X21t
YXAsDQo+ICsJLm1tYXBfcHJlcGFyZQkJPSByYW1mc19ub21tdV9tbWFwX3ByZXBhcmUsDQo+ICAJ
LmdldF91bm1hcHBlZF9hcmVhCT0gcmFtZnNfbm9tbXVfZ2V0X3VubWFwcGVkX2FyZWEsDQo+ICAJ
LnJlYWRfaXRlcgkJPSBnZW5lcmljX2ZpbGVfcmVhZF9pdGVyLA0KPiAgCS53cml0ZV9pdGVyCQk9
IGdlbmVyaWNfZmlsZV93cml0ZV9pdGVyLA0KPiBAQCAtMjYyLDEyICsyNjIsMTIgQEAgc3RhdGlj
IHVuc2lnbmVkIGxvbmcgcmFtZnNfbm9tbXVfZ2V0X3VubWFwcGVkX2FyZWEoc3RydWN0IGZpbGUg
KmZpbGUsDQo+ICAvKg0KPiAgICogc2V0IHVwIGEgbWFwcGluZyBmb3Igc2hhcmVkIG1lbW9yeSBz
ZWdtZW50cw0KPiAgICovDQo+IC1zdGF0aWMgaW50IHJhbWZzX25vbW11X21tYXAoc3RydWN0IGZp
bGUgKmZpbGUsIHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hKQ0KPiArc3RhdGljIGludCByYW1m
c19ub21tdV9tbWFwX3ByZXBhcmUoc3RydWN0IHZtX2FyZWFfZGVzYyAqZGVzYykNCj4gIHsNCj4g
LQlpZiAoIWlzX25vbW11X3NoYXJlZF9tYXBwaW5nKHZtYS0+dm1fZmxhZ3MpKQ0KPiArCWlmICgh
aXNfbm9tbXVfc2hhcmVkX21hcHBpbmcoZGVzYy0+dm1fZmxhZ3MpKQ0KPiAgCQlyZXR1cm4gLUVO
T1NZUzsNCj4gIA0KPiAtCWZpbGVfYWNjZXNzZWQoZmlsZSk7DQo+IC0Jdm1hLT52bV9vcHMgPSAm
Z2VuZXJpY19maWxlX3ZtX29wczsNCj4gKwlmaWxlX2FjY2Vzc2VkKGRlc2MtPmZpbGUpOw0KPiAr
CWRlc2MtPnZtX29wcyA9ICZnZW5lcmljX2ZpbGVfdm1fb3BzOw0KPiAgCXJldHVybiAwOw0KPiAg
fQ0KPiBkaWZmIC0tZ2l0IGEvZnMvcm9tZnMvbW1hcC1ub21tdS5jIGIvZnMvcm9tZnMvbW1hcC1u
b21tdS5jDQo+IGluZGV4IDQ1MjBjYTQxMzg2Ny4uNGI3N2M2ZGM0NDE4IDEwMDY0NA0KPiAtLS0g
YS9mcy9yb21mcy9tbWFwLW5vbW11LmMNCj4gKysrIGIvZnMvcm9tZnMvbW1hcC1ub21tdS5jDQo+
IEBAIC02MSw5ICs2MSw5IEBAIHN0YXRpYyB1bnNpZ25lZCBsb25nIHJvbWZzX2dldF91bm1hcHBl
ZF9hcmVhKHN0cnVjdCBmaWxlICpmaWxlLA0KPiAgICogcGVybWl0IGEgUi9PIG1hcHBpbmcgdG8g
YmUgbWFkZSBkaXJlY3RseSB0aHJvdWdoIG9udG8gYW4gTVREIGRldmljZSBpZg0KPiAgICogcG9z
c2libGUNCj4gICAqLw0KPiAtc3RhdGljIGludCByb21mc19tbWFwKHN0cnVjdCBmaWxlICpmaWxl
LCBzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSkNCj4gK3N0YXRpYyBpbnQgcm9tZnNfbW1hcF9w
cmVwYXJlKHN0cnVjdCB2bV9hcmVhX2Rlc2MgKmRlc2MpDQo+ICB7DQo+IC0JcmV0dXJuIGlzX25v
bW11X3NoYXJlZF9tYXBwaW5nKHZtYS0+dm1fZmxhZ3MpID8gMCA6IC1FTk9TWVM7DQo+ICsJcmV0
dXJuIGlzX25vbW11X3NoYXJlZF9tYXBwaW5nKGRlc2MtPnZtX2ZsYWdzKSA/IDAgOiAtRU5PU1lT
Ow0KPiAgfQ0KPiAgDQo+ICBzdGF0aWMgdW5zaWduZWQgcm9tZnNfbW1hcF9jYXBhYmlsaXRpZXMo
c3RydWN0IGZpbGUgKmZpbGUpDQo+IEBAIC03OSw3ICs3OSw3IEBAIGNvbnN0IHN0cnVjdCBmaWxl
X29wZXJhdGlvbnMgcm9tZnNfcm9fZm9wcyA9IHsNCj4gIAkubGxzZWVrCQkJPSBnZW5lcmljX2Zp
bGVfbGxzZWVrLA0KPiAgCS5yZWFkX2l0ZXIJCT0gZ2VuZXJpY19maWxlX3JlYWRfaXRlciwNCj4g
IAkuc3BsaWNlX3JlYWQJCT0gZmlsZW1hcF9zcGxpY2VfcmVhZCwNCj4gLQkubW1hcAkJCT0gcm9t
ZnNfbW1hcCwNCj4gKwkubW1hcF9wcmVwYXJlCQk9IHJvbWZzX21tYXBfcHJlcGFyZSwNCj4gIAku
Z2V0X3VubWFwcGVkX2FyZWEJPSByb21mc19nZXRfdW5tYXBwZWRfYXJlYSwNCj4gIAkubW1hcF9j
YXBhYmlsaXRpZXMJPSByb21mc19tbWFwX2NhcGFiaWxpdGllcywNCj4gIH07DQo+IGRpZmYgLS1n
aXQgYS9mcy96b25lZnMvZmlsZS5jIGIvZnMvem9uZWZzL2ZpbGUuYw0KPiBpbmRleCA0MmUyYzAw
NjViYjMuLmMxODQ4MTYzYjM3OCAxMDA2NDQNCj4gLS0tIGEvZnMvem9uZWZzL2ZpbGUuYw0KPiAr
KysgYi9mcy96b25lZnMvZmlsZS5jDQo+IEBAIC0zMTIsOCArMzEyLDEwIEBAIHN0YXRpYyBjb25z
dCBzdHJ1Y3Qgdm1fb3BlcmF0aW9uc19zdHJ1Y3Qgem9uZWZzX2ZpbGVfdm1fb3BzID0gew0KPiAg
CS5wYWdlX21rd3JpdGUJPSB6b25lZnNfZmlsZW1hcF9wYWdlX21rd3JpdGUsDQo+ICB9Ow0KPiAg
DQo+IC1zdGF0aWMgaW50IHpvbmVmc19maWxlX21tYXAoc3RydWN0IGZpbGUgKmZpbGUsIHN0cnVj
dCB2bV9hcmVhX3N0cnVjdCAqdm1hKQ0KPiArc3RhdGljIGludCB6b25lZnNfZmlsZV9tbWFwX3By
ZXBhcmUoc3RydWN0IHZtX2FyZWFfZGVzYyAqZGVzYykNCj4gIHsNCj4gKwlzdHJ1Y3QgZmlsZSAq
ZmlsZSA9IGRlc2MtPmZpbGU7DQo+ICsNCj4gIAkvKg0KPiAgCSAqIENvbnZlbnRpb25hbCB6b25l
cyBhY2NlcHQgcmFuZG9tIHdyaXRlcywgc28gdGhlaXIgZmlsZXMgY2FuIHN1cHBvcnQNCj4gIAkg
KiBzaGFyZWQgd3JpdGFibGUgbWFwcGluZ3MuIEZvciBzZXF1ZW50aWFsIHpvbmUgZmlsZXMsIG9u
bHkgcmVhZA0KPiBAQCAtMzIxLDExICszMjMsMTEgQEAgc3RhdGljIGludCB6b25lZnNfZmlsZV9t
bWFwKHN0cnVjdCBmaWxlICpmaWxlLCBzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSkNCj4gIAkg
KiBvcmRlcmluZyBiZXR3ZWVuIG1zeW5jKCkgYW5kIHBhZ2UgY2FjaGUgd3JpdGViYWNrLg0KPiAg
CSAqLw0KPiAgCWlmICh6b25lZnNfaW5vZGVfaXNfc2VxKGZpbGVfaW5vZGUoZmlsZSkpICYmDQo+
IC0JICAgICh2bWEtPnZtX2ZsYWdzICYgVk1fU0hBUkVEKSAmJiAodm1hLT52bV9mbGFncyAmIFZN
X01BWVdSSVRFKSkNCj4gKwkgICAgKGRlc2MtPnZtX2ZsYWdzICYgVk1fU0hBUkVEKSAmJiAoZGVz
Yy0+dm1fZmxhZ3MgJiBWTV9NQVlXUklURSkpDQo+ICAJCXJldHVybiAtRUlOVkFMOw0KPiAgDQo+
ICAJZmlsZV9hY2Nlc3NlZChmaWxlKTsNCj4gLQl2bWEtPnZtX29wcyA9ICZ6b25lZnNfZmlsZV92
bV9vcHM7DQo+ICsJZGVzYy0+dm1fb3BzID0gJnpvbmVmc19maWxlX3ZtX29wczsNCj4gIA0KPiAg
CXJldHVybiAwOw0KPiAgfQ0KPiBAQCAtODUwLDcgKzg1Miw3IEBAIGNvbnN0IHN0cnVjdCBmaWxl
X29wZXJhdGlvbnMgem9uZWZzX2ZpbGVfb3BlcmF0aW9ucyA9IHsNCj4gIAkub3BlbgkJPSB6b25l
ZnNfZmlsZV9vcGVuLA0KPiAgCS5yZWxlYXNlCT0gem9uZWZzX2ZpbGVfcmVsZWFzZSwNCj4gIAku
ZnN5bmMJCT0gem9uZWZzX2ZpbGVfZnN5bmMsDQo+IC0JLm1tYXAJCT0gem9uZWZzX2ZpbGVfbW1h
cCwNCj4gKwkubW1hcF9wcmVwYXJlCT0gem9uZWZzX2ZpbGVfbW1hcF9wcmVwYXJlLA0KPiAgCS5s
bHNlZWsJCT0gem9uZWZzX2ZpbGVfbGxzZWVrLA0KPiAgCS5yZWFkX2l0ZXIJPSB6b25lZnNfZmls
ZV9yZWFkX2l0ZXIsDQo+ICAJLndyaXRlX2l0ZXIJPSB6b25lZnNfZmlsZV93cml0ZV9pdGVyLA0K

