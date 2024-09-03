Return-Path: <linux-fsdevel+bounces-28433-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D708496A2D3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 17:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 625BC1F2621D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 15:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE6916F8EF;
	Tue,  3 Sep 2024 15:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="C1MzK8p8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qgXfca63";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="C1MzK8p8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qgXfca63"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE0412B94;
	Tue,  3 Sep 2024 15:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725377679; cv=none; b=HUT9hiCRbX84dWyNl/HLkqA5LxdiK44oZIuu0fRs3Utr/Y7rn4iPDPSH5p2Ve0eyOM4vI4gNCrzHl0Z/3B2ORvhCqIFYjAUtHghrHMPmvXLKkpmgFtFOhjq6kcG4fy3FWioN+QgIQQYSF6fPn1KrPYprBKRN8oqgNaXdjfa7kU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725377679; c=relaxed/simple;
	bh=CX6hlROLZ6Dn8+zXI9cvISHl8JPsSH5HsPbTaV7hlNU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ejdt0amSQEU39caE5z0/71JwjAfo0peH9FwwEnfpyU3S8SaQEQxOR6Mn/c/3Y1XWuIy2w0+zVV9xczxyaRyGb1Zv3qW8uLZS5t8q3T6WM9/VlXetLNyktCu9XXTF7gGvS81FpdprNdFejduh+KIo8LY5ZrsjodSgWQZwUWywOdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=C1MzK8p8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qgXfca63; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=C1MzK8p8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qgXfca63; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 160B51F394;
	Tue,  3 Sep 2024 15:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725377676; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g+G1IaZ6ST+Ogx2tNLBxW/wP/RnUtilr7tfLezU2LOA=;
	b=C1MzK8p8TybH6W5pmXwLvfwdOQ+toBgGXM6BG7PajFQm6UclSRvkq9MQJwwq2HhQ+7GrmX
	8O58Wa/RxSt+4M7gPkaQjDLJRAlTYyzuYNtZUXmT4z/erdtQGczw/m7NXNn6moRuDrVKZF
	MaYBfFGd708/VO56QK8848oRyy5S8Fw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725377676;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g+G1IaZ6ST+Ogx2tNLBxW/wP/RnUtilr7tfLezU2LOA=;
	b=qgXfca63PcJBhsS6pa1+scP610t/aTNMEKhlC2mOndwLcffBh5F6tIYF7oBhmawxvK5ir6
	EZanTVjL5AR7XkCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725377676; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g+G1IaZ6ST+Ogx2tNLBxW/wP/RnUtilr7tfLezU2LOA=;
	b=C1MzK8p8TybH6W5pmXwLvfwdOQ+toBgGXM6BG7PajFQm6UclSRvkq9MQJwwq2HhQ+7GrmX
	8O58Wa/RxSt+4M7gPkaQjDLJRAlTYyzuYNtZUXmT4z/erdtQGczw/m7NXNn6moRuDrVKZF
	MaYBfFGd708/VO56QK8848oRyy5S8Fw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725377676;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g+G1IaZ6ST+Ogx2tNLBxW/wP/RnUtilr7tfLezU2LOA=;
	b=qgXfca63PcJBhsS6pa1+scP610t/aTNMEKhlC2mOndwLcffBh5F6tIYF7oBhmawxvK5ir6
	EZanTVjL5AR7XkCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BEAD413A52;
	Tue,  3 Sep 2024 15:34:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3/WjKIss12aGcAAAD6G6ig
	(envelope-from <krisman@suse.de>); Tue, 03 Sep 2024 15:34:35 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>
Cc: Hugh Dickins <hughd@google.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Alexander Viro <viro@zeniv.linux.org.uk>,
  Christian Brauner <brauner@kernel.org>,  Jan Kara <jack@suse.cz>,
  krisman@kernel.org,  linux-mm@kvack.org,  linux-kernel@vger.kernel.org,
  linux-fsdevel@vger.kernel.org,  kernel-dev@igalia.com,  Daniel Rosenberg
 <drosen@google.com>,  smcv@collabora.com,  Christoph Hellwig <hch@lst.de>,
  Gabriel Krisman Bertazi <gabriel@krisman.be>
