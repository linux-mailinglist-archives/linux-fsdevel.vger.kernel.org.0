Return-Path: <linux-fsdevel+bounces-10045-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA53484749D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 17:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EC741F224D1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 16:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8DC146913;
	Fri,  2 Feb 2024 16:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Xgnvqcrz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E1C1474C3
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Feb 2024 16:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706891046; cv=none; b=J5BXk7iIrOm8UV5eddNwTTSdMVsdRzEQ5vGx1N7hX/QmnhwHTDoz/PKLmBryd7RrfOFkxJVDnFpet10GZoOCuqifv+uq52F4BF1v+/p/JXSnIUOTnwoSl8uf2+w0aZW58LAqwsU5BQ/DGKszYGLhH7jeDbJo2gGcHsCNz9dB4wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706891046; c=relaxed/simple;
	bh=9XR3WWkxrhBHhpgEIuSuY8Scib6u0Y65xY9ar/yKwKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lf5yTcxN5e8naJZcDmq3AgAaffJmep45Mk1XBKu0CRbRYT7yJhbSMbQZp/Ry/ODhgLz/9XR4Pi3cW9Iw8aT+O+Z7OlN/E5MWz5zuI0nitM7VNNuwS8V2hKAvQCJJa4znV2J0GVR8e69Cp7ow9Iag3okRaIqlDfP+8B69FtzmqDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Xgnvqcrz; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RoPQuVP555ZjHcYb0bsEO28B5B8Z6KNQKo27mt2Vw4Q=; b=XgnvqcrzwaLIRdH7DwoalzOs/H
	suF8gwgOZE1lMLZm5JD4lq7mSePMjmu6FgZd7jXL00SjlCKzhHTdFa2b1aDT52iq415qaLpWFwrcw
	comjaFxYsuAGuLvKjrW0FcCYJksxGFoJ6mvoMnR2qSDGVoC4eR0RDoA2NQej5JcekPJX42zhDBixm
	JLnITKXgyZb4oG408DSvyLmUuzhCGYPmKDB8/SMHL5IKI7wi7ZZ2/5ZtMMpr+eXbQqvfn7xAe9271
	c8vZV9gsjejL5x35bR9Ah1Hh6CsXBMAiWUsTg9Hp8c+BE4Prlb0izdVuLa4YErQHlI0oZa2vSg4h3
	PKEIt6RQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rVwKQ-0046jg-22;
	Fri, 02 Feb 2024 16:23:46 +0000
Date: Fri, 2 Feb 2024 16:23:46 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, lsf-pc@lists.linux-foundation.org,
	Matthew Wilcox <willy@infradead.org>,
	Kent Overstreet <kent.overstreet@linux.dev>, dwmw2@infradead.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [LSF/MM/BPF TOPIC] Replacing TASK_(UN)INTERRUPTIBLE with regions
 of uninterruptibility
Message-ID: <20240202162346.GB2087318@ZenIV>
References: <CAJfpegu6v1fRAyLvFLOPUSAhx5aAGvPGjBWv-TDQjugqjUA_hQ@mail.gmail.com>
 <2701318.1706863882@warthog.procyon.org.uk>
 <CAJfpegtOiiBqhFeFBbuaY=TaS2xMafLOES=LHdNx8BhwUz7aCg@mail.gmail.com>
 <2704767.1706869832@warthog.procyon.org.uk>
 <2751706.1706872935@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2751706.1706872935@warthog.procyon.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Feb 02, 2024 at 11:22:15AM +0000, David Howells wrote:
> Miklos Szeredi <miklos@szeredi.hu> wrote:
> 
> > Just making inode_lock() interruptible would break everything.
> 
> Why?  Obviously, you'd need to check the result of the inode_lock(), which I
> didn't put in my very rough example code, but why would taking the lock at the
> front of a vfs op like mkdir be a problem?

Plenty of new failure exits to maintain?

