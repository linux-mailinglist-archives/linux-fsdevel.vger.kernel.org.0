Return-Path: <linux-fsdevel+bounces-51274-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5DEAD510E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 12:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D3D63A7E93
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 10:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA63D270ECD;
	Wed, 11 Jun 2025 10:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vJclE1To"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A8127057D;
	Wed, 11 Jun 2025 10:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749636246; cv=none; b=FtRNFPRsI5W4gDxn0no/pcueuEf2PvV63sEOnz3F6RFwqA1mHuT9tCXQQ9HNUa3nD14DaMN3SWWP5RiMeYxfmFJGMTEW4L/bV3Uhbbi//ZfxO3/tjg5k3qel+VQy928G9Zy/yx1HkwP5LmqL8TGPLsBxfbLFjtyvGQsvSdha2yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749636246; c=relaxed/simple;
	bh=T1ppAz1VzmH29y9/d6Z6oorRiK8qdvAxomNpsVpA7tY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LyPyj20TaksDCBz1T4ITADG0hKM4EKkXHR0pjMveOV+wcKXDR/M0uZN94Qq4eqjz/bmqI6T5Q0cd/fPrF1uGUanCDvD+UlmgiO4eVGmFkioPZJPSc2S8Vgw59Wx0vVysc2MbChwaipYpK2HHlLmiptSPcaGbQgZ6NMTuFY5BlkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vJclE1To; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78D09C4CEEE;
	Wed, 11 Jun 2025 10:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749636245;
	bh=T1ppAz1VzmH29y9/d6Z6oorRiK8qdvAxomNpsVpA7tY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vJclE1Tok3zWmw469WgTJ5EfN7AFHXEMryPejVbjnnZNaiOSr7EoH6hpXn7+i6RmK
	 qgvgnPXbilI5n9p/ZyasBvgpz6QJ3moasqcwrb/ErkU9BP8nunnL8WR1BIgMIK2ce9
	 1oBQdITqAp07Ub5tWDyQ3vjl5SQeWukc4KdwWi5uEldxsyzGXw5Nexvfbcy+gVCMab
	 qERo1+l/2KjgQu4n4rCnS1f2aHiV8hr1U5J2alOAC9g/7G3LkPZ9SGuhRy3gCLnm3s
	 b5s4Q7W80x5EtTLfywawKOOktcD/jZM2lM00BiJnDzZFJC2RbfaidJxrZyp7CTz9ku
	 I6AOY5oQ2yh/A==
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	CIFS <linux-cifs@vger.kernel.org>,
	Bharath S M <bharathsm@microsoft.com>,
	Steve French <smfrench@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.com>
Subject: Re: [PATCH] VFS: change try_lookup_noperm() to skip revalidation
Date: Wed, 11 Jun 2025 12:03:53 +0200
Message-ID: <20250611-leisten-vokal-55db13cc534e@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <174951744454.608730.18354002683881684261@noble.neil.brown.name>
References: <174951744454.608730.18354002683881684261@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1354; i=brauner@kernel.org; h=from:subject:message-id; bh=T1ppAz1VzmH29y9/d6Z6oorRiK8qdvAxomNpsVpA7tY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR4hkwo6tjEvjbwxlf9mlOnrq59dEKKU6j3reh2q/66k 9ZlHR53OkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbiGcbwT9c71+gEu/T3hhyl SKYd7ef4fszk5fuzpXfJQsbGZN3TKxgZNtS0v3X6sqWQ+1EQ+8c8/ocrn2xQY3265+pjo7rz5gd t2QA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 10 Jun 2025 11:04:04 +1000, NeilBrown wrote:
> The recent change from using d_hash_and_lookup() to using
> try_lookup_noperm() inadvertently introduce a d_revalidate() call when
> the lookup was successful.  Steven French reports that this resulted in
> worse than halving of performance in some cases.
> 
> Prior to the offending patch the only caller of try_lookup_noperm() was
> autofs which does not need the d_revalidate().  So it is safe to remove
> the d_revalidate() call providing we stop using try_lookup_noperm() to
> implement lookup_noperm().
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

[1/1] VFS: change try_lookup_noperm() to skip revalidation
      https://git.kernel.org/vfs/vfs/c/ad5a0351064c

