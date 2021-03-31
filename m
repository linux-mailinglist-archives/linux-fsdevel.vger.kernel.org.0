Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71C7F3501E5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Mar 2021 16:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235946AbhCaOIg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Mar 2021 10:08:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:54760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235114AbhCaOII (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Mar 2021 10:08:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C45B860FE4;
        Wed, 31 Mar 2021 14:08:02 +0000 (UTC)
Date:   Wed, 31 Mar 2021 16:07:59 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Yongji Xie <xieyongji@bytedance.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Parav Pandit <parav@nvidia.com>,
        Christian Brauner <christian.brauner@canonical.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, viro@zeniv.linux.org.uk,
        Jens Axboe <axboe@kernel.dk>, bcrl@kvack.org,
        Jonathan Corbet <corbet@lwn.net>,
        Mika =?utf-8?B?UGVudHRpbMOk?= <mika.penttila@nextfour.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v6 01/10] file: Export receive_fd() to modules
Message-ID: <20210331140759.rxfpfcavzus3lomp@wittgenstein>
References: <20210331080519.172-1-xieyongji@bytedance.com>
 <20210331080519.172-2-xieyongji@bytedance.com>
 <20210331091545.lr572rwpyvrnji3w@wittgenstein>
 <CACycT3vRhurgcuNvEW7JKuhCQdy__5ZX=5m1AFnVKDk8UwUa7A@mail.gmail.com>
 <20210331122315.uas3n44vgxz5z5io@wittgenstein>
 <CACycT3vm_XvitXV+kXivAhrfwN6U0Nm5kZwcYhY+GrriVAKq8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACycT3vm_XvitXV+kXivAhrfwN6U0Nm5kZwcYhY+GrriVAKq8g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 31, 2021 at 09:59:07PM +0800, Yongji Xie wrote:
> On Wed, Mar 31, 2021 at 8:23 PM Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> >
> > On Wed, Mar 31, 2021 at 07:32:33PM +0800, Yongji Xie wrote:
> > > On Wed, Mar 31, 2021 at 5:15 PM Christian Brauner
> > > <christian.brauner@ubuntu.com> wrote:
> > > >
> > > > On Wed, Mar 31, 2021 at 04:05:10PM +0800, Xie Yongji wrote:
> > > > > Export receive_fd() so that some modules can use
> > > > > it to pass file descriptor between processes without
> > > > > missing any security stuffs.
> > > > >
> > > > > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > > > > ---
> > > >
> > > > Yeah, as I said in the other mail I'd be comfortable with exposing just
> > > > this variant of the helper.
> > >
> > > Thanks, I got it now.
> > >
> > > > Maybe this should be a separate patch bundled together with Christoph's
> > > > patch to split parts of receive_fd() into a separate helper.
> > >
> > > Do we need to add the seccomp notifier into the separate helper? In
> > > our case, the file passed to the separate helper is from another
> > > process.
> >
> > Not sure what you mean. Christoph has proposed
> > https://lore.kernel.org/linux-fsdevel/20210325082209.1067987-2-hch@lst.de
> > I was just saying that if we think this patch is useful we might bundle
> > it together with the
> > EXPORT_SYMBOL(receive_fd)
> > part here, convert all drivers that currently open-code get_unused_fd()
> > + fd_install() to use receive_fd(), and make this a separate patchset.
> >
> 
> Yes, I see. We can split the parts (get_unused_fd() + fd_install()) of
> receive_fd() into a separate helper and convert all drivers to use
> that. What I mean is that I also would like to use
> security_file_receive() in my modules. So I'm not sure if it's ok to
> add security_file_receive() into the separate helper. Or do I need to
> export security_file_receive() separately?

I think I confused you which is my bad. What you do here is - in my
opinion - correct.
I'm just saying that exporting receive_fd() allows further cleanups and
your export here could go on top of Christoph's change in a separate
series.

Christian
