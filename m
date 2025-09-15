Return-Path: <linux-fsdevel+bounces-61333-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B0CB579B7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 14:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7129B3B50D2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 12:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108573043AB;
	Mon, 15 Sep 2025 12:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XFqXFLTV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637C7301491
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 12:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757937742; cv=none; b=Bo+wH5pDbEsFT/uJVYQykkv134UuzK1l89OYbB5KUxkjfty261HNUqnt9XOKuJUDqi2fD0f++vgCSxtkFDT1JL57s3UtvCNjv923iGU7U8C0HtBEdI0UQDjffuGGIxJJe0hIxsnnNBCUwSJJHMr4uCO7mHd1dioLzWEdN/Ekk4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757937742; c=relaxed/simple;
	bh=AwwrecTdPxAHqZ5YXUSon13EY/WnKFx2zILgLyH32yA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ft523JTLFQbYu4vN8cI8mNabusO4JWe3jvcB8F1kXwzNO0Z3qqwvcKHi3a+amsAC8zEEfOTK3sokBrW2QZatUfBh6lyuFT9crGk5yOyOYueLSnb3gtjlhJ35q0dPlH2d7gi6iCYKv8toiDJ6zB0L40ilJsv1YEzd/B2cpkVL6nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XFqXFLTV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F026CC4CEF7;
	Mon, 15 Sep 2025 12:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757937741;
	bh=AwwrecTdPxAHqZ5YXUSon13EY/WnKFx2zILgLyH32yA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XFqXFLTVHWHeP0xABcx4Swvgto2RegMS144qQ473Uenm53jnpQvC1sCY7tSTyB7HW
	 CkYE9QkA3KYLojHqSAFuDeEdHSCVv70sjKjksD0vw2A70hVAgyAgMdYdARxmgirHRm
	 LhT7lu46w4/M/MRT3JQnLWhjAfjJVbPgxn18KnmYLsnvtHAo/3fSNUBD04SndtGWzp
	 dHnhQW2PVvz1K3Sqf8684alSwhP4ElPZvXLshssrguYyutIiqzMOFNqMA370Hb5oRA
	 mnZr3ctOVhtG42+f23mZPWJp7p0ahNl6IVJGX+tlDnptkBdiv+SCSkYvlYD/DthQtO
	 CO2NFcYRRXtsg==
Date: Mon, 15 Sep 2025 14:02:16 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org, amir73il@gmail.com, chuck.lever@oracle.com, 
	linkinjeon@kernel.org, john@apparmor.net
Subject: Re: [PATCH 06/21] nfs: constify path argument of __vfs_getattr()
Message-ID: <20250915-vorfreude-kompendium-3e84c47c9dcf@brauner>
References: <20250906090738.GA31600@ZenIV>
 <20250906091137.95554-1-viro@zeniv.linux.org.uk>
 <20250906091137.95554-6-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250906091137.95554-6-viro@zeniv.linux.org.uk>

On Sat, Sep 06, 2025 at 10:11:22AM +0100, Al Viro wrote:
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

