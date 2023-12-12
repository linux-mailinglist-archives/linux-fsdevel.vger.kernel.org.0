Return-Path: <linux-fsdevel+bounces-5761-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EEB180FA9B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 23:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9281281CE5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 22:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A525277D;
	Tue, 12 Dec 2023 22:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZWGGW63/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+gMiQbFA";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZWGGW63/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+gMiQbFA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831F1AD;
	Tue, 12 Dec 2023 14:57:30 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BB6801FCA1;
	Tue, 12 Dec 2023 22:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702421848; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BfXxmLpS5xeCuT7+jXU33MIwLj+cLIZbjTVjmhhdCd8=;
	b=ZWGGW63/k1+PafWXy3XMg65b5dAGsUoglP6BgHeuMt68RwibEG+LDlpdrigSITzgxIlOCP
	JhZxoNFYspzGm5WtWNpsRgyoh/2pBZeI6sOEzskBTlM1MprN5J6MUT0JckDaA7hQ4/ekKe
	Q/gmyPIrWZ9pge/ccCFJTnaCD038Z2I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702421848;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BfXxmLpS5xeCuT7+jXU33MIwLj+cLIZbjTVjmhhdCd8=;
	b=+gMiQbFA3cqcvWXwXNOWC1LrGwpBbwA8ArEBJCRk2hfUjfjZUy8u4BUcLG+xJjnoi4DehN
	KUL+OBy6Jwf2nfAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702421848; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BfXxmLpS5xeCuT7+jXU33MIwLj+cLIZbjTVjmhhdCd8=;
	b=ZWGGW63/k1+PafWXy3XMg65b5dAGsUoglP6BgHeuMt68RwibEG+LDlpdrigSITzgxIlOCP
	JhZxoNFYspzGm5WtWNpsRgyoh/2pBZeI6sOEzskBTlM1MprN5J6MUT0JckDaA7hQ4/ekKe
	Q/gmyPIrWZ9pge/ccCFJTnaCD038Z2I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702421848;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BfXxmLpS5xeCuT7+jXU33MIwLj+cLIZbjTVjmhhdCd8=;
	b=+gMiQbFA3cqcvWXwXNOWC1LrGwpBbwA8ArEBJCRk2hfUjfjZUy8u4BUcLG+xJjnoi4DehN
	KUL+OBy6Jwf2nfAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5983413725;
	Tue, 12 Dec 2023 22:57:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GIVEAVbleGX7IAAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 12 Dec 2023 22:57:26 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Kent Overstreet" <kent.overstreet@linux.dev>
Cc: "David Howells" <dhowells@redhat.com>,
 "Donald Buczek" <buczek@molgen.mpg.de>, linux-bcachefs@vger.kernel.org,
 "Stefan Krueger" <stefan.krueger@aei.mpg.de>, linux-fsdevel@vger.kernel.org
Subject: Re: file handle in statx (was: Re: How to cope with subvolumes and
 snapshots on muti-user systems?)
In-reply-to: <20231212205929.op6tq3pqobwmix5a@moria.home.lan>
References: <170181366042.7109.5045075782421670339@noble.neil.brown.name>,
 <97375d00-4bf7-4c4f-96ec-47f4078abb3d@molgen.mpg.de>,
 <170199821328.12910.289120389882559143@noble.neil.brown.name>,
 <20231208013739.frhvlisxut6hexnd@moria.home.lan>,
 <170200162890.12910.9667703050904306180@noble.neil.brown.name>,
 <20231208024919.yjmyasgc76gxjnda@moria.home.lan>,
 <630fcb48-1e1e-43df-8b27-a396a06c9f37@molgen.mpg.de>,
 <20231208200247.we3zrwmnkwy5ibbz@moria.home.lan>,
 <170233460764.12910.276163802059260666@noble.neil.brown.name>,
 <2799307.1702338016@warthog.procyon.org.uk>,
 <20231212205929.op6tq3pqobwmix5a@moria.home.lan>
Date: Wed, 13 Dec 2023 09:57:22 +1100
Message-id: <170242184299.12910.16703366490924138473@noble.neil.brown.name>
X-Spam-Level: 
X-Spam-Score: -4.30
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Flag: NO

On Wed, 13 Dec 2023, Kent Overstreet wrote:
> On Mon, Dec 11, 2023 at 11:40:16PM +0000, David Howells wrote:
> > Kent Overstreet <kent.overstreet@linux.dev> wrote:
> >=20
> > > I was chatting a bit with David Howells on IRC about this, and floated
> > > adding the file handle to statx. It looks like there's enough space
> > > reserved to make this feasible - probably going with a fixed maximum
> > > size of 128-256 bits.
> >=20
> > We can always save the last bit to indicate extension space/extension rec=
ord,
> > so we're not that strapped for space.
>=20
> So we'll need that if we want to round trip NFSv4 filehandles, they
> won't fit in existing struct statx (nfsv4 specs 128 bytes, statx has 96
> bytes reserved).
>=20
> Obvious question (Neal): do/will real world implementations ever come
> close to making use of this, or was this a "future proofing gone wild"
> thing?

I have no useful data.  I have seen lots of filehandles but I don't pay
much attention to their length.  Certainly some are longer than 32 bytes.

>=20
> Say we do decide we want to spec it that large: _can_ we extend struct
> statx? I'm wondering if the userspace side was thought through, I'm
> sure glibc people will have something to say.

The man page says:

     Therefore, do not simply set mask to UINT_MAX (all bits set), as
     one or more bits may, in the future, be used to specify an
     extension to the buffer.

I suspect the glibc people read that.

NeilBrown




>=20
> Kernel side we can definitely extend struct statx, and we know how many
> bytes to copy to userspace because we know what fields userspace
> requested. The part I'm concerned about is that if we extend userspace's
> struct statx, that introduces obvious ABI compabitibility issues.
>=20
> So this would probably force glibc to introduce a new version of struct
> statx, if I'm not mistaken.
>=20
> Or: another option would be to reserve something small and sane in
> struct statx (32 bytes max, I'd say), and then set a flag to tell
> userspace they need to use name_to_handle_at() if it didn't fit.
>=20


