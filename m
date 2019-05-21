Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40A4924546
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2019 02:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfEUA6Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 May 2019 20:58:24 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:46794 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727022AbfEUA6Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 May 2019 20:58:24 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4L0sA3N017441;
        Mon, 20 May 2019 17:57:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=TM8DZL0gmHIpp37seP1BhserElmc8pQZwFg67844eNo=;
 b=kibDD5fIhGy4onJX/swFTnjzVs21RqZMfN4BdNlhqLd17o7VE5zRfdARWgE1LivVospZ
 ELRui0vC1OAUPCAYeSzZtIUEgXTfH0gFdvoFr1htEOVR4JexJBCNSvk/uhIRsL2bX248
 6Hh/6YsgtgPhmyFEP+oNgYRzQXzAIQ1TnCI= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2sm23rh3kx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 20 May 2019 17:57:53 -0700
Received: from prn-mbx01.TheFacebook.com (2620:10d:c081:6::15) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 20 May 2019 17:57:52 -0700
Received: from prn-hub03.TheFacebook.com (2620:10d:c081:35::127) by
 prn-mbx01.TheFacebook.com (2620:10d:c081:6::15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 20 May 2019 17:57:52 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 20 May 2019 17:57:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TM8DZL0gmHIpp37seP1BhserElmc8pQZwFg67844eNo=;
 b=LyEtEOR2X5/TU0Ila0Kd5N5HpXBJm3pGWAT9C8vJTuwG19UBr83AxpBdOjWMwmZUfVrMVOp7wop2kgEkM1NYG90w9vx6S2E8lrAehiVj3hydjME8MwtG1S2YkoedpD5mf7XQl4AcCUMlcvY0yqsvtYPEIF+c8UYzb0yRi5bFiJ4=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB2216.namprd15.prod.outlook.com (52.135.196.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.17; Tue, 21 May 2019 00:57:48 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d4f6:b485:69ee:fd9a]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d4f6:b485:69ee:fd9a%7]) with mapi id 15.20.1900.020; Tue, 21 May 2019
 00:57:48 +0000
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
Subject: Re: [RFC PATCH v5 16/16] dcache: Add CONFIG_DCACHE_SMO
Thread-Topic: [RFC PATCH v5 16/16] dcache: Add CONFIG_DCACHE_SMO
Thread-Index: AQHVDs7p5YZCYW51S0W/c+2xf0nte6Z0wsaA
Date:   Tue, 21 May 2019 00:57:47 +0000
Message-ID: <20190521005740.GA9552@tower.DHCP.thefacebook.com>
References: <20190520054017.32299-1-tobin@kernel.org>
 <20190520054017.32299-17-tobin@kernel.org>
In-Reply-To: <20190520054017.32299-17-tobin@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR22CA0045.namprd22.prod.outlook.com
 (2603:10b6:300:69::31) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::3:a985]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 82f4699f-9fc4-4f82-2fdc-08d6dd87575c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR15MB2216;
