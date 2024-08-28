Return-Path: <linux-fsdevel+bounces-27601-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BA2962C4D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 17:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 891841C20944
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 15:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8C11A4F10;
	Wed, 28 Aug 2024 15:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cV8Jjz+a";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pUPa7gh3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cV8Jjz+a";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pUPa7gh3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF76B1A4B9F;
	Wed, 28 Aug 2024 15:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724858810; cv=none; b=t/1IRu2P+20QqpvH2k7AKsZ58Y7ZVFbRZkgh/HJPFI5stNyQlBqPjpXAfEkiAXzuV7SHnxrcy9uYtb1od8+4+zCj93ifTDVHzOTJR44JQ6PBDijYqOfJu9owSPYtz+HO3MWz6hCepayrBT2qpok/vP76UJSp7Lcf5Un2K1rvJng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724858810; c=relaxed/simple;
	bh=rxlkV+j+vdfUqHQYjq6CHRf43Bcc0FuNBBYeeRY83yA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZYhMj0scBGl9usfYYTgJNartAIp9GFy6hJ6jnXkyoc1PjwA+tBkXx1m8GAkN2KA8PL0rue/xfwASSs9D/RJVrCq97if2pTUatBjTNADJvF3UVXwp2QhKL0mlgBLOSj8ZVan/C9bAquIWV8WC/Lu8x+FJZMUPDiRuzPUBK/Mf9/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cV8Jjz+a; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pUPa7gh3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cV8Jjz+a; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pUPa7gh3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0BE1421996;
	Wed, 28 Aug 2024 15:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724858807; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7R+jbn/uYuS/hedGxq+PA41+J5CeshsqeGYUde3wyXM=;
	b=cV8Jjz+aSrsW3SGsjwExBvTATv5H2kppAa38oeoyFfaSVr7ELWwNcO+h2NUym7XAAQYwdK
	sMg8+zPVpiJ7O40NGhe1crQp2KwCYwE9xdlYISZbxTnWM4i0nD0NAUYjp9YoDRlTekHBFc
	3zoTEyW05W1xGj7SuEs6vRQ1POoEa2o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724858807;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7R+jbn/uYuS/hedGxq+PA41+J5CeshsqeGYUde3wyXM=;
	b=pUPa7gh3H7yi3MuVuHOrXnwoIz5V947U19JEMsYyVPJm+E2VKhFyGezz87hfp/wsDRllT/
	UlLPShQXkYMPoXCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724858807; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7R+jbn/uYuS/hedGxq+PA41+J5CeshsqeGYUde3wyXM=;
	b=cV8Jjz+aSrsW3SGsjwExBvTATv5H2kppAa38oeoyFfaSVr7ELWwNcO+h2NUym7XAAQYwdK
	sMg8+zPVpiJ7O40NGhe1crQp2KwCYwE9xdlYISZbxTnWM4i0nD0NAUYjp9YoDRlTekHBFc
	3zoTEyW05W1xGj7SuEs6vRQ1POoEa2o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724858807;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7R+jbn/uYuS/hedGxq+PA41+J5CeshsqeGYUde3wyXM=;
	b=pUPa7gh3H7yi3MuVuHOrXnwoIz5V947U19JEMsYyVPJm+E2VKhFyGezz87hfp/wsDRllT/
	UlLPShQXkYMPoXCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 00C20138D2;
	Wed, 28 Aug 2024 15:26:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Xz8pALdBz2ZFUAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 28 Aug 2024 15:26:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A05DBA0965; Wed, 28 Aug 2024 17:26:38 +0200 (CEST)
Date: Wed, 28 Aug 2024 17:26:38 +0200
From: Jan Kara <jack@suse.cz>
To: David Howells <dhowells@redhat.com>
Cc: Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
	Steve French <sfrench@samba.org>, netfs@lists.linux.dev,
	linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: The mapping->invalidate_lock, copy-offload and cifs
Message-ID: <20240828152638.iv7v5rj23n7mi73h@quack3>
References: <774275.1724770015@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <774275.1724770015@warthog.procyon.org.uk>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

Hi David!

On Tue 27-08-24 15:46:55, David Howells wrote:
> I'm looking at trying to fix cifs_file_copychunk_range().  Currently, it
> invalidates the destination range, apart from a partial folio at either end
> which will be flushed, and then tries the copy.  But if the copy fails or can
> only be partially completed (eg. ENOSPC), we lose any data in the destination
> region, so I think it needs to be flushed and invalidated rather than just
> being invalidated.
> 
> Now, we have filemap_invalidate_inode() which I can use to flush back and
> invalidate the folios under the invalidate_lock (thereby avoiding the need for
> launder_folio).  However, that doesn't prevent mmap from reinstating the
> destination folios with modifications whilst the copy is ongoing the moment
> the invalidate_lock is dropped.
> 
> Question is: would it be reasonable to do the copy offload whilst holding the
> invalidate_lock for the duration?

FWIW yes, I'd expect cifs_file_copychunk_range() to take invalidate_lock on
the target file to avoid possible races with page faults. We do it this
already for similar operations such as reflink or various fallocate
operations...

								Honza

> 
> Thanks,
> David
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

