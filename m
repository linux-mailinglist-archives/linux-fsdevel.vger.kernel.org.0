Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97A114A5F27
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Feb 2022 16:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239843AbiBAPGq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Feb 2022 10:06:46 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:8742 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239841AbiBAPGp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Feb 2022 10:06:45 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 211DO8Na028107;
        Tue, 1 Feb 2022 15:06:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : content-id : content-transfer-encoding
 : mime-version; s=corp-2021-07-09;
 bh=NymrcAKG6iAl+MYRgokq6NRR8JzK17uZduRryGdWJuk=;
 b=VZq6n/gv1cvj54qtnOjiHk4DVY46vRs+bhzdatcn83W0Uz7yllXNaa55pxO+z6gF3Rpm
 Dn+DdrS2JJ0gZHJ/nCOTLfy4cukfvFl3ieGgnx1/Yly7eDfWAqjlQlNpEdIbUWQ50Zg1
 YLtJwjrk8uSz7UWaiv/oe+qZYPNQunAem3BorIXZKceVTFhW1jVhBv7azPIkQfd8KdqS
 hW2MlSh5xwYPrJgVXxmdRD4SE15B/vaComuvM0lGxwZ+RPKhVoevKyUQWJVR0FrMlsUZ
 LouTwCnUHAqNOpN8K9UlyZWpV7YDQGeNVEsMQ4QNreOb1qVrdYWJu2zXVs+y8PDEqYy+ PA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxj9vb7xk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Feb 2022 15:06:42 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 211F5gMa171834;
        Tue, 1 Feb 2022 15:06:41 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2045.outbound.protection.outlook.com [104.47.73.45])
        by aserp3030.oracle.com with ESMTP id 3dvumfkhf1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Feb 2022 15:06:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RWCUn1M6f/yiswYfJskLqbT+aTPpHQf8sRt/dFOyBDijePcrHOf8WWS2PdMpwtsCCJJffwG4h1PhOQ4UYGFu4Zk1DqY2ASQ640qFBy8T+oBA38dqqgEMX405XM8N7DJQXWAq87kpCb9XcvDPfwIE1nCbvYdfGpp+qEZvHs55IN4SCd3W4MHEoQXZrOoJMDK/VcQWGc6cEqZmKlMVh0wvROPq8vST12pQGlRhYPyT5gEeq/i8DtcJsp20CF83puN2rsHboOdjPoHnt/yMmvbihFcZmrodIWoC6dOmGgeoXEG4rEeWB+fkwOnbyeTlayqGnkp75Rx8XgtTQFBlKpYflA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NymrcAKG6iAl+MYRgokq6NRR8JzK17uZduRryGdWJuk=;
 b=iIReoj3x1mkeGI519i/4ONrExKXVhzPd+IgkKERWbxsJxkg/NB/EGDZnNtBj2a+WYe4uWPg78rQyMWf3F09ekYTvZynHPx9u3MFhVq58emh/Y1h8DJXnXX/+qaeRb39MmTS2VMOcYXt0UT/KBpXd7Mqzz54VoxVmu5sp+eaUYoQscxIIrQeEk3GAm21obk0F3b3zVB3gtn7XngdWoFFASsJBEEac1TZf8tmes5Wbd0+VaNh/yjpLjBiADPqkXVnTVi323rMCWyqRGi9KknT5OK/U6txftQxar3OdG+93FR7NdDdr2LezXho2b6RMP7REF3CL3BN533lzQ1hd9xjeYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NymrcAKG6iAl+MYRgokq6NRR8JzK17uZduRryGdWJuk=;
 b=s5iRElar7Qy7f5inMQzko5c5TESKq6Q40pOT3BPnW5XTi074elBa6ZkhTVj2rmeMisU1Kr7n4aL1u69y+thlb+4z9IfpsHW3CdQx8pj2nwLctUNVexUWOo2TXPPLWQlVwYRDLuUoqMsqQJC/Lnq3moGh98uVWTDqhZ9wdY1Xlds=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB4558.namprd10.prod.outlook.com (2603:10b6:a03:2d8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.20; Tue, 1 Feb
 2022 15:06:39 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4930.022; Tue, 1 Feb 2022
 15:06:39 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: [LSF/MM/BPF TOPIC] The Maple Tree
Thread-Topic: [LSF/MM/BPF TOPIC] The Maple Tree
Thread-Index: AQHYF31QGM+6p7IpNUGgCHh+HVxyqw==
Date:   Tue, 1 Feb 2022 15:06:39 +0000
Message-ID: <20220201150633.jtlwrqfnh4xbhw2f@revolver>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a29ebd34-86e2-4694-1b1f-08d9e594730e
x-ms-traffictypediagnostic: SJ0PR10MB4558:EE_
x-microsoft-antispam-prvs: <SJ0PR10MB455830F8C4E4D4276FF7762AFD269@SJ0PR10MB4558.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J9jHYTj5Qkf0yv7SJaGXtW9RWjSwjyPDdeL70bUD8NMPOrEESCs0QPqNW34ZIH2w9pF4c9WaODaXdD0nwRtTESJYSCO/R49TdpWMss9Do1rmxKc397AXzAVa8uQ2PW2PO9/KPSoS63yVi4d8U1oqNsokfhY0siF9c/QXo44gzXiu/zrT2lw6b8prgwWDagrYZ3+ssqII07dABPQQ0POiTUyok094O3GiIK/h6OE6pqfvxkKmHdKYwKmpiUhfTvNPdE4FtU0UbLksSNjPZrsaPfWKXSve+1rA0vXsts6SB/i4+nPbAPVwEcxm0TBNknc7leyDwr/NDhuZ7fvvExg8RqvM0gWCDi/zl+puTbFyKYwjEb8nscUobNBGQTGhrTV3OdezBVTXuyzvE4GXyocJ5OjWU6opScy1Ay5Wsts4pI9W+7ULuLG50WNs8YmDyAKyi3l91RN1GlCUiUEJCqh1q2x3hULATjrkxCeROZdsUeNypeROtVuOL5vgChMnNdtdU2JXia8KJJX8wCc7j0lYkoeeCKTIuuXXtvRsxXkk3Kmg/V0nzCamSGJibkUEb78nFzLV9DlkB3BZ+QmCNAoWEMFOt+iCo8oVuA4evofW2lLxxIKdYRtaHx3PxZsUfKHMpLjopQ4+Kj2eyLuWyaXT7Cuh6/EwQxs8yNzYh/A1jckfgcgww332QkMUUxZPDVHFBZlZ37DVuzZNfKxcu3Ov2A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(2906002)(83380400001)(33716001)(26005)(186003)(1076003)(122000001)(71200400001)(6486002)(86362001)(38100700002)(44832011)(6506007)(91956017)(76116006)(66946007)(66476007)(64756008)(8936002)(9686003)(8676002)(6512007)(66446008)(66556008)(508600001)(316002)(110136005)(5660300002)(38070700005)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2ZVzypaiDfOAcMvrHFfBR8iV5ZKdFINfkdvzcYx6m1reZUmuBNtJMJ0pNXKJ?=
 =?us-ascii?Q?SYvXwLMan5ivGD79t3Pxz9kG0xD0I4lWOa0SpWv74NFc/iQnvxUaVwpS7aq3?=
 =?us-ascii?Q?GEsZj+8c+qicLIUTW2e+I5kQZYe05THDy6E0neDjD4MVkaCTITpPJZpnZBfo?=
 =?us-ascii?Q?HED7Xivn0FpUxz63dzSb/CFrzdA+etkG9rzNda30sDHpqy9rONqujXFYi7Zv?=
 =?us-ascii?Q?18sWuPv1r9e56FUGSds0TCCzD/hD0MYk27+zMFmhKf3cpleH77+wI3cIZ2+L?=
 =?us-ascii?Q?lsrpYXAlJ2MPxv/cF5YzcXbuupneFtfdWeLeSMIf+dADjIfuaAeI5KHFZzEv?=
 =?us-ascii?Q?JzNUymwQnAGpRdd+zk3hQKaqrlI/SBQ1gb9f6BIW/rzR2aYKX5c3SohYOdQV?=
 =?us-ascii?Q?A+U/IO6Ro4fD/v8BeEvRE40PQMF1r19Hu7tC4SzpMpj0pjDomR1zr9wsUFd/?=
 =?us-ascii?Q?pWZ1Q1uKWh+ZgNb5i2m5pWyyDfQt5a9guMmjl2UEabKDha3/+gIXSlkex081?=
 =?us-ascii?Q?fgxygJJmNY0s1ueYENaPJL+XgJlwYXPuMPX2G/sLlLKyE0oWN1xD23LpXRpW?=
 =?us-ascii?Q?BPLr1HVJJ3ROSOaDjgZ+9KSL3W/38IlaBvvPTxlvvxuQrPhE+DJwRztx8nmK?=
 =?us-ascii?Q?hDs96CM06mQej3DZpmBQDV2h0G53QZ5YP4jIYkt/9UzdtQ8uepAmVMFOObRs?=
 =?us-ascii?Q?wl+eZqEySlVkwn5x8Y+C068IeA4aayNcJENak7IGp/so1FT5T2iKG6E2GKpg?=
 =?us-ascii?Q?eW+QJqweCR6se/aUk6KvkVHjG4LfU43ltK6YckiZ19nA//dITbvDFJKrbUXJ?=
 =?us-ascii?Q?Tmc7VXvY+GR3p8bjT+OxwCPogsiFLZMHYOmySgX0t2tUbjq+kGC0bJbqTqOF?=
 =?us-ascii?Q?sYhvZlJW7Cev9nT+cSfcqcYMdjrzuX4VeKqGgsuhQk74h/Q2Wq/lAjLg2JO5?=
 =?us-ascii?Q?DWutnrBtGfRCJFAvCQqZ3YnTcnnbVSMb3rB8DuRjAaoFKw7okfwhNPTQOxn+?=
 =?us-ascii?Q?euz6Rh6i3Mvq2sHE2QOTG3aZpq20cWVqq6cwvS7X2uz0X9RrVm90qodMpwNL?=
 =?us-ascii?Q?5y8gFZtuItjX9d7lmSiAsZVyZ9f5gYepH44eqe9/fHAX8hQhgSF6DZm8RkXi?=
 =?us-ascii?Q?4byE3gq2d8UHLSyhpHuz+xVW9FepJkGafzsVvsHgyBOntHhLYnqKdqOxtLi0?=
 =?us-ascii?Q?sdJh6/Oaei84dihPkm+FPGtVLRAqQ021rU02Pi8MTQtuGeWLqr6npMFjsw7/?=
 =?us-ascii?Q?KS1iZ/vJr9+cCrj1ckI6UvnepzdZ8iHckvbnyhsjMDF4Lf2RCqkRYIqPSuus?=
 =?us-ascii?Q?gZhhoMZPDka74vLZjo+0L3QUBY2LjGIA/BTAen9+6921G9ivkYEzsr0153mP?=
 =?us-ascii?Q?tV/Ri1cJHJnqE3wzH0IGidPRk46PyG+B36Gh6cYxA4oF0wds/oVv3aa12LtB?=
 =?us-ascii?Q?blO8/StcorBACMEeLli2F50P86YSmno9dIoHnmENRTUsPW9UB4rNuTbl3CdV?=
 =?us-ascii?Q?GQ6HudVoJMZN4eQPMDxsLpS5XgJfVP56FunU1AeDWmp6PE2TMcKFN4kbj03D?=
 =?us-ascii?Q?Cek/u0JzaDFUG6nq/mCl5knGM6D9HNGKr2M7kvm12K24E2xWHFcxFU7Ehapx?=
 =?us-ascii?Q?p7yNeMVDvOuVfmJELPZqmX0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <01DB21A13AAADC41AFB89C36FCB82D47@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a29ebd34-86e2-4694-1b1f-08d9e594730e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2022 15:06:39.7548
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YpKN6y19aScMGWQbLUoTmUPJy5PXbv/YH5Quow6fE+QyLsfLu93qwEfxcS+M1oZuvPJqItlK2vnNev3UQx/kKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4558
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10244 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=279 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202010085
X-Proofpoint-ORIG-GUID: LrOZNIok-zQholvn3l1lOkYAcxtYhGig
X-Proofpoint-GUID: LrOZNIok-zQholvn3l1lOkYAcxtYhGig
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Over the years, the tracking of VMAs has slowly gathered more refinement
with added complexity.  Currently each MM has a linked list, a tree, and
a cache to track a list of ranges. The current patch set adding the
maple tree replaces all three of these data structures and is just as
fast or faster - even without modifying the locking.  As more of the MM
code is optimized to use the tree, the locking can be extracted and the
RCU benefits will begin to show.

The maple tree is a RCU safe range based B-tree.  Many of the rules of a
B-tree are kept such as each leaf being at the same height and being
self-balancing.  There are also fundamental differences such as how to
handle an insert operation that may cause one entry to become three or
several entries to disappear all together.

I'd like to discuss how to use the maple tree efficiently in complicated
scenarios such as those arising in the vma_adjust() scenarios. Also on
the table is the possibility of a range-based b-tree for the file
systems as it would seem to work well for file based scenarios.  If
people are interested, I can also dive into how the internals of the
tree operate.


Thank you,
Liam=
