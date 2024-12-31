Return-Path: <linux-fsdevel+bounces-38290-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8499FED36
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Dec 2024 07:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73CFB161260
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Dec 2024 06:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E673216EB54;
	Tue, 31 Dec 2024 06:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="FdIWaGn1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75421632D7
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Dec 2024 06:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735625875; cv=fail; b=UURne3EHVWccYhuZeFMB9LymDYT6jP4ksIW209552WXMQs+07fsL3Iqm06q/Q/dFdiEevf87uycxqIK8W2H8iYAiO/LNq5NZ2w66F8P2bFqkdihYqd/Dfyadehf46hTpbqhF/d/wbJ2vySFy99ONitRlQYU1QxuLnAEBsRVPaYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735625875; c=relaxed/simple;
	bh=s9B2EtblJ7apzbyEWyebB2yqxp5dZbMpJuM6m4YrV4k=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=cL4gQxd5E6RdPioXa0kcpOUMwfWh4pmblo8ShjWk6Dvpg0ieK+5mcnSwQKYW3OpLJFAx9UQXhEwGmKtYKBLc1ZflfLXj17DcIz/Tvrw3BW4+lJET2klnE1jG6sxRMVbTBHipu3gq0tV4tI9NMLzTXH9jqfZFNetYObNvmf5tlbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=FdIWaGn1; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209324.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BV5dSBi021515;
	Tue, 31 Dec 2024 05:40:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	S1; bh=Jacon7mZondtT+013piln1agkm+q41UjG+EdwcN0tms=; b=FdIWaGn1t
	NGAdqvwPAvOIqUxcE5kklCr4vZGycHqjKQsiXc3pUzHGZGtW7XBFtJxfqWc35mqi
	Hz8tIXNlYE/+fNnkAc3ilTovH9ZIQ0GpVmmM3OA8kbKlMhL+nF6EDQaT7qF4bl/7
	jSK7UfnS4VgT4sFI3HghCKoKMB+zENmTtjI1pr89ixPH7GHZlOAeL/t1z+cWQ3Yc
	yonwmhnaN0rtJcPzlre8v9EmllTfvipBSjBMVes4stg+iCoKd/1D4PXtnG5OJmYG
	NV4pTL07eu7EYBJA9nlYdrmYaYKOXTIP0kBOdql5BKQ2QM9QrXjIS8eV9IG5+t+X
	7soKH+VH/P/PQ==
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2048.outbound.protection.outlook.com [104.47.26.48])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 43t6g320w5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 31 Dec 2024 05:40:23 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lzh+9ZNT0tY7zJmNM/81SHoLWa4GH0ChkcPvbZz2+/k1H1xPx1h0Cr6VGBvqcVjNuzA45yt5BnhEwad9VTySNsZoNJRpRYPWWsV0R9TcUhb1EZGokLm9eFfK/joTiTZt32xDH36QF82iBrln+TNR19EDcX152f/Ivt4rXvcPsvscvZcUkDDWAGVBEUdHy3ILQtNsYkWpm3YBS/IGiFDwxdvetaDoUpVN2TBgZaTfpnpg/tSzm3Ubn+9E+y8xgF2sByzrsCVKuIxv2C7OieMeQztj6/VWcrXnP1140IWwQGMrmHjbhPuyJV/c5uvX8sWhGhCXp4wuuGyM8rbDi2ZvJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jacon7mZondtT+013piln1agkm+q41UjG+EdwcN0tms=;
 b=hnsBi7MMcGH2026ea5ohSqnEyh96mkim0kb6u/X6X/c8r3L1IFJgTduQ5TPnHwgMpetbVsq6dQFVa1X7V6RwH41kpDxXyCmILj1ALkzR10k94LyrhztlKzYij5rV6ybCNTlGu+BC7QcoYGwFQVSg0YxHEtClwCV/igT9EvtvwzGEuazvmrxeDVJo+qTzjwmQ7AzgzrVvlU6FYyPED9WNFbb4RQQ1Gd3GAKZ62xz16ZZ09MbU7UGJpPQR9U+d2X7zvOI158XVdUGNUwLTq+2FZxq+P4W6kjfxCNSF1+IX1GsOoVXpEjNYYJARAcQFNFJwfaZgrSSK3JHnEltIh0luyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by TYSPR04MB8128.apcprd04.prod.outlook.com (2603:1096:405:9a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.19; Tue, 31 Dec
 2024 05:40:18 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%4]) with mapi id 15.20.8293.000; Tue, 31 Dec 2024
 05:40:18 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: [PATCH v2] exfat: fix the new buffer was not zeroed before writing
