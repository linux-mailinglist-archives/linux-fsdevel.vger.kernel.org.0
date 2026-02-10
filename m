Return-Path: <linux-fsdevel+bounces-76782-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKMvM5B+imnVLAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76782-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 01:40:48 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A897115B6B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 01:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3E4DE300BC88
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 00:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8498A269CE7;
	Tue, 10 Feb 2026 00:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="D+s73UuV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E81B23EA87
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 00:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770684016; cv=none; b=GkUQ//k5+p8ErJTkH67NhLtuM9Yf1Uy+3cYslkjmB9WsxWe4eQfLxD2tcmFUVM7zPivEsJ4Ik2/KD7gHZVoz9uLxZlAp8JebpkHr5isBE7MvkqKHdwO2yRoeUPtJE46ZXTNr6WbyFy2IwSpHLZtfHM4F9vvTRmm4O0Mq1Vdypd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770684016; c=relaxed/simple;
	bh=/ae933nmJrvQxUhy6avayVPb8BKGNc5/iMDsp8dypWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BhlCnxq4b5S/dhH0nsdY/fXUQU7PR97tDjgZ4JqJtwV0jdyCRysxGIjxq28NLmQwQeKFOQqgwB+HRexEzr2vUiufYQFJllCd726Wk+KoeeYH+xxy53dTeeq2Vjvl7hnzaoTUc4qwni3V0cfNoD+HXxnJgx/dyNztZnxbL61lbsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=D+s73UuV; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4806f3fc50bso41136235e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Feb 2026 16:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770684011; x=1771288811; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=o2tLRSOxrnaGCpoU2B7CZpcr3ydd8qT1fDMCJSoMOsE=;
        b=D+s73UuVyY7xyh2wmOUxIEEOZt7i0qhXClxybylOFD01CpBqcnXL0oWoCPa0mNd/SS
         dNvLNUQ8i65L3uQTbw0RIfkRMIUC0kPxHKmwigYISjgxrtSG0PV3aPzg45vHVQGlburb
         psk0kFj7Qze4Sk0ECxuHkmpj7lHUexz74nH+L8F1JzoJnWlambVyhJ5FpB3mQvOu0dVc
         ukrwiZAbXa66rzqmzMwGbTiIz8SfXL2zlWlJAZZ6HMXEC0iva55RN1lhE6FvNY4w6ab8
         wmidvAya/ki8MqdteEkPVoujAzO/OE/bwjw3rXIDnaKSkjqiWHktVq7iPKp+EIT5wPmv
         Byxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770684011; x=1771288811;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o2tLRSOxrnaGCpoU2B7CZpcr3ydd8qT1fDMCJSoMOsE=;
        b=AirUFL+hhgLr6VXgB08Nm8WVG0HyStc9Rg9t72BMXdXQ/MgynBs4gB0EQp3HrWao9Q
         PyYXZjVu5droukN5LCYecQa/VKTDXb3j9DBbgATd+irDuuTr/WXbv7r9dc1oGgWaLnyO
         qNWxY9J1AX40WxS0yV7a3YcDyx1i+Nz6r6BVdPG8Ly8t32DpZVlPgg3JpoBgKc73M7xb
         rGzNWsUX4a/6sCkxdklYXdu7YF1P3lfQfIJtPjMrJ+bZPQAXyKIC3/Bq/1iTuJGkIz8+
         8vP3WUTDOYjd6jbirjBsVUw2k/cKGhKgTW66wQs7vr/GX1EbUwLpuJn+vklo0ZrML4b2
         To7w==
X-Forwarded-Encrypted: i=1; AJvYcCUm0AcLLQjaYE+FqjtY1BH6b9rc3kJOkTLPjG68fkiT1KyDG5bzIfZ7rByGpoxXBGzmxgWtQGMF/b5tnFi3@vger.kernel.org
X-Gm-Message-State: AOJu0YzbqPe90P056EsFbWYAsvQkCy0DFs8WM42Qn25WfLCqjU/JeCQl
	2lTpEX6rMCPpethVG18M6DTapOyU9B3NwXxBfLw8u+P4HefNvb5i1GGYl6xT41semg==
X-Gm-Gg: AZuq6aJeFSpbC/9inIKK9IbdWW8yNpyuOsx9PqXjIWWxoZRbQQwpOn/HPRsuRzfd4I6
	yX4u1fbQYuO06Z5rym86SvYAqP6UcQHb9/XAvFbXC8qBnl+AZ31LVxZrnIjvDzVtiEDpHpwhyAh
	hQZmVa3mT77cSkPhGC4FxfL61XF+lGRDDvQ6YMf9D8mSwODFI6BLYBjLpuQt++gNtKNenGZgUca
	pem1nYByy/J1esgfz+1ZJ1AUBWOp/g4lvQY9yhYUZ7ps3yoVbIHaLyBItjGN0x3Fh1g2gQaY4vM
	ERNnhbk8N9xqqXw8AVLijMAFebc/A9IPbRyHbPF9K62BXhuuDlivd/2l3xCT8qoL6x9BX8EEuRu
	mu6YszZ5sBqkvyDWnGWleTJXmV0LhSTlezbMP/0lEawyND+6oFHaEYbUUsvNm/Fpz/xsf17ZR3m
	IHY6702sr3i80bfnIleYNHf8fkWvBUOi6amHAww9WV
