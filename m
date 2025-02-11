Return-Path: <linux-fsdevel+bounces-41491-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE796A2FEEC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 01:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A6DB166DF5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 00:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751F617BD9;
	Tue, 11 Feb 2025 00:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="A6H+qCsz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C227526460F;
	Tue, 11 Feb 2025 00:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739232929; cv=none; b=QHvhzJDx4dhjjzI3QzAzXkh1U/TBRGvyyeTcx+5GypVNISoV+aLYgNk/K+W4bM5IHVxICfLL4KqT405u2BILgrG7On8F6DCuy7/Y1M1FOeeC5BiSl4COOEHp2VEV6elygtkS5JLOzkmCe+6W6eafttoli+UZNLMiwZqDIrH92GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739232929; c=relaxed/simple;
	bh=Kkh9ENYkDn7+pV582waw4jLys24NqsSErFY1Z4+1K5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kkIXdDQodd18wnaQG+QrD4XSaqYdG/Av0f68vC/FXYGgdjehZDKue0ovwXX8tYoSjO3Iq7a0YJfOMJzaCMA3uUiybAXj46ZK0HJH1rhKYMhEwjmIgpAVRJAUyCQo29pSMlqYxwXpnENs5xFzCUJdHWIpU7KXgV4aoU9zAtw7hBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=A6H+qCsz; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4vrhmXgJ4ij1/0IObGk+M+clUIUoEZzTS8/qHoLybNs=; b=A6H+qCszP2Ol0Z41lgydy8R/Fd
	9v92fudV1Ptdyq3LRSwqjSIfc28J2HLBLpNx8Cem7Pv/XqNwGet7Yt0mAD2Yyw5WsDFjsN69+NJUE
	xtgFBlrcKARyEFvRPgQpug+Turu1zgODxUT6t/BIOcWvu/kBMESsHoiSvf08lfZSJvczNZWWFHu6a
	5F+HAL3jM5UVjTUnYm3O4A2Xexsrp5HCoF7rUzTl4BnEm+qmLmMYLjmtde/SgToQTvR3H8dmlg7GH
	XMVgZGbwQiEWVDXl1Gh8Wy5+VHTgIlJ8Uu0LTw2tklekOJZPLx6YnbtffnxcreVEDsHdwlz7v0qyf
	g+NouxGQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1thdvt-00000009zA3-2jY7;
	Tue, 11 Feb 2025 00:15:21 +0000
Date: Tue, 11 Feb 2025 00:15:21 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "idryomov@gmail.com" <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	"slava@dubeyko.com" <slava@dubeyko.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
	Patrick Donnelly <pdonnell@redhat.com>
Subject: Re: [PATCH] ceph: is_root_ceph_dentry() cleanup
Message-ID: <20250211001521.GF1977892@ZenIV>
References: <20250128011023.55012-1-slava@dubeyko.com>
 <20250128030728.GN1977892@ZenIV>
 <dfafe82535b7931e99790a956d5009a960dc9e0d.camel@ibm.com>
 <20250129011218.GP1977892@ZenIV>
 <37677603fd082e3435a1fa76224c09ab6141dc22.camel@ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37677603fd082e3435a1fa76224c09ab6141dc22.camel@ibm.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Feb 11, 2025 at 12:08:21AM +0000, Viacheslav Dubeyko wrote:

> In general, the MDS can issue NULL dentries to clients so that  they "know" the
> direntry does not exist without having some capability (or lease) associated
> with it. As far as I can see, if application repeatedly does stat of file, then
> the kernel driver isn't repeatedly going out to the MDS to lookup that file. So,
> I assume that this is the goal of this check and logic.

Er...  On repeated stat(2) you will get ->lookup() called the first time around;
afterwards you'll be getting dentry from dcache lookup.  With ->d_revalidate()
each time you find it in dcache, and eviction if ->d_revalidate() says it's stale.
In which case a new dentry will be allocated and fed to ->lookup(), passed to
it in negative-unhashed state...