Thread-Topic: [PATCH v2] exfat: fix the new buffer was not zeroed before
 writing
Thread-Index: AQHbW0BN+ZoUCapwaE6xAGnGRVTnuw==
Date: Tue, 31 Dec 2024 05:40:18 +0000
Message-ID:
 <PUZPR04MB63167B83A765549A1B7CE375810A2@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|TYSPR04MB8128:EE_
x-ms-office365-filtering-correlation-id: cf2fe9c7-e54e-4eb2-7bab-08dd295d9be0
x-proofpoint-id: d8690225-876f-412f-87c6-a7cb45557a4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?MNS6JT7HyvrWhltVPrE93+T2ZAdTza8mipji0aKWYNNftmtVfcQmoGpbIL?=
 =?iso-8859-1?Q?ypgbl3t4x34uBVIdo/hMND126fbTFH30exyGAqJgMI25XnX48iTD7ytl5g?=
 =?iso-8859-1?Q?qi+qv+lhY0WDPBXLMJzT3wMLqVhK+dcjc+79nXK7OKyukhgaj/7QYjwqFx?=
 =?iso-8859-1?Q?teRrKe5pSB0SOJd843UGpvTDRJwd1mu8gmscOPi/y81ifQqGc85qkzTiAC?=
 =?iso-8859-1?Q?UP0GVQuOWJjIfxJI83UAHE9/SwRdDlB5oxUqOQ0nnV8ggZkq8B+Cfy46HU?=
 =?iso-8859-1?Q?0xxsgiFVL9DzWUI59WbFpaOvUTonXqVkVjrxEWWr77jTI4cdIzarTtu9sJ?=
 =?iso-8859-1?Q?ptmOjHmYLGBDdHJF6sMkQSSii3ETLkn7eElJJRqdx67phwhscR1bIPxgWF?=
 =?iso-8859-1?Q?p7JYlegES/doOBqa+gou7+w+i51Sf2BRRqdAxTaOX7UQqMzmf5TOgZAXGY?=
 =?iso-8859-1?Q?eZadJd5Vl0I0sO6RxAhHywJ8IvE/XIZuoORF3cHgVwdn0QwVMtYgh0sBAk?=
 =?iso-8859-1?Q?IWSDtxtgrlkImB/lKK5J7e07hdprR6ulSS380wvy+HZ3hrH5lTgJHJGg4B?=
 =?iso-8859-1?Q?Z/NrMtMM8taXmOlZ10f1n6wbQLRw5GSfGfjWUgr+JEmKyy1s42pCUiy+DS?=
 =?iso-8859-1?Q?N3GOLBTcKwy2dsR56TqwZ1sG6yD6ALLx7b+J+AvqWQsxchwI4r/5eWCKFk?=
 =?iso-8859-1?Q?autAwKOVvyXroRX8+D05wIywayj/BxZDjSNFsvvbxfNM9vwJgz4NrJC0E7?=
 =?iso-8859-1?Q?FWECNJmVUMwWQxMrA8pifJtZAm2xKgY7zJ9t+Y65drPnGRyc2bHW3rg73W?=
 =?iso-8859-1?Q?E2scwPWyKijk9BeDhAsHJqdHGgli3WYv/+uchBCQmCkyFinhpq/YW1NjrB?=
 =?iso-8859-1?Q?uNDRgY/CpWWFREYWImiZ5ToahvxuigEsbFE6N2SeQH/1geiis2pV1ZJeIM?=
 =?iso-8859-1?Q?MGKfO/+I365mqsJOlqeXMPE8Dj81wp0drBCrhnLDDhmRZeR1qQvHDWx40d?=
 =?iso-8859-1?Q?468TL/B5kxjLdh9uTIZzxv3S8OoSI7+fbtnbIZuv7XysXgkp3YnjQ5UlHT?=
 =?iso-8859-1?Q?ioMAinRPuelDcgUeKcI0JxDCP14FWLpMjb9g1A9kG51fGmrb41okTWWRA8?=
 =?iso-8859-1?Q?2YRToXAm/J4mT2XkKEKano46perrgk4yHkDTnJFMnggAl/xLJ2NQXaPpaz?=
 =?iso-8859-1?Q?umop/65lwLSZEKX7JejLSTcRadX4yMsvrSmGCwn9vG4fMnQkXdikQW4BwS?=
 =?iso-8859-1?Q?7wvOqq+cQk26yLZeLZimv3BHxckeD7rQeEhE/I3VlNj+Amdf3TPPOXjUJk?=
 =?iso-8859-1?Q?9FuhCxVZ2R0rWJE+uQLuvLz7jhX8Y4RmbtgiR7T/1Zhaj7i/1klAVzYTmT?=
 =?iso-8859-1?Q?RJFpyl4QZFU3Ve+Ji02S4x8rZoanUiup5lcOQYjOiGwCctTB/a7SV5jfH2?=
 =?iso-8859-1?Q?5vUBpsFe5+cRJOq2qiRQZbT2xpmSBPCJ7QQ2zQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?K0NSF9Qe3R9H5+WMwvLFvsUQYtmRGvYtlVlSterJ8AgZwlFIIN2qurSJVO?=
 =?iso-8859-1?Q?gvw4jO4LoWPq8DZJsnWvKpWUUB+rv8s4hU/I6PwDUScGWh0IHMqd212hHi?=
 =?iso-8859-1?Q?gCGJfwPedTVigndwujJik0sOtAcevkLvpxHQSNWd8RQfH76a6wVkmNhi4O?=
 =?iso-8859-1?Q?pIR4oX5RNQe7Dn2QlAlJKUhC1kzEvC2BkpNpjdhtcDTsFusA1o0iSTJ+R+?=
 =?iso-8859-1?Q?LxCVuiBKlVCDtEXFrIFhWtTvAPOe17m+NGSP/DEFvneXhl0ZLVKqRx8C43?=
 =?iso-8859-1?Q?KF2Zutpb0r3kNsY8RqIDlUIJgAXjBln/WG7GiBLNWYVyskKA9t+Z4dHYQv?=
 =?iso-8859-1?Q?w7Kpae1fygiW20Rpn5fVR5KuQ6z4w+3EXFRKq3zwCS77Tgj2i2QlGiMqBr?=
 =?iso-8859-1?Q?Yhv+L9PfOU2hUcHlmuyeqUzqMDDchjVIKPSmT8bS5WOpr9tgj96q/HknAU?=
 =?iso-8859-1?Q?1P+MtABNZ+2TW/b9k2dRpPX3BOXG0RrEV0NbQ5bcj6ATJ/hRfREp5YoyvF?=
 =?iso-8859-1?Q?MnC9uJZPHYF2297Ci+0ehcFx4vUEgDEzmUs2QeBXLSf1uK4itoME07d5f0?=
 =?iso-8859-1?Q?EXGU3vct1hZ9Y0KOoLFcnefw5Anv7vrW23nHbctQ/R0oWBWm9xAOFg/MbN?=
 =?iso-8859-1?Q?20fDTccp3A/UcW3eA4lCw0SGp8iM3lBI7n3IWv8/IwDwJJsAjay8p4YnvP?=
 =?iso-8859-1?Q?wTwsxT+ioHybeINiamfTIf6rznx1SMMW2DfLWDM1nRvoiX1w89VgY8/Xw3?=
 =?iso-8859-1?Q?o8G68gy7idTRAHzCBm86k4U8OdHB5UNojH3vl/+Db392FE05KnmHnZJ1x9?=
 =?iso-8859-1?Q?zxfZNq3CRFUH/Xk3IwR1R4q1mmRw8ypY6olr5iSkARDtjx6XT3VT9Set7j?=
 =?iso-8859-1?Q?RP0r9cRV0ONCMOAeOkRTSa+rc/igU3bwjXzV5hldG0YG0bimH2a9T/0MCa?=
 =?iso-8859-1?Q?Y3dQwZbDephVFaEdrYxzbdl5JlIvch+K3R0XYJLe8+mQICp/dT6aKz+BGd?=
 =?iso-8859-1?Q?r4xG6V0Kxv5wYx7XPOjROanf6h//DS7kggma8I4r7TiRqQJPUEjHG8T/KM?=
 =?iso-8859-1?Q?kZxIPUFkbKkV1v2Ykac680Jp+j9EGclJvBI7cum3Obg+otpfajh0YvV+gO?=
 =?iso-8859-1?Q?cHKaWaIMO1MB7lm+m6/7OSC//BxNrIQ7SMBsdg2ERDmvRQchMRJOotaTlV?=
 =?iso-8859-1?Q?h23zBbGOsfOPGMU7tXTlZSn1we9TSM4C/rzucYfbykf8wKDUwIVakV+zP4?=
 =?iso-8859-1?Q?qIUD4e1awGbROer6Jd0uY2SD2r166Emtf0QCW8QFfXySx3pB7hS1AOcwDK?=
 =?iso-8859-1?Q?R8iEyFH5LV7y1dpnV9oD1KclKiGH+Y/ahppRlesk1VC4bkNVb8I3xNNSQU?=
 =?iso-8859-1?Q?yqVdayTCFUy3wEb91fGZfdMRqxBp7KDFyKsg93YlHllJk+aa0RILxqdxtM?=
 =?iso-8859-1?Q?rQnRXo3tcOanmmwES2CjRV2D3jG/VMZ124HitjJ3IgmYCmwtfE/VPF7QpA?=
 =?iso-8859-1?Q?8PhE62d83whYsiHM+TxR4mIiCJmIvcXOUCQmbGRX6ZibQzJwY9DnkSNdF+?=
 =?iso-8859-1?Q?swEVlK5d6pkph7QRDTSLPXW1c0g3vYNLBCALCfen5Qe4BAd40gBFVC3DTx?=
 =?iso-8859-1?Q?HFLEpb3nlKdoMfRN9AQ8401aQ0Le3Y9x0LAbiSknMu6UFS/0ULVWK//NGu?=
 =?iso-8859-1?Q?wWDdAG7UvLDfzDRPpFA=3D?=
