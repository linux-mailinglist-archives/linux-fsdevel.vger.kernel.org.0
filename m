Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 877EC60E6F5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Oct 2022 20:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233567AbiJZSG2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Oct 2022 14:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbiJZSG1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Oct 2022 14:06:27 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2072.outbound.protection.outlook.com [40.107.100.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6DA7646A;
        Wed, 26 Oct 2022 11:06:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YYEzSysDvUSJc28avj0pn6tGxEabBajSWgcCZT0ovST/hcngoPrEe1++Shd4XeqkAonM4sHAp7ggo23obarb5oVy6wcEfqXLg5x7r5p1RpGMOOOyiM0zkYxbp1l0/vkqll7qtnzPbG6dYOrXbaiI/QElDjUZY3J5dClreNsycPbhehfJGZ+gI74ucajp7YZjL8CR1jnZ1yRzEAxVo6WvKaHKQH/wSYOaY50fIUhrlWou1Gdg8+Jsaf31j8SWY7E9DG+y+e/kKPpiqrzWHFIR+9vJXd9JPwPgnbx+nAcdBv30I7weJn7aSOw0JLx1psjMM8c43xONumZaoM51ZvcGQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CxBG3gumM3e5bV+iIRMpa9gbxFbIkRx1fswD0NT6iOg=;
 b=nyeNbjt82XwTCPEukdwLZ2ZEp1Pat5WriwT4AUz0WKBS7newOvGaiQKalAwfECuZ2bvCXFDwvkZZGVMQ6YAP0coz0IEm219JWrDbZKJKa8LURO3ZRXc108Dv/VhF1jYLu2XbdudRGbga0JIWfIqAORfw7JgmfXuElxdrsOvtoJBfhJqjSX8eymTRpiGs1PufkDOKGyBpMtcCQLa9txLvA4ULGereZbep2E0MH9QUdBjM5P1VoydFJPESUwnQLJgGCQoPlj+ITorehfbStrdrKUl6+5jdkhu9h9VOk0D8nTDvbh+bucdMttTNf4dgrZEaHaCWzlEv6h8+RHsTApS6QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CxBG3gumM3e5bV+iIRMpa9gbxFbIkRx1fswD0NT6iOg=;
 b=g4+BrTYQxe6sw+uc6j/zazf6GRA0H3H9PzkjUSKy9ZqAu0Dp6Hw9VMgbKVSyVuMtH9fKnHjZoaTdQzOe07WfkCG0Q73QsseQfB+0lKcwPwp8OYr0VeVsaZklKUvZyADZBP9UufzHRASDGUP8rm1QOX1vSmujmbW8PvVLWueqqRnXBDct1CsD8dk+Q5jRRDZkAIv5gSf2L2rRYVG9W5saaJofOiKu+YuzCRl0GmbO3Zlr9d2yeTVDU89GzCriIuGUnEl80YfEqOkhC6wMKYXP+AXOohpqwYOQkSdNaD9NDOoM5d4Y4omFcWxpVnCtVPGC99TRkVcpSV6Incm4MTisWg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SA1PR12MB6896.namprd12.prod.outlook.com (2603:10b6:806:24f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Wed, 26 Oct
 2022 18:06:24 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::1402:a17a:71c1:25a3]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::1402:a17a:71c1:25a3%7]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 18:06:24 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Keith Busch <kbusch@meta.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>, "djwong@kernel.org" <djwong@kernel.org>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] iomap: directly use logical block size
