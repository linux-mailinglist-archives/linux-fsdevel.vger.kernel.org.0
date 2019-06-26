Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55CB157271
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2019 22:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbfFZUUP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jun 2019 16:20:15 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:14684 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726357AbfFZUUP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jun 2019 16:20:15 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5QKDx9p007310;
        Wed, 26 Jun 2019 13:19:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=M4vrHSrBEE5RnH6j6JfZxg6FcoHo6rNTZz4qxyJUWfA=;
 b=oJHHrJK0eB/uYYyFJ0TYcfB6xkWEDAoV8ZB/c98R6Fs9iBQax88QAWKjxzpIFVPm6oqJ
 zy7LSPT0m9Tar9oE7ecKFZdn3TfV0tWvGCVnd7axTbF0MhTwveQexK3Px5w+62o6Wp0d
 t1kNbaatwWolIi0mBV4w9hcguEX+VZfbLXU= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2tcdfs8gku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 26 Jun 2019 13:19:26 -0700
Received: from prn-mbx03.TheFacebook.com (2620:10d:c081:6::17) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 26 Jun 2019 13:19:25 -0700
Received: from prn-hub02.TheFacebook.com (2620:10d:c081:35::126) by
 prn-mbx03.TheFacebook.com (2620:10d:c081:6::17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 26 Jun 2019 13:19:25 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 26 Jun 2019 13:19:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M4vrHSrBEE5RnH6j6JfZxg6FcoHo6rNTZz4qxyJUWfA=;
 b=pSycmtxs/UIGlbDkIx5ITb83xMnTnDo+YD1fZvxlECzYvPNr27K8Lsa3mRdf6bra+33JpL+RMgs+DKVzDiQ8WSjpn9wfAKkP/eJqI1O5Q/GJY9wxU68LTP5rgpsqlJmf7NPhmMqHsZUtLvOv20azq5KF03Cr/dBS2jGa3Yz49/w=
Received: from BN8PR15MB2626.namprd15.prod.outlook.com (20.179.137.220) by
 BN8PR15MB3443.namprd15.prod.outlook.com (20.179.76.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Wed, 26 Jun 2019 20:19:23 +0000
Received: from BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::e594:155f:a43:92ad]) by BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::e594:155f:a43:92ad%6]) with mapi id 15.20.2008.018; Wed, 26 Jun 2019
 20:19:23 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Waiman Long <longman@redhat.com>
CC:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH 2/2] mm, slab: Extend vm/drop_caches to shrink kmem slabs
Thread-Topic: [PATCH 2/2] mm, slab: Extend vm/drop_caches to shrink kmem slabs
Thread-Index: AQHVKrRnjGLXeWaE8kq5EhXDbrxOt6auY3OA
Date:   Wed, 26 Jun 2019 20:19:23 +0000
Message-ID: <20190626201900.GC24698@tower.DHCP.thefacebook.com>
References: <20190624174219.25513-1-longman@redhat.com>
 <20190624174219.25513-3-longman@redhat.com>
