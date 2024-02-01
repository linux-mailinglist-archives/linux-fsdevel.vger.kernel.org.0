Return-Path: <linux-fsdevel+bounces-9886-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3EB845BC2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 16:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBB5029105B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 15:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38591626DC;
	Thu,  1 Feb 2024 15:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="OyLFkASs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168a.ess.barracuda.com (outbound-ip168a.ess.barracuda.com [209.222.82.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC3B626BF;
	Thu,  1 Feb 2024 15:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706802013; cv=fail; b=E4GWSf12QEFsRDAkMxkK/AwsjN6aO6ciz15pDAANE0PVBQ5w7IOL3CWtsP0W4u7cp8kSkXdrw4sZJFJvoBsBkyoLsEsoXGpG5/yc5QwBm83VNfVCMoRh+kw72ZoUbQdAJpVbXA8HceBI4zOB2uZAepZnAg1dM8eJbmveJLJ4hgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706802013; c=relaxed/simple;
	bh=E2tRsrZDevPQrKlLNclxpiFTylpHxwwSB14HQYqa+p8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=byX7uXSqM73754fJFUGnyBME6Ir5yKJH9PhIPWoaHrh1dhUVYnRSPlUGFAARALzqkf75xz2blY3eUR9WgO17qrtZWjyguH4Df1IrsMVM8VnfUYlYtwTEdBEQ3NzBDju+EHKkWbXbCJz3uSXqCorAroc/MC+qq+gWWBMa2Yh6WDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=OyLFkASs; arc=fail smtp.client-ip=209.222.82.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41]) by mx-outbound8-188.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 01 Feb 2024 15:40:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mr4PWWMA0DDXAjH+EqPzW2jCA7wZ8f96MwkwZPoQA7etmlm+bPp4b0cwHV2CHZ0KKohW9ehEEf8xjy+DvAQVR3DeBBAdElxhGRLiOxGu5KLyuXvf7Xt4ZU8OJ3NDNXpA06XxNw3vrzltrZRZxqQtvt3mPz0ljIbiDgAafeN27LEfVaoILakjB1R3jw3M4ufXjcXAPZSABQiPdIGsGQjEnXeEMufgwhL3EyaCMIMQgOEPSasCBPpwKDs+ekHo27AJD6enshHN57exz/AGEkKo78oTgzerEQbD+2s3dwP9g7uTqDy1VxjTQDrFimJcwyfiASTzKy7svCfPOXaz2eEjUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E2tRsrZDevPQrKlLNclxpiFTylpHxwwSB14HQYqa+p8=;
 b=Thry2WutiPHehzDV8aTOpHPTq/2VYarvo2x7p9cBf6GnNHDFjDL6Y8JpWBOJSqnqBwp25PLSU5p2LABs5SAcHDBhUGQhwTOMh7jpJcEDdvCcANSBGhtsq9+4DwfuVjMLKfECKfPG5kpSJYtn2b0MVoHJ3CHPBBXzxSn/SuF7JB14p4gdYvw3vBlJU1EEenJPl5GVkl+1tSGLZC/LPY+0j9nTSSuP4ANaPapooPiA63BOkxm2ZWI+I421DFrWAF6utoqptIqRbZagI+0W21uzdNjpv0qDsBUoOl5Xmb6piiSttNRyv+fsKNAP62k1uwLlFje1xvEGKzuwkMxLUrJO1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E2tRsrZDevPQrKlLNclxpiFTylpHxwwSB14HQYqa+p8=;
 b=OyLFkASsBoUCuX1PQHMkat/NkI/ofQXM0DaYzy4AqtFmNnMEuPQrrhjn9l3OSVZ4hnVr+PNmMClzF6k/HfQ5t3fry5T7Kv1RsM5miyw+nRHJofc03cU0jRLy9ddo5MVsYx43Ln54wkDTGp1ISRkQDjVsdoFSMTO538fny8RMwMA=
