Return-Path: <linux-fsdevel+bounces-8395-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1AD835BAC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 08:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ACC41F221F1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 07:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDD1171D5;
	Mon, 22 Jan 2024 07:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="r16CENZi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zpp3PUi1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="r16CENZi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zpp3PUi1";
	dkim=permerror (0-bit key) header.d=gmail.com header.i=@gmail.com header.b="CzqZMzEZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56B1FBF1;
	Mon, 22 Jan 2024 07:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705908784; cv=none; b=YGwa8ZWMqWaOCwMjUgwwkGdbxnBY/Mz1GemHWB484aQi8qXUc/FfwK87TnlgNngWpnpUReg1WPkuD35INbIWctrTaoA206RM7aZuR5FpF0plikUitpqKmShu5JcZFCbM/9ZiZgdll5wDEu7mQBjobfhQhXfAEBMqoLnq27bq7oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705908784; c=relaxed/simple;
	bh=sWD5AGkRBwhuAG/GT1Bayy7saGl12tVct1E5myEMZ04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LiFo8NgTjH2esKPoZiuttqWVDj7UC3dILbdrdqHnLM3bEefYObviKgMirHY/dc33TgcnVmR/YpBKnPh2t5xWs1JqYihnImcRuuqX+ImR08F1q89IJRJj9WZjDlZqAXQNXsv+SQE1RmHweqsfhAhouP81j6/IuA/RAmhpbd+GFLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=r16CENZi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zpp3PUi1; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=r16CENZi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zpp3PUi1; dkim=permerror (0-bit key) header.d=gmail.com header.i=@gmail.com header.b=CzqZMzEZ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3C2A61FB96;
	Mon, 22 Jan 2024 07:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705908778;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:list-id:
	 list-unsubscribe:list-subscribe;
	bh=3igCp/BzejU8TkKcIbMGYWN93bxOYZ2K40uNvLaOz04=;
	b=r16CENZivv40J9jGSZzhRzZ8/4fFpAdxpyLT4kaqPCPcbJrDV62Mz2/p3XQ4fxMzJkWPph
	faSmjOxfd2i5mwdZ3GV6aVd1JNdUZdVSc1MjHuQ+jKBRClcDAcK2DwSC54JGVFiWeeoWQE
	sqOwq1zWq4SInVo6ny7rj9vVy3/kdlw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705908778;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:list-id:
	 list-unsubscribe:list-subscribe;
	bh=3igCp/BzejU8TkKcIbMGYWN93bxOYZ2K40uNvLaOz04=;
	b=zpp3PUi1pQV+VpbvqQ0qczoVRLDXcjVVREz/LYwpSyAAqxL36cM8E3F12ShoyK3dYAbEtw
	guJm6tb8bYI8AjAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705908778;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:list-id:
	 list-unsubscribe:list-subscribe;
	bh=3igCp/BzejU8TkKcIbMGYWN93bxOYZ2K40uNvLaOz04=;
	b=r16CENZivv40J9jGSZzhRzZ8/4fFpAdxpyLT4kaqPCPcbJrDV62Mz2/p3XQ4fxMzJkWPph
	faSmjOxfd2i5mwdZ3GV6aVd1JNdUZdVSc1MjHuQ+jKBRClcDAcK2DwSC54JGVFiWeeoWQE
	sqOwq1zWq4SInVo6ny7rj9vVy3/kdlw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705908778;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:list-id:
	 list-unsubscribe:list-subscribe;
	bh=3igCp/BzejU8TkKcIbMGYWN93bxOYZ2K40uNvLaOz04=;
	b=zpp3PUi1pQV+VpbvqQ0qczoVRLDXcjVVREz/LYwpSyAAqxL36cM8E3F12ShoyK3dYAbEtw
	guJm6tb8bYI8AjAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 23ED9139A2;
	Mon, 22 Jan 2024 07:32:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DTK5BikarmW+TAAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Mon, 22 Jan 2024 07:32:57 +0000
From: Petr Vorel <pvorel@suse.cz>
To: sedat.dilek@gmail.com,
	David Howells <dhowells@redhat.com>
