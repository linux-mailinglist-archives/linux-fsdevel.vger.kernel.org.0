Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0787A576E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 04:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbjISChd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 22:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjISChd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 22:37:33 -0400
Received: from out-210.mta1.migadu.com (out-210.mta1.migadu.com [IPv6:2001:41d0:203:375::d2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18372FF
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 19:37:27 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1695091045;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5OJNjyBnLREqB4t2y6BnDouZQfoMamnWSnx+o56AOxg=;
        b=SP1SG92CdlrZckX/eX1RfKyREfr7y1srpE2MIRRG4j65DzPvjkZETTLcQ6PbIrgwcXcKbc
        4o13mEguIAmfirNWUzGJFkZs7KXv1gE3Jeh1KkMgQaLn04N/Rric50c3yRN9JQLaErM35U
        q/aAqFcCfvguVSwdbBP6QjcjS8YL4Yg=
Mime-Version: 1.0
Subject: Re: [PATCH v6 01/45] mm: shrinker: add infrastructure for dynamically
 allocating shrinker
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <529bce6f-e23b-4b84-a7e6-cce3c12645aa@bytedance.com>
Date:   Tue, 19 Sep 2023 10:36:42 +0800
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, tkhai@ya.ru, Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>, djwong@kernel.org,
        Christian Brauner <brauner@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        yujie.liu@intel.com, Greg KH <gregkh@linuxfoundation.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2C92CE73-2766-4E1A-AB77-F0DD91043457@linux.dev>
References: <20230911094444.68966-1-zhengqi.arch@bytedance.com>
 <20230911094444.68966-2-zhengqi.arch@bytedance.com>
 <4aff0e17-b40f-406d-65fd-72a2bacfcc1a@linux.dev>
 <529bce6f-e23b-4b84-a7e6-cce3c12645aa@bytedance.com>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Sep 18, 2023, at 20:06, Qi Zheng <zhengqi.arch@bytedance.com> =
wrote:
>=20
>=20
>=20
> On 2023/9/18 17:03, Muchun Song wrote:
>=20
> ...
>=20
>>> @@ -95,6 +97,11 @@ struct shrinker {
>>>    * non-MEMCG_AWARE shrinker should not have this flag set.
>>>    */
>>>   #define SHRINKER_NONSLAB    (1 << 3)
>>> +#define SHRINKER_ALLOCATED    (1 << 4)
>> It is better to add a comment here to tell users
>> it is only used by internals of shrinker. The users
>> are not supposed to pass this flag to shrink APIs.
>=20
> OK, will annotate SHRINKER_REGISTERED and SHRINKER_ALLOCATED
> as flags used internally.
>=20
>>> +
>>> +struct shrinker *shrinker_alloc(unsigned int flags, const char =
*fmt, ...);
>>> +void shrinker_register(struct shrinker *shrinker);
>>> +void shrinker_free(struct shrinker *shrinker);
>>>   extern int __printf(2, 3) prealloc_shrinker(struct shrinker =
*shrinker,
>>>                           const char *fmt, ...);
>>> diff --git a/mm/internal.h b/mm/internal.h
>>> index 0471d6326d01..5587cae20ebf 100644
>>> --- a/mm/internal.h
>>> +++ b/mm/internal.h
>>> @@ -1161,6 +1161,9 @@ unsigned long shrink_slab(gfp_t gfp_mask, int =
nid, struct mem_cgroup *memcg,
>>>   #ifdef CONFIG_SHRINKER_DEBUG
>>>   extern int shrinker_debugfs_add(struct shrinker *shrinker);
>>> +extern int shrinker_debugfs_name_alloc(struct shrinker *shrinker,
>>> +                       const char *fmt, va_list ap);
>>> +extern void shrinker_debugfs_name_free(struct shrinker *shrinker);
>>>   extern struct dentry *shrinker_debugfs_detach(struct shrinker =
*shrinker,
>>>                             int *debugfs_id);
>>>   extern void shrinker_debugfs_remove(struct dentry *debugfs_entry,
>>> @@ -1170,6 +1173,14 @@ static inline int shrinker_debugfs_add(struct =
shrinker *shrinker)
>>>   {
>>>       return 0;
>>>   }
>>> +static inline int shrinker_debugfs_name_alloc(struct shrinker =
*shrinker,
>>> +                          const char *fmt, va_list ap)
>>> +{
>>> +    return 0;
>>> +}
>>> +static inline void shrinker_debugfs_name_free(struct shrinker =
*shrinker)
>>> +{
>>> +}
>>>   static inline struct dentry *shrinker_debugfs_detach(struct =
shrinker *shrinker,
>>>                                int *debugfs_id)
>>>   {
>>> diff --git a/mm/shrinker.c b/mm/shrinker.c
>>> index a16cd448b924..201211a67827 100644
>>> --- a/mm/shrinker.c
>>> +++ b/mm/shrinker.c
>>> @@ -550,6 +550,108 @@ unsigned long shrink_slab(gfp_t gfp_mask, int =
nid, struct mem_cgroup *memcg,
>>>       return freed;
>>>   }
>>> +struct shrinker *shrinker_alloc(unsigned int flags, const char =
*fmt, ...)
>>> +{
>>> +    struct shrinker *shrinker;
>>> +    unsigned int size;
>>> +    va_list ap;
>>> +    int err;
>>> +
>>> +    shrinker =3D kzalloc(sizeof(struct shrinker), GFP_KERNEL);
>>> +    if (!shrinker)
>>> +        return NULL;
>>> +
>>> +    va_start(ap, fmt);
>>> +    err =3D shrinker_debugfs_name_alloc(shrinker, fmt, ap);
>>> +    va_end(ap);
>>> +    if (err)
>>> +        goto err_name;
>>> +
>>> +    shrinker->flags =3D flags | SHRINKER_ALLOCATED;
>>> +    shrinker->seeks =3D DEFAULT_SEEKS;
>>> +
>>> +    if (flags & SHRINKER_MEMCG_AWARE) {
>>> +        err =3D prealloc_memcg_shrinker(shrinker);
>>> +        if (err =3D=3D -ENOSYS)
>>> +            shrinker->flags &=3D ~SHRINKER_MEMCG_AWARE;
>>> +        else if (err =3D=3D 0)
>>> +            goto done;
>>> +        else
>>> +            goto err_flags;
>> Actually, the code here is a little confusing me when I fist look
>> at it. I think there could be some improvements here. Something
>> like:
>>         if (flags & SHRINKER_MEMCG_AWARE) {
>>                 err =3D prealloc_memcg_shrinker(shrinker);
>>                 if (err =3D=3D -ENOSYS) {
>>                         /* Memcg is not supported and fallback to =
non-memcg-aware shrinker. */
>>                         shrinker->flags &=3D ~SHRINKER_MEMCG_AWARE;
>>                         goto non-memcg;
>>                 }
>>                 if (err)
>>                     goto err_flags;
>>                 return shrinker;
>>         }
>> non-memcg:
>>         [...]
>>         return shrinker;
>> In this case, the code becomes more clear (at least for me). We have =
split the
>> code into two part, one is handling memcg-aware case, another is =
non-memcg-aware
>> case. Any side will have a explicit "return" keyword to return once =
succeeds.
>> It is a little implicit that the previous one uses "goto done".
>> And the tag of "non-memcg" is also a good annotation to tell us the =
following
>> code handles non-memcg-aware case.
>=20
> Make sense, will do.
>=20
>>> +    }
>>> +
>>> +    /*
>>> +     * The nr_deferred is available on per memcg level for memcg =
aware
>>> +     * shrinkers, so only allocate nr_deferred in the following =
cases:
>>> +     *  - non memcg aware shrinkers
>>> +     *  - !CONFIG_MEMCG
>>> +     *  - memcg is disabled by kernel command line
>>> +     */
>>> +    size =3D sizeof(*shrinker->nr_deferred);
>>> +    if (flags & SHRINKER_NUMA_AWARE)
>>> +        size *=3D nr_node_ids;
>>> +
>>> +    shrinker->nr_deferred =3D kzalloc(size, GFP_KERNEL);
>>> +    if (!shrinker->nr_deferred)
>>> +        goto err_flags;
>>> +
>>> +done:
>>> +    return shrinker;
>>> +
>>> +err_flags:
>>> +    shrinker_debugfs_name_free(shrinker);
>>> +err_name:
>>> +    kfree(shrinker);
>>> +    return NULL;
>>> +}
>>> +EXPORT_SYMBOL_GPL(shrinker_alloc);
>>> +
>>> +void shrinker_register(struct shrinker *shrinker)
>>> +{
>>> +    if (unlikely(!(shrinker->flags & SHRINKER_ALLOCATED))) {
>>> +        pr_warn("Must use shrinker_alloc() to dynamically allocate =
the shrinker");
>>> +        return;
>>> +    }
>>> +
>>> +    down_write(&shrinker_rwsem);
>>> +    list_add_tail(&shrinker->list, &shrinker_list);
>>> +    shrinker->flags |=3D SHRINKER_REGISTERED;
>>> +    shrinker_debugfs_add(shrinker);
>>> +    up_write(&shrinker_rwsem);
>>> +}
>>> +EXPORT_SYMBOL_GPL(shrinker_register);
>>> +
>>> +void shrinker_free(struct shrinker *shrinker)
>>> +{
>>> +    struct dentry *debugfs_entry =3D NULL;
>>> +    int debugfs_id;
>>> +
>>> +    if (!shrinker)
>>> +        return;
>>> +
>>> +    down_write(&shrinker_rwsem);
>>> +    if (shrinker->flags & SHRINKER_REGISTERED) {
>>> +        list_del(&shrinker->list);
>>> +        debugfs_entry =3D shrinker_debugfs_detach(shrinker, =
&debugfs_id);
>>> +        shrinker->flags &=3D ~SHRINKER_REGISTERED;
>>> +    } else {
>>> +        shrinker_debugfs_name_free(shrinker);
>> We could remove shrinker_debugfs_name_free() calling from
>> shrinker_debugfs_detach(), then we could call
>> shrinker_debugfs_name_free() anyway, otherwise, it it a little
>> weird for me. And the srinker name is allocated from =
shrinker_alloc(),
>> so I think it it reasonable for shrinker_free() to free the
>> shrinker name.
>=20
> OK, will do.
>=20
>> Thanks.
>>> +    }
>>> +
>>> +    if (shrinker->flags & SHRINKER_MEMCG_AWARE)
>>> +        unregister_memcg_shrinker(shrinker);
>>> +    up_write(&shrinker_rwsem);
>>> +
>>> +    if (debugfs_entry)
>>> +        shrinker_debugfs_remove(debugfs_entry, debugfs_id);
>>> +
>>> +    kfree(shrinker->nr_deferred);
>>> +    shrinker->nr_deferred =3D NULL;
>>> +
>>> +    kfree(shrinker);
>>> +}
>>> +EXPORT_SYMBOL_GPL(shrinker_free);
>>> +
>>>   /*
>>>    * Add a shrinker callback to be called from the vm.
>>>    */
>>> diff --git a/mm/shrinker_debug.c b/mm/shrinker_debug.c
>>> index e4ce509f619e..38452f539f40 100644
>>> --- a/mm/shrinker_debug.c
>>> +++ b/mm/shrinker_debug.c
>>> @@ -193,6 +193,20 @@ int shrinker_debugfs_add(struct shrinker =
*shrinker)
>>>       return 0;
>>>   }
>>> +int shrinker_debugfs_name_alloc(struct shrinker *shrinker, const =
char *fmt,
>>> +                va_list ap)
>>> +{
>>> +    shrinker->name =3D kvasprintf_const(GFP_KERNEL, fmt, ap);
>>> +
>>> +    return shrinker->name ? 0 : -ENOMEM;
>>> +}
>>> +
>>> +void shrinker_debugfs_name_free(struct shrinker *shrinker)
>>> +{
>>> +    kfree_const(shrinker->name);
>>> +    shrinker->name =3D NULL;
>>> +}
>> It it better to move both helpers to internal.h and mark them as =
inline
>> since both are very simple enough.
>=20
> OK, will do.
>=20
> Hi Andrew, below is the cleanup patch, which has a small conflict
> with [PATCH v6 41/45]:
>=20
> =46rom 5bc2b77484f5cd4616e510158f91c8877bd033ad Mon Sep 17 00:00:00 =
2001
> From: Qi Zheng <zhengqi.arch@bytedance.com>
> Date: Mon, 18 Sep 2023 10:41:15 +0000
> Subject: [PATCH] mm: shrinker: some cleanup
>=20
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.

