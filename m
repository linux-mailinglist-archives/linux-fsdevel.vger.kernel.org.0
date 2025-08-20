Return-Path: <linux-fsdevel+bounces-58353-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 79447B2D13B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 03:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 48D284E447F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 01:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6A71A5BBE;
	Wed, 20 Aug 2025 01:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sGggO+fp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+asoAwJ2";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sGggO+fp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+asoAwJ2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC311714B7
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Aug 2025 01:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755652426; cv=none; b=TonukWzm2x0ulP0s0jWiSoSGJoyyqY7af+r+SqIl1kjXdMWRgPunKiT1V0mHOhsY1alJZra/tY6DBc7X9HqSm3ECwf7vOQfDvbQ6WP3TGnpZon9M/oF6zntRlQTMvnT52HwQ5PMr4qcJxzCzaXgvxC8o9K4i90IeGvf8idP3VuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755652426; c=relaxed/simple;
	bh=kxnX6ob31RX3s+OkNVF7X8IV7TZoAcVr2PrPqU8Vx4w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YcgPM1v/VuuADHVQGH9m7S2TgfDjv2dw3yMzviVHWnN9oAHG/nQt+IGCrrNtf5FgdXk6BOz5D/UP8SFI+1nHF6N4Jbt0WV3UR+rVdBuctdO8I65/MSc1Ek7liEJDFtGt6wvYLDzr6LKm+LSdcnAb8xM/1hr0gPUENZUoAwlw8/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sGggO+fp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+asoAwJ2; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sGggO+fp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+asoAwJ2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 01DAC1F785;
	Wed, 20 Aug 2025 01:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755652423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KIfi0a7kuPd0Ua7J5EBu0gSrCmMoU1TlizTgsIHHqYU=;
	b=sGggO+fpuZq7yDwp1IP6WIhDZj9s2ZYrw+p9WY0qYnAXw5uvvRw0XIh3MLJpfUimrYTpkO
	OnsuHK5uhCTA9BCzldf1HA15+irlxFOd0YMeGYSiSCwfFZjSkV38+gZoc8uaVLOUXyjcJJ
	d2Xs/fi/9z23PcKNxfj5U0zIzCvTmCo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755652423;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KIfi0a7kuPd0Ua7J5EBu0gSrCmMoU1TlizTgsIHHqYU=;
	b=+asoAwJ2Sjvw1fwYuGY0xV1mbeQz9YCgztaWtZmWB7ufmv5J8RIPOlBjZKIPufEI6751La
	Xo/OZIjCPUeZVsBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755652423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KIfi0a7kuPd0Ua7J5EBu0gSrCmMoU1TlizTgsIHHqYU=;
	b=sGggO+fpuZq7yDwp1IP6WIhDZj9s2ZYrw+p9WY0qYnAXw5uvvRw0XIh3MLJpfUimrYTpkO
	OnsuHK5uhCTA9BCzldf1HA15+irlxFOd0YMeGYSiSCwfFZjSkV38+gZoc8uaVLOUXyjcJJ
	d2Xs/fi/9z23PcKNxfj5U0zIzCvTmCo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755652423;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KIfi0a7kuPd0Ua7J5EBu0gSrCmMoU1TlizTgsIHHqYU=;
	b=+asoAwJ2Sjvw1fwYuGY0xV1mbeQz9YCgztaWtZmWB7ufmv5J8RIPOlBjZKIPufEI6751La
	Xo/OZIjCPUeZVsBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9B8D113867;
	Wed, 20 Aug 2025 01:13:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gs/LFEQhpWjadQAAD6G6ig
	(envelope-from <ddiss@suse.de>); Wed, 20 Aug 2025 01:13:40 +0000
Date: Wed, 20 Aug 2025 11:13:34 +1000
From: David Disseldorp <ddiss@suse.de>
To: kernel test robot <lkp@intel.com>
Cc: linux-kbuild@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 oe-kbuild-all@lists.linux.dev, linux-next@vger.kernel.org, nsc@kernel.org
Subject: Re: [PATCH v3 8/8] initramfs_test: add filename padding test case
Message-ID: <20250820111334.51e91938.ddiss@suse.de>
In-Reply-To: <202508200304.wF1u78il-lkp@intel.com>
References: <20250819032607.28727-9-ddiss@suse.de>
	<202508200304.wF1u78il-lkp@intel.com>
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
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -3.30

On Wed, 20 Aug 2025 04:16:48 +0800, kernel test robot wrote:

> sparse warnings: (new ones prefixed by >>)
> >> init/initramfs_test.c:415:18: sparse: sparse: Initializer entry defined twice  
>    init/initramfs_test.c:425:18: sparse:   also defined here
...
>    407		struct initramfs_test_cpio c[] = { {
>    408			.magic = "070701",
>    409			.ino = 1,
>    410			.mode = S_IFREG | 0777,
>    411			.uid = 0,
>    412			.gid = 0,
>    413			.nlink = 1,
>    414			.mtime = 1,
>  > 415			.filesize = 0,  
...
>    425			.filesize = sizeof(fdata),
>    426		} };

Thanks. I can send a v4 patchset to address this, or otherwise happy to
have line 415 removed by a maintainer when merged.

