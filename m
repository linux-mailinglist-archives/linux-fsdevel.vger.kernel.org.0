Return-Path: <linux-fsdevel+bounces-61376-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 046E0B57BA1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 14:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BA3C188D6E4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 12:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391A830CDAF;
	Mon, 15 Sep 2025 12:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tJ3rXy/h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D5B1D9346;
	Mon, 15 Sep 2025 12:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757940312; cv=none; b=HXIy5yUPLD9N/k0F2X6ca20ZWbE1y2/kcY4XAgkLM+Z1bKYL6D19jk3bRU2aeSxkMK4krT3nFzr+NHKl24MDgyEyzxXrIbn95uum9eUhplZL95Pymcnp0T1arnjbMvgpqqPX2CpbpebP8b8PHRp5DgG8vDtsZPsuhZRJQyjO/l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757940312; c=relaxed/simple;
	bh=kyMjFuRZ7ilbA/M6ilOkRwjIWWsMOYeKQqX2RH4Ihr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bPEyT40tsBnPXPgnXqhsA5Vquk+unkBHbTJIcSh2r+ptPEs0orrI2VTwVW3zNPilL9DADUWvpe8kQZMODpwqHkt/xK8mVglbbur60eDnEs9NsfmpE/AgGzynIMHwOKGoTTP1TzUbXljQpqctIVPgw2l99RpVQGe6huvxExZtTdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tJ3rXy/h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16D62C4CEF1;
	Mon, 15 Sep 2025 12:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757940312;
	bh=kyMjFuRZ7ilbA/M6ilOkRwjIWWsMOYeKQqX2RH4Ihr4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tJ3rXy/hPTTyuiFdZp0laYU2SRioUGNs7/qxcntFAVGiC7csBim5a6TKdTTpammZc
	 tzu4WiWicp+56KaVVjGcFPSTiCQx51PAnU0ju4xpEG3PCiLHilglT3VMvc0Phvmki+
	 125iUabOFK7jdbm4/xOOHvKbm4aKc3kYPJLBL3ZoHXzDUVXuQfyJiD8Wq/LtUU1xbv
	 f3AY9qjpM9BxOjz+kMFfh0+SGaKyxKbD9Ud7RAml050lY/9fwgjK/1qVN/TCrdpr0e
	 rLB5f0u7yIJyyuFN7U9Tuh1QHHl0jpItDQv5O8bjcgX8gLrI32rEAvm/FnzXczrL82
	 k6j+mF5RvkwkA==
Date: Mon, 15 Sep 2025 14:45:07 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org, 
	jack@suse.cz, neil@brown.name, linux-security-module@vger.kernel.org, 
	dhowells@redhat.com, linkinjeon@kernel.org
Subject: Re: [PATCH 1/6] security_dentry_init_security(): constify qstr
 argument
Message-ID: <20250915-mitdenken-nahrung-00c8cc586615@brauner>
References: <20250911050149.GW31600@ZenIV>
 <20250911050534.3116491-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250911050534.3116491-1-viro@zeniv.linux.org.uk>

On Thu, Sep 11, 2025 at 06:05:29AM +0100, Al Viro wrote:
> Nothing outside of fs/dcache.c has any business modifying
> dentry names; passing &dentry->d_name as an argument should
> have that argument declared as a const pointer.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