Cc: ceph-devel@vger.kernel.org,
	davem@davemloft.net,
	eadavis@qq.com,
	edumazet@google.com,
	horms@kernel.org,
	jaltman@auristor.com,
	jarkko@kernel.org,
	jlayton@redhat.com,
	keyrings@vger.kernel.org,
	kuba@kernel.org,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	marc.dionne@auristor.com,
	markus.suvanto@gmail.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	pengfei.xu@intel.com,
	smfrench@gmail.com,
	stable@vger.kernel.org,
	torvalds@linux-foundation.org,
	wang840925@gmail.com,
	sashal@kernel.org,
	gregkh@linuxfoundation.org,
	pvorel@suse.cz
Subject: Re: [PATCH] keys, dns: Fix size check of V1 server-list header
Date: Mon, 22 Jan 2024 08:32:20 +0100
Message-ID: <CA+icZUUc_0M_6JU3dZzVqrUUrWJceY1uD8dO2yFMCwtHtkaa_Q@mail.gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <1850031.1704921100@warthog.procyon.org.uk>
References: <1850031.1704921100@warthog.procyon.org.uk>
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46]) (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits)) (No client certificate requested) by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5DE5382; Thu, 11 Jan 2024 05:59:25 +0000 (UTC)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-50eaa8b447bso5330201e87.1; Wed, 10 Jan 2024 21:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20230601; t=1704952764; x=1705557564; darn=vger.kernel.org; h=content-transfer-encoding:cc:to:subject:message-id:date:from :reply-to:in-reply-to:references:mime-version:from:to:cc:subject :date:message-id:reply-to; bh=FJ87IotFFb22oBVL3yLTlm/KMv2+8lgNVJRq/vObCyk=; b=CzqZMzEZtvDdKV5J1zvfpPjPR0wILxDKt26BQKl6dgvHwvuCdUpx9zofNRErh3RHcX 4RuSBM6WZWJ1QKGW+9aiqdcuZ62e09X44gxoTRBDE+voHnFnRDsr+edQ5ck1zC7LsJhN EMK1qwLK1bRNnbMuChx86E3Azw77svFukz6fqTpXK3bsM2rTrEDn7RijQtfJzRULk5fh 03jquwf/rzboIOEKrCR16L4yr1+Xatxw99hk68jjfEH+31e9vDr7ITE8LCsNPBfAQQpH P6UrE+PD1kzUZiHQ0KvBiTXXqrktw2yk9LaQhbiPyPJxRxnNuSars1Af7vD/wPL9xNN4 4M3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1e100.net; s=20230601; t=1704952764; x=1705557564; h=content-transfer-encoding:cc:to:subject:message-id:date:from :reply-to:in-reply-to:references:mime-version:x-gm-message-state :from:to:cc:subject:date:message-id:reply-to; bh=FJ87IotFFb22oBVL3yLTlm/KMv2+8lgNVJRq/vObCyk=; b=PZikC1qFb00UIl7giDpbUhRi+PwG7WMGC2I2TAEF1QH5b8owBpy+p/8rvT3vq+CCsV V461beb9lR8JKSyJ8vearvFNjmrLIwdr8iJQp047Rwx+y81rtRcoq5yQ/yYSOHA76ehV lG2l3qp7uLV1MfLdNTGrt1s2zyKLXu7rjfQwT4PmnAXsQMnVUVqx3nnKa0jZFzbUvrOX s/zCJhOF6LAB2tHaRWCdKxPTPkGzCPKp2F8Xet1nwZI0SRPETfv9nGa3Y0Ltqxv7XDHQ MJ8M7lvivuv4Xh6kXxoODM4mc+k54GZl5vBHmg5W8oItq7JtStAu94AtWAezRC/u+uR9 5KZQ==
X-Gm-Message-State: AOJu0YyVqvzD5u0f/yOoNxYT7dq5ZdTTUXgj+AXRBVyKnTXhwC7XN5aF /LgPOEbucY8bFWak009t9Uj9eZlnQaX9WuTMcro=
X-Google-Smtp-Source: AGHT+IGQ5ZV/gXo7v/rJ2auVyXpmqs0QYfi3tBSjxW2wUQzS96ysR1EG48kjTCbHRzoOg/0bxoYvPzkVO6R5r9tJSuk=
X-Received: by 2002:a05:6512:3990:b0:50e:2e5d:10a8 with SMTP id j16-20020a056512399000b0050e2e5d10a8mr136706lfu.133.1704952763509; Wed, 10 Jan 2024 21:59:23 -0800 (PST)
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: sedat.dilek@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Level: ********
X-Spamd-Bar: ++++++++
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=r16CENZi;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=zpp3PUi1
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [8.63 / 50.00];
	 HAS_REPLYTO(0.30)[sedat.dilek@gmail.com];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 SUSE_ML_WHITELIST_VGER(-0.10)[];
	 R_RATELIMIT(0.00)[to_ip_from(RL9hkrcy1f6ordxndu6pi8qgoz)];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 MAILLIST(-0.15)[generic];
	 FREEMAIL_TO(0.00)[gmail.com,redhat.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_COUNT_FIVE(0.00)[5];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,qq.com];
	 PRECEDENCE_BULK(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 FREEMAIL_REPLYTO(4.00)[gmail.com];
	 REPLYTO_DOM_NEQ_FROM_DOM(1.60)[];
	 MIME_GOOD(-0.10)[text/plain];
	 HAS_LIST_UNSUB(-0.01)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 SPOOF_REPLYTO(6.00)[suse.cz,gmail.com];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[29];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,qq.com,google.com,kernel.org,auristor.com,redhat.com,lists.infradead.org,gmail.com,intel.com,linux-foundation.org,linuxfoundation.org,suse.cz];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: 8.63
