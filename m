Return-Path: <linux-fsdevel+bounces-76355-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NvsAYbQg2mOugMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76355-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 00:04:38 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FCF7ED288
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 00:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0739F3016931
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Feb 2026 23:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0FC3164A1;
	Wed,  4 Feb 2026 23:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Whke47Pm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C46528136F;
	Wed,  4 Feb 2026 23:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770246268; cv=fail; b=qZUFQFsKQyZXybnI24DV1fRkyBeMYTEWOUmctrlZe+dGyH6xtZhrPONBtMqjL3/UiYynd4ea2RsNJcyYEfRaXsysoh/0DCfWNIA+Nl3DxyvboQANA5CLIYBKc9vGVWv7Sao7F3dxuPnVxBu36d1R55ymyWYFQQN6keAzjtA+PUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770246268; c=relaxed/simple;
	bh=zNvDqrY0SvJwxIE7d7AfsEN37EzEk4qIiMw8CFoyPb4=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=M8xFRgk1W0vmcvlkj5/9qlmLThl5zA6KPK9YUCn+ELqRbnVkzMxk3C96bgJ62DiFT7VGjCO7diQeq2haGUa0e7/lgBTG5JoAgFv9vqyacXymgpWuEDoAM2L7bK5cmq5fZXMPbXzg+onZrv5gMT+S5hKtY0qqD8G6+JxEqjDsIr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Whke47Pm; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 614HPmRc003180;
	Wed, 4 Feb 2026 23:04:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=zNvDqrY0SvJwxIE7d7AfsEN37EzEk4qIiMw8CFoyPb4=; b=Whke47Pm
	PSxuOzLKoxLtro57XHfNhRBWYfu+B3xWZ/baWS8DUfg8O2jpQEE5NkDY551qlnPj
	Xqkr/7VI3c7W5U1GCUTu9ctG/D4N+qrGW6XkLuT76ojSOc8/iwM01o/GNR2RLUWu
	glHmaQd6aw3iy3a7qrfSD1ZYtu/TeOp9OEy6eg62Q51kaNEIQRtjGde56KOrrW3L
	mfWRCsYHzWYxCDizlm4xwoyHfOzwM+54N7eoeDfE1mH/TmKWQ9QhoFlGDeNltC1f
	2SlP5FpivadosNcZzhsBKpBX5GivTdVAS16w2UVwJieioZDpTBckw7v8L3fojStc
	HKDkgz/1txpeMA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c19f6me3j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Feb 2026 23:04:10 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 614N4ACg027760;
	Wed, 4 Feb 2026 23:04:10 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013021.outbound.protection.outlook.com [40.107.201.21])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c19f6me3f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Feb 2026 23:04:10 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HA6fjmPgePb0PAmcdG+PKFdEC+MrhAOyEph80gzKz7hnWGgXE6uQYoTFt3RKTjse7Jm1dAcjRAPmogBaZuHQNCuG/sGEwBxMglRdnnSmYb2X+316Akc/cUyZtglbaMLBZF7akC0xN2TKebbcGDz7OBlEhEZnStGkOnfwarDsDJQwxZMMEDunxD2TK7evPteJdBFtU5gxbsE5Qw+4iAFlcFA4fdEkBMN70n66s/mIoVhsZIgVTC6Gv7X1VaKvddWvdvDidMqE+JH4Uc7Jfh26YqbtwOr7qWIaZyjtqlRzGfW0YqEsr3YKQ5sGTUaZTRGXTw0WAr5ruI22yTRtM4OH9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zNvDqrY0SvJwxIE7d7AfsEN37EzEk4qIiMw8CFoyPb4=;
 b=LSlViPL3vp1DCgt/e84Q/O0GfYLDlQeHDIhyp30wMC1PPa4jXI0oZ8DFPaCKhXltCPCCYek9KvPcvdK6n7RJ9t9OeufkoDeEkJfJukWmeZo/GMosE3accCQwI6j/60OnY4s81acxBaJ5CSzIraRCUMNAjXFcDl2Pv2kSBqOf1odwMOcs+dTEGLPp5KTayQ9MvsO2mYCbNjXZGo7lGruzw9+qMaiJ995+Q0vfopBQwKKtmG6B8mBJp0cp3sSWU9jdgq5wdic6JxUjQ4EsIM4tgC0sWcO89lTqqNt0h59ssybqAgIijjt5n0VWl4T5gq/lW0Nh5mz/LaGlg+b6CQVTkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by DM3PPF5713E8565.namprd15.prod.outlook.com (2603:10b6:f:fc00::419) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 23:04:07 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%6]) with mapi id 15.20.9587.013; Wed, 4 Feb 2026
 23:04:07 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
