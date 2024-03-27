Return-Path: <linux-fsdevel+bounces-15386-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F7488D9BE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 10:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A78D61C25A0C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 09:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA00364D6;
	Wed, 27 Mar 2024 09:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="geyEDgAZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DFB36138
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Mar 2024 09:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711530264; cv=fail; b=WHbnQqzXIGCflgUI3sfyQj0ULsrKS4fhaHfplFADOF3Q7Hg61wc7puFHFYO/1j5ihDT8ehYhZ7sV+qNTmkwRSnrtOFmDg7hoMi9Gknmbe5RTTKn7hC4fbby6w1mpQPpap631eL/6M5AauZ26KW9gUajqfbwCjqdKqPk+jaRxhuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711530264; c=relaxed/simple;
	bh=sozqAX2Uwoi0iTIh0IRYSCDxkr3asdqFJ27naGMlPv4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kJ2UFyhzpJqhmVytBdQe44JZ3Oj244b5MaJEI37D5zdvfOjI0KRwqNPdyC3gD37IBxlNIX8XmIagHsteJX3EVPecZInAuW52wrkdfdtACbh3SeE+wrsCVKoEvjG8OX6UpCwR9rdI+/GUKOqnxgSHArXf34k1VlKeMGVsPYzjEcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=geyEDgAZ; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209323.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42R44iLr006414;
	Wed, 27 Mar 2024 09:03:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=S1;
 bh=rvtDXlK8+M00iqNrqZA6TTFSF6QARt3lWVlxnOJwJIs=;
 b=geyEDgAZ2prp3Zkx9ynlvAtsXRkRIOZ+etwr/O9TDnWyVSZZH4rWN/NHwYHH80djqvwb
 Sn3LOa9NMuj5XSGrv4T+d9DWIaOp8yKiEaUzbhYA21xAuvq1aqhWfAl47BP6wUOT9Mxa
 lAhx8w892qAQ68Yz1xHPT+UnKuWiTyQM+vNU0Zm2hZfhEdhujEyUZx+uhWDpb6VBop7R
 0lCGVlLPQrpiWQW2fJWvOXAmQD+SCJj3J1IhBBYxPZttYxahOchTpaEljZzlla+a9pbw
 H4oVxnR4UmBxMgqLbH9pz8yAD5wu3EEoRC68Nt0ynGJfQvzewzm0yUeUhUuIigkKih0U 1A== 
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2040.outbound.protection.outlook.com [104.47.26.40])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3x1pe2kxw2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Mar 2024 09:03:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ItXrMUw5YLToWLBF84XWNPby4pFg0ZBlz8YW6gia92Ywbd+OFsZ2/dEGgUhg5GibWD20fliO0CDbfDqM1BHmjEHY9CuYjfzKSBgnJ8bR+RwSnJor/YHpagxFepeaZLOcbo1W+5lEXtu6OD6Ns8+soKSuyXkSW2FcKIc+qnnEuZ0R6MuYHhitOXeQ43eVOvCh7WRMu8ET05tuUuiww6bVlwZKpEuG4kucIEFhF7SGUmg428WPiqM0OQLKo3BbzUDRcjjYeheeX8/cT59BaglchoDBZQHAF46QCwSxorqCPnXJiyldQSk8lvlmFhqzbSFTQDMaL1NvCC24eAhAXFRhqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rvtDXlK8+M00iqNrqZA6TTFSF6QARt3lWVlxnOJwJIs=;
 b=JCtjj8YdlQJ/zDJr1YYl5Zv4dATVyHu4t9PntQHmDxke48w0BxNWNM7Q7mVLO/YKgW0JZUB8nvUEAyTxCBQSludV3bMTry+w9YGOvdQn/vslk6nrjI5YFGb+a/9+P/i3aufwSTmoEG0vB9SwVRwZOqKHYYzuYfoTT0T4CUKIsJ9WTV3qpM+m0oKh80Zv+TYqRoZIot0rCqvE6n/5/I9oiPIuG/pGmb1FujWyrTeqLNFIvvj9GCeoH3nv6W8yS7qg9lMTJOONz2t6OYhaAMK228yKmurHMDuofdJuhP9VJi8uzNaWngbwJ854dR83HrAT3Vjb6Sb5QYZBPbNBh8zQuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by JH0PR04MB7058.apcprd04.prod.outlook.com (2603:1096:990:38::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Wed, 27 Mar
 2024 09:03:47 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::b59d:42cd:35d:351e]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::b59d:42cd:35d:351e%4]) with mapi id 15.20.7409.031; Wed, 27 Mar 2024
 09:03:47 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com"
	<Wataru.Aoyama@sony.com>
