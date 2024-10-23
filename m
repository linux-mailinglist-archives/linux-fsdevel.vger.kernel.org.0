Return-Path: <linux-fsdevel+bounces-32628-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9873D9ABAAC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 02:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7C5A1C20C41
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 00:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2ACA1C687;
	Wed, 23 Oct 2024 00:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lwoc7yo8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mJeezreo";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lwoc7yo8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mJeezreo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC656381B9;
	Wed, 23 Oct 2024 00:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729644594; cv=none; b=nZiI+EV8S+TBkkl7X0wJ/kzYUGHdvGdRuMkzIkUy04jbTigmI8uNJpGKyJts4fUJuFBlKLKIXhkpZckhFMlC2pMCmV1n7YkZUbexxwlMHN3sHER6SsJzYbBAL+tGOQveyBr1x+7S390O7xO3xEEvntHFV6ng4owwpp2m7OykkcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729644594; c=relaxed/simple;
	bh=1H70krAFFQnKSMTdlulrx+xU/B8GJ1UDxaR4z5z72yU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cszTpsqlt9Z01hHCtduccmUkoUYrM1RGndh97zxHDOBHuKaO87PAOlLSdn75+6lM8hxQ2x9ObdK177jRQESWycdn8xHFNh1veYNQuMNyJOUAkMl8N6NITLCwq1ypn96gLkVCirF+5Myp9ZksPbFe1JOpDCA5/lJnNF202ExXJ1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lwoc7yo8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mJeezreo; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lwoc7yo8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mJeezreo; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 109CB21CA1;
	Wed, 23 Oct 2024 00:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729644591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z9UnB97aT5chZUB6SsFs3xGInYZMzx2XkbtIvLb1OS0=;
	b=lwoc7yo8Uyg/wB2NendbgT9LkyhLsE078bGJbW/CuVJzTfOsaJiERLS+i8TBmhCQynzLx6
	tDO+LU0QM0fjn0gevQ9b3wIjUP6TNz+V/X6KsMLqfSeS/8t0bRjHjkgoKcgSjA0f5xC89Q
	qpKNBFWyf2WRvPAZtMtzKOJHP4UxTTk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729644591;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z9UnB97aT5chZUB6SsFs3xGInYZMzx2XkbtIvLb1OS0=;
	b=mJeezreopOgO4lktUXkh5CsZKpaUZ/His6+18Q67/ni13W26yVgnj9PNkhOIv2jdBo08Ek
	9jExaY9ADA3QDRDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729644591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z9UnB97aT5chZUB6SsFs3xGInYZMzx2XkbtIvLb1OS0=;
	b=lwoc7yo8Uyg/wB2NendbgT9LkyhLsE078bGJbW/CuVJzTfOsaJiERLS+i8TBmhCQynzLx6
	tDO+LU0QM0fjn0gevQ9b3wIjUP6TNz+V/X6KsMLqfSeS/8t0bRjHjkgoKcgSjA0f5xC89Q
	qpKNBFWyf2WRvPAZtMtzKOJHP4UxTTk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729644591;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z9UnB97aT5chZUB6SsFs3xGInYZMzx2XkbtIvLb1OS0=;
	b=mJeezreopOgO4lktUXkh5CsZKpaUZ/His6+18Q67/ni13W26yVgnj9PNkhOIv2jdBo08Ek
	9jExaY9ADA3QDRDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9A37813A63;
	Wed, 23 Oct 2024 00:49:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TV/UGS5IGGc0HQAAD6G6ig
	(envelope-from <rgoldwyn@suse.de>); Wed, 23 Oct 2024 00:49:50 +0000
Date: Tue, 22 Oct 2024 20:49:40 -0400
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	gfs2@lists.linux.dev, linux-block@vger.kernel.org
Subject: Re: [PATCH] iomap: writeback_control pointer part of
 iomap_writepage_ctx
Message-ID: <4xccx2qgkqkncwtpgrfdfyzrwcv6xssgnaxsyvpasd43rcb33x@pxf33u4kryz6>
References: <326b2b66114c97b892dbcf83f3d41b86c64e93d6.1729266269.git.rgoldwyn@suse.com>
 <Zxc8awN_MHkuNhQZ@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zxc8awN_MHkuNhQZ@infradead.org>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.995];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_FIVE(0.00)[5]
X-Spam-Flag: NO
X-Spam-Level: 

On 22:47 21/10, Christoph Hellwig wrote:
> On Fri, Oct 18, 2024 at 11:55:50AM -0400, Goldwyn Rodrigues wrote:
> > Reduces the number of arguments to functions iomap_writepages() and
> > all functions in the writeback path which require both wpc and wbc.
> > The filesystems need to initialize wpc with wbc before calling
> > iomap_writepages().
> 
> While this looks obviously correct, I'm not sure what the point of
> it is as it adds slightly more lines of code.  Does it generate
> better binary code?  Do you have future changes that depend on it?
> 

No future updates depending on it. It just makes the code
more readable.

No point bouncing two pointers to different functions in the write-
back path, when one can be encompassed into another.

-- 
Goldwyn

