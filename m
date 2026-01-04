Return-Path: <linux-fsdevel+bounces-72359-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD75CF0BD6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 04 Jan 2026 08:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 19ADF30146C8
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Jan 2026 07:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1362F6918;
	Sun,  4 Jan 2026 07:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="pCFhAJ4/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F699944F;
	Sun,  4 Jan 2026 07:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767513435; cv=fail; b=AQZvQ7/vKD+EOmwhAtudhrcSt3+tF9pIuPKjheHtbefYovZBpnCMFFchVL4EHzfCeIyi9XxfdWCUx47/KSyPOWQq4MufvZPx9DBUBGCr89bjxAxyp5xkEmbFzL8CjPIlxTEpPwxxb6dJc8+RAdJ8VZbsoEnaRiD+/dUCHThYAV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767513435; c=relaxed/simple;
	bh=HQ19ipK8CC6yNcXlFFjz8qa8smj9N2RAhDyQmJKjomE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E3PZuN1V/ptcapTtrYCvDWcFoQAfoCVGuKucmmm0Yg5H7dNKKqTZ2xa/1CoiLaWXmlUZj2uPF/wKCqYiGerJfhSmlngoSowYBgBEntETVZmUCf+FUsw7G46z6GbtOma6sgbySYiQqZN/01Gb0J2ikcoRGNIUiu0uFmeyvI3QQRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=pCFhAJ4/; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209322.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 6047oAZC017558;
	Sun, 4 Jan 2026 07:56:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=uy2hy87
	nEN3n1tiRw7pFBI79pQk4TULCoOgQsS8uiqo=; b=pCFhAJ4/hi/Lboj2xAbL4Om
	zrM0ORJE5gK/wX7diN0I18F+FdbC+0Y+UYNQ78FN85v67YIYOMQaY/a0y/31aRsD
	sBb5f3DsAdgt4RGcOle9nvYWqKmoLKSvZbFW2yVoIgDzFDhC7mQlsgi5lqy+5u+w
	Y6Kf57CBfqqyVXR4bOrxYsXndfSpKilpeBKbBEOoNW3QmGM92HBGougUDDHCO+sk
	FbItbGok0Hf7qC0B5Zo1S8Oygjs4Fsa7q4bevntibE+PbEQDynD/CEbWjV0oNI79
	PfA06HheNCaD0PE2NYUshv4BmL39gsZWa8U3TPI3JzUVpqWOhuCa9+YfZober+A=
	=
Received: from tydpr03cu002.outbound.protection.outlook.com (mail-japaneastazon11013033.outbound.protection.outlook.com [52.101.127.33])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 4besw2rsug-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 04 Jan 2026 07:56:28 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HWksw9Ia3WWdt72g9AVunTcz53ZBQgpcOk3ytCVT2SgeSYyGsPNIS3C1rd6a071++9wQxlIBDwfMU4YY3dIs2VfokETCT8bRCHsuNLSEkKBXCCcfGcwS4PIZcedW5FkCdbmSuPUMtSKANiEOkc9YXyw2JZj/iD01VskULJjAw7NewsIiQPx9x3Ma4U9mS2NOejS+AekyLuniA5Aw15pipyRtXMkWXEzt58nvikv/XG8xUJJ02gVFmUbxUF7kvzvkG3qrabghFhlzP8vrpoaT4vTlxdCzcHED6w4zoNg30NBUuHWmZRX+gQiL3DZ9XiqU7xmaOJzAvpkARYZwAnyUTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uy2hy87nEN3n1tiRw7pFBI79pQk4TULCoOgQsS8uiqo=;
 b=cqTWI+t4O8MTYjjNueapYwv9HOiOcgCh1QzEf098rF0qZJAFHfEtRIjYqSh4dsvpqleGnPXBNZF/KqrB1UJSqgP3PfnkZIw9WVbEoJlMUfekbPoWjCdMPVk1SROosidgu/rIAIZq6YJNOgLzkvmoo9DVPy3/YI3NRVrI7oIX6sqqprYVDlt/6fB+V1+wjYRw/OOtMCVvm721FFip+g23Mw81YecqGo41bKktA/+gq3lbqjntnInVTBWpkTORMWJZx/+93UDyVlIqieeIicgcixW967npRoJM+prp67LouV8N6J+euKZo3W029bEndmyKwKQWMHuygpESN9bLZk5iqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by TYSPR04MB7274.apcprd04.prod.outlook.com (2603:1096:400:473::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Sun, 4 Jan
 2026 07:56:22 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::a631:6b1a:332c:831c]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::a631:6b1a:332c:831c%5]) with mapi id 15.20.9478.004; Sun, 4 Jan 2026
 07:56:22 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: Chi Zhiling <chizhiling@163.com>
