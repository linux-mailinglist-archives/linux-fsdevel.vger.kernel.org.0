Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7AF53AE11
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jun 2022 22:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbiFAUsR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Jun 2022 16:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbiFAUrp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Jun 2022 16:47:45 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99FB41CAC23;
        Wed,  1 Jun 2022 13:44:46 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id BFF111F4382F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654116282;
        bh=edygCTD4LD4Xm8O700iJu8Cl2mc8i3RDl/9kRCU/hYI=;
        h=From:To:Cc:Subject:Date:From;
        b=dApX6njWsN6LLztxQ+qeShwyxdZmobsGH33onEc7XHbTtUy7RER6bcXoLr2oxLJZP
         fKq2E3KGXvbQ7tKTVbkWSQOIffdNVq1eHCmweooAGMjXXqpsmwsCYDLFSon9alNmn2
         G2O0JrcL7C0FayCwJQVKNVusvBuWgZRlPvu7eOK0eLZqxkU18WzJZxX9o7bCoJ3Dfg
         vCMhyL0w9xeu++7s9uMGTXcRF/1h3w28/cfZ1oFP15snKdORLDthr7msBFEKubbLWe
         ti5rEJK8qOFMrCNzEKUKqyWTKDfFHigkPEz+fxu/PiRTQzTJK0OxmiARJrqaiFZvnA
         /A23qCJGhG4fg==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     viro@zeniv.linux.org.uk, tytso@mit.edu, jaegeuk@kernel.org
Cc:     ebiggers@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH RFC 0/7] Support negative dentries on case-insensitive directories
Date:   Wed,  1 Jun 2022 16:44:30 -0400
Message-Id: <20220601204437.676872-1-krisman@collabora.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

I'm sending this as an RFC given the amount of corner cases that appear
when doing case-insensitive lookups.  I'm confident I've covered every
one of them, but I'd appreciate the review to ensure I'm not missing a
case where negative dentries cannot be trusted on case-insensitive
directories.

This survives every corner case I could think of, including those
already tested by fstests.  I also ran sanity checks to show it
uses the created negative dentries, and I observed the expected
performance increase of the negative dentry cache hit.

* Background

Negative dentries have always been disabled in case-insensitive
directories because they don't provide enough assurance that every case
variation of a filename doesn't exist in a directory and because there
are known corner cases in file creation where negative dentries can't be
instantiated.

In the trivial case the upstream implementation already works for
negative dentries, even though it is disabled. That is: if the lookup
that caused the dentry to be created was done in a case-insensitive way,
the negative dentry can already be trusted, since it means that no valid
dcache entry exists, *and* that no variation of the file exists on
disk (since the lookup failed). A following lookup will then be executed
with case-insensitive-aware d_hash and d_lookup, it will find the right
negative dentry and can trust it.  It has a creation problem, though,
discussed below.

The first problem appears when a case-insensitive directory has negative
dentries that were created when the directory was case-sensitive.  A
further lookup would incorrectly trust it:

This sequence demonstrates the problem:

  mkdir  d
  touch  d/$1
  touch  d/$2
  unlink d/$1   <- leaves negative dentry.
  unlink d/$2   <- leaves negative dentry.
  chattr +F d
  touch  d/$1   <- finds one of the negative dentries, makes it positive
  < if d/$1 is d_drop somehow >
  access d/$2   <- Might find the other negative dentry, get -ENOENT

There are actually a few problems here.  The first is that a preexisting
negative dentry created during a case-sensitive lookup doesn't guarantee
that no other variation of the name exists. This is not a big problem
in the common case, since the directory has to be empty to be converted,
and the d_hash and d_compare are case-insensitive; which means they will
find the same dentry and reuse it most of the time (except for
invalidations and hash collisions).  But it means that we are leaving
behind a stalled dentry that shouldn't be there.

The real problem happens if $1 and $2 are two strings where:
    (i) casefold($1) == casefold($2)
    (ii) hash($1) == hash($2) == hash(casefold($1))

This condition is the worst case.  Both negative dentries can
potentially be found during a case-insensitive lookup if the wrong
dentry is invalidated.

In fact, this is a problem even on the current implementation.  There
was a bug reported by Al in 2020 [1], where a directory might end up
with dangling negative dentries created during a case-sensitive lookup,
because when the +F attribute is set; even though that code requires an
empty directory, it doesn't check for negative dentries.

Condition (ii) is hard to test, but not impossible.  But, even if it
is not present, we still leave negative dentries behind, which shouldn't
currently exist for a case-insensitive directory.

