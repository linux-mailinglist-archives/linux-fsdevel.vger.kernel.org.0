Return-Path: <linux-fsdevel+bounces-8266-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B48831DDD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 17:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97FEE1F238D1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 16:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800942C85A;
	Thu, 18 Jan 2024 16:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MJIk05eu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bGo0VDTa";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MJIk05eu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bGo0VDTa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DC32C855
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jan 2024 16:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705596701; cv=none; b=nQpzaZnew9nWq7iHkroW7ojpTipKw3wUHwYgn5JxX2LU9RiIWrOIcE/v60IrTCcj58K2L05F501JXVxggRYv8kXR8C55jcItu9Yi20S+8mAuRnefgY932oswznyQXnHkiIjm4hUMX7vUNs1xssGm7we90Q53xbjNyZxn4knpcb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705596701; c=relaxed/simple;
	bh=v3+suleJmo1Q2wrZkm1g/deCVdl7lYLoU5O6GD+9zl0=;
	h=Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:User-Agent:MIME-Version:Content-Type:
	 X-Spamd-Result:X-Rspamd-Server:X-Rspamd-Queue-Id:X-Spam-Level:
	 X-Spam-Score:X-Spam-Flag; b=panSpdgbwxlJDBTMTwb6T8UCsxb9+J6qUw6+L5SWSiovnIy9Wp4RBUdM6yxjyW/5xjowEZPJffGzCQ0oeIxQtzGX35QbeNzSyg/czs4Pwa4pPi6pBuVyXgmbNZ2yPymouIY6wTcPXAVBmsIoMP7TAxYsyT2L9XDaKIc+jB0BKOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MJIk05eu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bGo0VDTa; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MJIk05eu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bGo0VDTa; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 433FD1F798;
	Thu, 18 Jan 2024 16:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705596696; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=86NGcE2QzsoPSKpgW7wxGnxXuC4kPvVufiXRwf1RnWU=;
	b=MJIk05eu8tFXCwp982AhZWctS1ZoqwzJq/EcTxOIhjcUkJfMSuxmN2cZbnfYAZ+L1HD1hK
	8Bc5yebir/6ZgMg188+x7W68YuxkTJK5i4BE+22J4pL6vTP+jnRzWvOM//jN8WJ3PTBtMS
	wuSOc1edqnBDAEB2DEqMAiwfVSt4+l4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705596696;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=86NGcE2QzsoPSKpgW7wxGnxXuC4kPvVufiXRwf1RnWU=;
	b=bGo0VDTavjybg86ux27BfXyP1HG/sg1YgAUaeyeIpla1vrr52bE3LUTB55NgyQUOohoAUw
	GMMcq6WQPCEggPCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705596696; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=86NGcE2QzsoPSKpgW7wxGnxXuC4kPvVufiXRwf1RnWU=;
	b=MJIk05eu8tFXCwp982AhZWctS1ZoqwzJq/EcTxOIhjcUkJfMSuxmN2cZbnfYAZ+L1HD1hK
	8Bc5yebir/6ZgMg188+x7W68YuxkTJK5i4BE+22J4pL6vTP+jnRzWvOM//jN8WJ3PTBtMS
	wuSOc1edqnBDAEB2DEqMAiwfVSt4+l4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705596696;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=86NGcE2QzsoPSKpgW7wxGnxXuC4kPvVufiXRwf1RnWU=;
	b=bGo0VDTavjybg86ux27BfXyP1HG/sg1YgAUaeyeIpla1vrr52bE3LUTB55NgyQUOohoAUw
	GMMcq6WQPCEggPCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BA3E4136F5;
	Thu, 18 Jan 2024 16:51:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TUcnIBdXqWXCSgAAD6G6ig
	(envelope-from <krisman@suse.de>); Thu, 18 Jan 2024 16:51:35 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: tytso@mit.edu,  linux-fsdevel@vger.kernel.org,  viro@zeniv.linux.org.uk,
  jaegeuk@kernel.org,  Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2] libfs: Attempt exact-match comparison first during
 casefold lookup
In-Reply-To: <8734uufy1o.fsf@mailhost.krisman.be> (Gabriel Krisman Bertazi's
	message of "Thu, 18 Jan 2024 12:42:27 -0300")
References: <20240118004618.19707-1-krisman@suse.de>
	<20240118035053.GB1103@sol.localdomain>
	<8734uufy1o.fsf@mailhost.krisman.be>
Date: Thu, 18 Jan 2024 13:51:33 -0300
Message-ID: <87y1cmega2.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=MJIk05eu;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=bGo0VDTa
X-Spamd-Result: default: False [-6.13 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_HI(-3.50)[suse.de:dkim];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.32)[96.81%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 433FD1F798
X-Spam-Level: 
X-Spam-Score: -6.13
X-Spam-Flag: NO

Gabriel Krisman Bertazi <krisman@suse.de> writes:

> can't change since it's already a copy of the dentry->d_name pointer;

dentry->d_name.name

-- 
Gabriel Krisman Bertazi

