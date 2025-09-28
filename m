Return-Path: <linux-fsdevel+bounces-62943-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB33BA6F1D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Sep 2025 12:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E9213B9858
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Sep 2025 10:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1832DCBF3;
	Sun, 28 Sep 2025 10:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="MHfqP6C0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638311AC44D;
	Sun, 28 Sep 2025 10:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759055362; cv=fail; b=a99HOyL1oL2roIGNoW8PK2T5FFMgFAgKYHmO0iR6D7Pia8yTKcGxicmq7QKFc+B8GiFhirwgnLfJkZ1hT+FqAT3K3Tmkim9d4TsiyJkQFr+TzS80mU+O6mlGTzQqYBxq80WWj1UvuO1mxuTF41iSee9X6qI79PXo+alCUsg8zug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759055362; c=relaxed/simple;
	bh=AFbsMYmPpp/j1gmflKVWbQ952AGtNhEVx+sEFhIg2/w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RzBKN4zmamRRkkSpCFgbEPmkl9YrpQYX2GplQa8/dPh3hT6FXnFKt5+JnDnWvs/PVakifHcBP2rKjUxOyLump2BilO5ijuf99ebSFxq7VP5d+52hhxlfRJ9e49sZOzak0ORMTeUmk7V3evGnp1BmEMUJfuG1o5aP3HbqwjFhV1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=MHfqP6C0; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209319.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58SAPAft003558;
	Sun, 28 Sep 2025 10:28:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=N/HqyOx
	R7X/MaMtWSugC7e9CT/EjzDNIcK8jxyolFRc=; b=MHfqP6C04yn+Z9kuX+0uAdc
	oB7NoaKAGR5GCNszkQi2hLyB23YT2dzO0N5/sgdHKFWS2uwYOitj14+8QBilkzVY
	2bQ8GatPT3GQiK4AbDvQIkwqz+M6kHicNy2ovAYjPqiWqIXGeScxb2AC7W/MADji
	cDvPobO8XyMUc5SU0MduHCQLHBDDHC5zDKLGgiR1Tu5oicrwpf5u6QLpKHlzB2iG
	vGC9Im4yfVtWd5CncCOILG7tTeOdUDzkp6d3kDYioCp3MGEL1xuu1GxcfHAUXQiT
	EuBWTh3itK6zdsckzlI8E33df5+G7Rr3+nC1EvDJ1PWNJFtAeDZsb3+/zmJkPfQ=
	=
Received: from seypr02cu001.outbound.protection.outlook.com (mail-koreacentralazon11013003.outbound.protection.outlook.com [40.107.44.3])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 49e8aprx08-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 28 Sep 2025 10:28:57 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vgfuPCGRqQSCRkpzWIum+yIj+GMhctOzSL5WCc6q/3T3xhcgaaiK8sFfeFhqvPT7LGnE8a00PZLkee+SM4bKNXZoKHMzmiO5d/z5NMAaDFY2h8PEzVOA1JbQdSBx3v6Rb9hbLvLE7FaPqJFLiDOFwzt11ji15dcnE/49X4ZMXSp/l4wiKnx6xVNIrOMun02bj/N+kcb4zOxSPVZRyPUOAx50/nWOWs04Wu2FRW2ykJS7uZNpdLMe6OC/RSHYB8gkfOj+nfpEXdgqNIt+j4T0Wy5+4H3GMf00Kg9ZmsqcOZcICwKN7DqoddbHwxpdSekjSqj3ZuHz5sO0ZnVe+yvgsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N/HqyOxR7X/MaMtWSugC7e9CT/EjzDNIcK8jxyolFRc=;
 b=G/NnHJoDWbKGP/KOul0siTV49Lm4vFokV1gyj6sKOOclpxSlvjWr3igCFE+cwK4UanJB5yMBPmjYvoudu4kZB0fPNLJOJc8nz2d1IVx4j40ePrHXXZb9Xx9Q3UKRSjfAedF+5fx2QmSPiydC9zlOmD6r0gE4yt4B8/ncRGB4jrCZ3/t/RoLPqZOw6zLb2wJcr6dNa7l0SQYh1XvT0GS6UjsLgmlgJ1Xmd66BimAroNNCUXt7FFt6BIgTs6pBaVb/ifzcJ9v6MPD7mYj9QEME4iDneF2QjerlaG8LL/uzA8zNoXwW8atHRpcxMwARUaS/ylT6W52iAnhabPE5Ae4Epw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by TYZPR04MB7580.apcprd04.prod.outlook.com (2603:1096:405:42::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.15; Sun, 28 Sep
 2025 10:28:50 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%7]) with mapi id 15.20.9137.018; Sun, 28 Sep 2025
 10:28:49 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: Ethan Ferguson <ethan.ferguson@zetier.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cpgs@samsung.com" <cpgs@samsung.com>,
        "linkinjeon@kernel.org"
	<linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>
