Return-Path: <linux-fsdevel+bounces-23291-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D9A92A630
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 17:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAE60B22716
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 15:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC7D145332;
	Mon,  8 Jul 2024 15:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A0NW7vG5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13B379FD;
	Mon,  8 Jul 2024 15:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720454024; cv=none; b=aEaj7uPqqhJdEjNZCiUqnECVWzWfui0AjcqGZ64/qLurP5Fr/HNrFBohfrZzo2CpxjmTCPtTtDZUyTwo7u3GoKMVh8bvou3j4Fw8ylz8HkOurPuHJZl0on67G/3NVlTRVjJJc3kN1S02jXJ3C57Imkzq9tk4NehxQ83pnkwUzc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720454024; c=relaxed/simple;
	bh=/Qo+XgpQAPTVv2ENVXGfWkHZ6t/gHiaFQGx6jJSjGuk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Bom8it5OFRcK16r00EDYI9XBl0Ecr9YIMJPSO1u5GovLnfS8JRgTNmxR5K7iMw2xQKBUaIOJg3t+N3Z5GxqaHBYtLJWlu/GxAgil1RCIXFoO9flqr5OqY4jd++IyI+0mSe9bxvdKeuXUK3BQs8+ZYgjRnxoMvwcrKLnwSSL2l1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A0NW7vG5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E79D2C116B1;
	Mon,  8 Jul 2024 15:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720454023;
	bh=/Qo+XgpQAPTVv2ENVXGfWkHZ6t/gHiaFQGx6jJSjGuk=;
	h=From:Subject:Date:To:Cc:From;
	b=A0NW7vG5u18AaljqIcp/PI7side45mWsryE6bAsbuZkS/1FKrNBC9ExduJamUMwB+
	 gg5N2ChhRVpDY8Ps4PP/2OYC+CQUn7oiUQzJkgCFYCZu2yCAJWX7w91CbwwEyRW/Iq
	 Wjo/Cq3mj8SF7Y3wsEGd9jlLXyeAcJcgaqMKEE2KwU7xo66C49a3X3B3oAtnANNSjx
	 QTAXd0W0K49h0Neusi2mtw35KnDan+ZDFmqR9LayZCzuOWFw4lFlSKVXnOzXLzizx6
	 4W2VqRpeWdugmv4iqjHayqi6pNOSL0p3HD6BO5K7YrNSk8Oc34f/Ok9JG0wA9xGFpc
	 RtusarUeZxQKw==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v4 0/9] fs: multigrain timestamp redux
Date: Mon, 08 Jul 2024 11:53:33 -0400
Message-Id: <20240708-mgtime-v4-0-a0f3c6fb57f3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH0LjGYC/2XMQQ6CMBCF4auQrq2ZTim2rryHcVFogUYB05JGQ
 7i7hQVqWL7JfP9EgvXOBnLOJuJtdMENfRr5ISNVq/vGUmfSJgiYQ4EF7ZrRdZaKykgomTSSAUn
 PT29r91pD11varQvj4N9rN7LluktERoFqJhUXaKCW9eVufW8fx8E3ZGlE/LoTsM1hckyZnKFWO
 Ri1c/zXic3x5KQo0WitSs7Fn5vn+QOI+y9bDQEAAA==
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Chandan Babu R <chandan.babu@oracle.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Theodore Ts'o <tytso@mit.edu>, 
 Andreas Dilger <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>, 
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
 Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: Dave Chinner <david@fromorbit.com>, Andi Kleen <ak@linux.intel.com>, 
 Christoph Hellwig <hch@infradead.org>, Uros Bizjak <ubizjak@gmail.com>, 
 Kent Overstreet <kent.overstreet@linux.dev>, kernel-team@fb.com, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-mm@kvack.org, 
 linux-nfs@vger.kernel.org, linux-doc@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4929; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=/Qo+XgpQAPTVv2ENVXGfWkHZ6t/gHiaFQGx6jJSjGuk=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmjAt/CnMEDSLOzDGP+T2D9l4n9SgWCIRmvivvu
 Qqs7X+/L9qJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZowLfwAKCRAADmhBGVaC
 FemsD/9OZBThulyqsLrBeTcPfDI+8Cp+Mgvc+tQwq0KteeeutP42tNFEScTTI0FnBDfTso4sQLF
 E/LtkS3M9fxs9ERAdS8t7BdWdySnpOEES7MaLYB9r4ugJygp7lZXw9QS/pJn6a/TZqm3x0CJVhC
 0ejqcyyzTXFQjRphzCJRAQiVSH10aiJZMqenYGW5mGrlv+wizycFUD3NAlXyu8UGESAaSJJUy1p
 YbMnwjZsZHIvMwTMMvih7zJLt7kIfATA27YZd8soS2Z3pBdyMSpykHStPftQ7+u76BZFhs/Mtzj
 2Lo+t+Mca7gqtmP2D+9Iix4Sb3BcwJgdxjGq0ZSZCaOBUShgZnCKru3BBV3jyXTpEcZGwnjuG3B
 lw4rnZYGyt6Gw8nRUDlpDiUUK2SvW7vKIQ5JuonWwYntQPwacszf3OnCJIG5pPM/wbnRNMexFfF
 pP3e90++d98/v3dvq/guzN8h0zwL9Jiv/VEUlahBN273VnTFQFcfoPub+Eu3jTa2vkhTSRebUk+
 4bFfj88eLZQU4kkOgii1ZjU+tM8nnjHPncrKv16gsR9l8i1x9uEv/2ZWP+NvRUcJCscjm5Go1rr
 G6SnW9BwN79EP9fRZaH/9tF6Z8Sws+Rdb3YOn641ejS+QkA87Gvf/urXCKKSDMOWoyhXcQx0dsK
 o2IkUML09NA2kLg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

