Return-Path: <linux-fsdevel+bounces-44160-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E18A63D97
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 04:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2870A16A7DC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 03:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E937170A23;
	Mon, 17 Mar 2025 03:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="NRpEuOAQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E236514A4F9;
	Mon, 17 Mar 2025 03:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742183621; cv=fail; b=akpLzze8lMOk50JuFUMsQ9pPs2MQEo6FJrPToXO2iZeuILo6r0S9WCAoshEKlq0MpCSQd1dY7ZFz8bUADaQm5KC6bNasV0PWhpQb5f3IwWc377a0kJnQ3ynOOb1JIPwPiEc3BDFSdgaFgAk5I1pvZmA+lzMnp4HDJeR7cgbDfFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742183621; c=relaxed/simple;
	bh=F1QQXAHBtrqie10eG2r4cF/MAkJ4Zz0Wl5qfsSve9Ns=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QJj40yeFpDp10u9BGfRYbzpXz3jLbG4KyrOpjBMigQM1H7frwhC9svMHkjho26raGFl0PObbZ7x+b5eikMvFverqEnqz+hY+Y0BfiYdp8ppV+mYtF47gEiW6h8thiGds/HHphFLuDGFCyvJHmBaOqpHzwpoAE8Yg1wPRrifsJf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=NRpEuOAQ; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209328.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52GNsD39031012;
	Mon, 17 Mar 2025 03:16:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=S1; bh=T+pAFuyBenxeHtwCTMhD9CoZi2jB8g5
	IDsf/nKD0mB4=; b=NRpEuOAQGmY4aRo04P83PNRwjHNclWycZOLQU3XzqmzaJca
	rNY7RDwvhltoQlp+w9yw0c5Dovy1gBx5DHYnLgQfTsl9weRWKUGbgS9G7rPylnsj
	jXXM4nGMIFX4QRFvOfLtXoyQQryzKNlyz6e/XR5Vb8ucTuwmdGCePaaKZ+TwYPfA
	PI8P/Fv+rkPp68TMXcMfmsnI04dg6TnCNJRHOPkqUj1gnjXuyJh5vcf0beGrWMEC
	p6Ci+Hg48WUgOeOJVw7zx3thPx6gz/iKODPB5M3zNPpal2a9WA/wp+V/7V7XcnSP
	cSE4XYyifd7NJtI7ZPn8EClHIrzbpSTgYsRy1MQ==
Received: from apc01-sg2-obe.outbound.protection.outlook.com (mail-sg2apc01lp2112.outbound.protection.outlook.com [104.47.26.112])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 45d2qgs8nq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Mar 2025 03:16:52 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ngLURMtJf9haWG8jBd40xeVQsTE6OFzAfhTNNazMMWtmUD6YSodqKd48yUp/+s7Kkd2tuPLzlDZwQDAbiw45+SAdhdHhXz/lmfCtixvk5KwPYJPViLu7ESbQNanlLd9TeU6PIcBhtngHIbS7Z3j68BGaq0UjvXL6UpBnCzt2gYtw1gh8+UpGoBX6hG/rKTxtJ3GTaQgW441qY4uRnbC4Y7MSPoeQHou4jurwCD9CdWOIQApj5ziyazgVe+rHP8O9HqJcvhoJWciiPuF/oUYCX9QW97J2NQfSdpBz3228ZVLoYiIvGg/dvytJRktDu+0cIx832Fgo2FkqWCXoRPOytQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T+pAFuyBenxeHtwCTMhD9CoZi2jB8g5IDsf/nKD0mB4=;
 b=nOmstNQL/nGAFYo3Nh1AJtOAW2jtTs5e4O2LvCcDgPUh9YJtrdUf4Yn9fJP9AQzdiLW74LcEwaMioQctG2ELXZnJou/sqrRz6vHBHFqhQVNSFpKfYLpAp94Is1FphCWD6qLjJV6p1QhAP/Yt9a7GUhaq6ZnqwRpsfXji19t2ZA7YTUGBgbIMCvSkdfEHBf/LXXxtxz4lRYyDkZTNGmAMfNn7LmX/r16jgKTBE5wd7ysplza3JYwl67WBnGxBwYZdXOHKgdxlHe+5dgVh/pkQUc3C1z/HiMXvB+TiCd/fxOD2CZJwquLyAJSQt03tDcE7TERrMpGChgGUF2+a8kYnqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by SE2PPF9F733F083.apcprd04.prod.outlook.com (2603:1096:108:1::623) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 03:16:44 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%5]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 03:16:44 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: syzbot <syzbot+f7d147e6db52b1e09dba@syzkaller.appspotmail.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>,
        "syzkaller-bugs@googlegroups.com"
	<syzkaller-bugs@googlegroups.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [syzbot] [exfat?] INFO: task hung in __blockdev_direct_IO (4)
