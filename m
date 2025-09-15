Return-Path: <linux-fsdevel+bounces-61337-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E7CB579C9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 14:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A09C71A27CE5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 12:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C37305E0A;
	Mon, 15 Sep 2025 12:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MuOAqGHR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C222877CF
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 12:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757937808; cv=none; b=BF5dde1V7cuMOuXD98qjEPlWrWG0gHQzQ81t/5nvk1w2s1phJqW72vISVsvxkoHNcGMO4rL/dLl1S2+c5XATzHXSAYqEfQaIDZKHs1uvMbLwO8jOGm20YQMXBUyR6q2vxgfMtkMWbrFtTejsgUUjVcnyuBu/74h1B0SDbPA2Ltw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757937808; c=relaxed/simple;
	bh=9GtRqZF3ZTWcSItC9DMNf1V+OTKthmMA2xHREFrciac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XrTzcx50GhGtb9Ff/kTm9/6PQbAK0dT1CO9xhcsKV60wXXITCmnbY/ADq3thdBSGSZaA3zLO/2NVO6kdxWAqjNK9Kqxb/QvTTeJDoubmpOofw2vA3kRQg/Nv77ZSy3Vr/NL3/7jXqnZ4wiNIzl8YSN5lflDAF+QCoRy5csS4cKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MuOAqGHR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2FADC4CEF5;
	Mon, 15 Sep 2025 12:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757937807;
	bh=9GtRqZF3ZTWcSItC9DMNf1V+OTKthmMA2xHREFrciac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MuOAqGHRkV81VboaH32mqjSU0UGlzUk+dl0rEsynKnGryI6QJTm2rVFIOIMKsNOm0
	 7ROUkSGQ+DDlaAn2lz8OfmhtE1iiUF82WC+sMTBcXc6JVAypmlUBr04YJ0MTpfbqEd
	 Q5MW8bBB4aEakHe1O/6oRkHw8XEIssofhGG+98EGZwjP8pCSdl6PYRjCQJFC9h0QsY
	 hMSGAuDjwwT3NZ4THYOKwV+iwiSCP7s/7535NpZYbgVUxci7X8NEgJ/iz2EH40vRS/
	 +szs2lFHBDuOXPi/NDu5KYx65sv70x/qkscgK/dxlCVI1qxTEuXcSorCiezWiOR8q9
	 IiR50DDh/ydzg==
Date: Mon, 15 Sep 2025 14:03:23 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org, amir73il@gmail.com, chuck.lever@oracle.com, 
	linkinjeon@kernel.org, john@apparmor.net
Subject: Re: [PATCH 09/21] check_export(): constify path argument
Message-ID: <20250915-lyrik-radau-f01848cfb33b@brauner>
References: <20250906090738.GA31600@ZenIV>
 <20250906091137.95554-1-viro@zeniv.linux.org.uk>
 <20250906091137.95554-9-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250906091137.95554-9-viro@zeniv.linux.org.uk>

On Sat, Sep 06, 2025 at 10:11:25AM +0100, Al Viro wrote:
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

