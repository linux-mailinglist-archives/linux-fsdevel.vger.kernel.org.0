Return-Path: <linux-fsdevel+bounces-76912-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMtjJJDGi2maawAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76912-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 01:00:16 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A0812033F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 01:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E47353052B8A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 00:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F142833B979;
	Wed, 11 Feb 2026 00:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FdIQ5Bh0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2172833B951;
	Wed, 11 Feb 2026 00:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770768008; cv=none; b=Dg4BXlLuGz+ozm8v4q1jjjtlpXouRghQQgARhtB6gH6xMXBkZ5iTPSCy4BHBOHae6Bj4q9XagI08q/lDaUKESrZnAG3tyPJWvOXmBsv8X9We9SZcvjPblZEhOvNiQaphkkAMIIZSFeFULXvrdhh4sY6p3g6rlmIDteflwnFxT7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770768008; c=relaxed/simple;
	bh=XaUt2fxs6+Hw9vgEH5aKDaojJF8p441vXL03S7tLBj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eBsSyU9cx/wn/GDzX7miukyrQ4wgDf+/5dEGUHvJkM0WM9WBnbIOaQou8vYQQA/GPiuTcUBNiFCHHgqMv0UPK2/6HkctRVQAsqsOfDtRl5tYrjhTtArRopmG6/1yDHQZPHqJNDjZlPN27eWu/PkwBuPcttHJFzWAtRszzR+m87E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FdIQ5Bh0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F253C116C6;
	Wed, 11 Feb 2026 00:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770768007;
	bh=XaUt2fxs6+Hw9vgEH5aKDaojJF8p441vXL03S7tLBj8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FdIQ5Bh0EUj3vBmq4eEFxj3fMDAAAsa1rXxIhaBMY6VwPG847J7X1XvtPP0GyI6mC
	 dVPcNhas+cTVIczdUA/bVzi5rC+BcKLBVbwn6MzITdu6u86JPOMhYt6KDoMUJO9OcE
	 uVswTjv1Z42YrdPQdbmvW0iKsPfI4XlI/4TZORBRht4rvY/jdXlyYolXZ5X7l9B7oH
	 4W7OuOtr7/EHM1yp8yAAImdLLFjFXCu6P/cRHzxOM5OtpFzqIpmwMypNkZyA3zzz6O
	 h5dKoOaESrUQkKNprSWdyisAXHF0rJ2vcewt+ktoU5DZMFkWpl4HBqvTsYLFktWbZG
	 q9DbyuzL/dvgg==
Date: Tue, 10 Feb 2026 19:00:05 -0500
From: Sasha Levin <sashal@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Wei Gao <wegao@suse.com>, willy@infradead.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] iomap: fix race between iomap_set_range_uptodate
 and folio_end_read
Message-ID: <aYvGhQI2ryNR7VLQ@laps>
References: <20251223223018.3295372-1-sashal@kernel.org>
 <20251223223018.3295372-2-sashal@kernel.org>
 <CAJnrk1ZiJVNg-k+CSY_VqJ3sQOW1mo6C-9QT0bzgLT4sKGGCyg@mail.gmail.com>
 <aUtCjXbraDrq-Sxe@laps>
 <aYbmy8JdgXwsGaPP@autotest-wegao.qe.prg2.suse.org>
 <CAJnrk1anodUxD5GR18N8w8239S_kbgijQyZC48Nsa4isb-e5JA@mail.gmail.com>
 <aYp33Ddm7wYFrr_Q@autotest-wegao.qe.prg2.suse.org>
 <CAJnrk1YARhOOKb=OuDLR-X8_que34Q93WagNMOiTjYVohHLdWA@mail.gmail.com>
 <aYp-aTJPzSnwRd6O@autotest-wegao.qe.prg2.suse.org>
 <CAJnrk1aPs2J_EerLROxtiHAKTyU2NHBkRXpS=-yunEsC9epAWw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1aPs2J_EerLROxtiHAKTyU2NHBkRXpS=-yunEsC9epAWw@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-76912-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email]
