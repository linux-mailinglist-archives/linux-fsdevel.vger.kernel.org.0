Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39D1F43CC59
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Oct 2021 16:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242599AbhJ0Ojw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Oct 2021 10:39:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32222 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238718AbhJ0Ojr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Oct 2021 10:39:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635345440;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E1vyAZxABNWLffAypdcb6P/mlOFUhtHlP6sxjkFN/ww=;
        b=GZS1TyLhAF295aE0jlbp9kkLmUkEexsM6SQOThgBTFmPcy3WK63At6ElWP6QUMBsr3foVO
        c5za/iGRGIWx9IRnliTCgQ5qBUxqoWQmdLoy7Fm+um9SpV5J6EPOWkdsqyk4SaxrRb1kPF
        grjo6flbJp0UJUJ2IpY+phbnjHijzbc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-590-owj1BTSENIGtCyjHaGNYrw-1; Wed, 27 Oct 2021 10:37:17 -0400
X-MC-Unique: owj1BTSENIGtCyjHaGNYrw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DDE4D100725B;
        Wed, 27 Oct 2021 14:36:30 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.34.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5F49C196F4;
        Wed, 27 Oct 2021 14:36:30 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id D6BDB2204A5; Wed, 27 Oct 2021 10:36:24 -0400 (EDT)
Date:   Wed, 27 Oct 2021 10:36:24 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        JeffleXu <jefflexu@linux.alibaba.com>,
        Theodore Ts'o <tytso@mit.edu>, adilger.kernel@dilger.ca,
        linux-xfs@vger.kernel.org,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, dan.j.williams@intel.com,
        Christoph Hellwig <hch@lst.de>,
        Dave Chinner <dchinner@redhat.com>
Subject: Re: [Question] ext4/xfs: Default behavior changed after per-file DAX
Message-ID: <YXlj6GhxkFBQRJYk@redhat.com>
References: <26ddaf6d-fea7-ed20-cafb-decd63b2652a@linux.alibaba.com>
 <20211026154834.GB24307@magnolia>
 <YXhWP/FCkgHG/+ou@redhat.com>
 <20211026205730.GI3465596@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211026205730.GI3465596@iweiny-DESK2.sc.intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 26, 2021 at 01:57:31PM -0700, Ira Weiny wrote:
> On Tue, Oct 26, 2021 at 03:25:51PM -0400, Vivek Goyal wrote:
> > On Tue, Oct 26, 2021 at 08:48:34AM -0700, Darrick J. Wong wrote:
> > > On Tue, Oct 26, 2021 at 10:12:17PM +0800, JeffleXu wrote:
> > > > Hi,
> > > > 
> > > > Recently I'm working on supporting per-file DAX for virtiofs [1]. Vivek
> > > > Goyal and I are interested [2] why the default behavior has changed
> > > > since introduction of per-file DAX on ext4 and xfs [3][4].
> > > > 
> > > > That is, before the introduction of per-file DAX, when user doesn't
> > > > specify '-o dax', DAX is disabled for all files. After supporting
> > > > per-file DAX, when neither '-o dax' nor '-o dax=always|inode|never' is
> > > > specified, it actually works in a '-o dax=inode' way if the underlying
> > > > blkdev is DAX capable, i.e. depending on the persistent inode flag. That
> > > > is, the default behavior has changed from user's perspective.
> > > > 
> > > > We are not sure if this is intentional or not. Appreciate if anyone
> > > > could offer some hint.
> > > 
> > > Yes, that was an intentional change to all three filesystems to make the
> > > steps we expose to sysadmins/users consistent and documented officially:
> > > 
> > > https://lore.kernel.org/linux-fsdevel/20200429043328.411431-1-ira.weiny@intel.com/
> > 
> > Ok, so basically new dax options semantics are different from old "-o dax".
> > 
> > - dax=inode is default. This is change of behavior from old "-o dax" where
> >   default was *no dax* at all.
> 
> Again I think this is debatable.  The file system will still work and all files
> will, by default, _not_ use DAX.  Specifying '-o dax' or future proof '-o
> dax=always' will override this just like it did before.
> 
> > 
> > - I tried xfs and mount does not fail even if user mounted with
> >   "-o dax=inode" and underlying block device does not support dax.
> >   That's little strange. Some users might expect a failure if certain
> >   mount option can't be enabled.
> 
> But the mount option _is_ enabled.  It is just that the files can't be used in
> DAX mode.  The files can still have their inode flag set.  This was
> specifically discussed to support backing up file systems on devices which did
> not support DAX.  This allows you to restore that file system with all the
> proper inode flags in place.
> 
> If a DAX file is on a non-DAX device the file will not be in DAX mode when
> opened.  A statx() call can determine this.
> 
> > 
> >   So in general, what's the expected behavior with filesystem mount
> >   options. If user passes a mount option and it can't be enabled,
> >   should filesystem return error and force user to try again without
> >   the certain mount option or silently fallback to something else.
> 
> But it is enabled.
> 
> > 
> >   I think in the past I have come across overlayfs users which demanded
> >   that mount fails if certain overlayfs option they have passed in
> >   can't be honored. They want to know about it so that they can either
> >   fix the configuration or change mount option.
> 
> I understand how this is a bit convoluted.  However, for 99% of the users out
> there who are using DAX on DAX devices this is not going to change anything for
> them.  (Especially since they are all probably using '-o dax').
> 
> > 
> > - With xfs, I mounted /dev/pmem0 with "-o dax=inode" and checked
> >   /proc/mounts and I don't see "dax=inode" there. Is that intentional?
> 
> Yes absolutely.  I originally implemented it to show dax=inode and was told
> that default mount options were not to be shown.  After thinking about it I
> agreed.  It is intractable to print out all the mount options which are
> defaulted.  The user can read what the defaults are an know what the file
> system is using for options which are not overridden.
> 
> > 
> > I am just trying to wrap my head around the new semantics as we are
> > trying to implement those for virtiofs.
> > 
> > So following is the side affects of behavior change.
> > 
> > A. If somebody wrote scripts and scanned for mount flags to decide whehter
> >    dax is enabled or not, these will not work anymore. scripts will have
> >    to be changed to stat() every file in filesystem and look for
> >    STATX_ATTR_DAX flag to determine dax status.
> 
> Why would you need to stat() 'every' file?  Why, and to who, is it important
> that every file in the file system is in dax mode?

