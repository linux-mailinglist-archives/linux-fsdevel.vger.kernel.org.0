Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 086794BD02D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Feb 2022 18:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240757AbiBTRLW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 20 Feb 2022 12:11:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiBTRLV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 Feb 2022 12:11:21 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081944551C
        for <linux-fsdevel@vger.kernel.org>; Sun, 20 Feb 2022 09:11:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ro7vxYUbHMRfthKZd+BsV24IVXKIN9mYC51bJ2NfL8XQl+cLfjGeUz01cXgnERQqAvpv/Hcm7GZfoWQsTUAZ2p+hPwd9XFR1m0rjZjexXctJFBXYIyFVNSwIStbFw7eNUJr2c8fXpvJQmzZS3qno3KBg/3k3g9FYAfjmBqmHRtrshqpLpmDG+Vm1ooxn5xjHuZejg3i8dHYHnKFXxfIN0nkB/FBWo1QHZvwp78gNWAZoWuoMWmCCbOueIkZNXad+1/AzpcFw1dGFkQ1QgWb41fQTcjyH3XhlRk9QiHfbw1UFPtcUwz4p+z1oIAmL9h7RCPGv8sxDwuHZlZO+VmZCKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/7pjlS0mMBI9fS6VIn2rKDMPVCqfhznd4m/H+dLr3K8=;
 b=H+rTF678H+WjKjtlV2cejQaomPD8SllaCKcDov6h+jHdYfuvmPBPZpjBhJEdN2jPEvs3niBUzSuwe9fKibaerFcp0Jo2fZ/NwcxgWzyQSJKT5esUNcRsNoD9T46A7HDr/Dye4oTPVNLvJr4Y32z29pxuzMaQ5FdxcVMETIAhG8WwEAdwmN0lJW9AJs8ldsy+wbZ5rFTQDN16p2nGtS2wlJOoKDR1BExVX1W1etK1/K1QLcHQdJeL8rhah4+h8YZCqxlquwcdY66rN0lIHj8jA0TaSMoIeHUoKkrCk5lrTXR01nuSqQaiH0j6bj0zPkHCtSaM/7fsZnLqVSwqHNGX4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7pjlS0mMBI9fS6VIn2rKDMPVCqfhznd4m/H+dLr3K8=;
 b=dJf+UvvxZ6ckZFdQqwmvuGdVXY+7v1BrsSb5yV3RDd5+/2GSwpS5V9/2DNNYhUCVuddG3G+zT0wL9IoEM9DIzA1vR3lCRln6uAyZl4fVO4psst/ujmGw5OGadX7NscN8gckvKJYkRGYBb5U7w7jpC9ljibV40TL4F3oVDBL3SIp+YFz14KnR/wZvnpZ7xH8X6joY9H75tIb3xyGV7Y9e64zf6qOG9Gnzi5z6M/AusuyzC6IU5IEoRqpBF5CBTw7O95xjlWxUXQxps9dTscuyE2xGo+5hGLuD484OZwPlZlXCrkBo2c8lekDzwYKxdAQVjpHUbWOgYflaVh5LHJThPQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by PH0PR12MB5417.namprd12.prod.outlook.com (2603:10b6:510:e1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Sun, 20 Feb
 2022 17:10:57 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2%4]) with mapi id 15.20.4995.026; Sun, 20 Feb 2022
 17:10:57 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Liam Howlett <liam.howlett@oracle.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] The Maple Tree
