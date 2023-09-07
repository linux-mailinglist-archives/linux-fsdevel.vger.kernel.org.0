Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B6E797498
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Sep 2023 17:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbjIGPkH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Sep 2023 11:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234421AbjIGPWr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:22:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A03173B
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Sep 2023 08:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694100090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jcp9t8PXlVRBPL3W86fd5Kv+062g5ucG1hdBZ2FAXhI=;
        b=Tt2kKaa1J7N50+kwWFoeHJNfOJKuTOSTF02XS/de7AMQ+/G9HyNPKW9fxm5oePADI4ZWIK
        pLKMTZI/8eNaGs25C0CpgMfi0UxQLMfYGjO4mtuC/f9zRMoQGuV6zCs3vWySRoMP2aKDab
        RFfjhhelIJ6ATOutKLRj6w8oZguj9Tk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-54-Ai8xAwkqPEKFexCSsXupuQ-1; Thu, 07 Sep 2023 08:04:52 -0400
X-MC-Unique: Ai8xAwkqPEKFexCSsXupuQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CB0162815E40;
        Thu,  7 Sep 2023 12:04:51 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8D48D4060E1;
        Thu,  7 Sep 2023 12:04:51 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
        id 7631030C1C07; Thu,  7 Sep 2023 12:04:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id 71E2E3FD6A;
        Thu,  7 Sep 2023 14:04:51 +0200 (CEST)
Date:   Thu, 7 Sep 2023 14:04:51 +0200 (CEST)
From:   Mikulas Patocka <mpatocka@redhat.com>
To:     Christian Brauner <brauner@kernel.org>
cc:     Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Zdenek Kabelac <zkabelac@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH] fix writing to the filesystem after unmount
In-Reply-To: <20230907-abgrenzen-achtung-b17e9a1ad136@brauner>
Message-ID: <513f337e-d254-2454-6197-82df564ed5fc@redhat.com>
References: <59b54cc3-b98b-aff9-14fc-dc25c61111c6@redhat.com> <20230906-launenhaft-kinder-118ea59706c8@brauner> <f5d63867-5b3e-294b-d1f5-a128817cfc7@redhat.com> <20230906-aufheben-hagel-9925501b7822@brauner> <60f244be-803b-fa70-665e-b5cba15212e@redhat.com>
 <20230906-aufkam-bareinlage-6e7d06d58e90@brauner> <818a3cc0-c17b-22c0-4413-252dfb579cca@redhat.com> <20230907094457.vcvmixi23dk3pzqe@quack3> <20230907-abgrenzen-achtung-b17e9a1ad136@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Thu, 7 Sep 2023, Christian Brauner wrote:

> > I think we've got too deep down into "how to fix things" but I'm not 100%
> 
> We did.
> 
> > sure what the "bug" actually is. In the initial posting Mikulas writes "the
> > kernel writes to the filesystem after unmount successfully returned" - is
> > that really such a big issue?

I think it's an issue if the administrator writes a script that unmounts a 
filesystem and then copies the underyling block device somewhere. Or a 
script that unmounts a filesystem and runs fsck afterwards. Or a script 
that unmounts a filesystem and runs mkfs on the same block device.

> > Anybody else can open the device and write to it as well. Or even 
> > mount the device again. So userspace that relies on this is kind of 
> > flaky anyway (and always has been).

It's admin's responsibility to make sure that the filesystem is not 
mounted multiple times when he touches the underlying block device after 
unmount.

> Yeah, agreed.
> 
> > namespaces etc. I'm not sure such behavior brings much value...
> 
> It would in any case mean complicating our code for little gain imho.
> And as I showed in my initial reply the current patch would hang on any
> bind-mount unmount. IOW, any container. And Al correctly points out
> issues with exit(), close() and friends on top of that.
> 
> But I also hate the idea of waiting on the last umount because that can
> also lead to new unexpected behavior when e.g., the system is shutdown
> and systemd goes on to unmount all things and then suddenly just hangs
> when before it was able to make progress.

Would you agree to waiting on the last umount only if the freeze was 
initiated by lvm? (there would be no hang in this case because lvm thaws 
the block device in a timely manner)

Mikulas

