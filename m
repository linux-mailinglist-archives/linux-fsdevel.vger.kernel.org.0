Return-Path: <linux-fsdevel+bounces-59227-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B256FB36D53
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 17:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BAE946827C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 15:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAFBF221FDE;
	Tue, 26 Aug 2025 15:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JDGEc25v";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fLKa+AzN";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JDGEc25v";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fLKa+AzN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BBE21D3C9
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 15:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756220539; cv=none; b=FnEst/YQQdFhEpCmwF/v+UZPpyu7o+kUIGabvg7J62YyW4TxNLYdixIJXH5QQSvwuGan69RVxDzBn5jPEQOPyMfYtSbXoUx8eXHf+6/vnowcXvRpoe/S83VL5peD15Bt7m7zj0GXbxonD52+id7PF8WVMdtsNkclAsAnaCd5dOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756220539; c=relaxed/simple;
	bh=k3q4IJGXIg1xsx6KhZ+5Uos14zt34y0pwkTclbo8zZE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=elDDXyViEuhyxjJwLQ02fMdNARn+FbClwPK2kFsPe2PZNLYnRY/jipPKESDezZMCXWdF/por25DJ/zy3kZggByEM5VXs4U1XTZR0bmFxtGCf6IwFI91ctaOdP/92xGuxpZ2sj5FwiDS/GUYOZWNCT7Ara/7GKNjzPFEu3S5lDHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JDGEc25v; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fLKa+AzN; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JDGEc25v; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fLKa+AzN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5A6751F79E;
	Tue, 26 Aug 2025 15:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756220535; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p1IlqAHsKccOQM/TV3kup+WmT3u/tu76lg3adcsS0QM=;
	b=JDGEc25v2MrcNLhbTzgtf8SPL3CEltPVKwH/1W+XgbfuzLbGZeMnvhYfuQscEveg2wm/4X
	qV58BlCSPIqDM/YvfaMg0B9y7+oU8iHK1xB9XnHZulkHsL6sW0Rxpzw620WXIUJM21MIKA
	4+rGfKRc3tO4LdA87ByijgRQVB0CctI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756220535;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p1IlqAHsKccOQM/TV3kup+WmT3u/tu76lg3adcsS0QM=;
	b=fLKa+AzN8jaJefnoNGeNcy6H3lMdyc543Z3B3eUDELl2acvP/6jypKP4ZvIiAT2dCslDe5
	lhs4MPGp/5N5pmBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756220535; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p1IlqAHsKccOQM/TV3kup+WmT3u/tu76lg3adcsS0QM=;
	b=JDGEc25v2MrcNLhbTzgtf8SPL3CEltPVKwH/1W+XgbfuzLbGZeMnvhYfuQscEveg2wm/4X
	qV58BlCSPIqDM/YvfaMg0B9y7+oU8iHK1xB9XnHZulkHsL6sW0Rxpzw620WXIUJM21MIKA
	4+rGfKRc3tO4LdA87ByijgRQVB0CctI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756220535;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p1IlqAHsKccOQM/TV3kup+WmT3u/tu76lg3adcsS0QM=;
	b=fLKa+AzN8jaJefnoNGeNcy6H3lMdyc543Z3B3eUDELl2acvP/6jypKP4ZvIiAT2dCslDe5
	lhs4MPGp/5N5pmBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 091D313A31;
	Tue, 26 Aug 2025 15:02:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id foFDNXbMrWjWUQAAD6G6ig
	(envelope-from <krisman@suse.de>); Tue, 26 Aug 2025 15:02:14 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Amir Goldstein <amir73il@gmail.com>
Cc: =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>,  Miklos Szeredi
 <miklos@szeredi.hu>,  Theodore Tso <tytso@mit.edu>,
  linux-unionfs@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-fsdevel@vger.kernel.org,  Alexander Viro <viro@zeniv.linux.org.uk>,
  Christian Brauner <brauner@kernel.org>,  Jan Kara <jack@suse.cz>,
  kernel-dev@igalia.com
Subject: Re: [PATCH v6 4/9] ovl: Create ovl_casefold() to support casefolded
 strncmp()
