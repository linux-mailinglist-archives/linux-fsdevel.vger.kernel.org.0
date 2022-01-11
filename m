Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D843D48B565
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jan 2022 19:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344028AbiAKSIk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jan 2022 13:08:40 -0500
Received: from mail-bn8nam12on2134.outbound.protection.outlook.com ([40.107.237.134]:38081
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1344904AbiAKSIb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jan 2022 13:08:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZUMAkhOx5mSZY8czOPahtNzMVt5E/vAofo2LDtokhMGAf3oR8e988xIFAI6xOsq+Eqp0RDkT5y3LfnBW6ly2f0wMJZ9XaaiMOdMVXJJvsTt5c6y1Y+625qA7pVZ35Z/98/QDRIWWC1Wnf5XuqcWFR15m7uGjUpLISnzYRAOs/g9caZP1NLq81mCIri7DBNqs1igkwAQ7VEdl6wavdcBoZS/Lfb+8Z9nJ0TbcnmQWPLO1H/8wx2ruV/QuVUFkePuZIRqsqzSHf+hbaa0xawAx1nbYBgFoDvrZj5J7bG/m4o9AuXgcY331D+vF9sQZI13dzL+0AqtlhQSHh8wtki37zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VsITgzzceWyPm9ovpQXtmG7dR2TZqtDWDZFgCd9uasc=;
 b=NA2/9aCFY8e7wZDq3PIPQi7vIN1SPjvNOweL4DnEOHsMyLSXcef1BFBw3xWbrUi2XQD5Q/dVCc7TuIuUnSEkAyiSDV5EmM7uyHM/IW7rL0DuSKVQWVaEUvtdRhPf3TOnhJ1rVacpe36E9OHufRMOc8Z03QLHm2xYxS2oCBNMIGRtfHBb4dF8XWlHbxuqYWFy6swz7grpru5Ok4LP3fHEac5D3XDEN0OQULTP9sob1+fQQHSm7a0dspOMrJcZLrWdR6pJ4xE036SKeTpa2xDU376GUA4linOMlbs3UsK/qf7EXFgRYVQtTdpLCyz/5QLItnjU9XbebM7tHpEJypl/nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VsITgzzceWyPm9ovpQXtmG7dR2TZqtDWDZFgCd9uasc=;
 b=Pr9sagKXzndVAyCiEOQ2EDYPSo0zprrkJxfjqOksCgiKMTs3oi4Q4LyqkAwQXercYKshwguzhHLqnf9QX6GQ9Lf+QRKHkSr70q6t9VP6F/Hf1F2BJmE0BAszSVRsBuJnLyUl8XW783V1Jo8dqYle6GHyjIDL9cHRh5hK0dfLtPM=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CY4PR1301MB2118.namprd13.prod.outlook.com (2603:10b6:910:48::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.4; Tue, 11 Jan
 2022 18:08:27 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::ecb4:77ee:a645:9bae]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::ecb4:77ee:a645:9bae%4]) with mapi id 15.20.4888.009; Tue, 11 Jan 2022
 18:08:27 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "hch@infradead.org" <hch@infradead.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        Lance Shelton <Lance.Shelton@hammerspace.com>,
        Richard Sharpe <Richard.Sharpe@hammerspace.com>,
        "Anna.Schumaker@netapp.com" <Anna.Schumaker@netapp.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [bug report] NFS: Support statx_get and statx_set ioctls
