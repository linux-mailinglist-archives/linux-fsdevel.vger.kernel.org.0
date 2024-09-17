Return-Path: <linux-fsdevel+bounces-29568-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D1E97AD8A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 11:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B30EB1F23767
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 09:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C4515AAD9;
	Tue, 17 Sep 2024 09:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m0/iJTXx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAD61BF24;
	Tue, 17 Sep 2024 09:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726563974; cv=none; b=q1JAx5b+AJXFGIon32+dUfQrU6Yw6tB09Ctk2BYE31/AacnbHraQ3QM1ZUL43jeA7Erioq5niVL4tM3l8NmkWWt0dqQbmZ49GoSOOKS2wcvtez720YeH+KeZaRw1EKU0L//nd+RNjnhYwPl/wHchmOE721U4lHoPIM2bqCfcSfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726563974; c=relaxed/simple;
	bh=ygjtxYhv9hYQ94rHfHDJ0TFVycGCI4wY9gAQqGLS3iM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lx01W3NrbcCVAd9sQ5wIOpSLf1EohsjdgbTl6l1bzbV7r8IQ35sIZhZh+D1ABlmNxE3BU5PpxfkeF/LyPldW91hSFDZkdjSoNviDEkPokI9qXK5IxXVEeDuu2E3g9CnrQ4ULAc1Gfw20esc+I2iFoj7ZsQB+HqNcoh8OG95GHpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m0/iJTXx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3CCEC4CEC5;
	Tue, 17 Sep 2024 09:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726563973;
	bh=ygjtxYhv9hYQ94rHfHDJ0TFVycGCI4wY9gAQqGLS3iM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m0/iJTXx2mfDnw2c77Glvs/t1uveBa373ary/8oaujNIg+IXiIu5aY67KTgTud8W+
	 7xExpfP8teap3eIznVtI1QyTyi/pMJptC3q5yP5gPPyJ/fWkhtEqvubSNdkDJs1EvM
	 LcdLjiERjV4CFRDrRXMyJ0yZ378rJlIPJnpuVe3HiAKcOAzeJTtGc8/My0XdhNZYZy
	 dDGIHVt3z4xP/Fj77FfkURnOlGdOQSpW4X7VaQGsMmj5AaiysLt2LyUS+SghCGDPyy
	 ZLw3clu/HNfQBEXQs9GmZhTsp8vXOy7SeqmQr6XAxUm6ijC45b2qkcAt//3Kgm1niS
	 8zE6bYjGnSSCA==
From: Christian Brauner <brauner@kernel.org>
To: Marc Dionne <marc.dionne@auristor.com>,
	David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Jeff Layton <jlayton@kernel.org>,
	linux-afs@lists.infradead.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] afs: Fix missing wire-up of afs_retry_request()
Date: Tue, 17 Sep 2024 11:06:04 +0200
Message-ID: <20240917-hilfen-triumphieren-56ea8289b839@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <1690847.1726346402@warthog.procyon.org.uk>
References: <1690847.1726346402@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1164; i=brauner@kernel.org; h=from:subject:message-id; bh=ygjtxYhv9hYQ94rHfHDJ0TFVycGCI4wY9gAQqGLS3iM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS9dKu/mn6y1Xntz9LZ0iFRxlmBvqd+PVDJ/jvv8MaK9 f8blwRc6ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjInpcMv9nyZK9u1Avel9b5 LGLepwm1J3MaJ71fXbp65weXPeI93+8w/Hc83XA9nzPSInO1zfndRWsM+k4ZhVlNO8hx5MyiuvV x+zkA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sat, 14 Sep 2024 21:40:02 +0100, David Howells wrote:
> afs_retry_request() is supposed to be pointed to by the afs_req_ops netfs
> operations table, but the pointer got lost somewhere.  The function is used
> during writeback to rotate through the authentication keys that were in
> force when the file was modified locally.
> 
> Fix this by adding the pointer to the function.
> 
> [...]

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/1] afs: Fix missing wire-up of afs_retry_request()
      https://git.kernel.org/vfs/vfs/c/3fe535cb1a3b

