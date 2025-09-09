Return-Path: <linux-fsdevel+bounces-60630-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDE2B4A730
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 11:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1059917D6CC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 09:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6DE286D66;
	Tue,  9 Sep 2025 09:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bpk2jstY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349FB285061;
	Tue,  9 Sep 2025 09:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757409245; cv=none; b=n1K7E1iV8XBkEnWO0I5bNLztp528I5EUD2aMV6D+DWGAIHRrdfDdrQZRHDb2+6S8I3qL1ytZ0bwLcYpX9fQmfpqXTpAQvGffi+inE46RTwqjp6nNb/bCgn9nW6gRwRPf6qZ/DCTnKcycsnEUkerGaOBTmmkRfR2SUhlBaac7KqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757409245; c=relaxed/simple;
	bh=m7+EjSEw7wGjGIHmJWC2yW7fI5jbNMbgdH73UJbKpuE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S1aWp/abLHtI57ZmWAmpLkT/IP2j/d0i8zBaWKOl/lKm4qBQSwaHF87X5zqYLxboAlq2h4t0bDcfbfP7Aoz0GQL9Fcl4ILj1uCksXOw63KciU+gXIaLbLxHfvvAfqDxwqIJyCVdXCAoqAeJqabCgPOY//NfqmDUcye9XJ7cfCCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bpk2jstY; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3e2055ce973so2851446f8f.0;
        Tue, 09 Sep 2025 02:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757409241; x=1758014041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ka25j5M/VbSSUXNqqPV03aOJpdPrHGb9SiYreXMkqJ8=;
        b=Bpk2jstY5zuP37nF8l7UqQOCigOraPRHY69F/+phDm1wcB/gq4+CbvdS/0qtiTTH7J
         epdO5sXKiAND7nMRJbAFju3g8gInAzpp0ialFwamkyYx5bJ+anAIvvw7tCLmEFhMvs+9
         sqtPASGaZATxpMMY5w/RVwxlek0PXMGRb1HGXoknM0JBx+miEBusVfM6lfcObmOlZ83s
         RRBNVVrCv8DTOF7imuJYD4x4GEjDHIvyMYqr9bTbnCPR/U2nTNJINrSyQCuf4dZKztgI
         uwjdd0P4v2v2fiCgs/mu6zAJuXjm+CYpmya6oMkEO0SsAQpaLbq/q0/W41FF7boVs022
         JQCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757409241; x=1758014041;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ka25j5M/VbSSUXNqqPV03aOJpdPrHGb9SiYreXMkqJ8=;
        b=b8p5DWDIyj/qVk0kGSs5VUMhtzezJaUFIzr5VCdM/Q2U1rkwIwc6ArWZb+/VoyElrQ
         NqPO+2arlvDmY8zkjsU+Tq98hqLpFJn6dZRwyVYqQRHt2wuUKQnlACXIK5R20Lip9kDw
         KxvQQN53SvnXRK07ujfr0ben5kFnuHM/ccCry7mb6+gi4eO8sEcHcwr0/uDYlxvnUMCe
         WisuOQViMeBk8//j3PSI2VbuJWr3fS9aZVL+OLeMEEeMjFkyENfHRT9Fh8GU3O0bu6We
         Tkr5VdrsUUTfMf5JhObFqDGCkBcYIHdIB80Bf+em7Zw83jhk3y8/8TcOJJl49sOowarC
         MEfw==
