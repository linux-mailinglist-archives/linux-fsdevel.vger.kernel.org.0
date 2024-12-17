Return-Path: <linux-fsdevel+bounces-37652-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A96999F54CD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 18:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27DE21891969
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 17:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A11D1F8ADD;
	Tue, 17 Dec 2024 17:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="e2OoKAAN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFBF50276;
	Tue, 17 Dec 2024 17:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734457099; cv=none; b=q1vH+/eLOrwkAQ2wzgkc4RTE0ZB0QW//Erivb0FyCVK5ItgYvkQTm3ZhyEjwl+6HZ/hf38OMbslrOA9FmoSFzHofGbzy5tLl/0KVz17mJd9BvBgUZMH6Sa3bGOeeMrnJwgPavRzHzoRobqYRt9oOuoqQs18R76Uitr5Eaw4Iwg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734457099; c=relaxed/simple;
	bh=RqLIxw+h5zWKsViM87nW2arJ/RJf3bT6BWU6QENOfzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/o8otP4OCDLWNfROPy0/mB1NtT18lh2ZTixBiZEfBF/G2AZRPMdwyl78fhK+HebfQHSFFC25rkTw+EnWNaszN8TB+EYNcOCuILAVXn6Xefa6Eud26ic7TmdqIKVQqNetSOCRNMC6+d7UfB63PO1RW1QEw4BgjTWO91a+YC8ncM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=e2OoKAAN; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=74iTgQa61eNzx/JtaTIBBgYsuHBgR7rqR7IEHxPvjDc=; b=e2OoKAANYzbM5rSDnwHgsVm69n
	/9ty0MCz/9Cz+auCMj6veYJCteeLb5HSZx23vKZ/29i1uyR0bZ7ZkNCynFrEN48zECXqncEQ7icM+
	bok36vLxNgtSlN5Dw7ydil52ab8iICczCFIY7E1IMv9JeGpKbraOeC1QxGj0O9SHYDU/APChRaisF
	107JeIdJwc8OjQzkllZLveYOfS9FDFH4+OzOdVjC1IDig17S7a5YP87ch/+DsfTCUF7vNKNVxGmBQ
	YO5ii5UpeWxrebjplxrxtqtgd29jgtzeF8XLedqaT2KcnW31KjbvO9tO7hUx9kpIXK7RQhFfUyOnm
	Q0hY548w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tNbWJ-00000009FYb-1yC6;
	Tue, 17 Dec 2024 17:38:07 +0000
Date: Tue, 17 Dec 2024 17:38:07 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Song Liu <song@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-security-module@vger.kernel.org,
	willy@infradead.org, corbet@lwn.net, clm@fb.com,
	josef@toxicpanda.com, dsterba@suse.com, brauner@kernel.org,
	jack@suse.cz, cem@kernel.org, djwong@kernel.org,
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	fdmanana@suse.com, johannes.thumshirn@wdc.com
Subject: Re: [RFC] lsm: fs: Use i_callback to free i_security in RCU callback
Message-ID: <20241217173807.GD1977892@ZenIV>
References: <20241216234308.1326841-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216234308.1326841-1-song@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

>  - Let pipe free inode from a RCU callback.

... which hurts the systems with LSM crap disabled.
NAK.