In-Reply-To: <20190624174219.25513-3-longman@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR14CA0047.namprd14.prod.outlook.com
 (2603:10b6:300:12b::33) To BN8PR15MB2626.namprd15.prod.outlook.com
 (2603:10b6:408:c7::28)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::2:d5a9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5bdf17f2-dfe0-45f4-fb22-08d6fa739431
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN8PR15MB3443;
x-ms-traffictypediagnostic: BN8PR15MB3443:
x-microsoft-antispam-prvs: <BN8PR15MB34436A3565DE963D8BB93538BEE20@BN8PR15MB3443.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:901;
x-forefront-prvs: 00808B16F3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(136003)(39860400002)(376002)(189003)(199004)(14454004)(33656002)(6246003)(102836004)(14444005)(256004)(71190400001)(71200400001)(486006)(305945005)(8676002)(11346002)(6436002)(7736002)(6916009)(186003)(6486002)(86362001)(7416002)(446003)(81156014)(6512007)(476003)(9686003)(81166006)(25786009)(1076003)(6116002)(66556008)(68736007)(53936002)(316002)(8936002)(66446008)(5660300002)(46003)(2906002)(229853002)(99286004)(76176011)(386003)(66946007)(52116002)(64756008)(73956011)(6506007)(54906003)(66476007)(4326008)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR15MB3443;H:BN8PR15MB2626.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4D7BX8RnVfFfaQ9pc/82uv9X23u14aj1iBvBB3MFxrqyIROiGlN8DNdW9eH0K9K34wJ1o/IVtY1LOmidZjcuc4wzPZx03ZwLo3c44oUIYoylX8io9DIzgc+1tP1d95mwTcUOteOrxwYc8RKkWzuYWj2l5Vm/FbVVt8NIWj3GBN/DyYvwzlw7M3hxeGqwu8YKpWbwR+m1630Bdews19tHmmtqz6w3RjFKOZzhUCdQBMGgU1JvHtcn2pTEbRXdeqpi44B23/JtBIL0v+9QFDSWVY8+2RrtOgj0QfuyLoBt8+TXCy+u9/TmUzL9r71Yd+tt6J/tvIpTo+vEMa2Ey1PSQPEl1+c8D5VRBqEskNRIymW8KiWwKgpRIvciTUNlguLQ66Sgw8FBjTUuT8zQPao4GxcD34DizPmBf0pEiOGdWsE=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <57AA2DBB24C0BA4DB2F8CE916F7C523C@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bdf17f2-dfe0-45f4-fb22-08d6fa739431
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2019 20:19:23.7718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: guro@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB3443
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-26_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906260234
X-FB-Internal: deliver
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 24, 2019 at 01:42:19PM -0400, Waiman Long wrote:
> With the slub memory allocator, the numbers of active slab objects
> reported in /proc/slabinfo are not real because they include objects
> that are held by the per-cpu slab structures whether they are actually
> used or not.  The problem gets worse the more CPUs a system have. For
> instance, looking at the reported number of active task_struct objects,
> one will wonder where all the missing tasks gone.
>=20
> I know it is hard and costly to get a real count of active objects. So
> I am not advocating for that. Instead, this patch extends the
> /proc/sys/vm/drop_caches sysctl parameter by using a new bit (bit 3)
> to shrink all the kmem slabs which will flush out all the slabs in the
> per-cpu structures and give a more accurate view of how much memory are
> really used up by the active slab objects. This is a costly operation,
> of course, but it gives a way to have a clearer picture of the actual
> number of slab objects used, if the need arises.
>=20
> The upper range of the drop_caches sysctl parameter is increased to 15
> to allow all possible combinations of the lowest 4 bits.
>=20
> On a 2-socket 64-core 256-thread ARM64 system with 64k page size after
> a parallel kernel build, the amount of memory occupied by slabs before
> and after echoing to drop_caches were:
>=20
>  # grep task_struct /proc/slabinfo
>  task_struct        48376  48434   4288   61    4 : tunables    0    0
>  0 : slabdata    794    794      0
>  # grep "^S[lRU]" /proc/meminfo
>  Slab:            3419072 kB
>  SReclaimable:     354688 kB
>  SUnreclaim:      3064384 kB
>  # echo 3 > /proc/sys/vm/drop_caches
>  # grep "^S[lRU]" /proc/meminfo
>  Slab:            3351680 kB
>  SReclaimable:     316096 kB
>  SUnreclaim:      3035584 kB
>  # echo 8 > /proc/sys/vm/drop_caches
>  # grep "^S[lRU]" /proc/meminfo
>  Slab:            1008192 kB
>  SReclaimable:     126912 kB
>  SUnreclaim:       881280 kB
>  # grep task_struct /proc/slabinfo
>  task_struct         2601   6588   4288   61    4 : tunables    0    0
>  0 : slabdata    108    108      0
>=20
> Shrinking the slabs saves more than 2GB of memory in this case. This
> new feature certainly fulfills the promise of dropping caches.
>=20
> Unlike counting objects in the per-node caches done by /proc/slabinfo
> which is rather light weight, iterating all the per-cpu caches and
> shrinking them is much more heavy weight.
>=20
> For this particular instance, the time taken to shrinks all the root
> caches was about 30.2ms. There were 73 memory cgroup and the longest
> time taken for shrinking the largest one was about 16.4ms. The total
> shrinking time was about 101ms.
>=20
> Because of the potential long time to shrinks all the caches, the
> slab_mutex was taken multiple times - once for all the root caches
> and once for each memory cgroup. This is to reduce the slab_mutex hold
> time to minimize impact to other running applications that may need to
> acquire the mutex.
>=20
> The slab shrinking feature is only available when CONFIG_MEMCG_KMEM is
> defined as the code need to access slab_root_caches to iterate all the
> root caches.
>=20
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  Documentation/sysctl/vm.txt | 11 ++++++++--
>  fs/drop_caches.c            |  4 ++++
>  include/linux/slab.h        |  1 +
>  kernel/sysctl.c             |  4 ++--
>  mm/slab_common.c            | 44 +++++++++++++++++++++++++++++++++++++
>  5 files changed, 60 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/sysctl/vm.txt b/Documentation/sysctl/vm.txt
> index 749322060f10..b643ac8968d2 100644
> --- a/Documentation/sysctl/vm.txt
> +++ b/Documentation/sysctl/vm.txt
> @@ -207,8 +207,8 @@ Setting this to zero disables periodic writeback alto=
gether.
>  drop_caches
> =20
>  Writing to this will cause the kernel to drop clean caches, as well as
> -reclaimable slab objects like dentries and inodes.  Once dropped, their
> -memory becomes free.
> +reclaimable slab objects like dentries and inodes.  It can also be used
> +to shrink the slabs.  Once dropped, their memory becomes free.
> =20
>  To free pagecache:
>  	echo 1 > /proc/sys/vm/drop_caches
> @@ -216,6 +216,8 @@ To free reclaimable slab objects (includes dentries a=
nd inodes):
>  	echo 2 > /proc/sys/vm/drop_caches
>  To free slab objects and pagecache:
>  	echo 3 > /proc/sys/vm/drop_caches
> +To shrink the slabs:
> +	echo 8 > /proc/sys/vm/drop_caches
> =20
>  This is a non-destructive operation and will not free any dirty objects.
>  To increase the number of objects freed by this operation, the user may =
run
> @@ -223,6 +225,11 @@ To increase the number of objects freed by this oper=
ation, the user may run
>  number of dirty objects on the system and create more candidates to be
>  dropped.
> =20
> +Shrinking the slabs can reduce the memory footprint used by the slabs.
> +It also makes the number of active objects reported in /proc/slabinfo
> +more representative of the actual number of objects used for the slub
> +memory allocator.
> +
>  This file is not a means to control the growth of the various kernel cac=
hes
>  (inodes, dentries, pagecache, etc...)  These objects are automatically
>  reclaimed by the kernel when memory is needed elsewhere on the system.
> diff --git a/fs/drop_caches.c b/fs/drop_caches.c
> index d31b6c72b476..633b99e25dab 100644
> --- a/fs/drop_caches.c
> +++ b/fs/drop_caches.c
> @@ -9,6 +9,7 @@
>  #include <linux/writeback.h>
>  #include <linux/sysctl.h>
>  #include <linux/gfp.h>
> +#include <linux/slab.h>
>  #include "internal.h"
> =20
>  /* A global variable is a bit ugly, but it keeps the code simple */
> @@ -65,6 +66,9 @@ int drop_caches_sysctl_handler(struct ctl_table *table,=
 int write,
>  			drop_slab();
>  			count_vm_event(DROP_SLAB);
>  		}
> +		if (sysctl_drop_caches & 8) {
> +			kmem_cache_shrink_all();
> +		}
>  		if (!stfu) {
>  			pr_info("%s (%d): drop_caches: %d\n",
>  				current->comm, task_pid_nr(current),
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 9449b19c5f10..f7c1626b2aa6 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -149,6 +149,7 @@ struct kmem_cache *kmem_cache_create_usercopy(const c=
har *name,
>  			void (*ctor)(void *));
>  void kmem_cache_destroy(struct kmem_cache *);
>  int kmem_cache_shrink(struct kmem_cache *);
> +void kmem_cache_shrink_all(void);
> =20
>  void memcg_create_kmem_cache(struct mem_cgroup *, struct kmem_cache *);
>  void memcg_deactivate_kmem_caches(struct mem_cgroup *);
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 1beca96fb625..feeb867dabd7 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -129,7 +129,7 @@ static int __maybe_unused neg_one =3D -1;
>  static int zero;
>  static int __maybe_unused one =3D 1;
>  static int __maybe_unused two =3D 2;
> -static int __maybe_unused four =3D 4;
> +static int __maybe_unused fifteen =3D 15;
>  static unsigned long zero_ul;
>  static unsigned long one_ul =3D 1;
>  static unsigned long long_max =3D LONG_MAX;
> @@ -1455,7 +1455,7 @@ static struct ctl_table vm_table[] =3D {
>  		.mode		=3D 0644,
>  		.proc_handler	=3D drop_caches_sysctl_handler,
>  		.extra1		=3D &one,
> -		.extra2		=3D &four,
> +		.extra2		=3D &fifteen,
>  	},
>  #ifdef CONFIG_COMPACTION
>  	{
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 58251ba63e4a..b3c5b64f9bfb 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -956,6 +956,50 @@ int kmem_cache_shrink(struct kmem_cache *cachep)
>  }
>  EXPORT_SYMBOL(kmem_cache_shrink);

Hi Waiman!

> =20
> +#ifdef CONFIG_MEMCG_KMEM
> +static void kmem_cache_shrink_memcg(struct mem_cgroup *memcg,
> +				    void __maybe_unused *arg)
> +{
> +	struct kmem_cache *s;
> +
> +	if (memcg =3D=3D root_mem_cgroup)
> +		return;
> +	mutex_lock(&slab_mutex);
> +	list_for_each_entry(s, &memcg->kmem_caches,
> +			    memcg_params.kmem_caches_node) {
> +		kmem_cache_shrink(s);
> +	}
> +	mutex_unlock(&slab_mutex);
> +	cond_resched();
> +}

A couple of questions:
1) how about skipping already offlined kmem_caches? They are already shrunk=
,
   so you probably won't get much out of them. Or isn't it true?
2) what's your long-term vision here? do you think that we need to shrink
   kmem_caches periodically, depending on memory pressure? how a user
   will use this new sysctl?

What's the problem you're trying to solve in general?

Thanks!

Roman
