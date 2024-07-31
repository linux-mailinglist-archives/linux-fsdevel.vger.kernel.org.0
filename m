Return-Path: <linux-fsdevel+bounces-24702-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADDA5943568
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 20:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 318331F24969
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 18:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297E83BBEA;
	Wed, 31 Jul 2024 18:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Qmjsv8S3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SWUvbruv";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Qmjsv8S3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SWUvbruv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65041F954;
	Wed, 31 Jul 2024 18:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722449235; cv=none; b=kVOrCENj0MdPO2VX5sygEh8eX84Q/sXcvFhj5lsKwXHSwLEWZxOaHOn9VBtEcT+gkLKOmuX2iBYBJFxjhzwBuWjtpUGij8grT6ahhJPOPER6cxThqbmWMXmjnstXXY75LqXI5ixYDTiy3v3G+9Yme+qVBiuQXJnKCl83TzPqOus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722449235; c=relaxed/simple;
	bh=2uSzs8P1Rp4TWAnNHCI26IxcMq2MH0hB+z16Sl9Qu6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=isfjEnHN82CPnctF2+zhArSj+N4WB0vFz3rex+W88+ISedU9mvvMieK6KnxlGrUUcKOGYcpmbE1BMyPUWczgIxKxbaFQ4cQQb7Skk5+pmN6yZFj3ETKW/wiL22hk7ZVHnyp3bJUel3tcYiQK7q+76L7EZkX9FZqj+o5HgEOQcbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Qmjsv8S3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SWUvbruv; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Qmjsv8S3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SWUvbruv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D864F1F86C;
	Wed, 31 Jul 2024 18:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722449231;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F7SBrUgvTDAnh5l+GkoOFFdqcfM90kNY/MnFDS/g4X4=;
	b=Qmjsv8S3JfCcdtFGJGnqftBV0mthI9SOW41l24zjtUCYm6ldkqgnSi78wswv5sZI8RmA22
	S/NOKHuO9UrgIIDgXMHbTY9QNt8917ysnT83TepDbn2QtLUT+B8+RC5xs01IvV+r/o7HWI
	9Ap3IE4M7SyfSzVE3sq4te8fv0pMRu4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722449231;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F7SBrUgvTDAnh5l+GkoOFFdqcfM90kNY/MnFDS/g4X4=;
	b=SWUvbruvRbzUhgOiTcV8Qi1HQgZ7J7+F1Z7pHSkyAsKDHnHlwr9z1sxqMkiXqLgcdWe/q+
	nZ8gXoLP65jqJdBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722449231;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F7SBrUgvTDAnh5l+GkoOFFdqcfM90kNY/MnFDS/g4X4=;
	b=Qmjsv8S3JfCcdtFGJGnqftBV0mthI9SOW41l24zjtUCYm6ldkqgnSi78wswv5sZI8RmA22
	S/NOKHuO9UrgIIDgXMHbTY9QNt8917ysnT83TepDbn2QtLUT+B8+RC5xs01IvV+r/o7HWI
	9Ap3IE4M7SyfSzVE3sq4te8fv0pMRu4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722449231;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F7SBrUgvTDAnh5l+GkoOFFdqcfM90kNY/MnFDS/g4X4=;
	b=SWUvbruvRbzUhgOiTcV8Qi1HQgZ7J7+F1Z7pHSkyAsKDHnHlwr9z1sxqMkiXqLgcdWe/q+
	nZ8gXoLP65jqJdBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B7CD71368F;
	Wed, 31 Jul 2024 18:07:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RqZnLE99qmbpMwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 31 Jul 2024 18:07:11 +0000
Date: Wed, 31 Jul 2024 20:07:02 +0200
From: David Sterba <dsterba@suse.cz>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Mateusz Guzik <mjguzik@gmail.com>, Florian Weimer <fweimer@redhat.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, Dave Chinner <dchinner@redhat.com>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: Testing if two open descriptors refer to the same inode
Message-ID: <20240731180702.GU17473@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <874j88sn4d.fsf@oldenburg.str.redhat.com>
 <ghqndyn4x7ujxvybbwet5vxiahus4zey6nkfsv6he3d4en6ehu@bq5s23lstzor>
 <875xsoqy58.fsf@oldenburg.str.redhat.com>
 <vmjtzzz7sxctmf7qrf6mw5hdd653elsi423joiiusahei22bft@quvxy4kajtxt>
 <87sevspit1.fsf@oldenburg.str.redhat.com>
 <CAGudoHEBNRE+78n=WEY=Z0ZCnLmDFadisR-K2ah4SUO6uSm4TA@mail.gmail.com>
 <20240729.113049-lax.waffle.foxy.nit-U1v9CY38xge@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240729.113049-lax.waffle.foxy.nit-U1v9CY38xge@cyphar.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-0.80 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,vger.kernel.org,kernel.org];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]
X-Spam-Flag: NO
X-Spam-Score: -0.80

On Mon, Jul 29, 2024 at 09:40:57PM +1000, Aleksa Sarai wrote:
> On 2024-07-29, Mateusz Guzik <mjguzik@gmail.com> wrote:
> > On Mon, Jul 29, 2024 at 12:57 PM Florian Weimer <fweimer@redhat.com> wrote:
> > > > On Mon, Jul 29, 2024 at 12:40:35PM +0200, Florian Weimer wrote:
> > > >> > On Mon, Jul 29, 2024 at 08:55:46AM +0200, Florian Weimer wrote:
> > > >> >> It was pointed out to me that inode numbers on Linux are no longer
> > > >> >> expected to be unique per file system, even for local file systems.
> > > >> >
> > > >> > I don't know if I'm parsing this correctly.
> > > >> >
> > > >> > Are you claiming on-disk inode numbers are not guaranteed unique per
> > > >> > filesystem? It sounds like utter breakage, with capital 'f'.
> > > >>
> > > >> Yes, POSIX semantics and traditional Linux semantics for POSIX-like
> > > >> local file systems are different.
> > > >
> > > > Can you link me some threads about this?
> > >
> > > Sorry, it was an internal thread.  It's supposed to be common knowledge
> > > among Linux file system developers.  Aleksa referenced LSF/MM
> > > discussions.
> > 
> > So much for open development :-P
> 
> To be clear, this wasn't _decided_ at LSF/MM, it was brought up as a
> topic. There is an LWN article about the session that mentions the
> issue[1].

A discussion about inode numbers or subvolumes comes up every year with
better of worse suggestions what to do about it.

> My understanding is that the btrfs and bcachefs folks independently
> determined they cannot provide this guarantee. As far as I understand,
> the reason why is that inode number allocation on btree filesystems
> stores information about location and some other bits (maybe subvolumes)
> in the bits, making it harder to guarantee there will be no collisions.

No, on btrfs the inode numbers don't encode anything about location,
it's a simple number. The inode numbers remain the same when a snapshot
is taken as it's a 1:1 clone of the file hierarchy, the directory
representing a subvolume/snapshot has fixed inode number 256. The only
difference is the internal subvolume id.

