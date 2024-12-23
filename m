Return-Path: <linux-fsdevel+bounces-38012-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CAB89FA9E5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 05:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05703188583C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 04:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CCD189520;
	Mon, 23 Dec 2024 04:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="He129GzW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B12183CCA
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Dec 2024 04:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734927946; cv=none; b=ips38BM71ytsczg+5B/SY3foRX7CHKQY3nePdHh0smXv7VQHooeOMY92FEgxF30QqRXbrxQXLdCB0o3ZRThBQwjjD4AXMBBSU5weYspcMTSJ8XASgz7i0m/olUo7bOsoVZqhsS88So9t6DGZzXZL7WE1dHU1wkkXKcEmC7YiKnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734927946; c=relaxed/simple;
	bh=NkUeRHj4ASHTKvhwJA5PCBquN4KYFTnYKeh3AnFL360=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PU7UiSbIE1/BUxeTOpm4cZ5rxo7ryvl/DZSJwFqoG3n2BaL2FixRLp4s3FEOOKWL3k7hPugwoF12EAwk2lDDhpb3LYfE92u1V1lkYL20boNFLiskZOepTxNu8nEYMcXWr2VR79JULw4n2pv9yAxPtjbMuvhKnFpHF8n+qhT+3ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=He129GzW; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1c4Gt5XuQvpjtBI3pa/oE4XlQDQgY5fhSXzERIzOfvU=; b=He129GzWZw1IDuLJo2Ek4lTb6g
	6n9vZRko/sfq0izW25RMTzPqQ7DEyQYf5B3YH5ridSNAGYYmz1ZrOpvVh4xf3zMoVUdSe0tXG/S8R
	GSnkk2NnFyL4UzlcFz02TxVJttIMc927/mV5HqKjn6PzFKwZwsSmmSHj/H0hjHJa7RXvoVLM0Ob/0
	w8Tc54QOedQVQ7XWtfTnlP+yoKMA/31SzpcXqK79ZU2cm7E0R3gBC6h/1nrqdYLTbBlA0DM/cet/t
	MuEga3bqmwfwLGXIIwwdHm6c3Jdp0WhrvpdeyISx8Ujk8FLeVDYysTbQc4bMPjBeVxddZ9mQAQo0e
	m4EgPmOg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tPa0i-0000000BBXa-1lRm;
	Mon, 23 Dec 2024 04:25:40 +0000
Date: Mon, 23 Dec 2024 04:25:40 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jann Horn <jannh@google.com>
Subject: Re: [PATCH][RFC] make take_dentry_name_snapshot() lockless
Message-ID: <20241223042540.GG1977892@ZenIV>
References: <20241209035251.GV3387508@ZenIV>
 <CAHk-=wh4=95ainkHyi5n3nFCToNWhLcfQtziSp3jSFSQGzQUAw@mail.gmail.com>
 <20241209211708.GA3387508@ZenIV>
 <20241209222854.GB3387508@ZenIV>
 <CAHk-=wjrtchauo9CO1ebkiES0X1VaZinjnHmcXQGBcZNHzyyBA@mail.gmail.com>
 <CAHk-=wj_rCVrTiRMyD8UKkRdUpeGiheyrZcf28H6OADRkLPFkw@mail.gmail.com>
 <20241209231237.GC3387508@ZenIV>
 <20241210024523.GD3387508@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210024523.GD3387508@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Dec 10, 2024 at 02:45:23AM +0000, Al Viro wrote:
> On Mon, Dec 09, 2024 at 11:12:37PM +0000, Al Viro wrote:
> > 
> > Actually, grepping for DNAME_INLINE_LEN brings some interesting hits:
> > drivers/net/ieee802154/adf7242.c:1165:  char debugfs_dir_name[DNAME_INLINE_LEN + 1];
> > 	cargo-culted, AFAICS; would be better off with a constant of their own.
> > 
> > fs/ext4/fast_commit.c:326:              fc_dentry->fcd_name.len > DNAME_INLINE_LEN)
> > fs/ext4/fast_commit.c:452:      if (dentry->d_name.len > DNAME_INLINE_LEN) {
> > fs/ext4/fast_commit.c:1332:                     fc_dentry->fcd_name.len > DNAME_INLINE_LEN)
> > fs/ext4/fast_commit.h:113:      unsigned char fcd_iname[DNAME_INLINE_LEN];      /* Dirent name string */
> > 	Looks like that might want struct name_snapshot, along with
> > {take,release}_dentry_name_snapshot().
> 
> See viro/vfs.git#work.dcache.  I've thrown ext4/fast_commit conversion
> into the end of that pile.  NOTE: that stuff obviously needs profiling.
> It does survive light testing (boot/ltp/xfstests), but review and more
> testing (including serious profiling) is obviously needed.
> 
> Patches in followups...

More fun with ->d_name, ->d_iname and friends:

87ce955b24c9 "io_uring: add ->show_fdinfo() for the io_uring file descriptor"
is playing silly buggers with ->d_iname for some reason.  This
        seq_printf(m, "UserFiles:\t%u\n", ctx->file_table.data.nr);
        for (i = 0; has_lock && i < ctx->file_table.data.nr; i++) {
                struct file *f = NULL;

                if (ctx->file_table.data.nodes[i])
                        f = io_slot_file(ctx->file_table.data.nodes[i]);
                if (f)
                        seq_printf(m, "%5u: %s\n", i, file_dentry(f)->d_iname);
                else
                        seq_printf(m, "%5u: <none>\n", i);
        }
produces user-visible data.  For each slot in io_uring file table you
show either that it's empty (fine) or, for files with short names, the
last component of the name (no quoting, etc. - just a string as-is) or
the last short name that dentry used to have.

And that's a user-visible ABI.  What the hell?

NOTE: file here is may be anything whatsoever.  It may be a pipe,
an arbitrary file in tmpfs, a socket, etc.

How hard an ABI it is?  If it's really used by random userland code
(admin tools, etc.), we have a problem.  If that thing is cast in
stone, we'll have to emulate the current behaviour of that code,
no matter what.  I really hope it can be replaced with something
saner, though.

Incidentally, call your file "<none>"; is the current behaviour
the right thing to do?

What behaviour _is_ actually wanted?  Jens, Jann?