CC: "brauner@kernel.org" <brauner@kernel.org>,
        "chizhiling@kylinos.cn"
	<chizhiling@kylinos.cn>,
        "jack@suse.cz" <jack@suse.cz>,
        "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
        "viro@zeniv.linux.org.uk"
	<viro@zeniv.linux.org.uk>,
        "willy@infradead.org" <willy@infradead.org>
Subject: Re: [PATCH v1 9/9] exfat: support multi-cluster for exfat_get_cluster
Thread-Topic: [PATCH v1 9/9] exfat: support multi-cluster for
 exfat_get_cluster
Thread-Index: AQHceWR4L2gswImwWE6uvNkpmwBpsbU7CWKAgAaVBPc=
Date: Sun, 4 Jan 2026 07:56:22 +0000
Message-ID:
 <PUZPR04MB631627BD83F409B370337E4D81B9A@PUZPR04MB6316.apcprd04.prod.outlook.com>
References:
 <PUZPR04MB6316194114D39A6505BA45A381BCA@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <d832364d-02e6-458d-9eb2-442e1452a0f9@163.com>
In-Reply-To: <d832364d-02e6-458d-9eb2-442e1452a0f9@163.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|TYSPR04MB7274:EE_
x-ms-office365-filtering-correlation-id: 5ccb201a-62a2-449d-9e54-08de4b66c0ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|7416014|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?xj/gNVHIoRIMoHYQnSRRAiMNcCe+tJ43oWxpfodDzy3pr91uXbWL9d75iu?=
 =?iso-8859-1?Q?UrZmJM9n+YAYJKSKyj/5HOLUSIbsVjNv1dS7JBxt11iALofrumbSE1H3K7?=
 =?iso-8859-1?Q?lYZLTYEjUt9lDT4EOghba7LguoSc/dynWiiDH916uH4vHFpunwCbZyckyC?=
 =?iso-8859-1?Q?WqiORjXccWbfMNoG6i2DH9CyiJ4sYzjSTdAaTJYBI8wfqDxSYiT4NAuTkP?=
 =?iso-8859-1?Q?GvVpCV5WoZlZk9E09iqiwYDrfnv9uY4l/55dQHMRNv1c70b89GT84WX1q5?=
 =?iso-8859-1?Q?MLoKOFnlSOBtwS4bG3vFWKljmMvvcfdopHjhGziDS3JCHVqrQYCNfw0KhU?=
 =?iso-8859-1?Q?DIKA0ZKoK62v8NOYb7EWXmpghkdrxgdmQLINsXRWSl6KX7C4gKtMLYEOhh?=
 =?iso-8859-1?Q?o83GrI5t3m1GYKJWfbQ0FC0BEfjwgoun96Vthdr2Qnt/c5ZJxaroHwwraV?=
 =?iso-8859-1?Q?FExMGZ9dikzQm6bn1WAdTg3suoey8uMQs2d8FbNiueij82II8j+NzegJUF?=
 =?iso-8859-1?Q?CgHz2Br8Nx2TqGHtta29a2DOr2gnpm9N0ZKdgmHXhW2AHBHHxcDzIr51HM?=
 =?iso-8859-1?Q?FyA6gguhGyMZkqbn5XfpAK/i5YNEkDJy+Y6hv6HiMsWpaQjJtD7NsVYN33?=
 =?iso-8859-1?Q?/wah/y5TBeALZsb3uRPhuU9AM92rIDxr4Y7r9qZVeoKn7DnsmbRM7ZH4FY?=
 =?iso-8859-1?Q?kIiAQK24G6jAfEPyk0xcJSFKCtKndcX0eEv76hF7EjsJ+z7Fdd4LFD/xt0?=
 =?iso-8859-1?Q?AejpI6YL2rYDwvKqM0vRXjmb+Qe5MUBUIGQVbOp7j7ebBUVE/IACRRVUkD?=
 =?iso-8859-1?Q?ZaknHexPBwdRmyL8eFWaQh4PafRVnba3Z6qOYyQ8puNg6/omvODBn8OqoM?=
 =?iso-8859-1?Q?uHRvkpbWiHwCmXgMmgvYM9aRtllXHztcFcem9zBKVUICK5LX5D8Yc85qPP?=
 =?iso-8859-1?Q?WGJWp2Wss0T3yo80wIdidBeMl/ijXxY5+cm6a0M+bFYp4uupLBK57jAnr4?=
 =?iso-8859-1?Q?mecwQaRrDb/Ks2LmiqM35Pi/9ZW5iZeGcLVB/UsXq6ExNTfYC3ONT82nBF?=
 =?iso-8859-1?Q?TuM7TNovrUu52UGbapxTceiGKH2VPozGoKm+3Rb93gWBfhfgpBoiy+q6aB?=
 =?iso-8859-1?Q?/Iz1B/OSy7y27d1Qtg5361QJn5gb+Np7riEY+8UrLtw1wOpaNrr9x/ngUA?=
 =?iso-8859-1?Q?gQQkJKqLsc7YuM9StRu7zKf1/QxO11AQLpy7RT7kGw64nu3oh8XQKaD7+b?=
 =?iso-8859-1?Q?7ZdTTBS+yZVlxiRw5rsc5A0z9ZfOCjmRuRID2rpwwFRiG8Fs2LgchcKW+W?=
 =?iso-8859-1?Q?/McctK4h5V9MQDZDWHWHVTcE3iT31CMbKBAk90peSgI79wk13idahSs59u?=
 =?iso-8859-1?Q?AsFerGliLbpgMVvwtmZBFhmDX5ZLCrDbTNuhGJeq8dMgAv/RESM2KK1JgV?=
 =?iso-8859-1?Q?AL+fSGeuVjCoNLQPWsfdj62WlOW9JC4DyHaRJitWjict3RuCmmNdatTG/5?=
 =?iso-8859-1?Q?7Q4MSjydy/8fAus6bJBsqO9yncsBHTGTW/DliSF1AY0GDwGujgsnzfrCuA?=
 =?iso-8859-1?Q?gDoh/jzjvNkQLmWqQJVlZbp40PoA?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?1AKl+iYxs0mf5/6NWdnSiRrEvvtv/nHAiERFLUZXckwqdlER0yJ+iWLwkh?=
 =?iso-8859-1?Q?Zxe2+DkbxPVqL4Kzj9ZhayDYHRWEdQzp2f2j/WIVN/plr5lYuesqMawKsz?=
 =?iso-8859-1?Q?BKPJ+alcTAO7bNUcmhpEOXLT/cdOAx6hgJpXd/nb9sFv7aqLmwd5C9Y5F5?=
 =?iso-8859-1?Q?iFlz1XxrVWJodw5NtIftzZTdsbQx5tKYNSIv3L221MUHjEz9QXvx/+KVaJ?=
 =?iso-8859-1?Q?c+mw5AJpB5rseDUz2N3JqYSd7hgLD9em+foAkgw1T2lF5gOU4TT6DPUoXp?=
 =?iso-8859-1?Q?UhdE0XwGyXMqovqvhHPHw0qje96EVhKlAQHAq1TqOAyV42QmRnyvOnngEg?=
 =?iso-8859-1?Q?6+8CNI21zvzivvKAayG3HzEajkIAuy17eIgIwamHz0qaKlX0BHmWFAb10P?=
 =?iso-8859-1?Q?S5DLIqr/tjSHJ4xD/V076Ujbz6tczq1aJqPD3i+qFz4YJghs39ruKMK0ZI?=
 =?iso-8859-1?Q?/Up9cApGpdoLKnfN1rR/0ox7hI6NOlHIvXpS5Q6DT1WT1C2pyB42DV5Ytq?=
 =?iso-8859-1?Q?dm/Vjh6/0mWo3EnOTspt/OsTyglVwyQWxgj/TT9M53/Lou55RPnnnXl9qc?=
 =?iso-8859-1?Q?+eR2Hwsty8IWRSdTQnZPYNS1Cwc7R6+aehM2qluESXI3WlLUYib/PQAcBj?=
 =?iso-8859-1?Q?8KOHcCZfPwxl1e+cIiSl8ys2bwMqvzKZ+/v+PZDr6iq+b1dYnDl/+k2oPc?=
 =?iso-8859-1?Q?o46v4uxE3vq3QccuRZaUhz8WAs1ZWeEtAzYK5M535qMqgwfpq3aSj6jFFB?=
 =?iso-8859-1?Q?YTRG9PKJtXGAgpERqh6/23qDzgtu5w2gFoIsGJD5mz07lYdo6a2hRhXKiY?=
 =?iso-8859-1?Q?It+uKFzPOPOl9tYVq5iqucggPbBHnwGhvM1J2UdlljM4QzLT8RhMxDp8Mo?=
 =?iso-8859-1?Q?Qoi//fRoQTjRo659abGmY8lnTBiRD1GIOTc8YfzgoRBkg6T32qLelm4RYM?=
 =?iso-8859-1?Q?+hzWTtHWmxkHpDf15juKx1L2quCp0udBZoNBHkrfmMJn9FWSsoT4JIZ7AL?=
 =?iso-8859-1?Q?X1ORslUbdHVP+pFZd4Qbyt0NflUlWBtgLkYb05La5X2YtynJZAILD/1vJ/?=
 =?iso-8859-1?Q?bdT2m5fVqHQMb6KfIexoVeraa6aga32HdqXKKOgrz76yhbDy8j9v2v0J3Z?=
 =?iso-8859-1?Q?MWD5TOFzcEoB7htYIGMrQz2VlH6Ch15IBx8fGGSmXLUZRXYjuXMBMHuJW4?=
 =?iso-8859-1?Q?orRb7v1RYOFiDQYGJKR/Tt90HZm7ru+7ZcwKR6C7hv4HErL7t6ejzvXj5I?=
 =?iso-8859-1?Q?UhfT8m8Qi/bxFBB/yqo4ix9tQogOrHul7DnbOfNP+ZgjXiw3OzAaFFTY5t?=
 =?iso-8859-1?Q?86+kWIH9iBEQ1h56XOceTwEbgDBFIRsY1TLB2auPN7/BTD6u6J90+lWI73?=
 =?iso-8859-1?Q?PHuiOTQ3gypyxDoS0vEwtM5jzaGmpmOEI6zZ9oddXVKjP5WHb8xE0vgXHf?=
 =?iso-8859-1?Q?zzMT4rYCBFRSpQt5pCboK1pAUf/D0ClJfSY5QRvF5mAwXojeuKFuGZ7loD?=
 =?iso-8859-1?Q?2b2aJb/Lj3EuMy+IPflPs2ZouqbFh3Nh3fVWtOWCo6decGLNK2HB0RW7L/?=
 =?iso-8859-1?Q?c7ikeFpLLxcTC3qjsdzYrmeC8HCim7yezmCyzOUhWIWAAjdrQMJGYU/dFL?=
 =?iso-8859-1?Q?/zg1HftGnnh1p5NakCdQqSqJCYn1EOvmx7zUoLl1tCbGYJs+Gjdb6AjPuY?=
 =?iso-8859-1?Q?3LQIp3QIr1s3t6pTefph7eDsHhxCuswQu7yHzSM3R1/qbuDPl+wpubSK6q?=
 =?iso-8859-1?Q?WMK/Sj/24oDc7yYf/PWSBFDSO9tZnOwqbn0C3rgaAoTgMhL1PrNupCjuoX?=
 =?iso-8859-1?Q?ALSfepN0fEkXZ9Yjf7NijDt8OvV6TAY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TNO8EcWgeNa/kk4JnOfvY+BnBE5uhQJCv/mUX69kLTZWFqP6QFlSdvSMm2zgOMyvBj5f+RnHvJNgDuP7LFC1wQQHCTvu85EMzN0uvFk6T/r52fP4e5GxBdFJVLIUk5DapY9m2qDMbZyr29fnoaOvRFFNGndtKmSCBpwr219KBraHaZiM9JMh7/DnLwE5JpiuCj8kO/1WF1aX6U4vC9AcSbPSxpCju22AlLEsYwKB+FTb+bdfF9DyXzcMqG5S0KNzuXYpy70zV/WaZg8M4BCoHEH12l1FiWCAmFoFH+A215rpBQ6CS6mLA/3HYuMEOmvFNTv13/hfiAreTdbpkvrLgJYbZXXlWa+UgLJDtinb2k+0lFtMt//eeEGcCugiOa05FKPTJNS+zHi4sX/TwNyvORUs4pDnEtfnAHNFLC7dfdmwGfDGHSEJfJRiwKuIKdCZCz0Hgfl9PrDW/JMTM70p2Bpy4IMwL1qZJxcTViAP5ANsB8GeO5gBDQyIbLUWGzsa6ALfMwvhliQ3tQDbwWPDvM1cbcHzU+TLv25HXTDoMi6xGbK5K32HsX41N6Q8fhsP4TdrM3AUzzVvaVREUR8ckkQsbbOjkAI2RYHUUVIIQ2uZ7pN8HHNeANjWDJxdWU6w
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ccb201a-62a2-449d-9e54-08de4b66c0ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2026 07:56:22.8522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1gFBhYl/z2sWcCxBkeFEfZL7Li5oCs/DluHrJF/H95ZXztWoxG+lpyatMekPs1FbPSTpQTHNocCx6AaTiYHagQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR04MB7274
X-Authority-Analysis: v=2.4 cv=P/Q3RyAu c=1 sm=1 tr=0 ts=695a1d2d cx=c_pps a=AV3VLuJWgg5JCmondQPfTw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=vUbySO9Y5rIA:10 a=7j0FZ4iXMVMA:10
 a=xR56lInIT_wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=z6gsHLkEAAAA:8 a=AEFdySdFzCt3eBlzStcA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-GUID: mnUz-SjBLHcRQDm3SpoCSXayEfSrlnmQ
