Return-Path: <linux-fsdevel+bounces-78949-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEbuB5rOpWm1GwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78949-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 18:53:30 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A741DE1C3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 18:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB95A304C112
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 17:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8394A36C0A8;
	Mon,  2 Mar 2026 17:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qt4ZBUe4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115A130BBB8;
	Mon,  2 Mar 2026 17:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772474001; cv=none; b=SkNLs+7wySNHfbOdBfs4Si58TULv5FKMxxrH3y4dKmFqHxUA8u51r+ILqVs54Gu5bE37pkOaiR6LB5ypeeiXCE615R0Hrk/feaYxKLifklPFwWEuZAzkgBGkTjZd4Jjec1d7fiShA/Qh1o8R74bGwS+kBS92wZPCfp84LIP92gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772474001; c=relaxed/simple;
	bh=nWBXbnNhag4+cEdW8TY8rjhIPYU1TFUCUpVrVf8PHfc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jT7Bd6oKod+R66unTUkBbXrDLx5cPuE71j9rawUgra5pscq/8OsD7V1mClpTj/0FGQsKdG34td5QZzqZXm8vS7Pf0OQpzThgT4m2sS0GTqaW75AFPS5RI6WFCWqJS7VoqBvFA6B76c7eleVMTmhzUa9JUUPj58WNYXjFGk7iV4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qt4ZBUe4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB25BC19425;
	Mon,  2 Mar 2026 17:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772474000;
	bh=nWBXbnNhag4+cEdW8TY8rjhIPYU1TFUCUpVrVf8PHfc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Qt4ZBUe4xeTsnnXHzLXIKx13xaIu/ib2T++O6+rUfSP2Oi6fM9ARG3i3q26CFCnUO
	 LpKBUSBDtdmzbXi/qm7TNu4QAXW0MaRni0eIEhfxwcLv/G9Vmb2NqS/2fiDu+5uEXv
	 eQqsxQ5iS0/dSGUpCc4cp5ddrQ/bD9kFqZbvGshVQCiLtb4PJlp0nJN+AZ1uFtAsW6
	 yK5LTBSyo1R3vGvPXzfv36TgmIocxJ6Ct2WtWg3H1Fb7t8nRi0Tl1zI2zOrt+SIFrZ
	 eGKnkC8Us5B6EofdBTPVe2/n7goy0q7SFYjBhTZ3zuM+6bx30lJCIeTPcI4fUnuSjw
	 UXk9fr1xeM2xA==
Message-ID: <d65b010cec3df6d999becf8afb3186d2a101a369.camel@kernel.org>
Subject: Re: [PATCH v3 1/3] fs: add umount notifier chain for filesystem
 unmount notification
From: Jeff Layton <jlayton@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>, Amir
 Goldstein	 <amir73il@gmail.com>, Christian Brauner <brauner@kernel.org>,
 Jan Kara	 <jack@suse.com>, Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo
	 <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 linux-nfs@vger.kernel.org, 	linux-fsdevel@vger.kernel.org, Chuck Lever
 <chuck.lever@oracle.com>
Date: Mon, 02 Mar 2026 12:53:17 -0500
In-Reply-To: <2fdaxflmm7hottalnc3wbyzvjp4i5cd6etyvgzq4v3oktfwuuf@spgdoi45urqd>
References: 
	<jxyalrg3a2yjtjfmdylncg7fz63jstbq6pwhhqlaaxju5sk72f@55lb7mfucc5i>
	 <3cff098e-74a8-4111-babb-9c13c7ba2344@kernel.org>
	 <CAOQ4uxiX5anNeZge9=uzw8Dkbad3bMBk5Ana5S94t9VfKNFO5g@mail.gmail.com>
	 <d7f2562a-7d32-41d5-a02e-904aa4203ed3@app.fastmail.com>
	 <CAOQ4uxiO+NCjhBme=YWCfnVyhJ=Zcg4zmnfoRspJab3n5waSCA@mail.gmail.com>
	 <07a2af61-6737-4e47-ad69-652af18eb47b@app.fastmail.com>
	 <177242454307.7472.11164903103911826962@noble.neil.brown.name>
	 <d7abef36-ce90-4b36-af16-e8bd61b963ed@kernel.org>
	 <3r5imygq5ah4khza5fsbgam6ss6ohla24p4ikmbpfpjoj4qmns@f6bw344w4axz>
	 <74db1cb73ef8571e2e38187b668a83d28e19933b.camel@kernel.org>
	 <2fdaxflmm7hottalnc3wbyzvjp4i5cd6etyvgzq4v3oktfwuuf@spgdoi45urqd>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 71A741DE1C3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78949-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,brown.name,gmail.com,suse.com,redhat.com,oracle.com,talpey.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, 2026-03-02 at 18:37 +0100, Jan Kara wrote:
