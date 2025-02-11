Return-Path: <linux-fsdevel+bounces-41549-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3FDA317FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 22:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD54F3A8791
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 21:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7281326A0AF;
	Tue, 11 Feb 2025 21:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="alFWLWxq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9224C26A0AC;
	Tue, 11 Feb 2025 21:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739310008; cv=none; b=sfjarApoZXqwsJO+wZ6l41hPk8MbAZPwU6zOCa9OdfhIt+DllCtJ1uxFSEYLXa8QqUuOSNl6Kwu3LMdUURWwzDJrT0tUMrZ7tfWz10QVYbNSaMiEPefYPAWHeNU9o27TziS9WXvhZoMMDW6WSnWXuA5uiO250ifS9HVCRjp0eGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739310008; c=relaxed/simple;
	bh=giHnIo+hakgD9NRjoF3zJywYlIsmkgPB43zMZje+l5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tQ9PYtjm+l3GzKdOcT3iRrGwiiVrQt4DsNwFJTnl7ilQUDNLvXRHsBdvXn5MxCUfAvgI+wPJbBH9HRpd26Gt8EQrQFtDQxUIYu0lTeq8Q7yPcK6Hzs2g06MuljS3OFqR+U0af4nUJF3kL+y7QQ0m90dmXyJOK+jHgNRHgzFZt6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=alFWLWxq; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7Imfx4OXdUIAlFlS91dg2h2kuZIkDMJDHnsX6odgDWE=; b=alFWLWxqkJa2DWKJkj6LUtJWR4
	pzxMF6ZBfTMzesyG/S8vtda8SnB6rweMaigl0BQFyX2P8x9f+66Tl5HYC5CHQyoqY+I0ZJFbm4gfa
	RMZ+RLZcMskmuHeQlIiZjfri/OQTHHgBEgDDSPIyaYYggay2mFkVwtTIXI9xRc/ibSernJiJoIHfK
	4aVo9YwfcZ9FvuKtqbf+GDQmNo2w0OIydEruPOpKqTo6CssXoVmgUJ4y2A6QJlAcZqTJEj1arUmOA
	FGhEVTo3elrVEAqw5X5KlUwOwQZ0SoM56rDKRRsa0moE/l5G8XgzxLLHbB8X39blUfVxw/kNxYACb
	iGmfqTIA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1thxz8-0000000Azsv-2ALL;
	Tue, 11 Feb 2025 21:40:02 +0000
Date: Tue, 11 Feb 2025 21:40:02 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "idryomov@gmail.com" <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	"slava@dubeyko.com" <slava@dubeyko.com>,
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	Patrick Donnelly <pdonnell@redhat.com>
Subject: Re: [PATCH] ceph: is_root_ceph_dentry() cleanup
Message-ID: <20250211214002.GJ1977892@ZenIV>
References: <20250128011023.55012-1-slava@dubeyko.com>
 <20250128030728.GN1977892@ZenIV>
 <dfafe82535b7931e99790a956d5009a960dc9e0d.camel@ibm.com>
 <20250129011218.GP1977892@ZenIV>
 <37677603fd082e3435a1fa76224c09ab6141dc22.camel@ibm.com>
 <20250211001521.GF1977892@ZenIV>
 <01dc18199e660f7f9b9ea78c89aa0c24ba09a173.camel@ibm.com>
 <20250211190111.GH1977892@ZenIV>
 <36afe0ca1c80a97962858b81619501e5a5483fe1.camel@ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36afe0ca1c80a97962858b81619501e5a5483fe1.camel@ibm.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Feb 11, 2025 at 07:32:16PM +0000, Viacheslav Dubeyko wrote:

> > The really unpleasant question is whether ceph_handle_notrace_create() could
> > end up feeding an already-positive dentry to direct call of ceph_lookup()...
> 
> We have ceph_handle_notrace_create() call in several methods:
> (1) ceph_mknod()
> (2) ceph_symlink()
> (3) ceph_mkdir()
> (4) ceph_atomic_open()
> 
> Every time we create object at first and, then, we call
> ceph_handle_notrace_create() if creation was successful. We have such pattern:
> 
> req = ceph_mdsc_create_request(mdsc, CEPH_MDS_OP_MKNOD, USE_AUTH_MDS);
> 
> <skipped>
> 
> err = ceph_mdsc_do_request(mdsc, dir, req);
> if (!err && !req->r_reply_info.head->is_dentry)
>      err = ceph_handle_notrace_create(dir, dentry);
> 
> And ceph_lookup() has such logic:
> 
> if (d_really_is_negative(dentry)) {
>     <execute logic>
>     if (-ENOENT)
>         return NULL;
> }
> 
> req = ceph_mdsc_create_request(mdsc, op, USE_ANY_MDS);
> 
> <skipped>
> 
> err = ceph_mdsc_do_request(mdsc, NULL, req);
> 
> So, we have two different type of requests here:
> (1) ceph_mdsc_create_request(mdsc, CEPH_MDS_OP_MKNOD, USE_AUTH_MDS)
> (2) ceph_mdsc_create_request(mdsc, op, USE_ANY_MDS)
> 
> The first request creates an object on MDS side and second one checks that this
> object exists on MDS side by lookup. I assume that first request simply reports
> success or failure of object creation. And only second one can extract metadata
> from MDS side.

If only...  The first request may return that metadata, in which case we'll get
splice_dentry() called by ceph_fill_trace() when reply arrives.  Note that
calls of ceph_handle_notrace_create() are conditional.

Intent is as you've described and normally that's how it works, but that
assumes sane reply.  Which is not a good assumption to make, when it comes
to memory corruption on client...

I _think_ the conditions are sufficient.  There are 4 callers of
ceph_handle_notrace_create().  All of them require is_dentry in reply to be false;
the one in ceph_mkdir() requires both is_dentry and is_target to be false.

ceph_fill_trace() does not call splice_dentry() when both is_dentry and is_target
are false, so we are only interested in the mknod/symlink/atomic_open callers.

Past the handling of !is_dentry && !is_target case ceph_fill_trace() has
a large if (is_dentry); not a concern for us.  Next comes if (is_target) where
we deal with ceph_fill_inode(); no calls of splice_dentry() in it.

After that we have
	if (is_dentry && ....) {
		...
		splice_dentry() call possible here
		...
	} else if ((req->r_op == CEPH_MDS_OP_LOOKUPSNAP ||
		    req->r_op == CEPH_MDS_OP_MKSNAP) &&
		   test_bit(CEPH_MDS_R_PARENT_LOCKED, &req->r_req_flags) &&
		   !test_bit(CEPH_MDS_R_ABORTED, &req->r_req_flags)) {
		...
		splice_dentry() call possible here
		...
	} else if (is_dentry && ...) {
		...
	}

Since we only care about !is_dentry case, that leaves the middle
part.  LOOKUPSNAP can come from ceph_lookup() or ceph_d_revalidate(),
neither of which call ceph_handle_notrace_create().  MKSNAP comes
only from ceph_mkdir(), which _does_ call ceph_handle_notrace_create(),
but only in case !is_dentry && !is_target, so that call of splice_dentry()
is not going to happen there.

*IF* the analysis above is correct, we can rely upon the ceph_lookup()
always getting a negative dentry and that if (d_really_is_negative(dentry))
is always taken.  But I could be missing something subtle in there ;-/

