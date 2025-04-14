Return-Path: <linux-fsdevel+bounces-46387-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7A1A88569
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 16:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C2E216052D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 14:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899452853EB;
	Mon, 14 Apr 2025 14:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EkiX2XCx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CB22741C1;
	Mon, 14 Apr 2025 14:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744640312; cv=none; b=qnnki8CroEnhaiTQ1+k6MEiwiuQuJrKJCtbrEK3hpLg210QMTvKeciremYunLfxH4WKegNa/KKfV18nRdrnCSclsCTmtFTXMiHycsnDE5iM/9/jTnakN2zlDuGFGaN60TDowhYKSESncTByrZZ9V/rKEgMkMwikh3noFuhX6nBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744640312; c=relaxed/simple;
	bh=VPcoMSVgB0AjiXU8wQPbxq2oNVYTLJnn9DWzBVMO12o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=etEyM2T+YQlJU2MGSoRulHUDZJcJVMaG15No1k4CxPs2uHDi/fbg9kDVuvO+aKrBAf8H4Qypy9Wa2vQgaMMgGW0wdVzO/lFmD2/xA7NL66cOYtsbLl6Pm4tMsCzkq4617tMEeZ2ULWQDr/fMSMh4pLjo8X/DIgGMIjvK+wt+nCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EkiX2XCx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B987FC4CEE9;
	Mon, 14 Apr 2025 14:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744640312;
	bh=VPcoMSVgB0AjiXU8wQPbxq2oNVYTLJnn9DWzBVMO12o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EkiX2XCxozttRslkuaVsM53K4HHxPPap6FDnAXe/mgx2AnmxzQhRra7tfDGmUkYGa
	 IE3vOXfBxHNPILbwhlXD2O8TeaVkhy4FzuEvukIy5jljfuPWDL8ojPbGhy9huFpLjT
	 165g3wvmThS5JQ6wyYTrnsWMHXJdZYJgF7qarnuerewu0cJRsciATb1BqKfX2tTKPG
	 KGQdOdhDG3XoRaSxoc3t7/Qzz+m9ut2Y7cBg31315wHb4acx+Ph1GXIe9v+/3uWOg4
	 cdEqWycs8QscM6RSjSNddVAVBpsjMsFAMM8CQ9Ia0udcIvNW307RolXAETFI2uNX2i
	 7mIPCoY+RgTAA==
Date: Mon, 14 Apr 2025 16:18:27 +0200
From: Christian Brauner <brauner@kernel.org>
To: now4yreal <now4yreal@foxmail.com>, Jan Kara <jack@suse.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Kara <jack@suse.cz>, 
	Viro <viro@zeniv.linux.org.uk>, Bacik <josef@toxicpanda.com>, Stone <leocstone@gmail.com>, 
	Sandeen <sandeen@redhat.com>, Johnson <jeff.johnson@oss.qualcomm.com>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug Report] OOB-read BUG in HFS+ filesystem
Message-ID: <20250414-behielt-erholen-e0cd10a4f7af@brauner>
References: <tencent_B730B2241BE4152C9D6AA80789EEE1DEE30A@qq.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <tencent_B730B2241BE4152C9D6AA80789EEE1DEE30A@qq.com>

On Mon, Apr 14, 2025 at 09:45:25PM +0800, now4yreal wrote:
> Dear Linux Security Maintainers,
> I would like to report a OOB-read vulnerability in the HFS+ file
> system, which I discovered using our in-house developed kernel fuzzer,
> Symsyz.

Bug reports from non-official syzbot instances are generally not
accepted.

hfs and hfsplus are orphaned filesystems since at least 2014. Bug
reports for such filesystems won't receive much attention from the core
maintainers.

I'm very very close to putting them on the chopping block as they're
slowly turning into pointless burdens.

