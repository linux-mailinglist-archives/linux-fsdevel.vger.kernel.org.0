Return-Path: <linux-fsdevel+bounces-36423-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FFA9E3968
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 13:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF4BD16921E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 12:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BB61B5823;
	Wed,  4 Dec 2024 12:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NjxamjzG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ojpZ9GOu";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xMp+M91r";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="shBmRZHn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6781AB53A;
	Wed,  4 Dec 2024 12:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733313710; cv=none; b=uXjwvcSdaGhShmjWYEQgeXZS/7KYDZiJ7/aLQ+B7m/0qgFZ7sH0LqrxyzepUGl0mjk6O6aDCxyCPuKoXRT5KjFKkZcC2lxLqJ8MJaaQI7lIX16hMSrmsKlJ0lZVUcH0xJBiJr3YO4j09QuK59K4XQLqgb2MOZcQXcRAq8uUm8o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733313710; c=relaxed/simple;
	bh=HTtDsJl8UjVCOZCNAauh17Ovd5yZpq3aDefXX2AeQvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lj6R82cu3qcKmMokZMa4JMuYu09yHbYK1XMAuZ8QUPSAmL0qHS55pesdy7bq9d20FoWYhV+pLk7JO0l8LEhm42bnJs96q7rd4zLuGgvuVchFDq1O0VuVijLA/QgS56B4481XSxijbkFmZUSOzy5dhT5+VhhQHPYwzS6cQRU0Iqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NjxamjzG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ojpZ9GOu; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xMp+M91r; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=shBmRZHn; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D0B1D1F38E;
	Wed,  4 Dec 2024 12:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733313707; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hdQpCtHb/G8boTtOws0ht3i2N81j+VDcQZjqp9/HdvQ=;
	b=NjxamjzGcjXW6to6l67i6CoFAKcBDp4lGRx+Rds0l5QPKt+rfXLehVdkQTKX94nXvnqWVn
	dpXrLNfg8NxZPLWdXuJH7UspxltmvsLZpTdjk4Xb0x9EFG63mYpAFK9V7Ez1jK5CSIJzXz
	6JkyLctehKOKOrnNuIQ38QxoDHHBxB8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733313707;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hdQpCtHb/G8boTtOws0ht3i2N81j+VDcQZjqp9/HdvQ=;
	b=ojpZ9GOuJXNyR/vp6XsHoLsOXhJI4cOfvhNlDca8oGvfzYIRMVPve4oCWqmADqbjdo4M+A
	0xAwqZEZjWrYLKAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733313706; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hdQpCtHb/G8boTtOws0ht3i2N81j+VDcQZjqp9/HdvQ=;
	b=xMp+M91r2pR9VfINWZDH6sdvftrKE19XFnk96zw5DBlW4nXRAP5NrINq6NY8kLMk1U1CUr
	030PFr75NrEb++m4vhg+/vZ50LhBHmFpJ0ZxxDMviI0iqFqX2YmVkIRSfFX74bpkwEz6cp
	Coa9deNVsd9x/qtwOsQ3oJzzN1mFGI8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733313706;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hdQpCtHb/G8boTtOws0ht3i2N81j+VDcQZjqp9/HdvQ=;
	b=shBmRZHndiZc4wVndDm9+gtzuB5CAsfzjQ7mNQFJ5f3zelUPbyWxeNnriDgCHAtmxZeazC
	Wb/ZzNzcpZo2grAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9E8B31396E;
	Wed,  4 Dec 2024 12:01:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lB9jJapEUGdOHgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 04 Dec 2024 12:01:46 +0000
