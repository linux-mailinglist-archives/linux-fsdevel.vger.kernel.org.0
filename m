Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C21E44DA215
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Mar 2022 19:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350858AbiCOSJx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Mar 2022 14:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344202AbiCOSJx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Mar 2022 14:09:53 -0400
Received: from mx0b-003b2802.pphosted.com (mx0b-003b2802.pphosted.com [205.220.180.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C951559A47;
        Tue, 15 Mar 2022 11:08:40 -0700 (PDT)
Received: from pps.filterd (m0278971.ppops.net [127.0.0.1])
        by mx0a-003b2802.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22FBfMMo000741;
        Tue, 15 Mar 2022 18:08:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=4Eg6GTGDJLi0SUUSW4bYnlXgQUnL6C2BUVEwYDGkk20=;
 b=DiOhQ8FOT7uUCDxXWhUdkj/OBy1115DmhD76ClSzv7RAKPW25JvPCsKgJou3/GcaS/ri
 X/iesIBJZ1u7dseHNSnO0covD8xNKWWez03v1i7p5u8et9+VQlxSYk6JyFH94/KyNZGY
 /FqkRAIXv8QeY5bxjdpJf1FZrtWxBgoihDAe9mrIiXeocciaMGeGhT7H+S8RUFmofAEm
 20TdvPX9qKsCulFhBVXdWDL7fAoHMJ5x34fiaY0U1MfSDItHUJJZLCUbTvOl0GZI8ewV
 aoK4l2R1z5mwTm4y/9LnMZ6p5ztQFfDSY0tdXjS7mBuYb47Mw8qikhyFrAR6zPibZ7Q8 JA== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
        by mx0a-003b2802.pphosted.com (PPS) with ESMTPS id 3et64439qv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Mar 2022 18:08:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=amBRULv/wgecEWhwPG2q2sDyrlfcnae/xslc5kbKTFAum5Pxe+04NcDd6D0ojSn7gRO3767MAcj1WhbJ0yxfPUXs0wK0Lalev/WzHksy8ybAgNS9u8noN0htPN5mcuThXP3ISeYQWBOnRvkGwHLHKTalakqocXttjnXtnt7O4pCRQyWj6bDusT51mmU0YfLoNJ3g3LmBVF9ud+O/UnDxMvF2Ci/gZzQkbJri7o0HqDyR3ddjpOUKKptoLIdTzuKZrZEd75Al+lGo6rFhkOdB1lB9V2Z6/b9Zqb6Qy6pjQBfXBEOIr8Np+n/k56Zz7WdLBUI5aGG248iQabFk6DPQ6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Eg6GTGDJLi0SUUSW4bYnlXgQUnL6C2BUVEwYDGkk20=;
 b=ixWYDfoEquBe074DPYZwjBnUGFHQ8Yt9gjcdUGubvF8BCp8NZkPTnByli9AW3YQjVPCH3Tm6/NDgExRZFqPi+GEKgMAlQXqK/oSS/C5Jjvwx3dM5c+Kludfx3VzGVB70JhYpDqthyKe6Yaz7b0nnlRPaJTLQYCjzsUyGgI9r01V5pwddTlSXTKU6MTHXqSN+iNOuFmv0hdZXI/ZjsRSb+zRRzu/aQoDab0U/a+C8hCDMcy5NyhiQkzq2gHQPB18Db/w3QauNaiU9cVk6xm16S4DQwQIG78+relSVbKaWy/3LcB4aOOS/xjQGuC/ZLIqFvRS6iBFWhyZ6aPUsnyN2LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=micron.com; dmarc=pass action=none header.from=micron.com;
 dkim=pass header.d=micron.com; arc=none
Received: from CO3PR08MB7975.namprd08.prod.outlook.com (2603:10b6:303:166::10)
 by MWHPR0801MB3803.namprd08.prod.outlook.com (2603:10b6:301:7f::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Tue, 15 Mar
 2022 18:08:25 +0000
Received: from CO3PR08MB7975.namprd08.prod.outlook.com
 ([fe80::106d:1c1:99ae:45ac]) by CO3PR08MB7975.namprd08.prod.outlook.com
 ([fe80::106d:1c1:99ae:45ac%9]) with mapi id 15.20.5061.028; Tue, 15 Mar 2022
 18:08:25 +0000
From:   "Luca Porzio (lporzio)" <lporzio@micron.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>
CC:     =?iso-8859-1?Q?Matias_Bj=F8rling?= <Matias.Bjorling@wdc.com>,
        =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier.gonz@samsung.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Keith Busch <Keith.Busch@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: RE: [EXT] [LSF/MM/BPF BoF] BoF for Zoned Storage
Thread-Topic: [EXT] [LSF/MM/BPF BoF] BoF for Zoned Storage
Thread-Index: AQHYLpnb4NSFBK3tMkukjFRN8f0P9qzAzpgg
Date:   Tue, 15 Mar 2022 18:08:25 +0000
Message-ID: <CO3PR08MB7975BCC4FF096DD6190DEF5DDC109@CO3PR08MB7975.namprd08.prod.outlook.com>
References: <YiASVnlEEsyj8kzN@bombadil.infradead.org>
In-Reply-To: <YiASVnlEEsyj8kzN@bombadil.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_6fdea275-d6f3-438f-b8d8-013cab2023d3_Enabled=true;
 MSIP_Label_6fdea275-d6f3-438f-b8d8-013cab2023d3_SetDate=2022-03-15T17:55:54Z;
 MSIP_Label_6fdea275-d6f3-438f-b8d8-013cab2023d3_Method=Privileged;
 MSIP_Label_6fdea275-d6f3-438f-b8d8-013cab2023d3_Name=Public;
 MSIP_Label_6fdea275-d6f3-438f-b8d8-013cab2023d3_SiteId=f38a5ecd-2813-4862-b11b-ac1d563c806f;
 MSIP_Label_6fdea275-d6f3-438f-b8d8-013cab2023d3_ActionId=c6b6032e-0cbf-421e-94bb-34f755fdf531;
 MSIP_Label_6fdea275-d6f3-438f-b8d8-013cab2023d3_ContentBits=0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2e62c486-0730-4b01-507d-08da06aeccc5
x-ms-traffictypediagnostic: MWHPR0801MB3803:EE_
x-microsoft-antispam-prvs: <MWHPR0801MB3803ECBBCED955F8D579FD3FDC109@MWHPR0801MB3803.namprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W8UEKc0aBRPbiPO/mC8Pa1kegY9egQnRCwzoHAzkz4ijgR7rWoNbeO45txwWigN259alNjz/zgiA6+RzOwllDL+/ua9299oWCo5m64zzaFf5PMP5uGIOYIGsb9x/C/nQjieMDyFdvdwwDZJJRzq+JJR9kL/vOtEQ70rJa5X6HHCevUbWlJTqnt/JHyPAUWjrZWbSa3u28DoQbrJNds1qKyG2gm1BtCy6gRCULpvBnYw3pw6Dja/VvFYob92P7qUKVaemlVYaHajGLCphC4eeJXFA7LmnPGtHLNtK6p+FcEo/GSorb+T/JOSKyM9trDM6cWH5PfQxHc9kTqMPsHTpwjs19Okl1CYAJ2fOrWxlmLHYOkteJB/hWqREfOc7q2X8POBWcHQvcSYnod+wiNVjxE7LZE611ujiLT7PI0Lrq1TeMlpl5Etwcfeh0FVQ9YlhY/MvIdjs+TWISzNvcRUw3yENw30e2dK7zNDFPgGGMOEYW86qTaJ7y6eNUo86O7ULGEXWh2MwB+VomT8YViAw4NIT1KoyrFUzVR6tBiQm52ULJ/VXX9k0dC2nkuqpA1SRxrruH9r6ay1suW5GE7iLkIhB8N9BCM3UcUZZ1EjOPnLuz7P40Ra89ZLJ3FOOg+DaYRm7OQ8y6VXKQyZoE3lB4aLP0qFDwTQWalFlxBSWb6tr7orWfE/I7SCGHl2j1oeti5YiPIJNMWTMPQDnfVyC5Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO3PR08MB7975.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(64756008)(52536014)(7416002)(33656002)(508600001)(4744005)(8936002)(4326008)(8676002)(66556008)(122000001)(66946007)(66476007)(66446008)(71200400001)(2906002)(316002)(5660300002)(110136005)(54906003)(7696005)(6506007)(9686003)(76116006)(86362001)(38070700005)(55016003)(186003)(26005)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Q5fAim3AzEh0n6K8TgBVpKV7wz6r1GCasY1Zd9lDkk9usEOtlyCrsVh5Ly?=
 =?iso-8859-1?Q?e+3TcPEEvexKuMZWUk17gBozOcdZ+kvUpMiDJunC23AC5O5l0+WBnL724S?=
 =?iso-8859-1?Q?ZpFLz09/Rd6mXq3xk3NBuPmsqoINhHiYorKKpELKZan0tlbSy+XVIls5hj?=
 =?iso-8859-1?Q?FrSXjPvXVfUao5FagHrCfxVcNsPgYiFcy/7MIRTHpKgzAuNayIwCWVQqJN?=
 =?iso-8859-1?Q?K0N6HyIcW4rfJ+WNYOsHKrdwMg34NyNSIwly5/Mg+/AnNGp66BjWwQHbF6?=
 =?iso-8859-1?Q?6SNy12h2G0/ZEuR7XeNQubOfwgxRw4WGKTKzsVru/JAquLZDgN7mWzVGLp?=
 =?iso-8859-1?Q?DRt3Ioc8Gj5ey+9N7VFD03rMT3bg2zH3JgIx4WepeI/flmctcDoyngQnsJ?=
 =?iso-8859-1?Q?A1NpWjJB4a9MM+jicvps25etHKCg5NWCMEv0bXAiqKYKX0aLob6JppK9I+?=
 =?iso-8859-1?Q?iI7/6K9qAhQ9Spo62uIvQkbjUQ0gfH7SCbhr+wy7sC3KKE2By/IZ5a6Tvt?=
 =?iso-8859-1?Q?fGcNG36L46HLFU89YAkuDTgtsJEfiGfMPIwFRjtnZyY453PSwIIvj2tlD0?=
 =?iso-8859-1?Q?W7ZARh3nuBTfzdxFatsMWOYIXZ9MiHaj1ToNlOTz4GaEVXmMJgMvUA5ZKG?=
 =?iso-8859-1?Q?IP0+RzmdAwUitY1ojpI0tbPCIpVO/d4P3t9ZQ6Hw0oP72qdJ0GABe4xTeW?=
 =?iso-8859-1?Q?o0+8CPkzJ/9BZPScSONptfDDoaBKukzZ2hGELxWt0qqrmWKJORZhbGwObN?=
 =?iso-8859-1?Q?isnpbaIu68V3A0jISZdGuivzgYqJk4B2dpI0KIZoYEZUCcLxXCTsoCQIUK?=
 =?iso-8859-1?Q?eP9rw96Nr6LuW+3Qr9SlbZuZ3kHTJsyYuIZxvUt33Za5e2hlmmTwnwu8PO?=
 =?iso-8859-1?Q?I7+aJGz67euEajejpQt/QuqBBfBby2Cks5QHmEFpdnTW2c2b9cKrQblpPh?=
 =?iso-8859-1?Q?pU+O1neHR6yJGuAaNn11jcfMXJ6oz0yVW98IxM/k+SusF6qwm2IPqht5mM?=
 =?iso-8859-1?Q?Qgx35LlThWrZYtXiFfcbWjAzkv5qjWXgDm5KQF7m4JoD2V+4FtQj8oYIex?=
 =?iso-8859-1?Q?lBWSvSAK2mBy/Qj135ny7aYrs0lhzWsn1/svsyj5oPBgyljd0ghEqX5Q0P?=
 =?iso-8859-1?Q?zO2B+cBy7zXmVvj2JJl58U+IJ9z19DGrmjrutvqEHBqm9wUtuYWswfUdqm?=
 =?iso-8859-1?Q?/f9ZSzEqtlQXp/JKnYsU3PHJSRY3Cg6X3GwojztPc7tbpOBSd0c9RSgYWd?=
 =?iso-8859-1?Q?zEtdyhHXK98s5xbTG3wjtfOPCuZeoOx3c585cdh0SdLdfiw9hE5bYwmoFN?=
 =?iso-8859-1?Q?Xnz3ZGofQOdrLnffxCZF75AVD3bFXVN1l95ZrNbgWVvlBQTWkN9gdx5D70?=
 =?iso-8859-1?Q?xiK0I0+esRdIjgesvCubhfDzgMSch0+BzdlfFRaCRrrnBhe/hjZHZTbd33?=
 =?iso-8859-1?Q?1mqeXop383ai9+B+ovnyHdl7kR5sKM5LhPc4YZwCQhUcFq5MW+BM+x6Lhb?=
 =?iso-8859-1?Q?h2wNZEvYGaRPiTQqQKtWd3?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO3PR08MB7975.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e62c486-0730-4b01-507d-08da06aeccc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 18:08:25.3718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r9+ep0/e9RuLACrCKubVa1WLXSSsv2xjRKVVNaFwmT8piRtu4B4//BlK9Srvz3OaSSPSN2AyiqBH0tW+NI+Z3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0801MB3803
X-Proofpoint-GUID: IM9dJZNeU-0E9QV1-PYkbU4XVFBJ9Vet
X-Proofpoint-ORIG-GUID: IM9dJZNeU-0E9QV1-PYkbU4XVFBJ9Vet
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Thinking proactively about LSFMM, regarding just Zone storage..
>=20
> I'd like to propose a BoF for Zoned Storage. The point of it is to addres=
s the
> existing point points we have and take advantage of having folks in the r=
oom
> we can likely settle on things faster which otherwise would take years.
>=20
> I'll throw at least one topic out:
>=20
>   * Raw access for zone append for microbenchmarks:
>         - are we really happy with the status quo?
>         - if not what outlets do we have?
>=20
> I think the nvme passthrogh stuff deserves it's own shared discussion tho=
ugh
> and should not make it part of the BoF.
>=20
>   Luis

Hi,

I'm doing some study on how ZNS may be introduced in UFS+embedded (android)=
=20
platforms and share this study with you to discuss changes which might be r=
equired=20
in Linux to support ZNS for embedded devices.

Can I get invitation?

Cheers,
   Luca

