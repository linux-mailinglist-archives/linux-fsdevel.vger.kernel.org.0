Return-Path: <linux-fsdevel+bounces-34016-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8A89C1E19
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 14:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A941288D57
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 13:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C92E1EF0B4;
	Fri,  8 Nov 2024 13:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AcLcuuX3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FvGeRrbq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31AB1EF082;
	Fri,  8 Nov 2024 13:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731072595; cv=fail; b=iiZk3KonwPb3+OgACr+Zk+8vQw6GgiCzjgD8569VPiGKY1xtNgmTMCHzmhcZ1ZXxLd+P8jLqMvoxiHCrcS+IeVTWsh5TaNSdhXMfuJCc/QFXXnWua3BJINU/X0+CR35tu8ckTO2JUSEVjY7NQHdC3S0jqCRC8hnqR0gx/DYMFm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731072595; c=relaxed/simple;
	bh=jcTsLM3++gF3Q/Io1ETxC8h5LmjU+pK9mbxtSlgXeuQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RhI1BdQcTKjh5FONGfURBAm+oSQd7ruAnog1y7WfUrCzduZLrRTymTA82TpAjTV2Q6AAluOiKOzBAB8ZRRHfA8BXGZ/ikzfYhiAln05hH1kkdVuDxjwOm//WdIn46h8E5E+V34JjKny+3KN64Gymny47GIAYMtHkdb9uUBEziDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AcLcuuX3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FvGeRrbq; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A8BgJOD008650;
	Fri, 8 Nov 2024 13:23:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=jcTsLM3++gF3Q/Io1ETxC8h5LmjU+pK9mbxtSlgXeuQ=; b=
	AcLcuuX3OW9Z4J93iwwVEC103qje84osbh2TjI93grPMV5Y2Z0kE/ehAd+JbcFoZ
	VUwm3KCTAk6IGumcwhOn3i4uGG/L5mxvt96kHAMxItqaQbDjbOb+Z/G+wF4DF8M2
	cofi5ejAW5tIvzRNP/FW4HYye6ZH8WIr7FLos78KBMB/N3M0EGQAm7C7Sn11yuGq
	6G/LbOGqD9SS0LCmuPRJAzrxej8DKFYoloBSLCC//Pf6xWNG1whFeuGyRh4mHydy
	Qh2Nq7kzCbffGO5SEjX6x7Uy93cjhM3HsLAiadOOyfeE3+R7I0I799NAR3vD8baa
	ZjXTcFKycXia1CBfbA0pFA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42s6jx1fk8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Nov 2024 13:23:27 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A8CVbJO037339;
	Fri, 8 Nov 2024 13:23:26 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42nahbky1h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Nov 2024 13:23:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EgTaYHNBY3XeXHPP9Sx8jwadytbqvC0murECSALTw4h3Zc4xf1laFfgwyaN3mvXL9m28OtPggTokLiU9JgH2NFAJ5tPPxrix3ZIMFn2LYkrsXA/2VAu/1G3wK4ZoM+ud4MHqOR4D33GyBddbNuccZdPUrz7umasK+1p1U/lxqv1qhlBqs33rxTRf+Eoq1FuFY4CXb0LEbyTHjPdeg2K0pzUyaCtOZCXdn6/QO+2wSG6Stcl2qGzo5VZRvDfXkcXxjbx+iUF+U0BUkVBh0Lt7IqFesCIxdT4k5xTRtWx018VjMqAJzN3s+kVLYIJ4TQVkTJ7KqSbnlH3RVyp8A8XTug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jcTsLM3++gF3Q/Io1ETxC8h5LmjU+pK9mbxtSlgXeuQ=;
 b=VHSc3YkkQrBk05g7W3kxgN7/TTd5MeLh8DkL9WdosjduRntBToMT+56TgzHLx6DEp2cie87kaH7pjvVm1kjfQGJOVhKE1G2TSpvLiA8OO1trqqEvRsORFtKw4/np7w7ioXQp5d011vCtTdtzdl3GSV4G1D3T5rbTzKF2k8GPpW0P18XSp6VTk01rDejvqEj/gpvPaD5zomDNOsAkDDhoMWDYFpMQNN2lxyBQ9azaqRf34cZji1f3JSNxNCFP4fXPz3OVXMoFXd2GZHpvSMcidqsSS87kOETohPO139vbUt4yRhpkA7qT2bn7XrtdOVVEpuSsGWQuxpyZKeMhi1CKbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jcTsLM3++gF3Q/Io1ETxC8h5LmjU+pK9mbxtSlgXeuQ=;
 b=FvGeRrbqva0kYPHlkdxgUI71cpniyj6+K5t6+kz/lVrrFB18FPty7xet9KCrksJuh7XCLG4qIR1gYH9G7CQ9bHiNP176KXYAgQWhAUdA2Vjc3a20VMfxwNylOG6bVWKCECyGrpe4mdLqZ8ekOoI7wCuxPtRqlXWHPDA01CFf6pc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.22; Fri, 8 Nov
 2024 13:23:23 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8137.019; Fri, 8 Nov 2024
 13:23:23 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
