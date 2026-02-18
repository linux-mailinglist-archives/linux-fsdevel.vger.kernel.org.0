Return-Path: <linux-fsdevel+bounces-77569-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBftCTq0lWneUAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77569-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 13:44:42 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BB110156664
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 13:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 945D73012C74
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 12:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D4F3191A0;
	Wed, 18 Feb 2026 12:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="FXdj6mr0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197532D9EF3
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 12:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771418673; cv=none; b=vBjV7tveiAZAotu2JShfybCr758KhPVt/iVokTfbfQG10AI9O+1iuMwOnEw01KZziJG6w0yE/oU+g+0jVYHTyOx/WiJOL7lXSCgyplOZHuWGrprJD6FGyCbWJStvpMhk0rZpKNpPMwrjtGwG/90omkGd1d356/wbXhEaGNfrxTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771418673; c=relaxed/simple;
	bh=K7fTYhSUD3yD7HDe0YOw+HjgjJLAsaiwW9zbjh6CpyE=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=jAxj2daqPjGd+zUW/8idnVCP9n0zi1TwtF9BL99Tp2+elGslh/3LpfDw7TuSUjb8nLt9BmzOn32tJXprQLz+AUNdeIdmrDoh4BdJLbbrAM9Zli8u1iVuj5fCVlVyuwJJw/1GPhKhzuzs0oChmeRjG2Esyv3JDR0PWKcGNB89sRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=FXdj6mr0; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4376de3f128so3610753f8f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 04:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1771418669; x=1772023469; darn=vger.kernel.org;
        h=mime-version:user-agent:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=K7fTYhSUD3yD7HDe0YOw+HjgjJLAsaiwW9zbjh6CpyE=;
        b=FXdj6mr0ixMnnvd5FdO8Ek+HmzuCnz1BR/hwRSJ75DZX/eIQn3BmhBTE9ODFViLyld
         dOLWXG17M1mEw6fAosqvVB+g9EYw77/rD26H52bqm+WBKO/SWKE+Xpu03JBXw9PLm26O
         mg9TG8A61E22VKG2WBSTddTZThF1A7iN5/4R8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771418669; x=1772023469;
        h=mime-version:user-agent:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K7fTYhSUD3yD7HDe0YOw+HjgjJLAsaiwW9zbjh6CpyE=;
        b=uwupHs7ya+7S6ZSf9G6NeRCFD3zskDsTpYSqRP9xodPUYKZ3r7AedDxY4hc2BW9bQW
         4O3wX0VkTIKNrEtWhbsfrjr06WgS+WHOTei8QTWF8Q5bc5Hg9SLSCO96A33IBAy7LlN/
         SOcZklnDIU10kF74qstVEoZCT0c3qWiGpJs9TrQU92AFgR97qVb8NJYUcB/VkRGsmBur
         KUEHCDxoL8LT/LwU3SoTcLowSYyE5xurGLOE6/nARBXCDq4PHR7iWWW+cxTQ+RFC2633
         vpc46Ebd0hO4mnAQYHp1sZg8GLIEn6NbEMfFeC4MrzmTBRK25TmhR2wK2tb8pvKTm9C/
         2ssA==
X-Forwarded-Encrypted: i=1; AJvYcCUoflopLUMWHhQWEFjzCiuQnp/NKIzD7WcnN+GqQOogUuLESQG54nWoUOY9+RXblwIigz1WI6dlp9+Sd+6U@vger.kernel.org
X-Gm-Message-State: AOJu0YzoRIcNaYdwMMvB0AmoZIWhteyGBegcK34+bMWXGHEgQDjcug9c
	cDDZvcWevtmO+UU/eBtO8ZjD/awVFDHYU69IzKs0d+mArwOxh4I+pUipKkxBgPoYlvo=
