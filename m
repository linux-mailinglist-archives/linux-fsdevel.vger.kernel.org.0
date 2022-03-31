Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7534EE0CA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Mar 2022 20:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235506AbiCaSmx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 14:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbiCaSmw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 14:42:52 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D6B1E3C8;
        Thu, 31 Mar 2022 11:41:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iq9PFvLA6/7avpMUur9sjqihDWCfTD/gDbl44bjyK9sK5/Er9m/DDzUUr4eRzuTTNwYQ65I1fkVSzw5h/0ilWWk4p/otE+/pAS0HCzbqDOcAjZ39y09ivdySqbIayX5rhPKooxEb21jrU8CkNHc1+kvfWWdEpLnqEoaz1VzcPxt909GDIu1WsmTiToHowXGKulOQv5vIWj9lTTtM/knOoX0rhtG1UaRO7jyjgZaKDJ8N7p6imaGexrj4gFwb59Yf+QJWX2d8p46pZR6/Ua/zBL/tq1PtJKWwrRTtmAn7Oo7u6+F/gHG9j84OfkE4AKu+jn2CcVqv2ZkynuZxdku37w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jx70hsLq6oCZRQWBWtowDgHAXrASvy1CIA5H6yHVNNY=;
 b=BNCATShPv8myFw0279wwD07ps2ll6v8xZL9bgoVYzR0AdWlvB8vdSGZaQ5gRfzIvWLLXPsSJY8JkQp8Pays53PVkbHM4tPZ1sl1xJPbBXHD1mth3xx8x7JMuadVfofMt8A54jtdaKm5+IBvWAD0BE/PBNyTawzT/+jIA5B5oD8TrDHO4ySXllIFEqK64SqaOg8Dc6OF3njxcjh7ERm57XCRAHmQjmhGrzPsPWWvok+jybhvqJFzENJTdp5M9bRHx9aV/+J114R9V5ShHQ3mp6TlG0DwGbMbgnYwU+LUzuEOFSjOcvSf6szINpiMr1HC6KCkKaBivzq+NolUrsKiUHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jx70hsLq6oCZRQWBWtowDgHAXrASvy1CIA5H6yHVNNY=;
 b=jQijRTqssmw0l4FmWdXYOGsQhIDRhffsyTNwv7tbhj0lPiaAPSk/sW5HLCPRysEKViPC5Gh0maQMkHdlNW0F373/yNde6zVBIKCvTL3EMN7hqQQ2l57rheVDQyVr0Nb3LTF+suaagxxfcM72Tucjx3k49Idj0INHI7v+2aCeD78=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by BL1PR12MB5876.namprd12.prod.outlook.com (2603:10b6:208:398::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Thu, 31 Mar
 2022 18:41:02 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::70d6:f6dd:3e14:3c2d]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::70d6:f6dd:3e14:3c2d%5]) with mapi id 15.20.5123.019; Thu, 31 Mar 2022
 18:41:02 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "mhocko@suse.cz" <mhocko@suse.cz>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mm-commits@vger.kernel.org" <mm-commits@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Subject: RE: mmotm 2022-03-30-13-01 uploaded (drivers/platform/x86/amd-pmc.o)
Thread-Topic: mmotm 2022-03-30-13-01 uploaded (drivers/platform/x86/amd-pmc.o)
Thread-Index: AQHYRRci2G4P62RIIk+9YLuFsTlihKzZwlrw
Date:   Thu, 31 Mar 2022 18:41:02 +0000
Message-ID: <BL1PR12MB5157D16702C349C2620AEE97E2E19@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <20220330200158.2F031C340EC@smtp.kernel.org>
 <5a0b94c3-406e-463e-d93e-d1dc2a260b47@infradead.org>
