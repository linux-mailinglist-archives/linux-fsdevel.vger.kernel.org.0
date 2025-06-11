Return-Path: <linux-fsdevel+bounces-51271-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 424C0AD5091
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 11:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4400188858F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 09:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A9425EF9F;
	Wed, 11 Jun 2025 09:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S8J/peN1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A662A23AB9C
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 09:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749635484; cv=none; b=THXxjlOpSw8Nm9IqgAZjn9mwg2gLJ1GrWs04un20xPt941EPgPjUKy6BTUf6k2IGyrov2RIYJgMgSvoxm9rNhKwNDwgGmpDNp9sGmcqph+6Mkw7kYOG/zK0ZG64FdOT1nrWRpAY9ZUkChJqtqRrBruT0L6B+AMMOcOb1ZAMMgp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749635484; c=relaxed/simple;
	bh=tGSeIDKtNeUbqMiHqeyl2n8BoNRq13wJxOPhzZZ4sAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YkjyzagmxtoVGPnAv65CCjT798VCGEXORQwolzHv9WQpOvOvhng3pNUcYmjNjbCstH2PzDhO//wA0cl94k6T9tN+hj/WFlOIDqEI+Om/idpaAYlM9ZRh2W98wSGi7Sn05oUSQ3zNDYlqj2JrK1pmPEwh9MR6/Lu8yjVC4l49lek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S8J/peN1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6216C4CEEE;
	Wed, 11 Jun 2025 09:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749635484;
	bh=tGSeIDKtNeUbqMiHqeyl2n8BoNRq13wJxOPhzZZ4sAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S8J/peN1gg5g/0dS/5Q4nCFAOoNctD1da1sLrC4Y+02zMjmhknjDLRxUHlLAlOwQi
	 tU9r2yRrjmTGT66HwNoniNQYUJerTiLlN3By+JoB6xY4zsCEhZyS8OCso3jXg7uYem
	 aEpDRm/3QiJHDAlpdBLyC5shSzhdmlgMzjaauRgBR3BO0S1XBmOY3u8HulzPA7Ds9C
	 sqo8a3dHe+0n1YZNtRA6ZiihQpMIyMQdWwzz8abM868lY4rYNakuYCtqpE4HnaJ30g
	 FrnBfXhx6MmxcHZs0irzFP/LF/faKPEEyOuDROx828jwDPYCfr5S7QHAUQUwqlnRUY
	 GZbEJtgHfLcYQ==
Date: Wed, 11 Jun 2025 11:51:20 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, miklos@szeredi.hu, 
	neilb@suse.de, torvalds@linux-foundation.org
Subject: Re: [PATCH v2 21/21] tracefs: set DCACHE_DONTCACHE
Message-ID: <20250611-nahelegen-geliebt-24e07ba8afb2@brauner>
References: <20250611075023.GJ299672@ZenIV>
 <20250611075437.4166635-1-viro@zeniv.linux.org.uk>
 <20250611075437.4166635-21-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250611075437.4166635-21-viro@zeniv.linux.org.uk>

On Wed, Jun 11, 2025 at 08:54:37AM +0100, Al Viro wrote:
> *NOTE* - this does change behaviour; as it is, cache misses are hashed
> and retained there.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

