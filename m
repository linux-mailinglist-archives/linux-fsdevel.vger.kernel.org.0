Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 368227B5D43
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Oct 2023 00:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235895AbjJBWnI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 18:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235711AbjJBWnG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 18:43:06 -0400
Received: from outbound-ip7a.ess.barracuda.com (outbound-ip7a.ess.barracuda.com [209.222.82.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B66F91
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Oct 2023 15:42:57 -0700 (PDT)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174]) by mx-outbound41-2.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 02 Oct 2023 22:42:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YgNsQu9gMBGx8EEh3eG/kpRgJ7LOi7aMTBQRww9oVLG5rwQGc9gzOwou/OVFTLQvN0KDKf1RaNLgR8V7UsBNIZrOMyS8eZha6HzVsY1PRpog6GMoILuWSNbMsB62DEH4GsiuhJL6dJ8wIC0YNHPzEpVEsqY2XPPYRISYetX2DcFksnkzVIH9i/Dg0VZlmwePE1FwfkSzND4RlXXQWKqa/HwIYZAR/hRTLBmxLuodcOoLeSuGnij3a/h9NO1dRl3lpjy3ogUb5P5mBQPVEJohDxmygnzCXR8EISmHHM/BKRHyrBCPXojEIKL8gVgixrKN2S67vnpbzTr/7gXMtj3zzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BlHJoVW5v7WOpVpI1RPjNwEwdGZR/OME+co47CAIzsg=;
 b=UZbFnTd3DnXLDzCS9kAzflnkc1Ek41kNMrCpt8f3k9x1uOdRSdNQjCGaxnmHojuWoCxZR4gKxMcZR9pYk9y7Uoza+TCs4mcTKCFbNaE1Y0nUI0B5UsNVLYBFfIFX55TS/Y0aB5toXpESjiI7gpAt48aaezokD5loRaL2Dz/7onYapHh6NfcWnfQC6/TmEmdGcUrcgE979ohtruEIkhvUYyyi5HiaUDKNt3tXAO53t2+vsIGVr9sm/y5GRNgCkJPP4Pm3YctvlEzk/qnV1NiI+bJth+ILhvsSL9aNNB+6l7aF2BkNKQVzEqYUOESLZ9Ky1Z32mHBMRN+6OsSzSGvgaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BlHJoVW5v7WOpVpI1RPjNwEwdGZR/OME+co47CAIzsg=;
 b=oHJcEtA+wsjZUtUTaAKUU+/OhQEiwKYdWL+GjVWs2TL1OhB2EivOcWJ+6a52OvG3saMn1LOWYXDJns0U/yzMvtMRQFz6uSaGJVQarUQhJYJVHIStrm6dWKuKGxIIZYBrHYq++wjwDx+Tdn4ekikP9GD+LfjGTc/NMaDIPdC+tR8=
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com (2603:10b6:4:aa::29)
 by SJ2PR19MB8228.namprd19.prod.outlook.com (2603:10b6:a03:55d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Mon, 2 Oct
 2023 22:42:39 +0000
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::b051:b4e4:8a2:33a2]) by DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::b051:b4e4:8a2:33a2%5]) with mapi id 15.20.6838.029; Mon, 2 Oct 2023
 22:42:38 +0000
From:   Bernd Schubert <bschubert@ddn.com>
To:     Yuan Yao <yuanyaogoog@chromium.org>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "bernd.schubert@fastmail.fm" <bernd.schubert@fastmail.fm>,
        "miklos@szeredi.hu" <miklos@szeredi.hu>,
        Dharmendra Singh <dsingh@ddn.com>,
        Horst Birthelmer <hbirthelmer@ddn.com>,
        Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v9 2/7] fuse: introduce atomic open
Thread-Topic: [PATCH v9 2/7] fuse: introduce atomic open
Thread-Index: AQHZ6+jHdF1yb4Zlj0OWK0En5/C5P7A1z7oAgAFb8QA=
Date:   Mon, 2 Oct 2023 22:42:38 +0000
Message-ID: <db0cb59d-66b8-480c-abd4-0bb235d68908@ddn.com>
References: <20230920173445.3943581-1-bschubert@ddn.com>
 <20230920173445.3943581-3-bschubert@ddn.com>
 <7616CA3C-312F-4F9F-9BB3-903D3A77289B@chromium.org>
