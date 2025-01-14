Return-Path: <linux-fsdevel+bounces-39152-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E3DA10B41
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 16:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6543F162F70
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 15:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2076D1D63DC;
	Tue, 14 Jan 2025 15:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="OsEBVjc5";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="ZPTtQSib"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [104.223.66.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B888F1D5143;
	Tue, 14 Jan 2025 15:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.223.66.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736869195; cv=none; b=SkucA0noFmhDhCSD4wDXnq6Z2sDiU5vzfo6pywJEvsGWU8ETbW3WIgdzm9jKvcH+b35P7MYZj+BfZ/SFldtjsC+S7GbLjHaF1KDmTToaKGzMA/Hd13yeP5btG1KXapmvCC6n7bHfAQZaxtg4zGki0rDeY1Om6DRd6lsfD9c3ryw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736869195; c=relaxed/simple;
	bh=FqxyaYX7DuXdn+b81nyDjx3MuTKl3nMwFSl/44sobnQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o+HKOK7j6AGhZAgTcNjxr8ktAWMS9+I6pDvMsqVc0ivw1OsXw1C1SbvG9n9+HFy35WlQM/SOjI9hnazqRlV+Qtd1Jey632kxSZ4xmgfh+gjeBoHTv6PBbxrgy6iZmrrwQ/InnnpLFa+84qB2MGSusl1EobLZnUrxGqDq9ccGgPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=OsEBVjc5; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=ZPTtQSib; arc=none smtp.client-ip=104.223.66.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1736869187;
	bh=FqxyaYX7DuXdn+b81nyDjx3MuTKl3nMwFSl/44sobnQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=OsEBVjc5CkYEQQnM3VqVgGn1KySd1ykmGv5DKjctSqvvRZobJ4PLolLR2xFQT5uQN
	 EpGxUQzMLPzgwoJAQxVERYUB1+KArpCaPsVWuU7mBgNZk9qeC9GRSH4gHtDF+oU/pV
	 uAzLcIsu86TY2GvzcGNiQKZf1d0TzHfqERtgbOHA=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 67CEA12806DD;
	Tue, 14 Jan 2025 10:39:47 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id Cv6hAFtKyU-J; Tue, 14 Jan 2025 10:39:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1736869186;
	bh=FqxyaYX7DuXdn+b81nyDjx3MuTKl3nMwFSl/44sobnQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=ZPTtQSibYdDWmBGwyfHNTxY2FPiYzJ7Py1c23bALl2IlAB1dsAljIeYAwu+RNoSrg
	 mhJx27CSay2PHjRk9+gE84284UCfte7MQc/Mz60du0YHrQzbinm6+Gm9oXRshgRQ3g
	 5miKqi/Srrz8p2aMpzaUexjDMuzcSuk/q8NMsKeE=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::db7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 902011280591;
	Tue, 14 Jan 2025 10:39:45 -0500 (EST)
Message-ID: <0497ed376578f8a6579d3e663a487c870675c9c7.camel@HansenPartnership.com>
Subject: Re: Bug: INFO_ task hung in lock_two_nondirectories
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jan Kara <jack@suse.cz>, Dmitry Vyukov <dvyukov@google.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, Kun Hu
 <huk23@m.fudan.edu.cn>,  jlayton@redhat.com, tytso@mit.edu,
 adilger.kernel@dilger.ca, david@fromorbit.com,  bfields@redhat.com,
 viro@zeniv.linux.org.uk, christian.brauner@ubuntu.com,  hch@lst.de,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 brauner@kernel.org, linux-bcachefs@vger.kernel.org,
 syzkaller@googlegroups.com
Date: Tue, 14 Jan 2025 10:39:41 -0500
In-Reply-To: <435wi7dfddjqhn5yxuw34tww2gyr4x2oeh3s25htuwl7cwggza@zuyzyrha7qk6>
References: <42BD15B5-3C6C-437E-BF52-E22E6F200513@m.fudan.edu.cn>
	 <gwgec4tknjmjel4e37myyichugheuba3sy7cxkdqqj2raaglf5@n7uttxolimpa>
	 <ftg6ukiq5secljpfloximhor2mjvda7qssydeqky4zcv4dpxxw@jadua4pcalva>
	 <CACT4Y+ZtHUhXpETW+x8FpNbvN=xtKGZ1sBUQDr3TtKM+=7-xcg@mail.gmail.com>
	 <435wi7dfddjqhn5yxuw34tww2gyr4x2oeh3s25htuwl7cwggza@zuyzyrha7qk6>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Tue, 2025-01-14 at 14:58 +0100, Jan Kara wrote:
> On Tue 14-01-25 10:07:03, Dmitry Vyukov wrote:
> > I also don't fully understand the value of "we also reported X bugs
> > to the upstream kernel" for research papers. There is little
> > correlation with the quality/novelty of research.
> 
> Since I was working in academia in the (distant) pass, let me share
> my (slightly educated) guess: In the paper you're supposed to show
> practical applicability and relevance of the improvement you propose.
> It doesn't have to be really useful but it has to sound useful enough
> to convince paper reviewer. I suppose in the fuzzer area this
> "practical applicability" part boils down how many bugs were
> reported...

It's not just that, as a recent reviewer for several Academic
Conferences, you always ask about the upstream status.  Chances are if
someone worked on open source but didn't send anything upstream that
was because there wasn't enough value to send.  However, when stuff
does go to upstream lists, you can at least look at what upstream made
of it as part of the review (the guilty confession would be this can be
done quite easily and does break supposedly blind reviews, but it is
very valuable).  Conferences now have open source badges and artifacts
to encourage this behaviour.  I'm afraid this now means that if you're
aiming at a Conference and you didn't send anything upstream you're
quite likely to get a rejection on that fact alone.

Regards,

James


