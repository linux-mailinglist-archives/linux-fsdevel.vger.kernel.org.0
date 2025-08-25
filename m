Return-Path: <linux-fsdevel+bounces-59047-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DC5B3402F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 14:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3670D1A841EB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 12:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF5C2701B1;
	Mon, 25 Aug 2025 12:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AUS+yMeP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DA626FA60
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 12:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756126627; cv=none; b=DMA4uuxLryf9tSWRxARYHK5cL+QANIoXXcbzlDit/PdV08uIVTZLvxMBVUs6/IN+tLuF5jpR7eos2MHEDEMDRcLtNMphOM7ro1Rg+VFEbefquek7dv9dp+M7Kinsr4kKcxtFtULQmoej+AeV+3oVlTsXaDpLBaulJJHm4qrBaUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756126627; c=relaxed/simple;
	bh=9Hpa8Gc5YCGSiNiO0qleigF/6MO9//wU6j/Fhonl2Ak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pKfdiAF/STNgOXLoJ0IaqP+Tdle26AxFV8qgKFeCUok6uryVmasNj1Olr6ZJxN2icJpyfePuhlBgSdMm4kbQ+zKOiXMuMw11Fw/adqYUr5gMBMrbv4PxIkDcPp94jSAgfIytDP8ZjR786aem2fsNN2XEuEZn+H4eUZQO6pF3Jlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AUS+yMeP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABEF7C4CEED;
	Mon, 25 Aug 2025 12:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756126626;
	bh=9Hpa8Gc5YCGSiNiO0qleigF/6MO9//wU6j/Fhonl2Ak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AUS+yMeP0lB7PJMeucXx/hembmrVaeogUjH1SXNTl82Da5wYAiUC1tg4ruEpaM2z2
	 0TFlOZcHsvhW8P2lg2CnVLlX8GzX7hHqDfrMfefeZ7CfxkgjqIGht5GtyKTBGmKyV1
	 Gb6pNPogcjzYqTJtCzM3GfNFphMhvcMUhVY+yogyTYW0+WF8fEZMSanwL0wedkKAM0
	 4OWscQvtkH5ahqP4gRMCcaebRpSjM6X2Ml371wm7nxgUA0Z0ohYmJ+2XWNTmIrAJWN
	 5LwFo5TklecQ3GTGq64ULQHjTJoBxunhz0HyWCVwOSgdjNcHYmY1OgnYLbTomXlnAd
	 zeRzsp8AZ3iVw==
Date: Mon, 25 Aug 2025 14:57:03 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 16/52] current_chrooted(): don't bother with
 follow_down_one()
Message-ID: <20250825-eisbahn-nachkam-768f2b554346@brauner>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
 <20250825044355.1541941-16-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250825044355.1541941-16-viro@zeniv.linux.org.uk>

On Mon, Aug 25, 2025 at 05:43:19AM +0100, Al Viro wrote:
> All we need here is to follow ->overmount on root mount of namespace...
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

