Return-Path: <linux-fsdevel+bounces-14192-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D8287920E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 11:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E48F828435E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 10:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CE65730A;
	Tue, 12 Mar 2024 10:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sbpwajHY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bG8jPD7s";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sbpwajHY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bG8jPD7s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86102572;
	Tue, 12 Mar 2024 10:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710239473; cv=none; b=lVVUzfn5nEI8zIREf4fUJ839D2H3YX3D1p6dQwzhsI0k2AbnSWVfV3uTK39EP8r1Hr0khHZ9rJ1xI83Wq+N/xo5e83MKnBV/OUn7MEsyF4GQxtnDuv+vOjN30V64cma6J64PtOaWA0nK4DkUdKr7O40rN17yW3kpoovk/9fAjoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710239473; c=relaxed/simple;
	bh=oVUL+dBKPkx7whFrUnaDiNXKFRtCaIYHoGoThqj/yr0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NkAFsc2E7tDGFW/5/am1lSMmXZ38+fsY4EaFP8wxjvelnmLRJ7JvCjF5TVYPgxNJOHPXMiGrYPscG39+eAryZup0JZMMGhunJoPazts+kUetWkLTlxRZF2vB+99AfalUU2KnH9rr+OJqrsze6U9Ui1g30m4p2eQ9LMafA8l4cyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sbpwajHY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bG8jPD7s; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sbpwajHY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bG8jPD7s; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0E2BA21B2F;
	Tue, 12 Mar 2024 10:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710239470; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3g+9XDNAwrGk3S9VJmZo4QqhJtERU4mDvEOCPEzW4NE=;
	b=sbpwajHYnwHRMCqlSIkDUAN1/WurUClOQDc/Wj3aeyHJE+ihctUMvLjr9os6AMsVHeQxGM
	oeN139zVyoSVrReO7S/OlhL1WKshW+Thq2auIK8Ef+12ym4hHx/9se9FFCjFVI5N1YhNqQ
	NHo3tgCE66TadWUzcUb8VUxKw4Ggy5c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710239470;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3g+9XDNAwrGk3S9VJmZo4QqhJtERU4mDvEOCPEzW4NE=;
	b=bG8jPD7s+P/CqQVv0b+NqS7Z8e091PsGQdV+t2WV916clig/B0VUNGklGKBgcpy7BnPWvI
	BRJuQxJmze0IKRCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710239470; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3g+9XDNAwrGk3S9VJmZo4QqhJtERU4mDvEOCPEzW4NE=;
	b=sbpwajHYnwHRMCqlSIkDUAN1/WurUClOQDc/Wj3aeyHJE+ihctUMvLjr9os6AMsVHeQxGM
	oeN139zVyoSVrReO7S/OlhL1WKshW+Thq2auIK8Ef+12ym4hHx/9se9FFCjFVI5N1YhNqQ
	NHo3tgCE66TadWUzcUb8VUxKw4Ggy5c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710239470;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3g+9XDNAwrGk3S9VJmZo4QqhJtERU4mDvEOCPEzW4NE=;
	b=bG8jPD7s+P/CqQVv0b+NqS7Z8e091PsGQdV+t2WV916clig/B0VUNGklGKBgcpy7BnPWvI
	BRJuQxJmze0IKRCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 43E7613795;
	Tue, 12 Mar 2024 10:31:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pxc0De0u8GW7TAAAD6G6ig
	(envelope-from <lhenriques@suse.de>); Tue, 12 Mar 2024 10:31:09 +0000
Received: from localhost (brahms.olymp [local])
	by brahms.olymp (OpenSMTPD) with ESMTPA id a69ac89a;
	Tue, 12 Mar 2024 10:31:08 +0000 (UTC)
From: Luis Henriques <lhenriques@suse.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>,  Theodore Ts'o <tytso@mit.edu>,
  Andreas Dilger <adilger.kernel@dilger.ca>,  Alexander Viro
 <viro@zeniv.linux.org.uk>,  Jan Kara <jack@suse.cz>,  Amir Goldstein
 <amir73il@gmail.com>,  linux-ext4@vger.kernel.org,
  linux-fsdevel@vger.kernel.org,  linux-unionfs@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] ovl: fix the parsing of empty string mount
 parameters
In-Reply-To: <20240312-orten-erbsen-2105c134762e@brauner> (Christian Brauner's
	message of "Tue, 12 Mar 2024 09:47:52 +0100")
References: <20240307160225.23841-1-lhenriques@suse.de>
	<20240307160225.23841-4-lhenriques@suse.de>
	<CAJfpegtQSi0GFzUEDqdeOAq7BN2KvDV8i3oBFvPOCKfJJOBd2g@mail.gmail.com>
	<87le6p6oqe.fsf@suse.de>
	<CAJfpeguN9nMJGJzx8sgwP=P9rJFVkYF5rVZOi_wNu7mj_jfBsA@mail.gmail.com>
	<20240311-weltmeere-gesiegt-798c4201c3f8@brauner>
	<CAJfpegsn-jMY2J8Wd2Q9qmZFqxR6fAwZ4auoK+-uyxaK+F-0rw@mail.gmail.com>
	<20240312-orten-erbsen-2105c134762e@brauner>
Date: Tue, 12 Mar 2024 10:31:08 +0000
Message-ID: <87h6hbhhcj.fsf@brahms.olymp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[4];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.997];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_LAST(0.00)[];
	 FREEMAIL_CC(0.00)[szeredi.hu,mit.edu,dilger.ca,zeniv.linux.org.uk,suse.cz,gmail.com,vger.kernel.org];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

Christian Brauner <brauner@kernel.org> writes:

> On Mon, Mar 11, 2024 at 03:39:39PM +0100, Miklos Szeredi wrote:
>> On Mon, 11 Mar 2024 at 14:25, Christian Brauner <brauner@kernel.org> wro=
te:
>>=20
>> > Yeah, so with that I do agree. But have you read my reply to the other
>> > thread? I'd like to hear your thoughs on that. The problem is that
>> > mount(8) currently does:
>> >
>> > fsconfig(3, FSCONFIG_SET_FLAG, "usrjquota", NULL, 0) =3D -1 EINVAL (In=
valid argument)
>> >
>> > for both -o usrjquota and -o usrjquota=3D
>>=20
>> For "-o usrjquota" this seems right.
>>=20
>> For "-o usrjquota=3D" it doesn't.  Flags should never have that "=3D", so
>> this seems buggy in more than one ways.
>>=20
>> > So we need a clear contract with userspace or the in-kernel solution
>> > proposed here. I see the following options:
>> >
>> > (1) Userspace must know that mount options such as "usrjquota" that can
>> >     have no value must be specified as "usrjquota=3D" when passed to
>> >     mount(8). This in turn means we need to tell Karel to update
>> >     mount(8) to recognize this and infer from "usrjquota=3D" that it m=
ust
>> >     be passed as FSCONFIG_SET_STRING.
>>=20
>> Yes, this is what I'm thinking.  Of course this only works if there
>> are no backward compatibility issues, if "-o usrjquota" worked in the
>> past and some systems out there relied on this, then this is not
>> sufficient.
>
> Ok, I spoke to Karel and filed:
>
> https://github.com/util-linux/util-linux/issues/2837
>
> So this should get sorted soon.

OK, so I if I understand it correctly I can drop all these changes as
there's nothing else to be done from the kernel, right?

(I'll still send out a patch to move the fsparam_string_empty() helper to
a generic header.)

And thanks everyone for your reviews.

Cheers,
--=20
Lu=C3=ADs

