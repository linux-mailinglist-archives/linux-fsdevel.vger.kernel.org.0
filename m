Return-Path: <linux-fsdevel+bounces-45898-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53CEBA7E5BF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 18:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0358742408A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 16:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FCA207E08;
	Mon,  7 Apr 2025 16:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OTzgXlIW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="InujRGej";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OTzgXlIW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="InujRGej"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FE01F9410
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Apr 2025 16:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744041613; cv=none; b=mTHHxBF5nqygwkmgr/Zf79RTIZfLxhHfKOGSZYF0lzZYN3wVAeFp3ppOYebbe7KRla4G0gDqviwQJHlqdjVqoqaIz85w+KgeiRabyFl9bZ042vxlPyfjo91u+s4aBfRWrmAQpm17D2Z3cA8PqQvZeo9cBnV8y3gdO9sjeo5QuqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744041613; c=relaxed/simple;
	bh=aBUs4O0sDavGZTW63hX5KDIhCcySRxy36aDzzktCYsk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oPh08LELzHKaFPIoRaSMhjB666qwQ8Hk1H73Lj5QTVj6G2bKTMOiM8O3hDm6n3dsmB1Hjp6lcxc7UYOm1rLZb2WYg7Qkny0RNwTylIp6oHzC87cEBRqJVfZk/D7J0V8Sp2uo/HCBeufNAzT8R0pXYzIBM1t6L0G17gzS5ZwGC/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OTzgXlIW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=InujRGej; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OTzgXlIW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=InujRGej; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 03CD12116A;
	Mon,  7 Apr 2025 16:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744041608; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=ePWBNhj7ZkZjjnwv+POf42L4B23CwYw8WEXDT8R1sNc=;
	b=OTzgXlIWtFBIlxKveekQT8vF2PFoBy4rNf2h+D/wtRfu+LvwvvnlSNds7KlJkPoGNSAgs+
	HStlokPSg0HVRAK6jWtOIcbPZHzVnSGYIEaGhv4dJKkLVFwCCK4adpSFH4H7vedvlOCkpx
	P66u0ND760RrDJ+3Jqx4dZab6fFPe+M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744041608;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=ePWBNhj7ZkZjjnwv+POf42L4B23CwYw8WEXDT8R1sNc=;
	b=InujRGejXzPfAG5rErTgV4RVyNQCqJ/I9GPp/BifJoPZlgWYVB5Agh55wS3crQVynArIqs
	KHcAHH18/q2gZWBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=OTzgXlIW;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=InujRGej
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744041608; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=ePWBNhj7ZkZjjnwv+POf42L4B23CwYw8WEXDT8R1sNc=;
	b=OTzgXlIWtFBIlxKveekQT8vF2PFoBy4rNf2h+D/wtRfu+LvwvvnlSNds7KlJkPoGNSAgs+
	HStlokPSg0HVRAK6jWtOIcbPZHzVnSGYIEaGhv4dJKkLVFwCCK4adpSFH4H7vedvlOCkpx
	P66u0ND760RrDJ+3Jqx4dZab6fFPe+M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744041608;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=ePWBNhj7ZkZjjnwv+POf42L4B23CwYw8WEXDT8R1sNc=;
	b=InujRGejXzPfAG5rErTgV4RVyNQCqJ/I9GPp/BifJoPZlgWYVB5Agh55wS3crQVynArIqs
	KHcAHH18/q2gZWBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DB27413A4B;
	Mon,  7 Apr 2025 16:00:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hhwvNYf282fYRwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 07 Apr 2025 16:00:07 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7757DA08D2; Mon,  7 Apr 2025 18:00:07 +0200 (CEST)
Date: Mon, 7 Apr 2025 18:00:07 +0200
From: Jan Kara <jack@suse.cz>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>, mkoutny@suse.cz
Subject: d_path() results in presence of detached mounts
Message-ID: <rxytpo37ld46vclkts457zvwi6qkgwzlh3loavn3lddqxe2cvk@k7lifplt7ay6>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Queue-Id: 03CD12116A
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

Hello!

Recently I've got a question from a user about the following:

# unshare --mount swapon /dev/sda3
# cat /proc/swaps
Filename                                Type            Size            Used            Priority
/sda3                                   partition       2098152         0               -2

Now everything works as expected here AFAICS. When namespace gets created
/dev mount is cloned into it. When swapon exits, the namespace is
destroyed and /dev mount clone is detached (no parent, namespace NULL).
Hence when d_path() crawls the path it stops at the mountpoint root and
exits. There's not much we can do about this but when discussing the
situation internally, Michal proposed that d_path() could append something
like "(detached)" to the path string - similarly to "(deleted)". That could
somewhat reduce the confusion about such paths? What do people think about
this?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