Received: from SJ2PR19MB7577.namprd19.prod.outlook.com (2603:10b6:a03:4d2::17)
 by DS7PR19MB4440.namprd19.prod.outlook.com (2603:10b6:5:2c1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Thu, 1 Feb
 2024 15:39:59 +0000
Received: from SJ2PR19MB7577.namprd19.prod.outlook.com
 ([fe80::9270:8260:3771:ff45]) by SJ2PR19MB7577.namprd19.prod.outlook.com
 ([fe80::9270:8260:3771:ff45%4]) with mapi id 15.20.7249.025; Thu, 1 Feb 2024
 15:39:59 +0000
From: Bernd Schubert <bschubert@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert
	<bernd.schubert@fastmail.fm>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	Dharmendra Singh <dsingh@ddn.com>, Hao Xu <howeyxu@tencent.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Amir Goldstein
	<amir73il@gmail.com>
Subject: Re: [PATCH v2 1/5] fuse: Fix VM_MAYSHARE and direct_io_allow_mmap
Thread-Topic: [PATCH v2 1/5] fuse: Fix VM_MAYSHARE and direct_io_allow_mmap
Thread-Index: AQHaVJp6pCpUGVTRIEOO0QTX1flKZ7D1LPKAgABh1QCAAASIgIAADU4A
Date: Thu, 1 Feb 2024 15:39:58 +0000
Message-ID: <95baad1f-c4d3-4c7c-a842-2b51e7351ca1@ddn.com>
References: <20240131230827.207552-1-bschubert@ddn.com>
 <20240131230827.207552-2-bschubert@ddn.com>
 <CAJfpegsU25pNx9KA0+9HiVLzd2NeSLvzfbXjcFNxT9gpfogjjg@mail.gmail.com>
 <0d74c391-895c-4481-8f95-8411c706be83@fastmail.fm>
 <CAJfpegvRcpJCqMXpqdW5FtAtgO0_YTgbEkYYRHwSfH+7MxpmJA@mail.gmail.com>
In-Reply-To:
 <CAJfpegvRcpJCqMXpqdW5FtAtgO0_YTgbEkYYRHwSfH+7MxpmJA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR19MB7577:EE_|DS7PR19MB4440:EE_
x-ms-office365-filtering-correlation-id: ab497ef9-86c1-4478-14e9-08dc233c0c34
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 5yqA1iFjFC9hTp1mDKV5j542zZ88bMIyj1VeYgm5bkHV4AbRFXKkqbkIHA9D1tF6fqnJPFhvBu6KT461wp1CephsY2xrwiURxIxAluWZDbhyevh3t4zQj2j2jMC+mDViL+z3V0rpa91ELFDO3AhFGtVWVJtmq9Q/biOSZniXBT31HHL8hSy4iMWhcOJCZYFyM1Qw4rMOtwMIjqg6C+B2HVqJFoNzfdl7sK1n6A6Zv9Ui3WrocE+UkQTwYUZMXh1fgCMTVJ8h7b3eA1pZ5T8fxC8eYyqG8vipPxk5bFfoDAr71lly9wcC14/eVqB5Q62ENY4uE1QWE5n5Vc5jCX70O+dzsF/89HHxdJEu2pqHmMGkSVQZIfs60OBHa+jP/URJwg5EOit/Cf0E0uVoxS1RMI5zuNFEHJsbw3YPgA4FzxzSd56H7Zla0OJnHbE7cWFinz4cQdFsh1loBw4LSXtwwM/bQAb+Q45KWZnR6BhwrwP9iT9q9qctt8YPr9IjWoeP/+Eya6Kc6TvlftUfnTfOZJ+k14BX+CZFULM50APCBdsEvtMa9bR+ibTFpX8ozlSBx/Q76Hh6puzDrQG6XsSjcZ8kDMggsb0qpA0ZrMrC5C/FjsmYkb+JZE+GEfmKrU4QjeyszCKuBRowOyxcpJaCJOAIZwPPLwrNKKtemRRX8GJVmwo9jHLWg6joY60if2+a1+44SBQtvlOtTdLxsgm72+iXiC9JouKD2sqAC/DIPL0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR19MB7577.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(396003)(39850400004)(136003)(230273577357003)(230922051799003)(230173577357003)(1800799012)(64100799003)(186009)(451199024)(31696002)(71200400001)(86362001)(64756008)(110136005)(54906003)(91956017)(316002)(66556008)(76116006)(66476007)(66446008)(66946007)(38100700002)(122000001)(8676002)(8936002)(4326008)(31686004)(478600001)(6512007)(26005)(53546011)(2616005)(5660300002)(6506007)(83380400001)(6486002)(36756003)(2906002)(38070700009)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TE5sempLSjdISmdRQTVFTmIzZitlSnhOUjF3WmNhWnQ3YXpjT0Z4ckxaWTVW?=
 =?utf-8?B?N2phNXA1Q3E0WDNhOExydkpHbUc4b0tKMXhXc1VMQnJyVXRheXNhVVREQ2Rj?=
 =?utf-8?B?Ty8rbUl6cTdYZEVsbTBTYSt3aWIyT3JNVVlCcUIxSVpZdEN5THVycjd4QWpm?=
 =?utf-8?B?VUp3a01lNmpVcmJRaC9waUVQeGwzWVpVYzB3ODB6VkpVeFpLVVBiUlorbzJr?=
 =?utf-8?B?NlBHekorVE40Z0w4SGVtY3lEYUthV2NPNXBReC9ycFBLb3VzZjZjeGdKV0hS?=
 =?utf-8?B?bUhha3NlQnB5TE9YTGpsa1c5MVpLOUR4WjBOMGtYclpZdjZscXc5NmZRZFlt?=
 =?utf-8?B?eGFnaVNpbXlBQ0swVWVHajJDUTZKQWpnbGU0NVpCUGs2Z2F5UStIbmxIRTAw?=
 =?utf-8?B?b00rYTlCbktFZU9QU2RCZFpLbjJjMVdjZVR0Um50NHo3aWZnYUtXRVArOTUz?=
 =?utf-8?B?aFl1ZlhvWWx0TjJaSkNWMXF2VHlJeW94aE54WTgvb3c2Q1UxekwxR081UE1C?=
 =?utf-8?B?Um5ybmFJQlpNUFBSQm9OVVByTGpMR2N6cUtucHlWcmphMnJaV2llR1QwanFN?=
 =?utf-8?B?VFVFdjF6SGRSM0ZPcmt0K0dKK1NVRTRXZXJmRDIrN3Z6OXhEWDNUSEw2eVA3?=
 =?utf-8?B?RzJEV2xLNVB2a3UzTkZvWENNZjhIOW8wb2cwcDBxWXBCMHpSRW5wc0ZNMzc0?=
 =?utf-8?B?eVkyVVBrbCtHYUxENEVZZGhVcUlITStPeGwzU05zRmxZV0hBblBTVUx0Y0o4?=
 =?utf-8?B?bUs4N1pmTllhN0xVVUZvczNmSk8wd0xmNFZ3M2hnRjhmYXhZRnNSazJka1Ju?=
 =?utf-8?B?R0Y2MUwyeUsvVkEvMVVYOVJ3VnVRVHVYZnNiVVVZVi9NZU9RVDNEMDJ2d1pk?=
 =?utf-8?B?aGVyb0NoRFljRWFuQ0RmZnFMeEUvRDBaTndKNGl0YXE1QmZZZytZd2h1amNa?=
 =?utf-8?B?WndrRWlqcGVHTTdYNTZZd2dVL0x5bzRxNzRsQThWanlOK2o4d0lWSXpvYnRp?=
 =?utf-8?B?dHpDNUdpU3V2cjd3OW5xYk9obXB3QkJqNmd0VE05K3JScHpTNWFVTzhoSFNy?=
 =?utf-8?B?WjhxU2ZPYUNyTEFVQkxWbDNwNDQrRGppQVhFNGpibklLcUROczREWU9DV1lu?=
 =?utf-8?B?QlJEUk9LcW1zNDVlWVYxblIzd2R2RndEVStBa0F5cDB4U3JydXBzNmRMbWg5?=
 =?utf-8?B?V1A1VXdWQ05LOFF2MTlkZHIvb2lkdFh4WTdqbWxyVTlLN2FPakJCRmF6MXFH?=
 =?utf-8?B?TXhnSGVJWXhkbXhzaitXRFExakUvd2FvSXcvWklnRGl5TjdCaVJ2cFdicjNR?=
 =?utf-8?B?OStlLzlCd2t5MjRXNXVJN3cyM05COCtDeks5OERGZVlaTm1qTHV0SU9sdm9I?=
 =?utf-8?B?a1EvSmphVHJXZmx2OTJQUEc0bnI1R3RKbmdZbVN5YnZualluMnQ3bFR1V3NB?=
 =?utf-8?B?SkF1TmV4RGxoZWlBeXhVejBhRC9uVmZwVW5RQllqNTBjZW5ZTHcvOG5tSGdv?=
 =?utf-8?B?VkVGTHRkUFQrdEIzbGJMdmxLT1d6enZnTWZzeUkvODN5K3QwQzFqUVRocHJJ?=
 =?utf-8?B?U3pBY2VRU0JLR0NaS3ZYOWpLWXlWR3N3STRvSlNta1VlVEhSM2hOdERVakU2?=
 =?utf-8?B?aDRDdlJSZHo3SGZlR0ROVDdnOWExRTU1TWx6UDdQWHYzbDZCbXZJWGowMGlQ?=
 =?utf-8?B?TGwxWk9SSzhsdlQ5ODhTQkRnS3duZXBldEtYRk1kcmdHUERBcVFBdUtoSGNy?=
 =?utf-8?B?TjdIZjdNMkhrbzcxaFduc0RkOERBUVE1elgwYWR3dm92NzYvVWM4c0VoYm5T?=
 =?utf-8?B?R3hndUgyU3QxbE5QM01OU25vRm5WeHN1WTlBdmpiN2dOYWV3YlNwUHExbWRs?=
 =?utf-8?B?WENMQUw2dU5jdEZOVlg3MVY5UzVJNnNRSGt5aXZrb0MvU0szMU0zRDRZcENM?=
 =?utf-8?B?SlZKSnRlbklyYkY5ZmNRRUJwbUJQRXhiUmw3SzU4UUlCSEZOeTlLbWdjd0hN?=
 =?utf-8?B?bWhVbWcwQlc4QjEyRXorY1hRbk9BWGlpZnlVcFJrc3VUV3hQSWJXbU5MaXAw?=
 =?utf-8?B?SWlKazU5RDZIY3JJeHVrZ1U5VVZGYm01VmdDY0xmQkxZSjYrWFZUWU12dVY3?=
 =?utf-8?Q?E7m4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <031E97128EAA304082B45A9ED128A761@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	o0dZ16lZZVHZg4W4rkNt4vzVHb+sx+PACLGxekkK4acvu1v2PJW4PmwzmGF0k2XfrjvYFMxsE0FS8LulAYR02kjl/LJj4sUESOStdwmEMorubsiA+eaRIEfw1ITiY2F/M/rh8Wq8oQqSjs+RHSNBJr0RWwnGn93wZ17V1tzPEvUPsOg1stH/f9Uq7mGUYedvaH7/3Al9AS5rdYz/wkq+wzVnuGvO2vNwwIZdXZqdt/Nf43RfrNzK0m6KOsAd013SHxkZPfKK1EiuHf6QcYIoT+IHlhp6MYNyUGZyT/HhmNkh7PRwCPLNRvVRN15Emo0rrCMan6WInVQ3Mv70VW0grmqNoQnlBy8/HGOeYCMqxXkiN5SC40T31Y1v9gg1vXk8tvPzTgD4j0BQKmVYmtiyhpthZP2SWBRg4GWxUrwPtGeuWV01IKIw9MBsmfGWvRB8XRyU88EQCXwKcB+fcDftJ81JTia1JbSmtdXFpIDNzcTfEXgdrERW1HwyQlmlpZF7bsdh5xw6P7NBvNJErvQbrgaSPAB1OAbKqojY9TFUMufTBVN5ucqU0/W8QZ45TAADOFN8jeaVn4nI/2kbqyUjVlsvJ7fa/njB7j5D/j4TZ36ux1PuX4DR8X+qzrsQ/AukP1mJBkqWVDgL9rMK641lpg==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR19MB7577.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab497ef9-86c1-4478-14e9-08dc233c0c34
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2024 15:39:58.9101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rF04W8npVfUxvOEAIeCNkXtaU25F7G0E67F78A2H0sCH7goJBqzWIz2nby2EdeQrHjEBt8UwEsxnc3T4/4Ajkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR19MB4440
X-BESS-ID: 1706802002-102236-12483-3444-1
X-BESS-VER: 2019.1_20240130.2130
X-BESS-Apparent-Source-IP: 104.47.73.41
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVobmBmZAVgZQ0MTSxNjY1MgkyS
	DRxNLc2DI5MdkgzTApKSUl1SDVzNhMqTYWACTbfzRBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.253913 [from 
	cloudscan18-150.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

T24gMi8xLzI0IDE1OjUyLCBNaWtsb3MgU3plcmVkaSB3cm90ZToNCj4gT24gVGh1LCAxIEZlYiAy
MDI0IGF0IDE1OjM2LCBCZXJuZCBTY2h1YmVydCA8YmVybmQuc2NodWJlcnRAZmFzdG1haWwuZm0+
IHdyb3RlOg0KPj4NCj4+DQo+Pg0KPj4gT24gMi8xLzI0IDA5OjQ1LCBNaWtsb3MgU3plcmVkaSB3
cm90ZToNCj4+PiBPbiBUaHUsIDEgRmViIDIwMjQgYXQgMDA6MDksIEJlcm5kIFNjaHViZXJ0IDxi
c2NodWJlcnRAZGRuLmNvbT4gd3JvdGU6DQo+Pj4+DQo+Pj4+IFRoZXJlIHdlcmUgbXVsdGlwbGUg
aXNzdWVzIHdpdGggZGlyZWN0X2lvX2FsbG93X21tYXA6DQo+Pj4+IC0gZnVzZV9saW5rX3dyaXRl
X2ZpbGUoKSB3YXMgbWlzc2luZywgcmVzdWx0aW5nIGluIHdhcm5pbmdzIGluDQo+Pj4+ICAgICBm
dXNlX3dyaXRlX2ZpbGVfZ2V0KCkgYW5kIEVJTyBmcm9tIG1zeW5jKCkNCj4+Pj4gLSAidm1hLT52
bV9vcHMgPSAmZnVzZV9maWxlX3ZtX29wcyIgd2FzIG5vdCBzZXQsIGJ1dCBlc3BlY2lhbGx5DQo+
Pj4+ICAgICBmdXNlX3BhZ2VfbWt3cml0ZSBpcyBuZWVkZWQuDQo+Pj4+DQo+Pj4+IFRoZSBzZW1h
bnRpY3Mgb2YgaW52YWxpZGF0ZV9pbm9kZV9wYWdlczIoKSBpcyBzbyBmYXIgbm90IGNsZWFybHkg
ZGVmaW5lZA0KPj4+PiBpbiBmdXNlX2ZpbGVfbW1hcC4gSXQgZGF0ZXMgYmFjayB0bw0KPj4+PiBj
b21taXQgMzEyMWJmZTc2MzExICgiZnVzZTogZml4ICJkaXJlY3RfaW8iIHByaXZhdGUgbW1hcCIp
DQo+Pj4+IFRob3VnaCwgYXMgZGlyZWN0X2lvX2FsbG93X21tYXAgaXMgYSBuZXcgZmVhdHVyZSwg
dGhhdCB3YXMgZm9yIE1BUF9QUklWQVRFDQo+Pj4+IG9ubHkuIEFzIGludmFsaWRhdGVfaW5vZGVf
cGFnZXMyKCkgaXMgY2FsbGluZyBpbnRvIGZ1c2VfbGF1bmRlcl9mb2xpbygpDQo+Pj4+IGFuZCB3
cml0ZXMgb3V0IGRpcnR5IHBhZ2VzLCBpdCBzaG91bGQgYmUgc2FmZSB0byBjYWxsDQo+Pj4+IGlu
dmFsaWRhdGVfaW5vZGVfcGFnZXMyIGZvciBNQVBfUFJJVkFURSBhbmQgTUFQX1NIQVJFRCBhcyB3
ZWxsLg0KPj4+DQo+Pj4gRGlkIHlvdSB0ZXN0IHdpdGggZnN4ICh2YXJpb3VzIHZlcnNpb25zIGNh
biBiZSBmb3VuZCBpbiBMVFAveGZzdGVzdHMpPw0KPj4+ICAgIEl0J3MgdmVyeSBnb29kIGF0IGZp
bmRpbmcgIG1hcHBlZCB2cy4gbm9uLW1hcHBlZCBidWdzLg0KPj4NCj4+IEkgdGVzdGVkIHdpdGgg
eGZzdGVzdCwgYnV0IG5vdCB3aXRoIGZzeCB5ZXQuIEkgY2FuIGxvb2sgaW50byB0aGF0LiBEbw0K
Pj4geW91IGhhdmUgYnkgYW55IGNoYW5jZSBhbiBleGFjdCBjb21tYW5kIEkgc2hvdWxkIHJ1bj8N
Cj4gDQo+IEp1c3Qgc3BlY2lmeWluZyBhIGZpbGVuYW1lIHNob3VsZCBiZSBnb29kLiAgTWFrZSBz
dXJlIHlvdSB0ZXN0IHdpdGgNCj4gdmFyaW91cyBvcGVuIG1vZGVzLg0KDQoNCg0KZnN4IGltbWVk
aWF0ZWx5IGZhaWxzIGluIEZPUEVOX0RJUkVDVF9JUCBtb2RlICgicGFzc3Rocm91Z2hfaHAgDQot
LWRpcmVjdC1pbyAuLi4iKSBvbiBhbiB1bnBhdGNoZWQga2VybmVsLCBidXQgY29udGludWVzIHRv
IHJ1biBpbiANCnBhdGNoZWQgbW9kZS4NCg0KR2l2ZW4NCi1OIG51bW9wczogdG90YWwgIyBvcGVy
YXRpb25zIHRvIGRvIChkZWZhdWx0IGluZmluaXR5KQ0KDQpIb3cgbG9uZyBkbyB5b3UgdGhpbmsg
SSBzaG91bGQgcnVuIGl0PyBNYXliZSBzb21ldGhpbmcgbGlrZSAzIGhvdXJzIA0KKC0tZHVyYXRp
b249JCgzICogNjAgKiA2MCkpPw0KDQoNClRoYW5rcywNCkJlcm5kDQoNCg==

