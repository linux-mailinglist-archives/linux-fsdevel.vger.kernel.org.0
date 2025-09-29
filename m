Return-Path: <linux-fsdevel+bounces-63039-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60222BA9E98
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 18:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76B4B3A8F92
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 16:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235D530C0FF;
	Mon, 29 Sep 2025 15:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ovjASZvC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="h1ZO/97W";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ovjASZvC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="h1ZO/97W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AE330C0F6
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Sep 2025 15:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759161598; cv=none; b=PzGMXeyoSn6ZU2cDkOShKDzy4cd31NIt3rZTR4Jpo99Q2L373zE3SmaYsb2pyIyIZT2+x+3s1WoHcptMeQTveu9Lj537EDjilTZY+rpDaOqADC1l9scEjJhvsfTGPwM2wibJqBhefUjPJaqj4I11VjmehSTl1asZYydA6Zp2lAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759161598; c=relaxed/simple;
	bh=xspjjuWzhBgp03yFQoal8leQdwed4iFcgvVqdAK5hp0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pgi6cUsGY1jfbLPBPmWzxh5anGtuAMcLxNtPUPWjaX6VHPtffPN+8/+yhd7ww4fY21no26yVWknRIfk+BMztvdnFgBxvJaPzDZ0mPzRHsSxM8itgfxhsQZfXQDz3ExQmsJlJPXClaHeHeaaKvLlWHftlo6eBnJKBUpgzZO+hrx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ovjASZvC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=h1ZO/97W; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ovjASZvC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=h1ZO/97W; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A706D206E1;
	Mon, 29 Sep 2025 15:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759161594; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=t55lpxNdoQmpRr3XCfrJ0Y0oTjekdjN8E8AhPhHjXCc=;
	b=ovjASZvCxZtLU6NIv5YrTD6g1HuQDhWUOfZN15lincbYS4vAPiShrs7/PfiQ7Q7Po7KIEt
	VvbkzVY8BMRM4D5aJllvDfkZP9E3pcPqt6vZHx2R/S9UDrm+Pojy3YWKEQRoNku/g3+6R3
	P74GYG9f6rvIV2lbXORwhQi/BZXKTDs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759161594;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=t55lpxNdoQmpRr3XCfrJ0Y0oTjekdjN8E8AhPhHjXCc=;
	b=h1ZO/97WyQSG14YyzwaqkeBHZK1QLSWerBUoSCBoBJU5Zqi/pvpBIPcXl2pir8A3u4gefE
	7DbpCAUYc5rJtmCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759161594; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=t55lpxNdoQmpRr3XCfrJ0Y0oTjekdjN8E8AhPhHjXCc=;
	b=ovjASZvCxZtLU6NIv5YrTD6g1HuQDhWUOfZN15lincbYS4vAPiShrs7/PfiQ7Q7Po7KIEt
	VvbkzVY8BMRM4D5aJllvDfkZP9E3pcPqt6vZHx2R/S9UDrm+Pojy3YWKEQRoNku/g3+6R3
	P74GYG9f6rvIV2lbXORwhQi/BZXKTDs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759161594;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=t55lpxNdoQmpRr3XCfrJ0Y0oTjekdjN8E8AhPhHjXCc=;
	b=h1ZO/97WyQSG14YyzwaqkeBHZK1QLSWerBUoSCBoBJU5Zqi/pvpBIPcXl2pir8A3u4gefE
	7DbpCAUYc5rJtmCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8DAB213A21;
	Mon, 29 Sep 2025 15:59:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PqOOIvqs2mjNTgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 29 Sep 2025 15:59:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 33012A0ACB; Mon, 29 Sep 2025 17:59:54 +0200 (CEST)
Date: Mon, 29 Sep 2025 17:59:54 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org
Subject: EXPORT_FH_FID not working properly?
Message-ID: <lhqfyklsgrcabcgduwmycv26ljt4u4ttj2jzf24rjf2rdvbjmn@ei4jfb66h7yg>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUBJECT_ENDS_QUESTION(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -2.80

Hello Amir!

I was looking into exportfs_can_encode_fh() today and after commit
5402c4d4d200 ("exportfs: require ->fh_to_parent() to encode connectable
file handles") we immediately return false if the filesystem has no
export_operations. However for the case with EXPORT_FH_FID I suppose we
want to allow !nop case as well and use the default encoding function? At
least that's what all the other code seems to be doing... Am I missing
something?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

