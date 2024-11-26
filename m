Return-Path: <linux-fsdevel+bounces-35886-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7D79D94F8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 10:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79234164C5F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 09:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5651BD9DC;
	Tue, 26 Nov 2024 09:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ivdsSqOk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDB81A3042;
	Tue, 26 Nov 2024 09:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732615065; cv=none; b=YOGS+AL7IVPHXy0kZyAw2uuFuPQvvDqJuGwtfzqcbf4EfjYj3ETHH6M/dXCLE3VAWuN54fL80LX6kygaGGifm93vB9cyfzQhq5oIKR34SeDci7qi3l25FTjUUiCQHTSGUllmjJ72und42gnwCIHku4E22w5C47WeX4Pykz/IfcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732615065; c=relaxed/simple;
	bh=C77GYZf+MMmOa2Q8HzVYnSBsG/ck0v9xBH9rZLhGZdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ohmnol0cHKf3xzriGIw8u0G4MaBxUEJ3mm8FWIr3An5FhwojDnk9quFColyvJ2UL46ckVsRVBCVTab1HO1WVCm3ELT72VWaxAiMHg2ldwWUvCubTD88SQFYSbwoPyNmMo6V/3q9sIOQwG6R9l97vYocvQdld+vK/Lr46aAguDlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ivdsSqOk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 498D5C4CED2;
	Tue, 26 Nov 2024 09:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732615065;
	bh=C77GYZf+MMmOa2Q8HzVYnSBsG/ck0v9xBH9rZLhGZdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ivdsSqOky2Zy6omW/jxIhPasjEkBEw+VS1nY9KjMyUXbob2KHuXDzcMf/2RY59p1i
	 HTXTUqmmPmCmhuLNmh6wc4+JMNQETDdw7S/k0ZJecPxOCjHVOqiF+0Q+5GNFsAJgfz
	 mFB0S6787IxHGCwwKTUcGQstVm52xvUDPLsyE2P5htLDVqO7KoX2qrPJTqesHXejj/
	 9PLawAeW/Oms4X9L3ofnDiulHCcmJOmopIUiylKnkGI9RTCZLdB0ofPRKezehKI2Uk
	 SLKmmzxOW7cgNlusy75UfjdnfH27rM3PhCx7Tj384PONgppNEg9aiSyhd25rXLbFc+
	 266/Muf2ItRBA==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jens Axboe <axboe@kernel.dk>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 00/29] cred: rework {override,revert}_creds()
Date: Tue, 26 Nov 2024 10:57:23 +0100
Message-ID: <20241126-bedarf-klonen-fa5955090f83@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241125-work-cred-v2-0-68b9d38bb5b2@kernel.org>
References: <20241125-work-cred-v2-0-68b9d38bb5b2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=4590; i=brauner@kernel.org; h=from:subject:message-id; bh=C77GYZf+MMmOa2Q8HzVYnSBsG/ck0v9xBH9rZLhGZdk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS7zu43UPRby77Zk9Xnn1S9rn+D5eZlhjUT6+t8TS++8 trwVe9SRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQ+HGNkuH8yaNnn0EXJHh/N N+zZX7vEReB5MlPPwj2bulVajrQcdmdk+MoU2bF/XnXV+xqeyakOt/jbr62959051fniS3Vj1bu qPAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 25 Nov 2024 15:09:56 +0100, Christian Brauner wrote:
> For the v6.13 cycle we switched overlayfs to a variant of
> override_creds() that doesn't take an extra reference. To this end I
> suggested introducing {override,revert}_creds_light() which overlayfs
> could use.
> 
> This seems to work rather well. This series follow Linus advice and
> unifies the separate helpers and simply makes {override,revert}_creds()
> do what {override,revert}_creds_light() currently does. Caller's that
> really need the extra reference count can take it manually.
> 
> [...]

Applied to the kernel.cred branch of the vfs/vfs.git tree.
Patches in the kernel.cred branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: kernel.cred

