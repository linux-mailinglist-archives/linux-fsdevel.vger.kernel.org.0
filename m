Return-Path: <linux-fsdevel+bounces-59037-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1644FB33FB6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 14:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15B401A8404A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 12:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF9E7FBA1;
	Mon, 25 Aug 2025 12:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T1UMii2G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AE712B93
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 12:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756125570; cv=none; b=uxGVDGejfikta+8vAbo8YS5mnY/6lAA02hVW8eSzd07xtsgGzzLxUEj7W3C3ZTmS5YVCY1oZ7/9l3QGrnxkw6i4kTf494kVtUzHv7h2UoipNDers/awAbC8oo7w3rn49CrK+Cj3MXv78FXS3lOwJEZH/Z+9X138A6OKEjJF1mxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756125570; c=relaxed/simple;
	bh=ql24bBwMf5WeTavREIF/nUux+We/ujXaRlxn5vNW138=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ect09eOoxmTirxAMcCxhOqgIDd/X28YsxzSrqhL5I1NatAdyOjDTtAGSSa1G0G5tzN/zyz3iqLD/I4HnB4IltPNrQ6AbqI2P2OGwYYCbfof4sFXdyRiGRxIiIncoxz7/i+YA+jFybcO148XyltdwAxTu/iN4GxehqXqqG1MLsEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T1UMii2G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD8ABC4CEED;
	Mon, 25 Aug 2025 12:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756125569;
	bh=ql24bBwMf5WeTavREIF/nUux+We/ujXaRlxn5vNW138=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T1UMii2GuUW0psEjsOXUT5ebWj8Nw6PT5p8yPDLDW/7anASAyLhTh8XX7FXZHbZpI
	 ogIiaQvgTLMidnwBku4Ui6VzFHo8GGSz0AgFMTZKXNaiPMVa/4S5lNFejGmWBzUgPs
	 XTiKov/srfMmYQ5pQDmo1x/ywUrJmK9LaYXm3YXYNM3eF67YDYgJchSJ66IMfdNbj2
	 0CseyS/qQXI/MoGczUx8nAd/H6aoXNvmZgAqUsrpE9gvWJzs2RFiticjQbdJu6S1N9
	 vyoVuB4sbFxIVvEPkDXU3nW8IaJflPOM65ktDb1LyNm8v3rEuVvgQj0GEf4yKjf3eB
	 4a/hqycozJrcA==
Date: Mon, 25 Aug 2025 14:39:26 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 10/52] mnt_already_visible(): use guards
Message-ID: <20250825-sohlen-zerreden-83e48c24ea98@brauner>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
 <20250825044355.1541941-10-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250825044355.1541941-10-viro@zeniv.linux.org.uk>

On Mon, Aug 25, 2025 at 05:43:13AM +0100, Al Viro wrote:
> clean fit; namespace_shared due to iterating through ns->mounts.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

