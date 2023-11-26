Return-Path: <linux-fsdevel+bounces-3836-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2287F9162
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Nov 2023 06:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84CA628140F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Nov 2023 05:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4023C32;
	Sun, 26 Nov 2023 05:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="HLN15rxS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A76C111
	for <linux-fsdevel@vger.kernel.org>; Sat, 25 Nov 2023 21:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BFdmgWqpI/imfedi/zQTMTb5eYeuOEdtJupWmeLMbOM=; b=HLN15rxSUJze4axJN0R/QMY/s5
	l8PaC3C7riOCr5mBtFbblasn/+XbUv2pI/UTJxgEvbHLAhZR0q6JWzCwUtZ5mszMfYFIFeYh9STcR
	TfzJ4AtCQvF/o7Aw49vxyBYi8DKd4HdoEbRYcKzWe9TImT9bMRGshOQnd4QP0tDjJvNfs8kjV9Qee
	WCLvysdUJHddaZlvWqwPfR+9OrKJYy1UO4fFk6/LWNRAxgalhDKw99pxIZbmiC72y/UwyklcDQPMY
	JZJQETIaEj6G7BLlGOZDbMbTXKNPvWfK1WJVM1T5pwKUZYJKsaqvAJJ1BgZ4RJIJdxKPL0Y6xj6Ts
	xGyLtOHA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r77NY-003LMm-0g;
	Sun, 26 Nov 2023 05:08:24 +0000
Date: Sun, 26 Nov 2023 05:08:24 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Mateusz Guzik <mjguzik@gmail.com>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [RFC][PATCH] simpler way to get benefits of "vfs: shave work on
 failed file open"
Message-ID: <20231126050824.GE38156@ZenIV>
References: <20231126020834.GC38156@ZenIV>
 <CAHk-=wg=Jo14tKCpvZRd=L-3LUqZnBJfaDk1ur+XumGxvems4A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg=Jo14tKCpvZRd=L-3LUqZnBJfaDk1ur+XumGxvems4A@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Nov 25, 2023 at 08:59:54PM -0800, Linus Torvalds wrote:
> On Sat, 25 Nov 2023 at 18:08, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > However, all of that can be achieved easier - all it takes is fput()
> > recognizing that case and calling file_free() directly.
> > No need to introduce a special primitive for that - and things like
> > failing dentry_open() could benefit from that as well.
> >
> > Objections?
> 
> Ack, looks fine.
> 
> In fact, I did suggest something along the lines at the time:
> 
>    https://lore.kernel.org/all/CAHk-=whLadznjNKZPYUjxVzAyCH-rRhb24_KaGegKT9E6A86Kg@mail.gmail.com/
> 
> although yours is simpler, because I for some reason (probably looking
> at Mateusz' original patch too much) re-implemented file_free() as
> fput_immediate()..

file_free() was with RCU delay at that time, IIRC.  I don't think that
cost of one test and (rarely) branch on each final fput() is going to
be measurable.

Mateusz, do you still have the setup you used for the original patch?
Could you profile and compare the current tree and current tree + the
patch upthread?

