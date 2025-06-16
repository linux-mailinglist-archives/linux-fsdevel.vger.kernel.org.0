Return-Path: <linux-fsdevel+bounces-51769-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23EF2ADB38E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 16:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A68EB174D8A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 14:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B0E286421;
	Mon, 16 Jun 2025 14:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WyPJn+98"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A26286419
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jun 2025 14:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750083436; cv=none; b=TO0hKkVHPDNCzeBOSu5vdZEhsGJfMIML1Ve+VmmW0TaqD0zHbO8KSyshBDEJ83f4o+Ehm5CVotzQEsGrUVyu78cwNA+ayocKG0NujbjAx0cqqUFsUoU9Vdivfu6a+AFlsxo9aZwIAGF43/gBRKV+D/kdTSNKvpvxT4lvBqKubrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750083436; c=relaxed/simple;
	bh=/k5eod8Lu6hC+kZ1pokLXRrA9dqFVt4YmV6u3v1jEuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p1nl96UlcTdu7WwMXmIIVux0LOLe9jcTixbdFa0v71BcvNB0oOunhy84dReCWRciljW2xEF707wO3lsRrSCcRIozKtnt/+2VuNr+yu94AIywUvjUvJ9tdrwAvVkcR+6egBSpLODXoi+wM63+SovWiH7EkffvZXPwQqVUL/eC4Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WyPJn+98; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3B79C4CEEA;
	Mon, 16 Jun 2025 14:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750083435;
	bh=/k5eod8Lu6hC+kZ1pokLXRrA9dqFVt4YmV6u3v1jEuk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WyPJn+98mTcuNOiyKvL7Vigj0u93S00ve86I9h4fwGfqPG6RIWMgJRmbhQ8HPWN5S
	 PTLpleO51+VLOJHSCo6tHfzbHSp8BMkTbnwK78OIl4+q424luXVfOAY96v3s0HEZtu
	 SS6zO6mSSczD2WYL1eauFJaOsQdDsoIXBrXoJU6qRldU+fWeHBvXHSAofGOL/37OGH
	 zlc+m5Gkn8Dr8ac18ISdT8wMp6l6RgwlfOtqtB+j/1jqHFR575UVopgunfpw7DkEbp
	 jlqNJXU1VpTYDqdk/nA0+Fc3j5FCnut/tU/Hl1/yemiHcjjrVT53HAutAtua2iEok5
	 IUfnJkBlZNYew==
Date: Mon, 16 Jun 2025 16:17:11 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] don't duplicate vfs_open() in kernel_file_open()
Message-ID: <20250616-natur-festbesuch-96d8d0f2fa38@brauner>
References: <20250615003011.GD1880847@ZenIV>
 <20250615003110.GA3011112@ZenIV>
 <20250615003216.GB3011112@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250615003216.GB3011112@ZenIV>

On Sun, Jun 15, 2025 at 01:32:16AM +0100, Al Viro wrote:
> [don't really care which tree that goes through; right now it's
> in viro/vfs.git #work.misc, but if somebody prefers to grab it
> through a different tree, just say so]
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

