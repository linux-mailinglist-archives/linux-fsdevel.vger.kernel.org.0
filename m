Return-Path: <linux-fsdevel+bounces-8473-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71828837355
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 20:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A50BA1C28748
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 19:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C2B405D6;
	Mon, 22 Jan 2024 19:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MFp8+XZ+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="e40P8gO4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MFp8+XZ+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="e40P8gO4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B653FE54;
	Mon, 22 Jan 2024 19:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705953426; cv=none; b=W2sJwbveO4fy8s40aZqOG0st+LEIoscj3E1zxxNmmgsZVdl+8l9YGPy8wT/mHO+Mi61gowzh83SCtT52xYhxR11l23kTmGky8irjbf24FWfqEZa7CmdB5jDsO0B4gdeTd8ebHJLR1Z6Zp1/T24ViktdyVW1mouFL+4WhAKushgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705953426; c=relaxed/simple;
	bh=FbFM4tgoOL0B5ezyGbX4Uc9mlvqz8O4C5VRZIqNoXwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BCXp2sw8ztg+yZf3mRp0f7vUESrq+u6m7V7Da+1+IXnW04ozkEFzG4F6pvL17XrStOM36Yw2NHz6rRbXcZqUuAeUXDd5xSkOU+OLJX9nDvcrFUjRQtBujbGYAAK0cAKRrdZAjsI9VoVPaP+XY6qUJ5FnjSeScmRHAozIouV1dsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MFp8+XZ+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=e40P8gO4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MFp8+XZ+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=e40P8gO4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 79AE91FC31;
	Mon, 22 Jan 2024 19:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705953423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=22xcc7q3S/Q3FHCMHrkfweD+r21TH2X17VVEB5XDWs0=;
	b=MFp8+XZ+TiBY4V/7DMLPNwrCFcpRGgM01RCupOb0tI70qFM8oSOBhIFjOmMrrFN/urR7JL
	dzZVksck61LhuhZtm4SOp/vCBR3NdiAxXrmwsBySy04VHnLmYu3Fe/NC7MP2N4m33XzhNW
	/fB0q7ba0aW8UDACX0bxNpvrUuWLKUs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705953423;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=22xcc7q3S/Q3FHCMHrkfweD+r21TH2X17VVEB5XDWs0=;
	b=e40P8gO45PLhpg+ZHQs6acT8uwQDJtQ/qM5Zs/OaWBd4FM6ZCGJABbDXAZ3yrcKTLddY16
	YqjQbEtnB17IRNBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705953423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=22xcc7q3S/Q3FHCMHrkfweD+r21TH2X17VVEB5XDWs0=;
	b=MFp8+XZ+TiBY4V/7DMLPNwrCFcpRGgM01RCupOb0tI70qFM8oSOBhIFjOmMrrFN/urR7JL
	dzZVksck61LhuhZtm4SOp/vCBR3NdiAxXrmwsBySy04VHnLmYu3Fe/NC7MP2N4m33XzhNW
	/fB0q7ba0aW8UDACX0bxNpvrUuWLKUs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705953423;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=22xcc7q3S/Q3FHCMHrkfweD+r21TH2X17VVEB5XDWs0=;
	b=e40P8gO45PLhpg+ZHQs6acT8uwQDJtQ/qM5Zs/OaWBd4FM6ZCGJABbDXAZ3yrcKTLddY16
	YqjQbEtnB17IRNBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6B1C613995;
	Mon, 22 Jan 2024 19:57:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id igrhGY/IrmVsOQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 22 Jan 2024 19:57:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0E943A0803; Mon, 22 Jan 2024 20:57:03 +0100 (CET)
Date: Mon, 22 Jan 2024 20:57:03 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+7cc52cbcdeb02a4b0828@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	paul@paul-moore.com, reiserfs-devel@vger.kernel.org,
	roberto.sassu@huawei.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [reiserfs?] kernel BUG in flush_journal_list
Message-ID: <20240122195703.piynymm3ss3xyojs@quack3>
References: <0000000000005f0b2f05fdf309b3@google.com>
 <0000000000003567b1060f7b8724@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000003567b1060f7b8724@google.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [2.85 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-0.05)[60.02%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=d855e3560c4c99c4];
	 TAGGED_RCPT(0.00)[7cc52cbcdeb02a4b0828];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,syzkaller.appspot.com:url];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Level: **
X-Spam-Score: 2.85
X-Spam-Flag: NO

On Sun 21-01-24 13:38:04, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
> 
>     fs: Block writes to mounted block devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1556b3dde80000
> start commit:   4652b8e4f3ff Merge tag '6.7-rc-ksmbd-server-fixes' of git:..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d855e3560c4c99c4
> dashboard link: https://syzkaller.appspot.com/bug?extid=7cc52cbcdeb02a4b0828
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=103dee6f680000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12883df7680000
> 
> If the result looks correct, please mark the issue as fixed by replying with:

Makes sense.
 
#syz fix: fs: Block writes to mounted block devices

									Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

