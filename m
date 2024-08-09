Return-Path: <linux-fsdevel+bounces-25517-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 323E494CFE1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 14:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D90EF1F21FE9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 12:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E063019412C;
	Fri,  9 Aug 2024 12:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OATaGJNK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4123614D6EB;
	Fri,  9 Aug 2024 12:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723205629; cv=none; b=WARpzpc9ylK/12qDkxn6Az3SRp2qF2a6kwvRgFGuD4Kazk1kb6OOU5UaCzmOh2xyLjwQoHH9FC+Om39iyOGsgEl/XA3Dl9khIRv3x2OgGoFurtIBo4R/UXPUQkMDqZWwcyhjvYXY3Ul0+9Ec5l9zygKAJCZjH4ZU0Z5QtX04xIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723205629; c=relaxed/simple;
	bh=mecnKH6bxsPGPVSZQNsg9R4g6jkMdRkKKZhsPTFDgkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X1cMKp24LMTfCDiw9LamP6XkykmcoTTrGZVk20bQJ1V+ctxPUpUxRUvGS5CyAbBQ8UnD0HD51VuUqQDBrw3f3f70HTq+ULLRR2/973A0390upSWAZrM3LNyWdUGu7+P5yUBdvOH2M4TxMUtLhxxCgTBmFQQDYV9RsWs1QT1/FPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OATaGJNK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2472C32782;
	Fri,  9 Aug 2024 12:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723205628;
	bh=mecnKH6bxsPGPVSZQNsg9R4g6jkMdRkKKZhsPTFDgkU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OATaGJNKRG9fpMKPHNjzyYutGl/gX62jnVMSZThlvhFxjMYDtPPAfbtBC/N0Xp9yT
	 Rh6L7rmQ40NsbVn7tHsFc9ar/4mJ2oEoVKnZgdZ4gtLFek0Ss4geaAr5O+vpDx3Mie
	 K6ulhM2I/ZZs6JQVg9xmYs5I+P4W99/iuBB9LpmFe7YmUi26ULI/JZ23Wc2jPBaHpw
	 Cl5+gOmGDCk8S92knckiPm4xUF3/0LA0itg56z/mS2qrKJV+ZhkzVr+s+sQY6J1ntH
	 oZrDvoT2fyl34gtY5OGlePW2qcGcBKklB8/z2n+DRV2+9qy5Ip1hwUw7baG21jL5iS
	 7subFSEWeZhww==
Date: Fri, 9 Aug 2024 14:13:44 +0200
From: Christian Brauner <brauner@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	amir73il@gmail.com, linux-xfs@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-bcachefs@vger.kernel.org
Subject: Re: [PATCH v2 12/16] mm: don't allow huge faults for files with pre
 content watches
Message-ID: <20240809-begnadet-pfosten-55b337ce05fb@brauner>
References: <cover.1723144881.git.josef@toxicpanda.com>
 <8b4c1abeff52322da354a4df2881ec13b7493fdd.1723144881.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8b4c1abeff52322da354a4df2881ec13b7493fdd.1723144881.git.josef@toxicpanda.com>

On Thu, Aug 08, 2024 at 03:27:14PM GMT, Josef Bacik wrote:
> There's nothing stopping us from supporting this, we could simply pass
> the order into the helper and emit the proper length.  However currently
> there's no tests to validate this works properly, so disable it until
> there's a desire to support this along with the appropriate tests.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

