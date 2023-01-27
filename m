Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E05B67EDE6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jan 2023 19:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233903AbjA0S5U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Jan 2023 13:57:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjA0S5T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Jan 2023 13:57:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACAA1BEA
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Jan 2023 10:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674845791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eJGKJEleR9o/IxmSmYsL3dGb9IEIEnukTgdURz3fSls=;
        b=fyN7Y602bPEWgkBL2ncmzDuNDHVXjOhpdPqEsUu+zgRoLnxXHmy0rsLLdgakT39cUan5Aq
        7YAWXmlGZOvy38PvzGQud2DqFfncmJFpRHjRnfN4zzEqE4VBqsU9h3ZeUs+g2UOKNDOIo/
        UNYZiLF6NYCyqblfOBhPft0kL2inA3w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-489-aG_z81QsOka_4PNufwieVw-1; Fri, 27 Jan 2023 13:56:30 -0500
X-MC-Unique: aG_z81QsOka_4PNufwieVw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 846EB886469;
        Fri, 27 Jan 2023 18:56:29 +0000 (UTC)
Received: from localhost (unknown [10.39.192.73])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 394C81121314;
        Fri, 27 Jan 2023 18:56:29 +0000 (UTC)
From:   Giuseppe Scrivano <gscrivan@redhat.com>
To:     Rik van Riel <riel@surriel.com>
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] ipc,namespace: fix free vs allocation race
In-Reply-To: <20230127184651.3681682-1-riel@surriel.com> (Rik van Riel's
        message of "Fri, 27 Jan 2023 13:46:49 -0500")
References: <20230127184651.3681682-1-riel@surriel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date:   Fri, 27 Jan 2023 19:56:27 +0100
Message-ID: <87wn57lsbo.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Rik van Riel <riel@surriel.com> writes:

> The IPC namespace code frees ipc_namespace structures asynchronously,
> via a work queue item. This results in ipc_namespace structures being
> freed very slowly, and the allocation path getting false failures
> since the to-be-freed ipc_namespace structures have not been freed
> yet.
>
> Fix that by having the allocator wait when there are ipc_namespace
> structures pending to be freed.
>
> Also speed up the freeing of ipc_namespace structures. We had some
> discussions about this last year, and ended up trying out various
> "nicer" ideas that did not work, so I went back to the original,
> with Al Viro's suggestion for a helper function:
>
> https://lore.kernel.org/all/Yg8StKzTWh+7FLuA@zeniv-ca.linux.org.uk/
>
> This series fixes both the false allocation failures, and the slow
> freeing of ipc_namespace structures.
>
> v3: remove mq_put_mnt (thank you Giuseppe)
> v2: a few more fs/namespace.c cleanups suggested by Al Viro (thank you!)

Tested-by: Giuseppe Scrivano <gscrivan@redhat.com>

