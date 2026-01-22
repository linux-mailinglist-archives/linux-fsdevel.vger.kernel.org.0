Return-Path: <linux-fsdevel+bounces-75169-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id O+XxJCOycmnwogAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75169-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 00:26:27 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9CC6E755
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 00:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 81F3E3006110
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 23:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220713DA2C0;
	Thu, 22 Jan 2026 23:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCTlFsh/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C223D6673;
	Thu, 22 Jan 2026 23:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769124379; cv=none; b=tqjSJzgRtmhcEH/HEsLFGSlyFVBHpMY5PajtAFsUoEUgTS9jjCKdhPzt7sl5+hbmcYQMYoRv8pJkLlvsFlkGsvmOQ0RFtfgAttXFBhZ4/kJVSI6q7qfjwR1lqhd/FZQlTkPWKzYeofPHeDrKpIe0HL2tOMgL/9qH4H/Bda13oWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769124379; c=relaxed/simple;
	bh=XGFkGzSWYNYNegHCuCLWkagl8o1IXw5VGAe9BlYwAeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jfPupx9olUhOdYMx783cesvHCikcQXUO827z3QjIQtHTn2bkDrUFhwzq4dglBgGmgG+Z2vAG2xynZURJZ7bL+G5ktDgjZk72z5HAyV4WS+fjQXeZ/La0iKYFnc7DXn9HCij1g6KUFV8YfbnylAz20OC46+xORqWB7Ho/lavyXxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YCTlFsh/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13697C116C6;
	Thu, 22 Jan 2026 23:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769124378;
	bh=XGFkGzSWYNYNegHCuCLWkagl8o1IXw5VGAe9BlYwAeo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YCTlFsh/PvlHEsFrvzeBnozx61sK5QqaeiMfQ/Wc+Sop7ADqPwRPj93gz+c7Ywx9H
	 phe4+Vp6OYAWWGe6mxS5+brmNZKJfC3d7Vbnq/jXrPUWzOBB4T7rV36VoJlKzWAHX+
	 y9+fHgwFz/eFYVKvs7pcSTGBYkCGbFjNPsA6DDjo46VsA0esXG4XsE37Szqpe7KF/r
	 dDS4hFd1ILM9viLxHowpQIrUCJTa6v2yzo/wpy+X6rzn/1kfdSUklKeJfnFm8Veg5u
	 6uSHTF+uCfTCqsto2aZddrU23DQAZMcA4pvH4e+86H8Mp29o7IhPRLq/bmrwxo/1/t
	 wkfv3h+j1kuuw==
Date: Thu, 22 Jan 2026 23:26:16 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/2] f2fs: improve readahead for POSIX_FADV_WILLNEED
Message-ID: <aXKyGIH-ZuvCI6h5@google.com>
References: <20251121014202.1969909-1-jaegeuk@kernel.org>
 <aSALfvLUObUGSx-e@infradead.org>
 <aSCpzRW8mUhNnjHB@google.com>
 <aXHhFN-feFYFcKYu@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXHhFN-feFYFcKYu@infradead.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75169-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jaegeuk@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2A9CC6E755
X-Rspamd-Action: no action

On 01/22, Christoph Hellwig wrote:
> On Fri, Nov 21, 2025 at 06:05:01PM +0000, Jaegeuk Kim wrote:
> > On 11/20, Christoph Hellwig wrote:
> > > On Fri, Nov 21, 2025 at 01:42:01AM +0000, Jaegeuk Kim wrote:
> > > > This patch boosts readahead for POSIX_FADV_WILLNEED.
> > > 
> > > How?  That's not a good changelog.
> > > 
> > > Also open coding the read-ahead logic is not a good idea.  The only
> > > f2fs-specific bits are the compression check, and the extent precaching,
> > > but you surely should be able to share a read-ahead helper with common
> > > code instead of duplicating the logic.
> > 
> > Ok, let me try to write up and post a generic version of the changes.
> 
> Did this go anywhere?

Here.

https://lore.kernel.org/lkml/20251202013212.964298-1-jaegeuk@kernel.org/

