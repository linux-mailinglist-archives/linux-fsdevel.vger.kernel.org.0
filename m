Return-Path: <linux-fsdevel+bounces-72010-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D680ECDB137
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 02:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C784301D5B0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 01:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD60E27703A;
	Wed, 24 Dec 2025 01:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QfJvAT34"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075F1242D7C;
	Wed, 24 Dec 2025 01:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766539919; cv=none; b=mZx8usJPhuSj6uLfDBscML6oWo2HMF2nlu9Uem4RwYiEeVZP+mxJDfm8AyEazCD08feRVcA+o21/YPxeJR186UylHxBc6Hp718fUyT3GWEzIbMeyHv+l6ECdFmn3tsXudVtTFJSfMug9CXyG0xF4rm1A/O2W+k9CtFwdPMmSrHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766539919; c=relaxed/simple;
	bh=Ti1FiacwzOrXt7zvsqO72RPmjAhVeJ2kKl9RYvDpOBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Js+xDYuypHSacoGStP+RpaUQZVS9rR4WDmaS5YcXobwQRFrwXHA/Rct7VEKtctZSlJJrTpp9U2f+taYPRQUBxiEOxX8kLaF1pgTwtb+hFCyMO7plhNZqJMgzTCRMGsr6i2eNYvgGCc9gVev5CwZPH6hZ90IXYp/keZMANQe+KAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QfJvAT34; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 533E4C113D0;
	Wed, 24 Dec 2025 01:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766539918;
	bh=Ti1FiacwzOrXt7zvsqO72RPmjAhVeJ2kKl9RYvDpOBA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QfJvAT34B8bCM46APmrNkbRDQZt5i/xZRtRnrLIVc4bEhXA+fSmpkac6+LPwCpVT7
	 I432+1dfxkaLqWHoMbLkvVJBJfqPowO8bBx8yR0il0EE5tUMaMzZfDFc+l0ImQkxy+
	 9AwB7gnt1eHgDS/0sPxiRLNgeQwDexwjMOLlqqIbL8Ufa6vovtMj4fsV1gBVtQc8XF
	 CRD7N4wC+XgwSij10sYLoHFtut1RpzL7F4EfUXB6kOqwFzrpc5lPd65NbhRTNQbBFB
	 fnp7yi1hoZWMD7n/c3Aemdb/rJLvaRSWtcqHw7hjR9FtCM/ywExNRhy0KyodWWblOQ
	 jY0Q3oKL27gTw==
Date: Tue, 23 Dec 2025 20:31:57 -0500
From: Sasha Levin <sashal@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: willy@infradead.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] iomap: fix race between iomap_set_range_uptodate
 and folio_end_read
Message-ID: <aUtCjXbraDrq-Sxe@laps>
References: <20250926002609.1302233-13-joannelkoong@gmail.com>
 <20251223223018.3295372-1-sashal@kernel.org>
 <20251223223018.3295372-2-sashal@kernel.org>
 <CAJnrk1ZiJVNg-k+CSY_VqJ3sQOW1mo6C-9QT0bzgLT4sKGGCyg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1ZiJVNg-k+CSY_VqJ3sQOW1mo6C-9QT0bzgLT4sKGGCyg@mail.gmail.com>

On Tue, Dec 23, 2025 at 05:12:09PM -0800, Joanne Koong wrote:
>On Tue, Dec 23, 2025 at 2:30 PM Sasha Levin <sashal@kernel.org> wrote:
>>
>
>Hi Sasha,
>
>Thanks for your patch and for the detailed writeup.

Thanks for looking into this!

