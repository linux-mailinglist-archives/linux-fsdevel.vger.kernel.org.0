Return-Path: <linux-fsdevel+bounces-52030-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8039ADE9A1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 13:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36AAA3BCE7F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 11:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2410128C5AA;
	Wed, 18 Jun 2025 11:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="NlZ6/uhu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCAC28A1C1
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 11:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750245032; cv=fail; b=dmgu+mna+XAtgs0J/raBCnSBV1+TdViwltF2MUd5n28+9lZNW5wlfpzhZbGyUIW0Z95Cs60cGO5hhIEIQs7BIPeXG6qK21eyojzvsw50CSvI03Auz0bZhnJ/A+h+PB6KVF7xhNrjusnoSvZPimDMJk0fhCI3U8M30ooguD5RFio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750245032; c=relaxed/simple;
	bh=h4QrWVkB/4LkP96vQD41h6Gz3gUsv/bwSVe1tsX3h8g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IIlQfIM8mrQvEei60q3sdLc0Uk/CFAxAzFcQksSoBBBPiH79kNXZKkhb6+wVE9dQ/vtlz9R4eC5/wGb8+EsZ3MGIvqeP9oLp1Pnaant0xlqAvGSOatUtXaWka59rfU4RWAKhvXkxpGdXN0rWnMSWxhuE7/PBquNS/qhXqmDcdXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=NlZ6/uhu; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209327.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55I88SEt024879;
	Wed, 18 Jun 2025 11:10:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=h4QrWVk
	B/4LkP96vQD41h6Gz3gUsv/bwSVe1tsX3h8g=; b=NlZ6/uhue6QC2tZPu6agyHL
	A2fTCjNjV1wK9SMiDqw9rJJ5YLlbYiZoGFoxwqZWYRlNzDKlT4Ec6VJO21J5Bgp3
	SYNvDgh929omtfxbwZaWPoOlWni7vJ/x5jiTO/C0W6Yf0ZX3FEs89v2HLZpOaIsj
	fVc1Tchh1QvzNpQcGzQyKbuufuvbzPcfbCqJHYvlJ3kPbOM3tqFprVbVhUZzAIWD
	Wr99qCbW8ksVMAZCYYM4Nm4Lx8mtpGNIOulVEoSXZy6iBDN8qycxPeuWoX3E05Cx
	T3X10ucz07y/F4QToSeBGXcTf6+UhEe0HU6acHQujmLoFcxvT1ONGGDlXgAD5nQ=
	=
Received: from seypr02cu001.outbound.protection.outlook.com (mail-koreacentralazon11013019.outbound.protection.outlook.com [40.107.44.19])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 478yy33u0n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Jun 2025 11:10:03 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wEGr49luxVVE9rFl1zoiBGOjT5VKjQTXSz1IRVXPBf7uFxnJH+Vz0QBhq2mPhVbr7i4IP/dPXCCJo6xnPAhsVbExs82DFpSXLlHxMLe/DgQ81qz/XwjuxEWmloFDBYpWUSFTSmQ8Opr72Ufd6X0brn6ksanj63xuOXClvFuijxM0BZYLnTodbvysbNg1qJ1fT+6MiQQhBZKUJbXHBPp8EtgFcb0TacTWRPmdPyR5a792zukts7+9kZ76Mn3qV0gMV1bu4fPPOMAZuuYFpIms50i450ACZF0wsewCnWMVhSchZP4ZWAPBe84Ng6Xd74XJZhK5CiQ5yBrqES/L+0hB3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h4QrWVkB/4LkP96vQD41h6Gz3gUsv/bwSVe1tsX3h8g=;
 b=m+Hujro9uyB0ckZacUOelmy6vE4O2Dd+g+VfBE6ZIiSLT7h0PyQ4n3YMsNzklxzT9CjVaF5pUqAkZxMXSxi7xxThFKKpFKkATse8I0LnkmsdlNeJhzdKU+SUekx04WoUnoGd5SJO+vWmfOHxyPKQCi+T15mDNDFOCRPqUby99oLp5ScB6JdrqAWacbnGVEEy8Bnz15IVZwUfvZoKgRkZZU+p3F124GkeV0+oFCym3/9oLI4vyHLuPWhblc5782bYbwy/sIdu/4TxeusrasRP6Yh9ihSR3u5BM3UX69/R6/m449AQTaX1XEeWMAseODXSDJQz6aEOK6iJ4ok82GuHMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by TYSPR04MB7750.apcprd04.prod.outlook.com (2603:1096:405:60::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Wed, 18 Jun
 2025 11:09:57 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%5]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 11:09:57 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: Namjae Jeon <linkinjeon@kernel.org>
