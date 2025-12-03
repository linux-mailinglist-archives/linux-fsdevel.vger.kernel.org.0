Return-Path: <linux-fsdevel+bounces-70548-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0889C9EA60
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 11:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 710F63A2124
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 10:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2C92E7657;
	Wed,  3 Dec 2025 10:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJoNkUiV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3B82853F1;
	Wed,  3 Dec 2025 10:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764756680; cv=none; b=FwejBCQ8jo9p0xc3lvwkssB2qAdRp+KvFF9zRCqdYM78SlP7PutaEebVTpti1uQpv/xmvHOk9CjT9aFOQjaso7y/GGkSOxx5M6yhVn4WERykEqW5KcDKh1ltW4CDcnpClB40wj0tczaOaqRXSrPjdiOYmZGChsWpT3t//WSUm4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764756680; c=relaxed/simple;
	bh=dw4TiZn8xxcrO2mUbONBSyQ7Uq01fFPlIO8nwtYEWGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oPBsOjD1wMy/KbjQn1Zr3CvfQae1zpiZ7dCBHKqvsv2Gb3LzPv6CuIgeg5/ZJZ3S9HCknn32uVNJvlzZ0V7cwFOhDhLA4TmQ3wWNqtvUxt+9XWHe+a+cyOVmEydlSFWCsGHP9ifR9wBHF9ApLcrkvbkhN1DXSl8Yqdyzk7znZzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJoNkUiV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C6E8C4CEFB;
	Wed,  3 Dec 2025 10:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764756679;
	bh=dw4TiZn8xxcrO2mUbONBSyQ7Uq01fFPlIO8nwtYEWGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YJoNkUiV7BJdPVfWDjdXEyTo290QuUwRS1gps4omZ9teErV8nllpfPyWLd7CwhMxM
	 tqV0vjM5QA7iRY8XZ2NnYc3nppdwzSo8yTjSZm/R4lrJP0IqPgDg4wtU/fP60spJ6V
	 qsnWL9CwzxYgObRwZcJfHF2MBTswjLfPGdbkzZ+FiCpreSLp78sr3TIX6Zj01U/74R
	 3F6gzVFdpW8QNOhf9OW8A1+E2iweDkbdv9UDFezbBPCXAAa6FCSA8Sq8AHV+aPzY8f
	 l0ekK/ZYZ7G3TubuLdavtHegDjQFYKr7JJSQmrKgceYLeu/yEKxsuGWESVw2i386Qu
	 G+tT5bMqAahSg==
From: Christian Brauner <brauner@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Linux PM <linux-pm@vger.kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v1] fs: PM: Fix reverse check in filesystems_freeze_callback()
Date: Wed,  3 Dec 2025 11:10:32 +0100
Message-ID: <20251203-harmonie-wirft-7c23dab0f888@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <12788397.O9o76ZdvQC@rafael.j.wysocki>
References: <12788397.O9o76ZdvQC@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1317; i=brauner@kernel.org; h=from:subject:message-id; bh=I9rQxRBS7UdWhIBo6tS1PDm3YufWgZ4UlioSglS5ZpM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQa8Kyp0GuW8IjVfLnKq/pIguSP7deC7+ypnp/q6WKh9 ZqX7WNRRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwESm7GD4H+j6UmHe35aOT4kf K7h2HRMX9nvXknm5NMWVt3vrpTim4wz/3TJmCs9awBJ3ZW/p23wRxcCzk2yPh858aPTv+9re90c 3cQMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 02 Dec 2025 19:27:29 +0100, Rafael J. Wysocki wrote:
> The freeze_all_ptr check in filesystems_freeze_callback() introduced by
> commit a3f8f8662771 ("power: always freeze efivarfs") is reverse which
> quite confusingly causes all file systems to be frozen when
> filesystem_freeze_enabled is false.
> 
> On my systems it causes the WARN_ON_ONCE() in __set_task_frozen() to
> trigger, most likely due to an attempt to freeze a file system that is
> not ready for that.
> 
> [...]

Ah, thanks for catching that.

---

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

[1/1] fs: PM: Fix reverse check in filesystems_freeze_callback()
      https://git.kernel.org/vfs/vfs/c/222047f68e85

