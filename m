Return-Path: <linux-fsdevel+bounces-15700-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C36BF892815
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 01:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 003D61C213CE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 00:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2736C10E9;
	Sat, 30 Mar 2024 00:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="en1YCBU4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F22F197;
	Sat, 30 Mar 2024 00:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711758640; cv=none; b=eCkM9dSIO01i5ue0z7/nIiT4L0Re1rHG91MRuIjlDbFtTHhiJjDBv5qftDS0zgWBud1j79hSXG7ImuRBCtsktpKTQTW1SqAm5oE4kTuImiXqKsa/cFwYj9xxX4jn5Cz9sHh/iXRWS3d4lRkLfzW7w9wK7ioJ1vV0GiRmV+XGiqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711758640; c=relaxed/simple;
	bh=7p58Ikn1RnxCwrNeyODk7IUGRxD+QKdEb8CrXUtmru4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Q8GQ0r1OXHp9BzA8FwuPWgj2Ww+Q32dyRslvUa5LluAF0idxoO30ygaOVZFZMfqGaX6/LQjudXfH7MfcO/IWYgjmL0LvofLX2tjkkVqM3rFNAZIDctNUxhNo/AH+6KthgUuqjyW57+MawWZgZtOCjtUSKtmTUCZ3p7ksUVH+IW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=en1YCBU4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3728C433F1;
	Sat, 30 Mar 2024 00:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711758640;
	bh=7p58Ikn1RnxCwrNeyODk7IUGRxD+QKdEb8CrXUtmru4=;
	h=Date:From:To:Cc:Subject:From;
	b=en1YCBU4yH5u4J4c2sPtzYFoynEPtgUWT9+XIN0bM0yY9obq3pxO+ij+7gq9oV1WT
	 AjYKWSxAekJAH4A0MD8x8/+U2Sn6SN8lXPtwkOWwFnWFvGfZDtHmLNfKlvUSEm+bFb
	 VJR+UpZwjqKxGJy0TMs3sifZ9rAqKmxVztdLhewvdJEJfm0Ou/AmUFkz5cmUT6AZBC
	 aXlqE5gWk+Y2pq1tqU/EE2VCBXkJcsbJ4LWuN49VqJidBnNA2fcL8P3iRlGBLiTyZB
	 c22FzYY08BSsJrwnarHF2WWgLU9Gpj18c7Ib1bxB//BYB5V3Yk8fFLSuTg4B7g0hqc
	 bn8sjh4d2LQSg==
Date: Fri, 29 Mar 2024 17:30:39 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org
Cc: linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org
Subject: [PATCHBOMB v5.5] fs-verity support for XFS
Message-ID: <20240330003039.GT6390@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi everyone,

I've rebased this atop 6.9-rc1 and cleaned up a lot of the grunginess in
the v5.3 patchset.  This has basically the same features as last time,
but it's better integrated with the new xattr helper functions that hch
and I have been working on to get the parent pointers series landed.

So.  Time for a new RFC.  Eric, can you look at the fs/verity/ changes
and let us know what you think?

Full versions are here:
https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=fsverity
https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfsprogs-dev.git/log/?h=fsverity

--D


