Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD3C77410B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 19:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234161AbjHHROI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Aug 2023 13:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234166AbjHHRNO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:13:14 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7811FEB;
        Tue,  8 Aug 2023 09:05:36 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3a5a7e7cd61so3453b6e.0;
        Tue, 08 Aug 2023 09:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691510734; x=1692115534;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fzo2iEFDqjoKe2itTMhBe9POlM72/0NxEjlqkxD4yos=;
        b=hw+egfc2PQOt5QpwbC8cssCgppxquQz04Bh4CeMRWhFMrFfN/so4LLPArgM6yEOz6z
         IKsX3eB9ACQ/Uu2A+HBt6KT2AUI9HfY+7Hnswa1k4evelaK5gn0FR7KN8eRxhmDxSoLH
         Zv3xdoAfuCfvX+GiJ/tZpT/vHGQ0GEP8GeDE/hGwAAOwBRqGlqQcXcZr9QzxBhGrahH8
         9FVCYuXzNd98T+cOCMV1W63T4FVJOOWD44zWS41ZuxB9hFoeVE+Z25InGnABIHWiTNrB
         uu1cSxZPdBXFl+yVi1oCjQIrfJCUOg/2TAvvw6ZNmEuo6j188tmMqegfIwn830C7PPRZ
         ESMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691510734; x=1692115534;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fzo2iEFDqjoKe2itTMhBe9POlM72/0NxEjlqkxD4yos=;
        b=eMKzuDdgwvgvrA1NvH9c7A+e4YZaasa6lHdsLq/B0VE+VPU5q9erj3PutGgj8T//x8
         E+bNAYtXTdtrdSakqBzvzpKGnTo1lRE1mpnXU4fUAgMDHF+ym7e6aDkpqSfYgS6M67AC
         5GAp2LWUrgLe8sIOHbKDhVfVQASwyjtvn8tyTAGSqZ+e5Svo/CT0BaDWtc+0dzNV/7rL
         RMy80gFBYz1H2O6GJ+4YL0EVkWmTOg4BUPQL8F7XH19yuEsqI6QeRMTCgVxVQvXUiXbO
         5r8kkexBT8lGO71RWv7v/hIWbl9bSKjbnlBxOzSPzbxH+oqPX4nTmb9LcWF0S9l/a8gn
         cZug==
X-Gm-Message-State: AOJu0Yw3PJ37//UfN9TIB6BJpFRjXjhU7aGO80Hrvb9ZisTKSUrR1zvU
        bRH7tx7nPtVv5pqMWv/Yxi7OzD7OlEDOkwlpqrk=
X-Google-Smtp-Source: AGHT+IE2hLN6Y11fMODLcfJGKbsNaQN0QJkyBsZgrNCuKEKiq7TSCLBxpdnFM3YHKgDmZZ0WHdo1jVeyR8NNQpSVD38=
X-Received: by 2002:a05:6808:1827:b0:3a4:4993:eef9 with SMTP id
 bh39-20020a056808182700b003a44993eef9mr9067286oib.28.1691510733916; Tue, 08
 Aug 2023 09:05:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:129a:0:b0:4f0:1250:dd51 with HTTP; Tue, 8 Aug 2023
 09:05:33 -0700 (PDT)
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Tue, 8 Aug 2023 18:05:33 +0200
Message-ID: <CAGudoHF_Y0shcU+AMRRdN5RQgs9L_HHvBH8D4K=7_0X72kYy2g@mail.gmail.com>
Subject: new_inode_pseudo vs locked inode->i_state = 0
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

new_inode_pseudo is:
        struct inode *inode = alloc_inode(sb);

	if (inode) {
		spin_lock(&inode->i_lock);
		inode->i_state = 0;
		spin_unlock(&inode->i_lock);
	}

I'm trying to understand:
1. why is it zeroing i_state (as opposed to have it happen in inode_init_always)
2. why is zeroing taking place with i_lock held

The inode is freshly allocated, not yet added to the hash -- I would
expect that nobody else can see it.

Moreover, another consumer of alloc_inode zeroes without bothering to
lock -- see iget5_locked:
[snip]
	struct inode *new = alloc_inode(sb);

		if (new) {
			new->i_state = 0;
[/snip]

I tried to find justification for it in git, the pre-history-wipe repo
(git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git)
says it came in "Import 2.1.45pre1" in 1997. This is where my digging
stopped.

As is, I strongly suspect this is a leftover waiting for clean up.
Moving i_state = 0 back to inode_init_always would result in a few
simplifications in the area. I'm happy to make them, provided this is
indeed safe.

If the lock is required, then it should be added to iget5_locked?

UNRELATED:

While here, new_inode starts with: spin_lock_prefetch(&sb->s_inode_list_lock)

This was also *way* back in a huge commit, since the line was only
getting patched to remain compilable.

This is the only remaining spin_lock_prefetch use in the tree.

I don't know the original justification nor whether it made sense at
the time, this is definitely problematic today in the rather heavy
multicore era -- there is tons of work happening between the prefetch
and actually take the s_inode_list_lock lock, meaning if there is
contention, the cacheline is going to be marked invalid by the time
spin_lock on it is called. But then this only adds to cacheline
bouncing.

Personally I would just remove this line without even trying to benchmark.
-- 
Mateusz Guzik <mjguzik gmail.com>
