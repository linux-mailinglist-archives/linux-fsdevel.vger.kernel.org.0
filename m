Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26B95213FD9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jul 2020 21:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgGCTU6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jul 2020 15:20:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:49142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbgGCTU5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jul 2020 15:20:57 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB37F207FF;
        Fri,  3 Jul 2020 19:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593804057;
        bh=PEmsm7KiYhEynj7JM9OkcWwJJEMC5FTZ1MgB7GC3/kw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cZz3+cYtChLGxVGtGhI0iqF8NG4vRe7SyHyKP6rwlrniscYuLOgqOM9tC5bBvh6V9
         rCNuVMRKKdD1/I05cjOph+0nERO2OeeH/Y1QSjn/3szq+YCjsBxWz49TxA/V8HiT6F
         N6pBBTbIdf7MhFFMTY1BRtmYQCvTyvOSvJ4M/pzg=
Date:   Fri, 3 Jul 2020 12:20:55 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Daniel Rosenberg <drosen@google.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fscrypt@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com
Subject: Re: [PATCH v9 2/4] fs: Add standard casefolding support
Message-ID: <20200703192055.GA2825@sol.localdomain>
References: <20200624043341.33364-1-drosen@google.com>
 <20200624043341.33364-3-drosen@google.com>
 <20200624055707.GG844@sol.localdomain>
 <CA+PiJmTDXTKnccJdADX=ir+PtqsDD72xHGbzObpntkjkVmKHxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+PiJmTDXTKnccJdADX=ir+PtqsDD72xHGbzObpntkjkVmKHxQ@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 02, 2020 at 06:01:37PM -0700, Daniel Rosenberg wrote:
> On Tue, Jun 23, 2020 at 10:57 PM Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > Note that the '!IS_ENCRYPTED(dir) || fscrypt_has_encryption_key(dir)' check can
> > be racy, because a process can be looking up a no-key token in a directory while
> > concurrently another process initializes the directory's ->i_crypt_info, causing
> > fscrypt_has_encryption_key(dir) to suddenly start returning true.
> >
> > In my rework of filename handling in f2fs, I actually ended up removing all
> > calls to needs_casefold(), thus avoiding this race.  f2fs now decides whether
> > the name is going to need casefolding early on, in __f2fs_setup_filename(),
> > where it knows in a race-free way whether the filename is a no-key token or not.
> >
> > Perhaps ext4 should work the same way?  It did look like there would be some
> > extra complexity due to how the ext4 directory hashing works in comparison to
> > f2fs's, but I haven't had a chance to properly investigate it.
> >
> > - Eric
> 
> Hm. I think I should be able to just check for DCACHE_ENCRYPTED_NAME
> in the dentry here, right? I'm just trying to avoid casefolding the
> no-key token, and that flag should indicate that.

Ideally yes, but currently the 'struct dentry' isn't always available.  See how
fscrypt_setup_filename(), f2fs_setup_filename(), f2fs_find_entry(),
ext4_find_entry(), etc. take a 'struct qstr', not a 'struct dentry'.

At some point we should fix that by passing down the dentry whenever it's
available, so that we reliably know whether the name is a no-key name or not.

So even my new f2fs code is still racy.  But it at least handles each filename
in a consistent way within each directory operation.  In comparison, your
proposed ext4 code can treat a filename as a no-key name while matching one
dir_entry and then as a regular filename while matching the next.  I think the
f2fs way is more on the right track, both correctness-wise and efficiency-wise.

- Eric