tl;dr for those who have been following along:

There are several changes in this version. The conversion of ctime to
be a ktime_t value has been dropped, and we now use an unused bit in
the nsec field as the QUERIED flag (like the earlier patchset did).

The floor value is now tracked as a monotonic clock value, and is
converted to a realtime value on an as-needed basis. This eliminates the
problem of trying to detect when the realtime clock jumps backward.

Longer patch description for those just joining in:

At LSF/MM this year, we had a discussion about the inode change
attribute. At the time I mentioned that I thought I could salvage the
multigrain timestamp work that had to be reverted last year [1].

That version had to be reverted because it was possible for a file to
get a coarse grained timestamp that appeared to be earlier than another
file that had recently gotten a fine-grained stamp.

This version corrects the problem by establishing a per-time_namespace
ctime_floor value that should prevent this from occurring. In the above
situation, the two files might end up with the same timestamp value, but
they won't appear to have been modified in the wrong order.

That problem was discovered by the test-stat-time gnulib test. Note that
that test still fails on multigrain timestamps, but that's because its
method of determining the minimum delay that will show a timestamp
change will no longer work with multigrain timestamps. I have a patch to
change the testcase to use a different method that is in the process of
being merged.

The testing I've done seems to show performance parity with multigrain
timestamps enabled vs. disabled, but it's hard to rule this out
regressing some workload.

This set is based on top of Christian's vfs.misc branch (which has the
earlier change to track inode timestamps as discrete integers). If there
are no major objections, I'd like to have this considered for v6.12,
after a nice long full-cycle soak in linux-next.

PS: I took a stab at a conversion for bcachefs too, but it's not
trivial. bcachefs handles timestamps backward from the way most
block-based filesystems do. Instead of updating them in struct inode and
eventually copying them to a disk-based representation, it does the
reverse and updates the timestamps in its in-core image of the on-disk
inode, and then copies that into struct inode. Either that will need to
be changed, or we'll need to come up with a different way to do this for
bcachefs.

[1]: https://lore.kernel.org/linux-fsdevel/20230807-mgctime-v7-0-d1dec143a704@kernel.org/

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v4:
- reordered tracepoint fields for better packing
- rework percpu counters again to also count fine grained timestamps
- switch to try_cmpxchg for better efficiency
- Link to v3: https://lore.kernel.org/r/20240705-mgtime-v3-0-85b2daa9b335@kernel.org

Changes in v3:
- Drop the conversion of i_ctime fields to ktime_t, and use an unused bit
  of the i_ctime_nsec field as QUERIED flag.
- Better tracepoints for tracking floor and ctime updates
- Reworked percpu counters to be more useful
- Track floor as monotonic value, which eliminates clock-jump problem

Changes in v2:
- Added Documentation file
- Link to v1: https://lore.kernel.org/r/20240626-mgtime-v1-0-a189352d0f8f@kernel.org

---
Jeff Layton (9):
      fs: add infrastructure for multigrain timestamps
      fs: tracepoints around multigrain timestamp events
      fs: add percpu counters for significant multigrain timestamp events
      fs: have setattr_copy handle multigrain timestamps appropriately
      Documentation: add a new file documenting multigrain timestamps
      xfs: switch to multigrain timestamps
      ext4: switch to multigrain timestamps
      btrfs: convert to multigrain timestamps
      tmpfs: add support for multigrain timestamps

 Documentation/filesystems/multigrain-ts.rst | 120 ++++++++++++++
 fs/attr.c                                   |  52 ++++++-
 fs/btrfs/file.c                             |  25 +--
 fs/btrfs/super.c                            |   3 +-
 fs/ext4/super.c                             |   2 +-
 fs/inode.c                                  | 234 ++++++++++++++++++++++++----
 fs/stat.c                                   |  39 ++++-
 fs/xfs/libxfs/xfs_trans_inode.c             |   6 +-
 fs/xfs/xfs_iops.c                           |  10 +-
 fs/xfs/xfs_super.c                          |   2 +-
 include/linux/fs.h                          |  34 +++-
 include/trace/events/timestamp.h            | 109 +++++++++++++
 mm/shmem.c                                  |   2 +-
 13 files changed, 560 insertions(+), 78 deletions(-)
---
base-commit: 49cb2d11beee730253f6f87263602a8c75f81f9b
change-id: 20240626-mgtime-5cd80b18d810

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


