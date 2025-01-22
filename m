Return-Path: <linux-fsdevel+bounces-39875-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7491DA19B12
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 23:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28276188362A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 22:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DAF738DF9;
	Wed, 22 Jan 2025 22:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PByBTE91"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA741C8FCE
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jan 2025 22:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737586410; cv=none; b=onVvBi0+zEaLfxVSJfgZsGeZGDC03jcQ9WuU9YGJUQWPNLhXKfUOxxBL4rGE6zRlCqhP+VRcgmldD2o4LoM/gKDQxXTSCvE1YeoKJ1KMdW+bdCRDAiBSm7SwSnFbOliAnHm0DLW1hOSzUUDqoMzEbAKC8a+eRbz8DqApLb2hATI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737586410; c=relaxed/simple;
	bh=/+Qb9piDpp0WtpJQLROTCuJy6yHAunocsk/oy1F6zmU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RurPwioxWZD2xgRBqpl+kXmGznD8+P5TiMXZPNdlbWliY1Lne8fxj/ezVKtL+OwkUPrEBhrZjTzng/xO3lkI8Gv5TjIp+yJErfWx3S6Cd5OvalGeDXLlJwchSSQitq73KdPvwz+FU2r0wwCrdk+5hgZ0UTA4tgarj1caEMDwjro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PByBTE91; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA539C4CED2;
	Wed, 22 Jan 2025 22:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737586409;
	bh=/+Qb9piDpp0WtpJQLROTCuJy6yHAunocsk/oy1F6zmU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=PByBTE91LAIlDnM0AFfuW0v4BfTMYsqb0k43o444hB28JVFrNlYbx42ljhEIit/fR
	 QJT01/qUNSTbrSnnw2m54ICNTXzrNjNizClwM/dGVcxlbPtwlHdfuWEW0nSDml/odI
	 vbHuzlcLoC5mk59n1OdxSX4axArFFSJsJrYDHheUOajc1uyU0xhjmLTPvX6ia18Wx8
	 ytnert+TpjF9tIqOcYZEJZZDjTG/vcS9dcSfM3KloqI1zoBWGVY08K8muKvk9xDy8d
	 FNiDNwA/gbUVNOegT3IXGThIseOcJV9CM43nb7AFMnZzoABVM2hUWa5ALUtLBKU0is
	 T0W1wTHOej3vA==
Message-ID: <a946a03228f7a0504ab8ddd48a0776bf288ba166.camel@kernel.org>
Subject: Re: [PATCH v12 0/2] fuse: add kernel-enforced request timeout option
From: Jeff Layton <jlayton@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu, 
	linux-fsdevel@vger.kernel.org
Cc: bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, 
	laoar.shao@gmail.com, senozhatsky@chromium.org, tfiga@chromium.org, 
	bgeffon@google.com, etmartin4313@gmail.com, kernel-team@meta.com
Date: Wed, 22 Jan 2025 17:53:27 -0500
In-Reply-To: <20250122215528.1270478-1-joannelkoong@gmail.com>
References: <20250122215528.1270478-1-joannelkoong@gmail.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-01-22 at 13:55 -0800, Joanne Koong wrote:
> There are situations where fuse servers can become unresponsive or
> stuck, for example if the server is in a deadlock. Currently, there's
> no good way to detect if a server is stuck and needs to be killed
> manually.
>=20
> This patchset adds a timeout option where if the server does not reply to=
 a
