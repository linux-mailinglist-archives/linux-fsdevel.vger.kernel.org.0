Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F125825E0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jul 2022 13:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbiG0LtU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jul 2022 07:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232499AbiG0LtQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jul 2022 07:49:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67BE74AD78
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Jul 2022 04:49:13 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658922551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l2X2DqDoeVLNPuGgYJPU21ZoOObmpTzKokmqtTV7SfU=;
        b=kX5EgXzxRRECz7jKIFEP/hsLUb0CV0p141JOd/QfZwhqNUKIooUzw3X7XoZ0aMq8lFXzui
        U5zCOTb5tIPlb3z/SfAR6x83w9vpwiWWKw4ZlsVzJHlD7rEVra0tE5GkNBKzYdCc5rLUZn
        /uneJWJUHA9DZu/KqcBxq/MVViXbmgXHoem7eQNHcIRljoQpYP2flQ2TsAVyMrh1dqTirQ
        dhUZt9nvRSZcZAaqVxnbuy5OQB8jGEpky6++Tv8wpyI+ux1e9zeRAE35yYb4YQh0gCLfqQ
        B8T2mGZVFzaDQCnM7PEfg85watjCRGJFNaPmSFZdNeOEAY+hEXqeKyfmJqWMqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658922551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l2X2DqDoeVLNPuGgYJPU21ZoOObmpTzKokmqtTV7SfU=;
        b=tDa/NobMm33dK6f5onLnvWViwfdJPf6DfPZXd/n6UaF58XGLzaW6CxWz2/Qi5cFD7jXPBo
        4H3tJavv/dv2MWDA==
To:     linux-fsdevel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 1/4 v2] fs/dcache: d_add_ci() needs to complete parallel lookup.
Date:   Wed, 27 Jul 2022 13:49:01 +0200
Message-Id: <20220727114904.130761-2-bigeasy@linutronix.de>
In-Reply-To: <20220727114904.130761-1-bigeasy@linutronix.de>
References: <20220727114904.130761-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Result of d_alloc_parallel() in d_add_ci() is fed to d_splice_alias(), which
*NORMALLY* feeds it to __d_add() or __d_move() in a way that will have
__d_lookup_done() applied to it.

However, there is a nasty possibility - d_splice_alias() might legitimately
fail without having marked the sucker not in-lookup. dentry will get dropped
by d_add_ci(), so ->d_wait won't end up pointing to freed object, but it's
still a bug - retain_dentry() will scream bloody murder upon seeing that, a=
nd
for a good reason; we'll get hash chain corrupted. It's impossible to hit
without corrupted fs image (ntfs or case-insensitive xfs), but it's a bug.

Invoke d_lookup_done() after d_splice_alias() to ensure that the
in-lookip flag is always cleared.

Fixes: d9171b9345261 ("parallel lookups machinery, part 4 (and last)")
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 fs/dcache.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2239,6 +2239,7 @@ struct dentry *d_add_ci(struct dentry *d
 		}=20
 	}
 	res =3D d_splice_alias(inode, found);
+	d_lookup_done(found);
 	if (res) {
 		dput(found);
 		return res;
