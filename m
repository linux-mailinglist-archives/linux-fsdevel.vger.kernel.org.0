Return-Path: <linux-fsdevel+bounces-39500-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DECC8A1547F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 17:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 471F13A1755
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 16:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991D319CC3E;
	Fri, 17 Jan 2025 16:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Sbv7Rhtv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B85813F434
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jan 2025 16:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737131970; cv=none; b=txUzrUxZsH8d0d76eRzzJk5HXdwNlqozodPkmXWnHPV8+vWYkmgoLfotigsHm8jQhyIHlEy2xQ6GPHs8jTvSEDvmBU9Wmfo68YdrYZX+90ZFmBSgxtl5a46UE8uHFLAad8h4uDhoDLSyumo/g7adrKfVldKi5oFQaHZiYHmtVFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737131970; c=relaxed/simple;
	bh=uQbTTYZcCZMTV9BpcydqXv3Wk0GgCo9Qv0BzdHgVFt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rvQRlnOY5g1mEWwZHJyJSu0kXmENfPaiirUm2wp0I2PFGrwR0mGomOKuJcrhlaSWa4peYkNUC2d8uXzBj6ESuZ1yQonlwQF5Y+e/JcI7ek754hMrjwblTAdBj5kWCq0xx2qivJTYEWxqdgnlp+5IoixLrx8c+miQS1xZqxwKBV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Sbv7Rhtv; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kuEqFCs7CJT0uKd+rtLDk2zGjbPLLEc9r0IkOFKo2sk=; b=Sbv7RhtvaB+uQaJ9lzFpTicxLL
	3Rg3abeSPcSllOFQcxKaVYE9ZK32smvjENPGqnOWWVwtgFRbcF4Jd/IhGmxQqXpVcgd+iwFThpHp9
	TiRw38Bi9ul0qQ8E7f9va0EagujGIwoz3msXc1IaCZyam09cyXiLo2JaQzwrWY/nM7vyor/O2gtX4
	0zoVLUnfq+h8fIn/nnB2oMRCIMBRADLoL1iTeREGnpGHsW9574tp8HUoQXpkq9a/GmvNytwGFTPVh
	BjSByumfMktNjhLj/BvywLS74encAMe7eoiNyYJLh/2n2Lf/QRkRKhZuWKoMuN0bI/WGg9uWV0ZYz
	tgVMW1hg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tYpNW-00000003QHB-1KiN;
	Fri, 17 Jan 2025 16:39:26 +0000
Date: Fri, 17 Jan 2025 16:39:26 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Eric Sandeen <sandeen@sandeen.net>
Cc: Eric Sandeen <sandeen@redhat.com>, linux-fsdevel@vger.kernel.org,
	brauner@kernel.org
Subject: Re: [PATCH] ufs: convert ufs to the new mount API
Message-ID: <20250117163926.GQ1977892@ZenIV>
References: <20250116184932.1084286-1-sandeen@redhat.com>
 <20250116190844.GM1977892@ZenIV>
 <9f1435d3-5a40-405e-8e14-8cbdb49294f5@sandeen.net>
 <20250117081136.GP1977892@ZenIV>
 <c624f5f2-33bf-42da-9aaa-ef1a346fb9ea@sandeen.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c624f5f2-33bf-42da-9aaa-ef1a346fb9ea@sandeen.net>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Jan 17, 2025 at 08:58:36AM -0600, Eric Sandeen wrote:

> LGTM; you may want to edit my commit log, because this:
> 
> "ufs_set/clear/test_opt macros are changed to take the full option,
> to facilitate setting in parse_param.
> 
> ufstype option changes during remount are rejected during parsing,
> rather than after the fact as they were before."
> 
> no longer makes any sense; you did that already in your new patches
> so these changes no longer exist in my patch.

Done.