CC: "jack@suse.cz" <jack@suse.cz>, "frank.li@vivo.com" <frank.li@vivo.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shardul.b@mpiricsoftware.com" <shardul.b@mpiricsoftware.com>,
        "shardulsb08@gmail.com" <shardulsb08@gmail.com>,
        "janak@mpiricsoftware.com"
	<janak@mpiricsoftware.com>,
        "glaubitz@physik.fu-berlin.de"
	<glaubitz@physik.fu-berlin.de>,
        "syzbot+99f6ed51479b86ac4c41@syzkaller.appspotmail.com"
	<syzbot+99f6ed51479b86ac4c41@syzkaller.appspotmail.com>
Thread-Topic: [EXTERNAL] Re: [PATCH v2] hfsplus: fix s_fs_info leak on mount
 setup failure
Thread-Index:
 AQHclMaiKtTJZ48RZUCMz1LaYapWfLVxofOAgAEsaYCAAALggIAAA2eAgAAJOICAAE23AA==
Date: Wed, 4 Feb 2026 23:04:07 +0000
Message-ID: <0001ad7957301981aa1c85e1bdda0f076cbd9a7a.camel@ibm.com>
References: <20260201131229.4009115-1-shardul.b@mpiricsoftware.com>
	 <cace4df975e1ae6e31af0103efcbca9cdb8b8350.camel@ibm.com>
	 <20260203043806.GF3183987@ZenIV>
	 <b9374ab2503627e0dd6f62a29ab5dcde9fc0354f.camel@ibm.com>
	 <20260204173029.GL3183987@ZenIV> <20260204174047.GM3183987@ZenIV>
	 <20260204175257.GN3183987@ZenIV> <20260204182557.GO3183987@ZenIV>