Content-Type: multipart/mixed;
	boundary="_002_PUZPR04MB63167B83A765549A1B7CE375810A2PUZPR04MB6316apcp_"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	k1PpgquONr3Yj6bQRRXk59sfkqukKQCvy2CojZMylBoa8ef+YI9NPt9TEPJ24nhM/08CRTkJ2aHy5gZArGx+v0hFcwVuF9N42dhXju0TApeRks6dZJRMK3ZSHylJd6hzQMutyAUz5Gbngk6YmwjxKRmb9aD5bwcNKqtNq2S7DRKnc2aBukUGRGTtgDu3EsStd80JGljTIe4+efmuQHgA2awYapGr9HZYB9ZSCik3vAe7FeRsxDZJoO4affRb0rqaho5cOSqlGkhZryrf0imsVzVqW4QLICbZWYDTPU9fFVW+uuFwduEkQaQtUMLcq4noCqI6jeN34WTFHwysZMqJaBZV04tAMPEDpXO1XHUI2iKx6cZohWeaDY3JLcuq7byCJRiziLr67zr0shCj7oVKsuQxsNe5neE22b/ph40r3IWqtPQ33YpMT80dJJGRCpx2lZXIlUpAIMZg5gFF/3R4651Xk+q8KqgYnPggHpuXBvqRi9ayWR+UjpwqLHXCMGpIik2tjQZwyZXUWySzAo1vgMLVn/aj65wyRTtkOw/uQHh74J5q2LWZFeTQ8h9zm3i/RjiuuQX4TAEk6c2XVHwhOh3EWhxrHp79/29Kz8MAA5oZBAiIvTCfKQQ/KxoHIOjd
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf2fe9c7-e54e-4eb2-7bab-08dd295d9be0
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Dec 2024 05:40:18.0117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sgZT7n/U+iXsXI27vLOuJmNT0mhNPOQb0ncrLnLDjVLRqwyYur9bu9CTPylr7Ni329kSKruQ9eSXtqiJwnlmVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR04MB8128
X-Proofpoint-GUID: rY6GYFVgTUNhHIOTPkgGMV-prREJ8oEg
X-Proofpoint-ORIG-GUID: rY6GYFVgTUNhHIOTPkgGMV-prREJ8oEg
X-Sony-Outbound-GUID: rY6GYFVgTUNhHIOTPkgGMV-prREJ8oEg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-31_02,2024-12-24_01,2024-11-22_01

