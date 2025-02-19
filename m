Return-Path: <linux-fsdevel+bounces-42030-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 344E0A3AF6D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 03:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD46A7A618E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 02:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CE317A2E0;
	Wed, 19 Feb 2025 02:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="DwaH/55c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2625D1581EE;
	Wed, 19 Feb 2025 02:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739931536; cv=none; b=jLfgxSX/eGfF7pAiwt3QU1PHk7dabcY8zspoIlFlENm3ExFdfGncN8o77L9YKbRIpokRBtWGREtqdj1Ujw36PYOephlPN3WmXaDravKUj3ZffwpUqipxA5Sw9O8HSXwCnvdcfvbGl5bOnAbJa504s2B1A+niU/4Fc8mccpAkTzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739931536; c=relaxed/simple;
	bh=kvd/rsjTpQZKACo+ozwIkZUNt9Yj0Ftom9dSJUA+Yus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uNvkwJMRc2IORfJcv7asHp8Z/WXfuPds2cSgkMMnpT/R87MOUD0E7zWVvTTzKFyw4YfATDaUbt/b2fHyN/erMSp+DhohDcTR8Uja8XYHdrOo5iuYNBvcGwQmK556EqdkaJbG7vui0m+m6ZJHjbey3DpQU+wjJaiouTPSjP4wxV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=DwaH/55c; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gkNhSiiutV2Ef4ChSM/m1UM5ulMB1q+H7Gp3La7sS98=; b=DwaH/55cx9VmUnJuJ2HX1D7IGE
	ePkmeRAt7Jhy+D9oqPnwKMcJq4v2tmUFrl6oGjXCf7CpQVb4wRRmhwvVDWChpea58+bHRoWt2f1n7
	uhQYNw1TLOiBWXGlZqit1ZSVWn3s6mxG7amXQcL56A+v/EbExWv+zubGCaQmQK+JbucUxs8SHAkeb
	uStE+TdVsEpIKCn9Z0d2qbJtDL0MmiYKagFORunS/lHBhY2nkeToMrltjJg3IBlwYWHTmaAKKd7yG
	fQDWYB0ExMhWB07afHmT8tYk8WoqULyRPvFzIcCd2d4HJB+7MHN9msfQqyEQmcS7ZvIQsVHVTer/s
	EqATlxMA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tkZfm-00000000tMd-2QQ6;
	Wed, 19 Feb 2025 02:18:50 +0000
Date: Wed, 19 Feb 2025 02:18:50 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "luis@igalia.com" <luis@igalia.com>,
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
	"jlayton@kernel.org" <jlayton@kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"idryomov@gmail.com" <idryomov@gmail.com>
Subject: Re: [RFC] odd check in ceph_encode_encrypted_dname()
Message-ID: <20250219021850.GK1977892@ZenIV>
References: <bbc3361f9c241942f44298286ba09b087a10b78b.camel@kernel.org>
 <87frkg7bqh.fsf@igalia.com>
 <20250215044616.GF1977892@ZenIV>
 <877c5rxlng.fsf@igalia.com>
 <4ac938a32997798a0b76189b33d6e4d65c23a32f.camel@ibm.com>
 <87cyfgwgok.fsf@igalia.com>
 <2e026bd7688e95440771b7ad4b44b57ab82535f6.camel@ibm.com>
 <20250218012132.GJ1977892@ZenIV>
 <20250218235246.GA191109@ZenIV>
 <4a704933b76aa4db0572646008e929d41dd96d6e.camel@ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a704933b76aa4db0572646008e929d41dd96d6e.camel@ibm.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Feb 19, 2025 at 12:58:54AM +0000, Viacheslav Dubeyko wrote:
> On Tue, 2025-02-18 at 23:52 +0000, Al Viro wrote:
> > On Tue, Feb 18, 2025 at 01:21:32AM +0000, Al Viro wrote:
> > 
> > > See the problem?  strrchr() expects a NUL-terminated string; giving it an
> > > array that has no zero bytes in it is an UB.
> > > 
> > > That one is -stable fodder on its own, IMO...
> > 
> > FWIW, it's more unpleasant; there are other call chains for parse_longname()
> > where it's not feasible to NUL-terminate in place.  I suspect that the
> > patch below is a better way to handle that.  Comments?
> > 
> 
> Let me test the patch.

That one is on top of mainline (-rc2); the entire branch is

git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #d_name

The first commit in there is this one, then two posted earlier rebased
on top of that (without the "NUL-terminate in place" in the last one,
which is what tripped KASAN and is no longer needed due to the first
commit).

