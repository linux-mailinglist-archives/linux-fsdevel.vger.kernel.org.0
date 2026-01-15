Return-Path: <linux-fsdevel+bounces-73996-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB5CD2803D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 20:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BEAC030A10E9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 19:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9102FF672;
	Thu, 15 Jan 2026 19:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cmJWzv/E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCF72FE595;
	Thu, 15 Jan 2026 19:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768504714; cv=fail; b=WAQxvxBeMcIlhHNkCyt5BZUjKHiIJz70Isdtp8cDj8Zlb1u0VR3wScTGy/HU0gcqhc7IXR5SacS/UwbA9MUfAgELYlze5bqICkkPCSXcijPdsHHpCnVGIKwenTAiM5TbKaY+TJyKNkXrAKZhsBw9KnlakN62h/l65wnuD5cLNpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768504714; c=relaxed/simple;
	bh=rH3LclXt/KLGbjchLkxp10IBRZAg9YiMc489miC4wus=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=Azn7XSHhvha+Fh298No12r4XFdtK+o+XMVdNCSLLwr7UokMYmtxpVYwVGGfsdUFZpNHJGSnfTxj5o8zCuv0QDeUs5AUx08kn6LWyFcgsVKZ8sLsO67mNOk2nErIB/wkBDQ3rr2QAjbnzQLSRyuwgZWl+8cgPENo+lH/U+5xTfnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cmJWzv/E; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60FIU2aC023089;
	Thu, 15 Jan 2026 19:17:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=rH3LclXt/KLGbjchLkxp10IBRZAg9YiMc489miC4wus=; b=cmJWzv/E
	4ruo4RTng6LGa9WwXsHQ36SQW9A5PhPfRzP6AP2FzTozeO0oX5OtheMQJiHleYEl
	iTSkupyvFN4g4Awna41JkHbM9tGn9OKtzaU9S7lWju4hQ2u5KK3AAMU2ekpOCfU8
	ZidI6D5cFv6zNURiluC61cGVOx3myS+B2bjVsDDFO3nHewxZldXTxawQyBHGzj39
	yHb9xmdvVwIEFmwNocKgwAf/8EODG3mOaTakYnUMJEhqy5KyGHxiXaazWYBU1Stx
	HpT/hqqf47w0UkchUt4urWN41fACXpw3QEKGqZvLAG/2OsM0q1xV1CD5TeRWKWLB
	1R+qe243QDGPpQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkd6efwag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Jan 2026 19:17:01 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60FJDQbJ015215;
	Thu, 15 Jan 2026 19:17:00 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013025.outbound.protection.outlook.com [40.93.201.25])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkd6efwa9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Jan 2026 19:17:00 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c2H3lKjoTehnlsrTK8C2fMw9UquOrYD8PVNopasn8MwhUuQ3ye0J8UwdN50NM8jES+R3ObNtJPFAcIs+CCBIxG3ypBUjsyNOcVOOIkD1oefV569fZxa9EOG4DMJQrDtmLpJrPKmEyDbTJQxt8+FbU8F3OGtUJ8HHaxw7Kuo9scCo9eYoIp+R6RHwtptVUM0RyyGW4LCRHEMYWG3xgXKJ98d4EZu435YcqqXlMbR5r+XtWt69W5BD/rfFELLOdE1uPtbbF6ToBgMis9aDno1NjP0nx3UfqLNfyxwkIpkysfcC+kVPNjuJNqhsmQHEXnYSmOfjx6fknRL9HjPgaPfKLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rH3LclXt/KLGbjchLkxp10IBRZAg9YiMc489miC4wus=;
 b=xh7m5Ro0wOnUdQ5647dMBoPu3WywMZdNwcCASfmViw7wmxO7albGeBMg4OxL3nHEQWiBvKhOXcoGamVVvYG06D6vmNH/VO9snUSf5nN47susKonG2IfeXKiCI8aLH+kFVRQX4xHC9mB0PbKtNiLJ1o61A52EuPveE8s0kRbQIKr35Fe8lztjmm1J76qQKYMRvf0R6N0kD+r8dZEN3ITk3dAlHbkQPMwfMQ1X5m5Z4yiqhEJ33Wcnd6EGTi6HMGszOazbTAfthyde0OEL0s8BZc61tAigX/SfgtA6RyZESJb/kOSFk9MY2crBuLBCwVNpHZRZ3Jmrcj8l6KA67vfj1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by MW3PR15MB4043.namprd15.prod.outlook.com (2603:10b6:303:48::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 19:16:57 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9520.003; Thu, 15 Jan 2026
 19:16:57 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "richard@nod.at" <richard@nod.at>,
        Andreas Gruenbacher
	<agruenba@redhat.com>,
        "lihongbo22@huawei.com" <lihongbo22@huawei.com>,
        "guochunhai@vivo.com" <guochunhai@vivo.com>,
        "sfrench@samba.org"
	<sfrench@samba.org>,
        "jefflexu@linux.alibaba.com"
	<jefflexu@linux.alibaba.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "viro@zeniv.linux.org.uk"
	<viro@zeniv.linux.org.uk>,
        "bharathsm@microsoft.com"
	<bharathsm@microsoft.com>,
        "konishi.ryusuke@gmail.com"
	<konishi.ryusuke@gmail.com>,
        "tom@talpey.com" <tom@talpey.com>,
        "hubcap@omnibond.com" <hubcap@omnibond.com>,
        "anna@kernel.org"
	<anna@kernel.org>,
        "luisbg@kernel.org" <luisbg@kernel.org>,
        "chao@kernel.org"
	<chao@kernel.org>,
        "ronniesahlberg@gmail.com" <ronniesahlberg@gmail.com>,
        "salah.triki@gmail.com" <salah.triki@gmail.com>,
        "jack@suse.cz"
	<jack@suse.cz>,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "Dai.Ngo@oracle.com" <Dai.Ngo@oracle.com>,
        "cem@kernel.org" <cem@kernel.org>,
        "amir73il@gmail.com" <amir73il@gmail.com>,
        "dhavale@google.com"
	<dhavale@google.com>,
        "martin@omnibond.com" <martin@omnibond.com>,
        "jack@suse.com" <jack@suse.com>, "neil@brown.name" <neil@brown.name>,
        "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
        "pc@manguebit.org" <pc@manguebit.org>,
        "xiang@kernel.org" <xiang@kernel.org>, "clm@fb.com" <clm@fb.com>,
        Olga Kornievskaia <okorniev@redhat.com>,
        "almaz.alexandrovich@paragon-software.com"
	<almaz.alexandrovich@paragon-software.com>,
        "adilger.kernel@dilger.ca"
	<adilger.kernel@dilger.ca>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "hughd@google.com" <hughd@google.com>,
        "sprasad@microsoft.com"
	<sprasad@microsoft.com>,
        "phillip@squashfs.org.uk" <phillip@squashfs.org.uk>,
        "hirofumi@mail.parknet.co.jp" <hirofumi@mail.parknet.co.jp>,
        "trondmy@kernel.org" <trondmy@kernel.org>,
        "dsterba@suse.com"
	<dsterba@suse.com>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "tytso@mit.edu" <tytso@mit.edu>, "mark@fasheh.com" <mark@fasheh.com>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        "chuck.lever@oracle.com"
	<chuck.lever@oracle.com>,
        "shaggy@kernel.org" <shaggy@kernel.org>,
        "jlbec@evilplan.org" <jlbec@evilplan.org>,
        "joseph.qi@linux.alibaba.com"
	<joseph.qi@linux.alibaba.com>,
        "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>,
        "zbestahu@gmail.com" <zbestahu@gmail.com>,
        Alex
 Markuze <amarkuze@redhat.com>,
        "miklos@szeredi.hu" <miklos@szeredi.hu>
CC: "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>,
        "samba-technical@lists.samba.org" <samba-technical@lists.samba.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>,
        "linux-xfs@vger.kernel.org"
	<linux-xfs@vger.kernel.org>,
        "linux-nilfs@vger.kernel.org"
	<linux-nilfs@vger.kernel.org>,
        "ocfs2-devel@lists.linux.dev"
	<ocfs2-devel@lists.linux.dev>,
        "linux-cifs@vger.kernel.org"
	<linux-cifs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-unionfs@vger.kernel.org"
	<linux-unionfs@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-f2fs-devel@lists.sourceforge.net"
	<linux-f2fs-devel@lists.sourceforge.net>,
        "ntfs3@lists.linux.dev"
	<ntfs3@lists.linux.dev>,
        "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>,
        "linux-ext4@vger.kernel.org"
	<linux-ext4@vger.kernel.org>,
        "devel@lists.orangefs.org"
	<devel@lists.orangefs.org>,
        "linux-mtd@lists.infradead.org"
	<linux-mtd@lists.infradead.org>,
        "jfs-discussion@lists.sourceforge.net"
	<jfs-discussion@lists.sourceforge.net>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "gfs2@lists.linux.dev"
	<gfs2@lists.linux.dev>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH 08/29] ceph: add EXPORT_OP_STABLE_HANDLES flag
 to export operations
