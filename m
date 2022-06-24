Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0564E55A3DF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jun 2022 23:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbiFXVsn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jun 2022 17:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiFXVsn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jun 2022 17:48:43 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2DD87B45;
        Fri, 24 Jun 2022 14:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KhLvdR8dqxxIHtQYXldm6IaigMgkt/y4dE8JBmBcxGo=; b=htS2TKEgga3eo+9gBpqrPPMBx2
        //IySGvrywnil/LYXWSwWTMvSRQrO5yaDYuqZ2HiwcFW+gmcxyjZh/cAwFv8IE2h11QyGA21zvQHf
        XhcJH8xZH4MxJfQocXOFZMQcb+gQhtSLBM2HMoxUfQA5lEBpYlgUKMfMMisDEJzzPwzGR+vysZyFX
        izF+a1UFpgmKnIH607hQm90kvSg/x2rpHCu5QTR0Rt+R70MnRzhMWSUCUbS8tt0hcKeFa9ifu+WQc
        IUeYdqs8yCKhOLD4gD+mM+RG2f424ysoNEurVUzbg9j7yvU3uDjNMxSg/MPPPe+I5OfXtD3bXpM0h
        ZBosvAgA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o4rAO-0044uS-3s;
        Fri, 24 Jun 2022 21:48:40 +0000
Date:   Fri, 24 Jun 2022 22:48:40 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/6] fs: do not set no_llseek in fops
Message-ID: <YrYxOC5dgCKBHwVE@ZenIV>
References: <20220624165631.2124632-1-Jason@zx2c4.com>
 <20220624165631.2124632-3-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624165631.2124632-3-Jason@zx2c4.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 24, 2022 at 06:56:27PM +0200, Jason A. Donenfeld wrote:
> vfs_llseek already does something with this, and it makes it difficult
> to distinguish between llseek being supported and not.

How about something along the lines of

===
struct file_operations ->llseek() method gets called only in two places:
vfs_llseek() and dump_skip().  Both treat NULL and no_llseek as
equivalent.

The value of ->llseek is also examined in __full_proxy_fops_init() and
ovl_copy_up_data().  For the former we could as well treat no_llseek
as NULL; no need to do a proxy wrapper around the function that fails
with -ESPIPE without so much as looking at its arguments.
Same for the latter - there no_llseek would end up with skip_hole
set true until the first time we look at it.  At that point we
call vfs_llseek(), observe that it has failed (-ESPIPE), shrug and
set skip_hole false.  Might as well have done that from the very
beginning.

	In other words, any place where .llseek is set to no_llseek
could just as well set it to NULL.
===

for commit message?

Next commit would remove the checks for no_llseek and have vfs_llseek()
just do
        if (file->f_mode & FMODE_LSEEK) {
		if (file->f_op->llseek)
			return file->f_op->llseek(file, offset, whence);
	}
	return -ESPIPE;
and kill no_llseek() off.  And once you have guaranteed that FMODE_LSEEK
is never set with NULL ->llseek, vfs_llseek() gets trimmed in obvious
way and tests in dump_skip() and ovl_copy_up_data() would become simply
file->f_mode & FMODE_LSEEK - no need to check ->f_op->llseek there
after that.  At the same time dump_skip() could switch to calling
vfs_llseek() instead of direct method call...
