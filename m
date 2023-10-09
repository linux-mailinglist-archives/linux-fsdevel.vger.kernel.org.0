Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808477BEB90
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Oct 2023 22:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378608AbjJIUWn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Oct 2023 16:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378544AbjJIUWm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Oct 2023 16:22:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8219A6
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Oct 2023 13:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696882910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5+RJjC/T7NRCS2/KRTZfi6Vx3C+aZeOiDh/GdLhMj1U=;
        b=hYhIb5M/Eqi1GoqD+s6KrnJlek8Qm6yLTWI5LAuZpaGI92yyxg77nFE0BBZv2eNYhJeR2Z
        uPPhuqhvY+xUcBcU2DOKL8iJ74qrVaeDxNNgeNlpC+6d9ESlaAPWgTHybZpR3Lm/rJdetk
        VT0lGgz6foyLgKP7pjMv/bQ6DYDyd68=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-303-MJQQRfVFNV2E2AZCsJkRRQ-1; Mon, 09 Oct 2023 16:21:47 -0400
X-MC-Unique: MJQQRfVFNV2E2AZCsJkRRQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 27145811E7B;
        Mon,  9 Oct 2023 20:21:47 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.8.140])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 038A936E1;
        Mon,  9 Oct 2023 20:21:46 +0000 (UTC)
Received: by fedora.redhat.com (Postfix, from userid 1000)
        id 61FCB20A716; Mon,  9 Oct 2023 16:21:46 -0400 (EDT)
Date:   Mon, 9 Oct 2023 16:21:46 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        mzxreary@0pointer.de, stefanha@redhat.com
Subject: Re: [Virtio-fs] [PATCH] virtiofs: Export filesystem tags through
 sysfs
Message-ID: <ZSRg2uiBNmY4mKHr@redhat.com>
References: <20231005203030.223489-1-vgoyal@redhat.com>
 <CAJfpegspVnkXAa5xfvjEQ9r5__vXpcgR4qubdG8=p=aiS2goRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegspVnkXAa5xfvjEQ9r5__vXpcgR4qubdG8=p=aiS2goRg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 09, 2023 at 11:53:42AM +0200, Miklos Szeredi wrote:
> On Thu, 5 Oct 2023 at 22:30, Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > virtiofs filesystem is mounted using a "tag" which is exported by the
> > virtiofs device. virtiofs driver knows about all the available tags but
> > these are not exported to user space.
> >
> > People have asked these tags to be exported to user space. Most recently
> > Lennart Poettering has asked for it as he wants to scan the tags and mount
> > virtiofs automatically in certain cases.
> >
> > https://gitlab.com/virtio-fs/virtiofsd/-/issues/128
> >
> > This patch exports tags through sysfs. One tag is associated with each
> > virtiofs device. A new "tag" file appears under virtiofs device dir.
> > Actual filesystem tag can be obtained by reading this "tag" file.
> >
> > For example, if a virtiofs device exports tag "myfs", a new file "tag"
> > will show up here.
> >
> > /sys/bus/virtio/devices/virtio<N>/tag
> >
> > # cat /sys/bus/virtio/devices/virtio<N>/tag
> > myfs
> >
> > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> 
> Hi Vivek,
> 
> This needs something under Documentation/.

Hi Miklos,

Hmm.., I can easily update the virtiofs documentation.

Initially I was thinking to put something in Documentation/ABI/testing/
as well. But I don't see any virtio related. In fact can't find any
files related to "virtio" at all.

So I will just update the Documentation/filesystems/virtiofs.rst for now.

> 
> While the interface looks good to me, I think we need an ack on that
> from the virtio maintainer.

I am assuming Stefan should be able to provide an ACK. But I will also
add Michael and Paolo in the V2 of the patch and hoping we should be
able to get atleast 1 ACK.

Thanks
Vivek

