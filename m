Return-Path: <linux-fsdevel+bounces-72408-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1231ACF586B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 05 Jan 2026 21:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1A605302FCF0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jan 2026 20:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB5E33B6F3;
	Mon,  5 Jan 2026 20:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U/XMa98T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D3C2EBDCD
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Jan 2026 20:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767644978; cv=none; b=tpZTAC9eVkRTGIkAa6K03mVFYsXX9K01V9+yhSHHy/OSbpBOz5FsXlwKTmJUOKkkRCg3gwYOFaywHEBAtfC31a3DFBXp2S03uhQCdlZOS6iUgGkcpstffC8U1o+BBtHd6rWMV5hug7V0ns+PYG538KT9JNCbX6uMZFDiC+DkllM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767644978; c=relaxed/simple;
	bh=MqrNAQSdHF/IMGXlbTqc92JwObd7M+FMg+7Wx50AtkE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VBEaEjx8foBWM0duenG07oClNp19dhyIOWwI13zwtLqF+y0AwHVC3Ncg6BcbSiKM1dLtvguPc7GcARPgbzlMN3VOpuGQ+7x9hJfHKV3FM3GHCoRwidvFBYxEDH/aj5y9T/2lPuMt5fs0u2xCkqt88wbEJ6GBY0JUDBE0UQiMUpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U/XMa98T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7AE1C116D0;
	Mon,  5 Jan 2026 20:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767644977;
	bh=MqrNAQSdHF/IMGXlbTqc92JwObd7M+FMg+7Wx50AtkE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=U/XMa98Tm91IPQSkB5hWOL1MazbVaAHT3CTna3pMDnLy76PbLuqByVM0DiKfHxOk2
	 /PGh2OBRnRgk8epGp+vUE5v+7tdu6nvxOf3sfGPtqXb+YBoNwJ5pDMOY2j2icUzGti
	 OQDuOigyrjaWg1Kamtw43mV8BXb9bzx0T73ZAouEIzZ7qj+SVdGu6WX1Xm+YTfyqsb
	 vSQqfZAkhMRzV/AC6tfKUC/FPIvecIL/J8kTBSlE4Vncv8wh3GbZUZWt1hhsrkgbKQ
	 dvLiKNEYm1ZljSXeYTdMTa7Ltd8nrxPgXTb3C6W4gzatCfI/uy7qmh2R7QfNY3s9QI
	 7I7qcofQXezdw==
Message-ID: <6efb8f5d904c3cc4273aef725ca0bd43b05902eb.camel@kernel.org>
Subject: Re: [PATCH 0/2] mount: add OPEN_TREE_NAMESPACE
From: Jeff Layton <jlayton@kernel.org>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Amir Goldstein	
 <amir73il@gmail.com>, Josef Bacik <josef@toxicpanda.com>, Jan Kara
 <jack@suse.cz>,  Aleksa Sarai <cyphar@cyphar.com>
Date: Mon, 05 Jan 2026 15:29:35 -0500
In-Reply-To: <20251229-work-empty-namespace-v1-0-bfb24c7b061f@kernel.org>
References: <20251229-work-empty-namespace-v1-0-bfb24c7b061f@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: multipart/mixed; boundary="=-KdvfuxsDD3i8Ge9SeXn3"
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

