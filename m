Return-Path: <linux-fsdevel+bounces-72009-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0A7CDB0E5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 02:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47DAE303C9F3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 01:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609FD26A0DB;
	Wed, 24 Dec 2025 01:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bWYgnnbL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF373256C8B
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Dec 2025 01:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766538743; cv=none; b=TeH9/9uhrvOaergfgPwKNAKYNbwpf8lLZGieLe2kr4P50zI5c81OOO8J20/6ETbYh38ZMk/Oua6s1W46eTVbMix7A4OHYmqTIbotovCFAfF8acpDlIdXopXnvCub1l6AB+6dXn+VrWuqErZCqamNulELj51220GOutrdGwNpEu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766538743; c=relaxed/simple;
	bh=TkOr5tYzqQVR21yojM9XgcPqVPy1KZCTnTGXFfmRiYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nomG2VuOt7Mj0SP2nDwERzIi3TQ96p9syMz+MgEXp1TKVGYbBdOQ0tq+fELuq+8FBrmr+BOK/N0bbdp2FIZxHf1y9Hfv0+MYDdN6YLTo6fuHj314oDxXEixdZYYUhYRhyFsYkmG02ojEBO7V9kW6J+W82sDCy6FmKK4HFXexPGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bWYgnnbL; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8c07bc2ad13so302360085a.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Dec 2025 17:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766538741; x=1767143541; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I7dUqKnfZnOzqEEKjXNcjYk+bAAz79TLT2Ws4aPMkG4=;
        b=bWYgnnbLCXSzkfdoC+wPDzk3OD0PNnJChk9FFHDNm3bFOEa6pIU4HCsKHUkALGoJWJ
         vdPgTdgJ4/4+tz1d7MN0l88G5h8vu8OrjiemAmy+IvYlPC//Kr2hddISBnTXS4wabvOT
         ELMhwgLYYEephz7KIe2GTQh0Qc1wG7XYnI8syeY0L0DHDa2ZB32T/u3IxCxz2yEB2yw4
         e6BN8QLXDSuoi6aAnrgBy4oegRsPjTKbyCcDPJJcUU7/hQNfmfZzd3OuTQ/08YP+BmQh
         YbvzciezsU5qFs2PHchb3QFf3CuOx1LQ86gewDNy4AJPTp7mB7AJA7NXEhN9yh+5oXl8
         sV0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766538741; x=1767143541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I7dUqKnfZnOzqEEKjXNcjYk+bAAz79TLT2Ws4aPMkG4=;
        b=quFRZytZS0wgromKCxCRcNiR4XC+ngc1aDb9CY1gIm2aNblBvoSjeSzx9bkR1Tc3nS
         kXML1NIq3tPlRnf/qv0qAEkiB8wSYOpsLxIjWRHnPkagoDHSe2YA2usDOO4uPPI0EJF2
         rwJpmROxAoZOj04fQEwP/ScoVqVnWz155xTkf+N9znskYAjxkgl0c0YLKZNz+3HQsqV5
         ZhoYHSXZdC66QEX7vEXRxXSn4/9x6uYpSmt16LPvKq8a5jEuWUmMMLdLvtO4uOulhK7W
         hrLreiEs8+PYcX82r7QyFY7Bl10cbMJxD6nXDCUYtTaSyImxnR4arj2hCnCb4My4v1bS
         WhmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWWHrnwcc2U2pTwVVrgqE/N1G9ttZuuA+DShrBXNtukmIZwCDgSJnhd3LqPjzpwJgVQmrNjdaWJTueveG2@vger.kernel.org
X-Gm-Message-State: AOJu0YypdPpc5INIbIdIdLUaC+EyyKsOWNg9LR48BJ89WIxMaMlVjzAY
	QdkmbgBHfbea0Iz4GCyhZwPoFdewuFwAmXV52yeI1kGufKYH1/sbQaSXdJmjEPxg/8M0zG38lnj
	NUzJkYDnlL1uBc1CtAtG9PnlIv6/8Bs4=
X-Gm-Gg: AY/fxX6MCMYEGcHTgQMXYnc+ZBYAUTqIWpOQebFULmO5xfI8gj/RYfUeDwJIo5L7fSU
	ThdjbOWRy8a8ezlEp6NeT+aTdupCFR4L4EtLvXo/ZhnAfsUOWRp0HMoAfdA4EVqY6erfLMHxyTm
	JO5a2jB5AWtdcCQsL7dN6wGFlfrD4sYH/uxeRX5YRZeVq36JvAawnfPgS040yx/1GRbx6jAkX4L
	1jwd1qzmT6xsBaSBFbTuYieFGZTnwrAfPzKeSOeaJIWxpFTy7a+WGVBH5MIXgUtBiSdrA==
