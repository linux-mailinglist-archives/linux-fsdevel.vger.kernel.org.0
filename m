Return-Path: <linux-fsdevel+bounces-70362-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DDBC9887C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 18:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AC3E3A1E9B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 17:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39710338582;
	Mon,  1 Dec 2025 17:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="P6WCAhlN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sY4RuH/C";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="P6WCAhlN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sY4RuH/C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACE4333727
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Dec 2025 17:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764610270; cv=none; b=lGXIsNuq31BbvSfC8M9oi3O/Gm3UUr+3Rdry7KlSvEGaxRAisnSpKvhvbsK2oFneZlKowDSv55gk4Zy/WgX65yVxSGzCqK3AU7TRw9BZ4job+th+UC+ll5QTnLrsnDbs1ptGuW/OtUOMKfpOAlvOMitW92LEJZOT0E0/DwrEXgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764610270; c=relaxed/simple;
	bh=pu+jMMpeMknGdHeJNUf68+gKXCujJzPFaVBQiESw9hE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NOYnu7oecqM6q1Fr1hpi6K0n02syfxb0Rx++0dnHzh4yeHhLL6ijh+4DJF/5WsEtJ1Lj5Ymh2ny4Phs0J4eWFA4/aBqhexRVxOEdyf3aV8XgFgOG49vpG7GSrBges895fmSTVXAHbO6xLggvxtuIu3NqY8So0v02/JzYeNZkfjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=P6WCAhlN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sY4RuH/C; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=P6WCAhlN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sY4RuH/C; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DB2F1336AE;
	Mon,  1 Dec 2025 17:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764610266; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z3S6YmQ2M6cWyEGT8MCDK9fjuDlng3/C8Vcn4xHul4A=;
	b=P6WCAhlN9rcdyQfHLc414EO7HoTrI/z1rDDUBzxYEAxa2wWL52IAHKxqK9jJNrvVFqyT2a
	eAxACdlcAIdpnx9yMr3qbevYt8t9So8F6kLwXSF5tX9ZKJJBTgCW/cUey4FMU3OFaOUT+O
	jBDhr9kpPsvtAbsnv/li8J+AV302HNI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764610266;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z3S6YmQ2M6cWyEGT8MCDK9fjuDlng3/C8Vcn4xHul4A=;
	b=sY4RuH/CvuB5afanhTF9Y+Zh2DvXtZjLTgNu8BaqheSFF4ESvFCcfYpb1KUeGajZ4mg3aS
	CjqjqOSlPMnpaYDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764610266; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z3S6YmQ2M6cWyEGT8MCDK9fjuDlng3/C8Vcn4xHul4A=;
	b=P6WCAhlN9rcdyQfHLc414EO7HoTrI/z1rDDUBzxYEAxa2wWL52IAHKxqK9jJNrvVFqyT2a
	eAxACdlcAIdpnx9yMr3qbevYt8t9So8F6kLwXSF5tX9ZKJJBTgCW/cUey4FMU3OFaOUT+O
	jBDhr9kpPsvtAbsnv/li8J+AV302HNI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764610266;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z3S6YmQ2M6cWyEGT8MCDK9fjuDlng3/C8Vcn4xHul4A=;
	b=sY4RuH/CvuB5afanhTF9Y+Zh2DvXtZjLTgNu8BaqheSFF4ESvFCcfYpb1KUeGajZ4mg3aS
	CjqjqOSlPMnpaYDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5D4DA3EA63;
	Mon,  1 Dec 2025 17:31:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9ZvVCNrQLWkIEgAAD6G6ig
	(envelope-from <ematsumiya@suse.de>); Mon, 01 Dec 2025 17:31:06 +0000
Date: Mon, 1 Dec 2025 14:30:59 -0300
From: Enzo Matsumiya <ematsumiya@suse.de>
To: David Howells <dhowells@redhat.com>
Cc: Paulo Alcantara <pc@manguebit.org>, Steve French <sfrench@samba.org>, 
	Shyam Prasad N <sprasad@microsoft.com>, Stefan Metzmacher <metze@samba.org>, linux-cifs@vger.kernel.org, 
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Can we sort out the prototypes within the cifs headers?
Message-ID: <qvtkweac7g5ejiicsnb7cqxlxl35toi2ykdmguaszqkcnir355@zvaw3oxlxzex>
References: <1430101.1764595523@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1430101.1764595523@warthog.procyon.org.uk>
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUBJECT_ENDS_QUESTION(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.80

Hi David,

On 12/01, David Howells wrote:
>Hi Paulo, Enzo, et al.,
>
>You may have seen my patch:
>
>	https://lore.kernel.org/linux-cifs/20251124124251.3565566-4-dhowells@redhat.com/T/#u
>
>to sort out the cifs header file prototypes, which are a bit of a mess: some
>seem to have been placed haphazardly in the headers, some have unnamed
>arguments and also sometimes the names in the .h and the .c don't match.
>
>Now Steve specifically namechecked you two as this will affect the backporting
>of patches.  Whilst this only affects the prototypes in the headers and not
>the implementations in C files, it does cause chunks of the headers to move
>around.
>
>Can we agree on at least a subset of the cleanups to be made?  In order of
>increasing conflictiveness, I have:
>
> (1) Remove 'extern'.  cifs has a mix of externed and non-externed, but the
>     documented approach is to get rid of externs on prototypes.
>
> (2) (Re)name the arguments in the prototypes to be the same as in the
>     implementations.
>
> (3) Adjust the layout of each prototype to match the implementation, just
>     with a semicolon on the end.  My script partially does this, but moves
>     the return type onto the same line as the function name.
>
> (4) Move SMB1-specific functions out to smb1proto.h.  Move SMB2/3-specific
>     functions out to smb2proto.h.
>
> (5) Divide the lists of prototypes (particularly the massive one in
>     cifsproto.h) up into blocks according to which .c file contains the
>     implementation and preface each block with a comment that indicates the
>     name of the relevant .c file.
>
>     The comment could then be used as a key for the script to maintain the
>     division in future.
>
> (6) Sort each block by position in the .c file to make it easier to maintain
>     them.
>
>A hybrid approach is also possible, where we run the script to do the basic
>sorting and then manually correct the output.

+1 for the cleanups, thanks for doing that.

On backports, I think points 1-3 could be done together, but in separate
commits (per header file) to minimise conflicts.

4 looks good to have.

5-6 would be most problematic (moving code around).

Not sure what else to say here, but more atomic commit are easier to
backport than big/monolithic ones.


Cheers,

Enzo

