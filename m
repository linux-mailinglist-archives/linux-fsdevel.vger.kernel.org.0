Return-Path: <linux-fsdevel+bounces-23237-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7674928CE0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 19:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7F021C240BE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 17:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F7C16EB6B;
	Fri,  5 Jul 2024 17:04:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04AEB16EB47
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jul 2024 17:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720199053; cv=none; b=pOWOGYuq3fYgao5x6dm4PJKrVUybtHWeJm0Qf7rG6US522+1ylvaVIhvZ/cbzPJhXP/nwtuak8m3MEXLQQSe+ZPOSLUfcIGhgRd1/bqLl1smI3EmwmROG7oMyYnmjOU/Ex69/++a2A41RSNzaUN5xL3xpB/TV/YtsI6KbfIGvHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720199053; c=relaxed/simple;
	bh=h+ZaTCZoFoPl0HTBTG781gsrf4sqdPHQw8AEAquEL2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=klMkNj0p9eeHPun/i1MDiiedtF4dasQGauSf79SGhf7xxvEHoy/oWaRCxtJ3CGNXz4RNwsFh+HdEdRpXFSGFaElrofGWZoqTXrRLZwFEEWSJRyVonCVyCc3jOzUxXhF2zmswUERGbs0jEKhrehwkJuNQ6qpdnl159sEjJjwFxfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C7DF1477;
	Fri,  5 Jul 2024 10:04:36 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C9F03F762;
	Fri,  5 Jul 2024 10:04:08 -0700 (PDT)
Date: Fri, 5 Jul 2024 18:04:06 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Joey Gouly <joey.gouly@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
	aneesh.kumar@kernel.org, aneesh.kumar@linux.ibm.com, bp@alien8.de,
	broonie@kernel.org, christophe.leroy@csgroup.eu,
	dave.hansen@linux.intel.com, hpa@zytor.com,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, maz@kernel.org, mingo@redhat.com,
	mpe@ellerman.id.au, naveen.n.rao@linux.ibm.com, npiggin@gmail.com,
	oliver.upton@linux.dev, shuah@kernel.org, szabolcs.nagy@arm.com,
	tglx@linutronix.de, will@kernel.org, x86@kernel.org,
	kvmarm@lists.linux.dev
Subject: Re: [PATCH v4 18/29] arm64: add POE signal support
Message-ID: <ZognhvuDmKyXk59Q@arm.com>
References: <20240503130147.1154804-1-joey.gouly@arm.com>
 <20240503130147.1154804-19-joey.gouly@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503130147.1154804-19-joey.gouly@arm.com>

On Fri, May 03, 2024 at 02:01:36PM +0100, Joey Gouly wrote:
> Add PKEY support to signals, by saving and restoring POR_EL0 from the stackframe.
> 
> Signed-off-by: Joey Gouly <joey.gouly@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Acked-by: Szabolcs Nagy <szabolcs.nagy@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

