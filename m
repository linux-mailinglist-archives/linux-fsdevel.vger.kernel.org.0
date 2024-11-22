Return-Path: <linux-fsdevel+bounces-35578-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 822099D5F69
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 13:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 056581F21E0D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 12:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B97A1DED58;
	Fri, 22 Nov 2024 12:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OxEL1zmY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF5879FE
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Nov 2024 12:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732280269; cv=none; b=fQSw87wE+b0dwv+6+GN8wNTQrczBzsgMN8KogEVpBJ409LECX743Y7asUbP+y+7jgDsQDqvXkug0Tp6E79DcomzwzVqsyC3tSmzK8Cubhw51Ce3FABDqCO559cpCOCXj4grq6cEBu5FO3D1DTr9zKw3lHank6pK1qnDnT6iPKE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732280269; c=relaxed/simple;
	bh=Qo2CC0O3STwDZtf2M+g2/VGPeW4PTS0ANAJTSmii2Ag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gBi3lRsHO0uZSZ/WkDQS1HhDceN1LDXwC5g98ncsjnwCPaMi/kS32hMJy28Z7CLUrsTu94Ez2LsOKpqbm7vX3FTv3WjDqug023a5Ey+oENcdd8V/60TCbCI6AohUU56uX4ahC+htGI+e1P5eseOUKHaoeb6nwUAH+GgLI5+fswU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OxEL1zmY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7E08C4CECE;
	Fri, 22 Nov 2024 12:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732280268;
	bh=Qo2CC0O3STwDZtf2M+g2/VGPeW4PTS0ANAJTSmii2Ag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OxEL1zmYtki4OGvzqC98WfRqF8hqXWHtPzgw48cqT1J0mb4O15OzuHX1HP5ZHy2Yd
	 4RMeWFjcnSlPlQJXKz5gyOfFDE2IrPfyii2FvNDKO2jzvaGGfILs+AgG+e3LZuJ8Ae
	 x9OrWtjt0HeImFLtHncwqukmP8XdjNFK1D0Lx+3Fdy0EZh3Qd08o+vT6gWry/m2Hr3
	 S2VeSZ4uK0j/K3sae4J6qo+yEPSYChOLc+Dz/ChKO8ASjgU3hzY2QCa20cuRZOnY6Y
	 TXwPzwDm/WD1BSfqAji3t9yAI1nTpRldsau1ZNreyVWDqoCSe1Vay9+obULz4neuuq
	 Cz8Z813w+DVBg==
Date: Fri, 22 Nov 2024 13:57:43 +0100
From: Christian Brauner <brauner@kernel.org>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <cel@kernel.org>, 
	linux-mm <linux-mm@kvack.org>, Linux FS Devel <linux-fsdevel@vger.kernel.org>, 
	Hugh Dickens <hughd@google.com>, "yukuai (C)" <yukuai3@huawei.com>, 
	"yangerkun@huaweicloud.com" <yangerkun@huaweicloud.com>
Subject: Re: [RFC PATCH 2/2] libfs: Improve behavior when directory offset
 values wrap
Message-ID: <20241122-bauer-willst-2d418ff7ab32@brauner>
References: <20241117213206.1636438-1-cel@kernel.org>
 <20241117213206.1636438-3-cel@kernel.org>
 <c65399390e8d8d3c7985ecf464e63b30c824f685.camel@kernel.org>
 <ZzuqYeENJJrLMxwM@tissot.1015granger.net>
 <20241120-abzocken-senfglas-8047a54f1aba@brauner>
 <Zz36xlmSLal7cxx4@tissot.1015granger.net>
 <20241121-lesebrille-giert-ea85d2eb7637@brauner>
 <34F4206C-8C5F-4505-9E8F-2148E345B45E@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <34F4206C-8C5F-4505-9E8F-2148E345B45E@oracle.com>

