Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 352AC824DB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2019 20:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730147AbfHES2p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Aug 2019 14:28:45 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:40246 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727802AbfHES2p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Aug 2019 14:28:45 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1huhik-00088X-Fk; Mon, 05 Aug 2019 18:28:34 +0000
Date:   Mon, 5 Aug 2019 19:28:34 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCHv2 2/3] i915: convert to new mount API
Message-ID: <20190805182834.GI1131@ZenIV.linux.org.uk>
References: <20190805160307.5418-1-sergey.senozhatsky@gmail.com>
 <20190805160307.5418-3-sergey.senozhatsky@gmail.com>
 <20190805181255.GH1131@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805181255.GH1131@ZenIV.linux.org.uk>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 05, 2019 at 07:12:55PM +0100, Al Viro wrote:
> On Tue, Aug 06, 2019 at 01:03:06AM +0900, Sergey Senozhatsky wrote:
> > tmpfs does not set ->remount_fs() anymore and its users need
> > to be converted to new mount API.
> 
> Could you explain why the devil do you bother with remount at all?
> Why not pass the right options when mounting the damn thing?

... and while we are at it, I really wonder what's going on with
that gemfs thing - among the other things, this is the only
user of shmem_file_setup_with_mnt().  Sure, you want your own
options, but that brings another question - is there any reason
for having the huge=... per-superblock rather than per-file?

After all, the readers of ->huge in mm/shmem.c are
mm/shmem.c:582:     (shmem_huge == SHMEM_HUGE_FORCE || sbinfo->huge) &&
	is_huge_enabled(), sbinfo is an explicit argument

mm/shmem.c:1799:        switch (sbinfo->huge) {
	shmem_getpage_gfp(), sbinfo comes from inode

mm/shmem.c:2113:                if (SHMEM_SB(sb)->huge == SHMEM_HUGE_NEVER)
	shmem_get_unmapped_area(), sb comes from file

mm/shmem.c:3531:        if (sbinfo->huge)
mm/shmem.c:3532:                seq_printf(seq, ",huge=%s", shmem_format_huge(sbinfo->huge));
	->show_options()
mm/shmem.c:3880:        switch (sbinfo->huge) {
	shmem_huge_enabled(), sbinfo comes from an inode

And the only caller of is_huge_enabled() is shmem_getattr(), with sbinfo
picked from inode.

So is there any reason why the hugepage policy can't be per-file, with
the current being overridable default?
