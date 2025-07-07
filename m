Return-Path: <linux-fsdevel+bounces-54166-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 855F4AFBB41
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 21:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC88F3BDA38
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 19:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4B626562D;
	Mon,  7 Jul 2025 19:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BykneT06"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D2E265606;
	Mon,  7 Jul 2025 19:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751915012; cv=fail; b=iZUfdzOWtpJo0ZFxJ6CM35Nt3ykjZ+Zsf3NAKSMfLR6o5u0FrblN+uvg2L3Fp6Gok6DMjwg5eWlQ9R5cKwvBwz3uYSHUHZGajDFtQdZm/6sLsaK7y1Z6/awUGGp/8YFIwtB0t0czhc2MLSweJxXsz+KNJJdQ6kN6XY9RQZjr0pk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751915012; c=relaxed/simple;
	bh=V2fZtDbAcxxRWBPwpUPLBaBE7YwHJSORrnOfjjHP4gA=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=ry1jM1XQyLf7m9r/K+22+Cz4n4SkHQb22Se1hAnTd8GKi8pdKaIMJpQ3/cXaSoEKXOkjg90XvH/9y3rWoNMmoJ2qxQAOeVdjmv/hs1Qe1yBr5AD2HpuEJqvaxUg9Taep1aJEaAdriuOhyGE97o/8tqItKqpYEI1sTzblvmjpJkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BykneT06; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5679f1Dw002270;
	Mon, 7 Jul 2025 19:03:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=V2fZtDbAcxxRWBPwpUPLBaBE7YwHJSORrnOfjjHP4gA=; b=BykneT06
	3oDxoTYYtQVRTETbz5SVN2DXafWT8sD6MbBUVa1KHDq8rw7YlMgZbPssL6WQLmV5
	oTEt/xqhQRrsUtm0kctZnZQcxOXNeuKdrS6X4aj92rpYTiomNaII2RaiCALUcvGa
	ihe/z94Yrjv3qDpBBFDphaefMqsOMlZAiO1UQF2PCMKnOkApYEhTKuYFqVBUkcUx
	fTS0OuyD+xalsb0vYHS51FjPSGWcLHVt1WitT1EVgO2vVIf7g4ubsKPG3VwJUndD
	S1VaSr7mgvYWGp68Ctj1BJrs6kUjBXxjzF46wgEXspV2emRPJ/mUWDA3yLSgx17C
	Vzq4VNdvGFQRAg==
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04on2055.outbound.protection.outlook.com [40.107.102.55])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47pur6uhvy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Jul 2025 19:03:20 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GinvYmuFsWuebwVntufPTT5/TPrDp9QQ4nWrpuRRUrLvwNrs4DWrh3hviiTSbMBxiMZsgtSQgmCVfcxghEQGcXxhqDbCci/P/x95iZgueElJxpA13cXwwZCnKGZLHIXNATdpS4cTm14yJ/VpWYrB3lxjGqfLI9Vvh+X5kBImdnaeWhpumRG1bu9LxHiYfV8kWX+Naxqew1+fbJzRehgXtiD7GES2QOuM6Fqw03LrbmqVX//fyMXHX8F7WbPBcVvoalYZihqCimVh2kIpz/u+JhldCsQqptdZ3LQc8ooV6ZxdvrWzl1QHhbAE0f04f+JUng7haNXC11FqErGUi1wivQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V2fZtDbAcxxRWBPwpUPLBaBE7YwHJSORrnOfjjHP4gA=;
 b=urxGeUM6AwI/u3QvwQu2t6DWqpn+GCJDkcyGQG/DAOqCd+wZlly+PFUm9GCQ13gX/Ij63UOHeE/dPI+bv7BT337FxXtm/UpplTS7opRmNtWBHWSccwv/mgUSsxXcYb5AAldFi65RLSh5Nk//Ho4s07ZuN8kx3kGyIPcrw3xfIwWt9wndCB/oxbtVHKgAzx+v+z16+rYL3cOTrjYnALzcp6tsXV0gleE9dh7RkJMNq7HZlYKHlBFcJ//uELugT1qQ6FHlkYFS7IiK+ppDe9NleEamF2bowtI3jPhRpzY35gZNTlZ6c03wB31DM+BxfAHoEmR/PboDZtEEgGzvld8IfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by BLAPR15MB3826.namprd15.prod.outlook.com (2603:10b6:208:272::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Mon, 7 Jul
 2025 19:03:18 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%7]) with mapi id 15.20.8880.026; Mon, 7 Jul 2025
 19:03:18 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "frank.li@vivo.com" <frank.li@vivo.com>,
        "glaubitz@physik.fu-berlin.de"
	<glaubitz@physik.fu-berlin.de>,
        "penguin-kernel@I-love.SAKURA.ne.jp"
	<penguin-kernel@I-love.SAKURA.ne.jp>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [PATCH] hfsplus: don't use BUG_ON() in
 hfsplus_create_attributes_file()
