Return-Path: <linux-fsdevel+bounces-33880-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1F49C0131
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 10:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B66751F2278E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 09:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551241DFDBB;
	Thu,  7 Nov 2024 09:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="H/wnFIW0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="I6ecOz4O";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="H/wnFIW0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="I6ecOz4O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1C91CC16C
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Nov 2024 09:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730972045; cv=none; b=d4+9LiAzWjeXrOhgXFSMTdyz+Z2rWPZu5jJkfcKvXLhw61Lr5UwU2M4GEWDk7AmihIClN7N5YrZ8TemPp/JOWShOymgzNc9t+WoOYF7Ifpp89yfy85j913lnKXQKBgzp6nZn3MIWHlqPTei10JZV6RRI5WqMcSr7nZQeRnHmcQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730972045; c=relaxed/simple;
	bh=09ACKYZ60Etkz52wdhJnjvnZNqL54BcI4BRNW/Ypvh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TYrm4NyJPMgv1UKF5AJIQVP4TpZgLaJrBFadoNT3klvU4VwD2hKtgMxboRvNhWl5jfJN7mIe5JHIYUN0rrXdCTe7m/bq3e7EVFlYyWsDg2a8RKrrqqFQnIECat67by8hGAVgKvlO+VMf9lPhuDZ9QWHtEApZfy0eJ3z91D/6J1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=H/wnFIW0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=I6ecOz4O; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=H/wnFIW0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=I6ecOz4O; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C2F1621B7A;
	Thu,  7 Nov 2024 09:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730972041; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Cyz80zlKqvV8nmLQQ9B2lpvFowV+vPiAW67TRxwxp7s=;
	b=H/wnFIW0nR/lzeUoCjDl/TOUQ/IJLWsG1wf9k5dWcIP7fwdNZZLI8e0oWcD5ISwaSnwlcN
	VJypAHtzVueVx9JA262fW6xXrHvI/h9wo46X9GgC+19g/cQSUUPdH+PwnckrFZ6UNp7XK4
	MAcK0ssxOEPH1XohTK4CfM3Eu+Tw0Js=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730972041;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Cyz80zlKqvV8nmLQQ9B2lpvFowV+vPiAW67TRxwxp7s=;
	b=I6ecOz4Opxiu4RTeQPnl7S/lGeTqDdNkAfrp+X932QeaEH/z9JcOYvLIa0G7ZXl3+MCQhT
	sTJmPg/E6jM0NRBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730972041; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Cyz80zlKqvV8nmLQQ9B2lpvFowV+vPiAW67TRxwxp7s=;
	b=H/wnFIW0nR/lzeUoCjDl/TOUQ/IJLWsG1wf9k5dWcIP7fwdNZZLI8e0oWcD5ISwaSnwlcN
	VJypAHtzVueVx9JA262fW6xXrHvI/h9wo46X9GgC+19g/cQSUUPdH+PwnckrFZ6UNp7XK4
	MAcK0ssxOEPH1XohTK4CfM3Eu+Tw0Js=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730972041;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Cyz80zlKqvV8nmLQQ9B2lpvFowV+vPiAW67TRxwxp7s=;
	b=I6ecOz4Opxiu4RTeQPnl7S/lGeTqDdNkAfrp+X932QeaEH/z9JcOYvLIa0G7ZXl3+MCQhT
	sTJmPg/E6jM0NRBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B9DB2139B3;
	Thu,  7 Nov 2024 09:34:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hu5XLYmJLGdndgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 07 Nov 2024 09:34:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 71ADBA0AF4; Thu,  7 Nov 2024 10:34:01 +0100 (CET)
Date: Thu, 7 Nov 2024 10:34:01 +0100
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] writeback: move wbc_attach_and_unlock_inode out of
 line
Message-ID: <20241107093401.rdc6ophq76iidgql@quack3>
References: <20241107072632.672795-1-hch@lst.de>
 <20241107072632.672795-3-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107072632.672795-3-hch@lst.de>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

I think the subject should rather have "move wbc_attach_fdatawrite_inode
out of line"...

On Thu 07-11-24 07:26:19, Christoph Hellwig wrote:
> This allows exporting this high-level interface only while keeping
> wbc_attach_and_unlock_inode private in fs-writeback.c and unexporting
> __inode_attach_wb.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Otherwise the patch looks good so feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