[01/29] tree-wide: s/override_creds()/override_creds_light(get_new_cred())/g
        https://git.kernel.org/vfs/vfs/c/166096e12ea2
[02/29] cred: return old creds from revert_creds_light()
        https://git.kernel.org/vfs/vfs/c/0f8b3bd1b3cc
[03/29] tree-wide: s/revert_creds()/put_cred(revert_creds_light())/g
        https://git.kernel.org/vfs/vfs/c/eb194f385c7a
[04/29] cred: remove old {override,revert}_creds() helpers
        https://git.kernel.org/vfs/vfs/c/eeb9c41696a9
[05/29] tree-wide: s/override_creds_light()/override_creds()/g
        https://git.kernel.org/vfs/vfs/c/8b9b75bc7a7f
[06/29] tree-wide: s/revert_creds_light()/revert_creds()/g
        https://git.kernel.org/vfs/vfs/c/5e0c1ca92141
[07/29] firmware: avoid pointless reference count bump
        https://git.kernel.org/vfs/vfs/c/0fc8b46c9698
[08/29] sev-dev: avoid pointless cred reference count bump
        https://git.kernel.org/vfs/vfs/c/6fb26cb0712b
[09/29] target_core_configfs: avoid pointless cred reference count bump
        https://git.kernel.org/vfs/vfs/c/2a7cf8f44396
[10/29] aio: avoid pointless cred reference count bump
        https://git.kernel.org/vfs/vfs/c/01d3402ff15e
[11/29] binfmt_misc: avoid pointless cred reference count bump
        https://git.kernel.org/vfs/vfs/c/0d80b0eeca95
[12/29] coredump: avoid pointless cred reference count bump
        https://git.kernel.org/vfs/vfs/c/1c51da6bee5b
[13/29] nfs/localio: avoid pointless cred reference count bumps
        https://git.kernel.org/vfs/vfs/c/b5c4d8852ca4
[14/29] nfs/nfs4idmap: avoid pointless reference count bump
        https://git.kernel.org/vfs/vfs/c/5549222d7969
[15/29] nfs/nfs4recover: avoid pointless cred reference count bump
        https://git.kernel.org/vfs/vfs/c/95c7b08dc110
[16/29] nfsfh: avoid pointless cred reference count bump
        https://git.kernel.org/vfs/vfs/c/9b7d4076e164
[17/29] open: avoid pointless cred reference count bump
        https://git.kernel.org/vfs/vfs/c/a58084535085
[18/29] ovl: avoid pointless cred reference count bump
        https://git.kernel.org/vfs/vfs/c/70545c2bb39e
[19/29] cifs: avoid pointless cred reference count bump
        https://git.kernel.org/vfs/vfs/c/2225ba3d36a0
[20/29] cifs: avoid pointless cred reference count bump
        https://git.kernel.org/vfs/vfs/c/2225ba3d36a0
[21/29] smb: avoid pointless cred reference count bump
        https://git.kernel.org/vfs/vfs/c/55545232890f
[22/29] io_uring: avoid pointless cred reference count bump
        https://git.kernel.org/vfs/vfs/c/bf8820866809
[23/29] acct: avoid pointless reference count bump
        https://git.kernel.org/vfs/vfs/c/11c99d734a22
[24/29] cgroup: avoid pointless cred reference count bump
        https://git.kernel.org/vfs/vfs/c/f9844cf85703
[25/29] trace: avoid pointless cred reference count bump
        https://git.kernel.org/vfs/vfs/c/5f10fe797c1d
[26/29] dns_resolver: avoid pointless cred reference count bump
        https://git.kernel.org/vfs/vfs/c/97f0beb2aa35
[27/29] cachefiles: avoid pointless cred reference count bump
        https://git.kernel.org/vfs/vfs/c/b25b2b31265a
[28/29] nfsd: avoid pointless cred reference count bump
        https://git.kernel.org/vfs/vfs/c/c45990a2e032
[29/29] cred: remove unused get_new_cred()
        https://git.kernel.org/vfs/vfs/c/d9bf032c76d9

