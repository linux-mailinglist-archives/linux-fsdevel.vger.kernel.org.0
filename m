Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D61751ADA7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 May 2022 21:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376857AbiEDTWf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 May 2022 15:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356002AbiEDTWe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 May 2022 15:22:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B248B289A5
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 May 2022 12:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651691936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZwSljj3c5T6Utkzz17OaX0BViEESRn+BH5N5ceRLoVg=;
        b=FexlnEssIAWDbxMIb8t3GSbRA7HoAucWtBzf8Rl6TRIFgW3tKVeon1kWYu3ZgoFPRl4hgI
        ECznpE9OtJpH/PuyLlg29f0nWiRWqgkh73I3V+ViDXeU4AaSPv6yq/0UtrBWj16KwWq8r9
        w3ItsPNBXesKpQ/MEZzzxboZuDKz2Mc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-607-bsMMlQ16PiqoSZ-tI920Ng-1; Wed, 04 May 2022 15:18:53 -0400
X-MC-Unique: bsMMlQ16PiqoSZ-tI920Ng-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 72B83101AA47;
        Wed,  4 May 2022 19:18:53 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.16.200])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 63326400E896;
        Wed,  4 May 2022 19:18:53 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 21F9D220463; Wed,  4 May 2022 15:18:53 -0400 (EDT)
Date:   Wed, 4 May 2022 15:18:53 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Dharmendra Singh <dharamhans87@gmail.com>
Cc:     miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        fuse-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        bschubert@ddn.com
Subject: Re: [PATCH v4 0/3] FUSE: Implement atomic lookup + open/create
Message-ID: <YnLRnR3Xqu0cYPdb@redhat.com>
References: <20220502102521.22875-1-dharamhans87@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220502102521.22875-1-dharamhans87@gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 02, 2022 at 03:55:18PM +0530, Dharmendra Singh wrote:
> In FUSE, as of now, uncached lookups are expensive over the wire.
> E.g additional latencies and stressing (meta data) servers from
> thousands of clients. These lookup calls possibly can be avoided
> in some cases. Incoming three patches address this issue.

BTW, these patches are designed to improve performance by cutting down
on number of fuse commands sent. Are there any performance numbers
which demonstrate what kind of improvement you are seeing.

Say, If I do kernel build, is the performance improvement observable?

Thanks
Vivek

> 
> 
> Fist patch handles the case where we are creating a file with O_CREAT.
> Before we go for file creation, we do a lookup on the file which is most
> likely non-existent. After this lookup is done, we again go into libfuse
> to create file. Such lookups where file is most likely non-existent, can
> be avoided.
> 
> Second patch handles the case where we open first time a file/dir
> but do a lookup first on it. After lookup is performed we make another
> call into libfuse to open the file. Now these two separate calls into
> libfuse can be combined and performed as a single call into libfuse.
> 
> Third patch handles the case when we are opening an already existing file
> (positive dentry). Before this open call, we re-validate the inode and
> this re-validation does a lookup on the file and verify the inode.
> This separate lookup also can be avoided (for non-dir) and combined
> with open call into libfuse. After open returns we can revalidate the inode.
> This optimisation is performed only when we do not have default permissions
> enabled.
> 
> Here is the link to performance numbers
> https://lore.kernel.org/linux-fsdevel/20220322121212.5087-1-dharamhans87@gmail.com/
> 
> 
> Dharmendra Singh (3):
>   FUSE: Implement atomic lookup + create
>   Implement atomic lookup + open
>   Avoid lookup in d_revalidate()
> 
>  fs/fuse/dir.c             | 211 +++++++++++++++++++++++++++++++++++---
>  fs/fuse/file.c            |  30 +++++-
>  fs/fuse/fuse_i.h          |  16 ++-
>  fs/fuse/inode.c           |   4 +-
>  fs/fuse/ioctl.c           |   2 +-
>  include/uapi/linux/fuse.h |   5 +
>  6 files changed, 246 insertions(+), 22 deletions(-)
> 
> ---
> v4: Addressed all comments and refactored the code into 3 separate patches
>     respectively for Atomic create, Atomic open, optimizing lookup in
>     d_revalidate().
> ---
> 

