Return-Path: <linux-fsdevel+bounces-1669-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B77DF7DD7E2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 22:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D5801F216DA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 21:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140A1249FE;
	Tue, 31 Oct 2023 21:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B884208A2
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 21:48:41 +0000 (UTC)
Received: from mail.stoffel.org (mail.stoffel.org [172.104.24.175])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68F1E4;
	Tue, 31 Oct 2023 14:48:40 -0700 (PDT)
Received: from quad.stoffel.org (097-095-183-072.res.spectrum.com [97.95.183.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.stoffel.org (Postfix) with ESMTPSA id 0DFA91E135;
	Tue, 31 Oct 2023 17:48:40 -0400 (EDT)
Received: by quad.stoffel.org (Postfix, from userid 1000)
	id 2CCD7A8B05; Tue, 31 Oct 2023 17:48:39 -0400 (EDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Message-ID: <25921.30263.150556.245226@quad.stoffel.home>
Date: Tue, 31 Oct 2023 17:48:39 -0400
From: "John Stoffel" <john@stoffel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
    Linus Torvalds <torvalds@linux-foundation.org>,
    linux-bcachefs@vger.kernel.org,
    linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs for v6.7


Using latest HEAD from linux git (commit
5a6a09e97199d6600d31383055f9d43fbbcbe86f (HEAD -> master,
origin/master, origin/HEAD), and the following config, I get this
failure when compiling on x86_64 Debian Bullseye (11):


     CC      fs/bcachefs/btree_io.o
   In file included from fs/bcachefs/btree_io.c:11:
   fs/bcachefs/btree_io.c: In function =E2=80=98bch2_btree_post_write_c=
leanup=E2=80=99:
   fs/bcachefs/btree_update_interior.h:274:36: error: array subscript 0=
 is outside the bounds of an interior zero-length array =E2=80=98struct=
 bkey_packed[0]=E2=80=99 [-Werror=3Dzero-length-bounds]
     274 |   __bch_btree_u64s_remaining(c, b, &bne->keys.start[0]);
=09 |                                    ^~~~~~~~~~~~~~~~~~~
   In file included from fs/bcachefs/bcachefs.h:206,
=09=09    from fs/bcachefs/btree_io.c:3:
   fs/bcachefs/bcachefs_format.h:2344:21: note: while referencing =E2=80=
=98start=E2=80=99
    2344 |  struct bkey_packed start[0];
=09 |                     ^~~~~
   In file included from fs/bcachefs/btree_io.c:11:
   fs/bcachefs/btree_io.c: In function =E2=80=98bch2_btree_init_next=E2=
=80=99:
   fs/bcachefs/btree_update_interior.h:274:36: error: array subscript 0=
 is outside the bounds of an interior zero-length array =E2=80=98struct=
 bkey_packed[0]=E2=80=99 [-Werror=3Dzero-length-bounds]
     274 |   __bch_btree_u64s_remaining(c, b, &bne->keys.start[0]);
=09 |                                    ^~~~~~~~~~~~~~~~~~~
   In file included from fs/bcachefs/bcachefs.h:206,
=09=09    from fs/bcachefs/btree_io.c:3:
   fs/bcachefs/bcachefs_format.h:2344:21: note: while referencing =E2=80=
=98start=E2=80=99
    2344 |  struct bkey_packed start[0];
=09 |                     ^~~~~
   cc1: all warnings being treated as errors
   make[4]: *** [scripts/Makefile.build:243: fs/bcachefs/btree_io.o] Er=
ror 1
   make[3]: *** [scripts/Makefile.build:480: fs/bcachefs] Error 2
   make[2]: *** [scripts/Makefile.build:480: fs] Error 2
   make[1]: *** [/local/src/kernel/git/linux/Makefile:1913: .] Error 2
   make: *** [Makefile:234: __sub-make] Error 2


My .config looks like this for BCACHEFS:

   $ grep BCACHEFS .config
   CONFIG_BCACHEFS_FS=3Dy
   CONFIG_BCACHEFS_QUOTA=3Dy
   CONFIG_BCACHEFS_POSIX_ACL=3Dy
   CONFIG_BCACHEFS_DEBUG_TRANSACTIONS=3Dy
   CONFIG_BCACHEFS_DEBUG=3Dy
   CONFIG_BCACHEFS_TESTS=3Dy
   # CONFIG_BCACHEFS_LOCK_TIME_STATS is not set
   # CONFIG_BCACHEFS_NO_LATENCY_ACCT is not set


