Return-Path: <linux-fsdevel+bounces-44749-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E920A6C6B7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 01:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E6EA3B3037
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 00:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA041C695;
	Sat, 22 Mar 2025 00:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="qw+da38A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32ED171A1;
	Sat, 22 Mar 2025 00:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742603648; cv=none; b=YQ/wfc0R8GHIUFIkis8t9ORX484jRqvI7cGBUW+/0eMsO8042IqjS7wDbe1n+UhdL25LlG8osIixoecxuJ1Ec7Gjd/B00JZK877wVbhEhG+ZaES8SwcXj5lvPBT09Y8ZKpUdLPvIC5bwCVoBRtmD2f3DqWnr9r37iz+UYPo3L+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742603648; c=relaxed/simple;
	bh=w/dRm0IJu0lY6XMYSY6ulvCw2Tp5NQYkuAVoXC0Dof0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DUeuPhSlFgXUgK1LpJAW2Yd5epaJE4y97yySxNKDdVKe8drDCFW74CoYYQdacuDFj47W2/zl9pCZ9949B6dNZsyZjU/ZWb/NbcZE/QMQmv1YomC/snQAn1ie1ofhoOU/+cSIq+CQM5QKcpzxvCMyXRyz0p3hxvPOm1xQHRDUwlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=qw+da38A; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=w/dRm0IJu0lY6XMYSY6ulvCw2Tp5NQYkuAVoXC0Dof0=; b=qw+da38AvVtT/Peu4ub0Q/8vg3
	q/xvBbbAmVcrgYwg96zZDX9SmpDgC8r2MXQUd632VDerMOaJDw4rq+H2SqBEtJlc8p0Io5JQyB7nT
	kHJ66RSzfjQgOHOt7YTYwpsGsLYAFB/j6iLQdSoBBU9NrQB+HR6vX8Omx7j8gvU/80K3Y8H90PiAA
	01geuaKLT6KsNfqSW85smmgXHB5q/r5MXr+nsaRsEw7BCWrQ0JRsse4BdTV4/ccX1o38YnZ9EjjJQ
	b26U4lTqnx8LOXpPX+r4fF4bqEGZQEEBUUdFydsTbCIVdSGzA103+jHUTy1kFSjQMtzpkzKfxb+Ue
	CJZMky/g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tvmoN-0000000BClA-1R1m;
	Sat, 22 Mar 2025 00:34:03 +0000
Date: Sat, 22 Mar 2025 00:34:03 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	David Howells <dhowells@redhat.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/6] VFS: rename lookup_one_len family to lookup_noperm
 and remove permission check
Message-ID: <20250322003403.GE2023217@ZenIV>
References: <20250319031545.2999807-1-neil@brown.name>
 <20250319031545.2999807-5-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319031545.2999807-5-neil@brown.name>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Mar 19, 2025 at 02:01:35PM +1100, NeilBrown wrote:

Quite a few of those should be switched to a common helper,
lifted out of debugfs/tracefs start_creating()...

I can live with that, but it'll cause fuckloads of noise in
persistency queue... ;-/

