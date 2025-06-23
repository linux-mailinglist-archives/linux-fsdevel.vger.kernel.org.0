Return-Path: <linux-fsdevel+bounces-52539-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F6CAE3EB6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 13:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 873FF18886E2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 11:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0331ACEDE;
	Mon, 23 Jun 2025 11:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LVvd4gMb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QFlStjea";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LVvd4gMb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QFlStjea"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA82823E359
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 11:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750679742; cv=none; b=GyZPiWMXgPNrwA8ZdmUBU2vYz8riAK2ZezkWWhY3zK90/buhjQ/lpKi90PXNDgzkMUAUBu4aDNaFfUeHwMPulKg6zRzVwT+/tfEAbN4XPdCur5OyeYe6q/vicNBsHE8EuI/pWdm1NIipJV+7K+wN2pzDsp556ba/xA2m4jyKPKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750679742; c=relaxed/simple;
	bh=T6z99fyMjETvJ/QQzvN1xC+BLTfP/mWolOyyqKS4+Es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GrYNXTXfYWyzQbpUvro/4WXM+eU5eudCpLQzMoiGYcmAcjSSVMlY56CAAaH4iOefuIG49Xj5A9QXgNRsevN2+huEd0pDBBGXfK/BKkH1z1vP7A7qrJLumxIa5HH2luKX/Ew06cFp4u01CV1Xua+tbRkRms0I3CL3V+Ii93MI/Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LVvd4gMb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QFlStjea; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LVvd4gMb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QFlStjea; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0861C1F391;
	Mon, 23 Jun 2025 11:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750679739; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7B/TKfZCRbhSJC7+UTH+wbsWKreirBzqqOLM6qLeAHc=;
	b=LVvd4gMbY3E4+4R9DQRLHACx5FXOjGU9181xxBEoUCzvyTvqAxYd/9+j7QUMWG8rnx4wCJ
	U4K7laAhAkK2RDdvJMbdfTJuR6OeBoWruDqjr3sTpOkMjJYyXb184Ebjw5hur1O8hLIbPt
	EAg86wHYAAD+Uaf2zWQFDvvysiHn4EY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750679739;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7B/TKfZCRbhSJC7+UTH+wbsWKreirBzqqOLM6qLeAHc=;
	b=QFlStjeaaUSeFY41uFvF+b2Xff1hwFNpiQDZ3JWFQtbbZNeo9brPUoHIti++oXQxpIC0iN
	J+IFxTLPcm0AvwDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750679739; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7B/TKfZCRbhSJC7+UTH+wbsWKreirBzqqOLM6qLeAHc=;
	b=LVvd4gMbY3E4+4R9DQRLHACx5FXOjGU9181xxBEoUCzvyTvqAxYd/9+j7QUMWG8rnx4wCJ
	U4K7laAhAkK2RDdvJMbdfTJuR6OeBoWruDqjr3sTpOkMjJYyXb184Ebjw5hur1O8hLIbPt
	EAg86wHYAAD+Uaf2zWQFDvvysiHn4EY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750679739;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7B/TKfZCRbhSJC7+UTH+wbsWKreirBzqqOLM6qLeAHc=;
	b=QFlStjeaaUSeFY41uFvF+b2Xff1hwFNpiQDZ3JWFQtbbZNeo9brPUoHIti++oXQxpIC0iN
	J+IFxTLPcm0AvwDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ED62F13AC4;
	Mon, 23 Jun 2025 11:55:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4uvsObpAWWjpNwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 23 Jun 2025 11:55:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 31F3BA0951; Mon, 23 Jun 2025 13:55:38 +0200 (CEST)
Date: Mon, 23 Jun 2025 13:55:38 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 6/9] exportfs: add FILEID_PIDFS
Message-ID: <y6yp3ldhmmtl6mzr2arwr5fggzrlffc2pzvqbr7jkabqm5zm3u@6pwl22ctaxkx>
References: <20250623-work-pidfs-fhandle-v1-0-75899d67555f@kernel.org>
 <20250623-work-pidfs-fhandle-v1-6-75899d67555f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623-work-pidfs-fhandle-v1-6-75899d67555f@kernel.org>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,oracle.com,suse.cz,gmail.com,ffwll.ch,vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Mon 23-06-25 11:01:28, Christian Brauner wrote:
> Introduce new pidfs file handle values.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  include/linux/exportfs.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> index 25c4a5afbd44..45b38a29643f 100644
> --- a/include/linux/exportfs.h
> +++ b/include/linux/exportfs.h
> @@ -99,6 +99,11 @@ enum fid_type {
>  	 */
>  	FILEID_FAT_WITH_PARENT = 0x72,
>  
> +	/*
> +	 * 64 bit inode number.
> +	 */
> +	FILEID_INO64 = 0x80,
> +
>  	/*
>  	 * 64 bit inode number, 32 bit generation number.
>  	 */
> @@ -131,6 +136,12 @@ enum fid_type {
>  	 * Filesystems must not use 0xff file ID.
>  	 */
>  	FILEID_INVALID = 0xff,
> +
> +	/* Internal kernel fid types */
> +
> +	/* pidfs fid types */
> +	FILEID_PIDFS_FSTYPE = 0x100,
> +	FILEID_PIDFS = FILEID_PIDFS_FSTYPE | FILEID_INO64,

What is the point behind having FILEID_INO64 and FILEID_PIDFS separately?
Why not just allocate one value for FILEID_PIDFS and be done with it? Do
you expect some future extensions for pidfs?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

