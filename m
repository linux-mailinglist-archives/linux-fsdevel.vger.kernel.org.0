Return-Path: <linux-fsdevel+bounces-61313-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7636B578A4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 13:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 814E4173845
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 11:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11102FA0F4;
	Mon, 15 Sep 2025 11:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="L4Q/Y2OF";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Lqzjjb0M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D8F2EC54B
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 11:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757936384; cv=none; b=OUW08+TMmbfmHIvCoMIU16oW5TwNN7q/42j9S/M5+Zs+VadCKTcn2WdRNMpsrCmVT2qjRF3rTD1nzxQZ7vEsGX9yO7vdFZmA4NpV449vutrMZLLhkpTicIfJ8gwKtPVvexgP08mRLBxQeqI3yJFDxxPb0wpaIyFgvqzZODl18wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757936384; c=relaxed/simple;
	bh=pxRfG48JHXGzCjqxBTxY6WKUTTCQO9YnXY/gPGtCk58=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fi1iqOZcyRl6q3mqxYv8r4oy+0YK8D+720/yY/TX9s8vBVOt1oW7xHiM+GNy0/JfMJwk0PfWPS8Qigrd+6MiDASkkTxgugWlbLoOAVN33jWdH/5CpSvAyIG6QGD4QFVmjgZ13iYuKFX7fdiO8az1gj/y1f5c+Ec5KyBPTYwlrBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=L4Q/Y2OF; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Lqzjjb0M; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4C80F1F8B0;
	Mon, 15 Sep 2025 11:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1757936380; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EWS23Ksjhwng7aG6+P+qQcbIi/2CQPisnn0O+hxkMsA=;
	b=L4Q/Y2OFxwSYzdRcb8rWDUuYmbyAyMQdz/fc2+sBsJy7ufhEhdGopXHtlV7HsKJgOBTovM
	O9d1vT3GGcuQ6dXtelsFDMpt6AoaRQ4BrZj7EvOESuxbqHoP49nGBCFsd30LL8jb+NCGsU
	gG8XKxYL5XF+AfPVs1G4vOqGy0eU6Zc=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1757936379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EWS23Ksjhwng7aG6+P+qQcbIi/2CQPisnn0O+hxkMsA=;
	b=Lqzjjb0MbCaXtzRZJx+p3SKHQogb0vADJ0WeO62Vgo7CyOHf+O6GQDk15BJfZevMwd60ZU
	qErT6ECVt/kVYr97Bxu+EwbLF3hGilNKyPbb6DKPBLkRpaV+CO8/SqPGeCTb7RKewiXLRE
	VjLQFa+s1JsDLEYXYsiWsMAtvvYigWI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 16ECE1372E;
	Mon, 15 Sep 2025 11:39:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uDKLBPv6x2gqKQAAD6G6ig
	(envelope-from <mwilck@suse.com>); Mon, 15 Sep 2025 11:39:39 +0000
Message-ID: <aa5d1e137ddab12d1fa6beca4279fd9c90ff58dd.camel@suse.com>
Subject: Re: [PATCH] init: INITRAMFS_PRESERVE_MTIME should depend on
 BLK_DEV_INITRD
From: Martin Wilck <mwilck@suse.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>, Andrew Morton	
 <akpm@linux-foundation.org>, David Disseldorp <ddiss@suse.de>, Alexander
 Viro	 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Jan Kara	 <jack@suse.cz>
Cc: Askar Safin <safinaskar@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 15 Sep 2025 13:39:38 +0200
In-Reply-To: <9a65128514408dc7de64cf4fea75c1a8342263ea.1757920006.git.geert+renesas@glider.be>
References: 
	<9a65128514408dc7de64cf4fea75c1a8342263ea.1757920006.git.geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[renesas];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80

On Mon, 2025-09-15 at 09:11 +0200, Geert Uytterhoeven wrote:
> INITRAMFS_PRESERVE_MTIME is only used in init/initramfs.c and
> init/initramfs_test.c.=C2=A0 Hence add a dependency on BLK_DEV_INITRD, to
> prevent asking the user about this feature when configuring a kernel
> without initramfs support.
>=20
> Fixes: 1274aea127b2e8c9 ("initramfs: add INITRAMFS_PRESERVE_MTIME
> Kconfig option")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Martin  Wilck <mwilck@suse.com>

> ---
> =C2=A0init/Kconfig | 1 +
> =C2=A01 file changed, 1 insertion(+)
>=20
> diff --git a/init/Kconfig b/init/Kconfig
> index e3eb63eadc8757a1..c0c61206499e6bd5 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1501,6 +1501,7 @@ config BOOT_CONFIG_EMBED_FILE
> =C2=A0
> =C2=A0config INITRAMFS_PRESERVE_MTIME
> =C2=A0	bool "Preserve cpio archive mtimes in initramfs"
> +	depends on BLK_DEV_INITRD
> =C2=A0	default y
> =C2=A0	help
> =C2=A0	=C2=A0 Each entry in an initramfs cpio archive carries an mtime
> value. When

