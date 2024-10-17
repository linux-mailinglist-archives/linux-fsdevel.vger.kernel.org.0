Return-Path: <linux-fsdevel+bounces-32182-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E49E29A1F3C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 11:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B6FBB26A0A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 09:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F171D95AB;
	Thu, 17 Oct 2024 09:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="T0f9Qkf/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gQxyNH32";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="b1IOpBl7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NrAZ6Bof"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8C2199E92;
	Thu, 17 Oct 2024 09:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729159126; cv=none; b=afAoOO2vwR0TCrClo2QUzVTwI5AQWmkw5kBZh9x54HyHsySl/vuPMHQ3O68yJnaL5f3DxTIb4XmFd3EeuW0UaukYzpQrbLvpqgc6LO3FjborpOBbL2UOtOjPTDx5KG3KYySMYeoZYjbbsPNIjx+qvx2C22jm9OdrdDXmIp5U+Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729159126; c=relaxed/simple;
	bh=V9eeRUm0jZ/MTPGmK3OFVCtMJbZkpqSZA/9diiUC8GQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PHQgnorynNXEGkzZ2af8dXzhU6qWxE8igFsTbUqSYUaAJUvKASM5tM+/Q0rfcDtL+nbzLpURHoKMezVmWnpeAtYZ5tOoEpiJma3FKvWnyymqeOppLurcWt8ztVSXnZyAwmgtsou85fUmhfT+DwcPK7b6gM0aOACFRtpq4VAiCtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=T0f9Qkf/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gQxyNH32; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=b1IOpBl7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NrAZ6Bof; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7BB441FD12;
	Thu, 17 Oct 2024 09:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729159121; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pM5umWXI+jLD/3ESY5D0uj7lba9PavrHvD7DoNE7JZ8=;
	b=T0f9Qkf/VcrVKtwTyAC/YVuWilQ7C+XJWmYSjSXAa3Q27CLK2NEr4XVxL7wTkzwpE3c2AL
	6ZUxqanpz+se2/RuQAhvwVtMK/SDgyd+VfbM9pcuuZFePrT7fTTgFBGPpJ3SSaggOxwPEl
	nhflJOp3Meg4L6ng9+n/YyiWqDWsbtA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729159121;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pM5umWXI+jLD/3ESY5D0uj7lba9PavrHvD7DoNE7JZ8=;
	b=gQxyNH32lWvzJ4rCFUBKbYN2yUCx6t9NKSfpycBjjIwSPcDLW2aWM8J0IdRJ2+BU6MqWEx
	wfsoEofpiicvxtBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=b1IOpBl7;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=NrAZ6Bof
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729159120; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pM5umWXI+jLD/3ESY5D0uj7lba9PavrHvD7DoNE7JZ8=;
	b=b1IOpBl7h6oBBMhaPGneQQ6pMtMIyS/m31NLL2H+kxIJVlgtSEA8NiC0J4WDLUnVlfzFiX
	6qvEOs2NKrLD340tLh6tstUc9rsamu+FIWnkE3MpH2zNwAGHhvxIhol0GHnkWDJvR3IgdN
	Mq/C9qPZksBtWk7MmVcQvKSQ/O+YnXY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729159120;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pM5umWXI+jLD/3ESY5D0uj7lba9PavrHvD7DoNE7JZ8=;
	b=NrAZ6Boft1OB4I6J9t7IwhkgVb+fiS/oz0rgcFj/c6DYBjTKvICMYWDpp3aCqBEiFZfYy/
	q8KadKGvE5FVagDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 628C913A53;
	Thu, 17 Oct 2024 09:58:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bNYMGNDfEGdRUwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 17 Oct 2024 09:58:40 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 118B9A07D0; Thu, 17 Oct 2024 11:58:36 +0200 (CEST)
Date: Thu, 17 Oct 2024 11:58:36 +0200
From: Jan Kara <jack@suse.cz>
To: Alessandro Zanni <alessandro.zanni87@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	anupnewsmail@gmail.com, alessandrozanni.dev@gmail.com,
	syzbot+6c55f725d1bdc8c52058@syzkaller.appspotmail.com
Subject: Re: [PATCH] fs: Fix uninitialized value issue in from_kuid
Message-ID: <20241017095836.ebrfj2323h4sn5xx@quack3>
References: <20241016123723.171588-1-alessandro.zanni87@gmail.com>
 <20241016132339.cq5qnklyblfxw4xl@quack3>
 <20241016-einpacken-ebnen-bcd0924480e1@brauner>
 <5lnqirv3cia7cqnjfjp4ypjlpppkx6do5ds5yexzxrtkoct5bm@zjdp32invihk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5lnqirv3cia7cqnjfjp4ypjlpppkx6do5ds5yexzxrtkoct5bm@zjdp32invihk>
X-Rspamd-Queue-Id: 7BB441FD12
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
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[10];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[6c55f725d1bdc8c52058];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	FREEMAIL_CC(0.00)[kernel.org,suse.cz,zeniv.linux.org.uk,vger.kernel.org,linuxfoundation.org,gmail.com,syzkaller.appspotmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.51
X-Spam-Flag: NO

On Thu 17-10-24 11:22:17, Alessandro Zanni wrote:
> On 24/10/16 04:52, Christian Brauner wrote:
> > On Wed, Oct 16, 2024 at 03:23:39PM +0200, Jan Kara wrote:
> > > That being said there are many more places calling notify_change() and none
> > > of them is doing the initialization so this patch only fixes that one
> > > particular syzbot reproducer but doesn't really deal with the problem.
> > > Looking at the bigger picture I think the right solution really is to fix
> > > ocfs2_setattr() to not touch attr->ia_uid when ATTR_UID isn't set and
> > > similarly for attr->ia_gid and ATTR_GID.
> > 
> > Yes, that's what we did for similar bugs.
> 
> Thanks for the valuable comments.
> 
> I digged more into the code. I think the two possible fixes are: 
> i) return 0 from ocfs2_setattr() if ATTR_UID/ATTR_GID are not set
> ii) enter in trace_ocfs2_setattr() only if ATTR_UID/ATTR_GID are set
> 
> What do you think?

I think the easiest fix is like:

        trace_ocfs2_setattr(inode, dentry,
                            (unsigned long long)OCFS2_I(inode)->ip_blkno,
                            dentry->d_name.len, dentry->d_name.name,
-                           attr->ia_valid, attr->ia_mode,
-                           from_kuid(&init_user_ns, attr->ia_uid),
-                           from_kgid(&init_user_ns, attr->ia_gid));
+                           attr->ia_valid,
+			    attr->ia_valid & ATTR_MODE ? attr->ia_mode : 0,
+                           attr->ia_valid & ATTR_UID ? from_kuid(&init_user_ns, attr->ia_uid) : 0,
+                           attr->ia_valid & ATTR_GID ? from_kgid(&init_user_ns, attr->ia_gid) : 0);

Bonus points for fixing up overly long lines I have in my proposal :)

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

