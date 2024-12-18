Return-Path: <linux-fsdevel+bounces-37731-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B16F9F663B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 13:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB71D189203F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 12:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25661ACEBB;
	Wed, 18 Dec 2024 12:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tm7Y6fw2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="P5i2lU7u";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tm7Y6fw2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="P5i2lU7u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7921791F4
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Dec 2024 12:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734526392; cv=none; b=JO9+soKeEwOaTP5YuhNBIViJtw6sme7Y8hPSZFLbT0HkFwXhIfETdwDec5ZTDcCPpMCf7xrVJc7zU6CXpYbajojX1M16eE6tzcGYTv9aWtANOkyYyOsZ3/4g8VaI7pHH0m3M+mHuK+OT3V7ZSdA2kF74jLr/vxUsAl6qf5pscvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734526392; c=relaxed/simple;
	bh=Eaa8k7GJKd3fijNTugNBAyz+rIWrqhdsvgxjj2G3tR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FB9mMgPVcmTxLcSRBui2dPGT7mVyK7eEB4ooAklJ72fahOpRSOdbYsX9HutoSZcX8BYAVt3HCjSQlQT8c2VfGV/nnP+0ukjTUE9pM9p0Imzl4lQBPgugXE9laSd2mkRx4YYTIgHRVOsxUGrKo4P/6miXOs8qFtOEE2xCLD5yCSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tm7Y6fw2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=P5i2lU7u; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tm7Y6fw2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=P5i2lU7u; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3FF4321108;
	Wed, 18 Dec 2024 12:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734526388; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BZllN5rzKG5elox5aloXeD4tCZHIpVKyOVz3Qryi2Pw=;
	b=tm7Y6fw2nzFNgdTwppmcaruGd+VXKiOlAj25T3vDOEGHFDmAkiUMWy6YJfXIb6ukTmvoqV
	BGfyPF5vWnNoXQBo02obdsE5uztvZdXpEGR7TXgJ+xajBCbwyE4B5uGJ4E0C6Gpp8MYtmA
	mkIUiF0cwI0wxykVDCCrEM+VZfcPCGk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734526388;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BZllN5rzKG5elox5aloXeD4tCZHIpVKyOVz3Qryi2Pw=;
	b=P5i2lU7u+JW3D376j47McbqZvsrMoZvA8EtMeT3Ocuji6x0+mFifCLrzIuRZF5m0B2QX3P
	5OEy0q0/zpTJ7VBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=tm7Y6fw2;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=P5i2lU7u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734526388; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BZllN5rzKG5elox5aloXeD4tCZHIpVKyOVz3Qryi2Pw=;
	b=tm7Y6fw2nzFNgdTwppmcaruGd+VXKiOlAj25T3vDOEGHFDmAkiUMWy6YJfXIb6ukTmvoqV
	BGfyPF5vWnNoXQBo02obdsE5uztvZdXpEGR7TXgJ+xajBCbwyE4B5uGJ4E0C6Gpp8MYtmA
	mkIUiF0cwI0wxykVDCCrEM+VZfcPCGk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734526388;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BZllN5rzKG5elox5aloXeD4tCZHIpVKyOVz3Qryi2Pw=;
	b=P5i2lU7u+JW3D376j47McbqZvsrMoZvA8EtMeT3Ocuji6x0+mFifCLrzIuRZF5m0B2QX3P
	5OEy0q0/zpTJ7VBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2B917137CF;
	Wed, 18 Dec 2024 12:53:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MBKhCrTFYmeZBwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 18 Dec 2024 12:53:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id DAE68A0935; Wed, 18 Dec 2024 13:53:03 +0100 (CET)
Date: Wed, 18 Dec 2024 13:53:03 +0100
From: Jan Kara <jack@suse.cz>
To: wangjianjian0 <wangjianjian0@foxmail.com>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: Does sync_bdevs need to issue a PREFLUSH ?
Message-ID: <20241218125303.d2n5hvlzwhpntsvk@quack3>
References: <tencent_44B6652AB436C56D310927AA9EDE3D2F9007@qq.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_44B6652AB436C56D310927AA9EDE3D2F9007@qq.com>
X-Rspamd-Queue-Id: 3FF4321108
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUBJECT_ENDS_QUESTION(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[foxmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[foxmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

On Wed 18-12-24 00:32:24, wangjianjian0 wrote:
> This may be a stupid question,&nbsp; ; -)
> ksys_sync call sync_bdevs to write all block device mapping but it seems it&nbsp; doesn't issue a PREFLUSH request.&nbsp;
> Without it, is it possible to lost data after a poweroff even though we have call sync() ?

Generally, it is the responsibility of individual filesystems to issue
cache flush requests as appropriate in their ->sync_fs() methods. Now if
there's no filesystem on given block device (i.e., the block device is used
directly), then I agree we fail to flush disk caches as a result of
sync(2). On the other hand issuing cache flush unconditionally in
sync_bdevs() will cause a lot of unnecessary cache flushing for mounted
devices or if there were in fact no dirty data. So fixing this in a way
that does not regress common case will be a bit tricky.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

