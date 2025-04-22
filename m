Return-Path: <linux-fsdevel+bounces-47001-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A85A97848
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 23:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D8D93AC234
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 21:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D059025C81D;
	Tue, 22 Apr 2025 21:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Mgo6bdk+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B6F25C815
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Apr 2025 21:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745356358; cv=fail; b=bIXJpjQnISa39atOqSTE/Bmp4lmMQh7ze4IaP5K0/bYAe4Rc3hYWAz2WC/uj+UdPV2DygUcflWblymaQ6/hC8f6fXLTjhEfQqsJ3BQ9IyPohT9VA07rSZAaw0w8Esp6o9aII/8HjPElF4NqPMjQAOZ13pbcl+4p8d/t0ZZa6dA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745356358; c=relaxed/simple;
	bh=WCp7b2umYlPWh2XvKowwjikJYz4zqcWBnbqy7swF0u4=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=kEQVquc1YkLCfgU5JorT0fiz5Yn50M8ZMEpEcfmWxfc7R489Djp5Xv+7yGxnIWkUVWojjpSdOSBUjl/xj1GYFXqWmpg66/Rcuh8GYJhx+bxW3J1aQJm29t89HIFSNI5ZYS06MxRe6my3lIgBy5UoBhk85X2hOfbzMu/DhPsVb8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Mgo6bdk+; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53ML1jDF030617;
	Tue, 22 Apr 2025 21:12:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=WCp7b2umYlPWh2XvKowwjikJYz4zqcWBnbqy7swF0u4=; b=Mgo6bdk+
	4HOJ8Z5BnMZD6+z2Ak0uIW3Yydj7ZWjtVmTt2MPbZFqw8VyiucmzFb9OnFEW/Baz
	gdV9P9gPV86QsxBF6JEuH4JSpNn5QmlxFoDbLGF/Yudjpblh4ppQ8D0O8Hs/vDat
	FVTpDdhhH8wD2ZHOY0ePEincUzjyIJS95l4PzSNmR0iakWh9YCTk6uM8qSsfxfEq
	XeJuF7HHYTV36knyrAC9E6kYAcEZgQA7o8i8VGUOkwHdQKMg6aYSfpUnbBFIu086
	sAoS0t6oqlIw8TdL6bcf3Sfyx+rvI+W/mHjoSrR/j5uG3nAJP2hFEUvN3dN9g83H
	sz3/E6HIjszAjQ==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 466jnwg1pj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Apr 2025 21:12:27 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YjQELatSlVD+hR4UJDd9z3i49ftPwJiekiPRDA9b3dqmppLUyHIXodNOHhLlqP8Er/yPzBC1hdb899eWRWc24hgXZbjxD1iByGT3X9W1tdftBsrMWbxUZMq1PnaQM3j6CKFo9K71xL7BcWMSeZ9XHjEhGo86ldTWXHTBHkMc7gnW573HsCOEmxWNWiz0f5Ojhg01GW2gw+toJDxl9kqvaNqPpus3amN738uwS6IdMxF+YnZYtdGTwryFe4S+wg4ZLkGKsoulVdQMgu1iCW9/kV4aSNh/IngLE5Xo8OpcejTQMhilXcDb4NI8dukE5vZVewS0xbKD2YXKRKw/o/JIZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WCp7b2umYlPWh2XvKowwjikJYz4zqcWBnbqy7swF0u4=;
 b=hJ0zAOA+9xlh7eotzo5Zz7fer51bXaqR8db3ksA5mdBw6B84/FofkE6WXvk/8octxSeTvIXxZNK9N2Gyqpno9uJpBt1Nmu0jAooGOH1AfxfZ1303CKgRkkzf5aXxuPeh0j8J84Eql0IuQ3Ci7qs90zX5zEcUHUMia6H/6X3kGUL4YJS5HMNqLWUi/MUBh1y2KIm1aUyiv2C/zedbW5+C9MJb2DsFWnrUFRRVstCXzcNpLVtQRoGfcrr4cdX/nShUvzk4udLevp97zlYHdaCdEcrUURomUqL4VH+r4sZAti7gP1DCptZu46gw97N0mhtzdLifkmoCh9Z2TKSascphsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by PH7PR15MB6502.namprd15.prod.outlook.com (2603:10b6:510:30b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Tue, 22 Apr
 2025 21:12:24 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%3]) with mapi id 15.20.8655.031; Tue, 22 Apr 2025
 21:12:24 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>
