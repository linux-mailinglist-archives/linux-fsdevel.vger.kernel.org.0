Return-Path: <linux-fsdevel+bounces-28442-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CC296A4A1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 18:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBEDA1C219D0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 16:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC4818CC1C;
	Tue,  3 Sep 2024 16:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pakxOuLz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rXlJJayy";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BYl+Yy8D";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LUXPaLBD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E8618BBBD;
	Tue,  3 Sep 2024 16:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725381513; cv=none; b=brb6M27m6dcBzpae2AVDNSfR1NNAmltYv7HQTfKq+myhtuKh5dsmn28XSYJn5bV4HS2i++EYahYMaIzull0umwkCNCMFHqh6EIX1WUnLGGEhWz8pZHfXBSM8Inu993GfB3VwON70SCkcAponQadrILfkhOLRV4DG+iSDqT8TE1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725381513; c=relaxed/simple;
	bh=LpQvR2HvzyH/c8qnap9HnqIK8r52wctDLvUarPcSTBs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I3IdK8TMnxjZCrpUZlcTqj3UjXIPHw2/661vBNbWviP46srg3ytYZd9Cqhrj8r1RNKxxqj1OcnSwNwwmbj2Y98HusnKfbDMek2k0Mfh9tLDShRjTL7dc3kWS4GtVOPzZmnm0QZmR1RMsDtazZzUaVBPC12DKNBqLsZExtOnIrpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pakxOuLz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rXlJJayy; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BYl+Yy8D; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LUXPaLBD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D752E1FD3E;
	Tue,  3 Sep 2024 16:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725381510; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XGsMAuFIuxIETZfL4882Kac2whnAuVvMgj76Uh+vSoY=;
	b=pakxOuLz2+853Wa/eXZ8plzfMIMkTkjneCWiOX41D9kPmDqrU6XYw42d0SFykuBYO3PzWc
	Gg2XB1XQ4SjqsmOf+WHGOYjcc/Mjwhp+7+RybDOEzjgQ6k8MTcmED4lnYaSnW1IBJ79LEo
	lwAu5OtN4MxNX6INKjGtnq9Gsjy5VwE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725381510;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XGsMAuFIuxIETZfL4882Kac2whnAuVvMgj76Uh+vSoY=;
	b=rXlJJayyP8/kQfEJe6eIh0wbsKyNkC1xbrSiRDSFtkKydcPB8XU7Ra6zbJetpB9uDHNFeg
	dTlGCTiMApNDzwAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725381509; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XGsMAuFIuxIETZfL4882Kac2whnAuVvMgj76Uh+vSoY=;
	b=BYl+Yy8DYcJ/YiW4bj+ZDjZmEtzAIippKdUENMrK6umgTq+LvthGIjlxO1mwICvBoVfyhn
	WdPQDhOzIhcZKj2cY6NKgY5m6LTVL2SqMhCMsg/he3bmh37faLI1njQrUnyooCncJIDDiu
	wbvitIAFJZ+8vPNl4/aA2nGQcIDmJSI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725381509;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XGsMAuFIuxIETZfL4882Kac2whnAuVvMgj76Uh+vSoY=;
	b=LUXPaLBDGLufIkPjEjxtR81T3k6XN0UPmICd982JppiShwng6AvGGyan/wYa9bJt5P80ES
	jT7wZ4yuZ+LDxzBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7C20413A80;
	Tue,  3 Sep 2024 16:38:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CQFlGIU712aABQAAD6G6ig
	(envelope-from <krisman@suse.de>); Tue, 03 Sep 2024 16:38:29 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>
Cc: Hugh Dickins <hughd@google.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Alexander Viro <viro@zeniv.linux.org.uk>,
  Christian Brauner <brauner@kernel.org>,  Jan Kara <jack@suse.cz>,
  krisman@kernel.org,  linux-mm@kvack.org,  linux-kernel@vger.kernel.org,
  linux-fsdevel@vger.kernel.org,  kernel-dev@igalia.com,  Daniel Rosenberg
 <drosen@google.com>,  smcv@collabora.com,  Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 8/8] docs: tmpfs: Add casefold options