CC: Greg KH <gregkh@linuxfoundation.org>,
        linux-stable
	<stable@vger.kernel.org>,
        "harry.wentland@amd.com" <harry.wentland@amd.com>,
        "sunpeng.li@amd.com" <sunpeng.li@amd.com>,
        "Rodrigo.Siqueira@amd.com"
	<Rodrigo.Siqueira@amd.com>,
        "alexander.deucher@amd.com"
	<alexander.deucher@amd.com>,
        "christian.koenig@amd.com"
	<christian.koenig@amd.com>,
        "Xinhui.Pan@amd.com" <Xinhui.Pan@amd.com>,
        "airlied@gmail.com" <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Al
 Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Liam
 Howlett <liam.howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        "Matthew Wilcox (Oracle)"
	<willy@infradead.org>,
        Sasha Levin <sashal@kernel.org>,
        "srinivasan.shanmugam@amd.com" <srinivasan.shanmugam@amd.com>,
        "chiahsuan.chung@amd.com" <chiahsuan.chung@amd.com>,
        "mingo@kernel.org"
	<mingo@kernel.org>,
        "mgorman@techsingularity.net"
	<mgorman@techsingularity.net>,
        "chengming.zhou@linux.dev"
	<chengming.zhou@linux.dev>,
        "zhangpeng.00@bytedance.com"
	<zhangpeng.00@bytedance.com>,
        "amd-gfx@lists.freedesktop.org"
	<amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>,
        Linux FS Devel
	<linux-fsdevel@vger.kernel.org>,
        "maple-tree@lists.infradead.org"
	<maple-tree@lists.infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        "yi.zhang@huawei.com" <yi.zhang@huawei.com>,
        yangerkun
	<yangerkun@huawei.com>, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH 6.6 00/28] fix CVE-2024-46701
Thread-Topic: [PATCH 6.6 00/28] fix CVE-2024-46701
Thread-Index:
 AQHbJhfg+I/QGRtH80+9+XvDi7dLrbKp2oMAgACX0ACAAKF/gIAA5l2AgACyM4CAAMomAA==
Date: Fri, 8 Nov 2024 13:23:23 +0000
Message-ID: <D2A4C13B-3B50-4BA7-A5CC-C16E98944D55@oracle.com>
References: <20241024132009.2267260-1-yukuai1@huaweicloud.com>
 <2024110625-earwig-deport-d050@gregkh>
 <7AB98056-93CC-4DE5-AD42-49BA582D3BEF@oracle.com>
 <8bdd405e-0086-5441-e185-3641446ba49d@huaweicloud.com>
 <ZyzRsR9rMQeIaIkM@tissot.1015granger.net>
 <4db0a28b-8587-e999-b7a1-1d54fac4e19c@huaweicloud.com>
