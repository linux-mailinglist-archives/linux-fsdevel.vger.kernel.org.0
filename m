Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D535430AA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jun 2022 14:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239474AbiFHMoq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jun 2022 08:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239409AbiFHMop (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jun 2022 08:44:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A7F16EC3FA
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jun 2022 05:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654692283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/gDZKJAkFIiucFog1TOTZeqqoQwvori+AWAJxkaK2Pk=;
        b=gs7MA2qcRWFo+gahkrWcCE6wr2aIhtuRYy4UdYUPGzZ9qC76zIjP/r0gXpYLF1PWgk+M3/
        EH1g+wAp69CLLoiGvJ6DymQIs6OQp6JSjGs93GSX/aHCHF55cz9VgT/UpESAbCl9XK8xVd
        h07Sh2NEGdzeIMxuA+BCLGK9/0fgUew=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-253-fvBPobWRMhiQfFGJUMr1Bg-1; Wed, 08 Jun 2022 08:44:40 -0400
X-MC-Unique: fvBPobWRMhiQfFGJUMr1Bg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0FB7C2999B56;
        Wed,  8 Jun 2022 12:44:40 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.9.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B75852026D64;
        Wed,  8 Jun 2022 12:44:39 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 76575220882; Wed,  8 Jun 2022 08:44:39 -0400 (EDT)
Date:   Wed, 8 Jun 2022 08:44:39 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Yongji Xie <xieyongji@bytedance.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        =?utf-8?B?5byg5L2z6L6w?= <zhangjiachen.jaycee@bytedance.com>,
        linux-fsdevel@vger.kernel.org,
        virtualization <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH] fuse: allow skipping abort interface for virtiofs
Message-ID: <YqCZt7tyEH50ktKq@redhat.com>
References: <20220607110504.198-1-xieyongji@bytedance.com>
 <Yp+oEPGnisNx+Nzo@redhat.com>
 <CACycT3vKZJ4YhPgGq1VFeh3Tqnr-vK3X+rPz0rObH=MraxrhYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACycT3vKZJ4YhPgGq1VFeh3Tqnr-vK3X+rPz0rObH=MraxrhYA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 08, 2022 at 04:42:46PM +0800, Yongji Xie wrote:
> On Wed, Jun 8, 2022 at 3:34 AM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > On Tue, Jun 07, 2022 at 07:05:04PM +0800, Xie Yongji wrote:
> > > The commit 15c8e72e88e0 ("fuse: allow skipping control
> > > interface and forced unmount") tries to remove the control
> > > interface for virtio-fs since it does not support aborting
> > > requests which are being processed. But it doesn't work now.
> >
> > Aha.., so "no_control" basically has no effect? I was looking at
> > the code and did not find anybody using "no_control" and I was
> > wondering who is making use of "no_control" variable.
> >
> > I mounted virtiofs and noticed a directory named "40" showed up
> > under /sys/fs/fuse/connections/. That must be belonging to
> > virtiofs instance, I am assuming.
> >
> 
> I think so.
> 
> > BTW, if there are multiple fuse connections, how will one figure
> > out which directory belongs to which instance. Because without knowing
> > that, one will be shooting in dark while trying to read/write any
> > of the control files.
> >
> 
> We can use "stat $mountpoint" to get the device minor ID which is the
> name of the corresponding control directory.
> 
> > So I think a separate patch should be sent which just gets rid of
> > "no_control" saying nobody uses. it.
> >
> 
> OK.
> 
> > >
> > > This commit fixes the bug, but only remove the abort interface
> > > instead since other interfaces should be useful.
> >
> > Hmm.., so writing to "abort" file is bad as it ultimately does.
> >
> > fc->connected = 0;
> >
> 
> Another problem is that it might trigger UAF since
> virtio_fs_request_complete() doesn't know the requests are aborted.
> 
> > So getting rid of this file till we support aborting the pending
> > requests properly, makes sense.
> >
> > I think this probably should be a separate patch which explains
> > why adding "no_abort_control" is a good idea.
> >
> 
> OK.

BTW, which particular knob you are finding useful in control filesystem
for virtiofs. As you mentioned "abort" we will not implement. "waiting"
might not have much significance as well because requests are handed
over to virtiofs immidiately and if they can be sent to server (because
virtqueue is full) these are queued internally and fuse layer will not
have an idea.

That leaves us with "congestion_threshold" and "max_background".
max_background seems to control how many background requests can be
submitted at a time. That probably can be useful if server is overwhelemed
and we want to slow down the client a bit.

Not sure about congestion threshold.

So have you found some knob useful for your use case?

Thanks
Vivek

