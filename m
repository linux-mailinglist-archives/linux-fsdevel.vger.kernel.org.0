Return-Path: <linux-fsdevel+bounces-14471-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A0487CF71
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 15:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD85FB21942
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 14:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4D139FFA;
	Fri, 15 Mar 2024 14:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ahxv7uPn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5q/3pwV4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ahxv7uPn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5q/3pwV4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA67C3D0A8;
	Fri, 15 Mar 2024 14:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710514203; cv=none; b=egzq370k3kC3CUB/ZsiApqeIdiq6x5FgBQB7YuXkUbsC7rphOmHv++8pUnss637QVT6M1xCb6C1YWnvA11ix/qwoC84ugLj67uVDVktIaEYG4LmTiNjk7vygjJxxqhFEyLpEcx4Za1SlH4B/onqJGsKCjEUZYZmdNcPnmEJDUSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710514203; c=relaxed/simple;
	bh=pYIocXJzjWQXvaE5A/LvqKx5ijceUidPNLC97XcDslg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=atV7tPYvsb6xWhI3gaiK55yQXLcIjAaC0Q9F9vVh5p2DoOfQS9i6/HUOU7M7lWWz4n84CXrQTSpylYz01UXDC4GSE4UIS+WUXYmQiv50qGoOoIigfawzNtqqm/xHpuiZhQiInDFSotfsjbHoIZL7j3Fn4tCpytQ8f9Ss+T3h8pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ahxv7uPn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5q/3pwV4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ahxv7uPn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5q/3pwV4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2C9EA1FB6F;
	Fri, 15 Mar 2024 14:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710514200; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qLns1K/O2DnblFDDOvNNQmCKnW+xm16WB3FqmaAZOVw=;
	b=Ahxv7uPn0yHUyjnSVGswZtpTD96N/M1Eq5D5oxrO5ZNIc5mCRwUV+uESmU/nnpRJCfJ4QM
	D/efYwLiIy+ILug7JgYGYHAap4jkfBrvbQu7BDat0RZC3Ewd7P3GLPFbgWyrfWkKtusRXj
	e6AkBS3oa4Wepby39OGTr/BFbC7Sxjo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710514200;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qLns1K/O2DnblFDDOvNNQmCKnW+xm16WB3FqmaAZOVw=;
	b=5q/3pwV4Nxs9UtGYE/cVhuZn7fFOdVV5nFHgAsTWRJrxUEnC5aqZaLP20X9Av2BuDSfSAp
	QF9M5g13ybobxfCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710514200; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qLns1K/O2DnblFDDOvNNQmCKnW+xm16WB3FqmaAZOVw=;
	b=Ahxv7uPn0yHUyjnSVGswZtpTD96N/M1Eq5D5oxrO5ZNIc5mCRwUV+uESmU/nnpRJCfJ4QM
	D/efYwLiIy+ILug7JgYGYHAap4jkfBrvbQu7BDat0RZC3Ewd7P3GLPFbgWyrfWkKtusRXj
	e6AkBS3oa4Wepby39OGTr/BFbC7Sxjo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710514200;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qLns1K/O2DnblFDDOvNNQmCKnW+xm16WB3FqmaAZOVw=;
	b=5q/3pwV4Nxs9UtGYE/cVhuZn7fFOdVV5nFHgAsTWRJrxUEnC5aqZaLP20X9Av2BuDSfSAp
	QF9M5g13ybobxfCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0930913931;
	Fri, 15 Mar 2024 14:50:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GsQAARhg9GVGRgAAD6G6ig
	(envelope-from <chrubis@suse.cz>); Fri, 15 Mar 2024 14:50:00 +0000
Date: Fri, 15 Mar 2024 15:49:03 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, lkp@intel.com, ltp@lists.linux.it,
	linux-kernel@vger.kernel.org
Subject: Re: [LTP] [linus:master] [pidfd]  cb12fd8e0d: ltp.readahead01.fail
Message-ID: <ZfRf36u7CH7bIEZ7@yuki>
References: <202403151507.5540b773-oliver.sang@intel.com>
 <20240315-neufahrzeuge-kennt-317f2a903605@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315-neufahrzeuge-kennt-317f2a903605@brauner>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Ahxv7uPn;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="5q/3pwV4"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.76 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.75)[84.05%]
X-Spam-Score: -1.76
X-Rspamd-Queue-Id: 2C9EA1FB6F
X-Spam-Flag: NO

Hi!
> So I'd just remove that test. It's meaningless for pseudo fses.

Wouldn't it make more sense to actually return EINVAL instead of
ignoring the request if readahead() is not implemented?

-- 
Cyril Hrubis
chrubis@suse.cz

