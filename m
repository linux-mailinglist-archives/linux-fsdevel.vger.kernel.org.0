Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A210624539
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2019 02:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfEUAww (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 May 2019 20:52:52 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:54808 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726586AbfEUAww (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 May 2019 20:52:52 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4L0lU5V020593;
        Mon, 20 May 2019 17:52:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=W09KEPBHKIqShgEcGVtd/p4ddz/ahhj9P5BMXq3ppRU=;
 b=blqSxzGEKBAqGVhUhwObKsrgY/vg9qwtgznoEHDZ2tsU+mPRlQq6RofGMpNq94neaQxU
 o6Iuuq6dc/m3BjUG6PN7N2ECf/06Z2Uc/88IyPuvVcdnV1Flkx4ARHThQWiog5KeR0uM
 mosKmuLORmRKvERVGvYjuJPrK+I26IIG6BQ= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2skuuhjfy5-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 20 May 2019 17:52:04 -0700
Received: from prn-mbx03.TheFacebook.com (2620:10d:c081:6::17) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 20 May 2019 17:52:02 -0700
Received: from prn-hub02.TheFacebook.com (2620:10d:c081:35::126) by
 prn-mbx03.TheFacebook.com (2620:10d:c081:6::17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 20 May 2019 17:52:02 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 20 May 2019 17:52:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W09KEPBHKIqShgEcGVtd/p4ddz/ahhj9P5BMXq3ppRU=;
 b=h4CdR+4tN2DwgKIR5sUEvddWcWyguofZMlBEXBpfZiok1XmAvaf/9h9I7LCjDAu0KLVc6grPGQDOblVbd5kptuCJb60XY0JWN6Elk7pabmNNXc6K4h6UFIDQPZMbl6mEGQcxZOjMUSWSAnOKuzZ8Du0BmaS1vIfBpd8w+1MqhQU=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB2216.namprd15.prod.outlook.com (52.135.196.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.17; Tue, 21 May 2019 00:51:57 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d4f6:b485:69ee:fd9a]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d4f6:b485:69ee:fd9a%7]) with mapi id 15.20.1900.020; Tue, 21 May 2019
 00:51:57 +0000
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
Subject: Re: [RFC PATCH v5 04/16] slub: Slab defrag core
Thread-Topic: [RFC PATCH v5 04/16] slub: Slab defrag core
Thread-Index: AQHVDs69QJvEmg+Y3UK7wQ/kts2ho6Z0wSQA
Date:   Tue, 21 May 2019 00:51:57 +0000
Message-ID: <20190521005152.GC21811@tower.DHCP.thefacebook.com>
References: <20190520054017.32299-1-tobin@kernel.org>
 <20190520054017.32299-5-tobin@kernel.org>
In-Reply-To: <20190520054017.32299-5-tobin@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR12CA0070.namprd12.prod.outlook.com
 (2603:10b6:300:103::32) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::3:a985]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6b996932-6882-46d6-ceaf-08d6dd86864d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR15MB2216;
