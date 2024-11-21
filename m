Return-Path: <linux-fsdevel+bounces-35390-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE999D487B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 09:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61E121F225F5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 08:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DF41CB313;
	Thu, 21 Nov 2024 08:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="H1ALKU9z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EA719F13B;
	Thu, 21 Nov 2024 08:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732176505; cv=fail; b=l6uIdsFeytFJyCbvMIP6Yfr7dWQLMBuDYJRz/QXgzvd95X9+GdUQIcJ53Y1dll/SHoyjKaIDKP6p+Vm2fEW99Y9wE5J/p4pk52Z4XtqzoW7tpa/6LB/BvZh0uJ93ZmOk5W84r/ifldPqCUwQBjhidvkeChbCFVWXMlhjFCjMaUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732176505; c=relaxed/simple;
	bh=kiVnxRXbLaK9OPpqCpWzGrA+FL2N5jCXOcfT3rCNdzY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ojw5QPxa5ipUC9egKu3HB9VlBw7YWKq3cPoM5fJ40JsTiQb/TuZfyAoXmDWIN+uD+dKqzIvh9MSkcHpkoQvCi8AC/ytZBNjFzlG+24efHVhvKF1Bc3szigLFau7BuRjhgXGR5C0UJ+bJfhZDAy6FTDKPUcD31DIGx0saMM9GfPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=H1ALKU9z; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AL4SMAR001335;
	Thu, 21 Nov 2024 00:08:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=kiVnxRXbLaK9OPpqCpWzGrA+FL2N5jCXOcfT3rCNdzY=; b=
	H1ALKU9znT8/k64Dt2sA7QG+O88dZ41SOsp7zrXVq3MeMmJqnUILWY0tibdkPolN
	Y1lpz4RXdkEzZyLA1jbo/Z5LBIMicJjKoTqLwbvJSEAS/rT1GckNk9FtB4csbkPT
	EBKsE/UEmI9g4USmrms4ukUsUmxlg8TN2W/htdZHz07SJ2gbYsH9HZxRORpPHspZ
	t8X/gdJL/65XO9nvcNnySN6m3XHfTqDxGt+5hQObM/PBBujSMVPMm0Q47qyIN3Qo
	D1ut338i1DobsSLlwxhyjR13TPHtJT6YTKxatbk7+C0ZHR7zrKVFLFrmNtPdkZQr
	pUPKtdb5G9urcb2CO8O8uA==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 431wv10tkx-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 00:08:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GAGENCyThnb0ZLD1eYZZ6UDtBk5NTeml5fd8o4yTUvyfgcKVq8ZJJX4X8ra21Hzb2IRm3+SODQytabZirxjkvsnG4kk6dXxFjUXiUKlpEL/J3JqvIB5rCN4Ujjz3Rz3g6SeKy5LLIsn9f0rpHc5jbUXmjo0g6uniTFd7vy72LSxLiCO3g17u2DNb/W5Ga2hKzomjlVRVwaABlB3bxyS5UdhXPkUaJvhEWoU4EjfpTFmW8+6gTZcLHkjG1wGIzLPOV9j92d7mQn12bjoFLvXlqQlMFFMmtn8I0hhZPKdaOh2WJHkVstpQ+zZYaVvAx63Ow7+oZ1RrUG0Vjpu0IHoNag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kiVnxRXbLaK9OPpqCpWzGrA+FL2N5jCXOcfT3rCNdzY=;
 b=iRWzTp6HbAQ6vFwwJSz8i6koptcplkaaDB8gCh5wv68jg0NHi2Xlt4vebPnwdpOclZYMnG0jws2Q9WbpUa2gJ5KN9yP87+IvDWMQlYUi2NCoppwuBXUJ6BKiTJySXL44/OjkJjVTwbbQJXzva7BDIPppGNNODi5A9ecJ85WC9/ocgrJTtPXrltGbHbm7Z28nX7iaii7WNLClMrweezLoyBOFOSMgfghWbss/2Ai2a//TYVYAtg8FJVdoc310QTgpgCM1LKKjVbjg6O3a76hlMQCI/M9HEQ5Bn+yCmGHfLtEvuQ6ufCz7VEirSRSMd2AYBuhTEvcugSobQAKFLhYdHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from PH0PR15MB5117.namprd15.prod.outlook.com (2603:10b6:510:c4::8)
 by SA0PR15MB4077.namprd15.prod.outlook.com (2603:10b6:806:90::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Thu, 21 Nov
 2024 08:08:18 +0000
Received: from PH0PR15MB5117.namprd15.prod.outlook.com
 ([fe80::90bf:29eb:b07e:94d9]) by PH0PR15MB5117.namprd15.prod.outlook.com
 ([fe80::90bf:29eb:b07e:94d9%6]) with mapi id 15.20.8182.013; Thu, 21 Nov 2024
 08:08:18 +0000
From: Song Liu <songliubraving@meta.com>
To: Christian Brauner <brauner@kernel.org>
CC: Song Liu <songliubraving@meta.com>, Amir Goldstein <amir73il@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>,
        Song Liu
	<song@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>,
        Kernel Team <kernel-team@meta.com>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "eddyz87@gmail.com"
	<eddyz87@gmail.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "martin.lau@linux.dev"
	<martin.lau@linux.dev>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "mattbobrowski@google.com"
	<mattbobrowski@google.com>,
        "repnop@google.com" <repnop@google.com>,
        Josef
 Bacik <josef@toxicpanda.com>,
        "mic@digikod.net" <mic@digikod.net>,
        "gnoack@google.com" <gnoack@google.com>
Subject: Re: [PATCH bpf-next 2/4] bpf: Make bpf inode storage available to
 tracing program
Thread-Topic: [PATCH bpf-next 2/4] bpf: Make bpf inode storage available to
 tracing program
Thread-Index:
 AQHbNNya8stOo5GwQE2QhVtvXBjXrrK1AUcAgAJInwCAAOzHAIAAaR8AgAYTNoCAABHkgIAAAU8AgABq6gCAAMJAgIABe+aA
Date: Thu, 21 Nov 2024 08:08:18 +0000
Message-ID: <B8335780-868E-4723-8A19-12582B7A7E6D@fb.com>
References: <20241112082600.298035-1-song@kernel.org>
 <20241112082600.298035-3-song@kernel.org>
 <20241113-sensation-morgen-852f49484fd8@brauner>
 <86C65B85-8167-4D04-BFF5-40FD4F3407A4@fb.com>
 <20241115111914.qhrwe4mek6quthko@quack3>
 <E79EFA17-A911-40E8-8A51-CB5438FD2020@fb.com>
 <8ae11e3e0d9339e6c60556fcd2734a37da3b4a11.camel@kernel.org>
 <CAOQ4uxgUYHEZTx7udTXm8fDTfhyFM-9LOubnnAc430xQSLvSVA@mail.gmail.com>
 <CAOQ4uxhyDAHjyxUeLfWeff76+Qpe5KKrygj2KALqRPVKRHjSOA@mail.gmail.com>
 <DF0C7613-56CC-4A85-B775-0E49688A6363@fb.com>
 <20241120-wimpel-virologen-1a58b127eec6@brauner>
In-Reply-To: <20241120-wimpel-virologen-1a58b127eec6@brauner>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.200.121)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR15MB5117:EE_|SA0PR15MB4077:EE_
x-ms-office365-filtering-correlation-id: 7cb93725-7b7d-44c2-ad5c-08dd0a03a861
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OXpTUEJvMFVOWnFnM0hTOTh2VklaZ2RFM1pJTmFWRm5ld2JBL2lmc0tXNE9o?=
 =?utf-8?B?Ni9ZTUQxU3dzemd4UE1UTGF3MEJadkVyKytweGM3eDBpTHpveGNqV0cxYk1H?=
 =?utf-8?B?b0luYWsxYUNqYkhsNE5pSVd6VXd3K00xT1Y0RStyc05QeGJSaStGdWRLVmdp?=
 =?utf-8?B?SmpPcTlWUkVWRm0rU2FocjJYNEUrTnhKVlV0UlhBY3VDYVJIWGlnQm9HUHRa?=
 =?utf-8?B?d1piUXZ6VGlMRnlxeE1rM1lDSDF6Nld6MjIvOHVZb3pLeGUxbjIyL3pYWC9x?=
 =?utf-8?B?akdSeUhQaWJDZkRvUVZhbXhnZkNzekEraTVmWGIzTlNieGlHd0lWRER2REpK?=
 =?utf-8?B?aXMzdWVTY3pWT00zTCtTSHRmY21uYnRubjcxUExqMWUzbER1bjJvNXcxTWdL?=
 =?utf-8?B?REtxUmpXMHpnKzE5NGV6alI1RE9KakpmTVdYeDByMWVJMnpnVzlLR3BPNjlR?=
 =?utf-8?B?ZERsdHpQRFRPZXMzcmNqK2FaNm52dWV3RVFlNDRXenBzWmNJdFBIMFhJVXZJ?=
 =?utf-8?B?L1VLdUlaLzl6dUtUUUl6elhvdkFaSk9kdEd5Um9pVTFvSzNNdjVCWnFGeUlw?=
 =?utf-8?B?NjFIYWJMTTVLOTlwb1puZDN5MmVpM3NjRTZDa1hrczREL0kvV0txZ2d0T04r?=
 =?utf-8?B?MVVZSkFVWVRMZ1B2OG45RGdGL1lKZWRVeENHQ0RvR21mNGl3Wk5CS3RpbkhY?=
 =?utf-8?B?Q1R0cnpuUzV5VWhTNmd4U2dkRlc2Qk92Ri9pR1dKT0FhMW9rbENCeE05TE9j?=
 =?utf-8?B?OVlvejM5NHEzT2cvdU0rTlh2dSt3YmlLcVdUSktGa3pkd3ZJQ3Azc2V2NXhw?=
 =?utf-8?B?UnBzekpUV293TFhZd3J3VTJ4Vlh2cy9ERmUxcjNxRzFsVjQwN0RONWEyeHpN?=
 =?utf-8?B?QmlpRU1INUhzeVNrdGhpdEZpeUtVcnEzNzBoalFhdVQwQ0J4cklPaWhqRWJI?=
 =?utf-8?B?YmxleUdGK0hDeUgrS0FBVFJGUmxyWDZHblducTdUQVVSNFNTTTE4akFtMEV5?=
 =?utf-8?B?WXMyd2RQdXpDM2w1Z09IU2dqeXVLa1FVN0VZd3R4Sk1QNU5uNjZMVFFBZVNP?=
 =?utf-8?B?Nm8rckdkbmF3MktsaXYrR2tzdFBPVU1GZXVMdUNCb0ZVRjFPWHBHeTNDVjh6?=
 =?utf-8?B?em9PeFZZRkRBTW50bDdYTDdueTNwVHl4OFhpMWxFaUl6ZWpSSTZkeXp5bVQz?=
 =?utf-8?B?Qis3SFBlRFZPRkZ3aEp0TnRGY0cxdzM0Q1J0RmRhNVZCTXQvK1N1a1ROSmo3?=
 =?utf-8?B?T21ER1F1RVc5RTNoczZubk5YeEVUSjJiK0tOK2dscCtKNzdTVG00OEREaWlT?=
 =?utf-8?B?MTAxYTJYbE1tVTBqS3BqaUpJYmhVTEJTSFVJaVdTMlRFSkRqYVlKTzQ2ajdy?=
 =?utf-8?B?TVN4dkkyc3pXUUhUanBXUkpJbkx6VUlibTl6bHZxZ1RMeXVGL2p4NE1ucUZS?=
 =?utf-8?B?MUVwUEFmc0xZd2gvKy9VN1kwYmpPSHlNNmRVdTdyMHRpMCtCVnhhakp3bHB1?=
 =?utf-8?B?VHFRTDg1NTFweGU5T2IyK2QvZVpHcnZaUUNSbEo1dVpXTkc1WDlXM0RtazFB?=
 =?utf-8?B?U2ZkV3BSQ0YyN05nUFpVVmc0dmM2WCtsQ0lGVlRRcEFwLzFCRWZQWU1FbkVR?=
 =?utf-8?B?ek1ldG15aGJCMUZlQkhyaEFOREhXNzhnc2RNbTFpZStwWUM5S0R5WHk1d0lL?=
 =?utf-8?B?SGxiSlZId0dMdUFCczVQWHZ4WUlyOGt1NGFVSzBVMkhyY3RHWU1wZHdvSzRR?=
 =?utf-8?B?b3MxTnpQeEFuVE9NOUN4SnZYYnR2MWtGazZtNU9MTHl4ZjMwb1dFMDNuSFhB?=
 =?utf-8?Q?G+JrzfglxoIqZp60lQpLsKqZyk0MTKdlTNC2U=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR15MB5117.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZHVTeGdTOGZuVjRGcHVzb1JKdjVrbm1jRmwwNEtqQ3l1aHovWkR2UklrNmRi?=
 =?utf-8?B?c2h5dEhBK3h4TENqYk1ySEd3alRPYU5xSU41ZnlRVW0zT2xpZjdwMCt2TFRX?=
 =?utf-8?B?NW1sVFBObjlPNE1DUlBCaHIvcHUrUDdjL0FORzNEYmM1bnlDbVJ6UUpPS2Vr?=
 =?utf-8?B?aTFUTjM5YWxwRW1IanEvcmxoNXVibjUvMXdiV3VVMllmTkkrS0w5WTRBVVVx?=
 =?utf-8?B?VTJweHQzZE1LL0JLekFER21Sdnk5T3ZTUk4yV0wrbnZqclRJRmxWNyttWTNq?=
 =?utf-8?B?eWd2TzU4M3I3amJObHVZZmFaUnBNOUhTbUY0OXljSUgvemVicFpVWktRTUQ3?=
 =?utf-8?B?WmdYdmVLTW9VdjRUZ2RQTVIyTE1JZ25wcVE3enhZcEwzZFkzYmdmbGM0eE11?=
 =?utf-8?B?cGZUZXNiTGRrVVA4L2syU1gwVnovdkxaQjBUWlBSemozLzBzakRMKzBLU2M4?=
 =?utf-8?B?dFN1SmpXYVVhbkdvQ282UG1UNFlMMnBwVm1kWHNkS1dMd2tzL2tocGRPSnpW?=
 =?utf-8?B?Qjl4cFQ2U1VWSFQvUEdhYVlieUhmejFkdFlVZkVYVlQ4bVo2ZmtScGlUc2xp?=
 =?utf-8?B?ckY2bVlpRVQySmdadW1QS2hTTWR1OFFKN25tZzA4U2pWSFZndUYveUkzdXBD?=
 =?utf-8?B?R0ZOK0Y5WTluQ25adnlWOVZjOS9PMENDZ3Y3Yms0UktnbVpLOXA3cWd2OUpY?=
 =?utf-8?B?UVpLbm9VWElpY1U5cHlCemIxRjVxSEdXWllzU1NYTmczQys1SXlqRE0veTRt?=
 =?utf-8?B?bGRzV09EQm9UT0xJSXlkREk0T0FseDRFbGxDRkVLYjlIOVpzZnliZUFuQTlU?=
 =?utf-8?B?VVd4QU41OWk2cFBMWjJTVEttakNNMmprUVkvMDRZQURhYm1pSW54d2hCRlJ0?=
 =?utf-8?B?eUxtTWtTdVVXNjIyeWVLV3lGa3BkU2tPNVZ5NThsTU54M2RQVzIxVDNOUkJ1?=
 =?utf-8?B?OUhDYTlzTExKWS94cm5MZHJORjdjZmpFUUNwTmM0cFJhQ0JoRzBjRVF0MWZF?=
 =?utf-8?B?OS9UZ2N0blRTRzdQaWRrSDZFMFpSYW9HLzZqNmRaQkdNWkxGYlJZN2JKQTBi?=
 =?utf-8?B?UzBBZkRJcVJ2V0dOR2dsYUZhZ0dxT1dKWUpGcmNvc2trc3ZoeUNJMDhoa3Ru?=
 =?utf-8?B?N3hzSjRDRzc3QnlZZWtrTGdSREswVG52NU15T0Y3WmFYWGppM1I1eVhrY2Qr?=
 =?utf-8?B?b2pKeERIUEd4bHdoeDJma09JeVVpVDJsVVlKMUNKTHNQOWZROSs3bUY0ZWRN?=
 =?utf-8?B?azA2M1hzQWlUTExadVFCMFNINkNnSnpERzg3djB2eStCOWhBUVQ3cG5GemdK?=
 =?utf-8?B?aVZvWDJMV0lZVlJHSVhaeXVzZFFBenFsMUxmOU84QVJ2RWxxLzA0cVlMREZN?=
 =?utf-8?B?QnI1cFVwVXQwaTh2MG9pdC9uaFEyWHJEaDNaci9UUU9BOURnZ1N5MWdBUHUz?=
 =?utf-8?B?Tys0RUpIS2pMVWtaVndURVQ4RHQ0MFJBTUdCMWdqenJUVG84dzJyRWZGeHRJ?=
 =?utf-8?B?NHgyQUpjVzI2RGt0WTF5NXNWcUVmOUVhc0dhVHRFcklMZitYbkRvZDhlbWRD?=
 =?utf-8?B?eUhLaFptZ0hMaHlwV3BVWllraGNUQmJtbTB4NjVTOHQwMkI5WkRGbzdoQllt?=
 =?utf-8?B?bHB0YnpVQ3g1N3hOSG4zNWdaUHFiM0l6TTVYVERzR0lWV0xreldhU1lQUFR4?=
 =?utf-8?B?dDY2VGZ2WkNQT0pja2tRUWtOVHh2OG1FL05qbU14V0dCWEVnQ1BHOG5mU0to?=
 =?utf-8?B?S0pLWUp6azFUZFcwSlBpTUJpcnVtU0dlQWpHZzdMTnIya0dqWUNicnVsTG1j?=
 =?utf-8?B?T3JOTEpGUGJYSVk1dnZKK3dHTHlzS2gycGhHQnNrTE9wNjg4Zk0yQXcrSkVR?=
 =?utf-8?B?em91MHk4aFdQWlp4S0hoQStoWWhZUlJ4Qzdqbi96N1RnUUFTR0RUaFVObkZw?=
 =?utf-8?B?SExKTm9LUFg4Um1yRlhzSkhocDZJdXNwYXZYQnljTlB0eXpuRnBnUXQ3RkNw?=
 =?utf-8?B?TEFRMWxrRm41L3FZMDc4MVB4RGpVeGhBYTUyNGdkbHQyUjZ0aWVJNi9acEFN?=
 =?utf-8?B?aUlDYjVQM2E2NE94ZXplOFByL0dRWjhQSlZzRWM1WVZOamtqMUlucU5QV3Jw?=
 =?utf-8?B?LzZpQm1aSmI0Z01sNkhPOFkrcDFXd2ltYXBIYU9OZ2VTdHNtTVZSbG5tUGdQ?=
 =?utf-8?B?NVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <54058B6F705D4F4FA832D7800705B4BF@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR15MB5117.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cb93725-7b7d-44c2-ad5c-08dd0a03a861
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2024 08:08:18.2248
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aP+y7BUz6cqSxPedlUonGJ7NBLb2enktTOPzQwptTY1XQ8Mrh4IpGkmDiitPQYMFROt2gEoo1trWyBzp87ZA0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB4077
X-Proofpoint-ORIG-GUID: T4m1R6qNIhAfcX85xe1Cacj8YTDT4FAq
X-Proofpoint-GUID: T4m1R6qNIhAfcX85xe1Cacj8YTDT4FAq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_02,2024-10-04_01,2024-09-30_01

