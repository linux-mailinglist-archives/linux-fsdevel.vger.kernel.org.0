Return-Path: <linux-fsdevel+bounces-51060-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D956AD2556
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 20:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 329797A6FE6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 18:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1D321CC47;
	Mon,  9 Jun 2025 18:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="v0wFk8tk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lZ/sAyPu";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YCrV4AIg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="P52/t0Rh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFAB27718
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Jun 2025 18:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749492733; cv=none; b=sN8gnOzOhUBf3lc/BRpEnFqXfNfSLbCcpLhO04ZwKdIw55HC5fKVIZLVbPKyUd0vNkOUvJXZ0+26nwohQcvD9S0REQtZOqKtvwTl9zhrKTSi2tmnj3dyVDvX5pGKFevu30H1KscX3y4yiwrhDU3Cs9qWRE0dtFL2o4io1oZ3/Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749492733; c=relaxed/simple;
	bh=7lWaZE7ndxwhziGP3AAYNmUDiUTCXmniJ1I9vk2gkfY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e4Ge3hrM8PM1USDcqIZPcinm5Ck6zESAcoyCisve+Uc/eMm2UsW6qOf9yWegkIDPSmCZqIyeEWVNOOdyMUjsC1kdH/a7TEABm/J4Wdzj4hPJ5SeuH9VF/Y5vhH6c1+UkebDQHI0wEZZmz7qN3BA9RezeneaLPaIDboo4GResew4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=v0wFk8tk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lZ/sAyPu; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YCrV4AIg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=P52/t0Rh; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DFC57211A7;
	Mon,  9 Jun 2025 18:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1749492727; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mCQPzKef5KBYPuZcGNrS+fYrFPTv4oGkkQMM7gBKAeg=;
	b=v0wFk8tkxF2LEk3vNFUobgi5VBD7BctOXt++MnagBW2HhRJhxR/b0lco6vX62OxZOt1D+k
	xHPkBfL8LEgvogtUOUOV1rgp3BiY+L08NRtePXy/NnKM8rI3Zj0eHAGFasmesms1uMvBkK
	CO7XUT4FofgpLXgNMdktWDRosb9/C8k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1749492727;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mCQPzKef5KBYPuZcGNrS+fYrFPTv4oGkkQMM7gBKAeg=;
	b=lZ/sAyPuGete1v3W9ylv8mDpew0Wc1skg1KwHyMljyZDTCI7CkzSyOp2o0KWHdh9IvR4gu
	Fs4W3MvLCnAlHDDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=YCrV4AIg;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="P52/t0Rh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1749492726; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mCQPzKef5KBYPuZcGNrS+fYrFPTv4oGkkQMM7gBKAeg=;
	b=YCrV4AIgFqBXev0BxeFE/N/1uLg3CP1G3c5qn3/+zNKWX8X26Q+vmDRWiD6vOL3n2vkrfg
	cDvL4tgij5wgBC/95I3cm5u+JxFHqGUvjsRUf7KdjI03g4hGb1hXK7UNRomS1uOvB/DUD/
	8/JPS/Bw7QsxnAXfc4l8Vg5fiw84bL0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1749492726;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mCQPzKef5KBYPuZcGNrS+fYrFPTv4oGkkQMM7gBKAeg=;
	b=P52/t0RhhgmiRSV/LMxlh0QN2rIPWggX8WM/acrx3AIdyhZU6DTTl9/WLJ1kL1ZgzqBh7G
	1OYQ2fbLFkti2dAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8CEAD13A1D;
	Mon,  9 Jun 2025 18:12:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wKAgG/YjR2iwLQAAD6G6ig
	(envelope-from <krisman@suse.de>); Mon, 09 Jun 2025 18:12:06 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: =?utf-8?Q?Bj=C3=B6rn?= JACKE <bjacke@SerNet.DE>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: casefold is using unsuitable case mapping table
In-Reply-To: <20250425114026.GA1032053@sernet.de> (=?utf-8?Q?=22Bj=C3=B6rn?=
 JACKE"'s message of
	"Fri, 25 Apr 2025 13:40:26 +0200")
Organization: SUSE
References: <20250422123141.GD855798@sernet.de>
	<87h62dtjyk.fsf@mailhost.krisman.be>
	<20250425114026.GA1032053@sernet.de>
Date: Mon, 09 Jun 2025 14:12:04 -0400
Message-ID: <87y0u0yebv.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: DFC57211A7
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWO(0.00)[2];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	URIBL_BLOCKED(0.00)[mailhost.krisman.be:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,sernet.de:email];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.51
X-Spam-Level: 

Bj=C3=B6rn JACKE <bjacke@SerNet.DE> writes:

> I understand that it's difficult to change this as we store hashes of the
> current lowercase version of the filenames. I'm not an expert enough in t=
he
> filesystem code to come up with a good idea how to solve this though.
> Eventually we can use different versions of casefolding tables and store =
in the
> filesystem, which version to use?

Regardless of the endless discussion about which code-points to fold or
not fold, which we've been having for years already, we must preserve
existing behavior for existing users, i.e. preserve semantics and disk
names and hashes.  Since the different semantics are a requirement for
SMB, we should envision a way to provide both maps side-by-side.

I suggest we do it as a separate unicode_map that filesystems can opt-in
through a flag in utf8_load.  It should be easy to generate the extra
map and this guarantees we won't break existing users.  I'll can take
look in the next weeks.

--=20
Gabriel Krisman Bertazi

