Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6C851DA38
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 May 2022 16:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442098AbiEFOQM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 May 2022 10:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442101AbiEFOQL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 May 2022 10:16:11 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.129.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 33AD867D0A
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 May 2022 07:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651846346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RM5hC72wouMRznT47lMMtck1s1JfmH/k+7sKB/Ax5EU=;
        b=F31z0Rgqx8fQEqu5FdOA9+XZvrbapTOai2LH+VdHyMYxSckzS4qxmvV6muGiEH0/ApSStE
        g/j0x6z6oP95tsacKIarG+HfkeSCu7WFzl2+Rab3Eobg9liRXhRG0fiK60Ax2BWIAlTJrU
        cgdoIzc03pxbIkCfbSXmqKtvhG7RuAw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-527-kOaKTxt8O5mKhA5bpgOCaQ-1; Fri, 06 May 2022 10:12:21 -0400
X-MC-Unique: kOaKTxt8O5mKhA5bpgOCaQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7F91E811E7A;
        Fri,  6 May 2022 14:12:20 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.8.114])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2BC5C46AC9D;
        Fri,  6 May 2022 14:12:20 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id DB412220463; Fri,  6 May 2022 10:12:19 -0400 (EDT)
Date:   Fri, 6 May 2022 10:12:19 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Dharmendra Hans <dharamhans87@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org, Bernd Schubert <bschubert@ddn.com>,
        Dharmendra Singh <dsingh@ddn.com>
Subject: Re: [PATCH v4 1/3] FUSE: Implement atomic lookup + create
Message-ID: <YnUsw4O3F4wgtxTr@redhat.com>
References: <20220502102521.22875-1-dharamhans87@gmail.com>
 <20220502102521.22875-2-dharamhans87@gmail.com>
 <YnGIUOP2BezDAb1k@redhat.com>
 <CACUYsyGoX+o19u41cZyF92eDBO-9rFN_EEWBvWBGrEMuNn29Mw@mail.gmail.com>
 <YnKR9CFYPXT1bM1F@redhat.com>
 <CACUYsyG+QRyObnD5eaD8pXygwBRRcBrGHLCUZb2hmMZbFOfFTg@mail.gmail.com>
 <YnPeqPTny1Eeat9r@redhat.com>
 <CACUYsyG9mKQK+pWcAcWFEtC2ad0_OBU6NZgBC965ZxQy5_JiXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACUYsyG9mKQK+pWcAcWFEtC2ad0_OBU6NZgBC965ZxQy5_JiXQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 06, 2022 at 11:04:05AM +0530, Dharmendra Hans wrote:
