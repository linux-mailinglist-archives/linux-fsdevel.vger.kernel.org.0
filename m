Return-Path: <linux-fsdevel+bounces-52319-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 394DDAE1B69
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 15:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ABB64A538F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 13:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BBB228BA91;
	Fri, 20 Jun 2025 13:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zX6RSH/E";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nh+hv8rR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="J3qtFgYX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="L0w8dxyW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA187284B3C
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jun 2025 13:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750424656; cv=none; b=rUpZfi5RO9s2vsyB/POWoYplCpIk2047009Uvz2/FolA0c+U68rWYxG/TM4Rl5HZbIe7+6QNLeldiNlFNggRrYHFWY3QPTNa6IdxlpQcioIpPbMPf4Sc0dvClu9ZCGTGne93aGY9PBFErpxRKO2qDFGi0Gwk7m2jNyeZ1CdN1nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750424656; c=relaxed/simple;
	bh=8xzRYna+3js/ZU7PKL4VsvV8120qgK725oSHwN4oeqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ODtDCxqfe3YnD5fJBP5VZQQSSOYIx/5TkucpqHyDMmvlwlCGMuckXgjn4n6mmsU08F/Ylsa6992JNrcqk/SdlkoSF7VVrb0QE0PxXik83XcEnwOzsdtUiIzMnjbv8+IbdrpB+eqfcfGgFwCdn4xBPYhHS6eyPm6tBecRMS0n7K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zX6RSH/E; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nh+hv8rR; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=J3qtFgYX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=L0w8dxyW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 368F61F38D;
	Fri, 20 Jun 2025 13:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750424650; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=daWLKQl2/0cgVx8ffNyLfCOsf+I6Pzyyw2AepgbtRX0=;
	b=zX6RSH/E1caNjcBgklWgZsm5Y/DMKlYXsbv6G/xsAFF/Lf8GVHyuj/MG42YdRUOQZrUq4q
	zRMpWaxVLsJk0i1xUq/cmTBZyVBPKR2ByqwA6KDgWRTbRF6kmrInAaqL7zX05RHsGaZm9Z
	L+XoVlS1EDbkEmdRK0AbFsS+6ZMi1uI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750424650;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=daWLKQl2/0cgVx8ffNyLfCOsf+I6Pzyyw2AepgbtRX0=;
	b=nh+hv8rRDlhFQFcofmha9TNcenwSDqo3w6PCqC5Qscu9vvAZp+AGzrHGTs5Qy9r8st0t2w
	zHN90KYGDxsoDlBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=J3qtFgYX;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=L0w8dxyW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750424645; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=daWLKQl2/0cgVx8ffNyLfCOsf+I6Pzyyw2AepgbtRX0=;
	b=J3qtFgYXaiEtPWNY2b+WVQipK4Bkth6OuexnmnM02JWlLHRs/lsKu/MfcMxY5eFBu1gPc1
	GExCZ5WZwZtIgz5d4OmvkIp56Fq3PGIG9PqNeoupog2Vf09rm/jNu7jhmry4CMoiGAYNKf
	yJOPkW9yNQs++Hr/krGac1h0pFIUfNo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750424645;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=daWLKQl2/0cgVx8ffNyLfCOsf+I6Pzyyw2AepgbtRX0=;
	b=L0w8dxyWrX/SkfEqgHoXO7wqXYLGAXVLD+LJwG8CFOYVSKtrGdYJtGKAFyznE1DvwlZ+sO
	xB9rOeQnC4q0B0CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B8FF4136BA;
	Fri, 20 Jun 2025 13:04:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id O8puKkNcVWijMgAAD6G6ig
	(envelope-from <osalvador@suse.de>); Fri, 20 Jun 2025 13:04:03 +0000
Date: Fri, 20 Jun 2025 15:04:02 +0200
From: Oscar Salvador <osalvador@suse.de>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, nvdimm@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Alistair Popple <apopple@nvidia.com>,
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>
Subject: Re: [PATCH RFC 02/14] mm: drop highest_memmap_pfn
Message-ID: <aFVcQh3sLFJe2-fS@localhost.localdomain>
References: <20250617154345.2494405-1-david@redhat.com>
 <20250617154345.2494405-3-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617154345.2494405-3-david@redhat.com>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 368F61F38D
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	R_RATELIMIT(0.00)[to_ip_from(RL88oxspsx4bg3gu1yybyqiqt4)];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,localhost.localdomain:mid,suse.de:dkim,suse.de:email]
X-Spam-Score: -4.51
X-Spam-Level: 

On Tue, Jun 17, 2025 at 05:43:33PM +0200, David Hildenbrand wrote:
> Now unused, so let's drop it.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE Labs

