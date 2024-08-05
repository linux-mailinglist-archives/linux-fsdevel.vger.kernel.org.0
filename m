Return-Path: <linux-fsdevel+bounces-25053-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CD8948643
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 01:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9119F1F234D0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 23:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02F516EB40;
	Mon,  5 Aug 2024 23:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="azsK131+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FC5273FD;
	Mon,  5 Aug 2024 23:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722901275; cv=none; b=PqTKL9axaIKVKxK4Vk5oyDvOkyewW14V+2TwQRUXZucWvpnC+AIWWmKr7SPd6XsMcxSKAGJlt1zBZOoxOALcGS/pj95p2Ucng7ZK4QNL65NPLT35jawXlfEdwPhDji4q/EfkGZRxnpxQeQyFOmZFDtWgICKrIh+EcHsQjpUCDtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722901275; c=relaxed/simple;
	bh=M/85eNeKlOQKxLNPugfN0fBJ3BNOJplBWoCpc0ICvZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XUbzuU8+zxOcBGDVsZ4+/4fhbmB9qL/xh6zQoCEkXZwHNnokoi9LeqnRwFJnlRReMgH6qN4FoR0c6dZumlddtnqfPNZpdy6/odlh5cfH1UdQk3S0A/c19J7WDv3PGzDDCrLl4XVT9RJIY+WRdnoUptbMuS1dJsSm3Yd8s5wZL2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=azsK131+; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=o6ElRjCjdhbSKkC6GaOJj1DTB8cP+GYths66ADQnGcM=; b=azsK131+5a9nUcew20guZCZGf0
	C4LOi+zDdEFPbzoX/C8puWRt5rJzF5ynSaqigSdeo27M9DrsZ92EAbbjYC6P1kq/ay1K15xLO98ZU
	xUx1G1drnetY7vtBxdTORWIPKcECCQ94MNzmljlGu2UZOlQFefJjmUPBylSoM+mw2QOvhgRNGazxN
	BdgswrETh+IfjnzEEsENSNMb1I7WZdkBs9ILgyQ6stdwWFsTqZHEB2svjEeRGEygSxPaVR4cYDEc+
	w10U/4hkQijx+Ot4SntCszhydhe3sOBjqeJbQVFMrLQsJzQHhcC5fbQBZmxZ/VKmEfn3HN69yd8jH
	cIeE39uQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sb7KA-00000001oCy-4Bi4;
	Mon, 05 Aug 2024 23:41:11 +0000
Date: Tue, 6 Aug 2024 00:41:10 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>, jack@suse.cz,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	josef@toxicpanda.com, wojciech.gladysz@infogain.com,
	ebiederm@xmission.com, kees@kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] exec: drop a racy path_noexec check
Message-ID: <20240805234110.GJ5334@ZenIV>
References: <20240805-fehlbesetzung-nilpferd-1ed58783ad4d@brauner>
 <20240805131721.765484-1-mjguzik@gmail.com>
 <20240805-denkspiel-unruhen-c0ec00f5d370@brauner>
 <20240805233804.GI5334@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805233804.GI5334@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Aug 06, 2024 at 12:38:04AM +0100, Al Viro wrote:
> On Mon, Aug 05, 2024 at 05:35:35PM +0200, Christian Brauner wrote:
> > > To my reading that path_noexec is still there only for debug, not
> > > because of any security need.
> > 
> > I don't think it's there for debug. I think that WARN_ON_ONCE() is based
> > on the assumption that the mount properties can't change. IOW, someone
> > must've thought that somehow stable mount properties are guaranteed
> > after may_open() irrespective of how the file was opened. And in that
> > sense they thought they might actually catch a bug.
> 
> That would be a neat trick, seeing that there'd never been anything to
> prevent mount -o remount,exec while something is executed on the
                           noexec, obviously...

