Return-Path: <linux-fsdevel+bounces-20236-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4768D8D01D2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 15:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F25D729417B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 13:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3929F16D312;
	Mon, 27 May 2024 13:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jWHHjC18";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ebz/lCbV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jWHHjC18";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ebz/lCbV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D069A163A97;
	Mon, 27 May 2024 13:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716816882; cv=none; b=AbS/QlzHYNNI2a+VOP3UpMrl9/Pn5gJeeeFUPuKP6foZ+Zfre5qWFcNkao/X9GSxQWnbjTXYva9lyIQBc1vZspk4iR6teC/mLzUMkYRXT+Y286xuNW936cJ+isxWv8rDtKkUzmLFLl5vR0qVw1zTN1zAZqij5fsop3h1YAuSwZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716816882; c=relaxed/simple;
	bh=kjPMXvkFqzalBmpVhNBchX/CPQKSHros1W9m/q220mE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mOxyJLaIT3O9ugB7kJ6hmT2bMLxS68azG92nZAPxpdanFbZDPWYeUfYgItln2jImKhhRzj4KaN/bU2da9fIDD0pijUN4IeiclW5ER8qu1l5CovdDUIg+zTaDqaYjbIcVjKdmw/737d7x9Wa5NyotZw2sQ90bcsfGmL3dP2mt0jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jWHHjC18; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ebz/lCbV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jWHHjC18; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ebz/lCbV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D6DFB21F12;
	Mon, 27 May 2024 13:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716816878; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1ewvVR78G9pjMmK37NXlCXasArwryOCz8cfNZq/3WtE=;
	b=jWHHjC180CR+Ukk3jtzt5IqdirLv2nEqDUj05vuEPLTMgLez3U8AxbYLdntRVc3l1RNAzn
	Rmow8EHzMLJ6z9CBW8RO7ZyFddUXumxNJPpgX1Teshnwqg8Xq0CObxV2sdHyDySPs5X/kw
	cYX0MIFbZvZJkBrUhBIHNF0+kR4O9AM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716816878;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1ewvVR78G9pjMmK37NXlCXasArwryOCz8cfNZq/3WtE=;
	b=ebz/lCbVJM6wF+e6Yfu0bG7UBmNCy1P68u5tnl+BckaYJztXjVfuP4hYJBkLv6rsNjNGxK
	Mxv4tSLuUcWG3fCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716816878; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1ewvVR78G9pjMmK37NXlCXasArwryOCz8cfNZq/3WtE=;
	b=jWHHjC180CR+Ukk3jtzt5IqdirLv2nEqDUj05vuEPLTMgLez3U8AxbYLdntRVc3l1RNAzn
	Rmow8EHzMLJ6z9CBW8RO7ZyFddUXumxNJPpgX1Teshnwqg8Xq0CObxV2sdHyDySPs5X/kw
	cYX0MIFbZvZJkBrUhBIHNF0+kR4O9AM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716816878;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1ewvVR78G9pjMmK37NXlCXasArwryOCz8cfNZq/3WtE=;
	b=ebz/lCbVJM6wF+e6Yfu0bG7UBmNCy1P68u5tnl+BckaYJztXjVfuP4hYJBkLv6rsNjNGxK
	Mxv4tSLuUcWG3fCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C8FF913A6B;
	Mon, 27 May 2024 13:34:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NBYOMe6LVGYJHQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 27 May 2024 13:34:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 487F0A07D0; Mon, 27 May 2024 15:34:30 +0200 (CEST)
Date: Mon, 27 May 2024 15:34:30 +0200
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@infradead.org>
Cc: Aleksa Sarai <cyphar@cyphar.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Alexander Aring <alex.aring@gmail.com>,
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH RFC v2] fhandle: expose u64 mount id to
 name_to_handle_at(2)
Message-ID: <20240527133430.ifjo2kksoehtuwrn@quack3>
References: <20240523-exportfs-u64-mount-id-v2-1-f9f959f17eb1@cyphar.com>
 <ZlMADupKkN0ITgG5@infradead.org>
 <20240526.184753-detached.length.shallow.contents-jWkMukeD7VAC@cyphar.com>
 <ZlRy7EBaV04F2UaI@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlRy7EBaV04F2UaI@infradead.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[cyphar.com,zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Score: -2.30
X-Spam-Flag: NO

On Mon 27-05-24 04:47:56, Christoph Hellwig wrote:
> On Sun, May 26, 2024 at 12:01:08PM -0700, Aleksa Sarai wrote:
> > The existing interface already provides a mount ID which is not even
> > safe without rebooting.
> 
> And that seems to be a big part of the problem where the Linux by handle
> syscall API deviated from all know precedence for no good reason.  NFS
> file handles which were the start of this do (and have to) encode a
> persistent file system identifier.  As do the xfs handles (although they
> do the decoding in the userspace library on Linux for historic reasons),
> as do the FreeBSD equivalents to these syscalls.

So I was wondering how this is actually working in practice. Checking the
code, NFS server is (based on configuration in /etc/exports) either using
device number as the filesystem identifier or fsid / uuid as specified in
/etc/exports.

> > An alternative would be to return something unique to the filesystem
> > superblock, but as far as I can tell there is no guarantee that every
> > Linux filesystem's fsid is sufficiently unique to act as a globally
> > unique identifier. At least with a 64-bit mount ID and statmount(2),
> > userspace can decide what information is needed to get sufficiently
> > unique information about the source filesystem.
> 
> Well, every file system that supports export ops already needs a
> globally unique ID for NFS to work properly.  We might not have good
> enough interfaces for that, but that shouldn't be too hard.

So as my research above shows, this ID is either manually configured in
/etc/exports or NFS server uses device number which is not guaranteed to be
persistent. Filesystems, at least currently, have no obligation to provide
anything (and some of them indeed don't provide any uuid or persistent
fsid). I guess that's the reason why mount ID is reported with
name_to_handle_at().

Don't get me wrong, I agree with your reservations towards mount ID (per
mount instead of per-sb, non-persistent) and I agree the properties you
describe are the golden standard we should strive for but I mainly wanted
to point out this is not reality today and in particular providing the
"persistency" guarantee of the filesystem ID may require on disk format
changes for some filesystems.

So returning the 64-bit mount ID from name_to_handle_at() weasels out of
these "how to identify arbitrary superblock" problems by giving userspace a
reasonably reliable way to generate this superblock identifier itself. I'm
fully open to less errorprone API for this but at this point I don't see it
so changing the mount ID returned from name_to_handle_at() to 64-bit unique
one seems like a sane practical choice to me...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

