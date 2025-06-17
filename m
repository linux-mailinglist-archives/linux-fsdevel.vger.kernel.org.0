Return-Path: <linux-fsdevel+bounces-51983-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C827CADDE96
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 00:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 548283AE43B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 22:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB77A293B44;
	Tue, 17 Jun 2025 22:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ozdWYcD3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA5C28F926;
	Tue, 17 Jun 2025 22:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750198505; cv=none; b=esnUYZO67VBPNQlXGfiClZh+wis6i/qNjO7Wko8QePa2qNwGdFviSlb2T+n5ZcuyT9JzG6Vowsdyfd0ZS8sRqJYUc/+z+b+eYzrzfbZgWUjI7XrW7O08gBOkN+QIv7BmhUanvbT4g7G4LEkn/+H5ANBr/3CkJO1WY3THyZHieAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750198505; c=relaxed/simple;
	bh=XUeH8KN8qsKbup97BWz233wrrzmBDES39fvFo9jL/2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DMN3svmjddeZp19rSbxc/Y4WHoGoIwRE0xVYKn8cjD1PPCzl0Gd0G0WJmN1nmouuc3ZfrJtEcOSfv0Tdd5mfj43LTgW4xPL0s+JVUfKlEdNO+TvMj6wIYjvtERitDJ4ZvSbFj3YgIK0EsMxumA7LEeBzrWF/qHt+6qt6FyIrO9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ozdWYcD3; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GJWhkI7curRveMQOPZr/qbrbPARld8RKxs6RGq/nqCc=; b=ozdWYcD3S0IBMZf0xkj6HaM9hp
	wXnPxi/KYoVU026phspsqK9EFVjGm0Z6DNESlInqCdERPbJdefvwyy10IJ9S8wMl0VOeSrqHIG+hS
	jVU00sao151le8IoJ5g7+abb8DlmwcEvtJG7gC+U9YvLesC+H9thG1Pj65ymhcNb1tVmorsU048Jt
	hZaf3zRhoX+95inuodNknNg8fBuRvMOvxAQ3A6DUtKczJp2iUiPBxz/E8n6LJ6HBqoPxkPCXk8QCQ
	10g+qytuTKuh9gjd8Dc91b3IXp1GyjoAb6KAyrasW6BTzCzy/lPWdx42vW9DCWZgf1ZINkbN2EtLE
	Z2yPmvdQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRea6-00000001Yeq-0pxd;
	Tue, 17 Jun 2025 22:15:02 +0000
Date: Tue, 17 Jun 2025 23:15:02 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "idryomov@gmail.com" <idryomov@gmail.com>,
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 3/3] ceph: fix a race with rename() in
 ceph_mdsc_build_path()
Message-ID: <20250617221502.GN1880847@ZenIV>
References: <20250614062051.GC1880847@ZenIV>
 <20250614062257.535594-1-viro@zeniv.linux.org.uk>
 <20250614062257.535594-3-viro@zeniv.linux.org.uk>
 <f9008d5161cb8a7cdfed54da742939523641532d.camel@ibm.com>
 <20250617220122.GM1880847@ZenIV>
 <cd929637ed2826f25d15bad39a884fac3fd30d0c.camel@ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd929637ed2826f25d15bad39a884fac3fd30d0c.camel@ibm.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Jun 17, 2025 at 10:12:08PM +0000, Viacheslav Dubeyko wrote:
> On Tue, 2025-06-17 at 23:01 +0100, Al Viro wrote:
> > On Tue, Jun 17, 2025 at 06:21:38PM +0000, Viacheslav Dubeyko wrote:
> > 
> > > Tested-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> > > Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> > 
> > OK, tested-by/reviewed-by applied to commits in that branch, branch
> > force-pushed to the same place
> > (git.kernel.org:/pub/scm/linux/kernel/git/viro/vfs.git work.ceph-d_name-fixes)
> > 
> > Would you prefer to merge it via the ceph tree?  Or I could throw it
> > into my #for-next and push it to Linus come the next window - up to you...
> 
> Frankly speaking, your tree could be the faster way to upstream. However, I can
> push this patch set into the ceph tree for more deeper testing in the internal
> testing infrastructure. But I don't expect any serious issues in the patches
> that could introduce some bugs.
> 
> Ilya,
> 
> What is your opinion on this? Would you prefer to go through the ceph tree?

I can send a pull request to you now just as easily as I could send it to Linus
a month and a half down the road... ;-)  Up to you, guys.