> On Thu, May 5, 2022 at 7:56 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > On Thu, May 05, 2022 at 10:21:21AM +0530, Dharmendra Hans wrote:
> > > On Wed, May 4, 2022 at 8:17 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > > >
> > > > On Wed, May 04, 2022 at 09:56:49AM +0530, Dharmendra Hans wrote:
> > > > > On Wed, May 4, 2022 at 1:24 AM Vivek Goyal <vgoyal@redhat.com> wrote:
> > > > > >
> > > > > > On Mon, May 02, 2022 at 03:55:19PM +0530, Dharmendra Singh wrote:
> > > > > > > From: Dharmendra Singh <dsingh@ddn.com>
> > > > > > >
> > > > > > > When we go for creating a file (O_CREAT), we trigger
> > > > > > > a lookup to FUSE USER SPACE. It is very  much likely
> > > > > > > that file does not exist yet as O_CREAT is passed to
> > > > > > > open(). This lookup can be avoided and can be performed
> > > > > > > as part of create call into libfuse.
> > > > > > >
> > > > > > > This lookup + create in single call to libfuse and finally
> > > > > > > to USER SPACE has been named as atomic create. It is expected
> > > > > > > that USER SPACE create the file, open it and fills in the
> > > > > > > attributes which are then used to make inode stand/revalidate
> > > > > > > in the kernel cache. Also if file was newly created(does not
> > > > > > > exist yet by this time) in USER SPACE then it should be indicated
> > > > > > > in `struct fuse_file_info` by setting a bit which is again used by
> > > > > > > libfuse to send some flags back to fuse kernel to indicate that
> > > > > > > that file was newly created. These flags are used by kernel to
> > > > > > > indicate changes in parent directory.
> > > > > >
> > > > > > Reading the existing code a little bit more and trying to understand
> > > > > > existing semantics. And that will help me unerstand what new is being
> > > > > > done.
> > > > > >
> > > > > > So current fuse_atomic_open() does following.
> > > > > >
> > > > > > A. Looks up dentry (if d_in_lookup() is set).
> > > > > > B. If dentry is positive or O_CREAT is not set, return.
> > > > > > C. If server supports atomic create + open, use that to create file and
> > > > > >    open it as well.
> > > > > > D. If server does not support atomic create + open, just create file
> > > > > >    using "mknod" and return. VFS will take care of opening the file.
> > > > > >
> > > > > > Now with this patch, new flow is.
> > > > > >
> > > > > > A. Look up dentry if d_in_lookup() is set as well as either file is not
> > > > > >    being created or fc->no_atomic_create is set. This basiclally means
> > > > > >    skip lookup if atomic_create is supported and file is being created.
> > > > > >
> > > > > > B. Remains same. if dentry is positive or O_CREATE is not set, return.
> > > > > >
> > > > > > C. If server supports new atomic_create(), use that.
> > > > > >
> > > > > > D. If not, if server supports atomic create + open, use that
> > > > > >
> > > > > > E. If not, fall back to mknod and do not open file.
> > > > > >
> > > > > > So to me this new functionality is basically atomic "lookup + create +
> > > > > > open"?
> > > > > >
> > > > > > Or may be not. I see we check "fc->no_create" and fallback to mknod.
> > > > > >
> > > > > >         if (fc->no_create)
> > > > > >                 goto mknod;
> > > > > >
> > > > > > So fc->no_create is representing both old atomic "create + open" as well
> > > > > > as new "lookup + create + open" ?
> > > > > >
> > > > > > It might be obvious to you, but it is not to me. So will be great if
> > > > > > you shed some light on this.
> > > > > >
> > > > >
> > > > > I think you got it right now. New atomic create does what you
> > > > > mentioned as new flow.  It does  lookup + create + open in single call
> > > > > (being called as atomic create) to USER SPACE.mknod is a special case
> > > >
> > > > Ok, naming is little confusing. I think we will have to put it in
> > > > commit message and where you define FUSE_ATOMIC_CREATE that what's
> > > > the difference between FUSE_CREATE and FUSE_ATOMIC_CREATE. This is
> > > > ATOMIC w.r.t what?
> > >
> > > Sure, I would update the commit message to make the distinction clear
> > > between the two. This operation is atomic w.r.t to USER SPACE FUSE
> > > implementations. i.e USER SPACE would be performing all these
> > > operations in a single call to it.
> >
> > I think even FUSE_CREAT is doing same thing. Creating file, opening and
> > doing lookup and sending all the data. So that's not the difference
> > between the two, IMHO. And that's why I am getting confused with the
> > naming.
> >
> > From user space file server perspective, only extra operation seems
> > to be that it sends a flag in response telling the client whether
> > file was actually created or it already existed. So to me it just
> > sounds little extension of existing FUSE_CREATE command and that's
> > why I thought calling it FUSE_CREATE_EXT is probably better naming.
> 
> The difference between the two is of atomicity from top to bottom i.e
> single call from fuse kernel to user space file server. Generally
> FUSE_CREATE goes upto libfuse low level API as atomic (check
> fuse_lib_create()) and it gets separated there into two calls (create
> + getattr). This is not what we want as it results in two network
> trips each for create and lookup to the file server.

Ok, looks like your fuse file server is talking to a another file
server on network and that's why you are mentioning two network trips.

Let us differentiate between two things first. 

A. FUSE protocol semantics
B. Implementation of FUSE protocl by libfuse.

I think I am stressing on A and you are stressing on B. I just want
to see what's the difference between FUSE_CREATE and FUSE_ATOMIC_CREATE
from fuse protocol point of view. Again look at from kernel's point of
view and don't worry about libfuse is going to implement it.
Implementations can vary.