Subject: Re: [PATCH v7 1/1] exfat: Add support for FS_IOC_{GET,SET}FSLABEL
Thread-Topic: [PATCH v7 1/1] exfat: Add support for FS_IOC_{GET,SET}FSLABEL
Thread-Index: AQHcI5URFRTyqxiuiUKaR8Ox787GqbSoeWB4
Date: Sun, 28 Sep 2025 10:28:49 +0000
Message-ID:
 <PUZPR04MB6316E73EE47154A64F8733DA8118A@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <20250912032619.9846-1-ethan.ferguson@zetier.com>
 <20250912032619.9846-2-ethan.ferguson@zetier.com>
In-Reply-To: <20250912032619.9846-2-ethan.ferguson@zetier.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|TYZPR04MB7580:EE_
x-ms-office365-filtering-correlation-id: 4d54132d-d765-470b-8e90-08ddfe79d02f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?2gi3iN7I7xQq+MO8TUc9gGwdYwNkZY60JIOQX+QeRXa7B1/qfPgC/4ftt0?=
 =?iso-8859-1?Q?HuRmSZnE4lWhY5is5fwUatakPaGifme+iXC5ucygSmZ8DbSLMc7M60K+OC?=
 =?iso-8859-1?Q?gAlJmpRwmjR0z9MvySsxjvI9w/sPlJ/1MzBCgLvE807BlvEqillAYm/r8T?=
 =?iso-8859-1?Q?VL6oJ8nckbywYrB1+Kcq3ke04aF7lckaryRxdhz/ButOL0YC2mJ1ihPCam?=
 =?iso-8859-1?Q?AtoTycT1HGFvFGi/yDEVBYd+6Oy23PSHO5uNJA+WIzfXv7WiYVSkW/zEVg?=
 =?iso-8859-1?Q?dnov8WNqVoBr1FW93KDA9bzT7zMoQlfjWQk1TTOwfRclALMTB37CtaXtXQ?=
 =?iso-8859-1?Q?Ar6wOkqiur0tw2Gn1EELM2LGbn0W+IM2sgPAflm4E9Fmy4Abr+zCsZ0ySO?=
 =?iso-8859-1?Q?nH/7/dMQkZ/C806YfC1aXyqb7PEx/P/HlTeoda8wZfoWKzKuvc7E7HMxiF?=
 =?iso-8859-1?Q?Bchj6l/w3sAD2dteE+vcnZ/+9IXn5oMOfh/vEsCLqZGw5Mz9ILqKXdOQRd?=
 =?iso-8859-1?Q?saE8Rvtox8CRlxvdKxOW1bhhThFLyKysYq4NwZoyZq8a0cMvSxAlxAoD+I?=
 =?iso-8859-1?Q?9Pse3uhHrigxQi0LWyXOfqXb+k3rG+NDtVpkLmlCXyLqMtAHNhHVT/ULsX?=
 =?iso-8859-1?Q?1NdSaiAyN19Dha4hCQ9Yt8yStQxvmEGdp9rYdcPU7d8NEWxvBuzBdd2siK?=
 =?iso-8859-1?Q?hV8jzTWBQlcmEXsZK9eIF0LlM8TFfRTkdMqCXnnxLHOUBqlkykW/SyuIxq?=
 =?iso-8859-1?Q?zdpE1V1KAmTyVJkYl/TKGKCbtCoL0GwH5oLsb/1TjJlqAX/eLCIzIu0+CQ?=
 =?iso-8859-1?Q?/W65cnVuFphOGmHn3ZWQLPSgFJwokypaON0aNWDUBm/SEU2LKNF2syoR8u?=
 =?iso-8859-1?Q?IyBj6pltGe45ChnF7KudZtIUwGp4yv/T1pa/9e9P8hcBl2NwIzAS0cfwVN?=
 =?iso-8859-1?Q?50T48qFfLhdY5bMdxbHDMcrCo+l9LpoSdf0mpqE3AYVUVlXTQPFatXp0Mo?=
 =?iso-8859-1?Q?LwwlJtiG1XONLIvbI4ynnKzHTLylYT1z7DST8UbwvxpYEm/mH9//uVTETG?=
 =?iso-8859-1?Q?ZSGZLSyJCso5jKty0UV81mpvkSpvK1m99vFU/BDYutTjhGQYcraD8Undr+?=
 =?iso-8859-1?Q?84LVe2Z/FkdkbctV6RzRNrN31NUnYnwULpIywWddf7ubCZ8wTPOcirUnqr?=
 =?iso-8859-1?Q?RtbkgDyw1pbMtoS1wSyY5ESQ70NtZ2m+fPUhhWyYg1tWu89w3xDa5Luu2F?=
 =?iso-8859-1?Q?0b13wUmQVs9501UtBm+HL/6VHAxPIk75w22ksymL2HPUTwijF1puUfJm1g?=
 =?iso-8859-1?Q?wl8RAI2HZDlUROY0Pn8LT8s4LlfObqDsefCnLeGTE4QZI1dAfKekKXmmUJ?=
 =?iso-8859-1?Q?N+sZV1Nd2cNoQO4Wc+kdbL31f+S0Q57kNN9wvkYCgeyf8rHRFqLo2OpkkI?=
 =?iso-8859-1?Q?DnxuMAWkn1MNKmYvjE9dbOSRGnxS9b2cHm7xz/S98amEhc9bI+a9/nQiTG?=
 =?iso-8859-1?Q?h/bvyfDvVY/M7E/sxdQ/Vu2znCRwvwG7uXkrX/XfMNP1KwdHfTGVnRXGk1?=
 =?iso-8859-1?Q?M++sJZ4pR0wn+INtK9NhH9OLTOTu?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?y+2p5iJMp/sB5bWum7K79dTbuWEaTJMZeX0f477lwU1Jd9vyxHoBBQeshY?=
 =?iso-8859-1?Q?DtoKaVn/7CbwFJ323y7/LXgZ6rxmM1IcqziHAo9cqIiB44N9TATmIqyVFd?=
 =?iso-8859-1?Q?NGT5on/gmvd5daPDOtBOUM5v/XHvIU39Xr7YTHjMNppmdFXUWbQ962N0a8?=
 =?iso-8859-1?Q?sCvUF7Yptinr4Xt2+dbORNQGn48+JgLu+Dbr2jJm6qCV9v9Jz2ob/ViA3r?=
 =?iso-8859-1?Q?0t46xpaYYnxGlAcUeHMoI0Ovex50jC7x0sVJKQ7awFM2HYguKy09+XWid+?=
 =?iso-8859-1?Q?6n+Z5UeyhSjCLzUvgq7+CMw9q0ZPaVs+5FuUbWl6qt9GTv9XwZG3gX0v8u?=
 =?iso-8859-1?Q?A1/YxstuGZ+9l7GU6WbZHyUu6GH7eKMvFuwGgDv5VzdNUj83IBMIIY/6vM?=
 =?iso-8859-1?Q?ebWqaoN9X92d5SBlYG5YpjDx4wHd1rsOX3cZPMXJLqvRzJ8wDPjRHc0sJv?=
 =?iso-8859-1?Q?1R9pCU2WOqeP7vQHfM7CG9N7vSHPVjDU7Iimy2ebPfX/K9rX4RF0P7pctK?=
 =?iso-8859-1?Q?Rc0kKIHBDWFagEMAokkFED3bqTVPEj8hz7zEtQUd3a4avkSgcJWEhCK9jX?=
 =?iso-8859-1?Q?XzcCwuAlrcTUgRduaMeOi0Bub7vEcoEjUio5cr9/sXLnDoHNvXLpTVYcTy?=
 =?iso-8859-1?Q?7Qyy0yNfsEBpQ47Dc533nOLqDNA6WfnB9BXF5lqDZMAS7Mx3iBTRG0CZH3?=
 =?iso-8859-1?Q?wi0ByakFuj/FgPNLxJ9dRFpyQL4DNvvJP+4VwzOXq95MdNIdrE/8QTEb1/?=
 =?iso-8859-1?Q?C6aV8pysT00EwGC/9aN5gbiid7dkhlfkfA+MGwHynVLdUg3Xcltw+d7sDc?=
 =?iso-8859-1?Q?3SNbRdD4MITy/krmWpyLiAoq3uKAGzfeCki7spi1H/UqBGgLSlk+qOuxMj?=
 =?iso-8859-1?Q?HrTjak6IRBCV5D+XRhp22aO9OcN9KF0Sm5W3QJnztoXCYHS3cZ4WihLUpp?=
 =?iso-8859-1?Q?fzAY8BuAlLvNXvGOaGga67AjbI03epvd5JolOl9fRXoQoxk2ChKOimup+S?=
 =?iso-8859-1?Q?pgYtbP7zULUeFTiACM8IZA6CAlLAstYNUTktdQCtsztZ81Mk8OuxvnHaT2?=
 =?iso-8859-1?Q?BsMKAeHF5CzSk53GqIhpOUVVPo3LufIxE7SxojRTyGEfVdqRDbmg6Sou2w?=
 =?iso-8859-1?Q?ee1qctf6C5GpvICtuN+TVVMuE2lKHpYOOWs6IIUDWnFIko4AEH7Yk6CfM7?=
 =?iso-8859-1?Q?og0QJfNP+0RutL8ros6CPH1pdWiT4LgY0NbYsttm1qdm1oB7dk/ZR4e1wR?=
 =?iso-8859-1?Q?HDcxEKj/u/eNbAqbE1yj2OLe0AIGFDzFPqGKf8bT2V8N0NgDjaxQX4+WnD?=
 =?iso-8859-1?Q?9Dv+3lkYOUGvbp+rEzD1bByGipYVZPgTXKPM46VuGgBzhRmJz7u7o/rKab?=
 =?iso-8859-1?Q?1rfWWdX2hh+GU237wl5VxrcJOLBOqoLyPb/JkT3f3KXgAfZIXrweQygB6P?=
 =?iso-8859-1?Q?JwfjlSHJHIbRoLQeT8MG33/HZirU4m1P2L4rIh66c5Ecb7C+j3PClYgJZc?=
 =?iso-8859-1?Q?Rgah1WIby6QkZXVxy7b8jc2Q/4gver+EgWMgvwh/qtq5w0KovbcsfUKJH8?=
 =?iso-8859-1?Q?f1KVzO6FnmMpUSm7s/Qo2adbh7YFv5Whkf8nSoWCiuAOE5zkOv7HuR8coS?=
 =?iso-8859-1?Q?X8uIMka5VnahsReSbL45vwg1NB7OhVjkq0gubAbTrO2al8uup/oqVlmg?=
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
	Bkkvj0U0OqqRC7/CiEmDw0WoysTKrq05Kw4TL0112a58xwAvS+7T2MDgOgE+FgHKK8Vp3zt5/FMmeUXjyLrdkNeYWGrpZNqcP/pb1h6Rx/kIDXPI+sxmcEWSbZbwdrGP4DNwMJrHRWBrXTZZXUCFPeuqOVaJp/hFLKZcuE5trFWoIGSgKHYTQsLnKf13Dl6WfVaYcAs0P2GzCZPUyHdfTIqjPnb4Nbr+KFOyYTvkKDOWnyHP62lvjLxHVXIRwMULHPfVFdHdRtv7U9KPtAgAgHNxKmS1aMVdNdWOd6e0v4uHXGpiSZcJoOJwLW4Tn1iLO+Mj9ljqPb3qsREeCqrKeNOmcMuzyd7L1wszGzDdB7zJNrf+ArR0MeWxSfhdrk64BUK+FsMQcaPRBZODHMvVngkXydoW55ldqGTRGDZYCPtEPvoMIgETfE4K/KkJwzan0TGrGN4yTH2vw82El8k5/p0FhsZGw8n6UmHyPw1+skXeWHRcRlmkBohAhyIP6zv5+/F1RtSffxIrVr21EmkiaJUs5PbHoYL88lArBFlivssk7rnO7CxETsxMRFtB6EIh1BkYn62stRy92cUCKXQrDUd74PSg+gKfJN3Ur1TqfyHNfrIte9HQJPAvG5kS2EDM
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d54132d-d765-470b-8e90-08ddfe79d02f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2025 10:28:49.3443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sfuCWUNzKhu74KuziRuGuxBChOhrDR8tF0Jsv8l6Hqx6t+X9AnAGhjz+tWr5TMYEK/MupEAER3xSCNoVPGrgVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB7580
X-Proofpoint-GUID: DkEbZyxfSbcfwW9f75Yge_lgcXzhJ48M
X-Authority-Analysis: v=2.4 cv=FOIWBuos c=1 sm=1 tr=0 ts=68d90de9 cx=c_pps a=P6ibNFzTp2C+69c3T+22kg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=yJojWOMRYYMA:10 a=7j0FZ4iXMVMA:10 a=xR56lInIT_wA:10 a=10nkISAlAAAA:8 a=1xgHMYrItmZ1riA2S14A:9 a=wPNLvfGTeEIA:10 a=1PkcQ2-W0spTykm8yBve:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: DkEbZyxfSbcfwW9f75Yge_lgcXzhJ48M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAzMyBTYWx0ZWRfX5J1Tf6DnmrLN iSBhXffmLu9UX1JQsYDppy3YGBHmkk/QNXaf7+jpAzqwroWnqnN5Rhi50pAOzu3AA73IYlglfFP Atr7ypXPOgjyoQvG4GNI6Ucy7oBEHznWByrAShHX8wb1wKZ1Br4sXi/BxlK0LsYE+UcE7ShzHc/
 OrDRPPI8U5MxaP+k1sbrTVlr+zP13A5tljbr9molYPeHqHEQ7ozr11oDoMG7PflZrhehhO3dssx iu/LLm06FgfwqhS1bTgTckaqPXjw0fkbQD/h0NYxEVanEkzq2n654DONAcFYF6vM9lPmoiAjqOa GJQ8G7w3guCHNUavsnHeLElR/VgnDHBYf86uFF80qImmFuQ1upjT5xyIELwCWlWLDbyg+8vPQPV
 4wLDgOxXUDOD6yoSVPcv+PrVeyC8KQ==
