Return-Path: <linux-fsdevel+bounces-52015-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE51FADE405
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 08:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D42E189A5A9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 06:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FB2217659;
	Wed, 18 Jun 2025 06:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="SeeK6Xj2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA0715442C;
	Wed, 18 Jun 2025 06:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750229668; cv=none; b=WKQgJu4sHAoQOT9AQEXiQE/G2JBi9zq8dUBbWakCcuOG8XCy83kQbdPFEUzd1VtSEJLUhGmbC9IF9hh8h2MN/Mwnalf6wR0UFimDj3Psavc5eADKqGbZBN2KCEkDozMR0KQTA0eyKvQyJLaUim7Njb6DhkMGnR1eDuH7SWy4Njk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750229668; c=relaxed/simple;
	bh=6O4E31IFWhwT1mKncIIfB5M0IyKaYLlTTLmgubkQWeM=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=HbpSun6yIwrXb9tsiRJ1wKFMQZV4eienFvOcy6l5nElmaJ0dX07SIO5LkgLtftX1OzYvFepcyO3LB+6Bx2WngVAVQvg9LKSKoN/l5NjQWfTkn4l3jz2sQIV05tzCVWI99IkZZxrQP6wovOmChvBtr8RMeQtDp8cHBMzdVsy4P7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=SeeK6Xj2; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1750229652; bh=g79FYQgOsNwSl3tOaXLz/txIsFLP64rs0sArg9v4BXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SeeK6Xj28icJWqq4Sc0D31vASv61oOpCh1BUQsTYlOn9bN0lxQISWLdDhnZMN/rCY
	 Fp0ARzzU1Xq+D9XGAKqV5RrVIopaetfR4y2IBW17svwGI6ZIMnJVZ4Lmfd+lwoFYEQ
	 InQ2v4IrIPM6+ERyGFv8mD+v1sRdfZTXRFNxqJGw=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.198.228.63])
	by newxmesmtplogicsvrszgpuc5-0.qq.com (NewEsmtp) with SMTP
	id D7617201; Wed, 18 Jun 2025 14:53:54 +0800
X-QQ-mid: xmsmtpt1750229634tc8wvgidz
Message-ID: <tencent_ED33789EDE1B3B4BB21B4325EDBA10BB7F08@qq.com>
X-QQ-XMAILINFO: MIAHdi1iQo+z16kuYiyj/ZhQ2a4rFDdwa0nU5mpjxpLJbUzgrj7FxujSkmVaje
	 5U3JMIsus966+z4oYcGSR1EZRDXl+nr6GdFBtHn8PIA4IEMlkDJC9BNx/NaWwPIHEXe2WnG0QHfN
	 FK7cxaEZ6O+il1tEFEsuveQs/ybmUQBqTls1k1nrdgciJhKPRT4b0Om2ZzfBTehXCW0RPsTydQSL
	 JDImCKWop+jpq0M6EXNmTsJ2hitv9mB/JcTUZBwWW1fXet8ysgf4vFhO5Gf/w37LMDiTGnYKinHj
	 TqieJYwoDrx+EzwM0ItXH3oB1FhY76pNzPPjoZ+IUDoYRtObZnAMlHIg2VRs/fm8UhBwlTNE8vqI
	 pnBNjDrqUZ8LmwP6OiD+hMyTP3e6g1XQ3VYq89NizwH1W+MxhNX/u+F8oogct04GDFNhXcMuu3jd
	 6gVcLbD02NkDm9HiT3zhxOgBQOB6z1Oc+hO/CjdNF8MQmCOXhBRY6jrp+5LaVdgY9r6wa6EEzvV2
	 yPZMZQttlLzSye1m9I/5y2/Cxg5V7GDbGwLQxNgbyxiQTWqkihLrn6yyLPjAIXunkH20WTm9/0lY
	 1lFm1XxHC5F77ABAOnrsTbpBas1Fg+q0FLLhUPLfITxr0iakG8ehgBJtTteQU0KopFext5SfhlfC
	 GKr6t50rOjKo1S2TmbAD56iPTH+m/BuDwt1ElW2cgnBbnL+vZs70rhBBj0LMLB9GX0eExidLoygg
	 csofFNjijbhBKgO/VHzbdXmrpPUQGpf51crGp4cj5MzV5dlz+SU+y0ygDfqkpz93cshQxgwVvvbD
	 Lce1yGaT4iUIUMJP1opDGq5qezgfcyrOGV439m7sXdYyk66mrH7hN6OQ4z1lQmQB1fsZ9jLnDhdL
	 eCAN763HFgLutlOaug0ZBBlpe3W/7wmKcuoiUiZATD0x2H8YbTLHacKUWR8omxW9/vy0baGOTvvu
	 Qc2AEEhSXpXqZZXfiS6sQWvNbXTww03m3tQwGrDJc=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Edward Adam Davis <eadavis@qq.com>
To: viro@zeniv.linux.org.uk
Cc: almaz.alexandrovich@paragon-software.com,
	brauner@kernel.org,
	eadavis@qq.com,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ntfs3@lists.linux.dev,
	syzbot+1aa90f0eb1fc3e77d969@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] fs: Prevent non-symlinks from entering pick link
Date: Wed, 18 Jun 2025 14:53:55 +0800
X-OQ-MSGID: <20250618065354.1322589-2-eadavis@qq.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250618061815.GR1880847@ZenIV>
References: <20250618061815.GR1880847@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 18 Jun 2025 07:18:15 +0100, Al Viro wrote:
> > On Wed, 18 Jun 2025 06:27:47 +0100, Al Viro wrote:
> > > Note that anything that calls __d_add(dentry, inode) with is_bad_inode(inode)
> > > (or d_add(), or d_instantiate(), or d_splice_alias() under the same conditions)
> > > is also FUBAR.
> > >
> > > So's anything that calls make_bad_inode() on a struct inode that might be
> > > in process of being passed to one of those functions by another thread.
> > >
> > > This is fundamentally wrong; bad inodes are not supposed to end up attached
> > > to dentries.
> > As far as I know, pick_link() is used to resolve the target path of a
> > symbolic link (symlink). Can you explain why pick_link() is executed on
> > a directory or a regular file?
> 
> Because the inode_operations of that thing contains ->get_link().
I removed _ntfs_bad_inode() and it fixed the problem.
I should have thought more carefully about what you said about the bad inode.
> Again, the underlying bug is that make_bad_inode() is called on a live inode.
> In some cases it's "icache lookup finds a normal inode, d_splice_alias() is called
> to attach it to dentry, while another thread decides to call make_bad_inode() on
> it - that would evict it from icache, but we'd already found it there earlier".
> In some it's outright "we have an inode attached to dentry - that's how we got
> it in the first place; let's call make_bad_inode() on it just for shits and giggles".

BR,
Edward


