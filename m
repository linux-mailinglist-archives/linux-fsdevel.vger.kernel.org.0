Return-Path: <linux-fsdevel+bounces-61352-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1EBB579F2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 14:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C1CB3B84B2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 12:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0E0305E0A;
	Mon, 15 Sep 2025 12:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dyq/wfgp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9443054F3
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 12:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757938035; cv=none; b=lerkBoXgj2BnOQk7RP7XFtUOjHy5/BfYfiXUr+6+oJwNlFUZNUfarXeRcMMjf2IWaEbpttjSYEuzRcVp7PpX4YNzcu9ka3sJR6nWhddQWM5NScW/ZZeoZloB5PGxBY9FIHzj1T2GE7HM9GrAjCZL5bdpYlp6RX3zV78cLLmNS/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757938035; c=relaxed/simple;
	bh=qaLd9uyrLB3f+rI4Kq/5R03UoCA9nTk1ix1aFaPLGa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d+vZvdVrjV956nSOJwG4glRlFPcC/VrMmvnbRN3M/pNe4PpBCWYK9ZezR5AFKfJOYXB1M5ehEczcnsv61MBkSYgxHLeVZTeb/u0pcrQHP/rY8uIqCHaHwSz59u+m5I8QLbTxQeK3oqTRrV8Y4AmsrrPikxYZvwAZsMmFWCNMbI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dyq/wfgp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42891C4CEF5;
	Mon, 15 Sep 2025 12:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757938035;
	bh=qaLd9uyrLB3f+rI4Kq/5R03UoCA9nTk1ix1aFaPLGa8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dyq/wfgpjx//KTm8mOTItTIo4kksy7zkc4j8V/Tx9scvzAaseWG0iUk6ld7UjtVtj
	 HrMro7IGFAslgBVUkx/IzNye5SKSkKP75gBIz9JrYA3NjM+1+WP+WlusfKcvnCuW/8
	 hW9QTBlhdmVflpvMLJRBTB4qfRydVdA/XwaHN+si/mQPhaQK7TG2BK4jqOWjoS7tpI
	 zW6ZgeGAXoktf1hp6r662ftSbwPiTsZaZOfUBcfPSC17bZFi4lPa/JXXCw8dPnrJ7I
	 jlPBGDMVgKbBnuPTHusHbZzXUX74+z6OpkSBfSNkVrSZnbEjD1PsF6V9eQYPb273mD
	 H6ZYzRPXiwyYA==
Date: Mon, 15 Sep 2025 14:07:11 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org, amir73il@gmail.com, chuck.lever@oracle.com, 
	linkinjeon@kernel.org, john@apparmor.net
Subject: Re: [PATCH 21/21] configfs:get_target() - release path as soon as we
 grab configfs_item reference
Message-ID: <20250915-zoomen-butterbrot-012ec9c3cb47@brauner>
References: <20250906090738.GA31600@ZenIV>
 <20250906091137.95554-1-viro@zeniv.linux.org.uk>
 <20250906091137.95554-21-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250906091137.95554-21-viro@zeniv.linux.org.uk>

On Sat, Sep 06, 2025 at 10:11:37AM +0100, Al Viro wrote:
> ... and get rid of path argument - it turns into a local variable in get_target()
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

