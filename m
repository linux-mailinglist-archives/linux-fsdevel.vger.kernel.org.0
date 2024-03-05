Return-Path: <linux-fsdevel+bounces-13610-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45591871D2F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 12:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A0791C21F86
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 11:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E415490D;
	Tue,  5 Mar 2024 11:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kg099sgr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8538710A1B
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Mar 2024 11:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709637353; cv=none; b=hsEKKdva0JOmZjMgvVpJEkpNd8nXLCrUR6ZjjkLekF6ixmZ4IuoqUyNmT/RY86exgv7p+poGucqrQl6+wxOlC98OlbG3H6XvYAFroxqWp6bzznIAUGuNxi9315zfTyB/sOyZ7GMAhEPAKbSyZSh0IwElIHX+rhwjLpZjGcT1ARE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709637353; c=relaxed/simple;
	bh=a8NhojM4xPbeewQG/DK7rze+Q6TFD6PRKp1fcAGVJmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wh12JqS6Cl4qwThMH9EIZGgBVPpjiEeOvYQ7Zf0P+8kBiiOphl5zYLT0GXrdDNlpWqNDghvNhk1N6+H1LBa3Pb4jzliRLcFNn6QuY4nSE+suJl2xBBIlnGEb5e1327j9f/byi5ah26qOPnAn7/4Fh7Pw6JtUP9ReD8ZH/an6BAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kg099sgr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C977FC433C7;
	Tue,  5 Mar 2024 11:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709637353;
	bh=a8NhojM4xPbeewQG/DK7rze+Q6TFD6PRKp1fcAGVJmg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kg099sgrOvwAXv/UIwYkzncQOYAPzFXGmscPs+5FZNxBBpM2dHyMX7PY5WuQbXzqq
	 MvsJNifcjbKKrYC7sT/TZNIZN28ckaUrsga6pAz9OvkwkulRSbzKjtjLoyK65lPIXs
	 mUGtVvM0aP2XMz2MmHzx96rgbL5eVwsd3NdfOo7uLqP82qFQcOj5g/Bmc7PURbqNR3
	 bWcjintbqymTlY7NznnIlxLYaoAeK6ycO2YXsaVO4SZsis6k37nmEj2p9rxkdI1s+l
	 YS4eAmxqoYN5ZodNjfh0MNTIYqZcxz4vuRVHLWHgREWlyHPgrL1TW2YGeziNSM+mKh
	 nSIwMtpy+GgMw==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	Bill O'Donnell <bodonnel@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	sandeen@redhat.com
Subject: Re: [PATCH v3] efs: convert efs to use the new mount api
Date: Tue,  5 Mar 2024 12:15:43 +0100
Message-ID: <20240305-jobangebote-fettgehalt-e729d2d59e68@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240304161526.909415-1-bodonnel@redhat.com>
References: <20240304161526.909415-1-bodonnel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=891; i=brauner@kernel.org; h=from:subject:message-id; bh=a8NhojM4xPbeewQG/DK7rze+Q6TFD6PRKp1fcAGVJmg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ++/d4YoFeglm6soed12qbyQcf7L05k31S6kSNl6L67 F23YrpNO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACaiI8bw33OnVdzztixure6l rl0v7l+8vjnRbvPkpXHOHjFCPtsehjH8LztwobGGI2VPR7V9vk/gCwbthxe/OjjvnvvbJdU+tO4 kLwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 04 Mar 2024 10:03:06 -0600, Bill O'Donnell wrote:
> Convert the efs filesystem to use the new mount API.
> 
> 

Applied to the vfs.mount.api branch of the vfs/vfs.git tree.
Patches in the vfs.mount.api branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.mount.api

[1/1] efs: convert efs to use the new mount api
      https://git.kernel.org/vfs/vfs/c/d5b1a5042b4a