Thread-Index: AQHchkkOSFpE53Tg/kazK4rHHMBGeLVTmnQA
Date: Thu, 15 Jan 2026 19:16:57 +0000
Message-ID: <dd46aee3d0523cb88e3fe5e5c0e20df08b848a59.camel@ibm.com>
References: <20260115-exportfs-nfsd-v1-0-8e80160e3c0c@kernel.org>
	 <20260115-exportfs-nfsd-v1-8-8e80160e3c0c@kernel.org>
In-Reply-To: <20260115-exportfs-nfsd-v1-8-8e80160e3c0c@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|MW3PR15MB4043:EE_
x-ms-office365-filtering-correlation-id: ef1a0c21-c3eb-413d-904b-08de546aa6b2
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|10070799003|7416014|1800799024|921020|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?TktXNDdSUlhOTFdhS0ZDR1FPVlJ0aFNtNHFZVVk0TjNEZE9vV2I0OXo0MWtz?=
 =?utf-8?B?OTdld29jSHkwSUNHMWRNaFZ6UVljaDhmcXpraUlyZmI3ZmhNUVpPZ1NpcUpw?=
 =?utf-8?B?ajM3ODFTLzBmSndYRFc0WWF2aWJ2R0szeHdoN3BNRmhqK2I2YlpodTViWGdX?=
 =?utf-8?B?b3pmTWpJbEhvYy9IN2ZaVkRKNjJ3VEU5eWZUd1ZvNEo2RTJsa0dGbDZCL205?=
 =?utf-8?B?Y0FVYnI5Z1ZoVkFVUHAxMWxPOXJRYWxPOVBaS1IvcXg1NWViS0xUb3JTc1Qx?=
 =?utf-8?B?SVNRdXAwUkpheFV6VXUvM1JOOGpKMkpEck12K1hPWDV0czdVYWlNSjE4RDlq?=
 =?utf-8?B?YTJCZE00WTg3K1VzZEpwZmg4dlQ5ekJDWFNQWkJ5VXkzMUUrQnNZM2ZxZDBk?=
 =?utf-8?B?b05pMEFCSEFTajZSd1dEWm1yMXNzQWJOWFpDcWhmbWdRcE82Ykdyc1gycGk0?=
 =?utf-8?B?RDFFMWtHQnkzY2d6cGE5ZERRb1hyNVZhZUIzdXllMUxiM1JyRHNtTHEwTThM?=
 =?utf-8?B?T3k5OWE0aDl6MDU0Y21QNDFWYWFwZXZyendTQjU4OXhhb2svWGs3VE9YU3ZM?=
 =?utf-8?B?RDFjTFB6MXB1Q2twWjlRMDhWWmppSk9rT0dSbk1BMWZhdWZZMmdMVUMwTjdw?=
 =?utf-8?B?dzBJTzZhK25yaHloYldJVVU4WjF6a21VdFBYNDNWdFpqUTJXT25lMlMwczJY?=
 =?utf-8?B?ekdXcFdheHVoc3lHT2dBNkhkUmxXTThTWUhGcVBsdTFhSnR5UnIwZHUvRWRv?=
 =?utf-8?B?RkFTbFZPbkVFc1pvc0VNaXlVUmN4WmREbjBERGx5K1FiQ21YS3RGTTJKRkMy?=
 =?utf-8?B?elZBVXNheHNiYkpVQ0YzNXF1RWl0UTNER0IzTFRRRHo3a1IrZVl2YnFGdzdG?=
 =?utf-8?B?TUNRdzZtYUtsaUQ0NFJlZUp5SEVqaURKZ3MxbG5TR2hlTTRsM1g4VXZoa0tq?=
 =?utf-8?B?SEJSWmphWEIzcFhlRy9VTHRYNWgxaS9VU0haSG92QzRnZmdJSDhmdmpzWTRs?=
 =?utf-8?B?dlNiMkFxVHFVQnN4cEEzcVZmQVRUbDZhNGFrYStLUEV0VGJ6TFhWWW1TQkxr?=
 =?utf-8?B?RUZWMEt6ZkZodkVtckowdEJNQ2xhNEpYM0lXaUd5ZGdnbFJGYStPdGlPWjcz?=
 =?utf-8?B?aEhEQmxYWkVCdTVXSElFemZCaDFkaXRxVEFqaEpzdXpramZCS21aNXpQMW1Z?=
 =?utf-8?B?TmRBRm5kQUhPSnVpRnBDTHhLMjZQSitqQ3EyVVJRRkxNRzEreWJBWlRyVitP?=
 =?utf-8?B?RW45QXhnckZsUlhTdzRHMnVTeVNFa3QxbEJhRUg2cXJxQ3FjdFZPVWxvaHFj?=
 =?utf-8?B?RWpwdkNWdFk3d3B0MXNwU3l4YVZ4TEZDQ0RiRjU1RmFvWTRTNFVSR1hNdnJn?=
 =?utf-8?B?RnY3TXhKRURaMkxaeEloVUhkdkVJK3dHSXY0OGhZUkNYNUNDUlNIcEhXb3o0?=
 =?utf-8?B?MkFSSHRWTUFPbzltckZVeEJ4ZnJSd1U2QXpKM251dTNoNDR2TUd0RkdZcEEx?=
 =?utf-8?B?RVFTRXh5NHFmYjI1MVJnZjcxYzIxQVlWM3RIUnRyTEh3d2c5V3JyZ0E2ZVJq?=
 =?utf-8?B?LzUwNFFrb0dnclZxcU5LaVVXOHA1RmF5RC9lNmZ0dkN0RnVDbnYra1FzMmsz?=
 =?utf-8?B?MVliOFkzMFJ3NmVJV0ZjM2FTd0tTTEIvQThiTmprNy9lRU5kUHVMUklUbmtD?=
 =?utf-8?B?NFVJMDJTUjM4NTI4dUNjMk81eXJwV09jc1E0NzJDYnZRb2pwNnp5QkFmWTNK?=
 =?utf-8?B?L1hHU1BieVp5N0hRajcydnZzdWlTY2Y1WjkzQzdKOWJ0Q2d2ZEdaRFZzWlpD?=
 =?utf-8?B?dDVBYzJLR3h5MVdJMFFPL25VWHpCM1p4SUR2cTR1SFdaOHE3L3hDejFDbUYv?=
 =?utf-8?B?WHBCVkJHM0o4dzZFRDB0WkIrRVZWSHAxZWFreXZPbmVtZjFzNzNsSGFZcjVR?=
 =?utf-8?B?eUxmenA2Znh2c2tTbVoxMmhYVUJ3ZnRnRS84eE9WSjJybmk4dGh4L1NrL21w?=
 =?utf-8?B?aFdqb1M4RmtaakJFZmJrWmZQaVg4cm9Pay9mSnBWUm5mR0xmYnppUnhXT1du?=
 =?utf-8?B?S0Rad21aUEVmYTh1OEZuTjFWbUpMSmtsOXR4akEwQmtIWnJGbnRmNXE0ak5E?=
 =?utf-8?B?d3JSVThBZ0lxVElZQ1hHMHpvdUQwNWVVaFVHVGFvOHN3RnVnRkFLR1k5UkZx?=
 =?utf-8?Q?HWnPZfmAOPlfTgyvS9sZ/KT8OEkxQplxympUI5Mty4on?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(7416014)(1800799024)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WkZ4OGRhaHI1N2VNS1FiZitRVFBMMHM4VHpSMFFOUEVDb3dCRzhrcjBVMm5u?=
 =?utf-8?B?RitPNXpETEtyV0lScU5TT2t4ckVoVG1SbWlVaDdmc3FWckNIa09MSXBHUVBw?=
 =?utf-8?B?TlgzV3M5S0dQK0pRTHFQRm5WaUthL1duTmVHbDNzUHZ5MXBaNVlCdEdtSXpP?=
 =?utf-8?B?eXhvbUFUV0EwQi8yY2FMdXRhNUVBVlVSU2JDMEtab29jdnR2ay84dlRsZi9m?=
 =?utf-8?B?T2JBMi9UcFc1UTBtUXRycGFLazNlb2VaQUJwTytLT3pmNnRVNWZ6WDVJMVhn?=
 =?utf-8?B?RE1FOVU3Vkp1YkdSY1czU2hsd3FhbWU1ckpYQTk4RjNyNDdtbC81cW1PVlBF?=
 =?utf-8?B?dW9UNkpCaUxkZUtiQnBRdzJ5VkNBTEFVT1R3L1dMQXNxblFldE50SlRqakdS?=
 =?utf-8?B?ZUg4SzJJM0dDM3hKeHVDYmV4dGUvMlBnTUVzdnRHQURLbFYwYVRWeitWWEhC?=
 =?utf-8?B?dExCSlozU0V3ZzJzTlNpQlZDQnR6YkovVy9XVzRYYjJZS21yZDRvZzNlczBi?=
 =?utf-8?B?TG44eURvejB5VzNQbGhFV1p3RzRoaDV1ZmczcVVTUElmeUxobUdKdEsrTXY3?=
 =?utf-8?B?dHEwaUw2dU1RdVEzUm5OS0JqMzJra3h0L2hMNXZIYjRhTFlIQ0ZWNjhIbCty?=
 =?utf-8?B?TVhSeXFQY2h4WlgreWYzb21neVAxWWs4K3RuVVBKNlhoNlpvdkdkZFduRG1Z?=
 =?utf-8?B?dmp2ZENsOVZoZCt3cGtRRTQrZlBGZ3VaaVNra0NkZGdqWnBmekNlcjh0eDdw?=
 =?utf-8?B?Wjg0YWlVSFJrL2kwbktIZHJjc3BtWGpRMjRBNmEvR2VTSzlqK3k3SzZ3ZGNu?=
 =?utf-8?B?WHVQeFZFZDlmbEMzY2NFL0M4LzJoOEYxY1ByTUI5SVVrbm5xRk9SdlB5clFG?=
 =?utf-8?B?QUtxWFJjbThDWjEvREtaWUt6WnVJSTY2bDBpYjQ0Uk5VRTQ3OUNXSU1VYU1h?=
 =?utf-8?B?SWM1YlNza2QyelllY2w0Qi9sa05NQUZYMUNmRUZJQXNETFE2WXIyQUczRk9w?=
 =?utf-8?B?YktlZFBnMUVVbnNMZDQyeWRaRkRGSDFxdUJHZEZ6ZkJnRkxzU1B2TFpON2xq?=
 =?utf-8?B?NUNic3piQmZ3bkgxTWZTcTJabHJmUGgwL1FGb3hJNUlYaUc0RndWejRHRDNU?=
 =?utf-8?B?eHhTNW5sZzk3VllubHp6UE9OMUxLSnpwVjlIRW1xZ3JxOVNoQmtiUnhUTEtY?=
 =?utf-8?B?NHNGUWgyc25iTHBlTWFINGxDcWNjVVZlRk80by9rd2tBbDZsUDBML3V0TnRI?=
 =?utf-8?B?dVhpTTRKbCsvS3luenpPQlZhdGovUmc5bzFDVEdoL2FMV0xKNXJTMkFjNEln?=
 =?utf-8?B?Z0FJT2IrN1B5REpBSC9rS1FLcEZJSG5uQXVYZUVodUZzK3F2MkQvd3VxWWx5?=
 =?utf-8?B?N1R5VkVKd05iZEdFUVIyN0hSWk5ucGM4aEh5ZWppbEEvendFYjRIeitYSjVu?=
 =?utf-8?B?NkNOMzRiWkFIT2p2QXNVb3l3TGNyd2JvWmxsbllsRWh5VzNMS1dralgzM1Fi?=
 =?utf-8?B?MjVSOFkrT0NYNk5WNFlwZUdmbndGMGJEZklmcVpFbWtCYTNtd0RzcEExMGFZ?=
 =?utf-8?B?SUtpeENGQjJKeExoNmsxaUNiRFV4YTUxeGhqSkZNQ2pGaTVnSEtXNmJiRXJC?=
 =?utf-8?B?ck9td1BNUFBEek9XTUdVbEk5bXhXRVVZSytZOFB6bzlBUUdIZEhmVTFoM2xB?=
 =?utf-8?B?MWhlK3czVlhRVnM0ZXY2b3ByQnNjNTNjcy9BYUthMTdzMEtoWmNpREswVzA3?=
 =?utf-8?B?bnBOK1c5L3RLYlEyS0pJNjNMZk91KzNOUUVBZ0oxTWozd21FTjdqWmRKWXc1?=
 =?utf-8?B?NlFraGpSa0tHVGE1WEFMbEszODIrL2JkUkl5MGcwbFVxWDI2dGUyR25xVCtn?=
 =?utf-8?B?SWEzeCtINk9MY0NjUTlSK1hCMVp0dDlxNWlZQ2h1RWhHaFNSckFZeThjN0Ew?=
 =?utf-8?B?SEM2bWNGTmpuZzJxeEhqelpFQXUwdDFrRk85a3MrUzgvSm92QWkrS0VML1J0?=
 =?utf-8?B?WGxqdzFjNEhUemNuWW5rZi9iSFd2Z2MvSEVjdnZBR093Z25xdnhHRjlNV3dk?=
 =?utf-8?B?WHArT0FuSU9Sekg5cDZrZ0ZnS1JMbVBORGpHWUhXSitIT25WUlFOS0VoWEs2?=
 =?utf-8?B?dlJUb2pkSkgxK3pvR1ZxVFlnQ2NKb0ZEL00zR2V6Q0ZOL3Zjc2p4cXNIU3Zz?=
 =?utf-8?B?RUlpV2RFUlVUKzJQMXNwbnp4c3dlUEdJTDZlL1Q2MmR1MDl5Y2w0d05iajVB?=
 =?utf-8?B?TGtHVG5CV1VBVUNDTWNrQ0tUaTR5Zkdmd1cvdXBXTGh5UTlvS1BUakFkWGVU?=
 =?utf-8?B?QU9tTVc3YVo0aE1qa1h2Y1YwOEFDZHk3K0ZPTlNqQVAvVWNCdjRvZ1ZjVG91?=
 =?utf-8?Q?1vqiBU113rH4HjuCybG/Yi+ZX5n5OcYBeP7Kt?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AA31506FFFEDAC438918E2313CC263D5@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ef1a0c21-c3eb-413d-904b-08de546aa6b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2026 19:16:57.3112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 68OaQ2D/5APJvo4bH1ZdelkSJTrTdtQh/imD505Vd1+LwN+2e/mFn5laFPrtdvGtwWLz74RNbPzlNRhCkzN00g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB4043
