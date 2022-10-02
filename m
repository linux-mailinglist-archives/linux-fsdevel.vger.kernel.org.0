Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07ACF5F2229
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Oct 2022 11:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiJBI76 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 Oct 2022 04:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiJBI74 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 Oct 2022 04:59:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5768C13E08
        for <linux-fsdevel@vger.kernel.org>; Sun,  2 Oct 2022 01:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664701190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uUV7VJSlnQzJ38mxDgh5xaYxjeTtv351HITh3SQqr0M=;
        b=J46bbuSI5IceDu/XUYlcFprpldDrc2at2L3QOgyjjgZ0nrMk6A5QbB/rZPK1zCErmaqPEu
        8IcM0MqzIDsTt5EWehSnuP8S/TyQZtNr64Pek5+phLy+M5KrR7Xj/PyhxDrH+SDnl8EBHL
        QNOA9ttI82hclbPucAYNbpd1SMrSlMI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-614-A5meftXDO-6l48yy-yhurA-1; Sun, 02 Oct 2022 04:59:47 -0400
X-MC-Unique: A5meftXDO-6l48yy-yhurA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 26727380670A;
        Sun,  2 Oct 2022 08:59:47 +0000 (UTC)
Received: from starship (unknown [10.40.192.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CD77B40C206B;
        Sun,  2 Oct 2022 08:59:44 +0000 (UTC)
Message-ID: <28ce86c01271c1b9b8f96a7783b55a8d458325d2.camel@redhat.com>
Subject: Re: Commit 'iomap: add support for dma aligned direct-io' causes
 qemu/KVM boot failures
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        qemu-devel@nongnu.org, kvm@vger.kernel.org,
        Kevin Wolf <kwolf@redhat.com>,
        Michael Roth <mdroth@linux.vnet.ibm.com>
Date:   Sun, 02 Oct 2022 11:59:42 +0300
In-Reply-To: <32db4f89-a83f-aac4-5d27-0801bdca60bf@redhat.com>
References: <fb869c88bd48ea9018e1cc349918aa7cdd524931.camel@redhat.com>
         <YzW+Mz12JT1BXoZA@kbusch-mbp.dhcp.thefacebook.com>
         <a2825beac032fd6a76838164d4e2753d30305897.camel@redhat.com>
         <YzXJwmP8pa3WABEG@kbusch-mbp.dhcp.thefacebook.com>
         <20220929163931.GA10232@lst.de>
         <32db4f89-a83f-aac4-5d27-0801bdca60bf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2022-09-29 at 19:35 +0200, Paolo Bonzini wrote:
> On 9/29/22 18:39, Christoph Hellwig wrote:
> > On Thu, Sep 29, 2022 at 10:37:22AM -0600, Keith Busch wrote:
> > > > I am aware, and I've submitted the fix to qemu here:
> > > > 
> > > >   https://lists.nongnu.org/archive/html/qemu-block/2022-09/msg00398.html
> > > 
> > > I don't think so. Memory alignment and length granularity are two completely
> > > different concepts. If anything, the kernel's ABI had been that the length
> > > requirement was also required for the memory alignment, not the other way
> > > around. That usage will continue working with this kernel patch.

Yes, this is how I also understand it - for example for O_DIRECT on a file which
resides on 4K block device, you have to use page aligned buffers.

But here after the patch, 512 aligned buffer starts working as well - If I
understand you correctly the ABI didn't guarantee that such usage would fail,
but rather that it might fail.

> > 
> > Well, Linus does treat anything that breaks significant userspace
> > as a regression.  Qemu certainly is significant, but that might depend
> > on bit how common configurations hitting this issue are.
> 
> Seeing the QEMU patch, I agree that it's a QEMU bug though.  I'm 
> surprised it has ever worked.
> 
> It requires 4K sectors in the host but not in the guest, and can be 
> worked around (if not migrating) by disabling O_DIRECT.  I think it's 
> not that awful, but we probably should do some extra releases of QEMU 
> stable branches.
> 
> Paolo
> 

I must admit I am out of the loop on the exact requirements of the O_DIRECT.


If I understand that correctly, after the patch in question, 
qemu is able to use just 512 bytes aligned buffer to read a single 4K block from the disk,
which supposed to fail but wasn't guarnteed to fail.



Later qemu it submits iovec which also reads a 4K block but in two parts,
and if I understand that correctly, each part (iov) is considered
to be a separate IO operation,  and thus each has to be in my case 4K in size, 
and its memory buffer *should* also be 4K aligned.

(but it can work with smaller alignement as well).


Assuming that I understand all of this correctly, I agree with Paolo that this is qemu
bug, but I do fear that it can cause quite some problems for users,
especially for users that use outdated qemu version.

It might be too much to ask, but maybe add a Kconfig option to keep legacy behavier
for those that need it?

Best regards,
	Maxim Levitsky

