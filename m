Return-Path: <linux-fsdevel+bounces-76666-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJFaNdTmhmklRwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76666-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 07 Feb 2026 08:16:36 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CF31051CE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 07 Feb 2026 08:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 42B1330069A8
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Feb 2026 07:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892262EAD1C;
	Sat,  7 Feb 2026 07:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ADSdjc8E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E0F82866
	for <linux-fsdevel@vger.kernel.org>; Sat,  7 Feb 2026 07:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770448591; cv=none; b=AoxHsP1j4TlMj1B4fk4ZJsTqh+S4uodZI9/2v5TUE+RrK5Q53RDk+MfqnsqcT9NPgfImA0fEgoBgWjEeuY5ZUUikdFK36jK0Z9W16nmdHhsaEY8oVlZAXnOeuytGbwYp9B0PJDoOkVYTurTI+nDkoENgI2JMzVF+ODrT2tmcOMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770448591; c=relaxed/simple;
	bh=eQbW9xS9B3mOEafny6TBM6v1t8c/s5LNQbWsMMV7I7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UtLKf53FhelqbpCr28GLGU9S92VaDr2m3qC5YP50yFvl6feQ3aHdl+Nfc6TvwhCcTDEF/ZQpQZjRTM6upd34sOVeF99MyUddQ5c3zGLNuHbiviS+XdldotHMiai7EvLhsHuFrLQmZ08T+LXAHbhjJLE/27y5K2EKkXZVk42OH6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ADSdjc8E; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-481188b7760so20319435e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Feb 2026 23:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770448589; x=1771053389; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gh72JUXqcZxwM6Qx/WEJMV7looK+tA62bwM2YXZnPuM=;
        b=ADSdjc8EsOYVOWojpVK5qGBjeEZ0dMZXX70QChPCdkE8xSLBW8WS3f2tPHikDteX0c
         vqISLUt+E2HxXRT6h7aQa3AozFmezyctUZRue2Ex8xh7ZC43fNajIjsb74Xg8ScgAZMu
         Hjg/c/O/cVF7eMpoTCaJlS+NcD0iZDyC0A3+CXJ/uvjrzvNMOlrumYddybVFNT0nxiSg
         Q+AD134FLpiqqt1IO319yZDXxZZeCFdS5Pw1BmVJdbHq72Yxi57vjSONe1soFdZrHbbE
         ngjMkCKVLmLNxHYAZZfDkcQ2FEOnh5DaiwSVpg/mQ23IPGbQGZSGG3Ytwe+1NVQfXckE
         lO3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770448589; x=1771053389;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gh72JUXqcZxwM6Qx/WEJMV7looK+tA62bwM2YXZnPuM=;
        b=i3vJt/Xku50Cd8o7ccOmMRhJWJrlIhePTJqPZLZzoznt7XkA59IYLR7mpGbCLOZhHS
         BlvG+jDRAb2llNMV6JT3ehpJp7gptxMdsipgaEMLtiwV7hKMsr2ZtPAJ6g1ZDCxXoGGj
         wG5N4qAEkbphvHzZ8fdm52Pgtal2i9LEkXITIkcoZRxzsMxMVWYLLGNYbaySqR7ob6tK
         5J5M4F3s5UARhYm6is6q/qe4J5cKho2zJBd3rGMay/s0W/Cw+2cziIQmAdDoPsO/PQzu
         rJG1aC2w824LCASzlxejki511IEwGQBB6XEGX6C+K4fUlCZaLNYzMox+X3MS5qfdDD/z
         0B9w==
X-Forwarded-Encrypted: i=1; AJvYcCW15WTX1aXHE7hRj/oV/tq9dS8CN0ASpcDsaehsgSjjAKKW1DbgAxAJ6VyM8ySBUvk43P7ERvg6L72P8670@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5g1OdQvdWk1vune4waFNAXo8O37SuMhea4SbwbVvOhNm0IwBC
	vwLxNGxdvDmjNdsNGAol/7T+r15RM55Z+Py3aONn1e6jDJs2mUIy6pzZqSPu808eCQ==
X-Gm-Gg: AZuq6aJlwD6QaGdS273AZKS34uB9l7R518ThWGp3jbf6RPDSStj+GrRt1IBHzYlHZHQ
	lrsJIR2pLeZOCa3IWyxauRUQxvZKiFcwGljFWOr3CmZTtlI0JBa8x3wmE64MC6s7/UPsGl+eLUY
	MQBAH44jJhxC0QZ6PIbaY8c07JiwVlGfoe3QsleFyEphIuO3jFsvifexlBQs/1/tMsHWBp3o81+
	KB65Uk3O/6M8DYBd2eMVRoR2m63CzXeIJj/MecD4JVPLYDz65FBsefUlda3dkFtgutX1mxO38XH
	/ekexXyRxmQjBzzfPilOiP0c3wuCsUkzrG2XgHNHYFx4B2k64nOGgWprJPPBY66t/ZbKbfUiHQA
	esTktNO9Q/v6bTq3ecEma2lvR1GORh8gdzeSdUJQAPGLe1LpajWPdw/HjnuojPcn4NvlrKqFRye
	CJUuanHQ5OlkjY0WriJotgVWHMzWI9
X-Received: by 2002:a05:600c:621a:b0:480:6852:8d94 with SMTP id 5b1f17b1804b1-4832097e2b0mr72233015e9.27.1770448589235;
        Fri, 06 Feb 2026 23:16:29 -0800 (PST)
