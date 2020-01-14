Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8CBF13B1E3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2020 19:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbgANSRz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jan 2020 13:17:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58464 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726491AbgANSRz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jan 2020 13:17:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579025873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hh3KavZEWvh09y9W/Fa2u/FR21ffnME+K80eDTgvZSQ=;
        b=abR1Fwn6q/zcUQpLlG5LqaC9f7JqYZJz/t3C/0iMNaV743Hw5xqIHmuk+6NFAAYH6BVp3V
        +QIIzwH1m9/rdClbZCIxFoi+LcobYXp4GjlvUsEMZhAaKZgU8htAykyJTPNP+vmX4pvnJS
        9UivZHGv9D+sl04bHn/qLlv+Rs48OaE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-Ybtb5NfzPF62aX4wm66bYg-1; Tue, 14 Jan 2020 13:17:50 -0500
X-MC-Unique: Ybtb5NfzPF62aX4wm66bYg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A0A7C801E6C;
        Tue, 14 Jan 2020 18:17:48 +0000 (UTC)
Received: from llong.remote.csb (ovpn-122-218.rdu2.redhat.com [10.10.122.218])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 06F4960BF4;
        Tue, 14 Jan 2020 18:17:44 +0000 (UTC)
Subject: Re: [PATCH 02/12] locking/rwsem: Exit early when held by an anonymous
 owner
To:     Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20200114161225.309792-1-hch@lst.de>
 <20200114161225.309792-3-hch@lst.de>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <925d1343-670e-8f92-0e73-6e9cee0d3ffb@redhat.com>
Date:   Tue, 14 Jan 2020 13:17:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200114161225.309792-3-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/14/20 11:12 AM, Christoph Hellwig wrote:
> The rwsem code overloads the owner field with either a task struct or
> negative magic numbers.  Add a quick hack to catch these negative
> values early on.  Without this spinning on a writer that replaced the
> owner with RWSEM_OWNER_UNKNOWN, rwsem_spin_on_owner can crash while
> deferencing the task_struct ->on_cpu field of a -8 value.
>
> XXX: This might be a bit of a hack as the code otherwise doesn't use
> the ERR_PTR family macros, better suggestions welcome.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  kernel/locking/rwsem.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
> index 44e68761f432..6adc719a30a1 100644
> --- a/kernel/locking/rwsem.c
> +++ b/kernel/locking/rwsem.c
> @@ -725,6 +725,8 @@ rwsem_spin_on_owner(struct rw_semaphore *sem, unsigned long nonspinnable)
>  	state = rwsem_owner_state(owner, flags, nonspinnable);
>  	if (state != OWNER_WRITER)
>  		return state;
> +	if (IS_ERR(owner))
> +		return state;
>  
>  	rcu_read_lock();
>  	for (;;) {

The owner field is just a pointer to the task structure with the lower 3
bits served as flag bits. Setting owner to RWSEM_OWNER_UNKNOWN (-2) will
stop optimistic spinning. So under what condition did the crash happen?

Anyway, PeterZ is working on revising the percpu-rwsem implementation to
more gracefully handle the frozen case. At the end, there will not be a
need for the RWSEM_OWNER_UNKNOWN magic and it can be removed.

Cheers,
Longman

RWSEM_OWNER_UNKNOWN

