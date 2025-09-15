Return-Path: <linux-fsdevel+bounces-61345-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 656C4B579DC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 14:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6FEB16709A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 12:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737362F0C58;
	Mon, 15 Sep 2025 12:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ppUbsYD/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FCC2E2EEF
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 12:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757937926; cv=none; b=YDFYh6mv1fe/UNZP+9l5r1MtCWyJXOqH2LxabjqWXXNWNANl7l3zG/AuonsrtAesYDZlJJqJaVIWrd8CQOdC8CIbGCqYGo8YYrylGcC3CN80XEUAJlNSJzl7H6pOQBJtid50wTuIFgbAwpfceufnKPiH0+tS9ssu/mbDrwLt1VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757937926; c=relaxed/simple;
	bh=q3tyCgeLKKXlv5iwsaMLRaerp5lVWmZ3Qe8I+NIn7lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UbHXApOCa8APyR8lRzcyhEEQzlLvaPXXMat5d7RVpqCDKUahiNVMe1t5dn3coTmGawgTMrSlRZGc9QVNfqq5G93gX1t6jmgjqmjAKgNAeLVCMcJGFkPHUFE/bCsOYkAHsJHsdsuWa/L2e646uENZ53dCHKKLMEfdCMNkSJn2G0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ppUbsYD/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C783C4CEF5;
	Mon, 15 Sep 2025 12:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757937926;
	bh=q3tyCgeLKKXlv5iwsaMLRaerp5lVWmZ3Qe8I+NIn7lk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ppUbsYD//C3/VssDd3yLJBe3ywMZRUnPn4fnQZGkKU48KexUe57Izfonu4ikG01yk
	 N7Ca2aPd3zjsPotdA3pP/X6xZUjRMuJPIzkAbGdXLOy5rZ8Jr/VQRzoSr4WIDRsI3W
	 oXoOsXMMjJypgb8/wAtkij25Fy+/U2mNvSK/2FiXKARjAWHNINSth10LplXNbfN5kT
	 f6C+NPsecgQNulhXyM+DjcAQIt7RI7SSk7vI5Kqri0EscD226qVPJBgWpqnpFI6yin
	 lN0aqCXZ8JFRGlFnV0J2BeXIev38ysDDNx6HhhIYLjx4+3lf7INDZ+/lYK1qPzFkcF
	 xRUB6MSbaNjyw==
Date: Mon, 15 Sep 2025 14:05:21 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org, amir73il@gmail.com, chuck.lever@oracle.com, 
	linkinjeon@kernel.org, john@apparmor.net
Subject: Re: [PATCH 16/21] ovl_get_verity_digest(): constify path argument
Message-ID: <20250915-bergen-ecken-611394df8b04@brauner>
References: <20250906090738.GA31600@ZenIV>
 <20250906091137.95554-1-viro@zeniv.linux.org.uk>
 <20250906091137.95554-16-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250906091137.95554-16-viro@zeniv.linux.org.uk>

On Sat, Sep 06, 2025 at 10:11:32AM +0100, Al Viro wrote:
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