In-Reply-To: <20260204182557.GO3183987@ZenIV>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|DM3PPF5713E8565:EE_
x-ms-office365-filtering-correlation-id: a7f514e2-c3d7-46e9-d077-08de6441b31c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|10070799003|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?VlYzU1QzYWdNR0VXTUVCbDJOOWNIWGNqT2hneTFrbFpOZ284UVZxbHJucDlZ?=
 =?utf-8?B?ajM2NWllZVF3MWUvYWc5MW5SbVdpdnNJZDAySDJQc0RMY1ZlN1RaemVSVjRL?=
 =?utf-8?B?VUJ5c2FXT2g1ODZQSU9jNjJCbWpNa3huRjZBeXVPdTFSelJSZVpjYzdZNks0?=
 =?utf-8?B?QlRqRjlsNXlRZ0dPbVdDMjhlb0I1d1hmaDRiM3FyOXdybGRFTXY0M29reVAx?=
 =?utf-8?B?ZTk2SE13NHh1ekJzQ29RNjJadHhuaVR5UkJHa0Y1ZkVSY3hyMmEycUpvWnIv?=
 =?utf-8?B?TXcvWTczZm9EYlphMWhqLzU1eGVlaUlCdk9vRDE1SlJJRHhpSTBEYWRSbHF3?=
 =?utf-8?B?UThwbXU3QW9QTDIzMzJKckhnNnU5NXRsUHp5WktENEgzK0ljREhuRHdrZzB1?=
 =?utf-8?B?QVhQd2Z0cWlWS3ZEY1NUT0ZxYnRBazBoeUtFcDJhdzYxRlRySTJURHhIdm5j?=
 =?utf-8?B?TFM5dnJENlJuZEpWQ3lTTS9FSFdPK0x3TUxUQnNJamxyZVczVElwUnVwc2RX?=
 =?utf-8?B?WnR6WDlXQ09tTGJmSWxxWXd5MTBzU3pUckxIbktxOTloYUU2bzV6NlZlVWRC?=
 =?utf-8?B?YkljMEVTNXhPNE1PSFdDeFVxR3d3SGtjdWFQVUR2bDhpVDJhME1nb3V6cUxD?=
 =?utf-8?B?M0w2clZnVjFGdW0wZmxCdHNNa1ZjZXkrTDlWN3BsWlFLMGU1MWhXQ3NKek1E?=
 =?utf-8?B?c2NoNW4xbHNrdjVPYWVCYlVnNVlwN1NYUmpPVndTcGV2MEwzOUhneWxSY2ZO?=
 =?utf-8?B?QlFxSkJiVEsyRkFDQTFqZHI2aGZUZFREWTA4NXV0blVKcWxlckovcG9hbGsr?=
 =?utf-8?B?ZzIxY3dPZlpOdElxT3dUdDIzVmlnOW1BWS81bjVsbXM3Z2xlU2xNMXVGYk95?=
 =?utf-8?B?K2hjajVDSTlVTDhZR3BYSVMwMFdPb1NUdjByMEJ5Q1hZMVhHQS9haUk1bFM1?=
 =?utf-8?B?MEV4ZkhTaFY5aW1GTjUxYVYyZExlcWsydkE4dG5jNnk5Nm5oSVZ5ZW9GVWZo?=
 =?utf-8?B?ekFGbFY1YlExdERQam56WDdLU29SOS9QeXhWN1ZNVjEvMFdVS251dU81ZlhY?=
 =?utf-8?B?cVdkeCtNUCt5Y0FWMTV6WUJSTHRRS1FtS3V6YUYyNmt1QlB0c1V4RDBZZUdS?=
 =?utf-8?B?SzUxUXJzZE16MjlkNW94Q0E1YldFaWxNRjZtSzAzbjczOWtld28zczBxZml0?=
 =?utf-8?B?ZjBTaFlpQU5KRE1COS9EOGwwYkJ6VWsrekhEQTA2ZjJkeFF3UHpsV0psb3c3?=
 =?utf-8?B?cm5mcTY1enhiOGdYcjY0MmYvdmpKMHBFT1duWG9HK2xkV1c2R3d0RXF3Yk1r?=
 =?utf-8?B?OEd0VXR0N3hYZStHVjQ3Y1BXUWZTekRqeTljUWx2dkcrMktud2ZBU055UkJq?=
 =?utf-8?B?ZHhWYTFFTmJCZ2VKemlCajY2V2lLZHgrUmdyMGlqUU9kcUJlbHhFQ3JBTW5M?=
 =?utf-8?B?UXJDTE03TFJiaWJiSkorSXNmempWMHVzVEhaaXRkeXJJY200TkJmMWhHQTZm?=
 =?utf-8?B?RWdSVW9vKytZbmNkM0NCdXFtMVNIY1ByYTlLNDFsT1k1TllGdXpNbzdQQzE1?=
 =?utf-8?B?SGJzaHIxNVN1Q0h1cm45RnQxVFl1eVNLeVNzVVgweWI2RURPUmpMU2hYdW0v?=
 =?utf-8?B?SFRWc2ZSQ20yTGM3MjBRWDlXamdhQU04V2xmNFEwS3VXRVMwd09UK0RlY1Jn?=
 =?utf-8?B?OVRVU1d0UGF6b0FJRHdUTHBpZVUzbVJWZGpFSUEvaFZWMmVwL3FDYmdoOVR0?=
 =?utf-8?B?ZzU3ajk2MDJvRVpBbG1nTVdLZnZURTZ3Ykg1Rmdjck1YOXBpc0tnQ1VBRjhw?=
 =?utf-8?B?bWhud1hDc3NIZFJmZlM0YWR3V1BsaHJlSHhtZXJYMFFmUVV3VEtOWGh5N010?=
 =?utf-8?B?OGpjeloxeTRuOExHRm5kSzRmdnZGTlYxNW9oMWk5NjFaZFF1TUlWWlFQQ25z?=
 =?utf-8?B?Unc2cWU2ajdYQTVtU0s3YkFXcjBqYWhUbVg1dzRUL2I4MkFIMHlNaU1hMVNF?=
 =?utf-8?B?S242OS92VWRjeThqUXUvT2E3dHQraUNUcjZxRlowR0ZwbU1HUHpOaFhhNE11?=
 =?utf-8?B?TEJLZjcvYk5DVFR0Uzd1eVp6RTB0TUdUSmZLYjIvM256SXAzakxyNEUrRVdu?=
 =?utf-8?B?UktlMkxpK1hFOG5kWERZbmxzRGk1dTNhZ3J3MW0wZzlTZy91UFBRdUxYRmU4?=
 =?utf-8?Q?wIKsrP9OCINb88WEA9cPkQk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WEsyZld5d2hmOGo5Y1NDVmdoMFV4Q3ZoRmRpenU0bzNTWUJnekwrUWlON3Vt?=
 =?utf-8?B?V1ZFdStkMmdEdTdiaUVqQ0R4dkRpc3FWZmpsNVZKSVd6S0hqRXlEUXpBR3Ro?=
 =?utf-8?B?RDhnODhzWC9XU1daTDZCWGxzVFZrY0pIclNWcTcxN29weGxuTnBFSW5kMkZY?=
 =?utf-8?B?b0s5TVdPL3MrdFJGQmpNUVh3cWw3SnN5TG5RSlA3NzVuZTcvbDJnMlJISGo3?=
 =?utf-8?B?VnUwWE9XNzMrbS95UE1lemdwT25mRjNrN1dvbFlKbnZsbzRlNkRUREx4K0hM?=
 =?utf-8?B?ME5zV25DTmdWSHpEMG1QdVk1M3IvRnVMcFNldmFyd1NmT2UzNGhWOWF4c0xP?=
 =?utf-8?B?Z3VjOWNRWHZDK2FZbHhoR0RiOFcxYUlyU0NCbmIrK2R1dnBIN2N3Uno5eUJM?=
 =?utf-8?B?bUhhMGxCdHhqTjRrZkkzVHJ4YWcwR3VpbW00T1dHVm9VVnJBQmszV0xPMEsz?=
 =?utf-8?B?S1VHZTczUnZKemFZbDZNd2Y1T0EyS1dRNHNOM1MwUXA0OWZkaGNFYmJxYW1J?=
 =?utf-8?B?eWpFSDVhdWx3b29mcUJGTmtpd0ZrUWJMTE9uRUtmRDJkM1R4VVBtMy9VT251?=
 =?utf-8?B?WkpsS2JrYWY2anFwakZKMkVzSDZzRTZYRXB3M244YWtKRUlzRCtpSFFHcGVY?=
 =?utf-8?B?eTh2alNtd3lYMGdNQkVJUFBDWW41bktGRWhyaFg3Y3d4c0swclRHbm9rdHcv?=
 =?utf-8?B?dG45YmFDNlRMUHduaTc2TXVXb1h3a1pJaGRsSnljT1drRlVxeGcrV3pramNz?=
 =?utf-8?B?cnF6M2ZZbVkzOHVFR010UUtQaFp5cHYvZWd0Sytvb3RrNHVDUGMyeU54OEUr?=
 =?utf-8?B?K1hqV3puYnhPRCtjUVl1TlY2QVhta2pQNWREV1pnaVdhRW5zOWd5S0hVV0hD?=
 =?utf-8?B?dFFyQytYMFZqUHJKeXdEeTNmY1BjYmllV1d5L0VacDl4OTFEaHJmc3J3SDli?=
 =?utf-8?B?K00xc3BaSTdHNkI3c3d3NzllVndTVE1Ea2JhOERZVUhKU3R2NVlDUGx4ZHM3?=
 =?utf-8?B?Q3pWM1V6a1NyY3JlamFtT0ExL2hIM1VpeFBBeDdDV0VvekUrNHFyWHNEWUtu?=
 =?utf-8?B?UmlmRVZOVjRaZlIrSGc2cXlJRXBoSSsvak5BaC9oNkN2WUZBNFRMc28vRU1Z?=
 =?utf-8?B?Q0xVTGk3UE9vMy9BRlVaZmNQRHhlczFKNE13TnlKMnFuVzh3QUpiOGtBbXUr?=
 =?utf-8?B?WTBkRUExS2ZmaHJUM3FNZXlKaXZmS2d1TVRmUk9IazVMWjJaNkk0Y2JyQ3l6?=
 =?utf-8?B?L1ZNeDBXUU5tVjIwV29YaWI0MFBTQkhBMGZySnZRT1U4VkRGanpJSkhvalFO?=
 =?utf-8?B?eE9qNTBrQmdRb1BvUWlHT0NpTnB0WjFGbVdTZmRXZWhBZ01mVFlwZnp4VHRk?=
 =?utf-8?B?SlNvaU4xbUhSVzlHMEhtbFFoVjY5MmRHaE5raUVObkVkMGFKZlh1RnFqSHpx?=
 =?utf-8?B?aktrUmx4Wm9UcFp2SlVTbnRTMlZzNVpwQWR5RjBObVhXdHNOZGRLNEkxYzV0?=
 =?utf-8?B?T0Vldnd1cE9FWkdrcVVwNjRCVGdTQTdXa3ZXZDE1WFRsVVB3NlhBOE0xZTFC?=
 =?utf-8?B?bkJzWUhoMDNnSkMyS3NTM0hqTjF5d2FIVWFCSFZjZjVxa0VuZHZzSVZqK1Fq?=
 =?utf-8?B?WHlNR3dpT3NSamVwY2pCYS9YQzRPY2o1bk9HU21UVHk1ZTBHMDZlUEM1VDJF?=
 =?utf-8?B?YzZOTk43dHM4amZpRkFLMFIzMTh5eERZZ1N3OEl3SG1ZVU1VOEp6UU9QVFRh?=
 =?utf-8?B?cDJ0aHErVzZPY2M3SUV0MTZMaEFOeDBTVzMrYmxwVkZDajFSVlJBS0hMajlI?=
 =?utf-8?B?RVhpMXlYUU1EYzkrMmJuMDhVN0hDaGxDbGxpeXhTMjRIQitlUUJUVWhCRWxC?=
 =?utf-8?B?QXdRWVlaY2gxYWdiQU51NXBRbTF0aHc1Y3dNMEgyeFRNdHoxZ0hjeWhpUEdr?=
 =?utf-8?B?R1hjOWVLSXNjNWtaa0tsWXdnOENpeXFqeVJ0aDk3ZTFlV0c0aUk2aDM4dEti?=
 =?utf-8?B?TW9oYkxJaEpIaE5QZWV6ZzAzTmVYYVA2OG01WlZmZzVLWXFSUmloZDRQMHZI?=
 =?utf-8?B?ZEFQbWtCMUdFOXZObXBSQWhhNmlyVlZ1Q1Vpb0VXNUd3Q1RmaUhSeHM3cFd5?=
 =?utf-8?B?L3ljSzBWVlNRVkRnQ0xOT001RkJ6d0JHbVNjWXZ2SWU0YUl2UEd3QXZxUHhy?=
 =?utf-8?B?bHZyelk5Q3AwNlRrdmQvdHNZUGhkM2dQSjdOZTF5U21UeHE5SytzRHFtN2J4?=
 =?utf-8?B?SmNVZnhQSTJxSkxMOE5IOFNpS2E3RERkTit1UFJYZTBhVXdHUVEvVlpJRUJY?=
 =?utf-8?B?dlZEN3VwMVBydmpJQk9mTnFkNGJMZ0NBY1phYXlZSEhHRFhmbk42em9uSGZS?=
 =?utf-8?Q?9hJOc5ceUAkMBqcfpiq6ozYuDSFs+7KO33Zsn?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B9C105FC495A0E43BE11DE9E56FD41FF@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7f514e2-c3d7-46e9-d077-08de6441b31c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2026 23:04:07.3219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2exZSgUcDyRkwklLxNbRuWgfhL1NtAYhNUKt4W+cdKQb012kU7wQqlS0V5dJeWC0iz4SBJRJQ0oJSXps8gWkRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF5713E8565
