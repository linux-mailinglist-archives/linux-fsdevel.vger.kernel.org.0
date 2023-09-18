Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49AB47A4940
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 14:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241781AbjIRMIF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 08:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241989AbjIRMIA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 08:08:00 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62DE8E
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 05:07:53 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c4456d595cso4761505ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 05:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1695038873; x=1695643673; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6b4Dq3JaEn3NjqvHsSqb1vNTF921wb5a6jhyMAxCtW0=;
        b=EpkY8NphhARMAHFGfxKBc6ePp8eJBIcnefvWrKVjv56X7gpanjFYs9kHQjUkulwPYi
         t/arOXhYaHK/nMQnda2YPAGUA5in8s8sgsTf01GalBTt8wDkNcxAkiSyCP+zeLic8QyI
         C2bZxD9Q+pA19/UComiXJFODgBWi3CtTJ9odIMxfdakzZsg1kxJf7bKpcRI+TXc6geMS
         Ni7taUWo+Z0ZohKndj2n7hGoOprTDL2hTUdS5mkTZMI9LOKqkagpkXNtFivcDPz6NMo0
         JgwyNiNkqzfvAxUcfEd+T9wy2v9oy5b/NDKBgO4Jfr+2Du3Yjhw+2M2TSeZpsyGhh0xa
         jAoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695038873; x=1695643673;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6b4Dq3JaEn3NjqvHsSqb1vNTF921wb5a6jhyMAxCtW0=;
        b=jGz1pL36txIDsTgWh76URRGaqch52u1GRk7+KwhkyWK1i95H0jP+IE/8sCTirO40p9
         +izaqJfpUDorHzxI0C7/VqvZCqQAWDUfwM2Df3aZTqTwVahQ5uTxGG+EZWAUk4RvR1MU
         XvnStNt/sPDu2Kj6f6+zGm3xasFbVF5HLf29xO8Bb5rflFTqmll9gms/CSS2ABxOFC2p
         oYg/LCNxVz0OupkbNQhaKgX1R1E4KprS364dv+SmIE316sHGbhoV+x1gFTxiQ7dnvJba
         uevSOoJJJpteYeAlKAiPLX3k6E8E/yQhqXX3tMdIZuo7iSjiBH2HU4sl/v6vUXC5WY6x
         cxMw==
X-Gm-Message-State: AOJu0YxbNt+HsQThF4HAQMASZnMA06YzDHR94X5Sr617FxEG+CCAi/JJ
        YXE3MxEzfbuOD2dintwiw7ygfA==
X-Google-Smtp-Source: AGHT+IGTm05O9v2E1cq+E8lJ8Jpivdic35bUYowvO5HvMrEl/Jo2UXoyEa/sR/oNhyotFRmAjKAFmg==
X-Received: by 2002:a17:902:e744:b0:1c0:bf60:ba82 with SMTP id p4-20020a170902e74400b001c0bf60ba82mr10598686plf.5.1695038873293;
        Mon, 18 Sep 2023 05:07:53 -0700 (PDT)
Received: from [10.84.155.178] ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id y7-20020a17090322c700b001c0a414695dsm8161538plg.62.2023.09.18.05.07.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 05:07:52 -0700 (PDT)
Message-ID: <529bce6f-e23b-4b84-a7e6-cce3c12645aa@bytedance.com>
Date:   Mon, 18 Sep 2023 20:06:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v6 01/45] mm: shrinker: add infrastructure for dynamically
 allocating shrinker
Content-Language: en-US
To:     Muchun Song <muchun.song@linux.dev>, akpm@linux-foundation.org
Cc:     Qi Zheng <zhengqi.arch@bytedance.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org
References: <20230911094444.68966-1-zhengqi.arch@bytedance.com>
 <20230911094444.68966-2-zhengqi.arch@bytedance.com>
 <4aff0e17-b40f-406d-65fd-72a2bacfcc1a@linux.dev>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <4aff0e17-b40f-406d-65fd-72a2bacfcc1a@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/9/18 17:03, Muchun Song wrote:
> 
> 

...

