Return-Path: <linux-fsdevel+bounces-44382-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBFCA680E5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 00:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F10B9189860C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 23:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1DC207A2C;
	Tue, 18 Mar 2025 23:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="AVYDKxY+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41431DD0D5;
	Tue, 18 Mar 2025 23:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742341792; cv=none; b=ga0ZAy2hHpSN5y6p1Ur6j1ksMJhRhFzKk1kH/DMLRu2kWZsij8zHuC9eAUeiW699LERERKdotJ98WhKILdVn4DI29kxrX2XiZuNuTD/z68UBKIpZn7np63a56w0JKlwXPPr/kYYxW41CsPXeIK+20x6Wgrm1MXKJ9hpEB8+B3pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742341792; c=relaxed/simple;
	bh=UhWm3Bxzfa1AaPPwzlEgd85EabPEm+XOozm36h56kXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DfGI4EjE+KY/IQNu69Ug/CkqjsS2mqrKrUHo5/w+kBZ7O+Mo2iKAGSmWprG4O5ti3j51GZ2GEsoA8B/WIPpolqv1nX4ly1Z2UeIczi2c2s2OHLHh49YPaKqNIok/jtfCVP8sCARQrGpTlgBalFVl9NWjG3bavX49eCKbOYR6JDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=AVYDKxY+; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MDM21kfd3jK3uD883UtXPvJsKUruvqnmYwxu1cep/E4=; b=AVYDKxY+Fckh47iPYwt/Ir1Pq4
	1RWW+QfCfE/rqkpgQ+Zr6ENN4dsJnva6UUTrGe0WVNNGyN45E4GznDwZXdgL5+srIr4yHj8eXpVMY
	Pa7wUeiuhnqdugaxmpY09SdO2J7B/UYJZhUS41CGYMTTQyz+OzhQvQwtob213XoPtdCj/i0SifvKn
	hXuhO9mSy/8DDDyIZ0WFZmTvjB1M3zYv69zRsoTRSV9Kn9NLfIhTJI+BoKKwWYV4NnFbOlVb6yu0H
	z1bnQyfJJkg2YvylOZReoUsUqk1OqLTlo8DuUg6tN1SF7n8oSWS9okm8Qp/tCGTOTnOxZWP2EOVBp
	y1NSxmdg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tuggu-0000000HIZ4-1KWY;
	Tue, 18 Mar 2025 23:49:48 +0000
Date: Tue, 18 Mar 2025 23:49:48 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-efi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [RFC PATCH 0/3] create simple libfs directory iterator and make
 efivarfs use it
Message-ID: <20250318234948.GZ2023217@ZenIV>
References: <20250318194111.19419-1-James.Bottomley@HansenPartnership.com>
 <20250318234505.GY2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318234505.GY2023217@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Mar 18, 2025 at 11:45:05PM +0000, Al Viro wrote:
> and it becomes just a simple loop -
> 	child = NULL;
> 	while ((child = find_next_child(parent, child)) != NULL) {
					that being root, obviously.

And we might want a better function name than that...

