Return-Path: <linux-fsdevel+bounces-69341-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 277E7C773BF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 05:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id CD8A5292C0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 04:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F002EBBA4;
	Fri, 21 Nov 2025 04:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="h46bM8eV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C730D2BE05F;
	Fri, 21 Nov 2025 04:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763698398; cv=fail; b=Li7Qe1/xqx8Lm2Wm/l5CUxetjcH5a6xbHw4Hvf5GmWzsmR8bxvCzFmZd0FK/CdhV1A9ULGduuzQOHuYMHe+D0D5/6cOWpAGEuoaxpmIG4MtycvSgmQyD7LTfevKN/aMMAMs6MUJFxY7pZFdKmIZ4Nl25L5+zJTY1EeQtwsJrVIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763698398; c=relaxed/simple;
	bh=3a5ke1yUrPBNftncwZEzYhHxKw+0Iu7dh0vSDDixYTo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Tafa6ZCj7ghj5tiCZ8yrJJp6xgXtmokdgmqhxPC+F+OFamS2pKOG3cBT/HZYOs1y4wwamGwN1ZoP7NIel92tRQK/F8UUN6LmbD6WZuIzEirDxuGehFx574/s6wWS/v579OVM3wZHFjzCdMQezD0Xbj4fwbsYF8Pvccmk+dXEcEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=h46bM8eV; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209319.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AKLYa0g008735;
	Fri, 21 Nov 2025 04:12:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=TZt8ov0
	fPDnbb+Tjv4qHxoXv0guUY/BTkJYAfHFipQ4=; b=h46bM8eVpMbspkMaglObHNT
	u0ypdSf7N1nSq39hX40oxJ14Tufp6mAUjEkdrBQAxzY1ypfv7LOKGlGyZhXCmxIM
	wOav2JOAaL3vqAJRTteIcYmHTupMK3CBhDJ0civZ6h3DjAmqlBVBXzhjGDLFT0K+
	HSJ1tAdugvsTLJ0CaWCtLhfmwonrstbuQsQlDiagfhhdKkpq1B1X0xrW8lMA155f
	H+K+oyeaXPm/t2OylUEP12FZ8d3OZB9LMHIADPHfnlZHfuHT/WzgEt/46sDirWpp
	250IYpOR6pQjei3Zu9TpXI2W600w15BgdeVtOLVO3/dP/SRcIT2b9D6nYW6CuYw=
	=
Received: from typpr03cu001.outbound.protection.outlook.com (mail-japaneastazon11012042.outbound.protection.outlook.com [52.101.126.42])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 4aehwrfuba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Nov 2025 04:12:56 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YN/QdNbJ1SzR2o5XSH1Pga6pp0CpZ2VoVDOF14shvLF7rFwf0wLonDozBQD1HVIQ2xbQ+oyeRrWCKsH2tMVzfvIc7R5CDJbHmAjPmKaokb6yD091P7IUGDfxnW0ICIpXTOl+yJk1REE7XylheFOEQ21PmO7faRZel6c1L+hbIG36fWwbPvx8dhL9D/mesT0oDxxmvJAEVmOGv0TAaH6wPjrqjkkuWU922slD+EcpPzXpI7ME6uw4bGqAaV1zFAXG/OrQIped7PRNsXCXEqTv6raLE6aEYQ2uSMImyT44U15zy9Bso/o2d91r3ynHmtYPi+aljFcPlnbI+jUPKgQC5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TZt8ov0fPDnbb+Tjv4qHxoXv0guUY/BTkJYAfHFipQ4=;
 b=u65WJn/sOXRi/HeUsggb9YJh3R8Y597jv6SlybeSKsz0iO2UejEbO1faqHNT+S0vJ66QrnepAuz7mV4ebi7wfEqzQ1obNezt64OFON5NpUumbmBPVay4SBtrieNxtX3U5Enccjwx1WAP9xRrrAv+jdyk3RxwfzB1EnSD2POrNT5xc/2YloZZz6ega+9lqoRLrgrYqANeYHtQUWAj1sfFok3m2mE406/NHajE3SBK6G9rvnrf6am8T+QRWkIqziryHGj87AmoqGonS/ZRvqyhT2C3mh5XeLEl8IS7rRtROLVdoz4sgNBm8m5heKFnmqPbuEQp0IXiR/w3rKLcONKatQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by KL1PR04MB7711.apcprd04.prod.outlook.com (2603:1096:820:13b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Fri, 21 Nov
 2025 04:12:46 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::a631:6b1a:332c:831c]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::a631:6b1a:332c:831c%5]) with mapi id 15.20.9343.009; Fri, 21 Nov 2025
 04:12:46 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>,
        "linux-erofs@lists.ozlabs.org"
	<linux-erofs@lists.ozlabs.org>
