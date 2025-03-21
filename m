Return-Path: <linux-fsdevel+bounces-44686-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E799BA6B5F5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 09:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 094CE16F436
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 08:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABD21EF08D;
	Fri, 21 Mar 2025 08:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="TI6OneB8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1681A841F;
	Fri, 21 Mar 2025 08:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742545108; cv=fail; b=q2yVboLsi3lVa3k+HzZI1tdLIz9GlomUBkyzWy3+qALp/s3VYIAHXZeRkD2807VaI7n19MeFZIRp7xQS1AooADxgWQH/jMB4sKc/hMO2Q34jE2ssmdifDZw4Oaz9ZWrUutIPhEdtdN9K4dEYFfw5IK6auFta4dZpv5OsgYcFu0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742545108; c=relaxed/simple;
	bh=zuSLYHQJIWpuZNu9syLjDZp5hrfEoFUY9aMXR2XVzPk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T9mExChv7fnpbeD3eZR5RckRmv0eouUUDUsKTobELWe4IkDbHRkAxtEqr6Hnf2Msgpb8gxxM5wN5MADINX4V+UIYNgcwbrNxHzjAOLZrhQi9xXWHrdQ9f9a1tX9CPtfBkuU30gohkKoljzFeXVcRXpe2HeRmehvL1X0NghuUxx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=TI6OneB8; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209321.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52L74WeC013332;
	Fri, 21 Mar 2025 08:18:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=zuSLYHQ
	JIWpuZNu9syLjDZp5hrfEoFUY9aMXR2XVzPk=; b=TI6OneB8CjniR5EZLVDrLyq
	dxmKB7+1gcQwbwR/MiNKYMOCnaR3wYxTXBtf3juCyLTifs9VWx/N4y/mEiUyEKSE
	nk+cyGYuWFi7nS7fx4gLLh4NaUDlrZjg6UVoK8Q2R9N/BfrvlU6AKqRB+OAl++E4
	eAJVJnaC99W1twsvQ2jpWR2BCgmPZ+wptAfHJwUMc3/qVFexUdXKsNX+Olwm1eJj
	wVVI62kqoPt0YTNT90YfnhBe0sS68OcTU/9EpJVcBfUIPG6JCg6qD7qxDeHkLySv
	EJYvD9Bh+fXnYdbgWZKO/9mlbSsldhHVgBKcd60l5UM98cMPNowpUz79G6msWRw=
	=
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2044.outbound.protection.outlook.com [104.47.26.44])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 45h3d0020a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Mar 2025 08:18:05 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G+D6RU5eZflM3FAwNCtzCCdjjfoEfhoBvobhbEZ9wJ0BOplkMSiwMdrkoriIcC2W0WgLjIg5rqUftrwdYmb0zEWuclJSMmw0K4RmtQ0BirqdpQ2PGQWWAaH96RqQPvKkASFcLV0a+C+5QiG2nvnlPTyRJGVPEnPsQMX6rb9NJl1PYYX/POWDo/T4I02SGbwtAaB0uoxsuz0flqtcvVI3x5wPaVfh5w29d3e7i79oHHhZ2vsklQDSwQl9G0KnIvRl8cTETaXHdhBhi7VHVw9vsY7uyZKF9YcvfjbMscRSk99Tdp4BCVlgP9rh6weVV+SEMYccdYXA+kNh9W/NtbSUcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zuSLYHQJIWpuZNu9syLjDZp5hrfEoFUY9aMXR2XVzPk=;
 b=hj/yE8EAKJPS1t9mji1hBd/OqSIQQCR4s1mFHm05LOAJMn1bp6Z3k04tlvg1Uwg9/suMB1NQDRXva3jhOmvN67BY0ZAAGLPzWIxlMbCeHMzcztLTTFfjtmEiN1n8pmsTP2ScIvQgiNojqRiKcCjmo9U1V0b4p4ZCeLkm7dryiHTJQc8KAZc4KSJWS/wcd35UgxNfhZuWQ7cx7bsbooVGFBejPkRAWqGK7ZF3iJon8/mmxEbrrcbYx/1p+nFLNLwsNqFpkvGRWb0e271uKahNBbqhfgx0HDE6meBpL+wvwDs2kL5RA4kD1FsS3whbpVP/iyml0H3bNp+WdJLNFDNEgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by OS8PR04MB8182.apcprd04.prod.outlook.com (2603:1096:604:285::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Fri, 21 Mar
 2025 08:17:54 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%5]) with mapi id 15.20.8534.036; Fri, 21 Mar 2025
 08:17:54 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: Sungjong Seo <sj1557.seo@samsung.com>,
        "linkinjeon@kernel.org"
	<linkinjeon@kernel.org>
