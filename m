Return-Path: <linux-fsdevel+bounces-8245-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7257831B0D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 15:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D66CB26EE3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 14:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974642576B;
	Thu, 18 Jan 2024 14:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMD+2c7m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0487425756;
	Thu, 18 Jan 2024 14:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705586647; cv=none; b=sDOcOgs0HJhPgzJMFDjREJk6msnKoooQY9l47WHDMqhMx3k5Xw5sAvVPP/cfzxuXBzLcOQtw7sY0TbjrB9tZwsFbmgw9YgRh+M/SEv7S/fSCxPETDH1jrSDtB+9Z4LH7n5QNCdXtMLhMyA/xzHxBAHoDGSvDiGKwSAGmgQnNmlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705586647; c=relaxed/simple;
	bh=CUg/TAW5ytfIjj6h763t+wFJWAbSx/xoyYthkV8NQsw=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=o8jx6fnVxTLeJZlobmeTzrxdWJCDLg4PoDBESZP/8M5uYASHPazazBtgEpzXKXITOgKcydjenbCB0FdGKoUnaQ5QMDWzpCMzXwsiMYVfwGL80d+mzHNYXKym5xVPfE9Y72paVMt0D6SORq0f7ANxGf1x2IkgMGMTaX1i3VblYDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kMD+2c7m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 235EFC433C7;
	Thu, 18 Jan 2024 14:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705586646;
	bh=CUg/TAW5ytfIjj6h763t+wFJWAbSx/xoyYthkV8NQsw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kMD+2c7m48E+1LfIfW+gz6LyGmuyZHIcsjo4I51x0Xi4IGHP+SSSKLhhuj8pELn/e
	 gcEr8byzzO2s9rRHsI39ryc5D/qCW8NI1KH2Nl8LX2wWHNF81V6om2WgY8Wu9fU8sU
	 eBWzg7CWnzrbmYt7IzUWTqOJnAz9OEDpSPYDC/DDE5r56LLFxBoAgtHIc1vfClonU4
	 GhhkempOC9za8YIdB7a3HN/BzzaQBEIsaqPZZMy6pxp08wpvBv1543I2PuJlfsymnD
	 bQAlyzsxkvz6cA6VzxFLSXgSbHX1e21brkbVw0GFg910JDMTY80FFPVnnk2el6rv6p
	 j3iRVHA0xb/lw==
Date: Thu, 18 Jan 2024 15:04:01 +0100
From: Christian Brauner <brauner@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org, jack@suse.cz, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: improve dump_mapping() robustness
Message-ID: <20240118-etwas-anbruch-9075adb23bd2@brauner>
References: <937ab1f87328516821d39be672b6bc18861d9d3e.1705391420.git.baolin.wang@linux.alibaba.com>
 <20240118013857.GO1674809@ZenIV>
 <ZaiJIIrzUR7qPkjC@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZaiJIIrzUR7qPkjC@casper.infradead.org>

> Agreed that it's not enough.  It does usually work, and it's very

Wasn't the intent to just get somewhat further and accepting that this
might crash no matter what?

