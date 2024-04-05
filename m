Return-Path: <linux-fsdevel+bounces-16211-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9C889A29F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 18:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9739B243B6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 16:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0416E16F858;
	Fri,  5 Apr 2024 16:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="W/kTTz5a";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="riYSMPLf";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="W/kTTz5a";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="riYSMPLf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879BB50A98;
	Fri,  5 Apr 2024 16:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712335043; cv=none; b=UGiuKnTwTr35EEUIs3X3JS8E8fWvy73pFikU1dA4G02eyyqM+YlbfJmAQk5c+R0sMV6FifzxuMYdS4dCZy1Es+lm6e/zytJNXmBYyC+hHmsXgS7oy+fZ/PdXU1jmBCIxQEVKJxikzFJ9N7QTvRjPOm2FLu7NG1MqLZL9s8/uKiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712335043; c=relaxed/simple;
	bh=fbRV8D+g8Pp361DpMzV4d80YR3tASUfH1VeZ1zh+ic4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OPbCvtKiX2OJCOsVHPGyULSOqp8v8LE+EaV3/Y3YtGb3QbMxs3JdB5My8EyHoyq7dANVgfRD/TnPaMltVIj1AODetOXZdgp27N3DNIKe2uWH62mT6GY1caZjAyjfoFcmZG9Bvl6IVQb/I/hZ8ZPmsGEW5WoHPfr2J0XkY6BoCE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=W/kTTz5a; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=riYSMPLf; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=W/kTTz5a; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=riYSMPLf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 417FD21ABB;
	Fri,  5 Apr 2024 16:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712335034; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9b6bVC5wHtPZFe+lwb/5F0DCN1XHlga3Dp0t9Yx4D6E=;
	b=W/kTTz5a0vf6qCbYd530AH8Ld3LbgdAvwrl0o7mQRnx++sK7lsXO8cVDnspMF3EtOiFfjQ
	WLF1c0RrSGfafJ5DK84sZcOqa+r0iDAUUK5jXG/Eaq1O4tbnQKhwe9egaX0XsVi2stjctD
	S8iinN3fNaL1br9CIG528txeUo1AqHk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712335034;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9b6bVC5wHtPZFe+lwb/5F0DCN1XHlga3Dp0t9Yx4D6E=;
	b=riYSMPLfFTJTaeD9N5m3QqVojPpAR+UoMNiolx4g/5uczTHbCJoXBox2cOjheK1LSwgJ/W
	pjdwpvQXkjkVpWAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="W/kTTz5a";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=riYSMPLf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712335034; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9b6bVC5wHtPZFe+lwb/5F0DCN1XHlga3Dp0t9Yx4D6E=;
	b=W/kTTz5a0vf6qCbYd530AH8Ld3LbgdAvwrl0o7mQRnx++sK7lsXO8cVDnspMF3EtOiFfjQ
	WLF1c0RrSGfafJ5DK84sZcOqa+r0iDAUUK5jXG/Eaq1O4tbnQKhwe9egaX0XsVi2stjctD
	S8iinN3fNaL1br9CIG528txeUo1AqHk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712335034;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9b6bVC5wHtPZFe+lwb/5F0DCN1XHlga3Dp0t9Yx4D6E=;
	b=riYSMPLfFTJTaeD9N5m3QqVojPpAR+UoMNiolx4g/5uczTHbCJoXBox2cOjheK1LSwgJ/W
	pjdwpvQXkjkVpWAQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id E3926139E8;
	Fri,  5 Apr 2024 16:37:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id dhBHK7koEGblbwAAn2gu4w
	(envelope-from <krisman@suse.de>); Fri, 05 Apr 2024 16:37:13 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Eugen Hristev <eugen.hristev@collabora.com>
Cc: Matthew Wilcox <willy@infradead.org>,  tytso@mit.edu,
  adilger.kernel@dilger.ca,  linux-ext4@vger.kernel.org,
  jaegeuk@kernel.org,  chao@kernel.org,
  linux-f2fs-devel@lists.sourceforge.net,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org,  kernel@collabora.com,
  viro@zeniv.linux.org.uk,  brauner@kernel.org,  jack@suse.cz,
  ebiggers@kernel.org
Subject: Re: [PATCH v16 0/9] Cache insensitive cleanup for ext4/f2fs
In-Reply-To: <ec3a3946-d6d6-40e1-8645-34b258d8b507@collabora.com> (Eugen
	Hristev's message of "Fri, 5 Apr 2024 16:02:15 +0300")
References: <20240405121332.689228-1-eugen.hristev@collabora.com>
	<Zg_sF1uPG4gdnJxI@casper.infradead.org>
	<ec3a3946-d6d6-40e1-8645-34b258d8b507@collabora.com>
Date: Fri, 05 Apr 2024 12:37:12 -0400
Message-ID: <87le5r3gw7.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns,suse.de:dkim,wikipedia.org:url];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 417FD21ABB
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.51

Eugen Hristev <eugen.hristev@collabora.com> writes:

> On 4/5/24 15:18, Matthew Wilcox wrote:
>> On Fri, Apr 05, 2024 at 03:13:23PM +0300, Eugen Hristev wrote:
>>> Hello,
>>>
>>> I am trying to respin the series here :
>>> https://www.spinics.net/lists/linux-ext4/msg85081.html
>> 
>> The subject here is "Cache insensitive cleanup for ext4/f2fs".
>> Cache insensitive means something entirely different
>> https://en.wikipedia.org/wiki/Cache-oblivious_algorithm
>> 
>> I suspect you mean "Case insensitive".
>
> You are correct, I apologize for the typo.

Heh. I completely missed it in the previous submissions. I guess we both
just mentally auto-corrected.

Since we are here, I think I contributed to the typo in the cover letter
with the summary lines of patch 1 and 2.  Differently from the rest of
the series, these two are actually working on a "cache of
casefolded strings".  But their summary lines are misleading.

Can you rename them to:

[PATCH v16 1/9] ext4: Simplify the handling of cached casefolded names
[PATCH v16 2/9] f2fs: Simplify the handling of cached casefolded names

From a quick look, the series is looking good and the strict mode issue
pointed in the last iteration seems fixed, though I didn't run it yet.
I'll take a closer look later today and fully review.

-- 
Gabriel Krisman Bertazi

