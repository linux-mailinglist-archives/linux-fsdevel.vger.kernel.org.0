Return-Path: <linux-fsdevel+bounces-57455-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E007B21C02
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 06:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4F071A22092
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 04:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567FB2DE1FA;
	Tue, 12 Aug 2025 04:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sw/AOjQ1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058B7169AE6;
	Tue, 12 Aug 2025 04:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754971677; cv=none; b=L1y4w5L6pAXHQBYexklKDP7drjGZl67pghceQlp5ZyyqBpBSEUYNOKeKrzU0sKKM4sFlMngdR3mpkfUMNW7u+1Gogl2q+ZeG+xYXc/vafo7Pxa33bc6d6TXUSrVKpBpja2Pj7NZvi0z4WPwxAT4aP/3HCPeT++FsWLk1REUvHxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754971677; c=relaxed/simple;
	bh=VVO4Ihq1jbe0CepI1nS4hTv0VXxvyTQppfvX64By31g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cqHFJvCUp4moDHIhWskycm1iSx36zAMVhwI/IDEk5IVezsVfTj5y35mzbezjga4OYXrSAwaNO3dv6pg9zRCaoA0MMBneAKAlZEZrMlQmGav1xvNCPWJvuTOv8CgFPf6XAqmAcLBlimr/CwKq6ExcbVLQ0aVjnlbnZOpF+eS5fgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sw/AOjQ1; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45a0dc77a15so8005005e9.2;
        Mon, 11 Aug 2025 21:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754971674; x=1755576474; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1zU1/vW/vo2Z1NQ5LuzJJRfwnw1wyRgmbBXUY+J9CEw=;
        b=Sw/AOjQ1oZZEt4DmGf9JMOVZuY9ud5+cyMURmucNuCREbuZRjgwwdmGi2ixVnW1fbo
         4MzUHWpka1Fw9bqNnXwltbQVWGOji2J0KT+EBV5lZI0xwnykq2dPWbc5hRPNvi2WB9KE
         M0+9tkAiNh0Ta206KuarXbVHN6sP29x139EqmeDYbNKmxmGeFmo1qz5OYeHE7Tr4gER2
         Aly10NvQP0AxHJSpJCnBwkFpdOHvl4covsX6TuXmrauF3yb3kHpvwSMoXGCA5c5Gn9c/
         +iVdfz2VJoC/VbzKmNi4TyLrpzzjcKeRT+oGAE1sUZs0GdUBeKUph5zXszMnw5O9+Hz1
         fXAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754971674; x=1755576474;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1zU1/vW/vo2Z1NQ5LuzJJRfwnw1wyRgmbBXUY+J9CEw=;
        b=FN+pXEivkybVu7nidO1KrgTqwSrTC/gFQ+cpjjuq01wRLAJIVaoXV3uToplJWplOj/
         FxMCHA6u1vs8dC59+xvQIpSoO0XX4StNLB/EeYPfEY7b3Jux9lriug70JLaIbdDTwnD6
         tozkgWgeGlONQO7Vgi3sATNH4SqPMvx5LdQenakxLBxQk7pcrtYUnvonxwy/pJ73fUoD
         n3t4BfGAfpoOF5Yli+VYAeE15d1YjoF9yBdKdxUuOvZ2R2lWhcYLIpEe8gpqRqlEcUn8
         STmnxJcim2/bmBBm14pObkdwnTL1TxuEpWw0BFgMwxh8GLNRzxfGOTpuUAu7q9CnkvTH
         n+bA==
X-Forwarded-Encrypted: i=1; AJvYcCVetV41qYiBoN/a0SKcYYoLDgxGNCI8cbo5A2SVrfuPikipqnKYU0nRFetjh8MAz0CUr4YAkPFSW6JZwyQ9@vger.kernel.org, AJvYcCWXjauoRW6C42J7duHQcKJtmCkWjKGmhwV4VjjAoow73VB8nsxBcacPeZ/RujOk3Ku2okeDap1zSHmCnMAj@vger.kernel.org
X-Gm-Message-State: AOJu0YzmkPBT0ZgCd7Y8Dc7jGQUdqya2Mqs88eANeR2MSy0qd1it/sTS
	GLNWPuABgfnJbXvdqzt3x1X3MjNIWq49yjcOPciAL9lQtf5wNT3WEuDd3cgprg==
X-Gm-Gg: ASbGncsVG1UBB1M5cM11UGjsP/RwJLMMbQk5+hK0e7cQ41B+ALdvoEs9IX/RwDaZmY2
	dL1J+Jte7aXIZ/nfEJN93HmDfwkN/xpi6PtCNMGi6MvXkef2ahQAG9+vESSLOFRy7/jZYP4w+b0
	0vFbXBlIHfHodxaRTPbqkK0gTwk9Ngwe7BEfMtSYMSvowqx41gv4DJATpovJM/otD+Q1guPI1nu
	Kx2BJXfAIyE/VssFa3pRkbA2VDASg9KfAuHbxlsCgDRxPh3rMztD9SgqyBRsMP1YA7pDcOxozGp
	2wfaat8mkI/+TSAu0WS1bDOLtcutISTmeAmpx0gXbcyTVftEroh6f+th9WS9x5b3nQNZ67VUN8c
	e75gadzo3Tw==