Subject: [PATCH v1] exfat: fix timing of synchronizing bitmap and inode
Thread-Topic: [PATCH v1] exfat: fix timing of synchronizing bitmap and inode
Thread-Index: AQHagCUhy5AEis88KUSAmZ0ptvY6Cg==
Date: Wed, 27 Mar 2024 09:03:47 +0000
Message-ID: 
 <PUZPR04MB6316DBBB2B99C8BA141EF48781342@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|JH0PR04MB7058:EE_
x-ms-office365-filtering-correlation-id: 175fe624-6acd-41d0-776d-08dc4e3ccfe0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 i5vSv7MX3mnUZIW8fqlK1c2fSbs+pYQf2119RDSvwrwgjP4RhM6C2i/K/bvUBmg4eV9QU03Vw5kKQIzLyXcMTOgvKjicLNNwyBQh/xRblGbQacOjkb9TBlL+cpAAHFaLvzBINfzZZ7gdPZldhFnW0kV30fyJpNENaYXPrG1QCdd258i8MqnFiuPB/dbn0WHXb0fGY/i7gO1ji9bvsLFdUD8trXHYrccaEuTCbVThL8E3/ZHQRlZz6FUmqkCg5fVWQUxUGtR4FwPtPxv8COdh92tSwxYL2fdZ6OxdJG+hCrjuS2jyQzfLTit13fiSLLQgr/RksNog+mK/lUfKPCmg90PlZVHsPFHu80A+ZVSXPOCYpNRI7oVNT3IjN1kvAcRcaQcMirtmiKgJOHU4vDp+ZELxXbHfOBEQx1MuO5U1yLlYeefpVKRjT79Hdc7sP5Fxh3CTwnuxQz67eP6oYuV3mEKuk4m09/a1BWRBUjtT7Aph7LxcyIoVN6r7o/fSDOOy4bMU86NqlBDbtNseFyOdkyr+AiX6GcyQCm2lDtkSqieFYy4my/9DtdbgaV4euqfsjXQMXbPy9PJillKg9814d0Xgiubxfr4B0EhA3vSSqui+YujRJ9NaUgHA/YI0h0fOcqsbubtUQBseQUFYppfEOgA9SG09Ggmmse6YhRbuBILbxscPS3+Gn6rywwq5uCJqJG2vE/dvi0oD1z83Qyn8mw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?gb2312?B?ZUxGMzdWN2ZTMjBaaGZONmVjbU9xdXB0Qy91VFhrM2tYaDluTnlVVzlqNU1k?=
 =?gb2312?B?dm1yRVdreXhXWWZhSHQ0dXM4UWxTb2JWSTFieC9lZDlKUEtZM1NBZWtsU25E?=
 =?gb2312?B?UFNON1RleUhCSnpmZi9pTys2UlkwbVc4d3dvdmwrdUdDSkJBVU9mT0owdFFv?=
 =?gb2312?B?bktCaXFwdG5UUFJFcC9PUE5SUDVSQzBNR2xIQk8yZ2RucG90bkNQREk5eEp3?=
 =?gb2312?B?TWQ4dmFUQjB0V1E5ZTdVaStWVFdWVzdoaEdRSWk4VEpCVEpocHcxN3hWMFlX?=
 =?gb2312?B?Q3RTYXZqSWtOT3Jnbzd4eTIzUk93VmVab2tBR0p1Z0x5WjgzNWFQZ3pobzQz?=
 =?gb2312?B?ZE1DZWpHcE1FUlBLK3pGdHVld09HTnlyZkU1NmU5bGFYNG1venRnKzhOV2xJ?=
 =?gb2312?B?YmU3Vi9rUS9BUTVZY3liYzByT1BqY25VMWhHelFDS0EweDhIR04veXZ2VlZ6?=
 =?gb2312?B?WmFyRnI1cXlYT2l4dmtMTFc2Z1ZuTHltVjA3NGYxQ2NBd0U3cVZpOVF4OWdW?=
 =?gb2312?B?aUdQSzVSeWxaRThRY0x5YlNhSDdnVWJ1ZWRQM29ETnJ2dzJrTjQvVk9kWGpo?=
 =?gb2312?B?Nms5Z1pvTEhrMXlITjBUTG50WGxiTitaMXNFL09DMjVyUE5lUW9SV21OYlR3?=
 =?gb2312?B?R2F5OXM1dS9BZWFMNnQ2UWVSZm5EeFZOTkVENk9ZYlJwb2IyTHVyc1B3Wms3?=
 =?gb2312?B?anNocGtHYzlJUlRyVDR1bkRkY1lqTmtoaERWSnFKem4yUmgzOVljWGdaVi9M?=
 =?gb2312?B?eDYxYVNEVmVhQm9FaEl3cXhlNlphVWhFUFoxTzlwTis5dXhHcXNQVUdvcTdp?=
 =?gb2312?B?NzRncHhPQ1lMUndQMWJuR3d2dGw3WU5YVUpRakd6NHJMdzUwU0lPZUJ2UDZB?=
 =?gb2312?B?MEp4eTVibzFIQ2h1T2lKMVBzN1NhWHVFcWhCdWxnK29xK0xwTjFaSDZoS2lU?=
 =?gb2312?B?R1B1dTBKV3M5UUdnM0JPc2EvY1JTazQ2ZUIvREgvYWR1UVBLNUVoejVKOWQ3?=
 =?gb2312?B?YWJLajUxd3MrQlJ4bm8yTFZQenJMMEVaeHZ6SzAwbWFHVXdKb3NWQnI5NmNw?=
 =?gb2312?B?N3BZcmhBUEVVS2NZT05IdnZ5dVZwUzNwUHVlWm9GaXV2Q1RKUThFNHY5Y3dW?=
 =?gb2312?B?TEVFWDg5Q0M3WWo3UlZFT1c2R1QzRS9YaFMwaCtXWWJKR0x3V3FzWlFvQ2xV?=
 =?gb2312?B?TDRpUjMzdzF3MTM4Wk5ZTWdXK24rZ2ZSYThVZDZFTGtxUkJCc1dCNTA1WTdj?=
 =?gb2312?B?TGZVR2NwWXVRakZvelVZaHlFaE9TY25qQmJxbnNYRjhpazgwOFJLNEc3a1pH?=
 =?gb2312?B?UDNHQ0gxR0xNcEZhQWVYb2VSNnY0cVJ4V3E3VHVlaE1uOG90c3VKK1Y1anIw?=
 =?gb2312?B?UmNTTDcyaFBCM0t2YzJVYTdqd0xpVGVDL05INVZmaXZQRmJKcTB3b2lvR0Iw?=
 =?gb2312?B?dUNXYlFqZHM3cnFiZUQxcDRWbWJnM21DWnNkUTVyTktKbjJYUnJ1SWcxUFoz?=
 =?gb2312?B?eTdmSW4yKzE1V2NZOWJXMzZzbktneWJHVUdOMDY1VGlMMGNmSldNdDVlVUJn?=
 =?gb2312?B?aUlMdHJmZjhhbE40QjgzUG1QNHY4THI3c2VGZzBaTnJGbUd3U2pXVStCNVlQ?=
 =?gb2312?B?enZHZVpqL1QwejhaZWlQR1BTa0NJNytEYUtteTlCZk1DYmRrUDlHUVVmUHhW?=
 =?gb2312?B?R1ZKR1Bza0cwQ3M4OFE2WGpqWGJrSDd2L09WUDRVdU5qNFc3dlVHaHkwcjJi?=
 =?gb2312?B?M01ENGxvckVpOXd1cUNNcVBBYlEzZng4RThlVkR4L3VxekVGcmY5UGQya3lY?=
 =?gb2312?B?azNmWldIK2xJOWNxK0xOKzkyakNIcHVZZXZvelpJSk1qVWFQMGlqZFhjSzlW?=
 =?gb2312?B?WDhqNUxDekdwZHZMNmdzYjk4UVpRQktnRFNValBuVU5iM0JMakdhZ0RIak5S?=
 =?gb2312?B?QWFpWW1LaTBPOTl4M3VxY3dIOVR0OUFRdTlLSHB6MDVucWUxck11SzNRazR5?=
 =?gb2312?B?bzFJaStRTEhpRGlGOVV2THZwRHIvaXF1YXhGYlBROCs1djVkY21peFg1TzlK?=
 =?gb2312?B?aGhYSTM3UCt2eGJ4MW50RHhockdKQ2tlUDV4ekY3SGU2MjZQY214bU5kdDNv?=
 =?gb2312?B?OE1YMDBwTE1RNmR5Wjk3c2RCMmpYRzgvMUs1QlBYVkZpY0lGZm1yRDVLSnVK?=
 =?gb2312?Q?ne3FoTiXBxEkc+VQQYVdLWM=3D?=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	XOmTtbp3u9Cf7CmoucxyFmvnca4a3fPulPFDt6egbJ8NdmEBCVBCHtawMSyurWp1hsLO3zGZZorEd1+ABDKa8p/XolTmBw8miBcy02yPLCEwWTK3iUJXF22DbTJ2ekUi523d7+S0+trZcyTLa8Sr7zNQb3Jx2+D8xIqL572y7/WBRISUnDpqf5+DQXm4OqQvGbxKUKtzypHajfe3eX1LYaRJYHBNpPyWRhA9bffv9A8NqTkV/fzxeNRGOqCL4JA67/RBted0IbtfG05Di66xHGzpL4JoDJPY/f/G1YyNJUcXo0rSQnf2bWBWYrpqQy8950yjfSIONfWB2niQWjOoaikIYH5AZvFclm5+qDg4PdEAdUsUXwpQp6Mzw7ugYLTs5u7HCg+a3vMEjSTryBChYcvTojdmijNr9jPDSehCKmyX7JSXxRzqRQrZxYS71DgFOdEEoTU0I5atWwdbJXMsy875NIWvjZAUaFJgpJ6BbvAdbLnWD3QGURnYszR2XYL6mxiVbgtHz0TW/WK5Sj4NoJMzi7Dyyhgy8qKqgZF41FeL+H2XCxwvASPGIvleC+GazxegFyXgATniw4sf5x0tpK1Nb7xNzt44VSAVlXYgZt44fheSG6fratiK+eZDlLMt
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 175fe624-6acd-41d0-776d-08dc4e3ccfe0
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2024 09:03:47.2190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZYZpxTrtITQT6eNGDwNZOFzpf8dmBXjd0QbK+Ywca7VQXx2Ja7guSyZEapShdlPlR15zfnwZG0JQ57YNRnQcWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR04MB7058
X-Proofpoint-ORIG-GUID: vHsHsNLfPIDKd7gd_-WkQfqKgpM4wxtk
X-Proofpoint-GUID: vHsHsNLfPIDKd7gd_-WkQfqKgpM4wxtk
Content-Type: multipart/mixed;	boundary="_002_PUZPR04MB6316DBBB2B99C8BA141EF48781342PUZPR04MB6316apcp_"
X-Sony-Outbound-GUID: vHsHsNLfPIDKd7gd_-WkQfqKgpM4wxtk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-27_05,2024-03-21_02,2023-05-22_02