X-Received: by 2002:a05:600c:4e05:b0:477:af07:dd21 with SMTP id 5b1f17b1804b1-4832021e7d3mr228705135e9.25.1770684011277;
        Mon, 09 Feb 2026 16:40:11 -0800 (PST)
Received: from autotest-wegao.qe.prg2.suse.org ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4832097e142sm103390975e9.8.2026.02.09.16.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 16:40:10 -0800 (PST)
Date: Tue, 10 Feb 2026 00:40:09 +0000
From: Wei Gao <wegao@suse.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Sasha Levin <sashal@kernel.org>, willy@infradead.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] iomap: fix race between iomap_set_range_uptodate
 and folio_end_read
Message-ID: <aYp-aTJPzSnwRd6O@autotest-wegao.qe.prg2.suse.org>
References: <20250926002609.1302233-13-joannelkoong@gmail.com>
 <20251223223018.3295372-1-sashal@kernel.org>
 <20251223223018.3295372-2-sashal@kernel.org>
 <CAJnrk1ZiJVNg-k+CSY_VqJ3sQOW1mo6C-9QT0bzgLT4sKGGCyg@mail.gmail.com>
 <aUtCjXbraDrq-Sxe@laps>
 <aYbmy8JdgXwsGaPP@autotest-wegao.qe.prg2.suse.org>
 <CAJnrk1anodUxD5GR18N8w8239S_kbgijQyZC48Nsa4isb-e5JA@mail.gmail.com>
 <aYp33Ddm7wYFrr_Q@autotest-wegao.qe.prg2.suse.org>
 <CAJnrk1YARhOOKb=OuDLR-X8_que34Q93WagNMOiTjYVohHLdWA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1YARhOOKb=OuDLR-X8_que34Q93WagNMOiTjYVohHLdWA@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76782-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wegao@suse.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.com:email,suse.com:dkim,autotest-wegao.qe.prg2.suse.org:mid]
