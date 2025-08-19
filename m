Return-Path: <linux-fsdevel+bounces-58223-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8232B2B544
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 02:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BCB3622BE0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 00:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D16F72626;
	Tue, 19 Aug 2025 00:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="INQ2OUaW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tKEzmHL1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="INQ2OUaW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tKEzmHL1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77BC22615
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 Aug 2025 00:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755562816; cv=none; b=I/vkebip0a/DLh5SPQfsY/iJP97dyRIO/QYFhXCQLhYx9TCBY8F2CXTF1Vwj78HgbEmY8Hmu2cfJdAV2ylXJaDBftz/4b9JSs8wialLX5i/QrMVsFi/2cOn2gGtE3WZ/MkdEqYN2OiDBVFiWMgY92IuSL6yFPbLnDEC94si5vUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755562816; c=relaxed/simple;
	bh=u+ZAMVWyhlz6/AanQOIgW90cNKxCA0zaG4nB7JIF2uY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vadi3H1FN1BqOcZ2ClLXL0v4hFbtL9BBHWUvtxaraA7+QuQlSyxXlBWgvsra1XH+Q8TiOTIVzEsrihJOVQAAaGkg7ZBAvdbXZXqxkBAbTMcjsiK0FNmVhJnlHIs00fa4dIowCdN22rUENWoIDPZ1CXoMFYMuR6uTOdMgPa9k6yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=INQ2OUaW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tKEzmHL1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=INQ2OUaW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tKEzmHL1; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 060B31F44E;
	Tue, 19 Aug 2025 00:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755562813; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UKmVtjk9XUmdGA58YJ6Cncs9NNP8aiC9zJjqXevlQ6o=;
	b=INQ2OUaW00mC8Gfm3HJo4cwNpf1j0UncWRJLgTDXUSfl2M5/ZH4cy6+lZj+Vb6FzXeE6vB
	xqPJjcbEgHsYuFYrCFsTNOD/uuvJkOElx9R+XlyjlIVCeq1aoM2ymYB5Af91E12DeoKLo6
	Lk5TkuDjx/7OfJfWmVWjeTHiy277EPs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755562813;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UKmVtjk9XUmdGA58YJ6Cncs9NNP8aiC9zJjqXevlQ6o=;
	b=tKEzmHL1aKbRe+jqEaFbENMPa+NdkMAtG1slsAJggAh2+tpP8w1xAKzW3Hr1/1slldghE5
	aaLxPrsxJGW1WrCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=INQ2OUaW;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=tKEzmHL1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755562813; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UKmVtjk9XUmdGA58YJ6Cncs9NNP8aiC9zJjqXevlQ6o=;
	b=INQ2OUaW00mC8Gfm3HJo4cwNpf1j0UncWRJLgTDXUSfl2M5/ZH4cy6+lZj+Vb6FzXeE6vB
	xqPJjcbEgHsYuFYrCFsTNOD/uuvJkOElx9R+XlyjlIVCeq1aoM2ymYB5Af91E12DeoKLo6
	Lk5TkuDjx/7OfJfWmVWjeTHiy277EPs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755562813;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UKmVtjk9XUmdGA58YJ6Cncs9NNP8aiC9zJjqXevlQ6o=;
	b=tKEzmHL1aKbRe+jqEaFbENMPa+NdkMAtG1slsAJggAh2+tpP8w1xAKzW3Hr1/1slldghE5
	aaLxPrsxJGW1WrCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 411241368C;
	Tue, 19 Aug 2025 00:20:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0IehOjrDo2hZOwAAD6G6ig
	(envelope-from <ddiss@suse.de>); Tue, 19 Aug 2025 00:20:10 +0000
Date: Tue, 19 Aug 2025 10:20:05 +1000
From: David Disseldorp <ddiss@suse.de>
To: Nicolas Schier <nsc@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-next@vger.kernel.org
Subject: Re: [PATCH v2 3/7] gen_init_cpio: attempt copy_file_range for file
 data
Message-ID: <20250819102005.2fe940a1.ddiss@suse.de>
In-Reply-To: <aKNzpz3ibFDQwdSQ@levanger>
References: <20250814054818.7266-1-ddiss@suse.de>
	<20250814054818.7266-4-ddiss@suse.de>
	<aKNzpz3ibFDQwdSQ@levanger>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 060B31F44E
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -3.51

On Mon, 18 Aug 2025 20:40:39 +0200, Nicolas Schier wrote:
...
> Thanks.  I like introducing copy_file_range() here, it reduces the cpio
> generation time on my system by a about 30% on a btrfs filesystem.
> May cpio_mkfile_csum() now the slowest part?

cpio checksums are slow, but I don't think it's worth optimizing for at
this stage: they're optional (-c) and support for them was only recently
added (800c24dc34b93). Besides, there are better ways to guarantee
initramfs integrity.

Thanks, David

