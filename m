Return-Path: <linux-fsdevel+bounces-55118-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E77FB0705D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 10:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71A9C7ADD77
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 08:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11D92EAB85;
	Wed, 16 Jul 2025 08:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yc7y2C6O";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fOdMwmH8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SKtCDwxJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VQapEGWN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6AD2EAB78
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jul 2025 08:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752654174; cv=none; b=kiwJ3EFvwDzetpm46mPdo56of4yOEp4yagm3E3YN/IvOgWVFvhdojK4xoU6xjxif0+ZIPALmVUFC+5fIq+tKKccJzs+tXLaon8uTPQgvklT2jZrm1QA758xrMZR4h+R4uLnmXeruA6XhtHhM858lH/qP1W7DoWDTkLwoq/Gwq44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752654174; c=relaxed/simple;
	bh=GRbjXPqZddzfIVVRIyFz7ZuTyQNfw9VoCi18wCUi1Wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZZ0855A1+mCcf5zioM7R+Bq5j4UWlgkmyusmHpYV5q/LcOd/6QQgpDA4RppUXz9M2iBjNp6PJ8WseZTVQShyG6Eobx6MXXXPbiBtRIEIHf+hPCOWGggbc4by2e7MMpJ6Xnv6arbgUvGnItTl0/BxQsFrVWTPU38ppXxQXDsZYEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yc7y2C6O; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fOdMwmH8; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SKtCDwxJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VQapEGWN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9648F1F38E;
	Wed, 16 Jul 2025 08:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752654170; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eYaQzTxO2EXAgTj5Tmh3qSEBV9qTyqV769ionVDxydo=;
	b=yc7y2C6OOZgd4x9WIB5Fsl5oTCcbpQz4jm9Kq+EoQ9QCutH+KbLCj+1v0aHvRp1LeurUkI
	FRfAMBG3EYJvSVy/R8oTFZl4/s2L/BXL5ak5CEHwZqwepHvnP8qYDdwm2w1DImdMO8wo5W
	9xerIS40xW1fufGncx8MwTgRWWJmQy0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752654170;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eYaQzTxO2EXAgTj5Tmh3qSEBV9qTyqV769ionVDxydo=;
	b=fOdMwmH8kyrOPeSCUT5zBSuQ4lVq/Id6NVZseDv1XtbuqIDi6Ll775JTt4ecNanN5XH1Ew
	GQ5E28xqUI+nL6DQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=SKtCDwxJ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=VQapEGWN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752654169; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eYaQzTxO2EXAgTj5Tmh3qSEBV9qTyqV769ionVDxydo=;
	b=SKtCDwxJo8nPlZdaW/yBPWECZgSEX/cx5Irqq/nvAQZvIzEYHdR2l6HG4Wp3ZpYwuAws+5
	VowBBx1gQ5vvxwv7gamBKohfkbdqAIm5hoyZKQri15D6GihKP3XFHBoIhCJ/xqvsK3tK9L
	COaG7EuEkg8Syz/YKsGgM+fDj8uaQvQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752654169;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eYaQzTxO2EXAgTj5Tmh3qSEBV9qTyqV769ionVDxydo=;
	b=VQapEGWNmv38Ig5isE+uVRHaUwcAwA70C/LQrjGZLGVEAwj5qiXZ7Nl9qdWIWHjMFl73fN
	RWNDObOLEczLSQDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E588A138D2;
	Wed, 16 Jul 2025 08:22:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WqVdNVdhd2icEgAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 16 Jul 2025 08:22:47 +0000
Date: Wed, 16 Jul 2025 10:22:46 +0200
From: Oscar Salvador <osalvador@suse.de>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org,
	nvdimm@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
	Hugh Dickins <hughd@google.com>, Lance Yang <lance.yang@linux.dev>,
	David Vrabel <david.vrabel@citrix.com>
Subject: Re: [PATCH v1 9/9] mm: rename vm_ops->find_special_page() to
 vm_ops->find_normal_page()
Message-ID: <aHdhVpGzOYHiDEq8@localhost.localdomain>
References: <20250715132350.2448901-1-david@redhat.com>
 <20250715132350.2448901-10-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715132350.2448901-10-david@redhat.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 9648F1F38E
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[localhost.localdomain:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email]
X-Spam-Score: -4.51

On Tue, Jul 15, 2025 at 03:23:50PM +0200, David Hildenbrand wrote:
> ... and hide it behind a kconfig option. There is really no need for
> any !xen code to perform this check.
> 
> The naming is a bit off: we want to find the "normal" page when a PTE
> was marked "special". So it's really not "finding a special" page.
> 
> Improve the documentation, and add a comment in the code where XEN ends
> up performing the pte_mkspecial() through a hypercall. More details can
> be found in commit 923b2919e2c3 ("xen/gntdev: mark userspace PTEs as
> special on x86 PV guests").
> 
> Cc: David Vrabel <david.vrabel@citrix.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

 

-- 
Oscar Salvador
SUSE Labs