x-ms-traffictypediagnostic: BYAPR15MB2216:
x-microsoft-antispam-prvs: <BYAPR15MB2216798B2B4ED86B7D0E44BCBE070@BYAPR15MB2216.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0044C17179
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(396003)(39860400002)(366004)(199004)(189003)(446003)(33656002)(8936002)(4326008)(81156014)(81166006)(8676002)(5660300002)(6916009)(11346002)(476003)(53936002)(6246003)(86362001)(54906003)(316002)(25786009)(186003)(46003)(486006)(6116002)(14454004)(6512007)(9686003)(6436002)(2906002)(73956011)(99286004)(1076003)(102836004)(66946007)(71190400001)(71200400001)(52116002)(76176011)(386003)(6506007)(64756008)(66446008)(66476007)(305945005)(229853002)(7736002)(7416002)(6486002)(256004)(66556008)(478600001)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2216;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xRpvirUkjERfb9PuWhG19+ZXknpLoCSjHnALl/MnkB3vNRAdN7xatpuFKWPQBOb2DawnATWWkZbIFhp13mWBXb/EiFDbZL9S22AMbGDrZ2dwq5z4/YzrSV5I1PbmpEH216v2mx8U3KsZIFsaimexp3xW1cxNh/WlXYY+Ymbmf/h3MHxU4ozxovZKbpmRd3LruZpZmwDuVvTLhTZZYoWhUGC2qieZg8ys2g2DLc5hgZVUWvxz2zFprP2IrhqzwgOPh4WEyQu6yxMzH0Upa/22sHmFO3kk5OOT+zY6iWceiN16eRHDbWs4+3RNoE0FpFQCKaz/XLQN2kQwqTJqs4nS3fa3w9j9PicJ9AANQvRlnM7DpsB66f7EbmL0feqvOoenc2bLJKsM+3FAyv3FPArv/PYXqd3TTJpqehdYYsnhCXE=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C9090530CF13BD48A17BBC06E3F61551@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 82f4699f-9fc4-4f82-2fdc-08d6dd87575c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2019 00:57:47.9854
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2216
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-20_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 20, 2019 at 03:40:17PM +1000, Tobin C. Harding wrote:
> In an attempt to make the SMO patchset as non-invasive as possible add a
> config option CONFIG_DCACHE_SMO (under "Memory Management options") for
> enabling SMO for the DCACHE.  Whithout this option dcache constructor is
> used but no other code is built in, with this option enabled slab
> mobility is enabled and the isolate/migrate functions are built in.
>=20
> Add CONFIG_DCACHE_SMO to guard the partial shrinking of the dcache via
> Slab Movable Objects infrastructure.

Hm, isn't it better to make it a static branch? Or basically anything
that allows switching on the fly?

It seems that the cost of just building it in shouldn't be that high.
And the question if the defragmentation worth the trouble is so much
easier to answer if it's possible to turn it on and off without rebooting.

Thanks!

>=20
> Signed-off-by: Tobin C. Harding <tobin@kernel.org>
> ---
>  fs/dcache.c | 4 ++++
>  mm/Kconfig  | 7 +++++++
>  2 files changed, 11 insertions(+)
>=20
> diff --git a/fs/dcache.c b/fs/dcache.c
> index 0dfe580c2d42..96063e872366 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -3072,6 +3072,7 @@ void d_tmpfile(struct dentry *dentry, struct inode =
*inode)
>  }
>  EXPORT_SYMBOL(d_tmpfile);
> =20
> +#ifdef CONFIG_DCACHE_SMO
>  /*
>   * d_isolate() - Dentry isolation callback function.
>   * @s: The dentry cache.
> @@ -3144,6 +3145,7 @@ static void d_partial_shrink(struct kmem_cache *s, =
void **_unused, int __unused,
> =20
>  	kfree(private);
>  }
> +#endif	/* CONFIG_DCACHE_SMO */
> =20
>  static __initdata unsigned long dhash_entries;
>  static int __init set_dhash_entries(char *str)
> @@ -3190,7 +3192,9 @@ static void __init dcache_init(void)
>  					   sizeof_field(struct dentry, d_iname),
>  					   dcache_ctor);
> =20
> +#ifdef CONFIG_DCACHE_SMO
>  	kmem_cache_setup_mobility(dentry_cache, d_isolate, d_partial_shrink);
> +#endif
> =20
>  	/* Hash may have been set up in dcache_init_early */
>  	if (!hashdist)
> diff --git a/mm/Kconfig b/mm/Kconfig
> index aa8d60e69a01..7dcea76e5ecc 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -265,6 +265,13 @@ config SMO_NODE
>         help
>           On NUMA systems enable moving objects to and from a specified n=
ode.
> =20
> +config DCACHE_SMO
> +       bool "Enable Slab Movable Objects for the dcache"
> +       depends on SLUB
> +       help
> +         Under memory pressure we can try to free dentry slab cache obje=
cts from
> +         the partial slab list if this is enabled.
> +
>  config PHYS_ADDR_T_64BIT
>  	def_bool 64BIT
> =20
> --=20
> 2.21.0
>=20