X-Forwarded-Encrypted: i=1; AJvYcCU94cAEpFe0SJd3vgxFJ4GvlfyXtBWSRWarhkqbxp7b+OGkc/2Z2C3vEDKHrIzy2s48uzJuQa4LxxvMztH6@vger.kernel.org, AJvYcCUdURounKsD6rLR1B+m38A47VUHXKBsVNbCCL92LBtGSSWU+tUPyjMXLR8734wbilCpLp8PFrWNoYl9@vger.kernel.org, AJvYcCV8QOnHEV0EmyZ8d77vmadrH5OSHiMMvxYeGX5mqFrVJKKorCry5GSDcVSW+2gc1POk20NCIL2hneFuTQ==@vger.kernel.org, AJvYcCWuYNcO4udHCSZpzQHSHQuQiB8JVgTDDXVPZBqqZ+bQTC1R2CV+4T3aP1Cbd4ASP8370cBsWgpBdkZ1lmcv2A==@vger.kernel.org, AJvYcCXfOG4t4xy34riLZDUeUmMxnZLWhARi5px58cvMz10uxzo5Rc9c7IEBJVS1vS4akKnZ3NoQlYwGawJQPA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2vpHp8NiSjlVFhtmsUeAaRzBDNI2IsTtyikNZ39yTlX7169bA
	rlJVHZ3tw7quVbeKOrzI5YLoCLHcusJahW36ManFExoFRyzuXCwwMGRC
X-Gm-Gg: ASbGncue0soLG5EXXGYx1+7eLcUXvv9vLmeIRZwz6zybVTIlvbabJuu0vule8oXSAPn
	xI3WeSIQmvT9h2BF40SP9HdoCNsUHy5zzDFo+8Cd98Ekdo+LbTHLgXA1L8GzW7PkXMQwAoq4lm1
	J4uyK7EbdwDOuTyGtHOZUKxfp77p9+wbs7089GeWvZB9GGSyIUFhpGJriFFBDVSgFNQD4YbTv8y
	V+sdyW/q0xBUls6sSsfT+rJvHM34qTkW7oHfE5he7+b1CpoDOezWScPuIzr8fnSRiQTXi2BQ+IV
	3VNX5K0wxpBVLnm8x46FKnxLoGP8g7wJz/Jhsq7JXMDtH4Ii0L+kWgS1h2uD/gluwPzMxeIVNKQ
	LRa97wukdrmm6YPy402Smd+c7VW4XBV27giHSxFPftYECMx+jODw=
X-Google-Smtp-Source: AGHT+IHFEehIPgdcNTbNx4qOhQtSRG+TRsytb4QDyjjp512DHDqKl5O00OUvTsgL0ex7EVMGQT0V4Q==
X-Received: by 2002:a05:6000:22c3:b0:3de:78c8:11fc with SMTP id ffacd0b85a97d-3e6497c0668mr9444917f8f.63.1757409240911;
        Tue, 09 Sep 2025 02:14:00 -0700 (PDT)
Received: from f.. (cst-prg-84-152.cust.vodafone.cz. [46.135.84.152])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7521bff6esm1810784f8f.13.2025.09.09.02.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 02:14:00 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	josef@toxicpanda.com,
	kernel-team@fb.com,
	amir73il@gmail.com,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [WIP RFC PATCH v2 00/10] i_state accessors + I_WILL_FREE removal
Date: Tue,  9 Sep 2025 11:13:34 +0200
Message-ID: <20250909091344.1299099-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NOTE: this is a WIP not meant to be included anywhere yet and perhaps
should be split into 2 patchsets.

It is generated against against:
https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?h=vfs-6.18.inode.refcount.preliminaries

The first patch in the series is ready to use(tm) and was sent
separately here:
https://lore.kernel.org/linux-fsdevel/20250909082613.1296550-1-mjguzik@gmail.com/T/#u

It is included in this posting as the newly patched routine has to get
patched further due to the i_state accessor thing. Having it here should
make it handier to test for interested.

This is a cleaned up continuation of the churn-ey patch which merely removed I_WILL_FREE:
https://lore.kernel.org/linux-fsdevel/20250902145428.456510-1-mjguzik@gmail.com/

The entire thing is a response to the patchset by Josef Bacik concerning
refcount changes, see:
https://lore.kernel.org/linux-fsdevel/cover.1756222464.git.josef@toxicpanda.com/

I'm writing my second reply to that patchset, but in the meantime the
stuff below should facilitate work forward, regardless if the refcount
patchset goes in or not.

The patchset splits churn from actual changes.

Plain ->i_state access is still possible to reduce upfront churn, only
some of the tree got covered so far.

short rundown:
  fs: hide ->i_state handling behind accessors