X-Proofpoint-GUID: fspa3z5uAx2l2G1v1cj2V8y5iGWkTN4p
X-Authority-Analysis: v=2.4 cv=drTWylg4 c=1 sm=1 tr=0 ts=6983d06b cx=c_pps
 a=L57JwnknqhavsmPomW3F8Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=aDXXJaU2qDHnul8pdzwA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: OYHA3STU0eSwsxdQbhmdjNuzrPN8I3AQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDE3MSBTYWx0ZWRfX4y0fQ2+cCt/e
 s/pnRDKN5U0ph50es9ZuEL5xmnJnxMfMykYg6jLfH1hXRZ7HbGTqPSYEFaEl6qAzlgZW14s9SkM
 tXxqKK3B57nB4AE3dWBZzOuWDWog9MCEmBZBqSUXD34tsGbk7SJ1OLUTnlsZSU4mOsf/vS9rKec
 c2uVHG8DbHHgzvjoSEtecjeSPOwXwaO2N4bBGyYKGSDqfPhASRUbwClvwXZdYrFdNhvu1764pRQ
 lYbkXfjZ+OuRhUROuyVg8VwWQTdkT4yJWm9xAFVhvCa3YkWc6TP/US++4ElfsghifREIQRUt66v
 zH+sEr3I4oWc6rweBAZzry5Kh8F42HhNwrGMuzdrFYLGYbluBxMd1LS1PgIf0b3rRge9HEGddEu
 BihW6/Crss1Jdn+1lQkCmB1+aw9qTvXpMWqeZnc13THZgAKOie34fugmM9e3VixqRKye9G8b1ho
 wUsWgTaghR/qikof7sg==
