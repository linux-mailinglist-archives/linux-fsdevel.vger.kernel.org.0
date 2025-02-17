Return-Path: <linux-fsdevel+bounces-41827-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D72B9A37D1C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 09:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94D291894429
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 08:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56051A2380;
	Mon, 17 Feb 2025 08:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rnVHDz4E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC5017B421;
	Mon, 17 Feb 2025 08:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739780667; cv=none; b=dVTnlpmnIAj4VANQNzkaUPWVXH8uyaHiaiZbsgr4WXxkvAuau+EGe2FM9p/EI69J7dG7OT0VjtI9iLkVCnhWKOZgqyPKzHiONMNN8SzfKiEWQ1tjZ7rWWzsHsx1G1EBEobUHTFd3ubF/llI8S2NEfrGrYLgE3jTBKd7OtEYcVCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739780667; c=relaxed/simple;
	bh=kzC2rWJn3pxTWye8A2AoSrj0peIJ4fHIOEE6DGFsjRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KqG9YrO4fOQ9KIKVYebZhbTF7jBrOsI+kDSt4V2smp0SMCoGlYJK1zZC1OuCiMf/FWOd3XzWDO9cgxTkg1GZuJKdNr+19addJODa0A6Q5xbM9eq1wQCn+eRCjeCpcuJdSXi0e6OL4myGHCqb01oGPJby/ShT2Vs26YTiLXYLECs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rnVHDz4E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 763D9C4CED1;
	Mon, 17 Feb 2025 08:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739780666;
	bh=kzC2rWJn3pxTWye8A2AoSrj0peIJ4fHIOEE6DGFsjRA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rnVHDz4EFIAU2HHn5aZmpGUtyeZMgZ5V4j3s9L7RdwctkMpGbvmjGOPGptK1ozmSD
	 pzt0uuKWygvjzw9YpX+xeBj3TGTXDEfQhtbvsiQx4N5E8q0d8rXUDirxpqoMpb7SW0
	 Wxwx1N4HllnSIoIY3HePJ0oOne6MeJTgFlScCxg2S3oKoyd6E7I98qxaomg4vXU2KG
	 tdev/hzAORXsBRvWWwycG1rWDwTj7GP7njsBgpEWvumTqfQt/rORi5ltnVHNd5ngUL
	 N80KecCGjBTS0lBlOHltZGAOd5P5GiDawqDg8oXRj4W72wrdAMafANejnYTIE5QMtD
	 DxG/RUk04MwCw==
Date: Mon, 17 Feb 2025 09:24:19 +0100
From: Christian Brauner <brauner@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, 
	Christian Brauner <christian@brauner.io>, Shuah Khan <shuah@kernel.org>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Oliver Sang <oliver.sang@intel.com>, 
	John Hubbard <jhubbard@nvidia.com>, Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Shakeel Butt <shakeel.butt@linux.dev>
Subject: Re: [PATCH v7 1/6] pidfd: add PIDFD_SELF* sentinels to refer to own
 thread/process
Message-ID: <20250217-endlich-etwas-ce9c8d815a6e@brauner>
References: <cover.1738268370.git.lorenzo.stoakes@oracle.com>
 <24315a16a3d01a548dd45c7515f7d51c767e954e.1738268370.git.lorenzo.stoakes@oracle.com>
 <gij5nh63s73dj5u33uvzl5lbmsvoh6zr5xnqpnfltwi6aamy7j@47iop2wgtdac>
 <dfbeb51e-f6ce-4cdf-9b91-a7d4f5e995dc@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dfbeb51e-f6ce-4cdf-9b91-a7d4f5e995dc@lucifer.local>

On Tue, Feb 11, 2025 at 03:45:20PM +0000, Lorenzo Stoakes wrote:
> On Tue, Feb 11, 2025 at 04:24:07PM +0100, Michal Koutný wrote:
> > On Thu, Jan 30, 2025 at 08:40:26PM +0000, Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
> > >
> > > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > ---
> > >  include/uapi/linux/pidfd.h |  24 +++++++++
> > >  kernel/pid.c               |  24 +++++++--
> > >  kernel/signal.c            | 106 ++++++++++++++++++++++---------------
> > >  3 files changed, 107 insertions(+), 47 deletions(-)
> >
> > Practical idea, thanks.
> 
> Thanks!
> 
> >
> > > diff --git a/include/uapi/linux/pidfd.h b/include/uapi/linux/pidfd.h
> > > + * To cut the Gideon knot, for internal kernel usage, we refer to
> >
> > A nit
> > https://en.wikipedia.org/wiki/Gordian_Knot
> >
> > (if still applicable)
> 
> MY GOD. Hahaha. How embarrassing. God knows how 'Gideon' ended up
> there. Apologies to all, I appear to have had a senior moment there...
> 
> Feel free to correct Christian, unless we want to leave this as an Easter
> Egg?  :P

Everybody knows it's the "quotidian knot" that's the most challenging.