This is churn-ey and should largely be a nop, worst case there will be
failed lock assertions if I messed up some annotations and which should
be easy to sort out. It covers fs/*.c and friends, but no filesystems.

  bcachefs: use the new ->i_state accessors
  btrfs: use the new ->i_state accessors
  ext4: use the new ->i_state accessors
  gfs2: use the new ->i_state accessors
  ocfs2: use the new ->i_state accessors

This patches only the filesystems which reference I_WILL_FREE. Again
should be a nop.

  ocfs2: retire ocfs2_drop_inode() and I_WILL_FREE usage

Actual change, needs ocfs2 folks approval.

  fs: set I_FREEING instead of I_WILL_FREE in iput_final() prior to
    writeback

Actual change. I_WILL_FREE still exists as a macro but is no longer set
by anything. As of right now I'm not fully confident this is correct,
the writeback code is more fuck-ey than not. However, figuring this out
is imo a hard prerequisite for the refcount patchset by Josef anyway.

  fs: retire the I_WILL_FREE flag

Churn change to whack the flag. It also uses the opportunity to do some
cosmetics.

Onto the rationale:

I. i_state

The handling in the stock kernel is highly error prone and with 0 assert
coverage.

Notably there is nothing guaranteeing the caller owns the necessary lock
when making changes. But apart from that there are spots which look at
->i_state several times and it is unclear if they think it is stable or
not. Moreover spots used on inode teardown use WRITE_ONCE, some spots in
hash lookup use READ_ONCE, but everyone else issues plain loads and
stores which invites compiler mischief.

All of this is easily preventable.

The ideal state as I see it would also hide the field behind a struct so
that plain open-coded accesses fail to compile. Not done yet to reduce
churn.

Another step not taken here but to be sorted out later is strict
handling of flags, where it is illegal to clear flags which are not
present and to set flags which are already set -- the kernel should know
whether a given flag can legally be present or not (trivial example:
I_FREEING).  Setting a flag which is already set is more likely to be a
logic error than not. If it turns out there are cases where a flag can
be legally already present/missing, an additional helper can be added to
forego the assertion.

Practical examples:
	spin_lock(&inode->i_lock);
	if (inode_state_read(inode) & I_WHATEVER) {
		....
	}
	spin_unlock(&inode->i_lock);

This asserts the lock is held.

But if the caller is looking to do a lockless check first, they can do
it and explicitly denote this is what they want:

	if (inode_state_read_unlocked(inode) & I_WHATEVER) {
		spin_lock(&inode->i_lock);
		if (inode_state_read(inode) & I_WHATEVER) {
			....
		}
		spin_unlock(&inode->i_lock);
	}

Similarly:
	state = inode_state_read_unlocked(inode);
	if (state & I_CRAP) {
	} else (state & I_MEH) {
	}
	...

We are guaranteed no mischief and the caller acknowledges the value in
the inode could have changed from under them and the code is READ_ONCE
(as opposed to plain ->i_state loads now).

Furthermore, should better lifecycle tracking get introduced, the
helpers can validate no flags get added when it is invalid to do so.

The *current* routines are as below. I don't care about specific
names, I do care about semantics.

/*
 * i_state handling
 *
 * We hide all of it behind helpers so that we can validate consumers.
 */
static inline enum inode_state_flags_enum inode_state_read(struct inode *inode)
{
        lockdep_assert_held(&inode->i_lock);
        return inode->i_state;
}

static inline enum inode_state_flags_enum inode_state_read_unlocked(struct inode *inode)
{
        return READ_ONCE(inode->i_state);
}

static inline void inode_state_add(struct inode *inode,
                                         enum inode_state_flags_enum newflags)
{
        lockdep_assert_held(&inode->i_lock);
        WRITE_ONCE(inode->i_state, inode->i_state | newflags);
}

static inline void inode_state_del(struct inode *inode,
                                         enum inode_state_flags_enum rmflags)
{
        lockdep_assert_held(&inode->i_lock);
        WRITE_ONCE(inode->i_state, inode->i_state & ~rmflags);
}

