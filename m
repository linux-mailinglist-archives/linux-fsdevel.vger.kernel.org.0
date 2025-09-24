Return-Path: <linux-fsdevel+bounces-62670-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F33B9C371
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 22:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E6E14C22A1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 20:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE292949E0;
	Wed, 24 Sep 2025 20:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="PH/8zpuX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655948F54;
	Wed, 24 Sep 2025 20:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758747455; cv=none; b=uhkcx++JsY+51HqaV+4s4RHvDxr7bFDeJcK7Sx45SpCs2AJv8vQEm/M3qTRLczT5VhT1KWgjsqaiyKBjrTIzTAVbZj2HKOSL4YFFELlu05eRJyMu8GC5+ThF03Ab3Zkdq73iZib15VrdauMI/5lhNgxdwn69QJ7pW5kZzyWqKd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758747455; c=relaxed/simple;
	bh=41yFwhiAMO6+aY7GYH7k75ZtIRhc/mDPKV8k8h7ucTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tD5a2VtvZRLUsPqkMQtgsD+i0++JhOohcuCu1/0OCou3rGGKWL+Gg5iVudX0+Zu5CY4hJIEfEVOcIDSKrayKCOI6/y8aJ3Q5lX5KB3iiKTUnf3lxNQWxmr7c8rguhSwFguN2qzz4KgCdK6nkr2JuYJkbczO9d6p6jgCdmbyZAV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=PH/8zpuX; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ygyLAPEyy5V+DqYwTMOL6GDniW51e1kFoVx5tVJGrlE=; b=PH/8zpuX7quP7b4frAlskBXE1d
	qA2uAvFFibSgXsSNyaEMdzqbQAaElrnopKYQWPr5PmmxPpRyOOpfaSMK+oLMzEHNeB6cNal9p093k
	oh4BXz8lgK6SG2uFx52AFlRIawsPVKaSePvbqPGKjOrjWtUgNQ5q9lD/s3mbExYEKMyF+jDBt5KmB
	EtNRRwGGCUdbkomM38CKZm7/dW/aN8+m+E+bLQF1Zk+NePz+llJiBQRJDVmD4U8OI/1AhzYtZFhsl
	JwpJ+REd05UYc+nN2gx0l6qOsuTRSjbfIpKkjTRNvyUe7rv+mfXwSsUIHDjdsIAKTOoFo1TNVm4R5
	3IGjGZeA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1WYM-0000000BNAB-1jba;
	Wed, 24 Sep 2025 20:57:30 +0000
Date: Wed, 24 Sep 2025 21:57:30 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Kriish Sharma <kriish.sharma2006@gmail.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, david.hunter.linux@gmail.com,
	skhan@linuxfoundation.org
Subject: Re: [PATCH] fs: doc: describe 'pinned' parameter in do_lock_mount()
Message-ID: <20250924205730.GU39973@ZenIV>
References: <20250924193611.673838-1-kriish.sharma2006@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924193611.673838-1-kriish.sharma2006@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Sep 24, 2025 at 07:36:11PM +0000, Kriish Sharma wrote:
> The kernel-doc comment for do_lock_mount() was missing a description
> for the 'pinned' parameter:
> 
>   Warning: fs/namespace.c:2772 function parameter 'pinned' not described
>   in 'do_lock_mount'
> 
> This patch adds a short description:
> 
>   @pinned: receives the pinned mountpoint
> 
> to fix the warning and improve documentation clarity.

Sigh...  There we go again...
	1.  It does not improve documentation clarity - it adds
a misleading line to an opaque chunk of text that does not match
what the function *does*.
	2.  In -next both the calling conventions and the comment
are both changed, hopefully making it more readable.
	3.  Essentially the same patch has already been posted and
discussed.

NAKed-by: Al Viro <viro@zeniv.linux.org.uk>