--=-KdvfuxsDD3i8Ge9SeXn3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2025-12-29 at 14:03 +0100, Christian Brauner wrote:
> When creating containers the setup usually involves using CLONE_NEWNS
> via clone3() or unshare(). This copies the caller's complete mount
> namespace. The runtime will also assemble a new rootfs and then use
> pivot_root() to switch the old mount tree with the new rootfs. Afterward
> it will recursively umount the old mount tree thereby getting rid of all
> mounts.
>=20
> On a basic system here where the mount table isn't particularly large
> this still copies about 30 mounts. Copying all of these mounts only to
> get rid of them later is pretty wasteful.
>=20
> This is exacerbated if intermediary mount namespaces are used that only
> exist for a very short amount of time and are immediately destroyed
> again causing a ton of mounts to be copied and destroyed needlessly.
>=20
> With a large mount table and a system where thousands or ten-thousands
> of namespaces are spawned in parallel this quickly becomes a bottleneck
> increasing contention on the semaphore.
>=20
> Extend open_tree() with a new OPEN_TREE_NAMESPACE flag. Similar to
> OPEN_TREE_CLONE only the indicated mount tree is copied. Instead of
> returning a file descriptor referring to that mount tree
> OPEN_TREE_NAMESPACE will cause open_tree() to return a file descriptor
> to a new mount namespace. In that new mount namespace the copied mount
> tree has been mounted on top of a copy of the real rootfs.
>=20
> The caller can setns() into that mount namespace and perform any
> additionally setup such as move_mount()ing detached mounts in there.
>=20
> This allows OPEN_TREE_NAMESPACE to function as a combined
> unshare(CLONE_NEWNS) and pivot_root().
>=20
> A caller may for example choose to create an extremely minimal rootfs:
>=20
> fd_mntns =3D open_tree(-EBADF, "/var/lib/containers/wootwoot", OPEN_TREE_=
NAMESPACE);
>=20
> This will create a mount namespace where "wootwoot" has become the
> rootfs mounted on top of the real rootfs. The caller can now setns()
> into this new mount namespace and assemble additional mounts.
>=20
> This also works with user namespaces:
>=20
> unshare(CLONE_NEWUSER);
> fd_mntns =3D open_tree(-EBADF, "/var/lib/containers/wootwoot", OPEN_TREE_=
NAMESPACE);
>=20
> which creates a new mount namespace owned by the earlier created user
> namespace with "wootwoot" as the rootfs mounted on top of the real
> rootfs.
>=20
> This will scale a lot better when creating tons of mount namespaces and
> will allow to get rid of a lot of unnecessary mount and umount cycles.
> It also allows to create mount namespaces without needing to spawn
> throwaway helper processes.
>=20
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
> Christian Brauner (2):
>       mount: add OPEN_TREE_NAMESPACE
>       selftests/open_tree: add OPEN_TREE_NAMESPACE tests
>=20
>  fs/internal.h                                      |    1 +
>  fs/namespace.c                                     |  155 ++-
>  fs/nsfs.c                                          |   13 +
>  include/uapi/linux/mount.h                         |    3 +-
>  .../selftests/filesystems/open_tree_ns/.gitignore  |    1 +
>  .../selftests/filesystems/open_tree_ns/Makefile    |   10 +
>  .../filesystems/open_tree_ns/open_tree_ns_test.c   | 1030 ++++++++++++++=
++++++
>  tools/testing/selftests/filesystems/utils.c        |   26 +
>  tools/testing/selftests/filesystems/utils.h        |    1 +
>  9 files changed, 1223 insertions(+), 17 deletions(-)
> ---
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> change-id: 20251229-work-empty-namespace-352a9c2dfe0a

I sat down today and rolled the attached program. It's a nonsensical
test that just tries to fork new tasks that then spawn new mount
namespaces and switch into them as quickly as possible.

Assuming that I've done this correctly, this gives me rough numbers
from a test host that I checked out inside Meta:

With the older pivot_root() based method, I can create about 73k
"containers" in 60s. With the newer open_tree() method, I can create
about 109k in the same time. So it seems like the new method is roughly
40% faster than the older scheme (and a lot less syscalls too).

Note that the run_pivot() routine in the reproducer is based on a
strace of an earlier reproducer. That one used minijail0 to create the
containers. It's possible that there are more efficient ways to do what
it's doing with the existing APIs. It seems to do some weird stuff too
(e.g. setting everything to MS_PRIVATE twice under the old root).
Spawning a real container might have other bottlenecks too.

Still, this extension to open_tree() seems like a good idea overall,
and gets rid of a lot of useless work that we currently do when
spawning a container. The only real downside that I can see is that
container orchestrators will need changes to use the new method.

You can add:

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Tested-by: Jeff Layton <jlayton@kernel.org>

--=-KdvfuxsDD3i8Ge9SeXn3
Content-Disposition: attachment; filename="spawnbench.c"
Content-Type: text/x-csrc; name="spawnbench.c"; charset="UTF-8"
Content-Transfer-Encoding: base64

