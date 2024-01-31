Return-Path: <linux-fsdevel+bounces-9592-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 898AC8431F2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 01:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36DE42890D8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 00:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D017EB;
	Wed, 31 Jan 2024 00:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="o6Bpqu9I";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qRcKcm/e";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="o6Bpqu9I";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qRcKcm/e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD23F360;
	Wed, 31 Jan 2024 00:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706661107; cv=none; b=EOwwJesDPh8GoqcfRTrN/MVttYWHxlY7bJ1WbLMmLuQ2/CMcWTVyEGY0cYIrndRB346zEX/Mg9zuiJgSRancWAMZvG//ritedxiGLKumiYWDvVOHw8jBOdcJ/eTObp/ygwfJuqFH5ftzBZWyfD97xlV5yGNN0yp8fssVd4F5iO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706661107; c=relaxed/simple;
	bh=ujvbSERiGdxI8pznUEWTtfALoPnJ87F+A4zlV/ouAys=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DPjizBsi2iZ51Lt79d+X95Iig/fminJsaywcgVfAJ2z5b6w9TVBwh+xSAavWCB9WBGtXEch+TeCHi0RmgPAyqf8fWTPUIo4pBh0HYKu+gpJwl2oOMlx9d6weyqpNEgENkTPkPnbfb5JAD4Kn0OZ+2twcuSV77tDo5deh5JRw1iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=o6Bpqu9I; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qRcKcm/e; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=o6Bpqu9I; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qRcKcm/e; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 75AA8220A0;
	Wed, 31 Jan 2024 00:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706661103; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/vilI7G8lL/UQ/kgBn//rsDqRLdTHE2OvPGJf/lKhcI=;
	b=o6Bpqu9INmzBfg3XWQ+3Vwf7dMtTEJjAtTd09dmU6QEBblg9hFHNK4mZ5KM7P8p8ARaw0d
	hgXFLp/ltewhmOXcLVCIp1MFW0IGsyb2umptBNQIs1fCSfqVdtb/E9keVAuJcfEheOBFbf
	rp94R7ASZYdek9lS5NXlQsckZYl3PvQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706661103;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/vilI7G8lL/UQ/kgBn//rsDqRLdTHE2OvPGJf/lKhcI=;
	b=qRcKcm/e/cqK0+ouUDJb3P3RH5IZ5az1RxFYH0qpUuMuEOfdg4/ukyWeXT330afsm4p3pj
	wZvpOP9AF3BvT0Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706661103; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/vilI7G8lL/UQ/kgBn//rsDqRLdTHE2OvPGJf/lKhcI=;
	b=o6Bpqu9INmzBfg3XWQ+3Vwf7dMtTEJjAtTd09dmU6QEBblg9hFHNK4mZ5KM7P8p8ARaw0d
	hgXFLp/ltewhmOXcLVCIp1MFW0IGsyb2umptBNQIs1fCSfqVdtb/E9keVAuJcfEheOBFbf
	rp94R7ASZYdek9lS5NXlQsckZYl3PvQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706661103;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/vilI7G8lL/UQ/kgBn//rsDqRLdTHE2OvPGJf/lKhcI=;
	b=qRcKcm/e/cqK0+ouUDJb3P3RH5IZ5az1RxFYH0qpUuMuEOfdg4/ukyWeXT330afsm4p3pj
	wZvpOP9AF3BvT0Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C8634139B1;
	Wed, 31 Jan 2024 00:31:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7cH2I+6UuWXqbAAAD6G6ig
	(envelope-from <krisman@suse.de>); Wed, 31 Jan 2024 00:31:42 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: viro@zeniv.linux.org.uk,  jaegeuk@kernel.org,  tytso@mit.edu,
  amir73il@gmail.com,  linux-ext4@vger.kernel.org,
  linux-f2fs-devel@lists.sourceforge.net,  linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 01/12] ovl: Reject mounting over case-insensitive
 directories
In-Reply-To: <20240131002258.GA2020@sol.localdomain> (Eric Biggers's message
	of "Tue, 30 Jan 2024 16:22:58 -0800")
References: <20240129204330.32346-1-krisman@suse.de>
	<20240129204330.32346-2-krisman@suse.de>
	<20240131002258.GA2020@sol.localdomain>
Date: Tue, 30 Jan 2024 21:31:40 -0300
Message-ID: <87plxi2vir.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=o6Bpqu9I;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="qRcKcm/e"
X-Spamd-Result: default: False [-2.34 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,mit.edu,gmail.com,vger.kernel.org,lists.sourceforge.net];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.03)[56.07%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 75AA8220A0
X-Spam-Level: 
X-Spam-Score: -2.34
X-Spam-Flag: NO

Eric Biggers <ebiggers@kernel.org> writes:

> On Mon, Jan 29, 2024 at 05:43:19PM -0300, Gabriel Krisman Bertazi wrote:
>> ovl: Reject mounting over case-insensitive directories
>
> Maybe:
>
>     ovl: Reject mounting over rootdir of case-insensitive capable FS
>
> or:
>
>     ovl: Always reject mounting over case-insensitive directories
>
> ... since as your commit message explains, overlayfs already does reject
> mounting over case-insensitive directories, just not in all cases.
>
>> Since commit bb9cd9106b22 ("fscrypt: Have filesystems handle their
>> d_ops"), we set ->d_op through a hook in ->d_lookup, which
>> means the root dentry won't have them, causing the mount to accidentally
>> succeed.
>
> But this series changes that.  Doesn't that make this overlayfs fix redundant?
> It does improve the error message, which is helpful, but your commit message
> makes it sound like it's an actual fix, not just an error message improvement.

Yes, this series will make it redundant.  But Christian Brauner had
suggested we make this verification explicit instead of relying on d_ops
being set, to avoid future changes breaking this again.  I found the
issue in ovl during testing of v2 and intended to send it separately for
-rc7, but Amir asked it to be sent as part of this series.  And also the
error code is improved.

Anyway, I'll can make this clear in the commit message

-- 
Gabriel Krisman Bertazi

