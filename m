Return-Path: <linux-fsdevel+bounces-64834-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F654BF53AC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 10:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 578DF4E71BC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 08:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8446E302CD9;
	Tue, 21 Oct 2025 08:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="hpKzOglY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A71B298CB7;
	Tue, 21 Oct 2025 08:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761035389; cv=fail; b=jDJL66AeouC4cpFBOiahQ9L30cM+WRuRQx46yUZYXYCTXZaYWISDQOslrCTQeKJOTVIt4C1KTs1+zie0T3hm/GZbZsBuX4qA0lka7X05A3B4ykXC7Ddrik8+zxGyzERoQMigZj000DUmEg69Db6ZO1pz7GSbCUe9fHPvresgnVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761035389; c=relaxed/simple;
	bh=RkKa0Ef93Oeubb46Mkh3eQJ56TFpmrPCnj8/nqzU/DY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JLp5sF7iTegKzpFec6BsT0HDt/VQ7SlpDAVADdluxgC5AioM/YN/L/1lvWb96xJaKDGNleLgicZk4/lyMUfXUKblCNJMYy8URTP0ujH5hzrG2C+z2Jn5ctbjfQ27X1pdk1kPQXtcznRIPXbhIidFIbEJ7W/BhvBqm5sk3gE7pgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=hpKzOglY; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209323.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59L5ehct015487;
	Tue, 21 Oct 2025 08:22:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=M3RssUP
	BqUrL9se6Cp6AaWlikEqA+HECzPU6MTeqPpQ=; b=hpKzOglYpYoU9J8qyVTNb5a
	c+l2g0QOnpXJOGxUDTEFK9nENdDzN5bEpRuinerqoSrpf9s7BFf8k8qcpMHPJD+V
	LQ0j9gi7gQW7f2sBv0O2GtKwobmEU7JboKnRG8USnTq+k2JkhvIpUdfSrxWirp2K
	CQh2S+LXKehobQT4zECIXh4ePf+AWAjPb3U2QPVnf+jfGcoyNUu23nBUCksBUsFV
	WLiiMsksiQBnTiq1bGuaIOIE1B7k1H6MKbeyNcYEN43xhh43TX7gILAMXGLQvsa2
	9SqYyS/Z2XgpOmYaPsAiBT6jH7w8vszp3F/vbZ+X6E2R+FxACuUJruv2DGcm8LA=
	=
Received: from os8pr02cu002.outbound.protection.outlook.com (mail-japanwestazon11012010.outbound.protection.outlook.com [40.107.75.10])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 49v27yu36k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Oct 2025 08:22:13 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZsjwLoZT3Amj1NG+bnev22vofZEYed+hBRm9En8JvhQcesUuOuJqFbwDls06L0zlFgKmGMhpZIA3LW15d4IJGHt1jj/hfLTx9jBFISXCiZ+8hAobx0bnHShK5vQ6db9WxsTv5XsL/LvqV1fak5sRGpfwdO6pLTgEHDfkbUNYnApsHo4aMrNFraMFR3I4iJ0mcrTOV/0Iv4hRzcKWthSlW3GI232lywUAqhGEH507SELmrUmqs9BGABNASKg+2uZSDiar3+sHoHJyuMHI6dncK1dIwTTK6/0g26RVG8CXl7riXjRDcPTW1OSqUYYU2CkL4kPYNWvctGOhhtdEkRqkWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M3RssUPBqUrL9se6Cp6AaWlikEqA+HECzPU6MTeqPpQ=;
 b=mvjefO9y8TesvMvBOPtv3R4u21sKuDca0D2Lt4NVzEBLhsZD/TOfILVewsHXd8schNbf5H/FSUNyYMKskufrZ7FrUSGCQbZ0NMeJj0xvfO0TUnddBMphe1X9vdPagCDEUGkYm3xugIUMpz9+RCwNAo9ZSZrlQiVmIT5cUsFL/yUsBWT98Wiffqo01VoucGXFliAQQSG2wpv8Qgy05+9lfPbXTmrdhazuWsB+EqUJysZEwYLLl1IlPPjwcpBiZFIqritSOH3ZaRCPcfcgK5bmwze5krgV4tjJrjWoIAG19cePkgChzCXZyKuiR3KGF0lyLS2ps9GZ434AYw58JJWQvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by KL1PR04MB6804.apcprd04.prod.outlook.com (2603:1096:820:db::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Tue, 21 Oct
 2025 08:21:58 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%7]) with mapi id 15.20.9228.016; Tue, 21 Oct 2025
 08:21:57 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: Shuhao Fu <sfual@cse.ust.hk>