DQo+IE9uIE5vdiAyMCwgMjAyNCwgYXQgMToyOOKAr0FNLCBDaHJpc3RpYW4gQnJhdW5lciA8YnJh
dW5lckBrZXJuZWwub3JnPiB3cm90ZToNCg0KWy4uLl0NCg0KPj4+Pj4gVGhlbiB3aGVuZXZlciB5
b3UgaGF2ZSB0byBwb3B1bGF0ZSBhbnkgb2YgdGhlc2UgZmllbGRzLCB5b3UganVzdA0KPj4+Pj4g
YWxsb2NhdGUgb25lIG9mIHRoZXNlIHN0cnVjdHMgYW5kIHNldCB0aGUgaW5vZGUgdXAgdG8gcG9p
bnQgdG8gaXQuDQo+Pj4+PiBUaGV5J3JlIHRpbnkgdG9vLCBzbyBkb24ndCBib3RoZXIgZnJlZWlu
ZyBpdCB1bnRpbCB0aGUgaW5vZGUgaXMNCj4+Pj4+IGRlYWxsb2NhdGVkLg0KPj4+Pj4gDQo+Pj4+
PiBJdCdkIG1lYW4gcmVqaWdnZXJpbmcgYSBmYWlyIGJpdCBvZiBmc25vdGlmeSBjb2RlLCBidXQg
aXQgd291bGQgZ2l2ZQ0KPj4+Pj4gdGhlIGZzbm90aWZ5IGNvZGUgYW4gZWFzaWVyIHdheSB0byBl
eHBhbmQgcGVyLWlub2RlIGluZm8gaW4gdGhlIGZ1dHVyZS4NCj4+Pj4+IEl0IHdvdWxkIGFsc28g
c2xpZ2h0bHkgc2hyaW5rIHN0cnVjdCBpbm9kZSB0b28uDQo+PiANCj4+IEkgYW0gaG9waW5nIHRv
IG1ha2UgaV9icGZfc3RvcmFnZSBhdmFpbGFibGUgdG8gdHJhY2luZyBwcm9ncmFtcy4gDQo+PiBU
aGVyZWZvcmUsIEkgd291bGQgcmF0aGVyIG5vdCBsaW1pdCBpdCB0byBmc25vdGlmeSBjb250ZXh0
LiBXZSBjYW4NCj4+IHN0aWxsIHVzZSB0aGUgdW5pdmVyc2FsIG9uLWRlbWFuZCBhbGxvY2F0b3Iu
DQo+IA0KPiBDYW4ndCB3ZSBqdXN0IGRvIHNvbWV0aGluZyBsaWtlOg0KPiANCj4gZGlmZiAtLWdp
dCBhL2luY2x1ZGUvbGludXgvZnMuaCBiL2luY2x1ZGUvbGludXgvZnMuaA0KPiBpbmRleCA3ZTI5
NDMzYzVlY2MuLmNjMDVhNTQ4NTM2NSAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9saW51eC9mcy5o
DQo+ICsrKyBiL2luY2x1ZGUvbGludXgvZnMuaA0KPiBAQCAtNjI3LDYgKzYyNywxMiBAQCBpc191
bmNhY2hlZF9hY2woc3RydWN0IHBvc2l4X2FjbCAqYWNsKQ0KPiAjZGVmaW5lIElPUF9ERUZBVUxU
X1JFQURMSU5LICAgMHgwMDEwDQo+ICNkZWZpbmUgSU9QX01HVElNRSAgICAgMHgwMDIwDQo+IA0K
PiArc3RydWN0IGlub2RlX2FkZG9ucyB7DQo+ICsgICAgICAgIHN0cnVjdCBmc25vdGlmeV9tYXJr
X2Nvbm5lY3RvciBfX3JjdSAgICAqaV9mc25vdGlmeV9tYXJrczsNCj4gKyAgICAgICAgc3RydWN0
IGJwZl9sb2NhbF9zdG9yYWdlIF9fcmN1ICAgICAgICAgICppX2JwZl9zdG9yYWdlOw0KPiArICAg
ICAgICBfX3UzMiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaV9mc25vdGlmeV9t
YXNrOyAvKiBhbGwgZXZlbnRzIHRoaXMgaW5vZGUgY2FyZXMgYWJvdXQgKi8NCj4gK307DQo+ICsN
Cj4gLyoNCj4gICogS2VlcCBtb3N0bHkgcmVhZC1vbmx5IGFuZCBvZnRlbiBhY2Nlc3NlZCAoZXNw
ZWNpYWxseSBmb3INCj4gICogdGhlIFJDVSBwYXRoIGxvb2t1cCBhbmQgJ3N0YXQnIGRhdGEpIGZp
ZWxkcyBhdCB0aGUgYmVnaW5uaW5nDQo+IEBAIC03MzEsMTIgKzczNyw3IEBAIHN0cnVjdCBpbm9k
ZSB7DQo+ICAgICAgICAgICAgICAgIHVuc2lnbmVkICAgICAgICAgICAgICAgIGlfZGlyX3NlcTsN
Cj4gICAgICAgIH07DQo+IA0KPiAtDQo+IC0jaWZkZWYgQ09ORklHX0ZTTk9USUZZDQo+IC0gICAg
ICAgX191MzIgICAgICAgICAgICAgICAgICAgaV9mc25vdGlmeV9tYXNrOyAvKiBhbGwgZXZlbnRz
IHRoaXMgaW5vZGUgY2FyZXMgYWJvdXQgKi8NCj4gLSAgICAgICAvKiAzMi1iaXQgaG9sZSByZXNl
cnZlZCBmb3IgZXhwYW5kaW5nIGlfZnNub3RpZnlfbWFzayAqLw0KPiAtICAgICAgIHN0cnVjdCBm
c25vdGlmeV9tYXJrX2Nvbm5lY3RvciBfX3JjdSAgICAqaV9mc25vdGlmeV9tYXJrczsNCj4gLSNl
bmRpZg0KPiArICAgICAgIHN0cnVjdCBpbm9kZV9hZGRvbnMgKmlfYWRkb25zOw0KPiANCj4gI2lm
ZGVmIENPTkZJR19GU19FTkNSWVBUSU9ODQo+ICAgICAgICBzdHJ1Y3QgZnNjcnlwdF9pbm9kZV9p
bmZvICAgICAgICppX2NyeXB0X2luZm87DQo+IA0KPiBUaGVuIHdoZW4gZWl0aGVyIGZzbm90aWZ5
IG9yIGJwZiBuZWVkcyB0aGF0IHN0b3JhZ2UgdGhleSBjYW4gZG8gYQ0KPiBjbXB4Y2hnKCkgYmFz
ZWQgYWxsb2NhdGlvbiBmb3Igc3RydWN0IGlub2RlX2FkZG9ucyBqdXN0IGxpa2UgSSBkaWQgd2l0
aA0KPiBmX293bmVyOg0KPiANCj4gaW50IGZpbGVfZl9vd25lcl9hbGxvY2F0ZShzdHJ1Y3QgZmls
ZSAqZmlsZSkNCj4gew0KPiBzdHJ1Y3QgZm93bl9zdHJ1Y3QgKmZfb3duZXI7DQo+IA0KPiBmX293
bmVyID0gZmlsZV9mX293bmVyKGZpbGUpOw0KPiBpZiAoZl9vd25lcikNCj4gcmV0dXJuIDA7DQo+
IA0KPiBmX293bmVyID0ga3phbGxvYyhzaXplb2Yoc3RydWN0IGZvd25fc3RydWN0KSwgR0ZQX0tF
Uk5FTCk7DQo+IGlmICghZl9vd25lcikNCj4gcmV0dXJuIC1FTk9NRU07DQo+IA0KPiByd2xvY2tf
aW5pdCgmZl9vd25lci0+bG9jayk7DQo+IGZfb3duZXItPmZpbGUgPSBmaWxlOw0KPiAvKiBJZiBz
b21lb25lIGVsc2UgcmFjZWQgdXMsIGRyb3Agb3VyIGFsbG9jYXRpb24uICovDQo+IGlmICh1bmxp
a2VseShjbXB4Y2hnKCZmaWxlLT5mX293bmVyLCBOVUxMLCBmX293bmVyKSkpDQo+IGtmcmVlKGZf
b3duZXIpOw0KPiByZXR1cm4gMDsNCj4gfQ0KPiANCj4gVGhlIGludGVybmFsIGFsbG9jYXRpb25z
IGZvciBzcGVjaWZpYyBmaWVsZHMgYXJlIHVwIHRvIHRoZSBzdWJzeXN0ZW0NCj4gb2ZjLiBEb2Vz
IHRoYXQgbWFrZSBzZW5zZT8NCg0KVGhpcyB3b3JrcyBmb3IgZnNub3RpZnkvZmFub3RpZnkuIEhv
d2V2ZXIsIGZvciB0cmFjaW5nIHVzZSBjYXNlcywgDQp0aGlzIGlzIG5vdCBhcyByZWxpYWJsZSBh
cyBvdGhlciAodGFzaywgY2dyb3VwLCBzb2NrKSBsb2NhbCBzdG9yYWdlLiANCkJQRiB0cmFjaW5n
IHByb2dyYW1zIG5lZWQgdG8gd29yayBpbiBhbnkgY29udGV4dHMsIGluY2x1ZGluZyBOTUkuIA0K
VGhlcmVmb3JlLCBkb2luZyBremFsbG9jKEdGUF9LRVJORUwpIGlzIG5vdCBhbHdheXMgc2FmZSBm
b3IgDQp0cmFjaW5nIHVzZSBjYXNlcy4gT1RPSCwgYnBmIGxvY2FsIHN0b3JhZ2Ugd29ya3MgaW4g
Tk1JLiBJZiB3ZSBoYXZlIA0KYSBpX2JwZl9zdG9yYWdlIHBvaW50ZXIgaW4gc3RydWN0IGlub2Rl
LCBicGYgaW5vZGUgc3RvcmFnZSB3aWxsIHdvcmsgDQppbiBOTUkuIA0KDQpUaGFua3MsDQpTb25n
DQoNCg==

