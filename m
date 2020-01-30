Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1280814DE00
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2020 16:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbgA3Pi3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jan 2020 10:38:29 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:55710 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727158AbgA3Pi3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jan 2020 10:38:29 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ixBth-004oy2-Rz; Thu, 30 Jan 2020 15:38:25 +0000
Date:   Thu, 30 Jan 2020 15:38:25 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        David Howells <dhowells@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH 04/17] follow_automount() doesn't need the entire
 nameidata
Message-ID: <20200130153825.GA23230@ZenIV.linux.org.uk>
References: <20200119031423.GV8904@ZenIV.linux.org.uk>
 <20200119031738.2681033-1-viro@ZenIV.linux.org.uk>
 <20200119031738.2681033-4-viro@ZenIV.linux.org.uk>
 <20200130144520.hnf2yk5tjalxfddn@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200130144520.hnf2yk5tjalxfddn@wittgenstein>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 30, 2020 at 03:45:20PM +0100, Christian Brauner wrote:
> > -	nd->total_link_count++;
> > -	if (nd->total_link_count >= 40)
> > +	if (count && *count++ >= 40)
> 
> He, side-effects galore. :)
> Isn't this incrementing the address but you want to increment the
> counter?
> Seems like this should be
> 
> if (count && (*count)++ >= 40)

Nice catch; incidentally, it means that usual testsuites (xfstests,
LTP) are missing the automount loop detection.  Hmm...

Something like

export $FOO over nfs4 to localhost

mkdir $FOO/sub
touch $FOO/a
mount $SCRATCH_DEV $FOO/sub
touch $FOO/sub/a
cd $BAR
mkdir nfs
mount -t nfs localhost:$FOO nfs
for i in `seq 40`; do ln -s l`expr $i - 1` l$i; done
for i in `seq 40`; do ln -s m`expr $i - 1` m$i; done
ln -s nfs/sub/a l0
ln -s nfs/a m0
for i in `seq 40`; do
	umount nfs/sub 2>/dev/null
	cat l$i m$i
done

BTW, the check of pre-increment value is more correct - it's
accidental, but it does give consistency with the normal symlink
following.  We do allow up to 40 symlinks over the pathname
resolution, not up to 39.

The thing above should produce
cat: l39: Too many levels of symbolic links
cat: l40: Too many levels of symbolic links
cat: m40: Too many levels of symbolic links

Here l<n> and m<n> go through n + 1 symlink, ending at
nfs/sub/a and nfs/a resp.; the former does trigger an automount,
the latter does not.

On mainline it actually starts to complain about l38, l39, l40 and m40,
due to that off-by-one in follow_automount().
