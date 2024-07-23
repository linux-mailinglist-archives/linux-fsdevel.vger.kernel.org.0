Return-Path: <linux-fsdevel+bounces-24112-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5AFC939BED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2024 09:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A220C282D94
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2024 07:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7ED614B08A;
	Tue, 23 Jul 2024 07:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQZTu6nA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3504436130
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jul 2024 07:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721720954; cv=none; b=OPqHzwfIqeSMnx6h3s6EXNTLZlQWdiaWoovPnLm2m4Zxtk13LCIzx1npR37aSOFlDLi8NiQpa8Dk/EJZkA6FwB/AlM05USJ2V/MFPytP3Dk0RtkmevTQLxTSaL5WvgfEF9qIe8AKywldhqobgZYl3nRgBAhcoWZ63+uB0UUhtL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721720954; c=relaxed/simple;
	bh=pQZW2V7gDdoYA5UxkDSPkRkCjEeYnY1//muppFU/VOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GsA662EEyQCS9uEYWFe7ZFFEhdIouxpuen+gmeD3o9ZjTJufGfvDCP6VJ0s8crHOYjSw6Ef6i2t5zEZ71JFAc5itNj6JORwAqrhq+pj9BfgcTS4X3r20naS5nmW6+wifWCmldQRKSzpn0kOsE7r/JWV2rW2FLgHPr7QmanGymSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQZTu6nA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C218C4AF09;
	Tue, 23 Jul 2024 07:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721720954;
	bh=pQZW2V7gDdoYA5UxkDSPkRkCjEeYnY1//muppFU/VOM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZQZTu6nAvQZ+x4zs++wOXwTMGCwceliX7pVZMyGwJyNwd9O4jsJjie+hkBHi/6xKE
	 KhM4RW2S6wP8uVosZ9CaAmiN22g6dQvmGS24J+2QJVvpJS9MIRp98xytgbdCN7CLvD
	 Tt9iFjGvO7P+I+n/CjoCPEX8ZWinX3O0JrqVxyoy4sZRVZ19bse9/AEaXybB8WdPWU
	 thcB2ka6k6TPPUjmA5DZYB4JU0mA2JoGeP5L0ke/wz7cX9/V7+8L31B+16CLaZY3F1
	 8Dz1fhG851q2I3plg+mAiVu8J3A//m/dCTmfGRVrgLHcIvcpjiTGsXAyzG0/MR/6qS
	 gAvcM3BxW3aSQ==
Date: Tue, 23 Jul 2024 09:49:10 +0200
From: Christian Brauner <brauner@kernel.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 00/23] Convert write_begin / write_end to take a folio
Message-ID: <20240723-einfuhr-benachbarten-f1abb87dd181@brauner>
References: <20240717154716.237943-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240717154716.237943-1-willy@infradead.org>

On Wed, Jul 17, 2024 at 04:46:50PM GMT, Matthew Wilcox wrote:
> You can find the full branch at
> http://git.infradead.org/?p=users/willy/pagecache.git;a=shortlog;h=refs/heads/write-end
> aka
> git://git.infradead.org/users/willy/pagecache.git write-end
> 
> On top of the ufs, minix, sysv and qnx6 directory handling patches, this
> patch series converts us to using folios for write_begin and write_end.
> That's the last mention of 'struct page' in several filesystems.
> 
> I'd like to get some version of these patches into the 6.12 merge
> window.

Is it stable enough that I can already pull it from you?
I'd like this to be based on v6.11-rc1.

