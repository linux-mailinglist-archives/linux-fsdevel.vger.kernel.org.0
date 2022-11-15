Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269E462A1FE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Nov 2022 20:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbiKOTer (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Nov 2022 14:34:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbiKOTe0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Nov 2022 14:34:26 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C36DFEE;
        Tue, 15 Nov 2022 11:34:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NQmc5FNtCpxf0hOjhjAOFqp62JuTJNx3VJPcp6/DyIWSrZB8khjYkJ9Wt0c0sljKAHu/tLYbQQzQp0jt/ZIwoo/HXYe3betZtD/RT4azpNEnP+YA33np1spGmoXl5oieZIK2dTHUpSiFStVNSEMqYbJgOcZomOk1N4kMl6sP3dIPee1V0WuAdVMaZyD5RR3AE0uzCTA8h6iTUUQoCJoGrGb9Y+85Nm4IC88FpodxjYWPI0KG8nyu+g17YkpaTXKFV0xE7XEgU+P1xN1q7g7oYNZFlGwum3ptTmsj1ctMv1avvN8iYytRh6JOq6mWQk9X1U6eS+lH6fJNrdQkhvDaYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aAYFCMM+mQxz2pbHX4krLnJb+gWtyoFpwFwxROBl3t4=;
 b=gdY0eusF8Th1PAzApXzFur9oGH7JwydGZdGy56+DQHDxeFSuGtAAnRHbyT+yEndWORqUQz18Z3aoFlGANqL9b4h6ND+oEh2eWsBprhqoIxZuy0I75vjRvWZ5rtRkJIdGTl7M+jzguJcQ0Vmyc/jOg/Q6vcnN9HXh7Ly2qBNFNPKSRqXXLlAr08QoaQ6heAO7GMZkiTSmRS6dAgi/Lr/CgPhV2QbCOEdXqgThIG6Tp/q2S4vnzLQeO/++EayctR5t+sm7RmU0j/CUu0uCEYT1VM4NmWrNx1dPt8LiwN2q7L4hfkmuSvmFI8VMPUp8kwVNgaRUyjPHFfjc23FMBB3XPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aAYFCMM+mQxz2pbHX4krLnJb+gWtyoFpwFwxROBl3t4=;
 b=elJG8qP7AVS4PJNhRBLakIsr40sSAi1913GUNsbemEUcjTdkN/pGAapnkZp4SWkdmK5u6DFN9hsEesUkDQkkQJGyxgnxZaK/BMs1O3py0TqTUuescibeC1LREBP7DmKkwIuJxVIA7aM40TevIPXPvVI69Tmt37QM66AWW7VFJXyqHAizLtrX3Cw54qNF1DFscxh7K1DKtr+LCG4EAbqWm6uvNxJpedJLMGwHhPzw2JH6EVgE9b/lTEePTx4XwU6NF0XgOGRt0LPbb1UudggYr0zSyaTluVemx/dc2dlw9Ih/bwrCAem9LVXgxQvpt824q6p2WQVJc1we2v8YjkBYVg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CH0PR12MB5299.namprd12.prod.outlook.com (2603:10b6:610:d6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 19:34:20 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 19:34:19 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Bo Liu <liubo03@inspur.com>, "bcrl@kvack.org" <bcrl@kvack.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
CC:     "linux-aio@kvack.org" <linux-aio@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] aio: replace IS_ERR() with IS_ERR_VALUE()
Thread-Topic: [PATCH] aio: replace IS_ERR() with IS_ERR_VALUE()
Thread-Index: AQHY+KC9/n9JgEjziEu45hffX8TvVK5AYUCA
Date:   Tue, 15 Nov 2022 19:34:19 +0000
Message-ID: <ab23614e-5da0-bc16-be23-f18245901fb9@nvidia.com>
References: <20221115031644.2341-1-liubo03@inspur.com>
In-Reply-To: <20221115031644.2341-1-liubo03@inspur.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|CH0PR12MB5299:EE_
x-ms-office365-filtering-correlation-id: 08d49e2c-068f-4c7d-054f-08dac7406421
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VK9H0c+Kdf8J42au3RIB4jFBB1OaF7/kWux1zEijlOjLjPMJjPh0ScnPkywLtyW/ddI0hT0TLK8AL0ZnjmovRJoO39PZeuQ409168FUtLw8jD5LMkydEr1YD/sHsJSRAzesy8pmVn5pbDJcXDC9a24nDLcbN1DpXv1BGU++9YmJDNBBjh7/dvOch+IOfLxDVVXbonF1/9hvOue/W4VSWNe2encoXbjeUT7cHqc1z4TAABmsRgZm+lAiqwGAXaj5j+amnNsYJLglyy2ZvGgNB3z8tNTVkwxHRdvjduj+554XM5K/MVMj3FQNFhi7MNvDk6gMgI1OzbxTGua+LdKmj2vaSGZTnM1SPWTCrDMHaU8GUdKvzXMhRXexWPcw4GEQ0uDJOzrAMDjQsgdzsE+c6lwe2ueHCQps436vMebIomr5mue2rbLVjkP7/gobXGGteimT36cpNh71Y7uHp/GV0FJDaWZC+cjCfJfxa8+yOCFl+/6UOJbP8mPRysuERvpUjOmOJkzriWG/SmIu29ode3RNAhp7CjKELVPiRSnH+FetiqJJbh0CZvuYvUL2OPDghqticFcQtqFw9lZWyE6mPiaKjAzPd5MhP7Rofo5+pASAlKRJ69pFvlV6DLrdzQlsVLcq6z6uzkJHs3RYL+Z1RXafbhwAeBVA/p/taHrOwnSISqHfUlBzQljYI4LGqDaGh42dXmD6HQFoCZJ47O04HHS5RNhM9TxunbmMhvS3FFCxzblm+Vk9We2Wzt7O55l6ggVVv5AqrI6B8CV1U2KY0AZpdv+EX7jWD3441ddwSXL/UAk+XY79245bJFPJtbA/URR1F5WQIUahhMk2tHRMl+g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(396003)(376002)(366004)(346002)(451199015)(36756003)(2616005)(6512007)(122000001)(86362001)(38100700002)(558084003)(8936002)(5660300002)(31696002)(2906002)(41300700001)(316002)(53546011)(478600001)(71200400001)(6486002)(38070700005)(31686004)(8676002)(91956017)(66476007)(186003)(110136005)(54906003)(76116006)(6506007)(4326008)(66446008)(64756008)(66946007)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YVB0ZWhsQkIveUM4TTVtMjRXR0tLdUZFWVI1V0RaZzNmaEpwUHovVllpa0VC?=
 =?utf-8?B?SG9zQmhuc1o1VHNCakFpWmlqbVlzMU52TGZsVUtsajQ0Z2oyL0R0b25QSDlH?=
 =?utf-8?B?dmJRZE9vTmdENHZHUDEvWEE0VmpnZ1pXVDB4Zmt0a3lxeERPbE8yUlVLYmV3?=
 =?utf-8?B?WmtaTG8zazlWOGd2czlUczN2ck5YcWdUdFF5L3N6ZFZRaWxXYU5IS0s5bGFk?=
 =?utf-8?B?VGJCdW9XM2tjYmJKTUlSYWxhMmJkUEd1amt4czh0MDZ1cVJCR01vT3BtOGd6?=
 =?utf-8?B?d2s1K3ZFc2R5c0ZncEgvQkRWd2MvejRHWjFqSUNDSnRXRnA5a1lkQi9FZnVQ?=
 =?utf-8?B?WHhlNmF0K25GY1I3cTdjcWRsNkQyVWJROHVkVkR2QnZ0N3hDcDNyQ3RzSEQ0?=
 =?utf-8?B?emFNVGVSNEcrdU91bnZUWnpUZjBIMk0zQjRnbkY3aG9yU3BuODE3eUFpSDJs?=
 =?utf-8?B?Vjl2aUxCcGt2ajdIMGpxSEhIK1BxZ3lXY0sxZk9XcHNSN2NxUXdiYUxXdVRw?=
 =?utf-8?B?dHNxWk9aaUJaSWd5cUpQSzRmUEhpU3Q2dldlSVFYWVYrcENXYUNXV0NPcnFG?=
 =?utf-8?B?eElMN0ZlTlVjd1hNUUJuN00zU0Z4WjZQaDF5R2dZanh4TnVFTGpaRUZhbnda?=
 =?utf-8?B?WFZaaFpiZlZCeUQxUGlUZElRV3VqcUZZNEtFNGpmQ2U1WW43U0VjbEJUelYr?=
 =?utf-8?B?QTZDOEdybDg3eUlEc05vR1FBVEp4L0QyQUtjMnFnTE9NRUMzRGlqVHg4MUFz?=
 =?utf-8?B?endSR3RPQXRzWTAxTy81SXdXTlp1MXU5c0FPQ2E1dG9vWU5GNTRLQmdlNVRG?=
 =?utf-8?B?STVQeDY3Rk83aXhXWUQ0M3FLM3R1c01JK1hRQnJvRHphT3JwRjR4MFVReWRW?=
 =?utf-8?B?TTV2MUIrUHlKMHFZSEZycFFVU3dTK1BYVHJxSHNuTElJckoxamRxQitCaGJR?=
 =?utf-8?B?S1JHRW02ZUl4R2NxVFQvM1hUNlBpK3FuZ0RIenI1cG82RGNUQllOYkVLdjEv?=
 =?utf-8?B?VzVlWmNZdnA1RENIamF2d0J1ZW0zek43TmI4M3pjenlBM3c5c3BJL3hNNnZN?=
 =?utf-8?B?MTFQYmtKWmtxOTNCWTlLNnNZYlFMMEJoUzZ4OUhZa005OC9OZTVHSUQvd3Yr?=
 =?utf-8?B?QjFKWXlEUmRyMHhraEM2SmVEYUxwdmZ0SXN0U29oVExWZUp4Ky85dVVUZHJq?=
 =?utf-8?B?c1dhRm9xdEVtK1pETy9TY3pkY0o3K2tFWjVqT1puMnNJZ1dIUDdhWU5QYzBK?=
 =?utf-8?B?NUNLbis5cVgrbm1OVjJRL01sZHpWVmJjNzdxK0NidWZHYXV2c1FhcG5DVm5m?=
 =?utf-8?B?UGluM015NE1MOVYrUG56bkx2QkgwNEQxQzQ3b0xpTjI3SjJZWE1LUFNNR0J2?=
 =?utf-8?B?OG9ROVRRMXJVTVk0bXlWQW5xYk1KTGFjTlRZWjN2RWpkdEJiRzd6WHdOQU0r?=
 =?utf-8?B?bm1PdkZEQjFwd25mbXVFSnVnNU1KWWF3enFVREZEaDE3WkZzcHI1a2o5aERW?=
 =?utf-8?B?N2xnaFRaMTVwVzFNWmtwS01wbFlqZ2diMnl3YVRwQ0pVSEhjV0c4WjB2c2t5?=
 =?utf-8?B?ODBUZDFONkVQMzJOenZ6Q1hTNGcxT1AvcllCSjlGVHBYR1YwWnF0NlBqSFJr?=
 =?utf-8?B?b0Fici90TGN2NHA0cGhORzRMWmRyajhqSUtvNVdYU0h3SkdHL3hpVzNBWXlv?=
 =?utf-8?B?bXRzRFJ5NVhYR3I5NmNlbVhEWTl4Qll0UlFhNzlrSlN1RHBhYmhRd0NqS2ha?=
 =?utf-8?B?T0x1SGhLRWxmWDJzeWllOXFLYTl6MkRneHNvQTJITm9DQ0JpcmZOcnA0SUc2?=
 =?utf-8?B?aFc0V1NwWVJHYUxGa1Mxa3NwWWVhTitIbGVhZzRJSWdzSDRWbGxnRGx4L2Yz?=
 =?utf-8?B?QUt6UXlDZXp2cnlSUFRmQWlsaXNwOFNxbENnZUVacDFCUk1XMEl5YXdtOHNF?=
 =?utf-8?B?dVBoVXcvWmV0OC9acXpzVUlEUmcwZXVPczBvZU5CTmJKZjVHb0V0Q0JOV0Zr?=
 =?utf-8?B?SVp0TlJ2bm0yNTZBeW5LVTQ1MmFqcGNNWGt3WnNrY2RsUTBGZ1lsaEZZdVov?=
 =?utf-8?B?ZmFOdGhxVlk2aTJGbjRnTnYzSUZPcE9vaFo0MG45THpzbFowN1ZHN0UzcGNQ?=
 =?utf-8?B?YzBUakdkbTU1RHl1ZlVQME9VQVJjbUt4cXZqME9KeXhpNjJWTlVsWWhjTG5P?=
 =?utf-8?Q?gsH8MHGrEwsOsys6mvDtXDGAiTrFfZqSjiTVeBCFTO9Z?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <46A0EED105CA834AA8ABC41478414406@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08d49e2c-068f-4c7d-054f-08dac7406421
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 19:34:19.7910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jLTpWnm6zxX3FXKBTU7f33PMvs8k/tplEI9Dyj6J53+ajEs7/Ry47Nv1AzrPWAXsrsYQhSCtm8dAeb1GH5+6eQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5299
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMTEvMTQvMjIgMTk6MTYsIEJvIExpdSB3cm90ZToNCj4gQXZvaWQgdHlwZWNhc3RzIHRoYXQg
YXJlIG5lZWRlZCBmb3IgSVNfRVJSKCkgYW5kIHVzZSBJU19FUlJfVkFMVUUoKQ0KPiBpbnN0ZWFk
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQm8gTGl1IDxsaXVibzAzQGluc3B1ci5jb20+DQo+IC0t
LQ0KPg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4N
Cg0KLWNrDQoNCg0K
