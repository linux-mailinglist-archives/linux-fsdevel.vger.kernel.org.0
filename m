Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D654D507FB7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Apr 2022 05:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbiDTEBc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Apr 2022 00:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbiDTEBc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Apr 2022 00:01:32 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2040.outbound.protection.outlook.com [40.107.102.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816BB2A265
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Apr 2022 20:58:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GAo028l1G3Zy+ZrrAK83LAs3CWWA2E7zoqNu+6cpc7oUBDGMMgo5WiNfH5k5a58XdkSkdRqUJ/RYz497tRJ+QwjCDqg25Ykmmxk/qLYAizIhw7ISEfz6Nu5VrpyWJcZ8xWNyKSbyiedddbGF618wELsUKKFk3p0Vb5ZdgLFRiqTRoEKereyKId0lxLbrcPkQyhonZmvGXG56ZImPzfkygIRIPQEqFiTwggPS2vxc+FTBuWj9EOArbGa1FXpO3jXDPGDHSzSmIKTG2UQGaj4XGNLoXEc5MyuT2gCWKgo/gcV4xDa5pry3UWFeeluZ85Qge2tjGbZXGrSpq6tKzQzQFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LhGbRDUp38e9p5OGM2K9+EKXCrvkQ+1H7+TWOd8fYG8=;
 b=QAJNnbKKeSe+eeUhdEvVTWrHqelhvnxTuaevUku1YQL7PFh2njFYOFXHbubyAw6AI7XJk1QQ/T5uhqa03vAZcJ633PqURwMfHKX5hdrF3ct+jqxdF5qFJTChPAu/i+I/vIsvaFId5po7BqcvpwMsvugIVYYylL5YPYnsBBfrhdNkoxx0tYQ5lUe/fxh9tHkG/GsLqwvOBGM9BVlEnqDXexqhOmRMIWnXuWKyrPCh+YG7CE/QClxah4Y8Vj6zJPwOwbh4yWSeZJE24lsiDgYOgwoGBfFvfNznNb5EQq5wmbDZe1IddTWUJ1RnrsjD9Ch0c7+75S3EomaMizJAZdqXlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LhGbRDUp38e9p5OGM2K9+EKXCrvkQ+1H7+TWOd8fYG8=;
 b=KVZyc9THia6BvkdlH0lEvuZ5O3GvjdLWHd82Snil3uI0Z/w2gg2QQ9h5rqCiTrJk3jAm/GL645ZPziXTLpbf4OaTFq9gxJK8uZdFqDBUxxMu/vFoIN2AjAv7C74IM7X0OTTB6j4gecqfgYaljcu25RrQiW++t2iv1nnkqmx3tuVpX1vQmvH9m2OQwNihyLSgRaAE80PGb8BOgQ/M2ZAA4nO4cdQwjkakQtrHF/a3L+vdCDn6iPij7sbYOKCA9I1zrPh+meKL0f0n/+h54Td/BLJ8gY7CCVfEBhijQdiFxtznOGpKXXIG/n+Uk3imkoKTIbuw8WwIFGD9EwjHlEhy7Q==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CH2PR12MB3942.namprd12.prod.outlook.com (2603:10b6:610:23::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Wed, 20 Apr
 2022 03:58:46 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b%3]) with mapi id 15.20.5164.025; Wed, 20 Apr 2022
 03:58:46 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v2 1/8] zonefs: Clear inode information flags on inode
 creation
Thread-Topic: [PATCH v2 1/8] zonefs: Clear inode information flags on inode
 creation
Thread-Index: AQHYVF/Y/Z73eUBPAUKdFwOh+LdjHaz4LR2A
Date:   Wed, 20 Apr 2022 03:58:46 +0000
Message-ID: <cdf153ba-464e-9707-844c-4129fc081294@nvidia.com>
References: <20220420023545.3814998-1-damien.lemoal@opensource.wdc.com>
 <20220420023545.3814998-2-damien.lemoal@opensource.wdc.com>
