Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58B8A351E9F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 20:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237465AbhDASoH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Apr 2021 14:44:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:32778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235472AbhDASh7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:37:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BCF4F601FA;
        Thu,  1 Apr 2021 11:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617276783;
        bh=5KMvA2+X56eTd5dyjjLD2hU0fGFm3/24CWsHPBvQ+Ig=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IBITasZ585a0W5dpATNVyHV+ozpDXKXjXXMpkscA6BRtiWbghKY/NvT30kNN9bfD4
         ecM/TbWMQwY0kbqKVGThvO5+T+13qJJWC/iP1GkSM+6VF8nQhvphmODIoOBObxMhqS
         kc8OIVsr1+YSIk6sakFY9eWRmDv3Eo21Gnz0gRTE=
Date:   Thu, 1 Apr 2021 13:33:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yongji Xie <xieyongji@bytedance.com>
Cc:     devel@driverdev.osuosl.org, tkjos@android.com,
        Kees Cook <keescook@chromium.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Jason Wang <jasowang@redhat.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Christoph Hellwig <hch@infradead.org>,
        Hridya Valsaraju <hridya@google.com>, arve@android.com,
        viro@zeniv.linux.org.uk, joel@joelfernandes.org,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        maco@android.com
Subject: Re: Re: Re: [PATCH 2/2] binder: Use receive_fd() to receive file
 from another process
Message-ID: <YGWvbAXQO2Vsiupo@kroah.com>
References: <20210401090932.121-1-xieyongji@bytedance.com>
 <20210401090932.121-3-xieyongji@bytedance.com>
 <YGWYZYbBzglUCxB2@kroah.com>
 <CACycT3ux9NVu_L=Vse7v-xbwE-K0-HT-e-Ei=yHOQmF66nGjeQ@mail.gmail.com>
 <YGWjh7qCJ8HJpFxv@kroah.com>
 <CACycT3uEGRiDuOj2XBwF2PmnGXsQgrLDemJDFRytsJiJMyRWDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACycT3uEGRiDuOj2XBwF2PmnGXsQgrLDemJDFRytsJiJMyRWDw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 01, 2021 at 07:29:45PM +0800, Yongji Xie wrote:
> On Thu, Apr 1, 2021 at 6:42 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Apr 01, 2021 at 06:12:51PM +0800, Yongji Xie wrote:
> > > On Thu, Apr 1, 2021 at 5:54 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Thu, Apr 01, 2021 at 05:09:32PM +0800, Xie Yongji wrote:
> > > > > Use receive_fd() to receive file from another process instead of
> > > > > combination of get_unused_fd_flags() and fd_install(). This simplifies
> > > > > the logic and also makes sure we don't miss any security stuff.
> > > >
> > > > But no logic is simplified here, and nothing is "missed", so I do not
> > > > understand this change at all.
> > > >
> > >
> > > I noticed that we have security_binder_transfer_file() when we
> > > transfer some fds. I'm not sure whether we need something like
> > > security_file_receive() here?
> >
> > Why would you?  And where is "here"?
> >
> > still confused,
> >
> 
> I mean do we need to go through the file_receive seccomp notifier when
> we receive fd (use get_unused_fd_flags() + fd_install now) from
> another process in binder_apply_fd_fixups().

Why?  this is internal things, why does seccomp come into play here?

