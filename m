Return-Path: <linux-fsdevel+bounces-25030-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD119480D6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 19:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D321DB22E96
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 17:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9659616A95B;
	Mon,  5 Aug 2024 17:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b="CtOx9OTd";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=juniper.net header.i=@juniper.net header.b="Dep7fgmB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00273201.pphosted.com (mx0b-00273201.pphosted.com [67.231.152.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD36D166F33;
	Mon,  5 Aug 2024 17:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722880600; cv=fail; b=csTrN7/WO04hGGta1Iz6bfnH/b/JdRmirLgrAE/x5sPVEUtfky7BuddFSR12bFNdTvZ3qHjjm7ZXnxflgT/6ocwicE/37zZz8Wzwvj58UOsHsGDoxGgIhyz70ZSm7XRULnNQ9xuGVekzhVSNcdcPM1q5iXBQp5Z8/YwCCckIQTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722880600; c=relaxed/simple;
	bh=NPtYNgC9wqBPYUMlNVOoyg934aUoalaWH+31HCtUDsQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HBMon3vmqxG05XaOJCnBPP4lK1vTiTcCWpQyJ6tRSfFJrAyWcNobCaTnWPDiY+J9elj4zPCJqZshPfyLhzA5vnQkSUJaJbJQoRc0TeKxJ7kXLcx36AnrUSx27wmwV6ym7FfvglBIrkYWZXwBza46XyNatH1WPMGtH6zu//RseB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=juniper.net; spf=pass smtp.mailfrom=juniper.net; dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b=CtOx9OTd; dkim=fail (0-bit key) header.d=juniper.net header.i=@juniper.net header.b=Dep7fgmB reason="key not found in DNS"; arc=fail smtp.client-ip=67.231.152.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=juniper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=juniper.net
Received: from pps.filterd (m0108160.ppops.net [127.0.0.1])
	by mx0b-00273201.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 475C4P1g012355;
	Mon, 5 Aug 2024 10:56:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS1017; bh=AjiaSga1WytiAS4mHSUWjRYuvOdNGIPI9e/VVrzk9LY=; b=CtOx
	9OTddhobGvbLWWYvLrj+FlQaQd0UoojNeeAn868VZQJlHtXbZ1xKPeV9jJhRm41E
	sa6VKv9PxxCk0vLFYQvwJ4vp+AZMvlfGrhKvOMLd5+8FYnSLfaObSMFIlBsweavK
	ZhQfei7EHF8EMJuy/mNifJtm/OUFBhXIPMgOIj4lcqyKn0ZAvHr6bMrXxwr/F7Xb
	Fcr7aJWhayxcJpXw0PheQcFrXZMle1UDa26Tw6H/Ts6/oY3pKoBVDb0MeICDR+0r
	xKW4P3vp3Mq8Hq4R47zPA3JcMfIMGJVrZHi4osUerh2E0BhlTuUYirWIgWAS59p1
	XLCZ0/vidheC9ocPAA==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazlp17010006.outbound.protection.outlook.com [40.93.1.6])
	by mx0b-00273201.pphosted.com (PPS) with ESMTPS id 40sjfe47qd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Aug 2024 10:56:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qLrcmRGo3HUYBgA9faekzkgqJ03FEUxxmbXRvc92Tx3oHsfSnnYgtxVLpoBwzfGNyFmE+d/djjTMxHu6bosA8Hq0AK/GC0meKUZW02uQdOJQEvcHG5EJbY0HHL8Q8U053B6L5Rc6kLlFkk0Q7UQHtH2irR0clV2++M39lGyfa/1nx6uDcuKHZYphOoFHzcE4+A8/NNU2sokFkhjLb+LSvuovTiZe4PMtjH/VztX42Pfqe4u0ShyWGNnVNQ9WySF5NtiaxbUUx3uo+tRjpNxeRGkfziVwhZnLi9xCCYtodX+naFTzZ3s3685z3Ep9s1t8StZEtk3P4hD8QQWmG2A2+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AjiaSga1WytiAS4mHSUWjRYuvOdNGIPI9e/VVrzk9LY=;
 b=s+i29m67sKz1l03FRROwqOyXgnJIWhU1gdikoCzDYOllMUYNpsdJ7PZqEqNXztZ3zgcmbHqB6Goe6y1TTzRx4WMlyDZME83D3nD3AueePJjO3cgYJ7XWGzUMuJQVdU96bdYdogVUqs5n2r28//kojYdcYm9JyABrOXul6cUYOkIbkpaFPStkBpuuXhz/q3pz0qnUcYApJxoe6w1ockmvL/MS/cJuE0QxEWnhEjtEuZuDQ4YcU61kUvCc7vzKTDuMp/s3kq0PJhNTyHdF2bJBR3/OiWIKZMyn39lVWZLqBWV7KAHDr5KbC7S9dODw7BxtCn1LM2C1nfYKjkW8RvDXyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=juniper.net; dmarc=pass action=none header.from=juniper.net;
 dkim=pass header.d=juniper.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AjiaSga1WytiAS4mHSUWjRYuvOdNGIPI9e/VVrzk9LY=;
 b=Dep7fgmBy/X6NGcm9rXvpcloogfDck8LbpzWU0kUV+TqQ9ZvmvH9melYIlw8qfiQle9joGDhA9kwsl+jKLEgblDaG84KaJXNM8CqxAUV7kdqAQeATEZ5Ibi2R4Yt1UA2t3psE9u4ILTzdDWioVOgS7IbOXph8SkggOUFOe6XrgI=
