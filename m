Return-Path: <linux-fsdevel+bounces-2030-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F41AE7E16E9
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Nov 2023 22:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A89D8281315
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Nov 2023 21:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CC018E0B;
	Sun,  5 Nov 2023 21:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bkebJNJQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6ZSOgg8O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1CE168BB
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 Nov 2023 21:51:21 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50135BF;
	Sun,  5 Nov 2023 13:51:20 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D1D6B1F37C;
	Sun,  5 Nov 2023 21:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1699221078; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nqRgNE5P1jDzN7ZIPihQxLLxqpGLvqnRD7xIJqZCR3w=;
	b=bkebJNJQlgGnGaGuzrpv8xNNiYhy55GigospdGDghd7pT7NDhBo6KlBtKs3xDTrTtClU9j
	bjojsKlad8D6MHdAvX1mCiAW2luv/aldEG11y+2Mwl53MZldLEhANu1pp5KfWo5olHrDWl
	GrGtAc2VACtJxdpRnoSYlBzY0lkgtAQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1699221078;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nqRgNE5P1jDzN7ZIPihQxLLxqpGLvqnRD7xIJqZCR3w=;
	b=6ZSOgg8Ov49ZnnUtryHN6DXIxvEgeqeALDmK5+wogtQ4QXMTOz6frL4vjDWLKH6aALqPjq
	qvvC28koZqkUEKAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 906B413463;
	Sun,  5 Nov 2023 21:51:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id XKH0EFUOSGV/bgAAMHmgww
	(envelope-from <neilb@suse.de>); Sun, 05 Nov 2023 21:51:17 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Donald Buczek" <buczek@molgen.mpg.de>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
 linux-fsdevel@vger.kernel.org
Subject: Re: Heisenbug: I/O freeze can be resolved by cat $task/cmdline of
 unrelated process
In-reply-to: <77184fcc-46ab-4d69-b163-368264fa49f7@molgen.mpg.de>
References: <77184fcc-46ab-4d69-b163-368264fa49f7@molgen.mpg.de>
Date: Mon, 06 Nov 2023 08:51:11 +1100
Message-id: <169922107188.24305.7903791112230110428@noble.neil.brown.name>

On Sun, 05 Nov 2023, Donald Buczek wrote:
....
>=20
>      for task in /proc/*/task/*; do
>          echo  "# # $task: $(cat $task/comm) : $(cat $task/cmdline | xargs =
-0 echo)"
>          cmd cat $task/stack
>      done
>=20
> which can further be reduced to
>=20
>      for task in /proc/*/task/*; do echo $task $(cat $task/cmdline | xargs =
-0 echo); done
>=20
> This is absolutely reproducible. Above line unblocks the system reliably.
>=20
> Another remarkable thing: We've modified above code to do the
> processes slowly one by one and checking after each step if I/O
> resumed.  And each time we've tested that, it was one of the 64 nfsd
> processes (but not the very first one tried).  While the systems
> exports filesystems, we have absolutely no reason to assume, that any
> client actually tries to access this nfs server.  Additionally, when
> the full script is run, the stack traces show all nfsd tasks in their
> normal idle state ( [<0>] svc_recv+0x7bd/0x8d0 [sunrpc] ).
>=20
> Does anybody have an idea, how a `cat /proc/PID/cmdline` on a specific
> assumed-to-be-idle nfsd thread could have such an "healing" effect?

/proc/PID/cmndline for an nfsd thread is empty.  So it probably isn't
accessing 'cmdline' specifically that unblocks, but any (or almost any)
proc file for the process might help.

You say that *after* accessing cmdline, the "stack" file shows a normal
stack trace.  It might be interesting to see if that same stack is
present *before* accessing cmdline.  But my guess is that nfsd is mostly
a distraction.

It would help to see the fully "echo t > /proc/sysrq-trigger" list of all
process stacks.  That should reveal where the blockage is.

NeilBrown


>=20
> I'm well aware, that, for example, a hardware problem might result in
> just anything and that the question might not be answerable at all.
> If so: please excuse the noise.
>=20
> Thanks
> Donald
> --=20
> Donald Buczek
> buczek@molgen.mpg.de
> Tel: +49 30 8413 1433
>=20
>=20


