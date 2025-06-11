Return-Path: <linux-fsdevel+bounces-51298-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 260A4AD5337
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 13:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB2EF7A5F67
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 11:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1642E6115;
	Wed, 11 Jun 2025 11:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MoQ7EDWD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE612E6107
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 11:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749640104; cv=none; b=Uqf8OtQflpaAXY/HHDQycZtYiiANkriNkVNTEghahUXDyBG3XmaJKjotRjbRclUft7UnklIPTlUJzRGXjYx/A9cuKGz/qMNMQOTD6RwMPX6TxCf5ruWe0QYTjcbnXGRQ+Lh5Dq8E+ZU7+eLPjEj34xqJfW36ZZ/Url6m5OGmVJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749640104; c=relaxed/simple;
	bh=XPPOjHRmAsMmxlyqS8KQRDn/H3uDlvE9ZDZMQKEPHoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QlyJH41k9Qekwmv4HngFcXzA4CQN2MFdzMGinsgmDneSfvtmoao3BBNew60UfmlChGEn4m0gXLNvMDhOr8Fm2yTZlgjO+yPPjHZuumRIz6y0TYPqR5+hI4wsc3jHsKr/07XguONQhs5aUysBvJyNO5xsl9z0+vNXw5NglG3geRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MoQ7EDWD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6417C4CEEE;
	Wed, 11 Jun 2025 11:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749640104;
	bh=XPPOjHRmAsMmxlyqS8KQRDn/H3uDlvE9ZDZMQKEPHoQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MoQ7EDWD4n3T3p3AU0fi2rwTu9cRfJKwoo3sfaaJR8XIa/IRojHmj6YShX+rmBpze
	 BkWf2ta1jp97IMO2e2rgH817W1nyw/moJ+6Eg23OS8dCtYkpkFzSrNjZdYxbbxjJG3
	 PIh6bXaH0jIfyBqlUiQKTc+KzRf5HRnxshv/bTJ/knq9t+ptlFwZVE/k3s6VAz9KhV
	 F0/GqvgiKXGOnZ/4ZjTIYKJx7nIQu6ad58LzkWWIZFHhiI91Vzlxx96Bb3Tq9ES1Tj
	 bSbGazdpMtzLRsVMvP9RCEJ6v5iQRtud41nHTJWVMEqcglWkczx8sCfXRF/iwFHtJq
	 n32Mkt4iR0qdg==
Date: Wed, 11 Jun 2025 13:08:20 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, ebiederm@xmission.com, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 19/26] attach_recursive_mnt(): get rid of flags entirely
Message-ID: <20250611-leben-endkunde-86bffa8a8917@brauner>
References: <20250610081758.GE299672@ZenIV>
 <20250610082148.1127550-1-viro@zeniv.linux.org.uk>
 <20250610082148.1127550-19-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250610082148.1127550-19-viro@zeniv.linux.org.uk>

On Tue, Jun 10, 2025 at 09:21:41AM +0100, Al Viro wrote:
> move vs. attach is trivially detected as mnt_has_parent(source_mnt)...
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

