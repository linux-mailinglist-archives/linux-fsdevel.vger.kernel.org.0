Return-Path: <linux-fsdevel+bounces-43787-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB89FA5D84E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 09:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95ACD189CEFE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 08:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6102356B1;
	Wed, 12 Mar 2025 08:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IPIxNrN/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAD41E260C;
	Wed, 12 Mar 2025 08:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741768524; cv=none; b=XOg286h4jWk2XoNH1oagqdDQ9Fzcpmkfsou/txWndxo1k9PRzPp1h9Iq0lDGTLbZc0lHju6s/iAUvP8YTYCpKu+r2JkFB7BzC1dgGEhcno7bvnTVhJo3dW+7uARE1X51tx2Aju9oaV8y7AUyUN2cLH/Kz3e80OI/w7HzdpB3n0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741768524; c=relaxed/simple;
	bh=cjlL9nNN2yPGP/kloooKrkaWMEAFVfhowW7F0NqhLy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kp4Xoa32U8RDkRME0fmubqt8LG1CN3viw8j02qqXaoYcY4VjYnc3SeR0Jo0jeXA2nTOsOQdDzA2EYZisHfcp/4wqXlhsZ+DGKUDLCWhI8riA9P6e86kPdvevf7OW9jWOKyjfFfh2KfWVuUr0h2x7zqLwvlzniJus0uN0A0xcxe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IPIxNrN/; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=beUqkLQd1QVbxP8uqlvFsRgB3x+ojLfHpVlLDx3r8Ow=; b=IPIxNrN/ZKMiyqQBuEMM2Po15Q
	IX6MvnGGuhTaB4pYM1LVywOrcrMjIbo4ZdiF+QEpBx00+AUO0nPZeaOV9BGdQktnWIIDzSCh2fSKh
	yGAiWFMFxZJb44AMBU38iTNbLbIkh5IaoF/PzhCAQyQJb/oEgdwpX8dwxWsRoxVaiiiPNaIcyE/Jv
	PCtyrjcLpT+c3wTnZK0HhacYp1J5rj+V9cH0qLvfP6DEp4fKfY+7atbSbqENP9WFjLEIjuguqO6sN
	70N+OnJQL7nXtP0NXfg88zGlKpQKM3MOTcjJHssBlAEkJszR+QL10CT4x11LG11mgAutgdVuVh8hJ
	pXPxn/EA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tsHYh-00000007qNV-0xM2;
	Wed, 12 Mar 2025 08:35:23 +0000
Date: Wed, 12 Mar 2025 01:35:23 -0700
From: Christoph Hellwig <hch@infradead.org>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>, brauner@kernel.org,
	djwong@kernel.org, cem@kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com
Subject: Re: [PATCH v5 03/10] xfs: Refactor xfs_reflink_end_cow_extent()
Message-ID: <Z9FHSyZ7miJL7ZQM@infradead.org>
References: <20250310183946.932054-1-john.g.garry@oracle.com>
 <20250310183946.932054-4-john.g.garry@oracle.com>
 <Z9E2kSQs-wL2a074@infradead.org>
 <589f2ce0-2fd8-47f6-bbd3-28705e306b68@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <589f2ce0-2fd8-47f6-bbd3-28705e306b68@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Mar 12, 2025 at 08:27:05AM +0000, John Garry wrote:
> On 12/03/2025 07:24, Christoph Hellwig wrote:
> > On Mon, Mar 10, 2025 at 06:39:39PM +0000, John Garry wrote:
> > > Refactor xfs_reflink_end_cow_extent() into separate parts which process
> > > the CoW range and commit the transaction.
> > > 
> > > This refactoring will be used in future for when it is required to commit
> > > a range of extents as a single transaction, similar to how it was done
> > > pre-commit d6f215f359637.
> > 
> > Darrick pointed out that if you do more than just a tiny number
> > of extents per transactions you run out of log reservations very
> > quickly here:
> > 
> > https://urldefense.com/v3/__https://lore.kernel.org/all/20240329162936.GI6390@frogsfrogsfrogs/__;!!ACWV5N9M2RV99hQ!PWLcBof1tKimKUObvCj4vOhljWjFmjtzVHLx9apcU5Rah1xZnmp_3PIq6eSwx6TdEXzMLYYyBfmZLgvj$
> > 
> > how does your scheme deal with that?
> > 
> The resblks calculation in xfs_reflink_end_atomic_cow() takes care of this,
> right? Or does the log reservation have a hard size limit, regardless of
> that calculation?

The resblks calculated there are the reserved disk blocks and have
nothing to do with the log reservations, which comes from the
tr_write field passed in.  There is some kind of upper limited to it
obviously by the log size, although I'm not sure if we've formalized
that somewhere.  Dave might be the right person to ask about that.