X-Sony-Outbound-GUID: DkEbZyxfSbcfwW9f75Yge_lgcXzhJ48M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-28_04,2025-09-26_01,2025-03-28_01

On Fri, Sep 12, 2025 11:26 Ethan Ferguson <ethan.ferguson@zetier.com> wrote=
:=0A=
> +int exfat_read_volume_label(struct super_block *sb, struct exfat_uni_nam=
e *label_out)=0A=
> +{=0A=
> +       int ret, i;=0A=
> +       struct exfat_sb_info *sbi =3D EXFAT_SB(sb);=0A=
> +       struct exfat_entry_set_cache es;=0A=
> +       struct exfat_dentry *ep;=0A=
> +=0A=
> +       mutex_lock(&sbi->s_lock);=0A=
> +=0A=
> +       memset(label_out, 0, sizeof(*label_out));=0A=
> +       ret =3D exfat_get_volume_label_dentry(sb, &es);=0A=
> +       if (ret < 0) {=0A=
> +               /*=0A=
> +                * ENOENT signifies that a volume label dentry doesn't ex=
ist=0A=
> +                * We will treat this as an empty volume label and not fa=
il.=0A=
> +                */=0A=
> +               if (ret =3D=3D -ENOENT)=0A=
> +                       ret =3D 0;=0A=
> +=0A=
> +               goto unlock;=0A=
> +       }=0A=
> +=0A=
> +       ep =3D exfat_get_dentry_cached(&es, 0);=0A=
> +       label_out->name_len =3D ep->dentry.volume_label.char_count;=0A=
> +       if (label_out->name_len > EXFAT_VOLUME_LABEL_LEN) {=0A=
> +               ret =3D -EIO;=0A=
> +               goto unlock;=0A=
> +       }=0A=
> +=0A=
> +       for (i =3D 0; i < label_out->name_len; i++)=0A=
> +               label_out->name[i] =3D le16_to_cpu(ep->dentry.volume_labe=
l.volume_label[i]);=0A=
> +=0A=
> +unlock:=0A=
> +       mutex_unlock(&sbi->s_lock);=0A=
> +       return ret;=0A=
> +}=0A=
=0A=
Hi Ethan Ferguson,=0A=
=0A=
This function has a buffer leak due to a missed call to=0A=
exfat_put_dentry_set(). Please fix it.=0A=
=0A=
Thanks=

