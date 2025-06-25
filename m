Return-Path: <linux-fsdevel+bounces-52872-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AF3AE7B5D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 11:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96B4E174EF7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 09:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A582951BA;
	Wed, 25 Jun 2025 09:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="K88MIKtY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TzFhUtlf";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pDNU/pMD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kjIsMO7l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B862980B4
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 09:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750842131; cv=none; b=slNifKIaC4YUaSnOHviyQLegCE1kqZnI37HeFuMs5ovZ5J34XAwQWqyEQW5oPcpP4w+DUYcM+OJi8ZTgxjJ2z5eaUPL6meXe7DA4AMeYtdujGzJuL1JVY2PHtovCFxG2SL3dca41aUIga0fRsavwGuhEw6ll/1r2o/9C8UqqkoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750842131; c=relaxed/simple;
	bh=w69PsKV0mtJP34RG1Oy9rkIyf8HycIJ0IGuxsGrYzfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BF8jOLhc+BquzIVhEzzLsNEJJStnR48TYpwV/PITSlmvcZ/T6NfXmpS8MQCy6OxEIXobt+LPQ+ltdZumn81wX6Twd8QQIYNHtsWzD7HEdRp3zUewXX7ROlbhRfzQHoESnLHsFAl3xKUHYVBM6x6oxkyF7SkEnCx9E0H2W8Y8cyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=K88MIKtY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TzFhUtlf; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pDNU/pMD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kjIsMO7l; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 543581F457;
	Wed, 25 Jun 2025 09:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750842127; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VQkPVKL8Rc6BcG1xlmknHJTwR6rrtSmQUG7dRS6JaQI=;
	b=K88MIKtY82CBpDzi6rQlT8OOPkg95o/p3QDoD2WpqwtqDG9ygD7FSVfzTnMIZ7K8uQHP/1
	a++hTBSfkSdfFK/P6HtAVN7TfcxDBmnw1rgQV/OyCk2yOckW4xtXP8KZyePm3xsYVnDJS+
	qcseI6zWccOfZ1VVNmzQcg2F9Ma33UU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750842127;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VQkPVKL8Rc6BcG1xlmknHJTwR6rrtSmQUG7dRS6JaQI=;
	b=TzFhUtlfsd2gpvUbQU498O7GUVWWT7ZHU7TLg3xy6oJ9oFZulfMtyjrmCdCh1Dc8Gt72rg
	P/DStVSGf1mo1nAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="pDNU/pMD";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=kjIsMO7l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750842126; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VQkPVKL8Rc6BcG1xlmknHJTwR6rrtSmQUG7dRS6JaQI=;
	b=pDNU/pMD3ceHkSNdLroWs06SZ+4g1lwFF7QW3K/tkoE2mMTb3gkLIDqm2lGc+KW1bkW2rW
	GzjhQwoQrrEfxyO917+9puLYEuPgaGkH6x2PRDB2/zOsyZqx2AYxOkSydeSijePK6AaCdx
	AM682U+M51EFr5F+lzgOVZumn85qvW4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750842126;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VQkPVKL8Rc6BcG1xlmknHJTwR6rrtSmQUG7dRS6JaQI=;
	b=kjIsMO7lE8qBubsM74x4X0Wczs7UPx+ikAJR1+7ZVgZY7b4ybJzMSyJuvtoN+MTFR9L/Hv
	s0a8I/zchHyFNcDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D8ABF13485;
	Wed, 25 Jun 2025 09:02:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id a54nMgy7W2iZKgAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 25 Jun 2025 09:02:04 +0000
Date: Wed, 25 Jun 2025 11:02:03 +0200
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
Subject: Re: [PATCH RFC 11/14] mm: remove "horrible special case to handle
 copy-on-write behaviour"
Message-ID: <aFu7C0S_SjSOqO8G@localhost.localdomain>
References: <20250617154345.2494405-1-david@redhat.com>
 <20250617154345.2494405-12-david@redhat.com>
 <5f4c0a45-f219-4d95-b5d7-b4ca1bc9540b@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f4c0a45-f219-4d95-b5d7-b4ca1bc9540b@redhat.com>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 543581F457
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-6.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	R_RATELIMIT(0.00)[to_ip_from(RL88oxspsx4bg3gu1yybyqiqt4)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim]
X-Spam-Score: -6.51
X-Spam-Level: 

On Wed, Jun 25, 2025 at 10:47:49AM +0200, David Hildenbrand wrote:
> I'm still thinking about this patch here, and will likely send out the other
> patches first as a v1, and come back to this one later.

Patch#12 depends on this one, but Patch#13 should be ok to review
If I ignore the 'addr' parameter being dropped, right?


-- 
Oscar Salvador
SUSE Labs