Thread-Topic: [EXTERNAL] Re: HFS/HFS+ maintainership action items
Thread-Index: AQHbswekna2OCwxWoE2e/XeZ/ACbe7Ovn+GAgACQiQA=
Date: Tue, 22 Apr 2025 21:12:23 +0000
Message-ID: <1d543ef5e5d925484179aca7a5aa1ebe2ff66b3e.camel@ibm.com>
References: <f06f324d5e91eb25b42aea188d60def17093c2c7.camel@ibm.com>
	 <2a7218cdc136359c5315342cef5e3fa2a9bf0e69.camel@physik.fu-berlin.de>
In-Reply-To:
 <2a7218cdc136359c5315342cef5e3fa2a9bf0e69.camel@physik.fu-berlin.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|PH7PR15MB6502:EE_
x-ms-office365-filtering-correlation-id: caa07a9b-95d4-4bf1-eda5-08dd81e2609d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aHVtMjh3YUlnSkVSVG5pSzIraS9qNGhhdmJQamdqMHNtV0xoWTJQWkJ3b0J0?=
 =?utf-8?B?N0tYTkNCcUpEMU9TWXNGUmZ3aGw3cUtNQXByT3g5OTZ2M2lIYkdIelMvazZj?=
 =?utf-8?B?SXRuTTU5NFk0eTgzZktONmNRejNVRk8yV1JCY0JoektvYk1PVGZ0TVJkTTdh?=
 =?utf-8?B?UEpBMUVlbVFSN1NIN3pkRko1WEVwUllja1g0NENKVFNIRkZ5UHlkckZXOEtC?=
 =?utf-8?B?M1FYanBoTGZMdWQ5QVNsekF4cGxIOVlCeGtSSjBRb29ERUw4cmd2aDY4R0xG?=
 =?utf-8?B?ek5nbUNVMGhpQnB4Nm5OQWRRN2M5Umc3aWlobjdlSWhBc2w1L2k4NWk2bFFC?=
 =?utf-8?B?UUQyQjN5VVhCTHRDb3FXbVpsYjd0N3ZrZnBuVzNwdnZVZG5hbS8yTVhXTmVK?=
 =?utf-8?B?OFEzcUFlbnJkMVdHUmZxYkhQWDRJNHlrZjZMM3RvenZyTW5rcUk0UnNFWUMx?=
 =?utf-8?B?YVBnU2s0blNuMUJQcU9hdzl4TkxORjB5RWU1Z1pJV29OK1cwaFhGenltU24y?=
 =?utf-8?B?eUVrT0FCb040bUpOYjBXbUFhS3dMY1dnbkIxd1pER2NUcXhmNkxDUW5UbnIr?=
 =?utf-8?B?Vk81K0JkSnZHTFFJRUtIMi84eHJLbXFLakkxeWJFME83TWluWDZEbUZUQWFj?=
 =?utf-8?B?TXJJZE4yZVROci9hWFQ5dnp5V3FSa1RtSEFkZy9aMnR2UStMVk9Oa2k4TWVD?=
 =?utf-8?B?WG9SR1dYUm9nUjB5eW9RNXkzTDhBR29RZ3ZVS0FCL0xxNFJRTUtCZGl3MHF1?=
 =?utf-8?B?NkJrUzF4a3B4OUN5K3dnME9jaElsWGcxSWp6bTh5NEJnWWZuZXpWWXh3ZXNw?=
 =?utf-8?B?Nkhaa0RiR0lESkdGOXBqZnAySC9EK2FmTXhxR3BqKzJBRFdUZWV1b0o2RVdv?=
 =?utf-8?B?MUlWQm9Yb1Jab3dhczgwcmZERDVzak5vTUovM0pveE9uUElrZEhjcDVoY0VN?=
 =?utf-8?B?VG01SmlTRVpEREpjK1M3VDh0Z0QxRnNnbXgrYldYTVdaUHE0UXdLc3JYMGls?=
 =?utf-8?B?M1ZoVlhFb2pHS0JaZHVGWmxtdXRIRmg0TWZmYUFnbGVKYU5TZmhwZllmMGJH?=
 =?utf-8?B?djNQLzVDaXZBbFdBM0ZjK1oyR3NQQWJodGYvR2ZJMisrYXRnckpMTTVKRnh5?=
 =?utf-8?B?bkZQcDg0RWl2cUxzYzFvT1FYeWNNWGNkTEVLQVg4VUtZMk1yK3lUeWl3Z2g5?=
 =?utf-8?B?YjVIeVhFQjJ1TEF4R3ZwRWpPdVZOYkplb1NPaUZJQXdyb2tSS1l5YWRRTG5U?=
 =?utf-8?B?aG51ZzArdHZzUmZLeHVPTTVDQkRGcS9zTWFNckd3Qm1qTmdvT0owSmVoTlJB?=
 =?utf-8?B?WHBNK0NRbWRYcEEwSGQvNzBiTlc1aU1zWVNwWVplSmYvK2JRMEVvR0hMR1F5?=
 =?utf-8?B?YzJycG5UTzRnZ2VzbTBMYnJ5bnNTaFRQTmJMT0E1STQzdUx6NFV6SHhQRmk4?=
 =?utf-8?B?aHI3Sk0rOUJsS1c2RUlvTkYzeEFRRjY1VnpwWllCMDBSVlgzanBSTU9nOTQv?=
 =?utf-8?B?RDlRSjI5M1d5Y1poTFJxdkxLVzV5OWdLVWdsT1VEVFFhb1lIa1RmM3Uwcjhi?=
 =?utf-8?B?S2d3K0lINURkZFIweU9hbkhVeDlwaG5ZWG1lTEtGb2RKYndyNTk2YlVlajVI?=
 =?utf-8?B?ZGI3SjZvK0U2VVFMNE02a2NBYmpZMzV1QXRmTm5wenZSZTBYZVdTVjV2bE85?=
 =?utf-8?B?OUQzOTUreS9hQldEckV1bmdnZEkxeWRaYzg5dC9uMHROUXJ5NlpKUktRTUI3?=
 =?utf-8?B?dUJyaVlFUDEvM0ZHSXY2cmhkRjFZWXF0ajFIMGYwaUc0bXZYVzQ5T0VpVDdP?=
 =?utf-8?B?YS8ra0dpb29XSFB2R1ZEVlJzZ2lieDAwNzFvTnVBeEZPZmExZU9scWYzNGVQ?=
 =?utf-8?B?U01BaHE0Q2hvcFpnOTYzWTdtVTNnTUdkY1RzU2tJeVVVdDl5aitJVTBtbGxh?=
 =?utf-8?B?Z1p4ZmxZSFpDKzRqbmRFRG1IS2NHZ0VMb0VROC9iaExVSy9NeERnelNHRTFV?=
 =?utf-8?B?TUZiSkVUdVZ3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WGxzQndVU2s1T1lDK2JUS1RoeVQzTm4yNFgyOXlEcnlSRGJGZmtQMSttVnpL?=
 =?utf-8?B?bFIwbzFuZTk0ZmhYM1dod2xIeU9OL2o2eDE1SDJ4ZjZNVExGQnhtMitQWXhR?=
 =?utf-8?B?RGxMbHJ2OEwxQ2IxWit5RUVFVVlCMjJFOGlLbGFmMmxtQkpIdDlCbDZWUFZQ?=
 =?utf-8?B?N0Q3WEJRcVR3SC9lb0d2VWM3OXJuSzZjd3Q1eE81cE8xM0VpcHFYN29CUDJK?=
 =?utf-8?B?YmNKK1ljTUV6bTRPTEQ4bnIwbDc0QkI1VEFKdEtXUGhKSHR5RlZlTUxNenNp?=
 =?utf-8?B?YTBsSXIrV1hxOExNSVNTMVMyTGRIQWtSeFBtTUdyWThmRmFvM3lVTVoyMGVo?=
 =?utf-8?B?SGZ2WlNyR2dhSkpNbTBVY3Z2ZnE2UW1ad29iVno1c1F1S2RYdFZqNWs4M2px?=
 =?utf-8?B?OWM2ay8xbEx0bGl6NXo3V2c4RU92T3lnN2I3by8rbXFlUWhhVGFOeCs2UFVo?=
 =?utf-8?B?S0k0SjMwdGxFWHpQNVRkSEszMkZaSk8xNEwySVlENUlIV0E2RjZ0R0FUc0dZ?=
 =?utf-8?B?dXdXTGNaS0tQNEcxYUdpZUx3elAyOXBvdU1td1h0bHpGZlN3a1djc01OdVZz?=
 =?utf-8?B?dXFSNEVOQUR2YS8wQ09RVzExb2p5VUx2T1gwajNXa29KM3QxWVZoQzljcDR4?=
 =?utf-8?B?WFdSSFRQaFhwOHFMVFZieXBkQ1BDQW0xcENRcENLQU1SY2NYQTJqMWxraVhF?=
 =?utf-8?B?YUdEYWVMenVzNWVPaHFZK0tYelJnTEdzU05yUk1pNjdVNGVqTG94T2FjdFpH?=
 =?utf-8?B?WkkvSmdOVFJMOS9nK3dXOU9ldEtySzVhcmhMc2YvUXh4VUxrWGMxdTZPTy9x?=
 =?utf-8?B?TnRNNWpaL1NEbFZYaFBsYTZZZHRkV3JNaVhNWk1iTjVacUxweXArbEUxTmN1?=
 =?utf-8?B?ZnhqLzNNRklPS21VZHMzL3UrQUIrS0FYV09ZdklPbTVBTDkrcjBCL0ZGOVdr?=
 =?utf-8?B?T3NabGxrcGNHazdybGcyNnNleWNXbHNEWVRPMlg0Z3I4VGxsQTh5TkdwbE55?=
 =?utf-8?B?NWNuaTIxZGFuQXU2V0xwM1FMc2R0b3VIUXhHeitaNEgxTU00cVB2YTdjUCta?=
 =?utf-8?B?d3hBNFhweGpaYjVTOFRBcDBMRG1vbUYzaFZHN2VDZjJjeFBtT2VpZGZqUXZ6?=
 =?utf-8?B?YVFyK2toYXdsbS9NbExDTkxIRHpqR2Z6TmxlL2VMZlB6L3BXT0FtN0tXWGhB?=
 =?utf-8?B?RDNrQjBKaWZhRHQ1SXZrdVlTQlZndnlTZ2s3U3c3aXJZbEhGM0U3enRVYzBL?=
 =?utf-8?B?ekszTmpKMUdraTNyS2VYWUdLTlpHWXNLd2Q0NG8vWUtXdkVWY2JraG14WTRF?=
 =?utf-8?B?QTQxc2NRWiswOUxoNDBFaXlVN1k1VkRiOWNtUlRaZ3F1UHZ5bG9aZDFraTdi?=
 =?utf-8?B?b3g5NlhHenFrYmpNMHlUcXhXbFh2eWllN211bXNqYjZaZ0QwWWNuQlFRdDhv?=
 =?utf-8?B?UmkvcTAvUjU5SmlnRDZJbTJWNXp6ajFOKytOc2UzSTZOZlF5clN1TkIrZk00?=
 =?utf-8?B?KzJKVjlNQ1hLNEhSU1d0S3libC9qYmE4emd4aFBnZU5IM2VveVplMk1hNnBF?=
 =?utf-8?B?dE5sTkRlc1pXS3VzVzVMMnZnUkpBR1BxaXNlUFltRWJtMDQvRDJzdEptMm5t?=
 =?utf-8?B?TXN0R1duUWltWEhuZHI5WmFlUnllK3VXNHNNa1Z4WTR5cVdVdGIyMHZqZzRJ?=
 =?utf-8?B?U2xGd0o2OFlLWVAyNHpuVWJFdTZwWE1NUitxejV4SXcyQjNjOGxPVkpURlBY?=
 =?utf-8?B?dEl2R1lnVVM0dkxQMVN0WnRReWFwV3o4UWM3eklpc1I3R2srTnI0bjFtUzQw?=
 =?utf-8?B?WjlqYlN2bVl0T3hhajVMSVdHcVR6NVhoSUZDVW16NDZ1dmRpUTJva21PK0s2?=
 =?utf-8?B?SjQ5NWoyWEpHSWZ2d21KSGVoL1BYemRwaWdoMllLTTFkay9JQ2Iyc2JuSU0r?=
 =?utf-8?B?emVFMGV6VFpnelE0V1d1NlA4bUw3SVNmQ2UrTHhPTXJTREdQa21FOXVnTU9G?=
 =?utf-8?B?bWxwNk5tcXRsS3ArR2YrQmpXREtnSjVBQ0hiWG5hRTdKcncyTUZBVG1uRE4r?=
 =?utf-8?B?Zk03U2lKRnJRSXhISWFMb0ZCbTJrVmNCbDZHMDhMR090WHhMaXZhclV3d3Bw?=
 =?utf-8?B?YzFoSms5OUtXTDVXdlpRQldNVmFzdGxKZWdhbHBJZVlHcVNIU0V4ZG5yVDBs?=
 =?utf-8?B?VWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EBA7E083A4775140BDE58139FB33DB40@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: caa07a9b-95d4-4bf1-eda5-08dd81e2609d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2025 21:12:23.9889
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YA4dn0VeV9SPx9uaIl4I3o+9gaS+b9dL+LU6nvjjWZ6e9+T4TipAPg/hufle5Wt5bbpuI8iHCtMfTt5Da3Y9bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR15MB6502
X-Authority-Analysis: v=2.4 cv=HI/DFptv c=1 sm=1 tr=0 ts=6808063b cx=c_pps a=AVVanhwSUc+LQPSikfBlbg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=1eHq3YVcmJFJUQ9RBM0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: jbZH-04fc9EXOExUj-WLxC8houEIIZY4
X-Proofpoint-GUID: jbZH-04fc9EXOExUj-WLxC8houEIIZY4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIyMDE1OCBTYWx0ZWRfX+5wzRMyuFzmN KsBzguyKwVHr1n8edzs6gXFbxkioQdXbTr0ZiikRDRuUC6U6nGZJzvuETIPcZE4/+ecG1ZBaD1B 217+5xVOfdTQPg+D4uO2adHRMY/gdXERkFoNsgnaXfi4O7hYXWUVoKfW5Va84T/AtJYsD129crC
 0f93TnJLAWDlPIk4dfyJ2357lYuXpiTODi7Sfn6UHMpBIrIvDOMC5tfqG3E1D5O0LmObRhmuu/K NYP6gynrHmBL6wQDCI/PGEeseBOB8oFs/sqhiOE680YxjF/utX7jEp0SHuCQI56BS9Cb1DU8U85 Nd6Qbw4HDWUNrdzl6GNTltKUcJLJSqXFDiU1bdx+mcXJZT0hhMeqdrdEzmyZc6AW/d4ELQoINdD
 M9WLY9aosr0soKDRVO39AYWg5SOXG1hieopuOTu4OtcxKqJ63BhWUSCoYBndvdWUaLkoamk+