Message-ID: <bfc97a69-de69-45ec-875d-2f1e652e0f94@suse.de>
Date: Wed, 4 Dec 2024 13:01:46 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Removing page->index
To: Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-s390@vger.kernel.org
References: <Z09hOy-UY9KC8WMb@casper.infradead.org>
Content-Language: en-US
From: Thomas Zimmermann <tzimmermann@suse.de>
Autocrypt: addr=tzimmermann@suse.de; keydata=
 xsBNBFs50uABCADEHPidWt974CaxBVbrIBwqcq/WURinJ3+2WlIrKWspiP83vfZKaXhFYsdg
 XH47fDVbPPj+d6tQrw5lPQCyqjwrCPYnq3WlIBnGPJ4/jreTL6V+qfKRDlGLWFjZcsrPJGE0
 BeB5BbqP5erN1qylK9i3gPoQjXGhpBpQYwRrEyQyjuvk+Ev0K1Jc5tVDeJAuau3TGNgah4Yc
 hdHm3bkPjz9EErV85RwvImQ1dptvx6s7xzwXTgGAsaYZsL8WCwDaTuqFa1d1jjlaxg6+tZsB
 9GluwvIhSezPgnEmimZDkGnZRRSFiGP8yjqTjjWuf0bSj5rUnTGiyLyRZRNGcXmu6hjlABEB
 AAHNJ1Rob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPsLAjgQTAQgAOAIb
 AwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftODH
 AAoJEGgNwR1TC3ojx1wH/0hKGWugiqDgLNXLRD/4TfHBEKmxIrmfu9Z5t7vwUKfwhFL6hqvo
 lXPJJKQpQ2z8+X2vZm/slsLn7J1yjrOsoJhKABDi+3QWWSGkaGwRJAdPVVyJMfJRNNNIKwVb
 U6B1BkX2XDKDGffF4TxlOpSQzdtNI/9gleOoUA8+jy8knnDYzjBNOZqLG2FuTdicBXblz0Mf
 vg41gd9kCwYXDnD91rJU8tzylXv03E75NCaTxTM+FBXPmsAVYQ4GYhhgFt8S2UWMoaaABLDe
 7l5FdnLdDEcbmd8uLU2CaG4W2cLrUaI4jz2XbkcPQkqTQ3EB67hYkjiEE6Zy3ggOitiQGcqp
 j//OwE0EWznS4AEIAMYmP4M/V+T5RY5at/g7rUdNsLhWv1APYrh9RQefODYHrNRHUE9eosYb
 T6XMryR9hT8XlGOYRwKWwiQBoWSDiTMo/Xi29jUnn4BXfI2px2DTXwc22LKtLAgTRjP+qbU6
 3Y0xnQN29UGDbYgyyK51DW3H0If2a3JNsheAAK+Xc9baj0LGIc8T9uiEWHBnCH+RdhgATnWW
 GKdDegUR5BkDfDg5O/FISymJBHx2Dyoklv5g4BzkgqTqwmaYzsl8UxZKvbaxq0zbehDda8lv
 hFXodNFMAgTLJlLuDYOGLK2AwbrS3Sp0AEbkpdJBb44qVlGm5bApZouHeJ/+n+7r12+lqdsA
 EQEAAcLAdgQYAQgAIAIbDBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftOH6AAoJEGgNwR1T
 C3ojVSkIALpAPkIJPQoURPb1VWjh34l0HlglmYHvZszJWTXYwavHR8+k6Baa6H7ufXNQtThR
 yIxJrQLW6rV5lm7TjhffEhxVCn37+cg0zZ3j7zIsSS0rx/aMwi6VhFJA5hfn3T0TtrijKP4A
 SAQO9xD1Zk9/61JWk8OysuIh7MXkl0fxbRKWE93XeQBhIJHQfnc+YBLprdnxR446Sh8Wn/2D
 Ya8cavuWf2zrB6cZurs048xe0UbSW5AOSo4V9M0jzYI4nZqTmPxYyXbm30Kvmz0rYVRaitYJ
 4kyYYMhuULvrJDMjZRvaNe52tkKAvMevcGdt38H4KSVXAylqyQOW5zvPc4/sq9c=
In-Reply-To: <Z09hOy-UY9KC8WMb@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Score: -4.30
X-Spam-Flag: NO

Hi


Am 03.12.24 um 20:51 schrieb Matthew Wilcox:
> I've pushed out a new tree to
> git://git.infradead.org/users/willy/pagecache.git shrunk-page
> aka
> http://git.infradead.org/?p=users/willy/pagecache.git;a=shortlog;h=refs/heads/shrunk-page
>
> The observant will notice that it doesn't actually shrink struct page
> yet.  However, we're getting close.  What it does do is rename
> page->index to page->__folio_index to prevent new users of page->index
> from showing up.
>
> There are (I believe) three build failures in that tree:
>
>   - fb_defio

It's only used for helpers of the mm code. So it should be good to change.

>   - fbtft

And this reference should be removed IMHO. The driver's display-update 
code has no business in looking at struct page.

Best regards
Thomas

>   - s390's gmap (and vsie?  is that the same thing?)
>
> Other than that, allmodconfig builds on x86 and I'm convinced the build
> bots will tell me about anything else I missed.
>
> Lorenzo is working on fb_defio and fbtft will come along for the ride
> (it's a debug printk, so could just be deleted).
>
> s390 is complicated.  I'd really appreciate some help.
>
> The next step is to feed most of the patches through the appropriate
> subsystems.  Some have already gone into various maintainer trees
> (thanks!)
>
>
> There are still many more steps to go after this; eliminating memcg_data
> is closest to complete, and after that will come (in some order)
> eliminating ->lru, ->mapping, ->refcount and ->mapcount.  We also need
> to move page_pool out into its own structure.

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