A completely different problem with negative dentries on
case-insensitive directories exist when turning a negative dentry to
positive.  If the negative dentry has a different case than what is
currently being looked up, the dentry cannot be reused without changing
its name, because we guarantee filename-preserving semantics.  We need
to either change the name or invalidate the dentry. This is currently
done in the upstream kernel by completely stopping negative dentries
from being created in the first place.

* Proposal

The proposed solution is to differentiate negative dentries created from
a case-insensitive context from those created during a case-sensitive
one via a new dentry flag, D_CASEFOLD_LOOKUP, set by the filesystem
during d_lookup.  Since a negative dentry created during a
case-insensitive lookup can be trusted (except for the name-preserving
issue), we can check that flag during d_revalidate to quickly accept or
reject the negative dentry.

Another solution for that problem would be to guarantee that no negative
dentry exists during the Case-sensitive to case-insensitive directory
conversion (the other direction is safe).  This has the following
problems:

  1) It is not trivial to implement a race-free mechanism to ensure
  negative dentries won't be recreated immediately after invalidation
  while converting the directory.

  2) The knowledge whether the negative dentry can be is
  valid (i.e. comes from a case-insensitive lookup) is implicit on the
  fact that we are correctly invalidating dentries when converting the
  directory.

Having a D_CASEFOLD_LOOKUP avoids both issues, and seems to be a cheap
solution to explicitly decide whether to validate a negative dentry.

As explained, in order to maintain the filename preserving semantics, it
is not sufficient to reuse the dentry.

One solution would be to invalidate the negative dentry when it is
decided to turn it positive, instead of reusing it. I implemented that
in the past (2018) but my understanding is that we don't want to incur
costs on the VFS critical path for other filesystems who don't care
about case-insensitiveness.  I think there is also a challenge in making
this invalidation race-free, but it might be simpler than I thought.

Instead, I'm suggesting that we only validate negative dentries in
casefold directories during lookups that will instantiate the dentry
when the lookup name is exactly what is cached.

* caveats

1) Encryption

Currently, negative dentries on encrypted directories are also disabled.
No semantic change on encrypted directories is intended in this
patchset; we just bypass the revalidation directly to fscrypt, for
positive dentries.  I'm working on this case as future work.

2) revalidate the cached dentry using the name under lookup

This is strange for a cache.  the new semantic is implemented on
d_revalidate() to stay out of the critical path of filesystems that
don't care about case-insensitive.  But this requires the revalidation
hook to validate based on what name is under lookup, which is odd for a
cache.

* Tests

There are a few tests for the corner cases discussed above in
generic/556.  They mainly verify the name-preserving semantics.
The invalidation when converting the directory is harder to test,
because it is hard to force the invalidation of specific cached dentries
that occlude a dangling invalid dentry.  I tested it with forcing the
positive dentries to be removed, but I'm not sure how to write an
upstreamable test for it.

This also survives smoke test on ext4 and f2fs.

* patchset

Patch 1 introduces a new version of d_revalidate to provide the
filesystem with the name under lookup; Patch 2 introduces a new dentry
flag to mark dentries as created during a case-insensitive lookup; Patch
3 introduces a libfs helper to validate negative dentries on
case-insensitive directories; Patch 4 deals with encryption; Patch 5
cleans up the now redundant dentry operations for case-insensitive with
and without encryption; Finally, Patch 6 and 7 enable negative dentries
on case-insensitive directories for ext4 and f2fs, respectively.

Gabriel Krisman Bertazi (7):
  fs: Expose name under lookup to d_revalidate hook
  fs: Add DCACHE_CASEFOLD_LOOKUP flag
  libfs: Validate negative dentries in case-insensitive directories
  libfs: Support revalidation of encrypted case-insensitive dentries
  libfs: Merge encrypted_ci_dentry_ops and ci_dentry_ops
  ext4: Enable negative dentries on case-insensitive lookup
  f2fs: Enable negative dentries on case-insensitive lookup

 fs/dcache.c            |  9 +++++-
 fs/ext4/namei.c        | 35 +++-----------------
 fs/f2fs/namei.c        | 23 ++------------
 fs/libfs.c             | 72 ++++++++++++++++++++++++------------------
 fs/namei.c             | 23 ++++++++------
 include/linux/dcache.h |  9 ++++++
 6 files changed, 78 insertions(+), 93 deletions(-)

-- 
2.36.1