CC: Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo
	<sj1557.seo@samsung.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] exfat: fix refcount leak in exfat_find
Thread-Topic: [PATCH] exfat: fix refcount leak in exfat_find
Thread-Index: AQHcQdJ0wcH5u5sPR0ix9yLePJBMrrTLzpsfgABwfoCAAAJEkQ==
Date: Tue, 21 Oct 2025 08:21:57 +0000
Message-ID:
 <PUZPR04MB6316F58807941F86C2769FCC81F2A@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <aPZOpRfVPZCP8vPw@chcpu18>
 <PUZPR04MB63160790974C70C70C8A062481F2A@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <aPc-gzWVu6q9FmZ5@osx.local>
In-Reply-To: <aPc-gzWVu6q9FmZ5@osx.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|KL1PR04MB6804:EE_
x-ms-office365-filtering-correlation-id: 264928d9-146a-4112-0ac5-08de107ae6d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?aCtPLYEn98eVheIPL+YgUN2vxKbaNnjyJeW3mJIm00eAHyNjfNP069F4hB?=
 =?iso-8859-1?Q?+41gfziFtUB6CcymM2T2GEzJl6CYGerzDbKfLU2qN0VHNr8udQgKZd5iDp?=
 =?iso-8859-1?Q?zGhh4YfLBkWSEATJUZ1ePftrRlv2eUCtL+qYghwYksl795oB9191xbrhrq?=
 =?iso-8859-1?Q?A9lJAFa4TYudnnZd9XIHpu5FJc94SmZFl7WYg8VndE6S1KbgC7gf3Dl/wc?=
 =?iso-8859-1?Q?PZM89Ss3DGzo93YXdmqgCiWc/WGKYRghdcS6HhLszNRDWkbWfwjPsVCzvS?=
 =?iso-8859-1?Q?IFaVMR+w3zPNQac+Wy5znFs8pixqFTu0FOA00LgoO5th4gs0qwVzVeQX6B?=
 =?iso-8859-1?Q?HmzEVl0vEjK0U/sm2kl1PCYmCXxzlPE90nbiAPFbM4XKn92DGVptOUvS/l?=
 =?iso-8859-1?Q?dA2whJwL/n4oQarNVK2HSUzXQG/JMM7JLLECiQ+xU1jUI2cWSf5/PYAt9y?=
 =?iso-8859-1?Q?TzMvTyQgAcdNDNpmoqOq4sf1ZDT2XZJqujj36xEL+g6caODAWE/bTJRlKC?=
 =?iso-8859-1?Q?Gt8K953AurxIG8/NsS8vQ4S/OiN7HpuDF0T7GZjVe4w90mrMBMCFLKyatt?=
 =?iso-8859-1?Q?TXg7R5faQRtCQHkfZNibzzIOynvYIo/qyIZxSJi/apIuVjvWIbIkTJTCIj?=
 =?iso-8859-1?Q?t6NqX3LYo4B15KcGEDlpIfkD2TGVec0Ll0PfdOgL8N488UCVuCqnK3Hd7V?=
 =?iso-8859-1?Q?Jek/gOE6w+xbp3RisFjCune2/gPnn35tG8ue2ZDhBLsv17d2uRKLZa42H6?=
 =?iso-8859-1?Q?GUV5DTdIjXWQLpob8iTr4ESma0Wuge+EdgVKJ/wX2TzTlnokLzmaxgn0eq?=
 =?iso-8859-1?Q?gchDiByvOaWDKKKTd+JfmoPvjLu99H4oN53dgZ8htXgGi8JiCgkLOlCFQG?=
 =?iso-8859-1?Q?TnlH2NI3Azl60zm7rxKdszAMMmle+h3YwSWpqP+Omh8t/tt87oqPZ/F4j9?=
 =?iso-8859-1?Q?FW0MijJrdIRvV8g80i4tKzFe9qsCCie5c2/5Yl3Qpn2ZSQ0ATyM9mx2GNb?=
 =?iso-8859-1?Q?qZfbh84heyLl+sozSXNxDs9lajnSHkN0ShI/rmYulo+SRG1dP9OQFAy313?=
 =?iso-8859-1?Q?1YlLRF74UaIVdyacO2iVAdd7ZgX5diuP5llopVT4ZtYcHKAr/vbpiD+9Dd?=
 =?iso-8859-1?Q?Oigi5YizX5FRsnb1OfymkKtyPV66mjnZpeQ+DXkuzLUUVn3u9I4v6L062H?=
 =?iso-8859-1?Q?jLDzlXgjZnvBBoPPJAuyHIBFlqcHnknwoyFn5SgLSrgVQJ9F6Ysxp7jkaP?=
 =?iso-8859-1?Q?qvF+efduRxzqBROkvEQATxhKWXGUB1CRddmso1X8gCqNclbZ2zqV/iKvQc?=
 =?iso-8859-1?Q?5IqM+mQNGDEbG9RDTkqe0/C4PkVpaUufBab7AgdJ79/0uUh0Vsf4MPxDKa?=
 =?iso-8859-1?Q?QwoxZ0Ios336dawI2hLslQ2obkxZx06WIxWi7U7+QzFGJ3AxrhsxEWFTBf?=
 =?iso-8859-1?Q?OXvJ5oLSsSIPHqAUM8uuyLHzqleC8s3z0KmowUyqvhst2x43LY/bX0UxY9?=
 =?iso-8859-1?Q?tMI+YDtTCawBExoU9GsBY1dsO6v3TogRgMrLYEzxCDfIvJiEXeFcNgGiJo?=
 =?iso-8859-1?Q?VwKue5nUrDpq1pgP9KbhWY9QVVvr?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?T3jcA5cat8FFmN2r+ALHkHOWRa1NdgQ58HyzThopehYxkA3MekfLF2gce2?=
 =?iso-8859-1?Q?jymeH/b6PRm1GlYcWqlsTLv27r/Wk/+v/pWDUWJJvWRLbt+qY+oWdQ0Cdu?=
 =?iso-8859-1?Q?VQ5hEn/NI67SeND72tJ3gI3PWkrkyPasAixNI5HKvVQd9Lj32C/ZssIvJ2?=
 =?iso-8859-1?Q?R/Zsal4xupSKzpf1GjTNEtH50WZhFhxuByY1a3ajoD8lbHVh2b2A4o50QL?=
 =?iso-8859-1?Q?zWU2SdVe4+pwiEzlFR5MFaFAk3Q8h96x6yrPD9sPnGOTV3AXqYmq0X9I/S?=
 =?iso-8859-1?Q?ZVTzATylaC6mbvbViwIJA6oUrGexwffwRUyNiiQQC2MeQVcOIob/7L24uZ?=
 =?iso-8859-1?Q?FSBJL4N1oKsx183qtXTeY+KVkntOlWpwhuV0ikYt3qOEZh7i0wCIw72mFW?=
 =?iso-8859-1?Q?3kLnybU6l6iT4Oxnh+5r50yaSzrxBGc60iYaMqf+MgKFVqSehGshM3ehxY?=
 =?iso-8859-1?Q?tftfWnfOQAsGG++x99H+nIx0WOlhvxVno9bqZPPmMLnkwrTY5vx15q6P6d?=
 =?iso-8859-1?Q?qlaVKSqqu46xadsiRby90bV33fuyVB85jFYXRrQnAS2cGqDB1vK4UaT0HA?=
 =?iso-8859-1?Q?+yMwL20G1yAOYNemEU7Ngmaw16bOni+4qPd9Rc6jbXOKTfS9dtuUdD+2j4?=
 =?iso-8859-1?Q?ooMBXANxPwwy3b/690O7pZgodHt6nTxpIB8lfPR5tKVdw23d+xdVoFYWbk?=
 =?iso-8859-1?Q?XqcAaZGQEKdrdsCReLtuoikxOyrRrTei4iS5JFzCmmxNeo9Q6UbKps79Cn?=
 =?iso-8859-1?Q?ZiSZ2NswjtcGQRd4+CndvuVIj5nKuYUylcnBxjEl4C2jlb6h0q5TmSlJs/?=
 =?iso-8859-1?Q?qQLy6rZ84MEIfEDUukf60lDysBE/BZ7byIVe5OUzFsc245CA/YRFR8JQp/?=
 =?iso-8859-1?Q?VlVy+RVMuex2C31djdYeMxXxh39ubhvaDy+/whu9vAI0oBKcpBrhj4S+5C?=
 =?iso-8859-1?Q?rpQuzZUipO0g17L1K23ibDrKlnihqkbb4MdgmI70KMVsC5M7R7XbGAGWMu?=
 =?iso-8859-1?Q?MUoBT23DyzH9GFjNWx8YyHHs3FLrP72bFgO9VFJjDvcfa3aWnwC+QcX4iN?=
 =?iso-8859-1?Q?J2WiIk0VX1GZN0Sh648FCTApIHCrkLHRTpShb2FPv0KUF2sf1GbasHiNIh?=
 =?iso-8859-1?Q?g/UwvIAv6uN8dGee9xaJdiMmY8g6K8RXpiHgaCxo3IMQkNB3GmGPmxNYpm?=
 =?iso-8859-1?Q?9b4MDZiG9agJu9vBL8Z1tbWYfrJwDSoTK9HY5iox8/EN92CBrSkRv1Z/Cu?=
 =?iso-8859-1?Q?/C6AtlzK7e0D3GlLrXYgS4f2EpYKqdyWN812m6noN6LAQ7C9XGezqv4CXZ?=
 =?iso-8859-1?Q?3n0mFfzD40W6vjplwziXpDeRPPKrH6Nh0I/1KR++00VdXm451Dka+cWkog?=
 =?iso-8859-1?Q?seKGT5IgniVickoLYIGanSOwRntBhr3GytM02m2U7qs6OUG1mPFX0znniM?=
 =?iso-8859-1?Q?MMmIfKMPy4OAEvK2PwjOmG9pBVYoeOTpYp6cHSuC5EHdbJjkU9RhBTP1Ra?=
 =?iso-8859-1?Q?iE1YiM0u8WM24nKNzOKHdsI76/ITIHSxjFKtr4WcIA5/TZAcVDKAcouwTr?=
 =?iso-8859-1?Q?KH2QwL66SltUZenbzLSSWcv4lYec0WdT2tVMZjLqP2HBy7/BKuk09Kdq51?=
 =?iso-8859-1?Q?OLG55I2WM/y9R6dXCgLLijh1NMrCcmtk8qEznuK6IaTwpGJ8tfCnknXg?=
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
	zmwwRqCGG0ObLYdvPJ9SrZtsuCcAdMv8Xo3R3MdasrJKEMdB9zcLGtnhBmqaMhQtn2Yp9DIPeHKSc9nKtgXsURdC0eRoAbk2qjr7bq+ZpeQfK5MtXG8Y6TcFHhButIK1+JOk05s+uMC/eXZYQ4kS1CkZzDUbtBP+PBOrywy3Wrn0wtirrQWYI1WU/d61cT5uwxc292c8v9dKdcGDnmU6WQFcCdvxt9cXMTWkXiZ+fFbd+tTSzJpgQoW4mBAYDE3X/uHR/CkG6IVdptEq1844Wp1qqrvyUn07d2Z/81Pk/OY7A52uVI20MpVMxsy6kJtHNHPlPq1BIKQan1aux5i4Tk/lj4TZtC3VQzOCTwkApz/995ehBrhQDZBvrRiPZknleYDaPVJKp+WtzYMDR+1QKqRI/DiiAARga5FnzdDCKJKX3wd9MEQ95QCB9M0nohZ/0uOUlGDoQT4iDaJVxZXN0S69vPH5dX3sSIVlnt+mJZbSWPfmrTivbtTajdywVDgjfUX9GCFZtEkVy7zK6A8qcSj0M9S3D6En6XXfozuYuAA7offtmA4guUB3z0Bhne2dBVaf60YeV5xb8YSzqZIkUQCCZgHUpalaxKuoVIK7rDzGFg+n0wPJPYRdYUCOEeS4
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 264928d9-146a-4112-0ac5-08de107ae6d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2025 08:21:57.7652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zS2qVW7snNlRBv2ZQKxYONzSaEIPxp4MuABsMeJvqAUQfkC4jXwm5Ede2v2HclGXVcPfOTJf372h+fxgsF2S0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB6804
X-Authority-Analysis: v=2.4 cv=FfM6BZ+6 c=1 sm=1 tr=0 ts=68f742b5 cx=c_pps a=pdDaYMG4YFUz8dsh1drOFg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=x6icFKpwvdMA:10 a=7j0FZ4iXMVMA:10
 a=xR56lInIT_wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=z6gsHLkEAAAA:8 a=TpBYoIgw9ZsI7x7CLDMA:9 a=wPNLvfGTeEIA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: 8WGwHiM6KPx-4avPVTwUKdCh6JzAFlEG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAxOCBTYWx0ZWRfXwmVy0vLqdJmk OT4abu5Z6GGlwcM0CTjbilthGI1fNZpl6uh1WOR48Sehqs40fjPmcoIPRpjhXMd3BQQw9YqSz6b WqYbOzedN0RNPJQK6KqYWPT6e5206M374+ly40MCIvbjYJDJ98qHPYEw4BqJX67sEXZiVnuYjKG
 r3eFarFVbQPFmFsd7qgBBhobszRiqfiPUbC9XUdgD7n6PkaWT3lCmgxd5yxqmnR05pWCozlvMzQ WeDJ4Bo57vUZDqhzINjfidmxSgoid/q5z+UpMkKvnmx8dZSFwEEKQgjqA43Y2GRdqUVGNSuvS/Z UTg9IXqsBR7dkrc/umGyjbbT3DnRVZ0g8/mi5pZtUWL1r/KVUFUcEYAGFsvUbRcCHuV4yPQGUDC
 RPVG+bRjVrc66GA25Z/epzNIJA79oA==
