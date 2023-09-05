Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4FD87924BA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Sep 2023 18:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbjIEP7d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Sep 2023 11:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353920AbjIEIhk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Sep 2023 04:37:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666C0CC7;
        Tue,  5 Sep 2023 01:37:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 26528B810DD;
        Tue,  5 Sep 2023 08:37:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0789DC433C7;
        Tue,  5 Sep 2023 08:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693903053;
        bh=nWeFZ6k8Xp2HYyQVWrIflEtvKs0At25doDrjBv8b9Xc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a3KHuyxON2Cfx5cByngTSUvF71JgIUfFtllAa+zWBn9rRYKAHtQ9ka6PE+09g79Hz
         sX+sNvCxZLg2to1VPXIkSdgKsgfQcA6xCMYt7VcWyd9XjDpdo7ldqBve5ALXm0xDdZ
         botAFOkfLQsBhy6M1ekNwvEZ00SKJ6UT1xgTMg5SO+gSjG1/E2fENKSQ16vknBKPsu
         lf9dLvshd2atW9l4L2oGMdbhZ2EwWQaV29c2PW5o3DSfINtmyz5rDHTTfgzpTf9NCy
         ldWaLCjTq+pzip/g28puzBobSJnYRwS/NzcE+6zYHzbjxhKuMavqULzt8AoJJR6uxn
         m4ziyG4KZGCZw==
Date:   Tue, 5 Sep 2023 10:37:27 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     =?utf-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jeff Xu <jeffxu@google.com>, Aleksa Sarai <cyphar@cyphar.com>,
        Daniel Verkamp <dverkamp@chromium.org>,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/2] fcntl: add fcntl(F_CHECK_ORIGINAL_MEMFD)
Message-ID: <20230905-ungehalten-umkehren-9cff581cffce@brauner>
References: <20230831203647.558079-1-mclapinski@google.com>
 <20230831203647.558079-2-mclapinski@google.com>
 <20230901-lockt-erbfolge-e1f9a26f0d63@brauner>
 <CAAi7L5f1KYrAyCYLzUN0dSy6xuQCGcC7SQML4+KUdxnQ6RaFfg@mail.gmail.com>
 <202309011133.10D66D0785@keescook>
 <20230904-meistens-umeinander-3366194553a1@brauner>
 <CAAi7L5eW1ZOfwvFz4b9As7-MkKyCgCQcG-41VMv6vfYpyRW_eA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAi7L5eW1ZOfwvFz4b9As7-MkKyCgCQcG-41VMv6vfYpyRW_eA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 04, 2023 at 07:57:03PM +0200, Michał Cłapiński wrote:
> On Mon, Sep 4, 2023 at 9:29 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Fri, Sep 01, 2023 at 11:34:32AM -0700, Kees Cook wrote:
> > > On Fri, Sep 01, 2023 at 04:50:53PM +0200, Michał Cłapiński wrote:
> > > > On Fri, Sep 1, 2023 at 2:56 PM Christian Brauner <brauner@kernel.org> wrote:
> > > > >
> > > > > On Thu, Aug 31, 2023 at 10:36:46PM +0200, Michal Clapinski wrote:
> > > > > > Add a way to check if an fd points to the memfd's original open fd
> > > > > > (the one created by memfd_create).
> > > > > > Useful because only the original open fd can be both writable and
> > > > > > executable.
> > > > > >
> > > > > > Signed-off-by: Michal Clapinski <mclapinski@google.com>
> > > > > > ---
> > > > > >  fs/fcntl.c                 | 3 +++
> > > > > >  include/uapi/linux/fcntl.h | 9 +++++++++
> > > > > >  2 files changed, 12 insertions(+)
> > > > > >
> > > > > > diff --git a/fs/fcntl.c b/fs/fcntl.c
> > > > > > index e871009f6c88..301527e07a4d 100644
> > > > > > --- a/fs/fcntl.c
> > > > > > +++ b/fs/fcntl.c
> > > > > > @@ -419,6 +419,9 @@ static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
> > > > > >       case F_SET_RW_HINT:
> > > > > >               err = fcntl_rw_hint(filp, cmd, arg);
> > > > > >               break;
> > > > > > +     case F_CHECK_ORIGINAL_MEMFD:
> > > > > > +             err = !(filp->f_mode & FMODE_WRITER);

That by the way is broken or at least misleading.

Looking at the sealing stuff, it's only available for memfds, i.e.,
memfd_create(). Any non-memfds have F_SEAL_SEAL set meaning that setting
seals on any non-memfds fails.

