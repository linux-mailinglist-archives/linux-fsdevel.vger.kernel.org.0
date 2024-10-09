Return-Path: <linux-fsdevel+bounces-31458-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 428FB997029
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 17:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC37D1F22C9B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 15:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087D11E1A0A;
	Wed,  9 Oct 2024 15:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="d64vjYsy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IbihkSJF";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="d64vjYsy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IbihkSJF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82931922FD
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Oct 2024 15:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728487835; cv=none; b=sQsasrYbi+iafWA1V4vpHb29bJjCfup7DaRvxZY3ZuiVb8GnGYbAlJ0qTBNso8kaGXnEmrZqrRLvLOyoQT2xYSdH+kbQUddgIB/1AJDJk7QTTnW00NwxvJiHZpvXDg/eni5YSwOd/uZjem6NzheXG0EKVRG/Wum33Ci+uzKT96s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728487835; c=relaxed/simple;
	bh=1LA4aPxEryGaqtd3idxbDHS6P8hhsYis1GI72X4dAcI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QHqKELSJPq1kVX5dK4K08flMjMd8+qN3Fgor5U/x5T2CduKcOqkMWUH+a6mdfmbIs5GYT94TzUdT28v0KqCbps7c6VEXyhuzLK0F6jJExSLssDsJByXB6I5DSbOEc+LxZmR8FxtcexE5yHNzsVBDAIAtvGcoVGq5W00TLbKkFlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=d64vjYsy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IbihkSJF; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=d64vjYsy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IbihkSJF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7BE1221F69;
	Wed,  9 Oct 2024 15:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728487826; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=3DGn2DV4ia6YFR+RFKUPtt8Jr6qpn7AD2mDVSBuc2Ac=;
	b=d64vjYsyLcuo1VjeBX05QEvGdqYDarwMJ/5pp/XIrjBO/1aMlLhs34IOEe54bWNFan3FkO
	ruBHYq/+NKfcE9hzHO+5D6xnH58YAebnSrXGXrZdO789BoeY4fJfjpN6GkN1QqR0RW9f8I
	rGAtJAujnx1D3q1H12iWpabi4gGaxL4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728487826;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=3DGn2DV4ia6YFR+RFKUPtt8Jr6qpn7AD2mDVSBuc2Ac=;
	b=IbihkSJFeVlT8r5E4ps0El6crjqnEvCYuxvt/0zFw+L5G15i0SukJTT3uf0mwLaTzwSXpi
	rO6luEMdq+eT2eBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728487826; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=3DGn2DV4ia6YFR+RFKUPtt8Jr6qpn7AD2mDVSBuc2Ac=;
	b=d64vjYsyLcuo1VjeBX05QEvGdqYDarwMJ/5pp/XIrjBO/1aMlLhs34IOEe54bWNFan3FkO
	ruBHYq/+NKfcE9hzHO+5D6xnH58YAebnSrXGXrZdO789BoeY4fJfjpN6GkN1QqR0RW9f8I
	rGAtJAujnx1D3q1H12iWpabi4gGaxL4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728487826;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=3DGn2DV4ia6YFR+RFKUPtt8Jr6qpn7AD2mDVSBuc2Ac=;
	b=IbihkSJFeVlT8r5E4ps0El6crjqnEvCYuxvt/0zFw+L5G15i0SukJTT3uf0mwLaTzwSXpi
	rO6luEMdq+eT2eBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 70B8713A58;
	Wed,  9 Oct 2024 15:30:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 15l8G5KhBmfoWAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 09 Oct 2024 15:30:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 287FDA0896; Wed,  9 Oct 2024 17:30:22 +0200 (CEST)
Date: Wed, 9 Oct 2024 17:30:22 +0200
From: Jan Kara <jack@suse.cz>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: New Defects reported by Coverity Scan for linux-next weekly scan
 (fwd)
Message-ID: <20241009153022.5uyp6aku2kcfeexp@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

I've got this complaint from coverity:

----- Forwarded message from scan-admin@coverity.com -----

________________________________________________________________________________________________________
*** CID 1600337:    (UNINIT)
/fs/attr.c: 311 in setattr_copy_mgtime()
305     	else if (ia_valid & ATTR_ATIME)
306     		inode_set_atime_to_ts(inode, now);
307     
308     	if (ia_valid & ATTR_MTIME_SET)
309     		inode_set_mtime_to_ts(inode, attr->ia_mtime);
310     	else if (ia_valid & ATTR_MTIME)
>>>     CID 1600337:    (UNINIT)
>>>     Using uninitialized value "now" when calling "inode_set_mtime_to_ts".
311     		inode_set_mtime_to_ts(inode, now);
312     }
313     
314     /**
315      * setattr_copy - copy simple metadata updates into the generic inode
316      * @idmap:	idmap of the mount the inode was found from
/fs/attr.c: 306 in setattr_copy_mgtime()
300     		WARN_ON_ONCE(ia_valid & ATTR_MTIME);
301     	}
302     
303     	if (ia_valid & ATTR_ATIME_SET)
304     		inode_set_atime_to_ts(inode, attr->ia_atime);
305     	else if (ia_valid & ATTR_ATIME)
>>>     CID 1600337:    (UNINIT)
>>>     Using uninitialized value "now" when calling "inode_set_atime_to_ts".
306     		inode_set_atime_to_ts(inode, now);
307     
308     	if (ia_valid & ATTR_MTIME_SET)
309     		inode_set_mtime_to_ts(inode, attr->ia_mtime);
310     	else if (ia_valid & ATTR_MTIME)
311     		inode_set_mtime_to_ts(inode, now);

Now we WARN if ATTR_MTIME is set without ATTR_CTIME but still it might be
good to place some sane value in 'now' so that we don't set the timestamp
to garbage and more importantly setting ATTR_ATIME without ATTR_CTIME looks
as a possible thing?

								Honza


-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

