Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08BC578EA0B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Aug 2023 12:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239143AbjHaKRs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Aug 2023 06:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjHaKRr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Aug 2023 06:17:47 -0400
Received: from outbound-ip7a.ess.barracuda.com (outbound-ip7a.ess.barracuda.com [209.222.82.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDABCED;
        Thu, 31 Aug 2023 03:17:31 -0700 (PDT)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169]) by mx-outbound9-52.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 31 Aug 2023 10:17:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i/bYJ6QBoAgd9cdIRpZPSqDnlugTdLImZBxgjxCQRGeOKtlx7rPKn6eU/eUHcO+ze+v5v5y7fp+xRyDVadO2tn6G2H65vKudKIWSccFg0NRu/0GmSGrlmcWuMNFe2DtiONZviZImxQbJfRtZEratk0PdwaxyeAz1EKc76FwhjT7Fjnyg/RdexL3ZW5N03WT48XWm/p5qkVCFGKYiBFiIPwdWJlMLDlGRqED04vLTTovDL4O6p5Yt77j34hnw+ZAyMLKjCbVxoyoHPG6dbCDuQsZY78aId6lo5IaCZT1bp6O+Tt31PteZ15GExtsjZ+gIfm5cZpy7za0zB5DLidn2Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p3ib/IbQhiEIhGtNV8WoZeVNiywFeKvZoUuWHHwGmNY=;
 b=mZHfPI7b2SZSOVpn6QVEDEecaWL7Yc4RqR3VPtx1EcAAS9cerf569KAMaha6dkuVzFK1b0ynK5yJzav97g3FyBjo0qn47/pLj0ez9qmLzKnY1gEugTzrNJI58uDCGgBm+GNVxXB38u14nHCglbOaueKaWI21yD7grtaNQRmZwNvm3WTkZaQgJCYOcPv+0sElXG+0T/ix1rmkITz4I4HT8kFK0Pw/ZRSAvc++y0IAi/rWFTBUwdJ7hjEHi/8i5hS/ixdvWtRleS+mQs209UY1m5qajcliyrOzeUCNFKNe7l0fsFi45DmF3Bi+DQ4hZynbtQZAcBfJSwns5nNXmuLO9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p3ib/IbQhiEIhGtNV8WoZeVNiywFeKvZoUuWHHwGmNY=;
 b=iVOcufj9G9NsAI84KMGXdxS7aigDD3pBZYbRoCucNJlX7CHh2U3cFcrAQy0NJ9JT7lNtBlma0NAn8vUWnjbwbMeZInDrh/gC5t4OWumpXP9NVY6SE9vhdst/Yqj+shZ3JmRHQRVl/oEysmhPTn/XZjlP/utIorB3Orvn/N4p+4k=
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com (2603:10b6:4:aa::29)
 by DS0PR19MB7926.namprd19.prod.outlook.com (2603:10b6:8:161::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Thu, 31 Aug
 2023 10:17:14 +0000
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::9fa6:5516:a936:1705]) by DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::9fa6:5516:a936:1705%7]) with mapi id 15.20.6699.035; Thu, 31 Aug 2023
 10:17:14 +0000
From:   Bernd Schubert <bschubert@ddn.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "bernd.schubert@fastmail.fm" <bernd.schubert@fastmail.fm>,
        "miklos@szeredi.hu" <miklos@szeredi.hu>,
        Dharmendra Singh <dsingh@ddn.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH 0/2] Use exclusive lock for file_remove_privs
Thread-Topic: [PATCH 0/2] Use exclusive lock for file_remove_privs
Thread-Index: AQHZ2230jhkpb2NJoEORvp5ugMQH87AEBgqAgAAruQA=
Date:   Thu, 31 Aug 2023 10:17:14 +0000
Message-ID: <3871c47e-14c1-46bf-f31a-4fcd6cd87388@ddn.com>
References: <20230830181519.2964941-1-bschubert@ddn.com>
 <ZPBD/X9IUrz46Sia@infradead.org>