But your check is available on any tmpfs or hugetlbfs file in addition
to memfds. In fact, it available for any file/fd...

But it has unclear meaning for anything that isn't a memfd_create() memfd.

> > > > > > +             break;
> > > > >
> > > > > Honestly, make this an ioctl on memfds. This is so specific that it
> > > > > really doesn't belong into fcntl().
> > > >
> > > > I've never touched ioctls but if I'm correct, I can't just add it to
> > > > memfd. I would have to add it to the underlying fs, so hugetlbfs and
> > > > shmem (which I think can be defined as ramfs so also there). File
> > > > sealing fcntl is already memfd specific. Are you sure ioctl will be a
> > > > better idea?
> >
> > fcntl() should be generic. Frankly, the sealing stuff should've gone
> > into an ioctl as well and only upgraded to a fcntl() once multiple fd
> > types support it.
> >
> 
> But ioctl is good for stuff related to the underlying fs, which this
> isn't. I'm worried if I rewrite it as an ioctl and put it in 3
> different places, the maintainers of shmem, hugetlbfs and ramfs will
> tell me to rewrite it as an fcntl. If a new filesystem pops up that
> can be used as the backend for memfd, the ioctl will also have to be
> added there.

I see your concern but first, the fact that memfd_create() was
implemented as a multiplexer over different filesystem types was a
deliberate choice. But that's not an argument to make us absorb an
ill-defined fcntl() addition. We're just up for a repeat if you decide
to add yet more fcntl()s later.

Second, looking at:

memfd_fcntl()
-> memfd_get_seals()
   -> memfd_file_seals_ptr()
      {
              if (shmem_file(file))
                      return &SHMEM_I(file_inode(file))->seals;
      
      #ifdef CONFIG_HUGETLBFS
              if (is_file_hugepages(file))
                      return &HUGETLBFS_I(file_inode(file))->seals;
      #endif
      
              return NULL;
      }

If you have a third backend then you need to handle that anyway. You
even need to add a new seals inode member to that new backend. So you
already fiddle with each backend to accomodate memfds.

Whether you do that to as a wrapper located in mm/memfd.c that's
callable from the fses ioctl implementation or through memfd_fcntl()
really isn't any more complicated.

(UNTESTED, FAILS TO COMPILE ON PURPOSE)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 316c4cebd3f3..bbdddcdc8936 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -1324,6 +1324,12 @@ static void init_once(void *foo)
 	inode_init_once(&ei->vfs_inode);
 }
 
