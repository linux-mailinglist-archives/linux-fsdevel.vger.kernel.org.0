Return-Path: <linux-fsdevel+bounces-71014-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 249E6CAFC08
	for <lists+linux-fsdevel@lfdr.de>; Tue, 09 Dec 2025 12:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BBB1301AD31
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Dec 2025 11:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C5D312813;
	Tue,  9 Dec 2025 11:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Sr97gI/Q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XAQRfhEo";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FWY7cIit";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xV8BsoR+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765503016F4
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Dec 2025 11:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765279402; cv=none; b=S17IdrPbwn/ywh73hBygms+2kk4LG4uPtGK+hbyb0Fch7BO6seGXmgvgKFMGUWv18GyTLC3usHvc1y+tGk6dLhJGhHuJ0/Coi6ZEcXDZyQia1wPL4NW84l0VpHidiX2ggiSSJn3oRzSIl13XqWafbxNMEqozuBaEZHRSjPlmXuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765279402; c=relaxed/simple;
	bh=kfs23jTHuW89ilzPwuGY+V1SlF21/Pwdqr6+D24Gn4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lxCxVen/ftCOF6pLWxws/N50H79wjAcbzVJ5YAdYf1lmLRB6v7nlKe+1Ka369JVdZEVusSbuqfbl3wJb0XUdCXvm8tsZv5cGrTx2K5E2IRG38b5W4B8Rrvlw467ShTS+b3hzDaDR3QksM8QJgIJtx8V8QLBRbgAaXhrWADMhfy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Sr97gI/Q; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XAQRfhEo; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FWY7cIit; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xV8BsoR+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5027C337FD;
	Tue,  9 Dec 2025 11:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765279397; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SnfWfbnxOA8jDoy4c1A37JRnqeADOSuWRpEm/SMpLIA=;
	b=Sr97gI/QqNaOA/hrorptUM89pDVvB6iYzAel1iv6sdvYUknlXr8iApN20uGaF+CmU2VnFZ
	3ZlGUaRAlG6cUeZScgB4roY4cfi8dwAenbmfe8AxBKRbYVsr0CMyEiSIG69YKjGoPXhk8d
	kHaHCbfbM7tdr4Zpc68ybR1V0hp0K6g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765279397;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SnfWfbnxOA8jDoy4c1A37JRnqeADOSuWRpEm/SMpLIA=;
	b=XAQRfhEo+BBljojzcmSIPXhLS8wix+zCwJQD+eHO++5B6cRkfGh4UWqeqnDMVpMKbzLoIC
	T/GLRABB1eTEFDDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=FWY7cIit;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=xV8BsoR+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765279396; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SnfWfbnxOA8jDoy4c1A37JRnqeADOSuWRpEm/SMpLIA=;
	b=FWY7cIitUFzH0zGDLz/7xDHRiH8pxfyQ851jxLmEoygd+RDyPb3ghh9tT58KywHU+eWdHO
	hPZMnVrPMO9ZfvA9X7pZb80A3pWzRPwI1MPNds/Kh2ncD7awbJ+xqQ7KpqgviZPL3NdLrX
	ny+e0aP9KcPc2EdFUwAvPZFRqxJ725Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765279396;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SnfWfbnxOA8jDoy4c1A37JRnqeADOSuWRpEm/SMpLIA=;
	b=xV8BsoR+77xYOQtrwo1QTeML+fc+FVIG16lgQv6MbEaTtDlNOBm4XtLiffFrOG6O6s/pUu
	rikA2Zfe5hWTvuBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3C8BB3EA63;
	Tue,  9 Dec 2025 11:23:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +L7BDqQGOGmhJQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 09 Dec 2025 11:23:16 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E4B12A0A04; Tue,  9 Dec 2025 12:23:11 +0100 (CET)
Date: Tue, 9 Dec 2025 12:23:11 +0100
From: Jan Kara <jack@suse.cz>
To: 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: send fsnotify_xattr()/IN_ATTRIB from
 vfs_fileattr_set()/chattr(1)
Message-ID: <n4xg7ncsvtey5wn6macx6nwt7x463uc4xqqcjaskvtpm227bzc@536xrtegrdq7>
References: <iyvn6qjotpu6cei5jdtsoibfcp6l6rgvn47cwgaucgtucpfy2s@tarta.nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <iyvn6qjotpu6cei5jdtsoibfcp6l6rgvn47cwgaucgtucpfy2s@tarta.nabijaczleweli.xyz>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: 5027C337FD
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:dkim];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Level: 

On Mon 08-12-25 23:20:24, Ahelenia Ziemiańska wrote:
> Currently it seems impossible to observe these changes to the file's
> attributes. It's useful to be able to do this to see when the file
> becomes immutable, for example, so emit IN_ATTRIB via fsnotify_xattr(),
> like when changing other inode attributes.
> 
> Signed-off-by: Ahelenia Ziemiańska <nabijaczleweli@nabijaczleweli.xyz>

Thanks. Yes, I guess this makes sense. I've picked up the patch to my tree.

								Honza

> ---
> Given:
> 	#include <sys/inotify.h>
> 	#include <unistd.h>
> 	#include <stdio.h>
> 	#include <limits.h>
> 	int main() {
> 		int fd = inotify_init();
> 		inotify_add_watch(fd, ".", IN_ATTRIB);
> 		char buf[sizeof(struct inotify_event) + NAME_MAX + 1];
> 		for (;;) {
> 			ssize_t rd = read(fd, buf, sizeof(buf));
> 			struct inotify_event *ev = buf, *end = buf + rd;
> 			while (ev < end) {
> 				printf("%x\t%s\n", ev->mask, ev->name);
> 				ev = (char *)(ev + 1) + ev->len;
> 			}
> 		}
> 	}
> 
> Before:
> 	sh-5.2# ./test &
> 	[1] 255
> 	sh-5.2# chmod -x test
> 	4       test
> 	sh-5.2# setfattr -n user.name -v value test
> 	4       test
> 	sh-5.2# chattr -i test
> 	sh-5.2#
> 
> After:
> 	sh-5.2# ./test &
> 	[1] 280
> 	sh-5.2# chmod -x test
> 	4       test
> 	sh-5.2# setfattr -n user.name -v value test
> 	4       test
> 	sh-5.2# chattr -i test
> 	4       test
> 	sh-5.2#
> 
>  fs/file_attr.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/file_attr.c b/fs/file_attr.c
> index 4c4916632f11..13cdb31a3e94 100644
> --- a/fs/file_attr.c
> +++ b/fs/file_attr.c
> @@ -2,6 +2,7 @@
>  #include <linux/fs.h>
>  #include <linux/security.h>
>  #include <linux/fscrypt.h>
> +#include <linux/fsnotify.h>
>  #include <linux/fileattr.h>
>  #include <linux/export.h>
>  #include <linux/syscalls.h>
> @@ -298,6 +299,7 @@ int vfs_fileattr_set(struct mnt_idmap *idmap, struct dentry *dentry,
>  		err = inode->i_op->fileattr_set(idmap, dentry, fa);
>  		if (err)
>  			goto out;
> +		fsnotify_xattr(dentry);
>  	}
>  
>  out:
> -- 
> 2.39.5


-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

