Return-Path: <linux-fsdevel+bounces-20785-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CA08D7BA1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 08:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CD701C20CC5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 06:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FC22D052;
	Mon,  3 Jun 2024 06:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="r4J9r/CI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cbW6GPde";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Qgx72MX3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="D5HwuqG8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97064282ED;
	Mon,  3 Jun 2024 06:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717396473; cv=none; b=obmWZQjimpKAXO5Lv57Z5jPyjRmwDLieGw/HjqLT2ScZ0zA3bWzFqoA8tMDI8bA3N/9KjjlgVBfSoyctfjbZZUqT6MUiJHPul0a5j/tNcSysK13RKu5SENSNtw/MChdrdy/msZjEWmtYLBQ8FW2HJURbftelIMkyjzlCvNc60qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717396473; c=relaxed/simple;
	bh=K41t5cNRMJLN6M4X4/lP/7QcNoH1790LXPikMhXwLtE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YTEzGN2+dqWPpLx6Bm2Ssoo4cJpudeunb7r7X/qnJLB/hNRFWcjDJRchqYM5RZZvJVyuG3Epy1hFurOyfXdLmLmvnUCUxo0xJJwLSioiqQ4fVKZ5yAPokJxjSCD6eNV7ZrvcDr7CG7hunT6Q7KUyVrgSo2nfBNCdlGXRQ6DtwWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=r4J9r/CI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cbW6GPde; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Qgx72MX3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=D5HwuqG8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DD1C320027;
	Mon,  3 Jun 2024 06:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717396463; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f1NqOg7+SmYpFyjN12bPuX9ZLErrX3Av3tfkALul2/E=;
	b=r4J9r/CIvwHDeheLN2a050SoQfn2+So/cNvfWhw6aOYdKr3A6umYNgaIXzGG42rN3QgAQf
	jLhDPOE/EHjZgBKTV8bLkV3J5Ds/gpwEDKzW9zDyRUoCHKqc1lfbfor2VXhwy7FQalXRH0
	Xo7z5vEQ55wj5XDlDrmCQVI5CA1fiGQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717396463;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f1NqOg7+SmYpFyjN12bPuX9ZLErrX3Av3tfkALul2/E=;
	b=cbW6GPdeTLjLomVb5oiQO142BbmYOiNZ88KSCzXoX1j9lhKTzYMMEWinEXr1YbggaWB8SV
	MWk2kbbOkbWcTIDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Qgx72MX3;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=D5HwuqG8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717396462; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f1NqOg7+SmYpFyjN12bPuX9ZLErrX3Av3tfkALul2/E=;
	b=Qgx72MX3w67PvEi5K8DJutGCGrSl2FCeX35/kfSrHgQCMDUhvqgFzEmhxxKXPE0wTuxmLa
	eyw8IFi8ihMY0flHrSe/QJlT8fTen0xYrvuerObm2F4ETudNhigdyiX9AK6AAGuNd7guaC
	x6uEfbRA6zUITF7Y+yQX7RuvgrS6SfM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717396462;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f1NqOg7+SmYpFyjN12bPuX9ZLErrX3Av3tfkALul2/E=;
	b=D5HwuqG8QbxGFpn9vFMdUXs0v6Ip+6S02HIMBWpOjP570u/2LccW+aRraxc3XHeqZ6WEK/
	8Dqy/lIqobxYQfDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 32B6113A93;
	Mon,  3 Jun 2024 06:34:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8RsMCe5jXWbTSQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 03 Jun 2024 06:34:22 +0000
Message-ID: <55610402-74c3-44fe-ac0d-37958f2f86b5@suse.de>
Date: Mon, 3 Jun 2024 08:34:21 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 05/11] mm: split a folio in minimum folio order chunks
Content-Language: en-US
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, david@fromorbit.com,
 chandan.babu@oracle.com, akpm@linux-foundation.org, brauner@kernel.org,
 willy@infradead.org, djwong@kernel.org
Cc: linux-kernel@vger.kernel.org, john.g.garry@oracle.com,
 gost.dev@samsung.com, yang@os.amperecomputing.com, p.raghav@samsung.com,
 cl@os.amperecomputing.com, linux-xfs@vger.kernel.org, hch@lst.de,
 mcgrof@kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
References: <20240529134509.120826-1-kernel@pankajraghav.com>
 <20240529134509.120826-6-kernel@pankajraghav.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240529134509.120826-6-kernel@pankajraghav.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -6.50
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: DD1C320027
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,samsung.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]

On 5/29/24 15:45, Pankaj Raghav (Samsung) wrote:
> From: Luis Chamberlain <mcgrof@kernel.org>
> 
> split_folio() and split_folio_to_list() assume order 0, to support
> minorder we must expand these to check the folio mapping order and use
> that.
> 
> Set new_order to be at least minimum folio order if it is set in
> split_huge_page_to_list() so that we can maintain minimum folio order
> requirement in the page cache.
> 
> Update the debugfs write files used for testing to ensure the order
> is respected as well. We simply enforce the min order when a file
> mapping is used.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>   include/linux/huge_mm.h | 14 ++++++++----
>   mm/huge_memory.c        | 50 ++++++++++++++++++++++++++++++++++++++---
>   2 files changed, 57 insertions(+), 7 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


