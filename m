Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9531719B74
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jun 2023 14:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233126AbjFAMC0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jun 2023 08:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233244AbjFAMCU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jun 2023 08:02:20 -0400
Received: from outbound-ip7a.ess.barracuda.com (outbound-ip7a.ess.barracuda.com [209.222.82.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE51E5E;
        Thu,  1 Jun 2023 05:01:49 -0700 (PDT)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2042.outbound.protection.outlook.com [104.47.51.42]) by mx-outbound11-242.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 01 Jun 2023 12:01:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RtwWpJPkrYRXl5IyDI/5pUMO5/oZGB2jaKLOFHebTDPbVwKNTA6wm7SHuHoj6sXzRjyMk8qf2csML2KSAiyb2qO1iBtH0Gx3KGDzTUsrqNKqV3pQOyz6dNudJq3L7vbGaQuTkPb3h/niu3JJYn14H+GP8xKSaWKSGVKCxMhfY+m2bvNVERQqiKnm5qAzvfUfCyy5e6/5GvuOVHL+IEniwaYdGxt11xL5rdCnInXtZXzoLCgmYGG+jePw44T/geHua8Rszl02fNxFEixi+mWKbimQoOoXVMdi4aQDMSgBofhHCM1k7gmqijSzgOP4sVlqPs2AtVvU5N0ap2EsEWfmWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8lU4Zn8PXB7Aadj8vFAWeYQtbP6Jl5GPPZr2hwSpxCA=;
 b=i+D2QyLbMZb6EGS14Bp118NrBjZPgxo1sosH5fSWxya5wimsv+iRsD0+aasix0qNHoivGXEPTb2gHZUBjKYATRUxMa0LJEIrtwpKqljsDeqNKlMLxyyhcNrO1+CyzoiHVP9OrbC5ppl5tlr29zzFMkJIcOGNdLT9UqWIwDiijTvPc9E9tvc4LXgl/QyiKQb/goP4H7rR8YIT9gEqHlke5NDP8vjpNzZvZAn28fbvQqK7A7Nge0NsSfvC/IBbfSNryMzRNeXnIB10t2xX3IduB6n05vBejjlxOzGDc4TfN9s3euShXrsAUUGQ0sI0BDsr3BJkFyxL9va9UGU9cZabuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8lU4Zn8PXB7Aadj8vFAWeYQtbP6Jl5GPPZr2hwSpxCA=;
 b=svgkumFo4Vq3rEZg/B4wYS0kjgQhS+fHexEznd52+XCR8yTSGSz5daBf418PEK2SO/TO7LnIW8+mbP7b/k6Fd+9ngTf04KEo7A9poEhI6jXG97HyPgnS0kZoeERDN0JfBwFzioJZZuB++Xd9oldVsZoDtuyh3Ethu0Ndn49iYCo=
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com (2603:10b6:4:aa::29)
 by MN0PR19MB6286.namprd19.prod.outlook.com (2603:10b6:208:3c5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Thu, 1 Jun
 2023 12:01:25 +0000
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::fce:3af8:dfe7:454a]) by DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::fce:3af8:dfe7:454a%4]) with mapi id 15.20.6477.008; Thu, 1 Jun 2023
 12:01:25 +0000
From:   Bernd Schubert <bschubert@ddn.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
CC:     Dharmendra Singh <dharamhans87@gmail.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Horst Birthelmer <horst@birthelmer.com>
Subject: Re: [PATCH v5 0/3] FUSE: Implement atomic lookup + open/create
Thread-Topic: [PATCH v5 0/3] FUSE: Implement atomic lookup + open/create
Thread-Index: AQHYadX+qfvv9wwlxE+YXrSP+CvzPq0l9N6AglIsloCAAAl9gIAAAvUA
Date:   Thu, 1 Jun 2023 12:01:25 +0000
Message-ID: <805d122a-34d0-b097-c3e3-f3cc7c95aa46@ddn.com>
References: <20220517100744.26849-1-dharamhans87@gmail.com>
 <CAJfpegsDxsMsyfP4a_5H1q91xFtwcEdu9-WBnzWKwjUSrPNdmw@mail.gmail.com>
 <ccfd2c96-35c7-8e33-9c5e-a1623d969f39@ddn.com>
 <CAJfpegswePPhVrDrwjZHbHb91iOkbfObnxFqzJU88U7pH86Row@mail.gmail.com>
