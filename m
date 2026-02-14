Return-Path: <linux-fsdevel+bounces-77227-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gOUmN6rfkGk+dgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77227-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 21:48:42 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1A013D2EB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 21:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 655643013A40
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 20:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94FCE298CC4;
	Sat, 14 Feb 2026 20:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OD+zjyX5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26608548EE;
	Sat, 14 Feb 2026 20:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771102117; cv=none; b=UrnObVCOCLf2KN3jMHE1Llu4dKlZpVlMomcgKJsAmSSi3HaJnUJBbUidKRsT68tgufiZ4SNJBdlhAchN7f2P2u5Db/9yGW15hOBTUidqY2xnA1AzcbTRE0TzyYNgrr9172en5DH6D9HAZYPYwLJnYABIDXE2y80ixDqmi7HjWUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771102117; c=relaxed/simple;
	bh=EDS7m6q/kT345PyBZ/yeEIm7Ek5/88xXMcyOBouQNZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=emEiEW3rSVBc8woq9HFZfP4g7q1DRh+LblLaNh2nGOoCvwGj8PXPMI+SyvkqVuuAK1zmTUUzzjtDvCrwyyexl9RmmsxKWhoDWOqDo8mBQHJZsfwcVcoAsBrCVrvvLrBNHOMbPQHmCpLsb9/lF+i7tiKubL6lT1Q21kST4T7N47A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OD+zjyX5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35E08C19421;
	Sat, 14 Feb 2026 20:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771102117;
	bh=EDS7m6q/kT345PyBZ/yeEIm7Ek5/88xXMcyOBouQNZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OD+zjyX5AZcv79MsQ/wEdyE3EhwZUTPKTuO1QznR8wcgpXKy9kCAygsdoBpuRt4B4
	 EqK4EEFy1DDE9hORrnoN04ySBK4rrl1Y3Ql4MNn+jJ2Gn6zmKAIHgBKY1Lm8vlEMtO
	 31wkctzS+JhQWUNx6TGOgVOOkpO7XdPZEdw6cgzxLRHpwsfBusUqmhi1yYcOVzPttk
	 EBBcZKLWgkoc3eYBvYK5FJ8c658WV9dl4cZz3zmvbozNZU/aG4RFEoJ0H1Zin+Fkhr
	 fnDgzxv5i1xf2iUB9yd1Ebuu4+YjpaJvbtshMOysWseK/4aP0p3df8Ly7nP+noo3wb
	 aiXJfwr+72HBQ==
Date: Sat, 14 Feb 2026 12:48:33 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: fsverity@lists.linux.dev, linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Subject: Re: [PATCH 1/2] f2fs: use fsverity_verify_blocks() instead of
 fsverity_verify_page()
Message-ID: <20260214204833.GA10472@quark>
References: <20260214203311.9759-1-ebiggers@kernel.org>
 <20260214203311.9759-2-ebiggers@kernel.org>
 <CAHk-=wi60UWZ=kVayGKfrGURiX4aN6P4J_bNMOw_pSvUrxw1jw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi60UWZ=kVayGKfrGURiX4aN6P4J_bNMOw_pSvUrxw1jw@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77227-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3F1A013D2EB
X-Rspamd-Action: no action

On Sat, Feb 14, 2026 at 12:39:22PM -0800, Linus Torvalds wrote:
> On Sat, 14 Feb 2026 at 12:33, Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > -               if (fsverity_verify_page(dic->vi, rpage))
> > +               if (fsverity_verify_blocks(dic->vi, page_folio(rpage),
> > +                                          PAGE_SIZE, 0))
> 
> This really is very wrong. It may be equivalent to the old code, but
> the old code was *also* wrong.
> 
> If you use "page_folio()", you need to do the proper offsetting of the
> page inside the folio, unless the filesystem is purely using the old
> legacy "folio is the same as page", which is simply not true in f2fs.
> 
> It might be true in this particular case, but considering that it was
> *NOT* true in another case I fixed up, I really don't want to see this
> same mistake done over and over again.
> 
> So either it's the whole folio, in which case PAGE_SIZE is wrong.
> 
> Or it really is PAGE_SIZE, in which case you need to use the proper
> offset within the folio.
> 
> Don't take the old buggy garbage that was fsverity_verify_page() and
> repeat the bug when you remove it.

The reason I went with the direct conversion is that
f2fs_verify_cluster() clearly assumes small folios already, and indeed
it's called only with small folios.  But sure, we can make that specific
line in it large-folio-aware.

- Eric

