Return-Path: <linux-fsdevel+bounces-51782-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0DD1ADB452
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 16:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42A433AA1A4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 14:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5AFB1DE3DB;
	Mon, 16 Jun 2025 14:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PcQLiOB8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405D92BEFFA
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jun 2025 14:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750085199; cv=none; b=kaiFS7+t7gAEjPRIPJ5UONYov+tu+JXEhnidSQSCjgmnN9cR3QxiyGnKvBNVGjKoeH0Uj4TbleeUU37cxol27+b1BB9w4F1s1Fi4Xb/lxtt0VREB9U1RQxzwXxrhvEVIfbZZH+Qn1eNiPzuJKp6M3xIRsP2JTCQxdhdNIcoJNQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750085199; c=relaxed/simple;
	bh=SFXunJ/180hu2kJCrGy+Bez16WDORcvjeLaUT5yAgGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j8A4jzfLPJeqFzGE8Pt96xvUi7oO8UUqvJ7wdNL1XhaZI3mnjwRdc03sdklLIetJqwCVvCXPlFB1OdlQ5JCUIlmP7Ix+LoFlYl+UYpsLhIN/OwTtOeZZc7WkxTSr7kfGuBt50+TI+9c7cGI2rJG3SKCIcjUl2hKjKRxdCoxylBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PcQLiOB8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDCBAC4CEF0;
	Mon, 16 Jun 2025 14:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750085199;
	bh=SFXunJ/180hu2kJCrGy+Bez16WDORcvjeLaUT5yAgGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PcQLiOB8WJ4vaq7hRyA8+w3HKgCskP5JzmykBhdB2aJ60xvEpSpC3ZwYCJiaLa3OI
	 RWjQ5sF46egu3TO47wy3MyZLS4cUVSMlKhkFmXktHO0vOhfQZCBiXQXojjheMOUbZZ
	 u6X5A7Gl+Ypy35uE57dt+gJXWLRL7wRnK2oBF8KabDvHeLnhlTIF1bCSo3w5GxcfVf
	 IkxrHqhXeL3v1OHfsuSE7A8I1vjQqXmqzdfFBQCxsHc3QFVdW/N3KsyysXXYDBVgOu
	 YUknQ0pf3Y74PvvolqJiZxjkhevCamz/DHtZp1KVszy+foiD5qAnARICTLk/ndXlTl
	 1Nzycri+9/0ag==
Date: Mon, 16 Jun 2025 16:46:35 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, neil@brown.name, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 8/8] functionfs, gadgetfs: use simple_recursive_removal()
Message-ID: <20250616-kappt-wandel-d0ae73b2a7d9@brauner>
References: <20250614060050.GB1880847@ZenIV>
 <20250614060230.487463-1-viro@zeniv.linux.org.uk>
 <20250614060230.487463-8-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250614060230.487463-8-viro@zeniv.linux.org.uk>

On Sat, Jun 14, 2025 at 07:02:30AM +0100, Al Viro wrote:
> usual mount leaks if something had been bound on top of disappearing
> files there.
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

