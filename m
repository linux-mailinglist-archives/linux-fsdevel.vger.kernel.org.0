Return-Path: <linux-fsdevel+bounces-61273-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2E5B56E41
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 04:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 104343B7CEF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 02:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52DF4220F5C;
	Mon, 15 Sep 2025 02:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wv/WAike";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ThFA7BNM";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wv/WAike";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ThFA7BNM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA512F2E
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 02:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757902937; cv=none; b=mvjLFtUyjIy8p6Gvmqe0Jbnu6DlV9Ri9dR4+JJ0kYvjwA26cac+hWDzdb/psHFYX7oeQ6WlN+DJ1KZbXBtVUPkZRBhCJjgdCT+VVjuBCEubnqm9G5XZ5o2uE+lhH3gL2rfRCJaNdpAzuGnGD50RuRdBjIlotbRWbzy5/0QLssmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757902937; c=relaxed/simple;
	bh=s2ix170QkLxa+s/sK6kD7u7AVhm+2DWw8W7p3aA+zpc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BjUL4ADz5cg7uhKDH6uUhJ71eQaBATeVBdyUOgJXkN+q4P8qQ81os9VKysL3mGbu3Wav4SGOG1TDKwchIPVjNvaGeltQ37utTZz5coEburhwV+9zmmOHJWEo0CjOQqUV/GAKsm3D2QfvTpmCU970b3DSIyLZKsEzRMgkbGavXys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wv/WAike; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ThFA7BNM; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wv/WAike; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ThFA7BNM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1947F21E3E;
	Mon, 15 Sep 2025 02:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757902928; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZwzU21VPOFmHOqlHgZPgrVDoZUTFXgYZMsVOu9oqEDM=;
	b=wv/WAikeIzXvfGA1f4U8WsZTTj/rYNwmAs10CgRJ1UzVvG4wuo9eQciBBcrbxPVWPVliLJ
	6qBpSwvJPyUU2L1y8wnVxWU0krE5xMwQcnobbm1v6wzPSIrJ6ef2gryORM37JKkQPPhp4e
	dGN82Pae1YPjkDvqrqh125vencWjISo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757902928;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZwzU21VPOFmHOqlHgZPgrVDoZUTFXgYZMsVOu9oqEDM=;
	b=ThFA7BNMoBQlC7gYqGhO/GSpkgEOW5OgwKdC11ORRqZ1HZsfd44U855HRw2F4MHo7I2y8o
	B11QvHUb+RbV4/DA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="wv/WAike";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ThFA7BNM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757902928; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZwzU21VPOFmHOqlHgZPgrVDoZUTFXgYZMsVOu9oqEDM=;
	b=wv/WAikeIzXvfGA1f4U8WsZTTj/rYNwmAs10CgRJ1UzVvG4wuo9eQciBBcrbxPVWPVliLJ
	6qBpSwvJPyUU2L1y8wnVxWU0krE5xMwQcnobbm1v6wzPSIrJ6ef2gryORM37JKkQPPhp4e
	dGN82Pae1YPjkDvqrqh125vencWjISo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757902928;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZwzU21VPOFmHOqlHgZPgrVDoZUTFXgYZMsVOu9oqEDM=;
	b=ThFA7BNMoBQlC7gYqGhO/GSpkgEOW5OgwKdC11ORRqZ1HZsfd44U855HRw2F4MHo7I2y8o
	B11QvHUb+RbV4/DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B1A0613782;
	Mon, 15 Sep 2025 02:22:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id f8QrGk14x2gEBQAAD6G6ig
	(envelope-from <ddiss@suse.de>); Mon, 15 Sep 2025 02:22:05 +0000
Date: Mon, 15 Sep 2025 12:21:46 +1000
From: David Disseldorp <ddiss@suse.de>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] initrd: Fix logged Minix/Ext2 block numbers in
 identify_ramdisk_image()
Message-ID: <20250915122146.56f66eb2.ddiss@suse.de>
In-Reply-To: <20250913103959.1788193-1-thorsten.blum@linux.dev>
References: <20250913103959.1788193-1-thorsten.blum@linux.dev>
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
X-Rspamd-Queue-Id: 1947F21E3E
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
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -3.51

Hi Thorsten,

On Sat, 13 Sep 2025 12:39:54 +0200, Thorsten Blum wrote:

> Both Minix and Ext2 filesystems are located at 'start_block + 1'. Update
> the log messages to report the correct block numbers.

I don't think this change is worthwhile. The offset of the superblock
within the filesystem image is an implementation detail.

> Replace printk(KERN_NOTICE) with pr_notice() to avoid checkpatch
> warnings.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

Nothing is being fixed here.

