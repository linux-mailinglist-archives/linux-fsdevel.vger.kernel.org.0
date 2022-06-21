Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE2D65534B3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jun 2022 16:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351042AbiFUOjp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jun 2022 10:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351510AbiFUOjn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jun 2022 10:39:43 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2138.outbound.protection.outlook.com [40.107.117.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D111E2528C;
        Tue, 21 Jun 2022 07:39:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EBb54Z2GAxgkBeJNRZFe5znQ8HBuqJzkey3iZJzPYRWFqSAHAm22rjQhYKyULOAEZit0ih9/kb9fYKA7tRXCKBIxX47x/BR9kJa010FjIDQPdOuBAjHWX63n55qkapXqqChMMz5tEPLeTY2Zpx8piSZ5On+g7Gw9iFZkxqnMYMhSsSxBbRAcVp+UKLqc0gPegjf5fEDpiQ+Xe7iII2k3pKjfnJpAhYQV0LnF1yTjhsM4KG+XZjWzgCvlqB7PZmhichx9zGqa/igm3mZ7sjzOgChMfTz8eysMWdvyiyL0CmlCluL3sQTh28NvW1fN5ij+yTIb9mRYCmoNdfwQXd1hag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lY553ICWDTZ3xklCuBLgoW9zpRbL8Qg9H/a+2hjUMBA=;
 b=fJE3Fy/3hvqlpMlsmOlpEPVviZ4S0xV/dt0/gFQxrTq/va0C15sahek3nee1u7MWTBpivztprmoPXVI516rHPeE4WXvFwRNbGbeYKZcRzMjkvFys7yPz1MtxlCp5YJhNn6OqIepJSVmftjb6eJFYfw+XMvL9JW7nCUDoPbDh90/OJauEP4iDZnfCtILthth/L6yexuqalYYTt1e/7Q/AjXNmgHPr8cbCH++Kde/NJt6UkwLSdrZjuwL5Y44U7jrU/f4OzdDfwc3HS5LkbUY/7bb5PakUbaJRirJuFuH3K4PsOWcM8VfQ5wPh9tR8o4KifnOSACxSJl8qx3RDXrY82w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lY553ICWDTZ3xklCuBLgoW9zpRbL8Qg9H/a+2hjUMBA=;
 b=YB34lFlaaON4YRR62u4Jrvo/cTqBmj8iSqaBWWRpDjoPF/fw5TtZPRt9zLB0aUUQSIj6Ox8ifKnvWvlWH9N2TRqxj89aiOSeo6MRRzXfHGT3VythDqxlETjmlPQYqaHwMQeeS5ZfgnAeGApSLyFA6uPm6C+BXjcVcb35qwBmRL0=
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by PU1PR06MB2087.apcprd06.prod.outlook.com (2603:1096:803:35::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.18; Tue, 21 Jun
 2022 14:39:33 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::ac67:6f7c:3c88:eb8c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::ac67:6f7c:3c88:eb8c%6]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 14:39:33 +0000
From:   =?utf-8?B?5p2O5oms6Z+s?= <frank.li@vivo.com>
To:     Namjae Jeon <linkinjeon@kernel.org>
CC:     "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?562U5aSNOiDnrZTlpI06IFtQQVRDSF0gZXhmYXQ6IGludG9yZHVjZSBza2lw?=
 =?utf-8?B?X3N0cmVhbV9jaGVjayBtb3VudCBvcHQ=?=
Thread-Topic: =?utf-8?B?562U5aSNOiBbUEFUQ0hdIGV4ZmF0OiBpbnRvcmR1Y2Ugc2tpcF9zdHJlYW1f?=
 =?utf-8?Q?check_mount_opt?=
Thread-Index: AQHYehlC77zhZwGEZ0yT3MKGsxe3Ha1H180AgADJdPCACJ+NgIAIw3/Q
Date:   Tue, 21 Jun 2022 14:39:33 +0000
Message-ID: <SEZPR06MB5269071233788E67CEB08296E8B39@SEZPR06MB5269.apcprd06.prod.outlook.com>
References: <20220607024942.811-1-frank.li@vivo.com>
 <CAKYAXd99NAbQP6m93P3bcjvWTN-T8Qy59DHJyfyTHqdH-7aWBQ@mail.gmail.com>
 <SEZPR06MB526945BC172186A13FA60B11E8A69@SEZPR06MB5269.apcprd06.prod.outlook.com>
 <CAKYAXd_j-MAYP_8a3xEi2MmxZ9Po8t2di5_yi+7V1xXJuD006A@mail.gmail.com>
In-Reply-To: <CAKYAXd_j-MAYP_8a3xEi2MmxZ9Po8t2di5_yi+7V1xXJuD006A@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cedd1781-7586-446c-a544-08da5393db8c
x-ms-traffictypediagnostic: PU1PR06MB2087:EE_
x-microsoft-antispam-prvs: <PU1PR06MB20878A01A4E039AD923D7676E8B39@PU1PR06MB2087.apcprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /FvyQUDs6N7Yged7MQXxLC+sfDVyQ4YiF73XmpaJ3ygNwN9s0dNSq7m5mW//xAS5+N5H/DiatddpXwu5C7z18TyhCUK4JgFWiv21LYRIDTt39eIjp7qgeiyC1s3Oboe5m4Er1NK/nFzlPdzwCGeL+aun6JPha2Wzcx3gZbCbtBxfvPHRv2Fhggwb9ostH9Mp/++gg6UqsntAMpZxf8LdqW5+/SWWTjFl6Rwbccl3wugawq4Q3A42szOY2cSIgYYxYN/7qpJdK+6N3O9zv3bQhy0vjRohGZip9aej+IvbiAOKnIInSGlBL3UCVinI5Ogu85TNzhqR7E8YOnu4YhQ/rEYiRbQdB94hMy9jhrqCn5cB+PuN1rxhGhKktkBlgR7K5EFuFlQWuYDy9pbY/7SKrdf9TcwdxOKutT96XC6TcS3W2VPD5NtKAdRFdqosAKtoFau6EgJwS631HqoEl++SFKteEH/M9bLy6/Jd8AonGIVVkTdUKglmVlBRWcxbVGBsR/VRlZYeHRiUBtA3K14AWM24Gc2pQplXT+srrFw2zsuEfBMMufXBuf7hAPMJS+gdbOmFOhGeWwVTFzQDPfYd79enV0aZJJ9PAxrOW8wfYkpBUmOH5+PfEApwYuwjhfZ18s2xEHcmc2r/FC8bE9i5YRLhf9GbqIad43TGKLNl6QbaqQ0UojrLg2mcc68S8RdUBZa3fcoiWwuld6q4sa56oQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(39860400002)(136003)(376002)(346002)(7696005)(54906003)(26005)(55016003)(6506007)(186003)(33656002)(9686003)(85182001)(5660300002)(2906002)(4744005)(8936002)(224303003)(122000001)(38100700002)(478600001)(316002)(52536014)(76116006)(66556008)(38070700005)(66476007)(66446008)(86362001)(41300700001)(64756008)(66946007)(4326008)(6916009)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bHZRckNNYjV6UTNzRy8yVzFmUU95My9kWlpQYTZiQzZHSTVIQVFSKzhQc0NT?=
 =?utf-8?B?eHFqV3hvL2hRcnB6SDhmcUVzWlpURjM3TVo3Y0o3YXo4MHg4dW1ybU0yUkVp?=
 =?utf-8?B?em9wSVlHcXFIcVgrclVzUE5WY095STM0dmw5V1I5OGwwU1N6U1FCdjhvMEhm?=
 =?utf-8?B?M2s5QjhMaHZqQmJ4czEwNmNxbVV0YU1BUEx4SzVidG9YY3NEMlJ1WmhQaExU?=
 =?utf-8?B?eDRnWFBIajF0TGRXTzg3VmZmejRNZ3ZOaGVmQ0dWRXNYUnlJdnpNcDV1WUxq?=
 =?utf-8?B?OXdTUVBhTHlVb1NLWjlGeGhDbzhtRU9QU1VaaTJOSllKQUNmUUdwaXB5S0x6?=
 =?utf-8?B?c2wxNVJrY04xR1puT055Q3Q5ZytIdE5ENitjS2trTFlOYU55L25hOWJwRHNT?=
 =?utf-8?B?TFlKRlBhVUJDRDdvK2ttNG5yaGp5WXg4NnRQZVFLeHVVbGZ2eCs1bFptWUZo?=
 =?utf-8?B?bjZuY2MxK1ZLNlFjMithblhxY2Zkb1FtSGNOSkJrVXFxVHBxM1l0dFA1di9I?=
 =?utf-8?B?bFZPN0JlZUd2blRRanpNUGlJTmJETU11Z0MzZlNaQ3BPZXc2emNPdEF0SG9x?=
 =?utf-8?B?MHlLZmNYeGJrK3AzNEtuSkx2Mk9xRUExaXprbkg2anl3MkI3dUZUbk02SDhm?=
 =?utf-8?B?VnlzSndYOFFkeXhiUCtvWmNwWVEwZHRmUk9SeHFNaTA4Wkx3QW1Sb0d0TEh1?=
 =?utf-8?B?Z2crcHFFSHR5S2V1aGRiSFExa0ZOMmhVb1IydFYrTGF2R3ovN0k4Sk1XQm9j?=
 =?utf-8?B?SWZXYzdlZmV1M2tnUHZ1U1ltdW91WjdheFUrSnB5R0VzbFZXS2sxQ3FpdDRz?=
 =?utf-8?B?YlZ1M01Dejh4UWgzN2RQOUpJcUZnOWszRjAvd2RQSTVvOGtXZThqR1gzWjZW?=
 =?utf-8?B?djJuVDZLQWMyOUQrSmt5ems5VW5ONjFEK2tnMXN1U1ZXZWExcW1uSjN4bXhq?=
 =?utf-8?B?VUdDbjBxYSs5NnBqbjRyMEg4WG5sTlNjMjRmMHVhOUJ4aDAveG5ZKzN5WDFk?=
 =?utf-8?B?eWEzaWhjeFR0NGlvcG8yaWVucDlheU1McTdkNkRtTEJrS0NTeWNVdVArUDNu?=
 =?utf-8?B?dE84a2E3bVdtS0ZyZ0MwVWZ4NHpYRHE3bmNpb2tkYUFwQ1IvWWE4OUhUeGlU?=
 =?utf-8?B?TlMrRmE0c2syOFE1ckJDVjE0c0ZVVDlQTVlJdDBzS0lSaXYzaGxZNGVFTng5?=
 =?utf-8?B?bHI5RjcwcG15ZGdCcEhVeGwxVHpUcXNvY0Q5S25RZEFZdVUxbjdoKzRkNzRu?=
 =?utf-8?B?WnBFZU5UcmU1NzkycDdmSThSRFdqTXNGaytKTG1UTmhoamRsQ3B1UXFLc3hJ?=
 =?utf-8?B?R0R0ZzRrSkJWYVN6UTJPckVZZ3doRmZBRjh4Q2hmSFEycTlscFE2ZTdsTHJt?=
 =?utf-8?B?WjA3Q1ZSMExadWhuK2pBNENkdm0vV1hyd1FKV2trNFdJcEdTTFAvdTdZempD?=
 =?utf-8?B?bnQzaDFKRGlOeTdxSUpCSTJtUHhQQlkwSEZmMCtTT1QvRUNyQlhoSXdTdTFx?=
 =?utf-8?B?NUdNalBod3VVQmlpRGgzb2s4ZmROb1E2c2prTnVqeVRmUU1SWnRWV1ZkWFNu?=
 =?utf-8?B?bVNGRm1MZEdtT2VsM005K0tpZlhjWkFIaHF4ZlZzUHFmZXI4bllpMFhoZzFl?=
 =?utf-8?B?V0VuYTU4dzZGRDVodks1TFcvQmJ4UFgvWldJdWI4Q29ZR3k0OEQyQzdlaE1B?=
 =?utf-8?B?RncrdnJpSVc1VUtwOUMvQnBveWd5NHUxWWJFK1dXczBvR2ZtNVBRY29DWWI4?=
 =?utf-8?B?K3dtd3IrTEoxTlk5VGJyY2UveXNHRVUyMU9oNkJWVkIvYnlsWVp5cjlJVGxp?=
 =?utf-8?B?ZDZLSVE4RitPejFqeTA2elJEMlh3VHhLMGEyVUxEei9EVmpncFBZLy9ZbGt3?=
 =?utf-8?B?UTA5NmkyQk5oVG52Z3B5SnB6ZTkzZnY3L0hQV2dsN0FFWlIxZWZYdHcwUEZM?=
 =?utf-8?B?TDdFc3R4TW5BeER5RDlnV1h6TVB4bm1YOWdORi94OCtNdHJPdW9iWUkxeVkr?=
 =?utf-8?B?M1Bwbm91MEhBM0V6Sk5TZzZDQ2RVeG01Ny9qUDFlc3FIb2daK3VOUWZJMHdV?=
 =?utf-8?B?dmZQbHFwa0cycG5EcXhmUjVhek5vWkZxM0d6R05mUUVKazFYZlJuaVRuTndQ?=
 =?utf-8?B?Ym1XbzVBaHlsc3FVeVRQbjNEdTBCbG5KZE1PcVAxTXlRU24yL0Yrei9UUGg3?=
 =?utf-8?B?ZjFxOXVKOHR2ZUJmbmtUMnpQcGVxNUxmQWVGNXlOY0F0L05tWHBZd1huellR?=
 =?utf-8?B?RmxLTTdVUUFLdlBSWWNRL3VlSEVQZVdmS2dWYUowRk9ibXNmSlR0ZFJ2Vzgv?=
 =?utf-8?Q?JtovcJEpIS+tX1453f?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cedd1781-7586-446c-a544-08da5393db8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 14:39:33.4915
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OEYJ0lKuKVEf9ZV2hKot7pcBmg/ty3yei4+Ms45drau7fD1J/apVt3LaEjwl81WMFJw/ItBbksfGqxiImRSX0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1PR06MB2087
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Pkkgc3VnZ2VzdCBmaXhpbmcgaXQgYnkgZnNjayBpbiBleGZhdHByb2dzIGJlZm9yZSBtb3VudGlu
Zy4gV2UgYXJlIHByZXBhcmluZyByZXBhaXIgZnVuY3Rpb24gcmVsZWFzZSBpbiBmc2NrIHRvIGRv
IHRoYXQgaW4gbmV4dCBtb250aC4NCg0KSXMgdGhlcmUgYW55IHByb2dyZXNzIGluIHRoZSBpbXBs
ZW1lbnRhdGlvbiBvZiB0aGlzIHBhcnQgb2YgdGhlIGNvZGU/DQpBbmQgY2FuIHlvdSBwcm92aWRl
IGEgZGVtbz8gV2hlbiBpcyBpdCBleHBlY3RlZCB0aGF0IHRoZSBjb2RlIHdpbGwgYmUgYWJsZSB0
byBiZSBtZXJnZWQuDQoNCk1CUiwNCllhbmd0YW8NCg==