X-Proofpoint-ORIG-GUID: 8WGwHiM6KPx-4avPVTwUKdCh6JzAFlEG
X-Sony-Outbound-GUID: 8WGwHiM6KPx-4avPVTwUKdCh6JzAFlEG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_07,2025-10-13_01,2025-03-28_01

On Tue, Oct 21, 2025 16:04 Shuhao Fu <sfual@cse.ust.hk> wrote:=0A=
> On Tue, Oct 21, 2025 at 01:38:29AM +0000, Yuezhang.Mo@sony.com wrote:=0A=
> > On Mon, Oct 20, 2025 23:00 Shuhao Fu <sfual@cse.ust.hk> wrote:=0A=
> > =0A=
> > I think it would be better to move these checks after exfat_put_dentry_=
set().=0A=
> > Because the following check will correct ->valid_size and ->size.=0A=
> > =0A=
> >         if (!is_valid_cluster(sbi, info->start_clu) && info->size) {=0A=
> >                 exfat_warn(sb, "start_clu is invalid cluster(0x%x)",=0A=
> >                                 info->start_clu);=0A=
> >                 info->size =3D 0;=0A=
> >                 info->valid_size =3D 0;=0A=
> >         }=0A=
> > =0A=
> =0A=
> Do you mean that we should put these two checks after=0A=
> `exfat_put_dentry_set`, like below?=0A=
> =0A=
=0A=
Yes, that's what I mean.=0A=
=0A=
> @@ -645,18 +645,6 @@ static int exfat_find(struct inode *dir, const struc=
t qstr *qname,=0A=
>  	info->valid_size =3D le64_to_cpu(ep2->dentry.stream.valid_size);=0A=
>  	info->size =3D le64_to_cpu(ep2->dentry.stream.size);=0A=
>  =0A=
> -	if (info->valid_size < 0) {=0A=
> -		exfat_fs_error(sb, "data valid size is invalid(%lld)", info->valid_siz=
e);=0A=
> -		return -EIO;=0A=
> -	}=0A=
> -=0A=
> -	if (unlikely(EXFAT_B_TO_CLU_ROUND_UP(info->size, sbi) > sbi->used_clust=
ers)) {=0A=
> -		exfat_fs_error(sb, "data size is invalid(%lld)", info->size);=0A=
> -		return -EIO;=0A=
> -	}=0A=
> -=0A=
>  	info->start_clu =3D le32_to_cpu(ep2->dentry.stream.start_clu);=0A=
>  	if (!is_valid_cluster(sbi, info->start_clu) && info->size) {=0A=
>  		exfat_warn(sb, "start_clu is invalid cluster(0x%x)",=0A=
> @@ -694,6 +682,16 @@ static int exfat_find(struct inode *dir, const struc=
t qstr *qname,=0A=
>  			     0);=0A=
>  	exfat_put_dentry_set(&es, false);=0A=
>  =0A=
> +	if (info->valid_size < 0) {=0A=
> +		exfat_fs_error(sb, "data valid size is invalid(%lld)", info->valid_siz=
e);=0A=
> +		return -EIO;=0A=
> +	}=0A=
> +=0A=
> +	if (unlikely(EXFAT_B_TO_CLU_ROUND_UP(info->size, sbi) > sbi->used_clust=
ers)) {=0A=
> +		exfat_fs_error(sb, "data size is invalid(%lld)", info->size);=0A=
> +		return -EIO;=0A=
> +	}=0A=
> +=0A=
>  	if (ei->start_clu =3D=3D EXFAT_FREE_CLUSTER) {=0A=
>  		exfat_fs_error(sb,=0A=
>  			       "non-zero size file starts with zero cluster (size : %llu, p_d=
ir : %u, entry : 0x%08x)",=0A=
> =0A=
> > > --=0A=
> > > 2.39.5 (Apple Git-154)=0A=
> =0A=

