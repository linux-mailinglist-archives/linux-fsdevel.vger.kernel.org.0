Return-Path: <linux-fsdevel+bounces-23894-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 911A0934694
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 05:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AE9428341D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 03:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360422CCC2;
	Thu, 18 Jul 2024 03:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="N8CX28Rd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2157.outbound.protection.outlook.com [40.92.62.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8468D3D966;
	Thu, 18 Jul 2024 03:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.62.157
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721271897; cv=fail; b=i8b8sr7In0v07NWUkllP6VGI0KF/95ka/vPhYOQGGHtGmZwSbGd3CnT9C4mvobvWRnr/LbW3+feY3xsdmxSweSeiOqb2skRwLLIaipPR+lBzsTFnWydj3VChvsXrcgZFPfwwMnTOt/egNhuuGEZK0vV+dEYLWYrhkCGrmSSKU+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721271897; c=relaxed/simple;
	bh=Afqn/+KWRwsqZS1fnrYQyMfoZP2TLodbAXCiHtzv+08=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=COqj9SOOENsd51aCBPWbbEcerfNQ/CogHI4loYKkfJ30MD+SC9IB/QNYRFIDf4LuqkGmd0sGBRl/+9x9UnY08nLxAtZ+BW/5yYBAPSanYHJavGu9k00qY/nLVBP7ql1G39eq59cyYA5M66uYQXtaUlk/y/5uIdpR8mPh7Pp2wjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=N8CX28Rd; arc=fail smtp.client-ip=40.92.62.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RLW8oXY/Fy1JaTOyMr2bTiOYJG5zlx5kQdTEAu9jBPJjt6tPKnqz6PMDkLCy3zk2RVG3gPWc1aAH3xeZRli3JI8weyfKXEKkg/Sc9ZZYs1kIH6Hg3DZgFSLyclcvIrlXHz4QGGnusGxMj6B3j7XWeiLtpm2WT4baQnrbv9mlNiw1c2/aJlFMFnAJt2UXJVuycAWjDdtHBl8m5h4WyYJ75EAY0htbfGbfJYcXmHkGAsVRrFXnGT2wXRu8xABtDuOIvvadbt4L8q58UI9GSY/hzE84V9P9/jIIifJDmsmlNJKF/hfiLZq26SANkBVU3Cye2d92/IphxHQTUxGLxilO5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WLzBeUv7uEyatawNZn4TXVt661GeDzmP6Lg6H1TaZCY=;
 b=CTRjdT69OshQWI/gJScyDcdzXAxomRcTXQVHKOvz1tTfW4Kdt9gJuxh+eTRV7pithOo1MYJJEozvzF56kC7p82H9s8fmUZnjedthPWSz7VuWJ+McqWEmil8NeE//XXkNafrEFTmjxTSd34QqBkADXBt7LqiGa+JuUiPy0BHgxXcvAOthDNbf7UFL/UtyV37mv53s35bZ5b1FeJZ3MU5DelUNQq/e2jZQx0Grd+hWPpr1zIHQP56wf4PqGc0hztnIJZ/ehIecmu+Zz4f2CoszMq6QVA9lYmYzDhIkGy2PraoD/LYafbe/1D98ih1ppcodSWzi4MGJAxIPU/rQN6Ocpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WLzBeUv7uEyatawNZn4TXVt661GeDzmP6Lg6H1TaZCY=;
 b=N8CX28Rd5jGYT0SF2qilAXhEtdeM5ZyYbQpX9By5d3M2U4qYx7l+5GnPGpglnHnOLBZR602YkNmGLotQ/cteRXeMw5FQqU1sUSRcDABCBF66yzR2KNf7skEtR1u3RvOxLGc3Gpa+kVn3B+DoDBTzYU6+ODEXXLvYNuaKGn34Wxr/IDzq3GRhbj8aIabkJzytJMxoGh/mJ1Al88HiRlN99dbR2l91xkgrAfL4EAwuk7mqovLpsUXp1rNxN3C7BfLEXeL4Bz1ovipnKpYd+MGQe7WderHLbE/qAAq40QxKHk64G+63E97i1g8jif9NDqRTBuQ8AkBBYpiXACfFMITNTw==
Received: from MEYP282MB3164.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:159::11)
 by SY4P282MB3661.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:1c0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Thu, 18 Jul
 2024 03:04:50 +0000
