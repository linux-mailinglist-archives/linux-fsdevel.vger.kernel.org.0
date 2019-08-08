Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1456886645
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2019 17:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390106AbfHHPyh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Aug 2019 11:54:37 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43515 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728380AbfHHPyg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Aug 2019 11:54:36 -0400
Received: by mail-ot1-f65.google.com with SMTP id j11so20112029otp.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Aug 2019 08:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=1sg8blSc4ktjYIlt+M6GsnZLOv8BJShN+hn4djS78FU=;
        b=mIYi4WLdXWIumYUeDN6cnMSHjo105PssVlySrSrAVFJKfZh7TG7G1RZKLuO0anDBNn
         Gpnfx6gn2opmmlvwQseCzMTgVv+uXDvkLCMriVnjJhLokn6wtZyLTMn2gOBWAr9LCuPf
         G4kK+52fIKN7be4D1f3ZhgCD800bY35k9o3y+zvQd444Ef03+RM4DOdnt8SHstppzGiH
         igaYPm42NustljaIDod+NbLxlQCR6takH+feS2j2eSO0d4pYYq7DYt5tQ6WSls8gUiD5
         tMdLP7V8Dq+rN8oZTwJ0TW37Oc06Dcxd+8TDUXqz56XIavRmx6HCagDr9ou5ZZUJh1hz
         e8Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=1sg8blSc4ktjYIlt+M6GsnZLOv8BJShN+hn4djS78FU=;
        b=IjC56MQJe1VXei8xQOQDSQig86+XfnCEvSJtVC/5+slmFM0jorvC3uSHZqCIiqM2MO
         7CnUKUIlHoY7z2CA1UDo4T7456c4rCYNb9/3juadtIhMmYJ1upquARiWokR7ApGxY9Hj
         z+tRxkT7Blo2LNUyTUE/FpdcDgrfngA0x+EXago7HVFFCLJHvfGk1+ji73yYObdBNVXz
         RxTm0tkEbSFeiimNONhUQRjcE63yCUI61DEYBwURmbxV3SCOzGvz7YlLBqy8tSnhY2Hr
         w1Z5miXMs0fRBRgDttlZ7x+08Ny+jcUitXWvAoaru/jojqTPbCXRnm4Vsb7Zxtd297sj
         GoJQ==
X-Gm-Message-State: APjAAAVItpZq93aFjiusVn/FjOItEB6OLN2ZPlOeXNkOIH2vtxVJHL5P
        JI+P3Tw488VF5xTO1pQcq1TdRQ==
X-Google-Smtp-Source: APXvYqxx6/FJYqhLJnvLciidKkcc3FlpTPip8iGEIy8CrynVdPXCprALbLDJgDY0Mq5eplxkiyU7pQ==
X-Received: by 2002:a9d:6150:: with SMTP id c16mr12962711otk.21.1565279675432;
        Thu, 08 Aug 2019 08:54:35 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id q11sm29370290oij.16.2019.08.08.08.54.33
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Aug 2019 08:54:34 -0700 (PDT)
Date:   Thu, 8 Aug 2019 08:54:16 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Al Viro <viro@zeniv.linux.org.uk>
cc:     Christoph Hellwig <hch@lst.de>, Hugh Dickins <hughd@google.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        David Howells <dhowells@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCHv2 2/3] i915: convert to new mount API
In-Reply-To: <20190808012314.GK1131@ZenIV.linux.org.uk>
Message-ID: <alpine.LSU.2.11.1908080813380.12321@eggly.anvils>
References: <20190805160307.5418-1-sergey.senozhatsky@gmail.com> <20190805160307.5418-3-sergey.senozhatsky@gmail.com> <20190805181255.GH1131@ZenIV.linux.org.uk> <20190805182834.GI1131@ZenIV.linux.org.uk> <alpine.LSU.2.11.1908060007190.1941@eggly.anvils>
 <20190807063002.GG6627@lst.de> <20190808012314.GK1131@ZenIV.linux.org.uk>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 8 Aug 2019, Al Viro wrote:
> On Wed, Aug 07, 2019 at 08:30:02AM +0200, Christoph Hellwig wrote:
> > On Tue, Aug 06, 2019 at 12:50:10AM -0700, Hugh Dickins wrote:
> > > Though personally I'm averse to managing "f"objects through
> > > "m"interfaces, which can get ridiculous (notably, MADV_HUGEPAGE works
> > > on the virtual address of a mapping, but the huge-or-not alignment of
> > > that mapping must have been decided previously).  In Google we do use
> > > fcntls F_HUGEPAGE and F_NOHUGEPAGE to override on a per-file basis -
> > > one day I'll get to upstreaming those.
> > 
> > Such an interface seems very useful, although the two fcntls seem a bit
> > odd.
> > 
> > But I think the point here is that the i915 has its own somewhat odd
> > instance of tmpfs.  If we could pass the equivalent of the huge=*
> > options to shmem_file_setup all that garbage (including the
> > shmem_file_setup_with_mnt function) could go away.
> 
> ... or follow shmem_file_super() with whatever that fcntl maps to
> internally.  I would really love to get rid of that i915 kludge.

As to the immediate problem of i915_gemfs using remount_fs on linux-next,
IIUC, all that is necessary at the moment is the deletions patch below
(but I'd prefer that to come from the i915 folks).  Since gemfs has no
need to change the huge option from its default to its default.

As to the future of when they get back to wanting huge pages in gemfs,
yes, that can probably best be arranged by using the internals of an
fcntl F_HUGEPAGE on those objects that would benefit from it.

Though my intention there was that the "huge=never" default ought
to continue to refuse to give huge pages, even when asked by fcntl.
So a little hackery may still be required, to allow the i915_gemfs
internal mount to get huge pages when a user mount would not.

As to whether shmem_file_setup_with_mnt() needs to live: I've given
that no thought, but accept that shm_mnt is such a ragbag of different
usages, that i915 is right to prefer their own separate gemfs mount.

Hugh

--- mmotm/drivers/gpu/drm/i915/gem/i915_gemfs.c	2019-07-21 19:40:16.573703780 -0700
+++ linux/drivers/gpu/drm/i915/gem/i915_gemfs.c	2019-08-08 07:19:23.967689058 -0700
@@ -24,28 +24,6 @@ int i915_gemfs_init(struct drm_i915_priv
 	if (IS_ERR(gemfs))
 		return PTR_ERR(gemfs);
 
-	/*
-	 * Enable huge-pages for objects that are at least HPAGE_PMD_SIZE, most
-	 * likely 2M. Note that within_size may overallocate huge-pages, if say
-	 * we allocate an object of size 2M + 4K, we may get 2M + 2M, but under
-	 * memory pressure shmem should split any huge-pages which can be
-	 * shrunk.
-	 */
-
-	if (has_transparent_hugepage()) {
-		struct super_block *sb = gemfs->mnt_sb;
-		/* FIXME: Disabled until we get W/A for read BW issue. */
-		char options[] = "huge=never";
-		int flags = 0;
-		int err;
-
-		err = sb->s_op->remount_fs(sb, &flags, options);
-		if (err) {
-			kern_unmount(gemfs);
-			return err;
-		}
-	}
-
 	i915->mm.gemfs = gemfs;
 
 	return 0;
