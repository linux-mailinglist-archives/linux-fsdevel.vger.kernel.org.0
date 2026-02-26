Return-Path: <linux-fsdevel+bounces-78596-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLKAMqyCoGkDkgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78596-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 18:28:12 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2BD1AC64A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 18:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 553C132A02C7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 16:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26FF146AEE2;
	Thu, 26 Feb 2026 16:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BhbEGh7c";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="F0nAmgvl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD20466B6A;
	Thu, 26 Feb 2026 16:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772123475; cv=fail; b=XmAw/ilfeGH/dx2M0BhqrpMvGs3bF+Zn/IeWImqlH4HXz9MzkpToG2KxwxTzwCVly1+CyKRP3kFS/eXhgI4fVTmIPX2i5bcijTqJAbBg6SyH5L5W1xy8WnaaOFU6OCJW8U6o1VYaK95r1sB7fMhBeYdKUVxkrDlJ6LkHwf9zdx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772123475; c=relaxed/simple;
	bh=t+FM93gHxZQuPuRNNR1BtnOnVVYy+wrmcF3SPt97SkQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sJUwErUPjM8osEDbgL5So0dRX7IXqV5o/jOY+BfGKwtQxF5mFPuJgfKOXPwd06K5D09CAWGRichjW46/ImAhDC5HFggnUc9WeWESSGPgEScGrgnherCPigB6W0V+KVwYJWCnU+hcbKdPo7GLfU9G1JUtw4hB++RNGHR4A3LupaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BhbEGh7c; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=F0nAmgvl; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61QDNCrR107273;
	Thu, 26 Feb 2026 16:30:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=j/HoNXy2/KdwEhbaiUHLNsdkhPRgNnGa9lgsHRNcBzM=; b=
	BhbEGh7c/1YtYUQgMOQr/5G/95YT1cDKgkbSsh0OZTS36xPf89fd+KBkIGvpIO+S
	pCwESBUnHnYMqvxvZYk4NaMNvvKLUrrnHKjHDmXs+0Ldz/uJSK3sBeF0FPmaWQau
	2IdxZ12tJYmRNp8HT6JWK/O7W9SqqOph4WclvhZcF7gbEdIqQrLCZxGMkEA74XRq
	qnzr7DxaAZIi9zsN2Xz4ZbSCRrQl/vtLSWLkQSgi5cCCAh25UcqC34rfYoAg5L5I
	lsBTE1wkT4sVtlaH1ikgWcrz6rcrUUUDY0Q2knWXwsyfM0QUDe6z+sAB6oE+TQiu
	UvqCNQDx7q3uOG/oHp6GQw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cjh018xxn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Feb 2026 16:30:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61QExN9S006258;
	Thu, 26 Feb 2026 16:30:35 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013017.outbound.protection.outlook.com [40.93.201.17])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cf35cxn8s-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Feb 2026 16:30:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MlWodxLa97ZJNyZ3llD7+HTxGQIrzso8pHbR29KF0/xL+hoSoFR1FXKQUE/jqUKs1BeBbJAW6BovT4+bh3DL1Eo735/+7BvlJmQmcShVvAwkrUotnT2I9R7OSFpmms7IJ04p/X45Lok9lSoLsbnp5e0OFVTsb4cFcVHggW+iuiL0T/6GMB07El/SLrT4MCTh180tiWTaRvrl9wk2O3B0Q/wLREUxLJ7wsYKSrt06cdZW7BA35L74db5ryojT7Bi+ZHg9GxEtYfv9VSe79qB38BJRs/FGOwXjKueqOt4zbjKSOBShebmja4y4gcZ3gSu/5gY7yKc7eqCpFirevyiybA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/HoNXy2/KdwEhbaiUHLNsdkhPRgNnGa9lgsHRNcBzM=;
 b=UcSiC5wlOrjrXMeO9DK0E63iSrCAt7eITnHJw01f7NNyK4ao+WcdAW2wOPlJPggF85lvAB5NT4V+6g8STQFXPC4Z/1kJ87tQh8FimAK/mX2ilXnIqptimuOifn2uwxm3dX6As473CoqEXTF1PJJqHBYKCoAZeIdeorO0wDeFNdf5+rIp/ikj27V4v8AeS32g53ZnD908qdtnGeIDSeRCsd/fkcYSp32m4N680PbbQCkSdefA7lFRccOzke5tNOzVYfuHkwx9s6YrteCD0o/MEBGbDSmQHEvTfvY+ZIPlf9GJbZyk+7DitDW8CmV77TzrANzvLGG915an/qNYkpenJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/HoNXy2/KdwEhbaiUHLNsdkhPRgNnGa9lgsHRNcBzM=;
 b=F0nAmgvlMT7GNK+WMe0zkqn8e1w1eJMKD0R8kTxnp3AD2F2t4GlAFvQfZWad142tbtipAqHHszXHWQRMQxQUY8NGOOPGGHZwaGm8SSA3Mlkot8xLzXlWvbkcLF2BaZX4lL6xh3aKTL5xcz1ldNwur+aBzKNIvf1r0QeoiOMp0c0=
