Return-Path: <linux-fsdevel+bounces-57352-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7939B20A94
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 15:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BDE317760B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 13:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8876B1E990E;
	Mon, 11 Aug 2025 13:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cv2rISWf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBAF2DE1FE;
	Mon, 11 Aug 2025 13:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754919713; cv=none; b=m7nrz1CPwuU8h6curHUuv+hvZTWR9q/GAp43W/j5gTAfL6hhum/1b2ni0LzeldFIH+biGFp3OvMtMXev5b9b5BFlDukHdYejP28Zlxd3Kzz037DgRE35v5cNMxqeT/XFQ2AQUcruOrmUZxxaF3mSVxidTOuf9etWXhRGSb7EVR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754919713; c=relaxed/simple;
	bh=3osHvzoxJlsSVwbZTMcuJWxZaUZZUOM5NQIViYuVKo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CFs4f+YqbUuUUjGqNg8QM3GiR7sGMTzT/4nGPE5oXao7lXHsmX3M8s4XvW805D8JKDD6j20h9g8vqya2/XMyhS4nYysigA+hPpdD51r6zPEGvqo8R+UK0mwOmINMb7SBZ07M1W5GdA1LrCHso9fm3OHz5aBrikHjTiXgia0M0bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cv2rISWf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF4E6C4CEF5;
	Mon, 11 Aug 2025 13:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754919712;
	bh=3osHvzoxJlsSVwbZTMcuJWxZaUZZUOM5NQIViYuVKo0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cv2rISWfyFxRCHlwTXtn3759cvclKZ9lX5SNGmiE3nVvUOKL2IUjQLTHTN4fo272s
	 /ATBpwQqx9iJfZMMaq3s1cyPR96JrhfvQANGdVTmWze99tr+JjZ7mpyBoGoEtY5BVG
	 P7i2ON0QlAmVPfMoSD7mG7TxYj3uLuXBv21h8A7U+h4r/Q+3JD708lAG53459Rmwqb
	 PD2PEnD8h1FSRvJT37bZ+cf/THz9LvFKOe76nMAC5tSSwN+dPVAhl8eugEB+x2+PRN
	 l2vzce0QbG0YfxfD8U4pf0vLLcPKA2TgIJTjtLOQ2K/m0dhWfhLSsrd+9nnPJgLiwC
	 4wZi1catHRD+Q==
Date: Mon, 11 Aug 2025 15:41:48 +0200
From: Christian Brauner <brauner@kernel.org>
To: Fushuai Wang <wangfushuai@baidu.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	viro@zeniv.linux.org.uk, jack@suse.cz
Subject: Re: [PATCH] coredump: simplify coredump_skip()
Message-ID: <20250811-vielversprechend-imker-3a87ced68e95@brauner>
References: <20250811075155.7637-1-wangfushuai@baidu.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250811075155.7637-1-wangfushuai@baidu.com>

On Mon, Aug 11, 2025 at 03:51:55PM +0800, Fushuai Wang wrote:
> Replace the multi-if conditional check with a single return statement.
> 
> Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
> ---

This is a matter of taste. Thanks for the idea but the checks on
separate lines make it easier to read.