CC: "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v1] exfat: add cluster chain loop check for dir
Thread-Topic: [PATCH v1] exfat: add cluster chain loop check for dir
Thread-Index: AQHb3E98aowgY+DhSkarP/Byf+TS7bQGhzwAgABTRAuAAAdqAIAB2pJQ
Date: Wed, 18 Jun 2025 11:09:57 +0000
Message-ID:
 <PUZPR04MB63162AAAE1128A915F966E388172A@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <20250613103802.619272-2-Yuezhang.Mo@sony.com>
 <CAKYAXd_TFNnbJLNsYFW4=mCzVyx1ZqhuLD58aLD5cWu2uk2+Qw@mail.gmail.com>
 <PUZPR04MB6316B26325B23BD49C3DC97C8173A@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <CAKYAXd-p6-HcjS4ZZHJ4YDsYgynBLczWKLJbh-5ATHyDHLCwGw@mail.gmail.com>
In-Reply-To:
 <CAKYAXd-p6-HcjS4ZZHJ4YDsYgynBLczWKLJbh-5ATHyDHLCwGw@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|TYSPR04MB7750:EE_
x-ms-office365-filtering-correlation-id: dda7b5ed-8e81-4bcb-7845-08ddae58a8f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|10070799003|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dXEyaTFkMmt5dDBNNWJaSEo4WFdGczlBRDFlU3BYTDZPbEMwQXRKTCs3TTJ5?=
 =?utf-8?B?WXMrUEE5QWVoY1E4ODcvOWZ0SS9nazVmb1YySWNsdHA5Q3BWZmJ5c3dsaEVl?=
 =?utf-8?B?eVFkbkFBbkgzaE1IWHo1anN0MzZ6OE11a0JpQytQNjAzK2plcDVxTjBCck90?=
 =?utf-8?B?TmlaYTluMmVkeTNiaUxWN281RG16ZktEWnpldk8zYldzMXQwb1pGVy82UnhS?=
 =?utf-8?B?K2F0ZTlCREVBZmVBYlYwS0x5RGZ0b3pkTWQxenRBL3JNT0Y0U3JlWjgraEpl?=
 =?utf-8?B?Z2Z1VnpUcnlzVksvWk1xYXFjQW12YTk0eVY5YVlia3lqRTRpazVxMUhBQkVk?=
 =?utf-8?B?SUFrMFUxazJKSHRPT245S1VCYU9HUHEvczVqMmdUOWloVEpsSUh6S3BQd0ZS?=
 =?utf-8?B?Sk5kYy83TmlmZExaRk5wMEZtQUxWcC9neEhmanE5cEl1QklVcG5XaTV2ZjFU?=
 =?utf-8?B?dkRUYzFKaDZZTEdaSVJnR3grT3N2d2J1NXJVSC9scTdOS0RSSTJ4RkFmVjh1?=
 =?utf-8?B?VHVXbmxVbWRvbnVrSUNYTTFMbXRxZDJPZnI3THZhdXVJVUJDN1NINVdmaXlp?=
 =?utf-8?B?SEthSkFxZG5KS2tTVVprbm02M1VObGkyQXU5K2ZXSStwNm9ubXg3QjRFVDFp?=
 =?utf-8?B?SEJmMUFreGJFSXpYTzF6MGJvYkk3WVg1cmx1MUZxa1hKM2tzZVN1bU5aK2ln?=
 =?utf-8?B?Z3JZQVcvWGIraUozSXhWdjk2WEdsT0xKOElTY004dXZKRzYrZHgrOEdFYUdW?=
 =?utf-8?B?VlN0NmxUWXFYamZJV3RVd0lZM0lMemt2dTMzWWUvVHpUNHVnSUhJNGlPZTlP?=
 =?utf-8?B?RWtselVJMmZkaUhLakhoNzBkaStqRjVocTBqdit3WUd1aitQTEhQMzNjMVMy?=
 =?utf-8?B?bWtHUDRKTHpBZGp0YlhMT3hEZ29hVFJwejh5dlB2NEJVanZ6R1JhSnNGNkFw?=
 =?utf-8?B?UStKL0pZNE1XNW9MdktiazhRYXpUc1p0dGtVL2IxMnczYmEwZHdCdm9QdUdS?=
 =?utf-8?B?V2gvQ3hBelp4NTVoWHZBWHRIUjViRlQyUDdwYzc1S3huSjdUL29uWmg3R0JL?=
 =?utf-8?B?MnMzcTVSd29PKzRFYjE5c25wQzE1STZYb29YQTBwclBna0grZ2t6NE1rdVlE?=
 =?utf-8?B?OTRiSjZJemZCb2hjcXYxcTFnTncxNGtua1NiNFRoNXhGSGR2Q1YzS1EvQS9w?=
 =?utf-8?B?L2I1RE5QZVVReWkvMmNBUlZoUTJ4MkhpZ1N3em9uVUN6RTgwQXJmWEVHd1Qx?=
 =?utf-8?B?ZS81UnhFVCtnZnhUQndNTWd4TjI3WW91M0Z3MDI3L2g3ZWdON04rdW16V1d4?=
 =?utf-8?B?Yng4dDA4aHdpeEYvQWVwcExmdEovaGlxR2RROHVzZmp0OUNEb2lPVTIwUzJw?=
 =?utf-8?B?MThmWmlZTy9tZXM5VlR0RXpHZVY3TlRsMXpyYmREeUNhRVhuMjlZcGN5V0xT?=
 =?utf-8?B?T2FnYUVxK1VUWlBKTWQzOHVQYUxDRjd6RG02dy9Ed2dLeDc4d3MvRjRNcEVx?=
 =?utf-8?B?T0pXdzBpSXpGNjNpYm9rMlMrOEwydHR6Uk1uZFFwUzFCZEo2WDBUSzZOQ2cr?=
 =?utf-8?B?aWpSaVlGL09KL05zTUNNOFRxSDgwd2p5SHFJRTk3eTNTWnFjbUdPQ2plUnhw?=
 =?utf-8?B?OERIdWtZZmVaNnZIL28vb2RSTmVubXVUZnNWWWZlQk5zUWtaK2ZPRlVsMi9n?=
 =?utf-8?B?RFB5ek1GOUJoaHVNNVIrdGRBeUFleFJtcWU4SWZuckxLeWg3eWxydU82NDU5?=
 =?utf-8?B?cVdETGNWb3FZTVJZM0VVR2pPMjQvcmpKSnlxUEtWNzZzVEFjTzdObGdQQzlv?=
 =?utf-8?B?YkR2YkZqd2xOaTJEdUt0SmdMTHZhMGVVc1lzWGpXaGhVbVBQUk1DbXUwVG5i?=
 =?utf-8?B?bXlvWjQ5TGIvbzdpeVNLbWIvajBDc1lYZ3d6YjlvcUg2WFkwSWIrelBlYTRW?=
 =?utf-8?B?ZWdlbjZsVHdEak9JbW40SkNFSUhnZVd6bytqMWdQUUxLNTBxeXVVVTVTQXpp?=
 =?utf-8?Q?iaSSgTVMC/2Ohl6euJQ08LIJCwjgto=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b0ZybWttbS84NVJBWjNtc0pzaFM5K2tVY1JTVlhjNWJuZGNZeVNoZHcrVVBk?=
 =?utf-8?B?d3M4R21TQnRkVllYUEV2cjI2eUFSNTU2VjVPdHUrdWRheFRrNkQvZXBLMWlu?=
 =?utf-8?B?MXN0ZS9Dd3FKcFBJQXY1NmNudjVlT2lLampGRmt3cFFwVEJqZU9NSDRhZG1O?=
 =?utf-8?B?TUlyOWRTUkVOejRHVU44RXp1amdBRVVTb2JndnBPc1kwRHJyVG9SZXIwd1FC?=
 =?utf-8?B?N1dCNFZMZDJvZ2Y5cmQ1ZlkwUHR2K2JJRWVuQlhsT01BUzByTDREek5jTmhV?=
 =?utf-8?B?d1RsWWVJc0psZ01qZmYwT2NBOFRPOVQrc09heWc5MmdwN2d1WHp2ajk4VXVC?=
 =?utf-8?B?aThuUUY3cTNpeE85d21ITitKaFd2Y3dJN293ZHdFTU1YdnI0TVY1Mmk0OTR4?=
 =?utf-8?B?UW9hVHZMMEJOODJRTGtuS09qOGFUT3ZCa2tFcVhqK0RaU1AzU0lWeVRPZHQ4?=
 =?utf-8?B?MW93V0lFZlpjb2RpakZMRDh6dGdvaEU2YW03M0JOWHF3SVlOREdrYyt3RExx?=
 =?utf-8?B?RDl5MmFHMzQ3KzVFUGxIWnByVy9yd0kyelBrS3dHYnprcEsveHQ1M3R6d0hz?=
 =?utf-8?B?c2xxLzI0OVhvUGNaTWp3UjlYajNMQk9ITzdLaW9JelI0b2FCSldpb2ZlbmUy?=
 =?utf-8?B?WEpoK1l2WldCenBvK2JGcTFDYkc1MFJlY3RaWTBneUN3Zm9NVEI1OC9ZTGhL?=
 =?utf-8?B?R3RSaTZOVWdRdWJGc0U3cjZLS0ttSElGTm81eHJGZFpOeEdSZkFqMUhNT0xM?=
 =?utf-8?B?U2Y5ZDVDT053WEEvNzJIZ202YlpuU2h3aElpT1Nwd3pJZE9KTFJMY0dQVGpV?=
 =?utf-8?B?OWNOUFJwK25jVjZuU082ZWU5WXRuVlhFaG9xQ29RZldmdkpaSzNWOHlyb2Jm?=
 =?utf-8?B?WTVpZ3RUU3d5NmVSbStFU21INE1XL29UdzdaLzRxL2dWdHV0eWxlT3M3YVFO?=
 =?utf-8?B?bGV5dytFS2grTzF2M1hINHlGV1JZMkF6aUJVeVJuaFhkZ1FFYUZnaDV5TGlB?=
 =?utf-8?B?WGJoVXZCUHhSUm1mYmRwUythc2JYMlEvVEdZcG1WdUQxZnFSa3hLNmt2UnRl?=
 =?utf-8?B?bmF1QjRrK3p2WUZYY0hIYzlhSWlUK2UwbVhsYzEzSk4wUVpRUXFteDNQTHJO?=
 =?utf-8?B?a0tIM0EzVk9CVld0S3Q4UzJqU3BCQmt2TjZyMjJESlFOdDdLVnhpT1o3Y1dF?=
 =?utf-8?B?L1FGTjR3U2I3K0djbnZ3cW9hUEpGK0lFcUpMeG50RUFsNzM4Yy85aGFNVkNM?=
 =?utf-8?B?UVp6V1REWHpsRVpEYm9PWGtMTzAxemczVW05NllyWllndUdsbUNVeE04T2hL?=
 =?utf-8?B?K29LOStOeXY0OEZSZGg0aXZ0QW9nNG11ektGRyt4S3ljR2pybEN5UmV6NUdW?=
 =?utf-8?B?U0x3Q2p2TjZlY2ZqVkJTYUo0OUlDanpOaGhwNEdQYlV4L2RYOUNSckRXekNv?=
 =?utf-8?B?OC9reW1XVHRFeE1ad2NqbU4xNDA3aFE4K2xCQmR1SmFPclkzSTB2dTVWcWdP?=
 =?utf-8?B?NS9wZGtjUjcweFQ0U1NrNUV0Nm9zengxVWo1RlBtcDJMR3VjUTE0eTJaYU1p?=
 =?utf-8?B?dW5hM2dOZDBHTitKZFZLdS9hV2ZtWFBSN3VVSFQzYmFXY1JFVTZzMEY1d3JW?=
 =?utf-8?B?MlJObFlTR0MrVkNnZytjd1NSd0J3KzdKbUZMV21JUVRSWXFUTzVBQmJjUXg4?=
 =?utf-8?B?RnQyWVFQQVd3ZWU2VENBMjFZL25CMW1PQWR5NVNQeFhjWVNhcXNaQnhMUC9M?=
 =?utf-8?B?ZWlHR2dWTlc2ZnQrcjNNc2daVFoyQWRnRlZDeURnZ3Z1NUFLSW5WSkpCSDBB?=
 =?utf-8?B?d0tBOWxkdS9KR0RTZ1lwcHFVUk5nUEJRNE1tTjd3MFREcXZtQU5qcE13a2hV?=
 =?utf-8?B?aHdEeE9IcHVvWHNmOC9mbEhpcEpNbGJpdlltdk9SMjNuRkFzSXhYMnlzekVY?=
 =?utf-8?B?ZDNOVmxOdGNId0I1THZWUkt6Mm1jQUFkdytCS2RsN2tOYVFJT0Q0NXZ4OXdI?=
 =?utf-8?B?MUtFazhDU3JENzFBSG9veUR3K2tmYXJyYnp6MmZKaUNjejNDN2tRbk5KMHM4?=
 =?utf-8?B?S3hjOXJCT3UySUN3czlTWDBXYXJVUXpKZ1VYOW94UFBJYW9tRGp2aXVGUzNy?=
 =?utf-8?B?OCtkcENZZ2VST3g4aGN5c0p4UWllYjRMK05FWDA1eUpWNEFmeHI1eWpVSUx0?=
 =?utf-8?Q?M8DdcWh1JRjABd9S3MZwnsE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jaXk84bnY1LcPwCeBnW1eyz5NmRVYHeIYqh5AYEowy02tA1WYCrakZ1GiA31BW7HVCPtAQRRoxTbzkGyHC91wMv/sEjbTVK/aFrmvFVSl74Wr+jz8OCYQuhMq6afedGWKilj8NeyCYJA3UjmxddSqXWZ8a2kN4HifKumJmbMXf0Iujl1N3knkSCQAxeyoU7MMWB1NjwXkr7nFIc09CTFInoDzrMHpTVyG0tqmFRNOCyULOdv7+ZpGfHnODCAMDqTZZF9o4TySJZJoTe5NE3dzTB2BeYcupkoW2TmcFrDRonLekqSZtmSG0+pU1+NGyMZzbq13a41JyDXx81LHYcqPA38WScDuJtZdADB9//7xsEhe01t+dT8GcRzMMZQZ+zmhhTFG3u6LnOYlvdcp9GjKK8+jNwGhu+VxqfQqXA1koL0WlsyNWxCsuwKDWJD8g7xt0kclQplzVHGpnSbWQHPzlN1Tf+fTJ/LeOmBOFanj+kkNj4l6pmny2Rr+Xf9kVxP3DYN4BHOIj0f/c1i6LzOYr0PI7BGCqhcBEutazxXBX0lV626UKDKIcoYZhYoQGEQRDRSV3jPrTge86SF3cdzxMtbYJ/qayCIIT0Ac9QFnuXitpnlpLTezFRPYsvWgUg4
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dda7b5ed-8e81-4bcb-7845-08ddae58a8f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2025 11:09:57.1083
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qa2fBeUSBNsrRL/BdGJiU3P+oPzZI6YBifC5kBFivVC/+U0KmMB9ONzHG6xBs/om4Gzx7uDSCrM/ZU3xJT24Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR04MB7750
X-Proofpoint-GUID: _aAPHoCqLv3yyCqzrOutYCpkQkWxRzBI
X-Authority-Analysis: v=2.4 cv=Qb5mvtbv c=1 sm=1 tr=0 ts=68529e8b cx=c_pps a=VedXox5PDv7MRHZ09beFKg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=7j0FZ4iXMVMA:10 a=xR56lInIT_wA:10 a=z6gsHLkEAAAA:8 a=aU0LFusll5MwX02NsIwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDA5NSBTYWx0ZWRfX5X6v27ZlSgJ7 0kzjbMv6IbzmTPO/Hei42ddFTy2MQwjPyPpabUnaDaTUPgRt2uXnqwJqtAvgv481sbepX4lOfmR HHS3JaMxRtTNs60mYNkXOsoAmdh0GQe0JSofWQNiq8hHsBl3k7NUePqRYRnVM1QblEOMXEXHRDE
 q9VrpwK7lCOsP6p0kcuw8JqDTGm6Co8o+2dlh0yrmIfsEoyAUcUQf+JzW8xv7epjmGuf+xgdZE5 9XU8JfwxRhDIK4Q3oa6CdO1UlDbZ1dhb+4dYSVzT0TMXIXRsWUMehhx7rY8XYeewYmKdH1Hzf3/ gFaqMPtf1BPmVhrF7LEJTZN1dPDnL8UbqPw5GDagG3tyScp6cPCkGy3y8g77PpNA+L3nMchQhy/
 BJsGIxpINUMPVNyliUNbHH86vBYgJylrZDp04meagnb5zFnPDNfA8O+HzHxxh7y93eBdxwew