X-Google-Smtp-Source: AGHT+IE/PAYMczz83M4BTLp6vMPTnByf4uxbRlfvzclhbzeq8OmY+GWBpLC5M89UXLkMzNwvGlspqg==
X-Received: by 2002:a5d:5f8d:0:b0:3b4:9b82:d44c with SMTP id ffacd0b85a97d-3b910fdb80fmr1357381f8f.22.1754971673760;
        Mon, 11 Aug 2025 21:07:53 -0700 (PDT)
Received: from f ([2a00:11b1:10c2:8527:f810:77a7:141e:b603])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b90a64318fsm7564659f8f.21.2025.08.11.21.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 21:07:52 -0700 (PDT)
Date: Tue, 12 Aug 2025 06:07:41 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vfs: show filesystem name at dump_inode()
Message-ID: <lm6pyrrfjvrpam3xdlyfdnr4dsdge5gtw6jwths5wynvbcgcfs@b2xgnw55aedh>
References: <ceaf4021-65cc-422e-9d0e-6afa18dd8276@I-love.SAKURA.ne.jp>
 <CAGudoHEowsc290kfSgCjDJfB+RKOv2gLYS6y4OxyjhjPW07vMQ@mail.gmail.com>
 <20250811203815.GS222315@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250811203815.GS222315@ZenIV>

On Mon, Aug 11, 2025 at 09:38:15PM +0100, Al Viro wrote:
> On Mon, Aug 11, 2025 at 09:45:52PM +0200, Mateusz Guzik wrote:
> 
> > Better printing is a TODO in part because the routine must not trip
> > over arbitrarily bogus state, in this case notably that's unset
> > ->i_sb.
> 
> That... is a strange state.  It means having never been passed to
> inode_init_always().  How do you get to it?  I mean, if the argument
> is not pointing to a struct inode instance, sure, but then NULL is
> not the only possibility - we are talking about the valur of
> arbitrary word of memory that might contain anything whatsoever.
> 
> If, OTOH, it is a genuine struct inode, it must be in a very strange
> point in the lifecycle - somewhere in the middle of alloc_inode(),
> definitely before its address gets returned to the caller...
> 
> > See mm/debug.c:dump_vmg for an example.
> 
> Not quite relevant here...
> 
> >  void dump_inode(struct inode *inode, const char *reason)
> >  {
> > -       pr_warn("%s encountered for inode %px", reason, inode);
> > +       struct super_block *sb = inode->i_sb; /* will be careful deref later */
> > +
> > +       pr_warn("%s encountered for inode %px [fs %s]", reason, inode,
> > sb ? sb->s_type->name : "NOT SET");
> 
> That's really misleading - this "NOT SET" is not a valid state; ->i_sb is
> an assign-once member that gets set by constructor before the object is
> returned and it's never modified afterwards.  In particular, it is never
> cleared.
> 
> There is a weird debugging in generic_shutdown_super() that goes through
> the inodes of dying superblock that had survived the fs shutdown
> ("Busy inodes after unmount" thing) and poisons their ->i_sb, but that's
> VFS_PTR_POINSON, not NULL.
> 
> We literally never store NULL there.  Not even with kmem_cache_zalloc()...

So I copied the stuff from mm/ and have distinct recollection they used
a special routine to deref pointers (or fail) to avoid faulting on
arbitrary breakage, even pointers which are expected to be sound on
crashes.

Based on that I assumed this is the expected treatment and I could not
be arsed to sort it out in dump_inode(), hence the stub and the remark
in my previous e-mail.

Now that I look at their dump_* routines I don't see anything of the
sort, so maybe I was tripping hard.

If the routine is fine just reading values from the passed inode
(including pointer derefs), perhaps one can sit through expanding the
output beyond just fs name?

Also note it would be nice (tm) if there was a callback in inode ops to
let the fs dump stuff on top of the whatever dump_inode() is doing.

I'm not in position to sort it out for the time being (fwiw FreeBSD has
one, see vn_printf -> VOP_PRINT).

However, bare minimum which should be immediately added in this case are
the state and flag fields.

With this in mind, here is a completely untested diff which prints
fields in order they are specified in struct inode in the range i_mode
to i_default_acl, then few extra fields (again in order). Preferably
someone(tm) would print all the fields and branch on inode type to know
how to handle unions.

I'm not in position to even compile test or validate format specifiers
work as expected on funky platforms though, so I'm just throwing this to
illustrate and perhaps save someone a bit of hand work (just in case
I'll note I don't want or need credit for the thing below, should
someone decide sort it out):

diff --git a/fs/inode.c b/fs/inode.c
index 01ebdc40021e..4022f1d009dc 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2914,7 +2914,14 @@ EXPORT_SYMBOL(mode_strip_sgid);
  */
 void dump_inode(struct inode *inode, const char *reason)
 {
-       pr_warn("%s encountered for inode %px", reason, inode);
+	struct super_block *sb = inode->i_sb;
+
+	pr_warn("%s encountered for inode %px fs %s mode %ho opflags %hx\n"
+		"uid %d gid %d flags %u acl %px default_acl %px inode %lu state %u\n",
+		"nlink %u size %u"
+		reason, inode, sb->s_type->name, inode->i_mode, inode->i_opflags,
+		inode->i_uid, inode->i_gid, inode->i_flags, inode->i_acl, inode->i_default_acl,
+		inode->i_ino, inode->i_state, inode->i_nlink, inode->i_size);
 }
 
 EXPORT_SYMBOL(dump_inode);