> On Mon 02-03-26 12:10:52, Jeff Layton wrote:
> > On Mon, 2026-03-02 at 16:26 +0100, Jan Kara wrote:
> > > On Mon 02-03-26 08:57:28, Chuck Lever wrote:
> > > > On 3/1/26 11:09 PM, NeilBrown wrote:
> > > > > On Mon, 02 Mar 2026, Chuck Lever wrote:
> > > > > > On Sun, Mar 1, 2026, at 1:09 PM, Amir Goldstein wrote:
> > > > > > > On Sun, Mar 1, 2026 at 6:21=E2=80=AFPM Chuck Lever <cel@kerne=
l.org> wrote:
> > > > > > > > Perhaps that description nails down too much implementation=
 detail,
> > > > > > > > and it might be stale. A broader description is this user s=
tory:
> > > > > > > >=20
> > > > > > > > "As a system administrator, I'd like to be able to unexport=
 an NFSD
> > > > > > >=20
> > > > > > > Doesn't "unexporting" involve communicating to nfsd?
> > > > > > > Meaning calling to svc_export_put() to path_put() the
> > > > > > > share root path?
> > > > > > >=20
> > > > > > > > share that is being accessed by NFSv4 clients, and then unm=
ount it,
> > > > > > > > reliably (for example, via automation). Currently the umoun=
t step
> > > > > > > > hangs if there are still outstanding delegations granted to=
 the NFSv4
> > > > > > > > clients."
> > > > > > >=20
> > > > > > > Can't svc_export_put() be the trigger for nfsd to release all=
 resources
> > > > > > > associated with this share?
> > > > > >=20
> > > > > > Currently unexport does not revoke NFSv4 state. So, that would
> > > > > > be a user-visible behavior change. I suggested that approach a
> > > > > > few months ago to linux-nfs@ and there was push-back.
> > > > > >=20
> > > > >=20
> > > > > Could we add a "-F" or similar flag to "exportfs -u" which implem=
ents the
> > > > > desired semantic?  i.e.  asking nfsd to release all locks and clo=
se all
> > > > > state on the filesystem.
> > > >=20
> > > > That meets my needs, but should be passed by the linux-nfs@ review
> > > > committee.
> > > >=20
> > > > -F could probably just use the existing "unlock filesystem" API
> > > > after it does the unexport.
> > >=20
> > > If this option flies, then I guess it is the most sensible variant. I=
f it
> > > doesn't work for some reason, then something like ->umount_begin sb
> > > callback could be twisted (may possibly need some extension) to provi=
de
> > > the needed notification? At least in my naive understanding it was cr=
eated
> > > for usecases like this...
> > >=20
> > > 								Honza
> >=20
> > umount_begin is a superblock op that only occurs when MNT_FORCE is set.
> > In this case though, we really want something that calls back into
> > nfsd, rather than to the fs being unmounted.
>=20
> I see OK.
>=20
> > You could just wire up a bunch of umount_begin() operations but that
> > seems rather nasty. Maybe you could add some sort of callback that nfsd
> > could register that runs just before umount_begin does?
>=20
> Thinking about this more - Chuck was also writing about the problem of
> needing to shutdown the state only when this is the last unmount of a
> superblock but until we grab namespace_lock(), that's impossible to tell =
in
> a race-free manner? And how about lazy unmounts? There it would seem to b=
e
> extra hard to determine when NFS needs to drop it's delegations since you
> need to figure out whether all file references are NFS internal only? It
> all seems like a notification from VFS isn't the right place to solve thi=
s
> issue...
>=20

The issue is that traditionally, "exportfs -u" is what unexports the
filesystem and at that point you can (usually) unmount it. We'd ideally
like to have a solution that doesn't create extra steps or change this,
since there is already a lot of automation and muscle memory around
these commands.

This method mostly works with v3, since there is no long term state
(technically lockd can hold some, but that's only for file locking).
With v4 that changed and nfsd holds files open for much longer.

We can't drop all the state when fs is unexported, as it's not uncommon
for it to be reexported soon afterward, and we can't force a grace
period at that point to allow reclaim.

Unmounting seems like the natural place for this. At the point where
you're unmounting, there can be no more state and the admin's intent is
clear. Tearing down nfsd state at that point seems pretty safe.

If we can't add some sort of hook to the umount path, then I'll
understand, but it would be a nice to have for this use-case.
--=20
Jeff Layton <jlayton@kernel.org>