Received: from IA1PR10MB8212.namprd10.prod.outlook.com (2603:10b6:208:463::20)
 by SN7PR10MB6475.namprd10.prod.outlook.com (2603:10b6:806:2a2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 16:30:28 +0000
Received: from IA1PR10MB8212.namprd10.prod.outlook.com
 ([fe80::ee8a:bd21:f1cb:c79a]) by IA1PR10MB8212.namprd10.prod.outlook.com
 ([fe80::ee8a:bd21:f1cb:c79a%2]) with mapi id 15.20.9654.007; Thu, 26 Feb 2026
 16:30:28 +0000
Message-ID: <68b8e5fc-f979-407d-896b-fb687fc9246a@oracle.com>
Date: Thu, 26 Feb 2026 10:30:19 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 38/61] jfs: update format strings for u64 i_ino
To: Jeff Layton <jlayton@kernel.org>,
        Alexander Viro
 <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox
 <willy@infradead.org>,
        Eric Biggers <ebiggers@kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Paulo Alcantara <pc@manguebit.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, Steve French <sfrench@samba.org>,
        Ronnie Sahlberg <ronniesahlberg@gmail.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Bharath SM
 <bharathsm@microsoft.com>,
        Alexander Aring <alex.aring@gmail.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        Eric Van Hensbergen <ericvh@kernel.org>,
        Latchesar Ionkov
 <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        David Sterba <dsterba@suse.com>,
        Marc Dionne <marc.dionne@auristor.com>, Ian Kent <raven@themaw.net>,
        Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki <salah.triki@gmail.com>,
        "Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
        Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
        Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu,
        Nicolas Pitre <nico@fluxnic.net>, Tyler Hicks <code@tyhicks.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Yangtao Li <frank.li@vivo.com>,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        David Woodhouse <dwmw2@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Mike Marshall
 <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        Miklos Szeredi <miklos@szeredi.hu>, Anders Larsen <al@alarsen.net>,
        Zhihao Cheng <chengzhihao1@huawei.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        John Johansen <john.johansen@canonical.com>,
        Paul Moore
 <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Eric Snowberg <eric.snowberg@oracle.com>, Fan Wu <wufan@kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Eric Dumazet <edumazet@google.com>,
        Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemb@google.com>,
        "David S. Miller"
 <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark
 <james.clark@linaro.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Martin Schiller <ms@dev.tdt.de>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
        fsverity@lists.linux.dev, linux-mm@kvack.org, netfs@lists.linux.dev,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-nilfs@vger.kernel.org,
        v9fs@lists.linux.dev, linux-afs@lists.infradead.org,
        autofs@vger.kernel.org, ceph-devel@vger.kernel.org,
        codalist@coda.cs.cmu.edu, ecryptfs@vger.kernel.org,
        linux-mtd@lists.infradead.org, jfs-discussion@lists.sourceforge.net,
        ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev,
        devel@lists.orangefs.org, linux-unionfs@vger.kernel.org,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        netdev@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-hams@vger.kernel.org, linux-x25@vger.kernel.org
References: <20260226-iino-u64-v1-0-ccceff366db9@kernel.org>
 <20260226-iino-u64-v1-38-ccceff366db9@kernel.org>
