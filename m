Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA6A584DBA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Jul 2022 10:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234462AbiG2Iyp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Jul 2022 04:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbiG2Iyn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Jul 2022 04:54:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E3D5A83206
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Jul 2022 01:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659084882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IHI9txL3xcXBJhnn+nRJ6psIpAzN5VY5djmq3vxdXkM=;
        b=PUreQo38rWv+9iC6aA6KMC8uZqVS5mF9xHi+A0GnTOm7KD9qJTbQe+eNghDtaQiY9pq/Fw
        K7CbxB8BGeXnW7NE60gauNnJSEIFn4WopnZWX+G2vqxJg709ZixKh+2QQZyQsi6+33bg7f
        ibZjiXrtH89K38HxRTN/Xu2/W9+xfj8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-610-aVGpGE0iO6m0313Zxd-55Q-1; Fri, 29 Jul 2022 04:54:38 -0400
X-MC-Unique: aVGpGE0iO6m0313Zxd-55Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 298E51C05132;
        Fri, 29 Jul 2022 08:54:38 +0000 (UTC)
Received: from fedora (unknown [10.40.194.157])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3E11F2026D64;
        Fri, 29 Jul 2022 08:54:37 +0000 (UTC)
Date:   Fri, 29 Jul 2022 10:54:35 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-ext4@vger.kernel.org, jlayton@kernel.org, tytso@mit.edu,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] fs: record I_DIRTY_TIME even if inode already has
 I_DIRTY_INODE
Message-ID: <20220729085435.b5unegq5ilbtcywu@fedora>
References: <20220728133914.49890-1-lczerner@redhat.com>
 <20220728133914.49890-2-lczerner@redhat.com>
 <YuNcd7q6a33tqkAf@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuNcd7q6a33tqkAf@sol.localdomain>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 28, 2022 at 09:05:11PM -0700, Eric Biggers wrote:
> On Thu, Jul 28, 2022 at 03:39:14PM +0200, Lukas Czerner wrote:
> > Currently the I_DIRTY_TIME will never get set if the inode already has
> > I_DIRTY_INODE with assumption that it supersedes I_DIRTY_TIME.  That's
> > true, however ext4 will only update the on-disk inode in
> > ->dirty_inode(), not on actual writeback. As a result if the inode
> > already has I_DIRTY_INODE state by the time we get to
> > __mark_inode_dirty() only with I_DIRTY_TIME, the time was already filled
> > into on-disk inode and will not get updated until the next I_DIRTY_INODE
> > update, which might never come if we crash or get a power failure.
> > 
> > The problem can be reproduced on ext4 by running xfstest generic/622
> > with -o iversion mount option. Fix it by setting I_DIRTY_TIME even if
> > the inode already has I_DIRTY_INODE.
> > 
> > Also clear the I_DIRTY_TIME after ->dirty_inode() otherwise it may never
> > get cleared.
> > 
> > Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> 
> If you're going to change the meaning of I_* flags, please update the comment in
> include/linux/fs.h that describes what they mean.
> 
> - Eric

Good point, it does say that I_DIRTY_TIME and I_DIRTY_INODE can't be
both set.

Thanks!
-Lukas