CC: "sjdev.seo@gmail.com" <sjdev.seo@gmail.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cpgs@samsung.com" <cpgs@samsung.com>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>,
        Yeongjin Gil <youngjin.gil@samsung.com>
Subject: Re: [PATCH v2] exfat: fix random stack corruption after get_block
Thread-Topic: [PATCH v2] exfat: fix random stack corruption after get_block
Thread-Index: AQHbmivTi1qUIeplLUSh+l0erCBSN7N9O9od
Date: Fri, 21 Mar 2025 08:17:54 +0000
Message-ID:
 <PUZPR04MB631610DCC3614D45B0A4CF7281DB2@PUZPR04MB6316.apcprd04.prod.outlook.com>
References:
 <CGME20250321063454epcas1p2194c3e69371dd4f025202d727bfb93a4@epcas1p2.samsung.com>
 <158453976.61742539083228.JavaMail.epsvc@epcpadp2new>
In-Reply-To: <158453976.61742539083228.JavaMail.epsvc@epcpadp2new>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|OS8PR04MB8182:EE_
x-ms-office365-filtering-correlation-id: 4497f63b-f994-42ff-6ad4-08dd6850e182
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?1wAyrYmDaFyLO/hyXf3DAQ2g2Td8ASwRSfdndGiAz+Bd3iklLHftEJ2rFN?=
 =?iso-8859-1?Q?hBJRVXSDMYpQfHQCYzSjClACmQtPJjJUICcuIQgIp3kSrm/lLU10lhlv4w?=
 =?iso-8859-1?Q?1O4B0alyyQ2T748Mmf4cnD7OLjIF0y+1xd9Dc0DPDLCW2bZNSNUH3SqK7S?=
 =?iso-8859-1?Q?Nd0DpicNviYrk/XXio9fNti8LbmaZNzN6WiLdDWV+LU/+pgLTcNw0ukRn5?=
 =?iso-8859-1?Q?rcaTBqiCz0HCh82IPON5Wa/7qL+vdpWi82xHkyOQHJOwxk/4VR9DUj6uNz?=
 =?iso-8859-1?Q?E/+Qsj+g+cONX4MOWqDuhkERuvG7DS5DPEQ+ghbNg+2ZQV6n2vB0hvmyDO?=
 =?iso-8859-1?Q?CmmB2RLE500lObJBogqNwQ/1LZ6dVVyCpzhGYXn3ScDN79h+E26N7XslLw?=
 =?iso-8859-1?Q?hPqovdZkUinJgGahkdiNzRE3Bn3d+UHxNspmcDyfBCP6G/vuJMwemvwjb5?=
 =?iso-8859-1?Q?qpy/bwZiwiQL6dSkYV4Oq9j5cA/9jwv+HjTMZYwilJEbmzJSjMlVW6p15M?=
 =?iso-8859-1?Q?6rKhiXFwFVyI3zj/zoB2fpSNve9uRusip0UJ3Q10pKQSTs4tttmV+Amwfg?=
 =?iso-8859-1?Q?Vxci2S4G98n6dtzQtwqkiiWxH35hQjw3BxvArt1RDr4bqc9vwbRefLUOrp?=
 =?iso-8859-1?Q?EvFCLa+g4f6mNLkSXU9RR/zoNcgAstLNK6hStCr4nOshooM2BvJcig3bEu?=
 =?iso-8859-1?Q?kRemVHuhkHExmrvcBLPHBw+A7EUbuOfLd2AxOpW/G82jlxQ6Rnj47X0z6B?=
 =?iso-8859-1?Q?QwaV3grBTPwJqNYvdrI7PnjpqOLWRhzIiJhN/kHdB1pK7iV75vir+Qdr0x?=
 =?iso-8859-1?Q?kVUcHmy+zwcudhwxOZyVFV1Vy3J2tqwzbPWAQoWDd0DX5SbUVui+fJ7hJk?=
 =?iso-8859-1?Q?2tJAJLsWx2DQuvuFKGC6XW7krOjwSmrM96zGQkEYrU6z0biqBIrTKghM+g?=
 =?iso-8859-1?Q?ryYc6aK/WWwJxVSK2DMjz8wnPPr6vVK0MBKjbozMns+2VESV7YElUBFU4v?=
 =?iso-8859-1?Q?hpqa8qI3zowRdqINd6htXrpEKrgiXwtcIv4aqQg+Fqnj7JAsMESU1LwuW5?=
 =?iso-8859-1?Q?I8QVKtS9hpJGpLtxtHx4Dh+PT1H+q6SwfAeMCRpTGjq4khBnYdg6S/K3iO?=
 =?iso-8859-1?Q?dQddW1PqwevTi+uy1Rd1q4D/BQ9oujN+GMsuBUjJ4DdzP4kLUWenxjSNZK?=
 =?iso-8859-1?Q?48P2AtFsOZebv0A/65ekLqck6kSTeMgsPC2yq8k/pwqGf3QptU4pxazw6i?=
 =?iso-8859-1?Q?RmQmb7IQ6Y8S+LHh/NJjtgIAJEEYjLHpjaE3VMuTM+JQ4lnPugi5ve9L1U?=
 =?iso-8859-1?Q?iw+ZQXLRzVEEDRNhYc3/0QyiKrjejghZ1uU8BSdfb+nl5v39TDjky3ACFl?=
 =?iso-8859-1?Q?K1ASxLXTDxbsZxxjER5V8DKkEhW4v2v785ayT/JGUAUZlnK+v0LS2JNdQf?=
 =?iso-8859-1?Q?FShVlZUnKFvdj2uS5FhIbCI+64irusILQBe0cKTJW8GVYP2uuonNw16DQy?=
 =?iso-8859-1?Q?aTg9djfYKVT/OUXyQ8roKu?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?OoQafGKqhnhOL33/ObOK6pXbnKcj6yFZel89eoo/W27vQPfSBjfCSJClbb?=
 =?iso-8859-1?Q?+qscPPtISpue1gNV48xhday/ktRsSeb84VZ5/rprt1A6SR6q2oKcYcvGcd?=
 =?iso-8859-1?Q?VeBnwm/wTtdmmjWqeRlwLHrSJJQCK3R7oUaAsCZwIX92fkR8v9Mx5JdYG/?=
 =?iso-8859-1?Q?IBPxyprFafFx7/q69yMc7+hIQLCtInQcDB2f3NcmIFundF6tQCeOqo6FAC?=
 =?iso-8859-1?Q?r5Hrf3I50M14CoIEgHphMrig6+V6geg3E8XrXod/8qd11WKW1ulsbuqZIQ?=
 =?iso-8859-1?Q?BjNuRoTRbog41eFWixbGlIny9fJ1CD1hccMQJTcPEUxdc6OuWoRH3d323r?=
 =?iso-8859-1?Q?Euq+2v8bP6nXCY8QwYu3oMKmt5VvuMWLarjQshdlR02fpidBCPUxToe/du?=
 =?iso-8859-1?Q?Y1Wte5PJe0YVIntbr2a/ZdNcHo5ltGZ70lK+xa5qbW4zH9w4jLqBTP/ANj?=
 =?iso-8859-1?Q?7A5GKBaHYMrRSxme72yofTT0JDCLOYqUWIlBQo+jiPsdHsbyrpyqwI4xPk?=
 =?iso-8859-1?Q?e3DEv7zYTN362Qn+ElDeRBOSEs28Xxq8RL8vQRtwaGlLAZMENxylfK+xsc?=
 =?iso-8859-1?Q?yl4wvs8Lyq15UaFRr2AQrz6yio2UWPMro61FIJH+HakXqabi3gu90vdjiC?=
 =?iso-8859-1?Q?MBeEisrj3PDqk8jdSxLW/fFxH4O5mkv2yBaZOAuX+Z2I3mmEt6ZHD2FOCo?=
 =?iso-8859-1?Q?urOL60hZBkp3ECYnxYA3A/1Q8xLSLLuCiHBKH4Z4Vjh1BNdlzgwEUqyLlk?=
 =?iso-8859-1?Q?mBCWtJL73M3ZIuQP5HiptmAYw5Tqt6m+IDhTIVFfTM28W2CBwwaGmMnkbo?=
 =?iso-8859-1?Q?8NVu+NAeVQQru4sbCt2Q8LPreH1Wa21E3LoiDY6uXzSh7VScy3UoPnpVUd?=
 =?iso-8859-1?Q?qoKbtgS8oPSYCbnCkgDqZ/kTYzYPvmV0yaQvP0Wpm898VXs6pb9JCCuTci?=
 =?iso-8859-1?Q?/rn5rhncDR0/zan3ZY/XNHsIcREkqGVpzI7+i2UXYNYpMKv1WdLRaygB6L?=
 =?iso-8859-1?Q?izdbAXJE/03T9lilpaNDKBWsap8NQZM82KO8WVIq+zqEmxpkqBqgStF3v9?=
 =?iso-8859-1?Q?u4TIcGGyqIHfY6JQz5iSCYwtkGAL/KsuupRklD+lKtrXy8SXD/FmC1KZBa?=
 =?iso-8859-1?Q?Y5fm+Hsyz8rz/t73J9mia4dhHmFJvoKwHe8rSUxr2msh+TR1Yidbp04s1/?=
 =?iso-8859-1?Q?68y8XutDjaJW8sSI00nDdnaP8UtOnRPo+2yavtOk9+YjAkpjLYB7ijVFRQ?=
 =?iso-8859-1?Q?jc2zyNHAdGBotUnSvaC8XXD4lyTVU+rOi4x7xW/PGsWqaXOqP65oUx7Sg4?=
 =?iso-8859-1?Q?BgdzdaO9jT4knVwFaANZvKKUyA7oGp5P02FQXZW1gjjoyzMFbBssxW0zua?=
 =?iso-8859-1?Q?9LemwfbwvQ+IbxYMhe6vvjIuRt13u1EfyLZo6NoM68FvzVkjyYmTyDGAXL?=
 =?iso-8859-1?Q?RrnySuzzsLc+05sWWPM0ODj1ZXo5sFGOX0t6k4Xc2GQorGR97ld6ihANQq?=
 =?iso-8859-1?Q?ofqYRz/SJjSs9/KwSnoGhd2qy2Q6C5fstdbLF/hV//GHaW58lkE1YcHkXw?=
 =?iso-8859-1?Q?5EmQ8RiREQbxf27FIQV90PSmtarP/pwlqFgI0MlXf6yFB9IeMMt1x8Jms6?=
 =?iso-8859-1?Q?ORPdyVPoPuocV3ZMfwQhtnq67unz72v31gh693vuiKceeDAmY/Ead7E1lZ?=
 =?iso-8859-1?Q?worsSS3RrlI25P9uED4=3D?=
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
	NL4OcGKyS/JboC53dH/AqIS7SNJPm/OZRH7b+UlqsRgRe0F9OJwgLpH2bhmHWtf1xJyVu32X9dgVJ/sL0IgQDk/nyORqBkhq5D0SaUJ3gZJWyqYOkRu4g2f3sqiBY2jrA8EsMNAtvK/hqx+ki5lJ9HO+VQKClpEco9iBC8vVtculzpA/rREfqD5UbKSobM+tbT7eCjNSwEbGSZuDEeOAa+oCGxWj3BUA5GqOjqjzpUhS+4rKy/1x85bn6dSqpXXSFBZ4nhQg3ENNbokuL3MZ7sHOZKj73b8AB6Y8O9gO2NUx44QjC6g7xUAwGW26KmfIoLa/GslG1tyuO7kSeViTMdd4Vx5M0t8wviQ1igVL4stt0T00nyNbtw4yUbGJ6sNhlSQiXiqkvKhXRHrW9hXYUGs7luWV7NA4pQJi/nuopKjQ/s3rfoFV1OWfkuRgMpmezGI/pJ5ijA+Cqka+BpvxJzZCUDSSOJwktxKoJ9jGXuzBYUF3uF/2Gr6VQSg8jAevUna4+E/PtMhaxyn3XDszBXJB6UqvQtR6juOAFMi7rMxPowfQrHI/BWlT4VVkNhGmUzTkBQomL7tD2vtRGo6vMiiHBgelRpqm2xMygp8TkgMPpsbcl7l14q5eqAojjEYZ
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4497f63b-f994-42ff-6ad4-08dd6850e182
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2025 08:17:54.6145
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: akEKWO09RdrRcbwUHCiEmLGPkVzxgqUj3LyO2/KmG5bk+CUum+JVHo1EyAU6Tlu1JbR9LwqSGdvJBCARJiwkiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS8PR04MB8182
X-Proofpoint-ORIG-GUID: OcA8F6mbB0itqJdMdQKW6N7-zmgtddpl
X-Proofpoint-GUID: OcA8F6mbB0itqJdMdQKW6N7-zmgtddpl
X-Sony-Outbound-GUID: OcA8F6mbB0itqJdMdQKW6N7-zmgtddpl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_03,2025-03-20_01,2024-11-22_01

Reviewed-by: Yuezhang Mo <Yuezhang.Mo@sony.com>=

