Return-Path: <linux-fsdevel+bounces-53390-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4722BAEE50F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 18:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 915CC189D3D1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 16:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1702328FFDA;
	Mon, 30 Jun 2025 16:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="H4El+and"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803BB28DF31
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 16:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751302510; cv=none; b=WkkPpb992J/zYNS4LJPo9WKXQvecNfy2RKN79B6UM3y1AmBJeYwbewnq0+0E5whakLHPgg31VV/OAXE7VoDy5CHHbXf4a2R5r77SEzlS/jVzgDZXK3Rolt4swaivq/PfttQQHSi8rk70z6D7Ra75V6X7mdQu+FlRtKFGf9hLw/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751302510; c=relaxed/simple;
	bh=1KVbXgy/Si8L4IN861RlhBWu44HG9+kFooUIi4UYnZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nI9ZwnzEBBXW7lY45/SFG/l4KOv1/uMNp5g+oj/c2XQClTwebH/+PWunOc3YvIT/4+GFo1y1mRDLq5FGlXX3g2NRdDw1a28oKx+Gcelv51G3BKZgU5YcPjILNBg9Af4QIp2TMvHqJ3EQOiH84e9POO9VQ8moW+NXmavD4+fBM5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=H4El+and; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=25LqoNE1CayDYf8CWsGc2SKu0L+gWn+7t+uO6/OQKz4=; b=H4El+and1Z8v2Op8G8ECSKR2YK
	LDSSl7JHidY9+8Z1JomxGEkTYs1J1ErPfG20d779PpBSYoDm1eHAO2DQPvSfBc6Lm0TF00ohF0J6l
	DL7U4vnwuN8J0PZ5XE4LJOHQ40Qezx6jbcG162Mf6v+4uhzLTEIdqR3PfC1B5P60RsgeJKNlWgxSh
	rk6fbgApDu881PU1jYGBnRVpZ1NjkDdruGRoU9kMOAcGpwXDVFcOxEyDQRuBHBfWBjPHGDSDa6lBt
	0VkxYmWcfRmUM3P0o5976AteyFOG/CUkvfeKC407kg3RUU+oukO0TpOJuFf9W7G7gvanwuNC+RJsO
	DPSk5vkQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWHma-0000000COBA-3ZQM;
	Mon, 30 Jun 2025 16:55:04 +0000
Date: Mon, 30 Jun 2025 17:55:04 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, brauner@kernel.org,
	ebiederm@xmission.com, jack@suse.cz
Subject: Re: [RFC] vfs_parse_fs_string() calling conventions change (was Re:
 [PATCH v2 17/35] sanitize handling of long-term internal mounts)
Message-ID: <20250630165504.GZ1880847@ZenIV>
References: <20250628075849.GA1959766@ZenIV>
 <20250623044912.GA1248894@ZenIV>
 <20250623045428.1271612-1-viro@zeniv.linux.org.uk>
 <20250623045428.1271612-17-viro@zeniv.linux.org.uk>
 <CAHk-=wjiSU2Qp-S4Wmx57YbxCVm6d6mwXDjCV2P-XJRexN2fnw@mail.gmail.com>
 <20250623170314.GG1880847@ZenIV>
 <2085736.1751296793@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2085736.1751296793@warthog.procyon.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Jun 30, 2025 at 04:19:53PM +0100, David Howells wrote:
> Al Viro <viro@zeniv.linux.org.uk> wrote:
> 
> > Frankly, looking at that stuff...  I wonder if we should add
> > vfs_parse_fs_qstr() for "comes with length" variant and lose the length
> > argument of vfs_parse_fs_string().
> 
> Um - why use a qstr?  Does using a qstr actually gain anything much?  Why not
> just, say:
> 
> extern int vfs_parse_fs_str_len(struct fs_context *fc, const char *key,
> 				const char *value, size_t v_size);
> static inline int vfs_parse_fs_string(struct fs_context *fc, const char *key,
> 			       const char *value)
> {
> 	return vfs_parse_fs_str_len(fc, key, value, value ? strlen(value) : 0);
> }
> 
> Is any arch other than i386 limited to fewer than four register arguments?

amd64, for one, but what does that have to do with anything?  If we are parsing
mount parameters at point where one or two words on stack are critical for
stack overflow, we are fucked anyway.

It's just that qstr is the usual type for string-with-length...