In-Reply-To: <ZPBD/X9IUrz46Sia@infradead.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR1901MB2037:EE_|DS0PR19MB7926:EE_
x-ms-office365-filtering-correlation-id: d07b4e1e-fa9a-443a-ec5a-08dbaa0b7281
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9TwRULT2wnD7rdSn0m+9AP9lFC4YCtxxSTQfafiSby3DzlaKw8A1fqTBOU2V7r9nCb5nZSi56UZGZqO3F2iwjzjJRmF1bJ3z0m5hIHTtG8wl1AR4ZltJShljv8/m2naMdupgSVYho/Lo42049iSqPfa0z4onqagYc3bmIS5jRng7L8UEG7ycyZs41ADQAOjj/kT5qG26dfokyIMxURIoMqbv903P9UmeDD65dF9hZwGzhwWgiSDGZzinmNbLK4btvrCv/DDYR/ypT8fi6DSixfPsbNRn2VJE8x03U7xSox3gqQbf8GJ4khbaSmP01VNUYuLbfHZTnKCOjjEEdLUZTszvAW39e9DTaqdz3ZLxJm94WzQfRU1QG44TwxCe5EztyJHScZK85czV8T1Ii5YxUyXY2nv6klyT29J/6HATnct6MkNaeylDbPSiwHozfGL/G9OAO55xI7B+c+J1IeBv/5Le7cqN3gA4jCDQeyBltJRJHasuJ4vUJnX98G6R5TsjmGaFFOWy6K5McZIWLr+QpbIb8eX8enBYm8WGNSj5RImvKmJQeVeuhFqSky29ZSVCs8tJKyVR1tj8MkIVmPZv+if2OAS74gQ5AGOSE4ZrF9nudbjh+53OO+x7OKeNzXUW9hGgMPV9YSvy1V75K74MDMrv379JDLPwofME9FXGsMkAjOZAF5f6EKLwGVariA+q
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1901MB2037.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(366004)(39850400004)(136003)(186009)(451199024)(1800799009)(36756003)(31686004)(83380400001)(4326008)(53546011)(41300700001)(86362001)(8936002)(5660300002)(31696002)(8676002)(6506007)(6486002)(71200400001)(2616005)(6512007)(38070700005)(478600001)(38100700002)(122000001)(76116006)(91956017)(64756008)(2906002)(66946007)(6916009)(66446008)(66556008)(66476007)(54906003)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d3RhZEhkS2hqY1JsTStMUHBVZU00aWt4Q1dOQXJWWE1YWmxvalVEdVpkejlp?=
 =?utf-8?B?cWpzS0pGRHN1VW1relQ1dDZ3T3o1ZzZIMnZRcS9mRVhBZWg2TzRQM2N3U1ls?=
 =?utf-8?B?bWJONk83ZTl2VERoQXZYdU9EWU9KTnkzQkc5UkJweVBNWFVaZzNZUHVpMG85?=
 =?utf-8?B?aDM4dVo2SjVjRDdrS2d4RWh1eHpUdzFjaWkxWk5CbUtLL1cyRlQvZXNxOUxp?=
 =?utf-8?B?aU5Vd3cwNHlHeG83SC9UbHJNWjREY2gwVnBLclVDWnRnTnBFTUFITUhUOHZp?=
 =?utf-8?B?cThBZDBrcFNZWHovbXUvZG9UTUsxQkpYY2o0Z3VtakpEVWQ1VUovSVpJZXc3?=
 =?utf-8?B?bTVORjdVK01FemM3amlqYlRwa1R3TlJoWWtTbEpsT29hM1I0MmxrWWJBdHh4?=
 =?utf-8?B?d1FxYVk0dlhJM3ZYOGxDUHhEdjNZNi8rT045aWkzN0trNTUrcXhnckFnUjRC?=
 =?utf-8?B?R2o2TGxacE1Xd1Z3eFBGNTJYTGxPbDc1N2dvQ1c4dEI0di9pK1RlTmYwOUxJ?=
 =?utf-8?B?TEhBZ3ZiL1MvS0FEdkcvdmw4SStnL1JHMzdRQi9qdmVGaW9PT1Nza0F6bjNM?=
 =?utf-8?B?S2JhYURPdGVEcTRXV0tBTm5HKzJIb3YyQUgyeEpBeklYMytVR0hUM3NYclVQ?=
 =?utf-8?B?OW9wSkI1Q0xjMHZpcFE1bmNhM2JTQWY1aVlvZERNanFHTERtN2psMmhOckpJ?=
 =?utf-8?B?b01pZTJBWjN4blpxZGQrVG03eW5PYlZ0S245TlV5b1BEbzlVZXQ5bUJhS1FL?=
 =?utf-8?B?Q1diWitQVEhwa2ZOQkJhY2JUSEtSVWNoblVMemlQVmI1aG9KbkxpNjVWaEph?=
 =?utf-8?B?VE1mcnI1OVM0SnkrOGtxUDI3TnVGZ3Bub1pmUHczYmszYWtXcFBYbGkwcGhH?=
 =?utf-8?B?VWxSVTVTU3lHdGtETzA4UVM1Z0FGTTNPVWZyV0hGeVFTNlJsN3VyN1c2S3dn?=
 =?utf-8?B?anB0L0NzTW1iMTkyVUE4MXQyZC9OUXdTcXFUSWJXR1V2V0Y2NXZZeUJhQjNj?=
 =?utf-8?B?WUJkTjA4MTZCdWJIT2NYWDF3ZTVNRXpBN2RBWlMvN3NPYTg0SjQxMEpaRjh3?=
 =?utf-8?B?TnJtOXhML04wTHBYZzBPNmVneTA4YUhhZXhlNjc2MXBIZDc5Wm9NUDBZeHYv?=
 =?utf-8?B?YXc3WWJmWUJDRjlsOVVzdzB6SDdzKzl3M3dNYktHMDJ1YU9RRG51SVN3d0JV?=
 =?utf-8?B?dHNGTWxoamcxN3M5cHFTekR2cE9hZ0p1dTIyQTBwQUpveFhlR2ZxRUVVRTBJ?=
 =?utf-8?B?a0wvMFpmSzJzbU9saHAzV3VzdkQwbHdHVGZSUCtFUTJHZklNU2xFMGtuVW1R?=
 =?utf-8?B?Y3BCWVdoSkV6dzFiWUlaQURXaVNMaUdQMUU4cnk4WGgvb1ZQTmgyblBocTNS?=
 =?utf-8?B?WG5KRmk5TjlBK3QwdTd6UlQycnFWYVFtSUcvR1JyTzBvSit5V0RLZWcrQVRj?=
 =?utf-8?B?NFRSRnZvUWI0M2Vaam1BclRYT3Y1SFRYTkMva0RyTWVXdmdnT0JJeXBkdGRp?=
 =?utf-8?B?Ymk2NXBoRW94RnlGRkpVWk8rTzZvL3l6WS9zbm9WcndlZEttQmtkMkpCV0g5?=
 =?utf-8?B?b09VbzdaOTlGYXRwOUZEWjIzSHBzaDhNblFFUjVBVjV2c2pJVC8rMGZ2WHRU?=
 =?utf-8?B?WGMzUG96S0l1K2NvSGhsZkEwZGQrdUJ4aHlUNFhUbEdFMklmRGZxb0tnQzY3?=
 =?utf-8?B?NWVMS0VxQVI1Tm9OZXJrbGt4KyttNjVMcmJDTTRQRWI1TlRoTUxkVmJ6QTV2?=
 =?utf-8?B?SWdKTm9JQk5rZVRuMHdPWVo3SnpLTVZpa25kSWJkcU1OZDBldjNQOFdQaWtN?=
 =?utf-8?B?a3pkdHlTWU95eWdpWEJRV1ArU0ZaK3NyWkViS2h4eHRnUy9zVUlqb0RTSFJI?=
 =?utf-8?B?MExWUTNEM28yTjBSNW1PYzFNV09NVmxOMldpQXU5MkpXWjJyOVE1ZUI4eHRE?=
 =?utf-8?B?b0JVekFHaElFWGlFSGphZUZ1U0tiYXBNNUl2Sk83ellBQ0pyMDgxaWYwZGpR?=
 =?utf-8?B?S2xmQzNxVldpR2cwb0gzNE1VZy9CUUJhQmFyOFFQbXBwc3V3K0RJdE01UzhK?=
 =?utf-8?B?MEJFR0d0VGtnejQ2d0ppekFVdVh6MFJBQUdNVU1RbWxXQUMyNGVSckJCTFMy?=
 =?utf-8?B?dXNCSTFiMHFyNStqcUdaSG91YUoxUWowN3F0SXpKZUJBTUdPYWJzSURsT3h0?=
 =?utf-8?Q?8MhBCU0ayfnVBc+dhRGHXmk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E2BEB71987647D44B7FB711FDE747CC9@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?b2Zhd0VIWnV0RG9FWEc1RU8vSXRwSWxQN3ZhU1JLbTNZbmloYUJNT3kycW8r?=
 =?utf-8?B?d0NqNjZYc0YvbDcvNkdmdEpRZ2hBNXViTmVURVBVQ0NsSjQ5VVhrNmFhVDVN?=
 =?utf-8?B?UFk2RC9TcGIrM1R3WmRmKzltVFhSQVJPVS92QXMyanhsa3FqQTIyVHVMSzdU?=
 =?utf-8?B?TU9mQXY0RmY3YlB1dnI1VXFwTlltakpDV2VnOTBzN21Wb2k4aWtVdTZRWEQv?=
 =?utf-8?B?Y1Y3dWU5RzQvYTMyTGlITVhRNWxxU3NHZjMyYWlxNVI1V1dYSUlPcldmdEJD?=
 =?utf-8?B?SXFlWm00eGR0a05hcXMyV2UyTUFnWncvbmJIMHYxOG92bC9KQlBlRGNMWHBu?=
 =?utf-8?B?dzEzempLa0xZRnJWTmdXclhvNndlR2FNOGJTd0M3NTdoNWZsN1R0TlZjSVZW?=
 =?utf-8?B?QVRxcGIxQlBCakEzb3FPR0FlVFZ6WCt6dzFoQ1c0WlFpUjJWbjV1ekNSZ3dD?=
 =?utf-8?B?T1IyN0pFOEtwYys1WGF6QStMemhhVkpOTG1mczY2S1JLRTZPY0hRTXpaSWhD?=
 =?utf-8?B?TEtvT3dvODY5VTdrQXhGdCtvT1JYdDUzeEo1NXFzOE1kNTdTSHY4SG9weFQ4?=
 =?utf-8?B?UlIweHptam1wZWwzRnU1SUVLcCtGODducmdDRXJtWnN6cFFJck5QQUVUTjZo?=
 =?utf-8?B?UWV1MXNyb3M4dzZBVzJ2OHpZSEdnNUJiM2g2cWZab2kwSURBMzFYL3EvRlF1?=
 =?utf-8?B?SUlhVytFbzlxVDFOYU5Nb3ZWZ1BTNVNJQnRtSlBSQTdabkRIS2s2U3EzcmhF?=
 =?utf-8?B?T0ZRR1U2MmdLZ2U4K1Z0U2F3VUhRRzFzbzM0clF2cVBadWZJV2RucUh6TnpM?=
 =?utf-8?B?a2FFMVhsRmxseURGajJCQm5mdVlweUFiK1diaFk2QkN0R0RRSWdDQ2FUMUdN?=
 =?utf-8?B?UmRqNUZrN01Fc1A5RWUrTm5RS1VBZ2Z0bVdnRFIzUitJa0NyMWIvQVhVNFZH?=
 =?utf-8?B?VXVkVVZYalpnUjhUcVpXVW91cjhDdkV4VUV5SktIdGVobnJmOFNlcmpNNW1K?=
 =?utf-8?B?emZKWDZ0Q01EUHEwb2pRUWRTdjFkWmZEbmRHY1VVMEVhRzNTSXcwYlR3M1Ez?=
 =?utf-8?B?RGYvKzg4eDAvSlFEZml2MWc1d1c4VlJuWmJyZzdyc1A1c1g0MEJzWnl5OUVa?=
 =?utf-8?B?RnpLcGliR0VwN3E4ZlQrOFh0NituQTRYSXQ5OFdON3ZncmoybWorQUdjalUv?=
 =?utf-8?B?anY2WVZ4OTFDQmlmUTRiSitFNThEcGJkOEJZc0UvU0QvVU9jSDM0aDQxMms1?=
 =?utf-8?B?S29JZHM5NzEvVnBBV3l1ZGR0UjhYUGI2UGNZWVpmbDdhWjlZQWwxNlY0aEtn?=
 =?utf-8?B?dEhmdWl5VU90Q0xQTnE2bkJ1aldTR0tMWm1IQ3pVZld6cmR1NmZCamNNYjhK?=
 =?utf-8?B?VXRwRHlEdHFOd0E9PQ==?=
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1901MB2037.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d07b4e1e-fa9a-443a-ec5a-08dbaa0b7281
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2023 10:17:14.5504
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kWXJYcpFNjvmDO3qqVFLisMXGp6iPayprZxSnjeDcKBEyr7SXIe8E/COHwYiH/783t+7mhweB5R7EVRa2QZtSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR19MB7926
X-BESS-ID: 1693477038-102356-7594-14959-1
X-BESS-VER: 2019.1_20230830.2058
X-BESS-Apparent-Source-IP: 104.47.58.169
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoZGBgZAVgZQ0NAyxcgoNdE8KT
        XV3DDFwNAy1czQ0jAt0cDc1DLJKDVVqTYWAInDDpxBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.250512 [from 
        cloudscan8-246.us-east-2a.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gOC8zMS8yMyAwOTo0MCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IE9uIFdlZCwgQXVn
IDMwLCAyMDIzIGF0IDA4OjE1OjE3UE0gKzAyMDAsIEJlcm5kIFNjaHViZXJ0IHdyb3RlOg0KPj4g
V2hpbGUgYWRkaW5nIHNoYXJlZCBkaXJlY3QgSU8gd3JpdGUgbG9ja3MgdG8gZnVzZSBNaWtsb3Mg
bm90aWNlZA0KPj4gdGhhdCBmaWxlX3JlbW92ZV9wcml2cygpIG5lZWRzIGFuIGV4Y2x1c2l2ZSBs
b2NrLiBJIHRoZW4NCj4+IG5vdGljZWQgdGhhdCBidHJmcyBhY3R1YWxseSBoYXMgdGhlIHNhbWUg
aXNzdWUgYXMgSSBoYWQgaW4gbXkgcGF0Y2gsDQo+PiBpdCB3YXMgY2FsbGluZyBpbnRvIHRoYXQg
ZnVuY3Rpb24gd2l0aCBhIHNoYXJlZCBsb2NrLg0KPj4gVGhpcyBzZXJpZXMgYWRkcyBhIG5ldyBl
eHBvcnRlZCBmdW5jdGlvbiBmaWxlX25lZWRzX3JlbW92ZV9wcml2cygpLA0KPj4gd2hpY2ggdXNl
ZCBieSB0aGUgZm9sbG93IHVwIGJ0cmZzIHBhdGNoIGFuZCB3aWxsIGJlIHVzZWQgYnkgdGhlDQo+
PiBESU8gY29kZSBwYXRoIGluIGZ1c2UgYXMgd2VsbC4gSWYgdGhhdCBmdW5jdGlvbiByZXR1cm5z
IGFueSBtYXNrDQo+PiB0aGUgc2hhcmVkIGxvY2sgbmVlZHMgdG8gYmUgZHJvcHBlZCBhbmQgcmVw
bGFjZWQgYnkgdGhlIGV4Y2x1c2l2ZQ0KPj4gdmFyaWFudC4NCj4gDQo+IEZZSSwgeGZzIGFuZCBl
eHQ0IHVzZSBhIHNpbXBsZSBJU19OT1NFQyBjaGVjayBmb3IgdGhpcy4gIFRoYXQgaGFzDQo+IGEg
bG90IG1vcmUgZmFsc2UgcG9zaXRpdmVzLCBidXQgYWxzbyBpcyBhIG11Y2ggZmFzdGVyIGNoZWNr
IGluIHRoZQ0KPiBmYXN0IHBhdGguICAgSXQgbWlnaHQgYmUgd29ydGggYmVuY2htYXJraW5nIHdo
aWNoIHdheSB0byBnbywgYnV0DQo+IHdlIHNob3VsZCBiZSBjb25zaXN0ZW50IGFjcm9zcyBmaWxl
IHN5c3RlbXMgZm9yIHRoZSBiZWhhdmlvci4NCj4gDQoNClRoYW5rcywgaW50ZXJlc3RpbmchIEl0
IGlzIGJhc2ljYWxseSB0aGUgc2FtZSBhcyBteSANCmZpbGVfbmVlZHNfcmVtb3ZlX3ByaXZzLCBh
cyBsb25nIGFzIElTX05PU0VDIGlzIHNldC4gSSBjYW4gcmVtb3ZlIHRoZSANCm5ldyBmdW5jdGlv
biBhbmQgZXhwb3J0IGFuZCB0byBjaGFuZ2UgdG8gdGhhdCBjaGVjay4NCk5vdCBzdXJlIGlmIGl0
IGlzIHRoYXQgbXVjaCBmYXN0ZXIsIGJ1dCBzaG91bGQga2VlcCB0aGUga2VybmVsIGEgYml0IA0K
c21hbGxlci4NCg0KDQpUaGFua3MsDQpCZXJuZA0K