--_002_PUZPR04MB63167B83A765549A1B7CE375810A2PUZPR04MB6316apcp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Before writing, if a buffer_head marked as new, its data must=0A=
be zeroed, otherwise uninitialized data in the page cache will=0A=
be written.=0A=
=0A=
So this commit uses folio_zero_new_buffers() to zero the new=0A=
buffers before ->write_end().=0A=
=0A=
Fixes: 6630ea49103c ("exfat: move extend valid_size into ->page_mkwrite()")=
=0A=
Reported-by: syzbot+91ae49e1c1a2634d20c0@syzkaller.appspotmail.com=0A=
Closes: https://syzkaller.appspot.com/bug?extid=3D91ae49e1c1a2634d20c0=0A=
Tested-by: syzbot+91ae49e1c1a2634d20c0@syzkaller.appspotmail.com=0A=
Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>=0A=
---=0A=
 fs/exfat/file.c | 6 ++++++=0A=
 1 file changed, 6 insertions(+)=0A=
=0A=
diff --git a/fs/exfat/file.c b/fs/exfat/file.c=0A=
index fb38769c3e39..05b51e721783 100644=0A=
--- a/fs/exfat/file.c=0A=
+++ b/fs/exfat/file.c=0A=
@@ -545,6 +545,7 @@ static int exfat_extend_valid_size(struct file *file, l=
off_t new_valid_size)=0A=
 	while (pos < new_valid_size) {=0A=
 		u32 len;=0A=
 		struct folio *folio;=0A=
+		unsigned long off;=0A=
 =0A=
 		len =3D PAGE_SIZE - (pos & (PAGE_SIZE - 1));=0A=
 		if (pos + len > new_valid_size)=0A=
@@ -554,6 +555,9 @@ static int exfat_extend_valid_size(struct file *file, l=
off_t new_valid_size)=0A=
 		if (err)=0A=
 			goto out;=0A=
 =0A=
+		off =3D offset_in_folio(folio, pos);=0A=
+		folio_zero_new_buffers(folio, off, off + len);=0A=
+=0A=
 		err =3D ops->write_end(file, mapping, pos, len, len, folio, NULL);=0A=
 		if (err < 0)=0A=
 			goto out;=0A=
@@ -563,6 +567,8 @@ static int exfat_extend_valid_size(struct file *file, l=
off_t new_valid_size)=0A=
 		cond_resched();=0A=
 	}=0A=
 =0A=
