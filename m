Return-Path: <linux-fsdevel+bounces-52324-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE88EAE1D16
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 16:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84E003B399F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 14:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12EAF28ECEA;
	Fri, 20 Jun 2025 14:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NWRV6aCQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lu5I6+IK";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LITdzs1i";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="J8iZwDMK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED73828C5BA
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jun 2025 14:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750428766; cv=none; b=SEqgJ2NE09nIzntWfjgilCWSRhq6AkRs89ZsxuXBtVqMZXYDFEKJQuGI9gAOiAKuJ4ck+dKCr6/BAPZbIoSrVXUDYdOMsIhc8dZqGEydl+sr3wMilV7OBcsuDUPqhAHlCHNNRur2k1nwWsxmwvD6o4NtXE9dUSQNuCpJYZQIfqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750428766; c=relaxed/simple;
	bh=qjM8Qrhoab/kYSa0GIn6YS+N8Y81lapvvHG2GTbpGo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TIXhOcb6QXI26wFbAwaY8JBkDt/8q4IUGVMJ336yuN4I7EWTfRslN1eGywC/6V+S849VZIJFfnT4PKLaXDazKU3R06XnhYMncJE/Iym8rPUsxhKiqFBXcOPZyOKk0+N132rIyhPpkuku6XoqmtW/Mkeq74YfsgrgDbzUzYOrI2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NWRV6aCQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lu5I6+IK; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LITdzs1i; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=J8iZwDMK; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 360232125C;
	Fri, 20 Jun 2025 14:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750428763; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dtga4mO8TWdhcrNxuBweDXF4tRengQ+fG9VcYGmkW3c=;
	b=NWRV6aCQSbsSKVN5q7Y9eC89NBbMnvIGOdeD9jTgcLGeihP0m1+9IfJ5+hR6kw8yI9AAuZ
	4eHDmJ8sPs3OVvqXplQVXS5djquRGXDNfQ7iWg/O4rcNRWFUZ+xyscmkQ90uwDPiNAr1zJ
	22YmVELpFy1fhQpf3UtBY+9IODRAoiM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750428763;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dtga4mO8TWdhcrNxuBweDXF4tRengQ+fG9VcYGmkW3c=;
	b=lu5I6+IKrQqOm4192LOXk9YZWP6wH/RZ0bgYxq9QyDcXuhYKm7+eejNbV+Z9D4qldbzsNu
	os4HkuacHmeJ9nCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750428762; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dtga4mO8TWdhcrNxuBweDXF4tRengQ+fG9VcYGmkW3c=;
	b=LITdzs1igri+FwLqtM0ZNwDGXD4masM2omJHh/AYPLu9s73jc1wuAZXTdiEwma0v/YV3f0
	UEXxFSYGjgJ6jG48+qTAN3LhSEcM2Go8CyS/rtXsOMcBx/uzgnW4/GlxLZ/4DEyUlxgz1F
	2wgUcSTUnkFX8PS7NBCw7w5g76srinE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750428762;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dtga4mO8TWdhcrNxuBweDXF4tRengQ+fG9VcYGmkW3c=;
	b=J8iZwDMKHqlx6VCsDIpTprxToxyIOpCO/tg1AQptUJ6i2mcjOOKEs+yuAuZPY2k3qr0FyG
	YECuaevK1f5TyxBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AB5C513736;
	Fri, 20 Jun 2025 14:12:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DZ8fJ1hsVWhhSAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Fri, 20 Jun 2025 14:12:40 +0000
Date: Fri, 20 Jun 2025 16:12:35 +0200
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
Subject: Re: [PATCH RFC 04/14] mm/huge_memory: move more common code into
 insert_pmd()
Message-ID: <aFVsU9-ZhZ9Ai53a@localhost.localdomain>
References: <20250617154345.2494405-1-david@redhat.com>
 <20250617154345.2494405-5-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617154345.2494405-5-david@redhat.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLhwqoz3wsm4df3nfubx4grhps)];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -4.30

On Tue, Jun 17, 2025 at 05:43:35PM +0200, David Hildenbrand wrote:
> Let's clean it all further up.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

I was thinking maybe we want to pass 'struct vm_fault' directly to insert_pmd(),
and retrieve the fields in there, but since you have to retrieve some in
insert_pfn_pmd().. maybe not.


-- 
Oscar Salvador
SUSE Labs

