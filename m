Return-Path: <linux-fsdevel+bounces-1671-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D59C77DD811
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 23:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7942CB20F91
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 22:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49AEB27442;
	Tue, 31 Oct 2023 22:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EKow9nLE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6F5A28
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 22:11:40 +0000 (UTC)
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [IPv6:2001:41d0:203:375::ab])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC22EA;
	Tue, 31 Oct 2023 15:11:38 -0700 (PDT)
Date: Tue, 31 Oct 2023 18:11:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1698790296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lKAVh/PtZlDLOODYkBclJPD12VobypZ8XYn2N5TwM0Y=;
	b=EKow9nLEka6mdz9vObOv4R1e1yPz6EF26QrdHb0wJDZgC/HmRs4GW6EMbTlM8ijQuRg0uw
	6StUyghZAKPEhWeYUBiPVMG9dLHOVawELNkufQDdzWOh65fJ5dpFg2sQG2r0W1AFo6xUkO
	UznDbkQSLAr5Rjt9UrINNuQ7xvFCzMc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: John Stoffel <john@stoffel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [GIT PULL] bcachefs for v6.7
Message-ID: <20231031221126.5wejfggu7gg2y3n4@moria.home.lan>
References: <25921.30263.150556.245226@quad.stoffel.home>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <25921.30263.150556.245226@quad.stoffel.home>
X-Migadu-Flow: FLOW_OUT