Only for debugging purpose say I want to know which mounts/files are using
DAX.

> I was getting the feeling
> that it was important to the client to know this on the server but you last
> email in the other thread has confused me on that point.[1]
> 
> 
> > 
> > I would have thought to not make dax=inode default and let user opt-in
> > for that using "dax=inode" mount option. But I guess people liked 
> > dax=inode default better.
> 
> Yes, because it gives the _end_ user (not the sys-admin) the control on their
> individual files.

Well, I can argue that _end_ user should get that control only if sysadmin
allows that. If sysadmin did not enable reflink feature, end user does not
get to use it.

Anyway, I think idea is that you did not want sys-admin to have to mount
xfs instance with dax=inode and have this feature be enabled by default
and that's why.

> 
> > 
> > Anway, I guess if we want to keep the behavior of virtiofs in-line with
> > ext4/xfs, we might have to make dax=inode default (atleast in client).
> 
> Yes, I think we should make dax=inode the default.
> 
> > Server default might be different because querying the state of
> > FS_XFLAG_DAX is extra ioctl() call on each LOOKUP and GETATTR call and
> > those who don't want to use DAX, might not want to pay this cost.
> 
> I've not responded on the other thread because I feel like I've reached the
> depth of my virtiofs knowledge.  From your email:
> 
> 	"In general, there is no connection between DAX in guest and device on
> 	host enabling DAX."[1]
> 
> But then you say:
> 
> 	"... if server does not support DAX and client asks for DAX, mount will
> 	fail. (As it should fail)."[1]

When I say server I mean "virtiofs daemon + qemu" combination. So qemu has
to specify that virtiofs device has a cache using option
"cache-size=<X>G". If this is missing, DAX can't be enabled in guest. This
is somewhat similar to whether underlying block device supports DAX or
not. In this case it signifies whether virtiofs device supports DAX or
not.

And this has nothing to do with host devieces capability of being able to
do DAX. 

> 
> So I decided I need to review the virtiofs code a bit to better understand this
> relationship.  Because I'm confused.
> 
> As to the subject of having a file based policy; any such policy is not the
> kernels job.  If users want to have different policies based on file size they
> are free to do that with dax=inode.  I don't see how that works with the other
> 2 mount options.

Right. File based policy will be in user space (virtiofsd). It will not
be part of kernel. In fat guest kernel will not even know what policy
is being used by server. Server will tell guest kernel whether to
enable DAX on a inode or not.

> 
> Furthermore, performance of different files may be device specific and moving a
> file from one device to another may result in the user wanting to change the
> mode, which dax=inode allows.
> 
> All of this this supports dax=inode as a better default.
> 
> I get the feeling that your most concerned with the admin user being able to
> see if the entire file system is in DAX mode.  Is that true?  And I can't argue
> that indeed that is different.

Right. I am looking at new dax options from the lens of old dax options
where I could easily look at mount options and tell whether filesystem
is using dax or not. And dax was disabled by default and user had to
opt-in to enable dax.

> But I'm failing to see the use case for that
> being a requirement.

Agreed that this is not necessarily a requirement. It is just little
different from old dax options. And I was only worried about users
being confused.

> 
> Is the biggest issue the lack of visibility to see if the device supports DAX?

Not necessarily. I think for me two biggest issues are.

- Should dax be enabled by default in server as well. If we do that,
  server will have to make extra ioctl() call on every LOOKUP and GETATTR
  fuse request. Local filesystems probably can easily query FS_XFLAGS_DAX
  state but doing extra syscall all the time will probably be some cost
  (No idea how much).

- So far if virtiofs is mounted without any of the dax options, just
  by looking at mount option, I could tell, DAX is not enabled on any
  of the files. But that will not be true anymore. Because dax=inode
  be default, it is possible that server upgrade enabled dax on some
  or all the files.

  I guess I will have to stick to same reason given by ext4/xfs. That is
  to determine whether DAX is enabled on a file or not, you need to
  query STATX_ATTR_DAX flag. That's the only way to conclude if DAX is
  being used on a file or not. Don't look at filesystem mount options
  and reach a conclusion (except the case of dax=never).

Thanks
Vivek

> 
> Ira
> 
> [1] https://lore.kernel.org/linux-fsdevel/YXgGlrlv9VBFVt2U@redhat.com/
> 

