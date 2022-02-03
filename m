Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56DDD4A7CCE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Feb 2022 01:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348513AbiBCAZF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Feb 2022 19:25:05 -0500
Received: from mail-bn8nam08on2078.outbound.protection.outlook.com ([40.107.100.78]:36320
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239246AbiBCAZE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Feb 2022 19:25:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=grIxTSKnQMufEYPzP+fWmMX8WQp+xscboHqqhmM6YAYgVsvqF5J56D32Rl2AwpP/jY4cGmWUipGeQI51kW3h23gKHgTF39lZ9ELmQApZYMW+GOtUKvJPra8feq3cAgQznm47VXygsVu8OX8wCad1nnD9enHNidPVEEuyh6nMTxufDj4wKxO04AXS6iGqH7rioF470ohDVvYo2CaW7YPjFWFNbVgAsu+N7HlElqrl2docznLGfHBzCAW0R2ldJUaxiqRxmYPZQQJtVBGRDtUppPTyUrLxx1AwtZIgjJsQOupuq8bf/6W3QZSmqEKMNb9B+AsMVim5jmHDH+1SsJbj8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/H87e7hpxsXXZlGsqtGdZ730IlOCdfdPC8I899PpPo=;
 b=lgiKLPC/GSFWpq1nT8SraVOGT2/rxg7NiigN4KSjq5T9Ijy5YoL9Xh4JPumaZLdK2uE5AIr59qCp0l5K1lrg9pq7mjDZ5IWpMEwALzNZxLSB9tOBIumdyUCE37NFD4cjMnS3wmiryFNS5LG46y4MDtsZZ5y+PVunbRK9+CRdKf+UDFXucLHLEEKQUKfG9uzwJqbhVtZj2HYh0PmPVAIjD09xWBTgNMDeRFj1ItGa/ZYzz/U9LqRuPv66mdHGSoU8on0X6V3BiWl7NFD/aeuX2u2PMLoyKo9TxRAPuSHBTwyAJ1tucJfSgqq/rfzkWYZ9d4c5rkgi9hhJmhcrlBrOLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/H87e7hpxsXXZlGsqtGdZ730IlOCdfdPC8I899PpPo=;
 b=kOpVJvV9WymMBIfvRofo+32eP7m4/moEXt5rKA9jAVwR2WGDnTPlZMPWFNIGzJvg2z6tXJ3/p1/emK8vpp/NKyNZacL2HUf6bEslFh7d3TFqCU39bFY4sT0g17FGv4DYCYAAagNcldUmMiu/LroZ61ZO6tzZ9ItBLArcj/orIqvANVZ7d0babu9WX1GUWha0RfGXh95g/JqYr5KFGnbzbfLPe/G/UWtpF7cXLG4xyokAm+Tiu9THhJZ+FlJWExiOP2YfE+1fqqV7HLt7o+kpFlVqlZf9XzanmbGgzHu4mS9w6qEQMvWTbNNvsTdq/iel/ObF6a0IHqrtTNaSzdgs+A==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CH2PR12MB3765.namprd12.prod.outlook.com (2603:10b6:610:25::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Thu, 3 Feb
 2022 00:25:02 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35%4]) with mapi id 15.20.4930.022; Thu, 3 Feb 2022
 00:25:02 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Chuck Lever III <chuck.lever@oracle.com>
Subject: Re: [LSF/MM/BPF TOPIC][LSF/MM/BPF ATTEND] TLS handshake for in-kernel
 consumers
Thread-Topic: [LSF/MM/BPF TOPIC][LSF/MM/BPF ATTEND] TLS handshake for
 in-kernel consumers
Thread-Index: AQHYGD7dr/MpUlMoGUeGOVN3qgAeSKyAvowAgAA57gA=
Date:   Thu, 3 Feb 2022 00:25:02 +0000
Message-ID: <0ef97873-5926-2940-9d66-3c180b39bc01@nvidia.com>
References: <3a066f81-a53d-4d39-5efb-bd957443e7e2@suse.de>
 <2640b631-f8ac-ab4b-5ff1-884972f25334@grimberg.me>
