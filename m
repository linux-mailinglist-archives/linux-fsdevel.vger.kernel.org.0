Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD18D76D878
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 22:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjHBURB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 16:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjHBURA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 16:17:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B4CE46
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Aug 2023 13:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691007375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0XIGrFGP7J2HGVDS8S1Cuzs5GSwXNIGvY43RGd9K/2A=;
        b=CgR7zEnLP2Oepx+D64NLGgKHYWKWIQlUTHAI4fS6NVVt0lX9LvwdInZ2AG4fJfh2MlnpX9
        MuisS8yCCjWLAa8P40TWye6t4XX6AA0A64KbqLSUrUovd1d4T8MhAde5xDypsdNMNvkGVN
        E772Ui+s94Xdq+YhHxkVVy8evtIz2JE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-224-9AZaV10IMy2zzJtrak0OJw-1; Wed, 02 Aug 2023 16:16:13 -0400
X-MC-Unique: 9AZaV10IMy2zzJtrak0OJw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5BA28185A792;
        Wed,  2 Aug 2023 20:16:13 +0000 (UTC)
Received: from [10.22.18.41] (unknown [10.22.18.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0C10E200A7CA;
        Wed,  2 Aug 2023 20:16:13 +0000 (UTC)
Message-ID: <bb77f456-8804-b63a-7868-19e0cd9e697f@redhat.com>
Date:   Wed, 2 Aug 2023 16:16:12 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 11/20] locking/osq: Export osq_(lock|unlock)
Content-Language: en-US
To:     Kent Overstreet <kent.overstreet@linux.dev>,
        linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
References: <20230712211115.2174650-1-kent.overstreet@linux.dev>
 <20230712211115.2174650-12-kent.overstreet@linux.dev>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230712211115.2174650-12-kent.overstreet@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/12/23 17:11, Kent Overstreet wrote:
> These are used by bcachefs's six locks.
>
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> ---
>   kernel/locking/osq_lock.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
> index d5610ad52b..b752ec5cc6 100644
> --- a/kernel/locking/osq_lock.c
> +++ b/kernel/locking/osq_lock.c
> @@ -203,6 +203,7 @@ bool osq_lock(struct optimistic_spin_queue *lock)
>   
>   	return false;
>   }
> +EXPORT_SYMBOL_GPL(osq_lock);
>   
>   void osq_unlock(struct optimistic_spin_queue *lock)
>   {
> @@ -230,3 +231,4 @@ void osq_unlock(struct optimistic_spin_queue *lock)
>   	if (next)
>   		WRITE_ONCE(next->locked, 1);
>   }
> +EXPORT_SYMBOL_GPL(osq_unlock);

Have you considered extending the current rw_semaphore to support a SIX 
lock semantics? There are a number of instances in the kernel that a 
up_read() is followed by a down_write(). Basically, the code try to 
upgrade the lock from read to write. I have been thinking about adding a 
upgrade_read() API to do that. However, the concern that I had was that 
another writer may come in and make modification before the reader can 
be upgraded to have exclusive write access and will make the task to 
repeat what has been done in the read lock part. By adding a read with 
intent to upgrade to write, we can have that guarantee.

With that said, I would prefer to keep osq_{lock/unlock} for internal 
use by some higher level locking primitives - mutex, rwsem and rt_mutex.

Cheers,
Longman

