Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D026B1860
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 02:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjCIBBn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Mar 2023 20:01:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjCIBBm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Mar 2023 20:01:42 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606F9B7DA6;
        Wed,  8 Mar 2023 17:01:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MAuCkR8bOep+D+x8+fP4iEGgzCbl6knfvlHSk+PwnWBGWp5aONuRu186Q1wHos9ZOVllUtj3gR9pvuQt33XPpADOjE24Lqj1JRxOFQOLve517nuxLJjb2lgF5ESiQmnZRDUKqnIx37B/feERuj95agdjrPzS7Um9C5zmZQM0k1hfbdaqysplA/JFk8GGngNenmv2oC4SM8N8iWuUEueNd+7urRi/xGTS8TrQ529YMkvEN9O/1tSSsj81iRaH9pfIgjmRP+pOk3ofXSpPJNS50IWMEaUd8OFYjOu0YidroWs6ql3ts0VxAFsO1O7IGdPF6xRPVR+MC1+xhmwMecsYQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xhOu2lk03W0FuAn54nJ5cLtDQpDzA8Ymlb2MZirIJFA=;
 b=nFI1FzCwpgCGNJ9HoM8bOHXNR6x2DJljeW6KawtKYSju753/OewEQ60ZFH2XVhe/+rXaoaSJ9NYr4UJcyXXAM/64JVzHbxf23s+5F3Tuq39FvW2caMRb2Lafb5LIIpL1H5IKbgAIhcjymytAT4v6ghxvbPSP1mqwhfV4TLs2UT3bKlQhegpUi9ZASYXBR3kExETUfbbEm8ZaWvNSkGYQNaMnH+JZzZ1k6/RoVjBIMkrTRyK+B2/Mv3OgjoiE4mkxTI1j/UrdNcnSYCLoyNL0rdsA5HJiab2Ukg3HoK8S0tN2XZiGD4FEa6WL1DZ9yoM9ZQxJjY65RhO0s0tHl9uQGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xhOu2lk03W0FuAn54nJ5cLtDQpDzA8Ymlb2MZirIJFA=;
 b=NP7kNHZ0vUk39Oz1gMItl1D2Ev327saVKC2Ng2vEjWPJWd+PekT6qob968FgMHzUdlb9zeXtRGK2ehGkwjnv+A0sdFJ7mj0gA8l0fJOTxeF4JtGSudMKvfbaVBegBxjJ0mnGVWXUo1Q74ooKxfGDDw4cn7zkW2roChOR2Ki6KrxlX7INx5KnhdOLJiQIkT4LSFSKuJbb2GeTklM4dHmwkWoMOD0TDvI3GCEeGDLheuMdJUPwIcOGWf8CZfeChEyGFwwHp+Ao59j/UdlIamJjMbP2XQvVnK0Gc6Lfc3BWqDq40nluLoc2B0xbttDFBAldgjflIqEHP4CC+wYT62oghA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SN7PR12MB6713.namprd12.prod.outlook.com (2603:10b6:806:273::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17; Thu, 9 Mar
 2023 01:01:37 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c%3]) with mapi id 15.20.6156.029; Thu, 9 Mar 2023
 01:01:37 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
