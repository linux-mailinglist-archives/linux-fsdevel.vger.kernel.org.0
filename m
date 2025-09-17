Return-Path: <linux-fsdevel+bounces-61967-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2CD9B810FF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 18:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A8C516BCA4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 16:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D64D2FA0CC;
	Wed, 17 Sep 2025 16:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ti9NBd3R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EED2F7464
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 16:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758127314; cv=none; b=EeDJVhookK5xQ1lGszQNfwe5DXLyeMuJPDN8ZdqQ9Yl1AQxgRqsThSNUqBnEMsX9GT+QEOX6gVCS4sKw6Pjl4mYFodcVzEqnZ/q41HLBBw4EW/JG0NuRQ3EgeD35iEtlBgTlreHeoWfKbi/QVjR/OPDpgNXqnxabd4O5QuCblwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758127314; c=relaxed/simple;
	bh=8xEarUuys45KHI5+H47w4JagDl9T7jnYzzNi4HzPDWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mLGByn1kqMjuHZen2ih8pVJMH34VT1o9zID7DHS58oKHofgu6+GDEnxsTatdB/5rOUXBpAsoG3GMqcO1u8B7GgLOApIMozrdPUQ/jSWRSSpq2QtT3In87Uu0RC7uaM4xXPEunFHB3HOc8Ovq02p51UwlEaUXKvSjqHU6Wke45Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ti9NBd3R; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2PI1MFa6vJCjXnSvoDj9zTqyK//UMKXKRYdoDxQ+urg=; b=ti9NBd3R14mfCk9x48MGG6Pkyq
	dHLrGc/TFEF100L1mJ/jIdW9IjHf8j7B8CkKeKdInwGS3n/ipKB+dCZ57utcLEvvBNNgIToC8Tqwf
	3EB0j7UAG81+zhQxo6LpoZYSetVL6wtp2UibPgkFyfiKq0qngrCI1y8kbXfkJjKBAAeYIVoyyBnly
	B4D80psW7YPpX/ltRINOn9wxbFV5VVIs84taV11a9DRXkPJgpKJcBqj+/so3qxkeA1/xMJXkMma+9
	EuaJwbjq5Y4LEKMsgaiXKKHKSiA49Y6CFZAvbbcdTv1CJdPvX4pRnxTOZP7MrICMSpprPuI9GI8DV
	hvWnG2qQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyvE5-00000003sEW-09Ee;
	Wed, 17 Sep 2025 16:41:49 +0000
Date: Wed, 17 Sep 2025 17:41:48 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org,
	NeilBrown <neil@brown.name>
Subject: Re: [PATCH] fuse: prevent exchange/revalidate races
Message-ID: <20250917164148.GV39973@ZenIV>
References: <20250917153031.371581-1-mszeredi@redhat.com>
 <20250917153655.GU39973@ZenIV>
 <CAJfpegsZT4X5sZUyNd9An-LxQQAV=T1AEPUYQJUUX4bZzUwJUg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegsZT4X5sZUyNd9An-LxQQAV=T1AEPUYQJUUX4bZzUwJUg@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Sep 17, 2025 at 05:42:18PM +0200, Miklos Szeredi wrote:
> > ... and if the call of ->d_revalidate() had been with parent locked, you've
> > just got a deadlock in that case.
> 
> Why?

Because the locking order on directories is "ancestors first"; you are trying
to grab an inode that is also a directory and might be anywhere in the tree
by that point - that's precisely what you are trying to check, isn't it?

What's to prevent several threads from mutually deadlocking that way?