From kernel's perspective FUSE_CREATE is supposed to create + open a 
file. It is possible file already exists. Look at include/fuse_lowlevel.h
description for create().

        /**
         * Create and open a file
         *
         * If the file does not exist, first create it with the specified
         * mode, and then open it.
         */

I notice that fuse is offering a high level API as well as low level
API. I primarily know about low level API. To me these are just two
different implementation but things don't change how kernel sends
fuse messages and what it expects from server in return.

Now with FUSE_ATOMIC_CREATE, from kernel's perspective, only difference
is that in reply message file server will also indicate if file was
actually created or not. Is that right?

And I am focussing on this FUSE API apsect. I am least concerned at
this point of time who libfuse decides to actually implement FUSE_CREATE
or FUSE_ATOMIC_CREATE etc. You might make a single call in libfuse 
server (instead of two) and that's performance optimization in libfuse.
Kernel does not care how many calls did you make in file server to
implement FUSE_CREATE or FUSE_ATOMIC_CREATE. All it cares is that
create and open the file.

So while you might do things in more atomic manner in file server and
cut down on network traffic, kernel fuse API does not care. All it cares
about is create + open a file.

Anyway, from kernel's perspective, I think you should be able to
just use FUSE_CREATE and still be do "lookup + create + open".
FUSE_ATOMIC_CREATE is just allows one additional optimization so
that you know whether to invalidate parent dir's attrs or not.

In fact kernel is not putting any atomicity requirements as well on
file server. And that's why I think this new command should probably
be called FUSE_CREATE_EXT because it just sends back additional
info.

All the atomicity stuff you have been describing is that you are
trying to do some optimizations in libfuse implementation to implement
FUSE_ATOMIC_CREATE so that you send less number of commands over
network. That's a good idea but fuse kernel API does not require you
do these atomically, AFAICS. 

Given I know little bit of fuse low level API, If I were to implement
this in virtiofs/passthrough_ll.c, I probably will do following.

A. Check if caller provided O_EXCL flag.
B. openat(O_CREAT | O_EXCL)
C. If success, we created the file. Set file_created = 1.

D. If error and error != -EEXIST, send error back to client.
E. If error and error == -EEXIST, if caller did provide O_EXCL flag,
   return error.
F. openat() returned -EEXIST and caller did not provide O_EXCL flag,
   that means file already exists.  Set file_created = 0.
G. Do lookup() etc to create internal lo_inode and stat() of file.
H. Send response back to client using fuse_reply_create(). 
   
This is one sample implementation for fuse lowlevel API. There could
be other ways to implement. But all that is libfuse + filesystem
specific and kernel does not care how many operations you use to
complete and what's the atomicity etc. Of course less number of
operations you do better it is.

Anyway, I think I have said enough on this topic. IMHO, FUSE_CREATE
descritpion (fuse_lowlevel.h) already mentions that "If the file does not
exist, first create it with the specified mode and then open it". That
means intent of protocol is that file could already be there as well.
So I think we probably should implement this optimization (in kernel)
using FUSE_CREATE command and then add FUSE_CREATE_EXT to add optimization
about knowing whether file was actually created or not.

W.r.t libfuse optimizations, I am not sure why can't you do optimizations
with FUSE_CREATE and why do you need FUSE_CREATE_EXT necessarily. If
are you worried that some existing filesystems will break, I think
you can create an internal helper say fuse_create_atomic() and then
use that if filesystem offers it. IOW, libfuse will have two
ways to implement FUSE_CREATE. And if filesystem offers a new way which
cuts down on network traffic, libfuse uses more efficient method. We
should not have to change kernel FUSE API just because libfuse can
do create + open operation more efficiently.

By introducing FUSE_ATOMIC_CREATE and hiding new implementation behind
it, I think we are mixing things and that's why it is getting confusing.

Thanks
Vivek