I2RlZmluZSBfR05VX1NPVVJDRQojaW5jbHVkZSA8c3RkaW8uaD4KI2luY2x1ZGUgPHB0aHJlYWQu
aD4KI2luY2x1ZGUgPHNjaGVkLmg+CiNpbmNsdWRlIDxzdGRsaWIuaD4KI2luY2x1ZGUgPHVuaXN0
ZC5oPgojaW5jbHVkZSA8c3RkaW50Lmg+CiNpbmNsdWRlIDxmY250bC5oPgojaW5jbHVkZSA8Z2V0
b3B0Lmg+CiNpbmNsdWRlIDxzeXMvbW91bnQuaD4KI2luY2x1ZGUgPHN5cy9zeXNjYWxsLmg+CiNp
bmNsdWRlIDxzeXMvd2FpdC5oPgojaW5jbHVkZSA8dGltZS5oPgojaW5jbHVkZSA8c3RkYm9vbC5o
PgoKI2RlZmluZSBDT05DVVJSRU5DWQk4OAojZGVmaW5lIERVUkFUSU9OCTYwCiNkZWZpbmUgUk9P
VERJUgkJIi92YXIvZW1wdHkiCgpzdGF0aWMgdWludDY0X3QJdG90YWxfY29udGFpbmVyczsKc3Rh
dGljIGJvb2wJCW9wZW50cmVlOwoKc3RhdGljIHZvaWQgcnVuX3Bpdm90KCkKewoJaW50IHJldCwg
b2xkZmQsIG5ld2ZkOwoKCXJldCA9IHVuc2hhcmUoQ0xPTkVfTkVXTlMpOwoJaWYgKHJldCkgewoJ
CXBlcnJvcigidW5zaGFyZSIpOwoJCWV4aXQoMSk7Cgl9CgoJcmV0ID0gbW91bnQoTlVMTCwgIi8i
LCBOVUxMLCBNU19SRUN8TVNfUFJJVkFURSwgTlVMTCk7CglpZiAocmV0KSB7CgkJcGVycm9yKCJt
b3VudCIpOwoJCWV4aXQoMSk7Cgl9CgoJb2xkZmQgPSBvcGVuYXQoQVRfRkRDV0QsICIvIiwgT19S
RE9OTFl8T19DTE9FWEVDfE9fRElSRUNUT1JZKTsKCWlmIChvbGRmZCA8IDApIHsKCQlwZXJyb3Io
Im9wZW5hdCIpOwoJCWV4aXQoMSk7Cgl9CgoJbmV3ZmQgPSBvcGVuYXQoQVRfRkRDV0QsIFJPT1RE
SVIsIE9fUkRPTkxZfE9fQ0xPRVhFQ3xPX0RJUkVDVE9SWSk7CglpZiAobmV3ZmQgPCAwKSB7CgkJ
cGVycm9yKCJvcGVuYXQiKTsKCQlleGl0KDEpOwoJfQoKCXJldCA9IG1vdW50KFJPT1RESVIsIFJP
T1RESVIsIE5VTEwsIE1TX0JJTkR8TVNfUkVDLCBOVUxMKTsKCWlmIChyZXQpIHsKCQlwZXJyb3Io
Im1vdW50Iik7CgkJZXhpdCgxKTsKCX0KCglyZXQgPSBjaGRpcihST09URElSKTsKCWlmIChyZXQp
IHsKCQlwZXJyb3IoImNoZGlyIik7CgkJZXhpdCgxKTsKCX0KCglyZXQgPSBzeXNjYWxsKFNZU19w
aXZvdF9yb290LCAiLiIsICIuIik7CglpZiAocmV0KSB7CgkJcGVycm9yKCJwaXZvdF9yb290Iik7
CgkJZXhpdCgxKTsKCX0KCglyZXQgPSBmY2hkaXIob2xkZmQpOwoJaWYgKHJldCkgewoJCXBlcnJv
cigiZmNoZGlyIik7CgkJZXhpdCgxKTsKCX0KCglyZXQgPSBtb3VudChOVUxMLCAiLiIsIE5VTEws
IE1TX1JFQ3xNU19QUklWQVRFLCBOVUxMKTsKCWlmIChyZXQpIHsKCQlwZXJyb3IoIm1vdW50Iik7
CgkJZXhpdCgxKTsKCX0KCglyZXQgPSB1bW91bnQyKCIuIiwgTU5UX0RFVEFDSCk7CglpZiAocmV0
KSB7CgkJcGVycm9yKCJ1bW91bnQiKTsKCQlleGl0KDEpOwoJfQoKCXJldCA9IGZjaGRpcihuZXdm
ZCk7CglpZiAocmV0KSB7CgkJcGVycm9yKCJmY2hkaXIiKTsKCQlleGl0KDEpOwoJfQoKCWNsb3Nl
KG9sZGZkKTsKCWNsb3NlKG5ld2ZkKTsKfQoKc3RhdGljIHZvaWQgcnVuX29wZW50cmVlKCkKewoJ
aW50IGZkLCByZXQ7CgoJLy8gMiA9PSBPUEVOX1RSRUVfTkFNRVNQQUNFCglmZCA9IHN5c2NhbGwo
U1lTX29wZW5fdHJlZSwgQVRfRkRDV0QsIFJPT1RESVIsIDIpOwoJaWYgKGZkIDwgMCkgewoJCXBl
cnJvcigib3Blbl90cmVlIik7CgkJZXhpdCgxKTsKCX0KCglyZXQgPSBzZXRucyhmZCwgQ0xPTkVf
TkVXTlMpOwoJaWYgKHJldCkgewoJCXBlcnJvcigic2V0bnMiKTsKCQlleGl0KDEpOwoJfQoKCWNs
b3NlKGZkKTsKfQoKc3RhdGljIHZvaWQgKnJ1bl9jb250YWluZXIodm9pZCAqYXJnKQp7CglwaWRf
dCBwaWQ7CgoJZm9yICg7OykgewoJCXBpZCA9IGZvcmsoKTsKCQlpZiAocGlkID09IDApIHsKCQkJ
aWYgKG9wZW50cmVlKQoJCQkJcnVuX29wZW50cmVlKCk7CgkJCWVsc2UKCQkJCXJ1bl9waXZvdCgp
OwoJCQlicmVhazsKCQl9IGVsc2UgaWYgKHBpZCA+IDApIHsKCQkJd2FpdHBpZChwaWQsIE5VTEws
IDApOwoJCQlfX2F0b21pY19hZGRfZmV0Y2goJnRvdGFsX2NvbnRhaW5lcnMsIDEsIF9fQVRPTUlD
X1JFTEFYRUQpOwoJCX0gZWxzZSB7CgkJCXBlcnJvcigiZm9yayIpOwoJCQlleGl0KDEpOwoJCX0K
CX0KCglyZXR1cm4gTlVMTDsKfQoKaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKiphcmd2KQp7Cglp
bnQgaSwgb3B0OwoJaW50IGNvbmN1cnJlbmN5ID0gQ09OQ1VSUkVOQ1k7CglpbnQgZHVyYXRpb24g
PSBEVVJBVElPTjsKCXRpbWVfdCBzdGFydCwgbm93OwoKCXdoaWxlICgob3B0ID0gZ2V0b3B0KGFy
Z2MsIGFyZ3YsICJjOmQ6byIpKSAhPSAtMSkgewoJCXN3aXRjaCAob3B0KSB7CgkJY2FzZSAnYyc6
CgkJCWNvbmN1cnJlbmN5ID0gYXRvaShvcHRhcmcpOwoJCQlicmVhazsKCQljYXNlICdkJzoKCQkJ
ZHVyYXRpb24gPSBhdG9pKG9wdGFyZyk7CgkJCWJyZWFrOwoJCWNhc2UgJ28nOgoJCQlvcGVudHJl
ZSA9IHRydWU7CgkJCWJyZWFrOwoJCX0KCX0KCglmb3IgKGkgPSAwOyBpIDwgY29uY3VycmVuY3k7
ICsraSkgewoJCXB0aHJlYWRfdCB0aWQ7CgkJaW50IHJldDsKCgkJcmV0ID0gcHRocmVhZF9jcmVh
dGUoJnRpZCwgTlVMTCwgcnVuX2NvbnRhaW5lciwgTlVMTCk7CgkJaWYgKHJldCAhPSAwKSB7CgkJ
CWZwcmludGYoc3RkZXJyLCAicHRocmVhZF9jcmVhdGUgZmFpbGVkISAlZFxuIiwgcmV0KTsKCQkJ
ZXhpdCgxKTsKCQl9Cgl9CgoKCXN0YXJ0ID0gdGltZShOVUxMKTsKCXdoaWxlICgobm93IC0gc3Rh
cnQpIDwgZHVyYXRpb24pIHsKCQl1aW50NjRfdCB2YWw7CgoJCV9fYXRvbWljX2xvYWQoJnRvdGFs
X2NvbnRhaW5lcnMsICZ2YWwsIF9fQVRPTUlDX1JFTEFYRUQpOwoJCXByaW50ZigiVG90YWwgY29u
dGFpbmVyczogJWx1XG4iLCB2YWwpOwoJCXNsZWVwKDIpOwoJCW5vdyA9IHRpbWUoTlVMTCk7Cgl9
Cn0K


--=-KdvfuxsDD3i8Ge9SeXn3--