Subject: Re: [PATCH v2 2/8] unicode: Create utf8_check_strict_name
In-Reply-To: <20240902225511.757831-3-andrealmeid@igalia.com>
 (=?utf-8?Q?=22Andr=C3=A9?=
	Almeida"'s message of "Mon, 2 Sep 2024 19:55:04 -0300")
References: <20240902225511.757831-1-andrealmeid@igalia.com>
	<20240902225511.757831-3-andrealmeid@igalia.com>
Date: Tue, 03 Sep 2024 11:34:34 -0400
Message-ID: <87y148hhth.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

Andr=C3=A9 Almeida <andrealmeid@igalia.com> writes:

> Create a helper function for filesystems do the checks required for
> casefold directories and strict enconding.
>
> Suggested-by: Gabriel Krisman Bertazi <gabriel@krisman.be>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> ---
>  fs/unicode/utf8-core.c  | 26 ++++++++++++++++++++++++++
>  include/linux/unicode.h |  2 ++
>  2 files changed, 28 insertions(+)
>
> diff --git a/fs/unicode/utf8-core.c b/fs/unicode/utf8-core.c
> index 0400824ef493..4966e175ed71 100644
> --- a/fs/unicode/utf8-core.c
> +++ b/fs/unicode/utf8-core.c

I don't think this belongs in fs/unicode. it is filesystem semantics whether
they don't allow invalid utf8 names and, while fs/unicode provides
utf8_validate to verify if a string is valid, it has no business looking
into superblock and inode flags.

It would be better placed as a libfs helper.

> @@ -214,3 +214,29 @@ void utf8_unload(struct unicode_map *um)
>  }
>  EXPORT_SYMBOL(utf8_unload);
>=20=20
> +/**
> + * utf8_check_strict_name - Check if a given name is suitable for a dire=
ctory

To follow the namespace in libfs, we could call it

generic_ci_validate_strict_name

> + *
> + * This functions checks if the proposed filename is suitable for the pa=
rent

suitable =3D> valid

> + * directory. That means that only valid UTF-8 filenames will be accepte=
d for
> + * casefold directories from filesystems created with the strict encondi=
ng flags.

enconding flags =3D> encoding flag

> + * That also means that any name will be accepted for directories that d=
oesn't
> + * have casefold enabled, or aren't being strict with the enconding.

encoding

> + *
> + * @inode: inode of the directory where the new file will be created
> + * @d_name: name of the new file

d_name means 'dentry name'. just 'name' is enough here since it doesn't
matter if the qstr is coming from the dentry.

> + *
> + * Returns:
> + *  * True if the filename is suitable for this directory. It can be tru=
e if a
> + *  given name is not suitable for a strict enconding directory, but the
> + *  directory being used isn't strict
> + *  * False if the filename isn't suitable for this directory. This only=
 happens
> + *  when a directory is casefolded and is strict about its encoding.
> + */
> +bool utf8_check_strict_name(struct inode *dir, struct qstr *d_name)
> +{
> +	return !(IS_CASEFOLDED(dir) && dir->i_sb->s_encoding &&
> +	       sb_has_strict_encoding(dir->i_sb) &&
> +	       utf8_validate(dir->i_sb->s_encoding, d_name));
> +}

Now that it is a helper, it could now be unfolded to something more
readable:

if (!IS_CASEFOLDED(dir) || !sb_has_strict_encoding(dir->i_sb)))
   return true;

/* Should never happen.  Unless the filesystem is corrupt. */
if (WARN_ON_ONCE(!dir->i_sb->s_encoding))
   return true;

return utf8_validate(...)

> +EXPORT_SYMBOL(utf8_check_strict_name);
> diff --git a/include/linux/unicode.h b/include/linux/unicode.h
> index 4d39e6e11a95..fb56fb5e686c 100644
> --- a/include/linux/unicode.h
> +++ b/include/linux/unicode.h
> @@ -76,4 +76,6 @@ int utf8_casefold_hash(const struct unicode_map *um, co=
nst void *salt,
>  struct unicode_map *utf8_load(unsigned int version);
>  void utf8_unload(struct unicode_map *um);
>=20=20
> +bool utf8_check_strict_name(struct inode *dir, struct qstr *d_name);
> +
>  #endif /* _LINUX_UNICODE_H */

--=20
Gabriel Krisman Bertazi

