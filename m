Return-Path: <linux-fsdevel+bounces-47293-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01016A9B883
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 21:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7091E3B8C0A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 19:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D702291165;
	Thu, 24 Apr 2025 19:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="t/UivPLR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yBZV8ILw";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="t/UivPLR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yBZV8ILw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F76228B4F4
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Apr 2025 19:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745524409; cv=none; b=jXNn7dT2rfzzq6IE+QNoxtLIOo0f4h9Ci9GaGotIoVSZB56UbKSkKQLDIJcUfNbldQe9+T0lVEXoyDNiHf5BHlIcquB4qf2La+Pwc+poq+MitdjBJqHni91fXGEXA//B+HWk6GafYFGBLxVqZBT1odbqdRwKIs7+/ygpPdtAbEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745524409; c=relaxed/simple;
	bh=vN7jOL/9Mni3AGaohHIz4KkE5stCRQhlbZwzpe414oI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oywP4zIz1XFBq8PW+myyHFyUbQSdCS1D0ZGMxaU5BQ4mR70RJsQE0SaDHjgKUajJRhENOf3aFKSIdi5qSqYblDKod6JOedKOfx7Jkb4GRPKsF6ei0azYkB9Xa26uLGjRfrg/Wt/TfKvqpTH2B55sxhPxIQhv6A8Xs3Fx0mwOJJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=t/UivPLR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yBZV8ILw; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=t/UivPLR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yBZV8ILw; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 55A881F44E;
	Thu, 24 Apr 2025 19:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745524405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qxfhp6h9zyJV/ulAoeZ/6yTqZYk3vUJC0jHt1Bt5Dho=;
	b=t/UivPLRUNEyeQE1SQMvlAOohxigmFMhXObN/VDvryKYUbDLtSva/Yg5O3UvaRkqy0NhwK
	AqIu4Gl/F1NMkTV/0SvQ/pvHS4KCZeSeMhq+PmU64I5TfcQRp1sR4oJ7Yy8wxEDMcRFmPw
	6i6p9j3Mnsv7DIOZjgbvwlJB8d+f3RQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745524405;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qxfhp6h9zyJV/ulAoeZ/6yTqZYk3vUJC0jHt1Bt5Dho=;
	b=yBZV8ILw9w2lRHmEQ9EZC3nvJcqx/cSY1MP5wDBkSvtg7l/oxj1Exja64TVZkYU7BZFdqi
	nMjiuZDB7LuPVGBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="t/UivPLR";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=yBZV8ILw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745524405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qxfhp6h9zyJV/ulAoeZ/6yTqZYk3vUJC0jHt1Bt5Dho=;
	b=t/UivPLRUNEyeQE1SQMvlAOohxigmFMhXObN/VDvryKYUbDLtSva/Yg5O3UvaRkqy0NhwK
	AqIu4Gl/F1NMkTV/0SvQ/pvHS4KCZeSeMhq+PmU64I5TfcQRp1sR4oJ7Yy8wxEDMcRFmPw
	6i6p9j3Mnsv7DIOZjgbvwlJB8d+f3RQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745524405;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qxfhp6h9zyJV/ulAoeZ/6yTqZYk3vUJC0jHt1Bt5Dho=;
	b=yBZV8ILw9w2lRHmEQ9EZC3nvJcqx/cSY1MP5wDBkSvtg7l/oxj1Exja64TVZkYU7BZFdqi
	nMjiuZDB7LuPVGBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1E2BA1393C;
	Thu, 24 Apr 2025 19:53:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LMB0AbWWCmjoTAAAD6G6ig
	(envelope-from <krisman@suse.de>); Thu, 24 Apr 2025 19:53:25 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: =?utf-8?Q?Bj=C3=B6rn?= JACKE <bjacke@SerNet.DE>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: casefold is using unsuitable case mapping table
In-Reply-To: <20250422123141.GD855798@sernet.de> (=?utf-8?Q?=22Bj=C3=B6rn?=
 JACKE"'s message of
	"Tue, 22 Apr 2025 14:31:41 +0200")
References: <20250422123141.GD855798@sernet.de>
Date: Thu, 24 Apr 2025 15:53:23 -0400
Message-ID: <87h62dtjyk.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 55A881F44E
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Bj=C3=B6rn JACKE <bjacke@SerNet.DE> writes:

> It turns out though that the case insensitive feature is not usable becau=
se it
> does not match the case mapping tables that other operating systems use. =
More
> specifically, the german letter "=C3=9F" is treated as a case equivanten =
of "ss".
>
> There is an equivalent of "=C3=9F" and "ss in some other scopes, also AD =
LDAP treats
> them as an equivante. For systems that requires "lossless" case conversion
> however should not treat =C3=9F and ss as equivalent. This is also why a =
filesystem
> should never ever do that

Well, filesystems should never ever have filename encoding.  Once
they do, we have to make semantics decisions and they are all apparently
stupid to someone.  And any kind of Casefolding is an inherently lossy
operation in this sense, as multiple byte sequences will map to the
same file.

The big problem is that each of the big OS vendors chose specific
semantics of what to casefold.  APFS does NFD + full casefolding[1],
right?  except for "some code-points". I'm not sure what they do with =C3=
=9F,
tbh. I could never find any documentation on the specific code-points
they add/ignore.

In ext4, we decided to have no exceptions. Just do plain NFD + CF.  That
means we do C+F from the table below:

  https://www.unicode.org/Public/12.1.0/ucd/CaseFolding.txt

Which includes =C3=9F->SS.  We could argue forever whether that doesn't make
sense for language X, such as German.  I'm not a German speaker but
friends said it would be common to see stra=C3=9Fe uppercased to STRASSE th=
ere,
even though the 2017 agreement abolished it in favor of =E1=BA=9E.  So what=
 is
the right way?

My point is we can't rely fully on languages to argue the right
semantics.  There are no right semantics.  And Languages are also alive
and changing. There are many other examples where full casefold will
look stupid; for instance, one would argue we should also translate the
T column (i.e non-Turkish languages).  We can produce all sorts of
stupid examples with combining characters in Portuguese/Spanish too.
Linux is not broken beyond the fact the whole idea is broken.  These are
just the semantics we agreed were slightly less insane back in 2017
(considering we don't want to have locales).  And, apart from the
ignorable code points issue, I still think our implementation is
relatively sane.

> Since 2017 there is a well-defined uppercase version of the codepoint (U+=
00DF)
> of the "=C3=9F" letter in Unicode: U+1E9E, this could eventually be used =
but I
> haven't seen any filesystem using that so far. This would be a possible a=
nd
> lossless case equivalent, but well, that's actually another thing to
> discuss.
>
> The important point is to _not_ use the =C3=9F/ss case equicalent. The ca=
sefold
> feature is mainly useless otherwise.

It is not useless.  Android and Wine emulators have been using it just
fine for years.  We also cannot break compatibility for them.

> Can this be changed without causing too much hassle?

We attempted to do a much smaller change recently in commit
5c26d2f1d3f5, because we assumed no one would be trying to create files
with silly stuff like ZWSP (U+200B). Turns out there is a reasonable
use-case for that with Variation Selectors, and we had to revert it.  So
we need to be very careful with any changes here, so people don't lose
access to their files on a kernel update.  Even with that, more
casefolding flavor will cause all sorts of compatibility issues when
moving data across volumes, so I'd be very wary of having more than one
flavor.

What are the exact requirements for samba?  Do you only fold the C
column? Do you need stuff like compatibility normalization?

 [1] https://developer.apple.com/support/downloads/Apple-File-System-Refere=
nce.pdf

--=20
Gabriel Krisman Bertazi

