Return-Path: <linux-fsdevel+bounces-29787-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1C197DCE9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Sep 2024 13:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EAD8281C7A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Sep 2024 11:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B93156C7B;
	Sat, 21 Sep 2024 11:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="XQCriIi8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11021131.outbound.protection.outlook.com [52.101.129.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C3113A26F
	for <linux-fsdevel@vger.kernel.org>; Sat, 21 Sep 2024 11:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726917439; cv=fail; b=TC37VhNYrTKvpZxQlJmOpqqJvGoownc/b1HHjeiIbyl0gRL2iBBhcE2YThUc9z162FXTVLOOYmSBxXIWWjzzKD5h4jtcMWU/adnG7K68frbP0a/DLv9Xyr7DjblBC4zLhGtiuXIrgIxFDHp7RVTaINgm3Dj1ZMzFVV1vhcsLVic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726917439; c=relaxed/simple;
	bh=jQFr5xhpMivt76+FhDXSriQWElFWtWVIAwZF5/mArfw=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=bSP1qBeN2dBfA9qI/USs0TTItd3sMnyv0xymwi68BGrzJRE6BKmR8+J6EDrW4ZfxEwEoZiaUr45WvnZOEAYHI9EuqVH2q1FN3zUDdJnbKF53nHMBdqz750dKklZBYjBbgC3bzMYb4kHlXzBQBJCQ7+EdPNIEDqfprz5HRD3xIg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=XQCriIi8; arc=fail smtp.client-ip=52.101.129.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nVVeAPKC9HtYW8XhDQha2NLSuiqMvqwBbEMAYiP6STPy4k9ZBFDTdGxpAL1rPCulVijQC6bzdIRitesAR2YP/0v9Q5Xp7lhzTUejf5B5rCjr6URYdoeONV9ihLd8G/fx8lWIaGrzhVI0dAr2/SRF2pOhLjnvzU607ZjO4vXzY3OfZBro/WwatqStbtVGQQtC6Fj0RbToQ1chPnYfz37u7GCLaQAjwET0eWUjHv+23pgdjE2XY+5NFiSb10HhHjde3kd3MD1NvYwhwDBCy1sYQ3UnrGlJ17JAKIrNUx0TXlpFLig1n4REnia9+l6hYC9eqWuYDjh25SOgUWAWZBlMKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jQFr5xhpMivt76+FhDXSriQWElFWtWVIAwZF5/mArfw=;
 b=n+Qvln1Rskr3L3ywI/i8HvAV+bNZ1qIKWxnoDM03Ckjex/m58oWSR5Yas4in9eSXu03xetD6jEluTjCY9JQHKvO6RR0IsLsqo+f4H12SAusFpusiI9qIO5V8caSxuzGuNap+8ZL8+Pf+ozUHVevb61Je0XN+vOfF8ScgjP5ABdqZg/8YENtl+vixq2wo6AFAk1WrKG82glS7n0jqBt/OXxlpLQ0D5g9DnLDeYPLFRmwi25yfmpsveqpO19ZlZj2Y/PadSsK1dHgVZzZN7zgDnR/bdPkjYfBX40pQir7ZAZ0mlAKyMaqhqr5kbThVx27DbSnaWOPsa+18V4vtHVpSUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQFr5xhpMivt76+FhDXSriQWElFWtWVIAwZF5/mArfw=;
 b=XQCriIi8azpslMUVSr01RiQRF8Hl81QUBhU9Yc5Wt5pCPyeW3X2JhqfrmI1QWgv7m8WwebQJKLDz8a2PoqYdEaMh0Esky080AvGkpu6tN6Mv1VgIqAu2E3hR+9SJ5B6T53x4idY3QgvcSqDjwnYF5uWaiMhDKALX6yUIiVaJb2A=
