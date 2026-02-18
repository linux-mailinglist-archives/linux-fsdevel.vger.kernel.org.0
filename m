Return-Path: <linux-fsdevel+bounces-77605-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDRZMhUHlmm4YQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77605-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 19:38:13 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 608FC158C22
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 19:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 980243007489
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 18:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE2B346FCA;
	Wed, 18 Feb 2026 18:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OtZTOy/3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Mf/PDw2W";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OtZTOy/3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Mf/PDw2W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46506346FA0
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 18:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771439874; cv=none; b=MrXRhiSJPd318nO0Ijd8A2v9xni3wyXXIKssU/0qr5b8kSnQsK1biCBakIBek0FunHkKDus4sLiM3DHXYyZ73+3wwpWSU3QiEg4f2bctZb3/r6yb2+sxumucFNWbP3LKmG07OgPQ9PL3XMsOz8565n/iYQx19kAOmXaAyFVomXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771439874; c=relaxed/simple;
	bh=Hoz9/57FagEVnDWp7H/V5BXnUKfy/zj09aMxPs+0OBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wqp6F1slI9g3rLsc6swZKtF3/Vp+dBl3QH0ceVdj+PfYpya+XDEOeGAcgv+OJhXzIcM15gPTUssQiMkg+ZVS7Snci/rN9qM+dniio4ed3qdOEdzYQcVuUZEFgdipjTXOROljjwdyqA6atIrm6cPbOasgrQlCGIo9eywf2350X8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OtZTOy/3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Mf/PDw2W; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OtZTOy/3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Mf/PDw2W; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8703D5BCF1;
	Wed, 18 Feb 2026 18:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1771439871; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GfS8AmrSc+X9FbAAoqibWbz6uZy/Jb/EL6+KvzsaBJw=;
	b=OtZTOy/3X0kNu4KFK4Nc9mB8/KLx8n6x6vxaXxkhhYu/wcNYb0riBlXH4NMqNWbpNOHY2t
	ZzlPEdOs1sqHCL3Xfku9Eq7yCCDexGg02L1Ya23dq6yz5C5ojrf8htLzLaeXE9j0iPXwDx
	yJhmTqC1Ty9oLfE0jrDq7X+gQwmsmJo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1771439871;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GfS8AmrSc+X9FbAAoqibWbz6uZy/Jb/EL6+KvzsaBJw=;
	b=Mf/PDw2Ws4OsG2AsftyfDuSwSwT7vmGCfAvF3NxL0YUVc4XeGCqsV/JzTRyBgTGLDl0Vl/
	GK+hWgQaY+dMW4Cg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="OtZTOy/3";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="Mf/PDw2W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1771439871; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GfS8AmrSc+X9FbAAoqibWbz6uZy/Jb/EL6+KvzsaBJw=;
	b=OtZTOy/3X0kNu4KFK4Nc9mB8/KLx8n6x6vxaXxkhhYu/wcNYb0riBlXH4NMqNWbpNOHY2t
	ZzlPEdOs1sqHCL3Xfku9Eq7yCCDexGg02L1Ya23dq6yz5C5ojrf8htLzLaeXE9j0iPXwDx
	yJhmTqC1Ty9oLfE0jrDq7X+gQwmsmJo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1771439871;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GfS8AmrSc+X9FbAAoqibWbz6uZy/Jb/EL6+KvzsaBJw=;
	b=Mf/PDw2Ws4OsG2AsftyfDuSwSwT7vmGCfAvF3NxL0YUVc4XeGCqsV/JzTRyBgTGLDl0Vl/
	GK+hWgQaY+dMW4Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6DF183EA65;
	Wed, 18 Feb 2026 18:37:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PR7PGv8GlmlLKAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 18 Feb 2026 18:37:51 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 13EADA08CF; Wed, 18 Feb 2026 19:37:51 +0100 (CET)
Date: Wed, 18 Feb 2026 19:37:51 +0100
From: Jan Kara <jack@suse.cz>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Jan Kara <jack@suse.cz>, gregkh@linuxfoundation.org, tj@kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, amir73il@gmail.com, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 2/3] kernfs: send IN_DELETE_SELF and IN_IGNORED on
 file deletion
Message-ID: <s4vb5vshejyasdw2tkydhhk4m6p3ybexoi254qjiqexzgcxb5c@ctazolc3nh6f>
References: <20260218032232.4049467-1-tjmercier@google.com>
 <20260218032232.4049467-3-tjmercier@google.com>
 <e7b4xiqvh76jvqukvcocblq5lrc5hldoiiexjlo5fmagbv3mgn@zhpzm4jwx3kg>
 <CABdmKX1S4wWFdsUOFOQ=_uVbmQVcQk0+VUVQjgAx_yqUcEd60A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABdmKX1S4wWFdsUOFOQ=_uVbmQVcQk0+VUVQjgAx_yqUcEd60A@mail.gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[suse.cz,linuxfoundation.org,kernel.org,lists.linux.dev,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-77605-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[memory.events:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.com:email];
	DMARC_NA(0.00)[suse.cz];
	DKIM_TRACE(0.00)[suse.cz:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 608FC158C22
X-Rspamd-Action: no action

On Wed 18-02-26 10:06:35, T.J. Mercier wrote:
> On Wed, Feb 18, 2026 at 10:01 AM Jan Kara <jack@suse.cz> wrote:
> >
> > On Tue 17-02-26 19:22:31, T.J. Mercier wrote:
> > > Currently some kernfs files (e.g. cgroup.events, memory.events) support
> > > inotify watches for IN_MODIFY, but unlike with regular filesystems, they
> > > do not receive IN_DELETE_SELF or IN_IGNORED events when they are
> > > removed.
> >
> > Please see my email:
> > https://lore.kernel.org/all/lc2jgt3yrvuvtdj2kk7q3rloie2c5mzyhfdy4zvxylx732voet@ol3kl4ackrpb
> >
> > I think this is actually a bug in kernfs...
> >
> >                                                                 Honza
> 
> Thanks, I'm looking at this now. I've tried calling clear_nlink in
> kernfs_iop_rmdir, but I've found that when we get back to vfs_rmdir
> and shrink_dcache_parent is called, d_walk doesn't find any entries,
> so shrink_kill->__dentry_kill is not called. I'm investigating why
> that is...

Strange because when I was experimenting with this in my VM I have seen
__dentry_kill being called (if the dentries were created by someone looking
up the names).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

