Return-Path: <linux-fsdevel+bounces-51517-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBD4AD7B13
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 21:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5652A18914CD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 19:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6816D2D3237;
	Thu, 12 Jun 2025 19:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Y+stGjDR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CDF2F4309;
	Thu, 12 Jun 2025 19:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749756993; cv=fail; b=jzVRl322ZDCIqjOfkSeyE8dAZqkelM5v9Q92BdMVdCzq9irxgEbwjfasyVCZ7CwZL/I1AjGwNAB3eLoeMCYOFl40y55RtYXDddoBq/lUt5oH4DMhe0ko/d6IrBUsWbycBcCDlIzLn8wPKNod9AHLSv9+sO8ntGLfj/hMooPrQ/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749756993; c=relaxed/simple;
	bh=TBDmbU6yz1c/A/pAf2+NpcXcKA0nCwyKsIT7Njq2TNM=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=DNDHl2+xNh1Catqux6GGsJa8GlY63fpniw+fxqXwD8fyf5J5idV5e1VQMRM9C18+gyc//INYznJUH2Q9J1oe8mrQXGzcZHZx3/V4LSjSxRzMUrHjVdjdFtaMw6WmYaHkGJzxPB8MtAJlg4kw68skSPZZpizHDv1hyqkI2b2m2KY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Y+stGjDR; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55CBGvgI000783;
	Thu, 12 Jun 2025 19:36:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=TBDmbU6yz1c/A/pAf2+NpcXcKA0nCwyKsIT7Njq2TNM=; b=Y+stGjDR
	x99DBh+5XGBA3zmbzl0l9y2DbSGI2Eke5TLdUYs/96Z7ge/1KjoQynI7fnpNYuHI
	eNy7HDSJGDeAvqniObYQsj7aO41oASQnQrkubve+jfjVd9S1zAnkdazKXrpAyPpm
	bEOGS8QnkvvHPRMVV63D83fJBJqEJIlQt4+eQaR2PLD00WzCYlALtLpXoPyG0xCv
	+Kr7F9Anads+1+0ECEskQFy+uZQvEBTnn9vdGkBqrP3b55eZIaIXfa6Ny/mQpDDT
	GAPzDCNefPfLyuayf1r6w34eIYgcY4cCx7OuopFED1DiBr2F6zgF9a1KypP6a5CQ
	um6m2OT+Dk/Lqw==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4769x01kyu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 19:36:14 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SKLJ4RKPgvYFqZCL6YRGuOSNdpiUU0hDXhfEXwPU8ctxh6jD1Mx0tTRjpN/gKtW6mYgIDLpg5hYsMzUGHyxxC2k/+ZYJR64HRH/b40ub5FiobnosZZxs43vE13njw6w/YWEebTxT17SJ28P1fP5Bwh4pRQs6BVG0JmXGO8pEW39ubY6UATn/SIVRid4eF8tF/a1mYy5HN8PzmZlTtJzKX5wsQyItZGue2HbcwEH8/fIy+FC2NUv1cBypq4HOTFyUlH2JJDdh2xzCWXxSEUYEhG4RMZtO1a3SUnvOOPGCWk/5VV5MqYUGntID/mrZAwoKoYBSidTnzS/CEe0VbCgxFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TBDmbU6yz1c/A/pAf2+NpcXcKA0nCwyKsIT7Njq2TNM=;
 b=uPwEqYvJbw1PR58vinw+lmXyiUFgPNubaM/FS3hnhsY+lk/g1pHYKdEaqoo/uz6McA+zIVZ+o5I1IEyOYBJ0TvLKvd5sOQb0P/2O4cK8m+9hVcrRfNdKS/Y69CR9ReNWw//O6kr2IaqyQHAsjktWnnNI+w6hqQnnuNnQVQEn2/jbSqbnIsH8nFNvrx0LNLvpDPU6zwwiFrmfHxl1fJNWoxBc9m0m3I0K9ateycIr0Uxr/0dsyx0N1dbkySVTxUo4hGOXyRjbQqCK/pVLZJ1p1FwMgdHo8INlqz4QIKsx9Bt/N0+hp0anJs/AnSEEx35NGxowa5COA5IiELB1VziBDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by IA3PR15MB6722.namprd15.prod.outlook.com (2603:10b6:208:51b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.23; Thu, 12 Jun
 2025 19:36:12 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%7]) with mapi id 15.20.8813.018; Thu, 12 Jun 2025
 19:36:12 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "willy@infradead.org" <willy@infradead.org>,
        "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>