In-Reply-To: <20240902225511.757831-9-andrealmeid@igalia.com>
 (=?utf-8?Q?=22Andr=C3=A9?=
	Almeida"'s message of "Mon, 2 Sep 2024 19:55:10 -0300")
References: <20240902225511.757831-1-andrealmeid@igalia.com>
	<20240902225511.757831-9-andrealmeid@igalia.com>
Date: Tue, 03 Sep 2024 12:38:24 -0400
Message-ID: <871q20hev3.fsf@mailhost.krisman.be>
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
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.993];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[igalia.com:email,mailhost.krisman.be:mid]
X-Spam-Score: -4.30
X-Spam-Flag: NO

Andr=C3=A9 Almeida <andrealmeid@igalia.com> writes:

> Document mounting options for casefold support in tmpfs.
>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> ---
>  Documentation/filesystems/tmpfs.rst | 37 +++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>
> diff --git a/Documentation/filesystems/tmpfs.rst b/Documentation/filesyst=
ems/tmpfs.rst
> index 56a26c843dbe..ce24fb16979a 100644
> --- a/Documentation/filesystems/tmpfs.rst
> +++ b/Documentation/filesystems/tmpfs.rst
> @@ -241,6 +241,41 @@ So 'mount -t tmpfs -o size=3D10G,nr_inodes=3D10k,mod=
e=3D700 tmpfs /mytmpfs'
>  will give you tmpfs instance on /mytmpfs which can allocate 10GB
>  RAM/SWAP in 10240 inodes and it is only accessible by root.
>=20=20
> +tmpfs has the following mounting options for case-insesitive lookups sup=
port:

insensitive

> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> +casefold          Enable casefold support at this mount point using the =
given
> +                  argument as the encoding standard. Currently only utf8
> +                  encodings are supported.
> +strict_encoding   Enable strict encoding at this mount point (disabled by
> +                  default). This means that invalid sequences will be re=
jected

Invalid sequences is not clear. Perhaps:

In this mode, the filesystem refuses to create file and directory with
names containing invalid UTF-8 characters.


> +                  by the file system.
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> +
> +Note that this option doesn't enable casefold by default; one needs to s=
et
> +casefold flag per directory, setting the +F attribute in an empty direct=
ory. New
> +directories within a casefolded one will inherit the flag.
> +
> +Example::
> +
> +    $ mount -t tmpfs -o casefold=3Dutf8-12.1.0,cf_strict fs_name /mytmpfs

cf_strict should be strict_encoding.

I keep wondering if we should accept 'casefold' without any argument to
just mean the latest encoding version available.  Sure, that is a
problem for filesystems that can be moved between systems, but for tmpfs
that is not a problem.  It is cumbersome to specify the version and most
will just want the latest.

> +    $ cd /mytmpfs # case-sensitive by default
> +    $ touch a; touch A
> +    $ ls
> +    A  a
> +    $ mkdir B
> +    $ cd b
> +    cd: The directory 'b' does not exist
> +    $ mkdir casefold_dir
> +    $ chattr +F casefold_dir/ # marking it as case-insensitive
> +    $ cd
> +    $ touch dir/a; touch dir/A
> +    $ ls dir
> +    a
> +    $ mkdir B
> +    $ cd b
> +    $ pwd
> +    /home/user/mytmpfs/casefold_dir/B

I don't think we need this example,  since it is just generic
how case-insensitiveness work.

>=20=20
>  :Author:
>     Christoph Rohland <cr@sap.com>, 1.12.01
> @@ -250,3 +285,5 @@ RAM/SWAP in 10240 inodes and it is only accessible by=
 root.
>     KOSAKI Motohiro, 16 Mar 2010
>  :Updated:
>     Chris Down, 13 July 2020
> +:Updated:
> +   Andr=C3=A9 Almeida, 23 Aug 2024

--=20
Gabriel Krisman Bertazi

