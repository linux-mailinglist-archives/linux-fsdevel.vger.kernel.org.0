Return-Path: <linux-fsdevel+bounces-52865-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C85F1AE7A6C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 10:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87DB116BF29
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 08:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97CF127C15C;
	Wed, 25 Jun 2025 08:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OLYJZMAt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OMwI9gql";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OLYJZMAt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OMwI9gql"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6646926C38D
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 08:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750840685; cv=none; b=SJNTUq4ujqJTizNgFdC4p54JfI5RhLqPjb0chIMZvahM75HCn2c17KEEPdPKzj/WjgmKl0Xt0yTQ83iFQ0PcnSbhJgMzGb1Thb7GXthzmwL5kajodZ+SpxYlthT1AvWTOKzwzwsQxSi1nzcF9Rsc9Q8JE4zuDRkgmg8WWWKo/JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750840685; c=relaxed/simple;
	bh=lEdGWdlGbPEO8ml2cohhIltylKHkmLl4yH78m08JaGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E4vuulhAkm6Z7w8W+SY5M0vKhB1k8vaWtjUmGLD4refkN1gq3VwXYB3kBoaeDWR+vcuxHOE+QSvPIrtFMK0Qv4/pfB8qmvoxTJsGowHdVAKUrIikQ+/jIJ4e47gBPZ3SY65KjEbSOsVaF20xDMFujGdkK7IZpYYTfJM6SxxEJsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OLYJZMAt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OMwI9gql; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OLYJZMAt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OMwI9gql; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9131C21225;
	Wed, 25 Jun 2025 08:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750840681; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HcMPAZexUY6msdIP55rf1vEz6oztuzPcCv+1Pw4Atj4=;
	b=OLYJZMAtygudvD/CIE0cZOWTk4461lHZrUEj0dGC2I73EjfPfHwnJVJ977L8C3VOZ4I/E5
	SSP3u3KALqeCXon9fk3gOxk1u0ZyINCSk0tYrnSP8uEU94+610t/koqQMPhkliDTI3qiqZ
	VTUjhBWy9ry6fWFKTwEVLSbCYC5m63Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750840681;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HcMPAZexUY6msdIP55rf1vEz6oztuzPcCv+1Pw4Atj4=;
	b=OMwI9gqlawaozmCo7wuNr/HhbhsxL2uRuAVg5AQOYBnUHVku7VmAoHYifwH+OThLFI+5I/
	S0kxmlSauUjnzpBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=OLYJZMAt;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=OMwI9gql
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750840681; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HcMPAZexUY6msdIP55rf1vEz6oztuzPcCv+1Pw4Atj4=;
	b=OLYJZMAtygudvD/CIE0cZOWTk4461lHZrUEj0dGC2I73EjfPfHwnJVJ977L8C3VOZ4I/E5
	SSP3u3KALqeCXon9fk3gOxk1u0ZyINCSk0tYrnSP8uEU94+610t/koqQMPhkliDTI3qiqZ
	VTUjhBWy9ry6fWFKTwEVLSbCYC5m63Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750840681;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HcMPAZexUY6msdIP55rf1vEz6oztuzPcCv+1Pw4Atj4=;
	b=OMwI9gqlawaozmCo7wuNr/HhbhsxL2uRuAVg5AQOYBnUHVku7VmAoHYifwH+OThLFI+5I/
	S0kxmlSauUjnzpBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0A4D913485;
	Wed, 25 Jun 2025 08:37:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YZNuO2e1W2iWIQAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 25 Jun 2025 08:37:59 +0000
Date: Wed, 25 Jun 2025 10:37:58 +0200
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
Subject: Re: [PATCH RFC 09/14] mm/memory: introduce is_huge_zero_pfn() and
 use it in vm_normal_page_pmd()
Message-ID: <aFu1Zoy0i4n0QkG0@localhost.localdomain>
References: <20250617154345.2494405-1-david@redhat.com>
 <20250617154345.2494405-10-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617154345.2494405-10-david@redhat.com>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 9131C21225
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RL88oxspsx4bg3gu1yybyqiqt4)];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -4.51
X-Spam-Level: 

On Tue, Jun 17, 2025 at 05:43:40PM +0200, David Hildenbrand wrote:
> Let's avoid working with the PMD when not required. If
> vm_normal_page_pmd() would be called on something that is not a present
> pmd, it would already be a bug (pfn possibly garbage).
> 
> While at it, let's support passing in any pfn covered by the huge zero
> folio by masking off PFN bits -- which should be rather cheap.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE Labs