x-ms-traffictypediagnostic: BYAPR15MB2216:
x-microsoft-antispam-prvs: <BYAPR15MB2216B525C0314F375BFF8E1BBE070@BYAPR15MB2216.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:820;
x-forefront-prvs: 0044C17179
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(396003)(136003)(346002)(376002)(199004)(189003)(66946007)(71190400001)(71200400001)(76176011)(52116002)(99286004)(73956011)(102836004)(1076003)(7736002)(229853002)(30864003)(14444005)(66556008)(68736007)(478600001)(6486002)(7416002)(256004)(6506007)(386003)(66476007)(66446008)(64756008)(305945005)(81166006)(81156014)(8676002)(5660300002)(53936002)(86362001)(6246003)(11346002)(6916009)(476003)(8936002)(33656002)(4326008)(446003)(54906003)(14454004)(6116002)(486006)(53946003)(6436002)(2906002)(6512007)(9686003)(316002)(46003)(186003)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2216;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tW3aJ9dXGKkaLgdvtuChmTJ4kpsFucK10DxtqT1lLiSFwuVcUJ+A2AR1LGV4EZ2H4NJmUVpuhOkCcLCq2CDjAZQ/NYKjtJvBxVwlzbaiaZ8NWpLiO4zP+anhbiDtWfEEW/urWXjwr+vVUhp6NmM3TpYnVmcBzD1WFrbEkmfuH8gfe7Srh3DD8HHLWLCresWs/snR8pYM3FKs6oNykGGQdrX2qdAR4ao/XCk0ZAueKT6V+qAoxle3Gc9ULZJDiNdcA1ZhRz+P3SnXfgXsHTUB4JCKSP0CHBle2FTf6A2aaUv1ZmwXimoJbm9mYBM3yaco5yHPG1xYGoJvJq5F3U8f8dTc6brhh5WLxEzzNQwTOwcrZEHWNyLfEbVRYyrcA/deS10H5iYHF2GOZBibovvd5jUoDeMxUXZObfUrdunP4Bw=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3F78B61F6A4EED4C83BB42869FACD089@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b996932-6882-46d6-ceaf-08d6dd86864d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2019 00:51:57.3553
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

On Mon, May 20, 2019 at 03:40:05PM +1000, Tobin C. Harding wrote:
> Internal fragmentation can occur within pages used by the slub
> allocator.  Under some workloads large numbers of pages can be used by
> partial slab pages.  This under-utilisation is bad simply because it
> wastes memory but also because if the system is under memory pressure
> higher order allocations may become difficult to satisfy.  If we can
> defrag slab caches we can alleviate these problems.
>=20
> Implement Slab Movable Objects in order to defragment slab caches.
>=20
> Slab defragmentation may occur:
>=20
> 1. Unconditionally when __kmem_cache_shrink() is called on a slab cache
>    by the kernel calling kmem_cache_shrink().
>=20
> 2. Unconditionally through the use of the slabinfo command.
>=20
> 	slabinfo <cache> -s
>=20
> 3. Conditionally via the use of kmem_cache_defrag()
>=20
> - Use Slab Movable Objects when shrinking cache.
>=20
> Currently when the kernel calls kmem_cache_shrink() we curate the
> partial slabs list.  If object migration is not enabled for the cache we
> still do this, if however, SMO is enabled we attempt to move objects in
> partially full slabs in order to defragment the cache.  Shrink attempts
> to move all objects in order to reduce the cache to a single partial
> slab for each node.
>=20
> - Add conditional per node defrag via new function:
>=20
> 	kmem_defrag_slabs(int node).
>=20
> kmem_defrag_slabs() attempts to defragment all slab caches for
> node. Defragmentation is done conditionally dependent on MAX_PARTIAL
> _and_ defrag_used_ratio.
>=20
>    Caches are only considered for defragmentation if the number of
>    partial slabs exceeds MAX_PARTIAL (per node).
>=20
>    Also, defragmentation only occurs if the usage ratio of the slab is
>    lower than the configured percentage (sysfs field added in this
>    patch).  Fragmentation ratios are measured by calculating the
>    percentage of objects in use compared to the total number of objects
>    that the slab page can accommodate.
>=20
>    The scanning of slab caches is optimized because the defragmentable
>    slabs come first on the list. Thus we can terminate scans on the
>    first slab encountered that does not support defragmentation.
>=20
>    kmem_defrag_slabs() takes a node parameter. This can either be -1 if
>    defragmentation should be performed on all nodes, or a node number.
>=20
>    Defragmentation may be disabled by setting defrag ratio to 0
>=20
> 	echo 0 > /sys/kernel/slab/<cache>/defrag_used_ratio
>=20
> - Add a defrag ratio sysfs field and set it to 30% by default. A limit
> of 30% specifies that more than 3 out of 10 available slots for objects
> need to be in use otherwise slab defragmentation will be attempted on
> the remaining objects.
>=20
> In order for a cache to be defragmentable the cache must support object
> migration (SMO).  Enabling SMO for a cache is done via a call to the
> recently added function:
>=20
> 	void kmem_cache_setup_mobility(struct kmem_cache *,
> 				       kmem_cache_isolate_func,
> 			               kmem_cache_migrate_func);
>=20
> Co-developed-by: Christoph Lameter <cl@linux.com>
> Signed-off-by: Tobin C. Harding <tobin@kernel.org>
> ---
>  Documentation/ABI/testing/sysfs-kernel-slab |  14 +
>  include/linux/slab.h                        |   1 +
>  include/linux/slub_def.h                    |   7 +
>  mm/slub.c                                   | 385 ++++++++++++++++----
>  4 files changed, 334 insertions(+), 73 deletions(-)