>> @@ -95,6 +97,11 @@ struct shrinker {
>>    * non-MEMCG_AWARE shrinker should not have this flag set.
>>    */
>>   #define SHRINKER_NONSLAB    (1 << 3)
>> +#define SHRINKER_ALLOCATED    (1 << 4)
> 
> It is better to add a comment here to tell users
> it is only used by internals of shrinker. The users
> are not supposed to pass this flag to shrink APIs.

OK, will annotate SHRINKER_REGISTERED and SHRINKER_ALLOCATED
as flags used internally.

> 
>> +
>> +struct shrinker *shrinker_alloc(unsigned int flags, const char *fmt, 
>> ...);
>> +void shrinker_register(struct shrinker *shrinker);
>> +void shrinker_free(struct shrinker *shrinker);
>>   extern int __printf(2, 3) prealloc_shrinker(struct shrinker *shrinker,
>>                           const char *fmt, ...);
>> diff --git a/mm/internal.h b/mm/internal.h
>> index 0471d6326d01..5587cae20ebf 100644
>> --- a/mm/internal.h
>> +++ b/mm/internal.h
>> @@ -1161,6 +1161,9 @@ unsigned long shrink_slab(gfp_t gfp_mask, int 
>> nid, struct mem_cgroup *memcg,
>>   #ifdef CONFIG_SHRINKER_DEBUG
>>   extern int shrinker_debugfs_add(struct shrinker *shrinker);
>> +extern int shrinker_debugfs_name_alloc(struct shrinker *shrinker,
>> +                       const char *fmt, va_list ap);
>> +extern void shrinker_debugfs_name_free(struct shrinker *shrinker);
>>   extern struct dentry *shrinker_debugfs_detach(struct shrinker 
>> *shrinker,
>>                             int *debugfs_id);
>>   extern void shrinker_debugfs_remove(struct dentry *debugfs_entry,
>> @@ -1170,6 +1173,14 @@ static inline int shrinker_debugfs_add(struct 
>> shrinker *shrinker)
>>   {
>>       return 0;
>>   }
>> +static inline int shrinker_debugfs_name_alloc(struct shrinker *shrinker,
>> +                          const char *fmt, va_list ap)
>> +{
>> +    return 0;
>> +}
>> +static inline void shrinker_debugfs_name_free(struct shrinker *shrinker)
>> +{
>> +}
>>   static inline struct dentry *shrinker_debugfs_detach(struct shrinker 
>> *shrinker,
>>                                int *debugfs_id)
>>   {
>> diff --git a/mm/shrinker.c b/mm/shrinker.c
>> index a16cd448b924..201211a67827 100644
>> --- a/mm/shrinker.c
>> +++ b/mm/shrinker.c
>> @@ -550,6 +550,108 @@ unsigned long shrink_slab(gfp_t gfp_mask, int 
>> nid, struct mem_cgroup *memcg,
>>       return freed;
>>   }
>> +struct shrinker *shrinker_alloc(unsigned int flags, const char *fmt, 
>> ...)
>> +{
>> +    struct shrinker *shrinker;
>> +    unsigned int size;
>> +    va_list ap;
>> +    int err;
>> +
>> +    shrinker = kzalloc(sizeof(struct shrinker), GFP_KERNEL);
>> +    if (!shrinker)
>> +        return NULL;
>> +
>> +    va_start(ap, fmt);
>> +    err = shrinker_debugfs_name_alloc(shrinker, fmt, ap);
>> +    va_end(ap);
>> +    if (err)
>> +        goto err_name;
>> +
>> +    shrinker->flags = flags | SHRINKER_ALLOCATED;
>> +    shrinker->seeks = DEFAULT_SEEKS;
>> +
>> +    if (flags & SHRINKER_MEMCG_AWARE) {
>> +        err = prealloc_memcg_shrinker(shrinker);
>> +        if (err == -ENOSYS)
>> +            shrinker->flags &= ~SHRINKER_MEMCG_AWARE;
>> +        else if (err == 0)
>> +            goto done;
>> +        else
>> +            goto err_flags;
> 
> Actually, the code here is a little confusing me when I fist look
> at it. I think there could be some improvements here. Something
> like:
> 
>          if (flags & SHRINKER_MEMCG_AWARE) {
>                  err = prealloc_memcg_shrinker(shrinker);
>                  if (err == -ENOSYS) {
>                          /* Memcg is not supported and fallback to 
> non-memcg-aware shrinker. */
>                          shrinker->flags &= ~SHRINKER_MEMCG_AWARE;
>                          goto non-memcg;
>                  }
> 
>                  if (err)
>                      goto err_flags;
>                  return shrinker;
>          }
> 
> non-memcg:
>          [...]
>          return shrinker;
> 
> In this case, the code becomes more clear (at least for me). We have 
> split the
> code into two part, one is handling memcg-aware case, another is 
> non-memcg-aware
> case. Any side will have a explicit "return" keyword to return once 
> succeeds.
> It is a little implicit that the previous one uses "goto done".
> 
> And the tag of "non-memcg" is also a good annotation to tell us the 
> following
> code handles non-memcg-aware case.

Make sense, will do.

> 
>> +    }
>> +
>> +    /*
>> +     * The nr_deferred is available on per memcg level for memcg aware
>> +     * shrinkers, so only allocate nr_deferred in the following cases:
>> +     *  - non memcg aware shrinkers
>> +     *  - !CONFIG_MEMCG
>> +     *  - memcg is disabled by kernel command line
>> +     */
>> +    size = sizeof(*shrinker->nr_deferred);
>> +    if (flags & SHRINKER_NUMA_AWARE)
>> +        size *= nr_node_ids;
>> +
>> +    shrinker->nr_deferred = kzalloc(size, GFP_KERNEL);
>> +    if (!shrinker->nr_deferred)
>> +        goto err_flags;
>> +
>> +done:
>> +    return shrinker;
>> +
>> +err_flags:
>> +    shrinker_debugfs_name_free(shrinker);
>> +err_name:
>> +    kfree(shrinker);
>> +    return NULL;
>> +}
>> +EXPORT_SYMBOL_GPL(shrinker_alloc);
>> +
>> +void shrinker_register(struct shrinker *shrinker)
>> +{
>> +    if (unlikely(!(shrinker->flags & SHRINKER_ALLOCATED))) {
>> +        pr_warn("Must use shrinker_alloc() to dynamically allocate 
>> the shrinker");
>> +        return;
>> +    }
>> +
>> +    down_write(&shrinker_rwsem);
>> +    list_add_tail(&shrinker->list, &shrinker_list);
>> +    shrinker->flags |= SHRINKER_REGISTERED;
>> +    shrinker_debugfs_add(shrinker);
>> +    up_write(&shrinker_rwsem);
>> +}
>> +EXPORT_SYMBOL_GPL(shrinker_register);
>> +
>> +void shrinker_free(struct shrinker *shrinker)
>> +{
>> +    struct dentry *debugfs_entry = NULL;
>> +    int debugfs_id;
>> +
>> +    if (!shrinker)
>> +        return;
>> +
>> +    down_write(&shrinker_rwsem);
>> +    if (shrinker->flags & SHRINKER_REGISTERED) {
>> +        list_del(&shrinker->list);
>> +        debugfs_entry = shrinker_debugfs_detach(shrinker, &debugfs_id);
>> +        shrinker->flags &= ~SHRINKER_REGISTERED;
>> +    } else {
>> +        shrinker_debugfs_name_free(shrinker);
> 
> We could remove shrinker_debugfs_name_free() calling from
> shrinker_debugfs_detach(), then we could call
> shrinker_debugfs_name_free() anyway, otherwise, it it a little
> weird for me. And the srinker name is allocated from shrinker_alloc(),
> so I think it it reasonable for shrinker_free() to free the
> shrinker name.

OK, will do.

> 
> Thanks.
> 
>> +    }
>> +
>> +    if (shrinker->flags & SHRINKER_MEMCG_AWARE)
>> +        unregister_memcg_shrinker(shrinker);
>> +    up_write(&shrinker_rwsem);
>> +
>> +    if (debugfs_entry)
>> +        shrinker_debugfs_remove(debugfs_entry, debugfs_id);
>> +
>> +    kfree(shrinker->nr_deferred);
>> +    shrinker->nr_deferred = NULL;
>> +
>> +    kfree(shrinker);
>> +}
>> +EXPORT_SYMBOL_GPL(shrinker_free);
>> +
>>   /*
>>    * Add a shrinker callback to be called from the vm.
>>    */
>> diff --git a/mm/shrinker_debug.c b/mm/shrinker_debug.c
>> index e4ce509f619e..38452f539f40 100644
>> --- a/mm/shrinker_debug.c
>> +++ b/mm/shrinker_debug.c
>> @@ -193,6 +193,20 @@ int shrinker_debugfs_add(struct shrinker *shrinker)
>>       return 0;
>>   }
>> +int shrinker_debugfs_name_alloc(struct shrinker *shrinker, const char 
>> *fmt,
>> +                va_list ap)
>> +{
>> +    shrinker->name = kvasprintf_const(GFP_KERNEL, fmt, ap);
>> +
>> +    return shrinker->name ? 0 : -ENOMEM;
>> +}
>> +
>> +void shrinker_debugfs_name_free(struct shrinker *shrinker)
>> +{
>> +    kfree_const(shrinker->name);
>> +    shrinker->name = NULL;
>> +}
> 
> It it better to move both helpers to internal.h and mark them as inline
> since both are very simple enough.

OK, will do.

Hi Andrew, below is the cleanup patch, which has a small conflict
with [PATCH v6 41/45]:

 From 5bc2b77484f5cd4616e510158f91c8877bd033ad Mon Sep 17 00:00:00 2001
From: Qi Zheng <zhengqi.arch@bytedance.com>
Date: Mon, 18 Sep 2023 10:41:15 +0000
Subject: [PATCH] mm: shrinker: some cleanup

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
  include/linux/shrinker.h | 14 ++++++++------
  mm/internal.h            | 17 ++++++++++++++---
  mm/shrinker.c            | 20 ++++++++++++--------
  mm/shrinker_debug.c      | 16 ----------------
  4 files changed, 34 insertions(+), 33 deletions(-)

diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
index 3f3fd9974ce5..f4a5249f00b2 100644
--- a/include/linux/shrinker.h
+++ b/include/linux/shrinker.h
@@ -88,16 +88,18 @@ struct shrinker {
  };
  #define DEFAULT_SEEKS 2 /* A good number if you don't know better. */

-/* Flags */
-#define SHRINKER_REGISTERED	(1 << 0)
-#define SHRINKER_NUMA_AWARE	(1 << 1)
-#define SHRINKER_MEMCG_AWARE	(1 << 2)
+/* Internal flags */
+#define SHRINKER_REGISTERED	BIT(0)
+#define SHRINKER_ALLOCATED	BIT(1)
+
+/* Flags for users to use */
+#define SHRINKER_NUMA_AWARE	BIT(2)
+#define SHRINKER_MEMCG_AWARE	BIT(3)
  /*
   * It just makes sense when the shrinker is also MEMCG_AWARE for now,
   * non-MEMCG_AWARE shrinker should not have this flag set.
   */
-#define SHRINKER_NONSLAB	(1 << 3)
-#define SHRINKER_ALLOCATED	(1 << 4)
+#define SHRINKER_NONSLAB	BIT(4)

  struct shrinker *shrinker_alloc(unsigned int flags, const char *fmt, ...);
  void shrinker_register(struct shrinker *shrinker);
diff --git a/mm/internal.h b/mm/internal.h
index b9a116dce28e..0f418a11c7a8 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1161,10 +1161,21 @@ unsigned long shrink_slab(gfp_t gfp_mask, int 
nid, struct mem_cgroup *memcg,
  			  int priority);

  #ifdef CONFIG_SHRINKER_DEBUG
+static inline int shrinker_debugfs_name_alloc(struct shrinker *shrinker,
+					      const char *fmt, va_list ap)
+{
+	shrinker->name = kvasprintf_const(GFP_KERNEL, fmt, ap);
+
+	return shrinker->name ? 0 : -ENOMEM;
+}
+
+static inline void shrinker_debugfs_name_free(struct shrinker *shrinker)
+{
+	kfree_const(shrinker->name);
+	shrinker->name = NULL;
+}
+
  extern int shrinker_debugfs_add(struct shrinker *shrinker);
-extern int shrinker_debugfs_name_alloc(struct shrinker *shrinker,
-				       const char *fmt, va_list ap);
-extern void shrinker_debugfs_name_free(struct shrinker *shrinker);
  extern struct dentry *shrinker_debugfs_detach(struct shrinker *shrinker,
  					      int *debugfs_id);
  extern void shrinker_debugfs_remove(struct dentry *debugfs_entry,
diff --git a/mm/shrinker.c b/mm/shrinker.c
index 201211a67827..d1032a4d5684 100644
--- a/mm/shrinker.c
+++ b/mm/shrinker.c
@@ -572,18 +572,23 @@ struct shrinker *shrinker_alloc(unsigned int 
flags, const char *fmt, ...)

  	if (flags & SHRINKER_MEMCG_AWARE) {
  		err = prealloc_memcg_shrinker(shrinker);
-		if (err == -ENOSYS)
+		if (err == -ENOSYS) {
+			/* Memcg is not supported, fallback to non-memcg-aware shrinker. */
  			shrinker->flags &= ~SHRINKER_MEMCG_AWARE;
-		else if (err == 0)
-			goto done;
-		else
+			goto non_memcg;
+		}
+
+		if (err)
  			goto err_flags;
+
+		return shrinker;
  	}

+non_memcg:
  	/*
  	 * The nr_deferred is available on per memcg level for memcg aware
  	 * shrinkers, so only allocate nr_deferred in the following cases:
-	 *  - non memcg aware shrinkers
+	 *  - non-memcg-aware shrinkers
  	 *  - !CONFIG_MEMCG
  	 *  - memcg is disabled by kernel command line
  	 */
@@ -595,7 +600,6 @@ struct shrinker *shrinker_alloc(unsigned int flags, 
const char *fmt, ...)
  	if (!shrinker->nr_deferred)
  		goto err_flags;

-done:
  	return shrinker;

  err_flags:
@@ -634,10 +638,10 @@ void shrinker_free(struct shrinker *shrinker)
  		list_del(&shrinker->list);
  		debugfs_entry = shrinker_debugfs_detach(shrinker, &debugfs_id);
  		shrinker->flags &= ~SHRINKER_REGISTERED;
-	} else {
-		shrinker_debugfs_name_free(shrinker);
  	}

+	shrinker_debugfs_name_free(shrinker);
+
  	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
  		unregister_memcg_shrinker(shrinker);
  	up_write(&shrinker_rwsem);
diff --git a/mm/shrinker_debug.c b/mm/shrinker_debug.c
index 38452f539f40..24aebe7c24cc 100644
--- a/mm/shrinker_debug.c
+++ b/mm/shrinker_debug.c
@@ -193,20 +193,6 @@ int shrinker_debugfs_add(struct shrinker *shrinker)
  	return 0;
  }

-int shrinker_debugfs_name_alloc(struct shrinker *shrinker, const char *fmt,
-				va_list ap)
-{
-	shrinker->name = kvasprintf_const(GFP_KERNEL, fmt, ap);
-
-	return shrinker->name ? 0 : -ENOMEM;
-}
-
-void shrinker_debugfs_name_free(struct shrinker *shrinker)
-{
-	kfree_const(shrinker->name);
-	shrinker->name = NULL;
-}
-
  int shrinker_debugfs_rename(struct shrinker *shrinker, const char 
*fmt, ...)
  {
  	struct dentry *entry;
@@ -255,8 +241,6 @@ struct dentry *shrinker_debugfs_detach(struct 
shrinker *shrinker,

  	lockdep_assert_held(&shrinker_rwsem);

-	shrinker_debugfs_name_free(shrinker);
-
  	*debugfs_id = entry ? shrinker->debugfs_id : -1;
  	shrinker->debugfs_entry = NULL;

--
2.30.2

> 
> Thanks.
> 
>> +
>>   int shrinker_debugfs_rename(struct shrinker *shrinker, const char 
>> *fmt, ...)
>>   {
>>       struct dentry *entry;
>> @@ -241,8 +255,7 @@ struct dentry *shrinker_debugfs_detach(struct 
>> shrinker *shrinker,
>>       lockdep_assert_held(&shrinker_rwsem);
>> -    kfree_const(shrinker->name);
>> -    shrinker->name = NULL;
>> +    shrinker_debugfs_name_free(shrinker);
>>       *debugfs_id = entry ? shrinker->debugfs_id : -1;
>>       shrinker->debugfs_entry = NULL;
> 
