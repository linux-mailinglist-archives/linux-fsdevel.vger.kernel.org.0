Return-Path: <linux-fsdevel+bounces-53663-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4B4AF5AF8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 16:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41FAB3B908A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 14:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9EF82F5302;
	Wed,  2 Jul 2025 14:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wLSloOXy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Tw93rIRJ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vI0EpeuB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YnR8PVsU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E094728A725
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Jul 2025 14:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751466032; cv=none; b=ORymUe9brlZKYKza+XsxPfGfCcFkp79Soj8ZDzWJ68pKe7pPvG0ycEYTyrGJLecEMeBkzEoz0fjntfSgcp3idloIL+F+SUePWy725wiWS9MICRScorMVu9HO0BxmHx2I1kVPlZzwTUpMlKAxC9YTnJOZy8Awc7eMHwIXMSZy4IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751466032; c=relaxed/simple;
	bh=avnRLKakTmibTGU63hfRD4q6SIXreBXAHQdAGo9SCpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AfqjhE1sXuGHo8HJuoAc2hV0ah0Z+RO8qCrQSA+wviq0JO1ZUOlpy5VOe6KRSH1wo2kUF1xYgKyCJc+lN7D5DXlhy538wMgP0N3I8Ck8YlyuxFR+arn07prLLDbE6cSRf8JOCsmYg6DiZSBxbyD2SqQkdYuEED6NbWpqzLEKQ/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wLSloOXy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Tw93rIRJ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vI0EpeuB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YnR8PVsU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EAD721F38D;
	Wed,  2 Jul 2025 14:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751466029; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+2NSSFfIrDFk0JWc9gz8bcD7t0dPLi/sMrLX5yogfHw=;
	b=wLSloOXyK5rfDlzwMUnHDy/nICkLlE+sNp6LuKYuEmRT1Y3JKtHB1jEhwDfzCWyZUlzjOk
	WK4ObxmghWXCxYk+J+tl7xhIulA8LHJ4nFuJgkN0DZUEcxAGHYlxVPS3oUA0GctkxG5aRp
	e6+kpb7yxO3ZyXbQmbFlKcDnRA5GRHU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751466029;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+2NSSFfIrDFk0JWc9gz8bcD7t0dPLi/sMrLX5yogfHw=;
	b=Tw93rIRJneVvpujkvzWy1bcXU7dl+YhAc14tZ1IR1ZWp+dBBJDGYQQrSpBbe6GJgaCvzL/
	MwAk8vy/y1CLc3AA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=vI0EpeuB;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=YnR8PVsU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751466027; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+2NSSFfIrDFk0JWc9gz8bcD7t0dPLi/sMrLX5yogfHw=;
	b=vI0EpeuBcQEzl7eL6fjQU8Ok+3MOJseFuW4FJ/CgCYKzs1vty/BsxUWiwaOxfgoMlCC2+5
	gb66kdmS0bTlJEJYhmI1z4egJ0RjXO+N5ePb6WKDjHQFtyBEHJ7G4rF9A2ILaqMVNTfyrL
	g803HoHgXcJDyuIoMMd1Ecz3mwdB3BU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751466027;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+2NSSFfIrDFk0JWc9gz8bcD7t0dPLi/sMrLX5yogfHw=;
	b=YnR8PVsUB256hPoh5fBSysAMk23XVFzbIyzycClk4go0voyQuJy80PZlu8F8nJ4+lJxWf3
	cWoZ5mu1mTxRxpDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AC8DA13A24;
	Wed,  2 Jul 2025 14:20:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4gcfKitAZWgkQwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 02 Jul 2025 14:20:27 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8481BA0A55; Wed,  2 Jul 2025 16:20:21 +0200 (CEST)
Date: Wed, 2 Jul 2025 16:20:21 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, 
	ojaswin@linux.ibm.com, sashal@kernel.org, yi.zhang@huawei.com, libaokun1@huawei.com, 
	yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v3 06/10] ext4: enhance tracepoints during the folios
 writeback
Message-ID: <jxtj25ptoel2l3723i26lxstemmvieejnql4iypinrejm5lvx5@72key7fyl3qi>
References: <20250701130635.4079595-1-yi.zhang@huaweicloud.com>
 <20250701130635.4079595-7-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701130635.4079595-7-yi.zhang@huaweicloud.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,huawei.com:email,suse.com:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: EAD721F38D
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.01

On Tue 01-07-25 21:06:31, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> After mpage_map_and_submit_extent() supports restarting handle if
> credits are insufficient during allocating blocks, it is more likely to
> exit the current mapping iteration and continue to process the current
> processing partially mapped folio again. The existing tracepoints are
> not sufficient to track this situation, so enhance the tracepoints to
> track the writeback position and the return value before and after
> submitting the folios.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