Thread-Index: AQHb70qjLuneU93t80+qPqT+jd4L9rQmvPcAgABIC4A=
Date: Mon, 7 Jul 2025 19:03:18 +0000
Message-ID: <127b250a6bb701c631bedf562b3ee71eeb55dc2c.camel@ibm.com>
References: <54358ab7-4525-48ba-a1e5-595f6b107cc6@I-love.SAKURA.ne.jp>
	 <4ce5a57c7b00bbd77d7ad6c23f0dcc55f99c3d1a.camel@ibm.com>
	 <72c9d0c2-773c-4508-9d2d-e24703ff26e1@vivo.com>
	 <427a9432-95a5-47a8-ba42-1631c6238486@I-love.SAKURA.ne.jp>
In-Reply-To: <427a9432-95a5-47a8-ba42-1631c6238486@I-love.SAKURA.ne.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|BLAPR15MB3826:EE_
x-ms-office365-filtering-correlation-id: fee08191-645a-49fb-1d0b-08ddbd88ef3c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?N2toNk1JOVBDR0xaalBoMGk2UFZRK2Q5am5kSElIT0NxVlRhcTJ4YnpWUU5s?=
 =?utf-8?B?SXBtVVM0andWenR4TERhdlp5T1V4N0tTZ3FieEIwQ01ZaStSMnRIWVFoTkp6?=
 =?utf-8?B?YXlUUlZuVVlGUXJyM2kzT2huSm5YbXk4SzkwTnFjcDg0dXRocTRYTFlZMytC?=
 =?utf-8?B?cHd3bzFNSXF2U0ZseTcwS1N6T0F1aXFyRTlzaFdXV0pxaFRMTlU4YSsyR2RJ?=
 =?utf-8?B?VXlOYW9sSmhVZ0xlRWl2YXY1Z2k1all5M0tweklhZmJoUWJLT2t5NTRXdE9h?=
 =?utf-8?B?dzErQk1Ycno5Yng0Z2tLR3Y3c0VNSUltMlYvK3ZnMktYa1RwYU9sMXY4bkIy?=
 =?utf-8?B?WW9oS1crdzF0WjFnb2E2dDZzQ3RSckFiWmpEQk5NdHZtSUExQXdNckM3cjVj?=
 =?utf-8?B?WHIzazZHblRNbWtVRzdJekwrMW9zdzAzbGRKUUg3OHlYVmJ2d2lhLzR2Y0Qw?=
 =?utf-8?B?QWZmNVg3OGwxMFNIMjIrZFQ3MnRxOEo2VVJ0Snh1SThiNFdjRnZWRnJ2OGxu?=
 =?utf-8?B?VERINnNJbDBoYnBySVBEdE9iekhTNUVDSU5RODRpM0lDMWEzMHRxKzBGUGFw?=
 =?utf-8?B?Ymk4WTJZNnBRWjJROWRXN3IyUFNDSjEyRzNubk5tR1c0MXRjeC9zRHZUeXM1?=
 =?utf-8?B?V2tKaWdFTnRqS3NlV0tvVEYycWlZN2ZBbU9FUTN2RGY5V0x4N08zWVo2RFRu?=
 =?utf-8?B?Qmg3bmNwbExnTE1VclR3SlpPVVNCL0JEVFVkUlhTVFoyZlNoclY3OG5SYVdQ?=
 =?utf-8?B?SXZxaGdZOGU5emxmSHI4YllnZkpDWWloQ09lOVF0eUhuV0R6Tm1CV2UxT3Rs?=
 =?utf-8?B?ckVJRmxoQ2tyMGoySEV2YWtzZUFuOFJFb2IvLzRZSDludnk2ZWVoZmMyRHdu?=
 =?utf-8?B?ejZnelN1cnZQcjkxTWdJZHhGMkI1bkpNZEswK3NNam1oSkdHLzZiTnF1OEhi?=
 =?utf-8?B?UlRoeUVuZml6Mm1sQ000d1VpUGhhcVh6R0JFM1VzWGNTSTQxUHpHdmpDUWtn?=
 =?utf-8?B?eUxEZ0Eva3g2K3V0TW1peUFwb0RtRDFWcUVOZFZzNGRjYjdHWTJJR1QyaVQ3?=
 =?utf-8?B?Y3lnZDBsbVlsdHl5MkFDWFhxUlByODNDVjlyYmI0ekxiSjJsc2NYVThYamVW?=
 =?utf-8?B?b1k2eWhKSDJiRkkweXhJMUlrWWVad0hialpER0NmQlRpMjhhb2lPL2RxcVNU?=
 =?utf-8?B?andDc2lTOWVyU01nelFvZEJzdlhKa21CVUxkQnMrdmRXODJaWXJSSXVPMGtH?=
 =?utf-8?B?MjByOEM0VFZlY2ViQldhYUZXeDF2a2JnNy80ekxoVS9ibDYxZHdpYjNZMElk?=
 =?utf-8?B?TzBLZ1VWT0kwRmhUZFA5dWdFTFBsZXNiMlhDdUxrTzQ3WWY1b3VLS0owWDZF?=
 =?utf-8?B?bEJIOUU0M2tDc04xditjeVV0MjV3cTNYMEhxV1RyeDE2ajQzUjFTYzQrNGpl?=
 =?utf-8?B?eklIYzBzR2RRMmVlZC9lUmM0akxROGdMVTFuTnJUcTg4a0h1NE16YkpnWFBu?=
 =?utf-8?B?TXljaUw1aUxYUXVXR2xxMVVpZGtLeUsra1lYdEJlZzJkR0h6MDdFV05nZmFI?=
 =?utf-8?B?TVJmM1VaMmR4RWtXazVqRHJQMGlTWWZPc2M2WXFvK2F5WEVHc2IvNGhtcFI3?=
 =?utf-8?B?UEJSSGx0aXdMNFlyNXZnZzF3dWw2ZTllQnlMd2k3SEoxeXIxTGxOaHo5Z3ln?=
 =?utf-8?B?OXdQV1UraEN5Qk1kQjZkdHk0WjVUMjkzQ1RRTW43dmRPNVdra3VpalVSdWMr?=
 =?utf-8?B?cG42VUVWdU5NRFNXSHF4bDVFTTdYSDFtUG9mQkxLZC9JL2RabTE2QVIvMTBW?=
 =?utf-8?B?WHBYSEU5Wk1LMit1Y0VERkhZdW5uNjhEdXN6Vzl3NXAwZXJPTlBRNU9SQ2p5?=
 =?utf-8?B?MzNCZVpQL3cvek8vMm56UzhOTXhiajcxbFpLTklFZi92OVZMNHoya0FSdXp3?=
 =?utf-8?B?cE5TcXFtdXBmSFZLMzZUMUI1VVFOSUhaalVwajhJK05INWRNYzNDK2NuNVU2?=
 =?utf-8?B?NGhoZ3JVMVBBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NWRid1BhbzMza1dBZ1RobnB2ZXRiWUxsa0pvWDBpVWhML3E3WmdlbUZRK1Ix?=
 =?utf-8?B?T05YdnBadHMxelZ6UHpGQzNhYjh4Z2VkejJ3TUFhcmxXUkUwcG93VkxVTTJK?=
 =?utf-8?B?ZHRGRGU5Q3ZZUDBiWU90enMwQUVtQUM4NHlhTW1kZlc2UkNsbXZjNExyNWtm?=
 =?utf-8?B?VWZ2K0p1L3RyUmYxUGIvK2VTb01ReDIyNGR1eDk4QUUxMjB5NW0zM0QyU3M1?=
 =?utf-8?B?UFpEYnBkeEV5bzM0bUp6TkswREF6S3BNTDVFVEx4QWZQWkZsS0ZjLzVjaFN6?=
 =?utf-8?B?QzdzNUJrYjl1Y3RLdXhYaHdxUE5nZ2lCaFIyZmxXekVZamFuUFUyYTVtVWkx?=
 =?utf-8?B?dGxZTmRDcDA3c2lzUXhING5tMWxLK2JtS09icG5paEQ5SXFuaC9qMThTNElL?=
 =?utf-8?B?VG9objF0aEluVWtqVFJJMy8wZXpFZkFjcFE1Mnh6UVVaS3hrUkRPSFJKaFp0?=
 =?utf-8?B?VThqQXFTVTFhVW1NT1VSc3dsMktLOVY1MWdCcVVPaHRobXJRd2UrZlY0U08v?=
 =?utf-8?B?eE5INFVDQmt4VmNycWcySTYvekt3WmpVVHRnMGNBb3J4K1lWQVc2MVAvazlR?=
 =?utf-8?B?NlFRZ1hpTGhXK3NlUUdJTVFJTUcvRnlXRVVrNDBsVjNVZ0pZTWtGVXBDRE1k?=
 =?utf-8?B?QysxUGZGdW1kQnZqbENNRnVjTFArK3ZEdkJEZzQyRmtGYWozSGx2RXFoWXpT?=
 =?utf-8?B?RzhEVW9CQ1NjKzlqakZFR0VSNzdhUEtGNTBNNXN2MFFZWnppdHdxOENqOW9U?=
 =?utf-8?B?Y2h0Y1dWdWV2dkExNnE3VXFTb2VtbmZldnhIRXRWbUlHb1EzbTVNbjFEamRp?=
 =?utf-8?B?SjZVWE9lYXNPVU1IVmFYWU5iSmo5dFFhU3hFbzlOUFNrUmlHeHlSL1hWcERv?=
 =?utf-8?B?Wk9TVlpoWnZYMTR6M3BBYVQxUGNGNHd1MkFtRThicll0MVVDdWw1cW5OUnU3?=
 =?utf-8?B?QkQzNnlpNUlNdVZpaXQ0dG9oZEFLeml6b1FZUVZKTWU4TEVKUE1Xa0F2K3Vv?=
 =?utf-8?B?aUIrRmVwRWprLytNSHhZS0FOT3FZVDdMc3pNWk9MMkE1TjVKTVp0Wm1rMk9V?=
 =?utf-8?B?MHVsbnp4V1NnQmt4c1VGSkpKL3BSelg0ZlZ2cVAvaXdtVG9qMEo0OXZKTWF6?=
 =?utf-8?B?U1JCalM2TXpkdFJMd29Mbk5xQVk3UG9ZMEwrYXByTHUra1lRZVB4b0tpUlhx?=
 =?utf-8?B?Y0ViakZuUFNEQkl2R1QyODlPTUpWMjNrLzkwVmJkSW9Ed2FQdWRPRmc4b3Nl?=
 =?utf-8?B?cm5FaDJ1R2p5MGxycitsWXMyVjdaUS9DWGN0UXBQc0xXOEtzMDRJRnRLZVpF?=
 =?utf-8?B?UmQ2YUI0T2gzQTFaTVpITkVMekpjemdCeG1VY3JCUW14NUxPV0RUdWVBVW93?=
 =?utf-8?B?YUhDbUovTkdxNEZuRmNsSldmMG94d1NQUHlOdklQd2dXMkJ4VGFtLzNweG9U?=
 =?utf-8?B?REFTZWUrdnYvUEd1SHF0aUJMS041anlpZ2ZRUU5URWRHSDQ0ZzFDbzhiUG5G?=
 =?utf-8?B?Wm90aXliNmVheDRlQklIMU90SzQwN09WaVNUNmlRUC9TN3lQMG15NnlpWWV3?=
 =?utf-8?B?TlVFSEFxYjVVYWtpS0JOb3FEQ21uZ1dTL2hXR282aGRjUjVXeGpaeHNpQ0pY?=
 =?utf-8?B?S0FteW9HU1RMOW1uMXVDTTVyeTJhenVBaTdRWFR5ejZGS2l6MzZ5bFU3SXJV?=
 =?utf-8?B?blErWEtkZWFhOGhGdldvbjhpeVFteVhqTjlyK3p3NlAyYXMyYWc1YUdYM3ov?=
 =?utf-8?B?YlEyUnhNd2ZLZ0ozZDNYWVVNVjNLdXVNTWliUTd1eEIzbTM1UEFCSnpqaFpH?=
 =?utf-8?B?Z2JkSXE0ZVRiMXFRdVNzOUxKMzBESyt1eW0rOStEemUzZGViV2VITXpndlIw?=
 =?utf-8?B?ZGdyeHhId1hXRy9PYlBWaDlaTFppNHlhVHJSSGpjZms2S1hkM1FFMTZRNTh4?=
 =?utf-8?B?UUwyaTI4TVQ1cEpzYkxJU0E2NFNJWW5iaFBHWm9mYTJWYWZibGF0TVpLekEz?=
 =?utf-8?B?c21zR1pSUU45NC8wUG1Gcy8yMTFPU1JFczdLaDhNSWRrYUZFRHNndzZNNTBE?=
 =?utf-8?B?dzNvNVNITk94azFUbmpzdUlCNkkyZndJcVRuQnR4VTRQV0k2S0xhd0VIdG12?=
 =?utf-8?B?d2xENjBGYWIxZ3RqUkdIbk1lS2xSem9tbXkzQ3laWnpMQ3k5RWpuczRUZ3dY?=
 =?utf-8?B?WWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <663E3DBFFD48E646B1548A65615628ED@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fee08191-645a-49fb-1d0b-08ddbd88ef3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2025 19:03:18.2900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gpNz++SAvJ5WwjL99r9dzDu9PAzL5p5eqBABGU3IitaABRfnnNrl94xUvwJWuaZiDNkkW3LLLNGRxg6qgLYQtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR15MB3826
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA3MDEyNCBTYWx0ZWRfX6Ofhs9swE/0t Kx9tMGxQq/g0eHK0KgS1ytRDUDM91P+UvIx76hCUQbiGw6DmkYtiVhSKtDKlU6DgOnRihxfirm1 iu1l63iBEGSGIVZ9qUSe7dTKxfN34OLsWyTAJt93u57Kjzk+ZnmOJ13PFQTpO4XmvlsBLVsmdyN
 C5Hcp1M+bQc5Arp9KL4Hvxh3RgkYbBO7k/He/fTKgEwsOxWjcpSqOmI3XdY6atv14BTH52YOsku f3h1b1y0ejSkDTD4Kqc/edTCRxz+5qzp0JOvMGYtbfnVk+2Z1o4NB8o5jn6zPKVvc4LGer8X+4H 6Lr6kMU8xbgw2bo6PK5oRR4sYkNqsHzNatJYmzOgR7QcpNkYMNSobBnMISy36Bz42fBPVkwNMGx
 RUa37jPnPpzet5ry4DzJuPK8OR449Wq52DJp3xMhF9zCBigxxZEz5hWajmGnAT2TZQZv1kQW
