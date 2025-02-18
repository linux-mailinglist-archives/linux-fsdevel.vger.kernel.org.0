Return-Path: <linux-fsdevel+bounces-42010-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA817A3A863
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 21:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA92E3B443E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 20:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71E21BCA07;
	Tue, 18 Feb 2025 20:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b="ZYmSkLn0";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=juniper.net header.i=@juniper.net header.b="Dc71V5xD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00273201.pphosted.com (mx0b-00273201.pphosted.com [67.231.152.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B0E21B9D5;
	Tue, 18 Feb 2025 20:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739909250; cv=fail; b=WuFp++tT6rcvUfRt0/oLNCD2jrzh+a856Lew8WGtLRYhinmFH9bZfNS1uFtpf89uIqlXasRwtDh8ZfdXB+ZEYzQZRer7Ndmtdo/Hc2wjDo6W2B5AUVjnC+o4zZMH57BKlO9RRi8iSoCXyFjPJAjZvAJp/ld1rxkMqI80jyb69x4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739909250; c=relaxed/simple;
	bh=b9/3xmuu3KoBAEcnP8jDskbeGgJKKikRh2svxwq5mks=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TcwJtM/ijNLTwZFdupfwGzuuTTk83wiXVTi3NRa9Y75LCN8eN8j8iJl5Pc7HzOxUrx4KQoAbF8Jy2XhiUYqkRAOFCgb6I900TId64gu+LXK/z4NbzzEQs4Acd1wXB+rsXT1CO41uTBImqrnunKqurxFAMXpJ6thribh3feQe+8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=juniper.net; spf=pass smtp.mailfrom=juniper.net; dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b=ZYmSkLn0; dkim=fail (0-bit key) header.d=juniper.net header.i=@juniper.net header.b=Dc71V5xD reason="key not found in DNS"; arc=fail smtp.client-ip=67.231.152.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=juniper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=juniper.net
Received: from pps.filterd (m0108162.ppops.net [127.0.0.1])
	by mx0b-00273201.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51IJ0Dut026049;
	Tue, 18 Feb 2025 11:53:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS1017; bh=b9/3xmuu3KoBAEcnP8jDskbeGgJKKikRh2svxwq5mks=; b=ZYmS
	kLn0zFgRx7maZg7y9NTJa5+nKA+4pIThSYBCEbTN5l+ZOlMehzlLDrm/UwhRnm6t
	TnAnQmHmvsMLmWv9J7h3CEdLfe2m7OgZHuSoYvlb3A5naiOANAALR85OXY0Tmf4a
	amYKYgZUP4sxgxj1vCYqKmYk4UIeqszSPZkl2GKB/qr8Pp15tIyV4ahWoiWHTdxf
	D4jx9E8eoghweuVLMW1EyVe3Aya0NtCkEyq6BbWNEwWR3RbIedzEaXBKlTbtDLJ1
	IkGcjeD1uYKzdGbmBA5q+H2b/c0Ko1FqcbBzC4F0v7qPpCCW43UZypUAuXT8cno9
	0PhSfEmwHdOJtfYrrg==