Thread-Topic: [PATCH] iomap: directly use logical block size
Thread-Index: AQHY6VtMhGyUgFy+mUmBUk3rMgjjWK4g+JmA
Date:   Wed, 26 Oct 2022 18:06:24 +0000
Message-ID: <526c5c01-3c3f-3ef0-35f7-924a6e3db134@nvidia.com>
References: <20221026165133.2563946-1-kbusch@meta.com>
In-Reply-To: <20221026165133.2563946-1-kbusch@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|SA1PR12MB6896:EE_
x-ms-office365-filtering-correlation-id: 3188c1bb-f734-4bc2-8caf-08dab77ccb74
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SlGt3DlQ5IeBYCLVsS3rQPr/fd+dSPyrglDOppVSfdDtHqcAvoyvowy7IVpJgRacuKg49qXYydCG/0xVDq9vI1T199qytMu/oC01gCtdJ7iu3OxCqgIKQB+ziIy6/qIC7J1ocgYh+zBcF0IrCQ8vVk+rUgRN/eaEK05dxeDzD/JGQahYPx5wSfoKWjKzRZLH3XqrF+HbGbgi+fhf206/KjX5QuNS3rYgk5LZ5qlUPnN/a2YLeuL/zRUm86HWA33+dsBsT76kpc/J9ME5w0dIXEQ7eevdaB8r7Bx48aGfTXKwrJLZvsUMiifvzg54m3suXKYMt2TxQXleo7a26RTC7LQVBdb4HscoeN0AJCZuBoninOyDNxP3s/e/ZLOawr7RPSjJ6sqoQ4UD72PfKY6o/dyGB8boU1pdwusceZ3NrFfXvxe0wgdhBgbsrdvTsxKJ3NNc8pPwiQOt/l8fXJftcwluD3TcZb41Ck4Bel6CSjEd7FZK6yRjVrIdJDJRqYFmVvKlAuBdlVFtmBtgyS6UVtnbThbBLE4a6hgKOZog9ok5aLk2rngm3GVhxa+FS2jb0iLnMc8k/dO71JN03MmOt6MDq24mnN6Tt1J6iaF4XnlFXMwYPB07g07hjq7BiloSz7s1VTyHEFS9LtAd5dyXaeg0RT0/r/xDnml9EVXS/Vmxj4G5tljUNr5qWZjnfK1eF20UDW1mfjBLllovI8y52leTVPtheh2+WlH3ofTL7n8BdA81bYS4aTVrwK+4lhenUKLHCQRn4Cr5OqLlgh9m6aXJfKLT1qs4Gx2yigPGMsHSuFhiJGUOT2zosTNtS2jLqGxYb9zmyMRqSUPUMhFDYA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(346002)(136003)(396003)(376002)(451199015)(5660300002)(2616005)(26005)(2906002)(38070700005)(83380400001)(186003)(38100700002)(31696002)(54906003)(122000001)(4744005)(8936002)(86362001)(478600001)(8676002)(91956017)(6506007)(76116006)(64756008)(53546011)(66556008)(66946007)(4326008)(66446008)(71200400001)(6512007)(41300700001)(110136005)(316002)(36756003)(31686004)(66476007)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZmRzaG5YcytkZ3hvZ3I1WVcyRzRzLzNrZzV6WG9MUmtsMGVFRXY5bVNmSXFM?=
 =?utf-8?B?N2txREdaSFlCVWoyYVArbmU2aitsSS9yV0dVQnFqZGdRbkNTZW9KbldkRXZ5?=
 =?utf-8?B?eDFRYTh1RkRlM1ZoKzhQU0lDNHd6dC9QMURpZHpkajFFanZMdnMrM0VRRDhR?=
 =?utf-8?B?UXMrbFlNelhkK3puVEVraUpVeG9HU3ZldHBDVDBpVjQzN1FKbEk1VXcyeHdW?=
 =?utf-8?B?bFhocjJYMFVRM2xDZi9QbkM1NmhXcHFVK0JocFczdmxLdVdyS05yNE81TnRZ?=
 =?utf-8?B?SWh3cTVnR0pnRk5VcHJxdkkxclB3ODRkS25NUVRta3F2N2M2TFZFVDVEc0Rh?=
 =?utf-8?B?YWl5MGdoRHAwV1lDejJXTkpqdTBZa0Via0wwOWpWbHd4T2pkc0pzSHBka2NB?=
 =?utf-8?B?NnJjK202aUZmWWd6clRtcXV1SU9yME5rdWNYb1pUaDZaNENCZ0JJeWNJSS8r?=
 =?utf-8?B?ZElDODk2VUFzZHBCditqb2NURDdHR1JMYzdoaG9rdkN0L3B4WHhpNUJ0NnAy?=
 =?utf-8?B?TFB3aDltK3krTGpYOGRyUHdYVVpvd0kxV21yMmdGdUg0WXhQaERiMWFRWEpE?=
 =?utf-8?B?NUs0U0FKS3lKTkJCUkJpR285RHkxSllqaExrZm1aOXNpRE8zdFFYRXlsZk5Q?=
 =?utf-8?B?UFZubVZXMU1hRWRqMXluSUsvSXAzdmRXRkFSZ2xpTWFXdVBwZlYxZFJKR0hR?=
 =?utf-8?B?Qk92a3lqSGVYRnpzU1BCcWRONmZqWVU3bVFRWmU5by9BZDY1NWJwUzdlMVV3?=
 =?utf-8?B?OCtwS2Z4QXpaOVVwbTZZWmVBQnFXUWI2T1RDUHYvK3JrQ2hSam8yd2t1Ukxj?=
 =?utf-8?B?MDFNcU1Ua1p3YzdIbHIrdXAvTm5EVW9XWUcxamZDOElFcGtBT0lWbFY4TDdE?=
 =?utf-8?B?UExoRTNVTm9tSWRQNGhhSkVEYzgzME5ycFd6UXNmb0xrT1lNc1RYT0pVc3JU?=
 =?utf-8?B?RlRpdjZ6WHMwb3d0QndKWDdzRG4vNVUwVUJLMDBkT2k5U2tiWWdFaG1XZmd4?=
 =?utf-8?B?aG1RUDhHZElzaytNMEZuQkRibk5PT0JNRnU2d2dnOUxOcHFFZjdjeWRwS25w?=
 =?utf-8?B?SWdEOHZvWmt2bFc4ZWRlY2JxYllDeEFSRGVBb0JjYnJjTGtFQ1VVc3AvL2tQ?=
 =?utf-8?B?RUVkbERsUmcrZ0hlQkhhNGx0Si9mU0wvblM0N2NqSCtpOVVUSHpkYTBBbWpW?=
 =?utf-8?B?d0p4cHh5YUtycVBrMHdsZG4wQTFMYmFOVVdqSkZWQStsTVI4MkVSMHdCajhR?=
 =?utf-8?B?Nm9ZYTVtTmhKZ0xyWlltZ0hSbi9Eb3NYYjh5R3UrOHFwTnpnWklzUXNtWElG?=
 =?utf-8?B?cHpRWTdLSEMvOVZRWkdtMGlZcmlCVjkwckg2ZGF4MkEzSGR1SlRJbXk4YWdo?=
 =?utf-8?B?QzhWZWxhLy9Sd0haNHk1THJFcE0wRjFQN08wVUpIeWlWVFp2eDIwai9sOEFp?=
 =?utf-8?B?cnR6ekVBRFhmVEN1NFhhbzVhd3BLWGF4Sm9ORHUxeWNEVXg0ZHZRUWk4eUJi?=
 =?utf-8?B?SzluZlc3dXJ2N0lEeXFVbFl1cFNxekJFcmNzSW5kcjZ2M2UwaEhsUFZYT0c1?=
 =?utf-8?B?WTcwUmxsMXVnR1JncHdqQXlvWWYvN0JtcDBRYXV6ZXRkYnZlem82OUxkQmxD?=
 =?utf-8?B?RCtEM0ovbUQ4NDR2d3RjbUdybmpTYWQwajVuS1dxNVZzd3RNSmgrTGVvcVkx?=
 =?utf-8?B?Um04Qk9sa1cvRDFuWDJCUlFuVHpSNS9Ha1VXNCswNDZzOHYwM2pvelJ3TURU?=
 =?utf-8?B?SVMrU0FIMXVTWmR5VlJRd2RET1BadHhIbzBUbUluT1EyTDlieDRMV2lodjho?=
 =?utf-8?B?R3MxNktUTVVTaWxIRFJjSEs0cWYrY2hRWkdhMDY2SXVFTkFGQ01VSi83YnpH?=
 =?utf-8?B?elVIeHBHK0FUZ2UxRlJKcGpMazhSWE04ajVqT1c4cTV4bExJVkxnWW00Y1l5?=
 =?utf-8?B?R0tDU252WUVKMTc2QWJldEgxWjNlR1lBb3pmQlBRdXhoTUplZEZyVlZSTzRB?=
 =?utf-8?B?aW53Tm1YV3VNWS9CK0FIMDBXd2hJZTFZUFMxUlFHYzdkS1NUV1ZoOU56bExa?=
 =?utf-8?B?ZXhuNlI2NnhYeklXVmlaUXVpeklXMUtnNzRwUXhWMWRuL0ovbWRtL2JlZVBi?=
 =?utf-8?Q?8rNO66YhGC7KDpVWm9gAa5pET?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <40A93DC729E017438D232374C62CB030@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3188c1bb-f734-4bc2-8caf-08dab77ccb74
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2022 18:06:24.2962
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q2/QEglSUeESBQ8goTyj6TpGn5xZBQwWi0cUF8Cv1UGoOGgJaWtsCB6Yq+t/nHM+0seWZ4DxTVLuzvfJEfiGsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6896
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMTAvMjYvMjAyMiA5OjUxIEFNLCBLZWl0aCBCdXNjaCB3cm90ZToNCj4gRnJvbTogS2VpdGgg
QnVzY2ggPGtidXNjaEBrZXJuZWwub3JnPg0KPiANCj4gRG9uJ3QgdHJhbnNmb3JtIHRoZSBsb2dp
Y2FsIGJsb2NrIHNpemUgdG8gYSBiaXQgc2hpZnQgb25seSB0byBzaGlmdCBpdA0KPiBiYWNrIHRv
IHRoZSBvcmlnaW5hbCBibG9jayBzaXplLiBKdXN0IHVzZSB0aGUgc2l6ZS4NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IEtlaXRoIEJ1c2NoIDxrYnVzY2hAa2VybmVsLm9yZz4NCj4gLS0tDQoNCndlIHNo
b3VsZCBhbHNvIGNoYW5nZSBhbnkgb3RoZXIgY2FsbGVycyBsaWtlIHRoaXMuDQoNClJldmlld2Vk
LWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0K
