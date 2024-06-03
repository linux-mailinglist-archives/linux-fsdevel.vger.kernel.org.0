Return-Path: <linux-fsdevel+bounces-20784-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE728D7B8F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 08:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0A1BB215EF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 06:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230502C6BB;
	Mon,  3 Jun 2024 06:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="icedoS8t";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Dr3NTjY7";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bkMILn3a";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="O1enm+Co"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDEB374C3;
	Mon,  3 Jun 2024 06:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717396099; cv=none; b=OUieYiMHvFwAVicvfmEhii+LagV8bjKmqjux8BrS7cNXnwMIKMfnFiUPTExAKesyn02X8n8AGTKMO5wqtU8eF/fRobAZ3bwYsxcBrnPQDBIiDANvbkd27y1T3/KT7U1vznOqa/MSAnttaATO4GbP6uQf9FY+qvMl/lGgvj8n0ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717396099; c=relaxed/simple;
	bh=7AaEvVMfY/4GKdSeCZCV1fOqUcNHAMZgXIepet8NVLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a21IH9G2Her9KM9jspLsQ6m/OOkot/016NRzZXVyWLpoVA1H/fuAYQvcKLOvXJo7GBwKKrkHvq5aSc+v7x+ZR7ikB5cEowfgvTpyUNZKHVGjVPOpBUR4TZMy0Xu4DNF2JfFtZ7mh0d20clV7YpGQoarBy3j6zDTnMYS/ozDyx3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=icedoS8t; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Dr3NTjY7; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bkMILn3a; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=O1enm+Co; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C3E9D222D3;
	Mon,  3 Jun 2024 06:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717396090; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G4kktwsbW6z/0NnNeugpgEFh8XvGTwwRbkxW1BafLgg=;
	b=icedoS8tE74qqGZXCIqtKhe2cdZjIqwBGKwvLk5Gl0tXhYgq/PpnmabeIM0HCpfth0iMA8
	1nLePLBZ6In4scqhcGwb8peKkIOvVTgA+8mzjM5IaThEIX5hhezYRaBW6MeNp7Z2eiFYnG
	rhn6+JBvhdqjlkjb/XDgf3vpb9NV044=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717396090;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G4kktwsbW6z/0NnNeugpgEFh8XvGTwwRbkxW1BafLgg=;
	b=Dr3NTjY7gE5DszwjwybB1Q8k6oUnim+TIzbFGQ008cbbIHxhpj/U47nEoI4CXLTchFJTMv
	3Z4AmNaE3qS+AsBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=bkMILn3a;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=O1enm+Co
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717396089; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G4kktwsbW6z/0NnNeugpgEFh8XvGTwwRbkxW1BafLgg=;
	b=bkMILn3auV3QWoiQ5ga+r46ZiJ+280ioTuMGqZagiAU+5c8RTDw70jvCjmRvnHZsHjzQ/c
	3Rh+ynPdXvVpoedKoEiS5L0hpdTYve5+UYhJ4tsnv97pc5bR9rsjcobNl74/ydnZ0ozVZ9
	XBTFf+s+3c+GqYdnZtF17v6xs9/sVBQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717396089;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G4kktwsbW6z/0NnNeugpgEFh8XvGTwwRbkxW1BafLgg=;
	b=O1enm+CoV2gDRN/SuNkMFZv6hZrjo79EFfoVDo0656LVgdlemDUskF5ctP6eMNX9vWdYxu
	tzfw5l2puMAIEPCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0EA3413A93;
	Mon,  3 Jun 2024 06:28:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bl1wAHliXWb9RwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 03 Jun 2024 06:28:09 +0000
Message-ID: <5ace80c8-8b70-4227-aa63-914b69fa32cb@suse.de>
Date: Mon, 3 Jun 2024 08:28:07 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 02/11] fs: Allow fine-grained control of folio sizes
Content-Language: en-US
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, david@fromorbit.com,
 chandan.babu@oracle.com, akpm@linux-foundation.org, brauner@kernel.org,
 willy@infradead.org, djwong@kernel.org
Cc: linux-kernel@vger.kernel.org, john.g.garry@oracle.com,
 gost.dev@samsung.com, yang@os.amperecomputing.com, p.raghav@samsung.com,
 cl@os.amperecomputing.com, linux-xfs@vger.kernel.org, hch@lst.de,
 mcgrof@kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
References: <20240529134509.120826-1-kernel@pankajraghav.com>
 <20240529134509.120826-3-kernel@pankajraghav.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240529134509.120826-3-kernel@pankajraghav.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -6.50
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: C3E9D222D3
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
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,infradead.org:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]

On 5/29/24 15:45, Pankaj Raghav (Samsung) wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> We need filesystems to be able to communicate acceptable folio sizes
> to the pagecache for a variety of uses (e.g. large block sizes).
> Support a range of folio sizes between order-0 and order-31.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Co-developed-by: Pankaj Raghav <p.raghav@samsung.com>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>   include/linux/pagemap.h | 86 ++++++++++++++++++++++++++++++++++-------
>   mm/filemap.c            |  6 +--
>   mm/readahead.c          |  4 +-
>   3 files changed, 77 insertions(+), 19 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