In-Reply-To: <4db0a28b-8587-e999-b7a1-1d54fac4e19c@huaweicloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DM6PR10MB4313:EE_
x-ms-office365-filtering-correlation-id: d758c902-de37-4883-9632-08dcfff8852e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NkRaRk1QT2tCK2psdHJQWVJIdWNXWTJIWDl5U1Jwdng3bWlpdGIvMVNHVzFv?=
 =?utf-8?B?MEJ0NDVGenJhSWZRR21FZk1PYWtJWGhYbllkMjdKb1pmZGhqV0x4MDdCQWNY?=
 =?utf-8?B?Y3ZielhULytZR0RaN0lVYmZXbHpmZXBZT0YzanFDM3BwWFd3TUZZcTFvNGls?=
 =?utf-8?B?M3BQUWR0Z1hXbUU3Zzdiam15VC9GWXBIUGZSL3M4UzNMaUtoVFF1bXdya2Jk?=
 =?utf-8?B?WXgzUGQ0SC9rcmhsOTJlbWFyaE5NaUcwWkZNZ2N0N21wY29xN1crZi91YURk?=
 =?utf-8?B?ejlKbU16UlBGQU81RkQ4UzNmRnc5eHhCQ0VKL0VCaUV6NXBITFNGTXltWFl5?=
 =?utf-8?B?bU5WMlczemhuU2tyeGhjTHRzVmFid1RJMzZhRURyMmNZdDJDaTZXNnh4RVZm?=
 =?utf-8?B?RGx5NnZFSjZGZUh6a1R4MkNhVm9KTVd0NUdnZDk2NE00SVYwY25EeC8yRWt5?=
 =?utf-8?B?NzlmNEdMS1NIN2FrellMUUx2a3JCS1lOV01zZ2dIMmFWZ3kxMWhXcGlDbGJD?=
 =?utf-8?B?QUNkMmcxbXYyekMwSHdydVczQU5wTDIzUzdKQ2ZTZTFtZXdDWVlmZkpzUmVy?=
 =?utf-8?B?dUYydlBpWEdzOVE0NmFuSnZLSUZKSEhJZjRCWG1nMXdhL3FHY0hOeUsrOWdY?=
 =?utf-8?B?SkpPQ3VPVExjbGtTYldmK0RvVUJYTGpRQUNwNGk3RmlXYjVVR0t4QTBRTVNO?=
 =?utf-8?B?aHVHdGZObVI1K0VKd3dsc2FvQlN5aXRNMW1iMGpJemhUU3ZFVndRY1Zsd1Zn?=
 =?utf-8?B?cjA5Z2NLNHFjTGtXSDFuZTEvMmY3UWJVWjBvQ3ZCa2lFeFVCYXpRanNDemds?=
 =?utf-8?B?SFMyVnlBYnZSSVpob2oyN0ZhQkZHSC9DYmF2TkxGbzIyTHQrRkVNNFpNWG92?=
 =?utf-8?B?b2t3amJNOWx3ekRicUhqMFN4aG92K0pBNWI4N2lEVEJLZVNaUjFQcDJrcnYv?=
 =?utf-8?B?NElubjVNKy9EK1UzWXo5QmxTdWFxY2JCNVhicDVsQUozcU9TZ0VLTWpiZHE1?=
 =?utf-8?B?YW83djJMRUgwaDFacmpnTTVTdDRiR0ZCcExWWHdtUFV2Q1ErZDl4V3BvUUxi?=
 =?utf-8?B?K2kwelhDUWQxSHpQeUJtdHFna2o0Q3VHOVJsSzRrWHBJek9wVi81V0hRSVF1?=
 =?utf-8?B?Y2RTZWFUZ2lmR09vN2pGckhxbmhpUk9ROUpsaGlRcHphL2Rhb3NsM1NmTEFv?=
 =?utf-8?B?U0REajNGZitLOGxmRnFteEVGNDVTWE9yMnM5WXZ1V096cTByei9KcWFZL05O?=
 =?utf-8?B?OGh6NzFuOHNjN1pwMmEySlQyN2RnNXo3a01YMjhXRFpUMDJIRmIwQ1ZjWEtm?=
 =?utf-8?B?bHZzb0VUSlJkYjhyTkg1QjJwTGlNL1c0bGFPb3ZpUGdNVFZwcXBxd05uaVdp?=
 =?utf-8?B?NmFrL3IvRzFWY0E1ZUZjeSs3dUEvOWZQZE9pdGhWOThrSWM5RnozL1Y5bFkr?=
 =?utf-8?B?b0JWSHhPeVpmaE45c1VjYkV3QXFjQVhFVTBvOWNjTTZ3bkVCTXQvaHVjYW1D?=
 =?utf-8?B?NmJrcVV3WmpGMUE2TWtxSGlvRVNuUnJiR2tHZXJqZ2RpVitJSlJEcDRxMFVI?=
 =?utf-8?B?dnIreVdVSGppWElUbFIzODlWeWRLclhwQnNLc0VXb3UxTDlNcCtaMDFDVUFo?=
 =?utf-8?B?ZDFJSHcvT0VTYlBGY1EzT1M3QlFBR2ZmRjJGRFJveHJFQW9NOEhJaWtUa3ZE?=
 =?utf-8?B?UEFpME43OW13ZFpVdGlWSmFNaW1sd3hMZEtadUpEUmRBTnZoeFBHam5scU1Y?=
 =?utf-8?B?bnAzbXp5KzJQMER1MUV1OGNsdlkyVE53SzV0NSt0TWU4UjFFcC8wcG5LNkxV?=
 =?utf-8?B?Q2FRZ1g3d2NiM2VVRXhxVzZIbkQ4NWN2T3ZRUytVNElUYjBGdU0wYkpOUVFn?=
 =?utf-8?Q?+DINsd7vmXKCV?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bkpPc0tyZ1JySlUrNFZDSHpSQlFMK1hKZ3FjMjhadS90YzdQTWpkMGx4WnBU?=
 =?utf-8?B?L0dTRXMwOG1iSVdQTjZ3Z0xaNlp0NmtxSFQwWDZpNStvM0wwYmVNUVpFZVYw?=
 =?utf-8?B?OTdtSk9RdlY4MTNTa0loLy9kM1pxVDRJSnlKZFRrK0dnQzNUR3pmL3IrNCtJ?=
 =?utf-8?B?cFlrNEdQem42MVlTZW5pcFIrWFVhZnVGWWVwMFVBSC8zMDBYTmhhYnllSDVC?=
 =?utf-8?B?SkVwZmZWaXBQSERqWW43VERnOU0yM2orYyt6aW0wenFKcXRLbDBYWnM1d3cr?=
 =?utf-8?B?ZlZQZ2MyNThwM2FZWFJhMXRabUo3OUhvMTFva3haVzVlVTZoMjIrUUp4QXNj?=
 =?utf-8?B?QVFIamtlQWpCUGQ0VFNJb0xMRXVtOUtzNUhob1R0WVBaQnJPUEw3bmh3dm9o?=
 =?utf-8?B?QWRzUkJzVVlGakdFZlpnL1pneEZ4UFRIWSt1R3ZGeDdtY0FocWVyQnRER2JC?=
 =?utf-8?B?MEkvSXdJeUNXU0t5aHhhajg5YzlMclRUYlNRbERlK3ExeG1aQXY4b01NeWYw?=
 =?utf-8?B?SVVlV3hONzJIWVNsTmZiTVdzd2xmZkNQNEJKU0xUemZBSjllSHc3NUNYQk1r?=
 =?utf-8?B?TnZRVlJTZVpjR0lPQ1ZNL21rYnZrREhmYVQyazRPNG9IcHJ6Zll5c2JmNVh3?=
 =?utf-8?B?RGlvTDdnQW9wajlOWEhzSXF2OE9oZUFZRFRuUFR2N1MvVU16MktmMHZTdkp6?=
 =?utf-8?B?SlJRN3dPbXZNRTRCdk43cTEwN21wM2ZDSWpodjk3THJGemJCcWh5OTN1Ni9y?=
 =?utf-8?B?RjVMYUxiOEJQUDF3SDFwSnEwRU1yVDhqenVkek1YSUZKSGZFSXpOVDdaRUVz?=
 =?utf-8?B?eXA4bmZlY0pxQmw4c1pkM3ovRmhzU0FCNGJoTHBkeHJJOWxzZk1NOGxzcndJ?=
 =?utf-8?B?dW9OakpkTG9BV1hlM1JlMmxEWllLWFNhZkkrY3F3djQvQUF5OTdlWXluUCtU?=
 =?utf-8?B?Mlh0ak5zNmZrYW9CR0JNVnQ1Mk5wbW4yNUl6cTcvVUdPaGVWT0JTR1MvSUh3?=
 =?utf-8?B?KzVBSThaSFlXaVI2SWJzaDl2aHZwWXhyNUJnaTJ6YTZvb0Jkcjl6RkdCN20z?=
 =?utf-8?B?UHBWT2Fib3d2d0JIWTlYSEVlMTBVd3V0dEFTYWphS3N5V2hqdUs2cll3VnlC?=
 =?utf-8?B?VjVVay9HOW54OHl4SDNWS2NKK08rMVhXdUZVQXpxR3g1WUt3cE11enRWc0g0?=
 =?utf-8?B?d1ZLdDh6cWlQdHl4U1N6dTl0TmtpeStxTFhRL1llelBqRWtVUllFMklrM01n?=
 =?utf-8?B?VUNqVEd5YlhWTjVMNmhRcUlSYjA1NEU1RXAwREtvbWNXMzRoTnptWSthRXFh?=
 =?utf-8?B?YS9rdXNtUkswbGdjejFuOTVrT2x5TFNkNGpzOEczMFo1M2E5UmhDRDNWUlpJ?=
 =?utf-8?B?REc4dUcwN3R5dUduYldIQm9ydmNSK1lNd0lSRkU1eUV1c1c3RUtOcDdPcVlK?=
 =?utf-8?B?Z2xoRFl1Q1hrQnUzVWJmcHpLVW5iN1RUcGwxS3J6cHZpc3hOSVNwODg4bndk?=
 =?utf-8?B?MTJ2Vm4vZC9DV2tyeTN5UUNJVWVkeFUxNGlkZWRoR3pPaWlIMDVBOGRtWHpz?=
 =?utf-8?B?WXEvdllTZzNkQ0huRjZkYnhrZFpOSDh3WmI4cDcwYVZMSndLVlpER0dIV292?=
 =?utf-8?B?czF4bldTNHRZQnM5SVY3aS93elZ1dzJrRmtHSFRzUTNPRkIwRXU2TzdpMnBT?=
 =?utf-8?B?dEJIbTF2RUR2QTZ1Y3hJWGdaNHcxcG93Wk9BeHZrQmEvOFNsSmhtU1BvUnpo?=
 =?utf-8?B?NnV3QVJ2eGc1bzJKN3JZSGZkN2lJNHArbjM5RlRqanI5SjVpY1Z0RnBMeU1M?=
 =?utf-8?B?RndtTktWek5kb29UUTJXSnZDdUVOZzhSYm5sODJNQTJPTzgvelg0RWdmK1VP?=
 =?utf-8?B?Y1FVN0s4aWtiTEJ1cFpkdUIxWTR5YVJBV2VNdlVqUUg5TW9yekRLcmliZzJO?=
 =?utf-8?B?aVRCQzJESTFrSE5UTWVRMHdMbVE2NVZSZ0ZUNU03UGNoZ0FlZFJGMmh6UVUv?=
 =?utf-8?B?cmw5ZFl5VVpUWDlpMk1EUTZrVGhONXVMbkNabEVzVVREeHoxbHh2WG9wMC9h?=
 =?utf-8?B?OTloYmxQaldrWDk2T1BzVXZvV3Y0bUJ6QVVaVno4LzUrTTl4L21wOXg2emd4?=
 =?utf-8?B?clZRYk9NYnIwajVuQWhtR0xkNEhFcmdrL2lhMEh3Q0xQRFVTZUcrMmFjUkhJ?=
 =?utf-8?B?WWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DB377F0CF04EC74B96CFD3AA9677C83F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zdthX/kwxuMYuuifGsEUbziWqKOaUjsG0WvLHrYq56/gU15RrpuF7RbFeLda+NRweCHgC9b9pDDxI9aoWzViJFB4E3OAHIpS77K7rVrNlGu505xk9TxD3xFMF6Gfp/NRGtOzTqqfU4AquCuzOlzM00zd4+HqNz+/4i20ozFarnJhhwQkYb3RJcltRzQbDEGN5f7AXibsv6GvYEaUH9RgYe93j1uREVWniD2DT/99rKu30rGfvdqE5udpsi1pl5+vyxzBLsBS3R92Ld6BScS8B47wOfw45HVkVJ7ztWAjmhYHbcgB5BY7q/yG0WAVlKwsl+wMLUP0IM/6bah+LYrM7a0Hv3wu/wV2ld/+tVWrj1pRjYvp03YYjRtHhYKRANE+UubBUKrab5FZz2SvGzpHlZrgQZY17uw9lbSH6gWLDdYRoCJdnHQB4fWILH9ls6yN7GBkuhC3shG+GrDVMwhNCVwIT7IZdcWGLZIL53QPP5mcildNF3Qv1ILOqe9fvS+fJNah8k1f/JcOYQ2QguMd/dXqucDd1rMx8pwIPde3aAgBd5fAf65lUWDD53vdSxdm88tY6abFJY7ZXt4/HfZIarD7TLA+NXDWwpMdlyvxqjw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d758c902-de37-4883-9632-08dcfff8852e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2024 13:23:23.0835
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aIBIFmLlfD2Jn/XXCFRdUCnZOutrq7M67GQSTHhePk4mezK2Ot8vdhjy/yzEq4ZsXKmjpgd2EQARSEouf3+QGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4313
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-08_11,2024-11-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411080112
X-Proofpoint-GUID: krwtnaC5mwRGCLmMzOprBLwluTO06eqQ
X-Proofpoint-ORIG-GUID: krwtnaC5mwRGCLmMzOprBLwluTO06eqQ