On Thu, Nov 21, 2024 at 02:54:16PM +0000, Chuck Lever III wrote:
> 
> 
> > On Nov 21, 2024, at 3:34 AM, Christian Brauner <brauner@kernel.org> wrote:
> > 
> > On Wed, Nov 20, 2024 at 10:05:42AM -0500, Chuck Lever wrote:
> >> On Wed, Nov 20, 2024 at 09:59:54AM +0100, Christian Brauner wrote:
> >>> On Mon, Nov 18, 2024 at 03:58:09PM -0500, Chuck Lever wrote:
> >>>> 
> >>>> I've been trying to imagine a solution that does not depend on the
> >>>> range of an integer value and has solidly deterministic behavior in
> >>>> the face of multiple child entry creations during one timer tick.
> >>>> 
> >>>> We could partially re-use the legacy cursor/list mechanism.
> >>>> 
> >>>> * When a child entry is created, it is added at the end of the
> >>>>  parent's d_children list.
> >>>> * When a child entry is unlinked, it is removed from the parent's
> >>>>  d_children list.
> >>>> 
> >>>> This includes creation and removal of entries due to a rename.
> >>>> 
> >>>> 
> >>>> * When a directory is opened, mark the current end of the d_children
> >>>>  list with a cursor dentry. New entries would then be added to this
> >>>>  directory following this cursor dentry in the directory's
> >>>>  d_children list.
> >>>> * When a directory is closed, its cursor dentry is removed from the
> >>>>  d_children list and freed.
> >>>> 
> >>>> Each cursor dentry would need to refer to an opendir instance
> >>>> (using, say, a pointer to the "struct file" for that open) so that
> >>>> multiple cursors in the same directory can reside in its d_chilren
> >>>> list and won't interfere with each other. Re-use the cursor dentry's
> >>>> d_fsdata field for that.
> >>>> 
> >>>> 
> >>>> * offset_readdir gets its starting entry using the mtree/xarray to
> >>>>  map ctx->pos to a dentry.
> >>>> * offset_readdir continues iterating by following the .next pointer
> >>>>  in the current dentry's d_child field.
> >>>> * offset_readdir returns EOD when it hits the cursor dentry matching
> >>>>  this opendir instance.
> >>>> 
> >>>> 
> >>>> I think all of these operations could be O(1), but it might require
> >>>> some additional locking.
> >>> 
> >>> This would be a bigger refactor of the whole stable offset logic. So
> >>> even if we end up doing that I think we should use the jiffies solution
> >>> for now.
> >> 
> >> How should I mark patches so they can be posted for discussion and
> >> never applied? This series is marked RFC.
> > 
> > There's no reason to not have it tested.
> 
> 1/2 is reasonable to apply.
> 
> 2/2 is work-in-progress. So, fair enough, if you are applying
> for testing purposes.
> 
> 
> > Generally I don't apply RFCs
> > but this code has caused various issues over multiple kernel releases so
> > I like to test this early.
> 
> The biggest problem has been that I haven't found an
> authoritative and comprehensive explanation of how
> readdir / getdents needs to behave around renames.
> 
> The previous cursor-based solution has always been a "best
> effort" implementation, and most of the other file systems
> have interesting gaps and heuristics in this area. It's
> difficult to piece all of these together to get the idealized
> design requirements, and also a get a sense of where
> compromises can be made.
> 
> Any advice/guidance is welcome.

I didn't mean to make it sound like you did anything wrong or I was
blaming you. I was literally just trying to say we had weird behavior in
this area for legitimate reasons. Posix states this:

    If posix_getdents() is called concurrently with an operation that
    adds, deletes, or modifies a directory entry, the results from
    posix_getdents() shall reflect either all of the effects of the
    concurrent operation or none of them. If a sequence of calls to
    posix_getdents() is made that reads from offset zero to end-of-file
    and a file is removed from or added to the directory between the
    first and last of those calls, whether the sequence of calls returns
    an entry for that file is unspecified.

Which to me all reads like we're pretty much free in what to do as long
as we clearly document it.

> >> I am actually half-way through implementing the approach described
> >> here. It is not as big a re-write as you might think, and addresses
> >> some fundamental misunderstandings in the offset_iterate_dir() code.
> > 
> > Ok, great then let's see it.
> 
> I'm finishing it up now. Unfortunately I have several other
> (NFSD and not) bugs I'm working through.

No horry.

