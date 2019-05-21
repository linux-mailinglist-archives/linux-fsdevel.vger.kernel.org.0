Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B21FD2454E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2019 03:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbfEUBEz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 May 2019 21:04:55 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:54468 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727043AbfEUBEz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 May 2019 21:04:55 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x4L0vULO029097;
        Mon, 20 May 2019 18:04:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=wLnn/Eui++2ZeQRtWAPLBNHxjw6FIDfyUOraIR4dEa8=;
 b=YojrL7Md4/peIsJucwWWqtPwRUULa7EZyEuXzvLIE9PMqLd7fAvF4TiSE9S0dWha539+
 qtW0LI/K1oNloRAXfGi+BULObl/RedeOu3njJ0Swg0Og/r9zUx6pgdEM6Ka8h9JHagIx
 WJ7MkRIzXvyWCXfQY+YL84BpUddLD1y4jBA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 2sjdqd7nst-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 20 May 2019 18:04:15 -0700
Received: from ash-exhub203.TheFacebook.com (2620:10d:c0a8:83::5) by
 ash-exhub104.TheFacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 20 May 2019 18:04:14 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 20 May 2019 18:04:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wLnn/Eui++2ZeQRtWAPLBNHxjw6FIDfyUOraIR4dEa8=;
 b=V+jcvHaV4ip8zWapneuSsQi32bhmaAhPm8YJGA1U4z80NgjjTvFY/TBdW8ieIBSkWZ/Qg0hLdHPpP6aoUUv4+fWq8VxjStGSSF0YMjvI4xETsXPGQT6JIgD4CdxjXM2Nmc39iYulKMJk06DeMaCDjtmmVtEV5vQ2YFDUHdnTVqY=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB2405.namprd15.prod.outlook.com (52.135.198.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.17; Tue, 21 May 2019 01:04:11 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d4f6:b485:69ee:fd9a]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d4f6:b485:69ee:fd9a%7]) with mapi id 15.20.1900.020; Tue, 21 May 2019
 01:04:11 +0000
From:   Roman Gushchin <guro@fb.com>
To:     "Tobin C. Harding" <tobin@kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@ftp.linux.org.uk>,
        "Christoph Hellwig" <hch@infradead.org>,
        Pekka Enberg <penberg@cs.helsinki.fi>,
        "David Rientjes" <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Christopher Lameter <cl@linux.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Waiman Long <longman@redhat.com>,
        "Tycho Andersen" <tycho@tycho.ws>, Theodore Ts'o <tytso@mit.edu>,
        Andi Kleen <ak@linux.intel.com>,
        David Chinner <david@fromorbit.com>,
        Nick Piggin <npiggin@gmail.com>,
        Rik van Riel <riel@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v5 13/16] slub: Enable balancing slabs across nodes
Thread-Topic: [RFC PATCH v5 13/16] slub: Enable balancing slabs across nodes
Thread-Index: AQHVDs7ctVwmY1mfWEGms02f+3BxA6Z0xI6A
Date:   Tue, 21 May 2019 01:04:10 +0000
Message-ID: <20190521010404.GB9552@tower.DHCP.thefacebook.com>
References: <20190520054017.32299-1-tobin@kernel.org>
 <20190520054017.32299-14-tobin@kernel.org>
In-Reply-To: <20190520054017.32299-14-tobin@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR1201CA0013.namprd12.prod.outlook.com
 (2603:10b6:301:4a::23) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::3:a985]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 862a72bd-6b3a-44a5-c236-08d6dd883b6c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR15MB2405;
x-ms-traffictypediagnostic: BYAPR15MB2405:
x-microsoft-antispam-prvs: <BYAPR15MB2405DB46A2035B72369246D0BE070@BYAPR15MB2405.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0044C17179
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(376002)(366004)(39860400002)(396003)(199004)(189003)(486006)(66946007)(2906002)(66476007)(46003)(66556008)(73956011)(64756008)(186003)(66446008)(81166006)(33656002)(446003)(11346002)(68736007)(8936002)(81156014)(8676002)(476003)(305945005)(6436002)(229853002)(6916009)(5660300002)(7736002)(9686003)(6512007)(6486002)(1076003)(4744005)(102836004)(478600001)(7416002)(14454004)(6116002)(256004)(76176011)(53936002)(71200400001)(71190400001)(25786009)(4326008)(52116002)(86362001)(54906003)(6246003)(6506007)(99286004)(316002)(386003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2405;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JjhJmYGMPkjH1z5jP878WPyQf2fbLbmFr6sqILpUMvAQjlukyOV2Dv5lTgY4vNACrM1TCll3/fBNJO46xbdfVCp3Jtg9Dd/OAByjGn3YnKlztJDMAnoYjwBOtdkY6OH3dwAPqBYg1qGmH/BiqeJC98ng0IHwxwGXtCW1JNflZ9VTy2ueNql+eOwDHZHN1qrTGt3h9QuXQ6BUEo+lhq5Dols5+VLZddMwnkNBwaTVKbKhDeYoE3D+rCjGfkziRg44ophKBKMGOlMU0dtP3ECyLMQvN/jI2bON9lsfZIxEjvcQyBzVfkwpSajFmSbkuKBcxAfEl26jikcwvZ1O/nWuBcjUqx50WAm9evexyyMFzw0mmd65DDSyOmPRGH3Cl/Da/DGNI/kj1Aqdy+E38yaHYVjMdvT0lZxGEUpMxmEDImE=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9D0C93632F69DC48947AE33B016879D1@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 862a72bd-6b3a-44a5-c236-08d6dd883b6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2019 01:04:10.7884
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2405
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-20_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=578 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905210004
X-FB-Internal: deliver
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 20, 2019 at 03:40:14PM +1000, Tobin C. Harding wrote:
> We have just implemented Slab Movable Objects (SMO).  On NUMA systems
> slabs can become unbalanced i.e. many slabs on one node while other
> nodes have few slabs.  Using SMO we can balance the slabs across all
> the nodes.
>=20
> The algorithm used is as follows:
>=20
>  1. Move all objects to node 0 (this has the effect of defragmenting the
>     cache).

This already sounds dangerous (or costly). Can't it be done without
cross-node data moves?

>=20
>  2. Calculate the desired number of slabs for each node (this is done
>     using the approximation nr_slabs / nr_nodes).

So that on this step only (actual data size - desired data size) has
to be moved?

Thanks!