+static int hugetlbfs_file_ioctl(struct file *file, unsigned int cmd, unsigned int arg)
+{
+	return memfd_ioctl(file, cmd, arg);
+}
+
 const struct file_operations hugetlbfs_file_operations = {
 	.read_iter		= hugetlbfs_read_iter,
 	.mmap			= hugetlbfs_file_mmap,
@@ -1331,6 +1337,8 @@ const struct file_operations hugetlbfs_file_operations = {
 	.get_unmapped_area	= hugetlb_get_unmapped_area,
 	.llseek			= default_llseek,
 	.fallocate		= hugetlbfs_fallocate,
+	.unlocked_ioctl		= hugetlbfs_file_ioctl,
+	.compat_ioctl		= hugetlbfs_file_ioctl,
 };
 
 static const struct inode_operations hugetlbfs_dir_inode_operations = {
diff --git a/include/linux/memfd.h b/include/linux/memfd.h
index e7abf6fa4c52..7e3c97ad842f 100644
--- a/include/linux/memfd.h
+++ b/include/linux/memfd.h
@@ -6,11 +6,16 @@
 
 #ifdef CONFIG_MEMFD_CREATE
 extern long memfd_fcntl(struct file *file, unsigned int cmd, unsigned int arg);
+long memfd_ioctl(struct file *file, unsigned int cmd, unsigned int arg);
 #else
 static inline long memfd_fcntl(struct file *f, unsigned int c, unsigned int a)
 {
 	return -EINVAL;
 }
+static inline long memfd_ioctl(struct file *file, unsigned int cmd, unsigned int arg)
+{

	PROPERLY DETECT A memfd_create() MEMFD INSTEAD OF F_SEAL_SEAL

+	return -EINVAL;
+}
 #endif
 
 #endif /* __LINUX_MEMFD_H */
diff --git a/mm/memfd.c b/mm/memfd.c
index 1cad1904fc26..4a26df1f4a91 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -243,6 +243,7 @@ static int memfd_get_seals(struct file *file)
 	return seals ? *seals : -EINVAL;
 }
 
+/* new memfd specific functionality goes into memfd_ioctl() */
 long memfd_fcntl(struct file *file, unsigned int cmd, unsigned int arg)
 {
 	long error;
@@ -254,6 +255,12 @@ long memfd_fcntl(struct file *file, unsigned int cmd, unsigned int arg)
 	case F_GET_SEALS:
 		error = memfd_get_seals(file);
 		break;
+	case F_SOMETHING_1:
+		error = memfd_something_1(file);
+		break;
+	case F_SOMETHING_1:
+		error = memfd_something_2(file);
+		break;
 	default:
 		error = -EINVAL;
 		break;
@@ -262,6 +269,22 @@ long memfd_fcntl(struct file *file, unsigned int cmd, unsigned int arg)
 	return error;
 }
 
+long memfd_ioctl(struct file *file, unsigned int cmd, unsigned int arg)
+{
+	long error;
+
+	switch (cmd) {
+	case F_SOMETHING_1:
+		error = memfd_something_1(file);
+		break;
+	case F_SOMETHING_1:
+		error = memfd_something_2(file);
+		break;
+	}
+
+	return memfd_fcntl(file, cmd, arg);
+}
+
 #define MFD_NAME_PREFIX "memfd:"
 #define MFD_NAME_PREFIX_LEN (sizeof(MFD_NAME_PREFIX) - 1)
 #define MFD_NAME_MAX_LEN (NAME_MAX - MFD_NAME_PREFIX_LEN)
diff --git a/mm/shmem.c b/mm/shmem.c
index 02e62fccc80d..6f580b2bf004 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -4445,6 +4445,11 @@ static int shmem_error_remove_page(struct address_space *mapping,
 	return 0;
 }
 
+static inline shmem_file_ioctl(struct file *file, unsigned int cmd, unsigned int arg)
+{
+	return memfd_ioctl(file, cmd, arg);
+}
+
 const struct address_space_operations shmem_aops = {
 	.writepage	= shmem_writepage,
 	.dirty_folio	= noop_dirty_folio,
@@ -4471,6 +4476,8 @@ static const struct file_operations shmem_file_operations = {
 	.splice_read	= shmem_file_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.fallocate	= shmem_fallocate,
+	.unlocked_ioctl	= shmem_file_ioctl,
+	.compat_ioctl	= shmem_file_ioctl,
 #endif
 };
 
> 
> > >
> > > Does this check "mean" anything for other files? Because if it's
> > > generically useful (and got renamed) it maybe would be right for
> > > fcntl...
> >
> > For regular files it just means that the file has gotten write access to
> > the underlying fs and we use this flag to release the necessary
> > refcounts/protections once the file is closed.
> >
> > If this check has any meaning beyond that than it only has meaning for
> > memfd. I'm also not sure why this checks FMODE_WRITER and not
> > FMODE_WRITE as FMODE_WRITER is almost an entirely internal thing that
> > only very specific codepaths need to know about.
> 
> If you reopen the memfd via /proc/<pid>/fd/ with O_RDWR, both file
> objects (the original and the reopened one) have FMODE_WRITE, so
> knowing if the flag is set gives me nothing. FMODE_WRITER is the only
> difference between the original fd and the reopened one. This flag
> also dictates whether `inode->i_writecount` will be decremented on
> close (in `put_file_access`) which influences exec()ability of the
> other fd. It surprised me too that this flag theoretically means
> "write access to underlying fs" but it's used to determine whether to
> decrement i_writecount.

It's not surprising at all. It's how read-write fds are created.
memfd_create() is the oddball because it uses an internal tmpfs
kernmount that's never remountable read-only afaict otherwise this would
be pretty broken as memfd_create() doesn't do the usual mark sb writable
and get write access to the mount dance and so the mount or sb could go
ro behind it's back.

And this has zero meaning for non-memfd. So NAK on fcntl(). However, as
an ioctl() on memfd backends we won't care.

And I would suggest to figure out a nicer way to differentiate between
memfd_create() and regular tmpfs/hugetlbfs files. So you can explicitly
detect them instead of this implict F_SEAL_SEALS dance. For example,
abuse a higher flag bit in unsigned int seals that both tmpfs and
hugetlbfs already have and set F_MEMFD or whatever. Or some other
mechanism. Just a thought.

Really, fcntl() is wrong here.
