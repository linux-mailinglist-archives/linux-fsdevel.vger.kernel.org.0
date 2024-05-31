Return-Path: <linux-fsdevel+bounces-20632-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFC98D641A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 16:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6F601F27BDC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 14:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8D715CD55;
	Fri, 31 May 2024 14:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ipt8Aw2T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98731E51E;
	Fri, 31 May 2024 14:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717164731; cv=none; b=feOQy+AYUXfyxKp2C7BjBEG9F242geWjklfi5mQYVQZyGiT0xBIJ+j82hX7y+9yApXpYUi5CJHNVuhFT6A6kUWCDAC3ipSght6zBdknbV1BgpcyN+UGXXjM6uV6vRg5C37UTAp0FyiKrMPJO2Rz6DwnXwWnt19chPQTa6k+byxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717164731; c=relaxed/simple;
	bh=ltHQlzja/oVvYD/+bUKbl1gFLeTZuZ0V+xk4C4XpYsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FyqHwdBN63YXg+jbg3UzRDAHJcptL/Tr9+5LpvdMzekkb1yRj2ec5ADmNdKowpD7v39AQjdM67GEZ+nMk7Yn0Kszl2MWHhHEqVNmZo3f2rzv9daQM4JBKIHMWnb9zwdCZpYsH+iEHbOCjvR/FMOGxS497AqqhVD4+tLHro5r8Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ipt8Aw2T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56106C116B1;
	Fri, 31 May 2024 14:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717164731;
	bh=ltHQlzja/oVvYD/+bUKbl1gFLeTZuZ0V+xk4C4XpYsY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ipt8Aw2TzmRuDmdOoYNqsQiFNcBXqqFslWMSSzSYtO9O4I3VaKYWQ+xnCFBvjzFHr
	 C6G6QYYd3MsrqsAhElhOiAcShArkFaeG1I15kY2wQ5n86i7UIgKb/n2Jiv8jH9VFsk
	 vZzrtjtmtHJvGBUAN+96TQeZQ3Aff5ltpFUR0a8BkN0AawQ1NoXXQuFjSO3TLNfIQu
	 dFi+Y4EtUQxLIZ/tDW10QnAMeu1nHDh7UYuD2vjfAglRi1pXi67SGvnoKAq2M5hfok
	 Sgo1RiLAThJUSAolfcLILS88aQ9KiqhoDHNRv6N/0UC6+mmxF7o6/e8Fd42zvmS7Pf
	 jmelPNTJt6XfQ==
Date: Fri, 31 May 2024 07:12:10 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Zhang Yi <yi.zhang@huaweicloud.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	brauner@kernel.org, david@fromorbit.com, chandanbabu@kernel.org,
	jack@suse.cz, willy@infradead.org, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [RFC PATCH v4 8/8] xfs: improve truncate on a realtime inode
 with huge extsize
Message-ID: <20240531141210.GI52987@frogsfrogsfrogs>
References: <20240529095206.2568162-1-yi.zhang@huaweicloud.com>
 <20240529095206.2568162-9-yi.zhang@huaweicloud.com>
 <ZlnUorFO2Ptz5gcq@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlnUorFO2Ptz5gcq@infradead.org>

On Fri, May 31, 2024 at 06:46:10AM -0700, Christoph Hellwig wrote:
> > +/*
> > + * Decide if this file is a realtime file whose data allocation unit is larger
> > + * than default.
> > + */
> > +static inline bool xfs_inode_has_hugertalloc(struct xfs_inode *ip)
> > +{
> > +	struct xfs_mount *mp = ip->i_mount;
> > +
> > +	return XFS_IS_REALTIME_INODE(ip) &&
> > +	       mp->m_sb.sb_rextsize > XFS_B_TO_FSB(mp, XFS_DFL_RTEXTSIZE);
> > +}
> 
> The default rtextsize is actually a single FSB unless we're on a striped
> volume in which case it is increased.
> 
> I'll take care of removing the unused and confusing XFS_DFL_RTEXTSIZE,
> but for this patch we'd need to know the trade-off of when to just
> convert to unwritten.  For single-fsb rtextents we obviously don't need
> any special action.  But do you see a slowdown when converting to
> unwritten for small > 1 rtextsizes?  Because if not we could just
> always use that code path, which would significantly simplify things
> and remove yet another different to test code path.

There are <cough> some users that want 1G extents.

For the rest of us who don't live in the stratosphere, it's convenient
for fsdax to have rt extents that match the PMD size, which could be
large on arm64 (e.g. 512M, or two smr sectors).

--D

