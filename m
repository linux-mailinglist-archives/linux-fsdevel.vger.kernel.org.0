Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65E9E770F7C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Aug 2023 13:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjHELrC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Aug 2023 07:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjHELrB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Aug 2023 07:47:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B1AE70;
        Sat,  5 Aug 2023 04:47:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0572A60CEE;
        Sat,  5 Aug 2023 11:47:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59E14C433C7;
        Sat,  5 Aug 2023 11:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691236019;
        bh=F/viQAtCmBsmf8fFp/zPikP9dkOYxWBOVwWsvbEtFoo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=aX+IVGk+jRFoLbKXeetWjJjbWnapZMv/0/fmNScSSJp9kCOXYm2S/n0yOmzm9xUlw
         7vMc36YxuJEbSulRYyFzdWCWkHaU0BQSfkhu7D/jAL/DgKlUHhH5PfbzfPx7IWDEh1
         U9I689NN3CEgHmTbZJNCISno/Q/9N7fIpqiiL7FnOlOg1vh/xe5qTkJG4rkqM4dYRI
         0AY39gTayUF1sWTudSMRhg7CyxfqA7BICD2b74CB3I01f08dkcW0o99EwxvCr5kDID
         9Pw8c3trzDy1dWzvuSK1VoEWh1fmIX9MEfTCf0wxQVoMGeK4Bjjx+kD00P2Z91G+fW
         YKU59cBGqf79w==
Date:   Sat, 5 Aug 2023 13:46:54 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mateusz Guzik <mjguzik@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>,
        linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] file: always lock position
Message-ID: <20230805-furor-angekauft-82e334fc83a3@brauner>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="2pofktc7xzw7zelm"
Content-Disposition: inline
In-Reply-To: <20230804-turnverein-helfer-ef07a4d7bbec@brauner>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--2pofktc7xzw7zelm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

> > thing to do is to just special-case S_ISDIR. Not lovely, but whatever.
> > 
> > So something like this instead? It's a smaller diff anyway, and it
> > gets the crazy afds/ceph cases right too.
> 
> If you really care about this we can do it. But if we can live with just

I see you went with the S_ISDIR thing for now. How do you feel about
adding something like the appended patch (untested) on top of this?

So instead of relying on the inode we could just check f_ops for
iterate/iterate_shared. That should amount to the same thing(*) but
looks cleaner to me. Alternatively we can do the flag thing you
mentioned ofc.

(*) I suffered from a proper cold so my brain is in a half-working state.

--2pofktc7xzw7zelm
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment; filename="dir.diff"

diff --git a/fs/file.c b/fs/file.c
index dbca26ef7a01..dd49bc77d5cf 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -1046,10 +1046,11 @@ unsigned long __fdget_raw(unsigned int fd)
  * not be, and for directories this is a correctness
  * issue, not a "POSIX requirement".
  */
-static inline bool file_needs_f_pos_lock(struct file *file)
+static inline bool file_needs_f_pos_lock(const struct file *file)
 {
 	return (file->f_mode & FMODE_ATOMIC_POS) &&
-		(file_count(file) > 1 || S_ISDIR(file_inode(file)->i_mode));
+	       (file_count(file) > 1 ||
+		file->f_op->iterate_shared || file->f_op->iterate);
 }
 
 unsigned long __fdget_pos(unsigned int fd)

--2pofktc7xzw7zelm--