In-Reply-To: <7616CA3C-312F-4F9F-9BB3-903D3A77289B@chromium.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR1901MB2037:EE_|SJ2PR19MB8228:EE_
x-ms-office365-filtering-correlation-id: e97fb788-4bf9-4e94-75d6-08dbc398e17e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hCvccM4uMbnhevtSicZnhRB9rJTQpY4IrcTPkGWtDt5TxTpPu0jch7L8yYxkxQu8BDjxclraeGMdjTRde5EhYSR2Otr7005+A5qUfMIg07YiWOSOcwL8E909vMT5meA84GBoaMH1RfRCqSmw0tZQaeb57hR+pfxzLAu6SwPqpUWh8Lokx4ydPcqAewDjGc0U2TviD7QPXEs01E016s8neHYfqYjsfndWCPFO5pDN4kT4l6cdjKulmPhaR6v+G9cKM6YNo8yv3iQ7POmEtMYA5MBHng4t+cAsJ5z6/WyEeTuzEARsw/Mkmg4HHG4rzGI+e7sPd9RrUfxeQEG7ucLAA5/vwgEhm6Ttvn+B8u3mGh+O8KKWF9YFgR8PVORTPmiUdQjKWnCMkq4MIc9WxEZw1u+Kk9j16PdNTSe00vvLwo1sjMz8G0Jc0hC0/RjtKgh3GdzTEqyeAhjZvJ/qUtAatfUKYlYw4BLozxLog/EbNgq30M5TxPkEEluwSjqoRQfJwkwtMh0S1rjd42D7sQmdMHVX8daEKu8FxSbtaRBhgIbxNR6nzfp36TOs9Om9Ub7Z1aQ8QHankHTvGb0h40QJJYdxSmJoLrpixsSy34ApWqtvPQ8RhH2LbKQdJlqNhl+rXZtukn1ERGPR9Ro9zU/x4GyOHQlR7SBSzVgcRu93mi4Wtg5bqQRzIBnlZLWUjYcx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1901MB2037.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(396003)(376002)(346002)(136003)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(2906002)(31686004)(5660300002)(8936002)(4326008)(36756003)(8676002)(2616005)(41300700001)(76116006)(64756008)(66446008)(66556008)(66946007)(66476007)(54906003)(6916009)(478600001)(316002)(91956017)(6506007)(71200400001)(86362001)(6486002)(83380400001)(53546011)(38070700005)(122000001)(31696002)(38100700002)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OEtiZW9pL2lpRUV2SWhrS1h3SjQ1ZmRRSllyVEJ6N3Z4Rjk0L2F0T3gvMFM2?=
 =?utf-8?B?UzBCVFB3cWpJM0hJRkt1dXJveitWOXBzSVNHVWZWRTJNVHVsMk16dXZVeHZ6?=
 =?utf-8?B?K1gvUllJdGVROXp5N3lCS0l5ZXpMcERVWHl6V2xJMEhZQXVpb0dlT0M0MWZz?=
 =?utf-8?B?ZlRBSFYwbWxhM2RhM2pLK3NZdFFndXY4N1l2K1Z2a0hOdTR2Mno2dTBmMCtN?=
 =?utf-8?B?OVEya2NLUFYwRm1ibFZrWEpLQTRXZ1hkSE5JeURXTjBEdHN5UVdLU0RpdTNp?=
 =?utf-8?B?RzJSaDNSQ0dIWjMvTmo3ZnBSYlNMM3dkOVc3ck1qQm5seUdXemJBNldDaG0z?=
 =?utf-8?B?eWFwNGFrN2kvNUY2di9yWUE3d1U3a3JtWkltSFp6TWl0NTFvQjRmZnc2bUEr?=
 =?utf-8?B?V3ZFVnFGQmJkSlVIV0xVZ1lWdXlqd3pXOTBJeTlTY3dabmxyL2ozSXZvY0Jr?=
 =?utf-8?B?WDhLUTA0V2tlUXJRekxuUnY1bVk0T2pZSDVBOTN0NjMrRXRwdkl2WUVTUzIz?=
 =?utf-8?B?VmRybC9ISG1WL25FbFVscG5qMU96ZUVSQ01zOHR1d2hieXZXaWhzY1Iyd1Ns?=
 =?utf-8?B?dE9XbCsrbENCWDVQcnlTR1F2NFcwY0NtMmVmZGx3bEl1aG5LdDVlMG9FV0Fr?=
 =?utf-8?B?Y29uaFZORDZWNWVTUFFFVkxwQjU5bWtJWHphOVE1RzFBa3hvUlpDWG5Iblow?=
 =?utf-8?B?dm01U1dEVVBvem13SUZUY00rZEJrT09WS01qMjBoQUJraUV2RzBkSUJVa0FF?=
 =?utf-8?B?OThXVFd2THhLbURFRnhWY2cyeHFNWXJmeFhNd3QxUkk2VlZ3VnowWlU3SkxH?=
 =?utf-8?B?aEh6Tll1aC95OUg1Y0hSWDloTkY2M3c0ekwvalJQQ1d0TWpGa09oVmY0N09O?=
 =?utf-8?B?YWJvdlphZlRuWFIrandhdXVlUkFMays4YUJCcG9XK0VrcVU4QkQwVmlqU0Y4?=
 =?utf-8?B?eDMreDVvbWlZMWNOb2NBaGtaSm9QWTNWN3ljNmRYckJXbk9ka2FqUHdjK2hs?=
 =?utf-8?B?U1I0Uy9XVEhIZzk3WGhSYUlIWlF5bUtzSmZDMWFaZ2Q1bUtsdDdrNUtFYjRn?=
 =?utf-8?B?RElzUXFreC9zUHdRbTNCN21GckxyWWFnT1NQWk1wemRHcUhNMWt5T01uME51?=
 =?utf-8?B?VHk4aU9sRVBsbUZNeVVYWDJ4dkxYazM1Q3JYRFFlb1BIV3ZEMmNZSVR0ZUls?=
 =?utf-8?B?SFh1dmRSMzdHZURzSERMM2VBS0RHeTlmbExwVkxrZ0p5MEtmTE9SUy83bk1S?=
 =?utf-8?B?ZzJaU21EV2hoWkQrWCtpNnkzalRES1JhUC9JcUFqME53OGJ0Z0xKM25IcXZh?=
 =?utf-8?B?aGJyNjhuS1haN2VKeE1EQVg5c1FuK1QzR0hCcXBRN0pBZC9NSHplOFh2RUpt?=
 =?utf-8?B?RTM3cDAwQmIzZXB0azV6Wit4NHg0Um9oUDFyRWFHQVdhWmtBMThSZXp1SEZS?=
 =?utf-8?B?RmlHTnJNMlVZSWhVYTBwQVZ4dVdPTWhsa21maktNZ29PUUsvdzBXOTI1RE9Y?=
 =?utf-8?B?eU5pbVVvSnpKUEticzZrbmtsY3lnMTZ6M2hHM0RZS0IxQzFxMGFQYmM5dGZV?=
 =?utf-8?B?ZEg5UDQ3RjFPU05nSE1iSEM5bjJERDlNL0RIYmtLeUJWdTVML1JGQmM2NWV5?=
 =?utf-8?B?emlGcEFhQWMzaVZuVkZKTGhRaTF5WlFsdUIrYTFCa0JEbzZET2c3YWlFeTJE?=
 =?utf-8?B?K2dCcldXRmh1cjZQWndFb1p2VFp0VTAxbnppdE5hd2FXRkRCMmdkU1VTZ0dv?=
 =?utf-8?B?b1YzUW9XYWpuNGlsdWYvNG5zVjhLWUt1ZlFXcWlJdzFNVVBoMTg4Q2JYMkJi?=
 =?utf-8?B?eXVVM3Nlb3d0YkYvU1lSZFFqZnlIakhBV3p4WmlNMW51bk9OTXpKRmVhNzF4?=
 =?utf-8?B?QjNFSHczdlIvUmEvV1lTV256cUk1TjQ3cjlNRW9HMkRjNVJ2aXk0aWVhN2pU?=
 =?utf-8?B?L0pYakpHZzk4cis0K0ZpTDJHTnhGQklsK2VOMDdOZmJQaUhiREEwZjYzcHIy?=
 =?utf-8?B?WXFsV3JpTlYzWnkyTGhZa25qS1ZkMTRiTlVXQWtIbTU1Vnk2OUN2Q08reTlG?=
 =?utf-8?B?ZnBaVzEwcHRWaEN4bit3cE5EOHB4bC93WnZQbUZOamNZc25wSUtiUTZBa3JY?=
 =?utf-8?B?cjhpYWJ4VUdKSkF2MmtsWlpwTlhsRkY0UFRtbzk2TmlnbzMxVmtsSzcyaklB?=
 =?utf-8?Q?O+L/RBZAqH6roNssvMUoxYE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2633C7D03117094096FCFD81D8E511AB@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Wmc5TFMwSGJ4S1pNb0ZnOXptSlpRRDFVenFpa2g0bEo5bzRaZXMvcTBQb2Zo?=
 =?utf-8?B?VFZ6UHJtajI1dFUzVnFOcFpOcGE5cDN2Z2ZnQUdVYlVCQXFzeDE3bXYwREZ6?=
 =?utf-8?B?SVdKZjdQUVIvL3dteUl2UmtrREhmYWVLVGYwbi9sbzU3MkFYTGJ5WlRiSTY3?=
 =?utf-8?B?bWx1Rk1aS1o3MEl6WE9wQVNuTVA3TWloUnNyeTl0YnRmUHVxRytPUi9zMVJT?=
 =?utf-8?B?dWsvNzNCalNHTWF0UkJLbnhQeGExcG9ZWSt4em9WQlFIK3ZpT3ZMbmFqMzR6?=
 =?utf-8?B?VS95VnlzUXBLWXFOandDeWttRmU0UmFiMkNQTTczM1J1WGkzY0pMUGNHUm4r?=
 =?utf-8?B?dFBhaUdRRzBwZ0x4NFdEMWh5dm5EcFF6ZTAxMjFJazBlWHkxU1BycDZLaE9u?=
 =?utf-8?B?T1JGTUY0UzN3d0N5d01Tb2JoVEFFYmluSXR5cXp6Rno0ZVVVNThRRDRkQnlv?=
 =?utf-8?B?NWdlZWxjbU5wNUJOeDROblBFMXBLdlIxRmlhVTVTeU0rbXlRR3Uzbnl0dGdt?=
 =?utf-8?B?U3VsN3ZpK0VkbmZTMTdRZjl4bnd1N2g5SldXSkQ2eWhDM3RqZU9wNVFqUEUz?=
 =?utf-8?B?VGFkaWwwQkVuejY0MUpraXM4am5vc0VhNEZJYkpSeURuL2RlL0kxYTNER2p4?=
 =?utf-8?B?cnpOWThzV0cxK1dxQ1NtUGRobFgyRTFkV3JWOWlpdWJhLzRBajhkRHpTVDg4?=
 =?utf-8?B?UE1EZGlYdHFYUDI0YzBLSzdDcThhdkdESkxNY0tZYTVhUllNWXVPNDh1Ynpu?=
 =?utf-8?B?MUViQU9YSjJNdjV2Qjg2SGxaZHU0ZUNUNXRQZzJ1VmRraHdYem1xWVNyaExt?=
 =?utf-8?B?MHhRUVJIY1NEUE55UTR3ZjQraTJ0YW1ONzZUMDBzdXFNbWtza3QxOHF3UUhF?=
 =?utf-8?B?UkRkQkJGTnlPTmpxSzNMWGhaNHRNNGZqSlhsNDVFUGVZcFhTYXlXODJxWS93?=
 =?utf-8?B?Yms0dDRJbndPRjZ2K0RoNFFaVjROK1duR1pEdGNZWEZVYURXcnZZUjZic1lM?=
 =?utf-8?B?eVFzM284QU1JVkthUmVURHoyS29kUjMvSWlWVytoL0Y0NVJiRDZJeTE3MWNx?=
 =?utf-8?B?SUVzYVRhdDZnbnZRRmpMVDd1ak1OU3p3VHA3WTNUY2VpbnliNzE0NUQvOFlE?=
 =?utf-8?B?MTQ1ZVJCMnFHTW9CeU1CeXY2UmdnaUlXKzVEd0NSMXhzamhwbXJlSHp6cDNO?=
 =?utf-8?B?SWgxM0RRV1lueld0Q3Y2WTFweklGV2czZjhEY1dWdzROUFlqalBGUStIUGdn?=
 =?utf-8?B?bFdzM0NQQzVsVDRycThELzBsNDdTSmtlQkxrVUlSbDVuSGFxcmtnVnNyb0Ry?=
 =?utf-8?Q?dYE6SetMyLkJ0=3D?=
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1901MB2037.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e97fb788-4bf9-4e94-75d6-08dbc398e17e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2023 22:42:38.8483
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CK9sdOcAobauV1YFovKiHepRWB6DEzcUGir6bIAVqKMBDF7Chffb/u5L8+iUA+GzmZ3QKfK1hfR6FO9BxLdPvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR19MB8228
X-BESS-ID: 1696286563-110498-12424-4531-1
X-BESS-VER: 2019.1_20230712.1926
X-BESS-Apparent-Source-IP: 104.47.57.174
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVobGZhZAVgZQ0CzRNNXY0DQ5xd
        QwxdjYPNEkKdnQPNnI0CjNwNjC1MJUqTYWADS2JhlBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.251235 [from 
        cloudscan11-173.us-east-2a.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMTAvMi8yMyAwMzo1NywgWXVhbiBZYW8gd3JvdGU6DQo+IEhpLCBJ4oCZbSBZdWFuLCBwYXJ0
aWN1bGFybHkgaW50ZXJlc3RlZCBpbiB0aGlzIHBhdGNoIHNldCwgYW5kIEkndmUgDQo+IG5vdGlj
ZWQgc29tZSBhbWJpZ3VpdHkgcmVnYXJkaW5nIHRoZSBiZWhhdmlvciBvZiBhdG9taWNfb3BlbiBm
b3IgDQo+IHN5bWJvbGljIGxpbmtzLg0KPiANCj4gDQo+IEkgdGhpbmsgdGhpcyBwYXJ0IG1heSBj
YXVzZSBhIHByb2JsZW0gaWYgd2UgYXRvbWljX29wZW4gYSBzeW1ib2xpYyANCj4gbGluay5UaGUg
cHJldmlvdXMgYmVoYXZpb3IgZm9yIGZ1c2VfY3JlYXRlX29wZW4oKSB3aWxsIG9ubHkgZG8gbG9v
a3VwIA0KPiBidXQgbm90IG9wZW4gdGhlIHN5bWJvbGljIGxpbmsuIEJ1dCwgd2l0aCB0aGUgZnVs
bCBhdG9taWMgb3BlbiBrZXJuZWwgDQo+IHBhdGNoLiBNeSB1bmRlcnN0YW5kaW5nIGlzIHRoYXQg
d2hlbiB0aGUga2VybmVsIHBlcmZvcm1zIGFuIGF0b21pY19vcGVuIA0KPiBvcGVyYXRpb24gb24g
YSBzeW1ib2xpYyBsaW5rLCB0aGUgZGVudHJ5IHJldHVybmVkIGZyb20gdGhlIEZVU0Ugc2VydmVy
IA0KPiBjb250YWlucyB0aGUgaW5vZGUgcG9pbnRpbmcgdG8gdGhlIG9wZW5lZCBzeW1ib2xpYyBs
aW5rLiBIb3dldmVyLCBhZnRlciANCj4gYXRvbWljX29wZW4oKSBpcyBjYWxsZWQsIHRoZSBtYXlf
b3BlbigpIGZ1bmN0aW9uIGluIG5hbWVpLmMgY2hlY2tzIHRoZSANCj4gbm9kZSdzIGlfbW9kZSBh
bmQgaWRlbnRpZmllcyBpdCBhcyBhIHN5bWJvbGljIGxpbmssIHJlc3VsdGluZyBpbiBhbiANCj4g
RUxPT1AgZXJyb3IuDQoNCg0KVGhhbmtzIGZvciB0ZXN0aW5nIGl0LCBJIGRpZG4ndCBtYW5hZ2Ug
dG8gbG9vayBpbnRvIGl0IHlldCwgYnV0IHdpbGwgZm9yIA0Kc3VyZSBkbyBkdXJpbmcgdGhlIG5l
eHQgZGF5cyAoSSBob3BlIHRvbW9ycm93KS4NCg0KPiANCj4gDQo+IE15IGNvbmNlcm5uIGlzOiB3
aGF0IGlzIHRoZSBleHBlY3RlZCBiZWhhdmlvciBmb3Igb3BlbmluZyBhIHN5bWJvbGljIA0KPiBs
aW5rLCBib3RoIG9uIHRoZSBrZXJuZWwgc2lkZSBhbmQgdGhlIHNlcnZlciBzaWRlPyBJcyBpdCBw
b3NzaWJsZSBmb3IgDQo+IHRoZSBmdXNlIHNlcnZlciB0byByZXR1cm4gdGhlIGRlbnRyeSBjb250
YWluaW5nIHRoZSBpbm9kZSBvZiB0aGUgbGluayANCj4gZGVzdGluYXRpb24gaW5zdGVhZCBvZiB0
aGUgaW5vZGUgb2YgdGhlIHN5bWJvbGljIGxpbmsgaXRzZWxmPw0KDQpuZnNfYXRvbWljX29wZW4g
aGFuZGxlcyAtRUxPT1AuIFBvc3NpYmx5IGZ1c2Ugc2VydmVyIG5lZWRzIHRvIGNoZWNrIGZvciAN
Ck9fTk9GT0xMT1csIGJ1dCBJJ20gbm90IHN1cmUuIFdpbGwgbG9vayBpbnRvIHRoYXQgaW4gdGhl
IG1vcm5pbmcuDQoNCg0KDQoNClRoYW5rcywNCkJlcm5kDQo=
