Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF4850D70B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Apr 2022 04:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240406AbiDYCrp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Apr 2022 22:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240266AbiDYCrn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Apr 2022 22:47:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138F068F87;
        Sun, 24 Apr 2022 19:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5cqZcBN/6VFoY2Kiw77E9V9l0udJorJnVRNxt6POB6Y=; b=pIe19kOM7lwduX9PIpON6Gl3Sb
        tYT/bmec/CDms8FQucEQp6BGZAPj/h3jUBLBkh0h3XXCKXO9c1KHZeplYXXTzPkIudQ39ORiAUt1N
        BDgYk5dNJzeztVjkG2pEEedWZvlTrtkUFgbOqjalWHN4EJ36ksozrS4EeaTP70ABLfhLRM3erkfXj
        uxEUuxKkBhom61Yus7fC7pKXE5CTkq32ISL4+6DCXYl0Aj7z6B89Xs0wZMj+zH3y+YZ8xVGwe9of6
        B5fdfzAbcW4/J1UmME6cC0nkd6PsnNAkik1MjWGztykCGHMi/GWeEEqJn9diQEIk29exTmYH1X9+H
        nABXy5rA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nioiI-008N4t-Ir; Mon, 25 Apr 2022 02:44:34 +0000
Date:   Mon, 25 Apr 2022 03:44:34 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Joe Perches <joe@perches.com>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, hch@lst.de, hannes@cmpxchg.org,
        akpm@linux-foundation.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-input@vger.kernel.org,
        roman.gushchin@linux.dev
Subject: Re: [PATCH v2 1/8] lib/printbuf: New data structure for
 heap-allocated strings
Message-ID: <YmYLEovwj9BqeZQA@casper.infradead.org>
References: <20220421234837.3629927-1-kent.overstreet@gmail.com>
 <20220421234837.3629927-7-kent.overstreet@gmail.com>
 <fcaf18ed6efaafa6ca7df79712d9d317645215f8.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcaf18ed6efaafa6ca7df79712d9d317645215f8.camel@perches.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Apr 24, 2022 at 04:46:03PM -0700, Joe Perches wrote:
> > + * pr_human_readable_u64, pr_human_readable_s64: Print an integer with human
> > + * readable units.
> 
> Why not extend vsprintf for this using something like %pH[8|16|32|64] 
> or %pH[c|s|l|ll|uc|us|ul|ull] ?

The %pX extension we have is _cute_, but ultimately a bad idea.  It
centralises all kinds of unrelated things in vsprintf.c, eg bdev_name()
and clock() and ip_addr_string().

Really, it's working around that we don't have something like Java's
StringBuffer (which I see both seq_buf and printbuf as attempting to
be).  So we have this primitive format string hack instead of exposing
methods like:

void dentry_string(struct strbuf *, struct dentry *);

as an example,
                if (unlikely(ino == dir->i_ino)) {
                        EXT4_ERROR_INODE(dir, "'%pd' linked to parent dir",
                                         dentry);
                        return ERR_PTR(-EFSCORRUPTED);
                }

would become something like:

		if (unlikely(ino == dir->i_ino)) {
			struct strbuf strbuf;
			strbuf_char(strbuf, '\'');
			dentry_string(strbuf, dentry);
			strbuf_string(strbuf, "' linked to parent dir");
			EXT4_ERROR_INODE(dir, strbuf);
			return ERR_PTR(-EFSCORRUPTED);
		}

which isn't terribly nice, but C has sucky syntax for string
construction.  Other languages have done this better, including Rust.