X-Rspamd-Queue-Id: 11A0812033F
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 02:18:06PM -0800, Joanne Koong wrote:
>On Mon, Feb 9, 2026 at 4:40 PM Wei Gao <wegao@suse.com> wrote:
>>
>> On Mon, Feb 09, 2026 at 04:20:01PM -0800, Joanne Koong wrote:
>> > On Mon, Feb 9, 2026 at 4:12 PM Wei Gao <wegao@suse.com> wrote:
>> > >
>> > > On Mon, Feb 09, 2026 at 11:08:50AM -0800, Joanne Koong wrote:
>> > > > On Fri, Feb 6, 2026 at 11:16 PM Wei Gao <wegao@suse.com> wrote:
>> > > > >
>> > > > > On Tue, Dec 23, 2025 at 08:31:57PM -0500, Sasha Levin wrote:
>> > > > > > On Tue, Dec 23, 2025 at 05:12:09PM -0800, Joanne Koong wrote:
>> > > > > > > On Tue, Dec 23, 2025 at 2:30 PM Sasha Levin <sashal@kernel.org> wrote:
>> > > > > > > >
>> > > > > > >
>> > > > > > > Hi Sasha,
>> > > > > > >
>> > > > > > > Thanks for your patch and for the detailed writeup.
>> > > > > >
>> > > > > > Thanks for looking into this!
>> > > > > >
>> > > > > > > > When iomap uses large folios, per-block uptodate tracking is managed via
>> > > > > > > > iomap_folio_state (ifs). A race condition can cause the ifs uptodate bits
>> > > > > > > > to become inconsistent with the folio's uptodate flag.
>> > > > > > > >
>> > > > > > > > The race occurs because folio_end_read() uses XOR semantics to atomically
>> > > > > > > > set the uptodate bit and clear the locked bit:
>> > > > > > > >
>> > > > > > > >   Thread A (read completion):          Thread B (concurrent write):
>> > > > > > > >   --------------------------------     --------------------------------
>> > > > > > > >   iomap_finish_folio_read()
>> > > > > > > >     spin_lock(state_lock)
>> > > > > > > >     ifs_set_range_uptodate() -> true
>> > > > > > > >     spin_unlock(state_lock)
>> > > > > > > >                                        iomap_set_range_uptodate()
>> > > > > > > >                                          spin_lock(state_lock)
>> > > > > > > >                                          ifs_set_range_uptodate() -> true
>> > > > > > > >                                          spin_unlock(state_lock)
>> > > > > > > >                                          folio_mark_uptodate(folio)
>> > > > > > > >     folio_end_read(folio, true)
>> > > > > > > >       folio_xor_flags()  // XOR CLEARS uptodate!
>> > > > > > >
>> > > > > > > The part I'm confused about here is how this can happen between a
>> > > > > > > concurrent read and write. My understanding is that the folio is
>> > > > > > > locked when the read occurs and locked when the write occurs and both
>> > > > > > > locks get dropped only when the read or write finishes. Looking at
>> > > > > > > iomap code, I see iomap_set_range_uptodate() getting called in
>> > > > > > > __iomap_write_begin() and __iomap_write_end() for the writes, but in
>> > > > > > > both those places the folio lock is held while this is called. I'm not
>> > > > > > > seeing how the read and write race in the diagram can happen, but
>> > > > > > > maybe I'm missing something here?
>> > > > > >
>> > > > > > Hmm, you're right... The folio lock should prevent concurrent read/write
>> > > > > > access. Looking at this again, I suspect that FUSE was calling
>> > > > > > folio_clear_uptodate() and folio_mark_uptodate() directly without updating the
>> > > > > > ifs bits. For example, in fuse_send_write_pages() on write error, it calls
>> > > > > > folio_clear_uptodate(folio) which clears the folio flag but leaves ifs still
>> > > > > > showing all blocks uptodate?
>> > > > >
>> > > > > Hi Sasha
>> > > > > On PowerPC with 64KB page size, msync04 fails with SIGBUS on NTFS-FUSE. The issue stems from a state inconsistency between
>> > > > > the iomap_folio_state (ifs) bitmap and the folio's Uptodate flag.
>> > > > > tst_test.c:1985: TINFO: === Testing on ntfs ===
>> > > > > tst_test.c:1290: TINFO: Formatting /dev/loop0 with ntfs opts='' extra opts=''
>> > > > > Failed to set locale, using default 'C'.
>> > > > > The partition start sector was not specified for /dev/loop0 and it could not be obtained automatically.  It has been set to 0.
>> > > > > The number of sectors per track was not specified for /dev/loop0 and it could not be obtained automatically.  It has been set to 0.
>> > > > > The number of heads was not specified for /dev/loop0 and it could not be obtained automatically.  It has been set to 0.
>> > > > > To boot from a device, Windows needs the 'partition start sector', the 'sectors per track' and the 'number of heads' to be set.
>> > > > > Windows will not be able to boot from this device.
>> > > > > tst_test.c:1302: TINFO: Mounting /dev/loop0 to /tmp/LTP_msy3ljVxi/msync04 fstyp=ntfs flags=0
>> > > > > tst_test.c:1302: TINFO: Trying FUSE...
>> > > > > tst_test.c:1953: TBROK: Test killed by SIGBUS!
>> > > > >
>> > > > > Root Cause Analysis: When a page fault triggers fuse_read_folio, the iomap_read_folio_iter handles the request. For a 64KB page,
>> > > > > after fetching 4KB via fuse_iomap_read_folio_range_async, the remaining 60KB (61440 bytes) is zero-filled via iomap_block_needs_zeroing,
>> > > > > then iomap_set_range_uptodate marks the folio as Uptodate globally, after folio_xor_flags folio's uptodate become 0 again, finally trigger
>> > > > > an SIGBUS issue in filemap_fault.
>> > > >
>> > > > Hi Wei,
>> > > >
>> > > > Thanks for your report. afaict, this scenario occurs only if the
>> > > > server is a fuseblk server with a block size different from the memory
>> > > > page size and if the file size is less than the size of the folio
>> > > > being read in.
>> > > Thanks for checking this and give quick feedback :)
>> > > >
>> > > > Could you verify that this snippet from Sasha's patch fixes the issue?:
>> > > Yes, Sasha's patch can fixes the issue.
>> >
>> > I think just those lines I pasted from Sasha's patch is the relevant
>> > fix. Could you verify that just those lines (without the changes
>> > from the rest of his patch) fixes the issue?
>> Yes, i just add two lines change in iomap_set_range_uptodate can fixes
>> the issue.
>
>Great, thank you for confirming.
>
>Sasha, would you mind submitting this snippet of your patch as the fix
>for the EOF zeroing issue? I think it could be restructured to
>
>diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
>index 1fe19b4ee2f4..412e661871f8 100644
>--- a/fs/iomap/buffered-io.c
>+++ b/fs/iomap/buffered-io.c
>@@ -87,7 +87,16 @@ static void iomap_set_range_uptodate(struct folio
>*folio, size_t off,
>
>        if (ifs) {
>                spin_lock_irqsave(&ifs->state_lock, flags);
>-               uptodate = ifs_set_range_uptodate(folio, ifs, off, len);
>+               /*
>+                * If a read is in progress, we must NOT call
>folio_mark_uptodate.
>+                * The read completion path (iomap_finish_folio_read or
>+                * iomap_read_end) will call folio_end_read() which uses XOR
>+                * semantics to set the uptodate bit. If we set it here, the XOR
>+                * in folio_end_read() will clear it, leaving the folio not
>+                * uptodate.
>+                */
>+               uptodate = ifs_set_range_uptodate(folio, ifs, off, len) &&
>+                       !ifs->read_bytes_pending;
>                spin_unlock_irqrestore(&ifs->state_lock, flags);
>        }
>
>to be a bit more concise.
>
>If you're busy and don't have the bandwidth, I'm happy to forward the
>patch on your behalf with your Signed-off-by / authorship.

Thanks for the offer Joanna!

Since you've done all the triaging work here, please go ahead and submit it -
something like a Suggested-by would be more than enought for me :)

-- 
Thanks,
Sasha

