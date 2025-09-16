Return-Path: <linux-fsdevel+bounces-61675-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3530B58C8D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 05:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 205D34882F1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 03:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53D328F948;
	Tue, 16 Sep 2025 03:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="q1r+Wut+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F2223A9B3;
	Tue, 16 Sep 2025 03:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757995163; cv=none; b=rLH/l0T8GCp0MPq4k3FBI0fIlskhXiv4d5Yt5hKYh75BdHoR4KzaSk4Hd5G/34jpr5UQ2vEz50EkSYd/Wh6kMV3FpJQNBxnOdmKhygcYnbfZc1BOqKCo5AO7Im0KQ7PvKPIvJdo1Ipsod9GJxYLnrz7N7cEdYInIgdZioq3nfKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757995163; c=relaxed/simple;
	bh=TEFB7NcyFNebYngWnBWJBfVCfe6d2ur15pj5HLe2p8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k4MipENqP6bMnRS+ltH0TKA8LbpyTk+DjlXeLWx7jG3Kb1/S86SQYnNBUJOWu7Rmk4EuxhEadbnTJ5BogY7FgAc4POi9ug0KymmjFkHPj2KGbcJAHiIdHSGu+rpMWwxwKnwUiafnVtzd/7af0QApXXrVoMw9RxaTUpI1INekyHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=q1r+Wut+; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/pdmY0b0He1RnNsVjxZUrR3AN/7XyxKGX3FuPsX1Sfk=; b=q1r+Wut+6kZtQV2+Gz7t7Wdb2D
	BlSUbnKuqPhSl9AXn3JFq/2QCy517XSyAhFi4akRexMjCDKfHQnP6x12xC3msiHuzFsA2jlVcfqk2
	YiMbsE9xP7A5ge4lLCYFKMla0VTEeGQBcW+CP5iWMqsHJb7zRfYsfxgSzKXuyS307+mzcSeiCaX0T
	uUTrt9CM+UF9x5LtJiT/sSG/0D8/8bRBlqXw/Fw5uWzMLrBwHQQs3CP/vGwsQfL1OfaYmp5Myudwy
	UU2WMqCVuDnPVxOkylkIUUopUnuFPFqmOZ2yYNrQhzNkZtepyVN0kya6H2i1xSUrM/RLHuRRktsQg
	jnlufNGg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyMqb-00000005pBd-0172;
	Tue, 16 Sep 2025 03:59:17 +0000
Date: Tue, 16 Sep 2025 04:59:16 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: brauner@kernel.org, amir73il@gmail.com, axboe@kernel.dk,
	cgroups@vger.kernel.org, chuck.lever@oracle.com, cyphar@cyphar.com,
	daan.j.demeyer@gmail.com, edumazet@google.com, hannes@cmpxchg.org,
	horms@kernel.org, jack@suse.cz, jlayton@kernel.org,
	josef@toxicpanda.com, kuba@kernel.org, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-nfs@vger.kernel.org,
	me@yhndnzj.com, mkoutny@suse.com, mzxreary@0pointer.de,
	netdev@vger.kernel.org, pabeni@redhat.com, tj@kernel.org,
	zbyszek@in.waw.pl
Subject: Re: [PATCH v2 18/33] mnt: support ns lookup
Message-ID: <20250916035916.GN39973@ZenIV>
References: <20250912-work-namespace-v2-18-1a247645cef5@kernel.org>
 <20250916032806.310477-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916032806.310477-1-kuniyu@google.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Sep 16, 2025 at 03:24:07AM +0000, Kuniyuki Iwashima wrote:

See upthread; basically, that
	if (!is_anon_ns(ns))
		ns_tree_remove(ns);

should've been
        if (!RB_EMPTY_NODE(&to_ns_common(ns)->ns_tree_node))
		ns_tree_remove(ns);