X-Proofpoint-ORIG-GUID: _aAPHoCqLv3yyCqzrOutYCpkQkWxRzBI
X-Sony-Outbound-GUID: _aAPHoCqLv3yyCqzrOutYCpkQkWxRzBI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_04,2025-06-18_02,2025-03-28_01

PiBPbiBUdWUsIEp1biAxNywgMjAyNSBhdCAyOjM44oCvUE0gWXVlemhhbmcuTW9Ac29ueS5jb20K
PiA8WXVlemhhbmcuTW9Ac29ueS5jb20+IHdyb3RlOgo+ID4KPiA+ID4gT24gRnJpLCBKdW4gMTMs
IDIwMjUgYXQgNzozOeKAr1BNIFl1ZXpoYW5nIE1vIDxZdWV6aGFuZy5Nb0Bzb255LmNvbT4gd3Jv
dGU6Cj4gPiA+ID4KPiA+ID4gPiBBbiBpbmZpbml0ZSBsb29wIG1heSBvY2N1ciBpZiB0aGUgZm9s
bG93aW5nIGNvbmRpdGlvbnMgb2NjdXIgZHVlIHRvCj4gPiA+ID4gZmlsZSBzeXN0ZW0gY29ycnVw
dGlvbi4KPiA+ID4gPgo+ID4gPiA+ICgxKSBDb25kaXRpb24gZm9yIGV4ZmF0X2NvdW50X2Rpcl9l
bnRyaWVzKCkgdG8gbG9vcCBpbmZpbml0ZWx5Lgo+ID4gPiA+ICAgICAtIFRoZSBjbHVzdGVyIGNo
YWluIGluY2x1ZGVzIGEgbG9vcC4KPiA+ID4gPiAgICAgLSBUaGVyZSBpcyBubyBVTlVTRUQgZW50
cnkgaW4gdGhlIGNsdXN0ZXIgY2hhaW4uCj4gPiA+ID4KPiA+ID4gPiAoMikgQ29uZGl0aW9uIGZv
ciBleGZhdF9jcmVhdGVfdXBjYXNlX3RhYmxlKCkgdG8gbG9vcCBpbmZpbml0ZWx5Lgo+ID4gPiA+
ICAgICAtIFRoZSBjbHVzdGVyIGNoYWluIG9mIHRoZSByb290IGRpcmVjdG9yeSBpbmNsdWRlcyBh
IGxvb3AuCj4gPiA+ID4gICAgIC0gVGhlcmUgYXJlIG5vIFVOVVNFRCBlbnRyeSBhbmQgdXAtY2Fz
ZSB0YWJsZSBlbnRyeSBpbiB0aGUgY2x1c3Rlcgo+ID4gPiA+ICAgICAgIGNoYWluIG9mIHRoZSBy
b290IGRpcmVjdG9yeS4KPiA+ID4gPgo+ID4gPiA+ICgzKSBDb25kaXRpb24gZm9yIGV4ZmF0X2xv
YWRfYml0bWFwKCkgdG8gbG9vcCBpbmZpbml0ZWx5Lgo+ID4gPiA+ICAgICAtIFRoZSBjbHVzdGVy
IGNoYWluIG9mIHRoZSByb290IGRpcmVjdG9yeSBpbmNsdWRlcyBhIGxvb3AuCj4gPiA+ID4gICAg
IC0gVGhlcmUgYXJlIG5vIFVOVVNFRCBlbnRyeSBhbmQgYml0bWFwIGVudHJ5IGluIHRoZSBjbHVz
dGVyIGNoYWluCj4gPiA+ID4gICAgICAgb2YgdGhlIHJvb3QgZGlyZWN0b3J5Lgo+ID4gPiA+Cj4g
PiA+ID4gVGhpcyBjb21taXQgYWRkcyBjaGVja3MgaW4gZXhmYXRfY291bnRfbnVtX2NsdXN0ZXJz
KCkgYW5kCj4gPiA+ID4gZXhmYXRfY291bnRfZGlyX2VudHJpZXMoKSB0byBzZWUgaWYgdGhlIGNs
dXN0ZXIgY2hhaW4gaW5jbHVkZXMgYSBsb29wLAo+ID4gPiA+IHRodXMgYXZvaWRpbmcgdGhlIGFi
b3ZlIGluZmluaXRlIGxvb3BzLgo+ID4gPiA+Cj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogWXVlemhh
bmcgTW8gPFl1ZXpoYW5nLk1vQHNvbnkuY29tPgo+ID4gPiA+IC0tLQo+ID4gPiA+ICBmcy9leGZh
dC9kaXIuYyAgICB8IDMzICsrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLQo+ID4gPiA+
ICBmcy9leGZhdC9mYXRlbnQuYyB8IDEwICsrKysrKysrKysKPiA+ID4gPiAgZnMvZXhmYXQvc3Vw
ZXIuYyAgfCAzMiArKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLQo+ID4gPiA+ICAzIGZp
bGVzIGNoYW5nZWQsIDUyIGluc2VydGlvbnMoKyksIDIzIGRlbGV0aW9ucygtKQo+ID4gPiA+Cj4g
PiA+ID4gZGlmZiAtLWdpdCBhL2ZzL2V4ZmF0L2Rpci5jIGIvZnMvZXhmYXQvZGlyLmMKPiA+ID4g
PiBpbmRleCAzMTAzYjkzMmI2NzQuLjQ2NzI3MWFkNGQ3MSAxMDA2NDQKPiA+ID4gPiAtLS0gYS9m
cy9leGZhdC9kaXIuYwo+ID4gPiA+ICsrKyBiL2ZzL2V4ZmF0L2Rpci5jCj4gPiA+ID4gQEAgLTEx
OTQsNyArMTE5NCw4IEBAIGludCBleGZhdF9jb3VudF9kaXJfZW50cmllcyhzdHJ1Y3Qgc3VwZXJf
YmxvY2sgKnNiLCBzdHJ1Y3QgZXhmYXRfY2hhaW4gKnBfZGlyKQo+ID4gPiA+ICB7Cj4gPiA+ID4g
ICAgICAgICBpbnQgaSwgY291bnQgPSAwOwo+ID4gPiA+ICAgICAgICAgaW50IGRlbnRyaWVzX3Bl
cl9jbHU7Cj4gPiA+ID4gLSAgICAgICB1bnNpZ25lZCBpbnQgZW50cnlfdHlwZTsKPiA+ID4gPiAr
ICAgICAgIHVuc2lnbmVkIGludCBlbnRyeV90eXBlID0gVFlQRV9GSUxFOwo+ID4gPiA+ICsgICAg
ICAgdW5zaWduZWQgaW50IGNsdV9jb3VudCA9IDA7Cj4gPiA+ID4gICAgICAgICBzdHJ1Y3QgZXhm
YXRfY2hhaW4gY2x1Owo+ID4gPiA+ICAgICAgICAgc3RydWN0IGV4ZmF0X2RlbnRyeSAqZXA7Cj4g
PiA+ID4gICAgICAgICBzdHJ1Y3QgZXhmYXRfc2JfaW5mbyAqc2JpID0gRVhGQVRfU0Ioc2IpOwo+
ID4gPiA+IEBAIC0xMjA1LDE4ICsxMjA2LDI2IEBAIGludCBleGZhdF9jb3VudF9kaXJfZW50cmll
cyhzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLCBzdHJ1Y3QgZXhmYXRfY2hhaW4gKnBfZGlyKQo+ID4g
PiA+ICAgICAgICAgZXhmYXRfY2hhaW5fZHVwKCZjbHUsIHBfZGlyKTsKPiA+ID4gPgo+ID4gPiA+
ICAgICAgICAgd2hpbGUgKGNsdS5kaXIgIT0gRVhGQVRfRU9GX0NMVVNURVIpIHsKPiA+ID4gPiAt
ICAgICAgICAgICAgICAgZm9yIChpID0gMDsgaSA8IGRlbnRyaWVzX3Blcl9jbHU7IGkrKykgewo+
ID4gPiA+IC0gICAgICAgICAgICAgICAgICAgICAgIGVwID0gZXhmYXRfZ2V0X2RlbnRyeShzYiwg
JmNsdSwgaSwgJmJoKTsKPiA+ID4gPiAtICAgICAgICAgICAgICAgICAgICAgICBpZiAoIWVwKQo+
ID4gPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FSU87Cj4gPiA+
ID4gLSAgICAgICAgICAgICAgICAgICAgICAgZW50cnlfdHlwZSA9IGV4ZmF0X2dldF9lbnRyeV90
eXBlKGVwKTsKPiA+ID4gPiAtICAgICAgICAgICAgICAgICAgICAgICBicmVsc2UoYmgpOwo+ID4g
PiA+ICsgICAgICAgICAgICAgICBjbHVfY291bnQrKzsKPiA+ID4gPiArICAgICAgICAgICAgICAg
aWYgKGNsdV9jb3VudCA+IHNiaS0+dXNlZF9jbHVzdGVycykgewo+ID4gPiAgICAgICAgICAgICAg
ICAgICAgIGlmICgrK2NsdV9jb3VudCA+IHNiaS0+dXNlZF9jbHVzdGVycykgewo+ID4KPiA+IFdl
bGwsIHRoYXQncyBtb3JlIGNvbmNpc2UuCj4gPgo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAg
ICAgIGV4ZmF0X2ZzX2Vycm9yKHNiLCAiZGlyIHNpemUgb3IgRkFUIG9yIGJpdG1hcCBpcyBjb3Jy
dXB0ZWQiKTsKPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVJTzsKPiA+
ID4gPiArICAgICAgICAgICAgICAgfQo+ID4gPiA+Cj4gPiA+ID4gLSAgICAgICAgICAgICAgICAg
ICAgICAgaWYgKGVudHJ5X3R5cGUgPT0gVFlQRV9VTlVTRUQpCj4gPiA+ID4gLSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICByZXR1cm4gY291bnQ7Cj4gPiA+ID4gLSAgICAgICAgICAgICAg
ICAgICAgICAgaWYgKGVudHJ5X3R5cGUgIT0gVFlQRV9ESVIpCj4gPiA+ID4gLSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBjb250aW51ZTsKPiA+ID4gPiAtICAgICAgICAgICAgICAgICAg
ICAgICBjb3VudCsrOwo+ID4gPiA+ICsgICAgICAgICAgICAgICBpZiAoZW50cnlfdHlwZSAhPSBU
WVBFX1VOVVNFRCkgewo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGZvciAoaSA9IDA7
IGkgPCBkZW50cmllc19wZXJfY2x1OyBpKyspIHsKPiA+ID4gPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGVwID0gZXhmYXRfZ2V0X2RlbnRyeShzYiwgJmNsdSwgaSwgJmJoKTsKPiA+
ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlmICghZXApCj4gPiA+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAtRUlPOwo+ID4gPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZW50cnlfdHlwZSA9IGV4ZmF0X2dldF9l
bnRyeV90eXBlKGVwKTsKPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJy
ZWxzZShiaCk7Cj4gPiA+ID4gKwo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgaWYgKGVudHJ5X3R5cGUgPT0gVFlQRV9VTlVTRUQpCj4gPiA+ID4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOwo+ID4gPiBJcyB0aGVyZSBhbnkgcmVhc29u
IHdoeSB5b3Uga2VlcCBkb2luZyBsb29wIGV2ZW4gdGhvdWdoIHlvdSBmb3VuZCBhbgo+ID4gPiB1
bnVzZWQgZW50cnk/Cj4gPgo+ID4gVGhlcmUgYXJlIHVudXNlZCBkaXJlY3RvcnkgZW50cmllcyB3
aGVuIGNhbGxpbmcgdGhpcyBmdW5jLCBidXQgdGhlcmUKPiA+IG1heSBiZSBub25lIGFmdGVyIGZp
bGVzIGFyZSBjcmVhdGVkLiBUaGF0IHdpbGwgY2F1c2UgYSBpbmZpbml0ZSBsb29wIGluCj4gPiBl
eGZhdF9jaGVja19kaXJfZW1wdHkoKSBhbmQgZXhmYXRfZmluZF9kaXJfZW50cnkoKS4KPiBJc24n
dCB0aGUgaW5maW5pdGUgbG9vcCBpc3N1ZSBpbiB0aGlzIHBhdGNoIGltcHJvdmVkIGJ5IGNoZWNr
aW5nCj4gY2x1X2NvdW50IGFuZCAtPnVzZWRfY2x1c3RlcnM/Cj4gSWYgaXQgcmVhY2hlcyBhbiB1
bnVzZWQgZW50cnksIGhvdyBhYm91dCByZXR1cm5pbmcgcmlnaHQgYXdheSBsaWtlIGJlZm9yZT8K
PiAKCkl0IHJlYWNoZXMgYW4gdW51c2VkIGRpcmVjdG9yeSBlbnRyeSBhbmQgZXhpdHMgdGhlIGxv
b3AsIGJ1dCBpdCBkb2VzIG5vdApmaW5kIHRoYXQgdGhlIGNsdXN0ZXIgY2hhaW4gaW5jbHVkZXMg
YSBsb29wLiBBZnRlciB1c2luZyB1cCB0aGVzZSB1bnVzZWQKZGlyZWN0b3J5IGVudHJpZXMsIGFu
IGluZmluaXRlIGxvb3Agd2lsbCBvY2N1ciBpbiBleGZhdF9jaGVja19kaXJfZW1wdHkoKQphbmQg
ZXhmYXRfZmluZF9kaXJfZW50cnkoKS4gVG8gYXZvaWQgdGhpcywgaXQgY29udGludWVzIHRyYXZl
cnNpbmcgdG8gZW5zdXJlCnRoYXQgdGhlIGNsdXN0ZXIgY2hhaW4gZG9lcyBub3QgaW5jbHVkZSBh
IGxvb3AuCgpGb3IgYW4gdW4tY29ycnVwdGVkIGZpbGUgc3lzdGVtLCB1bnVzZWQgZGlyZWN0b3J5
IGVudHJpZXMgd2lsbCBvbmx5IGluIHRoZQpsYXN0IGNsdXN0ZXIsIHNvIHRoaXMgb25seSBtYWtl
cyBGQVQgaXMgcmVhZCBvbmUgbW9yZSB0aW1lLiBXaGF0IGNvbmNlcm5zCmRvIHlvdSBoYXZlIGFi
b3V0IHRoaXM/

