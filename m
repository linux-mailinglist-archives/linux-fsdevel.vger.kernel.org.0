Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 138B5524FE0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 May 2022 16:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355235AbiELOWF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 May 2022 10:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355233AbiELOV7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 May 2022 10:21:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 093479B1BB
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 May 2022 07:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652365316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5yJtUKdXkDMbnvk5HEGITGVzXpG3gpDD591nQreQoMA=;
        b=F75T8bb3wtC//IEOay2VLGy7gSExflI4MHlRbqWOf2smKqhqmY1EWAeQkcSew94AXqRkQt
        p6vV1IjwNxuiJDR5qu8dr0vSDPJnxQSQrKEVWVKEF2Mm08QFa70eQfcU8pRNifjfhYxKaL
        tzY2lOCQjcQJt26MDA+zbFhirdt5U5Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-481-Byl6XbfQOd6FttKRZhSoIw-1; Thu, 12 May 2022 10:21:55 -0400
X-MC-Unique: Byl6XbfQOd6FttKRZhSoIw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 71B4B10DD0A8;
        Thu, 12 May 2022 14:21:33 +0000 (UTC)
Received: from rh (vpn2-54-35.bne.redhat.com [10.64.54.35])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A8C4574519;
        Thu, 12 May 2022 14:21:33 +0000 (UTC)
Received: from localhost ([::1] helo=rh)
        by rh with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <dchinner@redhat.com>)
        id 1np9h4-0035Ws-D8; Fri, 13 May 2022 00:21:30 +1000
Date:   Fri, 13 May 2022 00:21:28 +1000
From:   Dave Chinner <dchinner@redhat.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org,
        idryomov@gmail.com, xiubli@redhat.com,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2] fs: change test in inode_insert5 for adding to the sb
 list
Message-ID: <Yn0X6FyrosBlGnMq@rh>
References: <20220511165339.85614-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511165339.85614-1-jlayton@kernel.org>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 11, 2022 at 12:53:39PM -0400, Jeff Layton wrote:
> The inode_insert5 currently looks at I_CREATING to decide whether to
> insert the inode into the sb list. This test is a bit ambiguous though
> as I_CREATING state is not directly related to that list.
> 
> This test is also problematic for some upcoming ceph changes to add
> fscrypt support. We need to be able to allocate an inode using new_inode
> and insert it into the hash later if we end up using it, and doing that
> now means that we double add it and corrupt the list.
> 
> What we really want to know in this test is whether the inode is already
> in its superblock list, and then add it if it isn't. Have it test for
> list_empty instead and ensure that we always initialize the list by
> doing it in inode_init_once. It's only ever removed from the list with
> list_del_init, so that should be sufficient.
> 
> There doesn't seem to be any need to hold the inode_hash_lock for this
> operation either, so drop that before adding to to the list.
> 
> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Dave Chinner <dchinner@redhat.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> ---
>  fs/inode.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> A small revision to the patch that I sent as part of the ceph+fscrypt
> series. I didn't see any need to hold the inode_hash_lock when adding
> the inode to the sb list, so do that outside the lock. I also revised
> the comment to be more clear.

I'm not sure that's valid. The moment the hash lock is dropped,
other lookups can find this inode in the cache. Hence there's no
guarantee that someone else isn't already accessing the inode
once the hash lock is dropped. Hence it's not clear to me that this
is a safe modification to make.

Given that we already do the list add under the hash lock, I don't
see any real gain to removing it from that context and it isn't
necessary to address the problem.

If you are concerned about reducing inode_has_lock contention, then
the answer to that is to convert the global lock to bit list locks
as the dentry cache uses. I wrote a patch a while back to do this:

https://lore.kernel.org/linux-fsdevel/20210406123343.1739669-1-david@fromorbit.com/

Hence at this stage, I prefer the original version that doesn't
change locking because there's much less risk associated with it.

Cheers,

DAve.
-- 
Dave Chinner
dchinner@redhat.com