X-Rspamd-Queue-Id: 3C2A61FB96
X-Spam-Flag: NO

From: Sedat Dilek <sedat.dilek@gmail.com>

On Wed, Jan 10, 2024 at 10:12 PM David Howells <dhowells@redhat.com> wrote:
>
>
> Fix the size check added to dns_resolver_preparse() for the V1 server-list
> header so that it doesn't give EINVAL if the size supplied is the same as
> the size of the header struct (which should be valid).
>
> This can be tested with:
>
>         echo -n -e '\0\0\01\xff\0\0' | keyctl padd dns_resolver desc @p
>
> which will give "add_key: Invalid argument" without this fix.
>
> Fixes: 1997b3cb4217 ("keys, dns: Fix missing size check of V1 server-list header")

[ CC stable@vger.kernel.org ]

Your (follow-up) patch is now upstream.

https://git.kernel.org/linus/acc657692aed438e9931438f8c923b2b107aebf9

This misses CC: Stable Tag as suggested by Linus.

Looks like linux-6.1.y and linux-6.6.y needs it, too.

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v6.6.11&id=da89365158f6f656b28bcdbcbbe9eaf97c63c474
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v6.1.72&id=079eefaecfd7bbb8fcc30eccb0dfdf50c91f1805

BG,
-Sedat-

Hi Greg, Sasa,

could you please add this also to linux-6.1.y and linux-6.6.y?  (Easily
applicable to both, needed for both.) Or is there any reason why it's not
being added?

Kind regards,
Petr

> Reported-by: Pengfei Xu <pengfei.xu@intel.com>
> Link: https://lore.kernel.org/r/ZZ4fyY4r3rqgZL+4@xpf.sh.intel.com/
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Edward Adam Davis <eadavis@qq.com>
> cc: Linus Torvalds <torvalds@linux-foundation.org>
> cc: Simon Horman <horms@kernel.org>
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Cc: Jeffrey E Altman <jaltman@auristor.com>
> Cc: Wang Lei <wang840925@gmail.com>
> Cc: Jeff Layton <jlayton@redhat.com>
> Cc: Steve French <sfrench@us.ibm.com>
> Cc: Marc Dionne <marc.dionne@auristor.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> ---
>  net/dns_resolver/dns_key.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/dns_resolver/dns_key.c b/net/dns_resolver/dns_key.c
> index f18ca02aa95a..c42ddd85ff1f 100644
> --- a/net/dns_resolver/dns_key.c
> +++ b/net/dns_resolver/dns_key.c
> @@ -104,7 +104,7 @@ dns_resolver_preparse(struct key_preparsed_payload *prep)
>                 const struct dns_server_list_v1_header *v1;
>
>                 /* It may be a server list. */
> -               if (datalen <= sizeof(*v1))
> +               if (datalen < sizeof(*v1))
>                         return -EINVAL;
>
>                 v1 = (const struct dns_server_list_v1_header *)data;
>
>


