Return-Path: <linux-fsdevel+bounces-61676-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF78B58C95
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 06:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB401488839
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 04:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DB2296BDA;
	Tue, 16 Sep 2025 03:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Rb/mbuZT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08F025332E;
	Tue, 16 Sep 2025 03:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757995193; cv=none; b=iENdt9KiRWgcBD8mzVAxN6VtXIeotuWbVMQh2fE97VBdX0ocXDcf0oKEvbCRCpKcX3vXaFaqpHJTWyQR9fFywmei3mI3XSVO9ggDpyyFdH/kIY5f92vuLH/BiP8Tiz79gJ5BXgA4kip644QEpsx9cDxEANUjSmi+dAKuw1qEaN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757995193; c=relaxed/simple;
	bh=VSnIV73Mgzl+FBvW84c8BoxGAW9B6cmdciVODnbW/pQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQ+qKbkWOP/pF4trYbwchjVT7jLIGooRlC9prSDvsK7ZKQF5UPeLbHg1BSYeqr+XXt8bvmw8b7/G1voMNnPQNY4RbycDHB/WqOMKkR8UaRhMslIxiOxFsQlJ5T1N2FCbzG8YRhiTGnst4VbjR6ELyct4/k9AImvFrO5AJ//Qfao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Rb/mbuZT; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M3Htpy/4n6yd7KglZYmnnpiUSuu+lbQhL5XHW5tEA0s=; b=Rb/mbuZTmmsjd49pJ0zBP28Dbl
	NcrqOUkZ+H+Vec5WAyNv9bShr6yhbipS73tZ9AYvAjOqG/b9pSOBue5+36fsKCM8DnjUyvmKcl6KZ
	4AGAXOqquSSIJJ1P/yO8BkhyK8hcyYE8pvphHcL+DGymR1Xis8kkWOe6NK7bEZR/yfi6v1qEeiW84
	I3JqWz6rfYTkWwyLAR8JXhafXlPzYfJk+PeMcZ0CLc+KgXOSEaSXkDPvtq4QPYnMdI59Vvz/24naa
	a7QEI6SAe9kSxQElvOVS3ioTJdDvJlwq2mCHPhnPK4f89edHlvBccxAF7RgbcNKA4PaOzYLkc/aw1
	9sJk8W7Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyMr7-00000005pRb-3p6H;
	Tue, 16 Sep 2025 03:59:50 +0000
Date: Tue, 16 Sep 2025 04:59:49 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
	Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Lennart Poettering <mzxreary@0pointer.de>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	Aleksa Sarai <cyphar@cyphar.com>, Jens Axboe <axboe@kernel.dk>,
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v2 18/33] mnt: support ns lookup
Message-ID: <20250916035949.GO39973@ZenIV>
References: <20250912-work-namespace-v2-0-1a247645cef5@kernel.org>
 <20250912-work-namespace-v2-18-1a247645cef5@kernel.org>
 <20250916035633.GM39973@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916035633.GM39973@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Sep 16, 2025 at 04:56:33AM +0100, Al Viro wrote:
> 	if (!RB_EMPTY_NODE(to_ns_common(ns)->ns_tree_node))

 	if (!RB_EMPTY_NODE(&to_ns_common(ns)->ns_tree_node))

obviously...

