Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C926E3299
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Apr 2023 18:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjDOQ5f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 15 Apr 2023 12:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjDOQ5e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 15 Apr 2023 12:57:34 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2134.outbound.protection.outlook.com [40.107.94.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91AC31FCC;
        Sat, 15 Apr 2023 09:57:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mEovPfdDp3+wJ1LAvZqQh4gUMDOGMaiEwy7Qg3579A4gbV/sDrehfRrNnGqMBrwl4XQzgsPZOGlb7mcir+K3zoEmzOUebjYO1lzZ6kOL7hgmr/I2JrL2ksvj3E42ehfh+XZ3EEKYfwAdGzzEghpI6zDBJNBe+vCpmARcQGO4+K2td+3/i7HWcEWtycvV/jMDdgLe/7iGMJno0awtxZmogAXI9wOxH+heH/PpawiNnLX1nrUMW+yf76JY3BEKIRyGDHlbYZGRLEQoM5FEl1crF2q0xk6EegpX3YAlppAOry3GgZMurV+Jg2oZLb3X9Y9RZtIz8dxNT4Qx4Pb6T2WEUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sjZCx3crHjDVuyN0dbUuNVOaqGAVs4VPBVf8BOS5Fxs=;
 b=LraxUXwd28sBXuNH8rr+ZYhhjFf1rPfI5vwwMEt03EFnzZd+/ayxdvpySIJMlHZO83bTkiK3q+p2dmRLPLcaqz98r491mE8mGXZn8Nneubhreape9DdtozK3LaQYElmDmtITg+wtTZQSvF7CJoPAJxAOTHfW7lWxgtwiAcpAvLKQReLfbl8MYdqThG8KlGmr8JsBnKU7onsCzFhoCXRo2UVr7ziwTVAvX/Bv7utwrrXLd0jJz379nHCOfyOXi+C/vwsF50/4An1syaqVfvkZ+jeqlw15+WtebKy4sD+AZzgTEc5RZA4qHYQ66XDxvWnqzGQBo63VNqHz5+w71Qdl8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sjZCx3crHjDVuyN0dbUuNVOaqGAVs4VPBVf8BOS5Fxs=;
 b=fFX7NS4S6rCFZyTlpaTcUg+L98tpvPAmku49VtxaNFqBtH3CkfgWgrgCAWfN+jk8EmDDqOqxE522fLu7RNFhqupdPCHO63CB+Lh5sMEyxmqC6d0grGGZssr1KbNsM9ZbaWMFOGuF7i0NxdsN8LodCDirEwGpF9BboFl4+6xNPa4=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by DM8PR13MB5189.namprd13.prod.outlook.com (2603:10b6:8:e::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.30; Sat, 15 Apr 2023 16:57:28 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::3627:d466:b0ae:1740]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::3627:d466:b0ae:1740%3]) with mapi id 15.20.6298.030; Sat, 15 Apr 2023
 16:57:28 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     Charles Edward Lever <chuck.lever@oracle.com>
CC:     "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] BoF for nfsd
Thread-Topic: [LSF/MM/BPF TOPIC] BoF for nfsd
Thread-Index: AQHZbWxjbwN4AXhTVEi8u3WYTLTb1a8slZMAgAAGP4A=
Date:   Sat, 15 Apr 2023 16:57:28 +0000
Message-ID: <6D00F80D-7276-482A-8227-6D9D64EB39D7@hammerspace.com>
References: <FF0202C3-7500-4BB3-914B-DBAA3E0EA3D7@oracle.com>
 <45099985-B9DE-4842-9D0F-58A5205CD81D@oracle.com>