Received: from BYAPR05MB6743.namprd05.prod.outlook.com (2603:10b6:a03:78::26)
 by DS7PR05MB7318.namprd05.prod.outlook.com (2603:10b6:5:2cb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 17:56:12 +0000
Received: from BYAPR05MB6743.namprd05.prod.outlook.com
 ([fe80::12f7:2690:537b:bacf]) by BYAPR05MB6743.namprd05.prod.outlook.com
 ([fe80::12f7:2690:537b:bacf%6]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 17:56:11 +0000
From: Brian Mak <makb@juniper.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
CC: Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman"
	<ebiederm@xmission.com>,
        Kees Cook <kees@kernel.org>, Alexander Viro
	<viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara
	<jack@suse.cz>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] piped/ptraced coredump (was: Dump smaller VMAs first
 in ELF cores)
Thread-Topic: [RFC PATCH] piped/ptraced coredump (was: Dump smaller VMAs first
 in ELF cores)
Thread-Index: AQHa5oJN0OUvdCow60G/Xu8XfVXMurIXX7SAgAGUvoA=
Date: Mon, 5 Aug 2024 17:56:11 +0000
Message-ID: <E3873B59-D80F-42E7-B571-DBE3A63A0C77@juniper.net>
References: <C21B229F-D1E6-4E44-B506-A5ED4019A9DE@juniper.net>
 <20240804152327.GA27866@redhat.com>
 <CAHk-=whg0d5rxiEcPFApm+4FC2xq12sjynDkGHyTFNLr=tPmiw@mail.gmail.com>
In-Reply-To:
 <CAHk-=whg0d5rxiEcPFApm+4FC2xq12sjynDkGHyTFNLr=tPmiw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR05MB6743:EE_|DS7PR05MB7318:EE_
x-ms-office365-filtering-correlation-id: 54fa4a5e-08aa-4603-8958-08dcb577e422
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?To2ToeGkQ+tRvCtQ/Sk28SLXrKVmnEczzpgV0M16TIpbqepjmONgcENienfK?=
 =?us-ascii?Q?1zvIEz9V0pF5NhuCli74+UrCiuzuN2Kp+CVNn/ddJCAkyYTEfKmG+UfVlnsc?=
 =?us-ascii?Q?pKB4q0F+5340Jp7RniGXS9YxGOw72PfmosFbpuiM/ObZQVkC2/KixfnzRwNk?=
 =?us-ascii?Q?6mcTx40Ia8wnfBb4P8FA1mDvw7eRJ7lW4ooN8nF+31vY/OjfuhE7AfNm/Y7S?=
 =?us-ascii?Q?ZHKXfmq846b2QRB0eLzq/MsVKEUcYn9lndkTe7i3LX8ViRSADlHBSWxqY4KT?=
 =?us-ascii?Q?EXOsOC6xOahO0H+RGnMzta4E5J3Jangqs062M/HGeB/h7dvrBzUd1rPtaS+B?=
 =?us-ascii?Q?oBNf9GkM+b8fkk4ch0+VYEKHN/AZnj9ezWHHC70ZX381RRUl8e9z+/LbeLTD?=
 =?us-ascii?Q?CLgdylUP0ocKEhE8HqvCBTse8nLimPq5jI72CRCc0EgU4E6jKyyPXldh58vP?=
 =?us-ascii?Q?F5b+UiYZeO1A+24qp8j2NRJiDBaqqYHkabFhVGpUTmlbrqRPMxkeYHKITNQY?=
 =?us-ascii?Q?CwpH7YZ+14fjNd3EsGlbzYQrlKpquYrWw0zl/0GvnGuyStxILkTaJXFgKgVU?=
 =?us-ascii?Q?dMl3coEdPvnEsubvnxEOBmYw4ToyZw5Quw8GlvHARsquDjB3exbboQ+PD1iN?=
 =?us-ascii?Q?kJYwCtKCyYE7LM5MgS1RA9SI+Dg8JlISWzHBIk7B2gXST3bV5IdOQx6nAA3m?=
 =?us-ascii?Q?bnpAoGASrT7qHPpNQz7JHSYmfiwK923e5WL/18GimQyZQo+gS4k5nhl2fuej?=
 =?us-ascii?Q?fQ5X1AMwEXZ1M7Q4ZiA7eGULuV6iRsFDCFRz6ru6LvptKjULnvmYwgWUAZor?=
 =?us-ascii?Q?fQgd/hrmy+2+1kv6cHrBS5IxHnPU/5U2WRLMnPXqdlw3K/hDCc92A0yoPoxT?=
 =?us-ascii?Q?g7D6VbSmMeo6KLamtOeih7Qd0vGq7jv1IidANkete8+HZfiME2VWrmLa6qdU?=
 =?us-ascii?Q?fV+J0IqCAqefd+BbMYiFs/2oSEXQg9l0K3zgB1zcTeuX4X2wqOE+ECYCIMS5?=
 =?us-ascii?Q?eDhnC3vgwdcLCSPCbcIh0WofSk+FemyDyqHKJnIR2ySiIyF0Y19QTCsI7uqD?=
 =?us-ascii?Q?VxgWImNQCM8HzE23QkAyy6dZ+x42IEcS5W6FZToYfi6ul4epMlbcrjrv4GZG?=
 =?us-ascii?Q?Hk/VUqabgVzKDqNyCN+WA8k3CIiGJsmoDxkNtOKJm5lNEadcnjvnTNY0E79U?=
 =?us-ascii?Q?sFTiRCEjx6b0wGZJ7mg+uF1R+njd/rbm2CCSsXjZCphP1UJhUitqAk7DNPt3?=
 =?us-ascii?Q?iirrfdOLw9co5wBxnya+C+EmIqS0d8S6dT4ODWWZNShM2Ak60OOCxhS2i7E4?=
 =?us-ascii?Q?aeZubPF3S4CinCkj3xgfCF39xvWQu3wv8zhdE86rx7DgQixfXNaSH5Tmizsb?=
 =?us-ascii?Q?vnYrGZH8nqvhmc4lSuNWlxK68Pd1NPM7rKpoRgax6/2rWtACGQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB6743.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?hMZRIQhpOufY5L/4FsbWeIKOACu8QQGkE6ieKcRJr2li21bhmmIGkb0OpxF6?=
 =?us-ascii?Q?e6jgWXTcwQgGC8EersTCxk/q1xD35s3QqzwMM4RAI9WxTSZreqqhDuAsK29l?=
 =?us-ascii?Q?QwLd3tWr8WFMWPO2KOXJuYHQCwkcSu9t0a954698o3OW/aJLkRpQ60QvJIjO?=
 =?us-ascii?Q?iGavcxbKYN3FGbqxfmikMdO6UB/oF5zQPdNkbNQnHOwXsTh5CeHQzYHdjAIc?=
 =?us-ascii?Q?l3ZVuJ935Z/YrJbcghW+xVWOMde1tcPRrIYYlF7xOtwUugiHZC1ZkMPPx71s?=
 =?us-ascii?Q?AyrlRPOkMPdCGqF0nsGLGvydz4VnYKiuAUOnN51GELCOwtsmQFh8Cjq+Ee1l?=
 =?us-ascii?Q?beNazU7Lftmyiow1p9Suq1vl/IRWBe2wEBJyC/AxQC0KAGLkAqzSJ27DOdRi?=
 =?us-ascii?Q?r7jVhscNit6CcwXnRLIxPRRknRFwZiuwia18KjC91zjdiuCO0ywZCW9Cb+Kc?=
 =?us-ascii?Q?Tbc/mrWJVIsl9aVOiWTqa8JFlEeaC4FxO4oDkcQNn8AQwZJkesVzRxyBB+OI?=
 =?us-ascii?Q?XdAnCxci6ogTy3ykGZLlAuoj/hPoOGeU2gNisnUwRb1VYIq8Hdq/01psbLuw?=
 =?us-ascii?Q?uPbd00ZRnh0gHlQgiFYEJVTth4HVkyx+spOHk/uEOq/xdH3AbBPDdn1LZEFd?=
 =?us-ascii?Q?xFeJuktC9VslQ8U5WydUOW2IRBlamT2GFxahrslSwCp+/VN+IrbnZ9OvA/dM?=
 =?us-ascii?Q?HGyxfKQr6+9PN2FMk9d55kBzt2m29hPd99RGDOXCiesObYmgJG5NNp5t9HTT?=
 =?us-ascii?Q?K+xJKsf6R+ExXPzrm3VqEeQofz+G8G85TF0VvxqT64TsWyHnlrUK0yD5YUAO?=
 =?us-ascii?Q?xxODOPQ51gPSmvZfiboFtslDTEJHBFdTtSM6RA27Tjz/cvDhrcmKVJE7RH46?=
 =?us-ascii?Q?lWJinCx1ArkVKsEHu47kK8+babA9Qv95uOP0/AyhH14yPmyc2LHAmU/ZlVkw?=
 =?us-ascii?Q?wttjjMd4IzqvEPkInRzWPNRXA8aqZf7gMj320cH43QBLY6gRI7yw1CQ3WWyT?=
 =?us-ascii?Q?EP0TnfikbwZkeENWLIoXPzxfx84ocHE9OouAx2hGSXYL6P6y/bTBchVzxUfC?=
 =?us-ascii?Q?hVE9T0MoQVLJVKr2S769Wd19bG4GFLFtRo+ZL+u3VijlUwlfF8WmVCWqZ3g5?=
 =?us-ascii?Q?AUA5grtiUN6nwGnnFK3sUTSO77oMwy5Kp/dkS6TmY1mwrEEMw0sQdp8JPSc2?=
 =?us-ascii?Q?QuhG/Rc6mC84CoK4DhpB2ExnYZPU0lkuprzTG6/kIrNxifNYefNsB7ttf8qA?=
 =?us-ascii?Q?/zwraVbFC4q/X3AMgMbwyRlc6YtEHWOrMHibAhdZXDPfDxhwcxhdpbzca8VC?=
 =?us-ascii?Q?Jxc/EZh5IYqGLfGfq1rMP+ZKXD89znmktmXB2FRXUHwZxcxcv6bQDqdEraZc?=
 =?us-ascii?Q?KOjfu1yb/sNwFtfGkbiZODZvQCyw0vsAiTvYMj48lMoCzU1qHY9RiUWhPNzD?=
 =?us-ascii?Q?6dhVTETdM6DM45YHkc7fqtH+OkEy4C416MVCcBO2VKRus1OSDaQ5+VTJfrIa?=
 =?us-ascii?Q?fMel/TMZFpAHt0DzwAAeRoCBZ9kgo0jAwJg4F4tu0muM0Mf6nMdPIldrFAl+?=
 =?us-ascii?Q?2bEkX34TnD/k8tD3S33DPtLxprpGY46GWGipXE3o?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BCBE3194400F8D4DB74AC2D0AEE596FC@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: juniper.net
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR05MB6743.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54fa4a5e-08aa-4603-8958-08dcb577e422
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2024 17:56:11.2500
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bea78b3c-4cdb-4130-854a-1d193232e5f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mQgD7QFuXURUtNLm38O4mSDDVNQN9lKEVBzCD0+1b22C1g7nuTUl6QihXPM024MtwwyEd68zNVUK1X4PA/UmWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR05MB7318
X-Proofpoint-GUID: A1TGZrqKg8USneGc4CJXQYyZ6TYlXA6e
X-Proofpoint-ORIG-GUID: A1TGZrqKg8USneGc4CJXQYyZ6TYlXA6e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-05_06,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_spam_notspam policy=outbound_spam score=0 phishscore=0
 spamscore=0 mlxlogscore=999 priorityscore=1501 adultscore=0 suspectscore=0
 clxscore=1011 mlxscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408050129

On Aug 4, 2024, at 10:47 AM, Linus Torvalds <torvalds@linux-foundation.org>=
 wrote:

> On Sun, 4 Aug 2024 at 08:23, Oleg Nesterov <oleg@redhat.com> wrote:
>>=20
>> What do you think?
>=20
> Eww. I really don't like giving the dumper ptrace rights.
>=20
> I think the real limitations of the "dump to pipe" is that it's just
> being very stupid. Which is fine in the sense that core dumps aren't
> likely to be a huge priority. But if or when they _are_ a priority,
> it's not a great model.
>=20
> So I prefer the original patch because it's also small, but it's
> conceptually much smaller.
>=20
> That said, even that simplified v2 looks a bit excessive to me.
>=20
> Does it really help so much to create a new array of core_vma_metadata
> pointers - could we not just sort those things in place?

Hi Linus,

Thanks for taking the time to reply.

Yep, I don't see any immediate reason for why we can't sort this in
place to begin with.

Thanks, Eric, for originally bringing this up. Will send out a v3 with
these edits.

> Also, honestly, if the issue is core dump truncation, at some point we
> should just support truncating individual mappings rather than the
> whole core file anyway. No?

Do you mean support truncating VMAs in addition to sorting or as a
replacement to sorting? If you mean in addition, then I agree, there may
be some VMAs that are known to not contain information critical to
debugging, but may aid, and therefore have less priority.

If you mean as a replacement to sorting, then we'd need to know exactly
which VMAs to keep/discard, which is a non-trivial task, as discussed in
v1 of my patch, and so it doesn't seem like a viable alternative.

> Depending on what the major issue is, we might also tweak the
> heuristics for which vmas get written out.
>=20
> For example, I wouldn't be surprised if there's a fair number of "this
> read-only private file mapping gets written out because it has been
> written to" due to runtime linking. And I kind of suspect that in many
> cases that's not all that interesting.
>=20
> Anyway, I assume that Brian had some specific problem case that
> triggered this all, and I'd like to know a bit more.

Yes, there were a couple problem cases that triggered the need for this
patch. I'll repeat what i said in v1 about this:

At Juniper, we have some daemons that can consume a lot of memory, where
upon crash, can result in core dumps of several GBs. While dumping,
we've encountered these two scenarios resulting in a unusable core:

1. Disk space is low at the time of core dump, resulting in a truncated
core once the disk is full.

2. A daemon has a TimeoutStopSec option configured in its systemd unit
file, where upon core dumping, could timeout (triggering a SIGKILL) if
the core dump is too large and is taking too long to dump.

In both scenarios, we see that the core file is already several GB, and
still does not contain the information necessary to form a backtrace,
thus creating the need for this change. In the second scenario, we are
unable to increase the timeout option due to our recovery time objective
requirements.

Best,
Brian Mak

>           Linus


