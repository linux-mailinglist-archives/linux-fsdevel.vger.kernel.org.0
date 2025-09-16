Return-Path: <linux-fsdevel+bounces-61481-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C69B58911
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 130F952100F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB98F19F40B;
	Tue, 16 Sep 2025 00:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ph1se7xi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3315E625
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 00:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757982056; cv=none; b=dIEebnhJia4gHzlBreYHyK+Oc2iT7nppGlge9O0M5nEGqr5tqn2hFxEPFDkI06U3JQm5VMbvbIMe1wsUqjO81sNR3IFlXAmV9dvIr4g21figX/R/hqR2mvqyacbojyM/QQSd5MaJE5UX045AWwk0xWkJg7yOhkRRiGkwfhIztEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757982056; c=relaxed/simple;
	bh=9V6S+ToqYOKGoCF4liioLukqlDyrfN2J298ylaop/4A=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A4wzNEMmF3bg7bY9CK8AHi3cLr66fG19fDdf9qP4LJ+KeJ/toMRKN1bMil8YAukJWbcTBaM4Tu6EiGwpg7dn35/4sD+WVWsteR7COdsXYwy8/+UVcugz7XSNME1R/sttDLhHKAAK6ml7zS9+T3Z9znUYlMIdoCzcuAM0m/KopPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ph1se7xi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8127C4CEF1;
	Tue, 16 Sep 2025 00:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757982054;
	bh=9V6S+ToqYOKGoCF4liioLukqlDyrfN2J298ylaop/4A=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Ph1se7xiDKBAOIrpMZqzIHmJfznvCRWOGhyImLMt7KKBoc/+QtahcYMKovIgqxIIj
	 ofHvnKnoYW+l64p4+TV0+FWXeH9O7l1K3hzJ33CnH26DeZEvkdbdoEO878Bc0ZeOnQ
	 Oyqjezc00FI2aCM+F3PFzwz1lK1m8qsacAN37nKVXdFJeueLsHFW0BmoCOcb8NO4WY
	 npLe1mWZ1SJl8AMZMHPepeag71uQbKzdTWyCVvjMN9UFenDNM3ko8F2Th9HPvtkPfL
	 MpFN4oUrITpeF0j66LoIiHohKsRpnvUB/r+EOA/mKivWNJ1INqP7bMR01y4mgLm1VU
	 sgv72DpjHxH+w==
Date: Mon, 15 Sep 2025 17:20:54 -0700
Subject: [PATCHSET RFC v5 3/6] libfuse: allow servers to specify root node id
From: "Darrick J. Wong" <djwong@kernel.org>
To: bschubert@ddn.com, djwong@kernel.org
Cc: John@groves.net, neal@gompa.dev, bernd@bsbernd.com,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com
Message-ID: <175798155022.387637.12203325269097480388.stgit@frogsfrogsfrogs>
In-Reply-To: <20250916000759.GA8080@frogsfrogsfrogs>
References: <20250916000759.GA8080@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

This series grants fuse servers full control over the entire node id
address space by allowing them to specify the nodeid of the root
directory.  With this new feature, fuse4fs will not have to translate
node ids.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

With a bit of luck, this should all go splendidly.
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-root-nodeid
---
Commits in this patchset:
 * libfuse: allow root_nodeid mount option
---
 lib/mount.c |    1 +
 1 file changed, 1 insertion(+)


