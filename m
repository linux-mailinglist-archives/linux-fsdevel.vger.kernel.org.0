Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE9837C0B1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 May 2021 16:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbhELOvq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 May 2021 10:51:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51337 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231440AbhELOvF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 May 2021 10:51:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620830996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/g/HcRWJK0OnvZH6C7dQC3u45Y7+3wQdH9PWZ/XlGkA=;
        b=VE3pEQu1YSTRvyy6eixs2nIgbiuMEuhbtahJnobTmZgAYPENe01+Za09wCOr52D8GY5icA
        dAE5fxQ8pnx4mDvLl6yrRu/P0Cy9/mLfarKyhxfHH6vMus3JlZ123FnPLtJyWOUBPShPED
        BXDMyP758V1g1Lg0yS37x6s134//XWU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-QQ8YxaF4PgCqJW1Ti-ivgA-1; Wed, 12 May 2021 10:49:52 -0400
X-MC-Unique: QQ8YxaF4PgCqJW1Ti-ivgA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 088C91074657;
        Wed, 12 May 2021 14:49:51 +0000 (UTC)
Received: from localhost (ovpn-114-114.ams2.redhat.com [10.36.114.114])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B41C660657;
        Wed, 12 May 2021 14:49:45 +0000 (UTC)
Date:   Wed, 12 May 2021 15:49:44 +0100
From:   "Richard W.M. Jones" <rjones@redhat.com>
To:     Shachar Sharon <synarete@gmail.com>
Cc:     miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, eblake@redhat.com,
        libguestfs@redhat.com
Subject: Re: [PATCH v2] fuse: Allow fallocate(FALLOC_FL_ZERO_RANGE)
Message-ID: <20210512144944.GY26415@redhat.com>
References: <20210512103704.3505086-1-rjones@redhat.com>
 <20210512103704.3505086-2-rjones@redhat.com>
 <YJvlyiTR7LVM4q1n@lpc>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YJvlyiTR7LVM4q1n@lpc>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 12, 2021 at 05:27:22PM +0300, Shachar Sharon wrote:
> On Wed, May 12, 2021 at 11:37:04AM +0100, Richard W.M. Jones wrote:
> >libnbd's nbdfuse utility would like to translate fallocate zero
> >requests into NBD_CMD_WRITE_ZEROES.  Currently the fuse module filters
> >these out, returning -EOPNOTSUPP.  This commit treats these almost the
> >same way as FALLOC_FL_PUNCH_HOLE except not calling
> >truncate_pagecache_range.
> >
> Why don't you call 'truncate_pagecache_range' ?

Very good point.  I just assumed that it would only be useful when
hole-punching, but now I actually read the description of the function
I see we need it.

Also looking at other filesystems that also support FALLOC_FL_ZERO_RANGE:

  ext4_zero_range -> calls truncate_pagecache_range
  f2fs_zero_range -> calls it
  xfs -> calls it indirectly
  btrfs_zero_range -> does not call it (?)

I'll add this, and retest everything.

> >A way to test this is with the following script:

In my next version I'll also address this script which is rather
long-winded.  I think there's an easier way for people to test this:

> >--------------------
> > #!/bin/bash
> > # Requires fuse >= 3, nbdkit >= 1.8, and latest nbdfuse from
> > # https://gitlab.com/nbdkit/libnbd/-/tree/master/fuse
> > set -e
> > set -x
> >
> > export output=$PWD/output
> > rm -f test.img $output
> >
> > # Create an nbdkit instance that prints the NBD requests seen.
> > nbdkit sh - <<'EOF'
> > case "$1" in
> >   get_size) echo 1M ;;
> >   can_write|can_trim|can_zero|can_fast_zero) ;;
> >   pread) echo "$@" >>$output; dd if=/dev/zero count=$3 iflag=count_bytes ;;
> >   pwrite) echo "$@" >>$output; cat >/dev/null ;;
> >   trim|zero) echo "$@" >>$output ;;
> >   *) exit 2 ;;
> > esac
[etc]
> >diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> >index 09ef2a4d25ed..22e8e88c78d4 100644
> >--- a/fs/fuse/file.c
> >+++ b/fs/fuse/file.c
> >@@ -2907,11 +2907,13 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
> >	};
> >	int err;
> >	bool lock_inode = !(mode & FALLOC_FL_KEEP_SIZE) ||
> >-			   (mode & FALLOC_FL_PUNCH_HOLE);
> >+			   (mode & FALLOC_FL_PUNCH_HOLE) ||
> >+			   (mode & FALLOC_FL_ZERO_RANGE);
> To stay aligned with existing code style, consider:
> -			   (mode & FALLOC_FL_PUNCH_HOLE);
> +»      »       »          (mode & (FALLOC_FL_PUNCH_HOLE |
> +»      »       »       »           FALLOC_FL_ZERO_RANGE));

Good idea.

Thanks for the quick review.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
libguestfs lets you edit virtual machines.  Supports shell scripting,
bindings from many languages.  http://libguestfs.org