Thread-Topic: [syzbot] [exfat?] INFO: task hung in __blockdev_direct_IO (4)
Thread-Index: AQHbllXQTIbX8vp+XE6T9eJjIhPR+7N2qJ4K
Date: Mon, 17 Mar 2025 03:16:44 +0000
Message-ID:
 <PUZPR04MB6316E1DB152B8065EB4615C781DF2@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <67d699c1.050a0220.14e108.0065.GAE@google.com>
In-Reply-To: <67d699c1.050a0220.14e108.0065.GAE@google.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|SE2PPF9F733F083:EE_
x-ms-office365-filtering-correlation-id: 37bc14b2-1305-407c-b821-08dd65022501
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|7416014|4053099003|38070700018|921020;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?zr/4VEYITcw+zM7T1KekHV2DoNUeid7tfHFXybHNqKg99z2tMRSrsVieo4?=
 =?iso-8859-1?Q?aSVp1PWa7cvLt+He084hTCPtjdvJq6MfytM89nA8fy0XLdAhIVm6TaESHe?=
 =?iso-8859-1?Q?rA9x+XQSf7ZBlCdH57pU0EOUgzMzgthc9yaKZYNEssmQE/6gYESq5vRTr8?=
 =?iso-8859-1?Q?PiM6oIcb96jenxmm3YzkmCnyI4VQVn+tvxmkA330xPpL414gP+Ts1hOfm0?=
 =?iso-8859-1?Q?NkAF5WXFzYqiLHKEbafkkIWZrcfPRTPebksgiAMbcV2OIwaSOIgtF70Zsv?=
 =?iso-8859-1?Q?aSD6azUGOTOa3oZDh98p2tixocX20PeSb52+tMR4hZMDyvasFCuES7jysA?=
 =?iso-8859-1?Q?drpCKNfM87cTVIZLQKc4uD6QD2kEXwB6L678eaneu6vkf88ptOnM7z4DGP?=
 =?iso-8859-1?Q?aFnAupMNjep2G1Dq18B20h6DprXTcFdo3uOOCYcicRGmMf8bUu6geUVLSh?=
 =?iso-8859-1?Q?t4jgJY5fAlkOC2gp0xOeCMtp0g8Y/lxLbtukyJ8RD36aS39x9QXBA318xY?=
 =?iso-8859-1?Q?PwJfxrMOfAyMkh2FWmOJAdFSCw0E4/TZsz8xeZxKiCyEGfhUwyuO8ea9I7?=
 =?iso-8859-1?Q?oVSxbWi71XxG8KonaqZ+MkzKUmw5ldz7LjZ8aNDj4hmHJPtWpp9ehziEDd?=
 =?iso-8859-1?Q?9XvlS8tJyEO2I3YuACHBR54m6f64ypj/BhGdTemK6Y5yskQke6FQJe39hc?=
 =?iso-8859-1?Q?cDEWwRpaAU2AO/LfsyuTM6N2Dd+pjrxS+6e9RZ8L3ug1isApSRC6pqgZ7q?=
 =?iso-8859-1?Q?qDGlcEQbjCg1/yqXfMq5ff0kd6Z5bfzLV2W/vB22H12ax1+JA3gfkooY8/?=
 =?iso-8859-1?Q?nXLn24flDIhg8q9x9nZtg2tf340U/1A7/ccItO84QQqC23uZo6lItnskoT?=
 =?iso-8859-1?Q?U5QKSvJtH/zT8w1ckFLS06OGclVc4pWfm2qiKVdC2haKkxIFOVBwtf6mdw?=
 =?iso-8859-1?Q?wj1ZUps1h14qAiDW/SOBb0gBsuNGL0zV49sF3NQm6NdBbAoFRi1Nxw7Hlt?=
 =?iso-8859-1?Q?MwBbKoo3PDAfNr9dLZV56LkrPpRbPWmJ/ZEGLLHyor2+sReRd8zKnYIiIu?=
 =?iso-8859-1?Q?qGgWJ1kU3dN/1/cNjlFIUgbZXHNf85CWgrf4iZKQmaoAZbX2XZ7oe+r+j9?=
 =?iso-8859-1?Q?NuKOZZgjeqQ2uQGtbu/NS+lYZkDfJQhJ6cRUYdxrIcYHbXBRh500r7JCMf?=
 =?iso-8859-1?Q?p9H12LBfaLux+p4Z0JDzShRQWfC2tCRLDuZtNXqYp5EbQsMHP+G/ZD+L?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7416014)(4053099003)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?K9sG9s6s/8RZARaRAb6hZx6zzvhe4dd6dr+XBnHLSFNkhJkAl5hcgDjmx2?=
 =?iso-8859-1?Q?xjgKZGS8DszxzpkPByAoacTCkhhchD6wNW8SHVCuyErhR90/mOxd6c8nny?=
 =?iso-8859-1?Q?wLNt8Qk5Qa0BBKGc0t+lnnybvoSR6BgUskTLlcqWq0TKFJa7V2UAHMKhz0?=
 =?iso-8859-1?Q?MqDb5BqHlpznZ7W1Yba1oLxgyD9kK9hgqHrg/1xdyTc6pgXKv0rwPXdeeD?=
 =?iso-8859-1?Q?eFRTohIKnPd7nnEubVdjsQMnYay5b3azOQRc+LrVze9C48zbao/Uz9AM5D?=
 =?iso-8859-1?Q?fFkPTf6VK/TvUbUCDEq4yoYzVc8oGgW+QQ50M9KLuvt3S7lHXwnK4J+ZTE?=
 =?iso-8859-1?Q?vsERKnytWOX2qGskoFGBe8JPVw2HOQgoCEzZeyJIcPcPmSvFx0jxqOz3xr?=
 =?iso-8859-1?Q?qQgNdpvbmII0GznEZEBjR5qNnXyv1zFQJXmIh6l3VWKzfC5PyYyPPHQBm/?=
 =?iso-8859-1?Q?teIerWTnIn7g05cd3upr1bPpecXLprauyE75bF3t4n1JrNzIEz/NG4xuh/?=
 =?iso-8859-1?Q?H4hCz7Q1nrOeLGquU0sl4ACXQFcE2RxYgsc4Pt9gwaUoNTSwGJgbkIeKiC?=
 =?iso-8859-1?Q?bt25gbFVNwomM9UWDtRgHXf8r1lYh4yAi3aNhb8LhLXkibrx/1NL69g8DX?=
 =?iso-8859-1?Q?u0I4po9SIA8To1HHOCoAffzpPk+K4mpemEwZs7tlKuwT+QAs2yYQz0feRL?=
 =?iso-8859-1?Q?Y3YqOrNsuIUwaRW8cXBXOQa5GdQizfZUsyG4w2XyAsJkPbDKJgCbtZHfgt?=
 =?iso-8859-1?Q?FJYVWC2RRNvNQRpddxL0YXOMbVCr8cDZC8IdsdUjXGrYThbzkdtSkIQ8f/?=
 =?iso-8859-1?Q?jcGl9040rEyJek6xq/UWmmvA1tRD5Q0kNJblHJqyVhhRtIrqcZJOsoAIBB?=
 =?iso-8859-1?Q?pwZ7lmqRzQGZJUkjBGIHi4tIVI787djPvX3ky+j6tPPRTt0k8ov8ThLHl9?=
 =?iso-8859-1?Q?sCtzUZOi5B/m2Fz0JWPDgDiNl3NzleLGvOi9IPyI35c82Ui0NKV9e94VOK?=
 =?iso-8859-1?Q?GqBXdHOyGFUldRskX1H9Te7/bEyfdv3GfpZ9M97eW5pA+ofqEbthWf26ZQ?=
 =?iso-8859-1?Q?xCfAESRMsOxlLGzcGVAAYU1n5jHmAcLfwWqDk4pb9n5+lzoRTChB5QnUIP?=
 =?iso-8859-1?Q?c0Zw+Vcmp74bLE6v9YlXA9jCzDEwLG8gIJrAzuNTNLle5ZhYGQBuLwhLp2?=
 =?iso-8859-1?Q?Xi4NYtOxbeKaORQln7hs8U6XHg2XjgPuP2NYAn5xBilvhmk623pJ09NIgH?=
 =?iso-8859-1?Q?YTDquCr6dsFxYYMIBXx4mxohIVQ+jHwW8msJd53lVAZVHvEEzUV52Fr7Vd?=
 =?iso-8859-1?Q?qUM3WP8bDTNzSvTk++Vg5Ck3HAMABDJOLsqqxGG6my3uTR1KadGELjRcYe?=
 =?iso-8859-1?Q?XHh0rVr1uqDSV8ItPA3wEGGDs9M6Q6jXweaklBlgRo4pFQronVpYffnpMn?=
 =?iso-8859-1?Q?vGy3vtrZCyrEVHo3PY+eCSgYiUk6cT5gfNcy/sl2PsDDWKdpbqdJtIXqYA?=
 =?iso-8859-1?Q?Z5SyEt/YH7SFu/SKjHxVJQaIh2NLJz2mwFtzj8UdHh7WN4UCBtfxSy+VUj?=
 =?iso-8859-1?Q?Wzl0JaUfTG8C8gOvpTWHdle0Zd7A5yXxidvbB3LHu1H48WOQovK8LZm2UC?=
 =?iso-8859-1?Q?TSdyO8HY4E7/BPfyCr1HJLaL4D0JvyJI3OWelf5i6iUH+SS7I6Gc9hQW04?=
 =?iso-8859-1?Q?Q2+4envZ3Hlmpf19SII=3D?=
