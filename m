Return-Path: <linux-fsdevel+bounces-59630-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27831B3B7AD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 11:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A1C8566437
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 09:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A759304BB5;
	Fri, 29 Aug 2025 09:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VM2rYt4k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FDE23F40C
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Aug 2025 09:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756460929; cv=none; b=KO/QkMOAY9zgXPQ2jwYwLv6wInGXFxlPh6TwIRE25nnhxKEg93bvbRvzeIdk22FYPtE5qaQO5lFZMhjFpGFD27Estuzp8hHbantLSlM/5dOMGNZQASTrsFwZJtGPnYZZlfuZFNLpfD8wVjqZd5NJStVoitynoOKgSp2zMoFwx34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756460929; c=relaxed/simple;
	bh=PNl20q3w0790Jp1Llmkfye2N8RUUCIO1nwyDAhMuUWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f+Hh9XpTxBIDiIDtqr6r4sl8bAy+wkV7JnwpUM4RWKwGlNgxJZFkJVNvRN2sRv2WZgpAJLnHRwRMQoNejWWMGcYbgsROmP0IKD94VRWs8zvGmal5S2Ff9NPQuSI//hATCZXMk2UD7idOFTy8+FMB8VAU2eEw7+hoAXWqj1GSBXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VM2rYt4k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E113C4CEF0;
	Fri, 29 Aug 2025 09:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756460928;
	bh=PNl20q3w0790Jp1Llmkfye2N8RUUCIO1nwyDAhMuUWI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VM2rYt4klU4PqWHBnMNAkK0RSvwqRuKB8Moc4Cy+4vtUdo0aMzrRyKUyKm6SXeYlH
	 SAuawGM9wy4xC62hDi4Fq+JQ3n2khGIdI1EW2lwYWbSfmO59hcSBHOfEi6+AnoQK8a
	 6jC+qvJYVe8pyAW3c79RMUzUXcpjQWrj5K2K9DshmID4+75AVwEEfa+Kk7fH2+vhMb
	 mTdJt54EcuYOIrQc4mrpdTxoaWuLVs/RjntwtgwhmKkGiENK9YGOl7wCmFQRFJ62ap
	 5QIEKeCnqVXnliKTWXzvTw72Y5QWtUsR4fygqVwMg8EpGFebtsEG4cZL9t+3No2Gjp
	 R9g2gh6COZMhA==
Date: Fri, 29 Aug 2025 11:48:45 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH v2 04/63] __detach_mounts(): use guards
Message-ID: <20250829-hemmung-hinzog-d97f61032db0@brauner>
References: <20250828230706.GA3340273@ZenIV>
 <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
 <20250828230806.3582485-4-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250828230806.3582485-4-viro@zeniv.linux.org.uk>

On Fri, Aug 29, 2025 at 12:07:07AM +0100, Al Viro wrote:
> Clean fit for guards use; guards can't be weaker due to umount_tree() calls.
> ---

Did you drop my earlier RvB on accident? In any case:

Reviewed-by: Christian Brauner <brauner@kernel.org>

