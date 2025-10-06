Return-Path: <linux-fsdevel+bounces-63472-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D36DCBBDD30
	for <lists+linux-fsdevel@lfdr.de>; Mon, 06 Oct 2025 13:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8486C4E3D08
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Oct 2025 11:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A105F2676DE;
	Mon,  6 Oct 2025 11:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TK8ne2oZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08717212569
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Oct 2025 11:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759748534; cv=none; b=L4vmfd/0V05YWxvC0yGVCbODZkRcBLo+mM0ew4aAsf9hmLljZ0nmj8MJkcF2fa9/auCRxgzzn+12Z6ZZ1XF0FushHX/VWeUQysBbngpLgK+RgHmqj3KkQtWhrzTgOQQ9RayapMr+pbnQr8ztt6VjnX4ag1BPTjLmN/GoCM81p/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759748534; c=relaxed/simple;
	bh=trC4doR8JaY+67i1lCFdQ30RPlKGs06XX/QzFtkZSdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iP5zeizB0pFnE5dAdMlTXrBlm5G7f9WwxneEx14YUDntAeji1c9DSZnwCO8LauH9hYWTHmQdONsDg1FIE88l9z0bby9QMDG1UZGAf+xNiG8+4gnWb1dWSGlPi4D7iU+qusDhBm6BlAL/yrxNyxAA/i5ZLzA3zBiUdaghRPNGCfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TK8ne2oZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 896A9C4CEF5;
	Mon,  6 Oct 2025 11:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759748532;
	bh=trC4doR8JaY+67i1lCFdQ30RPlKGs06XX/QzFtkZSdo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TK8ne2oZOalNb4WXlaEmW5rSuRiZIVDzmK1WaJYw/Nab2RqHdWkhTES0Sw7SclkaZ
	 71LF2nF6dcHLqXZjVeaY3vxXiWZ1QOF0QMtGWaHYpcvN0/ApPiJixLKYzeQJ8izIZq
	 kKmX7Y60xN3zrUf07tzRI/VwwkoRoJBwkvIO0NMZWlq3VvfEgBioEzdLu8JE4rS+VN
	 TimQTjYHE2iI2BLx5GMjz8eM+mnIRWqkf/ArN9byr0A70s1tDaJTfyH2VemmtNJ0Ck
	 D8esvPwWoKd82+U3L061vkVpYQcc0gJ0XwMgErWBf0V1ilXZcbWY3ga9CFTbqu4b0j
	 hN14mXqvCvLdw==
Date: Mon, 6 Oct 2025 13:02:09 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] expfs: Fix exportfs_can_encode_fh() for EXPORT_FH_FID
Message-ID: <20251006-umsturz-begriffen-0ecd57a1fa37@brauner>
References: <20251001145218.24219-2-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251001145218.24219-2-jack@suse.cz>

On Wed, Oct 01, 2025 at 04:52:19PM +0200, Jan Kara wrote:
> After commit 5402c4d4d200 ("exportfs: require ->fh_to_parent() to encode
> connectable file handles") we will fail to create non-decodable file
> handles for filesystems without export operations. Fix it.
> 
> Fixes: 5402c4d4d200 ("exportfs: require ->fh_to_parent() to encode connectable file handles")
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

