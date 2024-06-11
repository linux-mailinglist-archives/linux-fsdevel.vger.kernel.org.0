Return-Path: <linux-fsdevel+bounces-21382-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3582090333D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 09:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72442281A91
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 07:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B89D172777;
	Tue, 11 Jun 2024 07:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XKoJtDzi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4eqAmxye";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="joOPdg0L";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hJGyDQHd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32E318643;
	Tue, 11 Jun 2024 07:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718090043; cv=none; b=IpTgyrqfXgqVl9uaQSi/2LGaZKdzJ41F1qfNiZ5sHn7AN/E6FMeGV/r5ANDTgfQLvw6y3+SGD1ytCbKe9+Pnw+K1Zy2d+ItK/alKFgPpW4gvNgQu3EcIYUXYg1C+S9D4a9eCyobfZiJbqDBNFJmvMS739wJKs5UjI+6xMIK8V10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718090043; c=relaxed/simple;
	bh=XeUNpSU7d3V1UZlO08Dsvz+kUONVDg04zNzZDSlTYCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GUHpAn4uHYUyuQHnosdZKjqCj+J48FTFJ7ZHHL8UffnH1Giu848VLqPDTmDFzLMfjS46G0Fw1jJlulV8DvHqNj5RaYqUhHSKupz+7Xcl7GrIWOaA5AvmuCWbDkDz3VSpGYMH8elzO8eqfLdOY4BaRokPt4SPA/vKnVb0ytcWxBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XKoJtDzi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4eqAmxye; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=joOPdg0L; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hJGyDQHd; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D10BF2051A;
	Tue, 11 Jun 2024 07:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718090040; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YlL+OWuw0802KSXyQBux9dX7ezSqhAZ0pJtvU4rpMUc=;
	b=XKoJtDzimLSS2XO4MhwrgjeJiPdUQJJe38pacnaTy4O0bzV7XRSlA/5zXBuIGUZf1vurLH
	K0liQFiNB7QTD3jX/SnkiPh6KVn/2r0IysZ9HEkO4LfyL/RQJwy6gRnaa9m9bZhbBHnndE
	oTFmr0RFlY7CVgfJZQZKlvTskqb8ck4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718090040;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YlL+OWuw0802KSXyQBux9dX7ezSqhAZ0pJtvU4rpMUc=;
	b=4eqAmxyed4wxhE1zFqg6tgXXN7pXifa7iQyk6dAgrWQbSgfMQz9jd8VQt4IX9lf+23bSIf
	8DOhOffpCMpGS9BA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=joOPdg0L;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=hJGyDQHd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718090039; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YlL+OWuw0802KSXyQBux9dX7ezSqhAZ0pJtvU4rpMUc=;
	b=joOPdg0LPdLvECRCbtOJCRH7QsqVJlilZj4P9jJpPHcp7HSEywvTklNyA0XJtaj6w+oCye
	VAmbjhcQV/ReZvFcKqCr1sNHETAypZXORSgalifpwOznm5ktbhZok1l0HS5oPEwWJoVy5T
	oC53ldNu98JCu0GxSQfSCpVkcjuaDrw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718090039;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YlL+OWuw0802KSXyQBux9dX7ezSqhAZ0pJtvU4rpMUc=;
	b=hJGyDQHdY9CGAybVhv77JZ242gs0nHpGMaftb+NtDJj2qU4CHc836nprALYxoRveCmYcJb
	9/9cEdWupYa8WKCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 634AF13A55;
	Tue, 11 Jun 2024 07:13:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rzsgFTf5Z2ZyRgAAD6G6ig
	(envelope-from <osalvador@suse.de>); Tue, 11 Jun 2024 07:13:59 +0000
Date: Tue, 11 Jun 2024 09:13:57 +0200
From: Oscar Salvador <osalvador@suse.de>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v1 2/6] fs/proc/task_mmu: don't indicate
 PM_MMAP_EXCLUSIVE without PM_PRESENT
Message-ID: <Zmf5NdeKewGEhYLI@localhost.localdomain>
References: <20240607122357.115423-1-david@redhat.com>
 <20240607122357.115423-3-david@redhat.com>
 <ZmaDSQZlAl7Jb-wi@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmaDSQZlAl7Jb-wi@localhost.localdomain>
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: D10BF2051A
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]

On Mon, Jun 10, 2024 at 06:38:33AM +0200, Oscar Salvador wrote:
> Signed-off-by: Oscar Salvador <osalvador@suse.de>

Uh, I spaced out here, sorry.

Reviewed-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE Labs

