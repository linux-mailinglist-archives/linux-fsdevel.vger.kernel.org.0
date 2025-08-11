Return-Path: <linux-fsdevel+bounces-57358-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4914BB20B4E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 16:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8995218C7A81
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 14:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC36820F070;
	Mon, 11 Aug 2025 14:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RJcS1rQA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E041EE7C6;
	Mon, 11 Aug 2025 14:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754921259; cv=none; b=bLzvZgHFPmWpvwidIk7BapioH1qc/ztCSJnPd3N4A0W+Nm5YnixbCaa7lqc4GKLc4donCrqmp57pmanHr7U0wOWwThbRuk7qOjlu4zwGXKP/FE1GL1vNzrITWA55E6WpOoi/Tfs+xixBJRqY1QPaVd4ly7+eRhAe4zK+bhRY45k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754921259; c=relaxed/simple;
	bh=K7u0H5z3vDfaEXuo51/4K17TiD6LYFYSNJZ33PJEquU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tYKjaYa+dxvgbPbfSEwVrh3hO52x+VyaWLDBJ9SY3QPRdZfPs8ECC9ty6or4b74VhCFxwxqXpCvwHb8ndg1lqE57YLskfU5FN29JHQ4vZpr8PTilU3KMK5QDB37Lc2cPSP6Ex/41Jhuk9LtcMMABUhWa4z+rldR068ePgmRCqQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RJcS1rQA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D700C4CEED;
	Mon, 11 Aug 2025 14:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754921257;
	bh=K7u0H5z3vDfaEXuo51/4K17TiD6LYFYSNJZ33PJEquU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RJcS1rQAlW6dT9Rd688QHivCWZHiBQOAKFRBEHm6hfFbbcP0xytKlrMaL/6x9IZxd
	 t5lQ5EO2PL8/qHEeaKGvKMmx57UoQBS6Om16yDN54wx3EdONQQo4F5Z7uUFrE2Iwzc
	 jc4EwF6Oi/1wBtK4yhsy0cHKSKUjbGKHfWgbVl1PKoeIALoNPirpWsNfb1p7OEk5w8
	 i/NvvKxjfeLQ18r3Jr79xE5SUbM6WBXsrsSbQoC2+wYvNkqC+rdL2yrWemfREOF/5r
	 aufZHBepgSpuHAEEzM50wsrO0WASTn/TJh1TKmJpcvF4SLDTYWBBywIYcRThY5jVBE
	 c2jW7rjzEnuPg==
Date: Mon, 11 Aug 2025 16:07:33 +0200
From: Christian Brauner <brauner@kernel.org>
To: Yuntao Wang <yuntao.wang@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] fs: fix incorrect lflags value in the move_mount syscall
Message-ID: <20250811-petrischalen-rednerpult-9cf14ac266da@brauner>
References: <20250811052426.129188-1-yuntao.wang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250811052426.129188-1-yuntao.wang@linux.dev>

On Mon, Aug 11, 2025 at 01:24:26PM +0800, Yuntao Wang wrote:
> The lflags value used to look up from_path was overwritten by the one used
> to look up to_path.
> 
> In other words, from_path was looked up with the wrong lflags value. Fix it.

Right, thanks.

