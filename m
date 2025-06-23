Return-Path: <linux-fsdevel+bounces-52596-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 559D5AE46E2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 16:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDB1616FB06
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 14:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FFC23E350;
	Mon, 23 Jun 2025 14:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="x3hlEMs7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oI968zJQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JYsVXf0I";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="heS3N+pq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93FD6136
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 14:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750688884; cv=none; b=JQuA019mEC6CA5RWNBMD0KArIRYtKHSv04rrQ4f73EC8chyD+TiMKwietZzjO23sAz6RNQxF99n6o9E/iQDzyqsGdBwAgFx5wtmv1yF8r9Wl/Nics1LKGQyIDeRt0vQf153kaQaFoG77tGXeIuXi2AgLzgnSKnSy3bKl4oQhnKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750688884; c=relaxed/simple;
	bh=YJCiIx6csLn0bpFv2gQQYRED31VRVaC9NNP5sjBpW0Q=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=eFUM2DtOIwwCrAU0p/tHXgIq6ka8Zc8E+eif5RlhnAYC5enVjRehlJl3MqyxtFc2zPuwKcxOUY6t9AWY46vfActTyZ+7D1ox+jhCz8ycRGv4aHrB3XnLf5acFKirvkYtdbY9lx7CjpvLk+1UUaGNtWRTy8zKQiCKDSLUm5NIszM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=x3hlEMs7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oI968zJQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JYsVXf0I; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=heS3N+pq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D2F812116B;
	Mon, 23 Jun 2025 14:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750688881; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=E5iEM9QDpyRDgX//nNw/KJ2WQ1r0Cs8xwFNmlzPnDVo=;
	b=x3hlEMs7Qeam81RvadgdyX74sjneiRIuSoLTV8Zh7tHYVzOvvJPLpOmq456wZDs+K3lZwf
	rhD5eDuzFJqLXL8TTTkzwLMQYDbwkURrobYjrXkQjk5qoqNRQN7o9v7FCFXFiiLQEXdHgK
	yF+RP4OJ3PLvV9aqyZyIqyYRh0jxvgg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750688881;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=E5iEM9QDpyRDgX//nNw/KJ2WQ1r0Cs8xwFNmlzPnDVo=;
	b=oI968zJQbRFY0zQwCT3VKqq9pG9i7OW2SURAfo5/ulY0hNG5ungqeZtZJpHZEnP3hy9ULG
	3Q2MpRA+ZzDyF5Cg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=JYsVXf0I;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=heS3N+pq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750688880; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=E5iEM9QDpyRDgX//nNw/KJ2WQ1r0Cs8xwFNmlzPnDVo=;
	b=JYsVXf0It5vYCvQpCLT+/NBQkTuOiMRZH5Nxnrt9kAEfJj896Q80TeZ6vB9GyOpVfhylwH
	5h8l6ifIWvzu8BSangwlhivu9ZBtwaSjKSJDSQNCpCIC9CMHY8KF5FCh+ENHIYSFf6g8IE
	yGk7jFjXBhCmCtDZJzxA9VYcv/6T2rk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750688880;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=E5iEM9QDpyRDgX//nNw/KJ2WQ1r0Cs8xwFNmlzPnDVo=;
	b=heS3N+pqYQB4nibgzso7aVZDikqAsmk3Towm7IX/mP8/6BiMXv7VjWEh4V/acQ4IMpjsKw
	8RUrlCwPQZgvY9Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A0FA313485;
	Mon, 23 Jun 2025 14:28:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +0kAJ3BkWWioZAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 23 Jun 2025 14:28:00 +0000
Message-ID: <568cba54-dd42-45e9-be0f-53569811f2e9@suse.cz>
Date: Mon, 23 Jun 2025 16:28:00 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] fs: export anon_inode_make_secure_inode() and fix
 secretmem LSM bypass
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
To: Shivank Garg <shivankg@amd.com>, David Hildenbrand <david@redhat.com>,
 akpm@linux-foundation.org, brauner@kernel.org, paul@paul-moore.com,
 rppt@kernel.org, viro@zeniv.linux.org.uk
Cc: seanjc@google.com, willy@infradead.org, pbonzini@redhat.com,
 tabba@google.com, afranji@google.com, ackerleytng@google.com, jack@suse.cz,
 hch@infradead.org, cgzones@googlemail.com, ira.weiny@intel.com,
 roypat@amazon.co.uk, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
References: <20250620070328.803704-3-shivankg@amd.com>
 <f2a205a5-aca9-4788-88ff-bfb3283610c5@redhat.com>
 <3114d54f-ed7c-4c68-9d32-53ce04175556@amd.com>
 <39f95eb9-c494-4967-8d4d-9768200637f4@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <39f95eb9-c494-4967-8d4d-9768200637f4@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: D2F812116B
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[googlemail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[google.com,infradead.org,redhat.com,suse.cz,googlemail.com,intel.com,amazon.co.uk,vger.kernel.org,kvack.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.51
X-Spam-Level: 

On 6/23/25 16:13, Vlastimil Babka wrote:
> On 6/23/25 16:08, Shivank Garg wrote:
>> 
>> 
>>> 
>>> In general, LGTM, but I think the actual fix should be separated from exporting it for guest_memfd purposes?
>>> 
>>> Also makes backporting easier, when EXPORT_SYMBOL_GPL_FOR_MODULES does not exist yet ...
>>> 
>> I agree. I did not think about backporting conflicts when sending the patch.
>> 
>> Christian, I can send it as 2 separate patches to make it easier?
> 
> The proper way is to send the fix without the export, and then add the
> export only when adding its user.

Note: AFAIU either way the new user would be depending on a patch in a vfs
tree (maybe scheduled for an 6.16 rc and not the next merge window?) if
that's an issue for the development.

>> Thanks,
>> Shivank
> 