Hi Tobin!

Overall looks very good to me! I'll take another look when you'll post
a non-RFC version, but so far I can't find any issues.

A generic question: as I understand, you do support only root kmemcaches no=
w.
Is kmemcg support in plans?

Without it the patchset isn't as attractive to anyone using cgroups,
as it could be. Also, I hope it can solve (or mitigate) the memcg-specific
problem of scattering vfs cache workingset over multiple generations of the
same cgroup (their kmem_caches).

Thanks!

>=20
> diff --git a/Documentation/ABI/testing/sysfs-kernel-slab b/Documentation/=
ABI/testing/sysfs-kernel-slab
> index 29601d93a1c2..c6f129af035a 100644
> --- a/Documentation/ABI/testing/sysfs-kernel-slab
> +++ b/Documentation/ABI/testing/sysfs-kernel-slab
> @@ -180,6 +180,20 @@ Description:
>  		list.  It can be written to clear the current count.
>  		Available when CONFIG_SLUB_STATS is enabled.
> =20
> +What:		/sys/kernel/slab/cache/defrag_used_ratio
> +Date:		May 2019
> +KernelVersion:	5.2
> +Contact:	Christoph Lameter <cl@linux-foundation.org>
> +		Pekka Enberg <penberg@cs.helsinki.fi>,
> +Description:
> +		The defrag_used_ratio file allows the control of how aggressive
> +		slab fragmentation reduction works at reclaiming objects from
> +		sparsely populated slabs. This is a percentage. If a slab has
> +		less than this percentage of objects allocated then reclaim will
> +		attempt to reclaim objects so that the whole slab page can be
> +		freed. 0% specifies no reclaim attempt (defrag disabled), 100%
> +		specifies attempt to reclaim all pages.  The default is 30%.
> +
>  What:		/sys/kernel/slab/cache/deactivate_to_tail
>  Date:		February 2008
>  KernelVersion:	2.6.25
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 886fc130334d..4bf381b34829 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -149,6 +149,7 @@ struct kmem_cache *kmem_cache_create_usercopy(const c=
har *name,
>  			void (*ctor)(void *));
>  void kmem_cache_destroy(struct kmem_cache *);
>  int kmem_cache_shrink(struct kmem_cache *);
> +unsigned long kmem_defrag_slabs(int node);
> =20
>  void memcg_create_kmem_cache(struct mem_cgroup *, struct kmem_cache *);
>  void memcg_deactivate_kmem_caches(struct mem_cgroup *);
> diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
> index 2879a2f5f8eb..34c6f1250652 100644
> --- a/include/linux/slub_def.h
> +++ b/include/linux/slub_def.h
> @@ -107,6 +107,13 @@ struct kmem_cache {
>  	unsigned int red_left_pad;	/* Left redzone padding size */
>  	const char *name;	/* Name (only for display!) */
>  	struct list_head list;	/* List of slab caches */
> +	int defrag_used_ratio;	/*
> +				 * Ratio used to check against the
> +				 * percentage of objects allocated in a
> +				 * slab page.  If less than this ratio
> +				 * is allocated then reclaim attempts
> +				 * are made.
> +				 */
>  #ifdef CONFIG_SYSFS
>  	struct kobject kobj;	/* For sysfs */
>  	struct work_struct kobj_remove_work;
> diff --git a/mm/slub.c b/mm/slub.c
> index 66d474397c0f..2157205df7ba 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -355,6 +355,12 @@ static __always_inline void slab_lock(struct page *p=
age)
>  	bit_spin_lock(PG_locked, &page->flags);
>  }
> =20
> +static __always_inline int slab_trylock(struct page *page)
> +{
> +	VM_BUG_ON_PAGE(PageTail(page), page);
> +	return bit_spin_trylock(PG_locked, &page->flags);
> +}
> +
>  static __always_inline void slab_unlock(struct page *page)
>  {
>  	VM_BUG_ON_PAGE(PageTail(page), page);
> @@ -3634,6 +3640,7 @@ static int kmem_cache_open(struct kmem_cache *s, sl=
ab_flags_t flags)
> =20
>  	set_cpu_partial(s);
> =20
> +	s->defrag_used_ratio =3D 30;
>  #ifdef CONFIG_NUMA
>  	s->remote_node_defrag_ratio =3D 1000;
>  #endif
> @@ -3950,79 +3957,6 @@ void kfree(const void *x)
>  }
>  EXPORT_SYMBOL(kfree);
> =20
> -#define SHRINK_PROMOTE_MAX 32
> -
> -/*
> - * kmem_cache_shrink discards empty slabs and promotes the slabs filled
> - * up most to the head of the partial lists. New allocations will then
> - * fill those up and thus they can be removed from the partial lists.
> - *
> - * The slabs with the least items are placed last. This results in them
> - * being allocated from last increasing the chance that the last objects
> - * are freed in them.
> - */
> -int __kmem_cache_shrink(struct kmem_cache *s)
> -{
> -	int node;
> -	int i;
> -	struct kmem_cache_node *n;
> -	struct page *page;
> -	struct page *t;
> -	struct list_head discard;
> -	struct list_head promote[SHRINK_PROMOTE_MAX];
> -	unsigned long flags;
> -	int ret =3D 0;
> -
> -	flush_all(s);
> -	for_each_kmem_cache_node(s, node, n) {
> -		INIT_LIST_HEAD(&discard);
> -		for (i =3D 0; i < SHRINK_PROMOTE_MAX; i++)
> -			INIT_LIST_HEAD(promote + i);
> -
> -		spin_lock_irqsave(&n->list_lock, flags);
> -
> -		/*
> -		 * Build lists of slabs to discard or promote.
> -		 *
> -		 * Note that concurrent frees may occur while we hold the
> -		 * list_lock. page->inuse here is the upper limit.
> -		 */
> -		list_for_each_entry_safe(page, t, &n->partial, slab_list) {
> -			int free =3D page->objects - page->inuse;
> -
> -			/* Do not reread page->inuse */
> -			barrier();
> -
> -			/* We do not keep full slabs on the list */
> -			BUG_ON(free <=3D 0);
> -
> -			if (free =3D=3D page->objects) {
> -				list_move(&page->slab_list, &discard);
> -				n->nr_partial--;
> -			} else if (free <=3D SHRINK_PROMOTE_MAX)
> -				list_move(&page->slab_list, promote + free - 1);
> -		}
> -
> -		/*
> -		 * Promote the slabs filled up most to the head of the
> -		 * partial list.
> -		 */
> -		for (i =3D SHRINK_PROMOTE_MAX - 1; i >=3D 0; i--)
> -			list_splice(promote + i, &n->partial);
> -
> -		spin_unlock_irqrestore(&n->list_lock, flags);
> -
> -		/* Release empty slabs */
> -		list_for_each_entry_safe(page, t, &discard, slab_list)
> -			discard_slab(s, page);
> -
> -		if (slabs_node(s, node))
> -			ret =3D 1;
> -	}
> -
> -	return ret;
> -}
> -
>  #ifdef CONFIG_MEMCG
>  static void kmemcg_cache_deact_after_rcu(struct kmem_cache *s)
>  {
> @@ -4317,6 +4251,287 @@ int __kmem_cache_create(struct kmem_cache *s, sla=
b_flags_t flags)
>  	return err;
>  }
> =20
> +/*
> + * Allocate a slab scratch space that is sufficient to keep pointers to
> + * individual objects for all objects in cache and also a bitmap for the
> + * objects (used to mark which objects are active).
> + */
> +static inline void *alloc_scratch(struct kmem_cache *s)
> +{
> +	unsigned int size =3D oo_objects(s->max);
> +
> +	return kmalloc(size * sizeof(void *) +
> +		       BITS_TO_LONGS(size) * sizeof(unsigned long),
> +		       GFP_KERNEL);
> +}

