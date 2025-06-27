Return-Path: <linux-fsdevel+bounces-53136-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5BB2AEAE8F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 07:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E27C44A7D29
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 05:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2855F1D5CE8;
	Fri, 27 Jun 2025 05:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=flyingcircus.io header.i=@flyingcircus.io header.b="NUg3Q+FS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.flyingcircus.io (mail.flyingcircus.io [212.122.41.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F994A21;
	Fri, 27 Jun 2025 05:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.122.41.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751003552; cv=none; b=Yo3q0SDSR+sgyO7aReIrI/PmJF8swkdr1V4NW66IqeXlxSebefmOokJqNZuoD/dNuWAtYaMWJkH/lbkiU3BZ8qplGDC0tqlJF7QTKXuq4N2Pq1koTCCv1go37IoHsYuulxmJWJaGwxkXkvTQq0Co5/V1dYTnAtZA1NBZvMtzVhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751003552; c=relaxed/simple;
	bh=I+cyzXXEFsVaAY+O6/we7LXtcWZMrSXWgPA81FRNw4c=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ZxNrFPMicuowjVKuEBF34vY8ukOizREkCskBjT1rYXDwbe+crFvn8BK8tkb0Jk3ju2li+CK8j379kDrQzr0AlPgTwCtFFtahv8vAi8uv0kM0eYap44cUIGfLAiiJs6t7Pp1fQ84eZ2AsTo4sy0ceXH7kgnWVPB4+e11XDXNEAzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flyingcircus.io; spf=pass smtp.mailfrom=flyingcircus.io; dkim=pass (1024-bit key) header.d=flyingcircus.io header.i=@flyingcircus.io header.b=NUg3Q+FS; arc=none smtp.client-ip=212.122.41.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flyingcircus.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flyingcircus.io
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flyingcircus.io;
	s=mail; t=1751003086;
	bh=UyV35LOM07P/PALS6LcEMleCj1no3wxnvAIeYWaEtMU=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=NUg3Q+FSo4ZvGRStNFZRcyBK2LQb6PdQnA/gJ9PlV5t7nFWQSPNUt3RjFyklTZ+HC
	 iXPD48xk53aOi7RlCQXLB0Orsic0/wjL9ImhlnrVhMz0XcN68kVY4/fHrIjaliksWB
	 ojxzRZjZeTqF6MG9YpIg6T86PnpEhMf8g2ubuyd8=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [REGRESSION] 9pfs issues on 6.12-rc1
From: Christian Theune <ct@flyingcircus.io>
In-Reply-To: <w5ap2zcsatkx4dmakrkjmaexwh3mnmgc5vhavb2miaj6grrzat@7kzr5vlsrmh5>
Date: Fri, 27 Jun 2025 07:44:31 +0200
Cc: Antony Antony <antony.antony@secunet.com>,
 David Howells <dhowells@redhat.com>,
 Antony Antony <antony@phenome.org>,
 Christian Brauner <brauner@kernel.org>,
 Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Christian Schoenebeck <linux_oss@crudebyte.com>,
 Sedat Dilek <sedat.dilek@gmail.com>,
 Maximilian Bosch <maximilian@mbosch.me>,
 regressions@lists.linux.dev,
 v9fs@lists.linux.dev,
 netfs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <C7DAFD20-65D2-4B61-A612-A25FCC0C9573@flyingcircus.io>
References: <ZxFQw4OI9rrc7UYc@Antony2201.local>
 <D4LHHUNLG79Y.12PI0X6BEHRHW@mbosch.me>
 <c3eff232-7db4-4e89-af2c-f992f00cd043@leemhuis.info>
 <D4LNG4ZHZM5X.1STBTSTM9LN6E@mbosch.me>
 <CA+icZUVkVcKw+wN1p10zLHpO5gqkpzDU6nH46Nna4qaws_Q5iA@mail.gmail.com>
 <3327438.1729678025@warthog.procyon.org.uk>
 <ZxlQv5OXjJUbkLah@moon.secunet.de>
 <w5ap2zcsatkx4dmakrkjmaexwh3mnmgc5vhavb2miaj6grrzat@7kzr5vlsrmh5>
To: Ryan Lahfa <ryan@lahfa.xyz>

Hi,

we=E2=80=99re experiencing the same issue with a number of NixOS tests =
that are heavy in operations copying from the v9fs mounted nix store.

> On 13. Jun 2025, at 00:24, Ryan Lahfa <ryan@lahfa.xyz> wrote:
>=20
> Hi everyone,
>=20
> Le Wed, Oct 23, 2024 at 09:38:39PM +0200, Antony Antony a =C3=A9crit :
>> On Wed, Oct 23, 2024 at 11:07:05 +0100, David Howells wrote:
>>> Hi Antony,
>>>=20
>>> I think the attached should fix it properly rather than working =
around it as
>>> the previous patch did.  If you could give it a whirl?
>>=20
>> Yes this also fix the crash.
>>=20
>> Tested-by: Antony Antony <antony.antony@secunet.com>
>=20
> I cannot confirm this fixes the crash for me. My reproducer is =
slightly
> more complicated than Max's original one, albeit, still on NixOS and
> probably uses 9p more intensively than the automated NixOS testings
> workload.
>=20
> Here is how to reproduce it:
>=20
> $ git clone https://gerrit.lix.systems/lix
> $ cd lix
> $ git fetch https://gerrit.lix.systems/lix refs/changes/29/3329/8 && =
git checkout FETCH_HEAD
> $ nix-build -A hydraJobs.tests.local-releng
>=20
> I suspect the reason for why Antony considers the crash to be fixed is
> that the workload used to test it requires a significant amount of
> chance and retries to trigger the bug.
>=20
> On my end, you can see our CI showing the symptoms:
> =
https://buildkite.com/organizations/lix-project/pipelines/lix/builds/2357/=
jobs/019761e7-784e-4790-8c1b-f609270d9d19/log.
>=20
> We retried probably hundreds of times and saw different corruption
> patterns, Python getting confused, ld.so getting confused, systemd
> sometimes too. Python had a much higher chance of crashing in many of
> our tests. We reproduced it over aarch64-linux (Ampere Altra Q80-30) =
but
> also Intel and AMD CPUs (~5 different systems).

