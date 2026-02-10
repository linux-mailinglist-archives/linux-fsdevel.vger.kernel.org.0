Return-Path: <linux-fsdevel+bounces-76903-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEwTOc60i2m1YwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76903-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 23:44:30 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4935611FCC1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 23:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED8F43064642
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 22:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B56335567;
	Tue, 10 Feb 2026 22:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gq8/7/1s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3287A30FF3A;
	Tue, 10 Feb 2026 22:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770763460; cv=fail; b=BWUAKrcrg7w2jGNzBzeNWjkxKczqlLQHi52WMHEOiByknU/0YzV7s/g8V6j6x29ohhiPbdKlmpMpZiVrzmkoO35dDIQh/njM7Suo8cqM0AmtB67KmKyqZEAel5Eeq/3kqmK5k74ig/OQUNnCbkdVUYJTYW6RxTHedCc8LXXDwB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770763460; c=relaxed/simple;
	bh=0W33BT2inBn3uhkls3cckBZ1Xcxl6Yay+mqucwCyDaQ=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=jKjt5AeG0ggk/zHH35F6ErvV/MgYPvlqj7VKRFpu389KMqFEWCW52Ih2admwijsjgwY9hWGyZ3ADZAkZ8HIa3jfUgW668K+V4LpCXloWZE3OeUkQdYUB5ZEKxN1ZHYljdYfOcDVaEq8nSSCRL9AICVdo6Xo27prteOkkxZtA3B0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gq8/7/1s; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61ALeGcl190125;
	Tue, 10 Feb 2026 22:44:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=0W33BT2inBn3uhkls3cckBZ1Xcxl6Yay+mqucwCyDaQ=; b=gq8/7/1s
	1hqhe9qoNooE/+YWDheAgvPvoXXxBZbYqDQsuds5YOL6SeBCw3wQMzGQNwBz+ASa
	i/Jqu8uToMASmlYtIlShSiqRXK6LFsjq3kcfxDb+tb6O/O5s6H8I2sRFxYROuPbo
	JoGYNz/IQOjjiD7RIaIuv8bo1nHZwV/8RUi9RDANLnevB96vqtBl4Qb4yhRrUqDD
	Bu9kUbRWeLI7ba+e+VeRF+V96s2iJnSYfKS3p1ZJ8r7MIccWpcDX51h12SW+b2ao
	gw8xanAd/AevR+60KZ26rQ3ylyiBZ5LD7hzbD7asIMbI+og44uCEVbVbLFoskvEG
	Eb5qqCSaWiBdkA==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012037.outbound.protection.outlook.com [52.101.48.37])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696uvckj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Feb 2026 22:44:13 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ewtgAOwtTOqJ9VcgA8QGbitgZ53PmF5R08OLgIle3LVcyzTHSgG3vRiSyoPLHMRyGQ+XHmRoPqrLW6rnTVi7Scs5OJJ135SCFm2sqsEvJRk7PuU6CSCr34eT39d5dZ8g/HxQGawoRwyqc4OM5XAOGxS1FnoN2+6iOT+GOB0hwjb15z9LC1sDTeOmP/FPZd+r1a5jIpSj1uF2+hZJcv9z0sUTs3lCNrUgGpTt0YV92JK4sV/aP3a69atHM3OnP8GJQGglTZL/vA8CR7D/THq6EKkVeGHE8mtrQfy4GPdDi/CkH2XfhDt7iF41/98XlorOveNeilb9ttco7/0IOrVFzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0W33BT2inBn3uhkls3cckBZ1Xcxl6Yay+mqucwCyDaQ=;
 b=QV5WWvuCX59cf69sHji90kZVJWY5zT4hze3NShm4IeEteOgnSTXAsZypmo7PRPoK3KIex3kLjmKfklrqu3wONpdfh2tJjLxWGyGjs1UqCCFnQFeoL76KDEASWx+6tzdeLPTjZEJ9gpNvxcsUJPXR6dw8vm3d4lZGsEFZ10txw8gvIR5VPxIhx53ZtUPDllfwLmYe5d7YRPrhVOS0Qw3ey8eKH5vlU4gmIfr/8KjA5ImjG8uSH609m76jJXj4PJ+aOFaXNOYA8VTTF9RWy+0XBVph/1I9dV00/3WXjkx7OSIO9SKWo7/aK/00Xs0wgy2XACOxrLjkC3D1URsq/1F5xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by LV8PR15MB6546.namprd15.prod.outlook.com (2603:10b6:408:260::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 22:44:10 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 22:44:09 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [RFC PATCH v1 1/4] ml-lib: Introduce Machine
 Learning (ML) library declarations
Thread-Index: AQHcmEnOC00VEXnru0q06Eiq8znH6LV62kAAgACPIwCAASORAA==
Date: Tue, 10 Feb 2026 22:44:09 +0000
Message-ID: <363063e09bace65c83bf04fd4d2c89c877eca581.camel@ibm.com>
References: <20260206191136.2609767-1-slava@dubeyko.com>
	 <20260206191136.2609767-2-slava@dubeyko.com>
	 <2026020756-remarry-declared-9187@gregkh>
	 <46449ed46d60767bd13b980e5ab63faf4364f718.camel@ibm.com>
	 <2026021005-tacky-pentagon-aab1@gregkh>
In-Reply-To: <2026021005-tacky-pentagon-aab1@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|LV8PR15MB6546:EE_
x-ms-office365-filtering-correlation-id: 77922f82-dc59-4d13-225c-08de68f5e7a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|7053199007|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?bWo1enRXckY5OWtXRjRlaXEyc0hET3B1WXFraFhJVVRqRzRFM0lQR0gyUDJZ?=
 =?utf-8?B?Y2lKQmVYR3k4NXZuaGQwVHloWTR4a0MwUEI3ZHZ6SkUzZ1EwTFNxMnV6WlFY?=
 =?utf-8?B?L1FlMUFPemd1WmRzS2RWZmw1VWhxd2haMVhUZmRMalFQRFBpQjJRTnVwS2Ny?=
 =?utf-8?B?aTZBQmQzT0JDbVhGeHp3TTMwR0V6QmpZdUY2ZTloZElNVmdRUkZaSlUrNGd3?=
 =?utf-8?B?ZUR5UGhzUFV0UzdZOEoyend1dy9UVytOM1YvcVRMM3lZTU9vNnBoNVpIRzE1?=
 =?utf-8?B?aGxGWGI2dUM2eEVyckwrdXZnZFQ3VXpvOTN6cnBPS3NQQ0tZQ1NnNm1ZQ3ZD?=
 =?utf-8?B?eWFRVlJtUWt5Z3ZydHhWdzJGZFNkall5aFRSREw3NkhsR2Jab005THg3b09w?=
 =?utf-8?B?d0Y3cXoxUVhxT0Q3UlRzTTJPRzZHdHM5dGJ1UUJ2UWp4bUkzUlc3UXY4TVBz?=
 =?utf-8?B?SXR1VEJJcmtac3hlT0w1bHFCU3pIQkN5aForOCt3MktFOG1kbWNsVFZaNFYr?=
 =?utf-8?B?L2FONW04UVQzOHZGRFQ1SHFwNkN1YmM5Mlc4RUJQTGpiL2FxVHZHUXZ0cDRo?=
 =?utf-8?B?eEhpREtHcm8xK3diVmRTOGl5QTBQYUlqaGp3am16SlQ3MkpDVXgzbmpUMTNv?=
 =?utf-8?B?KzVCbEVscldGWlBSVmFBZWo2NjlFcVpjcGs2RjRPRm1tbWkrdmJ2dUpSTHdP?=
 =?utf-8?B?MktFbEVRSlhBTXlqTzAxWHhhWGZpY2dvS3BMUU5ud0tHWG9WdWNNbzhEVlNK?=
 =?utf-8?B?ODRwRnJHd2Z3ZFNwOENGQ0RqQXJDMkdDbWQwKzhGRmQxdzhxZ2JKUm1Ka05x?=
 =?utf-8?B?K0hNNXY0UkUxbDRwNW1PNjFzT0xvaUZLK3hhSXhCYmdheENjdGtzMmZEdHZw?=
 =?utf-8?B?ZjZrV2ZkWXBsOEo4K0N5U21Sa2RQd0pZTHRodWRtTVBULzBSbFY4WW5QalFr?=
 =?utf-8?B?QmZTS01xT2U2QTR0ME1FbUdrWFIzWnhCUGZmd0kzZlhycmo2eThEc0JZQStU?=
 =?utf-8?B?eHp4emdma0FzSTdQTXB2TzJKTTNqeGFCN3doUTR6Z2U4NlN3ODY4YU1FWVdy?=
 =?utf-8?B?WEtTZG9BQkd4WGZQM1pzTTRqYVNFYXJYaElQVVR2cWhOaDgyQWc2YTJ6bXJW?=
 =?utf-8?B?K3ViZ3FWTG9PcGdia0JLSHM5OC9IWTl5TVkxMEs3TVZSSDlLOGFNRFdEVHZY?=
 =?utf-8?B?clhPUHVVak1EaDhSeEJ3dTBnQVNJTzBBQml2MGF2S2RGOU9JUUY0R0c5OHdm?=
 =?utf-8?B?Wnc3czBVbWV1akhzbDNoSXNMTkVlMUlxUUY3djg2RnN5UUwvL05GdE5LK0Uv?=
 =?utf-8?B?VGVDUnlSdFVSU3htMUVIWmcyTzZwek05dEVvVjl2bzNYdUNIRzJXa2VIbnlX?=
 =?utf-8?B?MEwzWXdkdEFiRkpvQlhsK1FtUUpPSjRuaW0wRHdBVHNKcHVPaGVUS3hUc0ZZ?=
 =?utf-8?B?clovUDlualRUc0FqNTN3RFRmZ3F6OTkveXh2cGdYZk0vdWkzUkZKK29GZDZh?=
 =?utf-8?B?NkgrMUUrWjNVL0NnV1RrcmEzRjVjanBjVlltcWw2SjJPeTVjU21aNStweFhI?=
 =?utf-8?B?cDEzNDZaVjlGbzZTdTFLY253R2EzbEowVmkwYmkrMitvNGR4U1RHaTVpc21l?=
 =?utf-8?B?a1JaR2N0WVdxU3hsdHE5TXNNMEhXZUttMklGMDJNRlZOaUdJekxHM1kxZy8z?=
 =?utf-8?B?bnpDdFErWjN2Nks4WWFUZm5WaXJrWmhGQno1d3QvTFZtandXMnhJNCthWWRj?=
 =?utf-8?B?SG5leXhmTzI4ZEV2RFBHOEtxYUt3WG9WQi9ISVZoVDZVbzhBSys3TW91eS9T?=
 =?utf-8?B?cFZVS2lGWVVZR0pVS2thdFUxZzhiVnRaYWtmdjRPcmdvOWcyNlp2ZU56enpS?=
 =?utf-8?B?VDd4NXRnQVFLdHhNWXVQV0c5ZnQra1M5V2JPVlBiWWd4WnRUZjFTcldjbEht?=
 =?utf-8?B?S3lvc3lOWVNSNjdTUExzanBGMUF4ejJqZE1vdTRNM3JZMEVIVFgvaGpCWEk1?=
 =?utf-8?B?dGFZNlJNdHU1bHNZZE9zdGdFeFVNS1NxU1p1QjJoZ295cWtJVWZVbitkY2NP?=
 =?utf-8?B?dWJGWEVDQ1lxalY2UWFmL1hYaUVjcnJOTUxnZUxGTzcwSm9ueEorck1DbzJj?=
 =?utf-8?B?d3hoY1Facy9jSHAzQ3hVZGtzZEtkSUtvSFR4VWp5bnJYMHR4d1ovSnhUcDZL?=
 =?utf-8?Q?YhUueIBGIDIXUZaugRlDX68=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UWEwcC96NzQrelkzaTdURHRpbTloOWlvRjZERlJXTmlDYVZiVFRzamhPZUFq?=
 =?utf-8?B?bjVOWVQvR1VQU3h5cjA1Vm1KelcrbFdEclJTczhYTVlEbmc5bXR5Y3pSZ09z?=
 =?utf-8?B?Nmd6UmVwNERGK1pQVG0waEdJSVpKT2xCVTRUZFVQWFBhQzdMWERHMytJNjdU?=
 =?utf-8?B?RHM2WlptaUd4a0VoWVdKbUNsTnQvb2Nqd0FzYm5sTFpjUjZLUnRtMTIrc2Nk?=
 =?utf-8?B?Z2tydmtLUm0wR1hWMCtEV1BhRlorQzJaak0rYU1TM29JQVNpelpNSXZCYk8y?=
 =?utf-8?B?U3REYzNlamxWZENJUFdTd2drS0RJWFc4MC9jTnZESFhHWkQwRWtveTRUdWVY?=
 =?utf-8?B?eTVuSExCV0NsV2QxRVY4MWRycGJFZHhuT1dJSVoxeFFaRXloY0FzeXkyb0RP?=
 =?utf-8?B?clkzMWliRGVSekx5Sk9ZSDc1eVhwTVI4MnlEaWtzWXdyUTBIZTg1NG5hVlRm?=
 =?utf-8?B?Z2FVSHp2TE1QUHB0eVVRVzZ3SldRbDVOb2QvVlllUXd3eWZlMkdjQ1FNeDRz?=
 =?utf-8?B?VzAwdEhsWWxQTkkwVTNqY21TdWhHZ2tuMTlQTm1SMmxydTNrbi9mZVhQczc2?=
 =?utf-8?B?VGFnenNUWWVMVGlWa1hWQnZSWmx0dmNJZ2F6OHBxSWdaWVFWQ1llQmhVMGZ0?=
 =?utf-8?B?QXNuR1p6Y3R1OFRaWWp3dTNMWmkzSVZSaXZDZnRLTmUxencyU1c2NTJ4Rmwx?=
 =?utf-8?B?blJ1LzdxQUl6dEVCZzBVS1NKRFByNzFnblJublhmRTlQZS82ZkVnMDZLMU05?=
 =?utf-8?B?RjQ0SlFHWTVoNDcyRldlcU5hNWNkQldBc1JkaGZlMFlIZy9GellhTnhNYnlV?=
 =?utf-8?B?UDk2TTdMNVJxOU5VZWlScEgrS0N5OEJuUHBrV093MGgzd3pXYU1TS3g4RnpC?=
 =?utf-8?B?akRrdjN5OWdnYjllQXNRQ0VCa0F3L1hFSUxhUXNzWC85WkVXTGNNR0V1L2pa?=
 =?utf-8?B?MGJwK2JSOXZDTzM3UjNOcXdOTDlWMGtpYnE5N3FtKzFoRzhnbUZpR1N6KzQy?=
 =?utf-8?B?TkZGRDBvVVY4bFROWTVRZ2doeXB3U0srVU1heVVXcno0U3YrSFRaUVFadUxu?=
 =?utf-8?B?ak1MbVhzOHFwbnZsWUxBeGhYb1g4b2RhY0laVE41dksvOGw2NnZka0RTa1BF?=
 =?utf-8?B?OTU5U1c3VzVVbzdzeXdST283cUgzeEFOYlpRV2JDNDlIZy9lSDV4LzRLY2J6?=
 =?utf-8?B?Rll0WjBseDF4WEkvUTlMekY3bkIwMHMzQ3BJemhIdmtXeDFjM3dEUEZYYis5?=
 =?utf-8?B?aDJQUk5Wc1BJTTlpdHdUL3FLY0RqeXNOb0s3dUUzazk1UWhIelF6OTArSFVQ?=
 =?utf-8?B?eFllb3ZhcFg5ZVFlN0hLK3dGWXRQc1dqandxbWZNb2YvUDNxMTljM0JkUmR5?=
 =?utf-8?B?ZFhqeGQxL0tZU2pTMTFDWmtDV2dEWC9MMWsvdlZMRGVOTEhSN09QYTlidVlv?=
 =?utf-8?B?cWZUR05aZVp5eGVNY2RHOUliVjlpOENpZEpLR1ZjQTVtK1Rlc0ZhMXZoYnQz?=
 =?utf-8?B?SVQreEh4c043aEJGOE8xYm5Tc1NFdUhRekpadHp1ZEZaZHUyM3pRQU55dnY5?=
 =?utf-8?B?RkVRRTF3RW40a0NLTWdrWTVIdlJ6MG5kWTM3eWYxVHhDNFoxYnBRWjIzNlo2?=
 =?utf-8?B?Q043b1gyRk9najAvT1VtWEhPblNmTkY2T0VvZ0tVUjVRZzhWMGZ6bGFzOHAv?=
 =?utf-8?B?M0doMHlMQlNMMDZPUXlSVElaTG1DMmFFUUtYZU1YN0hzMU1naDRyTkRzMVF3?=
 =?utf-8?B?N0VUQ1k5Wjlub0gya0IyTjBBY3FDVmxVRWV1aU9PekhzWFFsTjc0ZFV0WWRz?=
 =?utf-8?B?Z002RWJlekVLNEZLanhiU2gvcHhFN09XeXRaSGhKWENHRHVSdllaOUYzU1lB?=
 =?utf-8?B?N2ZlanM0MFhHUFlpQnVmQ2w1aGJsRzAzQSt6NmJ2Q2tXUk5wM2RmR3MzbU4r?=
 =?utf-8?B?WEdlYzhDT3oxanFGQ3FwL050V3c1SFFZRWVIT0dIb3hqTzNkN1V0VVN0cUIy?=
 =?utf-8?B?bStuSkdhd0grVC93ekdhWnlpZDdkZ1BDWGN4RDdlRXdLT2svMUk4V0tBQlVE?=
 =?utf-8?B?T1RmcE5DR3hRL3pGdkxXV2hWeEtTNzRmdGRjaGJ4bHpIaXNUKzlXczZJV3dB?=
 =?utf-8?B?ekxBQnp5QnF2Mm5sbnRBZVI5U1dhREdWdGJqSjVFOGRIN2JjbGlmcGxyaFZX?=
 =?utf-8?B?Tnc5TUlxYU1EOG1YNWhiaWxSb0tFbk13cGFFc3FSWnYvZUxoeFkrdnIvVytZ?=
 =?utf-8?B?bE5OSHRSSHN6RjNQL3FaM2x0cC9NbUM3Mk5KQThOYk90MGhqVFQ5dytJWEpz?=
 =?utf-8?B?WUtHZ21KZVcvL21pSVlZakd2UGhaZkpzV1JUSDNoY2dVRWlQUXQyT2pVOHNr?=
 =?utf-8?Q?LLQGBH0bJYfc4QNWAPwXjhvJtbkOfY4WAXFj3?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4F37FEB2622DF347A7B52417E03AD54E@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 77922f82-dc59-4d13-225c-08de68f5e7a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 22:44:09.4347
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1n4ESvJMDELR8J0nY8ofI79SrrRG1BuLuRfgtswiizBFZSYXuelNx59AGGkVZAutTi5KL8/URMc66+3wYc0lJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR15MB6546
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDE4NSBTYWx0ZWRfX96i2XbOOc8xC
 wNokATj/lPf+JDExmZFLwpsMzWU7SPMdE+WsxAATxy2LyHlIU1on6Wwk1GtyVV3cmo3mhNcwrKp
 lMVR1+1a36m97ulNqHCD42Pok1u2Dn2L9Q/hfG2bnKIHVb3ouE0lij7VCR535gsbHqEwoMgb3bt
 DE0l/4KomG9oTTMravk/Zc8lFxkIEpHxMmG0UIaEpgirLUWce71+QHNKZ5W7DKpFrgEPkHjMovW
 ZqoLKIMUgY4xi+T/7VmkxpKKF1CBtpwlO5q9OTQMeEosa5NGnwcaGIIJ7TNi/rCCJnC2kNcoznu
 J9r5+ZxjKWAmLcQjZ9yzB2GrngLiUAi59IamSx0xBMt02fTZh2TvF2FFJeM0KgY8ijYR7TyXJ6P
 xLk/fJXgEzCCp9le7uyrOS1seTHcTkREwu6jWU/5CO2n5AN+hBpGXI+RFnW3ZzdWiCphm4OVggm
 R+yKECZYicxq+eKCLtw==
X-Proofpoint-ORIG-GUID: eRbZl2Up2L-qSm8NH9sQFXThDQuCH-YQ
X-Proofpoint-GUID: eRbZl2Up2L-qSm8NH9sQFXThDQuCH-YQ
X-Authority-Analysis: v=2.4 cv=O+Y0fR9W c=1 sm=1 tr=0 ts=698bb4bd cx=c_pps
 a=uCbPN9sl+YgD9yJogSPUSw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=ag1SF4gXAAAA:8 a=xlFuFk4B6tNd9oDkOX0A:9
 a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
Subject: RE: [RFC PATCH v1 1/4] ml-lib: Introduce Machine Learning (ML)
 library declarations
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_03,2026-02-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 adultscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602100185
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-76903-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4935611FCC1
X-Rspamd-Action: no action

T24gVHVlLCAyMDI2LTAyLTEwIGF0IDA2OjIwICswMTAwLCBncmVna2hAbGludXhmb3VuZGF0aW9u
Lm9yZyB3cm90ZToNCj4gT24gTW9uLCBGZWIgMDksIDIwMjYgYXQgMDg6NDg6MTdQTSArMDAwMCwg
VmlhY2hlc2xhdiBEdWJleWtvIHdyb3RlOg0KPiA+IE9uIFNhdCwgMjAyNi0wMi0wNyBhdCAxNjo1
MiArMDEwMCwgR3JlZyBLSCB3cm90ZToNCj4gPiA+IE9uIEZyaSwgRmViIDA2LCAyMDI2IGF0IDEx
OjExOjMzQU0gLTA4MDAsIFZpYWNoZXNsYXYgRHViZXlrbyB3cm90ZToNCj4gPiA+ID4gKyAqIEBr
b2JqOiAvc3lzLzxzdWJzeXN0ZW0+LzxtbF9tb2RlbD4vIE1MIG1vZGVsIG9iamVjdA0KPiA+ID4g
PiArICogQGtvYmpfdW5yZWdpc3RlcjogY29tcGxldGlvbiBzdGF0ZSBmb3IgPG1sX21vZGVsPiBr
ZXJuZWwgb2JqZWN0DQo+ID4gPiA+ICsgKi8NCj4gPiA+ID4gK3N0cnVjdCBtbF9saWJfbW9kZWwg
ew0KPiA+ID4gPiArCWF0b21pY190IG1vZGU7DQo+ID4gPiA+ICsJYXRvbWljX3Qgc3RhdGU7DQo+
ID4gPiA+ICsJY29uc3QgY2hhciAqc3Vic3lzdGVtX25hbWU7DQo+ID4gPiA+ICsJY29uc3QgY2hh
ciAqbW9kZWxfbmFtZTsNCj4gPiA+ID4gKw0KPiA+ID4gPiArCXN0cnVjdCBtbF9saWJfc3Vic3lz
dGVtICpwYXJlbnQ7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKwlzcGlubG9ja190IHBhcmVudF9zdGF0
ZV9sb2NrOw0KPiA+ID4gPiArCXN0cnVjdCBtbF9saWJfc3Vic3lzdGVtX3N0YXRlICogX19yY3Ug
cGFyZW50X3N0YXRlOw0KPiA+ID4gPiArDQo+ID4gPiA+ICsJc3BpbmxvY2tfdCBvcHRpb25zX2xv
Y2s7DQo+ID4gPiA+ICsJc3RydWN0IG1sX2xpYl9tb2RlbF9vcHRpb25zICogX19yY3Ugb3B0aW9u
czsNCj4gPiA+ID4gKw0KPiA+ID4gPiArCXNwaW5sb2NrX3QgZGF0YXNldF9sb2NrOw0KPiA+ID4g
PiArCXN0cnVjdCBtbF9saWJfZGF0YXNldCAqIF9fcmN1IGRhdGFzZXQ7DQo+ID4gPiA+ICsNCj4g
PiA+ID4gKwlzdHJ1Y3QgbWxfbGliX21vZGVsX29wZXJhdGlvbnMgKm1vZGVsX29wczsNCj4gPiA+
ID4gKwlzdHJ1Y3QgbWxfbGliX3N1YnN5c3RlbV9zdGF0ZV9vcGVyYXRpb25zICpzeXN0ZW1fc3Rh
dGVfb3BzOw0KPiA+ID4gPiArCXN0cnVjdCBtbF9saWJfZGF0YXNldF9vcGVyYXRpb25zICpkYXRh
c2V0X29wczsNCj4gPiA+ID4gKwlzdHJ1Y3QgbWxfbGliX3JlcXVlc3RfY29uZmlnX29wZXJhdGlv
bnMgKnJlcXVlc3RfY29uZmlnX29wczsNCj4gPiA+ID4gKw0KPiA+ID4gPiArCS8qIC9zeXMvPHN1
YnN5c3RlbT4vPG1sX21vZGVsPi8gKi8NCj4gPiA+ID4gKwlzdHJ1Y3Qga29iamVjdCBrb2JqOw0K
PiA+ID4gPiArCXN0cnVjdCBjb21wbGV0aW9uIGtvYmpfdW5yZWdpc3RlcjsNCj4gPiA+ID4gK307
DQo+ID4gPiANCj4gPiA+IERvIE5PVCBhYnVzZSBzeXNmcyBmb3Igc29tZXRoaW5nIGxpa2UgdGhp
cy4gIFBsZWFzZSBtYWtlIHlvdXIgb3duDQo+ID4gPiBmaWxlc3lzdGVtIG9yIGNoYXIgZGV2aWNl
IG9yIHNvbWV0aGluZyBlbHNlLCBidXQgdGhpcyBpcyBub3Qgd2hhdCBzeXNmcw0KPiA+ID4gaXMg
Zm9yIGF0IGFsbCwgc29ycnkuDQo+ID4gPiANCj4gPiANCj4gPiBDdXJyZW50bHksIHN5c2ZzIGVu
dHJ5IGlzIHVzZWQgZm9yIHNlbmRpbmcgY29tbWFuZHMgKHN0YXJ0LCBzdG9wLA0KPiA+IHByZXBh
cmVfZGF0YXNldCwgZGlzY2FyZF9kYXRhc2V0KSBmcm9tIHVzZXItc3BhY2Ugb24gdGhlIGtlcm5l
bC1zcGFjZSBzaWRlLiBBbmQNCj4gPiB0aGUgaW50ZW50aW9uIG9mIHVzaW5nIHN5c2ZzIGVudHJp
ZXMgaXMgdGhlIGV4cG9ydCBpbmZvcm1hdGlvbiBhYm91dCBrZXJuZWwNCj4gPiBzdWJzeXN0ZW0g
YW5kIGV4Y2hhbmdpbmcgYnkgY29tbWFuZHMgYW5kIG5vdGlmaWNhdGlvbnMgYmV0d2VlbiB1c2Vy
LXNwYWNlIGFuZA0KPiA+IGtlcm5lbC1zcGFjZSBzaWRlcy4gRG8geW91IG1lYW4gdGhhdCBpdCBp
cyB3cm9uZyB1c2luZyBvZiBzeXNmcz8gSGF2ZSBJDQo+ID4gbWlzdW5kZXJzdG9vZCB5b3VyIHBv
aW50Pw0KPiANCj4gWWVzLCB0aGlzIGlzIE5PVCB0aGUgY29ycmVjdCB1c2Ugb2Ygc3lzZnMsIGRv
IE5PVCB1c2UgaXQgZm9yIGFuIGFwaSBsaWtlDQo+IHRoaXMgYXQgYWxsLiAgVXNlIHRoZSBjb3Jy
ZWN0IG9uZXMgaW5zdGVhZC4NCj4gDQo+IA0KDQpTbywgdG8gc3VtbWFyaXplIHlvdXIgcmVjb21t
ZW5kYXRpb25zOg0KKDEpIERvIG5vdCB1c2Ugc3lzZnM7DQooMikgRG8gbm90IHVzZSBjaGFyYWN0
ZXIgZGV2aWNlIGJ1dCBtaXNjIGRldmljZSBpbnN0ZWFkOw0KKDMpIEltcGxlbWVudCBzcGVjaWFs
aXplZCBmaWxlIHN5c3RlbTsNCig0KSBlQlBGPw0KDQpXb3VsZCB5b3UgbGlrZSB0byBzaGFyZSBh
bnkgb3RoZXIgcmVjb21tZW5kYXRpb25zPw0KDQpUaGFua3MsDQpTbGF2YS4NCg==