In-Reply-To: <20220420023545.3814998-2-damien.lemoal@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 10691135-5da1-43b7-64f4-08da22821184
x-ms-traffictypediagnostic: CH2PR12MB3942:EE_
x-microsoft-antispam-prvs: <CH2PR12MB394281D8A62BB17190767E03A3F59@CH2PR12MB3942.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EIIML+3dJ942Ko8yoF624/Sm8GAMcX5/KeIoCIVnbfAdQO/mp1CKhqQxYBHRWfR6x1V+kR7URre6Oll+Ql2blB7mKWnFUl2atpVvvy1sGNWvVgvvWdxbLu8pOF9lyobK+4xitMnFgsD5wVesuAk0bOyDI1PL98VELw5wFKGC8/Zy1Zyfui+UH2GuBybpTTJYc3YJN1rAfb7xh5cBoiCksVyCwJxT5CwfHcBHICQDiBapaWbpZ18fy1A3fz28fzl/t6IHegafDdFqrA0zxyshbNVuZIvJDTZCS7tn/CV4UxuWwDOJB9cScG7iMJqGguzUzp5c3kuK9yxk8uYJfpyBNQsf+BakZAK1QFma4CE1BxqKjpRexSPTgTJxJtg58LRc2hKmQrEeJHdtNm99wVuj1qcIpKxSdyvR1bmG+aGYciCXuLEEaqgoficRlvt8aMf+5r2huJSe18ebC4wOBzUW2B7J2eHz7+X1HYJhetIZpF8NNzOpL+hTNcqo7BRcWa6DN+ZQ/6cVmQvTi0jW47IJXwBVplZiQJVQvP9ByBfKvWfQFI+3RBNX/LThOV8++I21ufeLr7MG6LouvmcbX+rT43ZFmPLeFXvVGUxwQX3P7dFrEuz+FJFoCg9rKNYKgo/FOScRfVN/Ep1cjPpuRfoJgyLzY5xBwmPkjl4Yaz1GdbyIV4HGlOmuRA/E/5IeAma2bNoNDEBLbLdBv46bPmwkXy6RW3z+uoqWfgS5P3vRbknzj/6tIqBmB7qBrH14WtPZdVUY+wxgL+YJIr9+nXe17w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(71200400001)(2616005)(4744005)(122000001)(186003)(31696002)(38100700002)(86362001)(91956017)(66446008)(508600001)(76116006)(8676002)(64756008)(38070700005)(83380400001)(66476007)(66946007)(66556008)(5660300002)(31686004)(316002)(6512007)(6486002)(6506007)(53546011)(110136005)(36756003)(4326008)(2906002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Umt5WURYY0Z2ZVIyN01HRDYwVWkxVnlOVFhkUk9JWFNOWGZHSElaOWQ5Q1JL?=
 =?utf-8?B?TWJkRDRrcWNYUUZxazZsMCtIRFVUcmxLOWx5ay96d0dKR1o3Vmt1V05xd0N4?=
 =?utf-8?B?SkJ1Qy92ZTR0VHVucllCR2ZHM2RJaU1RYy9DcTRrdjJYYVA4S2E0RUxtSXM4?=
 =?utf-8?B?dGNBUzdicFV5TEtleUwxdm9LbzE3Q0g3bmtqZTNGU21IN25kNXBGSXJ3Ni9Q?=
 =?utf-8?B?Y1VpaUt0K3pJbmx0bW83UE05dk12L01PbWl3WnB5OGRMdDBEcFMwYmNFd2Rv?=
 =?utf-8?B?ang1MENvTHZaZmRBYnowMjNuYmJKQUJtOEtTdFlwLzFFdUszQVhTTkl3NEN0?=
 =?utf-8?B?b1dHMVlFNXp0SXN1MnFhY0JoY2tZUDh3aDJmZml4VUNGdXVxWStFYXFROGlv?=
 =?utf-8?B?Snhwb3pGS0tTRDBOYXovSSswTlJuMWRVOElLYjlubDVXVWRwb3o3TVo4YUJL?=
 =?utf-8?B?REhrZlZnWnhMZGZsRHdKNDZnTmlXUGl1MFVnOFQ5NGlyYWRpSzlEb3IvZlps?=
 =?utf-8?B?eHpuZW9tTWtic2ZXMVh6KzNCSFE5VGN1TDNBcFBiVEY0SHFOV0V3UmNYZ0ZL?=
 =?utf-8?B?QVVVYzFKTTBUejlVQVlIWDU2TUVRMTVWSkplQURIOGVVbE1iYTA3dUpwam02?=
 =?utf-8?B?WkV4ejhlZ3J2T2pEM005UEtPK0I3eHRnelNDYVI1dFpMR0M4aE1sVnJRbVJF?=
 =?utf-8?B?VnFBM1Rwa2tjRzhSbGwybnJaTEFMWmQ1VUE2ZHpWdWErZkhGWFZPZUdRVG45?=
 =?utf-8?B?Yk03Y0NzWXlCTFI1N2RXVnN3bFBRS1pBY3hZOC9vbXNXN1JCMWVKVjc4dDlH?=
 =?utf-8?B?RlVoZjZXZGIwc0NPdGRKVEZuTlZzZWF0YjJSd1R0QkZoaHMxMjJzWnMwb2gz?=
 =?utf-8?B?VUxNSEJKVFo5aGhJT1BLelg2MjBvSUJ3ZjdBbmJnOWk0U2tzNkJTWjBYOVk3?=
 =?utf-8?B?NU1MZG1WaGYyOHhOMnk2VGE5RVNrUkgzdE5yWHpEWDVNUUo2Qy9xQUx6U2RD?=
 =?utf-8?B?UVNGRHpmRHZ2R2M0dnIxZFBDMjk3SDRIMUZCUVJjTis3MWxwUkExb0M2Um91?=
 =?utf-8?B?RzlRc29Ib0RldjVFcnZnQkNXQXBDeTZwcXBsRHlGbmVycS9xVE9YdTJoTHRI?=
 =?utf-8?B?MHdMczNMMHhTUWNZaWIwc2FselVXeEpkS1oyVHkydVFSMDczVW5malVMckNW?=
 =?utf-8?B?ZUdscTU3MkhjMEw4ZE9kd0lXWmdBMGtTSitoUUNvc1BTdG5aV1A0OWlNZmJo?=
 =?utf-8?B?TTJrL3Bmc0dXMG10UEprSFdaY0Q0VUpYaVhOa0gvMnBEVzBzTUxmRW1VUG5I?=
 =?utf-8?B?OU42UGl4K0dRRjc3WTI3WExQbndNQm41T0MxNkljOThBcW1NQXlDWW5UbWhQ?=
 =?utf-8?B?THBXaVlhNW9vZm1VNUt6Z0VvMGE4ZUY1Q1dqazY3KzN0NkZMOXZzMnVpaW9y?=
 =?utf-8?B?aHZYSjZ1eDZGSVJnK01YUUh0TWdJSlFLd3ZRUzdlRzZ3bWM2S1MzS2dLZElp?=
 =?utf-8?B?OHVLMk1TeVBkWmZjUXdRS20xWHh1aThPY1Rad2pYeFcyUVUrR1NiSVBjUnBn?=
 =?utf-8?B?TDFxT2E3a3phMTgvaTIzZjQ2amxVOVlHMGkwbmZPTXR3ejlTY3UvZ3grMThx?=
 =?utf-8?B?blI3aUtuenhLekVHc1lJT3h2U0EvRTYyMFBDK3J0NmpIblZiQkdZa0tqazVt?=
 =?utf-8?B?M0dSNnBKaTh5U2ZGSmhEMXZKNnMvenhmZXlIY0xIRnFBeG4reWxUZEVSWStk?=
 =?utf-8?B?NmoyeHkvMGRnMmlsVW9wSW1CODJqZHFwK0N5Yy8vNCtkRVk2eE9DRUlUZ1Nn?=
 =?utf-8?B?aWduODlFY1dpSUI3NzMyNWFWWGJXTkNsNXpWaTRObmwrV0pvSXdHN0psMVlW?=
 =?utf-8?B?STA0dTVPSWtWcHZicnlhQm5yZ2JNWi9EY2lVZ1ZTRWtNSVlmUy9PQXc5SEZm?=
 =?utf-8?B?RkVWK3NqTnJBdlhTbWNMRS9SY3EyWU43NXpPRjAwZS9yKzVpL2xVUjlicGJu?=
 =?utf-8?B?dlIrczhWUG5LZEZkR3RMaWdEaFU5K0VuQVY0U0dWNGR5TktrTGF4enltaXJV?=
 =?utf-8?B?bWw3SFB4NlhCd0RML3ZTeFNCNUlaa2J4UlBIc0JWS0xnSjJEOXp4VUxyNG1B?=
 =?utf-8?B?N2ZCeTF0VFI4OFdxcGRBdTZrVnNWaHNNUy91d1FRWTFiMThMRVFTOXIyUHFQ?=
 =?utf-8?B?eTFIMEQ2amdSNDc0K09tSkM5Rk1xL25VS2JaQjF6ZmVUc0tqL3FmZlN3MklY?=
 =?utf-8?B?U1NtcEI1Y1pTdHlBcExIeXJPalJJeTVKcVMvUjc1YUUrYU8vUzdzRXhSa2lI?=
 =?utf-8?B?M1QwWmVObytpMFZzM3hGQ3Q5SkdaTk1tVHQrS1ljd2VqNThGMGJMZEpIUElB?=
 =?utf-8?Q?AkZ9C2qP67mrXEJrCSoGlwYJsewaksA3hsApGVuIKC/Yq?=
x-ms-exchange-antispam-messagedata-1: KmOoaf1SZxvU+Q==
Content-Type: text/plain; charset="utf-8"
Content-ID: <D59AEB263A70A74EB5431296D7A65EEE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10691135-5da1-43b7-64f4-08da22821184
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2022 03:58:46.0391
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PE9xfRvaoJjw8NAwkz7TmYn6UXFtBQ5tJbMF0XbJmvHzUsOOgszxhCndM+19YMAOU3J1Coc4iEhh+kFMeGQlPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3942
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gNC8xOS8yMiAxOTozNSwgRGFtaWVuIExlIE1vYWwgd3JvdGU6DQo+IEVuc3VyZSB0aGF0IHRo
ZSBpX2ZsYWdzIGZpZWxkIG9mIHN0cnVjdCB6b25lZnNfaW5vZGVfaW5mbyBpcyBjbGVhcmVkIHRv
DQo+IDAgd2hlbiBpbml0aWFsaXppbmcgYSB6b25lIGZpbGUgaW5vZGUsIGF2b2lkaW5nIHNlZWlu
ZyB0aGUgZmxhZw0KPiBaT05FRlNfWk9ORV9PUEVOIGJlaW5nIGluY29ycmVjdGx5IHNldC4NCj4g
DQo+IEZpeGVzOiBiNWMwMGU5NzU3NzkgKCJ6b25lZnM6IG9wZW4vY2xvc2Ugem9uZSBvbiBmaWxl
IG9wZW4vY2xvc2UiKQ0KPiBDYzogPHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+DQo+IFNpZ25lZC1v
ZmYtYnk6IERhbWllbiBMZSBNb2FsIDxkYW1pZW4ubGVtb2FsQG9wZW5zb3VyY2Uud2RjLmNvbT4N
Cj4gUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdk
Yy5jb20+DQo+IC0tLQ0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1
bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K