In-Reply-To: <CAJfpegswePPhVrDrwjZHbHb91iOkbfObnxFqzJU88U7pH86Row@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR1901MB2037:EE_|MN0PR19MB6286:EE_
x-ms-office365-filtering-correlation-id: 9d3fc390-b227-4fde-5b6a-08db6297ec9e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F0ItQ2mt+5nQHUkt0uMuGgCsg8zP9oIMVg1Wx9w0oqV7NRwXzqFDoWsnjmjRrX8R321PPtk6ykoTEofGku7bNYNjpakgFDD/jIaK0LmPvQQVtYU6NFLZwusmxjSH9SzCI7gkMxwMjTtCUkr30y24rSSqECawpoAxnlSS5KdpLLWY/+XbCaWoQnjroUP6hV1ZuI/PsK07+2gtle6uSg1f7LoZQ6WThfbEk4O2/gkxb4MYPWOqA9xyujfPrUg2wb8pmDsG1lst+E3vXOMVVGsQ4zFM/Z4XU8KcpYtJ4kfOp0AyKCmsrXTJozHlIyAKYI+54MJviDewS7jcPQP3ECf7YgDptI1ma3HMcGclBrnDBqnpbUrRFJp3urel8ywllCyYAxeZk7jHJa95CFvwDtDJ3YmuLxt8MayQUIrfJjn1gLsLqklOOPgclhgTEhf8POVdNXL3tX6nXKtH4s6FKe2cy2RX+v5+PbbgwvC8fU/kF6Ad3sI604kNMqY9T8byHGaZkd6LSRaGicqNopMY4vWvBUtZqeSBxkBgTWvZL0bEyHKOsC3TRHk+k+iidYMk2rrgodBXHqE+caLLE2DmnWjIicZppvX35ssuf7RTHpXQMncRIXRqGh8W11jsvlFJGYUWrXpG/QDFt+Q8uVNaRUkizwH/0e2aGUkAuAE7RMKnFc7rX7EN+bCGeXnWCosZ2X8i
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1901MB2037.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(396003)(39840400004)(346002)(376002)(451199021)(54906003)(31686004)(41300700001)(31696002)(86362001)(38070700005)(6916009)(71200400001)(6486002)(66476007)(91956017)(66556008)(64756008)(76116006)(36756003)(66946007)(66446008)(478600001)(316002)(4326008)(186003)(122000001)(2906002)(8936002)(38100700002)(83380400001)(8676002)(6512007)(53546011)(5660300002)(2616005)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dW5UdmI1MnpqMHV5VEgyVHFaYW9hUkQvWFd4YXpDaTdvSGVYbXJSSnYzWWRj?=
 =?utf-8?B?NGFkOEpyQlFvUnNVS09IcGFUekcrd1MrRTRzWTdWa2dDL2o4clBKVld4VzZP?=
 =?utf-8?B?OVRHMnkraktSemIvanFkVDBHb1ZSbEZTaXJZU2pYb0ZobVNXRjhxRkxXQXUy?=
 =?utf-8?B?TTJzOGxIbWdlVy9iSk56OWZqVUZwc2hPTzVwaW0xOWlJckh0MWE3amVDWXMv?=
 =?utf-8?B?czhyL0ZOVWI3RXk1Y0Z2UytWQnJjUUhKdEE0cHhDajlEQVN0UkdzNWQrRGw3?=
 =?utf-8?B?aU4vSWlySXpZdERubXNOdTVvSndZK3R2TThHUVRkMC85bERZMXUrd25Fb0Jh?=
 =?utf-8?B?NEZvWHZNa3BiL1pGZVEyK3ljVzd4eHBvWUQ4amc5ZlNZSUNFZ0ViQ0g2QjZQ?=
 =?utf-8?B?RG9zNGdrdnhxS3YwdnNvTDlZMko5NHNSbjNJbnpydHNwMjRCRHpGbDdncERQ?=
 =?utf-8?B?UitXYnNJUDNNUXhiZjVaMmVFUnR2bFEzOHdSR0RWeWFGbXl5MGY4eFIvaDhH?=
 =?utf-8?B?NXBtbVc3UStBZ2VrYVpjL1l4WnlDYndabm5BRTJTWUVmdzAyL2pOL0l1M05L?=
 =?utf-8?B?OUJzYm5KdHZ4SzA5RnY0UUxudFlUcnFaVldIWFh2YlNnL0Y1cTI2M0VQRXFx?=
 =?utf-8?B?NEd1RElqMHBIcWRYN3dabEVwb1dOM1NISWZpYWpPeEp2OTE0T09jbDk3dGU4?=
 =?utf-8?B?a3NIdUZ4bEl4YitGZjI4Ri9lbmxVOXlWaGJOdjJwRHJjaEFNNVdvMUI5anZW?=
 =?utf-8?B?UWRkeHZWYnZBbVBPLzVXUTBySFdVV1lwWHFBZ3BlblZBaG9qL2pMVXV4dXl4?=
 =?utf-8?B?QU41aEJvSmJDcHh1bFhRUUd1dUZVbFZOOFIwemM1ZlFFRVAyQkpFNVFFZVV4?=
 =?utf-8?B?ME9GSEEwZGFYT0dzVExCQzdLVDRvZ2xaTzZDV2htZ0NpZHJwa29wQkY4QmFt?=
 =?utf-8?B?L29sc0VpcW1aYWNaY0ZsTlZwS0ZUd1RFMHBka1hlUzVkUFduY0xjRFo1Um9m?=
 =?utf-8?B?V3NYbGRvMzB4T3lYQThSRjRFN1pFdDBqZ1lrRzlUcDBzTktQUFdLVjlyaUZC?=
 =?utf-8?B?c0RaQ29HZjFiRStjNExhNCtNRlBKTllXcm9pQVpzai9WZ1ZTWEtsUW16dlpy?=
 =?utf-8?B?NHY1WFZmelRnM29td0o5UzhlQ2x3TTBSUGMyRUFmMzdaRjFuZVhRR1RkR3Zt?=
 =?utf-8?B?eGFYTkdLSU5uZFpnUUNxZ3dkQWp0cElrTmxHZVpDZTkzUEdyUEYzNjExek5S?=
 =?utf-8?B?MHVlWUhMOVhXQzF2RU1NTytuL3o1cXFVa0JmeGpyWm5iWGk4dytPY1puMzJz?=
 =?utf-8?B?a0lWaWZ1VjJMbVVZZGJuNTNtcTZRTUZoSDlURk1LS0pJOHFicGRqU2oxeG43?=
 =?utf-8?B?ZDlqMEtWeHMxNkJIQm5GcTVDMHlUaEdtcitNQWhseFR0Und0OWt4cEF5N3VE?=
 =?utf-8?B?TUw1U3BrYWRxUHRDTDRNWmgxTDNlMEVraklJUStVMVB3ZEVxR29vZ28yNEdy?=
 =?utf-8?B?dEV1REx5aEErb05yMGZuT01LVjFqUnFlS3NPZmhXeDQ4TW4zeEIzVFVQUnlk?=
 =?utf-8?B?M3VCeWdQUXdQNWlzMkRqb0d6OStNNXB2MklSelNMeUJGci9mK3pWQWhXMHFW?=
 =?utf-8?B?bHFZN3Ivd0JBczlZNXlWdHUyR3ZuOGt2U2VIR0RNZ3JkRUdzY1haelQreXlD?=
 =?utf-8?B?YjZGdG9pc3MwL2dNNWlCY0h0a1ZnVXhuKzZoSzA5L0h5MmZRMXEvSVJETDJC?=
 =?utf-8?B?UDkrT2Z1VnpwVUFLSlNhTjVHditNZ3JhOE82QTI0dThsNGNvbkRxSzdwUWt4?=
 =?utf-8?B?bUdQUWw2RHdlK21ZY2pxRDdSVHFUK0lqQjQvRzZBakVBRU5TdXVlNHRabWVD?=
 =?utf-8?B?bW9YaTlUZEpYK01BbkxIZXhqRzhvakF5VGY3Vnl6Yk15dnR4MFQvMUlzaW5p?=
 =?utf-8?B?eWRMOHRCVDJHNGxGTUxENzNMQk1vNEhlbUFoN055azBJMFpKT204NVZkcW9r?=
 =?utf-8?B?NndDRE5Ld0svZ0lTMWRiZ29OaDl2Q2llS1gwdzQ4VjJCc1V4NmNubGtqeENW?=
 =?utf-8?B?Y0FYaGFZaW1CT0lVeHovbkh1ZmZmS1Jib1R3ek1YLzRSQVRmdDVMNGJsVXUv?=
 =?utf-8?B?VkZ3VFAxeVBUZUxyYWtIUUEzOExRcnJSWXVRa3puNk5KTkI2bUdJZ2htVTFm?=
 =?utf-8?Q?qNa1mKTsY1TyOrx1GHCKbB4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1AE5251D718F644B838681975903FF58@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?dE9QYmdndVdzVm5OeksxajgrbEQ1dXR0L0pzaHJoQ1BwbmkwK3BLSjlYd0tW?=
 =?utf-8?B?MGVWdzJKQzMwZUlGWVlERGZxNnlrMFM3b2F3U00rWjZHT09lWVNEa0dzNjZs?=
 =?utf-8?B?eXZzR2F3OXE0ZjZLUVJUVUhLVHRVUHR1dmo2L3RHM2VxQUU5dXNVeml4MW1Y?=
 =?utf-8?B?b0p3bUhMYnJJRVlHenErbDZCMUwzZ0s2WVZ2UDVxZmVlSWNzMjZsZXdtQzht?=
 =?utf-8?B?NWZiODJtTUtUODdhNzRFU21uOGdQZ045bkMwQ1BnV0ttTGxlaEdSbFBQY05i?=
 =?utf-8?B?OGpDWDNrV2QvWm5XL3hNUmtxKzhsRDM2a3BvaFhsajJtUm1hYXRhU2l3cEVP?=
 =?utf-8?B?K0NIR2ZxajRWYjZQTXEzNjZZbTZsSWQ2enBvaldMaFA5ZWRsMzhLRWZQTGhM?=
 =?utf-8?B?L2FCVnBVbkhFK29pV3o1UGFEaEZIbFlvbVlNREx1NTAzTUZRaVVoeDJnaFM1?=
 =?utf-8?B?SE9XcThHRlU5bjlCYVA2WDVvNUQ4a1dQZW5PSWhLTjR4dEw3OXhQMG1GQWhz?=
 =?utf-8?B?cytheE1RKzFvZVlmRVRDcXRUWVlCbkZQNnNKcWc0K3dKdDRmeHlmRkJkZHJq?=
 =?utf-8?B?TlRQSVpsK0E3NUhJc3hZOE9YYmJueFdHVm1RN3IzOEpKblo2VGxnancrUjhW?=
 =?utf-8?B?U09mYkxZaWpBUi9RVEdIcEtMMGF2bCttM2puL3EwYXdPMloyWkNoN0lEZzNs?=
 =?utf-8?B?NGo2VXlZL0N4bVVEd0N2ZVRYVVplTTk0T0tZM3pGM2hxenlRSG52aUUyUitF?=
 =?utf-8?B?UlhRTVR1cm9MSGZwTDlaUlhtcDRUcEVkMUhvaTlBeW5BUFR3QTRXbC9FQm1w?=
 =?utf-8?B?V2x0dGpvVmJJamt5b0RMZmtxTXZtWVgvWXppQXl2SFI5bVVRU0RKTWhvY0JY?=
 =?utf-8?B?VU5VdEg5dXNZWkYra0dHazllVk9GN2NFbW51L0tPNnVpM21kK2tUcXQ0Z1BP?=
 =?utf-8?B?dTA2K2RrSkJMMHFTZy9HQmZOVnBpeDlSSlNnN29DY3A1Yi9lcTFpK1JaMzNk?=
 =?utf-8?B?SXRZQ2l0M3ZuTU5Ya3A3ZXAxV3ZvY0ZvcjFNVnl3WFluRkxzeS9JcmZZaWhy?=
 =?utf-8?B?QndwTGVRY1BGZmNWZ2ZQYVlwdG5oaEprNkJsY0ZqM1dRN0c5bHByRHlHOWdS?=
 =?utf-8?B?VVovbk5ianI3MFBRUHBvK1ZPZnJOQUlvRE5kY0hObHkzWnQybnlaZHFQV3p6?=
 =?utf-8?B?T0hHVXM4UlJrNlNZUVVyL2d5SW40TEdiRlZnYmpnaXpVUjArRXNMQ1h5N0lQ?=
 =?utf-8?B?eXJJMHIzOThSSUNPUjRycnJoR0FLUEVxUitpZjlnV2EyM3FCUng1Q2Rta0o2?=
 =?utf-8?Q?+9PbRZo5A6u68=3D?=
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1901MB2037.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d3fc390-b227-4fde-5b6a-08db6297ec9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2023 12:01:25.2051
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oqcLuc+RJjlCzWX6oRyQqvtYb7R/a6f52YoRVKYsY5m1bHe2MZTDsXyg1LEuLB9dhyNNipD1di/8cr24YOyovw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR19MB6286
X-BESS-ID: 1685620888-103058-5639-24779-1
X-BESS-VER: 2019.1_20230525.1947
X-BESS-Apparent-Source-IP: 104.47.51.42
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkYmlqZAVgZQ0NzAyMDEPDXZ1C
        DFyCLV2MjQOCXZLDUlMS0pycDMMM1cqTYWAFyCR6JBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.248515 [from 
        cloudscan16-237.us-east-2b.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gNi8xLzIzIDEzOjUwLCBNaWtsb3MgU3plcmVkaSB3cm90ZToNCj4gT24gVGh1LCAxIEp1biAy
MDIzIGF0IDEzOjE3LCBCZXJuZCBTY2h1YmVydCA8YnNjaHViZXJ0QGRkbi5jb20+IHdyb3RlOg0K
Pj4NCj4+IEhpIE1pa2xvcywNCj4+DQo+PiBPbiA1LzE5LzIyIDExOjM5LCBNaWtsb3MgU3plcmVk
aSB3cm90ZToNCj4+PiBPbiBUdWUsIDE3IE1heSAyMDIyIGF0IDEyOjA4LCBEaGFybWVuZHJhIFNp
bmdoIDxkaGFyYW1oYW5zODdAZ21haWwuY29tPiB3cm90ZToNCj4+Pj4NCj4+Pj4gSW4gRlVTRSwg
YXMgb2Ygbm93LCB1bmNhY2hlZCBsb29rdXBzIGFyZSBleHBlbnNpdmUgb3ZlciB0aGUgd2lyZS4N
Cj4+Pj4gRS5nIGFkZGl0aW9uYWwgbGF0ZW5jaWVzIGFuZCBzdHJlc3NpbmcgKG1ldGEgZGF0YSkg
c2VydmVycyBmcm9tDQo+Pj4+IHRob3VzYW5kcyBvZiBjbGllbnRzLiBUaGVzZSBsb29rdXAgY2Fs
bHMgcG9zc2libHkgY2FuIGJlIGF2b2lkZWQNCj4+Pj4gaW4gc29tZSBjYXNlcy4gSW5jb21pbmcg
dGhyZWUgcGF0Y2hlcyBhZGRyZXNzIHRoaXMgaXNzdWUuDQo+Pj4+DQo+Pj4+DQo+Pj4+IEZpc3Qg
cGF0Y2ggaGFuZGxlcyB0aGUgY2FzZSB3aGVyZSB3ZSBhcmUgY3JlYXRpbmcgYSBmaWxlIHdpdGgg
T19DUkVBVC4NCj4+Pj4gQmVmb3JlIHdlIGdvIGZvciBmaWxlIGNyZWF0aW9uLCB3ZSBkbyBhIGxv
b2t1cCBvbiB0aGUgZmlsZSB3aGljaCBpcyBtb3N0DQo+Pj4+IGxpa2VseSBub24tZXhpc3RlbnQu
IEFmdGVyIHRoaXMgbG9va3VwIGlzIGRvbmUsIHdlIGFnYWluIGdvIGludG8gbGliZnVzZQ0KPj4+
PiB0byBjcmVhdGUgZmlsZS4gU3VjaCBsb29rdXBzIHdoZXJlIGZpbGUgaXMgbW9zdCBsaWtlbHkg
bm9uLWV4aXN0ZW50LCBjYW4NCj4+Pj4gYmUgYXZvaWRlZC4NCj4+Pg0KPj4+IEknZCByZWFsbHkg
bGlrZSB0byBzZWUgYSBiaXQgd2lkZXIgcGljdHVyZS4uLg0KPj4+DQo+Pj4gV2UgaGF2ZSBzZXZl
cmFsIGNhc2VzLCBmaXJzdCBvZiBhbGwgbGV0J3MgbG9vayBhdCBwbGFpbiBPX0NSRUFUDQo+Pj4g
d2l0aG91dCBPX0VYQ0wgKGFzc3VtZSB0aGF0IHRoZXJlIHdlcmUgbm8gY2hhbmdlcyBzaW5jZSB0
aGUgbGFzdA0KPj4+IGxvb2t1cCBmb3Igc2ltcGxpY2l0eSk6DQo+Pj4NCj4+PiBbbm90IGNhY2hl
ZCwgbmVnYXRpdmVdDQo+Pj4gICAgICAtPmF0b21pY19vcGVuKCkNCj4+PiAgICAgICAgIExPT0tV
UA0KPj4+ICAgICAgICAgQ1JFQVRFDQo+Pj4NCj4+DQo+PiBbLi4uXQ0KPj4NCj4+PiBbbm90IGNh
Y2hlZF0NCj4+PiAgICAgIC0+YXRvbWljX29wZW4oKQ0KPj4+ICAgICAgICAgIE9QRU5fQVRPTUlD
DQo+Pg0KPj4gbmV3IHBhdGNoIHZlcnNpb24gaXMgZXZlbnR1YWxseSBnb2luZyB0aHJvdWdoIHhm
c3Rlc3RzIChhbmQgaXQgZmluZHMNCj4+IHNvbWUgaXNzdWVzKSwgYnV0IEkgaGF2ZSBhIHF1ZXN0
aW9uIGFib3V0IHdvcmRpbmcgaGVyZS4gV2h5DQo+PiAiT1BFTl9BVE9NSUMiIGFuZCBub3QgIkFU
T01JQ19PUEVOIi4gQmFzZWQgb24geW91ciBjb21tZW50ICBARGhhcm1lbmRyYQ0KPj4gcmVuYW1l
ZCBhbGwgZnVuY3Rpb25zIGFuZCB0aGlzIGZ1c2Ugb3AgIm9wZW4gYXRvbWljIiBpbnN0ZWFkIG9m
ICJhdG9taWMNCj4+IG9wZW4iIC0gZm9yIG15IG5vbiBuYXRpdmUgRW5nbGlzaCB0aGlzIHNvdW5k
cyByYXRoZXIgd2VpcmQuIEF0IGJlc3QgaXQNCj4+IHNob3VsZCBiZSAib3BlbiBhdG9taWNhbGx5
Ij8NCj4gDQo+IEZVU0VfT1BFTl9BVE9NSUMgaXMgYSBzcGVjaWFsaXphdGlvbiBvZiBGVVNFX09Q
RU4uICBEb2VzIHRoYXQgZXhwbGFpbg0KPiBteSB0aGlua2luZz8NCg0KWWVhaCwganVzdCB0aGUg
dmZzIGZ1bmN0aW9uIGlzIGFsc28gY2FsbGVkIGF0b21pY19vcGVuLiBXZSBub3cgaGF2ZQ0KDQoN
CnN0YXRpYyBpbnQgZnVzZV9hdG9taWNfb3BlbihzdHJ1Y3QgaW5vZGUgKmRpciwgc3RydWN0IGRl
bnRyeSAqZW50cnksDQogICAgICAgICAgICAgICAgIHN0cnVjdCBmaWxlICpmaWxlLCB1bnNpZ25l
ZCBmbGFncywNCiAgICAgICAgICAgICAgICAgdW1vZGVfdCBtb2RlKQ0Kew0KICAgICBzdHJ1Y3Qg
ZnVzZV9jb25uICpmYyA9IGdldF9mdXNlX2Nvbm4oZGlyKTsNCg0KICAgICBpZiAoZmMtPm5vX29w
ZW5fYXRvbWljKQ0KICAgICAgICAgcmV0dXJuIGZ1c2Vfb3Blbl9ub25hdG9taWMoZGlyLCBlbnRy
eSwgZmlsZSwgZmxhZ3MsIG1vZGUpOw0KICAgICBlbHNlDQogICAgICAgICByZXR1cm4gZnVzZV9v
cGVuX2F0b21pYyhkaXIsIGVudHJ5LCBmaWxlLCBmbGFncywgbW9kZSk7DQp9DQoNCg0KUGVyc29u
YWxseSBJIHdvdWxkIHVzZSBzb21ldGhpbmcgbGlrZSBfZnVzZV9hdG9taWNfb3BlbigpIGFuZCAN
CmZ1c2VfY3JlYXRlX29wZW4oKSAoaW5zdGVhZCBvZiBmdXNlX29wZW5fbm9uYXRvbWljKS4gVGhl
IG9yZGVyIG9mICJvcGVuIA0KYXRvbWljIiBhbHNvIG1hZGUgaXQgaW50byBsaWJmdXNlIGFuZCBj
b21tZW50cyAtIGl0IGp1c3Qgc291bmRzIGEgYml0IA0Kd2VpcmQgOykgSSBoYXZlIHRvIGxpdmUg
d2l0aCBpdCwgaWYgeW91IHByZWZlciBpdCBsaWtlIHRoaXMuDQoNCg0KVGhhbmtzLA0KQmVybmQN
Cg0K
