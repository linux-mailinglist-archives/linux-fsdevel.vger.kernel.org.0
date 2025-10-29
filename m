Return-Path: <linux-fsdevel+bounces-66315-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BAAC1B7AF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 15:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 43CA234B053
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 14:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DFBA3358DA;
	Wed, 29 Oct 2025 14:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P3kOGNvK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5623358CD;
	Wed, 29 Oct 2025 14:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761749767; cv=none; b=K3yfRytE9hJYu392J5TVD8bQDXLxbimtyxps7W48NOkGlje0UGg4UwYlXfMkTvggzzAcOo0mTCb0PsSqlkO/ok/lpbpquchloOd0DCfD1Ujr/smfYtKsm3P+1QoF56uMLxQgOUk6GEto9LVFzh7xgjuhoktMw+DrHoMh8xMWFqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761749767; c=relaxed/simple;
	bh=NWQryUjSwQW73bTKY8T3e0hgWS+XmWERKd3i/Y6xVUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hNxUfP85ze4KgWovYMQhQGPtsUAmnWlPV8EX39/tsKW2q8Rvs0Qjyy262ke9Bb7vIHcmrD7Lycqen+NahmR2o+6+xEpJEhBQIVHi0uzU0RurDg3VhL8QYXYBPWVa45lQCHIukxm5MLKwWCQKw48f3gEN2QfPXVOOGZwwOJhVSzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P3kOGNvK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4D57C4CEF7;
	Wed, 29 Oct 2025 14:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761749767;
	bh=NWQryUjSwQW73bTKY8T3e0hgWS+XmWERKd3i/Y6xVUc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P3kOGNvKTTaLITLdtrF8r6T+Xs78Yq4HQi6kWz236WATKXQdPp2XEX+cQxgJd/PFI
	 jDd1y56NENE0CpUW8N86hTC+2HCqI14HBpgtwmWp1l9C4MDMfu7AMSEhBBDeD87QFD
	 7EdmbNkHw6g6yC0WAp5a8LIu4RbyyZMQlm4EBheXTO9Bxb4P1RG6/3nUUu9XtdJ0c7
	 n0poN9hUAk3VUHCZ8fVd22FibYZoakHk6wVajElsV4JoUcE5pQyN6MWGHOIhR/FPA+
	 xxpHUb1k2SzFfqubY29hNkN9b8shoBOMgpW7t1G6cRuPmopl5JitHhndM5vZYFnyJ8
	 hwZeU0iHaJT+Q==
Date: Wed, 29 Oct 2025 15:56:02 +0100
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jan Kara <jack@suse.cz>, Carlos Maiolino <cem@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, willy@infradead.org, dlemoal@kernel.org, hans.holmberg@wdc.com, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: allow file systems to increase the minimum writeback chunk size
 v2
Message-ID: <20251029-zielorientiert-pritsche-eedd6964dab0@brauner>
References: <20251017034611.651385-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251017034611.651385-1-hch@lst.de>

Now queued and pushed out. Sorry for the delay.

