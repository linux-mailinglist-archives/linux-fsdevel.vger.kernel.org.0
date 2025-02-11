Return-Path: <linux-fsdevel+bounces-41534-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE23CA31489
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 20:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22934188AF79
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 19:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755B9262D02;
	Tue, 11 Feb 2025 19:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="SgyTaso5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9657F1F940A;
	Tue, 11 Feb 2025 19:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739300477; cv=none; b=mJ6HuH5m+a5JYG8CoqpJMJU1lP6jOM9MQChxVByF82LWst01Dr4UbcEmkYCqO0YSzWwsvz7NB3kORXOyJgtPytoTv9zOd1vi6Hg4OxcxS0W6FBK3fjuqiKvXfOo8ZrJoQplUptbUQ0lC/6zIF+31PZEzPJs9fOo2lHdi4ddMcYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739300477; c=relaxed/simple;
	bh=/79Yqk3KQQZGeiG4pViuVhO6AoXp/XXD2Qzl3tk2hS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uxOCa8OgVDxLPdFQiYlxlTMrR5lB9JgjzBRXl+H9felnNW/WmRHuBypBtziCDL+Zs4lPExvWG9eVFW8bVnzlGSvD21q493qsR8ApanuAZgf45Zu5XFQDDiXRYIq95DNnTLCzmQ28Z+aMlZxB6Bmm3rZuRr81S46nkzyD4ig552k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=SgyTaso5; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=31z/lmSFDhy443wHwwmn04prV2DC6F/73WOsgcUyySc=; b=SgyTaso5U4V7YHWKsza3+WXo6A
	LOn1uCsUMl9c5zeITypzu/+WewhF50tLaKLppsAK+y9kfT/RszJrS411fl8mD27VAR1ITskLgLoaG
	aA+2+uKKgYePKTxpEkFRK/0bb5xL5qwYE8eYH5cdMWJGDWdR/Wqf6YIE8zPoWCkeT+XnyHbOXiH0F
	NmH0/7IOcObxRDwfCjrvPPkPNT8KaJ/mpsQOjVggXp1xCE1ZOhEFhDT99/rSHVhChkRxBdD6o4/Of
	dtLhREcLoYrlPAH+u9HQxwSTec+9CDTS9TgACSh7kZ21LZgsdnOWcXfWTyqRKYQ9dLzZ5bzhup4zY
	FwWfnlEg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1thvVP-0000000Ash1-1azb;
	Tue, 11 Feb 2025 19:01:11 +0000
Date: Tue, 11 Feb 2025 19:01:11 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "idryomov@gmail.com" <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	"slava@dubeyko.com" <slava@dubeyko.com>,
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	Patrick Donnelly <pdonnell@redhat.com>
Subject: Re: [PATCH] ceph: is_root_ceph_dentry() cleanup
Message-ID: <20250211190111.GH1977892@ZenIV>
References: <20250128011023.55012-1-slava@dubeyko.com>
 <20250128030728.GN1977892@ZenIV>
 <dfafe82535b7931e99790a956d5009a960dc9e0d.camel@ibm.com>
 <20250129011218.GP1977892@ZenIV>
 <37677603fd082e3435a1fa76224c09ab6141dc22.camel@ibm.com>
 <20250211001521.GF1977892@ZenIV>
 <01dc18199e660f7f9b9ea78c89aa0c24ba09a173.camel@ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01dc18199e660f7f9b9ea78c89aa0c24ba09a173.camel@ibm.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Feb 11, 2025 at 06:01:21PM +0000, Viacheslav Dubeyko wrote:

> After some considerations, I believe we can follow such simple logic.
> Correct me if I will be wrong here. The ceph_lookup() method's responsibility is
> to "look up a single dir entry". It sounds for me that if we have positive
> dentry,
> then it doesn't make sense to call the ceph_lookup(). And if ceph_lookup() has
> been
> called for the positive dentry, then something wrong is happening.

VFS never calls it that way; ceph itself might, if ceph_handle_notrace_create()
is called with positive dentry.

> But all this logic is not about negative dentry, it's about local check
> before sending request to MDS server. So, I think we need to change the logic
> in likewise way:
> 
> if (<we can check locally>) {
>     <do check locally>
>     if (-ENOENT)
>         return NULL;
> } else {
>    <send request to MDS server>
> }
> 
> Am I right here? :) Let me change the logic in this way and to test it.

First of all, returning NULL does *not* mean "it's negative"; d_add(dentry, NULL)
does that.  What would "we can check locally" be?  AFAICS, the checks in
__ceph_dir_is_complete() and near it are doing just that...

The really unpleasant question is whether ceph_handle_notrace_create() could
end up feeding an already-positive dentry to direct call of ceph_lookup()...