X-Proofpoint-GUID: bHSZRS4_faNPEJkhfpbLg9nnsRW7nXws
X-Proofpoint-ORIG-GUID: bHSZRS4_faNPEJkhfpbLg9nnsRW7nXws
X-Authority-Analysis: v=2.4 cv=W/M4VQWk c=1 sm=1 tr=0 ts=686c19f9 cx=c_pps a=IWGGpllXFVmBSEOUyijQVw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=_kF5oYEJbIdwgmUmGvgA:9 a=QEXdDO2ut3YA:10
Subject: RE: [PATCH] hfsplus: don't use BUG_ON() in hfsplus_create_attributes_file()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-07_04,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 mlxscore=0 priorityscore=1501 adultscore=0 clxscore=1015 suspectscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=964 bulkscore=0 impostorscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507070124

T24gTW9uLCAyMDI1LTA3LTA3IGF0IDIzOjQ1ICswOTAwLCBUZXRzdW8gSGFuZGEgd3JvdGU6DQo+
IE9uIDIwMjUvMDcvMDcgMjM6MjIsIFlhbmd0YW8gTGkgd3JvdGU6DQo+ID4gMTYxICAgICAgICAg
Y2FzZSBIRlNQTFVTX1ZBTElEX0FUVFJfVFJFRToNCj4gPiAxNjIgICAgICAgICAgICAgICAgIHJl
dHVybiAwOw0KPiA+IDE2MyAgICAgICAgIGNhc2UgSEZTUExVU19GQUlMRURfQVRUUl9UUkVFOg0K
PiA+IDE2NCAgICAgICAgICAgICAgICAgcmV0dXJuIC1FT1BOT1RTVVBQOw0KPiA+IDE2NSAgICAg
ICAgIGRlZmF1bHQ6DQo+ID4gMTY2ICAgICAgICAgICAgICAgICBCVUcoKTsNCj4gPiAxNjcgICAg
ICAgICB9DQo+ID4gDQo+ID4gSSBoYXZlbid0IGRlbHZlZCBpbnRvIHRoZSBpbXBsZW1lbnRhdGlv
biBkZXRhaWxzIG9mIHhhdHRyIHlldCwgYnV0DQo+ID4gdGhlcmUgaXMgYSBidWcgaW4gdGhpcyBm
dW5jdGlvbi4gSXQgc2VlbXMgdGhhdCB3ZSBzaG91bGQgY29udmVydA0KPiA+IHRoZSBidWcgdG8g
cmV0dXJuIEVJTyBpbiBhbm90aGVyIHBhdGNoPw0KPiANCj4gSSBkb24ndCB0aGluayB0aGlzIEJV
RygpIGlzIHRyaWdnZXJhYmxlLiBhdHRyX3RyZWVfc3RhdGUgaXMgYW4gYXRvbWljX3QNCj4gd2hp
Y2ggY2FuIHRha2Ugb25seSBvbmUgb2YgSEZTUExVU19FTVBUWV9BVFRSX1RSRUUsIEhGU1BMVVNf
VkFMSURfQVRUUl9UUkVFLA0KPiBIRlNQTFVTX0ZBSUxFRF9BVFRSX1RSRUUgb3IgSEZTUExVU19D
UkVBVElOR19BVFRSX1RSRUUuDQoNCkl0J3MgY29tcGxldGVseSBjb3JyZWN0IGNvbmNsdXNpb24u
IFRoZSBnb2FsIG9mIHRoaXMgQlVHKCkgc2ltcGx5IHRvIHRyaWdnZXIgdGhlDQpjcmFzaCBpZiBz
b21lYm9keSB3aWxsIGNoYW5nZSB0aGUgc2V0IG9mIHBvc3NpYmxlIHN0YXRlcyBvZiBhdHRyX3Ry
ZWVfc3RhdGUuIEJ1dA0KdGhpcyBsb2dpYyB3aWxsIG5vdCBiZSByZXdvcmtlZC4NCg0KPj4gQEAg
LTE3Miw3ICsxNzIsMTEgQEAgc3RhdGljIGludCBoZnNwbHVzX2NyZWF0ZV9hdHRyaWJ1dGVzX2Zp
bGUoc3RydWN0DQpzdXBlcl9ibG9jayAqc2IpDQo+PiAgIAkJcmV0dXJuIFBUUl9FUlIoYXR0cl9m
aWxlKTsNCj4+ICAgCX0NCj4+ICANCj4+IC0JQlVHX09OKGlfc2l6ZV9yZWFkKGF0dHJfZmlsZSkg
IT0gMCk7DQoNCkJ1dCBJIHN0aWxsIHdvcnJ5IGFib3V0IGlfc2l6ZV9yZWFkKGF0dHJfZmlsZSku
IEhvdyB0aGlzIHNpemUgY291bGQgYmUgbm90IHplcm8NCmR1cmluZyBoZnNwbHVzX2NyZWF0ZV9h
dHRyaWJ1dGVzX2ZpbGUoKSBjYWxsPw0KDQpUaGFua3MsDQpTbGF2YS4NCg==

