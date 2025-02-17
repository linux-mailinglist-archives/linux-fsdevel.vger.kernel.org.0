Return-Path: <linux-fsdevel+bounces-41896-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3FCA38DF1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 22:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E165E169B93
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 21:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB91523A560;
	Mon, 17 Feb 2025 21:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="L86YPNKS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DWGvmnKn";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ao5vxJiL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ElbHV3LG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8C522B8A1
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Feb 2025 21:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739827466; cv=none; b=cD2jAnPeDSYQp0Gv3IJ7rhMlycnXE7rONvEzHQlIqzbTQsp7FFagb90q7zjv3KVsbdIr73u+QTNVhmR4Uq92IaBSDpjX62zSJuZhqYSCED3iOriQIvymUpQMG9xJpECMkKZ3yBVsjYBjJNIIkZ4crCBWGgc8W+vasN2QITMsfeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739827466; c=relaxed/simple;
	bh=tt+NJK5nQxgKW+KB993hAzHX8Tc/Mw7ryX7jpOR3FaU=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=R6WXLJKORvK4meryDE5AQfcFgWzDGR8s/ETUClHnXkXML2+DGfGv9/O5R4g+rw6jiLWruKZRBFSVAIxHfyGItY6Ikvp09rmd4lRUb1VH97g2kJ2SvJQDWqCZNFZxfLAMn/5Tk6FhqU53p8Iq+qDnL9mzJ5QKcWj50lw9iIQbcok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=L86YPNKS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DWGvmnKn; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ao5vxJiL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ElbHV3LG; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DB82C1F443;
	Mon, 17 Feb 2025 21:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739827462; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dlveDQrAnfTMK0qdtzIydX2OoEQGvqaMhg1QN8QjYTI=;
	b=L86YPNKS/IeNdaCEWLjzF3oCMzEPo2kqoYBEenDwXyYSi3qtgVXOBrmRmyD5AaCfeqZfPA
	YETL9I6sUzb0z6dD8YaWNGADOz3idcUxd/uBk38BZXekOigc4oWFEml5zk3OZumHRiSKdt
	Ev1eVcdyKVFKHO1eFWLqHbRlk5mR5p0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739827462;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dlveDQrAnfTMK0qdtzIydX2OoEQGvqaMhg1QN8QjYTI=;
	b=DWGvmnKnS7hy9Qlteej+QsPA975tdpsQwIjAFBwJVlOcTLxKGmueQTiT24HurYVerMXaOi
	EEgJ9ppWyThz1RAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ao5vxJiL;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ElbHV3LG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739827460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dlveDQrAnfTMK0qdtzIydX2OoEQGvqaMhg1QN8QjYTI=;
	b=ao5vxJiLWfM3zU1rcDpgEKZNeXJwUpzY6697nu6x0MVP2EVrP324qa62hPCrfV+08W4SX9
	MsEkeeg6bxJc5ylFmJupeHACLs9/5vsj8ruHBFjfLsK6cVccMWoP9G5qP+2WcxgyAxxeho
	oV3oSp6cBtVLaEiuRnjr3x5LGC1JSBU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739827460;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dlveDQrAnfTMK0qdtzIydX2OoEQGvqaMhg1QN8QjYTI=;
	b=ElbHV3LGXU+un1/fAiMmxs/O7AfXXLCzmu/pPqFrtaaTgegZfcIz8EuAS/3kXWTGmX1gwt
	FtJF+LSOGyrJ91CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F2E5A13485;
	Mon, 17 Feb 2025 21:24:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BYW+KQOps2eIHAAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 17 Feb 2025 21:24:19 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Dan Carpenter" <dan.carpenter@linaro.org>
Cc: linux-fsdevel@vger.kernel.org
Subject:
 Re: [bug report] VFS: add common error checks to lookup_one_qstr_excl()
In-reply-to: <2037958b-8b1a-4355-be22-294b782aac31@stanley.mountain>
References: <2037958b-8b1a-4355-be22-294b782aac31@stanley.mountain>
Date: Tue, 18 Feb 2025 08:24:15 +1100
Message-id: <173982745596.3118120.8498317331771966862@noble.neil.brown.name>
X-Rspamd-Queue-Id: DB82C1F443
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_TWO(0.00)[2];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,noble.neil.brown.name:mid];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, 17 Feb 2025, Dan Carpenter wrote:
> Hello NeilBrown,
> 
> Commit 22d9d5e93d0e ("VFS: add common error checks to
> lookup_one_qstr_excl()") from Feb 7, 2025 (linux-next), leads to the
> following Smatch static checker warning:
> 
> 	fs/namei.c:1696 lookup_one_qstr_excl()
> 	error: 'dentry' dereferencing possible ERR_PTR()
> 
> fs/namei.c
>   1671  struct dentry *lookup_one_qstr_excl(const struct qstr *name,
>   1672                                      struct dentry *base,
>   1673                                      unsigned int flags)
>   1674  {
>   1675          struct dentry *dentry = lookup_dcache(name, base, flags);
>   1676          struct dentry *old;
>   1677          struct inode *dir = base->d_inode;
>   1678  
>   1679          if (dentry)
>   1680                  goto found;
> 
> It looks like lookup_dcache() can return both error pointers and NULL.

Yes it can.

> 
>   1681  
>   1682          /* Don't create child dentry for a dead directory. */
>   1683          if (unlikely(IS_DEADDIR(dir)))
>   1684                  return ERR_PTR(-ENOENT);
>   1685  
>   1686          dentry = d_alloc(base, name);
>   1687          if (unlikely(!dentry))
>   1688                  return ERR_PTR(-ENOMEM);
>   1689  
>   1690          old = dir->i_op->lookup(dir, dentry, flags);
>   1691          if (unlikely(old)) {
>   1692                  dput(dentry);
>   1693                  dentry = old;
>   1694          }
>   1695  found:
>   1696          if (d_is_negative(dentry) && !(flags & LOOKUP_CREATE)) {
>                                   ^^^^^^
> Unchecked dereference.

so that is bad.  A corrected version was merged in the vfs tree a few
hours after this post.

Thanks for your ongoing service!

NeilBrown

> 
>   1697                  dput(dentry);
>   1698                  return ERR_PTR(-ENOENT);
>   1699          }
>   1700          if (d_is_positive(dentry) && (flags & LOOKUP_EXCL)) {
>   1701                  dput(dentry);
>   1702                  return ERR_PTR(-EEXIST);
>   1703          }
>   1704          return dentry;
>   1705  }
> 
> regards,
> dan carpenter
> 


