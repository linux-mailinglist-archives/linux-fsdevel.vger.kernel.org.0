Return-Path: <linux-fsdevel+bounces-54001-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6984AF9DB5
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Jul 2025 04:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A2AD1C27148
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Jul 2025 02:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388DA26CE0F;
	Sat,  5 Jul 2025 02:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VzETWLqj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8986CF9C0;
	Sat,  5 Jul 2025 02:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751681880; cv=none; b=pGCBkEQkPZo3t4m2+obhLSMqRhnRzAqSMfmfW9mcnOXGYtfhAGmCbKQPKkIZFNlaCTTTFYQuzi8hS+HCznY1HEBFlP9nis8uj2BAu9kLr8E+6Xq8cBd7CgfqoBE0MOfbiAfSctHma5FK9P51R5mWZlhwve1OQZFw2P/VqgY3/PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751681880; c=relaxed/simple;
	bh=KLjzJvmcBlWpVpZts+62XfmqQ3g7Cx0jAYoobQykBWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ErI0svsGcqFFpsVV0l9IeJsJqVdGqlAThJiP6lB5UYIA9H3+yJ9dIGFy4OLxfV29HUghmYceA0dc73uUTzdrCcUrFSfDeH3AJyexMEoLmS/BpKEjVyH9BR1LfdR9FLSqoZde4LK6RP9eYnMGEQltPf96Ibw3T2hMEUqYMLgb900=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VzETWLqj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9EE1C4CEE3;
	Sat,  5 Jul 2025 02:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751681880;
	bh=KLjzJvmcBlWpVpZts+62XfmqQ3g7Cx0jAYoobQykBWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VzETWLqjWZcKNCgqZ4QwJI8Y8jNIC8TpkG3aA0Dg9PMGymVZ3TZnIcm0Wb1SiOzGZ
	 XllzMlAJkoQyvhtxNX2hwbZDUdKb12OcouivgEEr0Y+85oG6KvFProfFCPK1XZKDfR
	 nu2Mf9pT59RBIU6DXd3RJIyrTJEH8Jhs/np6BWGWFQcKfgWIh6iChcJePC4Wp3UTHz
	 /xjVhl3DvZBC8xPtPAn5D1S1xRJPOWy6yYYLbEkfi763bDdlInLn8f7ZoOjGNJses3
	 913qVza8FoCm6n5nAf5Q4lLDFRfqIZ2dsqzkxhwh5Vn0VjIYbrFo0RBFKtQOD36RP4
	 l/HXzUENQ9z3A==
Date: Fri, 4 Jul 2025 19:17:58 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: syzbot <syzbot+f4f84b57a01d6b8364ad@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, brauner@kernel.org, hare@suse.de,
	hirofumi@mail.parknet.co.jp, linkinjeon@kernel.org,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com,
	syzkaller-bugs@googlegroups.com, willy@infradead.org,
	p.raghav@samsung.com
Subject: Re: [syzbot] [exfat?] kernel BUG in folio_set_bh
Message-ID: <aGiLVkgBqh19rc6w@bombadil.infradead.org>
References: <6865e87a.a70a0220.2b31f5.000a.GAE@google.com>
 <68663a26.a70a0220.5d25f.0856.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68663a26.a70a0220.5d25f.0856.GAE@google.com>

On Thu, Jul 03, 2025 at 01:07:02AM -0700, syzbot wrote:
> syzbot has bisected this issue to:
> 
> commit 47dd67532303803a87f43195e088b3b4bcf0454d
> Author: Luis Chamberlain <mcgrof@kernel.org>
> Date:   Fri Feb 21 22:38:22 2025 +0000
> 
>     block/bdev: lift block size restrictions to 64k
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15ec33d4580000
> start commit:   50c8770a42fa Add linux-next specific files for 20250702
> git tree:       linux-next
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=17ec33d4580000
> console output: https://syzkaller.appspot.com/x/log.txt?x=13ec33d4580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d831c9dfe03f77ec
> dashboard link: https://syzkaller.appspot.com/bug?extid=f4f84b57a01d6b8364ad
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15c93770580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1001aebc580000
> 
> Reported-by: syzbot+f4f84b57a01d6b8364ad@syzkaller.appspotmail.com
> Fixes: 47dd67532303 ("block/bdev: lift block size restrictions to 64k")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

Odd, I can't see where the null pointer comes from.

bdev_getblk() --> __getblk_slow() properly returns NULL and doesn't use
the data. But neither does fat_fill_super() on failure. My only
suspicion was on fat_msg() but that sb usage seems fine and the goto out_fail
seems fine as iput() also doesn't process null inodes and unload_nls()
is fine. The return value is also set to -EIO correctly so we don't return NULL
actually. I jus tdon't see anything odd on _fat_msg() either.

Hrm..

  Luis