From: Dave Kleikamp <dave.kleikamp@oracle.com>
Content-Language: en-US
In-Reply-To: <20260226-iino-u64-v1-38-ccceff366db9@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR13CA0001.namprd13.prod.outlook.com
 (2603:10b6:610:b1::6) To IA1PR10MB8212.namprd10.prod.outlook.com
 (2603:10b6:208:463::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB8212:EE_|SN7PR10MB6475:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ecc48f7-f0f3-45bc-28bb-08de755459d8
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
 kYbEPIifubRfBpTlOV1gwhN85gd/iSnznPArQ2VdE8CyDcLOfywjKv3UQDjKJWf3SC4N+n6bMxhti83RpFE7+wxe5qnSThVbxn/2vuImKCBVZRrN+c4yV4+jEdIMKfIRwRcLV7dslDJXrjIdWjNEmgQ7u9GEjHnKYBByCcSiOLrTYyBAsBzdJkOcP4RnWL3Kc4AUno2ZTcOZzVQ6rKgZoIlfgbYDTTsWDg87JsgGOesbudzT6R4ne9qQuWOS7W9izwkYfspq1d8lea5aVObVJdKaYOH9N+VYssaun4o1xY4QvMNJaqwU5GPwYvQHf3b0i1VJt/x/fdDx5ZY1Av46JZVAKenSr4vO+tm0BijdVuWWPMmYDtlF02NUqQcgD6FhWdNYq1dwBU/+EEVXLJwdA/weBZRsFavdDnZZoeXv16kVEmjYr1NBsBKcf6v2z7T/+GybmULZ67kWHLghpPmqBM0fOpM9T9FgQt6N+ysDEMMibqqrTt+LDkElzqT9pPtcOEqUQ0j7VYr19IbQToDa5WvJML5fmZfkBgFLdP8v/j87fa6FcQGs6MsUaGhJV/ssrnYwYoL/xQRgjnk8VY1lc+VT2lMIOPHQ3GjZU5gmt4l8jNU5ZrVUSOiqVWHO7FP7Y98xupFs5p0nKRWupnbYZcbAdtany0sPh78raFXy1the9Hyi8Uj5bsipHANBYiBykLghWhV0xQsaRS2H+97jczCOk2JBf3Xwl1zZC5n6kBpQXGXOGCDVw1R/rX8WP9/YsFvo6cCV149uv8R+4tdXAQ==
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB8212.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?QkdMVnRMaVE0UTB5eCtiMjNLTnl4VVdiNmlkc0NRVXJDalNVYlJjSk9HTVRn?=
 =?utf-8?B?aW5JdnF2bEFsazlxVlZwd3gzcHB1d1dMZGlYMUlVUlJVaUJ5Rzk5NGNkK3Vn?=
 =?utf-8?B?dWMyaHljcHpoenFxcnhFM0tjZmNrU0pOYUsvR3RwUmR6WE0xSUx2bkNLZG9M?=
 =?utf-8?B?aCsxYTR3eDZYeUMyT0JMVnJQMkIvSkhHWWdnbGs0SDR4WlNPTkEwVlBMbnJN?=
 =?utf-8?B?Z2NMdDZITWROWTdPSGczeVA2NVlXTDU2eEFDZTFOV3piV2dvVjBoTXV0QmdR?=
 =?utf-8?B?S1p4akNKODQ5VUZ6Rno3R0xMS05zQjFzVERzdXR2bkFOcXA3THdVZ2U0L1ZV?=
 =?utf-8?B?eko3bUtZbDJhWitOaGlmUzV6T2piQllVc1puZHRqMVg1ejc5TTNHd0huMFNj?=
 =?utf-8?B?ZVZQU3pLRzlKL1Y3UDFwcC9HL09Ici9tcVNHQmdPY3owQ3Q0ZUIxeGRiQmxB?=
 =?utf-8?B?cjF4MzRTc3p0WDE0bVhXRmJ3SnJIMmFhU01BYzlHamU5Z081S3lYcTBvZlU5?=
 =?utf-8?B?b3BQSVRFb1VKc3Raek85OXlnM2dtdWk4SE9rSXJoVVRpb1ZZUjI5N2JMOU1K?=
 =?utf-8?B?UFNpWG5TK3IxZzcxc1R0WHdIUlF5a3JFZnQzd2VLZnJGNVBKSlZ1c2c5QVBM?=
 =?utf-8?B?Nk1VTkxiekNXcmN1ZHVGS3BUTjZCNUp0NjNnaGZWZnNzL0ZoeDg1MHgrQjlQ?=
 =?utf-8?B?R3RJRVNuQVFORmg2UlJ3SUY2d0M5Wk1IL1VGOXBBVWFtK2tHMndCMXFPWkRi?=
 =?utf-8?B?QkdWc2diQmVBZnlHbWpRd3hnRnMxRS9JOVROTXJIOE5yV3Z0UXJFMjZ3V1FO?=
 =?utf-8?B?TEh6Kzl2cWVBd2E4YSt4SElBRFcwa0lqK0NMNkQ5YWxhV04yRmhFK21tTWdj?=
 =?utf-8?B?bHFYeStHNUxVZXNFb3RZaS9UOFEwN2FKUWJSVlBpcENBUENJRUVJdnlPQVMy?=
 =?utf-8?B?QXAwRDZKa2ZrYXdzMFpqUGVwcWdtaXFBV3MrMXVodHFMd0NDRWlTOVFZL2Mr?=
 =?utf-8?B?L3NGcVVqSTgzMS95ZlRnYmVXem9NTGJrdDRmSFNMZnljN1hPTDc4dnRtQjJ4?=
 =?utf-8?B?WVJhRlQwZ0dPWDdGU0dyWGttaWdmTUwzNkNJZXNoMHRWUFBLZGZsdXVObDFR?=
 =?utf-8?B?cTdWUjF3Y3BmcmlRRDNHZkYrMk1TNEowREpoQ29HQkhEN2ZzVnRtUk1aQ3ZM?=
 =?utf-8?B?TFdVMmMyT2Y0ZDZQYjJQWGd1NDlLOG4zdVRrcFBmT2I5SzhaYTBTMmhEaWgy?=
 =?utf-8?B?ZWpweWh0YWRhTFVsK1UvNDlSZThwOVBTakZhWlRTdTBkTU9uMThnZjBoNkYy?=
 =?utf-8?B?Y29DNG9PREdzcjVDajE0YXRlQWduQ1c4a2pSclQvbmNBbUczeml4elhNL2wr?=
 =?utf-8?B?MU8wOS9yT3YvSW02NURoME9HU2RQRENpODhtMk93dGs4ZUFWajVnSDZyZ1lF?=
 =?utf-8?B?ZGRweUIyb21TTTJkaHRYLzFOb1ZMejZnQndITEZWNW4yOUpwdVA0SXNJelA3?=
 =?utf-8?B?dkZMcDBTNXhCZlVEK2dqZjZpWDRZSGs2UE9LVE5RQ3NVVUdXYXVHeGpsU25m?=
 =?utf-8?B?K1Q5bFExbzAvelc4c3ZMUG1uK1JJTXBVbDRIa0tldGpsL2IyQVFxb1g3aTBJ?=
 =?utf-8?B?Vlk1U2Y3eldhYVkwV2E2SXBQSGFxYitZQUtnVDIrRG4rNE9SbVdINkZ3QUpm?=
 =?utf-8?B?RkZVMjNkejgvbnA4UnA4VHBwU2U5ZmZTMnM1LzRCbWZDQ0tWdzVRQXc3dnFa?=
 =?utf-8?B?NFNxVFhLWnd4SkN3YW12SVg2RE04SE9yZ3U4UXBYUG9zVVd1ZFROZFEzNWZa?=
 =?utf-8?B?cnpuWTB4OUlPeXBkY3RZM0k2MDVud1UzbGYwUnhBckViSjBWOHdGNWw5WlJT?=
 =?utf-8?B?bjh6Vjg4UVl1NlQzVHBYNGJqREJKN3hId0pDdTZRQ2NvYWd2TFBqTjNGYW1T?=
 =?utf-8?B?cHRlZm9ZSGJ6ekFPUndzV1R4Y2FBbUJ6QUh2aXVGOGFIRzh4ZkplYlRlRDAr?=
 =?utf-8?B?Q1R0Nk1XZC9sUUFZQTBSOVdpRzFnREhYUmNRNk5DaWRETG1FZTFzaUxPNDF2?=
 =?utf-8?B?QzlpV1lxeHVqQWg4K0xhT0VnU1hEV2owN01aaENXUk5vWUxGSmpIZ1VIZDMw?=
 =?utf-8?B?UzRtVHRDKy9KZ3d4OEJyTUtPUHdFM0JaeEtMMzVCTkM3SUlUelJkcFZqd1M2?=
 =?utf-8?B?T2FFdzFubzZjYzZXTmNQQ0gremVZcnZuMXMzOHlqWEJXVngySERuOWhyNXNk?=
 =?utf-8?B?YUM0QU5sVWxEMWVqSTRBY29FcmlqdEJ0QjJGVEJOa0dXNEY3akx4Yzc5ek1Z?=
 =?utf-8?B?UU9NT1JyS2pqMjhCa012eDlFZWpUY0NSdUpCTk03UTJLRVEwZFlEQT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AmW0KxLhRGQsj2yVbq/qRMcrRaS+VOqu2gGRWBkVnGkJkRH7KtL/KgvyT36rlXPYYgvs6B69pfkZexZzKt02HDqM69PuYZ9H6CJhXQuDt5pXkq7AYD3hLW+7ockQj35jK3//KElm8Ha3CpTpi937G+EE8Wu9/iGke3LssQ8cW5+nxktDLGNgW3XvryGfjXxRbZmZGNDczMJLTCHdGOwvBTunjUcVaApZAzZy33higDEOH/+lS2VZga/fBmJ8vIM6cgjXbSfCloc4qX5/SKdLB4x3RTsEkFCBt7P0ra/lU8stBzajrzWdx+vrWKfSCOxwnC0LV2ZfRuPp4kCTtq0gwDGMmvaOy7PFFyjpiREEsGkD84mU0ypI+p/5V9xUWN/PIQmHcA+q2lPvnOSgMqdI+VJILMvbjISyvcaIf4Sr8s27Wyd/aJARDWAu0jGb0ZshVi4S9hLXNRdz65K9HJTbMQ+SLbPKNFSKwagQ9G/LObEnJbvvBZIDluE3PxW/G4NLFCwvdwKWIMrfhEDvnf9feZmqYKgruPw9z5ikHL9y+5FJ+CPAK8FhzDBw2OSjnDZTZifDjq3MNcDKeqqf9mMT8tEow6P/ofsr8VxHOtH3q30=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ecc48f7-f0f3-45bc-28bb-08de755459d8
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB8212.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 16:30:27.9676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9alYVhTcTkrzQu5ZWCa6xs4AADo2ug7+HQGXNX1HAOGSzoMJQ2s10Ogey48imfCBn6tuI1X9vO8awceQl/CPYLb1LBB0nUXwIq706ZH7yZM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6475
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-26_01,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602260148
X-Proofpoint-ORIG-GUID: jjL84s6TJ0lqIDUwjup-gBtF9R7CIoCq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDE0OCBTYWx0ZWRfX0xSkrHO7c5ri
 Qi3khRmI0qGa8snCwcx9dsQGDYpwzoRMBC5WKT1M/6tmWFhjpz97ZVe/RMtRpo42qIHEOY9PdIm
 jvE/GC7Hw2CjVozplEaorH5CncUBnHDWevC1wNMl3ipRSkIyf2wZLwcfg2T9XtYYR/AV+YNKy+u
 ccWE1sz7OnjZjRcrla115qlxgfRuh41QotvwelThX8JKUfddKYldogsyqJyLZKCmus/aqFGUcO3
 hlwi9co24F0tLJN06vxvkBroO/eS0Of7xl7SCJMcjtjSbsWWWPLE7pbzixDBxmkQRNXy+xTc+bB
 BkhqCu2KgHrVSbSQyitrg1UjQ3zrdGbX+5M5lJqCExDNkAkPnKi/vyxB8Rj/SJInW+vnLQ10/yw
 2kIWRkOopqlk3qonsBgzdZhJTELX9/vvFMXk4ljov2A5TIbAJVdjhQBqDADLYQdUDYAgOIdf10l
 fVrQCPPH23bPkkqSukw==
X-Proofpoint-GUID: jjL84s6TJ0lqIDUwjup-gBtF9R7CIoCq
X-Authority-Analysis: v=2.4 cv=D+xK6/Rj c=1 sm=1 tr=0 ts=69a0752c b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=ppRx11uXk-LizC6mCIQA:9 a=QEXdDO2ut3YA:10
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78596-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:mid,oracle.com:dkim,oracle.com:email,oracle.onmicrosoft.com:dkim];
	FREEMAIL_TO(0.00)[kernel.org,zeniv.linux.org.uk,suse.cz,goodmis.org,efficios.com,intel.com,infradead.org,mit.edu,linux.dev,suse.de,redhat.com,manguebit.org,dilger.ca,suse.com,oracle.com,brown.name,talpey.com,samba.org,gmail.com,microsoft.com,dubeyko.com,ionkov.net,codewreck.org,crudebyte.com,auristor.com,themaw.net,cs.cmu.edu,fluxnic.net,tyhicks.com,physik.fu-berlin.de,vivo.com,artax.karlin.mff.cuni.cz,nod.at,paragon-software.com,fasheh.com,evilplan.org,linux.alibaba.com,omnibond.com,szeredi.hu,alarsen.net,huawei.com,wdc.com,canonical.com,paul-moore.com,namei.org,hallyn.com,linux.ibm.com,schaufler-ca.com,amd.com,ffwll.ch,linaro.org,google.com,davemloft.net,arm.com,linux.intel.com,dev.tdt.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dave.kleikamp@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[145];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 6B2BD1AC64A
X-Rspamd-Action: no action

On 2/26/26 9:55AM, Jeff Layton wrote:
> Update format strings and local variable types in jfs for the
> i_ino type change from unsigned long to u64.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Acked-by: Dave Kleikamp <dave.kleikamp@oracle.com>

> ---
>   fs/jfs/inode.c        | 2 +-
>   fs/jfs/jfs_imap.c     | 2 +-
>   fs/jfs/jfs_metapage.c | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/jfs/inode.c b/fs/jfs/inode.c
> index 4709762713efc5f1c6199ccfd9ecefe933e13f67..c7914dbc91ed97e200edbd114e2d4c695b46fb7e 100644
> --- a/fs/jfs/inode.c
> +++ b/fs/jfs/inode.c
> @@ -64,7 +64,7 @@ struct inode *jfs_iget(struct super_block *sb, unsigned long ino)
>   		inode->i_op = &jfs_file_inode_operations;
>   		init_special_inode(inode, inode->i_mode, inode->i_rdev);
>   	} else {
> -		printk(KERN_DEBUG "JFS: Invalid file type 0%04o for inode %lu.\n",
> +		printk(KERN_DEBUG "JFS: Invalid file type 0%04o for inode %llu.\n",
>   		       inode->i_mode, inode->i_ino);
>   		iget_failed(inode);
>   		return ERR_PTR(-EIO);
> diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
> index 294a67327c735fb9cbe074078ed72e872862d710..3d714fff09992173dfe6c9c74980f034ba4e1a72 100644
> --- a/fs/jfs/jfs_imap.c
> +++ b/fs/jfs/jfs_imap.c
> @@ -302,7 +302,7 @@ int diRead(struct inode *ip)
>   	unsigned long pageno;
>   	int rel_inode;
>   
> -	jfs_info("diRead: ino = %ld", ip->i_ino);
> +	jfs_info("diRead: ino = %lld", ip->i_ino);
>   
>   	ipimap = sbi->ipimap;
>   	JFS_IP(ip)->ipimap = ipimap;
> diff --git a/fs/jfs/jfs_metapage.c b/fs/jfs/jfs_metapage.c
> index 64c6eaa7f3f264ac7c6c71ad8dd0d59b63f15414..714dbf34b7ac17f82ee9ebec2f9a5b4c5e6f7356 100644
> --- a/fs/jfs/jfs_metapage.c
> +++ b/fs/jfs/jfs_metapage.c
> @@ -692,7 +692,7 @@ struct metapage *__get_metapage(struct inode *inode, unsigned long lblock,
>   	unsigned long page_index;
>   	unsigned long page_offset;
>   
> -	jfs_info("__get_metapage: ino = %ld, lblock = 0x%lx, abs=%d",
> +	jfs_info("__get_metapage: ino = %lld, lblock = 0x%lx, abs=%d",
>   		 inode->i_ino, lblock, absolute);
>   
>   	l2bsize = inode->i_blkbits;
> 