Received: from MEYP282MB3164.AUSP282.PROD.OUTLOOK.COM
 ([fe80::f65e:52a:9bfb:525f]) by MEYP282MB3164.AUSP282.PROD.OUTLOOK.COM
 ([fe80::f65e:52a:9bfb:525f%5]) with mapi id 15.20.7784.017; Thu, 18 Jul 2024
 03:04:50 +0000
From: Ryder Wang <rydercoding@hotmail.com>
To: Theodore Ts'o <tytso@mit.edu>, Zhihao Cheng <chengzhihao@huaweicloud.com>
CC: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, Jan Kara <jack@suse.cz>, Christoph Hellwig
	<hch@infradead.org>, linux-mtd <linux-mtd@lists.infradead.org>, Richard
 Weinberger <richard@nod.at>, "zhangyi (F)" <yi.zhang@huawei.com>, yangerkun
	<yangerkun@huawei.com>, "wangzhaolong (A)" <wangzhaolong1@huawei.com>
Subject: Re: [BUG REPORT] potential deadlock in inode evicting under the inode
 lru traversing context on ext4 and ubifs
Thread-Topic: [BUG REPORT] potential deadlock in inode evicting under the
 inode lru traversing context on ext4 and ubifs
Thread-Index: AQHa1CTInbJ5495Kk0Oyw9CF3kyldLHzKagAgAiorN0=
Date: Thu, 18 Jul 2024 03:04:50 +0000
Message-ID:
 <MEYP282MB3164B39D532251DC6C36B652BFAC2@MEYP282MB3164.AUSP282.PROD.OUTLOOK.COM>
References: <37c29c42-7685-d1f0-067d-63582ffac405@huaweicloud.com>
 <20240712143708.GA151742@mit.edu>
