Return-Path: <linux-fsdevel+bounces-1673-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 211A77DD81D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 23:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96112B20FB3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 22:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234FD27443;
	Tue, 31 Oct 2023 22:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FD91C3F
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 22:17:07 +0000 (UTC)
Received: from mail.stoffel.org (mail.stoffel.org [172.104.24.175])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AFF8F4;
	Tue, 31 Oct 2023 15:17:06 -0700 (PDT)
Received: from quad.stoffel.org (097-095-183-072.res.spectrum.com [97.95.183.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by mail.stoffel.org (Postfix) with ESMTPSA id 7A4C01E135;
	Tue, 31 Oct 2023 18:17:05 -0400 (EDT)
Received: by quad.stoffel.org (Postfix, from userid 1000)
	id 28373A8B07; Tue, 31 Oct 2023 18:17:05 -0400 (EDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Message-ID: <25921.31969.127938.469728@quad.stoffel.home>
Date: Tue, 31 Oct 2023 18:17:05 -0400
From: "John Stoffel" <john@stoffel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: John Stoffel <john@stoffel.org>,
    Geert Uytterhoeven <geert@linux-m68k.org>,
    Linus Torvalds <torvalds@linux-foundation.org>,
    linux-bcachefs@vger.kernel.org,
    linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org,
    Kees Cook <keescook@chromium.org>
Subject: Re: [GIT PULL] bcachefs for v6.7
In-Reply-To: <20231031221126.5wejfggu7gg2y3n4@moria.home.lan>
References: <25921.30263.150556.245226@quad.stoffel.home>
	<20231031221126.5wejfggu7gg2y3n4@moria.home.lan>
X-Mailer: VM 8.2.0b under 27.1 (x86_64-pc-linux-gnu)

>>>>> "Kent" =3D=3D Kent Overstreet <kent.overstreet@linux.dev> writes:=


> On Tue, Oct 31, 2023 at 05:48:39PM -0400, John Stoffel wrote:
>>=20
>> Using latest HEAD from linux git (commit
>> 5a6a09e97199d6600d31383055f9d43fbbcbe86f (HEAD -> master,
>> origin/master, origin/HEAD), and the following config, I get this
>> failure when compiling on x86_64 Debian Bullseye (11):
>>=20
>>=20
>> CC      fs/bcachefs/btree_io.o
>> In file included from fs/bcachefs/btree_io.c:11:
>> fs/bcachefs/btree_io.c: In function =E2=80=98bch2_btree_post_write_c=
leanup=E2=80=99:
>> fs/bcachefs/btree_update_interior.h:274:36: error: array subscript 0=
 is outside the bounds of an interior zero-length array =E2=80=98struct=
 bkey_packed[0]=E2=80=99 [-Werror=3Dzero-length-bounds]
>> 274 |   __bch_btree_u64s_remaining(c, b, &bne->keys.start[0]);
>> |                                    ^~~~~~~~~~~~~~~~~~~
>> In file included from fs/bcachefs/bcachefs.h:206,
>> from fs/bcachefs/btree_io.c:3:
>> fs/bcachefs/bcachefs_format.h:2344:21: note: while referencing =E2=80=
=98start=E2=80=99
>> 2344 |  struct bkey_packed start[0];
>> |                     ^~~~~
>> In file included from fs/bcachefs/btree_io.c:11:
>> fs/bcachefs/btree_io.c: In function =E2=80=98bch2_btree_init_next=E2=
=80=99:
>> fs/bcachefs/btree_update_interior.h:274:36: error: array subscript 0=
 is outside the bounds of an interior zero-length array =E2=80=98struct=
 bkey_packed[0]=E2=80=99 [-Werror=3Dzero-length-bounds]
>> 274 |   __bch_btree_u64s_remaining(c, b, &bne->keys.start[0]);
>> |                                    ^~~~~~~~~~~~~~~~~~~
>> In file included from fs/bcachefs/bcachefs.h:206,
>> from fs/bcachefs/btree_io.c:3:
>> fs/bcachefs/bcachefs_format.h:2344:21: note: while referencing =E2=80=
=98start=E2=80=99
>> 2344 |  struct bkey_packed start[0];
>> |                     ^~~~~
>> cc1: all warnings being treated as errors
>> make[4]: *** [scripts/Makefile.build:243: fs/bcachefs/btree_io.o] Er=
ror 1
>> make[3]: *** [scripts/Makefile.build:480: fs/bcachefs] Error 2
>> make[2]: *** [scripts/Makefile.build:480: fs] Error 2
>> make[1]: *** [/local/src/kernel/git/linux/Makefile:1913: .] Error 2
>> make: *** [Makefile:234: __sub-make] Error 2

> It seems gcc 10 complains in situations gcc 11 does not.

> I've got the following patch running through my testing automation no=
w:

> -- >8 --
> From: Kent Overstreet <kent.overstreet@linux.dev>
> Date: Tue, 31 Oct 2023 18:05:22 -0400
> Subject: [PATCH] bcachefs: Fix build errors with gcc 10

> gcc 10 seems to complain about array bounds in situations where gcc 1=
1
> does not - curious.

> This unfortunately requires adding some casts for now; we may
> investigate getting rid of our __u64 _data[] VLA in a future patch so=

> that our start[0] members can be VLAs.

> Reported-by: John Stoffel <john@stoffel.org>
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>

> diff --git a/fs/bcachefs/bcachefs_format.h b/fs/bcachefs/bcachefs_for=
mat.h
> index 29b000c6b7e1..5b44598b9df9 100644
> --- a/fs/bcachefs/bcachefs_format.h
> +++ b/fs/bcachefs/bcachefs_format.h
> @@ -1617,9 +1617,7 @@ struct journal_seq_blacklist_entry {
=20
>  struct bch_sb_field_journal_seq_blacklist {
>  =09struct bch_sb_field=09field;
> -
> -=09struct journal_seq_blacklist_entry start[0];
> -=09__u64=09=09=09_data[];
> +=09struct journal_seq_blacklist_entry start[];
>  };
=20
>  struct bch_sb_field_errors {
> diff --git a/fs/bcachefs/btree_trans_commit.c b/fs/bcachefs/btree_tra=
ns_commit.c
> index 8140b6e6e9a6..32693f7c6221 100644
> --- a/fs/bcachefs/btree_trans_commit.c
> +++ b/fs/bcachefs/btree_trans_commit.c
> @@ -681,7 +681,7 @@ bch2_trans_commit_write_locked(struct btree_trans=
 *trans, unsigned flags,
>  =09=09=09=09=09=09       BCH_JSET_ENTRY_overwrite,
i-> btree_id, i->level,
i-> old_k.u64s);
> -=09=09=09=09bkey_reassemble(&entry->start[0],
> +=09=09=09=09bkey_reassemble((struct bkey_i *) entry->start,
>  =09=09=09=09=09=09(struct bkey_s_c) { &i->old_k, i->old_v });
>  =09=09=09}
=20
> @@ -689,7 +689,7 @@ bch2_trans_commit_write_locked(struct btree_trans=
 *trans, unsigned flags,
>  =09=09=09=09=09       BCH_JSET_ENTRY_btree_keys,
i-> btree_id, i->level,
i-> k->k.u64s);
> -=09=09=09bkey_copy(&entry->start[0], i->k);
> +=09=09=09bkey_copy((struct bkey_i *) entry->start, i->k);
>  =09=09}
=20
>  =09=09trans_for_each_wb_update(trans, wb) {
> @@ -697,7 +697,7 @@ bch2_trans_commit_write_locked(struct btree_trans=
 *trans, unsigned flags,
>  =09=09=09=09=09       BCH_JSET_ENTRY_btree_keys,
wb-> btree, 0,
wb-> k.k.u64s);
> -=09=09=09bkey_copy(&entry->start[0], &wb->k);
> +=09=09=09bkey_copy((struct bkey_i *) entry->start, &wb->k);
>  =09=09}
=20
>  =09=09if (trans->journal_seq)
> diff --git a/fs/bcachefs/btree_update_interior.c b/fs/bcachefs/btree_=
update_interior.c
> index d029e0348c91..89ada89eafe7 100644
> --- a/fs/bcachefs/btree_update_interior.c
> +++ b/fs/bcachefs/btree_update_interior.c
> @@ -2411,7 +2411,7 @@ void bch2_journal_entry_to_btree_root(struct bc=
h_fs *c, struct jset_entry *entry
=20
r-> level =3D entry->level;
r-> alive =3D true;
> -=09bkey_copy(&r->key, &entry->start[0]);
> +=09bkey_copy(&r->key, (struct bkey_i *) entry->start);
=20
>  =09mutex_unlock(&c->btree_root_lock);
>  }
> diff --git a/fs/bcachefs/btree_update_interior.h b/fs/bcachefs/btree_=
update_interior.h
> index 5e0a467fe905..d92b3cf5f5e0 100644
> --- a/fs/bcachefs/btree_update_interior.h
> +++ b/fs/bcachefs/btree_update_interior.h
> @@ -271,7 +271,7 @@ static inline struct btree_node_entry *want_new_b=
set(struct bch_fs *c,
>  =09struct btree_node_entry *bne =3D max(write_block(b),
>  =09=09=09(void *) btree_bkey_last(b, bset_tree_last(b)));
>  =09ssize_t remaining_space =3D
> -=09=09__bch_btree_u64s_remaining(c, b, &bne->keys.start[0]);
> +=09=09__bch_btree_u64s_remaining(c, b, bne->keys.start);
=20
>  =09if (unlikely(bset_written(b, bset(b, t)))) {
>  =09=09if (remaining_space > (ssize_t) (block_bytes(c) >> 3))
> diff --git a/fs/bcachefs/recovery.c b/fs/bcachefs/recovery.c
> index f73338f37bf1..9600b8083175 100644
> --- a/fs/bcachefs/recovery.c
> +++ b/fs/bcachefs/recovery.c
> @@ -226,7 +226,7 @@ static int journal_replay_entry_early(struct bch_=
fs *c,
=20
>  =09=09if (entry->u64s) {
r-> level =3D entry->level;
> -=09=09=09bkey_copy(&r->key, &entry->start[0]);
> +=09=09=09bkey_copy(&r->key, (struct bkey_i *) entry->start);
r-> error =3D 0;
>  =09=09} else {
r-> error =3D -EIO;


So this fixes the compile error, thanks!  Sorry for not reporting the
gcc version better.  And it also compiles nicely when I remove all the
BACHEFS .config entries, accept all the defaults from 'make oldconfig'
and re-compile.

Cheers,
John

