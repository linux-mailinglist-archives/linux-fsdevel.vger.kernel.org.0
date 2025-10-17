Return-Path: <linux-fsdevel+bounces-64436-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C4EEFBE7DE1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 11:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 70D5950781B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 09:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C880F2D837B;
	Fri, 17 Oct 2025 09:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GAoPDIcC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="o/MKD3Bb";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cXuafEbT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="B7hzEdwA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C719F2C15A5
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Oct 2025 09:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760693992; cv=none; b=mR964gkS5q8fPviALVkyrMU4UCKv/ziCdNuCyZWiLAkYyp8ZmMN2u+l4bMyVfR9PHqDb4RY88iPduX1WBDGgBQNG+1WMnVC68KWydwcNzDvzxPFNq4GIdSJkQn+GfEx6x/Oddi3wv997EZzKZY0RZeJ3xQ8M/Ao30nIV5BqZCbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760693992; c=relaxed/simple;
	bh=fUk/rh0WLjPqCjEuA4oTo6WbPH0FxjFUt1aN31cxz28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZfoaXkGSK+adeFQG2x1aQeqAMihlhf+1DMRUHxZci5qMcK6C/PKsI9mztxKynkWi2ioFow3pfofyADAEctxp1oMD4OcgBmuElZA1WpTx6THYG8R1IOUK8Lw7ItTC+XkytGrqtI9MMAXId5psCq8BagzD7QcNs3UB3kqKSMN0QqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GAoPDIcC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=o/MKD3Bb; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cXuafEbT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=B7hzEdwA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E3D4C1FBEF;
	Fri, 17 Oct 2025 09:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760693988; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rxsh8YLpkHchYlKNshAf0z+s1yJbhAt1iJY0i+ejDYU=;
	b=GAoPDIcCV6+vpN2iDFtj/3mvkDJEFoKmHBl0/NbpADziwHIRGKrxk6WZTnuXaIj+tsCpwC
	WCXA/uELPzNIHv90Xx2h/icyFYRnyiziC6S6WKonTkApJfTGXkOy0KyiI/sn2zYvQGZY1v
	kIfHSL9p6TANqJwIQ1u4JI3ZEXDeJ98=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760693988;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rxsh8YLpkHchYlKNshAf0z+s1yJbhAt1iJY0i+ejDYU=;
	b=o/MKD3Bbm3JaNR/TROHgWTnoVERx9RZ98wLS52tZYuyVSfVETzAzXZvjm6WE3qhhQU5x1I
	KGxxJtV/NbOp0PBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=cXuafEbT;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=B7hzEdwA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760693987; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rxsh8YLpkHchYlKNshAf0z+s1yJbhAt1iJY0i+ejDYU=;
	b=cXuafEbTAX9/XZgTNg/BOLkg8giGNM+h+2RNoboAK9WVqwtwTkKDotiqMCgJsFmPrNJx1D
	pFii51bEOdPeD0tWKFfXHNRd3nemr8T5I+8PcA9CEf/B5W25sMe41NKjCdomHjbg1Whx75
	CKQKbFiNAPSIjyvaduIumr23JuRiRKc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760693987;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rxsh8YLpkHchYlKNshAf0z+s1yJbhAt1iJY0i+ejDYU=;
	b=B7hzEdwAsrhSUk1zN5WRAOe2DljWClmcfy8BvsMauxdR6uwn4FPAXDkjh8Z99eMZvR/FnP
	UEqNwwtqu0tR9rDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D078B136C6;
	Fri, 17 Oct 2025 09:39:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 73ROMeMO8mjeOgAAD6G6ig
	(envelope-from <chrubis@suse.cz>); Fri, 17 Oct 2025 09:39:47 +0000
Date: Fri, 17 Oct 2025 11:40:41 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
	lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	LTP List <ltp@lists.linux.it>,
	Andrey Albershteyn <aalbersh@kernel.org>, Jan Kara <jack@suse.cz>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Ben Copeland <benjamin.copeland@linaro.org>,
	Petr Vorel <pvorel@suse.cz>,
	Andrea Cervesato <andrea.cervesato@suse.com>
Subject: Re: 6.18.0-rc1: LTP syscalls ioctl_pidfd05: TFAIL: ioctl(pidfd,
 PIDFD_GET_INFO_SHORT, info_invalid) expected EINVAL: ENOTTY (25)
Message-ID: <aPIPGeWo8gtxVxQX@yuki.lan>
References: <CA+G9fYuF44WkxhDj9ZQ1+PwdsU_rHGcYoVqMDr3AL=AvweiCxg@mail.gmail.com>
 <CA+G9fYtUp3Bk-5biynickO5U98CKKN1nkE7ooxJHp7dT1g3rxw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYtUp3Bk-5biynickO5U98CKKN1nkE7ooxJHp7dT1g3rxw@mail.gmail.com>
X-Rspamd-Queue-Id: E3D4C1FBEF
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,yuki.lan:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 

Hi!
> > ## Test error log
> > tst_buffers.c:57: TINFO: Test is using guarded buffers
> > tst_test.c:2021: TINFO: LTP version: 20250930
> > tst_test.c:2024: TINFO: Tested kernel: 6.18.0-rc1 #1 SMP PREEMPT
> > @1760657272 aarch64
> > tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
> > tst_kconfig.c:676: TINFO: CONFIG_TRACE_IRQFLAGS kernel option detected
> > which might slow the execution
> > tst_test.c:1842: TINFO: Overall timeout per run is 0h 21m 36s
> > ioctl_pidfd05.c:45: TPASS: ioctl(pidfd, PIDFD_GET_INFO, NULL) : EINVAL (22)
> > ioctl_pidfd05.c:46: TFAIL: ioctl(pidfd, PIDFD_GET_INFO_SHORT,
> > info_invalid) expected EINVAL: ENOTTY (25)

Looking closely this is a different problem.

What we do in the test is that we pass PIDFD_IOCTL_INFO whith invalid
size with:

struct pidfd_info_invalid {
        uint32_t dummy;
};

#define PIDFD_GET_INFO_SHORT _IOWR(PIDFS_IOCTL_MAGIC, 11, struct pidfd_info_invalid)


And we expect to hit:

        if (usize < PIDFD_INFO_SIZE_VER0)
                return -EINVAL; /* First version, no smaller struct possible */

in fs/pidfs.c


And apparently the return value was changed in:

commit 3c17001b21b9f168c957ced9384abe969019b609
Author: Christian Brauner <brauner@kernel.org>
Date:   Fri Sep 12 13:52:24 2025 +0200

    pidfs: validate extensible ioctls
    
    Validate extensible ioctls stricter than we do now.
    
    Reviewed-by: Aleksa Sarai <cyphar@cyphar.com>
    Reviewed-by: Jan Kara <jack@suse.cz>
    Signed-off-by: Christian Brauner <brauner@kernel.org>

diff --git a/fs/pidfs.c b/fs/pidfs.c
index edc35522d75c..0a5083b9cce5 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -440,7 +440,7 @@ static bool pidfs_ioctl_valid(unsigned int cmd)
                 * erronously mistook the file descriptor for a pidfd.
                 * This is not perfect but will catch most cases.
                 */
-               return (_IOC_TYPE(cmd) == _IOC_TYPE(PIDFD_GET_INFO));
+               return extensible_ioctl_valid(cmd, PIDFD_GET_INFO, PIDFD_INFO_SIZE_VER0);
        }
 
        return false;


So kernel has changed error it returns, if this is a regression or not
is for kernel developers to decide.

-- 
Cyril Hrubis
chrubis@suse.cz

