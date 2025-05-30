Return-Path: <linux-fsdevel+bounces-50142-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5983AC8800
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 07:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18B883B13FB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 05:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14F51DE881;
	Fri, 30 May 2025 05:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fDJp1jkV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016BB23A9;
	Fri, 30 May 2025 05:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748583115; cv=none; b=IRPnDB57f057m5X2Wj1nPXe1Pm0tsbkQZ5mKvm87fXdTDBE0G8jluoLedCHECucvKWj6uwfttnMi6R4Pkzf8jOQ/24tyo8toRRI4UWaLc9yGfL9iAE07N3Z/qGRreJFL6AwhBw3CUNcRKIy5o2Av4cOV0my1b6M56UNLWnX5CVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748583115; c=relaxed/simple;
	bh=djAHV4ZcorKvepAx5cvLMQPKw2wbXB1abMOASLXT0P8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AknIjU2H70m8LcfDuBx0EkpD/Z9ZqFHXL3OV/d818u6KB1SpFD05toyLfseFXSWdkb5eSmjdxANecJeMN9KWgnklbcoYVrOUmI6nAYUKxlV4tTeMuxcfi1EHSwYCpNLf6DVIbIDaeES4quiIKZlvRUM7WXKrSLn82i7hZ/p9LHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fDJp1jkV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7A4DC4CEE9;
	Fri, 30 May 2025 05:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748583114;
	bh=djAHV4ZcorKvepAx5cvLMQPKw2wbXB1abMOASLXT0P8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fDJp1jkVGR5On6urVTO15t6+aWD8cTaGrn9KYy2qX6PbUSbYsBqPf1bGH5uWOQ7aN
	 SSikR6xaeyrPlmiWw8WAjqZbkqfXxUADl9iT6pTtdZI4quDX1SV4Au0y4wgS7egLji
	 SVXkfncyCA45Ycn0Q9YGHkEiPXRjRR1bVnQLkQFo4XuJFSAsYrChUkOzGN3Kg5UI/h
	 S53I0Zjx0kC1hLmv8ziIEqmy6Ilh7jAXrnW/e5e5lRrzdZZfxeU6oZRCi1m7bnI6zB
	 oVqFwV8AdmaixRKmKcAXVSpQmaonh0FcAD5UgKax/YafhZyAt/1ETGT7jRna+Ggj7Y
	 qd0gn2/WwFXYA==
Date: Fri, 30 May 2025 07:31:50 +0200
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Zorro Lang <zlang@redhat.com>, linux-fsdevel@vger.kernel.org, 
	fstests@vger.kernel.org, Yang Xu <xuyang2018.jy@fujitsu.com>, 
	Anthony Iliopoulos <ailiop@suse.com>, David Disseldorp <ddiss@suse.de>
Subject: Re: [PATCH] generic: remove incorrect _require_idmapped_mounts checks
Message-ID: <20250530-deklamieren-ehrung-1895eefd99f1@brauner>
References: <20250526175437.1528310-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250526175437.1528310-1-amir73il@gmail.com>

On Mon, May 26, 2025 at 07:54:37PM +0200, Amir Goldstein wrote:
> commit f5661920 ("generic: add missed _require_idmapped_mounts check")
> wrongly adds _require_idmapped_mounts to tests that do not require
> idmapped mounts support.
> 
> The added _require_idmapped_mounts in test generic/633 goes against
> commit d8dee122 ("idmapped-mounts: always run generic vfs tests")
> that intentionally removed this requirement from the generic tests.
> 
> The added _require_idmapped_mounts in tests generic/69{6,7} causes
> those tests not to run with overlayfs, which does not support idmapped
> mounts. However, those tests are regression tests to kernel commit
> 1639a49ccdce ("fs: move S_ISGID stripping into the vfs_*() helpers")
> which is documented as also solving a correction issue with overlayfs,
> so removing this test converage is very much undesired.
> 
> Remove the incorrectly added _require_idmapped_mounts checks.
> Also fix the log in _require_idmapped_mounts to say that
> "idmapped mounts not support by $FSTYP", which is what the helper
> checks instead of "vfstests not support by $FSTYP" which is incorrect.
> 
> Cc: Yang Xu <xuyang2018.jy@fujitsu.com>
> Cc: Anthony Iliopoulos <ailiop@suse.com>
> Cc: David Disseldorp <ddiss@suse.de>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---

Seems correct to me:

Reviewed-by: Christian Brauner <brauner@kernel.org>

