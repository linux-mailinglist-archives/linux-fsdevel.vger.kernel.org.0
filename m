Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD0262A200
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Nov 2022 20:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbiKOTfW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Nov 2022 14:35:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbiKOTfH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Nov 2022 14:35:07 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5A4C76F;
        Tue, 15 Nov 2022 11:35:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gdDmxvXa0PNXgmvLVD8nKZMOxvT1/M9bzoEIcVbce7XixvgnBWiXYkbjllBNF7XhOrXc+t/vdbpsgmVEZfyJ6Rlnc1O2eEM++FwpHgDzAnyBdwDAF534ixeMwCXzls2tSEHKoKtP7h+ZRc4yACMoU4QSFyltt0vIAU/877gZUdIIcGkrR+yeLosUwDHecTHQbkJzKJBBpBJd+Yj9j9oiMlwXudKQKN7JXoahzTJSezag95mPgmOPYiFF9c2xTgx9jIFdqVc5my304doOltQlso4BcPtYHF7Waa7c8Xqgn4vaQ+OjUjJ/Qaz1pugqKne8rN5761YBxq1KM3oluyxdkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rZBKYh9FpySZkahUXdzKj+MHIfcXhEU3wAa33r7nQ20=;
 b=HQtr3u3klKKoe35XosNpxZBz9+eLGtv0GxPnVPOzA1ybIuLUqCthYbBQV+T9vXqb080L6yy6qwZX4OlcmBoAIn2eCaNK7tj3GbenWCYATnex9vWyPuyZ/jYgVWl1xUZ9wy+/zppiCkGErdraG2Di0x4VaAKeyQ/uloGWe2ojhrtDVN2eShnqPlq4u+1WGKok8NBQxW3MTdROt5QuiUYltlRyFvPR1Ysd8MpQncH2OyO2vw7ZvSMMntVdEpQIxHA3wiTd8LA0wVmhutS+APRdMGWrUeVH36pfUUnwEgwXPRQzG1Awz792HLoUUkdlSG9NxfQZic9BTQ/t2aY9+2rMvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rZBKYh9FpySZkahUXdzKj+MHIfcXhEU3wAa33r7nQ20=;
 b=FbmOFRgUKTR2B2B68VUTd8dpMG/L19o82G4F1qtfuHRDha83BCAIna+vKjqWxqf7uVMDHHxBBp3qoVojp6eVAhRU8aY9qCAlEe8NIA2oHfJK9mCnoiLdL9X0XsjOfGa0JVn0vNRo1kOsdmN3Wk9oafXNM90vssaUYn29R7JJ0NELuYmr7vue+M40hy8/VozbHY6iSj0F3JwVbiSJtE9VtXbaOi+q7p44TeJ6AyxvPGbgtljFB20sTPMr5Wy0Rq7qkIrE6oXTMT4rSwK6ZY3PENBRdZJKx927txiIYhwj33QAU+UDSzLLBi2TF7QoWnDjNH6N64YREIFmDP6r6YFBTw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CY5PR12MB6551.namprd12.prod.outlook.com (2603:10b6:930:41::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 19:35:03 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 19:35:03 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Li Hua <hucool.lihua@huawei.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "weiyongjun1@huawei.com" <weiyongjun1@huawei.com>,
        "yusongping@huawei.com" <yusongping@huawei.com>
Subject: =?utf-8?B?UmU6IFtQQVRDSF0gY29yZWR1bXA6IEZpeCBidWlsZCBlcnJvciBmb3Ig4oCY?=
 =?utf-8?B?ZHVtcF9lbWl0X3BhZ2XigJkgZGVmaW5lZCBidXQgbm90IHVzZWQ=?=
Thread-Topic: =?utf-8?B?W1BBVENIXSBjb3JlZHVtcDogRml4IGJ1aWxkIGVycm9yIGZvciDigJhkdW1w?=
 =?utf-8?B?X2VtaXRfcGFnZeKAmSBkZWZpbmVkIGJ1dCBub3QgdXNlZA==?=
Thread-Index: AQHY+KNJ3Bf8c/XyDki6sLURxL9Fr65AYXCA
Date:   Tue, 15 Nov 2022 19:35:03 +0000
Message-ID: <21af6b11-d6e8-6f37-7d3d-b548dc7f5330@nvidia.com>
References: <20221115040400.53712-1-hucool.lihua@huawei.com>
In-Reply-To: <20221115040400.53712-1-hucool.lihua@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|CY5PR12MB6551:EE_
x-ms-office365-filtering-correlation-id: feafc7d7-342c-4b70-55a9-08dac7407e34
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EbtdgBjHboZ1onW2OHaC2AV4mtD0tdPLcIhB2sapMNnDnW3ScNVW/xPZrG1DG0ma9aLWsQI5ABSiA1nhgPgGny2ukcR1K99dthr5CUPvyg+Er4wIvzhFA0eDHcNHP4AzjZrLwDNfdSNDgy0n2vLfKTkgAlQgpBYwJEnTCDJOc6EpkzPKnengxSPAIkMcpwSz6kgOAbOpneuDdWktXxtVvEGwxpju13h5j2aCyMa023hqWoGdTx52SBgMduy3O1rMUk8qtABII506Gv23I6EikwSaLqdWPK7tWWU3KSvtIa02h4mMLfQ7X/LKo9udTFfBcA0QSRpeRKAgBCcb/YxMFQrVg0weQfQh1inBUp0Q/6l4C8uv5dPz3Vc8TvaHCVs8j6UXzjptAPqLsxSNgCz/cJbkNHjkX6ot506nigm69YnDV3P+aRy4bTm4/N5ZhhVzA1aRWqqLd0QCKwFChcEwH+0rwu0K4RvymM3Kca6FI3Nf6hSS4u7EmlV5KZRNAJxdNhjU5rSpr+l7xE2srddhPxM+ft3g5fS5QVRA+fSlNs6SOGTcW0LEWdFIdB2STbYp3YyPLx4hQxKQg2WvzBptwtOryYXCy1qn+wUMITw4cPEqRjIpur5K1VTLpXbTFG6djNspFPXmqIwS1DA8ZtZoy5BS8jSW+HSHysQIqhSIhZeT7jRewLVMtH46CNV8mGWQ4xsNE5vu8LT6Y2QOS+eu9j0BKc51TE5PG5Fvx3ExRygRP+JsqkOsids5hpdb74Z+FL5FWjtCkRO37CtvQnCI9A4wZqTFfqN04uye1ITqyyU3HNwfUHDcr69DOseq+6tl/Ewk3R5A5naf/e2CaVSAuQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(346002)(396003)(39860400002)(376002)(451199015)(36756003)(31686004)(86362001)(31696002)(2906002)(478600001)(122000001)(4744005)(8936002)(38100700002)(38070700005)(186003)(2616005)(54906003)(316002)(110136005)(91956017)(5660300002)(6486002)(64756008)(66446008)(76116006)(53546011)(4326008)(41300700001)(66946007)(66556008)(6506007)(6512007)(66476007)(71200400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZEtzdURlZjJta1oydndWUkFlSzNnVmhlNnlRWUJ3YXV4RkFtbTJRdStCU3hI?=
 =?utf-8?B?ZURKMzR3b2tDRitwNGs5SUtDZkJKa2FESjhINTJiUWN6UmdwbDE4ajBheStq?=
 =?utf-8?B?bVVrTFhDOGJLbE1tcDBNMS9jK2VrQ2FsNGdPc3ZjSHA3ejdnaXRRdUVlV3hi?=
 =?utf-8?B?dUJaRC9pd2VHRFRlVWl0bnZJcGNnK2RYdU9pbVdoUFkzNFlQWXJ2WktzdEFt?=
 =?utf-8?B?RFptbWdJUkNKTk1nRmtXSWJkdnZ1S1BVTVJVb09qdU5hRUJWTEJtUDFxOVoy?=
 =?utf-8?B?MU5GYmhMUG5sajM1a0RJMXRGSkIxbzVKWDJqSkhiVEZ3TXJ4WnZMaVdTWWl0?=
 =?utf-8?B?dGpjU1l0MkV5aDkwQUI0Y1c0ZEUrVFhxOU5PK3REVEEzbjNHTlZDLzlNN0RW?=
 =?utf-8?B?bXdDRVhGRWNjWWJyQm5OVkdJU21mTFZNam1oZnJNUUE5WFZGSXRlK1R2djBm?=
 =?utf-8?B?bHpJRUwwbStVZzIxWFlZWlVhdnV3aWh3R05TVk5TSFB5QkhyeHlhNmFMbjZj?=
 =?utf-8?B?SGRlY3BFak4rQnR4UEJ5NEg3VXdhU0pSa3Q4ZWFDb3BBVWZRWENybE5QTkxw?=
 =?utf-8?B?SSszeU9HYjFDelRQNFR4Tm1ab29MWXlFY0JkU2xsT2VvaDhCK1RwTmdLYmMy?=
 =?utf-8?B?aEc4SG9LQmtSNGJJYVFKL1NDa25CTWtmdkVBNEFHZzlWN3RCK1dvN1REZk15?=
 =?utf-8?B?UUc4WVJhSUgweFkxVEdhUVBHVFVBSzdVZlMzOVNnU3p4bm5DMGdCbDNvQkxO?=
 =?utf-8?B?ZzVxQllRTjlZMXhvdjJQRSs4dVIrRnVZTUlkTlNkelZnMStWMTVZaU5WdVhq?=
 =?utf-8?B?eTVuMmQzWmd5T2tTVUdTR0Z6MyszUWZmL3pUNzY4cmo5VzEzVlhEelhXNkJB?=
 =?utf-8?B?NVhkWEJ6cnoxandzM2ZPUnpsQVlRazN2RTNJUFZ1eGdObjFZeTNNekx4bXo5?=
 =?utf-8?B?SlQ5elpJMTFCOENoL2xZR3RvcklZM0dtOUYyTkpyM3J5UVhGSUNwZDZoczB4?=
 =?utf-8?B?eVdrck9CSWNCcEpmQ2MyRHFyL0V6aVFuU1dJV0VsVHk3M0xyZTJLRGlyWUgw?=
 =?utf-8?B?MnZJM2ZRRUM3NkVXNDZPaTlGQUp4dnpMYzN0SWpEQk9BNytPbFU5ZlF3d0xK?=
 =?utf-8?B?bXNkdGhqSkpJQTIybUE0aWFWQVpaNm1kb1VjT3NYMlFybHcwNTVSVFU2Nmp1?=
 =?utf-8?B?SHBXUGR2REwrMUExeWxnQS9FOUdJRld4cE02VEJuOGhEdG13aStOYkV0aXQy?=
 =?utf-8?B?RitveUdVZmFVTFFXaENEYUpCY2FYRThIQlJGN3gydW9JcVVvcHNySXYraUJJ?=
 =?utf-8?B?bG0yRE8raHNlN2g4ekdyMWVPTmJNdCt4ZDlvdDFjZnUzZDhOcUdQZk9VbzZq?=
 =?utf-8?B?elFxV0xjc1BSdllPTm1hYllyQUsyT1crMzg4VHpvU09sK0lBcTEwSGRveFky?=
 =?utf-8?B?TEtpN09TOG5hQ3dENTVUaStXUmdhVHRXK0VSS3JqdDJKdlYzNFRwMUxlTndI?=
 =?utf-8?B?WFEwSDZnMXNpd0k4MjhwcjNYWjJlSmE4K09wZWlxSktENjc4VERNaURsTFZH?=
 =?utf-8?B?aTk3TGdWK2o1dDExd2J0c1NRb3BKSEprSit5SGZWeWlEdkdLdFFEeHdxYStS?=
 =?utf-8?B?Si8wTEJsb1ZBMkZVYWJuV0ErRHpmQk85c0VSR0RrZ3llZmdabnJPVlE4b0RJ?=
 =?utf-8?B?T0pXZ1hCN090SGoybldvWFpwa3ZXeHFRRXNhYU9rWktkSy9WYXVhLzR0NWRa?=
 =?utf-8?B?UEVLTWRjQ09SM1lXSWpCQjV3ZFNSYmJzVWhVUGFwUUwvNXBkZ24xZ0x2U0hq?=
 =?utf-8?B?NjdYYW1DWDR1SnZJV05HenBhSGc5eWluVXFxalhpNU52dTJodmNER0V4K1F6?=
 =?utf-8?B?NGZsOFQrUXpRQzRYSE1BemZvRUU1L3Z0eXBJYWsveVpUVG5pTHZtS3pacExx?=
 =?utf-8?B?NHF2SE0zRVlaTnlhU2F1ZWVnVDQ3S0Z6SkxINFQrMkpzWnBxcEQrSVVKVFha?=
 =?utf-8?B?eE45Z2hRcXJ0K0hpMG1Td1RhVXVvR3Bud3ROTjB2ZEE0TDMyeURhb1JOM0hr?=
 =?utf-8?B?LzQzOE45THRHQVpaZzJyQi93TEFOZHFWSGJvbTFsQ2RpQkRTbFB5dUlNZG9j?=
 =?utf-8?B?RVBsOHhJckZnK1BYNzJST002cnZUZ0dPbm1sNU5qQkhXRXJwWk9SeUZnTWdn?=
 =?utf-8?Q?rWlbC9F4uJclSLeM7RyBDwKp/+UWg9r7ShT+HVH2Md1L?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <658F0E709D9A9D488D1773E138E18A70@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: feafc7d7-342c-4b70-55a9-08dac7407e34
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 19:35:03.4914
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TEgWrFWwZ2XJPKD99NqyGaDdjh3m40LVeTjMP6W4UA8Rm+OXVm2NSa4tSlx+jmk3LHSE5iJePXnh+xnf1yFxMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6551
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMTEvMTQvMjIgMjA6MDQsIExpIEh1YSB3cm90ZToNCj4gSWYgQ09ORklHX0VMRl9DT1JFIGlz
IG5vdCBzZXQ6DQo+ICAgICAgZnMvY29yZWR1bXAuYzo4MzQ6MTI6IGVycm9yOiDigJhkdW1wX2Vt
aXRfcGFnZeKAmSBkZWZpbmVkIGJ1dCBub3QgdXNlZCBbLVdlcnJvcj11bnVzZWQtZnVuY3Rpb25d
DQo+ICAgICAgc3RhdGljIGludCBkdW1wX2VtaXRfcGFnZShzdHJ1Y3QgY29yZWR1bXBfcGFyYW1z
ICpjcHJtLCBzdHJ1Y3QgcGFnZSAqcGFnZSkNCj4gICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+
DQo+IA0KPiBGaXggdGhpcyBieSBhZGRpbmcgdGhlIG1pc3NpbmcgQ09ORklHX0VMRl9DT1JFIGZv
ciBkdW1wX2VtaXRfcGFnZS4NCj4gDQo+IEZpeGVzOiAwNmJiYWE2ZGM1M2MgKCJbY29yZWR1bXBd
IGRvbid0IHVzZSBfX2tlcm5lbF93cml0ZSgpIG9uIGttYXBfbG9jYWxfcGFnZSgpIikNCj4gU2ln
bmVkLW9mZi1ieTogTGkgSHVhIDxodWNvb2wubGlodWFAaHVhd2VpLmNvbT4NCj4gLS0tDQoNCg0K
UmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0K
DQoNCg0K
