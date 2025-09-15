Return-Path: <linux-fsdevel+bounces-61343-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6A8B579D8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 14:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32CB13A1296
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 12:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B36303C88;
	Mon, 15 Sep 2025 12:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qdl7LnKP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77AE1D9346
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 12:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757937897; cv=none; b=hYA209+z9K/NldEpLmEVka1TcHCZpsZo9VANBkE8UTF6PvjcJ39cd5nNFN5uu6blYogmevdFZz5dJ8dOmD+vbNbX2jNrbSVUyJyEUyN6rCTv/hNxXd7PgTXRKgnghkXMktodGL0KMXPcQ6s3Ijm5U6F625fHl9MZck/tShinTf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757937897; c=relaxed/simple;
	bh=OOzRguSdMRRTfHTkwrODQtCWpsSGD75LQMJv3rgJ+cw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QBaK0upf2624pnNEa0u/FJMMWm9SUY1wDKeToaGLSFcbE6975qeaGiQaO2rzZGxhCnX1iVz4ZdSqot5eh5TAFHsydAn6cM3a6191zqj8lKufoO87qdmHEIVGtiH3xpaBfqYrQ83sJWHqs/ZqKLAFkpozH/NXs3Y53np9VTcDOFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qdl7LnKP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E5ADC4CEF5;
	Mon, 15 Sep 2025 12:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757937897;
	bh=OOzRguSdMRRTfHTkwrODQtCWpsSGD75LQMJv3rgJ+cw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qdl7LnKPtHCMq0sgC8XViB0GCfAz/h5fDTpIeIgfV0aiiVWlOXY4HmUOPFM/q/5ks
	 yufCminIyT7sPjDyiAseGG1z413XWG29Q4GHrNEsNlNguA+z5AOB3cUtXIrsd7hefa
	 oYLFB+yejpqEN4KHtozjGvkipreATC4xlhPMYWCQbc9yWYbYmS9ncFeH+mGQDxvRt4
	 v0eepo1Qjele674q9DBUEBxU5rQ5BNZV0aOC8HRLMcnkEkJ/h3hLR9oSpzTg7YszQt
	 9UySc1KEoNedniAP1y7qyhFIOoVr/D77RXqWuxwtn5hjJg4uMTQrR2NOqV4+HfcnZG
	 pBzm0bm1coTJg==
Date: Mon, 15 Sep 2025 14:04:53 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org, amir73il@gmail.com, chuck.lever@oracle.com, 
	linkinjeon@kernel.org, john@apparmor.net
Subject: Re: [PATCH 14/21] ovl_ensure_verity_loaded(): constify datapath
 argument
Message-ID: <20250915-karawane-verachten-c69e6c570a10@brauner>
References: <20250906090738.GA31600@ZenIV>
 <20250906091137.95554-1-viro@zeniv.linux.org.uk>
 <20250906091137.95554-14-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250906091137.95554-14-viro@zeniv.linux.org.uk>

On Sat, Sep 06, 2025 at 10:11:30AM +0100, Al Viro wrote:
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

