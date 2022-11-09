Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF9A622759
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Nov 2022 10:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbiKIJnn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Nov 2022 04:43:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiKIJnm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Nov 2022 04:43:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A6011468
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Nov 2022 01:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667986966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3k4TxBqmNoHo3xG4obIRqkSktK8qyaCub3q4JLx4HAw=;
        b=U0p9AlnYqjtaQ6tLiCHBoElrMvPBVFPEONfge3I/7m+UOu231dIq0j865fDR4lnyZngAkS
        HLRMTZZzJnlZd34FaWJ/5Ioi+X6HBtff7dctVGRwi0DnxO5I9IbAD8SUSFbqySFo2xHVGi
        2UC3TYxp+h/qj5NP6Oy1Pv0AmpKKhDw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-433-yE3I9mc3Np6jde4toq53uw-1; Wed, 09 Nov 2022 04:42:03 -0500
X-MC-Unique: yE3I9mc3Np6jde4toq53uw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9A24A1C09041;
        Wed,  9 Nov 2022 09:42:02 +0000 (UTC)
Received: from fedora (ovpn-193-254.brq.redhat.com [10.40.193.254])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 79AB0112131B;
        Wed,  9 Nov 2022 09:42:01 +0000 (UTC)
Date:   Wed, 9 Nov 2022 10:41:58 +0100
From:   Lukas Czerner <lczerner@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.com>,
        Eric Sandeen <sandeen@redhat.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/2] [RFC] shmem: user and group quota support for tmpfs
Message-ID: <20221109094158.c2mubinj7g66iw6e@fedora>
References: <20221108133010.75226-1-lczerner@redhat.com>
 <20221108174326.hkgtrt72rpkmelyq@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221108174326.hkgtrt72rpkmelyq@quack3>
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

On Tue, Nov 08, 2022 at 06:43:26PM +0100, Jan Kara wrote:
> On Tue 08-11-22 14:30:08, Lukas Czerner wrote:
> > people have been asking for quota support in tmpfs many times in the past
> > mostly to avoid one malicious user, or misbehaving user/program to consume
> > all of the system memory. This has been partially solved with the size
> > mount option, but some problems still prevail.
> > 
> > One of the problems is the fact that /dev/shm is still generally unprotected
> > with this and another is administration overhead of managing multiple tmpfs
> > mounts and lack of more fine grained control.
> > 
> > Quota support can solve all these problems in a somewhat standard way
> > people are already familiar with from regular file systems. It can give us
> > more fine grained control over how much memory user/groups can consume.
> > Additionally it can also control number of inodes and with special quota
> > mount options introduced with a second patch we can set global limits
> > allowing us to replace the size mount option with quota entirely.
> > 
> > Currently the standard userspace quota tools (quota, xfs_quota) are only
> > using quotactl ioctl which is expecting a block device. I patched quota [1]
> > and xfs_quota [2] to use quotactl_fd in case we want to run the tools on
> > mount point directory to work nicely with tmpfs.
> > 
> > The implementation was tested on patched version of xfstests [3].
> > 
> > Thoughts?
> 
> Thanks for the work Lukas! I have one general note regarding this quota
> support: IMO it is pointless to try to retrofit how quota files work on
> block-based filesystems to tmpfs. All the bothering with converting between
> on-disk and in-mem representation, formatting of btree nodes is just
> pointless waste of CPU and code.

Hi Jan,

you're right and I did have some thoughts along the same lines. I wasn't
sure how the idea of quota on tmpfs is going to be received and so I
wanted to limit the scope of changes and make my job easier.
It works well as a proof-of-concept but I agree that storing quota data
in some in-memory representation is an ultimate way to go for tmpfs.

> 
> I think much simpler approach would be to keep some internal rbtree with
> quota structures carrying struct mem_dqblk and id. Then your .acquire_dquot
> handler will fill in quota information from the structure and
> .release_dquot will copy new data into the structure.
> 
> So basically all operations you'd need to provide in your implementation
> are .acquire_dquot, .release_dquot, and .get_next_id. And then you'll
> probably need to define new quota format with .read_file_info callback
> filling in some limits of the format (and some other stub callbacks doing
> nothing). If there's too much boilerplate code doing nothing, we can have a
> look into making quota core more clever to make life simpler for in-memory
> filesystems (hidden behind something like DQUOT_QUOTA_IN_MEMORY flag in
> struct quota_info) but currently I don't think it will be too bad.

Thanks for the insight and suggestions. I'll see what I can do with this
and prepare v2.

Thanks!
-Lukas

> 
> 								Honza
> 
> > [1] https://github.com/lczerner/quota/tree/quotactl_fd_support
> > [2] https://github.com/lczerner/xfsprogs/tree/quotactl_fd_support
> > [3] https://github.com/lczerner/xfstests/tree/tmpfs_quota_support
> > 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
> 

