Return-Path: <linux-fsdevel+bounces-52831-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 328A0AE72EA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 01:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8E44178D7F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 23:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F204F260561;
	Tue, 24 Jun 2025 23:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="hQSqUdAN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2BF25D8F7;
	Tue, 24 Jun 2025 23:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750806472; cv=none; b=BUqORTuokf9ZLMP9M1qUHvJCgPOIJ1BABdgSeaP8Wi92ibI51i3SqL/eKOJGhnEh5DC7/6aKlVz+Pfx5XwYYjDpB/iEWLs+sLGNn/BJG6MKd0m5Y1ZETOdK8JdhXCzY7IrJIRyAm2NW8jZ3uExjyzjY6hE68jynftKemOE2+He4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750806472; c=relaxed/simple;
	bh=h/naYKzD1fA09CU56GMoRKJdvVgjkWnez59beqSddZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H6kdPL7yv+mVNUPgminDGgCZK82ePoAexHKMbQ1harW5PhqQYtqBjd+WeA9vDxtlFwHBgdTU/0vySbRGgdu98BhFaD+5usNdHWOKnI56zydQJFeymb3mdq73m9V8T5OjMyuVY4hSeOStZfH8BCZIEu6HZvLBYBS6bjUtieDXk6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=hQSqUdAN; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HgwwnezT3sZ3qk/0xxCmSNz299CfH1Gz16A8+DmcGRs=; b=hQSqUdANQBZw7kOuIQSfYRap92
	vKDD8P+tqS3BgjXh+ebzu0slkpfCYlEdf4LmwzmYOrlIf8R82q1PF0xDUU5aS86f2sJF9vVTh6HDh
	moskdL9PaBdQDC/NRk0niT2ZmAI74r1TcC8mt92Tpet2ruC4ZnnkYHKAk8mIaUt2uaIbCd3lf2/HX
	M1HN3L/fN8eM2qlaCmj/bUYLH7NF4vBPKN0vYvI9NjkQHCCcHaRqWyvMCRFn5PTYw+S5CAB3PkWX/
	7kt+yV0Kwv9GC+KThiCWklmkShH3XY8lW0qGkJUjoMidNXugkJKFuliDGGBxRCOdIo7FgA6gc3nAQ
	q2RqdfdQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUCjx-00000004nmE-0h9R;
	Tue, 24 Jun 2025 23:07:45 +0000
Date: Wed, 25 Jun 2025 00:07:45 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
	Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
	Simona Vetter <simona@ffwll.ch>, linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 10/11] fhandle, pidfs: support open_by_handle_at()
 purely based on file handle
Message-ID: <20250624230745.GO1880847@ZenIV>
References: <20250624-work-pidfs-fhandle-v2-0-d02a04858fe3@kernel.org>
 <20250624-work-pidfs-fhandle-v2-10-d02a04858fe3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624-work-pidfs-fhandle-v2-10-d02a04858fe3@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Jun 24, 2025 at 10:29:13AM +0200, Christian Brauner wrote:
> Various filesystems such as pidfs (and likely drm in the future) have a
> use-case to support opening files purely based on the handle without
> having to require a file descriptor to another object. That's especially
> the case for filesystems that don't do any lookup whatsoever and there's
> zero relationship between the objects. Such filesystems are also
> singletons that stay around for the lifetime of the system meaning that
> they can be uniquely identified and accessed purely based on the file
> handle type. Enable that so that userspace doesn't have to allocate an
> object needlessly especially if they can't do that for whatever reason.

Whoa...  Two notes:
	1) you really want to make sure that no _directories_ on those
filesystems are decodable.
	2) do you want to get the damn things bound somewhere?