X-Proofpoint-GUID: h_Dt0A_HC-LCDVe9UGWssDMsfwUUlhuk
X-Authority-Analysis: v=2.4 cv=LLxrgZW9 c=1 sm=1 tr=0 ts=69693d2d cx=c_pps
 a=7LdyZ4/2TJtu80KvlWUjDA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=-3Ol6yoTp_daicIKV_wA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE1MDE1MCBTYWx0ZWRfX3vj2dRXKlhWu
 mV3PSM+6TXinvNfYl2YCMflYyZ9ZhdWqYPZEUf0jTeCqkufJHOH1f0zq1K+o0NM5oHjMqfaTgV7
 FIUXvx8hks0hJaahE4UmEeLeRF13DgyFKkZyG26ZW25d3LrzpFG17JIvpAGGuzl3Nio32I//rwT
 /8i31bg31sQwZr1fhMRYHty2NjBHQc/fWKH00EZAjFalBhOEFMLrpAc+SvuQA9ubLOkSQlreTMi
 evIYax7+8Ugap66xE0MVawUGRwueVWripGEOikoh76/91WdhkyOILalOpFbouLT5PyEdWlanYaB
 uZjSTwaVcoIcMyDZ9Ea5v8wRha6xHEhKg7mU606iPgAeviVcMHjU1G1/lBq2FPCzrcn4xqS4ygp
 6AeXSZcHk5Srs4QqksipxunA232+pcj2vZOGoOxdNWEJV17O92ZfRwbpZiIonk4Y2pp8vSIJs9k
 RU2ceuqpgD8XyvdXl8g==