Yeah. We=E2=80=99re on AMD CPUs and it wasn=E2=80=99t hardware-bound.=20

The errors we saw where:=20

- malloc(): unaligned tcache chunk detected
- segfaulting java processes
- misbehaving filesystems (errors about internal structures in ext4, =
incorrect file content in xfs)
- crashing kernels when dealing with the outfall of those errors

> As soon as we reverted to Linux 6.6 series, the bug went away.

Same here, the otherway around: we came from 6.6.94 and updated to =
6.12.34 and immediately saw a number of tests failing, all of which were =
heavy in copying data from v9fs to the root filesystem in the VM.

> We bisected but we started to have weirder problems, this is because =
we
> encountered the original regression mentioned in October 2024 and for =
a
> certain range of commits, we were unable to bisect anything further.

I had already found the issue from last October when started bisecting, =
I later got in touch with Ryan who recognized that we were chasing the =
same issue. I stopped bisecting at that point - the bisect was already =
homing in around the time of the changes in last October.

> So I switched my bisection strategy to understand when the bug was
> fixed, this lead me on the commit
> e65a0dc1cabe71b91ef5603e5814359451b74ca7 which is the proper fix
> mentioned here and on this discussion.
>=20
> Reverting this on the top of 6.12 cause indeed a massive amount of
> traces, see this gist [1] for examples.

Yeah. During bisect I noticed it flapping around with the original =
October issues crashing immediately during boot.

> Applying the "workaround patch" aka "[PATCH] 9p: Don't revert the I/O
> iterator after reading" after reverting e65a0dc1cabe makes the problem
> go away after 5 tries (5 tries were sufficient to trigger with the
> proper fix).

Yup, I applied the revert and workaround patch on top of 6.12.34 and the =
reliably broken test became reliably green again.

Our test can be reproduced, too:

$ git clone https://github.com/flyingcircusio/fc-nixos.git
$ cd fc-nixos
$ eval $(./dev-setup)
$ nix-build tests/matomo.nix

The test will fail with ext4 complaining something like this:

machine # [ 42.596728] =
vn2haz1283lxz6iy0rai850a7jlgxbja-matomo-setup-update-pre[1233]: Copied =
files, updating package link in /var/lib/matomo/current-package.
machine # [ 42.788956] EXT4-fs error (device vda): =
htree_dirblock_to_tree:1109: inode #13138: block 5883: comm setfacl: bad =
entry in directory: rec_len % 4 !=3D 0 - offset=3D0, inode=3D606087968, =
rec_len=3D31074, size=3D4096 fake=3D0
machine # [ 42.958590] EXT4-fs error (device vda): =
htree_dirblock_to_tree:1109: inode #13138: block 5883: comm chown: bad =
entry in directory: rec_len % 4 !=3D 0 - offset=3D0, inode=3D606087968, =
rec_len=3D31074, size=3D4096 fake=3D0
machine # [ 43.068003] EXT4-fs error (device vda): =
htree_dirblock_to_tree:1109: inode #13138: block 5883: comm chmod: bad =
entry in directory: rec_len % 4 !=3D 0 - offset=3D0, inode=3D606087968, =
rec_len=3D31074, size=3D4096 fake=3D0
machine # [ 43.004098] =
vn2haz1283lxz6iy0rai850a7jlgxbja-matomo-setup-update-pre[1233]: Giving =
matomo read+write access to /var/lib/matomo/share/matomo.js, =
/var/lib/matomo/share/piwik.js, /var/lib/matomo/share/config, =
/var/lib/matomo/share/misc/user, /var/lib/matomo/share/js, =
/var/lib/matomo/share/tmp, /var/lib/matomo/share/misc
machine # [ 43.201319] EXT4-fs error (device vda): =
htree_dirblock_to_tree:1109: inode #13138: block 5883: comm setfacl: bad =
entry in directory: rec_len % 4 !=3D 0 - offset=3D0, inode=3D606087968, =
rec_len=3D31074, size=3D4096 fake=3D0

I=E2=80=99m also available for testing and further diagnosis.

Christian

--=20
Christian Theune =C2=B7 ct@flyingcircus.io =C2=B7 +49 345 219401 0
Flying Circus Internet Operations GmbH =C2=B7 https://flyingcircus.io
Leipziger Str. 70/71 =C2=B7 06108 Halle (Saale) =C2=B7 Deutschland
HR Stendal HRB 21169 =C2=B7 Gesch=C3=A4ftsf=C3=BChrer: Christian Theune, =
Christian Zagrodnick


