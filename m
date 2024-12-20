Return-Path: <linux-fsdevel+bounces-37887-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1778E9F892D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 02:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 722DF16D5E6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 01:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DFB259489;
	Fri, 20 Dec 2024 01:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNJiDrbk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3E14C85;
	Fri, 20 Dec 2024 01:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734656839; cv=none; b=ArZXteQDq92GcNSZ4glyjhzhJHvVc0oth2EzUuUXidfZHtUUulcO6rJxgVoEMoEFn7FCSVnuiyEBn8/O3v41JHOr+FJLmVU836bb4xNw9na+lbU9ycM1n5ix36OMcNR7xXwHbS8PxwvBXyMtnU6Qw5kdJLHfFbQupW1V1kPR+xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734656839; c=relaxed/simple;
	bh=sMg3yiNS0/KcFfjwQhwPGmJIHHvyEy9NS1Nt89paaHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NgoDrqGOx8BipV5uxP8AVkYcGWpVyBqKMsLzTKZcOJUrN6wbTfNpMhNKIA1RgvLS7eivkIV6qZQb3js+dLK0dttjWxGDfT/VdXJsECmeWWwE0gBTfzRgGURkW3syAy56MbS9l5aZ7mIFJyaWfJjfcsEElqStQxwc3d6DUK4WuG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CNJiDrbk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 953D0C4CECE;
	Fri, 20 Dec 2024 01:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734656837;
	bh=sMg3yiNS0/KcFfjwQhwPGmJIHHvyEy9NS1Nt89paaHE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=CNJiDrbkYiRka8HQXFqYjbgggHpRUTaRqvcZLB58zaUcUns5rlBVLsjC6xaNavZPr
	 XoTW3pSyBktEaxHud7H/WwMmEvoNWkhXXIiNV9JkV7z/OOQaI0XG2mQdXgu2UQ26B5
	 o4YFb4w0u/AUH07nkNumoLb3HeLz3GSYDdZZ4Be0zxR71Ty//JMw79ZJlWZsMRT/1u
	 eEKQRHWjc3/T1HDKsJeXA26+tMJ/HB2WKnL1Kehlb1TwzZPQfuiu2pCS3IgAUTVAS3
	 iei16quFdFhs+CErro+TYTWZkFetGauZWy6aXz2+zbWG7wJH8mqXVQtSJAcmmhTTs0
	 yR3spWpsls86A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 33B3BCE0EE4; Thu, 19 Dec 2024 17:07:17 -0800 (PST)
Date: Thu, 19 Dec 2024 17:07:17 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>, jlayton@kernel.org,
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, sfr@canb.auug.org.au,
	linux-next@vger.kernel.org
Subject: Re: [PATCH RFC netfs] Fix uninitialized variable in
 netfs_retry_read_subrequests()
Message-ID: <03561ca5-df13-4b6c-8ac8-2dfe45ec2b6d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <fb54084d-6d4e-4cda-8941-addc8c8898f5@paulmck-laptop>
 <4059210.1734654011@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4059210.1734654011@warthog.procyon.org.uk>

On Fri, Dec 20, 2024 at 12:20:11AM +0000, David Howells wrote:
> Paul E. McKenney <paulmck@kernel.org> wrote:
> 
> > This should actually be considered more of a bug report than a patch.
> > 
> > Clang 18.1.8 (but not GCC 11.5.0) complains that the "subreq" local
> > variable can be used uninitialized in netfs_retry_read_subrequests(),
> > just after the abandon_after label.  This function is unusual in having
> > three instances of this local variable.  The third and last one is clearly
> > erroneous because there is a branch out of the enclosing do-while loop
> > to the end of this function, and it looks like the intent is that the
> > code at the end of this function be using the same value of the "subreq"
> > local variable as is used within that do-while loop.
> > 
> > Therefore, take the obvious (if potentially quite misguided) approach
> > of removing the third declaration of "subreq", instead simply setting
> > it to NULL.
> 
> I think you're looking at the old version of my netfs-writeback branch that's
> residing in Christian's vfs.netfs branch.  I've posted a new version of my
> branch[1] without this problem and am hoping for Christian to update the
> branch[2] so that Stephen can pull it into linux-next.

Me too, and thank you for looking into this!

							Thanx, Paul

> David
> 
> [1] https://lore.kernel.org/linux-fsdevel/20241216204124.3752367-1-dhowells@redhat.com/T/#t
> 
> [2] And hoping he'll remember to drop "[PATCH v5 26/32] Display waited-on page
> index after 1min of waiting" for me.  I forgot to remove that debugging patch.
> 