X-Google-Smtp-Source: AGHT+IFuJTWS0G9nR2pgHSbTEJo5I8LifuMl9Ug1wL4wCf8hoPU5eTN+NOiTbFALKl7eDa6ogTfdwlHjZX8hxu0QXN4=
X-Received: by 2002:a05:622a:4ccc:b0:4f1:dfc8:51e with SMTP id
 d75a77b69052e-4f4abcdbb38mr276041311cf.29.1766538740595; Tue, 23 Dec 2025
 17:12:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926002609.1302233-13-joannelkoong@gmail.com>
 <20251223223018.3295372-1-sashal@kernel.org> <20251223223018.3295372-2-sashal@kernel.org>
In-Reply-To: <20251223223018.3295372-2-sashal@kernel.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 23 Dec 2025 17:12:09 -0800
X-Gm-Features: AQt7F2qgVPCRvaWdXHe4wy649nNSAafagESzzTf9oNky_hcUMHVSHCHA-kw9iJE
Message-ID: <CAJnrk1ZiJVNg-k+CSY_VqJ3sQOW1mo6C-9QT0bzgLT4sKGGCyg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] iomap: fix race between iomap_set_range_uptodate
 and folio_end_read
To: Sasha Levin <sashal@kernel.org>
Cc: willy@infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 23, 2025 at 2:30=E2=80=AFPM Sasha Levin <sashal@kernel.org> wro=
te:
>

Hi Sasha,

Thanks for your patch and for the detailed writeup.

> When iomap uses large folios, per-block uptodate tracking is managed via
> iomap_folio_state (ifs). A race condition can cause the ifs uptodate bits
> to become inconsistent with the folio's uptodate flag.
>
> The race occurs because folio_end_read() uses XOR semantics to atomically
> set the uptodate bit and clear the locked bit:
>
>   Thread A (read completion):          Thread B (concurrent write):
>   --------------------------------     --------------------------------
>   iomap_finish_folio_read()
>     spin_lock(state_lock)
>     ifs_set_range_uptodate() -> true
>     spin_unlock(state_lock)
>                                        iomap_set_range_uptodate()
>                                          spin_lock(state_lock)
>                                          ifs_set_range_uptodate() -> true
>                                          spin_unlock(state_lock)
>                                          folio_mark_uptodate(folio)
>     folio_end_read(folio, true)
>       folio_xor_flags()  // XOR CLEARS uptodate!

The part I'm confused about here is how this can happen between a
concurrent read and write. My understanding is that the folio is
locked when the read occurs and locked when the write occurs and both
locks get dropped only when the read or write finishes. Looking at
iomap code, I see iomap_set_range_uptodate() getting called in
__iomap_write_begin() and __iomap_write_end() for the writes, but in
both those places the folio lock is held while this is called. I'm not
seeing how the read and write race in the diagram can happen, but
maybe I'm missing something here?

>
> Result: folio is NOT uptodate, but ifs says all blocks ARE uptodate.

Ah I see the WARN_ON_ONCE() in ifs_free:
        WARN_ON_ONCE(ifs_is_fully_uptodate(folio, ifs) !=3D
                        folio_test_uptodate(folio));

Just to confirm, are you seeing that the folio is not marked uptodate
but the ifs blocks are? Or are the ifs blocks not uptodate but the
folio is?

