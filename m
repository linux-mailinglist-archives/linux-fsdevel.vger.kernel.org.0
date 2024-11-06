Return-Path: <linux-fsdevel+bounces-33725-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E23BB9BE215
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 10:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F2331C22F07
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 09:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B101D7E26;
	Wed,  6 Nov 2024 09:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aT9IYe8Q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6QHqFyb3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aT9IYe8Q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6QHqFyb3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76A818FC79;
	Wed,  6 Nov 2024 09:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730884415; cv=none; b=ujbq8zbWbE1NFrNuBKRd9fY2vFtokhSogPTFB/7kia9Vmw4BFC9WhfbWlq1G2WQ3vehZLK5ge5GfDxYo6Td06AZgVxj5xpUbuNqcnO4ZKKy0b+HrTszAC/GsIEVCpQ/ApKOhuFfv2jewmDoRpglcuPS5D4A9QCxpemUlLksnZmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730884415; c=relaxed/simple;
	bh=94jLYejycYOf9QVMSkq6kFYUacAS7FhoLpY6HToocEw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DGr75ng4HdGndexjHLGaMt7wmvZO9RcjbztR7DtefOFRmlUCb7ljJYdbG1698HshOiZrTgLGqdQrWjqcGxTI5HmzrCxVbF8Mm2O36gxqyhV1Aj6yGUifMTtdH6Uixg6yOnFYfUGCPDsuN/v2hLMuB7A0FWDOP9Ez1a9L3WLJ5RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aT9IYe8Q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6QHqFyb3; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aT9IYe8Q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6QHqFyb3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 03D2421BEB;
	Wed,  6 Nov 2024 09:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730884412; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=55cWaEw1ej/FBoRaobaIvMtc2C188kjtfQDLtG0KL54=;
	b=aT9IYe8QVUwwtCjLPdxhkcA3l0hG5I4m3Eek8AwTy86/3FhF14Bt1z3cmhZR6Sd4Lpx95+
	bQZXLyDI5UpMvO4SkxI+JrscO+wFLQtz4xiDfILLzjVGf46Q5BtnHaoarnxsTIfBjGMsP1
	aHtW7RfGjnNkWej9b4m8vpI/q5oepbg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730884412;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=55cWaEw1ej/FBoRaobaIvMtc2C188kjtfQDLtG0KL54=;
	b=6QHqFyb3xAlEL1Td6VbzIC6zu85WfgaWwUSNU0u1+j0FMRJeNwA/tdEf4tDuiVzJIriMD8
	S8yWQgWYVPx+msCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730884412; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=55cWaEw1ej/FBoRaobaIvMtc2C188kjtfQDLtG0KL54=;
	b=aT9IYe8QVUwwtCjLPdxhkcA3l0hG5I4m3Eek8AwTy86/3FhF14Bt1z3cmhZR6Sd4Lpx95+
	bQZXLyDI5UpMvO4SkxI+JrscO+wFLQtz4xiDfILLzjVGf46Q5BtnHaoarnxsTIfBjGMsP1
	aHtW7RfGjnNkWej9b4m8vpI/q5oepbg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730884412;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=55cWaEw1ej/FBoRaobaIvMtc2C188kjtfQDLtG0KL54=;
	b=6QHqFyb3xAlEL1Td6VbzIC6zu85WfgaWwUSNU0u1+j0FMRJeNwA/tdEf4tDuiVzJIriMD8
	S8yWQgWYVPx+msCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3AE0A13736;
	Wed,  6 Nov 2024 09:13:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VgjBNzgzK2fgTQAAD6G6ig
	(envelope-from <ddiss@suse.de>); Wed, 06 Nov 2024 09:13:28 +0000
Date: Wed, 6 Nov 2024 20:13:19 +1100
From: David Disseldorp <ddiss@suse.de>
To: kernel test robot <lkp@intel.com>
Cc: linux-fsdevel@vger.kernel.org, oe-kbuild-all@lists.linux.dev, Al Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 2/9] initramfs_test: kunit tests for initramfs
 unpacking
Message-ID: <20241106201319.1241bc4c.ddiss@suse.de>
In-Reply-To: <202411060625.exdzruA8-lkp@intel.com>
References: <20241104141750.16119-3-ddiss@suse.de>
	<202411060625.exdzruA8-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.30
X-Spam-Flag: NO

[adding kunit lists to cc, see lore link below for context]

https://lore.kernel.org/linux-fsdevel/20241104141750.16119-3-ddiss@suse.de/

On Wed, 6 Nov 2024 07:04:21 +0800, kernel test robot wrote:
...
> All warnings (new ones prefixed by >>, old ones prefixed by <<):
> 
> >> WARNING: modpost: vmlinux: section mismatch in reference: initramfs_test_cases+0x0 (section: .data) -> initramfs_test_extract (section: .init.text)
> >> WARNING: modpost: vmlinux: section mismatch in reference: initramfs_test_cases+0x30 (section: .data) -> initramfs_test_fname_overrun (section: .init.text)
> >> WARNING: modpost: vmlinux: section mismatch in reference: initramfs_test_cases+0x60 (section: .data) -> initramfs_test_data (section: .init.text)
> >> WARNING: modpost: vmlinux: section mismatch in reference: initramfs_test_cases+0x90 (section: .data) -> initramfs_test_csum (section: .init.text)
> >> WARNING: modpost: vmlinux: section mismatch in reference: initramfs_test_cases+0xc0 (section: .data) -> initramfs_test_hardlink (section: .init.text)
> >> WARNING: modpost: vmlinux: section mismatch in reference: initramfs_test_cases+0xf0 (section: .data) -> initramfs_test_many (section: .init.text)  

If I understand correctly, the kunit_case initramfs_test_cases[]
members can't be flagged __initdata, as they need to be present
post-init for results queries via debugfs.

The remaining -Wimplicit-function-declaration reports are all valid.
I'll fix them in v3.

Thanks, David

