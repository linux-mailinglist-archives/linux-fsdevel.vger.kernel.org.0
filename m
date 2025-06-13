Return-Path: <linux-fsdevel+bounces-51583-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E176AD890D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 12:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B3B17AF04B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 10:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B5D2D23AA;
	Fri, 13 Jun 2025 10:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="MxgZT0Ge"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607C22D23BE;
	Fri, 13 Jun 2025 10:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749809692; cv=fail; b=c5rmemu4MSXMh1cIIQqtr27UTISFnPBgbWilOUhcE6dhapZRrvMXLC2faKW/AaIcPR5UwLl5ep+Uxkchb2iH4NMtHX5X2n7LYMTn/DANffX68vFrhB9HZJhMXajfeV9XiF2WhxAh+Ul0XJokmP0NG8H7RV0BDk2CTndJXYGWYF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749809692; c=relaxed/simple;
	bh=4jJrfmv3ZmeQrcC4p4iWksgQMDF7QTcsuDxJ2AMQ4H0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d5A30X8LfVnPCgn63Ahqt0+PMjevjUWuiTf1e4hdQPH6juCfhkUNsQqVZBQ6o041svHycxSaj/8kL39Yd3Zulq7O151BzU9WuEjHb1xgToHiL9zJNoOFPeDJ/rz8HYCVBR8v93MQoLAuVadMPOpVIuPqFTrg96XR5vbiuvbOZDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=MxgZT0Ge; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209320.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55D5H7Me026817;
	Fri, 13 Jun 2025 10:14:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=JXZzO4z
	cKrP6xAtA8F5eLAPNSDoGTEUQdEiG7veclU4=; b=MxgZT0GeMYUjbVIkrZQoGX5
	mzXG0KbSuFZIz+SiuUbvzwIliNuqpcw1ldqp7ZmEtbmEGtlpADyLwzlxI+tt9Zd8
	ZUXfYlNNjvxz8iBgmr21YNYQe4UyoMR2X+275kMVhgEoxp8LUDfo769EfmIuS+nK
	eCE0I64i6VjLbBdynUJahu48DR2zNExn8YN/u9ndE0+tUj+fFULgDeusjITDP78S
	2e3aH6uZ0hYP/PXquszkSgYiZ4su2JLDLz/bOsn/55o0njnwOIAz0ii6KYplBAnr
	23c7kKY2RBm2WhfJK3E/BiB5X6MFI6uWzV7bDyJMtPQyaTBeSegLcENAFnIE7CQ=
	=
Received: from os8pr02cu002.outbound.protection.outlook.com (mail-japanwestazon11012030.outbound.protection.outlook.com [40.107.75.30])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 474bandaef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Jun 2025 10:14:06 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uh7HOyiXSvTNqZe2wwHfIVi9EpAl7tY72FwSejT5nnu1n8sUCD4VLF4yrM1qPLui3TYyaio9dwiPnqZQtm9PRRVAYbgAYpSyVYCoR1LmmrxM1E1pA578pxLZa9iAgYR/Z8KqzDU/ldmpElYWcu0DpvNntr4jjPUKORST/g4+MIZU6cWzu+/iEzcwTXF8s7PP7mrwTuEkjOmw3nIGio66jGeKZt8ls1Sx29SlXRzCBAZyTm25WZHRzjUOZRrYKKyMYX7c6gGEYuCfE7tm4Vtw9jRy301I5XKJdXdUjpZdZanr/i4D0IDUa5/MmUEquxt0eKsFA2BDzCeuOibeXfMVXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JXZzO4zcKrP6xAtA8F5eLAPNSDoGTEUQdEiG7veclU4=;
 b=a2G0b5FgcjWF3mdaqInSr75QUHld1m9PL3sU1sYe4i2Qwx03H8DxMoav1C56OwdFQg+35AoSYHXMuxpWB1n9Tf0LQhq0XEtxAMauJ/4/sHMv9f6AgllpD2zm5A7hEE6zrCboOgwsWT9luaUgY0BZR1gEvyM3tHqWITc3/QxjtbjcmnRadQ08zujWIVtReRSMqSpNMqEuhYmsu9NTIrW/GmItN3pbwdK9dQLsUGEteOrVkj6SGWXCoM1lmG7W+APcHiaeryYkSD7GxL7EBv9tGmCOT83rDTKMl3C5DsFSgTSvUB8kKNPvFhCBS6uBbIwdWupPAaoV3qUNZrgB3wsoug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by SEYPR04MB7000.apcprd04.prod.outlook.com (2603:1096:101:16a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.29; Fri, 13 Jun
 2025 10:13:56 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%5]) with mapi id 15.20.8813.024; Fri, 13 Jun 2025
 10:13:55 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: Cixi Geng <cixi.geng@linux.dev>,
        "linkinjeon@kernel.org"
	<linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "zhengxu.zhang@unisoc.com" <zhengxu.zhang@unisoc.com>