static inline void inode_state_set_unchecked(struct inode *inode,
                                                   enum inode_state_flags_enum newflags)
{
        WRITE_ONCE(inode->i_state, newflags);
}

The inode_state_set_unchecked() crapper is there to handle early access
during inode construction (before it lands in the hash).

II. I_WILL_FREE removal

Sounds like nobody likes this flag and even the developer documenting it
in fs.h was not able to provide a justification for its existence,
merely stating how it is used.

As far as I can tell the only use was to allow ->drop_inode() handlers
to drop ->i_lock and still prevent anyone from picking up the inode. I
*suspect* this was used instead of I_FREEING because the routine could
have decided to *not* drop afterwards. Differentiating between
indicating the inode is going down vs just telling the consumer to
bugger off for the time being seemed like an ok idea.

However, the only filesystem using today is ocfs2, it always returns
"drop it" and this usage does not even have to be there. Removed in one
of the patches.

Apart from that the only use was write_inode_now() call in iput_final()
prior to setting I_FREEING anyway. This probably works as posted here,
but there might be some fuckery to sort out in writeback to truly
eliminate the flag. In the worst case it's just some work, but *so far*
I'm not staking anything on the patchset being fully correct yet.

tl;dr the flag does not have to be there, but there may be dragons in
writeback (to be seen). No matter what, shaking bugs out of this should
be considered a pre-requisite for any future work regarding inode
lifecycle (whether the refcount patchset lands or not, imo it should not
which I'll elaborate on later in that thread).

Apart from that the I_CREATING flag seems to have inconsistent handling,
but that's for another e-mail after I get a better hang of it.

So.. comments?

Mateusz Guzik (10):
  fs: expand dump_inode()
  fs: hide ->i_state handling behind accessors
  bcachefs: use the new ->i_state accessors
  btrfs: use the new ->i_state accessors
  ext4: use the new ->i_state accessors
  gfs2: use the new ->i_state accessors
  ocfs2: use the new ->i_state accessors
  ocfs2: retire ocfs2_drop_inode() and I_WILL_FREE usage
  fs: set I_FREEING instead of I_WILL_FREE in iput_final() prior to
    writeback
  fs: retire the I_WILL_FREE flag

 block/bdev.c                     |   4 +-
 fs/bcachefs/fs.c                 |   8 +-
 fs/btrfs/inode.c                 |  10 +--
 fs/buffer.c                      |   4 +-
 fs/crypto/keyring.c              |   2 +-
 fs/crypto/keysetup.c             |   2 +-
 fs/dcache.c                      |   8 +-
 fs/drop_caches.c                 |   2 +-
 fs/ext4/inode.c                  |  10 +--
 fs/ext4/orphan.c                 |   4 +-
 fs/fs-writeback.c                | 131 +++++++++++++++----------------
 fs/gfs2/file.c                   |   2 +-
 fs/gfs2/glops.c                  |   2 +-
 fs/gfs2/inode.c                  |   4 +-
 fs/gfs2/ops_fstype.c             |   2 +-
 fs/inode.c                       | 115 ++++++++++++++-------------
 fs/libfs.c                       |   6 +-
 fs/namei.c                       |   8 +-
 fs/notify/fsnotify.c             |   8 +-
 fs/ocfs2/dlmglue.c               |   2 +-
 fs/ocfs2/inode.c                 |  27 +------
 fs/ocfs2/inode.h                 |   1 -
 fs/ocfs2/ocfs2_trace.h           |   2 -
 fs/ocfs2/super.c                 |   2 +-
 fs/pipe.c                        |   2 +-
 fs/quota/dquot.c                 |   2 +-
 fs/sync.c                        |   2 +-
 fs/xfs/scrub/common.c            |   3 +-
 include/linux/backing-dev.h      |   5 +-
 include/linux/fs.h               |  75 ++++++++++++------
 include/linux/writeback.h        |   4 +-
 include/trace/events/writeback.h |  11 ++-
 security/landlock/fs.c           |  12 +--
 33 files changed, 249 insertions(+), 233 deletions(-)

-- 
2.43.0