X-Proofpoint-ORIG-GUID: mnUz-SjBLHcRQDm3SpoCSXayEfSrlnmQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA0MDA3MiBTYWx0ZWRfX4HQ6qsHzVzIl 7h0nmEzoZp5xxJVul9LGp1Uma6ichnM+mdP4X53UMgTIJFfz7jFZjvPaMjX9PY+bR6377DrhC+f ACNA36x+aKVdlOJNDLKk7DJuwaESYwtxM9EN1Nz7IeY9AgdjLVT+o1Yd6S/KdZtpd/ijZ0EbEzW
 DP6hCcgSaVbz02SlJGZvKZq1YJ/ldMJQUA5s0tKR1MhQu0bCb67VQ9jK3O9eB+CAGu/ecLKgUP9 qSlUC01AHObiI01SYLSzt3Dhx1EjVahimSBWCFUlMDsvvLHcjnrtKRn3UMzVNvdfUft/ZokLVoM eSCjWlUB4uJAmTYtsocTeIXrFEPUUY+V5IL3pa8pZ73mkf606g5omX7rWtZlyKwairjR0jYcmA/
 AKSwk66XGP/1vkApAodUz9BeiImYqyUYQMRvJC7OkHdXNt9xZ7e09BP2JfIhKxQlDgdwhAhdLyE 9ANwOHdIbtM+gVg0lZg==
