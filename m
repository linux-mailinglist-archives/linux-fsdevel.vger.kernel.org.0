Return-Path: <linux-fsdevel+bounces-76407-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LZrGwyFhGl43QMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76407-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 12:54:52 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4099F2159
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 12:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88AF03011C78
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 11:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7468A3B8D59;
	Thu,  5 Feb 2026 11:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mE5UAd6D";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AjNl3mpi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D70378F4A;
	Thu,  5 Feb 2026 11:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770292478; cv=fail; b=Um9nbBtIXPVP8KDvPGBwsjlgvVHlgPOf8GGdlc+pSBxfBruNgw1NUI1gKIYCc9IlUI+HKPR+R6dx/89tV01N6sxlVVr/iZZuaGWryyHTFYCie8wyDkrmEVv32QraOIoImrM2Pft4C0rmOALaetOVdRcByeyJGnOtJ1YPZ3+aUrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770292478; c=relaxed/simple;
	bh=y+jEedQO5ZAoGuNhtHkPoZkWpxoPjAwVt2jy0PUo4jg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VU9ZQApww9PgekWmua/oZ6fC+Nn4CMP5Pqzgc3T/dxyV8IU01oo8DsaKIdwcLIfOHfQYNgh7S2J/70WcwxPZxI9OXjtupEnqojEKZF+3niTrLYijvtaNYKDyd9kii7qcgdR51caDldHrGfDkjpyP2aZTBeUw90tFE5O8Gz0jmRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mE5UAd6D; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AjNl3mpi; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 614N03CJ3258017;
	Thu, 5 Feb 2026 11:53:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=B+9wdb1iCIi2aXds8k
	kDnIoLnEL0oi4ewN8cQ+AP7L8=; b=mE5UAd6DjDjegtHe3/7dVZ33PY4/8Z8pCk
	TUTD3X+AjhVdLfj8vIBEZMvdgSYyUZL3YEODy81eRTzyObSWzj09omG0+2GrXwrI
	hEPCN8Xn8XChhLzaPb1e2IkJbjCn/hIBXzkDi8b661z4P41N3Tm+yg2naja7M3pn
	htGQviiPBZl50rcm3+m3NJRZditp+7KFv75Yk90uWvTu3GvigoQAtQ1pqf+D1xV6
	ReRr+luU4d5oNTKA83MNNxY2Uy4jEH/HyTDRY7QMATaHCblpDmgoVzlgwFjo007b
	B5reQR10Uw7T5NhL/vDDwMVo/PJapYNYn68mcdvw93qZDfk/z0iA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c3jsqkh6c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Feb 2026 11:53:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 615BPvlf026508;
	Thu, 5 Feb 2026 11:53:39 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013058.outbound.protection.outlook.com [40.93.196.58])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c186d2ktj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Feb 2026 11:53:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sfyKitsAxltJEAO0xhpb5GO0D01fWtpd/Yz7pDAwQ60lAs/cnNUMl591jQMEwvfWBVYNYuJ+WjU6iF4II9YVuVlNGikFIxCI+cwNlINcijdtysGUBWUnlvqg+/iJ9eLrOQCxa9gHi2hsDYTcHosghbakM3d61UP3CYlpXHY73cO0cJutvnByauzvDm/IymT9btjF+2i/2kw7ATmJH7gIN9UDhX0mfyQVI7nY1mGCSwvBGWC5nrWiJHol8sAyO4aWPVdFy2wSDMSDYG5wjUa5iXSNpUsNZ0VD8v7AysxQrmCIP9rZ71IQZa7oGRFpN+Vxo6Z7wYfQLZTvmXjvjApI/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B+9wdb1iCIi2aXds8kkDnIoLnEL0oi4ewN8cQ+AP7L8=;
 b=Wae//NF7jopUMy/5DRa0qq/CshPMKhql+XDbzvqBYCxAFClvKAtMsAS58speV441TYzEMb0I1x9UREidCOpL15x3IpWS2JGYis3wxA+GMLwRYp31BDiR904YZU8lngCNZMW3UX0pDSFNqCgwcKaYOe4Pdctb6ueJpA4NfFntdiypE1fdkcMa6flVWwATpVLPonDCYrTZ+YpWG2HgbWYV51mH05c9G/mNhdke03XQUXMEceyrznTyNFvmRKN7b2W+u06JdniuxBEkogfsAHHxYlJsNffgpnws77OYRmS8lAENoYTFjjx/3coUrV9seJ+K6sgxXhV17ZieKMWzepR8Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B+9wdb1iCIi2aXds8kkDnIoLnEL0oi4ewN8cQ+AP7L8=;
 b=AjNl3mpii9b3aeLLJBtyUQhx0ILhXZhMiEeZzp4D+z0PlN+MdRB7+Pll7/GKUiF6zwAZggpkhLlzC1mcAGp1s9krfjADLIrhokbF5v5rlzYMqCx1JmUZDRC8//EfZs0xhMHtFGKJWpLiIQsNY2c/iwqYqpRS/hxYD4o/WWKOsKs=