Received: from bl0pr05cu006.outbound.protection.outlook.com (mail-BL0PR05CU006.outbound1701.protection.outlook.com [40.93.2.9])
	by mx0b-00273201.pphosted.com (PPS) with ESMTPS id 44vyyug4nx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Feb 2025 11:53:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j+54jT83WsFNXoBr4YO1G/TO3DPQhDtlNnq0ILn8H7rwxEQikxRDPbGcnJK5V0o6tGdtqpTwpU9oxNhaVKMtImhCtBCI4BjTUEy3lxWO/0v8AhkSExVBZEviAwwFQnomZO+1BKJmst2rovA12t61tW/Afr4ZcjIIv0F0XT+Ug4JtJPlOuEioNoK1mjmGiErE34RWIyX8EY9sDIpd1+vXVSlTKupc52iCeGamE5nEPQHDCb1Dv56VWSei4pmtm5/GUTSsLbWpbiPs7ayLv/bk/kRaAl3BlY+fMCx5oLStQWGnM766pXfWQ9/+7xyKh73hsc6yUjajikkudAC3Vl9oxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b9/3xmuu3KoBAEcnP8jDskbeGgJKKikRh2svxwq5mks=;
 b=x/qvoUXxQ3xuyVGQYbXXPaK2kqaA1LJh7ydVdBjfyggfMb0Cgg7ElBXXIbKvTdGTeDdIYjtZzgIX1JvgzG9QW9+tR1bJajETi/SMSKF4G4ZHYgwLIPAw5aQiOE/JnPS5vUAsElbLzzNgjPSIu0+Tyf90n9khCec1IQeI3nsZq0LuCFmxSVvLRurE/YR+M6MBwZV0effJUJjINoF+2rMvS65kLafT9LCHhfPy4iLO4Y8W2zWhBI5CjzdOj919et+2zOE+awZVrGhhPy6x5hmaKnXbpw3k5M3FLt306L5/1eUbO7wteWI353ZxujYuImVDwvevNs7aFBfQ7HPSGBMIuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=juniper.net; dmarc=pass action=none header.from=juniper.net;
 dkim=pass header.d=juniper.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b9/3xmuu3KoBAEcnP8jDskbeGgJKKikRh2svxwq5mks=;
 b=Dc71V5xDlhRa27IyeQMB/iMjSQdTwILOKDb3bGkYZ8wOPq1d/BNadrv1+DY7UUdeUoov+3Q8bqz4eugr0GPe1PWs4JfYgW3p/OL4oqdM/TfyGCUuqkobE2900gFBVdISDmHO4sHlin7jbuarX8xIXaD3x2qkfFCfNHUXONWuCE0=