CC: LKML <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "syzbot+31b8fb02cb8a25bd5e78@syzkaller.appspotmail.com"
	<syzbot+31b8fb02cb8a25bd5e78@syzkaller.appspotmail.com>
Subject: Re: [PATCH] erofs: correct FSDAX detection
Thread-Topic: [PATCH] erofs: correct FSDAX detection
Thread-Index: AQHcV7lntgUlqvJ+yUe/xRg+V+TUALT8dhoC
Date: Fri, 21 Nov 2025 04:12:45 +0000
Message-ID:
 <PUZPR04MB6316EBBEFB9F1878D1691E2481D5A@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <691af9f6.a70a0220.3124cb.0097.GAE@google.com>
 <20251117115729.626525-1-hsiangkao@linux.alibaba.com>
In-Reply-To: <20251117115729.626525-1-hsiangkao@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|KL1PR04MB7711:EE_
x-ms-office365-filtering-correlation-id: 59333d9b-8ef7-444e-a07a-08de28b439ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?U/4WH9tz9ctJ3iYTSwJkyL5c6awzMfrb0Dv8yL1DUvNSngjW9vzHtyDil3?=
 =?iso-8859-1?Q?rzHydyip611VZoYHZoRDHfNZPHktdrHsyZYloNVPVDQunX3qfbiaKxvGox?=
 =?iso-8859-1?Q?r29A62nszPc1qipTkcMALYWb6rXJ9x9WskF7nq9Ic1jHmvdsk+M8KYpMrW?=
 =?iso-8859-1?Q?PexZGqAHDvzMzrokSObEewmJJnpjEQPdbCiST/AsJpEagFGl6GXXk2wm3u?=
 =?iso-8859-1?Q?bMx4q25DHZ+UyOhzcqXKohDaGkBY5CqMiomo24shYnh/28Q0UKu6v4Clj3?=
 =?iso-8859-1?Q?LNiT7VFqkV8Co7azpiYSdVD7FXyp6JG+6wCEZK1wAl3ZD1nE7jtEAKKG7t?=
 =?iso-8859-1?Q?aniZnusA1fN4+rFkWdPerXf/rXLomI7kLagxIEzeLYyDpkh2YzMBu5niYL?=
 =?iso-8859-1?Q?zvV0WO2JxkiSh84k2u56Ob7tWFY2TiXhHWYEaFjqcLK9tWfgICB+U0pcV9?=
 =?iso-8859-1?Q?G2MLjWRBoFmeH2fJNxM9idv7GgTitj2n+Df2o8S6Na6eLnYM9D3S0WHks8?=
 =?iso-8859-1?Q?wyzA7SkVvyqai1fwWuMKhwrDBeHUJMh+D0TRXPr8a6BO64Cwk+kw4OU0m4?=
 =?iso-8859-1?Q?G4TVZ/Wc0gCq8GYZAN37x/P3h3Hzzm+LDN6XDwxWbss8PzX1kdQSkfbdWG?=
 =?iso-8859-1?Q?hkj/hvAA4Yf4gyj7mH6MsalmEXO5Lmdigs691j5tacDCTQD6ANLEs92MOs?=
 =?iso-8859-1?Q?JlJnDMywipjGdcMMtSp9dUpCFz+NfUdEcfelqrZwlcXigXQ6Dz0MrXc0EN?=
 =?iso-8859-1?Q?49F4m+ctR9qC/3GgDLHgWViLVUVf4S2Q/e2nTkV4iDjaJWVFerec7HYPxR?=
 =?iso-8859-1?Q?YcZa7r6gRz9MnJ0MP9jXMGNgZFlKfbMRpToIWPyE62/a0A2N0hekFtdSf6?=
 =?iso-8859-1?Q?j9IoKUXFPoSAzPByTA/KjCNbZxVmtxbNCCfpgFl+nwq4ZYahZErbypaJfw?=
 =?iso-8859-1?Q?0vLw0Ta7oRE5LWs4JdPdktHL4bekIxKWpHYvXSvs4x7YUrSRoCfo2tIYvM?=
 =?iso-8859-1?Q?GBCWj4dqY6TtAEAZT3HQc49szYBr3IHDYYURUTm7obuj8RNxt5oIBnjsE4?=
 =?iso-8859-1?Q?QzwNav/GTJfkzStpBTv85PBt+M4tAUlUPXfdzDtn81jMlxsFo9Sgio81da?=
 =?iso-8859-1?Q?RxlPpthGayD/S76VA2MNrQDt2gH2xQ6so/ITxJhZzAnRHRzc6Xl0/1MLPR?=
 =?iso-8859-1?Q?Avdfljkz4CZYjWQcKgDbbdQ1r3G6/za3IsMHD60kaTI5PVoBZEIcKHC6cS?=
 =?iso-8859-1?Q?XkI78t4/6vEB6ghef7Fma7hCRsEvn0u/bJlYKV8LIkT8pV9Hw71e3hxxgv?=
 =?iso-8859-1?Q?KsdIqgicPzOozeL/ycHZaKyX8I0yCKabw8N7qmjM3cxHGiST1bjQxSTasu?=
 =?iso-8859-1?Q?371Be2mEi73BMGpDJo/JylA4Fhy8zGFMD7pHKYXo+/4ikAc/xJOL0KVHq5?=
 =?iso-8859-1?Q?UqWM9S4PlQR5lTE1hjVPQ0d6FIuSCkCEnvNGWqwyMtc6tEdA11v+aYr8ls?=
 =?iso-8859-1?Q?Bcl198YbFhYiD3+AhldPmLuoEHOAuGCrEIfsb2U5zLCn5lzCkYL3LYFQ95?=
 =?iso-8859-1?Q?52eeC5lKRqEfCb7axYWlswPXyxvu?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?bKKYbzsQD7QPZXmEeTMToH3IrvtId3OZm3M3fAK8OSh8HFK8PjyREQkLt7?=
 =?iso-8859-1?Q?YlBJRRzzBzAr0zeZDPv4DIi/20jM0ZKEwaDl1YfC1bcG9Vmsrh9B7pxHU2?=
 =?iso-8859-1?Q?XeFdj59WM/0Fu+LLipPME36sjho8EmWwniHz437pnngz/OpgyGT2BoFty5?=
 =?iso-8859-1?Q?9D00MCV4mZ1DWbQbyfrdegsm463w/+nwAhjAW/2RYmcZUqGHcpX9sDOBn3?=
 =?iso-8859-1?Q?z2FDGyvj5vpAlLLs/QwTdCOc/++ns1/c2139nMkClMR2p70YUcLAR9Of+B?=
 =?iso-8859-1?Q?8e5YK8h+zsJr7FdgXx2/Y05otW1MiIboluDrOjFR3kx+yTkLmLprsmhpp/?=
 =?iso-8859-1?Q?zpQMG74uLK2vqeigwwSH/+Ycb8ZQ7FFKMdzFnZUiBENvIkczp8tqhjsypl?=
 =?iso-8859-1?Q?ihzZ5NnExBuOmv6tksU0sPue85XGjsA0vu5uHjZPd2BSZtjeNwa1EzMIab?=
 =?iso-8859-1?Q?4gSmcO5om8oG57IHuqb7eBuZzgEXNhmNPxlDZBoZEFz7sjgfW2nA6rZyw3?=
 =?iso-8859-1?Q?lCiF9t9hmXANeZ1ads8ec35Lk7aOHwhU50JPO76bzSUybIlu0kIHypGEXc?=
 =?iso-8859-1?Q?SKuHHDazcIjmJYTR6Vd64NRyzT5zVf6Qpc6DlMjgOCQbxlmoEca1vctEze?=
 =?iso-8859-1?Q?jX4J8XpjTkgVFqdg1XhnHXyrGxp76ikRbgW7IgjPkpV+xo+vvBt8lDbb/T?=
 =?iso-8859-1?Q?9qjk+JGNs5uaY4Hgd/v1Ri0HWu7j5HKds/r0A6fd0EQ5TecLEi1XLWxlCh?=
 =?iso-8859-1?Q?9XPVTIDInMQzncSBu1TcAeEM9ovOlPn+Ct6tKed+q6OI7IEnXADlNQIFcQ?=
 =?iso-8859-1?Q?9x3KBouclMxvSR6Ldrw5Ulb+O9ezcsu0eRH2a/3CQgukb4jHdzW5YN0Zlg?=
 =?iso-8859-1?Q?3lkAfnS/XcjXpe/Pat3A+JtBgwpKU08Wtkpr1dJdICPPKxbVEjwukus2K1?=
 =?iso-8859-1?Q?ccrtkk0HctTlsnGrVlasthnvgC3kWuH/2etieyR+Luum5vSsThVBHNoHiN?=
 =?iso-8859-1?Q?xZsgpa+sw9mHcGqry2iCwGi54Hlt6196FAJB/kbG/iijj6qxKlpf8hjuy1?=
 =?iso-8859-1?Q?DLmr41ELSzbxj1oj7WKF+nFWHiRHHoLhQSb4xX5O744evovZ4YBIQZjMRe?=
 =?iso-8859-1?Q?Svt1Unt4vGUNVzgdqWVUfe/g0vqLy7PyqRa+Ivxyg/fKFJxcGS4k3UvXpQ?=
 =?iso-8859-1?Q?YUfRAjRR7zO20vGXsftJvzCCitu3XbtCWbrjtps4EIUealeQJcsM6KkulI?=
 =?iso-8859-1?Q?FQPeC/Rc6nq5Jqk8pCiwFDQ77DQJZFBnuZv9gVg8A6ROdbK0KpfDmff0jD?=
 =?iso-8859-1?Q?zFogzrfvamws3WfgqsxaIpyy0Kb7yaKoaoQrka0hqU8XSYSgFOL1a86qeL?=
 =?iso-8859-1?Q?D2agChzuLXUHo/7eBz7KqBA3gkgAgVZ6sHhzxVVp0mSqVkm7G8y8GHIc5J?=
 =?iso-8859-1?Q?0qiPQBhhH2kx86aUxTwKm0aATg13qZVFvJLpyg3c3PNa2KdTf1ZeVV09eO?=
 =?iso-8859-1?Q?gRH6Bf3Bq3Yiu5jOTMiEHrItKUD7owyn5TaVTbTvaaETL//MPvQQQZ+Z6t?=
 =?iso-8859-1?Q?fUa4lly0Z4QOFmJ4JeARAxEpevbrw6IyI01CFs9QX3A+bkQU9wAyJdtefX?=
 =?iso-8859-1?Q?hHuNWmKzxKN8/7ogC3P1/OlfOoD5lcnWhuztNJurauzko8b9FJhIzXVw?=
 =?iso-8859-1?Q?=3D=3D?=
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
	N2ufQoqkvl/HIMgu7Yl7enYmVfTy6p597qBlZkGKpAwyNE6qBiy5C82vrigJYkF5g7/UI5Z4qLLzuX6oi9Aja8vKqiIAs3bN1d/Xc1k/SrI/X0Rm45mwQByY2x2G1K1lErvgiLrwPz64Q6/l/QP40QGqBKi44I07nuNa2W+T7vBxo8lTstEMwRFMCUHsmz7Z6kalgAb0ERsLKlc7xMnxHI8e5Vf0tVnsHmwQiJxEkUGdoStF3q85s2JHtpX6Dxr5k1pnDUKs0CUgH81xJkAGDs3Z9SpZ/TmtyV1ZhCXKVjx+Pa7yNxodqcI+rvlwqHWl8Tazkbxfv6DY7QwrRIt0/Lu299jZnAbV9IIT8EMwW+j8LnHl7JGx4cBARKSzHDfKZ0/nuhLmwfqNCKneQGTrf20f2/QIKb7WBQUEFmJ8HYmf3pB/eBg+ij5wL6aWCjw7RbwJKG+/xc7KGH/EoIZyDVxuCuA6DfcI1xsKpo8eU3orbsI7umrZPY6jM1RumLXkJD+jMI0/iUS8Z3pzRjxflRL68wp5R+mdBpc6a0ZUBEETQ1psyNKHGIbLCpPCQqrjggM8tcefMA9UYvCg0wC0gfNppO3nmd9aeP40HSxR0bEJJ3NZEAvF0D6mxA8dsHRV
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59333d9b-8ef7-444e-a07a-08de28b439ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2025 04:12:45.9604
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zcUA/e9lMQ01nX2vkNOt9Ck5XHPbBT3iBUMLipt1qbxi64FeMGjP2z1+60Y3na3cZjln5Ozbe4lM/NI7/xeMVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB7711
X-Proofpoint-ORIG-GUID: E_spdz0GjItWJTTip_--X4BXV3PJLkyc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAyOSBTYWx0ZWRfX7aQ6il/oBvoF io1SQOGGI1raaRRY+4rR7Ld6PoasWC5OdgG5R1QfmyG5oztIYrQLG0CUuTteo2iMSREkEypLRlK SoPzcKONWCb50+ILMwXvRptNFwEDIlUCmo/MZSgaliIHKzIsMw/81+Wp8/qBbRUT3Kr31etGAWo
 bnDh5lAMI387y/Dp4alxlUm8xwtP5b4yeTUS1Oz2EthtdHD8AIkVp2i3Kv9jKNYTdVy4w8pZXU2 UATeQZIG9FpEBE13MHcL6sS0UCl1pX9RjsSENkRN8iZLh8VUpTog08tkyW1jwVF/4iU4ItfvQo9 wMK9CN8OyV0TS+Wmg037fCe94nnNvJVarzPO4hPsVHmNsaCWozgzqwjxYU4iw+mce563f3Q+8OM
 FCv0jHg4hGYjjg3LLzWijDRj0Yx5bQ==