Thread-Topic: [LSF/MM/BPF TOPIC] The Maple Tree
Thread-Index: AQHYF31QGM+6p7IpNUGgCHh+HVxyq6ycyquA
Date:   Sun, 20 Feb 2022 17:10:57 +0000
Message-ID: <d57371b3-ed66-d48a-84f4-23c2dbcf212f@nvidia.com>
References: <20220201150633.jtlwrqfnh4xbhw2f@revolver>
In-Reply-To: <20220201150633.jtlwrqfnh4xbhw2f@revolver>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 472ece92-6d0c-4523-3f1e-08d9f493f616
x-ms-traffictypediagnostic: PH0PR12MB5417:EE_
x-microsoft-antispam-prvs: <PH0PR12MB54174F46AEF64BA9D4B3903DA3399@PH0PR12MB5417.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QpAg9stw7whMnYzVGgpvZiNuOLYLAIbb02TCsvHwwRrTMaa9D756yODZtezQOo/Mo2pN/lLO4twLWYEpY67/CDU5aYlag5ATgkUNPael1U2NXTkOjVjVqzvNPpUylpURvXcgRvG9t5U9Zm94SPl5CW74jntOk7olT/QWOiWz/QiT6lm7GdEsdGmY9mriFBDq2FU/gnNqYlsHTzuTVhhOBgzfG4FOnLXbeLbO+vjk7Bd/HvaqEf+GKcBHWk0K24gRmuzS4/nBt5aec1BzhGCDQRAqxg3j9VWUNOCc/unVx1X9BKPuzC7wcTAUW3x8ftw0jfHW50L31kh5n8C0UJy8uUKXOdoZKqPyO80g9DQcrDHcKUlK+erbHIQ6oEi/Qtwpxoi32ireZLMwrmS7oIB/vEGh2sm0I0WqMoxT1YX8qRobrlBlWYP9Icuav2CIYeVazUAWt0m9QKutg7EPdETxxjIBOUIoTnwffcAnrYCbKVgCGOA3RQbhpqV2Qxj6jAVXRrEnAVuQCwLbPfs460cokgC4yO4xw7xOm6bdS9+prAUheakyt7T0hWvkH/r2nnfxKrOdO0Hcm8j8wNkjRd/IFbdnBNzdBmA57Er0pnjd2aN+W6cIllbVT7BLEjVQ3Bwu7vv2Qv+Ig2SZYKCTEGjF9F7MeESkl6zoz75DBrA8HUCvtg4pCiesbLzFglDGzVRBkaxNPL3FHPB74yp+XmYy9V4BhqbYg+qDuWn3zgCfxZn++FfH9vYtmX/kRBSJqej93zqBFMqOqi7cQU32BQyi5Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(6506007)(8676002)(66476007)(66556008)(64756008)(66446008)(2616005)(53546011)(6512007)(91956017)(66946007)(110136005)(76116006)(6486002)(31696002)(71200400001)(86362001)(316002)(508600001)(122000001)(83380400001)(38070700005)(38100700002)(5660300002)(8936002)(31686004)(36756003)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dEZqZFMyMzlxdVBOQTA0T2tFWUxreCtVTC9UdUptUUc3STJwd05VWnJ3aWJo?=
 =?utf-8?B?V29UaVNULytrSU5YakVYVkNHbzM0YmpEc01ucUhpem1OZ2NMTHo3bW03dmxi?=
 =?utf-8?B?dGl4NU1tN1oxU0Q0SGRaL1gwNmc3S3ZGTTZSWkdteVFZNkRQdlVab2hWdkR4?=
 =?utf-8?B?NHU1SDZNdEZkb25yUWNxSmNXdVNYam9waVpoZEhvZlZqaFNsNnkvNU5KdWt3?=
 =?utf-8?B?VGpSNmJ5c3FSdjg1MGcyVFN1SjgzR3JQU25DOUIxZVlPWmI5ZzFMN0llU2R3?=
 =?utf-8?B?NlNaYVg4QUhwMnVzVGVwelRiby9TL0czTHhKc2IvVXkyUmNKdkVETUdPRGdG?=
 =?utf-8?B?SmE0bk1hQTRvLzFsOWRNRU5vWVF3Ritack1nTFJUWE5VSGJCUXpXcEtXUVRl?=
 =?utf-8?B?SGRpQzMyb2l2NG03VStsY2ZCRmdSeUZJYVNWU0VoZk9WMmdTWFo1L3Rra0I2?=
 =?utf-8?B?eGpOQi9hMFF2OHJVeE9MeGhoOVhVbVZZN0FONWhXdUF3cmVzUEFzM0RsajB3?=
 =?utf-8?B?VGg5dmVvRnZHYTBXYUhjbkZUTkdpRXpmeWlVMEZ3TDdScXJIMUtCYnI5YTRp?=
 =?utf-8?B?c3NZV3RSM2RhbVBmUUpUczlRQmhjNFdXc2RHblhGNEZzWXZyTllQdjZ6dUNS?=
 =?utf-8?B?T09wL1hlQUx3SnE3WXNCYmd1Z2xYMTk5bEhKa0FTY2N4anVONk9XT3hKMnF0?=
 =?utf-8?B?WDA3TmFFQ2dIdFJqY28xMWFGakFGdkZQRzZlOFIzSE90MHpLYjhGcE95aDdF?=
 =?utf-8?B?UHhsSnFIUU8zQWlrdWZBQmZHNnFtSVBtaGx2Qllaa3Jwam1mQzg0RkdnYlpS?=
 =?utf-8?B?dnI5R1R2OU05UGpDZGZnOEZ4Q2dCVlJpRVA1c1RoY1A5R1hXaUUxbDBySGJz?=
 =?utf-8?B?aU5FSFpnQ29Pa1RoZWhncVNNWmxQSlJLUjJRZVdWbUtERGpML2I3Z0VXaTRX?=
 =?utf-8?B?YTRNY2w2b09RZjMrdUxocnA5Z003QmNZa0ZqR1NqQXVSRklTSmZpR0M4RDhw?=
 =?utf-8?B?OGtvb2hlVVhXK2V4MUI0aWQxcTJoTGVjVTVTNnZvd1ZMcytLdldnU3JSYk1C?=
 =?utf-8?B?MFZ5dmF0dWprc3RxWG85YUdMS2VCZUg2ZWdaeWZTcXh3S293bVZLdWs1OC90?=
 =?utf-8?B?TUo0bWtpTnFzbFp1Mm9mMlY3bzhON1dqeHlORENYcld3dHZTa2ZGZHcxWkp4?=
 =?utf-8?B?R2lRWTNaYkI0UHh5ckFQcFJrSjFvdWRzZlI4dEhPV3ZjVGVNN1NRNzMzVDdx?=
 =?utf-8?B?QmwxWUlTbmx4YnY2dkJxbXVEdUNqNE5JSW0xOXZLQ2c5TThlOHJQNDNFUTgw?=
 =?utf-8?B?YUN4MVlTNExVaUlQcnVkT0hSUC9GTmZ1dVlvOFRrd01zVThzcGJQRkxkZGU5?=
 =?utf-8?B?QlNTVWVKcjU1ckw5MnZpaTY2clFrV2c3R1JFSFgzZ3ZCT3VtV3JlcXdMMENG?=
 =?utf-8?B?NUZSVEw2K015QjNmR3BxL1BCdmJheTFEcVYvZW8ybW4wM0pWYmFQbjhlbzNX?=
 =?utf-8?B?OWJiWjYwNDNTMEo3UUU2WHlWczdiTEplbWRkVUt5a05kbEhvQW8vbW90amI1?=
 =?utf-8?B?YjFObEVjSzludEdpbkhZWUhObzRlOGxhU1lLeEVUTVFTYXpGZmpZbjRZTEs1?=
 =?utf-8?B?SFpYbEd4bDJCQjJ0eE9HM2d2T3dqSWxDUnFaeFJiNVpRaVRvcVdMRHdoKytx?=
 =?utf-8?B?N01VS0w5VXVmRllUcllQdmNRdzFVcTBHUjNURzQzekNZWUJDQi9SVitwZjFi?=
 =?utf-8?B?ZDh4TVFIUEFCZWRYbFluUGlxdHZURVQydWpxaWlTL0prditnbDBEYkpSbk1h?=
 =?utf-8?B?OUpwcEpsWlR3dFRDaC8ya2NhNXZDaE11ZWgrZXVPS2VRVXlXYklUUzdOejVa?=
 =?utf-8?B?cFRIbXQ4R3hsUTRWbERFckhEd1FHZ1FvQjdqSk52K0VPU3JSRVZiZGxyVno4?=
 =?utf-8?B?a0ttd0tESFFnM09wTDRKVUhnZ20vdmx3UHRSWHZyZHFPSGx5VFhrTmhNKzRn?=
 =?utf-8?B?NFhzOUljTFFJUy9IR3A1NVRCWDVuRWg3RDEwamQwemhPTFlodjZDNjBBUGFH?=
 =?utf-8?B?SmVWYk14N3NZMnpWcVNQSlVOOWFhVDRLQWJySmphSFJYbVF0TFVpK1VwVXA3?=
 =?utf-8?B?RFhQdnB1VGFaUWZhR2ladmhCeENCRHp2TFpKNEU3YlFkVHcwMlgwM0dFUlhW?=
 =?utf-8?Q?pUinXoiUQkztaFRMPs8bebkrEPevan+mmW9LR4HRdSEz?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <69161B0F0E5C8B46BBBF06CA82E94ACC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 472ece92-6d0c-4523-3f1e-08d9f493f616
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2022 17:10:57.4877
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CU26luZHgp84CTw7C7gbUQW4hNF5fqpdqvXPPqUqo42nvRLz2be/6CPFtFNbDRJ9pz10focDx+4ho17jiT+cMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5417
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMi8xLzIyIDc6MDYgQU0sIExpYW0gSG93bGV0dCB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWw6
IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMNCj4gDQo+IA0KPiBPdmVy
IHRoZSB5ZWFycywgdGhlIHRyYWNraW5nIG9mIFZNQXMgaGFzIHNsb3dseSBnYXRoZXJlZCBtb3Jl
IHJlZmluZW1lbnQNCj4gd2l0aCBhZGRlZCBjb21wbGV4aXR5LiAgQ3VycmVudGx5IGVhY2ggTU0g
aGFzIGEgbGlua2VkIGxpc3QsIGEgdHJlZSwgYW5kDQo+IGEgY2FjaGUgdG8gdHJhY2sgYSBsaXN0
IG9mIHJhbmdlcy4gVGhlIGN1cnJlbnQgcGF0Y2ggc2V0IGFkZGluZyB0aGUNCj4gbWFwbGUgdHJl
ZSByZXBsYWNlcyBhbGwgdGhyZWUgb2YgdGhlc2UgZGF0YSBzdHJ1Y3R1cmVzIGFuZCBpcyBqdXN0
IGFzDQo+IGZhc3Qgb3IgZmFzdGVyIC0gZXZlbiB3aXRob3V0IG1vZGlmeWluZyB0aGUgbG9ja2lu
Zy4gIEFzIG1vcmUgb2YgdGhlIE1NDQo+IGNvZGUgaXMgb3B0aW1pemVkIHRvIHVzZSB0aGUgdHJl
ZSwgdGhlIGxvY2tpbmcgY2FuIGJlIGV4dHJhY3RlZCBhbmQgdGhlDQo+IFJDVSBiZW5lZml0cyB3
aWxsIGJlZ2luIHRvIHNob3cuDQo+IA0KPiBUaGUgbWFwbGUgdHJlZSBpcyBhIFJDVSBzYWZlIHJh
bmdlIGJhc2VkIEItdHJlZS4gIE1hbnkgb2YgdGhlIHJ1bGVzIG9mIGENCj4gQi10cmVlIGFyZSBr
ZXB0IHN1Y2ggYXMgZWFjaCBsZWFmIGJlaW5nIGF0IHRoZSBzYW1lIGhlaWdodCBhbmQgYmVpbmcN
Cj4gc2VsZi1iYWxhbmNpbmcuICBUaGVyZSBhcmUgYWxzbyBmdW5kYW1lbnRhbCBkaWZmZXJlbmNl
cyBzdWNoIGFzIGhvdyB0bw0KPiBoYW5kbGUgYW4gaW5zZXJ0IG9wZXJhdGlvbiB0aGF0IG1heSBj
YXVzZSBvbmUgZW50cnkgdG8gYmVjb21lIHRocmVlIG9yDQo+IHNldmVyYWwgZW50cmllcyB0byBk
aXNhcHBlYXIgYWxsIHRvZ2V0aGVyLg0KPiANCj4gSSdkIGxpa2UgdG8gZGlzY3VzcyBob3cgdG8g
dXNlIHRoZSBtYXBsZSB0cmVlIGVmZmljaWVudGx5IGluIGNvbXBsaWNhdGVkDQo+IHNjZW5hcmlv
cyBzdWNoIGFzIHRob3NlIGFyaXNpbmcgaW4gdGhlIHZtYV9hZGp1c3QoKSBzY2VuYXJpb3MuIEFs
c28gb24NCj4gdGhlIHRhYmxlIGlzIHRoZSBwb3NzaWJpbGl0eSBvZiBhIHJhbmdlLWJhc2VkIGIt
dHJlZSBmb3IgdGhlIGZpbGUNCj4gc3lzdGVtcyBhcyBpdCB3b3VsZCBzZWVtIHRvIHdvcmsgd2Vs
bCBmb3IgZmlsZSBiYXNlZCBzY2VuYXJpb3MuICBJZg0KPiBwZW9wbGUgYXJlIGludGVyZXN0ZWQs
IEkgY2FuIGFsc28gZGl2ZSBpbnRvIGhvdyB0aGUgaW50ZXJuYWxzIG9mIHRoZQ0KPiB0cmVlIG9w
ZXJhdGUuDQo+IA0KPiANCj4gVGhhbmsgeW91LA0KPiBMaWFtDQo+IA0KDQoNCg0KSSdtIGludGVy
ZXN0ZWQgaW4gYXR0ZW5kaW5nIHRoaXMgdG9waWMsIFNpbmNlIE1hdHRoZXcncyBwcmVzZW50YXRp
b24gDQpsYXN0IHRpbWUgYXQgY29uZmVyZW5jZSBpdCB3aWxsIGJlIHdvcnRoIHRvIGRpc2N1c3Mg
dXNpbmcgbWFwbGUgdHJlZQ0KaW4gZGlmZmVyZW50IHNjZW5hcmlvcy4gSSdtIGFsc28gaW50ZXJl
c3RlZCBpbiBoYXZpbmcgYSBkaXNjdXNzaW9uDQphYm91dCBob3cgaW50ZXJuYWxzIG9mIHRoZSB0
cmVlIG9wZXJhdGUuDQoNCi1jaw0KDQo=
