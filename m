Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3008A706425
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 May 2023 11:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjEQJ31 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 May 2023 05:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbjEQJ3Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 May 2023 05:29:16 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2116.outbound.protection.outlook.com [40.107.113.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5845C4495;
        Wed, 17 May 2023 02:29:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jg6DTMWXlNAQHltqrGfTaMu5jcRnfstgYcHQy4yxOGgUXkKxIvYMJe7sK0F0H/owHURdGeogn8vnUMfERrR2AWloODyvnEZ6fRQw2MktklVR9alC7fthH8XvCskq3a2NUuLT9OGppFqty8E4fcqRK2BPnGsm1YdZZshyWYWP5wsWHuWjWCUOTO1Soe8Fe1E3TmmPIQwUs8MJfV6lyv6H/fS5VXIEnM1Q4U6Rh58wbYfTmWroxhNgSLBlvLJhg6l6nU+feXFF2H95yAaRKQfYyY+2dRmn2Pnfj87LNjD8UMSTecMH5/5Gjr9KWjQOfIPj/rZhTBOaLV/NanEMr67Sjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cuLv6j7wk39XhenHL88l09qh9aj1O3u+D6iHvBqwsN4=;
 b=aAdQwqAtt4bUtpjQiW5a7RBG2i9NJwoG1i3VyidtqUZXBl+KXfCTiBXdmfkVrqwJZAQDJDtIv/mwRa5R3bOmsklsdlKIVs1LpB4K0ya/j39T+183HEgM5ScbwCHhSsQmtS5628JZ9pRO85d5eNFCuRVSaxPSEs8dfVaOY18wJFq0JxYB67mKpmFtAx74SImKDeS2Lm83fQqaEdVP/a1BeIQ/jK1R7SebwgcV/mps9wZ2YmyWsMIt0UDd6MrOH/EkMxL1eSxJ3vwoznsuBH1/DdBqvkOdd1DAbAx800K8Rp7xUtkBBao475gkCkN1djwRZmZJw/7r7Rm5wsXeytz6qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cuLv6j7wk39XhenHL88l09qh9aj1O3u+D6iHvBqwsN4=;
 b=hlibN1YaqLHmpmtMx4y76Q2+EMgaA/lPjmC9q0NB60/ozCPwzCH4Eg35/ypZIapy/IugeRW86THGtayugv8JJvMxjpj/JuBd9j4j5IHWgH3lEr6AwzeB1p+Lar4XWwrjf2emGpg+A29qa2K3UGwa8gpfYRiEgZqwV67tWWzGWCY=
Received: from OSAPR01MB1843.jpnprd01.prod.outlook.com (2603:1096:603:2b::11)
 by OSZPR01MB9486.jpnprd01.prod.outlook.com (2603:1096:604:1d2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.34; Wed, 17 May
 2023 09:29:03 +0000
Received: from OSAPR01MB1843.jpnprd01.prod.outlook.com
 ([fe80::67c5:5f6b:4c13:64a4]) by OSAPR01MB1843.jpnprd01.prod.outlook.com
 ([fe80::67c5:5f6b:4c13:64a4%3]) with mapi id 15.20.6387.034; Wed, 17 May 2023
 09:29:02 +0000
From:   Ondrej Valousek <ondrej.valousek.xm@renesas.com>
To:     Christian Brauner <brauner@kernel.org>,
        Jeff Layton <jlayton@kernel.org>
CC:     "trondmy@hammerspace.com" <trondmy@hammerspace.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: A pass-through support for NFSv4 style ACL
Thread-Topic: A pass-through support for NFSv4 style ACL
Thread-Index: AQHZiDgRL/8V1539UEOAlA+RtK3rRq9daJoAgACtXICAABnLwA==
Date:   Wed, 17 May 2023 09:29:02 +0000
Message-ID: <OSAPR01MB1843FD2B9710E89BDC1A72B3D97E9@OSAPR01MB1843.jpnprd01.prod.outlook.com>
References: <20230516124655.82283-1-jlayton@kernel.org>
 <20230516-notorisch-geblickt-6b591fbd77c1@brauner>
 <TYXPR01MB18549D3A5B0BE777D7F6B284D9799@TYXPR01MB1854.jpnprd01.prod.outlook.com>
 <cc4317d9cb8f10aa0b3750bdb6db8b4e77ff26f8.camel@kernel.org>
 <20230517-herstellen-zitat-21eeccd36558@brauner>
In-Reply-To: <20230517-herstellen-zitat-21eeccd36558@brauner>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSAPR01MB1843:EE_|OSZPR01MB9486:EE_
x-ms-office365-filtering-correlation-id: 3b60e7b2-b0f3-4574-1e85-08db56b926ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6ZaOOSg2ie1jlOvcoqidugO46Z81oVVEFZtfksrsBMPQ5xssx45XgSi9grfwQBfMuK+s1h5vmgnCrafu+tkh+ITo2qpqUHp5WyXNYqkqKju2de483mRcXUu3XgGMPNDO35R/ldpSCz55613oOleVduERRAhssZ25kpJFoaUypmk2cMugBd+ATz9nIU0laMl7WHbwkFg8C57ZN4F+knwCaXS452VZIVMJfFF1JOGXTpoDKqfZxzpE3catDQryhl0BSoflQW7V0c0eWxpsZiZH+hj/kCo3TUcqMTvNuyIde1pSUdeUNpzY3OTxE+Ej73VF6+5FRhh1pKqRcXjG5K88v8hNFAsIXR2g7wd9I+vg6PvMdMOAmZm5Pbb/2P5dGZyxhams0/fzcHxbnRJ6NhMiSWCH4ahOAJoQBxbPT90iw6fipsHrndi2CjCLDQzUHRLUcTFTmCtep0GTC91vPxg5SFW9Wh7YXpoy5sYs/QYvMAaq2dyNB8RUaarwq3dm+yQPtEenMgSJwfCuxxDyMSEsq1s+1R77R+LTt2zoJE04GC8CZFfyi/aKoW7rqbwffVEKWIn96BXqvejE4L/56rKCotzF8UI0oQC2j/0XyvEvJEM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB1843.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(396003)(376002)(346002)(39860400002)(451199021)(71200400001)(38070700005)(66446008)(66476007)(478600001)(110136005)(76116006)(54906003)(64756008)(66556008)(66946007)(7696005)(966005)(55016003)(86362001)(4326008)(316002)(186003)(6506007)(122000001)(38100700002)(5660300002)(52536014)(2906002)(41300700001)(8676002)(8936002)(83380400001)(26005)(33656002)(53546011)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YlF6cWNpK0xqWnhQWGVQWlRFdnlSOVk5aHVMTDN1UUdzY0hIL0hPZ3NmaHlJ?=
 =?utf-8?B?L3hPUnYybVFvaWFRa25vOXBEM3JkcTdBSnM4bGkzd0Z5RXVtRk54OUNLeUdy?=
 =?utf-8?B?T3ZmS005V3YzeXRSbk0vMzVQMzc5L2Z2RjZFTzAvZUtoN0FZVXVnbGhrQzFk?=
 =?utf-8?B?Zk1XYTlWWllmdDB0SFBPejNJN0FjWE54a3hKd1FFbkgyczNiWlJkOUJzbVN0?=
 =?utf-8?B?ck51VC9DVEVFNTFMN2E2eDBjQ3p1MHFUOWJMQlBMQ1ZmODVzMU94ZU1CeUxB?=
 =?utf-8?B?cEtCbGc1TjFaOXZHaURxM3daZkRXeVRxRHVzd0xzWXVtZ0lsd1BXQ1h1K3Ir?=
 =?utf-8?B?M0o3SHcrYWR1Qm83M0hibmdqUlNhaEpaem9TMDF3OXRZTmsyT0F2WFFJcVJy?=
 =?utf-8?B?alJLcjNhZ3JzcW1CdDVDZ3R5YmkyUXZZbnUxZGhjV0VxQktnZU8ydnJjRk9z?=
 =?utf-8?B?eGlRUUZFUmZxRDR3VmVBWFgrRVc0MUluOVZBTnhUNVYzU3YxRmlLaDgzUzNw?=
 =?utf-8?B?WVVpaHhLSVRoVnJOL2dJc3pjbUlydEk2MXBCNDA1QWtpckJURXJQRTBEdUhl?=
 =?utf-8?B?ejZJMVc3eXZXb21qV3AwdnFJLzFkVHNVbC9vRFpHeWdaRVlPZ0IvTTVObXdW?=
 =?utf-8?B?eEtlUXNCUnIvV3FMWEZYWUsvSGlQdTRzYVl2M2Q5T0JTNWZaWW9XNTRTRHFK?=
 =?utf-8?B?ekhtK3BVTE9iNGRrSnBvRnpWNGNpY1ViblQwand6V1JkU1BYb0tPS2s5Smky?=
 =?utf-8?B?VEI0YjlFWDFjeGQweVV5WkQvMklMMGpJRzkxeFcyWEJ2T251WWpSbC80bnhS?=
 =?utf-8?B?b3NhdFV3eXRQRXJwaTBPbDNmY1NaWWhlZDZ3S28wUm5NUUFDZ3lLaXB5akFw?=
 =?utf-8?B?ZmlRUUdZU3o1T0VHaHFXVTkvTS80T3dvT1VHcEhrZUdBRUxNMkQrbEZOS1E0?=
 =?utf-8?B?QWgxb3poY1JSbEwyUkNJRFN1UmhHNzJhb0ZUaFJybDRjRUxEVHY0NGV4a2NH?=
 =?utf-8?B?eVlXN2dFQnNGRXRYTnM1cnRZNm1NNTRnRUNTUW4rRlZYUUxnRm1MVVc2dVV5?=
 =?utf-8?B?c25Qajc3bHBYcXYveEI0QjduMVBnc0JSa3JoWWFMR013NGVvREt6cmlWM2Nq?=
 =?utf-8?B?RHBLbzRVWU1VdXRoc0lCNXplSnFXUzN0WDlQc2x5cDNLYjRPdlBRYWpkdWpp?=
 =?utf-8?B?R1dkT1MwNDFRTWpkQ2F4WVZqMGZLVEg1SU9RZ1VQTlBCSkgvblBBV3NYT2dF?=
 =?utf-8?B?SlF5K3U3cEw4WmQ5cVZKclZoNmRyT0FLK2lKcmlSdHRiQysrL0QrdW0xUXdq?=
 =?utf-8?B?UCtMaERqMUpVNVRkaXBYNFhiNnBQekxXckdrZ2FWcmtMRFJ1cHJJcit0SlhL?=
 =?utf-8?B?MVhjWEp0aDhLSURzRFdobkdrNExLKzdEM2NVaHJlM3hHS000SzJyb3dCVFVr?=
 =?utf-8?B?eEN4THNCVllCeitoSHRTQWQ3dm9jS2FDcUZpdmNKZHdjei8wSGp1dVdFSEd1?=
 =?utf-8?B?OVcrSkNYQTRrT0lOYm5CTXAyZEp3ZUgrSkEyZ0lHdmVCNFkwYmFRVVZ2SVRK?=
 =?utf-8?B?Q3ZEdEk5N1I0cWpxNG9IeHlXTWtRM1l1TmR0amdXbFUwNmdPL3poQm9NNXN6?=
 =?utf-8?B?VFhJYmRRUnh3bzMwNnI5dklVSDFOZmNrbDgyK1FuVkltaWpVTVRIeWVRdkw2?=
 =?utf-8?B?V01FKzQxSmR3L3FURjc2OFFOS3BVNklsUTFnMlAvb3pzeVlkYStHT3BQSUs5?=
 =?utf-8?B?ZGt6am5UOGd2c3RHLzZKdkRuWWdnZ3BDNFB2c3Z4ajlKeG0yQWFNU1lNS1Js?=
 =?utf-8?B?QWxTa1BPQ3lOTG0xNHp2alRYRDFMcmV4MVlEYnFpOTRMOXZ2NnhiYWFyQWdq?=
 =?utf-8?B?bHhkcEZLVDRLS25KdWt6YXJmckhhR1pDRTl5RmNQNXJLUkdiSXhEaDI4YldB?=
 =?utf-8?B?VGtLTkx4UTVBRENOOFVCakxReDhvcU01YytGRGJCSGlpdkRmUFUwK3Jxd3BB?=
 =?utf-8?B?SVM0cWdiNFl2b0Z1Z2VucDhRbnF2ak5kUTJuQTIvQzJYcVVmeitTR2Z3RGJU?=
 =?utf-8?B?aDhHZVpkdDk5cGRxdEJVMG14Y21lcmhWTHZTeWNQQk5QRlpwRzFTRkh1NGN0?=
 =?utf-8?B?cklabU1wamJLbWFQSVRNTzE4bnNpaGVvTWRuSnAwWnFRaGFHMFpJSVZ5N1JW?=
 =?utf-8?B?Smc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB1843.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b60e7b2-b0f3-4574-1e85-08db56b926ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2023 09:29:02.4818
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ygMCJB1LS2tBBLYmIKWMVUANE8eTLjMLFqMdtqpxV8v73MBwpnIZP0dG8w/rnpGLd7qPW7uLcFEogJKCWaiI7Jnk9QCF5nWNU2g89PnFppo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB9486
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T2sgdGhhbmtzIGd1eXMgZm9yIGlucHV0Lg0KDQpJIGRvIG5vdCBsaWtlIHJpY2hhY2wsIHRvbyAt
IGZvciByZWFzb25zIG1lbnRpb25lZCBoZXJlOg0KaHR0cDovL21pY2hhZWwub3JsaXR6a3kuY29t
L2FydGljbGVzL3RoZXJlX3dhc19hbl9hdHRlbXB0X3RvX3NhdmVfbGludXhfZmlsZXN5c3RlbV9h
Y2xzLnhodG1sDQpUaGUgIm1hc2siIGhhY2sgaW4gUG9zaXggQUNMcyBhbmQgUmljaEFDTHMgaXMg
c29tZXRoaW5nIHRoYXQgbm9ib2R5IHJlYWxseSB1bmRlcnN0YW5kcy4NCiBJIHdvdWxkIChhbmQg
bm90IG9ubHkgbWUpIGxpa2UgdG8gaGF2ZSBhIGNsZWFuIE5GU3Y0IGFjbHMgaW1wbGVtZW50ZWQg
LSBqdXN0IGxpa2UgTmV0YXBwLCBPbW5pT1MsIFNvbGFyaXMgb3IgRnJlZUJTRC4NClRoZSBzaW1p
bGFyaXR5IHdpdGggV2luZG93cyBBQ0xzIGlzIGp1c3QgYW5vdGhlciBiZW5lZml0LiBZZXMgdGhl
cmUgYXJlIHNtYWxsIGRpZmZlcmVuY2VzIChtYWlubHkgdGhlIE9XTkVSQCBhbmQgR1JPVVBAIHNw
ZWNpYWwgcHJpbmNpcGFscyB0aGVyZSBidXQgSSBhbSBzdXJlIGl0IHdvdWxkIGJlIHBvc3NpYmxl
IHRvIHJlc29sdmUpDQoNCkFzIHBlcjoNCmh0dHBzOi8vZ2l0aHViLmNvbS9vcGVuemZzL3pmcy9p
c3N1ZXMvNDk2Ng0KSSBnb3QgaW1wcmVzc2lvbiB0aGUgY29kZSBvbiB0aGUgWkZTIGlzIHByZXR0
eSBtdWNoIHJlYWR5IChpbmNsdWRpbmcgdGhlIFhEUiB0cmFuc2xhdGlvbiksIGJ1dCBub3Qgc3Vy
ZSBpZiBpdCdzIGFjdHVhbGx5IGVuZm9yY2luZyBhY2xzLCBwcm9iYWJseSBub3QgYXMgaXQncyB0
YXNrIGZvciBWRlMgcmlnaHQ/DQoNCkFueWhvdywgcGl0eSB0aGF0IGl0J3MgY29tcGxpY2F0ZWQg
dG8gaW1wbGVtZW50LCBpdCB3b3VsZCBiZSBuaWNlIHRvIGhhdmUgYSBmdW5jdGlvbmluZyBORlN2
NCBzZXJ2ZXIgd2l0aCBBQ0xzIHJ1bm5pbmcgb24gTGludXguDQoNCk9uZHJlag0KIA0KDQotLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogQ2hyaXN0aWFuIEJyYXVuZXIgPGJyYXVuZXJA
a2VybmVsLm9yZz4gDQpTZW50OiBNaXR0d29jaCwgMTcuIE1haSAyMDIzIDA5OjQzDQpUbzogSmVm
ZiBMYXl0b24gPGpsYXl0b25Aa2VybmVsLm9yZz4NCkNjOiBPbmRyZWogVmFsb3VzZWsgPG9uZHJl
ai52YWxvdXNlay54bUByZW5lc2FzLmNvbT47IHRyb25kbXlAaGFtbWVyc3BhY2UuY29tOyBsaW51
eC1mc2RldmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0K
U3ViamVjdDogUmU6IEEgcGFzcy10aHJvdWdoIHN1cHBvcnQgZm9yIE5GU3Y0IHN0eWxlIEFDTA0K
DQpPbiBUdWUsIE1heSAxNiwgMjAyMyBhdCAwNToyMjozMFBNIC0wNDAwLCBKZWZmIExheXRvbiB3
cm90ZToNCj4gT24gVHVlLCAyMDIzLTA1LTE2IGF0IDIwOjUwICswMDAwLCBPbmRyZWogVmFsb3Vz
ZWsgd3JvdGU6DQo+ID4gDQo+ID4gSGkgQ2hyaXN0aWFuLA0KPiA+IA0KPiA+IFdvdWxkIGl0IGJl
IHBvc3NpYmxlIHRvIHBhdGNoIGtlcm5lbCB0aGUgd2F5IGl0IGFjY2VwdHMgbmF0aXZlIChpLmUg
DQo+ID4gbm8gY29udmVyc2lvbiB0byBQb3NpeCBBQ0wpIE5GU3Y0IHN0eWxlIEFDTHMgZm9yIGZp
bGVzeXN0ZW1zIHRoYXQgDQo+ID4gY2FuIHN1cHBvcnQgdGhlbT8NCj4gPiBJLkUuIE9wZW5aRlMs
IE5URlMsIGNvdWxkIGJlIGFsc28gaW50ZXJlc3RpbmcgZm9yIE1pY3Jvc29mdHMgV1NMMsKgIA0K
PiA+IG9yIFNhbWJhIHJpZ2h0Pw0KPiA+IA0KPiA+IEkgbWVhbiwgSSBhbSBub3QgdHJ5aW5nIHRv
IHB1c2ggcmljaGFjbCBhZ2FpbiBrbm93aW5nIHRoZXkgaGF2ZSBiZWVuIA0KPiA+IHJlamVjdGVk
LCBidXQganVzdCBORlM0IHN0eWxlIEFjbHMgYXMgdGhleSBhcmUgc28gc2ltaWxhciB0byBXaW5k
b3dzIA0KPiA+IEFDTHMuDQo+ID4gDQo+IA0KPiBFcm0sIGV4Y2VwdCB5b3Uga2luZCBvZiBhcmUg
aWYgeW91IHdhbnQgdG8gZG8gdGhpcy4gSSBkb24ndCBzZWUgaG93IA0KPiB0aGlzIGlkZWEgd29y
a3MgdW5sZXNzIHlvdSByZXN1cnJlY3QgUmljaEFDTHMgb3Igc29tZXRoaW5nIGxpa2UgdGhlbS4N
Cg0KSSBoYXZlIG5vIGlkZWEgYWJvdXQgdGhlIG9yaWdpbmFsIGZsYW1lIHdhciB0aGF0IGVuZGVk
IFJpY2hBQ0xzIGluIGFkZGl0aXRpb24gdG8gaGF2aW5nIG5vIGNsZWFyIGNsdWUgd2hhdCBSaWNo
QUNMcyBhcmUgc3VwcG9zZWQgdG8gYWNoaWV2ZS4gTXkgY3VycmVudCBrbm93bGVkZ2UgZXh0ZW5k
cyB0byAiQ2hyaXN0b3BoIGRpZG4ndCBsaWtlIHRoZW0iLg0KDQo+IA0KPiA+IFRoZSBpZGVhIGhl
cmUgd291bGQgYmUgdGhhdCB3ZSBjb3VsZA0KPiA+IC0gbW91bnQgTlRGUy9aRlMgZmlsZXN5c3Rl
bSBhbmQgaW5zcGVjdCBBQ0xzIHVzaW5nIGV4aXN0aW5nIHRvb2xzDQo+ID4gKG5mczRfZ2V0YWNs
KQ0KPiA+IC0gc2hhcmUgd2l0aCBORlN2NCBpbiBhIHBhc3MgdGhyb3VnaCBtb2RlDQo+ID4gLSBp
biBXaW5kb3dzIFdTTDIgd2UgY291bGQgaW5zcGVjdCBsb2NhbCBmaWxlc3lzdGVtIEFDTHMgdXNp
bmcgdGhlIA0KPiA+IHNhbWUgdG9vbHMNCj4gPiANCj4gPiBEb2VzIGl0IG1ha2UgYW55IHNlbnNl
IG9yIGl0IHdvdWxkIHJlcXVpcmUgbG90IG9mIGNoYW5nZXMgdG8gVkZTIA0KPiA+IHN1YnN5c3Rl
bSBvciBpdHMgYSBub25zZW5zZSBhbHRvZ2V0aGVyPw0KDQpZZXMsIHZlcnkgbGlrZWx5Lg0KDQpX
ZSdkIGVpdGhlciBoYXZlIHRvIGNoYW5nZSB0aGUgY3VycmVudCBpbm9kZSBvcGVyYXRpb25zIGZv
ciBnZXR0aW5nIGFuZCBzZXR0aW5nIGFjbHMgdG8gdGFrZSBhIG5ldyBzdHJ1Y3QgYWNsIHRoYXQg
Y2FuIGNvbnRhaW4gZWl0aGVyIHBvc2l4IGFjbHMgb3IgcmljaCBhY2xzIG9yIGFkZCBuZXcgb25l
cyBqdXN0IGZvciB0aGVzZSBuZXcgZmFuZ2xlZCBvbmVzLg0KDQpDaG9vc2luZyB0aGUgZmlyc3Qg
LSBtb3JlIHNlbnNpYmxlIC0gb2YgdGhlc2UgdHdvIG9wdGlvbnMgd2lsbCBtZWFuIHVwZGF0aW5n
IGVhY2ggZmlsZXN5c3RlbSdzIGFjbCBpbm9kZSBvcGVyYXRpb25zLiBNaWdodCB0dXJuIG91dCB0
byBub3QgYmUgaW52YXNpdmUgY29kZSBhcyBpdCBtaWdodCBib2lsIGRvd24gdG8gc3RydWN0IHBv
c2l4X2FjbCAqYWNsID0NCmFjbC0+cG9zaXggYXQgdGhlIGJlZ2lubmluZyBvZiBlYWNoIG1ldGhv
ZCBidXQgc3RpbGwuDQoNClRoZW4gd2UnZCBwcm9iYWJseSBhbHNvIG5lZWQgdG86DQoNCiogaGFu
ZGxlIHBlcm1pc3Npb24gY2hlY2tpbmcgKHNlZSBKZWZmJ3MgY29tbWVudCBiZWxvdykNCiogY2hh
bmdlL3VwZGF0ZSB0aGUgQUNMIGNhY2hpbmcgbGF5ZXINCiogaWYgdGhlIHBhc3QgaGFzdCB0YXVn
aHQgbWUgYW55dGhpbmcgdGhlbiBvdmVybGF5ZnMgd291bGQgcHJvYmFibHkgbmVlZA0KICBzb21l
IGFkZGl0aW9uYWwgbG9naWMgYXMgd2VsbA0KDQo+ID4gDQo+IA0KPiBFdmVudHVhbGx5IHlvdSBo
YXZlIHRvIGFjdHVhbGx5IGVuZm9yY2UgdGhlIEFDTC4gRG8gTlRGUy9aRlMgYWxyZWFkeSANCj4g
aGF2ZSBjb2RlIHRvIGRvIHRoaXM/IElmIG5vdCB0aGVuIHNvbWVvbmUgd291bGQgbmVlZCB0byB3
cml0ZSBpdC4NCj4gDQo+IEFsc28gd2luZG93cyBhbmQgbmZzIGFjbHMgZG8gaGF2ZSBzb21lIGRp
ZmZlcmVuY2VzLCBzbyB5b3UnbGwgbmVlZCBhIA0KPiB0cmFuc2xhdGlvbiBsYXllciB0b28uDQoN
CkplZmYsIEkga25vdyB5b3UgaGF2ZSBzb21lIGtub3dsZWRnZSBpbiB0aGlzIGFyZWEgeW91IHBy
b2JhYmx5IGFyZSBiZXR0ZXIgZXF1aXBwZWQgdG8ganVkZ2UgdGhlIHNhbml0eSBhbmQgZmVhc2li
aWxpdHkgb2YgdGhpcy4NCg==