>> When iomap uses large folios, per-block uptodate tracking is managed via
>> iomap_folio_state (ifs). A race condition can cause the ifs uptodate bits
>> to become inconsistent with the folio's uptodate flag.
>>
>> The race occurs because folio_end_read() uses XOR semantics to atomically
>> set the uptodate bit and clear the locked bit:
>>
>>   Thread A (read completion):          Thread B (concurrent write):
>>   --------------------------------     --------------------------------
>>   iomap_finish_folio_read()
>>     spin_lock(state_lock)
>>     ifs_set_range_uptodate() -> true
>>     spin_unlock(state_lock)
>>                                        iomap_set_range_uptodate()
>>                                          spin_lock(state_lock)
>>                                          ifs_set_range_uptodate() -> true
>>                                          spin_unlock(state_lock)
>>                                          folio_mark_uptodate(folio)
>>     folio_end_read(folio, true)
>>       folio_xor_flags()  // XOR CLEARS uptodate!
>
>The part I'm confused about here is how this can happen between a
>concurrent read and write. My understanding is that the folio is
>locked when the read occurs and locked when the write occurs and both
>locks get dropped only when the read or write finishes. Looking at
>iomap code, I see iomap_set_range_uptodate() getting called in
>__iomap_write_begin() and __iomap_write_end() for the writes, but in
>both those places the folio lock is held while this is called. I'm not
>seeing how the read and write race in the diagram can happen, but
>maybe I'm missing something here?

Hmm, you're right... The folio lock should prevent concurrent read/write
access. Looking at this again, I suspect that FUSE was calling
folio_clear_uptodate() and folio_mark_uptodate() directly without updating the
ifs bits. For example, in fuse_send_write_pages() on write error, it calls
folio_clear_uptodate(folio) which clears the folio flag but leaves ifs still
showing all blocks uptodate?

>>
>> Result: folio is NOT uptodate, but ifs says all blocks ARE uptodate.
>
>Ah I see the WARN_ON_ONCE() in ifs_free:
>        WARN_ON_ONCE(ifs_is_fully_uptodate(folio, ifs) !=
>                        folio_test_uptodate(folio));
>
>Just to confirm, are you seeing that the folio is not marked uptodate
>but the ifs blocks are? Or are the ifs blocks not uptodate but the
>folio is?

The former: folio is NOT uptodate but ifs shows all blocks ARE uptodate
(state=0xffff with 16 blocks)

