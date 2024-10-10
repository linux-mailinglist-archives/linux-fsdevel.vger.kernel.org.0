Return-Path: <linux-fsdevel+bounces-31619-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA057998F83
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 20:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A19A286FD5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 18:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875CE1C9EBB;
	Thu, 10 Oct 2024 18:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GHIKNQ2S";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="R/uGGF6O";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GHIKNQ2S";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="R/uGGF6O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2F4198831;
	Thu, 10 Oct 2024 18:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728583970; cv=none; b=nIUYr/IpH1nSUrm6AJWPWLmBvai6qucS/hMBDDxIGKGuT3ynFbHtDWuxLIvJxgF3fgyrG5oMHSnD1sr0QOHl2jRbL0tkoXoT5qEOqRFcYEvo8qpyaE9kfEthw4b/foh6cZhK3ErgWH4ROOXgBiXov1+TF8Cjw9RF3vNbOm1b/ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728583970; c=relaxed/simple;
	bh=MeLT9On91Emxdpz2vM4qOLD/wTXoFMl1V2LZJC5eFEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/kVahQoXCwWEAQPIrbvljHBAlHldU4ND8jmgJYaeT9yfs3UREIRSJ4rzJMxfwWrFETiZOA82I+rnuiDFkBW/jS3L3sywGMyFUBzzA3tfNEEDiYNOdH4nHAoOp4iX0Bsr5xcNZ8xvHKyzXH35ZdVpddnb/9HQ0iGMS6AtLcb1cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GHIKNQ2S; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=R/uGGF6O; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GHIKNQ2S; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=R/uGGF6O; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 37D9D1F7CA;
	Thu, 10 Oct 2024 18:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728583964; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jA41+oHeNzNXX8wZAt3OyU0/Uvd/fsqUXfwDVqkoiaU=;
	b=GHIKNQ2SSSEv8P6wDvwVxbKIlYNa2QC7Rx7308haSY1Ac60eOzlINNouJruR6Cero/Xcgj
	7QX++4UtfHrNtzDeJ2bdW+hCM3c8WRCsZKE60bdelZNdDYDjEJUIyd7Wt1Ld6ZkUjvCupZ
	OP93e50VavKs/5tkvx7sRHITEtOUdPs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728583964;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jA41+oHeNzNXX8wZAt3OyU0/Uvd/fsqUXfwDVqkoiaU=;
	b=R/uGGF6Oa8Lh7abi4sgTD5cnmC8gDZFwfba+AddlwfkXD0rwu+H4FRtaGA4bDoOSrHEMDi
	z6U/gpOcqC+MWACA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=GHIKNQ2S;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="R/uGGF6O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728583964; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jA41+oHeNzNXX8wZAt3OyU0/Uvd/fsqUXfwDVqkoiaU=;
	b=GHIKNQ2SSSEv8P6wDvwVxbKIlYNa2QC7Rx7308haSY1Ac60eOzlINNouJruR6Cero/Xcgj
	7QX++4UtfHrNtzDeJ2bdW+hCM3c8WRCsZKE60bdelZNdDYDjEJUIyd7Wt1Ld6ZkUjvCupZ
	OP93e50VavKs/5tkvx7sRHITEtOUdPs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728583964;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jA41+oHeNzNXX8wZAt3OyU0/Uvd/fsqUXfwDVqkoiaU=;
	b=R/uGGF6Oa8Lh7abi4sgTD5cnmC8gDZFwfba+AddlwfkXD0rwu+H4FRtaGA4bDoOSrHEMDi
	z6U/gpOcqC+MWACA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 03B061370C;
	Thu, 10 Oct 2024 18:12:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PUK1NhsZCGdCLQAAD6G6ig
	(envelope-from <rgoldwyn@suse.de>); Thu, 10 Oct 2024 18:12:43 +0000
Date: Thu, 10 Oct 2024 14:12:38 -0400
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/12] iomap: include iomap_read_end_io() in header
Message-ID: <6zrqn4wicahjhfig6mgs45f3c7qq4xh3z7l5hgux6nmcf6w3gs@obvj4myhvavd>
References: <cover.1728071257.git.rgoldwyn@suse.com>
 <b608329aef0841544f380acede9252caf10a48c6.1728071257.git.rgoldwyn@suse.com>
 <20241007170217.GD21836@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007170217.GD21836@frogsfrogsfrogs>
X-Rspamd-Queue-Id: 37D9D1F7CA
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 10:02 07/10, Darrick J. Wong wrote:
> On Fri, Oct 04, 2024 at 04:04:31PM -0400, Goldwyn Rodrigues wrote:
> > From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > 
> > iomap_read_end_io() will be used BTRFS after it has completed the reads
> > to handle control back to iomap to finish reads on all folios.
> 
> That probably needs EXPORT_SYMBOL_GPL if btrfs is going to use it,
> right?

Yes! I got a warning from kernel test robot as well!

Note to self: Stop building all modules in the kernel for testing.

-- 
Goldwyn

