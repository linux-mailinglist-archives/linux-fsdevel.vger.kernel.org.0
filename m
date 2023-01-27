Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF5F67E295
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jan 2023 12:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbjA0LEN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Jan 2023 06:04:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232859AbjA0LEH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Jan 2023 06:04:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E364213531
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Jan 2023 03:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674817399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AIZ7SsGXjE6pNoVmeoTEDKKHIzvEwSlrhJ+UulUtcL0=;
        b=Vt7PEbaZv0GxMtqvz7cltrtZHBsno6M5soA+NZE37tkLrhX+sNqT0D0+yuEFEKKrcFEtRP
        UHR/QCPB50q/wtdWjU1kRFzVV7t9gXEFl12LCru90luP9iCZF8V5NbHhtBprQVX7LMkrSC
        2bAUh71whgDA9Vq8qkA2eGuG8QBN6MA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-639-PzKHVq1YNea7yyn5UE_uYw-1; Fri, 27 Jan 2023 06:03:13 -0500
X-MC-Unique: PzKHVq1YNea7yyn5UE_uYw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 37585101A52E;
        Fri, 27 Jan 2023 11:03:13 +0000 (UTC)
Received: from localhost (unknown [10.39.194.132])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E2187492C1B;
        Fri, 27 Jan 2023 11:03:11 +0000 (UTC)
From:   Giuseppe Scrivano <gscrivan@redhat.com>
To:     Rik van Riel <riel@surriel.com>
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, linux-fsdevel@vger.kernel.org,
        Chris Mason <clm@meta.com>
Subject: Re: [PATCH 2/2] ipc,namespace: batch free ipc_namespace structures
References: <20230127011535.1265297-1-riel@surriel.com>
        <20230127011535.1265297-3-riel@surriel.com>
Date:   Fri, 27 Jan 2023 12:03:10 +0100
In-Reply-To: <20230127011535.1265297-3-riel@surriel.com> (Rik van Riel's
        message of "Thu, 26 Jan 2023 20:15:35 -0500")
Message-ID: <878rhome8h.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Rik van Riel <riel@surriel.com> writes:

> Instead of waiting for an RCU grace period between each ipc_namespace
> structure that is being freed, wait an RCU grace period for every batch
> of ipc_namespace structures.
>
> Thanks to Al Viro for the suggestion of the helper function.
>
> This speeds up the run time of the test case that allocates ipc_namespaces
> in a loop from 6 minutes, to a little over 1 second:
>
> real	0m1.192s
> user	0m0.038s
> sys	0m1.152s
>
> Signed-off-by: Rik van Riel <riel@surriel.com>
> Reported-by: Chris Mason <clm@meta.com>
> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/namespace.c        | 10 ++++++++++
>  include/linux/mount.h |  1 +
>  ipc/namespace.c       | 13 ++++++++++---
>  3 files changed, 21 insertions(+), 3 deletions(-)
>
> diff --git a/fs/namespace.c b/fs/namespace.c
> index ab467ee58341..296432ba3716 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -1397,6 +1397,16 @@ struct vfsmount *mntget(struct vfsmount *mnt)
>  }
>  EXPORT_SYMBOL(mntget);
>  
> +/*
> + * Make a mount point inaccessible to new lookups.
> + * Because there may still be current users, the caller MUST WAIT
> + * for an RCU grace period before destroying the mount point.
> + */
> +void mnt_make_shortterm(struct vfsmount *mnt)
> +{
> +	real_mount(mnt)->mnt_ns = NULL;
> +}
> +
>  /**
>   * path_is_mountpoint() - Check if path is a mount in the current namespace.
>   * @path: path to check
> diff --git a/include/linux/mount.h b/include/linux/mount.h
> index 62475996fac6..ec55a031aa8c 100644
> --- a/include/linux/mount.h
> +++ b/include/linux/mount.h
> @@ -88,6 +88,7 @@ extern void mnt_drop_write(struct vfsmount *mnt);
>  extern void mnt_drop_write_file(struct file *file);
>  extern void mntput(struct vfsmount *mnt);
>  extern struct vfsmount *mntget(struct vfsmount *mnt);
> +extern void mnt_make_shortterm(struct vfsmount *mnt);
>  extern struct vfsmount *mnt_clone_internal(const struct path *path);
>  extern bool __mnt_is_readonly(struct vfsmount *mnt);
>  extern bool mnt_may_suid(struct vfsmount *mnt);
> diff --git a/ipc/namespace.c b/ipc/namespace.c
> index a26860a41dac..6ecc30effd3e 100644
> --- a/ipc/namespace.c
> +++ b/ipc/namespace.c
> @@ -145,10 +145,11 @@ void free_ipcs(struct ipc_namespace *ns, struct ipc_ids *ids,
>  
>  static void free_ipc_ns(struct ipc_namespace *ns)
>  {
> -	/* mq_put_mnt() waits for a grace period as kern_unmount()
> -	 * uses synchronize_rcu().
> +	/*
> +	 * Caller needs to wait for an RCU grace period to have passed
> +	 * after making the mount point inaccessible to new accesses.
>  	 */
> -	mq_put_mnt(ns);

mq_put_mnt() is not needed anymore, should it be removed?

> +	mntput(ns->mq_mnt);
>  	sem_exit_ns(ns);
>  	msg_exit_ns(ns);
>  	shm_exit_ns(ns);
> @@ -168,6 +169,12 @@ static void free_ipc(struct work_struct *unused)
>  	struct llist_node *node = llist_del_all(&free_ipc_list);
>  	struct ipc_namespace *n, *t;
>  
> +	llist_for_each_entry_safe(n, t, node, mnt_llist)
> +		mnt_make_shortterm(n->mq_mnt);
> +
> +	/* Wait for any last users to have gone away. */
> +	synchronize_rcu();
> +
>  	llist_for_each_entry_safe(n, t, node, mnt_llist)
>  		free_ipc_ns(n);
>  }