DQoNCj4gT24gTm92IDcsIDIwMjQsIGF0IDg6MTnigK9QTSwgWXUgS3VhaSA8eXVrdWFpMUBodWF3
ZWljbG91ZC5jb20+IHdyb3RlOg0KPiANCj4gSGksDQo+IA0KPiDlnKggMjAyNC8xMS8wNyAyMjo0
MSwgQ2h1Y2sgTGV2ZXIg5YaZ6YGTOg0KPj4gT24gVGh1LCBOb3YgMDcsIDIwMjQgYXQgMDg6NTc6
MjNBTSArMDgwMCwgWXUgS3VhaSB3cm90ZToNCj4+PiBIaSwNCj4+PiANCj4+PiDlnKggMjAyNC8x
MS8wNiAyMzoxOSwgQ2h1Y2sgTGV2ZXIgSUlJIOWGmemBkzoNCj4+Pj4gDQo+Pj4+IA0KPj4+Pj4g
T24gTm92IDYsIDIwMjQsIGF0IDE6MTbigK9BTSwgR3JlZyBLSCA8Z3JlZ2toQGxpbnV4Zm91bmRh
dGlvbi5vcmc+IHdyb3RlOg0KPj4+Pj4gDQo+Pj4+PiBPbiBUaHUsIE9jdCAyNCwgMjAyNCBhdCAw
OToxOTo0MVBNICswODAwLCBZdSBLdWFpIHdyb3RlOg0KPj4+Pj4+IEZyb206IFl1IEt1YWkgPHl1
a3VhaTNAaHVhd2VpLmNvbT4NCj4+Pj4+PiANCj4+Pj4+PiBGaXggcGF0Y2ggaXMgcGF0Y2ggMjcs
IHJlbGllZCBwYXRjaGVzIGFyZSBmcm9tOg0KPj4+PiANCj4+Pj4gSSBhc3N1bWUgcGF0Y2ggMjcg
aXM6DQo+Pj4+IA0KPj4+PiBsaWJmczogZml4IGluZmluaXRlIGRpcmVjdG9yeSByZWFkcyBmb3Ig
b2Zmc2V0IGRpcg0KPj4+PiANCj4+Pj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvc3RhYmxlLzIw
MjQxMDI0MTMyMjI1LjIyNzE2NjctMTIteXVrdWFpMUBodWF3ZWljbG91ZC5jb20vDQo+Pj4+IA0K
Pj4+PiBJIGRvbid0IHRoaW5rIHRoZSBNYXBsZSB0cmVlIHBhdGNoZXMgYXJlIGEgaGFyZA0KPj4+
PiByZXF1aXJlbWVudCBmb3IgdGhpcyBmaXguIEFuZCBub3RlIHRoYXQgbGliZnMgZGlkDQo+Pj4+
IG5vdCB1c2UgTWFwbGUgdHJlZSBvcmlnaW5hbGx5IGJlY2F1c2UgSSB3YXMgdG9sZA0KPj4+PiBh
dCB0aGF0IHRpbWUgdGhhdCBNYXBsZSB0cmVlIHdhcyBub3QgeWV0IG1hdHVyZS4NCj4+Pj4gDQo+
Pj4+IFNvLCBhIGJldHRlciBhcHByb2FjaCBtaWdodCBiZSB0byBmaXQgdGhlIGZpeA0KPj4+PiBv
bnRvIGxpbnV4LTYuNi55IHdoaWxlIHN0aWNraW5nIHdpdGggeGFycmF5Lg0KPj4+IA0KPj4+IFRo
ZSBwYWluZnVsIHBhcnQgaXMgdGhhdCB1c2luZyB4YXJyYXkgaXMgbm90IGFjY2VwdGFibGUsIHRo
ZSBvZmZldA0KPj4+IGlzIGp1c3QgMzIgYml0IGFuZCBpZiBpdCBvdmVyZmxvd3MsIHJlYWRkaXIg
d2lsbCByZWFkIG5vdGhpbmcuIFRoYXQncw0KPj4+IHdoeSBtYXBsZV90cmVlIGhhcyB0byBiZSB1
c2VkLg0KPj4gQSAzMi1iaXQgcmFuZ2Ugc2hvdWxkIGJlIGVudGlyZWx5IGFkZXF1YXRlIGZvciB0
aGlzIHVzYWdlLg0KPj4gIC0gVGhlIG9mZnNldCBhbGxvY2F0b3Igd3JhcHMgd2hlbiBpdCByZWFj
aGVzIHRoZSBtYXhpbXVtLCBpdA0KPj4gICAgZG9lc24ndCBvdmVyZmxvdyB1bmxlc3MgdGhlcmUg
YXJlIGFjdHVhbGx5IGJpbGxpb25zIG9mIGV4dGFudA0KPj4gICAgZW50cmllcyBpbiB0aGUgZGly
ZWN0b3J5LCB3aGljaCBJTU8gaXMgbm90IGxpa2VseS4NCj4gDQo+IFllcywgaXQncyBub3QgbGlr
ZWx5LCBidXQgaXQncyBwb3NzaWJsZSwgYW5kIG5vdCBoYXJkIHRvIHRyaWdnZXIgZm9yDQo+IHRl
c3QuDQoNCkkgcXVlc3Rpb24gd2hldGhlciBzdWNoIGEgdGVzdCByZWZsZWN0cyBhbnkgcmVhbC13
b3JsZA0Kd29ya2xvYWQuDQoNCkJlc2lkZXMsIHRoZXJlIGFyZSBhIG51bWJlciBvZiBvdGhlciBs
aW1pdHMgdGhhdCB3aWxsIGltcGFjdA0KdGhlIGFiaWxpdHkgdG8gY3JlYXRlIHRoYXQgbWFueSBl
bnRyaWVzIGluIG9uZSBkaXJlY3RvcnkuDQpUaGUgbnVtYmVyIG9mIGlub2RlcyBpbiBvbmUgdG1w
ZnMgaW5zdGFuY2UgaXMgbGltaXRlZCwgZm9yDQppbnN0YW5jZS4NCg0KDQo+IEFuZCBwbGVhc2Ug
bm90aWNlIHRoYXQgdGhlIG9mZnNldCB3aWxsIGluY3JlYXNlIGZvciBlYWNoIG5ldyBmaWxlLA0K
PiBhbmQgZmlsZSBjYW4gYmUgcmVtb3ZlZCwgd2hpbGUgb2Zmc2V0IHN0YXlzIHRoZSBzYW1lLg0K
Pj4gIC0gVGhlIG9mZnNldCB2YWx1ZXMgYXJlIGRlbnNlLCBzbyB0aGUgZGlyZWN0b3J5IGNhbiB1
c2UgYWxsIDItIG9yDQo+PiAgICA0LSBiaWxsaW9uIGluIHRoZSAzMi1iaXQgaW50ZWdlciByYW5n
ZSBiZWZvcmUgd3JhcHBpbmcuDQo+IA0KPiBBIHNpbXBsZSBtYXRoLCBpZiB1c2VyIGNyZWF0ZSBh
bmQgcmVtb3ZlIDEgZmlsZSBpbiBlYWNoIHNlY29uZHMsIGl0IHdpbGwNCj4gY29zdCBhYm91dCAx
MzAgeWVhcnMgdG8gb3ZlcmZsb3cuIEFuZCBpZiB1c2VyIGNyZWF0ZSBhbmQgcmVtb3ZlIDEwMDAN
Cj4gZmlsZXMgaW4gZWFjaCBzZWNvbmQsIGl0IHdpbGwgY29zdCBhYm91dCAxIG1vbnRoIHRvIG92
ZXJmbG93Lg0KDQpUaGUgcXVlc3Rpb24gaXMgd2hhdCBoYXBwZW5zIHdoZW4gdGhlcmUgYXJlIG5v
IG1vcmUgb2Zmc2V0DQp2YWx1ZXMgYXZhaWxhYmxlLiB4YV9hbGxvY19jeWNsaWMgc2hvdWxkIGZh
aWwsIGFuZCBmaWxlDQpjcmVhdGlvbiBpcyBzdXBwb3NlZCB0byBmYWlsIGF0IHRoYXQgcG9pbnQu
IElmIGl0IGRvZXNuJ3QsDQp0aGF0J3MgYSBidWcgdGhhdCBpcyBvdXRzaWRlIG9mIHRoZSB1c2Ug
b2YgeGFycmF5IG9yIE1hcGxlLg0KDQoNCj4gbWFwbGUgdHJlZSB1c2UgNjQgYml0IHZhbHVlIGZv
ciB0aGUgb2Zmc2V0LCB3aGljaCBpcyBpbXBvc3NpYmxlIHRvDQo+IG92ZXJmbG93IGZvciB0aGUg
cmVzdCBvZiBvdXIgbGlmZXMuDQo+PiAgLSBOby1vbmUgY29tcGxhaW5lZCBhYm91dCB0aGlzIGxp
bWl0YXRpb24gd2hlbiBvZmZzZXRfcmVhZGRpcigpIHdhcw0KPj4gICAgZmlyc3QgbWVyZ2VkLiBU
aGUgeGFycmF5IHdhcyByZXBsYWNlZCBmb3IgcGVyZm9ybWFuY2UgcmVhc29ucywNCj4+ICAgIG5v
dCBiZWNhdXNlIG9mIHRoZSAzMi1iaXQgcmFuZ2UgbGltaXQuDQo+PiBJdCBpcyBhbHdheXMgcG9z
c2libGUgdGhhdCBJIGhhdmUgbWlzdW5kZXJzdG9vZCB5b3VyIGNvbmNlcm4hDQo+IA0KPiBUaGUg
cHJvYmxlbSBpcyB0aGF0IGlmIHRoZSBuZXh0X29mZnNldCBvdmVyZmxvd3MgdG8gMCwgdGhlbiBh
ZnRlciBwYXRjaA0KPiAyNywgb2Zmc2V0X2Rpcl9vcGVuKCkgd2lsbCByZWNvcmQgdGhlIDAsIGFu
ZCBsYXRlciBvZmZzZXRfcmVhZGRpciB3aWxsDQo+IHJldHVybiBkaXJlY3RseSwgd2hpbGUgdGhl
cmUgY2FuIGJlIG1hbnkgZmlsZXMuDQoNClRoYXQncyBhIHNlcGFyYXRlIGJ1ZyB0aGF0IGhhcyBu
b3RoaW5nIHRvIGRvIHdpdGggdGhlIG1heGltdW0NCm51bWJlciBvZiBlbnRyaWVzIG9uZSBkaXJl
Y3RvcnkgY2FuIGhhdmUuIEFnYWluLCB5b3UgZG9uJ3QNCm5lZWQgTWFwbGUgdHJlZSB0byBhZGRy
ZXNzIHRoYXQuDQoNCk15IHVuZGVyc3RhbmRpbmcgZnJvbSBMaWFtIGlzIHRoYXQgYmFja3BvcnRp
bmcgTWFwbGUgaW50bw0KdjYuNiBpcyBqdXN0IG5vdCBwcmFjdGljYWwgdG8gZG8uIFdlIG11c3Qg
ZXhwbG9yZSBhbHRlcm5hdGUNCndheXMgdG8gYWRkcmVzcyB0aGVzZSBjb25jZXJucy4NCg0KDQot
LQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=

