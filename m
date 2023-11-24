Return-Path: <linux-fsdevel+bounces-3658-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE277F6E0F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 09:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A5881C20E91
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 08:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7EDBA38;
	Fri, 24 Nov 2023 08:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="QSjuy2Ja"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F872D4E;
	Fri, 24 Nov 2023 00:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uhBeOG3BwxHguj8NUhTFptKTzBfCf52z03Q5KQI6/Yk=; b=QSjuy2JaUJAi9EVLEXkdfE5exB
	qFOicfr8A1FnSrLlNaZbymorl5K9KNPaNcVl4vhZ83q43ie8/lm0udu9eeTqp1TKczxzpllNsEMWh
	Xp3ZYqsIUpBAeM+jF4tIBG6E1WeSNqrg0jxj7yvxM7H9AAdzdFTsdKnE09er1q+z9kXU7QfkBtj5f
	i7pIXeSM7GySx14bsx34LD/JowUZljXeePfEjMYHw07YQYTUqQuWTo8tbxgNknLe1Z6dkFxiLcefx
	LO/jO6p08zjasUAApsTwP+8BV6IxF1B9BAdEwg9+HYp127ZMpyn/naiUWsAnY8PgtFVVd+vCKaCMr
	ImZrE16A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r6RW1-002SmS-27;
	Fri, 24 Nov 2023 08:26:21 +0000
Date: Fri, 24 Nov 2023 08:26:21 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/20] [software coproarchaeology] dentry.h: kill a
 mysterious comment
Message-ID: <20231124082621.GW38156@ZenIV>
References: <20231124060553.GA575483@ZenIV>
 <20231124060644.576611-1-viro@zeniv.linux.org.uk>
 <20231124060644.576611-9-viro@zeniv.linux.org.uk>
 <CAOQ4uxgRiQCG_Q5TP+05_N4V=iFTemzGTd62ePgAgotK52EAAQ@mail.gmail.com>
 <20231124081141.GV38156@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124081141.GV38156@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Nov 24, 2023 at 08:11:41AM +0000, Al Viro wrote:
> On Fri, Nov 24, 2023 at 09:37:16AM +0200, Amir Goldstein wrote:
> 
> > Since you like pre-git archeology...
> > 
> > Mind digging up what this comment in fs.h is about:
> > 
> > /* needed for stackable file system support */
> > extern loff_t default_llseek(struct file *file, loff_t offset, int whence);
> 
> Umm...  I think it was about ecryptfs and its ilk, but it was a long
> time ago...
> 
> <looks>
> 
> 2.3.99pre6, along with exporting it:
> -/* for stackable file systems (lofs, wrapfs, etc.) */
> -EXPORT_SYMBOL(add_to_page_cache);
> +/* for stackable file systems (lofs, wrapfs, cryptfs, etc.) */
> +EXPORT_SYMBOL(default_llseek);
> +EXPORT_SYMBOL(dentry_open);
> 
> Back then ->llseek == NULL used to mean default_llseek; that had
> been changed much later.  And that was before vfs_llseek() as well,
> so any layered filesystem had to open-code it - which required
> default_llseek().
> 
> The comment is certainly stale, though - stackable filesystems do *not*
> need it (vfs_llseek() is there), but every file_operation that used
> to have NULL ->llseek does.
> 
> > Or we can just remove it without digging up what the comment used
> > to refer to ;)
> 
> Too late - it will have to be removed with that ;-)

BTW, there's this, covering more than just BK times:

git://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/

