Return-Path: <linux-fsdevel+bounces-50100-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0322AC8239
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 20:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7BEBA253C7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 18:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB12C231829;
	Thu, 29 May 2025 18:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="gMzp76L5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289BA1362;
	Thu, 29 May 2025 18:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748543810; cv=none; b=bMrazJcR8qc9G8jjbXPg9WzkUAWBhMuulY66xAbdPaqPbto8us06KvCPiYABufjivtwnzuJVqqGmNwpDqXDZpURb6Ti3Uo5LvKFo2Pci4azBzvQ6C0npPw92LAPeqNQuPqGtig/iMizbN0S0HH9T95+qZn/HrLvpRvC3HSQFnes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748543810; c=relaxed/simple;
	bh=ZT7bYnOk6X1dsatR0bpSuTKzQ1mVLcaJyvjuv6JvtwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kNIPweeg4oYY9WeIaymPAa78sKo1hx7C5jkfe1gj1xK35fVJaDGhx2QsPruSjXLKR/Uln8p62woXRMlsothw4bzCJaptxTkm8DUAJq7EX/QcNetHdHg88yIhBOhvBOTZQa8W5eGaNrDkJp6h7aWMgXfvjGMhKsWiLZQQOLYTxlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=gMzp76L5; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Xy7hQWPpKk1tX1kqDe7knuOHYDxwoPmB0XPqpxp3AUc=; b=gMzp76L55IkiIWimsFrcjEI1/u
	xJsmYwZgpLdPX4OKwjmHeb/OS6YHUCVOFQSgu+eoIpxrbIdmStCecE3qp9/2iASJiJNDnIrX5gPQZ
	DvKRCKaZ57u9PTESHnaHQpwE5zBOB5/UwJoJk7oPRnxQ2bnPknDZXcMSlh/LtDqx4hwCQ80Q4r/vJ
	N0AWl/7vVVM19Yoly4E3MWi4VMxfYfnbEdRFRCQplZVIlPwiZ25gKQchdiVmR/RMoxhOmLQ71DQ1f
	VMprwGFM9zvzProq+cA+7RPXFkdD/Dbgaq6wxZKggrqHHiRlPe1Kxqjt1okDgF2tMD+6oEj7jdT6F
	GoEiaUrg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKi7P-00000002L8S-2rdk;
	Thu, 29 May 2025 18:36:43 +0000
Date: Thu, 29 May 2025 19:36:43 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "frank.li@vivo.com" <frank.li@vivo.com>,
	"glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
	"slava@dubeyko.com" <slava@dubeyko.com>,
	"ernesto.mnd.fernandez@gmail.com" <ernesto.mnd.fernandez@gmail.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"syzbot+8c0bc9f818702ff75b76@syzkaller.appspotmail.com" <syzbot+8c0bc9f818702ff75b76@syzkaller.appspotmail.com>
Subject: Re: [PATCH v2] hfsplus: remove mutex_lock check in
 hfsplus_free_extents
Message-ID: <20250529183643.GM2023217@ZenIV>
References: <20250529061807.2213498-1-frank.li@vivo.com>
 <2f17f8d98232dec938bc9e7085a73921444cdb33.camel@ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f17f8d98232dec938bc9e7085a73921444cdb33.camel@ibm.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, May 29, 2025 at 06:34:43PM +0000, Viacheslav Dubeyko wrote:
> > diff --git a/fs/hfsplus/extents.c b/fs/hfsplus/extents.c
> > index a6d61685ae79..b1699b3c246a 100644
> > --- a/fs/hfsplus/extents.c
> > +++ b/fs/hfsplus/extents.c
> > @@ -342,9 +342,6 @@ static int hfsplus_free_extents(struct super_block *sb,
> >  	int i;
> >  	int err = 0;
> >  
> > -	/* Mapping the allocation file may lock the extent tree */
> > -	WARN_ON(mutex_is_locked(&HFSPLUS_SB(sb)->ext_tree->tree_lock));
> > -
> 
> Makes sense to me. Looks good.
> 
> But I really like your mentioning of reproducing the issue in generic/013 and
> really nice analysis of the issue there. Sadly, we haven't it in the comment. :)

Umm...  *Is* that thing safe to call without that lock?

