Return-Path: <linux-fsdevel+bounces-55969-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E548B111E7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 21:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39A535A1E3D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 19:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4528D21C9F5;
	Thu, 24 Jul 2025 19:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="U/4dC30p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CF99443
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Jul 2025 19:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753386596; cv=fail; b=Mk2LteBvKh3AqLnj/87a6APSgafigOU7Blg3ct25ZegYBwbuT9EgXqHRAfLPOkgC1NJiAMG9BtuZBo1G88+lkCHjzZ1xIsHZwVpBAoeqopfJWITcVj3zG+aWmpjlE23hBuhCHnyf21em6gOnIaFsG/TpGrAl/u1XB3QTuI5s50M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753386596; c=relaxed/simple;
	bh=k4WoCSDUab0jAR/pKo6+hbraBrlKbpvcvvpimLPdEPk=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=UrRIH8pnkwqlmvQBoIn5DAd0wjMJ/z8aTGT5QNzJDLz8hOv4ZmDEYUKWwA7GkAmbo0uDGfDCmiZ2sP9lu0C5jOyM8HpehxYdPipTUSu0tvgfezQQIzehYsTMbmJF1AvOPCrzMpLmo4ccUTBnhjCHZ3jwHimBhlqvQSScfdDs54I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=U/4dC30p; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56OHriWX028810
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Jul 2025 19:49:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=z0pdwLLrzI7xv9WAcSku+ueOWjLcbRA7XXmQhWT8268=; b=U/4dC30p
	5wwtOJXdOU+h8V1Hm9zqxToVivJc69zpU49y5l9FWbHeXUxZgtEcTGAlE1NjeoSn
	3JUGK04QLz5h+D8J3wD9Uo0xloqT2j0X4WtLDxfkcu34eh/smyANu83+QcOUvc4X
	YmQlk3a837JBvnsjOAA7hks4HV0V66T2AKpX34xxyMIqOphFRXIK2T/ubTIli/90
	D3PROe2w/dQwVLVBZKCxt3ERcYvUpNqnCtm0dHhjkzCt2tlhBARd+Wc862Y5Iu2E
	XBYALtyKT+zkAYmvdqi/QO/ZxMW4YNGeZBUKmJ+Y73Il7fzAsbk6wVmV5YWggo4c
	7uAt1T/vneYUbQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 482kdyuvxb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Jul 2025 19:49:54 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56OJgZ27004476
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Jul 2025 19:49:53 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02on2071.outbound.protection.outlook.com [40.107.96.71])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 482kdyuvx2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Jul 2025 19:49:53 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EeMFW5g6OKx10J7AzvO6mFnyTFQtrWFrgidYUMZNFlWsgSCaXAb1kDLs2bUcjCS5Uq9BGD3MMO+OCjvbkbULUWlIbUOjCfPcTSIAxGuqDqSVihn0pU+qGiOMG4Br4fRRhh3dk+EchppfUfBpnvBmxKTFOkS7nImn5z6vlDlkRfFRMsPbIjeQ+HmSBAB/qzqaFlAczRd73tWH20sYVyj0xIyq8f/y9JkSsP647YAFfVHhSbGNJ9y1eDm7lpIrdp0awutrrpV2oDdBUYpxpnWJOzhITWe0xl32Uk79kOlPS+QHTPbOe9VIORG5sgScIiSbUPmxrTiyqGsJQKA7HofxNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HIgAeqAUNlSUG4L7lvAOmly5/qCEcqgokw4ilG+KBgo=;
 b=Z+46rfHwm7FyK/Ppx6BR+GOv9OIsHyTgMuD09Md0KHWIkLAM3brsbd8NodVEd/d+4ZOUUCvYA7lHGpQfjpXVBhOyMLkInJJO65Yoc7EeeFy3a4pTYyt8g/A0fR8MWIYVK+Nu0EHjlf2a10FDIKfQbvD9ZendYgYfBULrIhGYTkG0Zg9rs71TQXZ7tUU+UN+cZ5BJAJVU6FlDVm0HsnQtkppvUd2Yp7VL4srtt2dNdK/zG12uA97yoSyOaBmLdwHSlsIrsAX9XBorQc+UwYPBf5upn7eHjXa8USuie2oUR9NB5EYG0xImFmPgKlKnANrsEmVE0Uh+lv8RFuqy3fCoxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SJ0PR15MB5821.namprd15.prod.outlook.com (2603:10b6:a03:4e4::8)
 by PH0PR15MB5023.namprd15.prod.outlook.com (2603:10b6:510:ce::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Thu, 24 Jul
 2025 19:49:50 +0000
Received: from SJ0PR15MB5821.namprd15.prod.outlook.com
 ([fe80::266c:f4fd:cac5:f611]) by SJ0PR15MB5821.namprd15.prod.outlook.com
 ([fe80::266c:f4fd:cac5:f611%4]) with mapi id 15.20.8880.030; Thu, 24 Jul 2025
 19:49:50 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "penguin-kernel@I-love.SAKURA.ne.jp" <penguin-kernel@I-love.SAKURA.ne.jp>,
        "willy@infradead.org" <willy@infradead.org>
CC: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>
Thread-Topic: [EXTERNAL] Re: [PATCH v3] hfs: remove BUG() from
 hfs_release_folio()/hfs_test_inode()/hfs_write_inode()
Thread-Index:
 AQHb91IJ4dXLt/uuZkqRbEGinlBUibQ2uTqAgAAmwgCABfRaAIABJ7GAgAAu4ICAAAmKAIAABPwAgAA/FgCAAHUJgIAAE2cAgAENGoCAAAaQAIAAzLAAgADYSYA=
Date: Thu, 24 Jul 2025 19:49:50 +0000
Message-ID: <5ef2e2838b0d07d3f05edd2a2a169e7647782de5.camel@ibm.com>
References: <4c1eb34018cabe33f81b1aa13d5eb0adc44661e7.camel@dubeyko.com>
	 <175a5ded-518a-4002-8650-cffc7f94aec4@I-love.SAKURA.ne.jp>
	 <954d2bfa-f70b-426b-9d3d-f709c6b229c0@I-love.SAKURA.ne.jp>
	 <aHlQkTHYxnZ1wrhF@casper.infradead.org>
	 <5684510c160d08680f4c35b2f70881edc53e83aa.camel@ibm.com>
	 <93338c04-75d4-474e-b2d9-c3ae6057db96@I-love.SAKURA.ne.jp>
	 <b601d17a38a335afbe1398fc7248e4ec878cc1c6.camel@ibm.com>
	 <38d8f48e-47c3-4d67-9caa-498f3b47004f@I-love.SAKURA.ne.jp>
	 <aH-SbYUKE1Ydb-tJ@casper.infradead.org>
	 <8333cf5e-a9cc-4b56-8b06-9b55b95e97db@I-love.SAKURA.ne.jp>
	 <aH-enGSS7zWq0jFf@casper.infradead.org>
	 <9ac7574508df0f96d220cc9c2f51d3192ffff568.camel@ibm.com>
	 <65009dff-dd9d-4c99-aa53-5e87e2777017@I-love.SAKURA.ne.jp>
	 <e00cff7b-3e87-4522-957f-996cb8ed5b41@I-love.SAKURA.ne.jp>
	 <c99951ae12dc1f5a51b1f6c82bbf7b61b2f12e02.camel@ibm.com>
	 <9a18338da59460bd5c95605d8b10f895a0b7dbb8.camel@ibm.com>
	 <bb8d0438-6db4-4032-ba44-f7b4155d2cef@I-love.SAKURA.ne.jp>
In-Reply-To: <bb8d0438-6db4-4032-ba44-f7b4155d2cef@I-love.SAKURA.ne.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR15MB5821:EE_|PH0PR15MB5023:EE_
x-ms-office365-filtering-correlation-id: 759172c1-6f06-4db0-d4e1-08ddcaeb405f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|376014|366016|38070700018|13003099007;
x-microsoft-antispam-message-info:
 =?utf-8?B?dkFCdkM2ckMzQVJ5Tmx5SjVld1VacWc3M1ROTThWblhNK2dCdis1Q2pYS2Nx?=
 =?utf-8?B?ZXF6TS8yVjBxTmRvZW5RWkdLa2c5Y3R2eEhwd3RnZ2V2RXlDczQzZkFXemhB?=
 =?utf-8?B?VldOenpoNTFBWHBYdnBRanpGU09QUkVmZnVaSVlPUlIwTm52VlZobnBMZ2V3?=
 =?utf-8?B?bHhNNDVHdXYyMWFWb3kwak5RbWI0MmJ6UGZ0am53M05VMThEeGFHRy93U0JJ?=
 =?utf-8?B?b0RkMEZZc05TdzlsY2QyanhFQUxXb2ZpaVRoSFFJczJkSGIzNThtMkcrVlUx?=
 =?utf-8?B?WlFpRm9rVWdZY0F2MVM0cFZPNmVmZUVJdG45SUhiMnZ5Rm9BMGdSaER3L2dL?=
 =?utf-8?B?YUFRZTBoWDltUVo3Z1F2T1U4TVdSWk5lKzVxbkF4RzZqN2NmaC9OY0I4UnV4?=
 =?utf-8?B?SzFWaWhLR2JhZmNDNktkditaRnEzUWhMcGVsTGZoZDFkamVLdGhxTDA1SXZP?=
 =?utf-8?B?RitaNm1mUmJoblNhOHhmcDUzZE9pNG8xajZRWnl4bDhBNEJoQUxMZDlKT043?=
 =?utf-8?B?dnB5TVRNVXFzOFNCU1M4aUZNeWp4b2VjcXJRZXU0U2hYUlVVSUlpRXRVdmtl?=
 =?utf-8?B?TjhlNUs4eTU4V0JheFFRSE5uTTlMQmlUQTE1RFVGVGp6U1BTcVlVd3ZvV0t3?=
 =?utf-8?B?WnRFMlJKMENFN0VpV3RoYmpDSnphVG1xY0hZMXJsbGxRQWtSTVRmZFdmdkZ2?=
 =?utf-8?B?NmhnbFQwTFFtZ01GeUpLZWdDc0lURGlidHU1U2xSQ3lpaUMrdjlUd290YVhM?=
 =?utf-8?B?RGxVV3dHTU0xdld5OGU3SzkrUEd6bnpnU1BpYTlBVFkwWWx2QVR6cmVxajNI?=
 =?utf-8?B?R0RnY0tsK3E2ZUVuLzNsTW03UlA5SUxmckI0ekNlTzNORmY0WXFydVl4UFAz?=
 =?utf-8?B?RUJOc3FhZzNjbmN4NTc2a2tSTXF4bTBCdkpmWWRHNHhzMEdycmYvVmdNQk40?=
 =?utf-8?B?S0toeXNYdWU0SWVtZzBjUFJ5TXAvSHZOcnVWeThNQW9lRTNMKzgvakhSTS9E?=
 =?utf-8?B?bjAzc1FCSXc2Sk4vMHRqeDUySlFKald4T2ZCbFZmV2NVQlVGYnJGc1RPcEVG?=
 =?utf-8?B?Qmw3M3FzbWhCY1QzZEhXbmtOOTM4TUMrZkMvbElwNkUzcTVoNFVCckVMSHF4?=
 =?utf-8?B?Q3pQSFFOdDB5NXRIS01ueXdzZGRKVitiODVPOEtVaDI0eVl5WXkzMmpabmVr?=
 =?utf-8?B?VzlMeFJzS21vc04vRURrWk4ybExxdkRHVWt3U2JjSWpBN3IwUUhzdlRQcXM0?=
 =?utf-8?B?SGIvNTZSdEphcUJlZDFzaE9oa2NlZmhIOFNnR1VHa1NScnJoTkJYWE14NE5I?=
 =?utf-8?B?MnFOYjA3M0VYWnZyTjgxc1F1SWNuaEs5cTMydTdBazQzeC83cEVjNlBNQmwz?=
 =?utf-8?B?cnBFYlBzUk9HSWdqcURza1d3QlowMkxJUlI1L2FRTjdUMWJCQ2lLM1oySTND?=
 =?utf-8?B?ZUtmTDJvdC9kYXJXbkpCYW1oN2JyQWZqd2JEVFpOajF3M2ErQi9ZbFBMZk1a?=
 =?utf-8?B?TkhZNzdaSzZqVnFrZkNMTjVDcllRQ0NwRStUWDZkSmNwQms2UC9OOCtFa01t?=
 =?utf-8?B?TVNoZFBPbTVQVVBiaC9YaTBzQjVLNXlidUlxL1FEdWVsR291NFhYQTJNV08x?=
 =?utf-8?B?UXpERFdiVEs4TEVFNTEwYVFpaWk0WGNtMGJweFI0RHVNRTlNaEc1R0QwMGZE?=
 =?utf-8?B?VFZ6TnI2TnpKNG1QbkZMc3NNaUpna0JsSmZNc2dicFN2ZEx1MURQaS9senpL?=
 =?utf-8?B?S0dLUXVUOVB4ZWFZMXE3K2F3NHl1T0dhSWVoWVhnYjRwbFQxWjZJOG5MT3VK?=
 =?utf-8?B?RWtwZ3JmQlBuVnYwM3lhbkhBSEQ4dU1yd2MxTlM4dERxVWZqdCtOY1c1OVJO?=
 =?utf-8?B?QUFVcGgyUmcvRW1yQXltd2pYdzFPZm51YVdBT216dmRQQmRBYi83MDczSm1F?=
 =?utf-8?Q?LrNNYEj1N5s=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5821.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(38070700018)(13003099007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z0JmOVZPV0ZjY1lqaTJoKzlHeWUxNGY3YStDdWZ0bEtwbCtLRkZWVFBwYmM4?=
 =?utf-8?B?R0ZzUkRzUnJTOW1DVVhFRUl4VHRhWVR6cWRSSlcxNm1aZis0S0lBNTVhUHM1?=
 =?utf-8?B?ZUJkaFQxaUVXWGJTb3VGVnZSdVlpQTFYSTlsZURjVTIxSlZOa0pUekwyOFEz?=
 =?utf-8?B?WkYwM0tOcXAyczZGYnZNcUtTUHRoK2JmVk9jbGZrSk9wWHhZSUtTb091RnlY?=
 =?utf-8?B?Q09nMHJ2VnRPTnZKK0xEK2xhMzlQZEU3ZmpGSStiekMxaHIrV0ZKWTBDYTdB?=
 =?utf-8?B?RlFML04yL1ZML3JSMkdpVWk1WEcxRk8zMjVGd3p4aDkweEthWXhpWUxBbEtu?=
 =?utf-8?B?TTlObGhFMzdZYVY3TVJ6OG1QNHUwNXdxL2NHWnBBM3lnd2RINitjOXV0Y00w?=
 =?utf-8?B?UlZKTmVnRWt5Nkl4WjVDQ1RuRnRwdWNzeXRiT0F5L0cvdUE1K0lFQi82ZlRx?=
 =?utf-8?B?eXlSL3NVVjJ1QTluRjZVYnZwamlsaVh3WlB3ZWp0L1EzTVpVbnMxVy83SEZI?=
 =?utf-8?B?Nmx2SHhyVi81R0RIcHI1K1hkT0hCR2xXdm9qbmNxWTdCMHpzMjhPOXJ0cVhs?=
 =?utf-8?B?cUNLQlIxR3dTR3ljck0vajJOeTN2UXhFQmlsTjkxdzVwT2E5ajRSUEFWKzRJ?=
 =?utf-8?B?dE1VemdZZVNycmtxREd4eUZRZ1ExeVhuNTh1QmZrNUNGUDFTbVhRYnZuTGVy?=
 =?utf-8?B?MjBsbEdkbGJ1L1BpekN2SDBRUU1MeTJHZ3VCR01kemFGTkYwOFZHUThQRXFF?=
 =?utf-8?B?S2VROEpvZkxTTjZubkVWVWZKTWxHV0xFVklXT2pKTTBOT0VpUlZST1BhMFo0?=
 =?utf-8?B?dVJmM2hSVlQ5V3NuWkltcVFhQ2pLaG54T1ZHclZ3d2RrMkZtQ0FicGUyWGxN?=
 =?utf-8?B?K3dqcjEvV0JGREpDaVdrUENrc0lKT2luUHBOM1ZwMjBHaklablR1K24zYkx4?=
 =?utf-8?B?ZzlzZlBKVUw1R2ViS0lSZjFCdUc4ajlGWGZOM2hDdFNOemdUdW43WDBwcjBH?=
 =?utf-8?B?NjU3UGRxd2U2aWRUK0xNYkFaVEdLVENVT25kbUdVN1E1ME53Qm9MUmlvMHNT?=
 =?utf-8?B?N1laUWFKWHI0OVc0UitralBZSFZ1c3Q2bmtwNzFMeGFwN29mTE5oYmVhNFBV?=
 =?utf-8?B?N3ZUZC9JQXRnVEovMnNmQmlrc0RYYzdtVGtJVDl2d0M2Smh3TmdSQXk1VUd2?=
 =?utf-8?B?T0d1TDVEY3lNd2RrV3E4NVJYeHRkZGlKdUc0cWdqdkw1c1dEVFQ3N3NSYXNr?=
 =?utf-8?B?bUM3ejdLYkZmY2RtQ0wwUDJaV1NVWVFXcWNWNmsrOFNnK2pXRkk3MmpxTFZh?=
 =?utf-8?B?RmVGZXZKeXBRdnlObUJhZkRxb0M5RzZVVldxWnFhQW1SaXdXL28xRENkRFpl?=
 =?utf-8?B?citxL0pUcS9jNFo4WTREcHVBRExlVkZIQXNRSG1vQlFJMGpnM1FoemNVQ21L?=
 =?utf-8?B?dStmOW9jUVFVd2VNSVd1TFR2bTJTMnVHWGI2eTgzZWduSzN4ODZwUTJ4a0Ru?=
 =?utf-8?B?RHZpRm9hdU9JTk1wbExDMzVYYlpTZFRTa2VLalA2VjZqZVJYYlJmT1lwOGFQ?=
 =?utf-8?B?QmZ1bWt1SWJicHg4RG1EVzN5dXhmMkJZUDZKT2Q2YUxOWkdUV09UN3pmemlU?=
 =?utf-8?B?M2V6VFo4ZUc0djRBUW4zcUc5VVpuelhuOGJveG92OVhSS0oreXR6Nk43aEEr?=
 =?utf-8?B?bzNud20xdmhRVkVTN0h3cFBuY0FjU0N2WjFlTXZ5NHFuS0w1Z3IvcUd0QVQy?=
 =?utf-8?B?UmM0Zlc3NFZqMEM2SFYvQ1dlK1gyNjE1L0E4MHFuQXpIU2dMbFFiOU9GWm40?=
 =?utf-8?B?eURYSWp2V1lVejZhR1BPcmh5cVFESHVNSXh4bTVvUTlUeGRERjl6V2NBeUJ3?=
 =?utf-8?B?WFUvdkN4d0lBK1JWUzFWK3VJRWpHK0ZjbGN3eVZtM2tuS1V6d2xoZzB4Y2NP?=
 =?utf-8?B?aVF3OGpNMlh6ejdFZUVHTWpIVUQwMG9KYXMvT1BPQStvZUlZSFJ0MDUxS0NB?=
 =?utf-8?B?Z0IrSHVZMWdBMDZvRHJJSSs3U1RmMWNKSU9mejdpeTFackZVM01MeS95SENS?=
 =?utf-8?B?c3FQT1UvejNjT013cVNLTlhNRWJUaDg3SmNVVS9vYlJQRnhjWE9sQXhuaXVI?=
 =?utf-8?B?c3ZmTmtlRWFPVjA3Ly9rdE52RWEyTmlReEtsSlgxM28rWkNxU1JwaWFuSkdK?=
 =?utf-8?Q?Hu+iMPFoQBSPS0Z46ocZptY=3D?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5821.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 759172c1-6f06-4db0-d4e1-08ddcaeb405f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2025 19:49:50.2092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WYEvBRBM3eJCddbPYS3ML74L6PTcOIJjC5NOD6+xjxZTmbDhSrtHQJ2tY4luTuhQ0NMeSrbYkMYaCj0jwo+r4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB5023
X-Proofpoint-ORIG-GUID: 6VxYue030Jdq6Hi6KYFRZ5q8pVtGmB2H
X-Authority-Analysis: v=2.4 cv=XP0wSRhE c=1 sm=1 tr=0 ts=68828e61 cx=c_pps
 a=ACYjI9XXP2BzzpCpjpIAbA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=t-IPkPogAAAA:8
 a=7qxwMKlZcpBroTKTlKAA:9 a=QEXdDO2ut3YA:10 a=55wNQ-xyllsA:10
X-Proofpoint-GUID: 6VxYue030Jdq6Hi6KYFRZ5q8pVtGmB2H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDE1MyBTYWx0ZWRfX3V42lVpi9Yn6
 /QMmBcpLils/qn/tHPC00Xf14rlI0m3AArIfEtFomss0wzBIpzdfwQRo3DWsTD4SHyPnfvvZaqX
 aKfkfCYMR1Qkf/rnxet3q6J6C/pJhw1atBzI2OClCkcswSOfbpLDlpw1GQnKrn52PeIab6quUfZ
 xwheN4hmuqkE1Nb7ItDOnB0h4iBprJ38jdmbKTqcs5nDd3VbEZrR+PMDbHVUhmsFA4TVMYoNybt
 yWdaR9tKtzmcaqfOGcenCzeotThReR3VOaEyBtzz9p6iJUlyoOPufFWywBfzA3No7qvnYF3GD3R
 LNyUdrxZ0Et++eHSvTJiH5GqdP4YGtTkftBIr5TNEg2efFK3OS6ZfqeRbkeN3wraHn+2ELRh6L1
 7K1f1yhG0ayf5OfvsEflixW3eC/afRz9rsJJWRAIAW/4gYZXK1c87oy/I/D6u7A+eWS4l6Yi
Content-Type: text/plain; charset="utf-8"
Content-ID: <3858E1E77B10E746843B6B1F838F7504@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: RE: [PATCH v3] hfs: remove BUG() from
 hfs_release_folio()/hfs_test_inode()/hfs_write_inode()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_04,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=999 spamscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=2
 engine=8.19.0-2505280000 definitions=main-2507240153

On Thu, 2025-07-24 at 15:55 +0900, Tetsuo Handa wrote:
> Then, something like below change?
>=20
> --- a/fs/hfs/inode.c
> +++ b/fs/hfs/inode.c
> @@ -318,6 +318,9 @@ static int hfs_read_inode(struct inode *inode, void *=
data)
>         struct hfs_iget_data *idata =3D data;
>         struct hfs_sb_info *hsb =3D HFS_SB(inode->i_sb);
>         hfs_cat_rec *rec;
> +       /* https://developer.apple.com/library/archive/technotes/tn/tn115=
0.html#CNID   */

We already have all declarations in hfs.h:

/* Some special File ID numbers */
#define HFS_POR_CNID		1	/* Parent Of the Root */
#define HFS_ROOT_CNID		2	/* ROOT directory */
#define HFS_EXT_CNID		3	/* EXTents B-tree */
#define HFS_CAT_CNID		4	/* CATalog B-tree */
#define HFS_BAD_CNID		5	/* BAD blocks file */
#define HFS_ALLOC_CNID		6	/* ALLOCation file (HFS+) */
#define HFS_START_CNID		7	/* STARTup file (HFS+) */
#define HFS_ATTR_CNID		8	/* ATTRibutes file (HFS+) */
#define HFS_EXCH_CNID		15	/* ExchangeFiles temp id */
#define HFS_FIRSTUSER_CNID	16

So, adding the link here doesn't make any sense.

> +       static const u16 bad_cnid_list =3D (1 << 0) | (1 << 6) | (1 << 7)=
 | (1 << 8) |
> +               (1 << 9) | (1 << 10) | (1 << 11) | (1 << 12) | (1 << 13);

I don't see any sense to introduce flags here. First of all, please, don't =
use
hardcoded values but you should use declared constants from hfs.h (for exam=
ple,
HFS_EXT_CNID instead of 3). Secondly, you can simply compare the i_ino with
constants, for example:

bool is_inode_id_invalid(u64 ino) {
      switch (inode->i_ino) {
      case HFS_EXT_CNID:
      ...
          return true;

      }

      return false;
}

Thirdly, you can introduce an inline function that can do such check. And it
make sense to introduce constant for the case of zero value.

Why have you missed HFS_EXT_CNID, HFS_CAT_CNID? These values cannot used in
hfs_read_inode().

>=20
>         HFS_I(inode)->flags =3D 0;
>         HFS_I(inode)->rsrc_inode =3D NULL;
> @@ -358,6 +361,8 @@ static int hfs_read_inode(struct inode *inode, void *=
data)
>                 inode->i_op =3D &hfs_file_inode_operations;
>                 inode->i_fop =3D &hfs_file_operations;
>                 inode->i_mapping->a_ops =3D &hfs_aops;
> +               if (inode->i_ino < HFS_FIRSTUSER_CNID && ((1U << inode->i=
_ino) & bad_cnid_list))
> +                       make_bad_inode(inode);

It looks pretty complicated. You can simply use one above-mentioned function
with the check:

if (is_inode_id_invalid(be32_to_cpu(rec->dir.DirID)))
     <goto to make bad inode>

We can simply check the the inode ID in the beginning of the whole action:

<Make the check here>
		inode->i_ino =3D be32_to_cpu(rec->file.FlNum);
		inode->i_mode =3D S_IRUGO | S_IXUGO;
		if (!(rec->file.Flags & HFS_FIL_LOCK))
			inode->i_mode |=3D S_IWUGO;
		inode->i_mode &=3D ~hsb->s_file_umask;
		inode->i_mode |=3D S_IFREG;
		inode_set_mtime_to_ts(inode,
				      inode_set_atime_to_ts(inode,
inode_set_ctime_to_ts(inode, hfs_m_to_utime(rec->file.MdDat))));
		inode->i_op =3D &hfs_file_inode_operations;
		inode->i_fop =3D &hfs_file_operations;
		inode->i_mapping->a_ops =3D &hfs_aops;

It doesn't make any sense to construct inode if we will make in bad inode,
finally. Don't waste computational power. :)

>                 break;
>         case HFS_CDR_DIR:
>                 inode->i_ino =3D be32_to_cpu(rec->dir.DirID);
> @@ -368,6 +373,8 @@ static int hfs_read_inode(struct inode *inode, void *=
data)
>                                       inode_set_atime_to_ts(inode, inode_=
set_ctime_to_ts(inode, hfs_m_to_utime(rec->dir.MdDat))));
>                 inode->i_op =3D &hfs_dir_inode_operations;
>                 inode->i_fop =3D &hfs_dir_operations;
> +               if (inode->i_ino < HFS_FIRSTUSER_CNID && ((1U << inode->i=
_ino) & bad_cnid_list))
> +                       make_bad_inode(inode);

We already have make_bad_inode(inode) as default action. So, simply jump th=
ere.

>                 break;
>         default:
>                 make_bad_inode(inode);
>=20
>=20
>=20
> But I can't be convinced that above change is sufficient, for if I do
>=20
> +		static u8 serial;
> +               if (inode->i_ino < HFS_FIRSTUSER_CNID && ((1U << inode->i=
_ino) & bad_cnid_list))
> +                       inode->i_ino =3D (serial++) % 16;

I don't see the point in flags introduction. It makes logic very complicate=
d.

>=20
> instead of
>=20
> +               if (inode->i_ino < HFS_FIRSTUSER_CNID && ((1U << inode->i=
_ino) & bad_cnid_list))
> +                       make_bad_inode(inode);
>=20
> , the reproducer still hits BUG() for 0, 1, 5, 6, 7, 8, 9, 10, 11, 12, 13=
, 14 and 15
> because hfs_write_inode() handles only 2, 3 and 4.
>=20

How can we go into hfs_write_inode() if we created the bad inode for invalid
inode ID? How is it possible?

Thanks,
Slava.

>         if (inode->i_ino < HFS_FIRSTUSER_CNID) {
>                 switch (inode->i_ino) {
>                 case HFS_ROOT_CNID:
>                         break;
>                 case HFS_EXT_CNID:
>                         hfs_btree_write(HFS_SB(inode->i_sb)->ext_tree);
>                         return 0;
>                 case HFS_CAT_CNID:
>                         hfs_btree_write(HFS_SB(inode->i_sb)->cat_tree);
>                         return 0;
>                 default:
>                         BUG();
>                         return -EIO;
>                 }
>         }
>=20
> Unless this is because I'm modifying in-kernel memory than filesystem ima=
ge,
> we will have to remove BUG() line.
>=20
> On 2025/07/24 3:43, Viacheslav Dubeyko wrote:
> > This could be defined in Catalog File (maybe not). I didn't find anythi=
ng
> > related to this in HFS specification.
>=20
> https://developer.apple.com/library/archive/technotes/tn/tn1150.html#CNID=
 =20
> says "the CNID of zero is never used and serves as a nil value." That is,
> I think we can reject inode->i_ino =3D=3D 0 case.
>=20
> But I'm not sure for other values up to 15, expect values noted as "intro=
duced
> with HFS Plus". We could filter values in bad_cnid_list bitmap, but filte=
ring
> undefined values might not be sufficient for preserving BUG() line.

