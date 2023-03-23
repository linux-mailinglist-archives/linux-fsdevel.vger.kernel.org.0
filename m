Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC096C6988
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Mar 2023 14:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbjCWNci (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Mar 2023 09:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbjCWNch (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Mar 2023 09:32:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B32B2596D
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Mar 2023 06:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679578311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mXzYR6c2WCVTnZ/W9wW/e0omNfMuDAlzjXCmVrC/wTo=;
        b=eukfv67RhveDKpprFlDwvUPjaHVRxbbF7zGaWefWtx6k8MSb79uVEyawmkPnWkx3q2Q7D9
        8nvVoTeiqPhftwo82jPpGHIf7LbVrUqyR1On5ezm9+JMzHvcvPa/lDSUyygDtTRR7mEmR7
        laW9aqO7uXs4+esLa82R8yhjlsOpwLI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-599-yk90ah0pPruWBLBfLw4E4g-1; Thu, 23 Mar 2023 09:31:47 -0400
X-MC-Unique: yk90ah0pPruWBLBfLw4E4g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3EE80855304;
        Thu, 23 Mar 2023 13:31:46 +0000 (UTC)
Received: from localhost (ovpn-12-97.pek2.redhat.com [10.72.12.97])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DFDC8C15BA0;
        Thu, 23 Mar 2023 13:31:44 +0000 (UTC)
Date:   Thu, 23 Mar 2023 21:31:40 +0800
From:   Baoquan He <bhe@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Liu Shixin <liushixin2@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v7 4/4] mm: vmalloc: convert vread() to vread_iter()
Message-ID: <ZBxUvBFHcQvsl0r9@MiWiFi-R3L-srv>
References: <cover.1679511146.git.lstoakes@gmail.com>
 <941f88bc5ab928e6656e1e2593b91bf0f8c81e1b.1679511146.git.lstoakes@gmail.com>
 <ZBu+2cPCQvvFF/FY@MiWiFi-R3L-srv>
 <ff630c2e-42ff-42ec-9abb-38922d5107ec@lucifer.local>
 <ZBwroYh22pEqJYhv@MiWiFi-R3L-srv>
 <7aee68e9-6e31-925f-68bc-73557c032a42@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7aee68e9-6e31-925f-68bc-73557c032a42@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 03/23/23 at 11:38am, David Hildenbrand wrote:
> On 23.03.23 11:36, Baoquan He wrote:
> > On 03/23/23 at 06:44am, Lorenzo Stoakes wrote:
> > > On Thu, Mar 23, 2023 at 10:52:09AM +0800, Baoquan He wrote:
> > > > On 03/22/23 at 06:57pm, Lorenzo Stoakes wrote:
> > > > > Having previously laid the foundation for converting vread() to an iterator
> > > > > function, pull the trigger and do so.
> > > > > 
> > > > > This patch attempts to provide minimal refactoring and to reflect the
> > > > > existing logic as best we can, for example we continue to zero portions of
> > > > > memory not read, as before.
> > > > > 
> > > > > Overall, there should be no functional difference other than a performance
> > > > > improvement in /proc/kcore access to vmalloc regions.
> > > > > 
> > > > > Now we have eliminated the need for a bounce buffer in read_kcore_iter(),
> > > > > we dispense with it, and try to write to user memory optimistically but
> > > > > with faults disabled via copy_page_to_iter_nofault(). We already have
> > > > > preemption disabled by holding a spin lock. We continue faulting in until
> > > > > the operation is complete.
> > > > 
> > > > I don't understand the sentences here. In vread_iter(), the actual
> > > > content reading is done in aligned_vread_iter(), otherwise we zero
> > > > filling the region. In aligned_vread_iter(), we will use
> > > > vmalloc_to_page() to get the mapped page and read out, otherwise zero
> > > > fill. While in this patch, fault_in_iov_iter_writeable() fault in memory
> > > > of iter one time and will bail out if failed. I am wondering why we
> > > > continue faulting in until the operation is complete, and how that is done.
> > > 
> > > This is refererrring to what's happening in kcore.c, not vread_iter(),
> > > i.e. the looped read/faultin.
> > > 
> > > The reason we bail out if failt_in_iov_iter_writeable() is that would
> > > indicate an error had occurred.
> > > 
> > > The whole point is to _optimistically_ try to perform the operation
> > > assuming the pages are faulted in. Ultimately we fault in via
> > > copy_to_user_nofault() which will either copy data or fail if the pages are
> > > not faulted in (will discuss this below a bit more in response to your
> > > other point).
> > > 
> > > If this fails, then we fault in, and try again. We loop because there could
> > > be some extremely unfortunate timing with a race on e.g. swapping out or
> > > migrating pages between faulting in and trying to write out again.
> > > 
> > > This is extremely unlikely, but to avoid any chance of breaking userland we
> > > repeat the operation until it completes. In nearly all real-world
> > > situations it'll either work immediately or loop once.
> > 
> > Thanks a lot for these helpful details with patience. I got it now. I was
> > mainly confused by the while(true) loop in KCORE_VMALLOC case of read_kcore_iter.
> > 
> > Now is there any chance that the faulted in memory is swapped out or
> > migrated again before vread_iter()? fault_in_iov_iter_writeable() will
> > pin the memory? I didn't find it from code and document. Seems it only
> > falults in memory. If yes, there's window between faluting in and
> > copy_to_user_nofault().
> > 
> 
> See the documentation of fault_in_safe_writeable():
> 
> "Note that we don't pin or otherwise hold the pages referenced that we fault
> in.  There's no guarantee that they'll stay in memory for any duration of
> time."

Thanks for the info. Then swapping out/migration could happen again, so
that's why while(true) loop is meaningful.