Received: from DS0PR10MB8223.namprd10.prod.outlook.com (2603:10b6:8:1ce::20)
 by SJ0PR10MB4493.namprd10.prod.outlook.com (2603:10b6:a03:2dd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Thu, 5 Feb
 2026 11:53:19 +0000
Received: from DS0PR10MB8223.namprd10.prod.outlook.com
 ([fe80::b4a4:94e3:f0bc:f4c9]) by DS0PR10MB8223.namprd10.prod.outlook.com
 ([fe80::b4a4:94e3:f0bc:f4c9%5]) with mapi id 15.20.9520.006; Thu, 5 Feb 2026
 11:53:19 +0000
Date: Thu, 5 Feb 2026 11:53:19 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Carlos Llamas <cmllamas@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        David Hildenbrand <david@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <lossin@kernel.org>,
        Andreas Hindborg <a.hindborg@kernel.org>,
        Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
        kernel-team@android.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-mm@kvack.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 1/5] export file_close_fd and task_work_add
Message-ID: <9a037fdf-1a98-437f-8b80-7fdc53d5b0fa@lucifer.local>
References: <20260205-binder-tristate-v1-0-dfc947c35d35@google.com>
 <20260205-binder-tristate-v1-1-dfc947c35d35@google.com>
 <9d0d6edd-eab4-4f31-9691-78ed48e7ad5b@lucifer.local>
 <aYSCNur71BJJeB2Q@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYSCNur71BJJeB2Q@google.com>