Content-Type: multipart/mixed;
	boundary="_002_PUZPR04MB6316E1DB152B8065EB4615C781DF2PUZPR04MB6316apcp_"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KBZN+D63T0mgV2Mdlx8K94K5iidj1faGNkFuXiwqZlkTlfLvPEFO5KFkqFITNEr2OTe/rDbjumAZ5c0S2ndqmeV4e9XMzKbb8tk3pWfBvccMxWyxO8O/9cF0URl04NBTbAlPFPzm+dPNiCBfPDR5ErJd8sWYQuTG/M084vCFbuG7NgVj/7+mNVvnGP11CmDQZToYfqmAJCS1YjtbErJbkSAvfXLNqIT1mj51aE7be6N2fmWw4j9a42Rb84LfXDw7qpYL/AxsTSM3w9imyq7HK3Hr+1+pAofUDyp8iWbB2qh19pT2oAms1UhAeRo+cRPlivwvITDnSJHl0kcqeewLTNPIDG8kXEcEokmvwCagiPyD6gm1Hr0huffxsBO5P2Cmo5hZVduaj2Td3OJnPSZZUOhD6Vqbc7SHvMFhITnDm2u8HdkzPHAuozlZHSN51MZR5BYdiWi39rH/bsKpJCp7FESGrypsEY/0yPrt5X4Maat0jV7HXwp/M216J1c3+PkabGNh46FJWWBJePAUz2lhSl0VOYiDj2ph3v1Oac14yFhSuf5ZVEiRTp3xCHAJ3SYOy1HQcwJhfXzXZooIvLsAljzcoiOAljvFp7qf4+2pyX7Nw0YZcpu1oG3fudV+CTcd
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37bc14b2-1305-407c-b821-08dd65022501
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2025 03:16:44.1151
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: knCIuhCZwG/w130/qtSAh9fqLMOsXGhgFGrFXRh0oAYYVSr1LAOE0SwnOEqWtQW6/cQ2/xdXeESBDITJo4vSfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2PPF9F733F083
X-Proofpoint-GUID: QN-HZS47G8EwJkDoudJ5NUpzQxAReDPv
X-Proofpoint-ORIG-GUID: QN-HZS47G8EwJkDoudJ5NUpzQxAReDPv
X-Sony-Outbound-GUID: QN-HZS47G8EwJkDoudJ5NUpzQxAReDPv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_01,2025-03-14_01,2024-11-22_01