In-Reply-To: <5a0b94c3-406e-463e-d93e-d1dc2a260b47@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-31T18:41:00Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=d91c4593-59e1-4e3e-947d-99950fb742eb;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-03-31T18:41:00Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 3f29b8e0-17c9-428a-883d-8a77e3627863
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 30b4a24a-0b4e-4ef2-4e14-08da134601e4
x-ms-traffictypediagnostic: BL1PR12MB5876:EE_
x-microsoft-antispam-prvs: <BL1PR12MB587628CD0798742F72C4F719E2E19@BL1PR12MB5876.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TdFV7KdD9d3hBE9qm57wadlfsObUWL1EJhQSpy9Skw43bDrWYqIIys2X3LYPtG3TlShpv52QqO4vuiMREF4KdJeY7X5NIJ8kbBpfYdN8Mk4++qgRE4bYDCw6l6pymnn6kjVNwRKtrG+XnCAy9NHXfvebGLXNB+tFKv5eg2MY0RCLRD1Uxptorf0E8n9Y7LJm9n2aBLiNoKQKXB75r6OgUdyYrYe6IzU+obrZBxkSq3w2r0N7gaVDgYaguXkqRNp2gw8n+eceMo9cbGEIBycHgvjhJqIuRShYo/rTeD2/3KeVU1rPfEZeuPBNWnmC4aO7+DOLkAn0ZSbMQg9gW1W90fXSQmK185QDq5Covkl1KQQgTSDsIViOYDVlV3emPMWrDe35lLXpQuJ53IEdsdw13EodzQRZlgdC42s0qwiLhvhUsR8t+Ev9cwzo+D5PQOVFMpzgVcKkJzwAU9/8CJbVnPn/ocZV40wDtnVg7F9fdqsEPegpk9hSiSHCoSgd0PFVnP+KzuGo1O8govcHeWIiichynkcx4oWhs6q1CrfaCfgLdcOBLorxJSszg7/3vNTWigz++ru0NnmwQDbu1pjhaetPE4PFHnePxpYXMloXuy+VR8anBq8bzgvkjRate5gTIVVm7Mx4McyEY5btLvVc10jrUWx38ZV9vlK3QFDSkdXEaDCzzN3c3Bs3mRAWls90qE/mCVGE5wwFzZJaQgvTfL9Md3A/puVnJ4KUXRznGX1bHV6/eYPGleNfVNO0LAOKYRS1kutOKZ7kp9ncBu4GA09sILk1hnsWhG2Xmo9MtkBfGgq80p+QYRJNAlLZkg0uT5KR8oIf7MOfSC3fhU+3qg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(55016003)(83380400001)(38100700002)(122000001)(186003)(52536014)(66946007)(5660300002)(8936002)(66446008)(7416002)(76116006)(66476007)(66556008)(64756008)(2906002)(8676002)(45080400002)(38070700005)(71200400001)(6506007)(53546011)(9686003)(7696005)(33656002)(921005)(86362001)(110136005)(316002)(508600001)(966005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yzovJpmJxoUrw9rtEnteUbqlvFrcURJORVtamSMpQebM3yiu7dquPrn56IZI?=
 =?us-ascii?Q?aeNS+veD9dKYaXCvHoi6bhXKzDdnUwNSfW4/1OxcPLuSXIVfz79LP/hbnQh5?=
 =?us-ascii?Q?/6dLHeoZiFuKbCQJYmUIUzd88J6GvAwBwyK3T98zQ7ozq/burM9U8yVDOihh?=
 =?us-ascii?Q?4gf/5Pm2q9I8HB8gpMfrwQHeRUqwZw9+c5hQFTdhXyhyYL9cZUVJ1qbr9S4M?=
 =?us-ascii?Q?34tJWelaW9aNxMOSuHDcsbYF6JlxnFbLa2tR1BXPtgWxKigqBiXLb7ZRlz6b?=
 =?us-ascii?Q?p4L4U8/t9th48FUcryg5UMP5JtiBtZxvO/nRiAruSYE6MT8h4NchK2JTSmo8?=
 =?us-ascii?Q?WnQ8EptFXbKsCWw8ENmEK/WX8yxfpUGSUs1mKwO8hWcvNrAaWUBd5K52VA5C?=
 =?us-ascii?Q?SFhKagOIeYx0M/aycMKhQHufjHh2wc+wJBXk2FpXXppO+KC4pVvQc/91SeK8?=
 =?us-ascii?Q?+Dsv4Yye3kpxgcFLgDIjfV9yxKZSkeuwe3PbUDd32icLn32aUXwLRKl83KlM?=
 =?us-ascii?Q?yz4Exfw57IZHoWBUzNjKR2U509xFUpmUSV22JheMKwQP/2N/BcCaJYCeBR2p?=
 =?us-ascii?Q?Y8b83IOJqQwvX3OPNHjwIubn8MLBD6r0pfHF48M00ZKllY9l947PQoP2CGCj?=
 =?us-ascii?Q?zlUvwQF3UDC2hnFG8T4rGjj6PJkFHLuSwiQhOsYjJGEy8zpxCi6ZaDvW6ZKJ?=
 =?us-ascii?Q?9JxFta3IqrDGYhIod0I7LlUasSE9DTq51Tzb+MA0iCpZ7cLItmbnxa7cRrb6?=
 =?us-ascii?Q?EQDvu2XZe7Eo3upvtCpEtzsWc+p7ay4Kto3GGrWQP5CGmKSY23yj+h6ADcZP?=
 =?us-ascii?Q?vEbVWLUHuXQqxYRCW5UkWmve8+0Q8v3zeevjou4JUT6IymjUgbKLLvCrlAd0?=
 =?us-ascii?Q?owTYMk1DC6/5DiW3SqwS4+7DvB2g9akqHcmxFwhb1fILjjKckZrhCVgdjwCL?=
 =?us-ascii?Q?ZOeXibiKwY/dIFyX1djsIvyi4ZYYR5aDMg/ScBGA7+HgVdKs6tSou+6pvyKO?=
 =?us-ascii?Q?h6JM0ZfZteXTDFSCw57zzrR4t1o1bfKvsXGFrpYSeLrrJcLct1Tg/GxciJv3?=
 =?us-ascii?Q?S0lAmNOU6ioq6eU16qXwntmLJgThd2hTuODw0isiT3L7T0ObOMr9AH3hQzx3?=
 =?us-ascii?Q?YFILEe3011KPos5bunoV2wu3Aj+p0uEnHX0uOAlOoWeuVmdAHSLRchaw7MDn?=
 =?us-ascii?Q?Q18cVg60N/gFaEobOdZiurufNHzoAbcMMJkoG5tH/SQ+W9+GkMOrVNgZpT5c?=
 =?us-ascii?Q?FhFKXvyN/TJRrtWyBmvLoG+/03azMXJtyGaff2X7Np/D6lxWBC/O3hA1YV6v?=
 =?us-ascii?Q?ZixLTWsrLZyj6TFpUu+tTQ9vf3LwyNa5Q2JDaAnxrvVNpXKMPDoU1pgLpmOJ?=
 =?us-ascii?Q?pxZOj4YiJuBWZd31G8fbg7g+j0jdwn8v0DW4nW2v4tr589FHXmPyDdM48YU7?=
 =?us-ascii?Q?l8bMHwSk+8Nxk7dCW1AvyGx9DJspY4aphKdI/9pnoBMlyUgi3shLjtMxP59w?=
 =?us-ascii?Q?7mhjM7REhaM112IIxDOu4Yvsgv3/l14OQtw8kB9iVFoMJR24S6OnmT6tKZAd?=
 =?us-ascii?Q?1ZUAQdT3JvVNhfqld1IiSVL7WxJsN3eFIm7B4FdQQW6muYhgNAyq5lbV7n9f?=
 =?us-ascii?Q?oEMeO4N2qn4N90GDjPMzRLdQkrQ0HMzhHKMYdCssMHO5e8QX1vL5URe/gg0R?=
 =?us-ascii?Q?Awb4YjM003TcunfKpT6VP5FdNGqZM29+W15O5G8Vq5Z26q+g?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30b4a24a-0b4e-4ef2-4e14-08da134601e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2022 18:41:02.5474
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zqA1e+exPubha7iZQtRzEOSRKbTZmG0Mnl53kVxu03aAxt59MoLvGnPU9qpVYfhBL4xFsi1OHJWZAfszMpBIwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5876
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[AMD Official Use Only]

> -----Original Message-----
> From: Randy Dunlap <rdunlap@infradead.org>
> Sent: Thursday, March 31, 2022 10:51
> To: Andrew Morton <akpm@linux-foundation.org>; broonie@kernel.org;
> mhocko@suse.cz; sfr@canb.auug.org.au; linux-next@vger.kernel.org; linux-
> fsdevel@vger.kernel.org; linux-mm@kvack.org; linux-
> kernel@vger.kernel.org; mm-commits@vger.kernel.org; platform-driver-
> x86@vger.kernel.org; Limonciello, Mario <Mario.Limonciello@amd.com>
> Subject: Re: mmotm 2022-03-30-13-01 uploaded (drivers/platform/x86/amd-
> pmc.o)
>=20
>=20
>=20
> On 3/30/22 13:01, Andrew Morton wrote:
> > The mm-of-the-moment snapshot 2022-03-30-13-01 has been uploaded to
> >
> >
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fww
> w.ozlabs.org%2F~akpm%2Fmmotm%2F&amp;data=3D04%7C01%7Cmario.limo
> nciello%40amd.com%7Caa3aae02b7b6437c46ea08da132e4222%7C3dd8961fe
> 4884e608e11a82d994e183d%7C0%7C0%7C637843386674652995%7CUnknown
> %7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1ha
> WwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3DWpfXOyTRBgvqCj3iZ%2BJjXVTb
> V%2FUWDP4ds5XtDfa5bPc%3D&amp;reserved=3D0
> >
> > mmotm-readme.txt says
> >
> > README for mm-of-the-moment:
> >
> >
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fww
> w.ozlabs.org%2F~akpm%2Fmmotm%2F&amp;data=3D04%7C01%7Cmario.limo
> nciello%40amd.com%7Caa3aae02b7b6437c46ea08da132e4222%7C3dd8961fe
> 4884e608e11a82d994e183d%7C0%7C0%7C637843386674652995%7CUnknown
> %7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1ha
> WwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3DWpfXOyTRBgvqCj3iZ%2BJjXVTb
> V%2FUWDP4ds5XtDfa5bPc%3D&amp;reserved=3D0
> >
> > This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> > more than once a week.
> >
> > You will need quilt to apply these patches to the latest Linus release =
(5.x
> > or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated=
 in
> >
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fozla
> bs.org%2F~akpm%2Fmmotm%2Fseries&amp;data=3D04%7C01%7Cmario.limon
> ciello%40amd.com%7Caa3aae02b7b6437c46ea08da132e4222%7C3dd8961fe4
> 884e608e11a82d994e183d%7C0%7C0%7C637843386674652995%7CUnknown
> %7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1ha
> WwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3DadnYHchdMvieQ0lCqQ1er1jhHA
> UMomgFpaWBo%2BMnINk%3D&amp;reserved=3D0
> >
>=20
> on x86_64:
> when CONFIG_SUSPEND is not set:
>=20
> drivers/platform/x86/amd-pmc.o: in function `amd_pmc_remove':
> amd-pmc.c:(.text+0x11d): undefined reference to
> `acpi_unregister_lps0_dev'
> ld: drivers/platform/x86/amd-pmc.o: in function `amd_pmc_probe':
> amd-pmc.c:(.text+0x20be): undefined reference to `acpi_register_lps0_dev'
>=20
>=20
>=20
> --
> ~Randy

AFAICT you're missing 20e1d6402a71dba7ad2b81f332a3c14c7d3b939b.

I cloned https://github.com/hnaz/linux-mm
As of commit 074b4ea9811e2c47ae1ecada177629c19fa56d59
And don't see the commit.  This is in mainline though.

$ git show 20e1d6402a71dba7ad2b81f332a3c14c7d3b939b
fatal: bad object 20e1d6402a71dba7ad2b81f332a3c14c7d3b939b
