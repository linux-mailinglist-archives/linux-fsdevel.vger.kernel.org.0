Return-Path: <linux-fsdevel+bounces-9653-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7C68440D2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 14:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1C181F2BD58
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 13:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DC284A34;
	Wed, 31 Jan 2024 13:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+9eE4kx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5793C84A29;
	Wed, 31 Jan 2024 13:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706708362; cv=none; b=gVYTD0/HErrVUK69MDyQ9fEcH+O810NmvdGwNmjLHUiJOcptOIiDx1O1ARBb/9Tmex8tWdOaO6QddwEh87E4phSRqde9H/pevZ+FUvkFWVIx7wTiEKq0JrL9ZVs8DgH6DtLxx72/X+2puvx/wB69BXuENk1VNhQinNiqDgGCHlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706708362; c=relaxed/simple;
	bh=9Gbc5Q80vFOUp2fVirkYxzBggbmlX9X02znwd+/ytdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NHYHpi9vwgYLDUhgi7OVXQOfvhB//lFlkLgynibHoERbhOafohBm3h66tHcjC0dkTXowieKNSw6P5wk8iIrawUP1obvG2YW+GKNUnl1F+f/bkpSklMF9EuV8jzFMoAW14hQ07vn1uD3K9ASdV+o3gvYylABGuedzFgFJl3exJoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+9eE4kx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5C47C433C7;
	Wed, 31 Jan 2024 13:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706708362;
	bh=9Gbc5Q80vFOUp2fVirkYxzBggbmlX9X02znwd+/ytdQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W+9eE4kxm0PLUpNEmvmMkgNyp2h3dBygJVIRmJfzyeBpZGfulaPERHUo9hokomPxB
	 fhJwfKn+O6iN7XqJwvrYqIM2sQQjNOykieONHi9SNd953GCU7yN7e2xza4OQBTrWLa
	 1eDGA3R1958kQfLD2zKdMj4cecWa344KIV5/Fs/4rgCCa6i35bAHJVAt1Itl7UW7ft
	 i7jHWJrVjlJ80P1fVmfsH/KZy/X+t/Kdvh/7nanWY9g30ret+8zmhABK5CXWOe+zj8
	 IxITF2yWlCqp03piiHjgh6mznjrLKEvmtNDxWn93Dv0IRliGxCeHzRgz/sPkAIAsyW
	 VoXV5JVorqo8Q==
From: Christian Brauner <brauner@kernel.org>
To: Kunwu Chan <chentao@kylinos.cn>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	miklos@szeredi.hu,
	amir73il@gmail.com,
	viro@zeniv.linux.org.uk,
	jack@suse.cz
Subject: Re: [PATCH] fs: Use KMEM_CACHE instead of kmem_cache_create
Date: Wed, 31 Jan 2024 14:39:13 +0100
Message-ID: <20240131-kanufahren-lernmittel-ef0624c0aa47@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131070941.135178-1-chentao@kylinos.cn>
References: <20240131070941.135178-1-chentao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1033; i=brauner@kernel.org; h=from:subject:message-id; bh=9Gbc5Q80vFOUp2fVirkYxzBggbmlX9X02znwd+/ytdQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTu8m267XYrfcNPA+35X+fc0zgYdkFs9fzln3IeqnTdl T+XJ5OR1FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRBYYMf3jDTJaf37TjPa/m 6cD/ISmuni0C72QKktcwbpm+fvm0dhlGhmf9jFvrwxsTVwm5Gr9vv//R2Gj6bs30z99/5x1UqLl bxw0A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 31 Jan 2024 15:09:41 +0800, Kunwu Chan wrote:
> commit 0a31bd5f2bbb ("KMEM_CACHE(): simplify slab cache creation")
> introduces a new macro.
> Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
> to simplify the creation of SLAB caches.
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

[1/1] fs: Use KMEM_CACHE instead of kmem_cache_create
      https://git.kernel.org/vfs/vfs/c/6f351af0c85f