Received: from autotest-wegao.qe.prg2.suse.org ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483209c6de6sm35906685e9.13.2026.02.06.23.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 23:16:28 -0800 (PST)
Date: Sat, 7 Feb 2026 07:16:27 +0000
From: Wei Gao <wegao@suse.com>
To: Sasha Levin <sashal@kernel.org>
Cc: Joanne Koong <joannelkoong@gmail.com>, willy@infradead.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	wegao@suse.com
Subject: Re: [RFC PATCH 1/1] iomap: fix race between iomap_set_range_uptodate
 and folio_end_read
Message-ID: <aYbmy8JdgXwsGaPP@autotest-wegao.qe.prg2.suse.org>
References: <20250926002609.1302233-13-joannelkoong@gmail.com>
 <20251223223018.3295372-1-sashal@kernel.org>
 <20251223223018.3295372-2-sashal@kernel.org>
 <CAJnrk1ZiJVNg-k+CSY_VqJ3sQOW1mo6C-9QT0bzgLT4sKGGCyg@mail.gmail.com>
 <aUtCjXbraDrq-Sxe@laps>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aUtCjXbraDrq-Sxe@laps>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76666-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,infradead.org,vger.kernel.org,suse.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wegao@suse.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 03CF31051CE
X-Rspamd-Action: no action

On Tue, Dec 23, 2025 at 08:31:57PM -0500, Sasha Levin wrote:
> On Tue, Dec 23, 2025 at 05:12:09PM -0800, Joanne Koong wrote:
> > On Tue, Dec 23, 2025 at 2:30 PM Sasha Levin <sashal@kernel.org> wrote:
> > > 
> > 
> > Hi Sasha,
> > 
> > Thanks for your patch and for the detailed writeup.
> 
> Thanks for looking into this!
> 
> > > When iomap uses large folios, per-block uptodate tracking is managed via
> > > iomap_folio_state (ifs). A race condition can cause the ifs uptodate bits
> > > to become inconsistent with the folio's uptodate flag.
> > > 
> > > The race occurs because folio_end_read() uses XOR semantics to atomically
> > > set the uptodate bit and clear the locked bit:
> > > 
> > >   Thread A (read completion):          Thread B (concurrent write):
> > >   --------------------------------     --------------------------------
> > >   iomap_finish_folio_read()
> > >     spin_lock(state_lock)
> > >     ifs_set_range_uptodate() -> true
> > >     spin_unlock(state_lock)
> > >                                        iomap_set_range_uptodate()
> > >                                          spin_lock(state_lock)
> > >                                          ifs_set_range_uptodate() -> true
> > >                                          spin_unlock(state_lock)
> > >                                          folio_mark_uptodate(folio)
> > >     folio_end_read(folio, true)
> > >       folio_xor_flags()  // XOR CLEARS uptodate!
> > 
> > The part I'm confused about here is how this can happen between a
> > concurrent read and write. My understanding is that the folio is
> > locked when the read occurs and locked when the write occurs and both
> > locks get dropped only when the read or write finishes. Looking at
> > iomap code, I see iomap_set_range_uptodate() getting called in
> > __iomap_write_begin() and __iomap_write_end() for the writes, but in
> > both those places the folio lock is held while this is called. I'm not
> > seeing how the read and write race in the diagram can happen, but
> > maybe I'm missing something here?
> 
> Hmm, you're right... The folio lock should prevent concurrent read/write
> access. Looking at this again, I suspect that FUSE was calling
> folio_clear_uptodate() and folio_mark_uptodate() directly without updating the
> ifs bits. For example, in fuse_send_write_pages() on write error, it calls
> folio_clear_uptodate(folio) which clears the folio flag but leaves ifs still
> showing all blocks uptodate?

Hi Sasha
On PowerPC with 64KB page size, msync04 fails with SIGBUS on NTFS-FUSE. The issue stems from a state inconsistency between
the iomap_folio_state (ifs) bitmap and the folio's Uptodate flag.
tst_test.c:1985: TINFO: === Testing on ntfs ===
tst_test.c:1290: TINFO: Formatting /dev/loop0 with ntfs opts='' extra opts=''
Failed to set locale, using default 'C'.
The partition start sector was not specified for /dev/loop0 and it could not be obtained automatically.  It has been set to 0.
The number of sectors per track was not specified for /dev/loop0 and it could not be obtained automatically.  It has been set to 0.
The number of heads was not specified for /dev/loop0 and it could not be obtained automatically.  It has been set to 0.
To boot from a device, Windows needs the 'partition start sector', the 'sectors per track' and the 'number of heads' to be set.
Windows will not be able to boot from this device.
tst_test.c:1302: TINFO: Mounting /dev/loop0 to /tmp/LTP_msy3ljVxi/msync04 fstyp=ntfs flags=0
tst_test.c:1302: TINFO: Trying FUSE...
tst_test.c:1953: TBROK: Test killed by SIGBUS!

Root Cause Analysis: When a page fault triggers fuse_read_folio, the iomap_read_folio_iter handles the request. For a 64KB page, 
after fetching 4KB via fuse_iomap_read_folio_range_async, the remaining 60KB (61440 bytes) is zero-filled via iomap_block_needs_zeroing, 
then iomap_set_range_uptodate marks the folio as Uptodate globally, after folio_xor_flags folio's uptodate become 0 again, finally trigger 
an SIGBUS issue in filemap_fault.

So your iomap_set_range_uptodate patch can fix above failed case since it block mark folio's uptodate to 1.
Hope my findings are helpful.

> 
> -- 
> Thanks,
> Sasha
> 