Received: from SI2P153MB0718.APCP153.PROD.OUTLOOK.COM (2603:1096:4:1ff::8) by
 SI2P153MB0670.APCP153.PROD.OUTLOOK.COM (2603:1096:4:1fd::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8005.13; Sat, 21 Sep 2024 11:17:02 +0000
Received: from SI2P153MB0718.APCP153.PROD.OUTLOOK.COM
 ([fe80::a647:e1c3:31c9:e35]) by SI2P153MB0718.APCP153.PROD.OUTLOOK.COM
 ([fe80::a647:e1c3:31c9:e35%6]) with mapi id 15.20.8005.010; Sat, 21 Sep 2024
 11:17:02 +0000
From: Krishna Vivek Vitta <kvitta@microsoft.com>
To: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC: "jack@suse.cz" <jack@suse.cz>
Subject: Git clone fails in p9 file system marked with FANOTIFY
Thread-Topic: Git clone fails in p9 file system marked with FANOTIFY
Thread-Index: AdsMF7H2pA+A3TMFT7qIn4M6deqPig==
Date: Sat, 21 Sep 2024 11:17:01 +0000
Message-ID:
 <SI2P153MB07182F3424619EDDD1F393EED46D2@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b3cb83a9-9f35-4243-9b7b-198dad1ed686;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-09-21T11:14:46Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2P153MB0718:EE_|SI2P153MB0670:EE_
x-ms-office365-filtering-correlation-id: e199a6a4-195c-4bc5-1f62-08dcda2eea92
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?jiCecDfRoEgO9YVkIqD9Yaucw5gPubsJOSsIj07V/1yWqm2EvfKCSfM1wA7z?=
 =?us-ascii?Q?78CyYGWNn96OuHRAHcnMbN8Y2ol9hXRtYFeeERC977JCBuaY10gxPSItn7VL?=
 =?us-ascii?Q?oTW4xrmYpEYh3ElQwqurwrbwyrkacXZ2+g0IzD4MwhrAfy19atvf+0OcPBna?=
 =?us-ascii?Q?Ik9rPKByhbh7Vb2TLBnGT+dD4uODLGRwhcVLCEeFvprY3A67jcdLPcfKz9wz?=
 =?us-ascii?Q?hWiHnQLEjFbYdKT5O1xuQAJH6/oUCQATQkkfSEbBNCEo9OyAFEQFqpU5iwx6?=
 =?us-ascii?Q?z24hEMd9T9AxgMS9NihA0RMExRljlocVfiMOYTX5NwECO1Vc65CXPar2FZbo?=
 =?us-ascii?Q?mN/gf/fGn7xA1da/eO3ht34tJ+itGmgoNOXVSoEIfxVIH3xy28BDte+OJc3C?=
 =?us-ascii?Q?0wd9erjBSV3h1bFDieK435VIFOwudOP2i5asqD9jbHuvzo9V/MzyKbumWtdZ?=
 =?us-ascii?Q?koN2R+09J4zgWa6RNhKke8ALaiAjKgnCy4i5+EdsziMXkhSnV5oB5cWFbW6a?=
 =?us-ascii?Q?iBXGo/PDY/JF3u81L3hcQWXz+1xQOggiQzjlyM4QtkEkZO3Y1xW/YDXW4cPH?=
 =?us-ascii?Q?2zeFk4BvkbDBb8SmR0bTRqL8BZfkz57iO+UdR4e8Ghw3qd+xGndV3UGKPgRC?=
 =?us-ascii?Q?wYatJ59jUxGZ8GRoz4izlO2otf9EH1juOj+o+z0SU9em4b6NQ9dGMW8FKiuN?=
 =?us-ascii?Q?GOtgyGzD+5JtLtg3LyZldumQ+tIEl3Ich77rQrUAVWdyE9NS9ouDDQzZnW31?=
 =?us-ascii?Q?a4JDcNe+SCSIfKsocBnoj8zKoifh6yx49aT7lxSyk26cnTOIjTwiWbxkuqI1?=
 =?us-ascii?Q?MEUCffmlt1tuj8Wh4aHX6sCq5+2iJg2EHTN4W56VygH4tw+Skhgb9ruQMfFM?=
 =?us-ascii?Q?Yiysg/ycvSfOoqc6oGMeGKAHXre2xymLXAUccfZylDpFyJuoTJj6oFJTwF1n?=
 =?us-ascii?Q?a0ziKOiECaXXRx6L8qN+xskIGqHZGWYE8WyhlLlCa3X0mDiLtdbeeFDwg8/P?=
 =?us-ascii?Q?V3oP2YrI2c+CjqGCR67Wur1vJRA/M9/W7xDc3Cbg4SG+4Z0RxlcgxqKNsVJN?=
 =?us-ascii?Q?Fd9u3oKw8KpnkZB4hu/dx4+4xDjbEElz3Xqy5kebI6Jp2GUmLPTKMVk9Ehe6?=
 =?us-ascii?Q?h5C7ZoF8zTrZUHcz++5YNsckprrHz+0cSZwB1pArPsJuKPDtCpxJxoSNiQpV?=
 =?us-ascii?Q?FWssDN4hrgFT1tHW4KwXg8DxnHw28LKQ5ska02srGmvcWZwzduQIQsqRg9S7?=
 =?us-ascii?Q?hbJeOzmsfU7oTrjtj7gMgTvPv0UnaSTHnVQJM3f+jWgqKxdmNK1mSb4yWiS7?=
 =?us-ascii?Q?+FA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2P153MB0718.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?f2kwR7QlHNwgX2QSNFQcb94s1ef5zofrdIzClTh7lCSSCUSwndKKttTMJyul?=
 =?us-ascii?Q?xqFyvAngkvi1YiKMrMuZEv/9ABvOGV264tg1oNJOfPwqbYi8SIJqRn+T7v/M?=
 =?us-ascii?Q?DLXTbLwokg4QGI/N8eRTte12v+pTJJJYAz3DLAWT5MkrFbzY6D8gQgoEQzGU?=
 =?us-ascii?Q?q1Av9s4SF5N6J0io3wDsOkLfJeaBqZP/ZvOSU4fCNqY3FZLfIx13MozjWGf4?=
 =?us-ascii?Q?Gmnuu0+JRiooLe3nHEBYfsX0G/Ha+tO0akzYe4rKXkA2o5gsIU6jKrXcHwb4?=
 =?us-ascii?Q?KK25UearKqGUJxMaeGsca+TTsUsiIOTx/j6UqyySuBQzGcrnOLNSEg0DuPDZ?=
 =?us-ascii?Q?tA6SXOfUjK06dfSgNhAx12lojU8vDva8ucXuiBx8a2AatbDd+ipWb+iSE/Wk?=
 =?us-ascii?Q?Q9YP/qboLRonFXEGlbwLuxVNGGNkHcVywdw4kZ1kc+1IodxYrAnBm22utImZ?=
 =?us-ascii?Q?zIHGfeBbKsvwpD8pXxnPGLxA9c6+K1X+iFQjwfvvmjYdufe7C92tV0AB2QVh?=
 =?us-ascii?Q?cTVcsQ5RZ4REZ/Bw7sf5esyGRXlfPrcnIplpcl51qZ9YhWmfYipXv7JOI1gS?=
 =?us-ascii?Q?ZLkCkHDwez3P8p3pHCFPRn+eAFaJm/1KVJrjvqH8iThfF2Lf3Qk1HqMs+6XM?=
 =?us-ascii?Q?it9vL9wRQCn0p7Q2SrFEGYQ1hlHvQ9KdDiRLpDGywb2l511DVCsTqO0h0XnL?=
 =?us-ascii?Q?BCL7UBGcMXTk5oHL5r28aa++JSH2whNvn57KAswk10E43m5wnj7yGEZ24CqS?=
 =?us-ascii?Q?LenncaI+mRVQzjSPs+RDsqx6lZdOwRmPLt/maBALHRrXxzfVuwFpho8V7vE6?=
 =?us-ascii?Q?qa7Tcb0cz/0PnG8H8OsKpXjDfD/EwrOMShpQY+orYbcqXPjx6YU9GopRrg+q?=
 =?us-ascii?Q?nzUfFlsoKABWz/YHfQsnSDxmszGfpUKULWtH2L04cIgt14Lo7lKtERhbY+uP?=
 =?us-ascii?Q?BsVIkDo7hxhe3hEU7eMvnn8p/edRusEnXl0HvhkMf48hk9XxwyY/g4aDcRF3?=
 =?us-ascii?Q?DFWwYUs1rMufxS9uGs1B4jcXvq9R+/hOEPSWJVaJozDnsSW3l9CSlY5FdAWF?=
 =?us-ascii?Q?x0zBS/NOjuPkeiIBJ5yx1ptlfi6jzgRk+Rh8jNW8QXnmDa1zt6y/Zk9C/GeF?=
 =?us-ascii?Q?RWK4jojPvboNuagZjgqbhyCGlFzT/a32csRpocWuEsqv4QLwHTWcb/GO6Zsc?=
 =?us-ascii?Q?D9Gf3Zo5gRPj4g2+BwFwXMV8qv8qlry1ZNI6BJT94C6dzu7nd3O6/TOC74Vu?=
 =?us-ascii?Q?fg/RhH9POtv91g73Oy2wUJqDyZL+F4mzp4cUpALspO8uQpNUUFc03B97QbEn?=
 =?us-ascii?Q?RSwtf73NrE1gcjmRiVh0u/NaerMITAPe5VwNc+z4qEdyAhDuZeJWGfkVhqCY?=
 =?us-ascii?Q?RFWap/hhCanKXiM8DXFp7QMLZWPBlRPbR3ittZW6yHO0FghDlYtIozWO5k2q?=
 =?us-ascii?Q?W49DOmXwIUWNQqnwsXSbF9jwIZo4zZRoJdl5kGCQ0VhUPF3UKD7Kr1LVZ3O1?=
 =?us-ascii?Q?+9y0SonRDpizJGU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2P153MB0718.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e199a6a4-195c-4bc5-1f62-08dcda2eea92
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2024 11:17:01.8501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xTMmxQqh0BzlKggp5U/QYoKV0wbyEPt256tP6gvcYQ0YGJXi0oFxkQ26RdB7tXWNBAWSlLB6DeUbQ5FY+0iCnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2P153MB0670


Hi experts,=20

Need your help in identifying the root cause for issue.

We've seen multiple reports of git repositories failing to clone / getting =
corrupted in p9 file system. The mount points under this file system are ma=
rked for FANOTIFY(flags: FAN_MARK_ADD | FAN_MARK_MOUNT) to intercept file s=
ystem events

When we remove the marking on these mount points, git clone succeeds.

Following is the error message:
kvitta@DESKTOP-OOHD5UG:/mnt/c/Users/Krishna Vivek$ git clone https://github=
.com/zlatko-michailov/abc.git gtest
Cloning into 'gtest'...
fatal: unknown error occurred while reading the configuration files

We have a MDE(Microsoft Defender for Endpoint) for Linux client running on =
the this device which marks the filesystems for FANOTIFY to listen to file =
system events. And, the issue(git clone failure) is occurring only in mount=
 points of p9 file systems.=20

Following is the system information

root@DESKTOP-OOHD5UG [ ~ ]# cat /etc/os-release
NAME=3D"Common Base Linux Mariner"
VERSION=3D"2.0.20240609"
ID=3Dmariner
VERSION_ID=3D"2.0"
PRETTY_NAME=3D"CBL-Mariner/Linux"
ANSI_COLOR=3D"1;34"
HOME_URL=3Dhttps://aka.ms/cbl-mariner
BUG_REPORT_URL=3Dhttps://aka.ms/cbl-mariner
SUPPORT_URL=3Dhttps://aka.ms/cbl-mariner

root@DESKTOP-OOHD5UG [ ~ ]# uname -a
Linux DESKTOP-OOHD5UG 5.15.153.1-microsoft-standard-WSL2 #1 SMP Fri Mar 29 =
23:14:13 UTC 2024 x86_64 x86_64 x86_64 GNU/Linux

On collecting the strace of the operation(git clone <repo link>), it is fou=
nd that renaming file name from .git/config.lock to .git/config and subsequ=
ent read of that latter is failing.

Any known issues in this regard ?=20

Let us know if you require further information.


Thank you,
Krishna Vivek


