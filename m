Return-Path: <linux-fsdevel+bounces-51771-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B2FADB3A6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 16:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D411E16A81E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 14:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B369263F2D;
	Mon, 16 Jun 2025 14:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CUhiDkQ4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994E32BEFE4;
	Mon, 16 Jun 2025 14:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750083574; cv=none; b=uoXnnneGeXu2bdZVK76nRO6BKL3s9sNlrVZwveJnWgcPrpvPBHHKs1KhlQrSpVTw3maCx4XDEhTrddSdX+mLOt0ITcmdMirZBGAsKvpJbrOP4LdQ+pTPuJiDHR0xXlR5MY+tx8PaXrVJCEJpCSoVYNccWuQARSrD7ZhMdOUPABQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750083574; c=relaxed/simple;
	bh=fAKBZKvzyJfwRzoCTS4/9oOWkDgSGwuHp8G3bK/u0aY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=It/aazGk/rDSBbpZY4jBUTq3lTDoTdWve0ewcuK/0k6X6+LF6EfkbdEkLlZzPrk0EWKooKO3bKKinTYYyV/MQEzlq3ctpzZ84VZC9gmIRp1/07c2W6yfnUJTChWuIgC6oSiBRyfAib/gh/WgmREPKUQZdeL7T3Jv9or/cLg6JNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CUhiDkQ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C1DC4CEED;
	Mon, 16 Jun 2025 14:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750083574;
	bh=fAKBZKvzyJfwRzoCTS4/9oOWkDgSGwuHp8G3bK/u0aY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CUhiDkQ4fkQh3HbPQwFaU1dKim+oBbytl7FE31KDgiHl1W6LyyctFd8Zn4vv4HQ0P
	 naVAyyv0s5kKotSyo4PAJzBY/XIjUvVsp3r38ahFELkS3VOlPYGSQO6e7t3w3mxESk
	 SMwx2NDd8YsUZRaoYnmSFQ34cBrYBkIFPx9N8G/QpnQGay4Fetjoc0/dyaGJZ56I0Z
	 blT0BNLFCfdKAc0SPOuFvGQqLWhmANgRkbtLalgOsEXqnqWhY/buil4pbLZwng2BUN
	 EfHpaWONF4e7WZOgmb3AO6qnJRM1SCXEGsqK80h5Un5H4C5VhHrQXIH7osvPVs56Ok
	 JcpiDQCAeojww==
Date: Mon, 16 Jun 2025 16:19:30 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] selinuxfs_fill_super(): don't bother with
 selinuxfs_info_free() on failures
Message-ID: <20250616-buche-kognitiv-5d684b75db05@brauner>
References: <20250615003011.GD1880847@ZenIV>
 <20250615003110.GA3011112@ZenIV>
 <20250615020154.GE1880847@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250615020154.GE1880847@ZenIV>

On Sun, Jun 15, 2025 at 03:01:54AM +0100, Al Viro wrote:
> [don't really care which tree that goes through; right now it's
> in viro/vfs.git #work.misc, but if somebody prefers to grab it
> through a different tree, just say so]
> 
> Failures in there will be followed by sel_kill_sb(), which will call
> selinuxfs_info_free() anyway.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

