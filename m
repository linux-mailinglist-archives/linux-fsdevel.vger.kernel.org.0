Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562BA5F2901
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Oct 2022 09:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiJCHMI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Oct 2022 03:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiJCHMF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Oct 2022 03:12:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E35D36418
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Oct 2022 00:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664781123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I0LXfsSyKXGjmai9f263mAbHu12AmzCqqawR+zfFGBM=;
        b=RhMO/y/mxirnqSG/054b5Jz7BWgAG2OIz5XOjA+DvMVu7IXKKHQ1OJMsHhDHQkaTaj3pJi
        FdESAUwMQ2ohQSI10n5dM5hqOVDZKM9Ipo0B2KGkgpWAxkK12RVvlCLcyL4MmK5/J84Ai2
        wMIVAZ++aQi34vGoAQnl7S88XR4Ts74=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-477-GNJWiLMGNs6-wrhEm2uRtw-1; Mon, 03 Oct 2022 03:11:59 -0400
X-MC-Unique: GNJWiLMGNs6-wrhEm2uRtw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2F28D85A59D;
        Mon,  3 Oct 2022 07:11:59 +0000 (UTC)
Received: from starship (unknown [10.40.193.232])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ED50440C6EC2;
        Mon,  3 Oct 2022 07:11:56 +0000 (UTC)
Message-ID: <2a9fe4f9759b9971e76f719f4c1295eed41ed50c.camel@redhat.com>
Subject: Re: Commit 'iomap: add support for dma aligned direct-io' causes
 qemu/KVM boot failures
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, qemu-devel@nongnu.org,
        kvm@vger.kernel.org, Kevin Wolf <kwolf@redhat.com>,
        Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <YzmYojlHKZ79mseE@kbusch-mbp>
References: <fb869c88bd48ea9018e1cc349918aa7cdd524931.camel@redhat.com>
         <YzW+Mz12JT1BXoZA@kbusch-mbp.dhcp.thefacebook.com>
         <a2825beac032fd6a76838164d4e2753d30305897.camel@redhat.com>
         <YzXJwmP8pa3WABEG@kbusch-mbp.dhcp.thefacebook.com>
         <20220929163931.GA10232@lst.de>
         <32db4f89-a83f-aac4-5d27-0801bdca60bf@redhat.com>
         <28ce86c01271c1b9b8f96a7783b55a8d458325d2.camel@redhat.com>
         <YzmYojlHKZ79mseE@kbusch-mbp>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Date:   Mon, 03 Oct 2022 10:06:48 +0300
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 2022-10-02 at 07:56 -0600, Keith Busch wrote:
> On Sun, Oct 02, 2022 at 11:59:42AM +0300, Maxim Levitsky wrote:
> > On Thu, 2022-09-29 at 19:35 +0200, Paolo Bonzini wrote:
> > > On 9/29/22 18:39, Christoph Hellwig wrote:
> > > > On Thu, Sep 29, 2022 at 10:37:22AM -0600, Keith Busch wrote:
> > > > > > I am aware, and I've submitted the fix to qemu here:
> > > > > > 
> > > > > >   https://lists.nongnu.org/archive/html/qemu-block/2022-09/msg00398.html
> > > > > 
> > > > > I don't think so. Memory alignment and length granularity are two completely
> > > > > different concepts. If anything, the kernel's ABI had been that the length
> > > > > requirement was also required for the memory alignment, not the other way
> > > > > around. That usage will continue working with this kernel patch.
> > 
> > Yes, this is how I also understand it - for example for O_DIRECT on a file which
> > resides on 4K block device, you have to use page aligned buffers.
> > 
> > But here after the patch, 512 aligned buffer starts working as well - If I
> > understand you correctly the ABI didn't guarantee that such usage would fail,
> > but rather that it might fail.
> 
> The kernel patch will allow buffer alignment to work with whatever the hardware
> reports it can support. It could even as low as byte aligned if that's the
> hardware can use that.
> 
> The patch aligns direct-io with the same criteria blk_rq_map_user() has always
> used to know if the user space buffer is compatible with the hardware's dma
> requirements. Prior to this patch, the direct-io memory alignment was an
> artificial software constraint, and that constraint creates a lot of
> unnecessary memory pressure.
> 
> As has always been the case, each segment needs to be a logical block length
> granularity. QEMU assumed a buffer's page offset also defined the logical block
> size instead of using the actual logical block size that it had previously
> discovered directly.
> 
> > If I understand that correctly, after the patch in question, 
> > qemu is able to use just 512 bytes aligned buffer to read a single 4K block from the disk,
> > which supposed to fail but wasn't guarnteed to fail.
> > 
> > Later qemu it submits iovec which also reads a 4K block but in two parts,
> > and if I understand that correctly, each part (iov) is considered
> > to be a separate IO operation,  and thus each has to be in my case 4K in size, 
> > and its memory buffer *should* also be 4K aligned.
> > 
> > (but it can work with smaller alignement as well).
> 
> Right. The iov length needs to match the logical block size. The iov's memory
> offset needs to align to the queue's dma_alignment attribute. The memory
> alignment may be smaller than a block size.
>  
> > Assuming that I understand all of this correctly, I agree with Paolo that this is qemu
> > bug, but I do fear that it can cause quite some problems for users,
> > especially for users that use outdated qemu version.
> > 
> > It might be too much to ask, but maybe add a Kconfig option to keep legacy behavier
> > for those that need it?
> 
> Kconfig doesn't sound right.
> 
> The block layer exports all the attributes user space needs to know about for
> direct io.
> 
>   iov length:    /sys/block/<block-dev>/queue/logical_block_size
>   iov mem align: /sys/block/<block-dev>/queue/dma_alignment
> 
> If you really want to change the behavior, I think maybe we could make the
> dma_alignment attribute writeable (or perhaps add a new attribute specifically
> for dio_alignment) so the user can request something larger.
> 
All makes sense now. 

New attribute could make sense I guess, and can be set by an udev rule or something.


Anyway I won't worry about this for now, and if there are issues I'll see how we could work
around them.

Thanks for everything,
Best regards,
	Maxim Levitsky

