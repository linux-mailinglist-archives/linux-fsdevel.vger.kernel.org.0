Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43F12351931
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 19:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234204AbhDARwM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Apr 2021 13:52:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:48922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235382AbhDARr7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:47:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 20FED61288;
        Thu,  1 Apr 2021 14:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617286199;
        bh=TDLUzw4MMzO7aDwvC0yr2aYJe8IBkudM8ks/SAnPVIc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MAvctnmQJ8sDD1P6uOlOyiAJUW9AvADDffHo+VPZb/uxh1DjdwcnfKEUSNLlHhUMi
         RgQZTeyhmQTAfSzZIpphgOwA34new/QxvN1BkuNTAN09X/4+p0e+OV8giLPwou3M2Q
         h8gONp/2xpYqb9vsrm0I+5LXw0N32mujvOzuOQ3Y=
Date:   Thu, 1 Apr 2021 16:09:57 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yongji Xie <xieyongji@bytedance.com>
Cc:     devel@driverdev.osuosl.org, tkjos@android.com,
        Kees Cook <keescook@chromium.org>, maco@android.com,
        Jason Wang <jasowang@redhat.com>, joel@joelfernandes.org,
        Christoph Hellwig <hch@infradead.org>,
        Hridya Valsaraju <hridya@google.com>, arve@android.com,
        viro@zeniv.linux.org.uk, Sargun Dhillon <sargun@sargun.me>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: Re: Re: Re: [PATCH 2/2] binder: Use receive_fd() to receive file
 from another process
Message-ID: <YGXUNfsExs6tZD0c@kroah.com>
References: <20210401090932.121-1-xieyongji@bytedance.com>
 <20210401090932.121-3-xieyongji@bytedance.com>
 <YGWYZYbBzglUCxB2@kroah.com>
 <CACycT3ux9NVu_L=Vse7v-xbwE-K0-HT-e-Ei=yHOQmF66nGjeQ@mail.gmail.com>
 <YGWjh7qCJ8HJpFxv@kroah.com>
 <CACycT3uEGRiDuOj2XBwF2PmnGXsQgrLDemJDFRytsJiJMyRWDw@mail.gmail.com>
 <YGWvbAXQO2Vsiupo@kroah.com>
 <CACycT3vNaDg5twEpKtnZTjbyD=0FhZKJLzH+uBNQuyCmxFaeww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACycT3vNaDg5twEpKtnZTjbyD=0FhZKJLzH+uBNQuyCmxFaeww@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 01, 2021 at 08:28:02PM +0800, Yongji Xie wrote:
> On Thu, Apr 1, 2021 at 7:33 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Apr 01, 2021 at 07:29:45PM +0800, Yongji Xie wrote:
> > > On Thu, Apr 1, 2021 at 6:42 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Thu, Apr 01, 2021 at 06:12:51PM +0800, Yongji Xie wrote:
> > > > > On Thu, Apr 1, 2021 at 5:54 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > > >
> > > > > > On Thu, Apr 01, 2021 at 05:09:32PM +0800, Xie Yongji wrote:
> > > > > > > Use receive_fd() to receive file from another process instead of
> > > > > > > combination of get_unused_fd_flags() and fd_install(). This simplifies
> > > > > > > the logic and also makes sure we don't miss any security stuff.
> > > > > >
> > > > > > But no logic is simplified here, and nothing is "missed", so I do not
> > > > > > understand this change at all.
> > > > > >
> > > > >
> > > > > I noticed that we have security_binder_transfer_file() when we
> > > > > transfer some fds. I'm not sure whether we need something like
> > > > > security_file_receive() here?
> > > >
> > > > Why would you?  And where is "here"?
> > > >
> > > > still confused,
> > > >
> > >
> > > I mean do we need to go through the file_receive seccomp notifier when
> > > we receive fd (use get_unused_fd_flags() + fd_install now) from
> > > another process in binder_apply_fd_fixups().
> >
> > Why?  this is internal things, why does seccomp come into play here?
> >
> 
> We already have security_binder_transfer_file() to control the sender
> process. So for the receiver process, do we need the seccomp too? Or
> do I miss something here?

I do not know, is this something that is a requirement that seccomp
handle all filesystem handles sent to a process?  I do not know the
seccomp "guarantee" that well, sorry.

greg k-h
