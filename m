Return-Path: <linux-fsdevel+bounces-42376-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB6DA41322
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 03:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DFA93AAD67
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 02:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C50D19ABC6;
	Mon, 24 Feb 2025 02:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="J92B4XFh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wVqIq0t/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="J92B4XFh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wVqIq0t/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AF01F5FA
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 02:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740362584; cv=none; b=ocZh9926XD1eS6Zyc3cfc4chRwLA9TfwlJLMAz2cu7jNayyU7aZQiMw1J8Jjuk/cGYmNsN5D1uBSMEZUrNycAfPEL80YwwZTlMHOcrjdR1RwTff8n/XQv1mlVvjHmZI//uW0+vIzJe0i/VafaTkR5HijH+I/af9GwJ4wbgAWaQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740362584; c=relaxed/simple;
	bh=r23F23VtBxZmCeOjMmfsF5qOa7i3vXvCJf+NmyNRN1I=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=I5+UeJ/6lcg/l6bG9r14Cl6jrF5miBs+PTwoVHBLtk4wF6vZBDKqMByewvF8bEvCMHkoP3zqSVY0gy25QAUeBREHzNKeLK5bsgFVkaLigWzcZ52UiLoI8SA43LPv55ajJsXQByTU/KW06yoPpzs1WWCd/PeYp7A/8oMI/AyL9n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=J92B4XFh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wVqIq0t/; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=J92B4XFh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wVqIq0t/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B2FF71F383;
	Mon, 24 Feb 2025 02:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740362580; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PDbNe/EHhaK9CaRzSNencM5JCMpX3p/DG2ccrHCzlR8=;
	b=J92B4XFhtoq0Cp3lIzYk7//ZGYHufF+SyuVtwRGcn4J0eBpoDQefUL8U8Rq/0Lobu9PFqy
	glg8vpl1CuFvBGfnRBJO/b4dzOzo4fJcS9PCkxUPSeCbWKoKn+Cu2Tf3LHqaY52BgGfxEs
	urjLY84mEkeIfjZJyAjNSiLGS644/PE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740362580;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PDbNe/EHhaK9CaRzSNencM5JCMpX3p/DG2ccrHCzlR8=;
	b=wVqIq0t/jYZYXg2qq8CvOF9h8iG2LHyoGMtrXTmh/CgXzu55j3A2M8n9EwVgidPmcUI4yG
	L3eCOnKnBXei3nDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740362580; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PDbNe/EHhaK9CaRzSNencM5JCMpX3p/DG2ccrHCzlR8=;
	b=J92B4XFhtoq0Cp3lIzYk7//ZGYHufF+SyuVtwRGcn4J0eBpoDQefUL8U8Rq/0Lobu9PFqy
	glg8vpl1CuFvBGfnRBJO/b4dzOzo4fJcS9PCkxUPSeCbWKoKn+Cu2Tf3LHqaY52BgGfxEs
	urjLY84mEkeIfjZJyAjNSiLGS644/PE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740362580;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PDbNe/EHhaK9CaRzSNencM5JCMpX3p/DG2ccrHCzlR8=;
	b=wVqIq0t/jYZYXg2qq8CvOF9h8iG2LHyoGMtrXTmh/CgXzu55j3A2M8n9EwVgidPmcUI4yG
	L3eCOnKnBXei3nDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1627D136B3;
	Mon, 24 Feb 2025 02:02:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HEMWJ07Tu2ddcQAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 24 Feb 2025 02:02:54 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Steve French" <smfrench@gmail.com>
Cc: "Al Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "Miklos Szeredi" <miklos@szeredi.hu>, "Xiubo Li" <xiubli@redhat.com>,
 "Ilya Dryomov" <idryomov@gmail.com>, "Richard Weinberger" <richard@nod.at>,
 "Anton Ivanov" <anton.ivanov@cambridgegreys.com>,
 "Johannes Berg" <johannes@sipsolutions.net>,
 "Jeff Layton" <jlayton@kernel.org>, "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 "Sergey Senozhatsky" <senozhatsky@chromium.org>,
 "linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
 "CIFS" <linux-cifs@vger.kernel.org>
Subject:
 Re: [PATCH 1/6] Change inode_operations.mkdir to return struct dentry *
In-reply-to:
 <CAH2r5mvXVc4=ZwvfwZtVaVM88+3cvUtjz-71af_Q+Jmbdst2_g@mail.gmail.com>
References:
 <>, <CAH2r5mvXVc4=ZwvfwZtVaVM88+3cvUtjz-71af_Q+Jmbdst2_g@mail.gmail.com>
Date: Mon, 24 Feb 2025 13:02:43 +1100
Message-id: <174036256374.74271.7577867606646159750@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,szeredi.hu,redhat.com,gmail.com,nod.at,cambridgegreys.com,sipsolutions.net,oracle.com,talpey.com,chromium.org,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17]
X-Spam-Flag: NO
X-Spam-Level: 

On Sat, 22 Feb 2025, Steve French wrote:
> I didn't see the cifs part of this series either. Did I miss it?
>=20
> On Fri, Feb 21, 2025, 10:56=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
>=20
>     On Fri, Feb 21, 2025 at 10:36:30AM +1100, NeilBrown wrote:
>   =20
>     > Not all filesystems reliably result in a positive hashed dentry:
>     >
>     > - NFS, cifs, hostfs will sometimes need to perform a lookup of
>     >=C2=A0 =C2=A0the name to get inode information.=C2=A0 Races could resu=
lt in this
>     >=C2=A0 =C2=A0returning something different. Note that this lookup is
>     >=C2=A0 =C2=A0non-atomic which is what we are trying to avoid.=C2=A0 Pl=
acing the
>     >=C2=A0 =C2=A0lookup in filesystem code means it only happens when the
>     filesystem
>     >=C2=A0 =C2=A0has no other option.
>   =20
>     At least in case of cifs I don't see that lookup anywhere in your
>     series.=C2=A0 Have I missed it, or...?

I didn't make any interesting changes to cifs.  I wasn't sure that I
needed to...

cifs already does the lookup - sometimes.
cifs_get_unix_fattr() (I think) does a lookup based on the full path
name.  Though now I see that is only enabled with CONFIG_CIFS_ALLOW_INSECURE_=
LEGACY.

This is sometimes called by cifs_mkdir_qinfo() which is called after
success in cifs_mkdir().  This creates the inode and called
d_instantiate().  As that isn't d_instantiate_new() it maybe needs to be=20
d_splice_alias().

However cifs doesn't provide open_by_handle_at() functionality so one
race that can sometimes cause a problem cannot happen.

Also of the three clients of vfs_mkdir which care about the dentry,
- cachefiles will still repeat the lookup
- nfsd cannot export cifs, so its behaviour isn't relevant
- smb/server - even if it can re-export cifs the only down-side is that
   the uid won't be written by ksmbd_vfs_inherit_owner() but I wonder
   of persistent of i_uid_write() without a notify_change() could be=20
   on a network filesystem...

I should probably change the d_instantiate() to
d_drop();d_splice_alias().

I'm not able to review all the paths to determine if a lookup might be
needed somewhere or to add any lookup.

Should d_instantiate() WARN_ON when the inode->i_dentry list isn't empty
for a directory??

Thanks,
NeilBrown