+	return 0;=0A=
+=0A=
 out:=0A=
 	return err;=0A=
 }=0A=
-- =0A=
2.43.0=0A=

--_002_PUZPR04MB63167B83A765549A1B7CE375810A2PUZPR04MB6316apcp_
Content-Type: text/x-patch;
	name="v2-0001-exfat-fix-the-new-buffer-was-not-zeroed-before-wr.patch"
Content-Description:
 v2-0001-exfat-fix-the-new-buffer-was-not-zeroed-before-wr.patch
Content-Disposition: attachment;
	filename="v2-0001-exfat-fix-the-new-buffer-was-not-zeroed-before-wr.patch";
	size=1736; creation-date="Tue, 31 Dec 2024 04:58:51 GMT";
	modification-date="Tue, 31 Dec 2024 04:58:51 GMT"
Content-Transfer-Encoding: base64

RnJvbSBjMzgwNmMzNTgxMWNlNDdlMTQzZjNkMjUxY2VkMThjNDgxYTBkODA4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBZdWV6aGFuZyBNbyA8WXVlemhhbmcuTW9Ac29ueS5jb20+CkRh
dGU6IFRodSwgMTIgRGVjIDIwMjQgMTY6Mjk6MjMgKzA4MDAKU3ViamVjdDogW1BBVENIIHYyXSBl
eGZhdDogZml4IHRoZSBuZXcgYnVmZmVyIHdhcyBub3QgemVyb2VkIGJlZm9yZSB3cml0aW5nCgpC
ZWZvcmUgd3JpdGluZywgaWYgYSBidWZmZXJfaGVhZCBtYXJrZWQgYXMgbmV3LCBpdHMgZGF0YSBt
dXN0CmJlIHplcm9lZCwgb3RoZXJ3aXNlIHVuaW5pdGlhbGl6ZWQgZGF0YSBpbiB0aGUgcGFnZSBj
YWNoZSB3aWxsCmJlIHdyaXR0ZW4uCgpTbyB0aGlzIGNvbW1pdCB1c2VzIGZvbGlvX3plcm9fbmV3
X2J1ZmZlcnMoKSB0byB6ZXJvIHRoZSBuZXcKYnVmZmVycyBiZWZvcmUgLT53cml0ZV9lbmQoKS4K
CkZpeGVzOiA2NjMwZWE0OTEwM2MgKCJleGZhdDogbW92ZSBleHRlbmQgdmFsaWRfc2l6ZSBpbnRv
IC0+cGFnZV9ta3dyaXRlKCkiKQpSZXBvcnRlZC1ieTogc3l6Ym90KzkxYWU0OWUxYzFhMjYzNGQy
MGMwQHN5emthbGxlci5hcHBzcG90bWFpbC5jb20KQ2xvc2VzOiBodHRwczovL3N5emthbGxlci5h
cHBzcG90LmNvbS9idWc/ZXh0aWQ9OTFhZTQ5ZTFjMWEyNjM0ZDIwYzAKVGVzdGVkLWJ5OiBzeXpi
b3QrOTFhZTQ5ZTFjMWEyNjM0ZDIwYzBAc3l6a2FsbGVyLmFwcHNwb3RtYWlsLmNvbQpTaWduZWQt
b2ZmLWJ5OiBZdWV6aGFuZyBNbyA8WXVlemhhbmcuTW9Ac29ueS5jb20+Ci0tLQogZnMvZXhmYXQv
ZmlsZS5jIHwgNiArKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykKCmRpZmYg
LS1naXQgYS9mcy9leGZhdC9maWxlLmMgYi9mcy9leGZhdC9maWxlLmMKaW5kZXggZmIzODc2OWMz
ZTM5Li4wNWI1MWU3MjE3ODMgMTAwNjQ0Ci0tLSBhL2ZzL2V4ZmF0L2ZpbGUuYworKysgYi9mcy9l
eGZhdC9maWxlLmMKQEAgLTU0NSw2ICs1NDUsNyBAQCBzdGF0aWMgaW50IGV4ZmF0X2V4dGVuZF92
YWxpZF9zaXplKHN0cnVjdCBmaWxlICpmaWxlLCBsb2ZmX3QgbmV3X3ZhbGlkX3NpemUpCiAJd2hp
bGUgKHBvcyA8IG5ld192YWxpZF9zaXplKSB7CiAJCXUzMiBsZW47CiAJCXN0cnVjdCBmb2xpbyAq
Zm9saW87CisJCXVuc2lnbmVkIGxvbmcgb2ZmOwogCiAJCWxlbiA9IFBBR0VfU0laRSAtIChwb3Mg
JiAoUEFHRV9TSVpFIC0gMSkpOwogCQlpZiAocG9zICsgbGVuID4gbmV3X3ZhbGlkX3NpemUpCkBA
IC01NTQsNiArNTU1LDkgQEAgc3RhdGljIGludCBleGZhdF9leHRlbmRfdmFsaWRfc2l6ZShzdHJ1
Y3QgZmlsZSAqZmlsZSwgbG9mZl90IG5ld192YWxpZF9zaXplKQogCQlpZiAoZXJyKQogCQkJZ290
byBvdXQ7CiAKKwkJb2ZmID0gb2Zmc2V0X2luX2ZvbGlvKGZvbGlvLCBwb3MpOworCQlmb2xpb196
ZXJvX25ld19idWZmZXJzKGZvbGlvLCBvZmYsIG9mZiArIGxlbik7CisKIAkJZXJyID0gb3BzLT53
cml0ZV9lbmQoZmlsZSwgbWFwcGluZywgcG9zLCBsZW4sIGxlbiwgZm9saW8sIE5VTEwpOwogCQlp
ZiAoZXJyIDwgMCkKIAkJCWdvdG8gb3V0OwpAQCAtNTYzLDYgKzU2Nyw4IEBAIHN0YXRpYyBpbnQg
ZXhmYXRfZXh0ZW5kX3ZhbGlkX3NpemUoc3RydWN0IGZpbGUgKmZpbGUsIGxvZmZfdCBuZXdfdmFs
aWRfc2l6ZSkKIAkJY29uZF9yZXNjaGVkKCk7CiAJfQogCisJcmV0dXJuIDA7CisKIG91dDoKIAly
ZXR1cm4gZXJyOwogfQotLSAKMi40My4wCgo=

--_002_PUZPR04MB63167B83A765549A1B7CE375810A2PUZPR04MB6316apcp_--

