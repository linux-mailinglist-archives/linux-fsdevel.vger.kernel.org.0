Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2629544DB4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jun 2022 15:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239779AbiFINbW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jun 2022 09:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238801AbiFINbV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jun 2022 09:31:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4357D1ABA7B
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jun 2022 06:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654781478;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KMPwHw/Q9eNYynI7+rtrxtdteC/ovjXlvHhbRHIpVsk=;
        b=IDK5fYS7CS3a5zRYM05VRMs50VD4C6cABW9vF2YXIjILdcn8AgxJizafase2jEKYI32P8B
        2tmkar4s/Cc9WGvmB0+Jkc6P2IqUuDymcR1hL4Cmsv1YHgIvGl1aQSYB6doJCqzyX4y0Ci
        CFiH7HGFyCSzZTS6vTI7kzuHAueHOL0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-331-MC8o3B3aOta2xz9Xz0x6tA-1; Thu, 09 Jun 2022 09:31:07 -0400
X-MC-Unique: MC8o3B3aOta2xz9Xz0x6tA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 502C829AA3B4;
        Thu,  9 Jun 2022 13:31:07 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.210])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3B9F6C53360;
        Thu,  9 Jun 2022 13:31:07 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 12D9B220882; Thu,  9 Jun 2022 09:31:07 -0400 (EDT)
Date:   Thu, 9 Jun 2022 09:31:06 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Yongji Xie <xieyongji@bytedance.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        =?utf-8?B?5byg5L2z6L6w?= <zhangjiachen.jaycee@bytedance.com>,
        linux-fsdevel@vger.kernel.org,
        virtualization <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH] fuse: allow skipping abort interface for virtiofs
Message-ID: <YqH2GofHjS4nkWpQ@redhat.com>
References: <20220607110504.198-1-xieyongji@bytedance.com>
 <Yp+oEPGnisNx+Nzo@redhat.com>
 <CACycT3vKZJ4YhPgGq1VFeh3Tqnr-vK3X+rPz0rObH=MraxrhYA@mail.gmail.com>
 <YqCZt7tyEH50ktKq@redhat.com>
 <CACycT3sMe8EdBWxZhT0HTwVB7mGPk=eV3jG-8EkNK+W-Y_RAiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACycT3sMe8EdBWxZhT0HTwVB7mGPk=eV3jG-8EkNK+W-Y_RAiw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 08, 2022 at 09:57:51PM +0800, Yongji Xie wrote:
> On Wed, Jun 8, 2022 at 8:44 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > On Wed, Jun 08, 2022 at 04:42:46PM +0800, Yongji Xie wrote:
> > > On Wed, Jun 8, 2022 at 3:34 AM Vivek Goyal <vgoyal@redhat.com> wrote:
> > > >
> > > > On Tue, Jun 07, 2022 at 07:05:04PM +0800, Xie Yongji wrote:
> > > > > The commit 15c8e72e88e0 ("fuse: allow skipping control
> > > > > interface and forced unmount") tries to remove the control
> > > > > interface for virtio-fs since it does not support aborting
> > > > > requests which are being processed. But it doesn't work now.
> > > >
> > > > Aha.., so "no_control" basically has no effect? I was looking at
> > > > the code and did not find anybody using "no_control" and I was
> > > > wondering who is making use of "no_control" variable.
> > > >
> > > > I mounted virtiofs and noticed a directory named "40" showed up
> > > > under /sys/fs/fuse/connections/. That must be belonging to
> > > > virtiofs instance, I am assuming.
> > > >
> > >
> > > I think so.
> > >
> > > > BTW, if there are multiple fuse connections, how will one figure
> > > > out which directory belongs to which instance. Because without knowing
> > > > that, one will be shooting in dark while trying to read/write any
> > > > of the control files.
> > > >
> > >
> > > We can use "stat $mountpoint" to get the device minor ID which is the
> > > name of the corresponding control directory.
> > >
> > > > So I think a separate patch should be sent which just gets rid of
> > > > "no_control" saying nobody uses. it.
> > > >
> > >
> > > OK.
> > >
> > > > >
> > > > > This commit fixes the bug, but only remove the abort interface
> > > > > instead since other interfaces should be useful.
> > > >
> > > > Hmm.., so writing to "abort" file is bad as it ultimately does.
> > > >
> > > > fc->connected = 0;
> > > >
> > >
> > > Another problem is that it might trigger UAF since
> > > virtio_fs_request_complete() doesn't know the requests are aborted.
> > >
> > > > So getting rid of this file till we support aborting the pending
> > > > requests properly, makes sense.
> > > >
> > > > I think this probably should be a separate patch which explains
> > > > why adding "no_abort_control" is a good idea.
> > > >
> > >
> > > OK.
> >
> > BTW, which particular knob you are finding useful in control filesystem
> > for virtiofs. As you mentioned "abort" we will not implement. "waiting"
> > might not have much significance as well because requests are handed
> > over to virtiofs immidiately and if they can be sent to server (because
> > virtqueue is full) these are queued internally and fuse layer will not
> > have an idea.
> >
> 
> Couldn't it be used to check the inflight I/O for virtiofs?

Actually I might be wrong. It probably should work. Looking at
implementation.

fuse_conn_waiting_read() looks at fc->num_waiting to figure out
how many requests are in flight.

And either fuse_get_req()/fuse_simple_request() will bump up the
fc->num_request count and fuse_put_request() will drop that count
once request completes. And this seems to be independent of
virtiofs.

So looks like it should work even with virtiofs. Please give it a try.

> 
> > That leaves us with "congestion_threshold" and "max_background".
> > max_background seems to control how many background requests can be
> > submitted at a time. That probably can be useful if server is overwhelemed
> > and we want to slow down the client a bit.
> >
> > Not sure about congestion threshold.
> >
> > So have you found some knob useful for your use case?
> >
> 
> Since it doesn't do harm to the system, I think it would be better to
> just keep it as it is. Maybe some fuse users can make use of it.

I guess fair enough. I don't mind creating "control" file system for
virtiofs. Either we don't create "abort" file or may be somehow
writing to file returns error. I guess both the solutions should
work. 

Thanks
Vivek

