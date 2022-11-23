Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A94FA6352D2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Nov 2022 09:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236553AbiKWIhN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Nov 2022 03:37:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiKWIhM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Nov 2022 03:37:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665BAE9311
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Nov 2022 00:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669192582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZXpADkosxLt0AA2jYCiJ8BdnoYTtcT80XliNqZ/i9wo=;
        b=XDG/XiLQuno/dTRczof6EDx8SV2vwZPYUvuXYBKO2/j1fzPVcjIzbWVerNJdqTwbh+CHhT
        qkfdWnBbgWHki7SlbLi+9U/yB8KIv+FaZAPdQOtwC3cUCMoXIT2Arw4D17ojkqeAT20qFa
        ovG8DuksYkUcoYN4uIjy0UxLmZKoJ60=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-610-hIQ5oH6kPV-Rik523lwo0w-1; Wed, 23 Nov 2022 03:36:19 -0500
X-MC-Unique: hIQ5oH6kPV-Rik523lwo0w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ABFBA802D32;
        Wed, 23 Nov 2022 08:36:18 +0000 (UTC)
Received: from fedora (ovpn-193-217.brq.redhat.com [10.40.193.217])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6C7BD39D7C;
        Wed, 23 Nov 2022 08:36:17 +0000 (UTC)
Date:   Wed, 23 Nov 2022 09:36:15 +0100
From:   Lukas Czerner <lczerner@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.com>,
        Eric Sandeen <sandeen@redhat.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] quota: add quota in-memory format support
Message-ID: <20221123083615.sj26ptongwhk6wcl@fedora>
References: <20221121142854.91109-1-lczerner@redhat.com>
 <20221121142854.91109-2-lczerner@redhat.com>
 <Y3u54l2CVapQmK/w@magnolia>
 <Y3zHn4egPhwMRcDE@infradead.org>
 <20221122142117.epplqsm4ngwx5eyy@fedora>
 <Y33SqRyAGTXVFBIF@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y33SqRyAGTXVFBIF@infradead.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 22, 2022 at 11:58:33PM -0800, Christoph Hellwig wrote:
> On Tue, Nov 22, 2022 at 03:21:17PM +0100, Lukas Czerner wrote:
> > > That seems like a good idea for memory usage, but I think this might
> > > also make the code much simpler, as that just requires fairly trivial
> > > quota_read and quota_write methods in the shmem code instead of new
> > > support for an in-memory quota file.
> > 
> > You mean like the implementation in the v1 ?
> 
> Having now found it: yes.
> 

Jan,

do you have any argument for this, since it was your suggestion?

I also think that the implementation is much simpler with in-memory
dquots because we will avoid all the hassle with creating and
maintaining quota file in a proper format. It's not just reads and
writes it's the entire machinery befind it in quota_v2.c and quota_tree.c.

But it is true that even with only user modified dquots being
non-reclaimable until unmount it could theoreticaly represent a
substantial memory consumption. Although I do wonder if this problem
is even real. How many user/group ids would you expect extremely heavy
quota user would have the limits set for? 1k, 10k, million, or even
more? Do you know?

-Lukas