X-Gm-Gg: AZuq6aIJ96xSjDS3YJf/1zAgv3iZFOZVmkbMUc3ChZViVVtrw89xrDFudVjy7Qafz8W
	fG0+8I89pqQtJb3rCQwT0lubj+0ciMqkWtWskbVUufpMt6Ttw3Tu6Z85ll2xE2ZPaMGMUq0BOwq
	0UC+Xk1I6ZWS2vejf3rw9uhr6LLHl1pb0aqDs/Xll2vwhOf9Xwtz3SYGpn2A1zTeddLK/pK07un
	vthUKlwfMdkfhk094ICUp6j68OJsh6PV9bXZGtIe2CZ252Moru2lvVGLaL3ulzcm5+/1nxkZ8yd
	tAIXC0hUHCXTbpYNwI+uFlImOS1onu9n6hyrLjGRAOGQxL/LgMFLDjbyNsD6m6sgtPOnynlAHDX
	y1OrDnQAdAXjyaFE4IZMDY9xIv2IKuigzvSY3jXm35LMy0cRp5SIW1PM9lAcMQ7CNZnY3cbyV1s
	/HStxFBl8swrqFoUot3qZizlv27UE7Rs6SMk4FLeio+kKHqZn5JJdR8jpW4Ob3XuGZm5S3NuJCQ
	dBv4PYeEff/726MLGM8XuKd2pdjAuQ6PQnbpHlCGsQvwOWWb823THXfPui0Fg==
X-Received: by 2002:a05:6000:40c7:b0:436:f7e5:e047 with SMTP id ffacd0b85a97d-4379dba717emr27656673f8f.47.1771418669150;
        Wed, 18 Feb 2026 04:44:29 -0800 (PST)