In-Reply-To: <CAOQ4uxhw26Tf6LMP1fkH=bTD_LXEkUJ1soWwW+BrgoePsuzVww@mail.gmail.com>
	(Amir Goldstein's message of "Tue, 26 Aug 2025 09:19:32 +0200")
Organization: SUSE
References: <20250822-tonyk-overlayfs-v6-0-8b6e9e604fa2@igalia.com>
	<20250822-tonyk-overlayfs-v6-4-8b6e9e604fa2@igalia.com>
	<875xeb64ks.fsf@mailhost.krisman.be>
	<CAOQ4uxiHQx=_d_22RBUvr9FSbtF-+DJMnoRi0QnODXRR=c47gA@mail.gmail.com>
	<CAOQ4uxgaefXzkjpHgjL0AZrOn_ZMP=b1TKp-KDh53q-4borUZw@mail.gmail.com>
	<871poz4983.fsf@mailhost.krisman.be>
	<87plci3lxw.fsf@mailhost.krisman.be>
	<CAOQ4uxhw26Tf6LMP1fkH=bTD_LXEkUJ1soWwW+BrgoePsuzVww@mail.gmail.com>
Date: Tue, 26 Aug 2025 11:02:09 -0400
Message-ID: <87ldn62kjy.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	HAS_ORG_HEADER(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Flag: NO
X-Spam-Score: -4.30

Amir Goldstein <amir73il@gmail.com> writes:

> On Tue, Aug 26, 2025 at 3:34=E2=80=AFAM Gabriel Krisman Bertazi <krisman@=
suse.de> wrote:
>
>>
>> I was thinking again about this and I suspect I misunderstood your
>> question.  let me try to answer it again:
>>
>> Ext4, f2fs and tmpfs all allow invalid utf8-encoded strings in a
>> casefolded directory when running on non-strict-mode.  They are treated
>> as non-encoded byte-sequences, as if they were seen on a case-Sensitive
>> directory.  They can't collide with other filenames because they
>> basically "fold" to themselves.
>>
>> Now I suspect there is another problem with this series: I don't see how
>> it implements the semantics of strict mode.  What happens if upper and
>> lower are in strict mode (which is valid, same encoding_flags) but there
>> is an invalid name in the lower?  overlayfs should reject the dentry,
>> because any attempt to create it to the upper will fail.
>
> Ok, so IIUC, one issue is that return value from ovl_casefold() should be
> conditional to the sb encoding_flags, which was inherited from the
> layers.

yes, unless you reject mounting strict_mode filesystems, which the best
course of action, in my opinion.

>
> Again, *IF* I understand correctly, then strict mode ext4 will not allow
> creating an invalid-encoded name, but will strict mode ext4 allow
> it as a valid lookup result?

strict mode ext4 will not allow creating an invalid-encoded name. And
even lookups will fail.  Because the kernel can't casefold it, it will
assume the dirent is broken and ignore it during lookup.

(I just noticed the dirent is ignored and the error is not propagated in
ext4_match.  That needs improvement.).

>>
>> Andr=C3=A9, did you consider this scenario?
>
> In general, as I have told Andre from v1, please stick to the most common
> configs that people actually need.
>
> We do NOT need to support every possible combination of layers configurat=
ions.
>
> This is why we went with supporting all-or-nothing configs for casefolder=
 dirs.
> Because it is simpler for overlayfs semantics and good enough for what
> users need.
>
> So my question is to you both: do users actually use strict mode for
> wine and such?
> Because if they don't I would rather support the default mode only
> (enforced on mount)
> and add support for strict mode later per actual users demand.

I doubt we care.  strict mode is a restricted version of casefolding
support with minor advantages.  Basically, with it, you can trust that
if you update the unicode version, there won't be any behavior change in
casefolding due to newly assigned code-points.  For Wine, that is
irrelevant.

You can very well reject strict mode and be done with it.

>
>> You can test by creating a file
>> with an invalid-encoded name in a casefolded directory of a
>> non-strict-mode filesystem and then flip the strict-mode flag in the
>> superblock.  I can give it a try tomorrow too.
>
> Can the sb flags be flipped in runtime? while mounted?
> I suppose you are talking about an offline change that requires
> re-mount of overlayfs and re-validate the same encoding flags on all laye=
rs?

No, it is set at mkfs-time.  The scenario I'm describing is a
filesystem corruption, where a filename has invalid characters but the
disk is in strict mode.  What I proposed is a way to test this by
crafting an image.

--=20
Gabriel Krisman Bertazi

