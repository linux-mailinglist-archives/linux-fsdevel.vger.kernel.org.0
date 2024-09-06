Return-Path: <linux-fsdevel+bounces-28891-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7707796FE56
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Sep 2024 01:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E69D285FB3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 23:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A7015B137;
	Fri,  6 Sep 2024 23:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="t0J1pBHL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wCVMRFcv";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oPsilf3m";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0jc9mi8J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEE515A86A;
	Fri,  6 Sep 2024 23:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725664507; cv=none; b=BCBGnR54pK1y90GEZsLRgS/SPfKdx+f3B4Bg7C8uNPrQqmIbZiqXklwi0K1jfKWFXOOeHXJOUPAQw/40cl9wrCpDf/AFXI/S8TByCvO9p6wU8toCjSOY9CtSFoC3aaA5OXz5hsn/91D1aDNAmoTNtwmyDgHivOB//5nDOg+BrG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725664507; c=relaxed/simple;
	bh=gpbGCNtdu3NDnI8JQG08CjJ4n9MF45pTmdTxPHCwhQo=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=XZAiynthsRKxBcxO3XtHJPs6Ia0XqWeFSRAMYHHzn4ma1sa604QnqaQt4Rqzu1nOg3LnjoP56cVjZLWFe9PZz2tZGXAJQ5OfQn+FDeHdru8OBpWs4qII5+qLKaKwLmIPVIbwMZBmn8YT2KmakHedP3mYe/mkacBpzYKGLU1MZ2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=t0J1pBHL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wCVMRFcv; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oPsilf3m; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0jc9mi8J; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D2BB91FB4C;
	Fri,  6 Sep 2024 23:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725664504; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D8zOcUGrulkPZeRN4x1CwFyxmiy/XfPDmzoAQ74LPOA=;
	b=t0J1pBHLl/svt9eL5uzVlkIBYTq7TuMdGXOKEYKhWVsiFks2DFEltKUuMCHgOM57MAeqsM
	qQXFP9BkMFxKXQ5OB0hoIJn0Jzg2A1Tbb1jtVtNfyG1yUFP2SsD2crEgf7AHs0+7epfNvD
	wE13xQPCQs8rgx7lDgosVdibNkFtz74=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725664504;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D8zOcUGrulkPZeRN4x1CwFyxmiy/XfPDmzoAQ74LPOA=;
	b=wCVMRFcv63rMSdUZe1cx/Zf8aauCb0V26zKKYuYSYIw6J5i8KmbAp1oFBfSlUAUAzDMSlf
	B+r53eba9gqj1eCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=oPsilf3m;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=0jc9mi8J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725664502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D8zOcUGrulkPZeRN4x1CwFyxmiy/XfPDmzoAQ74LPOA=;
	b=oPsilf3mGj2xcYi3dwjd0oSrnZHzR6ICfgYxBs/EXmv95mi7KIG/5RQ/d6C4a/tlALKW4q
	VVTh9pudtDrgiGRra9LcO9VuIDeb5fQELi4SICyNiHv+FLaHT+iTUkb1cuy26xN0+4T9N1
	NRz5OoFE0/l728XSxWNvRIzGQcBRM8Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725664502;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D8zOcUGrulkPZeRN4x1CwFyxmiy/XfPDmzoAQ74LPOA=;
	b=0jc9mi8JN+UXSiSWAojl1oeRefrT9ldIhReRR51QgGJmn8PmrleWXsbzCBFcui4WOZ0Lsp
	LYqjITOnATClT8Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6810B136A8;
	Fri,  6 Sep 2024 23:15:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2da+BvSM22a0OQAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 06 Sep 2024 23:15:00 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Chuck Lever III" <chuck.lever@oracle.com>
Cc: "Mike Snitzer" <snitzer@kernel.org>, "Jeff Layton" <jlayton@kernel.org>,
 "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
 "Anna Schumaker" <anna@kernel.org>,
 "Trond Myklebust" <trondmy@hammerspace.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v15 16/26] nfsd: add LOCALIO support
In-reply-to: <2D4C95CA-3398-4962-AF14-672DEBADD3EE@oracle.com>
References: <>, <2D4C95CA-3398-4962-AF14-672DEBADD3EE@oracle.com>
Date: Sat, 07 Sep 2024 09:14:57 +1000
Message-id: <172566449714.4433.8514131910352531236@noble.neil.brown.name>
X-Rspamd-Queue-Id: D2BB91FB4C
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,noble.neil.brown.name:mid];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Sat, 07 Sep 2024, Chuck Lever III wrote:
> 
> 
> > On Sep 6, 2024, at 5:56 PM, NeilBrown <neilb@suse.de> wrote:
> > 
> > We could achieve the same effect without using symbol_request() (which
> > hardly anyone uses) if we did a __module_get (or try_module_get) at the
> > same place you are calling symbol_request(), and module_put() where you
> > do symbol_put().
> > 
> > This would mean that once NFS LOCALIO had detected a path to the local
> > server, it would hold the nfsd module until the nfs server were shutdown
> > and the nfs client noticed.  So you wouldn't be able to unmount the nfsd
> > module immediately after stopping all nfsd servers.
> > 
> > Maybe that doesn't matter.  I think it is important to be able to
> > completely shut down the NFS server at any time.  I think it is
> > important to be able to completely shutdown a network namespace at any
> > time.  I am less concerned about being able to rmmod the nfsd module
> > after all obvious users have been disabled.
> > 
> > So if others think that the improvements in code maintainability are
> > worth the loss of being able to rmmod nfsd without (potentially) having
> > to unmount all NFS filesystems, then I won't argue against it.  But I
> > really would want it to be get/put of the module, not of some symbol.
> 
> The client and server are potentially in separate containers,
> administered independently. An NFS mount should not pin either
> the NFS server's running status, its ability to unexport a
> shared file system, the ability for the NFS server's
> administrator to rmmod nfsd.ko, the ability for the
> administrator to rmmod a network device that is in use by the
> NFS server, or the ability to destroy the NFS server's
> namespace once NFSD has shut down.

While I mostly agree, I should point out that nfsd.ko is a global
resource across all containers.  So if the client and server are
administer separately, there is no certainty that the server
administrator is at all related to the global moderator who controls
when nfsd.ko might be unloaded.  So preventing the unload of nfsd.ko is
quite a different class of problem to preventing the shutdown of the
nfsd service or of the container that it runs in.

NeilBrown


> 
> I don't feel that this is a code maintainability issue, but
> rather this is a usability and security mandate. Remote NFS
> mounts don't (or, are not supposed to) pin NFSD's resources
> in any way. That is the behavioral standard, and if we find
> that is not the case, we treat it as a bug.
> 
> TL;DR: it does matter. LOCALIO NFS mounts should not
> indefinitely pin NFSD or its resources.
> 
> 
> --
> Chuck Lever
> 
> 
> 