X-Rspamd-Queue-Id: 0A897115B6B
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 04:20:01PM -0800, Joanne Koong wrote:
> On Mon, Feb 9, 2026 at 4:12 PM Wei Gao <wegao@suse.com> wrote:
> >
> > On Mon, Feb 09, 2026 at 11:08:50AM -0800, Joanne Koong wrote:
> > > On Fri, Feb 6, 2026 at 11:16 PM Wei Gao <wegao@suse.com> wrote:
> > > >
> > > > On Tue, Dec 23, 2025 at 08:31:57PM -0500, Sasha Levin wrote:
> > > > > On Tue, Dec 23, 2025 at 05:12:09PM -0800, Joanne Koong wrote:
> > > > > > On Tue, Dec 23, 2025 at 2:30 PM Sasha Levin <sashal@kernel.org> wrote:
> > > > > > >
> > > > > >
> > > > > > Hi Sasha,
> > > > > >
> > > > > > Thanks for your patch and for the detailed writeup.
> > > > >
> > > > > Thanks for looking into this!
> > > > >
> > > > > > > When iomap uses large folios, per-block uptodate tracking is managed via
> > > > > > > iomap_folio_state (ifs). A race condition can cause the ifs uptodate bits
> > > > > > > to become inconsistent with the folio's uptodate flag.
> > > > > > >
> > > > > > > The race occurs because folio_end_read() uses XOR semantics to atomically
> > > > > > > set the uptodate bit and clear the locked bit:
> > > > > > >
> > > > > > >   Thread A (read completion):          Thread B (concurrent write):
> > > > > > >   --------------------------------     --------------------------------
> > > > > > >   iomap_finish_folio_read()
> > > > > > >     spin_lock(state_lock)
> > > > > > >     ifs_set_range_uptodate() -> true
> > > > > > >     spin_unlock(state_lock)
> > > > > > >                                        iomap_set_range_uptodate()
> > > > > > >                                          spin_lock(state_lock)
> > > > > > >                                          ifs_set_range_uptodate() -> true
> > > > > > >                                          spin_unlock(state_lock)
> > > > > > >                                          folio_mark_uptodate(folio)
> > > > > > >     folio_end_read(folio, true)
> > > > > > >       folio_xor_flags()  // XOR CLEARS uptodate!
> > > > > >
> > > > > > The part I'm confused about here is how this can happen between a
> > > > > > concurrent read and write. My understanding is that the folio is
> > > > > > locked when the read occurs and locked when the write occurs and both
> > > > > > locks get dropped only when the read or write finishes. Looking at
> > > > > > iomap code, I see iomap_set_range_uptodate() getting called in
> > > > > > __iomap_write_begin() and __iomap_write_end() for the writes, but in
> > > > > > both those places the folio lock is held while this is called. I'm not
> > > > > > seeing how the read and write race in the diagram can happen, but
> > > > > > maybe I'm missing something here?
> > > > >
> > > > > Hmm, you're right... The folio lock should prevent concurrent read/write
> > > > > access. Looking at this again, I suspect that FUSE was calling
> > > > > folio_clear_uptodate() and folio_mark_uptodate() directly without updating the
> > > > > ifs bits. For example, in fuse_send_write_pages() on write error, it calls
> > > > > folio_clear_uptodate(folio) which clears the folio flag but leaves ifs still
> > > > > showing all blocks uptodate?
> > > >
> > > > Hi Sasha
> > > > On PowerPC with 64KB page size, msync04 fails with SIGBUS on NTFS-FUSE. The issue stems from a state inconsistency between
> > > > the iomap_folio_state (ifs) bitmap and the folio's Uptodate flag.
> > > > tst_test.c:1985: TINFO: === Testing on ntfs ===
> > > > tst_test.c:1290: TINFO: Formatting /dev/loop0 with ntfs opts='' extra opts=''
> > > > Failed to set locale, using default 'C'.
> > > > The partition start sector was not specified for /dev/loop0 and it could not be obtained automatically.  It has been set to 0.
> > > > The number of sectors per track was not specified for /dev/loop0 and it could not be obtained automatically.  It has been set to 0.
> > > > The number of heads was not specified for /dev/loop0 and it could not be obtained automatically.  It has been set to 0.
> > > > To boot from a device, Windows needs the 'partition start sector', the 'sectors per track' and the 'number of heads' to be set.
> > > > Windows will not be able to boot from this device.
> > > > tst_test.c:1302: TINFO: Mounting /dev/loop0 to /tmp/LTP_msy3ljVxi/msync04 fstyp=ntfs flags=0
> > > > tst_test.c:1302: TINFO: Trying FUSE...
> > > > tst_test.c:1953: TBROK: Test killed by SIGBUS!
> > > >
> > > > Root Cause Analysis: When a page fault triggers fuse_read_folio, the iomap_read_folio_iter handles the request. For a 64KB page,
> > > > after fetching 4KB via fuse_iomap_read_folio_range_async, the remaining 60KB (61440 bytes) is zero-filled via iomap_block_needs_zeroing,
> > > > then iomap_set_range_uptodate marks the folio as Uptodate globally, after folio_xor_flags folio's uptodate become 0 again, finally trigger
> > > > an SIGBUS issue in filemap_fault.
> > >
> > > Hi Wei,
> > >
> > > Thanks for your report. afaict, this scenario occurs only if the
> > > server is a fuseblk server with a block size different from the memory
> > > page size and if the file size is less than the size of the folio
> > > being read in.
> > Thanks for checking this and give quick feedback :)
> > >
> > > Could you verify that this snippet from Sasha's patch fixes the issue?:
> > Yes, Sasha's patch can fixes the issue.
> 
> I think just those lines I pasted from Sasha's patch is the relevant
> fix. Could you verify that just those lines (without the changes
> from the rest of his patch) fixes the issue?
Yes, i just add two lines change in iomap_set_range_uptodate can fixes
the issue.
+		if (uptodate && ifs->read_bytes_pending)
+			uptodate = false;
> 
> Thanks,
> Joanne
> 
> 
> > >
> > > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > > index e5c1ca440d93..7ceda24cf6a7 100644
> > > --- a/fs/iomap/buffered-io.c
> > > +++ b/fs/iomap/buffered-io.c
> > > @@ -87,12 +86,50 @@ static void iomap_set_range_uptodate(struct folio
> > > *folio, size_t off,
> > >   if (ifs) {
> > >           spin_lock_irqsave(&ifs->state_lock, flags);
> > >           uptodate = ifs_set_range_uptodate(folio, ifs, off, len);
> > >           + /*
> > >           + * If a read is in progress, we must NOT call folio_mark_uptodate
> > >           + * here. The read completion path (iomap_finish_folio_read or
> > >           + * iomap_read_end) will call folio_end_read() which uses XOR
> > >           + * semantics to set the uptodate bit. If we set it here, the XOR
> > >           + * in folio_end_read() will clear it, leaving the folio not
> > >           + * uptodate while the ifs says all blocks are uptodate.
> > >           + */
> > >          + if (uptodate && ifs->read_bytes_pending)
> > >                    + uptodate = false;
> > >         spin_unlock_irqrestore(&ifs->state_lock, flags);
> > >   }
> > >
> > > Thanks,
> > > Joanne
> > >
> > > >
> > > > So your iomap_set_range_uptodate patch can fix above failed case since it block mark folio's uptodate to 1.
> > > > Hope my findings are helpful.
> > > >
> > > > >
> > > > > --
> > > > > Thanks,
> > > > > Sasha
> > > > >