CC:     "brauner@kernel.org" <brauner@kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] fs/locks: Remove redundant assignment to cmd
Thread-Topic: [PATCH] fs/locks: Remove redundant assignment to cmd
Thread-Index: AQHZUY1+hmu4NxUx1katbaYvGGTY5K7xokkA
Date:   Thu, 9 Mar 2023 01:01:37 +0000
Message-ID: <c419644f-cd79-af86-e455-0052d5287ef9@nvidia.com>
References: <20230308071316.16410-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20230308071316.16410-1-jiapeng.chong@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|SN7PR12MB6713:EE_
x-ms-office365-filtering-correlation-id: 354ccdf3-d141-4ac5-b141-08db2039d596
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N9YYTLnMLTh1D7l5i/lAH6QhDxckryuUsXzgc4PaaNdDMnlrCKXojtELZJReWwUK4wPKPEsx+IU6AEDa06KetzM+oHRbhzMMNnt17xi/WhxfQi9Deo9q9yxfCdjqghL2y3cUoOldw9bUhkDMLdstgCQ5SrMoB3LPfgpM5xhoieZp4d7qXeAEySP44e17CTy3i9yqPiWhFj2W845+Czho5GlHN5pda+qaY5t+4OLQABFuqdZnazXTX1+JwMvgOOLuGSAwcUi77ZAyBwZTXUsVeThXG943NOGXezYm3QlkJKShGNTKDZdmBLn1ycq9aMDv3+ZtovNnAMvrMHJmNOiXESurv9XRqygrSFq0qNb+ReHqNoNjJ2xCEkDRi2sJ7WYDsi6nHs9R2Zl5xPuYj50suEjDLuc3GKX2w55f/PTsY87CWoB1+XG1p5zuPnvQWZSwJa029DHB0XAFfbZkdoM8gr/ylL0Qm0DqqNoXv/AMaGxeCIlMUPM1u5PrYMHA+dEWvbuTjtXBxQsgG8zIUbHAt4ej/pWtPRsO3hK0TJ5S1AQ7BwxGuv52KxNKAUnnH6wgCtqByq72ofPNAs/WIIToS4AeGeRN76GfPEMZ5bs9aqjUYF/51yUxntIHXNmYmez+2PVX4b5SPnd6DCzYiY8TrYYWPGligYrX2RYtjNo4V+AKMQVWV19+yWw3dkHsyyi3hJqlP9269tlFXdYumxgYeyWtWkYM9IanNq6fGqrY7eeDyHw9HHQ3fKpFxqgz0OQl+0vWjfyf8dT56NOsbNhBw9+1khlhSmOYjJun6LO1JN8DzAyC2q6nrSbDc0q/Sqpw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(451199018)(38100700002)(31696002)(31686004)(316002)(86362001)(110136005)(54906003)(66556008)(8676002)(66476007)(66946007)(64756008)(66446008)(122000001)(76116006)(8936002)(4326008)(91956017)(36756003)(6486002)(38070700005)(966005)(2616005)(478600001)(4744005)(5660300002)(41300700001)(71200400001)(83380400001)(2906002)(186003)(53546011)(26005)(6512007)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cEw2bEZvUUJKM3hWZ2wwNjh1RGlqUEJOc0diV2tGa1lSVnM4d3YzNFRrbjN2?=
 =?utf-8?B?U3NqNkZFNGoySHFFc3BJTy9DTmtxU3prR1U5UEVGZnJDSlY4MXhkMGhBRFdL?=
 =?utf-8?B?b0F1a2Y3ZWJlNjNibThackpPMThmWERIL3FaSGNoZkViNVJ4R3Ywam95Y0tO?=
 =?utf-8?B?SnhsNkNDR1dYVW9OK2VpMG8rUkNBbkpnRVAxSktZZTZPMnZabkhpUitTT3JF?=
 =?utf-8?B?bkJqNGZsRGo5MGlrL0N2UlIxM3d5ZEw4YVVEbEcrNytrSVpyZ2QzMHdjVHpO?=
 =?utf-8?B?dFJsY0pHdTV3SDQxejI1OGFQUXZFM1lkK1hnbVlYNkkvZTdyQVhsZmdFRjJY?=
 =?utf-8?B?L2I4T3ltaGUzVXFFR3UreXRvQ1pQQ05vVnc2akF0UEgyVDRkbThGTDVBdllu?=
 =?utf-8?B?c1doZFlBNHBFSS8ra3NaUVVzVGVubjBxZTJoZnJOTldBQm9nZXNwT3VRVzdO?=
 =?utf-8?B?K0JCWE1QNGJ2a3RBWGZZclJZK3N4TEx5bm5ablpvNlMvV0JvVWNCQzZDSFBX?=
 =?utf-8?B?ekR5L3pBT0xHWEZnMnZHVk0wdjZ1T3VoaFVwUWtEQ2Y0a2wzam1iOUpCNkRj?=
 =?utf-8?B?OGhhUEw0Mmw3VXNrcFJQa2tDTXJwdGliRUhPenVqeWNzdHU3Y1pLcUR1T2hn?=
 =?utf-8?B?NVd3Q0Q3dXFGR0U1aFMyKzJSWGJnMW9hRXBmWTBCSmRGSEJHT2FhSTV4RUZW?=
 =?utf-8?B?NlFDV1FSblRha3NkMVllNHU3RGhTTXlpM2k2OTl6TWp2M213ZFlwUzlkSUdQ?=
 =?utf-8?B?c04rcFRaajFwMlJWR2ErZG9YMHFUdVI1aUdlZ2ErQ21FZEt6UERJVFFZVHJP?=
 =?utf-8?B?YkFQVkdEdURrWDRBUEpWbTJGTnhwVDZMU1pQYm4xb0xmUS9WVnNpNDZaaEhy?=
 =?utf-8?B?RXlSamszSmhVZTloV0dsU0ZGYW9TR0lPMnh0c3FJUXJodVFITXp0OGVNbGs3?=
 =?utf-8?B?Y1R1ZjN0VEZNY3h0R2lKVmtsU3hpeXBxaGh5TXNyV3VDT2FYMW01dmZQOXFF?=
 =?utf-8?B?aWhwOHpBVkl4eUtNR0FySVoySDFSK0xmYnJid0FyTGx3cVF0QVJQOGZQTEFJ?=
 =?utf-8?B?NkFtRGVmV2dYKzR6ZHlHb1Q2WlJ0UG9jVzVUa1p0U2RMeWRtMDJRbjhxWlZw?=
 =?utf-8?B?VlZESHRNaFFTRy9TeDRtQ0dWR3VlWWp2Vy9LRG9NUW56eEJHUUlQN28zanl6?=
 =?utf-8?B?cDFSSXFsczZhQ1hSditGUlpNSVp0UytHclVjKzNZS1h0YWtDcjEwL203SzhG?=
 =?utf-8?B?bTVzNnYwUjNleVFiVDMrMk05NUNnY1IraXZmUHd1SXR1bFRZVFlIcllIZWpO?=
 =?utf-8?B?K2ZoWWpTd09MMnJacWhqRVhnTnJjNzhTOUt0UTV2OVN0WW5KVzBuaDJ4V3pN?=
 =?utf-8?B?Sy9WYmlCYzk0VnlGMDZSNUxTQmNnclU1L1BocC9pd1B4NTljTVlPODhCblFR?=
 =?utf-8?B?WlQ2cGlKRm52dHcxOGdqalNkd0RzNkJVajc0ZEh1VkJQT3JSZGc1aDRORkcx?=
 =?utf-8?B?K0hvRk1NWUs3NTZJMk1kSXFVaGJZeXFsclAvQ1FXL0lyLzdIbjBtM3diNXIw?=
 =?utf-8?B?YzNJVms1d0NaU3NtUmZrT3RzUDlmRVhXd2l3MmRLOFAwVmtiUWd2RnFNSkhX?=
 =?utf-8?B?L3JTa0RraWZNOWZ4YW5DeW43MlYrUDVFUU9SVTBkTzFRNm51T1lDTlFJOWZz?=
 =?utf-8?B?UDgxKy9jRFdqYlVIZmtSSnd2M2dKbjEzYW9tQU9DUlUyWTU2Y2lGVjB1bVNR?=
 =?utf-8?B?bnpRKzVVbVdVdU50TExCTDRnSC9mMzJvM1BJbng3V3lkTEdHTmc4cWhGbmND?=
 =?utf-8?B?UDM2UkFERW5tOHZxUC96MkNuYytabWF6Y2JaWnkvNDlldXVOUi9YTURBK0ZC?=
 =?utf-8?B?ZzBZTytYR2lNRVRhOWhmemgrZmlKeGJnK0d1L3h2d2U2cUI5dUtobUhRYW9V?=
 =?utf-8?B?QzdVOHorb04wOXNUNnFneDNMOGp4L1pxYlc3Qkc2STVnUFJnNXV3RS9Sd3Bq?=
 =?utf-8?B?N2Z0aFVXeHEyS1M4bE13dW5MWkpuT3pHWmVwckYxdnRZRkpjRkhqcFI2TnIy?=
 =?utf-8?B?S0NHRmQwd2RTV2I2WmpYNnk2NnBTL1laeFdWWXpOZDF5T0xhVmw5YUlvSnJV?=
 =?utf-8?Q?6JtIaudyWhn5/uW6Y250jl9Yj?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <51069DD37C35D94D84F7A147AD1261F0@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 354ccdf3-d141-4ac5-b141-08db2039d596
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2023 01:01:37.1392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hNySpT16ku05TCBfcHKGstYq2YaR4P2Bgg9Ridkwj69N2snkZ+O+FfGJHAIFnNE6iYF55Vp2AWGwfuWUery9hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6713
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMy83LzIzIDIzOjEzLCBKaWFwZW5nIENob25nIHdyb3RlOg0KPiBWYXJpYWJsZSAnY21kJyBz
ZXQgYnV0IG5vdCB1c2VkLg0KPg0KPiBmcy9sb2Nrcy5jOjI0Mjg6Mzogd2FybmluZzogVmFsdWUg
c3RvcmVkIHRvICdjbWQnIGlzIG5ldmVyIHJlYWQuDQo+DQo+IFJlcG9ydGVkLWJ5OiBBYmFjaSBS
b2JvdCA8YWJhY2lAbGludXguYWxpYmFiYS5jb20+DQo+IExpbms6IGh0dHBzOi8vYnVnemlsbGEu
b3BlbmFub2xpcy5jbi9zaG93X2J1Zy5jZ2k/aWQ9NDQzOQ0KPiBTaWduZWQtb2ZmLWJ5OiBKaWFw
ZW5nIENob25nIDxqaWFwZW5nLmNob25nQGxpbnV4LmFsaWJhYmEuY29tPg0KPiAtLS0NCj4gICBm
cy9sb2Nrcy5jIHwgMSAtDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgZGVsZXRpb24oLSkNCj4NCj4g
ZGlmZiAtLWdpdCBhL2ZzL2xvY2tzLmMgYi9mcy9sb2Nrcy5jDQo+IGluZGV4IDY2YjRlZWYwOWRi
NS4uZDgyYzRjYWNkZmI5IDEwMDY0NA0KPiAtLS0gYS9mcy9sb2Nrcy5jDQo+ICsrKyBiL2ZzL2xv
Y2tzLmMNCj4gQEAgLTI0MjUsNyArMjQyNSw2IEBAIGludCBmY250bF9nZXRsazY0KHN0cnVjdCBm
aWxlICpmaWxwLCB1bnNpZ25lZCBpbnQgY21kLCBzdHJ1Y3QgZmxvY2s2NCAqZmxvY2spDQo+ICAg
CQlpZiAoZmxvY2stPmxfcGlkICE9IDApDQo+ICAgCQkJZ290byBvdXQ7DQo+ICAgDQo+IC0JCWNt
ZCA9IEZfR0VUTEs2NDsNCj4gICAJCWZsLT5mbF9mbGFncyB8PSBGTF9PRkRMQ0s7DQo+ICAgCQlm
bC0+Zmxfb3duZXIgPSBmaWxwOw0KPiAgIAl9DQpJbmRlZWQgY21kIGlzIG5vdCB1c2VkIGFmdGVy
IHRoaXMgYXNzaWdubWVudCBpbiBhYm92ZSBmdW5jdGlvbi4NCg0KTG9va3MgZ29vZC4NCg0KUmV2
aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoN
Cg==