Thread-Topic: [bug report] NFS: Support statx_get and statx_set ioctls
Thread-Index: AQHYBr7uESfB0KyML0ueAstOBZLgUaxdgnIAgACchQA=
Date:   Tue, 11 Jan 2022 18:08:27 +0000
Message-ID: <56202063c1eba6020b356a393178b9626652198e.camel@hammerspace.com>
References: <20220111074309.GA12918@kili> <Yd1ETmx/HCigOrzl@infradead.org>
In-Reply-To: <Yd1ETmx/HCigOrzl@infradead.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0461db4d-edc9-4626-b1e1-08d9d52d5e0b
x-ms-traffictypediagnostic: CY4PR1301MB2118:EE_
x-microsoft-antispam-prvs: <CY4PR1301MB21186C3994F08B3252B24C2EB8519@CY4PR1301MB2118.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:167;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PHgM/fPzifYdWfQpdZAyC5Kqa0DHplO+6DcV0ozl/HffSMTnTAnpQal2Agmrw8AhNRqiZlQpp3lzyYk/BdnXPMLMNoPhl661Kr3w8LoWGijH9cFhjeCFQg4GuwJ9BrlHuc8VazxMPM/51KHXzlEvtnbkJQ4b2LhjPJLJRf2tWSnjGcv9wRyhaV7nUtxFgo954BuhHRpsWFKohC9k9BLvcSQbKHPIDqf4xH4YDwO1yMK0pHstoKSEwNoON3J9EWRPIEVD7/BXEngUhtzgpNqtcP7NTcCFxgzNJd4N6Mu4L3+fsfDLqg4UuDL5FJzYDTEAAC8EYCZgyIquhyKF59tOBjWTvPfooixHZe2ote5bKq4LloM4sEhEjogPV1p1fdfBrhll3k1xorQZfAgwEON7gvH76LdtpVzIqCk5vAXAvmp1z8gTYwidNYPIEn2g5xRhNc7IUItLB5Y3LIm12KOZnODdVAS261uqD1vvPTW/qyJo6DyOqY/+CdmvnYIDg87dRf2+Jc5rOknmHiF3v4W9HBvfXl9mh31RIgx2vz2KW9MCoR7Z+PfHNiK6Zm1dWu0lMM9iRMBFPWEUcC5EP7p7e/JFQ5eMuSJgj6lt4S4TchcPhSyWcHiq6QDCWA1AW6ocbB2Rl1lLLFftOkFxdbmQo1S5mQUBVr3nUeSdIFIy/66OADAytKaN648+qFu9HZHCteIdkSdjThYBqTz6uSTLz5nJw9L/i4zYot7JS8bPImG1H2ryTbkE5S5yD3bu+/3Sg5jf8PC82MZ/97Ajzpu+AfzCl5emBOG39gVIg4AJWOs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(376002)(39840400004)(396003)(346002)(136003)(6486002)(6506007)(2906002)(38070700005)(110136005)(71200400001)(6512007)(966005)(36756003)(508600001)(8676002)(26005)(76116006)(316002)(66946007)(38100700002)(66446008)(186003)(86362001)(4326008)(66556008)(5660300002)(66476007)(8936002)(122000001)(2616005)(54906003)(83380400001)(64756008)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SXcvSkxjWXk5WXRvbDM2QUx6QUVIMzdoeFViTC9RWVFOa1RNSzQ1cm56UGRE?=
 =?utf-8?B?U0poeWJ3a2wyVTNsckp3SjQ2US9SZFBIY3Y3RGd3TTk5UWhiaVZtWGxZR1dI?=
 =?utf-8?B?N3NBZEEzNis0TGwzalF5c0hNK2ZEcjRMcVRheWVpa3ArQ253L2gxL2hOSHd5?=
 =?utf-8?B?L3BZbTJpbVVUYlVJckxUdksxYjVUNElEOGY3TXJsZUtGYVJoYisxbmtsQ09o?=
 =?utf-8?B?cDRTY05id3FiWFcrd29aSUtydXR5SjRHNHdZQnBSVFNLSTFTdTZjOUJydHlY?=
 =?utf-8?B?Y3AyYld2WW5HN3g2a2NjbTg5OWVHL1A3cmlNS3hteW0wNUJSakh5b0ZzcS9K?=
 =?utf-8?B?a3VVRUJ4TzNrYm1NNDFIS1J1c20wSEplR1QzZCtia2ZLUS9vM0ZaMzVNeGxX?=
 =?utf-8?B?Qmpwc1ZDa1k3V2gxUVB6akdsbitlSCsrZGdEOFdXOHJMU1hEVzJSTk5tS094?=
 =?utf-8?B?dm01TVFSdjhtU1R2ZWRLc1hHWk9XZ0JlcUg4alJ6VXIyblgvWit4VjZOM2NE?=
 =?utf-8?B?VkFDMlVOd3ltK0VGRzl1djRpZTdlNlF2a2prK2MwVDkzQmRzU3NGclVWSjZ2?=
 =?utf-8?B?OE5aVWZJQWtWZElBd0NHSVFMcDVhcEFIRTRtNWR4K0ZqUkpvaU5uckNEZHd0?=
 =?utf-8?B?MUFWMjRNL2MyZTRZWWxiVGtpT0J1eWNHQ1lVWFl0clQycnIvTXdiaEpoVG9P?=
 =?utf-8?B?ZjhTNW0xYkh4Y0N3Y0IzSWVaQTdNN1FXWmRtMmkyL1pQWlBSQWgzWklvMkxv?=
 =?utf-8?B?VSt1M2x2M2tlYkNiMVJjb2loVndpMk5xRzk5dlpyZ2pJMlhJcjZuZHJHWTlV?=
 =?utf-8?B?T3ZyTnZKMitHRmZ4OTFlamxvWkJmb1VpNU5EMDNRcXRhUmJ1bDk5ajVzUlFX?=
 =?utf-8?B?ZTFMaUppL0luUnEvMGc4VTJUKzJpd3RBUkVoaldPYW1NTzJGRkZpS1BjU2s0?=
 =?utf-8?B?NWFrWWUya09nZEJrZ3R1OVpWSlViWHlpdXRjcmt1TXdYYnE0Nk1iUXVpTzRX?=
 =?utf-8?B?Qm5Dc1ByYnRKQ1lGNWZQWGhOWEd4MWE2RGNtWVBmVDNXa1JuQy9KNUVBNXQv?=
 =?utf-8?B?eHB5QlN2NGFrRW5oOEdhbU50QUQxcWlON1lsanYzQkxNVDl0L1BvSlVSNE50?=
 =?utf-8?B?YnhuSzRIVU1JTEw1cHVPU1B3eDM5dXI4VGlGUmoyMHRjMWtXdFFaMjRRMkU3?=
 =?utf-8?B?WDg1dFpqQmU4bnZRbnVBVXdEbUJzQ0lLaXRGRFAyZDRKLzdBRkRZSWp0Ylp4?=
 =?utf-8?B?VFZuV1owU2FSSXByL0ZoUlpYeVRteCtsTG1OUzFuaWYxTGVEUWlVWWRxVndX?=
 =?utf-8?B?dE9UZ3h0bzlidXJGNlVUSWxNVnVETXRuemJ0U3lpL2trVytESlRRUHczamFt?=
 =?utf-8?B?cHBKamNlTXBlVFhSWVBhTng3NXhZQmxkTmM5RE5FOGNCTHhaL2YzWldzMDFY?=
 =?utf-8?B?R1ZYdHNDakhCQ3BSSWdObmRWaVhuWklkNzhQeUJRY2lUTDN5UjAwcmJkanJO?=
 =?utf-8?B?UVAvdWVISG9QQVNYb0o3U0pJcGJBZmE2WWErMHRUQTJSZE10RUJXU2pKNmlR?=
 =?utf-8?B?MUZJSlNuY2hpaUdVbzVDSEhsVkFNKzlOckROVUo1aWZKcS82b2MzYTNZV0VX?=
 =?utf-8?B?MW5aMWMySkcydkxEc3M5U29sSHM4N2dFNmZ2L05RWjh0VkV2cTlKZG5NU1E3?=
 =?utf-8?B?M0pXODRscERFMXJFU3VVVzdEbERwKytJL08yNVdLVGdWTEV2UFl4UjdjMWlO?=
 =?utf-8?B?MWtGTEVBemx3cVlmNkM2NXovV25mbS9TYnppenYxR0FOTHBvNUJzVUR0WVBH?=
 =?utf-8?B?Sm5UWjZaT3c2U21wNGhGamczUm9Ba2NwWjFFSDlBRi9HS1ZjVi85emhrN2RI?=
 =?utf-8?B?eHhVSmpHdCtqUkVuYTVsN2hoeFpiQ0tiM1ZJL1Rwa2kyNXVCNzVmTmtpOStB?=
 =?utf-8?B?aDlBZ1JEOS9JZUxyL09SRTdPaHE2SG85VzRvdGNwa3I3LzVkd0hYL0JGNFVS?=
 =?utf-8?B?bHZCYzBXYzQ0by9lOGhCZlF1OEVqTWVlVlRTMlBhZllQRHBqYTR6OEw4VTd2?=
 =?utf-8?B?T0J5ZGU2L1J1aDQ4WmhDSElhL3MxNFNPaHRhMGdjbWVxZ015am4xR1NKV0xw?=
 =?utf-8?B?TzNHVWtSQ1ZqZnBkd2ZmQ2lZSVJ3UGt5WG9FY3VPcjd2YkJ6a1l2OGw5aXhI?=
 =?utf-8?Q?WLJYbXvwGlV47lG/mZF7RDk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E98C92BBA54207479EE992AA063C3A4E@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0461db4d-edc9-4626-b1e1-08d9d52d5e0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2022 18:08:27.6924
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /veVNDVdlSKuAAlQwxqBCx/y6gPzq7sNTLlJNfXa2gz9Mq/aJUfxXjgudaW3e2BOHcjUfQBojscQvJxf4szcdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1301MB2118
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gVHVlLCAyMDIyLTAxLTExIGF0IDAwOjQ4IC0wODAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gT24gVHVlLCBKYW4gMTEsIDIwMjIgYXQgMTA6NDM6MDlBTSArMDMwMCwgRGFuIENhcnBl
bnRlciB3cm90ZToNCj4gPiBIZWxsbyBSaWNoYXJkIFNoYXJwZSwNCj4gPiANCj4gPiBUaGlzIGlz
IGEgc2VtaS1hdXRvbWF0aWMgZW1haWwgYWJvdXQgbmV3IHN0YXRpYyBjaGVja2VyIHdhcm5pbmdz
Lg0KPiA+IA0KPiA+IFRoZSBwYXRjaCBiYzY2ZjY4MDU3NjY6ICJORlM6IFN1cHBvcnQgc3RhdHhf
Z2V0IGFuZCBzdGF0eF9zZXQNCj4gPiBpb2N0bHMiIA0KPiA+IGZyb20gRGVjIDI3LCAyMDIxLCBs
ZWFkcyB0byB0aGUgZm9sbG93aW5nIFNtYXRjaCBjb21wbGFpbnQ6DQo+IA0KPiBZaWtlcywgaG93
IGRpZCB0aGF0IGNyYXAgZ2V0IG1lcmdlZD/CoCBXaHkgdGhlIGYqKmsgZG9lcyBhIHJlbW90ZSBm
aWxlDQo+IHN5c3RlbSBuZWVkIHRvIGR1cGxpY2F0ZSBzdGF0P8KgIFRoaXMga2luZCBvZiBzdHVm
ZiBuZWVkcyBhIHByb3Blcg0KPiBkaXNjdXNzaW9uIG9uIGxpbnV4LWZzZGV2ZWwuDQo+IA0KPiBB
bmQgYnR3LCB0aGUgY29tbWl0IG1lc3NhZ2UgaXMgdXR0ZXIgbm9uc2Vuc2UuDQoNClNvIGZpcnN0
bHksIHRoZXJlIGFscmVhZHkgaGFzIGJlZW4gYSBkaXNjdXNzaW9uIG9mIHRoaXMgb24gbGludXgt
DQpmc2RldmVsIChhbmQgbGludXgta2VybmVsKToNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xr
bWwvMjAxNjA0MjkxMjU4MTMuMjM2MzYuNDk4MzAuc3RnaXRAd2FydGhvZy5wcm9jeW9uLm9yZy51
ay8NCmFuZCB0aGUgY29uc2Vuc3VzIGF0IHRoZSB0aW1lIHdhcyB0aGF0IHRoZXNlIGF0dHJpYnV0
ZXMgd2VyZSBub3QgbmVlZGVkDQppbiBzdGF0eC4NCg0KVGhlIG90aGVyIGlzc3VlIGlzIHRoYXQg
dGhpcyBpcyBub3QgYSBkdXBsaWNhdGUgb2Ygc3RhdC4gSXQncyBhZGRpbmcNCnN1cHBvcnQgZm9y
IGJvdGggX3NldHRpbmdfIGFuZCByZWFkaW5nIGJhY2sgdGhlc2UgYXR0cmlidXRlcy4gVGhlDQph
YmlsaXR5IHRvIHN1cHBvcnRpbmcgcmVhZGluZyB0aGUgYXJjaGl2ZSBiaXQgLyBiYWNrdXAgdGlt
ZSwgZm9yDQpleGFtcGxlLCBpcyBjb21wbGV0ZWx5IHVzZWxlc3MgdW5sZXNzIHlvdSBjYW4gYWxz
byBzZXQgdGhvc2UgdmFsdWVzDQphZnRlciBiYWNraW5nIHVwIHRoZSBmaWxlLiBSaWdodCBub3cs
IHRoZXJlIGlzIG5vIHN1cHBvcnQgaW4gdGhlIFZGUw0KZm9yIHNldHRpbmcgYW55IGF0dHJpYnV0
ZXMgdGhhdCBhcmUgbm90IHBhcnQgb2YgdGhlIHN0YW5kYXJkIFBPU0lYIHNldC4NCg0KLS0gDQpU
cm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UN
CnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
