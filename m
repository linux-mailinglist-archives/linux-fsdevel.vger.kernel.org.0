Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74DBA4D519B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 20:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245615AbiCJSxQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Mar 2022 13:53:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233311AbiCJSxP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Mar 2022 13:53:15 -0500
Received: from mx0b-003b2802.pphosted.com (mx0b-003b2802.pphosted.com [205.220.180.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1620B120F7A;
        Thu, 10 Mar 2022 10:52:13 -0800 (PST)
Received: from pps.filterd (m0278969.ppops.net [127.0.0.1])
        by mx0a-003b2802.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22AIngBl011166;
        Thu, 10 Mar 2022 18:51:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=X8Fnd7vqzmyt8wBT/PtYZC/SYzfD8qEnPFfSQuQeCZg=;
 b=a0wy8rzF1dyYjLoX5JZkJyy7gMof3oJ289qRgFBIA1ArbwnHYvx9IrNnz39tXbnUg3//
 vn3sXPB4lGekGRgQaRvSWawRGe+K4laoQouOwL9AFGQsvDey8jRnqnZWWk2nsu4i2NA8
 ATiTwnQHao/oxvwOvzkAqiSuWU98e0usxU2wgdNaPDK1Hn/SrVkSaFkaja8U5wqcEJAJ
 muyvWQwrnGJ6SeSEWSf2myn5O1xfxUnwIcwQCi6seouuxlmEJIskOqIQJObH3i851Gc2
 OPyyRCa2tlH0rLXNvce1Kb75OtKMBDPuEaBMNrFPKKvzIqAnAfBP3ayeecgV6607bQR0 9Q== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0a-003b2802.pphosted.com (PPS) with ESMTPS id 3ekwtmdx3q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Mar 2022 18:51:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eAqB78GT9LOluxMJNJLUqTJ8aiCsJeyMisxj0Mfe6BCqdxA2x9EH8hzlaktVjL43u1Mh6wLkb1z0anvwZbNYGAvpWbyeqKjAHCJhs9zJ/tRzyAQFW8VigSDTxk0nUrLXa6Xzm6L2xjclG8C+WiUmYfyIK65y+QUmaPmoBFUG2T1qMfdyIYqhp5WeMTJECUTgH7b7+3g667yy+m9JDHB27YUHcbAkh3yaN7ySsDUkTtrG8K20JLFQKZRDbN/qyWS/xZMJQRxFVeP0snHTw75gcdC6c2/65bLMTgPA+AqnVgWZ8mwGVQN+cKV71HlDQ7NZAURsm5tJQDfB547eETBgDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X8Fnd7vqzmyt8wBT/PtYZC/SYzfD8qEnPFfSQuQeCZg=;
 b=KpqASrQn768lk2B+5WLdygoo1cyyHXJgyaFguKMhhAsmWhhF1t8wS6RGQBe9ORPjF1NzpJhkpmuEFB66Ou+LZVabHm0hzGl84WbHcvttuKybP2McM4qv7Kgpft0AtnjCCzNQhQQoMNISD2JZNhgYbS108FpSYeHzLVaCtpvdq3tTP5U0NNwcEJAba9UtRjfBDAvqRU8OSWFtiJZqJ5QG/EWBRBB5rQ+Fvqk4ceT6FGqIQdlohglMltM4BXDH840sED20XNjkOjUVXytkyw2NbCFYPbekWQauqcIyes9E48+4ic2d2vM8UAJnS8n8hjGh2to1eENf6Ldy2Sqwx2UAUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=micron.com; dmarc=pass action=none header.from=micron.com;
 dkim=pass header.d=micron.com; arc=none
Received: from CO3PR08MB7975.namprd08.prod.outlook.com (2603:10b6:303:166::10)
 by SN6PR08MB4943.namprd08.prod.outlook.com (2603:10b6:805:69::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.19; Thu, 10 Mar
 2022 18:51:39 +0000
Received: from CO3PR08MB7975.namprd08.prod.outlook.com
 ([fe80::106d:1c1:99ae:45ac]) by CO3PR08MB7975.namprd08.prod.outlook.com
 ([fe80::106d:1c1:99ae:45ac%9]) with mapi id 15.20.5061.022; Thu, 10 Mar 2022
 18:51:39 +0000
From:   "Luca Porzio (lporzio)" <lporzio@micron.com>
To:     "hch@lst.de" <hch@lst.de>
CC:     Manjong Lee <mj0123.lee@samsung.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "song@kernel.org" <song@kernel.org>,
        "seunghwan.hyun@samsung.com" <seunghwan.hyun@samsung.com>,
        "sookwan7.kim@samsung.com" <sookwan7.kim@samsung.com>,
        "nanich.lee@samsung.com" <nanich.lee@samsung.com>,
        "woosung2.lee@samsung.com" <woosung2.lee@samsung.com>,
        "yt0928.kim@samsung.com" <yt0928.kim@samsung.com>,
        "junho89.kim@samsung.com" <junho89.kim@samsung.com>,
        "jisoo2146.oh@samsung.com" <jisoo2146.oh@samsung.com>
Subject: RE: [EXT] Re: [PATCH 2/2] block: remove the per-bio/request write
 hint.
Thread-Topic: [EXT] Re: [PATCH 2/2] block: remove the per-bio/request write
 hint.
Thread-Index: AQHYM213hUiroX0Mx0m03tMAg0KZ2Ky4fWtAgAAwFACAAEsrEA==
Date:   Thu, 10 Mar 2022 18:51:39 +0000
Message-ID: <CO3PR08MB7975AB3E282C7DA35A5B1CF0DC0B9@CO3PR08MB7975.namprd08.prod.outlook.com>
References: <20220306231727.GP3927073@dread.disaster.area>
 <CGME20220309042324epcas1p111312e20f4429dc3a17172458284a923@epcas1p1.samsung.com>
 <20220309133119.6915-1-mj0123.lee@samsung.com>
 <CO3PR08MB797524ACBF04B861D48AF612DC0B9@CO3PR08MB7975.namprd08.prod.outlook.com>
 <20220310142148.GA1069@lst.de>
In-Reply-To: <20220310142148.GA1069@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_Enabled=true;
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_SetDate=2022-03-10T18:50:50Z;
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_Method=Standard;
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_Name=Confidential;
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_SiteId=f38a5ecd-2813-4862-b11b-ac1d563c806f;
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_ActionId=753b0bcb-b800-44cd-978e-6ec3014c33e0;
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_ContentBits=3
msip_label_37874100-6000-43b6-a204-2d77792600b9_enabled: true
msip_label_37874100-6000-43b6-a204-2d77792600b9_setdate: 2022-03-10T18:51:37Z
msip_label_37874100-6000-43b6-a204-2d77792600b9_method: Standard
msip_label_37874100-6000-43b6-a204-2d77792600b9_name: Confidential
msip_label_37874100-6000-43b6-a204-2d77792600b9_siteid: f38a5ecd-2813-4862-b11b-ac1d563c806f
msip_label_37874100-6000-43b6-a204-2d77792600b9_actionid: e3d4359d-2dac-46e8-8efa-daa832456f6a
msip_label_37874100-6000-43b6-a204-2d77792600b9_contentbits: 0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 729d846c-e457-43f5-1a2a-08da02c702c7
x-ms-traffictypediagnostic: SN6PR08MB4943:EE_
x-microsoft-antispam-prvs: <SN6PR08MB49438057D839AA9A66683BA9DC0B9@SN6PR08MB4943.namprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8PIC4Ik/P6ngI8JzrAHPAtfR762AdfWPt2A9CoLsffGQGBDrYQo705H9Sm9fnurXKP7c+KPrWJPT5Xir2DzumO9GguAYqulnZn5n48G3HEtfOWoTRpKfTUOORskBH1/LyiH4Eodw9eOCqB+4z+ANTxT7PcGE2hMQVMDxmJgVgGETxj4t8xRobI8HnO/1XIkn1UEqoTz8V7kY/78F3FL1wd0/H+aARLyFWqxIO6ucC/s0zqjx+W8dWnsiEQPpFDlRSUYUHkBxpCS3FVKIyp6zUS8ZWiceHyQubDrBu6jTQCsfEFHYz79OF9qwvz+XO7yCiyjx/XOGW3jrHmkWcMYtTj+XAP7r53Nin5sO07+7dblaVQ4dPkUaPB2yXNa5sURJsTCZRxFmCYqRoz1w3GHei4jRwbfnOoYKfX2P/X2jKN4oa1d/K6nbMALpzC3f6kT7X2eN3yCO8RMitCAcLZFAkV84b77ONXVf0ao1J549Vdvw/5z5HwqENwxNVk5ndxQS9KcDigmM02kEC4r4wGnnBE/lxZ4C1Plyh1pCp3pYiwCfgUhDm/A9O9MqDJhUjN0g/mtN+7Fp8O937xBbEm4tr/ZQT8jyLIdFJbSYPU3m32GeIEHZTI3pZB8JvUqQGd5VMECNX2vaD28fh1peiyB2RqtFfn7I8uoc81aRTrzsP2pixYnTwEWcxpzzP6Lor+67JAJmjaq9STOeAbqpedWumU8Kgs2DTsGbF7H/8aSshrA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO3PR08MB7975.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(71200400001)(54906003)(38100700002)(52536014)(6916009)(76116006)(66476007)(66946007)(66556008)(55016003)(4744005)(66446008)(4326008)(8676002)(6506007)(7696005)(86362001)(64756008)(5660300002)(2906002)(33656002)(508600001)(7416002)(122000001)(8936002)(38070700005)(186003)(26005)(316002)(9686003)(556444004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tKlYNYBuKWpPJg98n4+5HCDyVmSPSTr1QgrJ7GoTAFPA4n6nxwC7uOaGVDJC?=
 =?us-ascii?Q?UfdFpD9nsWs1hVWozuV+QyiaFNf4pDvh8AxSsuaA66JAq+frRZSZoeyoSElG?=
 =?us-ascii?Q?gm6y5XD0Cf8xOnmYlksfmpkPk3E83nX71jbtopfl8ATZm/5ypTCv2smtTaNh?=
 =?us-ascii?Q?vavshyXGfPDauHZYNlG9xb0JobSgm4q7ltCQ/M1cptehv3TdPtQ/OY8gSKfQ?=
 =?us-ascii?Q?5T0wFt/bRSZbPKgDR/Fw46dS/WhkxWXB7AKcCFldE3WsnwBE6WkJpNW2Qy0r?=
 =?us-ascii?Q?NJKpqIYM/eEZBnbcSSlDGwLHWQWkwxD2x6KFOd0nIWDquxoQ0s5lNju2ZdKi?=
 =?us-ascii?Q?vN7ZH9q0XFdz2mMfwdCK+nNK3X+y7f7w372e3wAaVzcnmwceaAyWhgpU00JS?=
 =?us-ascii?Q?bIB1uHc4ozuTB/F/nbAN1R3GUcw0XnizzvcHpCy31OpmX8aUkRElP1uvR22E?=
 =?us-ascii?Q?u0R1BVfJeHXBU8YRPXm+oV/6MTBs7fYbIfMkwz+IyB3rMmJenl6xmUARX7uf?=
 =?us-ascii?Q?sYbXcwC5uQOPeKKw9QvSvxRnGceHcL9o5NjbJtEqI+xiQOf8lrL83nyQ/s7N?=
 =?us-ascii?Q?kLLdy/Ve6WgxG8zZYE/E4jqqSTkoU6pG5OSoxwdbTwWxe3Q1zADNBcBEcNyI?=
 =?us-ascii?Q?9hNUX92nhgu8iY+YBLFOnsDRZJedMSBCMNC+7ReTrk7rBX49beDtePeVxpUy?=
 =?us-ascii?Q?IDMbzjV2ysygygNzyvMJz2WbWJ1IBrnA1zrbY+LZCebjuR/hVyXx/93/9MGD?=
 =?us-ascii?Q?gIdtpuoi3aA+W9JTEa7k2dPyPLVgVecSTHrxNF/icH+PiDpay1uIdzoLTbY8?=
 =?us-ascii?Q?1/Rjz1R4uHfrnLuEWgKZs0NQyYv/NoDdniXjQws6R14KdQ9FLvRNyE0+BFQq?=
 =?us-ascii?Q?QGLOGwteE/NQ5wObcg+Mk2gtg25aejD7VQL1bdmhZXkCj0ZTC/EouF3A/P/r?=
 =?us-ascii?Q?r1MSFuF/kNCASBsxCBiphhhEVdMkzCySAPVuI/KIpso0FEBWRgz+ndjmxgq/?=
 =?us-ascii?Q?Rtq/RmFNFfsyBY7dfE5KqgZUDi2jW8xCBeRDL8Xv0Zd29njqy4smUBs/8aNF?=
 =?us-ascii?Q?4f3dHn/JaGcDkz2Rqq3UfrcIlChDR/LTz5bfcrWkHHwjTpEhuYQ5kfm6talg?=
 =?us-ascii?Q?W4nKS0WB1KeICGsQuC98cDPdlG9R2+eCVVax/I1MdXP4cq6XhdXMK0cqVqxb?=
 =?us-ascii?Q?5R0nl88MJTDNfueQYDVDFYm5RT191H5EyEeZ2uyXGnfmVWq4/YZ0s4Nizqbj?=
 =?us-ascii?Q?9QMRCDKUKyMVe6Ez84DABf+YOn5kf/p25PWePZQ2/Oc9GMHcSYevxkzoMpY/?=
 =?us-ascii?Q?FnmTpwNcbNNTT9gGUhWeXSxG38oQA0vRMffrscvf79gNuZIcaqljvUDV7+WN?=
 =?us-ascii?Q?UpoDeF5Lp4PhG/9b86YsoS5BFKimLqBDatmStUGxME6zw0HAXSXFs0RwSXpR?=
 =?us-ascii?Q?HFfi9XXqoA3lrRcbc3/U7mFohHDezt0cCdQLeaZSf/1SB6ioXPGhIbHcn2Jt?=
 =?us-ascii?Q?dMNwn+eb+ebioeZFMW2S9p+6VYbWDj6MioVL4doNqvJTB1hACViH9/UGvjPY?=
 =?us-ascii?Q?vUb7yU/JBIewdLlIO5SheZ7vh479zncDYiIg/xq41+e6OoGrn0IK0lwJJKYU?=
 =?us-ascii?Q?GujY5+O8i8po5/w0eDjHtxs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO3PR08MB7975.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 729d846c-e457-43f5-1a2a-08da02c702c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2022 18:51:39.3915
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qNmUgCWJrJHO4FKp1QtOXv2RL5FW7+cJHKcPIgJONKPsg+0InF38OwkqfCC+iHePELwEVBl/CjCd1N6TXrTTsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB4943
X-Proofpoint-GUID: eR3mEJXMXjl2nT7-Z-sqsUf5Z5SYwRu5
X-Proofpoint-ORIG-GUID: eR3mEJXMXjl2nT7-Z-sqsUf5Z5SYwRu5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Micron Confidential


> > Can we revert back this decision? Or think of an alternative solution
> > which may work?
>=20
> Hell no.  Given that these custmomers never gave a singe fuck to actually
> support whatever crap they came up with upstream we're not going to leave
> dead code to encurage them to keep doing this.

You are starting from the wrong assumption: I'm just saying this is not dea=
d code
but it is used across the (Android) ecosystem.

Micron Confidential
