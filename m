Return-Path: <linux-fsdevel+bounces-32250-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B299A2B8A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 19:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAD0D1F222D0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 17:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962F41DFE16;
	Thu, 17 Oct 2024 17:58:19 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295271DF26E;
	Thu, 17 Oct 2024 17:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729187899; cv=none; b=GVCDLbi8PuqtQUFIHvqzT6gBx0lRg/JB8jRQWeaoukGVUBIfBN7M+omV+sPlSqfuNgENUC71ZjgobiHK+w7FD5AgZwtmvvb055FeFCClBavLESHesMIacIOKdOnPQ8pKVaCJ43VqwMpOeWIamQdZEqVUM8pN4C3Zis3E7UUZTGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729187899; c=relaxed/simple;
	bh=hsjbwXSxk9ifemsdlZfLhG0q3eoDs3K5n+hnWuAlkkQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CZaG5NilicBoA9TEI7OPqS9wsmwcuGvJyPI4WWOhVATj1SGNoWpGXAFggadItBlmSnHeZD1fFyu+oLDVFrmdjG0S4uQr35nNE6tFxb9Gvkh941ZRR5lWzRPrOGen+HrQRYLh7fdICmclA3XshS7EtT2ay5DSqEmUfrGUg8EhZws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D20B8C4CEC3;
	Thu, 17 Oct 2024 17:58:15 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <kees@kernel.org>,
	Will Deacon <will@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Mark Brown <broonie@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Yury Khrustalev <yury.khrustalev@arm.com>,
	Wilco Dijkstra <wilco.dijkstra@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH RFC v2 0/2] arm64: Add infrastructure for use of AT_HWCAP3
Date: Thu, 17 Oct 2024 18:58:13 +0100
Message-Id: <172918775909.3620066.7512436802272338661.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241004-arm64-elf-hwcap3-v2-0-799d1daad8b0@kernel.org>
References: <20241004-arm64-elf-hwcap3-v2-0-799d1daad8b0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 04 Oct 2024 21:26:28 +0100, Mark Brown wrote:
> Since arm64 has now used all of AT_HWCAP2 it needs to either start using
> AT_HWCAP3 (which was recently added for PowerPC) or start allocating
> bits 32..61 of AT_HWCAP first.  Those are documented in elf_hwcaps.rst
> as unused and in uapi/asm/hwcap.h as unallocated for potential use by
> libc, glibc does currently use bits 62 and 63.  This series has the code
> for enabling AT_HWCAP3 as a reference.
> 
> [...]

Applied to arm64 (for-next/hwcap3), thanks! I decided to queue this now
as we seem to burn through about 15 hwcaps at a time with features like
dpISA. It gives libcs out there a bit of time to wire it up.

[1/2] binfmt_elf: Wire up AT_HWCAP3 at AT_HWCAP4
      https://git.kernel.org/arm64/c/4e6e8c2b757f
[2/2] arm64: Support AT_HWCAP3
      https://git.kernel.org/arm64/c/ddadbcdaaed5

-- 
Catalin


