Return-Path: <linux-fsdevel+bounces-36419-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B06A9E3900
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 12:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AF1C285E18
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 11:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A7B1B3949;
	Wed,  4 Dec 2024 11:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZMTo/0yi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CcyQ4Olh";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZMTo/0yi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CcyQ4Olh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF7B1ADFF1;
	Wed,  4 Dec 2024 11:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733312230; cv=none; b=DofTQATIiaEhpfDtHLSO5agqUBjTr83qLS2+6jMHWoEXIxNzmT9i/3e2EQHzh5uZfwhknRPMuGR2LRIv4vZSuUNTnzZNctRrGYaUG1fKL+yVqhxBxCKBb7KsGzXhlyxUoyTzsNw3g9iLU9sAM9yMPWn2ZQAeMvgwg49MK3dXac0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733312230; c=relaxed/simple;
	bh=1YO2PntrIDCbifJgrs9ihNDbY95WySYJBi3hOGaNyvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iOBiK41BrfxtDgz/ppzOGe0WwH/MaaPkyqPG5QpBQLP4XTtdFgvK1cPu5WyxalHQ2Kq2YJpesX34SbShg4rpEeFFiweOsPs7fxkj12erCjgV14SAPprG0+idX4sbgM/qGzzRXPYkCLK9WsCeK2mBnDb6cuWkUoO2Hmuvv+5bzq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZMTo/0yi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CcyQ4Olh; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZMTo/0yi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CcyQ4Olh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 810901F38E;
	Wed,  4 Dec 2024 11:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733312226; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5vO78+wMZ9dV0QQjo3NmnQU7KTkxj4qpHIjvUKV8DP8=;
	b=ZMTo/0yiwHoAgb1+NVjwjVJ+Y5CrLIRrixW/uVdwCksZHqq/UKiqWOq9Cu4x3DE59KHtUM
	thfTY94Phgf3Pe0yHcG056eQNFnIPfvzVmSGjYPmykgRuEYPCkgxsqbSBmlfvJt5RPjFIy
	7gULErcYzRBrVTHwOiOP78TB9+r15A0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733312226;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5vO78+wMZ9dV0QQjo3NmnQU7KTkxj4qpHIjvUKV8DP8=;
	b=CcyQ4Olh34n20LNBDt6NsEznSmuZ1GIA5WJgdOg/Y1BEFHz21ahx+QATE8pt+C8RAGqtXl
	SiB8hznXYq3vuWDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="ZMTo/0yi";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=CcyQ4Olh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733312226; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5vO78+wMZ9dV0QQjo3NmnQU7KTkxj4qpHIjvUKV8DP8=;
	b=ZMTo/0yiwHoAgb1+NVjwjVJ+Y5CrLIRrixW/uVdwCksZHqq/UKiqWOq9Cu4x3DE59KHtUM
	thfTY94Phgf3Pe0yHcG056eQNFnIPfvzVmSGjYPmykgRuEYPCkgxsqbSBmlfvJt5RPjFIy
	7gULErcYzRBrVTHwOiOP78TB9+r15A0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733312226;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5vO78+wMZ9dV0QQjo3NmnQU7KTkxj4qpHIjvUKV8DP8=;
	b=CcyQ4Olh34n20LNBDt6NsEznSmuZ1GIA5WJgdOg/Y1BEFHz21ahx+QATE8pt+C8RAGqtXl
	SiB8hznXYq3vuWDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 701A01396E;
	Wed,  4 Dec 2024 11:37:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gOZZG+I+UGdDFgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 04 Dec 2024 11:37:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1FBB5A0918; Wed,  4 Dec 2024 12:36:58 +0100 (CET)
Date: Wed, 4 Dec 2024 12:36:58 +0100
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
	hch@infradead.org, djwong@kernel.org, david@fromorbit.com,
	zokeefe@google.com, yi.zhang@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH 04/27] ext4: refactor ext4_punch_hole()
Message-ID: <20241204113658.y4usar2p6rlndglc@quack3>
References: <20241022111059.2566137-1-yi.zhang@huaweicloud.com>
 <20241022111059.2566137-5-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022111059.2566137-5-yi.zhang@huaweicloud.com>
X-Rspamd-Queue-Id: 810901F38E
X-Spam-Level: 
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,infradead.org,kernel.org,fromorbit.com,google.com,huawei.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,suse.com:email,suse.cz:dkim]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.51
X-Spam-Flag: NO

On Tue 22-10-24 19:10:35, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> The current implementation of ext4_punch_hole() contains complex
> position calculations and stale error tags. To improve the code's
> clarity and maintainability, it is essential to clean up the code and
> improve its readability, this can be achieved by: a) simplifying and
> renaming variables; b) eliminating unnecessary position calculations;
> c) writing back all data in data=journal mode, and drop page cache from
> the original offset to the end, rather than using aligned blocks,
> d) renaming the stale error tags.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Again, this should get slightly simplified with the new function (no need
for special data=journal handling) but overall it looks fine.

> -out_dio:
> +out_invalidate_lock:
>  	filemap_invalidate_unlock(mapping);
> -out_mutex:
> +out:
>  	inode_unlock(inode);
>  	return ret;
>  }

I agree with Darrick that just 'out' is not a great name when we are
actually releasing inode->i_rwsem. So perhaps "out_inode_lock:"?

							Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