>
> Fix by checking read_bytes_pending in iomap_set_range_uptodate() under th=
e
> lock. If a read is in progress, skip calling folio_mark_uptodate() - the
> read completion path will handle it via folio_end_read().
>
> The warning was triggered during FUSE-based filesystem (e.g., NTFS-3G)
> unmount when the LTP writev03 test was run:
>
>   WARNING: fs/iomap/buffered-io.c at ifs_free
>   Call trace:
>    ifs_free
>    iomap_invalidate_folio
>    truncate_cleanup_folio
>    truncate_inode_pages_range
>    truncate_inode_pages_final
>    fuse_evict_inode
>    ...
>    fuse_kill_sb_blk
>
> Fixes: 7a4847e54cc1 ("iomap: use folio_end_read()")
> Assisted-by: claude-opus-4-5-20251101
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  fs/fuse/dev.c          |  3 +-
>  fs/fuse/file.c         |  6 ++--
>  fs/iomap/buffered-io.c | 65 +++++++++++++++++++++++++++++++++++++++---
>  include/linux/iomap.h  |  2 ++
>  4 files changed, 68 insertions(+), 8 deletions(-)
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 6d59cbc877c6..50e84e913589 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -11,6 +11,7 @@
>  #include "fuse_dev_i.h"
>
>  #include <linux/init.h>
> +#include <linux/iomap.h>
>  #include <linux/module.h>
>  #include <linux/poll.h>
>  #include <linux/sched/signal.h>
> @@ -1820,7 +1821,7 @@ static int fuse_notify_store(struct fuse_conn *fc, =
unsigned int size,
>                 if (!folio_test_uptodate(folio) && !err && offset =3D=3D =
0 &&
>                     (nr_bytes =3D=3D folio_size(folio) || file_size =3D=
=3D end)) {
>                         folio_zero_segment(folio, nr_bytes, folio_size(fo=
lio));
> -                       folio_mark_uptodate(folio);
> +                       iomap_set_range_uptodate(folio, 0, folio_size(fol=
io));
>                 }
>                 folio_unlock(folio);
>                 folio_put(folio);
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 01bc894e9c2b..3abe38416199 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1216,13 +1216,13 @@ static ssize_t fuse_send_write_pages(struct fuse_=
io_args *ia,
>                 struct folio *folio =3D ap->folios[i];
>
>                 if (err) {
> -                       folio_clear_uptodate(folio);
> +                       iomap_clear_folio_uptodate(folio);
>                 } else {
>                         if (count >=3D folio_size(folio) - offset)
>                                 count -=3D folio_size(folio) - offset;
>                         else {
>                                 if (short_write)
> -                                       folio_clear_uptodate(folio);
> +                                       iomap_clear_folio_uptodate(folio)=
;
>                                 count =3D 0;
>                         }
>                         offset =3D 0;
> @@ -1305,7 +1305,7 @@ static ssize_t fuse_fill_write_pages(struct fuse_io=
_args *ia,
>
>                 /* If we copied full folio, mark it uptodate */
>                 if (tmp =3D=3D folio_size(folio))
> -                       folio_mark_uptodate(folio);
> +                       iomap_set_range_uptodate(folio, 0, folio_size(fol=
io));
>
>                 if (folio_test_uptodate(folio)) {
>                         folio_unlock(folio);
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index e5c1ca440d93..7ceda24cf6a7 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -74,8 +74,7 @@ static bool ifs_set_range_uptodate(struct folio *folio,
>         return ifs_is_fully_uptodate(folio, ifs);
>  }
>
> -static void iomap_set_range_uptodate(struct folio *folio, size_t off,
> -               size_t len)
> +void iomap_set_range_uptodate(struct folio *folio, size_t off, size_t le=
n)
>  {
>         struct iomap_folio_state *ifs =3D folio->private;
>         unsigned long flags;
> @@ -87,12 +86,50 @@ static void iomap_set_range_uptodate(struct folio *fo=
lio, size_t off,
>         if (ifs) {
>                 spin_lock_irqsave(&ifs->state_lock, flags);
>                 uptodate =3D ifs_set_range_uptodate(folio, ifs, off, len)=
;
> +               /*
> +                * If a read is in progress, we must NOT call folio_mark_=
uptodate
> +                * here. The read completion path (iomap_finish_folio_rea=
d or
> +                * iomap_read_end) will call folio_end_read() which uses =
XOR
> +                * semantics to set the uptodate bit. If we set it here, =
the XOR
> +                * in folio_end_read() will clear it, leaving the folio n=
ot
> +                * uptodate while the ifs says all blocks are uptodate.
> +                */
> +               if (uptodate && ifs->read_bytes_pending)
> +                       uptodate =3D false;

Does the warning you saw in ifs_free() still go away without the
changes here to iomap_set_range_uptodate() or is this change here
necessary?  I'm asking mostly because I'm not seeing how
iomap_set_range_uptodate() can be called while the read is in
progress, as the logic should be already protected by the folio locks.

>                 spin_unlock_irqrestore(&ifs->state_lock, flags);
>         }
>
>         if (uptodate)
>                 folio_mark_uptodate(folio);
>  }
> +EXPORT_SYMBOL_GPL(iomap_set_range_uptodate);
> +
> +void iomap_clear_folio_uptodate(struct folio *folio)
> +{
> +       struct iomap_folio_state *ifs =3D folio->private;
> +
> +       if (ifs) {
> +               struct inode *inode =3D folio->mapping->host;
> +               unsigned int nr_blocks =3D i_blocks_per_folio(inode, foli=
o);
> +               unsigned long flags;
> +
> +               spin_lock_irqsave(&ifs->state_lock, flags);
> +               /*
> +                * If a read is in progress, don't clear the uptodate sta=
te.
> +                * The read completion path will handle the folio state, =
and
> +                * clearing here would race with iomap_finish_folio_read(=
)
> +                * potentially causing ifs/folio uptodate state mismatch.
> +                */
> +               if (ifs->read_bytes_pending) {
> +                       spin_unlock_irqrestore(&ifs->state_lock, flags);
> +                       return;
> +               }
> +               bitmap_clear(ifs->state, 0, nr_blocks);
> +               spin_unlock_irqrestore(&ifs->state_lock, flags);
> +       }
> +       folio_clear_uptodate(folio);
> +}
> +EXPORT_SYMBOL_GPL(iomap_clear_folio_uptodate);
>
>  /*
>   * Find the next dirty block in the folio. end_blk is inclusive.
> @@ -399,8 +436,17 @@ void iomap_finish_folio_read(struct folio *folio, si=
ze_t off, size_t len,
>                 spin_unlock_irqrestore(&ifs->state_lock, flags);
>         }
>
> -       if (finished)
> +       if (finished) {
> +               /*
> +                * If uptodate is true but the folio is already marked up=
todate,
> +                * folio_end_read's XOR semantics would clear the uptodat=
e bit.
> +                * This should never happen because iomap_set_range_uptod=
ate()
> +                * skips calling folio_mark_uptodate() when read_bytes_pe=
nding
> +                * is non-zero, ensuring only the read completion path se=
ts it.
> +                */
> +               WARN_ON_ONCE(uptodate && folio_test_uptodate(folio));

Matthew pointed out in another thread [1] that folio_end_read() has
already the warnings against double-unlocks or double-uptodates
in-built:

        VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
        VM_BUG_ON_FOLIO(success && folio_test_uptodate(folio), folio);

but imo the WARN_ON_ONCE() here is nice to have too, as I don't think
most builds enable CONFIG_DEBUG_VM.

[1] https://lore.kernel.org/linux-fsdevel/aPu1ilw6Tq6tKPrf@casper.infradead=
.org/

Thanks,
Joanne
>                 folio_end_read(folio, uptodate);
> +       }
>  }
>  EXPORT_SYMBOL_GPL(iomap_finish_folio_read);
>
> @@ -481,8 +527,19 @@ static void iomap_read_end(struct folio *folio, size=
_t bytes_submitted)
>                 if (end_read)
>                         uptodate =3D ifs_is_fully_uptodate(folio, ifs);
>                 spin_unlock_irq(&ifs->state_lock);
> -               if (end_read)
> +               if (end_read) {
> +                       /*
> +                        * If uptodate is true but the folio is already m=
arked
> +                        * uptodate, folio_end_read's XOR semantics would=
 clear
> +                        * the uptodate bit. This should never happen bec=
ause
> +                        * iomap_set_range_uptodate() skips calling
> +                        * folio_mark_uptodate() when read_bytes_pending =
is
> +                        * non-zero, ensuring only the read completion pa=
th
> +                        * sets it.
> +                        */
> +                       WARN_ON_ONCE(uptodate && folio_test_uptodate(foli=
o));
>                         folio_end_read(folio, uptodate);
> +               }
>         } else if (!bytes_submitted) {
>                 /*
>                  * If there were no bytes submitted, this means we are
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 520e967cb501..3c2ad88d16b6 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -345,6 +345,8 @@ void iomap_read_folio(const struct iomap_ops *ops,
>  void iomap_readahead(const struct iomap_ops *ops,
>                 struct iomap_read_folio_ctx *ctx);
>  bool iomap_is_partially_uptodate(struct folio *, size_t from, size_t cou=
nt);
> +void iomap_set_range_uptodate(struct folio *folio, size_t off, size_t le=
n);
> +void iomap_clear_folio_uptodate(struct folio *folio);
>  struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos, size_=
t len);
>  bool iomap_release_folio(struct folio *folio, gfp_t gfp_flags);
>  void iomap_invalidate_folio(struct folio *folio, size_t offset, size_t l=
en);
> --
> 2.51.0
>

