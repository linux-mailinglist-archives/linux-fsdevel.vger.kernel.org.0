Return-Path: <linux-fsdevel+bounces-56342-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C56ADB161F3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 15:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CADFC3BF8C1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 13:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507102D8DD9;
	Wed, 30 Jul 2025 13:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gYyVN/XG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFA82D837F;
	Wed, 30 Jul 2025 13:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753883656; cv=none; b=u0WxvvDuX4aI3tseH7Ixdhk3SiB+o/s3mbse6LBPIRYUz2L8sNO3QNAYKhUvjy7x47dJo5kGPA9Xjib4KHL36skSKz0u/U4KY9/htm3e4m4/JQdrMKulaASJnvFdt+xyhM151XUwwdLvcCaTO7V8aLnpWXxYK7eorPdR26o+WTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753883656; c=relaxed/simple;
	bh=nmt+hN9TOEJeE4um5/7l+RZD3WXERXwa4/JhfQBUngc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sr3J+jd/IX4KW/iWT1hH011ez+0dgY2YjD06qH5iQUxXlIw0wt81CR3Dj5ufUpUR+eFutDWYBfxuCWXofHklrO33/7znVvN+hcK6WCNpdN+njOm9t+L5fDjjhV3rPcACr42IQG4i3yjxTZvPU+MNbI2FEeiPz67mndergauaiNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gYyVN/XG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5E0FC4CEE3;
	Wed, 30 Jul 2025 13:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753883656;
	bh=nmt+hN9TOEJeE4um5/7l+RZD3WXERXwa4/JhfQBUngc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gYyVN/XGm8G3BPv8aBwxXLnXm2fQQ07mU48tyk6KSHxjsyYR+yRaiYwcXVzmSc4zo
	 Pn40dSla1VAi9WgCMWiVIv04M/i4H0xf27rX7jVX9k0mhng3HY8qKPGZFG/x/CkdZU
	 /X71tv+zklpHX0D0a9pP3Ba9+ZOaS8n6eIoVFMiUX/Izn6ovimcpyWiMf48Hj2YaAd
	 JcK5JkkTO8H44pbJOrquWC0mepfNPOXPVkFaSrxRYqRnb7c235/9DaHMIpHnRA3zKy
	 6mVMmzbdgzOQWD8gzb4+LXgMUlqBnV1a5ZvCQr9Ls5CvJyoZj0O1lZ1uSN67og8iWY
	 +lHNUBfKo6Lvg==
From: Chuck Lever <cel@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v4 0/8] nfsd/vfs: fix handling of delegated timestamp updates
Date: Wed, 30 Jul 2025 09:54:10 -0400
Message-ID: <175388362821.78947.18183127032969015435.b4-ty@oracle.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250730-nfsd-testing-v4-0-7f5730570a52@kernel.org>
References: <20250730-nfsd-testing-v4-0-7f5730570a52@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Wed, 30 Jul 2025 09:24:29 -0400, Jeff Layton wrote:
> This patchset fixes the handling of delegated timestamps in nfsd. This
> one also adopts Neil's suggestopn to use FMODE_NOCMTIME to freeze
> timestamp updates while there is a WRITE_ATTRS delegation outstanding.
> 
> Most of these patches are identical to the last set. I dropped the patch
> that removes inode_set_ctime_deleg(), and reworked the logic in
> setattr_copy() and friends to accomodate.
> 
> [...]

Applied v4 to nfsd-testing, thanks!

[1/8] nfsd: fix assignment of ia_ctime.tv_nsec on delegated mtime update
      commit: 237f236e44701cffc5cd9e302d4fec172a954d2f
[2/8] nfsd: ignore ATTR_DELEG when checking ia_valid before notify_change()
      commit: 30a594d856dc2fc89d3751b5d630cd55fceffd9a
[3/8] vfs: add ATTR_CTIME_SET flag
      commit: 3076cf4693efc8596a1d1eee17a9bc9b5c4b197d
[4/8] nfsd: use ATTR_CTIME_SET for delegated ctime updates
      commit: 12b1b09ddb932c2be8148758ebb5d93265293d18
[5/8] nfsd: track original timestamps in nfs4_delegation
      commit: 2082ff203cad83a7d50478112b2089743f8fea43
[6/8] nfsd: fix SETATTR updates for delegated timestamps
      commit: 90a615f4a2836bbaf91ac18c3157944655949368
[7/8] nfsd: fix timestamp updates in CB_GETATTR
      commit: ba17826b25e921ebca04fc54a59336dad68302ac
[8/8] nfsd: freeze c/mtime updates with outstanding WRITE_ATTRS delegation
      commit: 278138d4f85df580edde73ad4d89b8aae75d0e77

--
Chuck Lever


