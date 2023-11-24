Return-Path: <linux-fsdevel+bounces-3654-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 683987F6DBF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 09:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80B011C20A0E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 08:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9934C9465;
	Fri, 24 Nov 2023 08:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="nUI/LBl7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C355A130;
	Fri, 24 Nov 2023 00:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xb0fYDHuEvLn0b5HxDGh3ZwJKEg5iFq21bHRvvsAAys=; b=nUI/LBl71oIVtey5Ok/FIkn+ob
	oIP6Pl5zGOpBe6GWBtJP7D5sQ6g66A5bSQkcMqLm4MMC6FSrFz6mcF6AKngwy+DkyTDQr3YvvZjWE
	ljeXeVIIftu8KCVBDFsutuZVM9wVr9ZovLOhr3HE64jZEZTY1KZJGWP4ZBfJXphiEFY/upF9VvZn5
	Awvlq8Ioc0sG3pXZsBcgG6zjmrv4HcXpPaonc8kURrAmM5tBabYqkSnuoAsOxMXTepz169CWKA0q6
	mOBC5n4CsznWedcXsaLzoWfjAtXM4ARA7yrs9SEAW7h0sz2LwpbjqlrKdlts+nYSdYB2HRw/nr7F4
	zwz2Tsfw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r6RHp-002STH-1N;
	Fri, 24 Nov 2023 08:11:41 +0000
Date: Fri, 24 Nov 2023 08:11:41 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/20] [software coproarchaeology] dentry.h: kill a
 mysterious comment
Message-ID: <20231124081141.GV38156@ZenIV>
References: <20231124060553.GA575483@ZenIV>
 <20231124060644.576611-1-viro@zeniv.linux.org.uk>
 <20231124060644.576611-9-viro@zeniv.linux.org.uk>
 <CAOQ4uxgRiQCG_Q5TP+05_N4V=iFTemzGTd62ePgAgotK52EAAQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgRiQCG_Q5TP+05_N4V=iFTemzGTd62ePgAgotK52EAAQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Nov 24, 2023 at 09:37:16AM +0200, Amir Goldstein wrote:

> Since you like pre-git archeology...
> 
> Mind digging up what this comment in fs.h is about:
> 
> /* needed for stackable file system support */
> extern loff_t default_llseek(struct file *file, loff_t offset, int whence);

Umm...  I think it was about ecryptfs and its ilk, but it was a long
time ago...

<looks>

2.3.99pre6, along with exporting it:
-/* for stackable file systems (lofs, wrapfs, etc.) */
-EXPORT_SYMBOL(add_to_page_cache);
+/* for stackable file systems (lofs, wrapfs, cryptfs, etc.) */
+EXPORT_SYMBOL(default_llseek);
+EXPORT_SYMBOL(dentry_open);

Back then ->llseek == NULL used to mean default_llseek; that had
been changed much later.  And that was before vfs_llseek() as well,
so any layered filesystem had to open-code it - which required
default_llseek().

The comment is certainly stale, though - stackable filesystems do *not*
need it (vfs_llseek() is there), but every file_operation that used
to have NULL ->llseek does.

> Or we can just remove it without digging up what the comment used
> to refer to ;)

Too late - it will have to be removed with that ;-)