In-Reply-To: <45099985-B9DE-4842-9D0F-58A5205CD81D@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|DM8PR13MB5189:EE_
x-ms-office365-filtering-correlation-id: d3c1b895-ceb5-4c6b-4f49-08db3dd27ecb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W4tR9WlEHoCfW+8ORDZiuOSREkyb2WH2vuyCO6TCfdgYz3t5rAqC2AmkfOfXVkDLpxmyVE1UKOVVFhrRkvpf5lJqEv6MNhpua6RohhWT5gNrLgZptSxT3WN7X8zKKa+avJ9tSgHUpTv3Q9cJR5BQJMJugR0OF7sBWaOxX08d3lXrvS3OgF4IO0Tnk3U13q8cPIhWfE5+mWVz6npEXeRrC5JoOE1D64TZI/o2NDBjDglTL5VrCbtLkvKhEpnX/YorKbjCPm69Pz1eMEEsyJpmjKmY/JIUIJYAS/fR6korMSjKzx5eK2Z9GHOv/NEQTW2AFXopXCUkQyTVql6hTzZTZBYEt8G2vvmtrUSvDVfCG628Q9u1hF1+/YiOM3fvYM8PP1SgDBYxih1GbO4fDg34NZw8JQczF7auHKnaha6hperGH7+TpGYPyOOemCCG5daT62GQc1rnCu41qOj4tZ/xNhedBwLhpqSiPuIkpQCiWYAQImofYPMEriUlr4Ra+HqYsoTJhcgMfrFVp7xTi+lxK4aivl3SZp4nH3891wqgF/vqIruhPA4hNmjIdaRB3BndGGOZXFDsJvvXecsnJETdZ3aEOTcHfykDVq+vuPygXSQAQH/+Ldy03VKanW5qKMovwaiNN4N3TmUGb98RZ4eGwGExSPbW3PT9+/Y+jcER3uEbgX1cvDp7pjeSDSRSQ6qQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39830400003)(136003)(346002)(396003)(376002)(451199021)(41300700001)(4326008)(66476007)(66556008)(64756008)(66446008)(6916009)(76116006)(66946007)(36756003)(186003)(2906002)(4744005)(38070700005)(5660300002)(2616005)(33656002)(8936002)(8676002)(86362001)(71200400001)(54906003)(478600001)(966005)(6486002)(53546011)(26005)(6512007)(6506007)(316002)(38100700002)(122000001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cjlNaGNONENtTHAxc0FXY3pmaE5LOU84bHJYYVhzdTcwMEFJdFN3QllaeVpG?=
 =?utf-8?B?WXlrNmdpaTZMTXliK2Z1K2xSb3pTL0wwTlh1MFhEZ0dZdmlIVmZFU3l4QkRL?=
 =?utf-8?B?OG1sanJxQ2NCWUJDeVFKQmxNeU1rdU1TQTdEem1IMFplRHBuZW5lRDNMRFRJ?=
 =?utf-8?B?V0NFdEgzRnVNYnRQdzdrWXhJWWl4VHRubEFtdEJiSnBtaHJleTF0cnJSQWJW?=
 =?utf-8?B?eHdmWVFOc01TcWlRcGFSczFBeENWWnFFMnRrRW5KTGhuM25IdVZ3Y3p5emNG?=
 =?utf-8?B?QmNmZmF2WXFvb2M5NyttbUhkay9hdWllRk9kSUNwMFRLcXhZUEZObk5LeVA5?=
 =?utf-8?B?L01GY2l5c0NsYlB1WmRoeklPUnlFRVhaWXo3R29KNUpjSmkrRjhHQ05MY0tO?=
 =?utf-8?B?dEZIMi9BYTJMV09yRk1SVUVydmVBYzNWZWxaaEQwRGpWQ2hkdXN5RHljQjNm?=
 =?utf-8?B?QVgxNFpTdTNUQy9hQndqK3RwKzBtemcvaWhFVFhlbW5UenBheG9kWEFKV1ZV?=
 =?utf-8?B?NTFkdzZMdzY2dktFNnUzWTYyQmc3eGs3U0xLZnBkYVBIc0gyemRBNXhabFJ3?=
 =?utf-8?B?d01vQ2pWYlBhMXJwV2d5ejZKTnQ3cHhQYk4ySHhQc041dllHTUlSaEFib01S?=
 =?utf-8?B?WWc5QXV2dTdVQUhOWWsvWXk0WHYwMVdYY2dqaE1rRHJHdjNRZEIzWW1iSjFz?=
 =?utf-8?B?b0g0U0ZMZ0VjVDZIaDJtdDZmbnVnUjlCWWZyV1I1WEhVTE5ZU3J3T1V3T29Q?=
 =?utf-8?B?eStuclkrdGwvemw1eFJtNlAvc0ZKSTR1RmIxMXE1aHBLU1YvQ1B6Z3ZzTWky?=
 =?utf-8?B?SE9QMldKVjNVcTdRQjRoT3JNMHJvZ1p1L09TZFlvUWdtUFdSKzh3Qm1NMWQr?=
 =?utf-8?B?SXdlcVNaZzFaSklCdHkvd0pFemdFNlBqUGJzRWJPZVBqNnMrdW1XZ3FDejE0?=
 =?utf-8?B?VEtBdUN6OW1RcGZTblBoUDJsNTdIR1FUTTg3a0UvekpPUEpUV24vcUZ3VU5j?=
 =?utf-8?B?NU1qcjlpOU42bE5Fckt1c2p6WEE5YjdWRlR5WUpuOGhGcUlnMUxMOGtUaTla?=
 =?utf-8?B?eGZqVnJKankzd1M4NUxzVzkxNHpwZ3k1YkNYSGFabTFWTGxKK2RDNUZkQTg5?=
 =?utf-8?B?STI0UHdFQ2V4UjNmdy8vUFZHQWRFcnVuV1A1ajdvU0EzcUliWlEvYTM5QnFL?=
 =?utf-8?B?WVpZMWM0bXVnc0p5N0ExdENsNHhiWEdUeTBiRzhRNVhTZENJZG9oZHN1bGl0?=
 =?utf-8?B?OXJCVVZJZTNQVG9RUG4xSi9CZjZTaU9ITnpKSDNmYy9MazQzdmNLUkJUanZS?=
 =?utf-8?B?Y3h2bDgweUxwRkY0NUh1ME92ZFVwTzVNWDVocDk5ZXlUZzcwOWNJdUpQNlBw?=
 =?utf-8?B?b004UHVnd0k0VXVYY0RYdmJleVF4N2lOU1JVWXBaZ2NHcFNmVHBBK2tJdXZq?=
 =?utf-8?B?SmFTdWJXK3ZCREkzY3FYTG5qVXlyZWFPWHpocU5uQ2l6VHFrMWhOODNXRWg1?=
 =?utf-8?B?SGhuVEQ0WHdGVGRBL3JMbjErSXRPTmhKZndaaU9OdVNqZFE1TEFuTmtPL2lk?=
 =?utf-8?B?dE1hS3FlcXRtQlJhcXg3MCt1WTZhTk9adVVKTU9TNEpacFB0L3RkajVTMy92?=
 =?utf-8?B?LzRvNDR2Q2tUWTYvUWpmYzEvVlRBZktGczlScyt3UXZUbXEwSkJLUTdLN0NU?=
 =?utf-8?B?RXJKRVRMbUxSOXR5aGwwNzR2YUsvK21PbTJIeG15LzNnYzE1NmdpL1lUOGJu?=
 =?utf-8?B?N2EvTmUza0c1YUZ6RTlROEFFVm5IN3gyRDVrTUNuVERVQVp1SmVXYzVVZTZF?=
 =?utf-8?B?dll3Z1BGUXBza0hwMUFGR3B5MUpCVm5xSHFiTWhkOVViaFRsZyticlA3N2d2?=
 =?utf-8?B?bDdhQk9JTzdCanZMbDRnek42ck1PdDcyWEdZelBrT1pMczV4bC9DT09hYW1E?=
 =?utf-8?B?Ujh0WHlGaU8xVzMrU3FxMlBnQkVOTmEyY2hVNWNwb2NsOUlPdHdIVUtBVEx4?=
 =?utf-8?B?OEU0czM0blQxdVdleVFxSGFKOGpZcGZTR3QzenJvTWUydHJXS2VMWnBsV3F4?=
 =?utf-8?B?MlFkVVpsRk5UZS9PUEdyY3V1VGpQalVYV3pvM0RWSy9UaGRPS3ZOVkVUWDBz?=
 =?utf-8?B?VTlKRWl0RTlzYjBkTjJrVU9SR3hVRnQxVHVGN1MxdVJjMHM0ME5aU1hhU2pt?=
 =?utf-8?B?MkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0DD3B384DC9DF24CA7D51527FD514C3D@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3c1b895-ceb5-4c6b-4f49-08db3dd27ecb
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2023 16:57:28.2129
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7McDt0agudiDTOrAOFIXMM1914tmMUrApGUjOzapeais3Zrgf2vtHxJ2gynjbK7cNVDU78+It4MHpAksiqTtTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR13MB5189
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQoNCj4gT24gQXByIDE1LCAyMDIzLCBhdCAxMjozNCwgQ2h1Y2sgTGV2ZXIgSUlJIDxjaHVjay5s
ZXZlckBvcmFjbGUuY29tPiB3cm90ZToNCj4gDQo+PiAgIOKAoiBORlNEIFBPU0lYIHRvIE5GU3Y0
IEFDTCB0cmFuc2xhdGlvbiAtIHdyaXRpbmcgZG93biB0aGUgcnVsZXMgKGFsbCkNCj4gDQo+IA0K
PiBDb3VsZCBiZSBpdHMgb3duIHNlc3Npb24sIGJ1dCBpdCBtaWdodCBoYXZlIG9ubHkgYQ0KPiBo
YW5kZnVsIG9mIGludGVyZXN0ZWQgcGFydGllcy4NCj4gDQoNCkRvZXNu4oCZdCBrbmZzZCBwcmV0
dHkgbXVjaCBzdGlsbCBmb2xsb3cgaHR0cHM6Ly9kYXRhdHJhY2tlci5pZXRmLm9yZy9kb2MvaHRt
bC9kcmFmdC1lcmlrc2VuLW5mc3Y0LWFjbC0wMiA/DQoNCkFGQUlLLCB0aGF0IGlzIHdoZXJlIGl0
IHdhcyBzdXBwb3NlZCB0byBiZSBkb2N1bWVudGVkLg0KX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwg
SGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0K