On Tue, Oct 31, 2023 at 05:48:39PM -0400, John Stoffel wrote:
> 
> Using latest HEAD from linux git (commit
> 5a6a09e97199d6600d31383055f9d43fbbcbe86f (HEAD -> master,
> origin/master, origin/HEAD), and the following config, I get this
> failure when compiling on x86_64 Debian Bullseye (11):
> 
> 
>      CC      fs/bcachefs/btree_io.o
>    In file included from fs/bcachefs/btree_io.c:11:
>    fs/bcachefs/btree_io.c: In function ‘bch2_btree_post_write_cleanup’:
>    fs/bcachefs/btree_update_interior.h:274:36: error: array subscript 0 is outside the bounds of an interior zero-length array ‘struct bkey_packed[0]’ [-Werror=zero-length-bounds]
>      274 |   __bch_btree_u64s_remaining(c, b, &bne->keys.start[0]);
> 	 |                                    ^~~~~~~~~~~~~~~~~~~
>    In file included from fs/bcachefs/bcachefs.h:206,
> 		    from fs/bcachefs/btree_io.c:3:
>    fs/bcachefs/bcachefs_format.h:2344:21: note: while referencing ‘start’
>     2344 |  struct bkey_packed start[0];
> 	 |                     ^~~~~
>    In file included from fs/bcachefs/btree_io.c:11:
>    fs/bcachefs/btree_io.c: In function ‘bch2_btree_init_next’:
>    fs/bcachefs/btree_update_interior.h:274:36: error: array subscript 0 is outside the bounds of an interior zero-length array ‘struct bkey_packed[0]’ [-Werror=zero-length-bounds]
>      274 |   __bch_btree_u64s_remaining(c, b, &bne->keys.start[0]);
> 	 |                                    ^~~~~~~~~~~~~~~~~~~
>    In file included from fs/bcachefs/bcachefs.h:206,
> 		    from fs/bcachefs/btree_io.c:3:
>    fs/bcachefs/bcachefs_format.h:2344:21: note: while referencing ‘start’
>     2344 |  struct bkey_packed start[0];
> 	 |                     ^~~~~
>    cc1: all warnings being treated as errors
>    make[4]: *** [scripts/Makefile.build:243: fs/bcachefs/btree_io.o] Error 1
>    make[3]: *** [scripts/Makefile.build:480: fs/bcachefs] Error 2
>    make[2]: *** [scripts/Makefile.build:480: fs] Error 2
>    make[1]: *** [/local/src/kernel/git/linux/Makefile:1913: .] Error 2
>    make: *** [Makefile:234: __sub-make] Error 2

It seems gcc 10 complains in situations gcc 11 does not.

I've got the following patch running through my testing automation now:

-- >8 --
From: Kent Overstreet <kent.overstreet@linux.dev>
Date: Tue, 31 Oct 2023 18:05:22 -0400
Subject: [PATCH] bcachefs: Fix build errors with gcc 10

gcc 10 seems to complain about array bounds in situations where gcc 11
does not - curious.

This unfortunately requires adding some casts for now; we may
investigate getting rid of our __u64 _data[] VLA in a future patch so
that our start[0] members can be VLAs.

Reported-by: John Stoffel <john@stoffel.org>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>

diff --git a/fs/bcachefs/bcachefs_format.h b/fs/bcachefs/bcachefs_format.h
index 29b000c6b7e1..5b44598b9df9 100644
--- a/fs/bcachefs/bcachefs_format.h
+++ b/fs/bcachefs/bcachefs_format.h
@@ -1617,9 +1617,7 @@ struct journal_seq_blacklist_entry {
 
 struct bch_sb_field_journal_seq_blacklist {
 	struct bch_sb_field	field;
-
-	struct journal_seq_blacklist_entry start[0];
-	__u64			_data[];
+	struct journal_seq_blacklist_entry start[];
 };
 
 struct bch_sb_field_errors {
diff --git a/fs/bcachefs/btree_trans_commit.c b/fs/bcachefs/btree_trans_commit.c
index 8140b6e6e9a6..32693f7c6221 100644
--- a/fs/bcachefs/btree_trans_commit.c
+++ b/fs/bcachefs/btree_trans_commit.c
@@ -681,7 +681,7 @@ bch2_trans_commit_write_locked(struct btree_trans *trans, unsigned flags,
 						       BCH_JSET_ENTRY_overwrite,
 						       i->btree_id, i->level,
 						       i->old_k.u64s);
-				bkey_reassemble(&entry->start[0],
+				bkey_reassemble((struct bkey_i *) entry->start,
 						(struct bkey_s_c) { &i->old_k, i->old_v });
 			}
 
@@ -689,7 +689,7 @@ bch2_trans_commit_write_locked(struct btree_trans *trans, unsigned flags,
 					       BCH_JSET_ENTRY_btree_keys,
 					       i->btree_id, i->level,
 					       i->k->k.u64s);
-			bkey_copy(&entry->start[0], i->k);
+			bkey_copy((struct bkey_i *) entry->start, i->k);
 		}
 
 		trans_for_each_wb_update(trans, wb) {
@@ -697,7 +697,7 @@ bch2_trans_commit_write_locked(struct btree_trans *trans, unsigned flags,
 					       BCH_JSET_ENTRY_btree_keys,
 					       wb->btree, 0,
 					       wb->k.k.u64s);
-			bkey_copy(&entry->start[0], &wb->k);
+			bkey_copy((struct bkey_i *) entry->start, &wb->k);
 		}
 
 		if (trans->journal_seq)
diff --git a/fs/bcachefs/btree_update_interior.c b/fs/bcachefs/btree_update_interior.c
index d029e0348c91..89ada89eafe7 100644
--- a/fs/bcachefs/btree_update_interior.c
+++ b/fs/bcachefs/btree_update_interior.c
@@ -2411,7 +2411,7 @@ void bch2_journal_entry_to_btree_root(struct bch_fs *c, struct jset_entry *entry
 
 	r->level = entry->level;
 	r->alive = true;
-	bkey_copy(&r->key, &entry->start[0]);
+	bkey_copy(&r->key, (struct bkey_i *) entry->start);
 
 	mutex_unlock(&c->btree_root_lock);
 }
diff --git a/fs/bcachefs/btree_update_interior.h b/fs/bcachefs/btree_update_interior.h
index 5e0a467fe905..d92b3cf5f5e0 100644
--- a/fs/bcachefs/btree_update_interior.h
+++ b/fs/bcachefs/btree_update_interior.h
@@ -271,7 +271,7 @@ static inline struct btree_node_entry *want_new_bset(struct bch_fs *c,
 	struct btree_node_entry *bne = max(write_block(b),
 			(void *) btree_bkey_last(b, bset_tree_last(b)));
 	ssize_t remaining_space =
-		__bch_btree_u64s_remaining(c, b, &bne->keys.start[0]);
+		__bch_btree_u64s_remaining(c, b, bne->keys.start);
 
 	if (unlikely(bset_written(b, bset(b, t)))) {
 		if (remaining_space > (ssize_t) (block_bytes(c) >> 3))
diff --git a/fs/bcachefs/recovery.c b/fs/bcachefs/recovery.c
index f73338f37bf1..9600b8083175 100644
--- a/fs/bcachefs/recovery.c
+++ b/fs/bcachefs/recovery.c
@@ -226,7 +226,7 @@ static int journal_replay_entry_early(struct bch_fs *c,
 
 		if (entry->u64s) {
 			r->level = entry->level;
-			bkey_copy(&r->key, &entry->start[0]);
+			bkey_copy(&r->key, (struct bkey_i *) entry->start);
 			r->error = 0;
 		} else {
 			r->error = -EIO;

