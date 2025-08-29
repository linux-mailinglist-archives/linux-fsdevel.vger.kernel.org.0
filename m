Return-Path: <linux-fsdevel+bounces-59633-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2619AB3B7B4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 11:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D54E73A287D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 09:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3053054CE;
	Fri, 29 Aug 2025 09:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dBxT2DSA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5593054C6
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Aug 2025 09:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756460992; cv=none; b=CRDYLZWzElUcpS3QD2Kt3JGh30oH492hB+ak+KYk/F9eDvOPLRM/TdjZRAidbD6Yz59R7LNCSlWbdwTJebi4y3B31+sLdJ9rckLkxSpI0lUkpiJhXycHuLxaLLvw2ZrpA7PSESznaWJ7A4YDRd64IwrhaYn0fTdCFOinq3p/uZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756460992; c=relaxed/simple;
	bh=uRaCuuYRajN2WmdnF1AzFcuyuquJNthtY0b+XCPtmrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hqDfmuEBERY8H4Mn0nrx1+kEbksHKsk8ZpA9DQ+73C2ZHONZqDpxwvdRPsCi6remYVEp8QVAqt0+GFTaxrskGX+FlU3Au5hYw7gHC4L+pfDqUuK/vJx5OhIqQKy7ZX35Mlzn3FXMvjh7okz7zpGJ+BZzkQEYCk4kkdChEuo2hPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dBxT2DSA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9619EC4CEF0;
	Fri, 29 Aug 2025 09:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756460991;
	bh=uRaCuuYRajN2WmdnF1AzFcuyuquJNthtY0b+XCPtmrQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dBxT2DSA1DzOQMepsLhVzDEYwAumjm/w9mvBnIIBUlZhhC4BhBcgdmKj5x59oZFgL
	 ZaCVUtlIxm20bTbGtg935uuwXQuGnuJ4Yyd8GuAIlwZ57ooEgsiINgkRM/YAG7hODJ
	 Onc37MZyCp6oc3A7mWVpwjfT1t4FsGzPo4a95wQuLhJo/+gkzmn0RkrI3cY1Txq0eV
	 UG5Y3W7v3Ss5ctI2IbMsgQ+fELeFOBYylO3iaMgVqEDXknXV8PGkc6+W/lOih04gvZ
	 FGTZO8KX5Kc0+SiRL+dbsLjXjR+f7O1LGuyQgpBjJkgPVJl89URM89OdzxEKAg/iLn
	 15bmXQ/MYTQIg==
Date: Fri, 29 Aug 2025 11:49:48 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH v2 14/63] mnt_set_expiry(): use guards
Message-ID: <20250829-kannen-gewogen-e9bb585ed8b7@brauner>
References: <20250828230706.GA3340273@ZenIV>
 <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
 <20250828230806.3582485-14-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250828230806.3582485-14-viro@zeniv.linux.org.uk>

On Fri, Aug 29, 2025 at 12:07:17AM +0100, Al Viro wrote:
> The reason why it needs only mount_locked_reader is that there's no lockless
> accesses of expiry lists.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

