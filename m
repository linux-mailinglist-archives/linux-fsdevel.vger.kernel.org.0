Return-Path: <linux-fsdevel+bounces-20826-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B3F8D8453
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 15:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0C32286216
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 13:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BF512E1DB;
	Mon,  3 Jun 2024 13:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WtjiVMAm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4E712DDBC;
	Mon,  3 Jun 2024 13:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717422486; cv=none; b=NaJeu5pmvyWyP6Q3mZFtGRfTPYRZmHh3D7S1hAnsZEY/FDLWTfc3IzG+cCEibkpE6Ws1nerbkBm5CdzRB4Q2AQQfamUOazKHRvJCIa2lSe1s9fSRHfwPPChA6LNxtgY8KsysgyZYVRywdSusj5QF/mUCEyFmAq22V2MbRVz6woY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717422486; c=relaxed/simple;
	bh=pNs6i46eu8WKhrahud/8KXnGovcuD9UWUC7h0pxtUng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WQaD8zT8/pPm0008v6Ngcu7xf5JYxOXZg2KKKrfpT3Ia4yfAeZa/7S4PNlv+Oi2zbUbe0f1RjL513tWTK779OnIKaGi3w/Wexgyo3BErqfS8bKqAv08NdcJ4SlAqEg8ktMWbJkpvM4kKviumxQaUm7y6z/Lo7egKv+yiiGnkTBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WtjiVMAm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 579D1C32781;
	Mon,  3 Jun 2024 13:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717422486;
	bh=pNs6i46eu8WKhrahud/8KXnGovcuD9UWUC7h0pxtUng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WtjiVMAmFBuw+20u783NITpEIiI1h2ZFWn8/d4wa1kqjyBOyg9uGp2by0PWjAXsdM
	 CVLP1I35lc3OqX2fv2ZLYG33VVokFu9Uips/F0Xljv9HYxdrLesaUmADIO4NPNpvDP
	 KfCUzu5JXBktw/GDIzlts5QuAma3yI+Kro7VhwQz+Ta24VD0OtU+eiCSOfOC+fKbmd
	 EFDBK5QGTyLG4SZR3w+w3hzdIRGDHar5ttieSt4f1GrDj0OiG42F/459ANNY/iws8F
	 XErUChJVODlaft6zzObHh+v3EvUaBVtKF4zMmArF6WGfIeQTnX3Yb1pfftQrP5IeuD
	 FgGW1wHVn+d9g==
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] vfs: replace WARN(down_read_trylock, ...) abuse with proper asserts
Date: Mon,  3 Jun 2024 15:47:56 +0200
Message-ID: <20240603-autark-vorgibt-f63b210cd4cf@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240602123720.775702-1-mjguzik@gmail.com>
References: <20240602123720.775702-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=902; i=brauner@kernel.org; h=from:subject:message-id; bh=pNs6i46eu8WKhrahud/8KXnGovcuD9UWUC7h0pxtUng=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTFnuxfszNJ40/10Q0qdT4LtNe8DljCccIs/8fNB39+K R/fbqyj0lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARnWeMDO+/7vz4Q7FzmczN 7ZOUlYrWJXH/S2vOnmt+zNLwzTPF7ccY/hkzW996a3CJwXvmle33j2leOagy1fGVxqu4CzPUAi5 tl2AEAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sun, 02 Jun 2024 14:37:19 +0200, Mateusz Guzik wrote:
> Note the macro used here works regardless of LOCKDEP.
> 
> 

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/1] vfs: replace WARN(down_read_trylock, ...) abuse with proper asserts
      https://git.kernel.org/vfs/vfs/c/43bcd0a6aa46

