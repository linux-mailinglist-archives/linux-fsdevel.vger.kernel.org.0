Return-Path: <linux-fsdevel+bounces-20610-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4648D5FBB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 12:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CF79B21622
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 10:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB43155CB4;
	Fri, 31 May 2024 10:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cIpelTrE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A39150997;
	Fri, 31 May 2024 10:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717151331; cv=none; b=t2X+jqxz2oEJ1bVOhee9SzPLVpC7goBwgVaGa9W9T1z2jKwvkS3up8dy3omtY/OSfntqOorC26vjMY5SsPaLuPr9dXv0ER9TPEPh7HY6L870WDbhk2gMe0GdHI2n1kv0YlQC/DW9VpOk2du2111LtQRZbdxkudWZ5R/MrE07oLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717151331; c=relaxed/simple;
	bh=KB7cZUDNKLMAO8YBjAtoXYlExNlywx7Yb8mKsAAluKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kJCwjN8n/x15hJnzDa9OgzAr5ZHR72MFIfkOFYKl7SeQLbqSul07YWzQqhReOnPMyTOJ+D7YbDhOCskQOuGKzfJY9Ds39TQpzGx+vTTF76jNV+I9CfF6V9KhngkqL6T39z5ifJd0CWjqS+EzVgWm6k2qkcoxpTQnR95sD43K58M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cIpelTrE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 930E2C116B1;
	Fri, 31 May 2024 10:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717151330;
	bh=KB7cZUDNKLMAO8YBjAtoXYlExNlywx7Yb8mKsAAluKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cIpelTrE1vbY2pI4N067jdvvohc44mf5PUJCwDpi+SWltx44rFhuGRfBFXTQrOFAF
	 kkmPBy+/nrjlRzsi1RVHdtsqTz7RoeTmtAwXiq7bTRcqq6gPBAYwoxRElKqEqVqugj
	 kr1HcKuC9vuF4HCoG0hoNYqyu7DfQJjyqmhdjXQm+L0WXIDfJtTZEie6cLumqEQ8dm
	 6eISPD5/1sH43FygdmX0YHAaTbVqc4GMN3v9jdyivbuQ8tZOXEpPqfp9m2d2TI3GhR
	 DmCgIvSUjN/5i8DC/qNuykn4I9DyU6d9ehxxx+blgg0F6iCM1CF2UyNWHL3kvZE6MA
	 Lru+PtSncp43A==
Date: Fri, 31 May 2024 12:28:44 +0200
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jan Kara <jack@suse.cz>, Aleksa Sarai <cyphar@cyphar.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
	Alexander Aring <alex.aring@gmail.com>, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH RFC v2] fhandle: expose u64 mount id to
 name_to_handle_at(2)
Message-ID: <20240531-beizeiten-mythisch-667a70d59a82@brauner>
References: <20240527133430.ifjo2kksoehtuwrn@quack3>
 <ZlSzotIrVPGrC6vt@infradead.org>
 <20240528-wachdienst-weitreichend-42f8121bf764@brauner>
 <ZlWVkJwwJ0-B-Zyl@infradead.org>
 <20240528-gesell-evakuieren-899c08cbfa06@brauner>
 <ZlW4IWMYxtwbeI7I@infradead.org>
 <20240528-gipfel-dilemma-948a590a36fd@brauner>
 <ZlXaj9Qv0bm9PAjX@infradead.org>
 <20240529-marzipan-verspannungen-48b760c2f66b@brauner>
 <ZlmG1Rss6gTgbSVT@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZlmG1Rss6gTgbSVT@infradead.org>

> I don't understand what you mean.  If we hand out file handles with

I don't think adding another highly privileged interface in opposition
to exposing the mount id is warranted. The new mount id exposure patch
is a performance improvement for existing use-cases to let userspace
avoid additional system calls. Because as Aleksa showed in the commit
message there's ways to make this race-free right now. The patch hasn't
gained any Acks from Amir or Jeff so it's obviously not going to get
merged. So really, I don't want another interface that goes from
arbitrary superblock to file hidden behind yet another global capability
check.

