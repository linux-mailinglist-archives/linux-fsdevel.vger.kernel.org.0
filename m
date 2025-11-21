Return-Path: <linux-fsdevel+bounces-69455-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2C9C7B756
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 20:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 818573685D0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 19:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E312FE07B;
	Fri, 21 Nov 2025 19:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GZyWX2Mn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBD82FD7A7;
	Fri, 21 Nov 2025 19:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763752474; cv=none; b=MTiGXy+Ewk1yvNTQvFeVIcLYIqihhUhzRxxm9tnARvmPHlp6VUhQgqGOUp3njMQRZskJBYYHMAHbq9+ORG/Fv+BBCGx4+guzVfFw5ay/AeuB5RsYAgy1wA+DbwVtH372xVjyso9uGF3y/cYcqisiWEu/UNqHDV6ymZFoSzVKNbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763752474; c=relaxed/simple;
	bh=q14sVA4KCjPx3tNYuQ9FbdiV8V7LAz23UXdJHkuN3Fo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=thFUCTRnQVT3duyl/itk4Sinrgwp6M3xM4FzzuYYEquF9A8DKE98j/6zzTcIiBMxfEn8Rgxwo9kvOcgCw7vZhI0VYUDil/7cQPiaz2JJgKUDx3PLT9Nhte6S3psIE+ioaf6OWcXFZL0MnfJ+cTm5hPERvWmNE3BosMBP7xOz8sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GZyWX2Mn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEBEDC4CEF1;
	Fri, 21 Nov 2025 19:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1763752474;
	bh=q14sVA4KCjPx3tNYuQ9FbdiV8V7LAz23UXdJHkuN3Fo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GZyWX2MnGcSSq4xqwF5sagJZrz9exyyUPLppcdjUp58ZCfOBZNazm5xYZneGq5o0N
	 JnURXsRyFJiqFdnPgQEtplCJfaTwJ96atEFgEH5SrFGonsOt473Ky3KQZXzZ+UK5nw
	 7qYtJwssGWiWJJO3+/CRFjlCP9HHdOnXRZQt88Sw=
Date: Fri, 21 Nov 2025 11:14:33 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: syzbot <syzbot+b0a0670332b6b3230a0a@syzkaller.appspotmail.com>,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ext4?] WARNING in __folio_mark_dirty (3)
Message-Id: <20251121111433.91bea9e742dd2a2e0a3ecfff@linux-foundation.org>
In-Reply-To: <aSC3OsxouD7lFKEy@casper.infradead.org>
References: <691f44bb.a70a0220.2ea503.0032.GAE@google.com>
	<20251121101155.173d63bd6611cd3c4aa22cf9@linux-foundation.org>
	<aSC3OsxouD7lFKEy@casper.infradead.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Nov 2025 19:02:18 +0000 Matthew Wilcox <willy@infradead.org> wrote:

> > I'm guessing that ext4 permitted a non-uptodate folio to find its way
> > into the blockdev mapping then the pagefault code tried to modify it
> > and got upset.
> 
> I think you're right, but the reason it's upset is that it found a
> !uptodate folio that was mapped into userspace, and that's not supposed
> to happen!  Presumably it was uptodate at the point it was initially
> faulted in, then (perhaps when the error happened?) somebody cleared the
> uptodate flag without unmapping the folio.
> 
> Hm.  I wonder if we should do this to catch the offender:
> 
> @@ -831,7 +833,17 @@ static __always_inline void SetPageUptodate(struct page *pa
> ge)
>         folio_mark_uptodate((struct folio *)page);
>  }
> 
> -CLEARPAGEFLAG(Uptodate, uptodate, PF_NO_TAIL)
> +static __always_inline void folio_clear_uptodate(struct folio *folio)
> +{
> +       VM_BUG_ON_FOLIO(folio_mapped(folio), folio);
> +       clear_bit(PG_uptodate, folio_flags(folio, 0));
> +}
> +
> +static __always_inline void ClearPageUptodate(struct page *page)
> +{
> +       VM_BUG_ON_PGFLAGS(PageTail(page), page);
> +       folio_clear_uptodate((struct folio *)page);
> +}
> 
>  void __folio_start_writeback(struct folio *folio, bool keep_write);
>  void set_page_writeback(struct page *page);

We have a reproducer, fortunately.

> ... it doesn't actually compile because folio_mapcount() is in mm.h
> so the declaration is out of order, but I can invest smoe effort into
> making that work if you think it's worth doing.

It's a shame to add more debug stuff into oft-called inline functions.

Maybe some hacky thing which uninlines these functions and adds the
debug?  I can slip that into -next until we fix the bug then throw the
debug patch away.

Of course, there may be other filesystems which are tripped up by this.
Once we fully understand the failure we can decide whether it's worth
adding the extra debug to mainline?