> 
> >
> > >
> > >
> > > > May be atomic here means that "lookup + create + open" is a single operation.
> > > > But then even FUSE_CREATE is atomic because "creat + open" is a single
> > > > operation.
> > > >
> > > > In fact FUSE_CREATE does lookup anyway and returns all the information
> > > > in fuse_entry_out.
> > > >
> > > > IIUC, only difference between FUSE_CREATE and FUSE_ATOMIC_CREATE is that
> > > > later also carries information in reply whether file was actually created
> > > > or not (FOPEN_FILE_CREATED). This will be set if file did not exist
> > > > already and it was created indeed. Is that right?
> > >
> > > FUSE_CREATE is atomic but upto level of libfuse. Libfuse separates it
> > > into two calls, create and lookup separately into USER SPACE FUSE
> > > implementation.
> >
> > I am not sure what do you mean by "libfuse separates it into two calls,
> > create and lookup separately". I guess you are referring to lo_create()
> > in example/passthrough_ll.c which first creates and opens file and
> > then looks it up and replies.
> >
> >         fd = openat(lo_fd(req, parent), name,
> >                     (fi->flags | O_CREAT) & ~O_NOFOLLOW, mode);
> >         err = lo_do_lookup(req, parent, name, &e);
> >         fuse_reply_create(req, &e, fi);
> >
> > I am looking at your proposal for atomic_create implementation here.
> >
> > https://github.com/libfuse/libfuse/pull/673/commits/88cd25b2857f2bb213d01afbcfd666787d1e6893#diff-a36385ec8fb753d6f4492a5f0d3c6a5750bd370b50df6ef0610efdcd3f8880ffR787
> >
> > It is doing exactly same thing as lo_create(), except one difference that
> > it is checking first if file exists. It essentially is doing this.
> >
> > A. newfd = openat(lo_fd(req, parent), name, O_PATH | O_NOFOLLOW);
> > B. fd = openat(lo_fd(req, parent), name,
> >                     (fi->flags | O_CREAT) & ~O_NOFOLLOW, mode);
> > C. err = lo_do_lookup(req, parent, name, &e);
> > D. fuse_reply_create(req, &e, fi);
> >
> > So what do you mean by libfuse makes it two calls.
> >
> > And I think above implementation is racy. What if filesystem is
> > shared and another client creates the file between calls to
> > A and B. You will think you created the file but some other
> > client created it.
> >
> > So if intent is to know whether we created the file or not, then
> > you should probably do openat() with O_EXCL flag. If that succeeds
> > you know you created the file. If it fails with -EEXIST, then you
> > know file is already there. That's what virtiofs does.
> >
> > Anyway, coming back to the point. IMHO, from server perspective,
> > there is no atomicity difference between FUSE_CREATE and
> > FUSE_ATOMIC_CREATE. Only difference seems to be to send addditional
> > information back to the client to tell it whether file was created
> > or not.
> >
> > In fact for shared filesystem this is probably a problem. What if
> > guest's cache is stale and it does not know about the file. A client
> > B creates the file and we think we did not create the file. And we
> > will return with FOPEN_FILE_CREATED = 0. And in that case client
> > will not call fuse_dir_changed(). But that seems wrong in case
> > of shared filesystems. I am concerned about virtiofs which can
> > be shared between different guests.
> >
> > Miklos, WDYT?
> >
> > May be it is not a huge concern. If one guest drops a file, other guest
> > will not invalidate its dir attrs till timeout happens. Case of shared
> > filesystem is very tricky with fuse. And sometimes it is not clear
> > to me what kind of coherency matters.
> >
> > So in this case say I am booted with cache=auto, if guest B drops a file
> > bar/foo.txt and guest A does open(bar/foo.txt, O_CREAT), then should
> > guest A invalidate the attrs of bar/ right away or it will be invalidated
> > anyway after a second.
> >
> > Anyway.., my core point is that difference between FUSE_CREATE and
> > FUSE_ATOMIC_CREATE is just one flag FOPEN_FILE_CREATED which tells
> > client whether file was actually created or not. And that is used
> > to determine whether to invalidate parent dir attributes or not. It
> > does not have anything extra in terms of ATOMICITY as far as I can
> > see and that's what confuses me.
> 
> You checked the wrong code. pasthrough_ll is not production code, we
> do not use it at all, just using it to test these patches here. There
> is a main patch which implements atomic create in libfuse for low
> level api(). It is in same pull request, check it here
> https://github.com/libfuse/libfuse/pull/673/commits/f86fe92bef7bb529ef1617e077d69a39eb26bc9f
> 
> What this FUSE_ATOMIC_CREATE(fuse_lib_atomic_create()) does in libfuse
> is it make a single call into fuse_operations where file server would
> be doing all 'lookup + create + open' in one call itself  whereas
> FUSE_CREATE gets separated into two calls 'create + lookup' which
> eventually are two rpcs to the user space file server for a single
> operation.  Now you can see FUSE_CREATE  is not atomic from file
> systems point of view(i.e  from user space file server perspective)
> but from fuse kernel point of view only. We can make existing libfuse
> code i.e fuse_lib_create() to call new atomic create but then the
> interface becomes messy and it might start a trend to twist libfuse.
> We want to keep libfuse APIs neat and clean. And do not break existing
> systems. No flag from fuse kernel to libfuse to decide which code to
> traverse.  Therefore a new call for all this work.
> 
> >
> >
> >
> > > This FUSE_ATOMIC_CREATE does all these ops in a single call to FUSE
> > > implementations.  We do not want to break any existing FUSE
> > > implementations, therefore it is being introduced as a new feature. I
> > > forgot to include links to libfuse patches as well. That would have
> > > made it much clearer.  Here is the link to libfuse patch for this call
> > > https://github.com/libfuse/libfuse/pull/673.
> > >
> > > >
> > > > I see FOPEN_FILE_CREATED is being used to avoid calling
> > > > fuse_dir_changed(). That sounds like a separate optimization and probably
> > > > should be in a separate patch.
> > >
> > > FUSE_ATOMIC_CREATE needs to send back info about if  file was actually
> > > created or not (This is suggestion from Miklos) to correctly convey if
> > > the parent dir is really changing or not. I included this as part of
> > > this patch itself instead of having it as a separate patch.
> >
> > This needs little more thought w.r.t shared filesystems.
> >
> > >
> > > > IOW, I think this patch should be broken in to multiple pieces. First
> > > > piece seems to be avoiding lookup() and given the way it is implemented,
> > > > looks like we can avoid lookup() even by using existing FUSE_CREATE
> > > > command. We don't necessarily need FUSE_ATOMIC_CREATE. Is that right?
> > >
> > > Its not only about changing fuse kernel code but USER SPACE
> > > implementations also. If we change the you are suggesting we would be
> > > required to twist many things at libfuse and FUSE low level API. So to
> > > keep things simple and not to break any existing implementations we
> > > have kept it as new call (we now pass `struct stat` to USER SPACE FUSE
> > > to filled in).
> > >
> > > > And once that is done, a separate patch should probably should explain
> > > > the problem and say fuse_dir_changed() call can be avoided if we knew
> > > > if file was actually created or it was already existing there. And that's
> > > > when one need to introduce a new command. Given this is just an extension
> > > > of existing FUSE_CREATE command and returns additiona info about
> > > > FOPEN_FILE_CREATED, we probably should simply call it FUSE_CREATE_EXT
> > > > and explain how this operation is different from FUSE_CREATE.
> > >
> > > As explained above, we are not doing this way as we have kept in mind
> > > all existing libfuse APIs as well.
> > >
> >
> > I am not seeing what will break in existing passthrough_ll.c if I
> > simply used FUSE_CREATE for a file which already exists.
> >
> >         fd = openat(lo_fd(req, parent), name,
> >                     (fi->flags | O_CREAT) & ~O_NOFOLLOW, mode);
> >
> > This call should still succeed even if file already exists. (until and
> > unless called it with O_EXCL and in that case failing is the correct
> > behavior).
> 
> It's not passthrogh_ll but low level libfuse API. Passthrough_ll is
> just another user of low level API. It has been used just to test
> these patches. We do not use passthrough_ll at all for any other
> purpose.
> 