X-ClientProxiedBy: LO4P265CA0261.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::14) To DS0PR10MB8223.namprd10.prod.outlook.com
 (2603:10b6:8:1ce::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB8223:EE_|SJ0PR10MB4493:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fffcc32-4a0c-462c-cd66-08de64ad27f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MnWWgT/Nw8rW2a374lxRAPmDkmtFWnRBSfqy1Xj/loI3k8aLP3S9u1eEt/Lv?=
 =?us-ascii?Q?9hZPuBd6L77q/MNn+X/q/56ezKrJ4hJEIh4z0x+vmRbs4ZljLVm2fv9aDTQL?=
 =?us-ascii?Q?31TNtAKfFGYRkoQOrUAj+9/HyuJFxaq+PTsPivgkGeYT/+p5fmymaaiTPuX+?=
 =?us-ascii?Q?EOQS1Huw1S6lJXsl1Muu/7FUdCIKWG3vcrI5iTodBuPmYNe8ndjn+5/9cBfM?=
 =?us-ascii?Q?Sfb6iLBL0Y8L8QGMFtUOxJvY/PCV0H2oxgW8BJxgg5Ty5GWAsm04/Y/dfU4p?=
 =?us-ascii?Q?aPiDbzp4Xz9VJ6w2CAp09uNfjswKmhnzzQtSoY0y4Two3X3wJlnMaMc7FekN?=
 =?us-ascii?Q?JXKzO+PT3X5Cu53Qmbe1eGxK3n4SM1oPbLxo9p8N5FpXg6okClo4RfxqBg8F?=
 =?us-ascii?Q?bY18cBqYsdqH8WyHst+dYHgOnzQIqHv8HlCc1NE007J3nOedHW0ulPWt4dMb?=
 =?us-ascii?Q?y5Mu0me5yfr7EU843iSyDJfCQwGFVcpBnlwQm4dl9xgQ6C43ZQUQTO8F7+gK?=
 =?us-ascii?Q?w1lpqNdhEuWNPH2iBsKww6fP+9zkWNwf+1nn4ET9VMIVdYz0mqA30dFrhkfL?=
 =?us-ascii?Q?2VsT1HyPbi6k7LBR38QJpqcleB7ny0olKjekb3ZHuJE18DC59qtsQMDZquGE?=
 =?us-ascii?Q?QVyBV7+TQiAz6eHvor9aDsxInCjPRQo0wOk+EwpA1sh1fVbu8RD9waxH5xRO?=
 =?us-ascii?Q?hryPVv+nhkTbmMszKNe7/0m/sLrIs8xw9e0EqoPZcN+vy+pb351VB12aYhdE?=
 =?us-ascii?Q?mVOzSffy1eU+drFjcPmN12fCGqf3jrEQ7o683oNVQksz2dTehXPSOwDO7Xx6?=
 =?us-ascii?Q?f1Kmn+nVWdqDMv5wA70GyK5JcmbRE+U9zYYqtDiNvou0KFf03LMWg6Y6w7Jb?=
 =?us-ascii?Q?lsnU8t5PzfKmJvyEXb8/JwntDWOPzdpbOM1zCMd9rBLvHXAI8gpyErntM6kt?=
 =?us-ascii?Q?JRAAn/Nu8Z6UCJ9cHqqXD6jI87+PuoMOjRaVq/3lr05rodVGhyOpQXR3OhK/?=
 =?us-ascii?Q?h0bGerDvv76MRXHvcBcoASr251QRF0AdZDKtTas6jM+156H07arPD3aMIdY5?=
 =?us-ascii?Q?aXI7Ff/m3DFMbJ4D3lH6xsKOcb28YkzXgIZ93pHT8TPcC00OzUWPBmmjCIS/?=
 =?us-ascii?Q?g0DHz7c/cG953wjkxLeaWr2qhWnaZOnK4U6tlNjTYylklndrW2imJJITxd3P?=
 =?us-ascii?Q?LbGu9FGFp1cA0b1TXli2IxIFqyWBC7G05ZUD8Ylj8Rb0H1KmjbareFZBRiih?=
 =?us-ascii?Q?w4VJCd0ZRv5gT89y1eKcSfQrg4aAmMjFVZcRTJEarC6SNwrt4F66e5p4XY/p?=
 =?us-ascii?Q?8ni+6ZzfIVIspSG95VlHrWyHp0jyyOg7aTEwbjP+IU1feq4OP26DbiQHci6S?=
 =?us-ascii?Q?bxYHvms4vnHT40nmfnYz5DjlJyos8NAMJlKFp9YTF/oOsO90VFib/pdfzYmG?=
 =?us-ascii?Q?+i2gPfDJ46A83NM33AD7rfB056fjTzGYENbQKLQURVL+ysvwE9teQbgK1C6t?=
 =?us-ascii?Q?HCwvMx49Wphknhi41BIaheEU/q9zUTAWn6FP24a5aqsozPZhIv+qbgfJyY1q?=
 =?us-ascii?Q?8isQrSGjiOqVvKH8G/o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB8223.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i8mgEHuebN9ZMQriPDyZ3fFo2LbjXEpKe+R3zACag6jALm2NOyuj9UcAOWW0?=
 =?us-ascii?Q?W0R4eBcyWDJ6lza4dPHINLhqrsHy5bm1D4gGPug3wMHli763cYGyFM27MyVV?=
 =?us-ascii?Q?kQXvWxdfhm6fWcb6EN0FG0nM+53KtOkXwaI2r1nl+iwcFcQtk5wuww2chKad?=
 =?us-ascii?Q?azTMZMtjX9QwKfB+hPM9xhJKhZ/e+t25Xu1Mw64X/xOv3qXJ6zCT+ZFNv6O4?=
 =?us-ascii?Q?+XnEmICLuBBgz0klH3zDTP8IzZH40sVu79t+Z7trUZvyGi5CiIrWvCBsOUDE?=
 =?us-ascii?Q?02HPiEWEQussqTFqbOng/tsnUWjRR1NYbtLI3CZeAwZpOMwXKx8myHGI6iUq?=
 =?us-ascii?Q?PPocHzuJlsLMuINLNjSkH6gBbbdlvUzi/lJyiAWpWVaxS6mihOiQPzgue3Dl?=
 =?us-ascii?Q?X54ROa4jFN9vkFlsTXZbxKUALILCfNYFHfFVR/+iI/CNSAm/nA2NzC+macA4?=
 =?us-ascii?Q?GYvCPSmAP2Fhah3BT3GwYRH6tYDotKAcQIFpV64L4lwhj2LTv8RHkpCWt/sa?=
 =?us-ascii?Q?1ooXydJphf9dEiHXUGxPuNgPijOsaRNHiED9zPZKERA3ahZ1kf0yOX7zs8qQ?=
 =?us-ascii?Q?dLbwNnr58njleLnQrNQS+FsIuu30QVItHGw6EBAfWCTyu0rjqy8kHjNFrxYG?=
 =?us-ascii?Q?3iHXFpFeqWNnDu3Wl1i3KTCOIuEQw0Krw2HLyIoLHRed7m0c2nATNsNoH+J2?=
 =?us-ascii?Q?vQu0hqN8C+DkS0qh3MoJ+8j2wKNciwe9Scqvb5Hg/Ni9Qq7/s9BWw3nDPwqB?=
 =?us-ascii?Q?2lZH8Tf+e/SP2gV6InfpKFAipvR4f1gansPs+X8UGdpb6mzw59+1UXXrkwBr?=
 =?us-ascii?Q?1NoAHMV545c63CGVcdeKO9yJ9pkPSQXJjEOQiagq/AHgEscWXDnehk06Bg4U?=
 =?us-ascii?Q?4AsAhyKxZMmP5rhneEHOkQPRk+jhliKcbIJ0evNGrTAGp/IZVS2kAwZIJyYe?=
 =?us-ascii?Q?XDwLt37SrXOWPzYKOR9alFQKxlrGJKdR8LdepvmPGrQIYm09aLIW3ca7gpBT?=
 =?us-ascii?Q?RBC8Is6srwI9ph20yTlILPcWvCVNClIliVGqWv5mQF/xlWYYmsK8oWLtCVvE?=
 =?us-ascii?Q?F6Uer4WHEgDXN/lcIfcNGuUd775qCcIyhzt2ZcFlhDyZiVf4s2cvaZ53sW9E?=
 =?us-ascii?Q?IEkoLfU+rezd6Zyebt7RmZNyKo/vpicxKs8mDoFZHdAs66RJialMKthzhfcX?=
 =?us-ascii?Q?zT5CWm32EsN95RuG/lUqRtI6pHBvdj5/DAfBjRkFJHX3syyaPPIbPQLBQ8MA?=
 =?us-ascii?Q?iK4pvAilLOACuznj3nmNlfZh7/S2hqo0GmVAQd5e0q0zET25f0/lbLzYuN2t?=
 =?us-ascii?Q?f68TgEqIn4EjcOBvF12EZCu7rc5gzCNvl9LNBOX+zHwL3dt6V1otAp/wsUGk?=
 =?us-ascii?Q?KHS70Hr3cxKYq9Xe7Hj6MB24bKnHh3LAkY4ksgfveQBU6qodZGlZiAs5YWWA?=
 =?us-ascii?Q?fTGqTt5LHGtDC4WwCo/YX+GpQdkQ7y/3GAViYIf2OfP0MsuGhiSiU8dwLz/l?=
 =?us-ascii?Q?A78ytpv217aTctmSsDXLczDPLtrbiK/gd2bgwDASBmVJp4iMEPF7UYzDCmPG?=
 =?us-ascii?Q?B1cmP6LDHZ+sWwuW3L7lL8wWtu+7+9mqyaZicDogL04Lrfk7kBrWvzfVlYtQ?=
 =?us-ascii?Q?jvsik2aW/yYqC0Qye5fb/7Qy8FMmzJIFYgdRs2H+6+yVMDIq+SxkH6Pl/ikJ?=
 =?us-ascii?Q?er38TIlHQLAX2yGe+qx1oz2q99IIJ3T+t6yexrqny+ibAjL2w3p0oTmlsnZc?=
 =?us-ascii?Q?YEFs4n+5zowKQpGQEyS5I5XTNRKpNCs=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	P4bR0e3Nk+TRTdbrLlWt9cNSoqYu37QVCPIiorQwMh7ToLg4iyBIm0w4CkWE2MA5zyvE2OVzdAAL85JrX7iA3S3obJwtVqhObzxVP5N8553pDKwMQUoKx82D0UnBgHUz8EOgn14+5XdIbw0/zmtepgoa56fNXuybovY7i4/T71CAkx6WE4TvHtd+bLP5nWHEdpVSQc9VnxtUxVlr2rWVw3XjAfmSMoH6DF/aDUyY0d45guFQhGjAPlzCz16NyjScV8zbaEYWIZ67gsSJxvTjR6ajHwC2x176iiTM7w2/3CnPhnOvUqixuj14UiCombVQ8ltYC6JYcc9sSNTcrunly4AZcASV2pZfKi/9mQfta/CQV1SKmnkKQLgUL+FU0oqVDvtaLlIr9sQrq3hGpg9qbsB75B0WapmQFO4EqNg1qa/RcEOX0whAKwys2T8RMjksHYWMBNc5q7qS22shASH2YJkn83kbp1DnBYUO+HZbzR/GTDPREpEZ2qQkwzkNY/cc9EhfJ7d4zFwxCPyNiRW1GpBdipP31uvweu88w7KxSj7AAbTLVxZkZGsaHwv6awQ4Ez/yTYvGmf+zR8VaqhJdU0dElfDW5ICh9lEHfOkoAKI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fffcc32-4a0c-462c-cd66-08de64ad27f6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB8223.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 11:53:19.6684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r54yNvAK5kpxkv6JYEDCXmC0uaDMgO7enVCI3xgl6bx0MIkUVxNJrAXmX/Jj6rgZbLEBWUjIrBduHvNMRWjdpDqjyxcuaHX9c7DZ+RFC5YI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4493
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_02,2026-02-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602050088
X-Authority-Analysis: v=2.4 cv=Db0aa/tW c=1 sm=1 tr=0 ts=698484c4 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=1XWaLZrsAAAA:8 a=fBMwrRO94P8TKjW3qe8A:9
 a=CjuIK1q_8ugA:10 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: occ5j24cSh2Mnq_y_ZQnrY28N1Y94RtF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDA4NyBTYWx0ZWRfXxf05v1a+ty8t
 g/q65vKSJaUldDZ+0V9xgCvKOLmTq42LD9u5uHkgmdmMOYMpOtUW/1sQsLW8wFF1+WBhGoQcX2L
 TYU406PqpDHAb0p9shvTPFhMHX+mKRYMdCxu4OxdQWK4pRLjNv/MUEwULVZMdT9ZT3IIWGD1ulw
 IVlZem5taZuZdTblxDLvkTCoSzEJuhnEZh99SLWxkQn/0CqmfRUqvWs7rzWSK5pktxJ/FnCp3Je
 TJhxytAyzz1PiDXE5euLW7InsQisD9LZg/J6FB0yptTBKctaFSkOGB7if1zT4qJHpvmfhqmgUA1
 uYKBUyb0SgoJeo4iQ8NZBt3rF8PE5/HwTzGScj9533gyNbWLatgYfqndWAym8jgVSNu1yE1HE9e
 98+oj9dTYdzsCxMfgAWWWx0/T4TvdRieGbZGSwNh6fB/s6oNwVsef8z36GJpP/RdZaUU209TyZE
 WHXykPT+XbLe7zZEleg==
X-Proofpoint-GUID: occ5j24cSh2Mnq_y_ZQnrY28N1Y94RtF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[34];
	TAGGED_FROM(0.00)[bounces-76407-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,google.com,zeniv.linux.org.uk,kernel.org,suse.cz,paul-moore.com,namei.org,hallyn.com,linux-foundation.org,fromorbit.com,bytedance.com,linux.dev,oracle.com,suse.com,gmail.com,garyguo.net,protonmail.com,umich.edu,android.com,vger.kernel.org,kvack.org];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lucifer.local:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.onmicrosoft.com:dkim,oracle.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo.stoakes@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: D4099F2159
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 11:42:46AM +0000, Alice Ryhl wrote:
> On Thu, Feb 05, 2026 at 11:20:33AM +0000, Lorenzo Stoakes wrote:
> > On Thu, Feb 05, 2026 at 10:51:26AM +0000, Alice Ryhl wrote:
> > > This exports the functionality needed by Binder to close file
> > > descriptors.
> > >
> > > When you send a fd over Binder, what happens is this:
> > >
> > > 1. The sending process turns the fd into a struct file and stores it in
> > >    the transaction object.
> > > 2. When the receiving process gets the message, the fd is installed as a
> > >    fd into the current process.
> > > 3. When the receiving process is done handling the message, it tells
> > >    Binder to clean up the transaction. As part of this, fds embedded in
> > >    the transaction are closed.
> > >
> > > Note that it was not always implemented like this. Previously the
> > > sending process would install the fd directly into the receiving proc in
> > > step 1, but as discussed previously [1] this is not ideal and has since
> > > been changed so that fd install happens during receive.
> > >
> > > The functions being exported here are for closing the fd in step 3. They
> > > are required because closing a fd from an ioctl is in general not safe.
> > > This is to meet the requirements for using fdget(), which is used by the
> > > ioctl framework code before calling into the driver's implementation of
> > > the ioctl. Binder works around this with this sequence of operations:
> > >
> > > 1. file_close_fd()
> > > 2. get_file()
> > > 3. filp_close()
> > > 4. task_work_add(current, TWA_RESUME)
> > > 5. <binder returns from ioctl>
> > > 6. fput()
> > >
> > > This ensures that when fput() is called in the task work, the fdget()
> > > that the ioctl framework code uses has already been fdput(), so if the
> > > fd being closed happens to be the same fd, then the fd is not closed
> > > in violation of the fdget() rules.
> >
> > I'm not really familiar with this mechanism but you're already talking about
> > this being a workaround so strikes me the correct thing to do is to find a way
> > to do this in the kernel sensibly rather than exporting internal implementation
> > details and doing it in binder.
>
> I did previously submit a patch that implemented this logic outside of
> Binder, but I was advised to move it into Binder.

Right yeah that's just odd to me, we really do not want to be adding internal
implementation details to drivers.

This is based on bitter experience of bugs being caused by drivers abusing every
interface they get, which is basically exactly what always happens, sadly.

And out-of-tree is heavily discouraged.

Also can we use EXPORT_SYMBOL_FOR_MODULES() for anything we do need to export to
make it explicitly only for binder, perhaps?

>
> But I'm happy to submit a patch to extract this logic into some sort of
> close_fd_safe() method that can be called even if said fd is currently
> held using fdget().

Yup, especially given Christian's view on the kernel task export here I think
that's a more sensible approach.

But obviously I defer the sensible-ness of this to him as I am but an mm dev :)

>
> > > Link: https://lore.kernel.org/all/20180730203633.GC12962@bombadil.infradead.org/ [1]
> > > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > > ---
> > >  fs/file.c          | 1 +
> > >  kernel/task_work.c | 1 +
> > >  2 files changed, 2 insertions(+)
> > >
> > > diff --git a/fs/file.c b/fs/file.c
> > > index 0a4f3bdb2dec6284a0c7b9687213137f2eecb250..0046d0034bf16270cdea7e30a86866ebea3a5a81 100644
> > > --- a/fs/file.c
> > > +++ b/fs/file.c
> > > @@ -881,6 +881,7 @@ struct file *file_close_fd(unsigned int fd)
> > >
> > >  	return file;
> > >  }
> > > +EXPORT_SYMBOL(file_close_fd);
> >
> > As a matter of policy we generally don't like to export without GPL like this
> > unless there's a _really_ good reason.
> >
> > Christian or Al may have a different viewpoint but generally this should be an
> > EXPORT_SYMBOL_GPL() and also - there has to be a _really_ good reason to export
> > it.
>
> Sorry I should just have done _GPL from the beginning. My mistake.

Thanks!

>
> Alice

Cheers, Lorenzo

