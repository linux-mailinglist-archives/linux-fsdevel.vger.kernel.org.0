Return-Path: <linux-fsdevel+bounces-59700-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCC0B3C7EB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Aug 2025 06:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3E917C8A89
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Aug 2025 04:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430BE274B4D;
	Sat, 30 Aug 2025 04:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="qYaMOO8O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D5342049
	for <linux-fsdevel@vger.kernel.org>; Sat, 30 Aug 2025 04:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756528589; cv=none; b=V92720pztv1GZYPA+gxJmnJzLPO7esU4264AAg90H5OiNFUxsS3Ewp9W4Pa4IfGg399szCcu9RWGc2Qp7gmYlreopq0+qcgvr+R5mEZNaOfEAnomS1ozXhyv4A6rh/UClOMFbpA8f/YTYQOdx/+XsDeIEYvB7yQPlJ1IcFDxx74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756528589; c=relaxed/simple;
	bh=b3DVeL2osbdMlpsrBwm8d/rQFzezXI2Zm3OgXdIW67E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MdTPW5JepnEiZm0aZUM8X1SSpGT+3fL/GRDAGusQRmPtSqodfA1sWImkyMtedcNynN2xV7FivKX6BCyEBp1oYrgFSbaK9DTUu+7P9Yl6HoxmZSYl/2MlRXwwBq4FON8qD16INxqV8aIqwj6ejMliNIm/SBQSJ+7KgwGsi1ONAas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=qYaMOO8O; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sM7c7F/MiThsorpwOE2ZAUPCHma3SdbZfSo+0hKpULU=; b=qYaMOO8OAUwVYQQawaKsoHwKrC
	jMzGqBynr8C2tQ2YjoIToa5sH5U/zTW4V3YFxIIviG/tlkcY4uoQqaczoJflf0tQ2Uie7KcIJ7Pmx
	WT2Tu+9C2njpiNbR85NBV8313r5Y6OVt+0veVTba+lOXyr6jzZ28Fl9Wbq+IupEac70E/VyDb6B9g
	jXFjeEErrosKrB+yfmVWUZiq986SEA2BcULYYobp0gyS7rs+72zrWLOA5F4TTtqqe5t+G8wRYvSyz
	6gBMhTjl0jPlgvd9lDSTQNzINC2fWXVOzG9If2kkfVgxHLpidGgEcxTImCpZ0bz0vUXyy7LerFb4e
	e7Z0s9AA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1usDKC-000000043g9-0qE0;
	Sat, 30 Aug 2025 04:36:24 +0000
Date: Sat, 30 Aug 2025 05:36:24 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, jack@suse.cz
Subject: Re: [60/63] setup_mnt(): primitive for connecting a mount to
 filesystem
Message-ID: <20250830043624.GE39973@ZenIV>
References: <20250828230706.GA3340273@ZenIV>
 <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
 <20250828230806.3582485-61-viro@zeniv.linux.org.uk>
 <CAHk-=wgZEkSNKFe_=W=OcoMTQiwq8j017mh+TUR4AV9GiMPQLA@mail.gmail.com>
 <20250829001109.GB39973@ZenIV>
 <CAHk-=wg+wHJ6G0hF75tqM4e951rm7v3-B5E4G=ctK0auib-Auw@mail.gmail.com>
 <20250829060306.GC39973@ZenIV>
 <20250829060522.GB659926@ZenIV>
 <20250829-achthundert-kollabieren-ee721905a753@brauner>
 <20250829163717.GD39973@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829163717.GD39973@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Aug 29, 2025 at 05:37:17PM +0100, Al Viro wrote:

> It would be in v3, but I didn't feel like sending another 63-patch
> mailbomb for the sake of these 4 changed commits (well, and a cosmetical
> change in #33, with matching modification in #35, ending with both
> being cleaner - with the same resulting tree after #35).
> 
> These 4 do repace #59..#62 in v3.

Speaking of v3 - does anybody have objections to the following?
	1) allow ->show_path() to return -EOPNOTSUPP, interpreted as
"fall back to default seq_path(...)"?  E.g. kernfs_sop_show_path()
could return that if there's no ->scops->show_path().
	2) pass the sodding escape set as explicit argument, made
an argument of fs/namespace.c:show_path() as well.
	3) similar for ->show_devname().
	4) ... and to hell with those string_unescape_inplace() calls
in there.

