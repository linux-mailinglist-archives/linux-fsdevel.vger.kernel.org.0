Return-Path: <linux-fsdevel+bounces-54185-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD64AFBD87
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 23:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD9AD42010B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 21:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20F2286433;
	Mon,  7 Jul 2025 21:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="PUprsLvc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F8928030C;
	Mon,  7 Jul 2025 21:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751923938; cv=none; b=ebml5HaR0aTN/lY0icGItzc9lLAT5mpoTnZhkAheuAMfCL6oFeffKP3K3ZKqEsxKXtrEq/MXvhTquZ4a2TKrOKI6Lem4MhgUAr9FOLqdoilEPP6FROuWZfScjODznFDpg4wMLCgnw9O3D44NwL8wiRGTllgIQe/8+yoq20pJk3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751923938; c=relaxed/simple;
	bh=riSfBUak/uoP1Y1iesd2NBsbnd8skuTzXZBr+DXi7/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lcX3ij7/zTvoV2vcCSNswtnec57IjToYVquJE2yAc+XetKsEhlrn6zviXO3S6cOxpm9otSmCWnieuYBR8OPdPFt7c95Kjw2jQsIrDdgzDeCh+J8bPbX4A8X7VlLJf6Jq5Wda65rIhXdLuUIn+P1U/y+WiFlf+H8P7uz3ShiMNUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=PUprsLvc; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=N4ODAoVfQaA+l9xnJUHT+/koiucpLvkQjTP7ys2N2YA=; b=PUprsLvc6SZzoNmKCkgH/JKxFB
	MDyOy9e4Sv4rmk/01wYaXMcGTekut4Kklm1l0ggJWuiuU0w9UkzaZ7ucfKvvA+qj4wmfPQnJE63je
	UPr+xoLYRaHxduv1Ps11TKTny5sNhxYBFYS1dhqOWt6T1KV5tDMQHwnB7cjpwu1iHyuz7O+bUP0qv
	GTaFuyFC7jWGKrRB4FcqFH+SSvLDqYJfQDPSdzYx0u97beUEJVZWSKvKgFm65vRPJsCTGnYqskvzu
	nkV1l/YXpJfsKe6luH8BFnFfVVPQuVDoBvA6q6f+KBIetfS6RAc1VPOX0egPuIqPQio+c0X3HuiL6
	nDjikc2Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uYtRe-00000003yIi-2nId;
	Mon, 07 Jul 2025 21:32:14 +0000
Date: Mon, 7 Jul 2025 22:32:14 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 20/21] __dentry_kill(): new locking scheme
Message-ID: <20250707213214.GM1880847@ZenIV>
References: <20250707180026.GG1880847@ZenIV>
 <CAKPOu+-QzSzUw4q18FsZFR74OJp90rs9X08gDxWnsphfwfwxoQ@mail.gmail.com>
 <20250707193115.GH1880847@ZenIV>
 <CAKPOu+_q7--Yfoko2F2B1WD=rnq94AduevZD1MeFW+ib94-Pxg@mail.gmail.com>
 <20250707203104.GJ1880847@ZenIV>
 <CAKPOu+8kLwwG4aKiArX2pKq-jroTgq0MSWW2AC1SjO-G9O_Aog@mail.gmail.com>
 <20250707204918.GK1880847@ZenIV>
 <CAKPOu+9qpqSSr300ZDduXRbj6dwQo8Cp2bskdS=gfehcVx-=ug@mail.gmail.com>
 <20250707205952.GL1880847@ZenIV>
 <CAKPOu+8zjtLkjYzCCVyyC80YgekMws4vGOvnPLjvUiQ6zWaqaA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKPOu+8zjtLkjYzCCVyyC80YgekMws4vGOvnPLjvUiQ6zWaqaA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Jul 07, 2025 at 11:06:06PM +0200, Max Kellermann wrote:
> On Mon, Jul 7, 2025 at 10:59 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > Umm...  Note that further in that loop we'll be actively stealing the stuff from that
> > shrink list that hasn't gotten to __dentry_kill().  Does your busy loop go into
> > if (data.victim) after the second d_walk()?  IOW, does it manage to pull anything out
> > of that shrink list?
> 
> No, I traced this, there is never a "data.victim" because none of the
> dentries has DCACHE_SHRINK_LIST. "data.found" is only ever incremented
> once (per loop iteration) because a "dead" lockref was found. The
> second d_walk() doesn't find anything because it doesn't look for dead
> (dying) dentries. You added that check only to the first call (only to
> select_collect(), but not to select_collect2()).
> 
> I think we're getting closer to the point I was trying to make :-)

The second d_walk() does not have the if (!data.found) break; after it.
So if your point is that we should ignore these and bail out as soon as we
reach that state, we are not getting any closer to it.

The second d_walk() is specifically about the stuff already in some other
thread's shrink list.  If it finds more than that, all the better, but the
primary goal is to make some progress in case if there's something in
another thread's shrink list they are yet to get around to evicting.

Again, what would you have it do?  The requirement is to take out everything
that has no busy descendents.

BTW, is that the same dentry all along in your reproducer?  Or does it switch
to a different dentry after a while?

