Return-Path: <linux-fsdevel+bounces-25817-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE865950D19
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 21:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 601F3B286CF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 19:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F1A1A4F13;
	Tue, 13 Aug 2024 19:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NQ5CaaBR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eUlLWPNz";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fipF3S6l";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6i5+tYsn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CD419D089;
	Tue, 13 Aug 2024 19:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723577127; cv=none; b=S4GswYsxfaoTUlMhCveeUwPqPRoXHSMvFs6Mj317IS9lSXz02RCXyb7dsdwcvk0HUbNn5EkWk3y+tzAzX4t6USDd8Ra5Il5cm6fcpVW1e2Go8jVU2JAuHusID4BHgCyPfStVyUK3IVejwYPsyySU/m+HCPzjQmzK6irvfu/BZw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723577127; c=relaxed/simple;
	bh=Mt6cj9PlVfv2J3ubnFH9Qln42zBuj+jvEHFHpAtHF1E=;
	h=From:To:Cc:Subject:In-Reply-To:Date:References:Message-Id:
	 MIME-Version:Content-Type; b=PxJiHAhWFYmjM7s1xPSco4VghftqHMoOabFStjNNNAYgoJCmvSJBcw2YX6DkCsZtV4fxoIRIASFedP14AtWskAwZFNVN7nKJrAofgCu2npP+PFW/wUXEElXxT2uuCylIT6e5tfO1x6UsWknBn2sZmha7HZhV3z6bHERXqxok55I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NQ5CaaBR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=eUlLWPNz; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fipF3S6l; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6i5+tYsn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E0A812271D;
	Tue, 13 Aug 2024 19:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723577123; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ugKjNhRMNgwXJ5EiAXRajci6DMtc6jQk92sVFu7H7iM=;
	b=NQ5CaaBRddWSnMj4ZrG6aoAM08iZw7wD44tyM7DnCEmnWDpJxeP1j66fbCfsadIUIGDYal
	XxnD77id68+gHQop1R27V4bRkahiAUgvuyQ24aMqnzKAmK7XA8GVqnyiX2KWpLWyaDd2wm
	p8TknCMuVzyKnUZ4xjkhdgn9gARhJso=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723577123;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ugKjNhRMNgwXJ5EiAXRajci6DMtc6jQk92sVFu7H7iM=;
	b=eUlLWPNz2tljd0J/s2l2TeE2zpowpXOn9ntXbcSEmyMymjK20a+kB8DbT6NR5nVuXv1GKP
	XcdGEgWsrmwY3JBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723577121; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ugKjNhRMNgwXJ5EiAXRajci6DMtc6jQk92sVFu7H7iM=;
	b=fipF3S6lPpRW5BttneiBdn0b1F9NpjtIWSH5au0LrNgAQ4cecqZN0MmrqfC/SV9ZfyezG8
	Qy8MoyDokytUSJnduUPvjib3wgcfvVey08Rorg6C3Z+pGAAJtzUzv/EAmMnX8C8xK6/NQj
	XbSgyWiIilAolivj5cIL4GJuuMbrvAE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723577121;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ugKjNhRMNgwXJ5EiAXRajci6DMtc6jQk92sVFu7H7iM=;
	b=6i5+tYsnvwloc3G2zIj6gi9Rul5fUQ2n0bRG3ZrefsCnqOXYSunlSsY2DKpf0or+HWOSsf
	tQkpFJ7c4TQh+LCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A4F8A136A2;
	Tue, 13 Aug 2024 19:25:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6Ww7IiGzu2ZGeQAAD6G6ig
	(envelope-from <krisman@suse.de>); Tue, 13 Aug 2024 19:25:21 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] unicode: constify utf8 data table
In-Reply-To: <20240809-unicode-const-v1-1-69968a258092@weissschuh.net>
Date: Tue, 13 Aug 2024 15:22:59 -0400
References: <20240809-unicode-const-v1-1-69968a258092@weissschuh.net>
Message-Id: <172357697992.2513606.16354340416648362105.b4-ty@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.989];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 


On Fri, 09 Aug 2024 17:38:53 +0200, Thomas Wei=C3=9Fschuh wrote:
> All users already handle the table as const data.
> Move the table itself into .rodata to guard against accidental or
> malicious modifications.

Applied, thanks!

[1/1] unicode: constify utf8 data table
      commit: 43bf9d9755bd21970d8382dc88f071f74fc18fbf

Best regards,
--=20
Gabriel Krisman Bertazi