X-Proofpoint-GUID: E_spdz0GjItWJTTip_--X4BXV3PJLkyc
X-Authority-Analysis: v=2.4 cv=NqjcssdJ c=1 sm=1 tr=0 ts=691fe6c9 cx=c_pps a=pbUL58iNF13cnplmrRAwGA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=6UeiqGixMTsA:10 a=7j0FZ4iXMVMA:10
 a=xR56lInIT_wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=hSkVLCK3AAAA:8 a=z6gsHLkEAAAA:8 a=SRrdq9N9AAAA:8 a=jsJyXMH1m7xw-WpCU2EA:9 a=wPNLvfGTeEIA:10 a=cQPPKAXgyycSBL8etih5:22
X-Sony-Outbound-GUID: E_spdz0GjItWJTTip_--X4BXV3PJLkyc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_01,2025-11-20_01,2025-10-01_01

On November 17, 2025 19:57 Gao Xiang wrote:=0A=
> The detection of the primary device is skipped incorrectly=0A=
> if the multiple or flattened feature is enabled.=0A=
> =0A=
> It also fixes the FSDAX misdetection for non-block extra blobs.=0A=
> =0A=
> Fixes: c6993c4cb918 ("erofs: Fallback to normal access if DAX is not supp=
orted on extra device")=0A=
> Reported-by: syzbot+31b8fb02cb8a25bd5e78@syzkaller.appspotmail.com=0A=
> Closes: https://lore.kernel.org/r/691af9f6.a70a0220.3124cb.0097.GAE@googl=
e.com=0A=
> Cc: Yuezhang Mo <Yuezhang.Mo@sony.com>=0A=
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>=0A=
> ---=0A=
>  fs/erofs/super.c | 22 +++++++++++-----------=0A=
>  1 file changed, 11 insertions(+), 11 deletions(-)=0A=
> =0A=
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c=0A=
> index f3f8d8c066e4..cd8ff98c2938 100644=0A=
> --- a/fs/erofs/super.c=0A=
> +++ b/fs/erofs/super.c=0A=
> @@ -174,15 +174,15 @@ static int erofs_init_device(struct erofs_buf *buf,=
 struct super_block *sb,=0A=
>                 if (!erofs_is_fileio_mode(sbi)) {=0A=
>                         dif->dax_dev =3D fs_dax_get_by_bdev(file_bdev(fil=
e),=0A=
>                                         &dif->dax_part_off, NULL, NULL);=
=0A=
> -                       if (!dif->dax_dev && test_opt(&sbi->opt, DAX_ALWA=
YS)) {=0A=
> -                               erofs_info(sb, "DAX unsupported by %s. Tu=
rning off DAX.",=0A=
> -                                          dif->path);=0A=
> -                               clear_opt(&sbi->opt, DAX_ALWAYS);=0A=
> -                       }=0A=
>                 } else if (!S_ISREG(file_inode(file)->i_mode)) {=0A=
>                         fput(file);=0A=
>                         return -EINVAL;=0A=
>                 }=0A=
> +               if (!dif->dax_dev && test_opt(&sbi->opt, DAX_ALWAYS)) {=
=0A=
> +                       erofs_info(sb, "DAX unsupported by %s. Turning of=
f DAX.",=0A=
> +                                  dif->path);=0A=
> +                       clear_opt(&sbi->opt, DAX_ALWAYS);=0A=
> +               }=0A=
>                 dif->file =3D file;=0A=
>         }=0A=
> =0A=
> @@ -215,13 +215,13 @@ static int erofs_scan_devices(struct super_block *s=
b,=0A=
>                           ondisk_extradevs, sbi->devs->extra_devices);=0A=
>                 return -EINVAL;=0A=
>         }=0A=
> -       if (!ondisk_extradevs) {=0A=
> -               if (test_opt(&sbi->opt, DAX_ALWAYS) && !sbi->dif0.dax_dev=
) {=0A=
> -                       erofs_info(sb, "DAX unsupported by block device. =
Turning off DAX.");=0A=
> -                       clear_opt(&sbi->opt, DAX_ALWAYS);=0A=
> -               }=0A=
> -               return 0;=0A=
> +=0A=
> +       if (test_opt(&sbi->opt, DAX_ALWAYS) && !sbi->dif0.dax_dev) {=0A=
> +               erofs_info(sb, "DAX unsupported by block device. Turning =
off DAX.");=0A=
> +               clear_opt(&sbi->opt, DAX_ALWAYS);=0A=
>         }=0A=
> +       if (!ondisk_extradevs)=0A=
> +               return 0;=0A=
=0A=
Hi Gao Xiang,=0A=
=0A=
If using multiple devices, is there still file data on the primary device?=
=0A=
If the primary device only contains metadata, the primary device does not n=
eed=0A=
to support DAX.=0A=
=0A=
> =0A=
>         if (!sbi->devs->extra_devices && !erofs_is_fscache_mode(sb))=0A=
>                 sbi->devs->flatdev =3D true;=0A=
> --=0A=
> 2.43.5=0A=

