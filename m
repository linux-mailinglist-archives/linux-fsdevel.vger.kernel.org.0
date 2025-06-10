Return-Path: <linux-fsdevel+bounces-51147-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB3DAD303E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 10:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 676B7172E88
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 08:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CD7280CE3;
	Tue, 10 Jun 2025 08:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="XO9JCRIa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD51220699;
	Tue, 10 Jun 2025 08:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749544007; cv=none; b=CgGje8OokptjYS0qqYy943iZ8sRDKwzRXs+F2+PgDbcZltvhWJ13hpohFPuDC3TSM3MuIUfgmbDD7PQVtdGoj560RENVBDzW0Tvr6N5A1gMfLnU/ch916bmlrNYEyUPlUovLvfv0L7L8GTNi3AknAb6KTX3NNilHeZNOB392CCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749544007; c=relaxed/simple;
	bh=hsUFDBfZdSIR8tVs5pcdIO2t5Rqm3FQasO9x+5ffL/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DAchEpBKWOcwsqkveVte+0jTh0GW4ycA05ih9akmGvn+jEZD9B2FZ9hFu9MEs6H88T3yNK4sosBwGOr2WsqclrlfU46ff+prPN6PO74kYcUKtGobxwE5H7VxClIowu97GZWRxngic7rlcQqlNG3OHY8F4cr7cbWvFGH6TZOtNK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=XO9JCRIa; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gJjdNpvFM5H1GrQp90MUXelTKQKyUyiKDrJlTSfmRX4=; b=XO9JCRIaZShdY6x5O88SggXoA8
	uFwjOwHiujLn1n5A/Ig2GP3eZ6yc58fpcv27yh6+KT0HDTAD/RH/yNWXnKmnpqz90PXc9K+31X9Ju
	Je14nhoJxsqNu4OYmHRNgPbUkSvBsKstZnihAQa2KUJLcmasNsdX/hglTNt0/cmsIJNXjWrjb/MiR
	mgezfhZkeD28qsUsL2rhgoW0m+2Kl7KXku6Q2P6ysqtEyFUhJ+jKHIW6tQZyH9Q14RTecI3aPg6ZY
	B3wA0d3YKMO37MwUjWaxH1PBnUjpnQeeekmX7lUW5bnJkK6Tgco/Ubhl2yDfFnvKlZlwB+6+BSJrV
	LYsrxVbA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOuJY-00000004m5v-0CE1;
	Tue, 10 Jun 2025 08:26:36 +0000
Date: Tue, 10 Jun 2025 09:26:36 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Jan Harkes <jaharkes@cs.cmu.edu>,
	David Howells <dhowells@redhat.com>, Tyler Hicks <code@tyhicks.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Carlos Maiolino <cem@kernel.org>, linux-fsdevel@vger.kernel.org,
	coda@cs.cmu.edu, codalist@coda.cs.cmu.edu,
	linux-nfs@vger.kernel.org, netfs@lists.linux.dev,
	ecryptfs@vger.kernel.org, linux-unionfs@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] Change vfs_mkdir() to unlock on failure.
Message-ID: <20250610082636.GA1131663@ZenIV>
References: <>
 <20250609005009.GB299672@ZenIV>
 <174944652013.608730.3439111222517126345@noble.neil.brown.name>
 <20250609053442.GC299672@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609053442.GC299672@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Jun 09, 2025 at 06:34:42AM +0100, Al Viro wrote:

> I can't promise a response tonight - going down in an hour or so
> and I'd like to do enough reordering of #work.mount to be able
> to post the initial variant of at least some of that in the
> morning...

Grr...  Sorry, that took longer than I hoped - fun propagate_mnt_busy()
bug had eaten a lot of time ;-/

I'll go through your series when I get up; apologies for delay...

