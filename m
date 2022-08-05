Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F0558B01F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Aug 2022 20:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241325AbiHES6a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Aug 2022 14:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237004AbiHES63 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Aug 2022 14:58:29 -0400
X-Greylist: delayed 356 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 05 Aug 2022 11:58:27 PDT
Received: from mta-102a.earthlink-vadesecure.net (mta-102a.earthlink-vadesecure.net [51.81.61.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7EF51A3A;
        Fri,  5 Aug 2022 11:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; bh=xRsDc1qDSJw6d5P2BwD3yzRvNWXzLa25kh4CKC
 4heBo=; c=relaxed/relaxed; d=earthlink.net; h=from:reply-to:subject:
 date:to:cc:resent-date:resent-from:resent-to:resent-cc:in-reply-to:
 references:list-id:list-help:list-unsubscribe:list-subscribe:list-post:
 list-owner:list-archive; q=dns/txt; s=dk12062016; t=1659725543;
 x=1660330343; b=ZOCJ2QXBuVa9fLssHWMhpl3eaY+Uvfz5UgIVMdSmuSfXL54t08qjc4W
 XuMhPdWj90+wkiRM9+zhl4cHnNmw/1r2asvCVFnUD7/CZBLYUDgv0wbJZguzs9cfEkT4jh3
 WVZyTedMIsJEpFhqY/IzOVN11P0ziYpmnbYaNkv3Mrk9d7nOt0I4mJIxrdDdWo9TYNFPh18
 sRXW6S8abeCD6q+tqF0FzfEZUiAiLMsE1fVFIPg7pKD49LRX/Tzh9lqwdtD+BMJmB1C2Y1S
 i/nNkxB27CXwv7EhHx2j8vZZdDxSCI3wT/Rs+LR+lXTsh/RA6qZUL/j5Zpa/RVhs/rUOLD1
 Khg==
Received: from FRANKSTHINKPAD ([76.105.143.216])
 by smtp.earthlink-vadesecure.net ESMTP vsel1nmtao02p with ngmta
 id da041a6f-170887961dc98578; Fri, 05 Aug 2022 18:52:22 +0000
From:   "Frank Filz" <ffilzlnx@mindspring.com>
To:     "'Jeff Layton'" <jlayton@kernel.org>,
        <linux-fsdevel@vger.kernel.org>
Cc:     <dhowells@redhat.com>, <lczerner@redhat.com>, <bxue@redhat.com>,
        <ceph-devel@vger.kernel.org>, <linux-nfs@vger.kernel.org>,
        <linux-afs@lists.infradead.org>, <linux-ext4@vger.kernel.org>,
        <linux-xfs@vger.kernel.org>, <linux-btrfs@vger.kernel.org>
References: <20220805183543.274352-1-jlayton@kernel.org>
In-Reply-To: <20220805183543.274352-1-jlayton@kernel.org>
Subject: RE: [RFC PATCH 0/4] vfs: allow querying i_version via statx
Date:   Fri, 5 Aug 2022 11:52:21 -0700
Message-ID: <030701d8a8fc$7fae8b80$7f0ba280$@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Content-Language: en-us
Thread-Index: AQEtGZTJQmRjw345ne5MFo8sgZw3IK73xOQQ
Authentication-Results: earthlink-vadesecure.net;
 auth=pass smtp.auth=ffilzlnx@mindspring.com smtp.mailfrom=ffilzlnx@mindspring.com;
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Recently I posted a patch to turn on the i_version counter unconditionally
in
> ext4, and Lukas rightly pointed out that we don't currently have an easy
way to
> validate its functionality. You can fetch it via NFS (and see it in
network traces),
> but there's no way to get to it from userland.
> 
> Besides testing, this may also be of use for userland NFS servers, or by
any
> program that wants to accurately check for file changes, and not be
subject to
> mtime granularity problems.

This would definitely be useful for NFS Ganesha.

Thanks

Frank

> Comments and suggestions welcome. I'm not 100% convinced that this is a
> great idea, but we've had people ask for it before and it seems like a
reasonable
> thing to provide.
> 
> Jeff Layton (4):
>   vfs: report change attribute in statx for IS_I_VERSION inodes
>   nfs: report the change attribute if requested
>   afs: fill out change attribute in statx replies
>   ceph: fill in the change attribute in statx requests
> 
>  fs/afs/inode.c            |  2 ++
>  fs/ceph/inode.c           | 14 +++++++++-----
>  fs/nfs/inode.c            |  3 +++
>  fs/stat.c                 |  7 +++++++
>  include/linux/stat.h      |  1 +
>  include/uapi/linux/stat.h |  3 ++-
>  samples/vfs/test-statx.c  |  4 +++-
>  7 files changed, 27 insertions(+), 7 deletions(-)
> 
> --
> 2.37.1

