Return-Path: <linux-fsdevel+bounces-36488-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 115CB9E4026
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 17:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF9B5B29E70
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 16:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C31220DD49;
	Wed,  4 Dec 2024 16:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MLKnTEDr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541441AF0DD;
	Wed,  4 Dec 2024 16:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733328454; cv=none; b=oQVzmH2l3dd1NbZ88aXr4rWwPxZ8edl38IhqBQrL0aOCRjr3LOwRnFIyDiiZMLNnegVDNwcmeC+kKfIYxI2k+Y4tnycc3LuopOMJ+WAx7hKlBFmKb2WPc+0oTT3hf9oMHKPpt7ltXvlm2jIA2sx5fcP6NwGnVlt37voGIDpjC5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733328454; c=relaxed/simple;
	bh=pCvMz5PktIzh9299IaK+tWADNPBRGAPiWFvfw/iZ6/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AIDKzriUs31EOwwk0buNT0J+kQxSr4XT+oZty1QPkIZFpA3U1uFB0VtVx+jbxh4W6yy3kSJn+anvYYQdstcH2PSIVh70Ofe+BBrrD+Ubwr6Ju/zF+ANHdQfsym6FvjOrZpL6YdpI4Y/EiSJ5H1Wqa9PrQtp/XbPBSmxxRPDuetA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MLKnTEDr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51CB0C4CECD;
	Wed,  4 Dec 2024 16:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733328453;
	bh=pCvMz5PktIzh9299IaK+tWADNPBRGAPiWFvfw/iZ6/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MLKnTEDrLIVEDi35JWYyKo47NvjXcXlOpeczuuOksDtl03ke/9PVJ2HFth5xpmF9G
	 0DBU8FbV6/bO6DEVd75dvedq0CtinQFT/XI3gsFta4xNQTl41ZJpoZDOKVUcLHwa7k
	 XdM2FwBQ0lJfubWkz5ml45x4oUCdafg1L70NvuTXHCmjwGczGkxpFtoCwhMXnfR72d
	 iWkIG+Zpcg2VoLDlUDUN1DbFSasbl6E1DRZg0DwLgeSpjjFRlepGLr62g5+q0yARkf
	 TQ5ejfj91b8cr0dh52m/MStLR5lrlZO7/G/m6zl8gsXu/wULARbS3CAGNAQlFA+wO9
	 DicCWVO+DJEKg==
Date: Wed, 4 Dec 2024 17:07:29 +0100
From: Christian Brauner <brauner@kernel.org>
To: I Hsin Cheng <richard120310@gmail.com>
Cc: Jan Kara <jack@suse.cz>, viro@zeniv.linux.org.uk, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] file: Wrap locking mechanism for f_pos_lock
Message-ID: <20241204-entrollt-nestbau-e45aada983e1@brauner>
References: <20241204092325.170349-1-richard120310@gmail.com>
 <20241204102644.hvutdftkueiiyss7@quack3>
 <20241204-osterblume-blasorchester-2b05c8ee6ace@brauner>
 <20241204124829.4xpciqbz73u2e2nc@quack3>
 <Z1B2Lxxenie3SA6d@vaxr-BM6660-BM6360>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z1B2Lxxenie3SA6d@vaxr-BM6660-BM6360>

> Is it just for the inline function speed up?

Yes, very likely.

