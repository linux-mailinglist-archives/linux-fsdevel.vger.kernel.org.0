Return-Path: <linux-fsdevel+bounces-15864-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C330B8950B8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 12:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AD591C230E1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 10:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90882605C6;
	Tue,  2 Apr 2024 10:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s3pKIoou"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C337B4776F;
	Tue,  2 Apr 2024 10:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712054938; cv=none; b=eeh0HHKLZZQ17dPoeQpQszzUucChVaAMK4aHUj1WtnlbI/V6n9bxLD5s5bEOS5fCjuXkse7+jW79YbDArYe2xq+hSJFmRiKkQdL4tzWU9cfR8hIr5ib+wcDkmQjWfx9ItRINQ2B+2Io+kGFh/imMa3fdgyXq57xOYffIqQ1kGAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712054938; c=relaxed/simple;
	bh=0o849oaUCS/1to/11XOBsrrHkZ6HnWiwjHhXX1XawsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GDwHJ7XqCP8SICjGWIrNkHKwcgYY8likZYkKfgvTtsD6y9dBFOW0/r+ZmavJnj+muzbMcIM32zhkHSsnM8kiy20Yq4v78EncUpGOFz4gUfj4XHqA8nKON5pj+KCdRBlddNKlC1pE9hTmT3NQnArXv4vMNftcjaxHgyIM4r0CdPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s3pKIoou; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B1F0C433C7;
	Tue,  2 Apr 2024 10:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712054937;
	bh=0o849oaUCS/1to/11XOBsrrHkZ6HnWiwjHhXX1XawsY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s3pKIoouIXwXD4lmoPfSlZSDJZnmmtOa1RUJNiFaCXHRyfUJWBCybV99rJXm7gV8y
	 T7Fjk4lyWWWjVz2Gcq+2fNAoTMJnNX/2F2ImxDn9loGZaAaUiIrrOGUofL9i7svfdk
	 XAdlme0aallBdCc4GUuODtk5GZtLEzaPI3vng58HDE2HBNIlc4c6Bq3f6hazpMeaEx
	 Xgj2CoKMoSLbndyirg0YejiKL0ZEAGFUReEzmqbp1wYq+3/s1f3ZCIqrcblHvsWe1U
	 u/Fu8N++N778FF1N0TJzW8msw8oIsVzOMv/4cCc32kKXWGv+qqR4NqN76QQvHhbwO4
	 xB4Ir5cVjt1jw==
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Steve French <smfrench@gmail.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	netfs@lists.linux.dev,
	linux-cachefs@redhat.com,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Gao Xiang <xiang@kernel.org>
Subject: Re: [PATCH 00/26] netfs, afs, 9p, cifs: Rework netfs to use ->writepages() to copy to cache
Date: Tue,  2 Apr 2024 12:48:39 +0200
Message-ID: <20240402-angezapft-geltung-eedf20c747b6@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240328163424.2781320-1-dhowells@redhat.com>
References: <20240328163424.2781320-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1071; i=brauner@kernel.org; h=from:subject:message-id; bh=0o849oaUCS/1to/11XOBsrrHkZ6HnWiwjHhXX1XawsY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRxP+pcP3O9duihh7ft/O8vis97k3zynpVeQfGsW8E7b q56dXSyVUcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEuNwYGTasXTr9sKjU3hPX Ei5oGyxbtVov5EPVyh7dA8dse88LRt5l+M2u8X9Xtd2ZVVnejNGvL9xPN9z30XT+j+sXvgWrTvz jocYCAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 28 Mar 2024 16:33:52 +0000, David Howells wrote:
> The primary purpose of these patches is to rework the netfslib writeback
> implementation such that pages read from the cache are written to the cache
> through ->writepages(), thereby allowing the fscache page flag to be
> retired.
> 
> The reworking also:
> 
> [...]

Pulled from netfs-writeback which contains the minor fixes pointed out.

---

Applied to the vfs.netfs branch of the vfs/vfs.git tree.
Patches in the vfs.netfs branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.netfs