>>
>> Fix by checking read_bytes_pending in iomap_set_range_uptodate() under the
>> lock. If a read is in progress, skip calling folio_mark_uptodate() - the
>> read completion path will handle it via folio_end_read().
>>
>> The warning was triggered during FUSE-based filesystem (e.g., NTFS-3G)
>> unmount when the LTP writev03 test was run:
>>
>>   WARNING: fs/iomap/buffered-io.c at ifs_free
>>   Call trace:
>>    ifs_free
>>    iomap_invalidate_folio
>>    truncate_cleanup_folio
>>    truncate_inode_pages_range
>>    truncate_inode_pages_final
>>    fuse_evict_inode
>>    ...
>>    fuse_kill_sb_blk
>>
>> Fixes: 7a4847e54cc1 ("iomap: use folio_end_read()")
>> Assisted-by: claude-opus-4-5-20251101
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>>  fs/fuse/dev.c          |  3 +-
>>  fs/fuse/file.c         |  6 ++--
>>  fs/iomap/buffered-io.c | 65 +++++++++++++++++++++++++++++++++++++++---
>>  include/linux/iomap.h  |  2 ++
>>  4 files changed, 68 insertions(+), 8 deletions(-)
>>
>> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
>> index 6d59cbc877c6..50e84e913589 100644
>> --- a/fs/fuse/dev.c
>> +++ b/fs/fuse/dev.c
>> @@ -11,6 +11,7 @@
>>  #include "fuse_dev_i.h"
>>
>>  #include <linux/init.h>
>> +#include <linux/iomap.h>
>>  #include <linux/module.h>
>>  #include <linux/poll.h>
>>  #include <linux/sched/signal.h>
>> @@ -1820,7 +1821,7 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
>>                 if (!folio_test_uptodate(folio) && !err && offset == 0 &&
>>                     (nr_bytes == folio_size(folio) || file_size == end)) {
>>                         folio_zero_segment(folio, nr_bytes, folio_size(folio));
>> -                       folio_mark_uptodate(folio);
>> +                       iomap_set_range_uptodate(folio, 0, folio_size(folio));
>>                 }
>>                 folio_unlock(folio);
>>                 folio_put(folio);
>> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
>> index 01bc894e9c2b..3abe38416199 100644
>> --- a/fs/fuse/file.c
>> +++ b/fs/fuse/file.c
>> @@ -1216,13 +1216,13 @@ static ssize_t fuse_send_write_pages(struct fuse_io_args *ia,
>>                 struct folio *folio = ap->folios[i];
>>
>>                 if (err) {
>> -                       folio_clear_uptodate(folio);
>> +                       iomap_clear_folio_uptodate(folio);
>>                 } else {
>>                         if (count >= folio_size(folio) - offset)
>>                                 count -= folio_size(folio) - offset;
>>                         else {
>>                                 if (short_write)
>> -                                       folio_clear_uptodate(folio);
>> +                                       iomap_clear_folio_uptodate(folio);
>>                                 count = 0;
>>                         }
>>                         offset = 0;
>> @@ -1305,7 +1305,7 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
>>
>>                 /* If we copied full folio, mark it uptodate */
>>                 if (tmp == folio_size(folio))
>> -                       folio_mark_uptodate(folio);
>> +                       iomap_set_range_uptodate(folio, 0, folio_size(folio));
>>
>>                 if (folio_test_uptodate(folio)) {
>>                         folio_unlock(folio);
>> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
>> index e5c1ca440d93..7ceda24cf6a7 100644
>> --- a/fs/iomap/buffered-io.c
>> +++ b/fs/iomap/buffered-io.c
>> @@ -74,8 +74,7 @@ static bool ifs_set_range_uptodate(struct folio *folio,
>>         return ifs_is_fully_uptodate(folio, ifs);
>>  }
>>
>> -static void iomap_set_range_uptodate(struct folio *folio, size_t off,
>> -               size_t len)
>> +void iomap_set_range_uptodate(struct folio *folio, size_t off, size_t len)
>>  {
>>         struct iomap_folio_state *ifs = folio->private;
>>         unsigned long flags;
>> @@ -87,12 +86,50 @@ static void iomap_set_range_uptodate(struct folio *folio, size_t off,
>>         if (ifs) {
>>                 spin_lock_irqsave(&ifs->state_lock, flags);
>>                 uptodate = ifs_set_range_uptodate(folio, ifs, off, len);
>> +               /*
>> +                * If a read is in progress, we must NOT call folio_mark_uptodate
>> +                * here. The read completion path (iomap_finish_folio_read or
>> +                * iomap_read_end) will call folio_end_read() which uses XOR
>> +                * semantics to set the uptodate bit. If we set it here, the XOR
>> +                * in folio_end_read() will clear it, leaving the folio not
>> +                * uptodate while the ifs says all blocks are uptodate.
>> +                */
>> +               if (uptodate && ifs->read_bytes_pending)
>> +                       uptodate = false;
>
>Does the warning you saw in ifs_free() still go away without the
>changes here to iomap_set_range_uptodate() or is this change here
>necessary?  I'm asking mostly because I'm not seeing how
>iomap_set_range_uptodate() can be called while the read is in
>progress, as the logic should be already protected by the folio locks.

Yes, the warning goes away even without this part. I don't think that this is
necessary - I just kept it while figuring out the race.

>>                 spin_unlock_irqrestore(&ifs->state_lock, flags);
>>         }
>>
>>         if (uptodate)
>>                 folio_mark_uptodate(folio);
>>  }
>> +EXPORT_SYMBOL_GPL(iomap_set_range_uptodate);
>> +
>> +void iomap_clear_folio_uptodate(struct folio *folio)
>> +{
>> +       struct iomap_folio_state *ifs = folio->private;
>> +
>> +       if (ifs) {
>> +               struct inode *inode = folio->mapping->host;
>> +               unsigned int nr_blocks = i_blocks_per_folio(inode, folio);
>> +               unsigned long flags;
>> +
>> +               spin_lock_irqsave(&ifs->state_lock, flags);
>> +               /*
>> +                * If a read is in progress, don't clear the uptodate state.
>> +                * The read completion path will handle the folio state, and
>> +                * clearing here would race with iomap_finish_folio_read()
>> +                * potentially causing ifs/folio uptodate state mismatch.
>> +                */
>> +               if (ifs->read_bytes_pending) {
>> +                       spin_unlock_irqrestore(&ifs->state_lock, flags);
>> +                       return;
>> +               }
>> +               bitmap_clear(ifs->state, 0, nr_blocks);
>> +               spin_unlock_irqrestore(&ifs->state_lock, flags);
>> +       }
>> +       folio_clear_uptodate(folio);
>> +}
>> +EXPORT_SYMBOL_GPL(iomap_clear_folio_uptodate);
>>
>>  /*
>>   * Find the next dirty block in the folio. end_blk is inclusive.
>> @@ -399,8 +436,17 @@ void iomap_finish_folio_read(struct folio *folio, size_t off, size_t len,
>>                 spin_unlock_irqrestore(&ifs->state_lock, flags);
>>         }
>>
>> -       if (finished)
>> +       if (finished) {
>> +               /*
>> +                * If uptodate is true but the folio is already marked uptodate,
>> +                * folio_end_read's XOR semantics would clear the uptodate bit.
>> +                * This should never happen because iomap_set_range_uptodate()
>> +                * skips calling folio_mark_uptodate() when read_bytes_pending
>> +                * is non-zero, ensuring only the read completion path sets it.
>> +                */
>> +               WARN_ON_ONCE(uptodate && folio_test_uptodate(folio));
>
>Matthew pointed out in another thread [1] that folio_end_read() has
>already the warnings against double-unlocks or double-uptodates
>in-built:
>
>        VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
>        VM_BUG_ON_FOLIO(success && folio_test_uptodate(folio), folio);
>
>but imo the WARN_ON_ONCE() here is nice to have too, as I don't think
>most builds enable CONFIG_DEBUG_VM.
>
>[1] https://lore.kernel.org/linux-fsdevel/aPu1ilw6Tq6tKPrf@casper.infradead.org/
>
>Thanks,
>Joanne
>>                 folio_end_read(folio, uptodate);
>> +       }
>>  }
>>  EXPORT_SYMBOL_GPL(iomap_finish_folio_read);
>>
>> @@ -481,8 +527,19 @@ static void iomap_read_end(struct folio *folio, size_t bytes_submitted)
>>                 if (end_read)
>>                         uptodate = ifs_is_fully_uptodate(folio, ifs);
>>                 spin_unlock_irq(&ifs->state_lock);
>> -               if (end_read)
>> +               if (end_read) {
>> +                       /*
>> +                        * If uptodate is true but the folio is already marked
>> +                        * uptodate, folio_end_read's XOR semantics would clear
>> +                        * the uptodate bit. This should never happen because
>> +                        * iomap_set_range_uptodate() skips calling
>> +                        * folio_mark_uptodate() when read_bytes_pending is
>> +                        * non-zero, ensuring only the read completion path
>> +                        * sets it.
>> +                        */
>> +                       WARN_ON_ONCE(uptodate && folio_test_uptodate(folio));
>>                         folio_end_read(folio, uptodate);
>> +               }
>>         } else if (!bytes_submitted) {
>>                 /*
>>                  * If there were no bytes submitted, this means we are
>> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
>> index 520e967cb501..3c2ad88d16b6 100644
>> --- a/include/linux/iomap.h
>> +++ b/include/linux/iomap.h
>> @@ -345,6 +345,8 @@ void iomap_read_folio(const struct iomap_ops *ops,
>>  void iomap_readahead(const struct iomap_ops *ops,
>>                 struct iomap_read_folio_ctx *ctx);
>>  bool iomap_is_partially_uptodate(struct folio *, size_t from, size_t count);
>> +void iomap_set_range_uptodate(struct folio *folio, size_t off, size_t len);
>> +void iomap_clear_folio_uptodate(struct folio *folio);
>>  struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos, size_t len);
>>  bool iomap_release_folio(struct folio *folio, gfp_t gfp_flags);
>>  void iomap_invalidate_folio(struct folio *folio, size_t offset, size_t len);
>> --
>> 2.51.0
>>

-- 
Thanks,
Sasha

