Return-Path: <linux-fsdevel+bounces-51267-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7367AD5078
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 11:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B4DE176C0D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 09:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762AF242D90;
	Wed, 11 Jun 2025 09:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NWUyjvCU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74CA7081D
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 09:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749635271; cv=none; b=cDB4pcjdjEB/2zx0RMyZZs+AEffBYkvyQawTU2xd9Pw2tnHzDbrM/d4Ul+0cM41jBAqHqKpLDyLIVPcL+KNv5oTzyqoTSr+13nfYxd0h6DVLEM7wHiaR+xB7Pw32BFDps79arjv8AN3P7D1sB6XhBmWcL6TLtaBzLeY3Zgtnpg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749635271; c=relaxed/simple;
	bh=SZYZjrh6wvDkjWwr1bKqolGLVtjXaHfhP7iBoP8WqKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V2rHIy2N+5oMqgOQeL6SmvdD51qx9c4P7n8gquhlhD1MGDCRIy8DFynNtVvMAa0alpaVzBT6YUPSW0C410FYaHMtvUOuhtTHaVO4WIIvHvQouoKB2rNLDnHZOrAf0GFHOG0L7zlE5pIRoduZkiO/HxWW1VLNYrJqH9Ftec8H1x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NWUyjvCU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1162C4CEEE;
	Wed, 11 Jun 2025 09:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749635271;
	bh=SZYZjrh6wvDkjWwr1bKqolGLVtjXaHfhP7iBoP8WqKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NWUyjvCU996NgI9HvaL1q7DZxvcxlWoexcbkN/gbmlandxiJ0mDNmz12VXSKb+fhn
	 jw9u9owIxlhhrv0rB33jBB5jc1zNjbwgJFB3Jfqn/5i6FFiCMVWA0Ls5zMx+C/iE00
	 vXM9yJVtwe5FwSktHVd3Y2D2c6qsJxdSji+Rzu2vSbKNeSq+e5DM/R/iGmvmUTLHN8
	 /E19W0ITUUXNrC+yvDsPEWtafMh1n4jhWZpk0aEOMjBMz9Z36OFBc+foM8l2mjq7ii
	 HdEHJqCYO8CZmvJrRQkI1cbRk2Vd2NGG2XFAzJSnwzZzLo8S2U9+7ihFOdfN59Tc36
	 39pdkFRgh+4dg==
Date: Wed, 11 Jun 2025 11:47:46 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Neil Brown <neilb@suse.de>, Miklos Szeredi <miklos@szeredi.hu>, 
	Jan Kara <jack@suse.cz>
Subject: Re: [RFC][PATCHES v2] dentry->d_flags locking
Message-ID: <20250611-absender-substantiell-efa976a909a3@brauner>
References: <20250224010624.GT1977892@ZenIV>
 <20250224-anrief-schwester-33e6ca8774de@brauner>
 <20250611075023.GJ299672@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250611075023.GJ299672@ZenIV>

> Or are you talking about DCACHE_DONTCACHE (i.e. "unhash as soon as
> refcount hits 0", rather than "never hash it at all")?

Yes. The series is doing exactly that.