Received: from ?IPv6:2003:cf:574b:cf00:fc5a:f53c:338f:241a? (p200300cf574bcf00fc5af53c338f241a.dip0.t-ipconnect.de. [2003:cf:574b:cf00:fc5a:f53c:338f:241a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796abe3b3sm47731520f8f.18.2026.02.18.04.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 04:44:28 -0800 (PST)
Message-ID: <65a53a2d6fcc053edeed688a8c8d580c03bd6f3b.camel@mihalicyn.com>
Subject: [LSF/MM/BPF TOPIC] VFS idmappings support in NFS
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: lsf-pc@lists.linux-foundation.org
Cc: aleksandr.mikhalitsyn@futurfusion.io, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, stgraber@stgraber.org, brauner@kernel.org, 
	ksugihara@preferred.jp, utam0k@preferred.jp, trondmy@kernel.org,
 anna@kernel.org, 	jlayton@kernel.org, chuck.lever@oracle.com,
 neilb@suse.de, miklos@szeredi.hu, 	jack@suse.cz, amir73il@gmail.com,
 trapexit@spawn.link
Date: Wed, 18 Feb 2026 13:44:27 +0100
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-lUxtfA/mDY3MZDjLvXqE"
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mihalicyn.com,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[mihalicyn.com:s=mihalicyn];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[futurfusion.io,vger.kernel.org,stgraber.org,kernel.org,preferred.jp,oracle.com,suse.de,szeredi.hu,suse.cz,gmail.com,spawn.link];
	TAGGED_FROM(0.00)[bounces-77569-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[mihalicyn.com:+];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander@mihalicyn.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BB110156664
X-Rspamd-Action: no action


--=-lUxtfA/mDY3MZDjLvXqE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear friends,

I would like to propose "VFS idmappings support in NFS" as a topic for disc=
ussion at the LSF/MM/BPF Summit.

Previously, I worked on VFS idmap support for FUSE/virtiofs [2] and cephfs =
[1] with support/guidance
from Christian.

This experience with Cephfs & FUSE has shown that VFS idmap semantics, whil=
e being very elegant and
intuitive for local filesystems, can be quite challenging to combine with n=
etwork/network-like (e.g. FUSE)
FSes. In case of Cephfs we had to modify its protocol (!) (see [2]) as a pa=
rt of our agreement with
ceph folks about the right way to support idmaps.

One obstacle here was that cephfs has some features that are not very Linux=
-wayish, I would say.
In particular, system administrator can configure path-based UID/GID restri=
ctions on a *server*-side (Ceph MDS).
Basically, you can say "I expect UID 1000 and GID 2000 for all files under =
/stuff directory".
The problem here is that these UID/GIDs are taken from a syscall-caller's c=
reds (not from (struct file *)->f_cred)
which makes cephfs FDs not very transferable through unix sockets. [3]

These path-based UID/GID restrictions mean that server expects client to se=
nd UID/GID with every single request,
not only for those OPs where UID/GID needs to be written to the disk (mknod=
, mkdir, symlink, etc).
VFS idmaps API is designed to prevent filesystems developers from making a =
mistakes when supporting FS_ALLOW_IDMAP.
For example, (struct mnt_idmap *) is not passed to every single i_op, but i=
nstead to only those where it can be
used legitimately. Particularly, readlink/listxattr or rmdir are not expect=
ed to use idmapping information anyhow.

We've seen very similar challenges with FUSE. Not a long time ago on Linux =
Containers project forum, there
was a discussion about mergerfs (a popular FUSE-based filesystem) & VFS idm=
aps [5]. And I see that this problem
of "caller UID/GID are needed everywhere" still blocks VFS idmaps adoption =
in some usecases.
Antonio Musumeci (mergerfs maintainer) claimed that in many cases filesyste=
ms behind mergerfs may not be fully
POSIX and basically, when mergerfs does IO on the underlying FSes it needs =
to do UID/GID switch to caller's UID/GID
(taken from FUSE request header).

We don't expect NFS to be any simpler :-) I would say that supporting NFS i=
s a final boss. It would be great
to have a deep technical discussion with VFS/FSes maintainers and developer=
s about all these challenges and
make some conclusions and identify a right direction/approach to these prob=
lems. From my side, I'm going
to get more familiar with high-level part of NFS (or even make PoC if time =
permits), identify challenges,
summarize everything and prepare some slides to navigate/plan discussion.

[1] cephfs https://lore.kernel.org/linux-fsdevel/20230807132626.182101-1-al=
eksandr.mikhalitsyn@canonical.com
[2] cephfs protocol changes https://github.com/ceph/ceph/pull/52575
[3] cephfs & f_cred https://lore.kernel.org/lkml/CAEivzxeZ6fDgYMnjk21qXYz13=
tHqZa8rP-cZ2jdxkY0eX+dOjw@mail.gmail.com/
[4] fuse/virtiofs https://lore.kernel.org/linux-fsdevel/20240903151626.2646=
09-1-aleksandr.mikhalitsyn@canonical.com/
[5]
mergerfshttps://discuss.linuxcontainers.org/t/is-it-the-case-that-you-canno=
t-use-shift-true-for-disk-devices-where-the-source-is-a-mergerfs-mount-is-t=
here-a-workaround/25336/11?u=3Damikhalitsyn

Kind regards,
Alexander Mikhalitsyn @ futurfusion.io

--=-lUxtfA/mDY3MZDjLvXqE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEELZu/qM1TGKcTxEFrsfR/XLBbT6MFAmmVtCsACgkQsfR/XLBb
T6OnhQ//RutJOOKp1HFDksmU2Ly6Qb0uBaKLcU8nTjpuPlvvDD9rorb8dp7SCUAl
OO2csU+rgMb0b9uez8iAThU0Y5WO6VChoGeye/DZFg7xtYA9WF+TYhDlY76OKyhH
KO1B4ywXmjXJbYyQn9uaUTECwnzp9K8k5kKWfNvSJ1RiawVR7kOEDkSrSJoxkaRF
7Iq/mybapByx56ZuNQFcuFmIwjvRVQJkjp2e7Ls/iXSmKhjs+MwTMwIVOBM1w/PS
YdxTwaTg3oeY/bqCGJioR7g2mMBtaLeYMaZccHOVIN9L1cu9HYbjZgb/RK0dPKcT
hXIMEcdw5UKRovlQ362cM/a2iV/77H7n/nXJTXJnevJf3xSUO3kLrW2Q5Gnpvk70
rvkosFWJVIgrtPiedolPSVmR+sw6sGaZ6WAzjF5zgrIHwTrvIYh49EUB7gTMcPc6
J5MatAYigNWhbmMCVdKutmOhGyUwIY1u34hbHwPLOr2InzDtiDzazB5f0agsY+Vg
SuegMcd1g+ny6KRuAiwVCHWbcERvY7wsaE4Chm6oG3inKugTDvq9UxqZAgftEE/H
EMfswY4Q15qrYLW6pGwNdU31zJmEyJBsT5F9c6REkVXm1EE3Z7rC4qAX1I1GEa2p
5wpEMuw+LxcssulZZFWjLfOgheVnG8Q7xTG2NLaWpJfMk/F6NqI=
=n9/h
-----END PGP SIGNATURE-----

--=-lUxtfA/mDY3MZDjLvXqE--