Subject: Re: [PATCH] exfat: fdatasync flag should be same like
 generic_write_sync()
Thread-Topic: [PATCH] exfat: fdatasync flag should be same like
 generic_write_sync()
Thread-Index: AQHb3CvFSyisR7Q+SUOzmxnGLTa10bQA2ySn
Date: Fri, 13 Jun 2025 10:13:55 +0000
Message-ID:
 <PUZPR04MB6316E8048064CB15DACDDE1B8177A@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <20250613062339.27763-1-cixi.geng@linux.dev>
In-Reply-To: <20250613062339.27763-1-cixi.geng@linux.dev>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|SEYPR04MB7000:EE_
x-ms-office365-filtering-correlation-id: a35bde32-b5b5-4e51-e09b-08ddaa630160
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?tXVLCCCVFgZQ47t7bIkp6e6PbvBWRm3rX1/vBv0z34A6W7EPckkkkgCfyO?=
 =?iso-8859-1?Q?Xgg7Q4LgI8hQfmzskUmEzKEtXUCQLHUGm4FZVBIxRDzrg7WA1XBb8XBE8G?=
 =?iso-8859-1?Q?IvX4Sy+//b0tv/Ix76m0cV2+aJSzOFFyX3vqYEP6/RmECXUgFsYPgwFe3y?=
 =?iso-8859-1?Q?J7Y8eEtvo8ob1/3e5ZOV2tLi3YfW2V3bTcUAFbUJeA0zGzsqPq6jsWP8uS?=
 =?iso-8859-1?Q?dlvf56AVSXZZvllGgu+11sBTIm3LFLWcKkAI1pAOszv1+Ovy/FtJC5AkT6?=
 =?iso-8859-1?Q?73PtSwbwlsSF2VfUTpd78hE/OpkUcJYtffIdyYg4JAnH3pZT0sDUcsupkf?=
 =?iso-8859-1?Q?CmeqxD8gahPLfvokZpfD97WDP2R2fAGE4ZQQBv+r+7HqOZlNbIG99l+BwF?=
 =?iso-8859-1?Q?P4EEZSjoTqAzq+tYoPCbHNT4oxX47DEdzh23gdnZHlJTvQS8QRsYVpz04m?=
 =?iso-8859-1?Q?N/u6EKvEFocRPECKF138GJM5iOmLJUTSgFjJcdasEhzyWQ8OrB1XXDTjgS?=
 =?iso-8859-1?Q?ovWIp+uYjFhaX6HteEWNfM21kG9itslqwzFDKJmIPrJSr6DsNTwPok1WF4?=
 =?iso-8859-1?Q?M/jNqMe1G+mjr5kBhxk46GqtxSSQ71fvSwyp3CPkiHC+EHevI9u1DzDEEZ?=
 =?iso-8859-1?Q?wT8D0O2FneSGiFz8hzptyxqGq9YjSQofs/vpNTKcY5rbwvvM5lollVJl12?=
 =?iso-8859-1?Q?5Eu90tyo9pjAoOnVzLsy5v1VglusSktw7mPWyvDvNg9ksmA6NHIBVzI3vP?=
 =?iso-8859-1?Q?kOvoylHcdaA1BArqabHowV1y5mkKXPcaWOPGhwZ6iWCkKNTwCekvxtMHMZ?=
 =?iso-8859-1?Q?EZCMrb96d+MwWLSr8T9PakFxxgqum9qCehDaMwzPdsPBSXNPonkhwEzU7/?=
 =?iso-8859-1?Q?l6qgtamtx5qcaTH3WyHBNL0mCuPZcx/GB//g7cu0epjI+73OGcw8BZUrZs?=
 =?iso-8859-1?Q?ARToh516HPqrH6KoSsHXoHXNMGRIEY41S99BJuJMprt8lLdSgoIbVjqJm6?=
 =?iso-8859-1?Q?WiBLgOCs6t4p0c4o0Lp02lREOyd8XSlCuGW1MT4d7jhbLsIEm+T899Zaak?=
 =?iso-8859-1?Q?xDTHCr1EgEHjUxIqogzy5+s5vvGU/WiOxrenHHh+6nv3MJvCwZVhCO+fsB?=
 =?iso-8859-1?Q?O158pTF7TnSVfjrVVk8ZGrlemUV0MLfyPM6ybckhGNXUzcQVNDvyI4E+kB?=
 =?iso-8859-1?Q?4UHfqDzn9wsOjTlgdoacyiYuTTkFZ6cKtnOj+7P1VR0j76HAY7N+61rqnF?=
 =?iso-8859-1?Q?x0blUOwSR0nXzIvSgfUT5nyyY6nJDiNoJ4o42+EhqkNE4WsnaMZcfVg9sc?=
 =?iso-8859-1?Q?YnFI7rruuRUYDT+n5tRh4cxdrq/2r42vtyGaP6lTpRQ8YeT++LSPNtQ7Y9?=
 =?iso-8859-1?Q?YJqh/nZGIVVzkk9WbRxWjAvlz0zxfKOTlBLJ88d3jiRnoOHU1ZJK1AdehQ?=
 =?iso-8859-1?Q?Fwr6D0ROcrnnwrRTdZulKQOkvG//JJMkBzsphu0o5ie9OpqFEWKNOUYLLT?=
 =?iso-8859-1?Q?NvEPfY61ba+2OR0r4Kpcmx2K4KHek4RhxuFEfmD6PG/Q=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?E3CwXEIMuUu/KM3xeKr4ZhnIseFuNsSXFMz3HQhA9jUz426FKAujUvkC2N?=
 =?iso-8859-1?Q?rYCmREiH4uvSpLIGJC45QimCCZi1ewlvstQQVguACXPfutrKArJhMAR4t7?=
 =?iso-8859-1?Q?xDUUgbr9TkHeKRmgZyyj6GXuBvcQ/xtUIkEdwBYmhXmZmYtI7kZ5uNupoq?=
 =?iso-8859-1?Q?WwkQdGAAMHCJLLFr+AlSIXciqhFrkFcG9nnGZ7JCRvoTdjLquZI6t9i4VN?=
 =?iso-8859-1?Q?Qxn8Xpf+0Vq5ql0iY/NQbWSN9G0LF6tuA4uIcPnA03riOH/aJvKp3bJBB4?=
 =?iso-8859-1?Q?7L3mB4jaq5k12/rppvWRk16BIi4YPOoaX5kyQeNQ4OZ6qMuylInngG3tzD?=
 =?iso-8859-1?Q?4kNYgiTMqXVLeMlfR9vcekkWGs17sq3JX0nY1UiYsvC0eVOLykS5+MhT8j?=
 =?iso-8859-1?Q?NANs0JbeOtmVDIYPF6OWT8kEApop9B+N0fb2HP8+Kv0wmS/tfxBTxoWivm?=
 =?iso-8859-1?Q?PTXYAhwYELVMZUTwFlR1NTyR6l1mieoF6/ziS7VGP0HCgf8tRKXD4F8VkM?=
 =?iso-8859-1?Q?rE8/jGIrByErIzn4p9nl3JGyQiwqvKbEymW+7E5PYWE6S/ZQthiANOyrhv?=
 =?iso-8859-1?Q?IRxds5k2iy/Ak/f8LM8ht/mW3/kNmcOWQLmlyl8Lqoc67IB+aSxqhTWX0f?=
 =?iso-8859-1?Q?YVtvggznCRU+M9vfc5DFT6iDbvcLAauihhEQNnpEySEkdPsc4FiCC1cvr5?=
 =?iso-8859-1?Q?qmN6UlprZHXLwYuJxxfcHLAFIvbSoxIDJMBlkhqkdbsd918Rb1lHJSj03F?=
 =?iso-8859-1?Q?5szziuey7G45ldl1imGfj//Xj6ADEVUJrFLSRBvqi4QPgORhm2FPxhMuLR?=
 =?iso-8859-1?Q?jnk+XndkbVswC4nUmboHCpDP35SNzSCu5KjPluOp/funh+G1H9yJRAdXGq?=
 =?iso-8859-1?Q?2Va/9r+L2RRg9oOJQCKOoOdTtO5vwSTbAD6REdRexs7gYmWliAoHHrSIHa?=
 =?iso-8859-1?Q?RFAKjTzy07PSMHE4zqCGfE1bed0JEXtGe4SlXVfesbSU97JnHxy9X7uDwA?=
 =?iso-8859-1?Q?hVp/Of9b3rJ/WxJkDl2wHwbdSybifWii0aGCycikJ/jdSweLc6ZqFEFucw?=
 =?iso-8859-1?Q?Kcx8FTULT1/VcC9ISp49KD6oPkXg4OOdg/BSdNPQc9XZlapSXnyrz39A2M?=
 =?iso-8859-1?Q?aUJzUnFJNOnhwXBSxkLWHSySt7T8KwqzrzOYi0TW39DrhVbLWAr2IBXjtJ?=
 =?iso-8859-1?Q?mSz/wRlGiKk5cGlMpc5su78jP9d1Ob+ChLxPfveAWYeEGrlXi55QevKcFP?=
 =?iso-8859-1?Q?63Nv8rga3n0/zoJBi4BNBnrC0TxamQwWx067q/t1fFiHX1V3OCxnr4RKvE?=
 =?iso-8859-1?Q?P/KgK/rMMKr0D2EhuZc8J/Y+csfW+X5VyZR7MVxM1LEExvE18faLDSI1yC?=
 =?iso-8859-1?Q?JW0FjIwvNSIKv/pLPYsyEHkdaCf+WGrRHrRaSAzu7fyLSqruW56TMcorBu?=
 =?iso-8859-1?Q?218euByjk7LMg0l87V3hnDaotsV4owqkAEwZw1tB6LAKngLixyAl2k/xAY?=
 =?iso-8859-1?Q?hEBea0/wT9rrCF0LTD+TLtm8ru0KVS3fLziGPENJ75shHGUswWDTkPQ+qE?=
 =?iso-8859-1?Q?MEjMSnrkxdew3ceMwHOKXxDYaKu5bPAF8pJk8S0B01GcN3y0cuEbdtRHrT?=
 =?iso-8859-1?Q?UqVaAu0YZ0tvjK5Kcc7NArdSalZjbylovIdG7FxRH6QMWFg9PaoCQRwCO3?=
 =?iso-8859-1?Q?Yn3QGi71rXeS5gjOZhs=3D?=
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
	UAoq4e7TxnYpUz7HLOApnk8W/k4Jkh1VSX7ZUXwuVXvpfjnZAjiHAhTAuoPzDOLdz59nuweDksv7s5pwLjLe0FuJOOoeJ33OFL0Q/mz08+h6OSfGZ61Crk0JdxLkGOqiL7mtwlQEkuWkH1haDSjx+zd02Re0MEbRsJLFxY7NB5bmTvyf8XSbAveltwx21XbMwEyyFA4EG/W2p5CTUED5rfTURScFmc/nWGnEuwnm90Rst0YbnC7qZKTF9A9PcZ0ux/MQx9Zt94FqtJg3gNe7UEMh04kelXawmQ+5ygZ8VQYdbkXFVEf3By1jwMGi3R9LwD2Fva/ec78gwn+eN2cL6bFyFLlZ5a/Yr88/a+JYTPITsSsiUfOoYoD345EtWVuYduow/IBKBbevxKMaskuOsQFEprzvfrK3JBTN6kHslEhR8S1MKIS10njwBMcZbllJqwbadRMSjc/mO0qyBc0NjdcB6IK19LpCAairx9qcOc1Utal8ZsWDHMri1xusgatnmBOznhaOBf4b30cVk+Z45at3WFZqfpNrgq26akBRzvX+cblWCj65iJAWXOhl8SbDgjozbxfmbOT7qbJE50sXCongWnPw2rbj502RiYj6nbPNN6xwLUpIHPduirgmjC48
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a35bde32-b5b5-4e51-e09b-08ddaa630160
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2025 10:13:55.7662
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wDRY46L7qP09UW0vFFLpQMt3x4Eqxjzn2L5vbe7G5wV41jdkA0y2ZF+25PNkXlnK7nFjyTujaK0Cl/dd2AWS+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB7000
X-Authority-Analysis: v=2.4 cv=XKQwSRhE c=1 sm=1 tr=0 ts=684bf9ee cx=c_pps a=CxsgeCAjkRZ/KLQUX/i4DA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=6IFa9wvqVegA:10 a=7j0FZ4iXMVMA:10 a=xR56lInIT_wA:10 a=r-GZ6k12N-yjzqMV0AgA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: 5gWNj0Z50sXYjMwobTGB3BO1VKblmHT1
X-Proofpoint-GUID: 5gWNj0Z50sXYjMwobTGB3BO1VKblmHT1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEzMDA3NCBTYWx0ZWRfX0eCVFkASLm29 2aXQIF1F9tdTw4zH+fL7j5UJn2+9M/VGclVyBFUvZRC9rAGK4xM7KbsDHY4ilglDAZ9KeiGw3ne sKW5vegoZOmsyGjAdt2E4eC5YPek4W4y+5caXIYqApg9FWndwaXUxE4eimwXxym6XBNyfYHJ7x6
 qlx5sJ71hcwy/0saXASwoonxW8d2td0EQYMt5YDxX8vNKRrT7ua1KCVZKljCm9BWpFo2HtgXC5T zaamJTwpYgzYXnJy7xbnCs9iiiDIpeILRyqdGKKh5aAKOWSdPnLSLFBH4TfCj797reH2+hIeWRl aSbWXi3ptKjP792eknCQfOqKj0+WutDXDRfNr/NXqTm9GvmxpnVx37SkbZ4oabMvYcexByftza3
 9hiVKdHKC596GbDT22mj1L4ilW4D2pBBI2MGrze+l+M9P4bz3cVDdMkW5xyMVB6NuVU4LQWg
X-Sony-Outbound-GUID: 5gWNj0Z50sXYjMwobTGB3BO1VKblmHT1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_10,2025-06-12_02,2025-03-28_01

> generic_file_write_iter(), when calling generic_rite_sync() and=0A=
=0A=
s/_rite/_write=0A=
=0A=
> --- a/fs/exfat/file.c=0A=
> +++ b/fs/exfat/file.c=0A=
> @@ -625,7 +625,7 @@ static ssize_t exfat_file_write_iter(struct kiocb *io=
cb, struct iov_iter *iter)=0A=
> =0A=
>        if (iocb_is_dsync(iocb) && iocb->ki_pos > pos) {=0A=
>                 ssize_t err =3D vfs_fsync_range(file, pos, iocb->ki_pos -=
 1,=0A=
> -                               iocb->ki_flags & IOCB_SYNC);=0A=
> +                               (iocb->ki_flags & IOCB_SYNC) ? 0 : 1);=0A=
=0A=
How about calling generic_write_sync() instead of vfs_fsync_range(), like i=
n =0A=
generic_file_write_iter()?=