X-Proofpoint-ORIG-GUID: T8w5wUNtXLJyj-F79G75yxxlr34fyCpU
Subject: Re:  [PATCH 08/29] ceph: add EXPORT_OP_STABLE_HANDLES flag to export
 operations
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-15_06,2026-01-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1011 spamscore=0 impostorscore=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601150150

T24gVGh1LCAyMDI2LTAxLTE1IGF0IDEyOjQ3IC0wNTAwLCBKZWZmIExheXRvbiB3cm90ZToNCj4g
QWRkIHRoZSBFWFBPUlRfT1BfU1RBQkxFX0hBTkRMRVMgZmxhZyB0byBjZXBoIGV4cG9ydCBvcGVy
YXRpb25zIHRvIGluZGljYXRlDQo+IHRoYXQgdGhpcyBmaWxlc3lzdGVtIGNhbiBiZSBleHBvcnRl
ZCB2aWEgTkZTLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSmVmZiBMYXl0b24gPGpsYXl0b25Aa2Vy
bmVsLm9yZz4NCj4gLS0tDQo+ICBmcy9jZXBoL2V4cG9ydC5jIHwgMSArDQo+ICAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKykNCj4gDQo+IGRpZmYgLS1naXQgYS9mcy9jZXBoL2V4cG9ydC5j
IGIvZnMvY2VwaC9leHBvcnQuYw0KPiBpbmRleCBiMmYyYWYxMDQ2NzkxZDg0MjNjOTFiNzk1NTZi
ZGUzODRhMmZlNjI3Li4xMDEwNGQyMGY3MzZhODA5MmVkODQ3ZWNiMjcwMzBiZTI4NmMwZWRlIDEw
MDY0NA0KPiAtLS0gYS9mcy9jZXBoL2V4cG9ydC5jDQo+ICsrKyBiL2ZzL2NlcGgvZXhwb3J0LmMN
Cj4gQEAgLTYxNSw0ICs2MTUsNSBAQCBjb25zdCBzdHJ1Y3QgZXhwb3J0X29wZXJhdGlvbnMgY2Vw
aF9leHBvcnRfb3BzID0gew0KPiAgCS5maF90b19wYXJlbnQgPSBjZXBoX2ZoX3RvX3BhcmVudCwN
Cj4gIAkuZ2V0X3BhcmVudCA9IGNlcGhfZ2V0X3BhcmVudCwNCj4gIAkuZ2V0X25hbWUgPSBjZXBo
X2dldF9uYW1lLA0KPiArCS5mbGFncyA9IEVYUE9SVF9PUF9TVEFCTEVfSEFORExFUywNCj4gIH07
DQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBWaWFjaGVzbGF2IER1YmV5a28gPFNsYXZh
LkR1YmV5a29AaWJtLmNvbT4NCg0KVGhhbmtzLA0KU2xhdmEuDQo=

