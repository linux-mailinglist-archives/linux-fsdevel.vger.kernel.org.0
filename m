Return-Path: <linux-fsdevel+bounces-13663-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3688729A3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 22:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 091DEB300C5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 21:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACD512AAFB;
	Tue,  5 Mar 2024 21:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="vTrTh8xU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B9A14012
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Mar 2024 21:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709674195; cv=none; b=PU5ySf6UXCXt27LHHZziq4SpTQllXQts6A+ahKkstqMH5JO1Q9JqyNldqTKaXVUHp1csR3185QbsDxGnCOyxYB2WXGtDEWeLkX4OSxUBFA117H0mP/9QgFL+ev+3WVsPwpsAh/Nlu81quMCHRB0eFJcJsxh+y2HS1fMq40IuulA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709674195; c=relaxed/simple;
	bh=I9YgCbAmWPXlHqEAlAJyLrZwMLtISrjMov1kauJfAYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OpzFifTjqQoCm3HvWskNLcJMPXXv7bmobBX6X70yj1NovpXkk+8x/J6Cp8dpwiDSwHnNUNtxPmoz2YXU+Gbrpx3YiAnfcjlxWaDKLZLkR/oPZqJjw57RN13mOXbAG6fgYXq6J0Z2uvR4uwc8knmX1pMQU8fq6hHaCVwHnQPX1ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=vTrTh8xU; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rzjLTLYYuF/lRwvKutMeiu7ZPIiz4281zbAMiT/ptfw=; b=vTrTh8xUw3pZiSbGcedpMq651z
	r+ePxz3LDfJL23jj48kj34x2gCpXHikKOOGPZtOCJ6A5ldQ4OtimpPQAHQz40kA4XMY510enHgqbo
	MG7AtekPVaEYZosLEyhpToHKREpf6/xPtUZCxT7KN/bCOjAu5635O5ZZU5YBEIWcXOPUd9pX2mznp
	L3gLvEnW2Vozh8Nw2dMmXym3br82eWFlOP0ZwLD2aVZyf4jSrzajV4+MpVfNhS5hd0/DWno/WoE//
	iDAGZK2cHIyg7mlWjp+upj4mmW81PuWTxRorBdh1mOOpm41h7eqbli19st4BPAN5puyK4iLag8OCm
	2Djm5eoA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rhcMA-002MMo-1R;
	Tue, 05 Mar 2024 21:29:50 +0000
Date: Tue, 5 Mar 2024 21:29:50 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Bill O'Donnell <bodonnel@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, sandeen@redhat.com
Subject: Re: [PATCH] minix: convert minix to use the new mount api
Message-ID: <20240305212950.GA538574@ZenIV>
References: <20240305210829.943737-1-bodonnel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305210829.943737-1-bodonnel@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Mar 05, 2024 at 03:08:18PM -0600, Bill O'Donnell wrote:
> -	if ((bool)(*flags & SB_RDONLY) == sb_rdonly(sb))
> +	if ((bool)(fc->sb_flags & SB_RDONLY) == sb_rdonly(sb))
>  		return 0;

This is getting really annoying - let's just add

static inline bool fc_rdonly(const struct fs_context *fc)
{
	return fc->sb_flags & SB_RDONLY;
}

and spell the above as

	if (fc_rdonly(fc) == sb_rdonly(sb))
		return 0;

etc.  Quite a few places have that open-coded...

