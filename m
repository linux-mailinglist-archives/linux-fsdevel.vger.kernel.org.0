Return-Path: <linux-fsdevel+bounces-52878-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4960EAE7CDE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 11:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 814F117D89C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 09:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD1D2BE7AC;
	Wed, 25 Jun 2025 09:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rbtjJP9z";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GgVMoCJy";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="O/vvHBWM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xfzFyc8T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F6A2080C4
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 09:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750843352; cv=none; b=iVMJVjnN9dRG7o4B0cNC1VwmIzGiyyBd0VJv0AQqe/bXvGkWnWQ6pSoD/KLri+e6RUmwm4Z3YqUcgzSDdGtq8+jpMxL92kpcyetx9ubU6i6EEcdW7LYxUa02ioimT1ZrUh7Gss7sH+kv3sIg2w0imFwlYVVA54/74QheLbjw8MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750843352; c=relaxed/simple;
	bh=WFI6E6+VRUWyHl6ZReIPA0IZvlzEs7H4ajbL8lgEN5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b9yKp9uHZWmOLS2g/bvYxo/H9Ok8foJatjQFjPXu0j62Dvumh2/QIHX5k76YjcZefNZS9BCo2++PK4K4dgbp/OODk316m9KMlsfUi3cwzHCdEQnKwnjBGbhX0smk6IPRBAyaeiye/s8u/5ZixQ9YWO9Ygc11SLHMP2cZcHRfbD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rbtjJP9z; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GgVMoCJy; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=O/vvHBWM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xfzFyc8T; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CC8941F441;
	Wed, 25 Jun 2025 09:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750843349; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PkNXozaFqCl3r1OmdA8t+IzKcrfCQu04Mbq/ObVKxp8=;
	b=rbtjJP9zhGrVoJ43Ic9kugFSgL+KJpHkhNFjNzwFABe+2xjA8xtzPucLEDHFiRnRsWrdwn
	gsoOiPJig/Yv0UcdGA1Nce3zenDSyru5GjEROLMekd/5/3GvIDBP1sl3ABsroWeWdJ30X0
	Egm+gOPeA6Oq9ou2STYzXGu8ISNcZF4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750843349;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PkNXozaFqCl3r1OmdA8t+IzKcrfCQu04Mbq/ObVKxp8=;
	b=GgVMoCJyBt986jshsNs+3JcbCpxXSTveGpp2fw/56tFaD4umjtQPTNQmwnmEUrXGcdYk/c
	Q8lfEQQpRSTJyyCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="O/vvHBWM";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=xfzFyc8T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750843348; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PkNXozaFqCl3r1OmdA8t+IzKcrfCQu04Mbq/ObVKxp8=;
	b=O/vvHBWMUGSXvYo9OiVppR/pJSlJIxUObpuvSRpSaq2f4LaAbtBS3GI/sWSYARt0fzWuSg
	phQeflOpg4l1YLtUYYNw9Y1ctszd/PXb6vCfCv2Zu845RlwSlnNYMhul/Othun4kVSc6k+
	sk3WDOpHEsJ3jKgJ66p7kU/LAAFF3YE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750843348;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PkNXozaFqCl3r1OmdA8t+IzKcrfCQu04Mbq/ObVKxp8=;
	b=xfzFyc8TfzuRj1e5fLLi2HFfMPWUNAuYgqbpY6DE84k35H3GMtTOQQ3rrTI7xZXm5gaGhn
	soUCykV8MVeapKBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5E66713485;
	Wed, 25 Jun 2025 09:22:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id t8dVFNO/W2gdMQAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 25 Jun 2025 09:22:27 +0000
Date: Wed, 25 Jun 2025 11:22:25 +0200
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
Subject: Re: [PATCH RFC 13/14] mm: introduce and use vm_normal_page_pud()
Message-ID: <aFu_0VLYN5s8GPPe@localhost.localdomain>
References: <20250617154345.2494405-1-david@redhat.com>
 <20250617154345.2494405-14-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617154345.2494405-14-david@redhat.com>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: CC8941F441
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RL88oxspsx4bg3gu1yybyqiqt4)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,localhost.localdomain:mid]
X-Spam-Score: -4.51
X-Spam-Level: 

On Tue, Jun 17, 2025 at 05:43:44PM +0200, David Hildenbrand wrote:
> Let's introduce vm_normal_page_pud(), which ends up being fairly simple
> because of our new common helpers and there not being a PUD-sized zero
> folio.
> 
> Use vm_normal_page_pud() in folio_walk_start() to resolve a TODO,
> structuring the code like the other (pmd/pte) cases. Defer
> introducing vm_normal_folio_pud() until really used.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Ignoring the parameter stuff, I'd make the same comment I made wrt.
vm_normal_page_pmd, but LGTM.

Reviewed-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE Labs

