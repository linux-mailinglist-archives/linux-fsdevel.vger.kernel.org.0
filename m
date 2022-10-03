Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C51C35F38B6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Oct 2022 00:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbiJCWSy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Oct 2022 18:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiJCWSp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Oct 2022 18:18:45 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887F64DB0A;
        Mon,  3 Oct 2022 15:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TGwU/N4a47sP6hsnMoQt2nlieeLBUyOBUKzXe25Fmd8=; b=fFw+XTHeOH4hxjGeac0A2pkwHG
        aYcQ8iZUbeQf54nPaVlUO8rvJH25YaWdqKR2uAc2MOMh4fqA8u5bi3Cj44OjaT+/NgA4mXw0EMdk/
        ek4ZPbUfOJebBjTBfjOXarM0Kfcv/SSkCLvf4KBFakesWcezvq7ehClYpSU5Wg4PLqpzpH0/2dsec
        IAavQe+CifzMQgD628CM50oEhIphcoRiz66pn08uwNfOPrPjaVt5ioXaW+ZBnkOS33TxQ5MCaL1sl
        +rv94sr4yzPq/FjPOMWqYwOgfOcGjTbwLL4JmmiJOcvCUCyFTKGE3rVYaZUxRjMfSd4ZK1AXNLNGC
        huGcis7Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1ofTll-006clE-2F;
        Mon, 03 Oct 2022 22:18:37 +0000
Date:   Mon, 3 Oct 2022 23:18:37 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     "J. R. Okajima" <hooanon05g@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH][CFT] [coredump] don't use __kernel_write() on
 kmap_local_page()
Message-ID: <YztfvaAFOe2kGvDz@ZenIV>
References: <YzN+ZYLjK6HI1P1C@ZenIV>
 <YzSSl1ItVlARDvG3@ZenIV>
 <YzpcXU2WO8e22Cmi@iweiny-desk3>
 <7714.1664794108@jrobl>
 <Yzs4mL3zrrC0/vN+@iweiny-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yzs4mL3zrrC0/vN+@iweiny-mobl>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 03, 2022 at 12:31:36PM -0700, Ira Weiny wrote:
> On Mon, Oct 03, 2022 at 07:48:28PM +0900, J. R. Okajima wrote:
> > Ira Weiny:
> > > On Wed, Sep 28, 2022 at 07:29:43PM +0100, Al Viro wrote:
> > > > On Tue, Sep 27, 2022 at 11:51:17PM +0100, Al Viro wrote:
> > > > > [I'm going to send a pull request tomorrow if nobody yells;
> > > > > please review and test - it seems to work fine here, but extra
> > > > > eyes and extra testing would be very welcome]
> > 
> > I tried gdb backtrace 'bt' command with the new core by v6.0, and it
> > doesn't show the call trace correctly. Is it related to this commit?
> >
> 
> Are you also getting something like this?
> 
> BFD: warning: /mnt/9p/test-okajima/core is truncated: expected core file size >= 225280, found: 76616
> 
> I did not see that before.  I'm running through this patch vs a fix to
> kmap_to_page()[1] and I may have gotten the 2 crossed up.  So I'm retesting
> with your test below.

Argh....  Try this:

fix coredump breakage caused by badly tested "[coredump] don't use __kernel_write() on kmap_local_page()"

Let me count the ways I'd screwed up:

* when emitting a page, handling of gaps in coredump should happen
before fetching the current file position.
* fix for problem that occurs on rather uncommon setups (and hadn't
been observed in the wild) sent very late in the cycle.
* ... with badly insufficient testing, introducing an easily
reproducable breakage.  Without giving it time to soak in -next.

Fucked-up-by: Al Viro <viro@zeniv.linux.org.uk>
Fixes: 06bbaa6dc53c "[coredump] don't use __kernel_write() on kmap_local_page()"
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/fs/coredump.c b/fs/coredump.c
index 1ab4f5b76a1e..3538f3a63965 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -841,7 +841,7 @@ static int dump_emit_page(struct coredump_params *cprm, struct page *page)
 	};
 	struct iov_iter iter;
 	struct file *file = cprm->file;
-	loff_t pos = file->f_pos;
+	loff_t pos;
 	ssize_t n;
 
 	if (cprm->to_skip) {
@@ -853,6 +853,7 @@ static int dump_emit_page(struct coredump_params *cprm, struct page *page)
 		return 0;
 	if (dump_interrupted())
 		return 0;
+	pos = file->f_pos;
 	iov_iter_bvec(&iter, WRITE, &bvec, 1, PAGE_SIZE);
 	n = __kernel_write_iter(cprm->file, &iter, &pos);
 	if (n != PAGE_SIZE)
