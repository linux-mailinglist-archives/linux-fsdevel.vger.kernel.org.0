Return-Path: <linux-fsdevel+bounces-65088-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 84674BFBCAC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 14:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 08A0C3568D0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 12:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E38534165E;
	Wed, 22 Oct 2025 12:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nMFPJTmK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="96GHO7kE";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0itR3CsJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="07dwfYMr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3317F3126BA
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 12:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761135136; cv=none; b=szjvWpJjfrKWNYVzNFBplT+guslZcohp6EHbLglmpFFzlSkcP3JT3wAA+kkQzZaR6fgea2wg7mkGgoqFuyuU4SmwsV5x58SBUJLZfV3+lNegvrhjtZRLweBPk7QyG4UdKyQI0BuFjXc/OD10vGdpA8/kixi6XXtRwHn3FBGXJ2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761135136; c=relaxed/simple;
	bh=KPYQHJydC+41DZNG/UQhU3NOtQQd3fs3N8308YZjraQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mycgJfu0kzdJcasu9eRWplxIY1cSe+EZXkz/Q6E2dJMcwRQie77G6ZJRaqOmPPEzGwnABsXWtSiUaNsz+Mz8q0ZAVwtBq0ZsEBH1ToRCFAVAPHFiTb0OAYgogTjH6LnaCDo98s6vpKant9OMkYeTNuszc1a0zl44eDLIFL8qhkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nMFPJTmK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=96GHO7kE; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0itR3CsJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=07dwfYMr; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1F30221168;
	Wed, 22 Oct 2025 12:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761135129;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GOATducwgjJYNf5xRUUlUigG5jvG/objCWoK3h1UNoM=;
	b=nMFPJTmKqSCxr11/LtGHNRjCGNpQ+MLZOE+3j4M9FHGpbwDHJF0kADldkBgTCKvJmkIhzz
	BQl+5svEUU2l1TCEhTYjTVZJTtFvzqrKNxiCkpm+8gkNtwzmi1yJkaCZncu5mi1QNuHEKR
	C8NtJ98JlOZaT4mKdJDHDRy3CryDcs0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761135129;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GOATducwgjJYNf5xRUUlUigG5jvG/objCWoK3h1UNoM=;
	b=96GHO7kE//mCSmmANRBvMOvx8HaS41atmVmupWfpqbD7dZ2SgkrfgNa345n2svaY1McU7X
	jhC14mw1l3K+vRBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=0itR3CsJ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=07dwfYMr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761135125;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GOATducwgjJYNf5xRUUlUigG5jvG/objCWoK3h1UNoM=;
	b=0itR3CsJ5T5nlGrp1T/WtXxreTrPSocGRF4zQ4f3XhI9YY3XPh0vWuBt8QoLXHivGvm04Y
	PSY3NXtfF1+3fvANCWLhIVrwRw3ZnB4SYobonn3gczgNpSQFAYLoBuguoDF1jnoykizsPt
	Co0apKLApNKYdVL75VtBLV3KZV63L9A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761135125;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GOATducwgjJYNf5xRUUlUigG5jvG/objCWoK3h1UNoM=;
	b=07dwfYMrkhqVWXy+i2oBY4odwxdKrwib4Px9QAmfzvsuMFsfn+fxotX1tVMR4ecTVLlKRU
	U267ichU8LdJ9PDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 91A9413AAC;
	Wed, 22 Oct 2025 12:12:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ikGNIhTK+GjVHgAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Wed, 22 Oct 2025 12:12:04 +0000
Date: Wed, 22 Oct 2025 14:12:03 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: ltp@lists.linux.it, lkft@linaro.org, lkft-triage@linaro.org,
	arnd@kernel.org, dan.carpenter@linaro.org, jack@suse.cz,
	brauner@kernel.org, chrubis@suse.cz, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, lkft-triage@lists.linaro.org,
	regressions@lists.linux.dev, aalbersh@kernel.org, arnd@arndb.de,
	viro@zeniv.linux.org.uk, anders.roxell@linaro.org,
	benjamin.copeland@linaro.org, andrea.cervesato@suse.com
Subject: Re: [PATCH] ioctl_pidfd05: accept both EINVAL and ENOTTY as valid
 errors
Message-ID: <20251022121203.GA481852@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20251022115704.46936-1-naresh.kamboju@linaro.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022115704.46936-1-naresh.kamboju@linaro.org>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 1F30221168
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-test-project.readthedocs.io:url,suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_EQ_FROM(0.00)[]
X-Spam-Score: -3.71

Hi Naresh,

> Latest kernels return ENOTTY instead of EINVAL when invoking
> ioctl(pidfd, PIDFD_GET_INFO_SHORT, info_invalid).  Update the test to
> accept both EINVAL and ENOTTY as valid errors to ensure compatibility
> across different kernel versions.

Thanks a lot for contributing to LTP, we really appreciate it.

> Link: https://lore.kernel.org/all/CA+G9fYtUp3Bk-5biynickO5U98CKKN1nkE7ooxJHp7dT1g3rxw@mail.gmail.com
very nit: +1 for this. I prefer to reference it differently (e.g. [1]) as I add
Link: for referencing your actual patch the same way how it's used in kernel.
(e.g. Link: https://lore.kernel.org/ltp/20251022115704.46936-1-naresh.kamboju@linaro.org/)

> +++ b/testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c
> @@ -4,7 +4,7 @@
>   */

>  /*\
> - * Verify that ioctl() raises an EINVAL error when PIDFD_GET_INFO is used. This
> + * Verify that ioctl() raises an EINVAL or ENOTTY error when PIDFD_GET_INFO is used. This
nit: maybe note for ENOTTY: (from v6.18)?
>   * happens when:
>   *
>   * - info parameter is NULL
> @@ -14,6 +14,7 @@
>  #include "tst_test.h"
>  #include "lapi/pidfd.h"
>  #include "lapi/sched.h"
> +#include <errno.h>
>  #include "ioctl_pidfd.h"

>  struct pidfd_info_invalid {
> @@ -43,7 +44,22 @@ static void run(void)
>  		exit(0);

>  	TST_EXP_FAIL(ioctl(pidfd, PIDFD_GET_INFO, NULL), EINVAL);
> -	TST_EXP_FAIL(ioctl(pidfd, PIDFD_GET_INFO_SHORT, info_invalid), EINVAL);
> +	/* Expect ioctl to fail; accept either EINVAL or ENOTTY */
> +	TEST(ioctl(pidfd, PIDFD_GET_INFO_SHORT, info_invalid));

I'm sorry, we prefer these macros in include/tst_test_macros.h which shorten the
code. Could you please use TST_EXP_FAIL_ARR() [1]?

Kind regards,
Petr

[1] https://linux-test-project.readthedocs.io/en/latest/developers/api_c_tests.html#macro-tst-exp-fail-arr

> +	if (TEST_RETURN == -1) {
> +		if (TEST_ERRNO == EINVAL || TEST_ERRNO == ENOTTY) {
> +			tst_res(TPASS,
> +				"ioctl(PIDFD_GET_INFO_SHORT) failed as expected with %s",
> +				tst_strerrno(TEST_ERRNO));
> +		} else {
> +			tst_res(TFAIL,
> +				"Unexpected errno: %s (expected EINVAL or ENOTTY)",
> +				tst_strerrno(TEST_ERRNO));
> +		}
> +	} else {
> +		tst_res(TFAIL, "ioctl(PIDFD_GET_INFO_SHORT) unexpectedly succeeded");
> +	}
> +

>  	SAFE_CLOSE(pidfd);
>  }