Received: from BYAPR05MB5799.namprd05.prod.outlook.com (2603:10b6:a03:c9::17)
 by DS0PR05MB9399.namprd05.prod.outlook.com (2603:10b6:8:139::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 19:53:51 +0000
Received: from BYAPR05MB5799.namprd05.prod.outlook.com
 ([fe80::e33:dc6a:8479:61e2]) by BYAPR05MB5799.namprd05.prod.outlook.com
 ([fe80::e33:dc6a:8479:61e2%4]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 19:53:51 +0000
From: Brian Mak <makb@juniper.net>
To: Michael Stapelberg <michael@stapelberg.ch>
CC: Christian Brauner <brauner@kernel.org>,
        "Eric W. Biederman"
	<ebiederm@xmission.com>, Jan Kara <jack@suse.cz>,
        Kees Cook
	<kees@kernel.org>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Linus Torvalds
	<torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v3] binfmt_elf: Dump smaller VMAs first in ELF cores
Thread-Topic: [PATCH v3] binfmt_elf: Dump smaller VMAs first in ELF cores
Thread-Index: AQHa6Cyyr+Pv/zK/REOrOTMOkQf+lLNN9PkAgAC4SgA=
Date: Tue, 18 Feb 2025 19:53:51 +0000
Message-ID: <39FC2866-DFF3-43C9-9D40-E8FF30A218BD@juniper.net>
References: <036CD6AE-C560-4FC7-9B02-ADD08E380DC9@juniper.net>
 <20250218085407.61126-1-michael@stapelberg.de>
In-Reply-To: <20250218085407.61126-1-michael@stapelberg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR05MB5799:EE_|DS0PR05MB9399:EE_
x-ms-office365-filtering-correlation-id: 637871bb-f912-4d2b-3d11-08dd5055f77b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YVRCelQwbDZ3cFloc3IrWjJTZ3Mxako4NkpTdk1DWWpuZ1poRmJMWTdZWXE5?=
 =?utf-8?B?OCt3NHpnQ0l6dHRySmZ3Y1U3ODVUK2FwKzdrTWdMVWZNQWlRLzluY1A5eGNG?=
 =?utf-8?B?T083aFg4K1IyS09YWUdRclZNWGJURkxKZE8yZjBBcDhEZjZ2NlBCVWhDbVlO?=
 =?utf-8?B?c282R1hQUGZHR3NmQzFIL1BDd2t6VjRCeDQzcHR5b1hoYWJUUTNPWEprMkhB?=
 =?utf-8?B?bzdCL2M0dzQ0TU9RYnBzL0lPOEkxOXRnTk5CaXptVFhLVnBJejFaaWMza0Fl?=
 =?utf-8?B?NVBFWWhPVkg3c0Q1eGtRN1V4VS9Mc1NWNmxVTFJKWEFWQVdiYnFlTTF3SUJO?=
 =?utf-8?B?NGZVNHh5V1ZsMzM4Rld2OTFZS1FISFlMK0lpN2NVSDIvcEUvRFJvcXJXN3JW?=
 =?utf-8?B?dFB3Z3JjaHRXMHdRRWRQY0p0SlhXUExNemdyRm5MWGloZ3cybEw1aHlRTmZT?=
 =?utf-8?B?T1AwTGlnTE9aZURUSHNtMXBrdGFPN1VLR0dtS1lEb1dBeHdweFZBS2lUbWVY?=
 =?utf-8?B?ZG82S2V4WndJYnovQmlRcWxXc2FHQW5UQ1piZWpXeHIxK2NaYzhHeHMvNXhH?=
 =?utf-8?B?b2lLNmJ3UXByODdaTU1rTEpPcWxYUHZyODFZeFR6N25uTUhVNm9CNFJYYWxF?=
 =?utf-8?B?dkxhTm94aUpqM2RCQVFYeitjYWNjSlhtTmp3dnVQZVUyNGh4ODRqOUJUVUhS?=
 =?utf-8?B?TWFiMzU4RE8yVmhrRHIwVWkwUUZ4b0xGMkhVRjFVUnZHYWRyODUwNVBiS21l?=
 =?utf-8?B?YUdBQXVUQXlISzdDOGFDNnJPWWV0amxuSDBvTHY3aDgzUCtDTlhCeTM0OWRj?=
 =?utf-8?B?Qjl5cXlSemxpS3JoUWloYmxqMDBGcDdQSTlXVHRmVVFOL3ZZRHEwSExGTUU3?=
 =?utf-8?B?RWltWnB4RDNSeXM3eFAwMnFrVm5kQmpMMWJZL0xkVVpyWmlVY1dHNGNWL1ll?=
 =?utf-8?B?L0JENE9IbGs4S0liY0JaWmZ6QklWUURNa29vdExIUnZRaWFFNTlUUktDZysv?=
 =?utf-8?B?WmNJYnZmeGF1b2kxRkNTNFVGZzYwMldwQjVpZ3Fob0xVTmxPckJ2anhxd3Zm?=
 =?utf-8?B?amwxMnRicTFGdkdIblJHNVhNUzBLM0lxb0tzc2doQWRubXNRSXlsd2J0QXlG?=
 =?utf-8?B?dkRZaUpVZE16VDRlN3VyZ3hQUm9vUlFMbnErZlljbENsMTNwQTUzeHIxb0py?=
 =?utf-8?B?bGdvc0M3V2lJS2V3ZXRjMVBDVm5zTEREM2xBTEZObXFQZEk0NUFmdktUc3FE?=
 =?utf-8?B?Uk04RHVUSmdKVXFHTFdSVjJGb252QUJQOWg0djBpeGRqbUdyZG0rNDh0dFZr?=
 =?utf-8?B?MlZlQWRTY3llaVdMMDQrNGk1RWFYcDRQSnhoRlhFY05XdWI4S29TTTVNQmY1?=
 =?utf-8?B?eWlZa3dCSWlmSDN1bkJha0d5MDJ3THI0MWUwVExON3kzbktFR1hQSXVqNHdx?=
 =?utf-8?B?Y1JMSEVVVDRJdlIzRXo3elBNOGltaXc4VlZ3U09ScEdQVTJCeWx3c0JGV2FJ?=
 =?utf-8?B?eEpOaXZDR0ZsbGxiVFBlMlBpTWJ2cWlXb0puM2Fkd294M1QzdDNzNHVReUtI?=
 =?utf-8?B?Zk5USUZBbkJhSUQ5cUZuZXVZR0UzV3g2WTVVLzhMVDhiRW1sTkhRcnFpb3Zi?=
 =?utf-8?B?dGQvL3ltRFJuZThlQnUySHhiRjJEalZxSkhsOUgrRVJEbHhoMzZ0TmdMR1FF?=
 =?utf-8?B?UUo2UkxNSEExZlFvN3pGN3dieENYRk9uM0lyRlFET0pNdzNIVG50UHM3NEJh?=
 =?utf-8?B?aFFxKzk5VWwzUndJZEhodkJiWXNPTkhDNHNRREJzdjI0czRhOHRBcmp0YTNs?=
 =?utf-8?B?RlhQOGh5NFlrdjZzVXZvZ3g0RnFETTBUeEY1VWlGQXVSUWtGS3pQOGYrb3Mz?=
 =?utf-8?Q?dftQqhYyeoLYR?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB5799.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c1I0dUhYVDY4ZnUzT2JQTC81K0p5RnZiZS9JQTkzZ1hiM1VVb3JQeXd5cDZv?=
 =?utf-8?B?cEdpbzVYbkdZNmc3T0dPb1JveExsdzcwUVRuRTBPNlN6VndnL0Rhem1oaXJk?=
 =?utf-8?B?bExwTUUzOUtyYnJNcWUydmtiZU1nUWNmdXhkc2toR1Z0QjF0bXNOYXg2R2pv?=
 =?utf-8?B?ZXNyK1QwdEtYSGlTbU5Sd041amQrNm41M1hsL1FiREFIWkI1ekl2QWU3YkFR?=
 =?utf-8?B?Sy9lcWxpWWRoWlI3M3g4OFRDSkNiZyt6TjhuaWM5ZXFMbTVleHg1ZGZnRmY2?=
 =?utf-8?B?a3BmbldNNVEvNnZldEczYUxOY1NyRi9WbWN3NEZpR2pIR3RaanZyemJldGhF?=
 =?utf-8?B?Y0I5a3F3K2FpbEd4VlNodk9SMXNPelFQSmN5VlpobzFLV2hUcm5oMVIrRFdo?=
 =?utf-8?B?Q1kvRkF4NXdzMDJrYVhqa0J2Wi9oaEd1MXEzdzRFLzZQc2JEbVFGenUvdGMy?=
 =?utf-8?B?N2d0S3daVVdQaWY3ZDhqMkorU09xd1JjbGQxekRmdHV2QktOWlRsc1JCNUY1?=
 =?utf-8?B?TzlMNFBCYWo4dWtMU2V4RTNwRzRSYmFIRDJJc2xNdFpsNldRdGd0Q01KM1Zr?=
 =?utf-8?B?K05DYWllV09pTmhtWHNaNGxZZUYwdE8xWERRYi9wcDZVZUlqdko4N3p6RnV0?=
 =?utf-8?B?TFBrNjZCL3dJSW1aRm80dXdCMlA4SklaZnoybll5ekx1N01KeTd1MWNxRGpv?=
 =?utf-8?B?MEw4dXpkcUlTUFIwVWxXU2c1c0xEdUM5UmViL05TTThodU1GejlkUG5tbXRr?=
 =?utf-8?B?QnhGK0NVdjR3RUVRSnhYM0ljSlRESnRaeG1adWJyS0xJUzJNbnprZGFGbWlK?=
 =?utf-8?B?azk2WGxIWlRidVNUMThqZm41WWt5SEdUdGdZRFE1dEdTcmZxaEZPajlaT2U5?=
 =?utf-8?B?T0VZaSt6SnJLL1ZacWpjcG1JKzR2TkkxUkk0YnkzcmNnMTg5Y2laZU1wTmdO?=
 =?utf-8?B?ejJOOHljRVloOE51d1czc3kvRmNrRnN5aHdHN3daeG5aSm03YURPMXphb0hK?=
 =?utf-8?B?WDJLbCtZd0FTRmFKbkVCRFNmdmx6YUVLSWw0Y2Jvd3E0TjFsc3AvZlJMclps?=
 =?utf-8?B?NUVyU0JWOTViWU9GSFREeFFsYk9TU3dPTS9MWGR5a3c2MmdXNzZRTjFDTGh5?=
 =?utf-8?B?ZWttTnZQUlRmVnZmcGIvdEE0YWlhVHArOXZHUTBIUVNKQjU3bkJyTjdaMmxI?=
 =?utf-8?B?MGJ5S1g4azd1R2RERTFhbmJEU1VpZEhUaXhUNEE4ejRKcWppMm42bGZtWlVF?=
 =?utf-8?B?WjhSRlFOemVPekVGRmg0c1Q2VUtTbnFjSHNEQjlOQk5tUDZsV1R4R1RMeldK?=
 =?utf-8?B?cWVucUxFZ09HelppaFFjdHQ4elZEZnNoWHUwbnBReFEzdGc5RkN3YWN2NDNX?=
 =?utf-8?B?ZXNRbzcvN1A1UnJMZW5kZVdmMXhXRDB6WVlUQkdyck5Ec3c5Q3dOUXo3YTBP?=
 =?utf-8?B?Z1JqN05tNlN4enY3ZkJxTm9TQlRrb0VYZ3VqME53VFdjSEdEb05GUDZIcUxH?=
 =?utf-8?B?bW1Bc3REa2h0R2N6WHBnU2dFQ3huVERHQjhvTFM3MS8rV3BjcXpLZUZqU2Y4?=
 =?utf-8?B?RzNtNFZya1V3WGplSEp5RTZQWHMrbi9BaU1iaXI2TXcwOUVWL3VMZFRNc1p2?=
 =?utf-8?B?b2RNMWpRSm9sYzhWVXJ2bHFsbkpMYW9IcnU0RHFDY1UwVHAxdUVwVkxkN0po?=
 =?utf-8?B?VjBqR1BrcDFsRXU0YVNBOEJkdklNb1R6WVZmeFRpZW1RTDViNEtHbHNZTnRs?=
 =?utf-8?B?SmFXelhFZWw5V29kTzBmbzYrVmVEb3FscEpMSDA1dkhFdW0zcW9PU0N1MjZ0?=
 =?utf-8?B?b01QWUFnd0lHVEI2WXNkU01YbTZKQklEQ0JXOVZzb0NLOXF2TnhSSG5KalZ3?=
 =?utf-8?B?bHV0MTAveklkSVVEQzZycDVLWjVxMFJraFZaamhsaTNpeHVEMjd6WG8wWndt?=
 =?utf-8?B?Qk00TW5WOWNBY0lnZkRrK1BYaWNJOWF4N1RES3YycG5JT0tuWXNTdE5hMHlU?=
 =?utf-8?B?OGVpdHp6Skl1VEpaRjZXVXNNcUZYNG5XWkV0c1EzNWlsREpYc0RUajh5Vk94?=
 =?utf-8?B?YUhKNFBqYkhHR29tUEh3c1d3TUFaaHRkczVzaTVtd2xHUnNBOWVDR011NWk0?=
 =?utf-8?Q?kRvNL/Oq8+CZ+MVzMq6Jx19FE?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BB022E3EF8CD074B8CB678E5E17B35DE@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: juniper.net
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR05MB5799.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 637871bb-f912-4d2b-3d11-08dd5055f77b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2025 19:53:51.0395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bea78b3c-4cdb-4130-854a-1d193232e5f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CyxywO+ECrLAVlnbW0bUWiyTRQgOZNZrDZ6pPAXepO1CB9gzH2s/AtTRll06RfgA9RlMdstQXCHpjVkCoiy+MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR05MB9399
X-Authority-Analysis: v=2.4 cv=LNicQIW9 c=1 sm=1 tr=0 ts=67b4e551 cx=c_pps a=yfQ+ne3pfVgCfke9fm/9IQ==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=T2h4t0Lz3GQA:10 a=cdyz6TIjWnUA:10
 a=rhJc5-LppCAA:10 a=CCpqsmhAAAAA:8 a=R2S0Cl6El1YswUm8OzEA:9 a=QEXdDO2ut3YA:10 a=xjj0GC5SL0ELW4ibpBgG:22 a=ul9cdbp4aOFLsgKbc677:22
X-Proofpoint-ORIG-GUID: oBk7soCH5p6yEo-8CrMjpG7swSIwGw93
X-Proofpoint-GUID: oBk7soCH5p6yEo-8CrMjpG7swSIwGw93
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-18_09,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_spam_notspam policy=outbound_spam score=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 clxscore=1011 phishscore=0
 spamscore=0 impostorscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502180135

T24gRmViIDE4LCAyMDI1LCBhdCAxMjo1NCBBTSwgTWljaGFlbCBTdGFwZWxiZXJnIDxtaWNoYWVs
QHN0YXBlbGJlcmcuY2g+IHdyb3RlOg0KDQo+IEkgdGhpbmsgaW4geW91ciB0ZXN0aW5nLCB5b3Ug
cHJvYmFibHkgZGlkIG5vdCB0cnkgdGhlIGV1LXN0YWNrIHRvb2wNCj4gZnJvbSB0aGUgZWxmdXRp
bHMgcGFja2FnZSwgYmVjYXVzZSBJIHRoaW5rIEkgZm91bmQgYSBidWc6DQoNCkhpIE1pY2hhZWws
DQoNClRoYW5rcyBmb3IgdGhlIHJlcG9ydC4gSSBjYW4gY29uZmlybSB0aGF0IHRoaXMgaXNzdWUg
ZG9lcyBzZWVtIHRvIGJlDQpmcm9tIHRoaXMgY29tbWl0LiBJIHRlc3RlZCBpdCB3aXRoIEp1bmlw
ZXIncyBMaW51eCBrZXJuZWwgd2l0aCBhbmQNCndpdGhvdXQgdGhlIGNoYW5nZXMuDQoNCllvdSdy
ZSBjb3JyZWN0IHRoYXQgdGhlIG9yaWdpbmFsIHRlc3RpbmcgZG9uZSBkaWQgbm90IGluY2x1ZGUg
dGhlDQpldS1zdGFjayB0b29sLg0KDQo+IEN1cnJlbnQgZWxmdXRpbHMgY2Fubm90IHN5bWJvbGl6
ZSBjb3JlIGR1bXBzIGNyZWF0ZWQgYnkgTGludXggNi4xMisuDQo+IEkgbm90aWNlZCB0aGlzIGJl
Y2F1c2Ugc3lzdGVtZC1jb3JlZHVtcCg4KSB1c2VzIGVsZnV0aWxzLCBhbmQgd2hlbg0KPiBhIHBy
b2dyYW0gY3Jhc2hlZCBvbiBteSBtYWNoaW5lLCBzeXNsb2cgZGlkIG5vdCBzaG93IGZ1bmN0aW9u
IG5hbWVzLg0KPiANCj4gSSByZXBvcnRlZCB0aGlzIGlzc3VlIHdpdGggZWxmdXRpbHMgYXQ6DQo+
IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL3NvdXJjZXdhcmUub3JnL2J1Z3pp
bGxhL3Nob3dfYnVnLmNnaT9pZD0zMjcxM19fOyEhTkV0NnlNYU8tZ2shRGJ0dEt1SHhrQmRyVjRD
ajlheE0zRUQ2bWxCSFhlUUdZM05WenZmRGx0aGwtSzM5ZTlRSXJaY3dUOGlDWExSdTBPaXZXUkdn
ZmljY0QtYUN1dXMkDQo+IOKApmJ1dCBmaWd1cmVkIGl0IHdvdWxkIGJlIGdvb2QgdG8gZ2l2ZSBh
IGhlYWRzLXVwIGhlcmUsIHRvby4NCj4gDQo+IElzIHRoaXMgYnJlYWthZ2Ugc3VmZmljaWVudCBy
ZWFzb24gdG8gcmV2ZXJ0IHRoZSBjb21taXQ/DQo+IE9yIGFyZSB3ZSBzYXlpbmcgdXNlcnNwYWNl
IGp1c3QgbmVlZHMgdG8gYmUgdXBkYXRlZCB0byBjb3BlPw0KDQpUaGUgd2F5IEkgc2VlIGl0IGlz
IHRoYXQsIGFzIGxvbmcgYXMgd2UncmUgaW4gY29tcGxpYW5jZSB3aXRoIHRoZQ0KYXBwbGljYWJs
ZSBFTEYgc3BlY2lmaWNhdGlvbnMsIHRoZW4gdGhlIGlzc3VlIGxpZXMgd2l0aCB1c2Vyc3BhY2Ug
YXBwcw0KdG8gZW5zdXJlIHRoYXQgdGhleSBhcmUgbm90IG1ha2luZyBhZGRpdGlvbmFsIGVycm9u
ZW91cyBhc3N1bXB0aW9ucy4NCg0KSG93ZXZlciwgRXJpYyBtZW50aW9uZWQgYSB3aGlsZSBhZ28g
aW4gdjEgb2YgdGhpcyBwYXRjaCB0aGF0IGhlIGJlbGlldmVzDQp0aGF0IHRoZSBFTEYgc3BlY2lm
aWNhdGlvbiByZXF1aXJlcyBwcm9ncmFtIGhlYWRlcnMgYmUgd3JpdHRlbiBpbiBtZW1vcnkNCm9y
ZGVyLiBEaWdnaW5nIHRocm91Z2ggdGhlIEVMRiBzcGVjaWZpY2F0aW9ucywgSSBmb3VuZCB0aGF0
IGFueSBsb2FkYWJsZQ0Kc2VnbWVudCBlbnRyaWVzIGluIHRoZSBwcm9ncmFtIGhlYWRlciB0YWJs
ZSBtdXN0IGJlIHNvcnRlZCBvbiB0aGUNCnZpcnR1YWwgYWRkcmVzcyBvZiB0aGUgZmlyc3QgYnl0
ZSBvZiB3aGljaCB0aGUgc2VnbWVudCByZXNpZGVzIGluDQptZW1vcnkuDQoNClRoaXMgaW5kaWNh
dGVzIHRoYXQgd2UgaGF2ZSBkZXZpYXRlZCBmcm9tIHRoZSBFTEYgc3BlY2lmaWNhdGlvbiB3aXRo
DQp0aGlzIGNvbW1pdC4gT25lIHRoaW5nIHdlIGNhbiBkbyB0byByZW1lZHkgdGhpcyBpcyB0byBo
YXZlIHByb2dyYW0NCmhlYWRlcnMgc29ydGVkIGFjY29yZGluZyB0byB0aGUgc3BlY2lmaWNhdGlv
biwgYnV0IHRoZW4gY29udGludWUgZHVtcGluZw0KaW4gVk1BIHNpemUgb3JkZXJpbmcuIFRoaXMg
d291bGQgbWFrZSB0aGUgZHVtcGluZyBsb2dpYyBzaWduaWZpY2FudGx5DQptb3JlIGNvbXBsZXgg
dGhvdWdoLg0KDQpTZWVpbmcgaG93IG1vc3QgcG9wdWxhciB1c2Vyc3BhY2UgYXBwcywgd2l0aCB0
aGUgZXhjZXB0aW9uIG9mIGV1LXN0YWNrLA0Kc2VlbSB0byB3b3JrLCB3ZSBjb3VsZCBhbHNvIGp1
c3QgbGVhdmUgaXQsIGFuZCB0ZWxsIHVzZXJzcGFjZSBhcHBzIHRvDQpmaXggaXQgb24gdGhlaXIg
ZW5kLg0KDQpFcmljIGFuZCBLZWVzLCB0aG91Z2h0cz8gSSdtIG9wZW4gdG8gZ29pbmcgZWl0aGVy
IHdheS4NCg0KQmVzdCwNCkJyaWFu

