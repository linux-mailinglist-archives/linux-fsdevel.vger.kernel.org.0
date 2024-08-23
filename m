Return-Path: <linux-fsdevel+bounces-26857-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F010D95C281
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 02:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5F892849C1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 00:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCE0BA46;
	Fri, 23 Aug 2024 00:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SpkuuldI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Qt6+w0pa";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SpkuuldI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Qt6+w0pa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59D71CA96
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 00:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724373424; cv=none; b=fGof/UbwMgd0V+K9G4D4I4J9ZQ/Qfvx9Ew+9o8tjKmB//OdCJ92RfdAeE4ryN1S3J2cr67Czqw9UpqpoGQGw817vPaysS0ybLa6lYJNpsyrPAmf60J+ZP6n/2Vl3w7WJvc+0yfdnsYzAlonYbJYhDgtGmFaLEAk1/RCKjef3QNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724373424; c=relaxed/simple;
	bh=FpjHkCHpdzp/LBDzVsrGmt3YZworrFMaDbEWHs6FZzY=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=NKE+O+aAfcN93ZVUqqGEu5dXSlGQxLLDoi755ydXiEWZag34sU+X1m8yQv/c3dGsJcy2Yz7EpzQOLLUytESci3ezRalSY49dhOmvZ6sNm/EttjzLs06K6O3ako+sxufJ3tqkubp+8pjC+weq1nDjuTQmxBrRzEF0oXEREKblFg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SpkuuldI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Qt6+w0pa; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SpkuuldI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Qt6+w0pa; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2909B223E2;
	Fri, 23 Aug 2024 00:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724373421; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QEMmiGGSoY9hJU/rTR77tOeSaryfobSDoTxeYppJjS8=;
	b=SpkuuldIvafSYA7W7ZloLXj7xiiWehuWibLswToRIRmlpXrXqJaD5oQdNWzzHhcbCqQNTM
	GwQO6EhyJpBlUEF2HQEDPaEq8WSWDD0LqDFk/zFx3wqe3VoWCavGMLIZknKF3JV0FStiNd
	Ytl9/9NCNDyiKKcB9rPb3JwtMRA04x8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724373421;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QEMmiGGSoY9hJU/rTR77tOeSaryfobSDoTxeYppJjS8=;
	b=Qt6+w0paR5z6tKb9dvaRHUDk0nRJejh/eDxf1z0VqqPMGtBN35KoNrU7NDIU+rPC9IkOQ6
	b9EFMdS/PvFjWqDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724373421; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QEMmiGGSoY9hJU/rTR77tOeSaryfobSDoTxeYppJjS8=;
	b=SpkuuldIvafSYA7W7ZloLXj7xiiWehuWibLswToRIRmlpXrXqJaD5oQdNWzzHhcbCqQNTM
	GwQO6EhyJpBlUEF2HQEDPaEq8WSWDD0LqDFk/zFx3wqe3VoWCavGMLIZknKF3JV0FStiNd
	Ytl9/9NCNDyiKKcB9rPb3JwtMRA04x8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724373421;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QEMmiGGSoY9hJU/rTR77tOeSaryfobSDoTxeYppJjS8=;
	b=Qt6+w0paR5z6tKb9dvaRHUDk0nRJejh/eDxf1z0VqqPMGtBN35KoNrU7NDIU+rPC9IkOQ6
	b9EFMdS/PvFjWqDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B4EB7139D3;
	Fri, 23 Aug 2024 00:36:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id J0sEGqrZx2ZkCwAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 23 Aug 2024 00:36:58 +0000
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
Subject: Re: [PATCH RFC v2 5/6] inode: port __I_LRU_ISOLATING to var event
In-reply-to: <20240821-work-i_state-v2-5-67244769f102@kernel.org>
References: <20240821-work-i_state-v2-0-67244769f102@kernel.org>,
 <20240821-work-i_state-v2-5-67244769f102@kernel.org>
Date: Fri, 23 Aug 2024 10:36:55 +1000
Message-id: <172437341576.6062.4865045633122673711@noble.neil.brown.name>
X-Spam-Score: -4.26
X-Spamd-Result: default: False [-4.26 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.16)[-0.822];
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
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, 22 Aug 2024, Christian Brauner wrote:
> Port the __I_LRU_ISOLATING mechanism to use the new var event mechanism.
>=20
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/inode.c | 26 +++++++++++++++++---------
>  1 file changed, 17 insertions(+), 9 deletions(-)
>=20
> diff --git a/fs/inode.c b/fs/inode.c
> index d18e1567c487..c8a5c63dc980 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -510,8 +510,7 @@ static void inode_unpin_lru_isolating(struct inode *ino=
de)
>  	spin_lock(&inode->i_lock);
>  	WARN_ON(!(inode->i_state & I_LRU_ISOLATING));
>  	inode->i_state &=3D ~I_LRU_ISOLATING;
> -	smp_mb();
> -	wake_up_bit(&inode->i_state, __I_LRU_ISOLATING);
> +	inode_wake_up_bit(inode, __I_LRU_ISOLATING);
>  	spin_unlock(&inode->i_lock);
>  }
> =20
> @@ -519,13 +518,22 @@ static void inode_wait_for_lru_isolating(struct inode=
 *inode)
>  {
>  	lockdep_assert_held(&inode->i_lock);
>  	if (inode->i_state & I_LRU_ISOLATING) {
> -		DEFINE_WAIT_BIT(wq, &inode->i_state, __I_LRU_ISOLATING);
> -		wait_queue_head_t *wqh;
> -
> -		wqh =3D bit_waitqueue(&inode->i_state, __I_LRU_ISOLATING);
> -		spin_unlock(&inode->i_lock);
> -		__wait_on_bit(wqh, &wq, bit_wait, TASK_UNINTERRUPTIBLE);
> -		spin_lock(&inode->i_lock);
> +		struct wait_bit_queue_entry wqe;
> +		struct wait_queue_head *wq_head;
> +
> +		wq_head =3D inode_bit_waitqueue(&wqe, inode, __I_LRU_ISOLATING);
> +		for (;;) {
> +			prepare_to_wait_event(wq_head, &wqe.wq_entry,
> +					      TASK_UNINTERRUPTIBLE);
> +			if (inode->i_state & I_LRU_ISOLATING) {
> +				spin_unlock(&inode->i_lock);
> +				schedule();
> +				spin_lock(&inode->i_lock);
> +				continue;
> +			}
> +			break;
> +		}
> +		finish_wait(wq_head, &wqe.wq_entry);

I would really like to add

  wait_var_event_locked(variable, conditon, spinlock)

so that above would be one or two lines.

 #define  wait_var_event_locked(var, condition, lock) \
    do { \
	might_sleep(); \
	if (condition) \
		break; \
	___wait_var_event(var, condition, TASK_UNINTERRUPTIBLE, \
			  0, 0,  \
			  spin_unlock(lock);schedule();spin_lock(lock)); \
    } while(0)

That can happen after you series lands though.

The wake_up here don't need a memory barrier either.

NeilBrown


>  		WARN_ON(inode->i_state & I_LRU_ISOLATING);
>  	}
>  }
>=20
> --=20
> 2.43.0
>=20
>=20