Subject: RE: [PATCH v2] hfsplus: fix s_fs_info leak on mount setup failure
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_07,2026-02-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 spamscore=0 malwarescore=0 bulkscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2602040171
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[suse.cz,vivo.com,kernel.org,vger.kernel.org,dubeyko.com,mpiricsoftware.com,gmail.com,physik.fu-berlin.de,syzkaller.appspotmail.com];
	TAGGED_FROM(0.00)[bounces-76355-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel,99f6ed51479b86ac4c41];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 5FCF7ED288
X-Rspamd-Action: no action

T24gV2VkLCAyMDI2LTAyLTA0IGF0IDE4OjI1ICswMDAwLCBBbCBWaXJvIHdyb3RlOg0KPiBPbiBX
ZWQsIEZlYiAwNCwgMjAyNiBhdCAwNTo1Mjo1N1BNICswMDAwLCBBbCBWaXJvIHdyb3RlOg0KPiA+
IE9uIFdlZCwgRmViIDA0LCAyMDI2IGF0IDA1OjQwOjQ3UE0gKzAwMDAsIEFsIFZpcm8gd3JvdGU6
DQo+ID4gPiBPbiBXZWQsIEZlYiAwNCwgMjAyNiBhdCAwNTozMDoyOVBNICswMDAwLCBBbCBWaXJv
IHdyb3RlOg0KPiA+ID4gDQo+ID4gPiA+IFdoaWxlIHdlIGFyZSBhdCBpdCwgdGhpcw0KPiA+ID4g
PiAgICAgICAgIGtmcmVlKHNiaS0+c192aGRyX2J1Zik7DQo+ID4gPiA+IAlrZnJlZShzYmktPnNf
YmFja3VwX3ZoZHJfYnVmKTsNCj4gPiA+ID4gbWlnaHQgYXMgd2VsbCBnbyBpbnRvIC0+a2lsbF9z
YigpLiAgVGhhdCB3b3VsZCByZXN1bHQgaW4gdGhlICh1bnRlc3RlZCkNCj4gPiA+ID4gZGVsdGEg
YmVsb3cgYW5kIElNTyBpdCdzIGVhc2llciB0byBmb2xsb3cgdGhhdCB3YXkuLi4NCj4gPiA+IA0K
PiA+ID4gQUZBSUNTIG9uY2UgeW91J3ZlIGdvdCAtPnNfcm9vdCBzZXQsIHlvdSBjYW4ganVzdCBy
ZXR1cm4gYW4gZXJyb3IgYW5kDQo+ID4gPiBiZSBkb25lIHdpdGggdGhhdCAtIHJlZ3VsYXIgY2xl
YW51cCBzaG91bGQgdGFrZSBjYXJlIG9mIHRob3NlIHBhcnRzDQo+ID4gPiAobm90ZSB0aGF0IGlw
dXQoTlVMTCkgaXMgZXhwbGljaXRseSBhIG5vLW9wIGFuZCB0aGUgc2FtZSBnb2VzIGZvcg0KPiA+
ID4gY2FuY2VsX2RlbGF5ZWRfd29ya19zeW5jKCkgb24gc29tZXRoaW5nIHRoYXQgaGFzIG5ldmVy
IGJlZW4gdGhyb3VnaA0KPiA+ID4gcXVldWVfZGVsYXllZF93b3JrKCkpLg0KPiA+IA0KPiA+IFNj
cmF0Y2ggdGhlIGxhc3Qgb25lIC0geW91J2QgZ2V0IG5scyBsZWFrIHRoYXQgd2F5LCB0aGFua3Mg
dG8gdGhlDQo+ID4gdHJpY2tlcnkgaW4gdGhlcmUuLi4gIERlcGVuZGluZyBvbiBob3cgbXVjaCBk
byB5b3UgZGlzbGlrZSBjbGVhbnVwLmgNCj4gPiBzdHVmZiwgdGhlcmUgbWlnaHQgYmUgYSB3YXkg
dG8gZGVhbCB3aXRoIHRoYXQsIHRob3VnaC4uLg0KPiANCj4gU2VlIHZpcm8vdmZzLmdpdCAjdW50
ZXN0ZWQuaGZzcGx1cyAoSSd2ZSBhcHBsaWVkIGxlYWsgZml4IHRvIHlvdXINCj4gI2Zvci1uZXh0
LCBjb21taXRzIGluIHF1ZXN0aW9uIGFyZSBkb25lIG9uIHRvcCBvZiB0aGF0KS4NCj4gDQo+IEl0
IGJ1aWxkcywgYnV0IEkndmUgZG9uZSBubyBvdGhlciB0ZXN0aW5nIG9uIGl0LiAgQW5kIG5scy5o
IGJpdA0KPiBuZWVkcyB0byBiZSBkaXNjdXNzZWQgb24gZnNkZXZlbCwgb2J2aW91c2x5Lg0KDQpP
Sy4gTGV0IG1lIHNwZW5kIHNvbWUgdGltZSBvbiB0ZXN0aW5nIGFuZCByZXZpZXdpbmcgdGhlIGZp
eC4NCg0KVGhhbmtzLA0KU2xhdmEuDQo=

