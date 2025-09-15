Return-Path: <linux-fsdevel+bounces-61334-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4FDB579B9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 14:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 019727A8682
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 12:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328D12FE56D;
	Mon, 15 Sep 2025 12:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KycqyqOB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922A71F4169
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 12:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757937762; cv=none; b=d3FjN8K8ln1ueoDAd0UwqoLfgPF/qpLHLe/J7Y+fm5K67PYzki0x0wLERhE5Zh0bL0IVjI/quFsE7JhCNblTdBgYmj1TGxV7tSqrVmQsDrI/CSoktYXB/gTo7+vgOLrH7U9lgaC0hAAmoXUjEO9LMvNXRMyPTbobDBy4f22RyjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757937762; c=relaxed/simple;
	bh=CJkyunj8+KXWwJy9lVCya73o2+0Xyj8w7Qo+otoZRio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mNu85O+NrQS0omgZUjfkCdlaYfNozuY620xS4zCNkTq5uCL7mRJU4yT25V1bVOwQDCXI131LCFG11xm93ulsHW9RNu9x2hsiuWbMpOo6WupJ7k70+5ENFZG3pB3TympxmyvT/TcZ1H81Khss7jZNUeVPOX6ufgaTZvZgJqBYb5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KycqyqOB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E56FC4CEFF;
	Mon, 15 Sep 2025 12:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757937762;
	bh=CJkyunj8+KXWwJy9lVCya73o2+0Xyj8w7Qo+otoZRio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KycqyqOBBVTBk5sFsvFfb3l+nNnqmyJQm4xkXbpBO4brMFDTZnZ3oKF2ORRiCvbvh
	 +pJYGyUIOnlXaPheN1lZrdJ869yT0YRDptJnqi3Kgs5Hvy+NiDYeWwQIpaEgVszK1T
	 qt6MaLzQdaOvE+3Te4Swfaa/EEtXuqman7uFumPonYYx++zTIXeHUHg4yi6Bz1L+Bm
	 DI9f4ggSb4VHdHbbW6jJBiIogYtcJWiKpY1YMcVSQQz1bfcO0JyDABdibW5UrbN6Cj
	 AegdPttwaoQeLQ7UMcTLfgtMV77sNhsfnTrWxvlAa5RwHbO8wdR+QrNORQ4ZryMzPs
	 Bt96n4QY/gbqw==
Date: Mon, 15 Sep 2025 14:02:37 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org, amir73il@gmail.com, chuck.lever@oracle.com, 
	linkinjeon@kernel.org, john@apparmor.net
Subject: Re: [PATCH 07/21] rqst_exp_get_by_name(): constify path argument
Message-ID: <20250915-herhalten-leisten-ac34a9c7fecf@brauner>
References: <20250906090738.GA31600@ZenIV>
 <20250906091137.95554-1-viro@zeniv.linux.org.uk>
 <20250906091137.95554-7-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250906091137.95554-7-viro@zeniv.linux.org.uk>

On Sat, Sep 06, 2025 at 10:11:23AM +0100, Al Viro wrote:
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