In-Reply-To: <20240712143708.GA151742@mit.edu>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-tmn: [JV5QR5IXsnChSSdq0+cS3AJvHdP1OA03]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MEYP282MB3164:EE_|SY4P282MB3661:EE_
x-ms-office365-filtering-correlation-id: c7cfac0f-5a47-4335-7f5e-08dca6d66379
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799003|461199028|8060799006|3412199025|102099032|440099028;
x-microsoft-antispam-message-info:
 J9LaPZ5lds60YiEF5umOrG1UmOo5Imp33idt7iBE7WGnkNGBF35v9i4d0q/dbPZwctLI/9/F253gi95x8gn0w5VTnoWmQTY4IcGL4FTvYCVZ5Qbmlb1LMKogK6tG/lhcmhGtUZesS/WBYd+jy92V3LuSrmkPlrB/tso/Tj2FnDYZj/83asGgyan6n2/WfSREiM4Eur9Gb1iZ2eyn7y6jXEK4LjWdIpKZOJjU0RVwDp7rwT7ksQP9Tn2w36DZ86rEJ4KaRoSioPcTHSp5gRj6dUfQQPnYaslDS0lP9Jr2NAH0KeaUrWPIx1DyXpsZy5DyKtJUCKVWICm86tDtQlbCWLjtzGZqFjg2SQxLgTgRwpHEGtx6lVHBtEhzbbu+uKhLqxfeYfHwRtYhRvAKu2FmKrzosJkkVAEzdB7hhISQHWHp+C/UHj/dZ1MPe8TB/wn3guyeP39iG5hri+d40O0RmJ/U+a3YL8kkiFXfVfa/mRHlsLLg/wgRHEkuz6h8N+YFL/A3GEk5EweKMZNffePfk6kgOc0xgM0KDRhEn7htO7SyPqLRSbDDzuHnOTO8zDAE35jRFaIP9Gm72TVO81anE8q653AyRv8rdwVR9LICxgHiYnlGdPFW753JNzWDPg5sdMHjM7f/lxRa+o1ZTP2S+Q==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?+ailHlAzLLI3Pmbdph/b8iovr3EOB5E4cTBGw9bdxGmXocT62+p/a1z43R?=
 =?iso-8859-1?Q?w/Z8FBDXxFtXvC6I1ijw3dmeG7fSlmk77cMsDnFsFWDMeh8XLI2HgVgWkP?=
 =?iso-8859-1?Q?brDxdI2dT5VIhWukVkpL3m4kncjdL2Vqq+PkvuVQWXYtU2jPwgO1Hion40?=
 =?iso-8859-1?Q?hA5bn0kINK9YnWbLvXge4YNZV/hsc+LsTihktKCEEyUEVtBboXY/G09I9h?=
 =?iso-8859-1?Q?g2XbSY/He1GAyITuTkJgL52mmtNxgKBLqQGQ63QekwY9mNEcwY0wCaNpAK?=
 =?iso-8859-1?Q?wmTFTKM6MJPlQYrH3U4NaGO8Q1kBuwVnz6KjhV/5DRIFOCuAKQlg2bU9ol?=
 =?iso-8859-1?Q?e2lYZSAEY/AaidqKYTO3JsOvX5OGJD7ZThwPGpsPLnFnIq7X0mJl6RUX1j?=
 =?iso-8859-1?Q?kI6/Hyu5QFDAR27AG/iNvzEJXqGzT01wH6hISyxkW7RpWyTxizTFGA5++E?=
 =?iso-8859-1?Q?EeadmPGcuK4PBYFR7iU0JJANin6U4dR/vJLXYrQEgIAxBCLvACjBTVopZO?=
 =?iso-8859-1?Q?jGK4doMohNKK0Kad21Ja/+FOwTUISpRTJO7HLTM7TiJGBrCKEJXoU2aA55?=
 =?iso-8859-1?Q?oGB94yhpAZbXzjJtD5Js25Vjf2efDaRLR8imJcdJ0QcECrUT4NNhO0vEr6?=
 =?iso-8859-1?Q?E3heju6ajObz2XzQv1GN7/vovIXVpA97WwPPi/XT10DzsaWM9kD8EwVo12?=
 =?iso-8859-1?Q?KTJ/NlHsITNwq7zncpJpboCP3g+eK/dm2ALMMhgjyayDYwzeYqgJO71m84?=
 =?iso-8859-1?Q?nPL7TqjRfIKZVhv6EM5QQOrFcpLB6p0LuE/aGc/FoTrNm3o0o5+0DtzWaQ?=
 =?iso-8859-1?Q?sx7NbukCaIg5QShNefk0S64auiqzrZ2ljBHphqqkI1GjjZS/OQHvWacIjX?=
 =?iso-8859-1?Q?GLtAd+jnko6Dgz8uwYQACGLu+gBBdrprjVZnQurJOvxVwzSUVPy7SA3vvs?=
 =?iso-8859-1?Q?KacC1S42cuB/WrJ9vqoB6cfKgK3lmu89j2VQj0GMW2z6N89xTaxPNCh9a3?=
 =?iso-8859-1?Q?P46kCSjnQL/vFI5OQ5fD5o24rAibrmOohcYOb/fHDF5WjkUV/vsig9CM5N?=
 =?iso-8859-1?Q?kkBlDtgNfEJ7kMZxrOHpuU2Cm2D4Ib2fvopog71zKNcGTcxzLAwLgXcKlw?=
 =?iso-8859-1?Q?mtmQiEt9FIiDb5TdhXubipPEXIIhTCgIOHUVedSB+t4ACI4i/Lzd/n2cm1?=
 =?iso-8859-1?Q?RJrwuK3C1QzSXi/BFnMHBHBSMOw9StN6qflc0Ahxbo4OzBQFMbgFEMuiKv?=
 =?iso-8859-1?Q?Ek2K0UnlHsTubTHKB/m56mF1eIgPC6j5mGvuHb3+I=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-722bc.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB3164.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: c7cfac0f-5a47-4335-7f5e-08dca6d66379
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2024 03:04:50.1493
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY4P282MB3661

> Um, I don't see how this can happen.  If the ea_inode is in use,=0A=
> i_count will be greater than zero, and hence the inode will never be=0A=
> go down the rest of the path in inode_lru_inode():=0A=
> =0A=
>         if (atomic_read(&inode->i_count) ||=0A=
>             ...) {=0A=
>                 list_lru_isolate(lru, &inode->i_lru);=0A=
>                 spin_unlock(&inode->i_lock);=0A=
>                 this_cpu_dec(nr_unused);=0A=
>                 return LRU_REMOVED;=0A=
>         }=0A=
=0A=
Yes, in the function inode_lru_inode (in case of clearing cache), there has=
 been such inode->i_state check mechanism to avoid double-removing the inod=
e which is being removed by another process. Unluckily, no such similar ino=
de->i_state check mechanism in the function iput_final (in case of removing=
 file), so double-removing inode can still appear.=0A=
=0A=
It looks we need to add some inode->i_state check in iput_final() , if we w=
ant to fix this race condition bug.=

