Return-Path: <linux-fsdevel+bounces-42689-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CA2A462F2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 15:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79FA77A592E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 14:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E14E221DA0;
	Wed, 26 Feb 2025 14:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jeHEbhOA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RMzxU6tW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jeHEbhOA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RMzxU6tW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679A51A238B
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Feb 2025 14:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740580317; cv=none; b=rn5fTX6Jj9sNstPuT7OQ7vw9oM0Os2eOBL+O8B6IlNy0bxhEZdaRDAKFoqHHuUPDAvA1VoNuWApDjIciWhAJzkNhmS39rv5Y7TFZd+dQfnopCd2BLP16fXzGP2mMsjpkJKIH+LrZgBsP/vs8sprkavbkB3WG4PdPgVF2bH6/z3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740580317; c=relaxed/simple;
	bh=h6wwG6GSEljrhPjukMtz9RNIqQTST7OvilmbN7/DWNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kFeqSBVFBuYCYqPwp+6faI0NNiuno/c0+RFOsVHOJdLyn6cB7rcv5LLQ7aPViUnwtKz2d9KQ1A0FbliH5ozaN1IOTMn1Ux1frbTHG+sn4NN9HvK/Q2YMngRqaHWDL9bjdX7UDSSCXg9MZNBAWpsNnGU/sQds0Urzf1C/p5Xo/pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jeHEbhOA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RMzxU6tW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jeHEbhOA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RMzxU6tW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8AD5D2116B;
	Wed, 26 Feb 2025 14:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740580314;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p0GJWkQqiG58Mx7MIdGhMtpBZe86zPEQoq1/4+3yfEg=;
	b=jeHEbhOAwrVAZk/xajjkysJlmAsjlaV7Q/7JCPrUfjeeJoy3Z+EPGtf9qZDUnkTuS4HE+z
	KjEOEsyE8AsbVYKKt+LUrz97q24w4N1Ne4LGhJUZ2T+g5VG9Qgn6xX5klaB5gG1PVsu7N5
	pcIBZiyFADOxOEARuY8nJfMjEXCCJfY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740580314;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p0GJWkQqiG58Mx7MIdGhMtpBZe86zPEQoq1/4+3yfEg=;
	b=RMzxU6tWi+82GAn68kLlDDVb6be02boRgoIN9Q00snCpqIgW835qpC8I7ZB9RzNamhwyY3
	4eQQxaF311pAm+Ag==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740580314;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p0GJWkQqiG58Mx7MIdGhMtpBZe86zPEQoq1/4+3yfEg=;
	b=jeHEbhOAwrVAZk/xajjkysJlmAsjlaV7Q/7JCPrUfjeeJoy3Z+EPGtf9qZDUnkTuS4HE+z
	KjEOEsyE8AsbVYKKt+LUrz97q24w4N1Ne4LGhJUZ2T+g5VG9Qgn6xX5klaB5gG1PVsu7N5
	pcIBZiyFADOxOEARuY8nJfMjEXCCJfY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740580314;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p0GJWkQqiG58Mx7MIdGhMtpBZe86zPEQoq1/4+3yfEg=;
	b=RMzxU6tWi+82GAn68kLlDDVb6be02boRgoIN9Q00snCpqIgW835qpC8I7ZB9RzNamhwyY3
	4eQQxaF311pAm+Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6FE701377F;
	Wed, 26 Feb 2025 14:31:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UUcWG9olv2fURQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 26 Feb 2025 14:31:54 +0000
Date: Wed, 26 Feb 2025 15:31:48 +0100
From: David Sterba <dsterba@suse.cz>
To: Simon Tatham <anakin@pobox.com>
Cc: David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] affs: generate OFS sequence numbers starting at 1
Message-ID: <20250226143148.GT5777@suse.cz>
Reply-To: dsterba@suse.cz
References: <20250220081444.3625446-1-anakin@pobox.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220081444.3625446-1-anakin@pobox.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.993];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:mid];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Thu, Feb 20, 2025 at 08:14:43AM +0000, Simon Tatham wrote:
> If I write a file to an OFS floppy image, and try to read it back on
> an emulated Amiga running Workbench 1.3, the Amiga reports a disk
> error trying to read the file. (That is, it's unable to read it _at
> all_, even to copy it to the NIL: device. It isn't a matter of getting
> the wrong data and being unable to parse the file format.)
> 
> This is because the 'sequence number' field in the OFS data block
> header is supposed to be based at 1, but affs writes it based at 0.
> All three locations changed by this patch were setting the sequence
> number to a variable 'bidx' which was previously obtained by dividing
> a file position by bsize, so bidx will naturally use 0 for the first
> block. Therefore all three should add 1 to that value before writing
> it into the sequence number field.
> 
> With this change, the Amiga successfully reads the file.
> 
> Signed-off-by: Simon Tatham <anakin@pobox.com>

Thanks for the fixes, I'll send them for merge soon and to stable as
well as they're both real fixes. I found the sequence documented at
https://wiki.osdev.org/FFS_(Amiga) so I added the reference to the
changelog.