> request by the time the timeout elapses, the connection will be aborted.
> This patchset also adds two dynamically configurable fuse sysctls
> "default_request_timeout" and "max_request_timeout" for controlling/enfor=
cing
> timeout behavior system-wide.
>=20
> Existing systems running fuse servers will not be affected unless they
> explicitly opt into the timeout.
>=20
> v11:
> https://lore.kernel.org/linux-fsdevel/20241218222630.99920-1-joannelkoong=
@gmail.com/
> Changes from v11 -> v12:
> * Pass request timeout through init instead of mount option (Miklos)
> * Change sysctl upper bound to max u16 val
> * Rebase on top of for-next, need to incorporate io-uring timeouts
>=20
> v10:
> https://lore.kernel.org/linux-fsdevel/20241214022827.1773071-1-joannelkoo=
ng@gmail.com/
> Changes from v10 -> v11:
> * Refactor check for request expiration (Sergey)
> * Move workqueue cancellation to earlier in function (Jeff)
> * Check fc->num_waiting as a shortcut in workqueue job (Etienne)
>=20
> v9:
> https://lore.kernel.org/linux-fsdevel/20241114191332.669127-1-joannelkoon=
g@gmail.com/
> Changes from v9 -> v10:
> * Use delayed workqueues instead of timers (Sergey and Jeff)
> * Change granularity to seconds instead of minutes (Sergey and Jeff)
> * Use time_after() api for checking jiffies expiration (Sergey)
> * Change timer check to run every 15 secs instead of every min
> * Update documentation wording to be more clear
>=20
> v8:
> https://lore.kernel.org/linux-fsdevel/20241011191320.91592-1-joannelkoong=
@gmail.com/
> Changes from v8 -> v9:
> * Fix comment for u16 fs_parse_result, ULONG_MAX instead of U32_MAX, fix
>   spacing (Bernd)
>=20
> v7:
> https://lore.kernel.org/linux-fsdevel/20241007184258.2837492-1-joannelkoo=
ng@gmail.com/
> Changes from v7 -> v8:
> * Use existing lists for checking expirations (Miklos)
>=20
> v6:
> https://lore.kernel.org/linux-fsdevel/20240830162649.3849586-1-joannelkoo=
ng@gmail.com/
> Changes from v6 -> v7:
> - Make timer per-connection instead of per-request (Miklos)
> - Make default granularity of time minutes instead of seconds
> - Removed the reviewed-bys since the interface of this has changed (now
>   minutes, instead of seconds)
>=20
> v5:
> https://lore.kernel.org/linux-fsdevel/20240826203234.4079338-1-joannelkoo=
ng@gmail.com/
> Changes from v5 -> v6:
> - Gate sysctl.o behind CONFIG_SYSCTL in makefile (kernel test robot)
> - Reword/clarify last sentence in cover letter (Miklos)
>=20
> v4:
> https://lore.kernel.org/linux-fsdevel/20240813232241.2369855-1-joannelkoo=
ng@gmail.com/
> Changes from v4 -> v5:
> - Change timeout behavior from aborting request to aborting connection (M=
iklos)
> - Clarify wording for sysctl documentation (Jingbo)
>=20
> v3:
> https://lore.kernel.org/linux-fsdevel/20240808190110.3188039-1-joannelkoo=
ng@gmail.com/
> Changes from v3 -> v4:
> - Fix wording on some comments to make it more clear
> - Use simpler logic for timer (eg remove extra if checks, use mod timer A=
PI) (Josef)
> - Sanity-check should be on FR_FINISHING not FR_FINISHED (Jingbo)
> - Fix comment for "processing queue", add req->fpq =3D NULL safeguard  (B=
ernd)
>=20
> v2:
> https://lore.kernel.org/linux-fsdevel/20240730002348.3431931-1-joannelkoo=
ng@gmail.com/
> Changes from v2 -> v3:
> - Disarm / rearm timer in dev_do_read to handle race conditions (Bernrd)
> - Disarm timer in error handling for fatal interrupt (Yafang)
> - Clean up do_fuse_request_end (Jingbo)
> - Add timer for notify retrieve requests=20
> - Fix kernel test robot errors for #define no-op functions
>=20
> v1:
> https://lore.kernel.org/linux-fsdevel/20240717213458.1613347-1-joannelkoo=
ng@gmail.com/
> Changes from v1 -> v2:
> - Add timeout for background requests
> - Handle resend race condition
> - Add sysctls
>=20
>=20
> Joanne Koong (2):
>   fuse: add kernel-enforced timeout option for requests
>   fuse: add default_request_timeout and max_request_timeout sysctls
>=20
>  Documentation/admin-guide/sysctl/fs.rst |  25 ++++++
>  fs/fuse/dev.c                           | 101 ++++++++++++++++++++++++
>  fs/fuse/dev_uring.c                     |  27 +++++++
>  fs/fuse/dev_uring_i.h                   |   6 ++
>  fs/fuse/fuse_dev_i.h                    |   3 +
>  fs/fuse/fuse_i.h                        |  27 +++++++
>  fs/fuse/inode.c                         |  41 +++++++++-
>  fs/fuse/sysctl.c                        |  24 ++++++
>  include/uapi/linux/fuse.h               |  10 ++-
>  9 files changed, 261 insertions(+), 3 deletions(-)
>=20

Nice work, Joanne. You can add:

Reviewed-by: Jeff Layton <jlayton@kernel.org>

