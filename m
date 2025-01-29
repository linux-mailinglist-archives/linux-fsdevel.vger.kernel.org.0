Return-Path: <linux-fsdevel+bounces-40319-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B61C9A222B9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 18:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B2B61884392
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 17:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A7D1E0B86;
	Wed, 29 Jan 2025 17:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tdcLNM04";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7NcLMcMH";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tdcLNM04";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7NcLMcMH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58F11DF742;
	Wed, 29 Jan 2025 17:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738171215; cv=none; b=bg/3b6X+/wqIu8oefnjXKD1J7gX64HDYV4ema0tgV+xyDnQalB0N9TwreIO0+jfTPm29DefO8o1b/KMtHgYRryf654rUkFqxXE1aUpnDQxeG3D2fK8UcgNFImM8L8NJG7jfq6qj78ohBk6Zb/M6erycotn/d7VPWmuwp1a5fXqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738171215; c=relaxed/simple;
	bh=gIhxg0cAPjdLLZCbQoxAKYUV/FgS44R6EUSdwCqMXVU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A/YyqMQXvc1sMB61XT9qOGFu+4KiXGrHlB8RIyZIOGF0g3anM93L0kLtLZm4fa3awT2wRQZSkzWdfyLnXkX9jlxGh6ft4KhXd8fidGeSu3z6DLeOUnsc02BNY/mPVulPebBpBgpRT6I3wDPYpD6BGh9Nc+x8h1bEhHXrAauztv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tdcLNM04; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7NcLMcMH; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tdcLNM04; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7NcLMcMH; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from hawking.nue2.suse.org (unknown [10.168.4.11])
	by smtp-out2.suse.de (Postfix) with ESMTP id 19CA11F365;
	Wed, 29 Jan 2025 17:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738171212; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8PVjeOTkMBSAcHcY2G8sb0Gayt/prH91RL5Rc6LjVwc=;
	b=tdcLNM04Cqj+90LwHPVXU9pD7aEcIG0dz44MyQoHcPJ1RHkL7YdkQe4sJrCEP5w7EOw6iV
	SjKu9vm7rTmQ0lomV3p/o0Z1sS0rCn84O7m2vRQxISNeeOAkZELuSz4d9ao9W7b+ihn10W
	HBr34EZ9mxmW26uPhIwenHhiw+sXbX4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738171212;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8PVjeOTkMBSAcHcY2G8sb0Gayt/prH91RL5Rc6LjVwc=;
	b=7NcLMcMH+mw0wonQIjB2h7Ygzbns9AdLEGyOVYKp/gC3mPlgG1PGA6H9bIgtW00RfCNo6u
	tEDcdyzHDLR3/8AQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738171212; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8PVjeOTkMBSAcHcY2G8sb0Gayt/prH91RL5Rc6LjVwc=;
	b=tdcLNM04Cqj+90LwHPVXU9pD7aEcIG0dz44MyQoHcPJ1RHkL7YdkQe4sJrCEP5w7EOw6iV
	SjKu9vm7rTmQ0lomV3p/o0Z1sS0rCn84O7m2vRQxISNeeOAkZELuSz4d9ao9W7b+ihn10W
	HBr34EZ9mxmW26uPhIwenHhiw+sXbX4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738171212;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8PVjeOTkMBSAcHcY2G8sb0Gayt/prH91RL5Rc6LjVwc=;
	b=7NcLMcMH+mw0wonQIjB2h7Ygzbns9AdLEGyOVYKp/gC3mPlgG1PGA6H9bIgtW00RfCNo6u
	tEDcdyzHDLR3/8AQ==
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
	id 05E514AAD7B; Wed, 29 Jan 2025 18:20:12 +0100 (CET)
From: Andreas Schwab <schwab@suse.de>
To: linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,  linux-fsdevel@vger.kernel.org
Subject: Re: Multigrain timestamps do not work on RISC-V
In-Reply-To: <mvmv7ty3pd8.fsf@suse.de> (Andreas Schwab's message of "Wed, 29
	Jan 2025 11:07:15 +0100")
References: <mvmv7ty3pd8.fsf@suse.de>
Date: Wed, 29 Jan 2025 18:20:11 +0100
Message-ID: <mvmikpx4jw4.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Score: -4.20
X-Spamd-Result: default: False [-4.20 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	RCVD_NO_TLS_LAST(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ONE(0.00)[1];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_THREE(0.00)[3]
X-Spam-Flag: NO
X-Spam-Level: 

On Jan 29 2025, Andreas Schwab wrote:

> My guess would be that something in inode_set_ctime_current is going
> wrong.

The bug is in the arch_cmpxchg macros in <asm/cmpxchg.h>, they mishandle
atomic exchange of u32 values:

    # fs/inode.c:2802: 	if (cns == now.tv_nsec && inode->i_ctime_sec == now.tv_sec) {
    #NO_APP
            ld	a5,-96(s0)		# _33, now.tv_nsec
    # fs/inode.c:2802: 	if (cns == now.tv_nsec && inode->i_ctime_sec == now.tv_sec) {
            slli	a4,s2,32	#, _49, cns
            srli	a4,a4,32	#, _49, _49
    # fs/inode.c:2802: 	if (cns == now.tv_nsec && inode->i_ctime_sec == now.tv_sec) {
            beq	a4,a5,.L1248	#, _49, _33,
    .L1205:
            addi	a3,s1,120	#, __ai_ptr, inode
    .L1221:
    # fs/inode.c:2809: 	if (try_cmpxchg(&inode->i_ctime_nsec, &cur, now.tv_nsec)) {
    #APP
    # 2809 "fs/inode.c" 1
            0:	lr.w a2, 0(a3)	# __ret, *__ai_ptr_20
            bne  a2, a4, 1f	# __ret, _49

Here the unsigned extended value of cur (a4) is compared with the sign
extended value of inode->i_ctime_nsec (a2).  They cannot match if cur
has I_CTIME_QUERIED set (the sign bit).  The lr/sc loop is exited before
the store conditional is executed.

            sc.w.rl a1, a5, 0(a3)	# __rc, _33, *__ai_ptr_20
            bnez a1, 0b	# __rc
            fence rw,rw
    1:

    # 0 "" 2
    #NO_APP
            sext.w	a5,a2	# __ret, __ret

A redundant sign extension of the current contents of inode->i_ctime_nsec.

    # fs/inode.c:2809: 	if (try_cmpxchg(&inode->i_ctime_nsec, &cur, now.tv_nsec)) {
            bne	a5,s2,.L1211	#, __ret, cns,

Here the sign extended value of inode->i_ctime_nsec (a5) is compared
with the sign extended expected value (s2).  They match, and try_cmpxchg
returns true, but the store never happend.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."