In-Reply-To: <2640b631-f8ac-ab4b-5ff1-884972f25334@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0c8f90fd-7b05-40d7-9437-08d9e6ab9eb7
x-ms-traffictypediagnostic: CH2PR12MB3765:EE_
x-microsoft-antispam-prvs: <CH2PR12MB376585068DDB99E32B3710D1A3289@CH2PR12MB3765.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vOYOt1gVVm3rHI31+z9zJipJWKUpzBeCS12wbdtX+ApqbXXBQ3/1/vS3BKMbVee1yLFlOVtI8Zt2ZuR9czXB1bDWYfiVGPwTs1wQ0YyrbUCw2KTU0x4e+NHyHKMFqQhPzZvI4TipDe6aDK1tKEtTgKVC/dMNlPZYUJjzth/JRQGIWMeosxbSMTYVmhgf0YCSEBd9+112IZDmXkvvHEj8bJKXhAXfQHVSQy+6qp5u2PHOc9J2Y1qTS+sAK8jgPRNTe/cFpmzY5ZAIJ4KynRdUrPG8jtO7mgfzM1B5WJh5U3E0z017lliQ/731j+Bb9GXEB8hBtmvrCqmGAHYHeILJ+judQwVml9iodUQbiTlo8WCunHpge2sH67LHOJWXugoR1evZgRZzFPaxd6BgHPhYKdjQfcg1g9GZv1UpPapdao2WEak4dCsYz1FKl9uTQeaov5DQ2e/llsCjwu33afZvcVLf4u6gSHHqbE1WAYn9ql7dAPNO8R6yW4rDIlLzVX5HHOzf6RLWvfgmXs8hILjY7kVdRvBK4v3iyy5dvRkmIGQyW23YCNP8Q7hCe54kZSl5pLXXHRVyvPLMP5eBZWGfeL0rrLDi+9kEqmI0z6Ea/pxhTND0OVlR13wXHXIrB7DRAq6idyLFhBCp6ToCr3xpaotdbMWdzJyd2kxQqUL3PXPNMZw15q19sjqHXUTektBl8/f53/j3mII4UZUSCGm59mwB4NBJ7D0EwU1aOH9lRB9PDgckLGlVjCPQgx/ovz7sO4fP0jy7NidAJ8LE3YJ5kA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(66556008)(8676002)(8936002)(31696002)(2906002)(86362001)(38100700002)(122000001)(66476007)(66446008)(66946007)(38070700005)(64756008)(54906003)(6506007)(316002)(76116006)(91956017)(508600001)(6486002)(110136005)(36756003)(4744005)(31686004)(6512007)(186003)(5660300002)(2616005)(71200400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SjFYY2JjWTgwdkh1ekFQRzlQKytzdXFvOGVKSHZ2U1FscGUyRmJrT3hwWGJo?=
 =?utf-8?B?TnFmQmJmeWdYRk0ySUhURlhWNGN1N2k0MEFRc3NQY0NVejNFNVg4UHZTeDdW?=
 =?utf-8?B?cXZFa1R6bjd5ZzJROTBldFdrVktXQTFjVVowdldMTDN3M3RJWU0xOUhsRVBD?=
 =?utf-8?B?dmR4YkxoMjNGbXplMDlrQTVsRkNMNWFCVGl1VXliY1dGdUtTWlFCREZTWngy?=
 =?utf-8?B?cGZ6RnZXWEphRFlIc2w4cHREZ3NlanJjTTRpa1BuSkJvTm1DSk5oaG5KcU1L?=
 =?utf-8?B?Vm1yME5mYm90d3huM0poUC9JQ1FVMjlVaGhqVnMvV2lFUTI3NitvVWVJUzQ0?=
 =?utf-8?B?d1VFVmFPSkhOdVZGVUc2STJIdkdBckFvb0lsZ1BUTUZ6MXFuSDVoRTlaSkRp?=
 =?utf-8?B?eFczVEdDQmlwaTRVcEhTUTBQQlErWUtHRUFLN29kR2FZbEk4OXE4cDR3b1Uz?=
 =?utf-8?B?cS9lYWxLS2NNQXE3dnBBa211c3hjUi9RU2tSdTY3MTFYMm4yL21SVXQ1UG4r?=
 =?utf-8?B?NnhnTWNxOW1ZaFI4VCtUSE5DT1l4NVRpcFdoclFpbWZyMnh4NDFTWHZ3dWg1?=
 =?utf-8?B?cEp5SkdnQTZqNG5ScklNcFI5U0NSeTRxYVprRTEzdHdNaU1LZU83LzhMVXhT?=
 =?utf-8?B?b0NwWXpxUUlmZzFPUnE4eWl0WEhRU0MrRUdoWFFzOVVpMzd1U1lGNWpxek9D?=
 =?utf-8?B?cUtXcFdVQjI3U092NjMyZk41bW8vNzN3aWtjMHE1YjlpU0EvODhQTXZTVDhE?=
 =?utf-8?B?bUJkUnFScFNrN0hMRU1zUlNCWnVjVEcwVDdUcGVDZkJiZnNCV3BhNVJqOEhk?=
 =?utf-8?B?cHd5OXhzNXdEZjR2ajl2VWx6cXdEOWEvSEZFTVBWQmxEcjR6dXRjbDJmbjg3?=
 =?utf-8?B?N3B5UWZDY2w1ZjVSVk8rZU81Zk93NUNaNjZUOFZteCtIa1NOWVVFeFB4dnQy?=
 =?utf-8?B?NFlIY2JPMTdDRnBXTVBMZ2xIaXFKVitPOUpyZXpqcjZVdlkrblpGUE52Nm5s?=
 =?utf-8?B?dVExTFdGbGVCUitnTW1ROEY0dGpuQjkxMzk0L2crMEkybTBQcmhvamE2WG16?=
 =?utf-8?B?SVgvRGR5RExCRWVBeUhYWGNlYlg3TWt4L0xBMGFtam8vSjRJNi9pZndVd0Fy?=
 =?utf-8?B?Q3Vrb0l3S2lzRXFLVjZUSmR1VTFpTGJTS3llbGdueWlZb3VvRktCb3ovRzNJ?=
 =?utf-8?B?Tzc4TjQ3eVZIamt1Zit1Y0pHaTN6eHRIa2FWRFhsenUxRVVOVlV1SDZObExy?=
 =?utf-8?B?eXpRUk5MNlJZc21yVlZVQXRDK0E4RUJmSkNUdWZXZ0VYUmx3dCtIc3M4RnRl?=
 =?utf-8?B?N05IWXMxU0NZQ3B3cWg4V3M1bk43dU5wRHVJb2Zxa080dlo3TVZhMldBUFQ3?=
 =?utf-8?B?WXNlRWlrenY5ZDlzWjZmamdzZWlVK1RuR1NINy94ZkJDM3IweEJaeXhYZ2RV?=
 =?utf-8?B?RzN2NTc5TXhuRG5oY2RESHdiVnRhL0hET214K3p4aTZFT3M4THBUekxCTTBD?=
 =?utf-8?B?bzNUbzBHSGJYYkZDZEkwY3VLVkRVT2lNZVoyMEswOWJDZWlOMFl2bVEwMjBP?=
 =?utf-8?B?NCtNSFFTSG55NE5WL0t6K0NJbDB3VFE2UU9CNllaMDQvYnV3ZmovQ3Y3cGFi?=
 =?utf-8?B?Vm9MaGlKT3FyOUlyNVVPYzlkTjlpSnF4cFdGcFhlNGIweG5lSTRtd0xJY24v?=
 =?utf-8?B?MWsyanE1UTdqbEkzUVA2U2VJYVp2YlNBUHI4bTBBY2ZCNFd2a09lL0tIVUk4?=
 =?utf-8?B?QVp0V3JFUWUvRmcyN3NSWGxnNFZwZm5weXZNT1dPZVl1SUx6UUdHTnJLR1dQ?=
 =?utf-8?B?clV4cVpwTVNuc3RGdTU1MnZqQjZXeHJZRGtCM0pRemF3TDZTRVdjQjlnUVQ5?=
 =?utf-8?B?eFUyVXR0RWtSU2xhandZMk5heWxYVHBoNWZodjZoWVQ3elo2VGs0SWpDZGNa?=
 =?utf-8?B?dFVBRHp6RExyR1docHY0Ujd4Q3VnbXBGQVdBdUVSUmZZcU0rRE9iSk1pYnZE?=
 =?utf-8?B?cHhqVXZocFI2RWlmekFpRThYTFRsRG5hQUVWanNOTUlNWDBxV2VVQWticHJo?=
 =?utf-8?B?WGVWYVRnMkx1ZWlkWDV2WHZCcjQxRnV4MUcyQVBEeXVmaWFuTkFJNkl5bnhJ?=
 =?utf-8?B?a25XL1dCdW95WE5QTjVDcWd3OXMvWldUZUhNRXFIQTVObndXYVVvdDBwcERX?=
 =?utf-8?Q?p43kFqC8ZltFXaSqD8f9gZWZnmC7k4X5rKM3EU2jtRzZ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <00FE9E25439E854EBF7301A28F1B3289@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c8f90fd-7b05-40d7-9437-08d9e6ab9eb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2022 00:25:02.5169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VAO20ALbdYZL0mAxTh3zJzMEpEOolu/AhxaB/DZxJaFcLHSNRrcBzuE0YlJbvmwtvyahG6MswYohcPixxHmXoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3765
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQo+PiBUaGUgcHJvcG9zZWQgY29uZmlnZCB3b3VsZCBiZSBhbiBvcHRpb24sIGJ1dCB0aGVuIHdl
IGRvbid0IGhhdmUgdGhhdCwgDQo+PiBlaXRoZXIgOi0pDQo+Pg0KPj4gUmVxdWlyZWQgYXR0ZW5k
ZWVzOg0KPj4NCj4+IENodWNrIExldmVyDQo+PiBKYW1lcyBCb3R0b21sZXkNCj4+IFNhZ2kgR3Jp
bWJlcmcNCj4gDQo+IEknZCBiZSBpbnRlcmVzdGVkIHRvIGRpc2N1c3MgdGhpcy4NCj4gDQo+IE9u
ZSBvdGhlciBpdGVtIHdpdGggVExTIGJlc2lkZXMgdGhlIGhhbmRzaGFrZSBwYXJ0IGlzIHRoYXQN
Cj4gbmZzL2NpZnMvbnZtZS10Y3AgYXJlIGFsbCB0Y3AgdWxwcyBsaWtlIHRscyBpdHNlbGYsIHdo
aWNoIGF0DQo+IHRoZSBjdXJyZW50bHkgY2Fubm90IGJlIHN0YWNrZWQgSUlSQyAoYWxsIHVzZSBz
ayBjYWxsYmFja3MsDQo+IGluY2x1ZGluZyB0bHMpLg0KPiANCj4gSXMgYW55b25lIGxvb2tpbmcg
aW50byBlbmFibGluZyBzdGFja2luZyB0Y3AgdWxwcyBvbiB0b3Agb2YgdGxzPw0KDQpJJ20gaW50
ZXJlc3RlZCBpbiBhdHRlbmRpbmcgdGhpcyB0b3BpYy4NCg0KLWNrDQoNCg==