--_002_PUZPR04MB6316DBBB2B99C8BA141EF48781342PUZPR04MB6316apcp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

Q29tbWl0KGY1NWMwOTZmNjJmMSBleGZhdDogZG8gbm90IHplcm8gdGhlIGV4dGVuZGVkIHBhcnQp
IGNoYW5nZWQKdGhlIHRpbWluZyBvZiBzeW5jaHJvbml6aW5nIGJpdG1hcCBhbmQgaW5vZGUgaW4g
ZXhmYXRfY29udF9leHBhbmQoKS4KVGhlIGNoYW5nZSBjYXVzZWQgeGZzdGVzdHMgZ2VuZXJpYy8w
MTMgdG8gZmFpbCBpZiAnZGlyc3luYycgb3IgJ3N5bmMnCmlzIGVuYWJsZWQuIFNvIHRoaXMgY29t
bWl0IHJlc3RvcmVzIHRoZSB0aW1pbmcuCgpGaXhlczogZjU1YzA5NmY2MmYxICgiZXhmYXQ6IGRv
IG5vdCB6ZXJvIHRoZSBleHRlbmRlZCBwYXJ0IikKU2lnbmVkLW9mZi1ieTogWXVlemhhbmcgTW8g
PFl1ZXpoYW5nLk1vQHNvbnkuY29tPgotLS0KIGZzL2V4ZmF0L2ZpbGUuYyB8IDcgKysrLS0tLQog
MSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9mcy9leGZhdC9maWxlLmMgYi9mcy9leGZhdC9maWxlLmMKaW5kZXggNDBhYTEzNGFkNGNi
Li5lMDY3YTgyZWM2MmEgMTAwNjQ0Ci0tLSBhL2ZzL2V4ZmF0L2ZpbGUuYworKysgYi9mcy9leGZh
dC9maWxlLmMKQEAgLTUxLDcgKzUxLDcgQEAgc3RhdGljIGludCBleGZhdF9jb250X2V4cGFuZChz
dHJ1Y3QgaW5vZGUgKmlub2RlLCBsb2ZmX3Qgc2l6ZSkKIAljbHUuZmxhZ3MgPSBlaS0+ZmxhZ3M7
CiAKIAlyZXQgPSBleGZhdF9hbGxvY19jbHVzdGVyKGlub2RlLCBuZXdfbnVtX2NsdXN0ZXJzIC0g
bnVtX2NsdXN0ZXJzLAotCQkJJmNsdSwgSVNfRElSU1lOQyhpbm9kZSkpOworCQkJJmNsdSwgaW5v
ZGVfbmVlZHNfc3luYyhpbm9kZSkpOwogCWlmIChyZXQpCiAJCXJldHVybiByZXQ7CiAKQEAgLTc1
LDEyICs3NSwxMSBAQCBzdGF0aWMgaW50IGV4ZmF0X2NvbnRfZXhwYW5kKHN0cnVjdCBpbm9kZSAq
aW5vZGUsIGxvZmZfdCBzaXplKQogCWlfc2l6ZV93cml0ZShpbm9kZSwgc2l6ZSk7CiAKIAlpbm9k
ZS0+aV9ibG9ja3MgPSByb3VuZF91cChzaXplLCBzYmktPmNsdXN0ZXJfc2l6ZSkgPj4gOTsKKwlt
YXJrX2lub2RlX2RpcnR5KGlub2RlKTsKIAotCWlmIChJU19ESVJTWU5DKGlub2RlKSkKKwlpZiAo
SVNfU1lOQyhpbm9kZSkpCiAJCXJldHVybiB3cml0ZV9pbm9kZV9ub3coaW5vZGUsIDEpOwogCi0J
bWFya19pbm9kZV9kaXJ0eShpbm9kZSk7Ci0KIAlyZXR1cm4gMDsKIAogZnJlZV9jbHU6Ci0tIAoy
LjM0LjEK

