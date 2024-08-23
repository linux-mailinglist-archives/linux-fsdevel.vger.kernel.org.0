Return-Path: <linux-fsdevel+bounces-26856-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5428E95C27B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 02:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C90FE2847E9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 00:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4200BA46;
	Fri, 23 Aug 2024 00:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="A0kMJ8wW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uy5I5KAV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="A0kMJ8wW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uy5I5KAV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A194B1C36
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 00:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724373124; cv=none; b=a4oscs+0Uf3yMDf7k1rYK5E/N7ThmNAqi6kPudm0fwm6Pm2CJYQkADcsamXQjGhaQ6kStsikIZrliPNniBK+MIjIOqYKf7ZRZygN/6bGpCggkVeHjtDSm6GkGrX/POg4YyEa5WNdZb3YAHsXOSnHFtjHuWIAtvgsuflY5+aS15U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724373124; c=relaxed/simple;
	bh=E8yMrR8PXvsjBMb1lg0SkuIhXdkOQtdDAxMDsikVcxY=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=YtLD+9mJMR8JKssy6MmS4LLV6aKBaruLnSll4LJm8TFRtQDeuP3NrHOhaQ/shL4PlF+sOBMsxkhLerEcxx5Ug7IGYNSi/cPV8OhtSwu5JrPg3FA9UDJGIrYksx8tnyPGt/D45dCuQO1779/pkH3KHyr3OUtSoxy1tWiqKE/tL2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=A0kMJ8wW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uy5I5KAV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=A0kMJ8wW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uy5I5KAV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B5A8A2257E;
	Fri, 23 Aug 2024 00:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724373120; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=muIVLgLFtGvvIjyFDP9TbZqdc/tKjSKeLLz0SSRZcOY=;
	b=A0kMJ8wWrZrDDINB4+4iZcwBhoWPFy15BwQP053cAzopC6jI/T1OU3xcGusXvvElwB9ioQ
	/TrDt5VxtQvc/Ob7g2Ex8y0jSpYqnZlvgHD4qgb2RvQKtmeOumJRKt/gz7cdqFAEGtERJi
	ov8xLv0xDorDHLfLC5tH5Vl5wEGVf6o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724373120;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=muIVLgLFtGvvIjyFDP9TbZqdc/tKjSKeLLz0SSRZcOY=;
	b=uy5I5KAVsT9KhJHLRqg7eBRiN1ZkoD8DYwZt1rvhVtb0JWTTh05dGFBfD4r+ZAPlIm1DuH
	UpBpdR53tYGU2iCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724373120; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=muIVLgLFtGvvIjyFDP9TbZqdc/tKjSKeLLz0SSRZcOY=;
	b=A0kMJ8wWrZrDDINB4+4iZcwBhoWPFy15BwQP053cAzopC6jI/T1OU3xcGusXvvElwB9ioQ
	/TrDt5VxtQvc/Ob7g2Ex8y0jSpYqnZlvgHD4qgb2RvQKtmeOumJRKt/gz7cdqFAEGtERJi
	ov8xLv0xDorDHLfLC5tH5Vl5wEGVf6o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724373120;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=muIVLgLFtGvvIjyFDP9TbZqdc/tKjSKeLLz0SSRZcOY=;
	b=uy5I5KAVsT9KhJHLRqg7eBRiN1ZkoD8DYwZt1rvhVtb0JWTTh05dGFBfD4r+ZAPlIm1DuH
	UpBpdR53tYGU2iCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 50154139D3;
	Fri, 23 Aug 2024 00:31:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id D1fIAX7Yx2YpCgAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 23 Aug 2024 00:31:58 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Christian Brauner" <brauner@kernel.org>
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Peter Zijlstra" <peterz@infradead.org>, "Ingo Molnar" <mingo@redhat.com>,
 "Jeff Layton" <jlayton@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "Christian Brauner" <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v2 4/6] inode: port __I_NEW to var event
In-reply-to: <20240821-work-i_state-v2-4-67244769f102@kernel.org>
References: <20240821-work-i_state-v2-0-67244769f102@kernel.org>,
 <20240821-work-i_state-v2-4-67244769f102@kernel.org>
Date: Fri, 23 Aug 2024 10:31:55 +1000
Message-id: <172437311532.6062.13754145971447516576@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.27 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.17)[-0.835];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-Spam-Score: -4.27
X-Spam-Flag: NO

On Thu, 22 Aug 2024, Christian Brauner wrote:
> Port the __I_NEW mechanism to use the new var event mechanism.
>=20
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/bcachefs/fs.c          | 10 ++++++----
>  fs/dcache.c               |  3 +--
>  fs/inode.c                | 18 ++++++++----------
>  include/linux/writeback.h |  3 ++-
>  4 files changed, 17 insertions(+), 17 deletions(-)
>=20
> diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
> index 94c392abef65..c0900c0c0f8a 100644
> --- a/fs/bcachefs/fs.c
> +++ b/fs/bcachefs/fs.c
> @@ -1644,14 +1644,16 @@ void bch2_evict_subvolume_inodes(struct bch_fs *c, =
snapshot_id_list *s)
>  				break;
>  			}
>  		} else if (clean_pass && this_pass_clean) {
> -			wait_queue_head_t *wq =3D bit_waitqueue(&inode->v.i_state, __I_NEW);
> -			DEFINE_WAIT_BIT(wait, &inode->v.i_state, __I_NEW);
> +			struct wait_bit_queue_entry wqe;
> +			struct wait_queue_head *wq_head;
> =20
> -			prepare_to_wait(wq, &wait.wq_entry, TASK_UNINTERRUPTIBLE);
> +			wq_head =3D inode_bit_waitqueue(&wqe, &inode->v, __I_NEW);

I don't think you EXPORT inode_bit_waitqueue() so you cannot use it in
this module.

And maybe it would be good to not export it so that this code can get
cleaned up.
Maybe I'm missing something obvious but it seems weird.
Earlier in this file a comment tells use that bcache doesn't use I_NEW,
but here is bcache explicitly waiting for it.

If bch2_inode_insert() called unlock_new_inode() immediately *before*
adding the inode to vfs_inodes_list instead of just after, this loop
that walks vfs_inodes_list would never need to wait for I_NEW to be
cleared.

I wonder if I am missing something.

NeilBrown