Subject: RE: HFS/HFS+ maintainership action items
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_10,2025-04-22_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504220158

SGkgQWRyaWFuLA0KDQpPbiBUdWUsIDIwMjUtMDQtMjIgYXQgMTQ6MzUgKzAyMDAsIEpvaG4gUGF1
bCBBZHJpYW4gR2xhdWJpdHogd3JvdGU6DQo+IEhpIFNsYXZhLA0KPiANCj4gT24gTW9uLCAyMDI1
LTA0LTIxIGF0IDIxOjUyICswMDAwLCBWaWFjaGVzbGF2IER1YmV5a28gd3JvdGU6DQo+ID4gSSBh
bSB0cnlpbmcgdG8gZWxhYm9yYXRlIHRoZSBIRlMvSEZTKyBtYWludGFpbmVyc2hpcCBhY3Rpb24g
aXRlbXM6DQo+ID4gKDEpIFdlIG5lZWQgdG8gcHJlcGFyZSBhIExpbnV4IGtlcm5lbCB0cmVlIGZv
cmsgdG8gY29sbGVjdCBwYXRjaGVzLg0KPiANCj4gWWVzLiBJIHN1Z2dlc3QgY3JlYXRpbmcgYSB0
cmVlIG9uIGdpdC5rZXJuZWwub3JnLg0KPiANCg0KTWFrZXMgc2Vuc2UuIFdob20gZG8gd2UgbmVl
ZCB0byBhc2sgdG8gbWFrZSBpdCBoYXBwZW5lZD8NCg0KPiA+ICgyKSBJIHRoaW5rIGl0IG5lZWRz
IHRvIHByZXBhcmUgdGhlIGxpc3Qgb2YgY3VycmVudCBrbm93biBpc3N1ZXMgKFRPRE8gbGlzdCku
DQo+IA0KPiBTaGFsbCB3ZSB1c2UgdGhlIGtlcm5lbCB3aWtpIGZvciB0aGF0PyBJIHN1Z2dlc3Qg
c3RhcnRpbmcgd2l0aCB0aGUgY29sbGVjdGlvbg0KPiBvZiBrbm93biBDVkVzIGFzIHdlbGwgYXMg
cG9zc2libGUgcGF0Y2hlcy4gSSBrbm93IG9mIGF0IGxlYXN0IG9uZSBDVkUgdGhhdA0KPiBVYnVu
dHUgaGFzIGZpeGVkIGxvY2FsbHkuDQo+IA0KDQpXZSBjYW4gZG8gdGhpcywgYnV0LCBhcyBmYXIg
YXMgSSBjYW4gc2VlLCB0aGUga2VybmVsIHdpa2kncyBwYWdlcyBhcmUgbWFya2VkIGFzDQpvYnNv
bGV0ZSBjb250ZW50LiBBbHNvLCBCdWd6aWxsYSBjb3VsZCBiZSBtb3JlIHN1aXRhYmxlIGZvciB0
aGlzLiBBbmQsIHllcywgd2UNCm5lZWQgdG8gY29sbGVjdCBhbGwga25vd24gQ1ZFcyBzb21ld2hl
cmUuDQoNCj4gSSBjYW4gc2VuZCBhbiBlbWFpbCB0byB0aGUgYXV0aG9yIG9mIHRoYXQgcGF0Y2gg
YW5kIGFzayB0aGVtIHRvIHNlbmQgdGhlaXINCj4gcGF0Y2ggdXBzdHJlYW0uDQo+IA0KDQpMZXQn
cyBwcmVwYXJlIHRoZSBrZXJuZWwgdHJlZSBhbmQgV2lLaSBvci9hbmQgQnVnemlsbGEgYXQgZmly
c3QuDQoNCj4gRnJvbSBteSBtZW1vcnksIHRoZXJlIGFyZSBzb21lIG9jY2FzaW9uYWwgZmlsZXN5
c3RlbSBjb3JydXB0aW9ucyByZXBvcnRlZA0KPiBvbiBIRlMgcGFydGl0aW9ucyB3aGljaCBtaWdo
dCBiZSBhIHJlc3VsdCBvZiBhIGJ1ZyBpbiB0aGUga2VybmVsIGRyaXZlci4NCj4gDQo+IFRoZXkg
Y2FuIGJlIGVhc2lseSBmaXhlZCB3aXRoIGZzY2tfaGZzIGZyb20gaGZzcHJvZ3MgdGhvdWdoLg0K
PiANCg0KWWVhaCwgSSBuZWVkIHRvIGNoZWNrIHRoZSBlbWFpbCBsaXN0IGZvciB0aGUgaXNzdWUg
cmVwb3J0cy4gRXZlbiBpZiBzb21lIGlzc3Vlcw0KY2FuIGJlIGZpeGVkIGJ5IHRoZSBmc2NrX2hm
cywgcG90ZW50aWFsbHksIHNvbWUgaXNzdWVzIGNvdWxkIGJlIGhhcm1mdWwgZW5vdWdoLg0KU28s
IGl0IG1ha2VzIHNlbnNlIHRvIGZpeCBpdC4NCg0KPiA+ICgzKSBMZXQgbWUgcHJlcGFyZSBlbnZp
cm9ubWVudCBhbmQgc3RhcnQgdG8gcnVuIHhmc3Rlc3RzIGZvciBIRlMvSEZTKyAodG8gY2hlY2sN
Cj4gPiB0aGUgY3VycmVudCBzdGF0dXMpLg0KPiANCj4gSSBzdWdnZXN0IGEgRGViaWFuIFZNIGZv
ciB0aGF0IGFzIGl0IGhhcyBoZnNwcm9ncyB3aGljaCBhbGxvd3MgY3JlYXRpbmcgYm90aA0KPiBI
RlMgYW5kIEhGUysgZmlsZXN5c3RlbXMuIEl0J3MgYWxzbyBlYXNpbHkgcG9zc2libGUgdG8gdGVz
dCBvbiBQb3dlclBDIGluc2lkZQ0KPiBRRU1VIGlmIG5lY2Vzc2FyeS4NCj4gDQoNClNvdW5kcyBn
b29kISBEbyB5b3UgbWVhbiBhIHBhcnRpY3VsYXIgbGluayB3aXRoIHJlYWR5LW1hZGUgRGViaWFu
IFZNIGltYWdlcz8NCg0KPiA+ICg0KSBXaGljaCB1c2UtY2FzZXMgZG8gd2UgbmVlZCB0byBjb25z
aWRlciBmb3IgcmVndWxhciB0ZXN0aW5nPw0KPiANCj4gRGVmaW5pdGVseSB0ZXN0aW5nIGJvdGgg
bGVnYWN5IEhGUyBhbmQgSEZTKyB3aXRoIGNyZWF0aW5nIG5ldyBmaWxlc3lzdGVtcywgd3JpdGlu
Zw0KPiBhbmQgcmVhZGluZyByYW5kb20gZmlsZXMgZnJvbSBpdCBhcyB3ZWxsIGFzIHJ1bm5pbmcg
ZnNjayBvbiB0aGVzZS4NCj4gDQo+IEknbSBub3QgYSBMaW51eCBrZXJuZWwgZmlsZXN5c3RlbSBl
eHBlcnQsIHNvIEkgZG9uJ3Qga25vdyB3aGF0IHRoZSByZWNvbW1lbmQgdGVzdHMNCj4gZm9yIENJ
IGFyZSwgYnV0IEkgc3VnZ2VzdCBldmVyeXRoaW5nIHRoYXQgaXMgY29tbW9ubHkgdXNlZCwgYm90
aCB3aXRoIEhGUyBhbmQgSEZTKy4NCj4gDQoNCk1ha2VzIHNlbnNlLiBGaXJzdCBvZiBhbGwsIHhm
c3Rlc3RzIGlzIGEgZ29vZCB0b29sIGZvciBmaWxlIHN5c3RlbSdzDQpmdW5jdGlvbmFsaXR5IHJl
Z3Jlc3Npb24gdGVzdGluZy4gUHJvYmFibHksIEkgbmVlZCB0byB0YWtlIGEgZGVlcGVyIGxvb2sg
aW50bw0KZnN0ZXN0cywgZmluYWxseS4gTWF5YmUsIHdlIG5lZWQgdG8gY29uc2lkZXIgZmlvIHRv
b2wgZm9yIHRoZSB0ZXN0aW5nIHRvby4gSQ0KdGhpbmsgdGhhdCBpdCBtYWtlcyBzZW5zZSB0byBj
aGVjayBhbGwgc3VwcG9ydGVkIGxvZ2ljYWwgYmxvY2sgc2l6ZXMgYW5kIHNvbWUNCnNldCBvZiB2
b2x1bWUgc2l6ZXMuIEkgbmVlZCB0byBkb3VibGUgY2hlY2sgdGhlIEhGUy9IRlMrIGZlYXR1cmVz
LCBhbmQgd2Ugd2lsbA0KbmVlZCB0byB0ZXN0IHRoYXQgc3VwcG9ydGVkIGZlYXR1cmVzIGFyZSBu
b3QgYnJva2VuLiBBbmQsIG9mIGNvdXJzZSwgd2Ugd2lsbA0KbmVlZCB0byBiZSBzdXJlIHRoYXQg
ZmlsZSBzeXN0ZW0gdm9sdW1lIGlzIGNvbnNpc3RlbnQgYWZ0ZXIgYmVlbiB1c2VkIGJ5IHg4NiBh
bmQNClBvd2VyUEMgcGxhdGZvcm1zLiANCg0KU28sIGxldCBtZSBzcGVuZCBzb21lIHRpbWUgZm9y
IHRoZSB0ZXN0aW5nIHN0cmF0ZWd5IGVsYWJvcmF0aW9uLiANCg0KPiANClRoYW5rcywNClNsYXZh
Lg0KDQo=