--_002_PUZPR04MB6316DBBB2B99C8BA141EF48781342PUZPR04MB6316apcp_
Content-Type: text/x-patch;
	name="v1-0001-exfat-fix-timing-of-synchronizing-bitmap-and-inod.patch"
Content-Description: 
 v1-0001-exfat-fix-timing-of-synchronizing-bitmap-and-inod.patch
Content-Disposition: attachment;
	filename="v1-0001-exfat-fix-timing-of-synchronizing-bitmap-and-inod.patch";
	size=1427; creation-date="Wed, 27 Mar 2024 09:02:09 GMT";
	modification-date="Wed, 27 Mar 2024 09:02:09 GMT"
Content-Transfer-Encoding: base64

RnJvbSBjMTU1YmRhMGJhMTg5YjNkMmJmODczZTY0MDg2YjIzYTA3Yzc4YWM0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBZdWV6aGFuZyBNbyA8WXVlemhhbmcuTW9Ac29ueS5jb20+CkRh
dGU6IEZyaSwgMjIgTWFyIDIwMjQgMTc6NTI6MTkgKzA4MDAKU3ViamVjdDogW1BBVENIIHYxXSBl
eGZhdDogZml4IHRpbWluZyBvZiBzeW5jaHJvbml6aW5nIGJpdG1hcCBhbmQgaW5vZGUKCkNvbW1p
dChmNTVjMDk2ZjYyZjEgZXhmYXQ6IGRvIG5vdCB6ZXJvIHRoZSBleHRlbmRlZCBwYXJ0KSBjaGFu
Z2VkCnRoZSB0aW1pbmcgb2Ygc3luY2hyb25pemluZyBiaXRtYXAgYW5kIGlub2RlIGluIGV4ZmF0
X2NvbnRfZXhwYW5kKCkuClRoZSBjaGFuZ2UgY2F1c2VkIHhmc3Rlc3RzIGdlbmVyaWMvMDEzIHRv
IGZhaWwgaWYgJ2RpcnN5bmMnIG9yICdzeW5jJwppcyBlbmFibGVkLiBTbyB0aGlzIGNvbW1pdCBy
ZXN0b3JlcyB0aGUgdGltaW5nLgoKRml4ZXM6IGY1NWMwOTZmNjJmMSAoImV4ZmF0OiBkbyBub3Qg
emVybyB0aGUgZXh0ZW5kZWQgcGFydCIpClNpZ25lZC1vZmYtYnk6IFl1ZXpoYW5nIE1vIDxZdWV6
aGFuZy5Nb0Bzb255LmNvbT4KLS0tCiBmcy9leGZhdC9maWxlLmMgfCA3ICsrKy0tLS0KIDEgZmls
ZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
ZnMvZXhmYXQvZmlsZS5jIGIvZnMvZXhmYXQvZmlsZS5jCmluZGV4IDQwYWExMzRhZDRjYi4uZTA2
N2E4MmVjNjJhIDEwMDY0NAotLS0gYS9mcy9leGZhdC9maWxlLmMKKysrIGIvZnMvZXhmYXQvZmls
ZS5jCkBAIC01MSw3ICs1MSw3IEBAIHN0YXRpYyBpbnQgZXhmYXRfY29udF9leHBhbmQoc3RydWN0
IGlub2RlICppbm9kZSwgbG9mZl90IHNpemUpCiAJY2x1LmZsYWdzID0gZWktPmZsYWdzOwogCiAJ
cmV0ID0gZXhmYXRfYWxsb2NfY2x1c3Rlcihpbm9kZSwgbmV3X251bV9jbHVzdGVycyAtIG51bV9j
bHVzdGVycywKLQkJCSZjbHUsIElTX0RJUlNZTkMoaW5vZGUpKTsKKwkJCSZjbHUsIGlub2RlX25l
ZWRzX3N5bmMoaW5vZGUpKTsKIAlpZiAocmV0KQogCQlyZXR1cm4gcmV0OwogCkBAIC03NSwxMiAr
NzUsMTEgQEAgc3RhdGljIGludCBleGZhdF9jb250X2V4cGFuZChzdHJ1Y3QgaW5vZGUgKmlub2Rl
LCBsb2ZmX3Qgc2l6ZSkKIAlpX3NpemVfd3JpdGUoaW5vZGUsIHNpemUpOwogCiAJaW5vZGUtPmlf
YmxvY2tzID0gcm91bmRfdXAoc2l6ZSwgc2JpLT5jbHVzdGVyX3NpemUpID4+IDk7CisJbWFya19p
bm9kZV9kaXJ0eShpbm9kZSk7CiAKLQlpZiAoSVNfRElSU1lOQyhpbm9kZSkpCisJaWYgKElTX1NZ
TkMoaW5vZGUpKQogCQlyZXR1cm4gd3JpdGVfaW5vZGVfbm93KGlub2RlLCAxKTsKIAotCW1hcmtf
aW5vZGVfZGlydHkoaW5vZGUpOwotCiAJcmV0dXJuIDA7CiAKIGZyZWVfY2x1OgotLSAKMi4zNC4x
Cgo=

--_002_PUZPR04MB6316DBBB2B99C8BA141EF48781342PUZPR04MB6316apcp_--