I'd pass a single number (s->max) instead of s here.

> +
> +/*
> + * move_slab_page() - Move all objects in the given slab.
> + * @page: The slab we are working on.
> + * @scratch: Pointer to scratch space.
> + * @node: The target node to move objects to.
> + *
> + * If the target node is not the current node then the object is moved
> + * to the target node.  If the target node is the current node then this
> + * is an effective way of defragmentation since the current slab page
> + * with its object is exempt from allocation.
> + */
> +static void move_slab_page(struct page *page, void *scratch, int node)
> +{
> +	unsigned long objects;
> +	struct kmem_cache *s;
> +	unsigned long flags;
> +	unsigned long *map;
> +	void *private;
> +	int count;
> +	void *p;
> +	void **vector =3D scratch;
> +	void *addr =3D page_address(page);
> +
> +	local_irq_save(flags);
> +	slab_lock(page);
> +
> +	BUG_ON(!PageSlab(page)); /* Must be a slab page */
> +	BUG_ON(!page->frozen);	 /* Slab must have been frozen earlier */
> +
> +	s =3D page->slab_cache;
> +	objects =3D page->objects;
> +	map =3D scratch + objects * sizeof(void **);
> +
> +	/* Determine used objects */
> +	bitmap_fill(map, objects);
> +	for (p =3D page->freelist; p; p =3D get_freepointer(s, p))
> +		__clear_bit(slab_index(p, s, addr), map);
> +
> +	/* Build vector of pointers to objects */
> +	count =3D 0;
> +	memset(vector, 0, objects * sizeof(void **));
> +	for_each_object(p, s, addr, objects)
> +		if (test_bit(slab_index(p, s, addr), map))
> +			vector[count++] =3D p;
> +
> +	if (s->isolate)
> +		private =3D s->isolate(s, vector, count);
> +	else
> +		/* Objects do not need to be isolated */
> +		private =3D NULL;
> +
> +	/*
> +	 * Pinned the objects. Now we can drop the slab lock. The slab
> +	 * is frozen so it cannot vanish from under us nor will
> +	 * allocations be performed on the slab. However, unlocking the
> +	 * slab will allow concurrent slab_frees to proceed. So the
> +	 * subsystem must have a way to tell from the content of the
> +	 * object that it was freed.
> +	 *
> +	 * If neither RCU nor ctor is being used then the object may be
> +	 * modified by the allocator after being freed which may disrupt
> +	 * the ability of the migrate function to tell if the object is
> +	 * free or not.
> +	 */
> +	slab_unlock(page);
> +	local_irq_restore(flags);
> +
> +	/* Perform callback to move the objects */
> +	s->migrate(s, vector, count, node, private);
> +}
> +
> +/*
> + * kmem_cache_defrag() - Defragment node.
> + * @s: cache we are working on.
> + * @node: The node to move objects from.
> + * @target_node: The node to move objects to.
> + * @ratio: The defrag ratio (percentage, between 0 and 100).
> + *
> + * Release slabs with zero objects and try to call the migration functio=
n
> + * for slabs with less than the 'ratio' percentage of objects allocated.
> + *
> + * Moved objects are allocated on @target_node.
> + *
> + * Return: The number of partial slabs left on @node after the
> + *         operation.
> + */
> +static unsigned long kmem_cache_defrag(struct kmem_cache *s,
> +				       int node, int target_node, int ratio)
> +{
> +	struct kmem_cache_node *n =3D get_node(s, node);
> +	struct page *page, *page2;
> +	LIST_HEAD(move_list);
> +	unsigned long flags;
> +
> +	if (node =3D=3D target_node && n->nr_partial <=3D 1) {
> +		/*
> +		 * Trying to reduce fragmentation on a node but there is
> +		 * only a single or no partial slab page. This is already
> +		 * the optimal object density that we can reach.
> +		 */
> +		return n->nr_partial;
> +	}
> +
> +	spin_lock_irqsave(&n->list_lock, flags);
> +	list_for_each_entry_safe(page, page2, &n->partial, lru) {
> +		if (!slab_trylock(page))
> +			/* Busy slab. Get out of the way */
> +			continue;
> +
> +		if (page->inuse) {
> +			if (page->inuse > ratio * page->objects / 100) {
> +				slab_unlock(page);
> +				/*
> +				 * Skip slab because the object density
> +				 * in the slab page is high enough.
> +				 */
> +				continue;
> +			}
> +
> +			list_move(&page->lru, &move_list);
> +			if (s->migrate) {
> +				/* Stop page being considered for allocations */
> +				n->nr_partial--;
> +				page->frozen =3D 1;
> +			}
> +			slab_unlock(page);
> +		} else {	/* Empty slab page */
> +			list_del(&page->lru);
> +			n->nr_partial--;
> +			slab_unlock(page);
> +			discard_slab(s, page);
> +		}
> +	}
> +
> +	if (!s->migrate) {
> +		/*
> +		 * No defrag method. By simply putting the zaplist at
> +		 * the end of the partial list we can let them simmer
> +		 * longer and thus increase the chance of all objects
> +		 * being reclaimed.
> +		 */
> +		list_splice(&move_list, n->partial.prev);
> +	}
> +
> +	spin_unlock_irqrestore(&n->list_lock, flags);
> +
> +	if (s->migrate && !list_empty(&move_list)) {
> +		void **scratch =3D alloc_scratch(s);
> +		if (scratch) {
> +			/* Try to remove / move the objects left */
> +			list_for_each_entry(page, &move_list, lru) {
> +				if (page->inuse)
> +					move_slab_page(page, scratch, target_node);
> +			}
> +			kfree(scratch);
> +		}
> +
> +		/* Inspect results and dispose of pages */
> +		spin_lock_irqsave(&n->list_lock, flags);
> +		list_for_each_entry_safe(page, page2, &move_list, lru) {
> +			list_del(&page->lru);
> +			slab_lock(page);
> +			page->frozen =3D 0;
> +
> +			if (page->inuse) {
> +				/*
> +				 * Objects left in slab page, move it to the
> +				 * tail of the partial list to increase the
> +				 * chance that the freeing of the remaining
> +				 * objects will free the slab page.
> +				 */
> +				n->nr_partial++;
> +				list_add_tail(&page->lru, &n->partial);
> +				slab_unlock(page);
> +			} else {
> +				slab_unlock(page);
> +				discard_slab(s, page);
> +			}
> +		}
> +		spin_unlock_irqrestore(&n->list_lock, flags);
> +	}
> +
> +	return n->nr_partial;
> +}
> +
> +/**
> + * kmem_defrag_slabs() - Defrag slab caches.
> + * @node: The node to defrag or -1 for all nodes.
> + *
> + * Defrag slabs conditional on the amount of fragmentation in a page.
> + *
> + * Return: The total number of partial slabs in migratable caches left
> + *         on @node after the operation.
> + */
> +unsigned long kmem_defrag_slabs(int node)
> +{
> +	struct kmem_cache *s;
> +	unsigned long left =3D 0;
> +	int nid;
> +
> +	if (node >=3D MAX_NUMNODES)
> +		return -EINVAL;
> +
> +	/*
> +	 * kmem_defrag_slabs() may be called from the reclaim path which
> +	 * may be called for any page allocator alloc. So there is the
> +	 * danger that we get called in a situation where slub already
> +	 * acquired the slub_lock for other purposes.
> +	 */
> +	if (!mutex_trylock(&slab_mutex))
> +		return 0;
> +
> +	list_for_each_entry(s, &slab_caches, list) {
> +		/*
> +		 * Defragmentable caches come first. If the slab cache is
> +		 * not defragmentable then we can stop traversing the list.
> +		 */
> +		if (!s->migrate)
> +			break;
> +
> +		if (node >=3D 0) {
> +			if (s->node[node]->nr_partial > MAX_PARTIAL) {
> +				left +=3D kmem_cache_defrag(s, node, node,
> +							  s->defrag_used_ratio);
> +			}
> +			continue;
> +		}
> +
> +		for_each_node_state(nid, N_NORMAL_MEMORY) {
> +			if (s->node[nid]->nr_partial > MAX_PARTIAL) {
> +				left +=3D kmem_cache_defrag(s, nid, nid,
> +							  s->defrag_used_ratio);
> +			}
> +		}
> +	}
> +	mutex_unlock(&slab_mutex);
> +	return left;
> +}
> +EXPORT_SYMBOL(kmem_defrag_slabs);
> +
> +/**
> + * __kmem_cache_shrink() - Shrink a cache.
> + * @s: The cache to shrink.
> + *
> + * Reduces the memory footprint of a slab cache by as much as possible.
> + *
> + * This works by:
> + *  1. Removing empty slabs from the partial list.
> + *  2. Migrating slab objects to denser slab pages if the slab cache
> + *  supports migration.  If not, reorganizing the partial list so that
> + *  more densely allocated slab pages come first.
> + *
> + * Not called directly, called by kmem_cache_shrink().
> + */
> +int __kmem_cache_shrink(struct kmem_cache *s)
> +{
> +	int node;
> +	int left =3D 0;
> +
> +	flush_all(s);
> +	for_each_node_state(node, N_NORMAL_MEMORY)
> +		left +=3D kmem_cache_defrag(s, node, node, 100);
> +
> +	return left;
> +}
> +EXPORT_SYMBOL(__kmem_cache_shrink);
> +
>  void kmem_cache_setup_mobility(struct kmem_cache *s,
>  			       kmem_cache_isolate_func isolate,
>  			       kmem_cache_migrate_func migrate)
> @@ -5168,6 +5383,29 @@ static ssize_t destroy_by_rcu_show(struct kmem_cac=
he *s, char *buf)
>  }
>  SLAB_ATTR_RO(destroy_by_rcu);
> =20
> +static ssize_t defrag_used_ratio_show(struct kmem_cache *s, char *buf)
> +{
> +	return sprintf(buf, "%d\n", s->defrag_used_ratio);
> +}
> +
> +static ssize_t defrag_used_ratio_store(struct kmem_cache *s,
> +				       const char *buf, size_t length)
> +{
> +	unsigned long ratio;
> +	int err;
> +
> +	err =3D kstrtoul(buf, 10, &ratio);
> +	if (err)
> +		return err;
> +
> +	if (ratio > 100)
> +		return -EINVAL;
> +
> +	s->defrag_used_ratio =3D ratio;
> +	return length;
> +}
> +SLAB_ATTR(defrag_used_ratio);
> +
>  #ifdef CONFIG_SLUB_DEBUG
>  static ssize_t slabs_show(struct kmem_cache *s, char *buf)
>  {
> @@ -5492,6 +5730,7 @@ static struct attribute *slab_attrs[] =3D {
>  	&validate_attr.attr,
>  	&alloc_calls_attr.attr,
>  	&free_calls_attr.attr,
> +	&defrag_used_ratio_attr.attr,
>  #endif
>  #ifdef CONFIG_ZONE_DMA
>  	&cache_dma_attr.attr,
> --=20
> 2.21.0
>=20