X-Sony-Outbound-GUID: mnUz-SjBLHcRQDm3SpoCSXayEfSrlnmQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-04_02,2025-12-31_01,2025-10-01_01

> On 12/30/25 17:06, Yuezhang.Mo@sony.com wrote:=0A=
>>> +     /*=0A=
>>> +      * Return on cache hit to keep the code simple.=0A=
>>> +      */=0A=
>>> +     if (fclus =3D=3D cluster) {=0A=
>>> +             *count =3D cid.fcluster + cid.nr_contig - fclus + 1;=0A=
>>>                return 0;=0A=
>>=0A=
>> If 'cid.fcluster + cid.nr_contig - fclus + 1 < *count', how about contin=
uing to collect clusters?=0A=
>> The following clusters may be continuous.=0A=
>=0A=
> I'm glad you noticed this detail. It is necessary to explain this and=0A=
> update it in the code comments.=0A=
> =0A=
> The main reason why I didn't continue the collection was that the=0A=
> subsequent clusters might also exist in the cache. This requires us to=0A=
> search the cache again to confirm this, and this action might introduce=
=0A=
> additional performance overhead.=0A=
> =0A=
> I think we can continue to collect, but we need to check the cache=0A=
> before doing so.=0A=
>=0A=
=0A=
So we also need to check the cache in the following, right?=0A=
=0A=
```=0A=
        /*=0A=
         * Collect the remaining clusters of this contiguous extent.=0A=
         */=0A=
        if (*dclus !=3D EXFAT_EOF_CLUSTER) {=0A=
                unsigned int clu =3D *dclus;=0A=
=0A=
                /*=0A=
                 * Now the cid cache contains the first cluster requested,=
=0A=
                 * Advance the fclus to the last cluster of contiguous=0A=
                 * extent, then update the count and cid cache accordingly.=
=0A=
                 */=0A=
                while (fclus < end) {=0A=
                        if (exfat_ent_get(sb, clu, &content, &bh))=0A=
                                goto err;=0A=
                        if (++clu !=3D content) {=0A=
                                /* TODO: read ahead if content valid */=0A=
                                break;=0A=
                        }=0A=
                        fclus++;=0A=
                }=0A=
                cid.nr_contig =3D fclus - cid.fcluster;=0A=
                *count =3D fclus - cluster + 1;=0A=
```=0A=
=0A=
>>>=0A=
>>> +             while (fclus < end) {=0A=
>>> +                     if (exfat_ent_get(sb, clu, &content, &bh))=0A=
>>> +                             goto err;=0A=
>>> +                     if (++clu !=3D content) {=0A=
>>> +                             /* TODO: read ahead if content valid */=
=0A=
>>> +                             break;=0A=
>>=0A=
>> The next cluster index has been read and will definitely be used.=0A=
>> How about add it to the cache?=0A=
>=0A=
> Good idea!=0A=
> will add it in v2,=0A=

