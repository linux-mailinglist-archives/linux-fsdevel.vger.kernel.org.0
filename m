Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24CCE53BF09
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jun 2022 21:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238913AbiFBTmN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jun 2022 15:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238907AbiFBTmF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jun 2022 15:42:05 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E21A13D3B;
        Thu,  2 Jun 2022 12:41:58 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 252C2YA4026365;
        Thu, 2 Jun 2022 12:41:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=RkQHchZV8WKCuHxnWrfTHlOntcA8UGscVkU8XQfhuT0=;
 b=G8PSRsfFOLN/0GSBqBOTEgg5KQ7nuj68he2mBGcJzbKmm63eTqvJgYtMINl1S6Qxfhgp
 grnWn8O0YKfiLtrZMSTtwD3fVgGecz/VIsvORQTBqO4jhKEtd9S17sb9oNkJKcLQU/s9
 FgbaGXdKxpkGd6hsc+s7rYcAKIkO4LBRMh0= 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gevuu308y-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Jun 2022 12:41:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k/Gg0J1/+ktOCAZvAtZYErAjnBCOCly19CfcA5W/5ueE6wHq3p33eWNBKey9IcTM4cCDAY8x8o9OYp6NDlqBiS6Kdk8ijJTennOR9FnLjaoKeEXUCdbjB93QvYIau/u6owYlJeN6vY9oWmbv/QHHkzrxsaELKsG9m5r7na5IDb8Ydk4PRXL07prFzo9zSPRyylAf+F19pUR19HqFrnOmTW1oo3E8k7z+PxH8WjDscJl3fUTt8NEkwLVBOMf15PFJgXILeXaqP930GHrWM3OvZEEuLhpHAoxCZp9pVFpilCpvfJVaeullifGgPoO4bYZ0KULhAohSOJdcwnHegCa3yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RkQHchZV8WKCuHxnWrfTHlOntcA8UGscVkU8XQfhuT0=;
 b=Rayr1hG3AnmXDJHqqJCbAOQs5b26mS18DU5rifkWtlCgN+sPchLc8RnAxeJDwSevpTpQ1XGbzfv88MfaM886eDOFVoVtt5/zlMt+H5odwWvbKECYpY/ZvQCquNz+p74hAMh8YESn5/EFs+jMKOi64zJJugTQvYzx1FJHaavFo8FuFe2LKgPw2d+4L6AXOTETJxChIDonkGgfwseddyqNvGPyNkkXJELe6G1QhePAhCpA6BmdYNQHE+D4YPFrtyeLp1nJ6DHSMxT1q7IhP3Vy/tPuoR0jYkDJRjbMLoANt/ifZA5ouJztae8NIHlrfYhy+72BQ9ztBPp8aO7QM4j5Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MN2PR15MB4287.namprd15.prod.outlook.com (2603:10b6:208:1b6::13)
 by BY3PR15MB4868.namprd15.prod.outlook.com (2603:10b6:a03:3c3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Thu, 2 Jun
 2022 19:41:55 +0000
Received: from MN2PR15MB4287.namprd15.prod.outlook.com
 ([fe80::548f:cce1:5c99:3995]) by MN2PR15MB4287.namprd15.prod.outlook.com
 ([fe80::548f:cce1:5c99:3995%7]) with mapi id 15.20.5314.013; Thu, 2 Jun 2022
 19:41:55 +0000
From:   Chris Mason <clm@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "dchinner@redhat.com" <dchinner@redhat.com>
Subject: Re: [PATCH RFC] iomap: invalidate pages past eof in
 iomap_do_writepage()
Thread-Topic: [PATCH RFC] iomap: invalidate pages past eof in
 iomap_do_writepage()
Thread-Index: AQHYdVSdJFyxgdgUO0+O8N+baoACW606eNWAgAAgGICAARcrAIAAkS8AgABFrwA=
Date:   Thu, 2 Jun 2022 19:41:55 +0000
Message-ID: <0B09932C-66FB-4ED9-8CF1-006EEC522E6B@fb.com>
References: <20220601011116.495988-1-clm@fb.com>
 <YpdZKbrtXJJ9mWL7@infradead.org>
 <BB5F778F-BFE5-4CC9-94DE-3118C60E13B6@fb.com>
 <20220602065252.GD1098723@dread.disaster.area> <YpjYDjeR2Wpx3ImB@cmpxchg.org>
In-Reply-To: <YpjYDjeR2Wpx3ImB@cmpxchg.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.80.82.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2bb6db40-733c-4538-67c0-08da44cff2f7
x-ms-traffictypediagnostic: BY3PR15MB4868:EE_
x-microsoft-antispam-prvs: <BY3PR15MB4868129336DA2E33165F20DFD3DE9@BY3PR15MB4868.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f1WJC03fSvE1dlpBQbkFbNlJIzHevqD3NRUGzv5+l2Iy1YOlckQq2f9xP9WofHMk56ZTbDnKYjo1glMEF7ybVP8fcja3Fv4vGOBVg91XmmamtT9eRPQ14NINt01mn7T8/T2fogmmZQBaVH6g2sXWAOYg+wieL4x0ZfkqsTINJYfIAj1lwNS8zjj76F9kE76dZ2JCnj1kBtwkEAtHSjsivEFu9olL5YPbGoKEYqeQMlHtrH938C/HXctTUv3Om1iS5LveSd3Ep21XBfQ55uafEM70CnZgliOnPlKrnFlAbUrA/AJTJ47x5IWdb5eDKF7sflYh0ZdTTXuTAIWim5H57bIXtaJXDyGhmlt/ADSqiusnXwhpw/55pRLM+6mwd3kyMbiRqBD8yK3EEGboi71ZYvyu/aAfO5sKX2+Yx6c41vahoCBmghBjRCvo2qwc70rhpCM45ka9wM5pR1mSJZfhwcxJW+8Yd8Gz117eNqH5/cQc1bSJqdtGsJEm4oW4S3I0zAYGG4SOyfNkYbvwqejBrheFr3nzldSdd6J4UteJSSb0RN8LjB/VtietveBvsQlh4YNZnCZOrLIi381s+bwZwtGbuPNYekLw9v+R//T9E5DsLMphBnMFrUgIjTk5Ah08yxHGlWo/yyVGL8gG2taBPD8bLU/WT7ohQyeY6mtUujyH0k79IvNBS1ZdesyeJvdhD3WOILqZtRPUvEpbr82o/tpEP9imwxWvLLBc8c7j7feh1TeQnbi/FljKe/rb2Efm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR15MB4287.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4744005)(83380400001)(38070700005)(38100700002)(5660300002)(86362001)(8936002)(508600001)(6486002)(6512007)(2616005)(2906002)(33656002)(6506007)(53546011)(122000001)(186003)(36756003)(6916009)(316002)(54906003)(71200400001)(4326008)(8676002)(64756008)(66446008)(66946007)(66476007)(76116006)(66556008)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RHQ3cWRlanQ0cGliOWQ5OG5RWU1ZOHJjS2xlbU1XRUNZTEZvOUp5cFVXVWli?=
 =?utf-8?B?eWlId2lqczRxQlBYR28yQVZ3c1BQQUdNTHYzUUVEdi9hbEhZSk9SdDNYMnFt?=
 =?utf-8?B?Q1R6YnVNcFlVQzROMVdtV1NLM2laNzVuVHBDbTFSRU10a1hod05EZE5POG95?=
 =?utf-8?B?cVRnY0pjYVM5dWVmT1kzSHY2MmE1Z0hVN2F5a0w2Q1JsajdCWUdENTFNT1BR?=
 =?utf-8?B?aVRBNEZ6U1VybTM5M3JFWFhTMGVJWE0xenJkNnR4WTFEMVFkMGRoSlFYNEdM?=
 =?utf-8?B?dktodGt1QlBMdmdGc0pTait4dml4TWxnYzFUR0MrZ0VlNGF0LzkyWWVDVVpz?=
 =?utf-8?B?U3VBeHV6UXYxclRnMFcwSmtTWWVtUXpLY2ZnSVpaYm5FM2ZIaWhWTlN2a3Iy?=
 =?utf-8?B?Q0gxQ0diZkNPUU9icUZFTUdXd05SRndoQzJ0ZUYwVmhuWGNhSkdlcitEcFg4?=
 =?utf-8?B?ZTBPTVFrTGswTmIvcGJPYVdBaWtjR05wcHQ1NU9XV1VWc2dzbUYwU0FEbFFr?=
 =?utf-8?B?cEdPOG1aa0ZGeUhrVjdPR1VmS1NRT0YzWmMzZk1XTHdZdjdMclhaSTdCZ3BL?=
 =?utf-8?B?dW1aRzI3N0Jscmh6NS83S2ExTzN6aUtZYThhYlhCK2VNdXhzd001Vmo4U1dt?=
 =?utf-8?B?QUpTdXlNOWJGeDVpK09BTVNVRWtYNE5Qdy9QSWVYTjVaYytFRXNBTjJZV0dG?=
 =?utf-8?B?V09JcU5qNjBFT1Izc0FDWFdsUS9aZlFzNzY2OExoRFBMQTdKRVZzNXlxOEpZ?=
 =?utf-8?B?V0lzSk9hdmk4bXd6UFptTW9Pa2VySHUyME0zZlp4UmZzeXJkcDZCaVppRkVq?=
 =?utf-8?B?MW5adG1tcnJHL1V5TngyaHd5VlQzeEpTRGtPcnNsR05jYXkwMnZXWnQ0UHVo?=
 =?utf-8?B?dmMrbmY2Qktxam1tbWJWMXRZM3FVNURzTUhiN2xzSzV3emhqN1ZKamhrajZV?=
 =?utf-8?B?UDNTcEpuTzkwWGlBc3Z2RFp6S2FaTTFZT3Z6ZTBDdkhBRXRMNXFRNUZTMXRG?=
 =?utf-8?B?aUpKanZ1SGtxci84NTFkVE9tU3RmeG9GeERGT1ZoWWR3Sk9QRDhsWHlsMHJi?=
 =?utf-8?B?M2JkNGtTaUtSSGJEdDVRYXJnL3NMMlRpaUpXZ3orNzVOZ05NODQ1WWNZRjUv?=
 =?utf-8?B?RTR1TEFqdnhTZE15dTV6VlN0djJZamd4ekRzU0Z2T1Y0eHN2a2pDNTNKT05z?=
 =?utf-8?B?Z3JBaWdHYTJJTjh2MEpWWTBoSTNMaDF6MDNRSDdLb0ZGekZLbXdvR3JpaEpz?=
 =?utf-8?B?a0NWcnBTUjRQblhiQ2RkZUg5aE9HNWJnenY4OHJvanFLeWgrTnN1bEJ6cDdW?=
 =?utf-8?B?OExsVTdJRlpZUlRXWjREZzZWT2NSSjJTVU5DcHBoK3U1dXdYVXRRR1U5Rm1E?=
 =?utf-8?B?alo3dXUvN21XWnZZcEFNZWh4amlPQlkrMFBvTzR1VzRKb05BOVIvVWpOK0to?=
 =?utf-8?B?bTlNeEVNZWZ6Si8xMG43d2xEbElNeDVHS1NaU0NXWHExYkh3ZE00SGtodWMz?=
 =?utf-8?B?QzRLaThtUllyT0UvZHJJQWlMUllvb0ZZemxRZ2tEa0lZTlc2bG5NcGx0cGFh?=
 =?utf-8?B?VWlhdnZRRCswc1NPdzk1WE1vUS92Mm9janNWbGZDaDJoVjhGa2U4NzA3VVdy?=
 =?utf-8?B?SlA3dHRwVWJJaG1WNlVpcHVkNzZiUVAxZVdzWjlxbTZ6ZllRVGkzcVgwWXFK?=
 =?utf-8?B?ZURrSTR1ZmVvWEtENXpOSUFpdG5wbHI5Z1R2czhHcnBKQmJ3d01oNDRaK3ZV?=
 =?utf-8?B?VHZ0azNFNURLQ2IyZlQwcmEzWDRGYS96bjM4UjdNY08ybXFXVGVFdXE2NUtk?=
 =?utf-8?B?ZUs1SG0zaWMrUmlyamNDbjEzdDR2RWo1c0o1YVpOTFFWd0JMZXRwV3U1UU9Y?=
 =?utf-8?B?cnMrUS9oSGFUSlVrRWh3V0FsbTZSaGo1V0lxbmtlTEgwQ2k2dkdvbFd4SVc4?=
 =?utf-8?B?R3N4TnA5WHVLZ2RmNm9WUHdYVDNyN0FJWGpRRG5NbHZXU24reC9FaG4wMXV6?=
 =?utf-8?B?bllvd3A0L2E4dHA0SUE0ZDQ4d09CaHl5M0JkYVVVMlArdmw1dUlvUEsrYm9s?=
 =?utf-8?B?VlVORE9yNFQyOVFxemNQWFZSRDNPMGQxeUZHUmRiL0RkdWErWXBScVJBTWkz?=
 =?utf-8?B?LzBPRjdGY1AvellsSGJMTytPa2pWTCtTUDdzaGtsRkZLRzNqZHk1aDVqaklG?=
 =?utf-8?B?TUtkRTg2TzNROGRSeWJkdGJBY1lnVkNjVWN4WFVWeXkvS0MvdExCYitXU2Jn?=
 =?utf-8?B?K3c2Q1BUUFdYQTI2MFc1eVcwb2R1UFA2VlVscnhYamRkcHZIV2FPS0p1VjlV?=
 =?utf-8?B?RE82aWwxY0pISTRzWEJSOWJqT09IUlFNajNtQ09BQi85M01jNGxQSG1Gdisx?=
 =?utf-8?Q?SRjxkWR+7sW2Iytg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0AC3527CFC5E34468602563CD33702F9@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR15MB4287.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bb6db40-733c-4538-67c0-08da44cff2f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2022 19:41:55.1097
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sNBOO/mPxJJkGlBmOypI08qtH6hV8SosMDdA5xOhqRZXM+sem4oMQE/zuXKS3ff2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR15MB4868
X-Proofpoint-GUID: MljP0kVP1gycFxXreszyoKs4J6y6Ucax
X-Proofpoint-ORIG-GUID: MljP0kVP1gycFxXreszyoKs4J6y6Ucax
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-02_05,2022-06-02_01,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQo+IE9uIEp1biAyLCAyMDIyLCBhdCAxMTozMiBBTSwgSm9oYW5uZXMgV2VpbmVyIDxoYW5uZXNA
Y21weGNoZy5vcmc+IHdyb3RlOg0KPiANCj4gT24gVGh1LCBKdW4gMDIsIDIwMjIgYXQgMDQ6NTI6
NTJQTSArMTAwMCwgRGF2ZSBDaGlubmVyIHdyb3RlOg0KPj4gDQo+PiBGdXJ0aGVyLCBJIGRvbid0
IHRoaW5rIHdlIG5lZWQgdG8gaW52YWxpZGF0ZSB0aGUgZm9saW8sIGVpdGhlci4gSWYNCj4+IGl0
J3MgYmV5b25kIEVPRiwgdGhlbiBpdCBpcyBiZWNhdXNlIGEgdHJ1bmNhdGUgaXMgaW4gcHJvZ3Jl
c3MgdGhhdA0KPj4gbWVhbnMgaXQgaXMgc29tZWJvZHkgZWxzZSdzIHByb2JsZW0gdG8gY2xlYW4g
dXAuIEhlbmNlIHdlIHNob3VsZA0KPj4gbGVhdmUgaXQgdG8gdGhlIHRydW5jYXRlIHRvIGRlYWwg
d2l0aCwganVzdCBsaWtlIHRoZSBwcmUtMjAxMyBjb2RlDQo+PiBkaWQuLi4uDQo+IA0KPiBQZXJm
ZWN0LCB0aGF0IHdvcmtzLg0KDQpPaywgSeKAmWxsIHJ1biBpdCB0aHJvdWdoIHhmc3Rlc3RzIGFu
ZCByZXNlbmQgYSB2Mi4gIFdpbGwgdGhpcyBjb3ZlciBhbGwgb2YgdGhlIHN1YnBhZ2UgYmxvY2tz
aXplIGNvbmNlcm5zPw0KDQotY2hyaXMNCg0KDQo=
