Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E63792451C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2019 02:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbfEUAiP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 May 2019 20:38:15 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:43082 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726913AbfEUAiP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 May 2019 20:38:15 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4L0Y8kL000574;
        Mon, 20 May 2019 17:37:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=ZJ85rOyElubMYipRdbsgjUk3NtByDcHSnWPVtvc7k/s=;
 b=HhWaXluLu5nFDvbQxTzRd6wzSCFoPxAa+8aFMdTwYpfKAzeS1RbbrpcWt1pd2WsgVNWa
 v3Q0bkSeu4x24xtleW6bihP/RDIk0nFkZUMZxGxWrXQ7dolVeSPYdVn/9l8zgR48nVCS
 LEaUJCT3r6YybKdLcExVHKncu3DcwCTWcts= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2sm23rh1y0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 20 May 2019 17:37:22 -0700
Received: from ash-exhub201.TheFacebook.com (2620:10d:c0a8:83::7) by
 ash-exhub102.TheFacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 20 May 2019 17:37:20 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 20 May 2019 17:37:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJ85rOyElubMYipRdbsgjUk3NtByDcHSnWPVtvc7k/s=;
 b=a4DyncUzmiZ5gpVA064d/cW45taQmb924H0FSFJZSvZKaWFVps/S9AFVHTRIpMkgP94DuO3dZFrdS8fZdvnyrGpK86EZdffnH2RdwnENC2YWKkexyyUe3fOe9CvXvkppQFDoVTq1Av2DyouaKmOq7EKqgPZQNF5y1i7rKMHAPIY=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB3030.namprd15.prod.outlook.com (20.178.238.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.17; Tue, 21 May 2019 00:37:16 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d4f6:b485:69ee:fd9a]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d4f6:b485:69ee:fd9a%7]) with mapi id 15.20.1900.020; Tue, 21 May 2019
 00:37:16 +0000
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
Subject: Re: [RFC PATCH v5 01/16] slub: Add isolate() and migrate() methods
Thread-Topic: [RFC PATCH v5 01/16] slub: Add isolate() and migrate() methods
Thread-Index: AQHVDs6pVcV/OG74Wk6CpvJtS3vh06Z0vQqA
Date:   Tue, 21 May 2019 00:37:16 +0000
Message-ID: <20190521003709.GA21811@tower.DHCP.thefacebook.com>
References: <20190520054017.32299-1-tobin@kernel.org>
 <20190520054017.32299-2-tobin@kernel.org>
In-Reply-To: <20190520054017.32299-2-tobin@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:300:117::16) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::3:a985]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d99cefef-97a6-4cbe-1c5b-08d6dd847948
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR15MB3030;
x-ms-traffictypediagnostic: BYAPR15MB3030:
x-microsoft-antispam-prvs: <BYAPR15MB30305CE52774139B0ECF71D3BE070@BYAPR15MB3030.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0044C17179
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39860400002)(376002)(346002)(396003)(199004)(189003)(6116002)(7736002)(8676002)(81166006)(81156014)(4326008)(66946007)(73956011)(64756008)(186003)(66476007)(66556008)(68736007)(66446008)(6436002)(53936002)(9686003)(6486002)(6246003)(99286004)(6512007)(7416002)(305945005)(446003)(316002)(6916009)(8936002)(46003)(102836004)(229853002)(76176011)(54906003)(52116002)(486006)(25786009)(476003)(2906002)(11346002)(33656002)(386003)(6506007)(14454004)(256004)(71200400001)(86362001)(71190400001)(478600001)(1076003)(5660300002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3030;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bafUyGvs+JShrCdkx+i9PqhNPl7JekYoyH+hc3VkdhMYWXujaWEKv0qb1nRn/qHYxRN4vv8HSbcqxbYMCmlbff+HC6/t0cQj1YVCsjB6XQ0FY77txq1cwq+7BPdjMskEC4OZzrs3i2FHsKaqxnCLsjeXc31lgVU2sLoOmyD0OFrEG8A0G+G8j/MZy2u9fAoFmu5WpYrSTqxEVgoGOHlC1u28Fch/daYKUsGp/MgG0SaW8UUmEB3x9Tz79nIthZChJ0MpzFNt6SdhKPW1Oj8GIkXKEjQEgAt/I+JV+aAK7+noNGEn8BuCU+1CQ0BgAmHd8bhhvjZnmMY6oTSuLMVT00mwj97C963bBiZvI4l6vsIaBrDTO7q9NfR83FXlwURDLwPLP0tDa+rS5praDNjN1S5QGPG22xmp7ovXP8cvaqk=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D27462347A96654B8D1C91CD8BAF33C5@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d99cefef-97a6-4cbe-1c5b-08d6dd847948
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2019 00:37:16.3502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3030
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-20_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=442 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905210002
X-FB-Internal: deliver
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 20, 2019 at 03:40:02PM +1000, Tobin C. Harding wrote:
> Add the two methods needed for moving objects and enable the display of
> the callbacks via the /sys/kernel/slab interface.
>=20
> Add documentation explaining the use of these methods and the prototypes
> for slab.h. Add functions to setup the callbacks method for a slab
> cache.
>=20
> Add empty functions for SLAB/SLOB. The API is generic so it could be
> theoretically implemented for these allocators as well.
>=20
> Change sysfs 'ctor' field to be 'ops' to contain all the callback
> operations defined for a slab cache.  Display the existing 'ctor'
> callback in the ops fields contents along with 'isolate' and 'migrate'
> callbacks.
>=20
> Co-developed-by: Christoph Lameter <cl@linux.com>
> Signed-off-by: Tobin C. Harding <tobin@kernel.org>
> ---
>  include/linux/slab.h     | 70 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/slub_def.h |  3 ++
>  mm/slub.c                | 59 +++++++++++++++++++++++++++++----
>  3 files changed, 126 insertions(+), 6 deletions(-)

Reviewed-by: Roman Gushchin <guro@fb.com>

Thanks!
