Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 663BF866F0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2019 18:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733035AbfHHQYL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Thu, 8 Aug 2019 12:24:11 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:61521 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728020AbfHHQYL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Aug 2019 12:24:11 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 17933662-1500050 
        for multiple; Thu, 08 Aug 2019 17:24:00 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Al Viro <viro@zeniv.linux.org.uk>, Hugh Dickins <hughd@google.com>
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <alpine.LSU.2.11.1908080813380.12321@eggly.anvils>
Cc:     Christoph Hellwig <hch@lst.de>, Hugh Dickins <hughd@google.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Howells <dhowells@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Matthew Auld <matthew.auld@intel.com>
References: <20190805160307.5418-1-sergey.senozhatsky@gmail.com>
 <20190805160307.5418-3-sergey.senozhatsky@gmail.com>
 <20190805181255.GH1131@ZenIV.linux.org.uk>
 <20190805182834.GI1131@ZenIV.linux.org.uk>
 <alpine.LSU.2.11.1908060007190.1941@eggly.anvils>
 <20190807063002.GG6627@lst.de> <20190808012314.GK1131@ZenIV.linux.org.uk>
 <alpine.LSU.2.11.1908080813380.12321@eggly.anvils>
Message-ID: <156528143789.22627.18099397585070419297@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCHv2 2/3] i915: convert to new mount API
Date:   Thu, 08 Aug 2019 17:23:57 +0100
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Quoting Hugh Dickins (2019-08-08 16:54:16)
> On Thu, 8 Aug 2019, Al Viro wrote:
> > On Wed, Aug 07, 2019 at 08:30:02AM +0200, Christoph Hellwig wrote:
> > > On Tue, Aug 06, 2019 at 12:50:10AM -0700, Hugh Dickins wrote:
> > > > Though personally I'm averse to managing "f"objects through
> > > > "m"interfaces, which can get ridiculous (notably, MADV_HUGEPAGE works
> > > > on the virtual address of a mapping, but the huge-or-not alignment of
> > > > that mapping must have been decided previously).  In Google we do use
> > > > fcntls F_HUGEPAGE and F_NOHUGEPAGE to override on a per-file basis -
> > > > one day I'll get to upstreaming those.
> > > 
> > > Such an interface seems very useful, although the two fcntls seem a bit
> > > odd.
> > > 
> > > But I think the point here is that the i915 has its own somewhat odd
> > > instance of tmpfs.  If we could pass the equivalent of the huge=*
> > > options to shmem_file_setup all that garbage (including the
> > > shmem_file_setup_with_mnt function) could go away.
> > 
> > ... or follow shmem_file_super() with whatever that fcntl maps to
> > internally.  I would really love to get rid of that i915 kludge.
> 
> As to the immediate problem of i915_gemfs using remount_fs on linux-next,
> IIUC, all that is necessary at the moment is the deletions patch below
> (but I'd prefer that to come from the i915 folks).  Since gemfs has no
> need to change the huge option from its default to its default.
> 
> As to the future of when they get back to wanting huge pages in gemfs,
> yes, that can probably best be arranged by using the internals of an
> fcntl F_HUGEPAGE on those objects that would benefit from it.
> 
> Though my intention there was that the "huge=never" default ought
> to continue to refuse to give huge pages, even when asked by fcntl.
> So a little hackery may still be required, to allow the i915_gemfs
> internal mount to get huge pages when a user mount would not.
> 
> As to whether shmem_file_setup_with_mnt() needs to live: I've given
> that no thought, but accept that shm_mnt is such a ragbag of different
> usages, that i915 is right to prefer their own separate gemfs mount.
> 
> Hugh
> 
> --- mmotm/drivers/gpu/drm/i915/gem/i915_gemfs.c 2019-07-21 19:40:16.573703780 -0700
> +++ linux/drivers/gpu/drm/i915/gem/i915_gemfs.c 2019-08-08 07:19:23.967689058 -0700
> @@ -24,28 +24,6 @@ int i915_gemfs_init(struct drm_i915_priv
>         if (IS_ERR(gemfs))
>                 return PTR_ERR(gemfs);
>  
> -       /*
> -        * Enable huge-pages for objects that are at least HPAGE_PMD_SIZE, most
> -        * likely 2M. Note that within_size may overallocate huge-pages, if say
> -        * we allocate an object of size 2M + 4K, we may get 2M + 2M, but under
> -        * memory pressure shmem should split any huge-pages which can be
> -        * shrunk.
> -        */
> -
> -       if (has_transparent_hugepage()) {
> -               struct super_block *sb = gemfs->mnt_sb;
> -               /* FIXME: Disabled until we get W/A for read BW issue. */
> -               char options[] = "huge=never";
> -               int flags = 0;
> -               int err;
> -
> -               err = sb->s_op->remount_fs(sb, &flags, options);
> -               if (err) {
> -                       kern_unmount(gemfs);
> -                       return err;
> -               }
> -       }

That's perfectly fine; we should probably leave a hint as to why gemfs
exists and include the suggestion of looking at per-file hugepage
controls.

Matthew, how does this affect your current plans? If at all?
-Chris
