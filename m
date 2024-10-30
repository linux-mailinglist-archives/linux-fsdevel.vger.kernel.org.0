Return-Path: <linux-fsdevel+bounces-33291-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3C29B6BFA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 19:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DDC51C22A49
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 18:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DC11C9EBB;
	Wed, 30 Oct 2024 18:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="qEDqJv58"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE781BD9DA;
	Wed, 30 Oct 2024 18:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730312351; cv=none; b=SdWlLdJ8yHFRiGh3O8ICOyViNpPBHj2DU7MWV/2JjJwz4+wYYJavnmbDtMEEhFw5ZA43B8lMrS4QxHme5ZsNHPplC5OTv8guKfgVjO7xkHvOVWxJGE1kfChN/Q8PWckH/uxnXieE0T/X5OCFBNG0l+L6LLUWu7WWZ6GaJ1WDV2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730312351; c=relaxed/simple;
	bh=oQ3Da+AnWsEKrBsfzfkvdAfz2gS6MD7adn3DpmVSJ6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YGFmg71iReUx9FVIHNMEdAiedYicrN4zzmBDHOLhxuYMwldK/7vWSLoZ3Zanu5dXdHbuseb2UPT0DJO5xVmTrT5bG1QX5eDMp3m5PNVBUkzE2Koht9IEFF7CXzSHLbhlppnSqKeq1wkLFJGYH0hCnISbEtxrjuyO5CA3SERM1zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=qEDqJv58; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oQ3Da+AnWsEKrBsfzfkvdAfz2gS6MD7adn3DpmVSJ6A=; b=qEDqJv58HqvVup+BbATh4r1PiX
	NFObIX5rgIYowKvbNs4r9Zfo8MSowLlaZBqRdPoPGRhfXKU3uEsFt/gxErCP8yKW0qQoZKP2TuEBS
	yEYwnbHpv5dGoMcyLbJtSEBs4eUruMLxVXL4iy859nQUnz+UmT4vR+c+vUxVcOaiavvzqO1i6iOUg
	qSlnqrM8EBCV6482Xwi/BzWi/W1nDvKLn9LlNQ7cOul1GETve7iPiERK+QPH0xq/82E0Hp+wCT4TP
	8Y8Y8EdwLeqRYosyeCOggfhOUv8/VqNDe34AKN1J5wIZfx/Ewe9s3WksJyFxVHX0R5how1MjGiA6f
	1Wzc/8FQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t6DHe-00000009WYm-19qq;
	Wed, 30 Oct 2024 18:19:06 +0000
Date: Wed, 30 Oct 2024 18:19:06 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] xattr: remove redundant check on variable err
Message-ID: <20241030181906.GI1350452@ZenIV>
References: <20241030180140.3103156-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030180140.3103156-1-colin.i.king@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Oct 30, 2024 at 06:01:40PM +0000, Colin Ian King wrote:
> Curretly in function generic_listxattr the for_each_xattr_handler loop
> checks err and will return out of the function if err is non-zero.
> It's impossible for err to be non-zero at the end of the function where
> err is checked again for a non-zero value. The final non-zero check is
> therefore redundant and can be removed.

I'd suggest taking err itself into the loop body, while we are at it...

