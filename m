Return-Path: <linux-fsdevel+bounces-32194-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4819A23DB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 15:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1312528352B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 13:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9AF1DE2BF;
	Thu, 17 Oct 2024 13:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rsloRRa+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA931DDC02;
	Thu, 17 Oct 2024 13:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729171951; cv=none; b=uvh98HK6+XwVTwyumTYqOrTIauicNl0juBesKMIOOx3SGoYlHcjLMiS78n/rwO2aBsnRfvPY9tKoxtUeg/Z69bxaCvSKA7Bj1PeJT1y2+4b9K6y+9p/WmTWDtIUOCwKb8jN85YtU+ySlPV7VRWecTDz4QFDjxMNMG377xn9LmyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729171951; c=relaxed/simple;
	bh=ldOdKIHpLBswL6IKGggg+kE70tHTp89hi9GupjMUZrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q7svPGJJnEPzt2onYDjouPVfi3Gn2xO/pG4/RP85BJu4gWCR15ltIHWKmY8bStBJ+fcGN38op8l+aZQ5x2rGnBDq0/L19XDmTvAC6pu8RJCGv9OFDDscDWWfRinyqOmhqg7QztlwgFZczlAHNrcTPHHroyhAWWJ//SP+5EE78O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rsloRRa+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 487E2C4CED0;
	Thu, 17 Oct 2024 13:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729171950;
	bh=ldOdKIHpLBswL6IKGggg+kE70tHTp89hi9GupjMUZrs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rsloRRa+5RQAr6PG5chQ6cpXlq//myllx7V2nA0PB6hLq+zFH7+VCDeB3DNVQW3ee
	 B43gSAohiBvwzGaCETNjwC4QerJv/LBXaTHtSgkMr1H6tNikf0KqmK5S3Ypw7s67rI
	 yZ8rvsuledxdB5BUR8YHVLRlG0lfOau5Cc00eaSlarKRMkIsGI6S6ek4PWnBfvD/+s
	 qw75mf48VW2T5lkMFTzzkIUBJ4bmljLxUG9EwmxWHFabNIUeSJjUhP5eF+fZ5UthYl
	 QQfzVBoQvsuHXKJVsnPPRjbFvYns5bB8A0JNiXTJ+5aST+NKGszGCPh9xC2CotsS3T
	 QzM+Eht76HeyA==
From: Christian Brauner <brauner@kernel.org>
To: Alessandro Zanni <alessandro.zanni87@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	anupnewsmail@gmail.com,
	alessandrozanni.dev@gmail.com,
	syzbot+6c55f725d1bdc8c52058@syzkaller.appspotmail.com,
	viro@zeniv.linux.org.uk,
	jack@suse.cz
Subject: Re: [PATCH v2] fs: Fix uninitialized value issue in from_kuid and from_kgid
Date: Thu, 17 Oct 2024 15:32:16 +0200
Message-ID: <20241017-flausen-verwoben-b07eb6d72070@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241017120553.55331-1-alessandro.zanni87@gmail.com>
References: <20241017120553.55331-1-alessandro.zanni87@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1152; i=brauner@kernel.org; h=from:subject:message-id; bh=ldOdKIHpLBswL6IKGggg+kE70tHTp89hi9GupjMUZrs=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQLCj6XajStNRbda/h48ZRDj6UPrjm77I7t3fxbhetcS 2a8nmHY2FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRE9aMDNPMLz0tlp21eo65 jfzMwlZX7Zk9vDV9Ky7mhR/MVth4exHD/0j9R6KrnMsv11+dvmDx3YLPXHcTrI5N3Jr99i3zhqk b1ZgA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 17 Oct 2024 14:05:51 +0200, Alessandro Zanni wrote:
> ocfs2_setattr() uses attr->ia_mode, attr->ia_uid and attr->ia_gid in
> a trace point even though ATTR_MODE, ATTR_UID and ATTR_GID aren't set.
> 
> Initialize all fields of newattrs to avoid uninitialized variables, by
> checking if ATTR_MODE, ATTR_UID, ATTR_GID are initialized, otherwise 0.
> 
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

[1/1] fs: Fix uninitialized value issue in from_kuid and from_kgid
      https://git.kernel.org/vfs/vfs/c/eeb1277262f8

