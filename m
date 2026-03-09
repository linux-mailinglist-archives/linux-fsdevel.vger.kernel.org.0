Return-Path: <linux-fsdevel+bounces-79768-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPa2OYe9rmlEIgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79768-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 13:31:03 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B96238DC2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 13:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EDF39305F786
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 12:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77EA3A901F;
	Mon,  9 Mar 2026 12:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QsqXORHf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1kEb1Bf/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QsqXORHf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1kEb1Bf/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93AC3A7853
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Mar 2026 12:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773058868; cv=none; b=gJX8uS5IlWrAVCigjvq5EUoZOBs+nKQKi7CaeRf26Ee+vM6k2ceG0kaTFxu9lYqBPhoRHsm0xmRQcdUxd2ZY2IWiuMFPtxFWPzhf3m5JsxJxZ628FjJJsMFxmS4qcRMW5j1yfL8sAlIG0doCVRcnKIqGEq/30pzjnIQc47ey41M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773058868; c=relaxed/simple;
	bh=9qUkM/eoFW7EMl7zVZVCDbxJcZ1Ng1DUCEi19/F+0/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DGx2fH+59OqRwPAMg8JtmmRMeM85vuu8ifrALjvCBPapruYnu/42RJKZkw6ssTA8uUk4r+cMCNazBKUfvA7D7UfTbkgQlA9z8WQYu8NKAlPcXJkX42KJW+2eztbBEkR866HK9svuN4CJZmiuo1eBQCj7eOPWP3Jky17rvyiFPNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QsqXORHf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1kEb1Bf/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QsqXORHf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1kEb1Bf/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BF9B65BE24;
	Mon,  9 Mar 2026 12:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1773058864; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dvqgbkxJrugsvDdf72aPAOvqq058jH0Z/25E4NG6rQ0=;
	b=QsqXORHf9vSV/0uldv5hajL/18KXFFY7i/HDxLTU/v3ZIxPInm9sMlltjD0K2Fs/IzX9kI
	nY8ZoS0v93MZyrMPMPDsXPSd8MVV4iwnpUZrb5nEPQa9wkKFWm9cmb5KVR/OtgYfBGNHCm
	9037k9eJedoGkx8AG9RcCOZNcanDhps=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1773058864;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dvqgbkxJrugsvDdf72aPAOvqq058jH0Z/25E4NG6rQ0=;
	b=1kEb1Bf/NvHxVGDDljkUOOaSysHwMENujKJgzHiqx8UyGEeAze+2JYwtNTGt7dNhCxTMM6
	VSwSXfPkqTwktTDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=QsqXORHf;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="1kEb1Bf/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1773058864; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dvqgbkxJrugsvDdf72aPAOvqq058jH0Z/25E4NG6rQ0=;
	b=QsqXORHf9vSV/0uldv5hajL/18KXFFY7i/HDxLTU/v3ZIxPInm9sMlltjD0K2Fs/IzX9kI
	nY8ZoS0v93MZyrMPMPDsXPSd8MVV4iwnpUZrb5nEPQa9wkKFWm9cmb5KVR/OtgYfBGNHCm
	9037k9eJedoGkx8AG9RcCOZNcanDhps=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1773058864;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dvqgbkxJrugsvDdf72aPAOvqq058jH0Z/25E4NG6rQ0=;
	b=1kEb1Bf/NvHxVGDDljkUOOaSysHwMENujKJgzHiqx8UyGEeAze+2JYwtNTGt7dNhCxTMM6
	VSwSXfPkqTwktTDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B6D503EEC5;
	Mon,  9 Mar 2026 12:21:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id B+ycLDC7rmkFOAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 09 Mar 2026 12:21:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7FDC2A09A4; Mon,  9 Mar 2026 13:21:04 +0100 (CET)
Date: Mon, 9 Mar 2026 13:21:04 +0100
From: Jan Kara <jack@suse.cz>
To: Xianying Wang <wangxianying546@gmail.com>
Cc: tytso@mit.edu, jack@suse.cz, yi.zhang@huawei.com, libaokun1@huawei.com, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [BUG] WARNING: lib/ratelimit.c:LINE at ___ratelimit, CPU:
 kworker/u16:NUM/NUM
Message-ID: <ehjcrvjl6bf4wnoefvmjqecv2lhdzb3yz3ee3kteqngvgf2wfw@hri2icpgyrhb>
References: <CAOU40uDriX5NCfac2iK70z-M3Ea9pTMvTHtPGz97HKXbYhrjdQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOU40uDriX5NCfac2iK70z-M3Ea9pTMvTHtPGz97HKXbYhrjdQ@mail.gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Queue-Id: E7B96238DC2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79768-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pastebin.com:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	DMARC_NA(0.00)[suse.cz];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.928];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Hello,

the warning you've hit looks very likely like a race in the ratelimit code
itself where the WARN_ON is racing with some update to the ratelimit interval
resulting in intermediate invalid value. Neither quota code nor ext4 does
anything to the printk ratelimit state.

Secondly, we don't have a capacity (or even a will) to verify fuzzing
results of each random contributor. We generally process only fuzzing
results from the syzbot run by Google where there's both infractructure to
ease bug triage as well as safety guarantees someone isn't just trying to
make you run a malicious code in your test environment. If you have some
improvements to the way syzkaller works, please work with syzbot guys to
integrate your improvements there for everybody's benefit. Thank you!

							Honza

On Mon 09-03-26 18:24:01, Xianying Wang wrote:
> Hello,
> 
> I encountered the following warning while testing Linux kernel
> v7.0-rc2 with syzkaller.
> 
> The kernel reports a warning in lib/ratelimit.c triggered from the
> quota release workqueue:
> 
> WARNING: lib/ratelimit.c at ___ratelimit
> 
> Workqueue: quota_events_unbound quota_release_workfn
> 
> Before the warning occurs, the filesystem reports several EXT4 errors
> indicating that the filesystem metadata is already corrupted. In
> particular, ext4 detects that allocated blocks overlap with filesystem
> metadata and subsequently forces the filesystem to unmount. After
> that, during the quota cleanup phase, the kernel reports a cycle in
> the quota tree and attempts to release dquot structures through the
> quota release workqueue.
> 
> The call chain indicates that the warning is triggered during the
> quota cleanup path:
> 
> quota_release_workfn → ext4_release_dquot → dquot_release →
> qtree_release_dquot → qtree_delete_dquot → remove_tree → __quota_error
> → ___ratelimit
> 
> During this error reporting process, ___ratelimit() receives invalid
> parameters (e.g., a negative interval), which triggers the warning
> about an uninitialized or corrupted ratelimit_state structure.
> 
> From the observed behavior, the warning appears to be a secondary
> symptom triggered while handling a corrupted filesystem and quota
> tree. The initial corruption is detected by ext4 during block
> allocation checks, and the subsequent quota cleanup path exposes the
> ratelimit warning while reporting quota errors.
> 
> This can be reproduced on:
> 
> HEAD commit:
> 
> 11439c4635edd669ae435eec308f4ab8a0804808
> 
> report: https://pastebin.com/raw/yJp9p1dM
> 
> console output : https://pastebin.com/raw/tyPquTTH
> 
> kernel config : https://pastebin.com/7hk2cU0G
> 
> C reproducer :https://pastebin.com/raw/Sh3a62JM
> 
> Let me know if you need more details or testing.
> 
> Best regards,
> 
> Xianying
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