--_002_PUZPR04MB6316E1DB152B8065EB4615C781DF2PUZPR04MB6316apcp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

#syz test=

--_002_PUZPR04MB6316E1DB152B8065EB4615C781DF2PUZPR04MB6316apcp_
Content-Type: text/x-patch;
	name="0001-exfat-fix-the-infinite-loop-in-exfat_find_last_clust.patch"
Content-Description:
 0001-exfat-fix-the-infinite-loop-in-exfat_find_last_clust.patch
Content-Disposition: attachment;
	filename="0001-exfat-fix-the-infinite-loop-in-exfat_find_last_clust.patch";
	size=836; creation-date="Mon, 17 Mar 2025 03:15:45 GMT";
	modification-date="Mon, 17 Mar 2025 03:15:45 GMT"
Content-Transfer-Encoding: base64

RnJvbSBmNWZhNzJhZDA5MjU4OTQzMzQ2ZjMxZWZjYzY1OTY0NmI1NzZiYTZiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBZdWV6aGFuZyBNbyA8WXVlemhhbmcuTW9Ac29ueS5jb20+CkRh
dGU6IE1vbiwgMTcgTWFyIDIwMjUgMTA6NTM6MTAgKzA4MDAKU3ViamVjdDogW1BBVENIXSBleGZh
dDogZml4IHRoZSBpbmZpbml0ZSBsb29wIGluIGV4ZmF0X2ZpbmRfbGFzdF9jbHVzdGVyKCkKClNp
Z25lZC1vZmYtYnk6IFl1ZXpoYW5nIE1vIDxZdWV6aGFuZy5Nb0Bzb255LmNvbT4KLS0tCiBmcy9l
eGZhdC9mYXRlbnQuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBk
ZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2ZzL2V4ZmF0L2ZhdGVudC5jIGIvZnMvZXhmYXQvZmF0
ZW50LmMKaW5kZXggOWU1NDkyYWM0MDliLi45MTdlMzEzMjhjZGMgMTAwNjQ0Ci0tLSBhL2ZzL2V4
ZmF0L2ZhdGVudC5jCisrKyBiL2ZzL2V4ZmF0L2ZhdGVudC5jCkBAIC0yNjIsNyArMjYyLDcgQEAg
aW50IGV4ZmF0X2ZpbmRfbGFzdF9jbHVzdGVyKHN0cnVjdCBzdXBlcl9ibG9jayAqc2IsIHN0cnVj
dCBleGZhdF9jaGFpbiAqcF9jaGFpbiwKIAkJY2x1ID0gbmV4dDsKIAkJaWYgKGV4ZmF0X2VudF9n
ZXQoc2IsIGNsdSwgJm5leHQpKQogCQkJcmV0dXJuIC1FSU87Ci0JfSB3aGlsZSAobmV4dCAhPSBF
WEZBVF9FT0ZfQ0xVU1RFUik7CisJfSB3aGlsZSAobmV4dCAhPSBFWEZBVF9FT0ZfQ0xVU1RFUiAm
JiBjb3VudCA8PSBwX2NoYWluLT5zaXplKTsKIAogCWlmIChwX2NoYWluLT5zaXplICE9IGNvdW50
KSB7CiAJCWV4ZmF0X2ZzX2Vycm9yKHNiLAotLSAKMi40My4wCgo=

--_002_PUZPR04MB6316E1DB152B8065EB4615C781DF2PUZPR04MB6316apcp_--