CC: "hch@lst.de" <hch@lst.de>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>
Thread-Topic: [EXTERNAL] [PATCH 4/5] ceph: Convert ceph_zero_partial_page() to
 use a folio
Thread-Index: AQHb26ffIYbDsrgK+k6JSmW9loNoQrP/6zCA
Date: Thu, 12 Jun 2025 19:36:12 +0000
Message-ID: <80277dc7220fa255044d3d90109866aeb46a52da.camel@ibm.com>
References: <20250612143443.2848197-1-willy@infradead.org>
	 <20250612143443.2848197-5-willy@infradead.org>
In-Reply-To: <20250612143443.2848197-5-willy@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|IA3PR15MB6722:EE_
x-ms-office365-filtering-correlation-id: 25b5cfb7-2c46-4b07-bc44-08dda9e86375
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?d045ZlpNa255RUpMNTZKL2lQYnlPWFRZaldyZEo0eXUzd2Q3NDdXZlNrLzdJ?=
 =?utf-8?B?eXZMT1dMT290cC9EYlNNNy9SMUVGWEtxS2gxUWRvMVA5TW9FeTg4bzZkQmpW?=
 =?utf-8?B?VVRNUytqVDhmSWpvTFVDdktZSkFXRWo3UGt2VjhlRUdEd25ncWZZeHIzWGM5?=
 =?utf-8?B?MkZ4ZUluL212RmwzanhhRkhIek94YWlhMUVEaVAwc28yTXVMTS9LZmx4L3A3?=
 =?utf-8?B?UjFDaThKbFhPQTJ4enZXU2xJOHNXbnNNTGtNOTRld2trbXJERHI1bFA4Zkc4?=
 =?utf-8?B?ZnFhSU1qR2JnY3U3Ull6eGhHelBraHFBYkhJbnRiNjB3Zk9mWm1JUVVCZ0dG?=
 =?utf-8?B?VCtIcGRheXFBaDk4SkQyTmFvUlVjREJXM3BUMXlaRnNKei9IZk9WTWRwR1ZG?=
 =?utf-8?B?MHFJVXkrQ3R1SDhsbnphRWxLMzhUZFdOUXYwbi84MXBTZ1YvK3BWUWRtU2Zx?=
 =?utf-8?B?N29TQkVJWmI2Y2VoT0tWelhMVHJTOGRyTjVxU1RHbFpYMkZRMlcxSnhPVGZF?=
 =?utf-8?B?VlF2eGVDY0pLOGhRQnF3TFZFdjdVRjdQTXBDMWxVZVE3NjV4ZTc4MlMvOUpV?=
 =?utf-8?B?eFBjMVorU051R05xMGtvNUZlOHRoU0hOUUlyT1NyU3dnbjBtRW16a0ZNY0c1?=
 =?utf-8?B?V0RnTEIyaFFZRXRJVGpHZUtsaVM4dW9XS1lOc0lqZUpFYVJ6OUVlc0hNY2oy?=
 =?utf-8?B?S2R4SWtYZCtWS1RzUXd6YkZnbEZJcmZZV0thWHRXTVJ3V1QvL0gxN1FjZ20r?=
 =?utf-8?B?VVZEZWZXU0ZPYmZsY2tLZGNTbnpPTE42NE5UblgxTHIwSG1DTUVmSVRMcGhL?=
 =?utf-8?B?Wm5mWFNNMXpZQ0htSHlCdFVEeDV0bWZPZTdkMW9EdlZyRjg1RmIvcENzQ3A1?=
 =?utf-8?B?RjRoZ3ZYdE03c2NHNWxkTG5XTmFEdUZ4WnJqa04xclhVL0hJNCsrVGJXT1o1?=
 =?utf-8?B?QWM2cjJEb0FHeVZXdjRYYzFkUmF6L3owS01zTGdsUzR2NUdYYms2M3FrMDBE?=
 =?utf-8?B?Nmh5cnQ3QUZ4bkR4VGVEZkFUWnQyZXlhU3l5bEc5TzhaU0hGdnFBVG9WNlRN?=
 =?utf-8?B?b1IySm1WR2tFSFBGVUNhQ3ArNUE2OVpwQkdWUTRsUlJvNWVGSHFMOFNjNnpB?=
 =?utf-8?B?UU9US082cG5MRVpkVWliQk1zaEg3NG84SG5qS25rcXJPQWluNzYxWjBFWWVM?=
 =?utf-8?B?eGlwMlRZYnl2S2NkTEdna2IzYmNZUi9LMmM1R3dPNTFTWjdaalQxdVNWTHNF?=
 =?utf-8?B?RUx2QnI1UGErL3JrcVJsTUVMVUYzakJOTkZ0cGNVWjZBYytZWUtDQTI3STZq?=
 =?utf-8?B?Z2x3ZENOUi9uZnc4NnJWYUZTVkNSbG01QXRYcUphZVEvSWNQK0pQYlFrZWpI?=
 =?utf-8?B?SUQxYXhYWVlTU3EyQis5VHk3aGRQTzlyN245aGpwbjRHdGZlVVlHZFk0RXp1?=
 =?utf-8?B?a2NEWGkwSmM1aVFJUVFqU01KbTExbDVtUWlBemczNFUvRjUyaEt2aFFPWnFl?=
 =?utf-8?B?TjV5Z3g5bCtEVnJOUjUwbmkyMXFZN3d4a0FSMEdkdDFSTVhpT2J3RE9SbFJp?=
 =?utf-8?B?L1VFUHp6Zm5tUjZ1QmxHTVUvbEhWTFpqT3BYQXlKREpEZFo1SjZJMGc2N3lq?=
 =?utf-8?B?MWNNTVZWcHRhRlFsQmxpUHFSbC96Q3owVjV1b3NoYndBTlUxMWFrU0RZSnpr?=
 =?utf-8?B?QkoxZEk1R01MVTlmZElTNnNRbHBPeHlLWERFWWhuZ3NHK09sTmJERVRjZHlW?=
 =?utf-8?B?d1JFTTFaYnBQVExpckZwTng5dm5xcTc0Qlg0UjJFeTJtSyt5MHVWWWhXR2lQ?=
 =?utf-8?B?bHhBeUZDRWh5eERsNkVMeHVLeUZFMWxOV282YmJ1OVN0aExkUGorQ01ia0pR?=
 =?utf-8?B?anBPbldodzZqQWdMclAvcVJSOHM4OWlDSnA2cmRleTlyNHBDWXpiMlZ2bzd4?=
 =?utf-8?B?dUU2eWNXV2JTQ21sbDFEdk0wc2RPRmxtSFZlQ29MVEhYRUd2aGZwQ1Y0aTYy?=
 =?utf-8?B?Y1gwMVIweHl3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WWhNNzg4NVB6eTFNSXhlclpHT0dadWE4VEhPM0ZVODBXK05pQVl4Q0FZYWds?=
 =?utf-8?B?UUp4cHJiSXFIdjR6b3NKUWE1enBkNjJWanFqTjRPMUw4VXhPYTBidGlpY1Zx?=
 =?utf-8?B?bzYrRFdRZENKbTBHU1FySjJHR3VBcDZFMnhmSW5VUTc3NzJlcFZIK1huS3hQ?=
 =?utf-8?B?bU5zRFVRdk9acjRnTG9SbEN5RUdVWDJoZC9BOXMxaHVwNUtJYVRSSGlLTzNn?=
 =?utf-8?B?UzRjS05IeGtySGVUTXk0U2ZOSTllb0hOOTllSHJGTk5pVFBXSm1JNHI3YXRP?=
 =?utf-8?B?YkZpRGwxTlNqaEJ6WXhJUmg2YWErdmxIWmJUdkJoUjYxYUFpVUdmZXJtaDg0?=
 =?utf-8?B?NE5WL3RrT09IY3dZYmEzbzlsY1NKTTFTVVBDWmFocmdYWXAvWXFSRHY2L2l3?=
 =?utf-8?B?b204M0tIUUZPdmswVXlLZ3g1ODlNaGtzVmRJMlVSbXZNdklmek02c1JEVDEx?=
 =?utf-8?B?Um42MWM2bkZIR2Z2NjY2T1FTU3UxNXdDNVQwSUVpUms5YUo4cGcraWFpUnVP?=
 =?utf-8?B?Y25aSGw3aVVtZjliYTc4VmpGMitQK3Y3eFAvd0J5MVJRaHE2eWU0ZDJOdFRw?=
 =?utf-8?B?eHV2V1VzWGZITXFpd05DRHNHaVhaRTdJblFLdkIzcGtYaXMrenViSXNoeXla?=
 =?utf-8?B?SFdxRC9BR3owZ3l0ajRFK1U5WkpieWN1YndaOWhZMFlLYjlNdU45Qnl0cFpk?=
 =?utf-8?B?bVZuTzJXWjNSeUVzcnZBbUFIQzhxYnB4Q05rMlJnTk1UTUVad1J1WDI2dlpK?=
 =?utf-8?B?ejVlakhGeEFOdndMRHdQbnZDbmVUWk9PeXBMdGsrMDFacDRyU3JuaC9QenBr?=
 =?utf-8?B?STNhWHdvT1JjQmdTMndqaW92bXNITVRpUUxNbTFmY21aQ09hNU1LVVRDanFE?=
 =?utf-8?B?b3VQNlhweFpZTlVGbHI4d2NuZTU2bnRyN0pXNmc0TVNCcXAxZHkyT05yUkNT?=
 =?utf-8?B?Q1duVlBxaFpWSVN0RzNaRkIwbVByU2svTURsOXFDdUY4bTBWSFVDcjY1Ni9B?=
 =?utf-8?B?YzlvajAxVFpnb2RtTVVERlZHVzB4VGR6d1QyZXlKWTJZNC9XWks0ZTNsMWJM?=
 =?utf-8?B?WEV4RWxWL3BjTzJvQTB0TTJDaWtxN3BwcTJSSmgzbXh2MXZaNWU1RTlyYTAz?=
 =?utf-8?B?Z0JtVG4xa0UvVC9TZDZVSzZxcS9sVDNsRkhoazE3ZnhKTytFc2xrOVo0Sk1q?=
 =?utf-8?B?SE5NNFVCUkwrRVhHbFBiM1puNjdEODB5cTU2ZnBJb1kxQWpBSW9YTjBjSXZU?=
 =?utf-8?B?TUNsK2dQUTJaMnNuNHJFamQyTGJVV0RiLzVaYm9tMUorb0ZSQ2pUYnVCZFpo?=
 =?utf-8?B?UkxGQzFkV2FZUlpQMXlvRysyQXZiR2YxdVdYc3A4Z21wTVUzUmdCTzE4Y3RZ?=
 =?utf-8?B?T2Rrekpkemoxd0Y4QlZncHRCaGkrT3lxK08rbm45R0hnNlNFSkxSaFJuUWFi?=
 =?utf-8?B?M0FJdXdYdmxLNTc0WmZOSmVvMGZGc1VuS1ZDOFdYaUR0clVCWXNXMVhsNXo4?=
 =?utf-8?B?VlZkVkc0T3c5L3BRWXNGZnNaUjlZUGhqR1UwbmV6UmtlemlYbmpSWHRzZU9O?=
 =?utf-8?B?TGVTRGh3UVRmOG1jYmtsempKZ20rOGpGRkhsUUN0SCtONmdIMkd0Q3BySURz?=
 =?utf-8?B?elVvTm5hREJvTXRHRW5vVUFaNEdWZ1h1RzFGRmJHYUpxOUh2QnpIVjVHRklx?=
 =?utf-8?B?TzVjdkJvR2RZRzFDdWFDcFNmZWF2bGN6NlJzaFY3a1RVTExDMzNianRrRFB0?=
 =?utf-8?B?YUpWS3ZjcFV6dzlGTXhIcUNDMytrUWdhcXo1QW9VNnliMXZ3Y2kzNUk0cm95?=
 =?utf-8?B?WWhncjFpTU9ZME9nc2FGbW1yeU8zT3A5NEkzMDNUVGp5YjRsVGtuUVJaU243?=
 =?utf-8?B?cmpXN3RMeWZHM3M3U00wRjFKRXJDYk10aENQeTJRTzBMRjUxdmNTbElVOVFy?=
 =?utf-8?B?YjMrSjgyV1U5NlpsTm81RzVnb1J6dUNmdklIb2hUMDRFUnU5dFg3SVhPK1lt?=
 =?utf-8?B?VWdFZGoyRm9IeitkZkNaNmNZOUJwdUdPTkcxTmVpSHlqWFhLcWZrSnlPYm9p?=
 =?utf-8?B?Mi92cTJ5Z0diOGVlQjg4Rk5lVWsxN0gxVnVzQkhWQWdjYmlseTB1OWlIaU11?=
 =?utf-8?B?MUFnME5pRE91TVRQZGFHTmxXQitVd0NOSmNDTGh4bUVWdFBHTHlGTkxFc2J3?=
 =?utf-8?Q?z7xqech15M+s9I/K3JbaMJM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BEE25C0D52FFF24E94C04FAF910B8C90@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 25b5cfb7-2c46-4b07-bc44-08dda9e86375
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2025 19:36:12.2396
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rOCydhJjEVJNRg34CqrsULjwLeiY95O8QBuoje/YyXKlzrp5+z4ASfSgmSPWqYD7v1+BBcowxnzBsEebttVlzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR15MB6722
X-Proofpoint-ORIG-GUID: 0r5KPyh9kTCxtTHmr8ShzaZL9aAcwkAE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDE0OSBTYWx0ZWRfX5Jmj/IsIUXCN wVWTHoe6ISFtzfjKKOvte8MjDvKA327LMUJrpCpSPuxsGbxyrGmIaEnM7gAWzXr8XkJX2Oh9R0K Q/gN/iWt2PJD+RxKCuExuNUTj5k5A601amsvqt/a9YsNxsnDBsaJDLFDnSwnsII5/vk8YqBStAZ
 r6bEljuHrIOqrnN9MbXQykT4N4M7+cRC+9d4fZ3OzI3VHFhrRsKBVcpX5OIvGSJDnQ15dqG0U6n CBe7Itodf/1dgAItfUzSkG6KuXxFCHOu7K1+zeP8jsYQsG5uXMw/9IJoOOz0BgGBcrEmqcsGG9B 9v3Bs4tlpF8xgOyRz8HNwijI7F3bv5iE9DEntV1tjtuUMt7Tk2CQcPWDxLftNoODJzoc/P0cT/d
 G3KDPoZhclzFrTT+mfmZV8aEUYr5kDNb+B06ohYgbqdX051a0Nyf4LFZ6c/an+ThexusTuPi
X-Authority-Analysis: v=2.4 cv=YKGfyQGx c=1 sm=1 tr=0 ts=684b2c2e cx=c_pps a=qYMZzBO7ydizK6UiZNNFIA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=JfrnYn6hAAAA:8 a=VnNF1IyMAAAA:8 a=yblNkXvDgx5R9Dp-HPEA:9 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: 0r5KPyh9kTCxtTHmr8ShzaZL9aAcwkAE
Subject: Re:  [PATCH 4/5] ceph: Convert ceph_zero_partial_page() to use a folio
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_10,2025-06-12_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 malwarescore=0 bulkscore=0 priorityscore=1501 phishscore=0 mlxscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506120149

T24gVGh1LCAyMDI1LTA2LTEyIGF0IDE1OjM0ICswMTAwLCBNYXR0aGV3IFdpbGNveCAoT3JhY2xl
KSB3cm90ZToNCj4gUmV0cmlldmUgYSBmb2xpbyBmcm9tIHRoZSBwYWdlY2FjaGUgaW5zdGVhZCBv
ZiBhIHBhZ2UgYW5kIG9wZXJhdGUgb24gaXQuDQo+IFJlbW92ZXMgc2V2ZXJhbCBoaWRkZW4gY2Fs
bHMgdG8gY29tcG91bmRfaGVhZCgpIGFsb25nIHdpdGggY2FsbHMgdG8NCj4gZGVwcmVjYXRlZCBm
dW5jdGlvbnMgbGlrZSB3YWl0X29uX3BhZ2Vfd3JpdGViYWNrKCkgYW5kIGZpbmRfbG9ja19wYWdl
KCkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNYXR0aGV3IFdpbGNveCAoT3JhY2xlKSA8d2lsbHlA
aW5mcmFkZWFkLm9yZz4NCj4gLS0tDQo+ICBmcy9jZXBoL2ZpbGUuYyB8IDIxICsrKysrKysrKyst
LS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDExIGRlbGV0
aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2ZzL2NlcGgvZmlsZS5jIGIvZnMvY2VwaC9maWxl
LmMNCj4gaW5kZXggYTcyNTRjYWI0NGNjLi5kNWM2NzRkMmJhOGEgMTAwNjQ0DQo+IC0tLSBhL2Zz
L2NlcGgvZmlsZS5jDQo+ICsrKyBiL2ZzL2NlcGgvZmlsZS5jDQo+IEBAIC0yNTMwLDE4ICsyNTMw
LDE3IEBAIHN0YXRpYyBsb2ZmX3QgY2VwaF9sbHNlZWsoc3RydWN0IGZpbGUgKmZpbGUsIGxvZmZf
dCBvZmZzZXQsIGludCB3aGVuY2UpDQo+ICAJcmV0dXJuIGdlbmVyaWNfZmlsZV9sbHNlZWsoZmls
ZSwgb2Zmc2V0LCB3aGVuY2UpOw0KPiAgfQ0KPiAgDQo+IC1zdGF0aWMgaW5saW5lIHZvaWQgY2Vw
aF96ZXJvX3BhcnRpYWxfcGFnZSgNCj4gLQlzdHJ1Y3QgaW5vZGUgKmlub2RlLCBsb2ZmX3Qgb2Zm
c2V0LCB1bnNpZ25lZCBzaXplKQ0KPiArc3RhdGljIGlubGluZSB2b2lkIGNlcGhfemVyb19wYXJ0
aWFsX3BhZ2Uoc3RydWN0IGlub2RlICppbm9kZSwNCj4gKwkJbG9mZl90IG9mZnNldCwgc2l6ZV90
IHNpemUpDQo+ICB7DQo+IC0Jc3RydWN0IHBhZ2UgKnBhZ2U7DQo+IC0JcGdvZmZfdCBpbmRleCA9
IG9mZnNldCA+PiBQQUdFX1NISUZUOw0KPiAtDQo+IC0JcGFnZSA9IGZpbmRfbG9ja19wYWdlKGlu
b2RlLT5pX21hcHBpbmcsIGluZGV4KTsNCj4gLQlpZiAocGFnZSkgew0KPiAtCQl3YWl0X29uX3Bh
Z2Vfd3JpdGViYWNrKHBhZ2UpOw0KPiAtCQl6ZXJvX3VzZXIocGFnZSwgb2Zmc2V0ICYgKFBBR0Vf
U0laRSAtIDEpLCBzaXplKTsNCj4gLQkJdW5sb2NrX3BhZ2UocGFnZSk7DQo+IC0JCXB1dF9wYWdl
KHBhZ2UpOw0KPiArCXN0cnVjdCBmb2xpbyAqZm9saW87DQo+ICsNCj4gKwlmb2xpbyA9IGZpbGVt
YXBfbG9ja19mb2xpbyhpbm9kZS0+aV9tYXBwaW5nLCBvZmZzZXQgPj4gUEFHRV9TSElGVCk7DQo+
ICsJaWYgKGZvbGlvKSB7DQo+ICsJCWZvbGlvX3dhaXRfd3JpdGViYWNrKGZvbGlvKTsNCj4gKwkJ
Zm9saW9femVyb19yYW5nZShmb2xpbywgb2Zmc2V0X2luX2ZvbGlvKGZvbGlvLCBvZmZzZXQpLCBz
aXplKTsNCj4gKwkJZm9saW9fdW5sb2NrKGZvbGlvKTsNCj4gKwkJZm9saW9fcHV0KGZvbGlvKTsN
Cj4gIAl9DQo+ICB9DQo+ICANCg0KTG9va3MgcmVhbGx5IGdvb2QuIEFuZCBmaWxlbWFwX2xvY2tf
Zm9saW8oKSBpcyBtb3JlIGVmZmljaWVudCB0aGFuDQpmaW5kX2xvY2tfcGFnZSgpIG5vdy4NCg0K
UmV2aWV3ZWQtYnk6IFZpYWNoZXNsYXYgRHViZXlrbyA8U2xhdmEuRHViZXlrb0BpYm0uY29tPg0K
DQpUaGFua3MsDQpTbGF2YS4NCg==

