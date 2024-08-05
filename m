Return-Path: <linux-fsdevel+bounces-25052-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35426948628
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 01:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D89501F21D97
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 23:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4A016D9DD;
	Mon,  5 Aug 2024 23:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="RjN3VOSk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF5D14A088;
	Mon,  5 Aug 2024 23:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722901091; cv=none; b=Qgt3ZyP1ENAYZJlzU61C3sec6AodmO9ahOQDQi6fMCaUmugPzmU7MUgb/igdUKqStWaxIv/LMgpFd0otJjDrjKa90sIOpXjm5WOCR9Pg/QB/39KgGGlfppRUer8wdMNhqH47Te7A7mLYoPhPBsvMJ+2gGiSsqeTBILW0zB2FpDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722901091; c=relaxed/simple;
	bh=QF26dv5/yomFrXq11p75nmgvVMlCM2Tdf0vamozzK/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rpJ0e8nwR7XatXxGanG98Ust9+wHmVWQwAomNu1iLi71XlpVQK3FGYjy8rnXkK+ndYwl/ka4cHypHmu3X8gSVk8Bvr+bESRb2kl31Zd7FtocI3mxbt1rQrlQodP9s2ippklgHg01KY+Flnr6fzwbo/4k+0bvohmwNw5MEp2zeWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=RjN3VOSk; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MSAmWqYkKRN/HHqstiDviuQxRLcZP+YK+4gWmisEfpw=; b=RjN3VOSk5rzbAMTVLLL3e+Kiwj
	FBwtBiR/yRsinYCy0Y0EkFq2BhZWP0M82ARExui5cgBULau48RWw1yoMGqjrrG1+3TjGtTyOfTDBq
	omTGxi4qDQ2j3Qp0Qe2WszjlXfdbAndg/zDCaVAhacI4L5+Wy7YoBQE0FY/CX+HdfrZBjr0GWu1Zl
	iHKFQvxIE1ILQNSkU8INnQal/rAZStYNULzvloOb0/mqBWN51ZYpMUby2uX0HHWBNdGTKx1VRQx5N
	aEKd2s5D6RNgwf41V8noZ3WrYVAeX+J19+d2V9EuE8Cj/v5AvregWjtCRB0G8bZv2HJz5ENpQ1hbr
	Eusbvg+g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sb7HA-00000001oAD-3xeI;
	Mon, 05 Aug 2024 23:38:04 +0000
Date: Tue, 6 Aug 2024 00:38:04 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>, jack@suse.cz,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	josef@toxicpanda.com, wojciech.gladysz@infogain.com,
	ebiederm@xmission.com, kees@kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] exec: drop a racy path_noexec check
Message-ID: <20240805233804.GI5334@ZenIV>
References: <20240805-fehlbesetzung-nilpferd-1ed58783ad4d@brauner>
 <20240805131721.765484-1-mjguzik@gmail.com>
 <20240805-denkspiel-unruhen-c0ec00f5d370@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805-denkspiel-unruhen-c0ec00f5d370@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Aug 05, 2024 at 05:35:35PM +0200, Christian Brauner wrote:
> > To my reading that path_noexec is still there only for debug, not
> > because of any security need.
> 
> I don't think it's there for debug. I think that WARN_ON_ONCE() is based
> on the assumption that the mount properties can't change. IOW, someone
> must've thought that somehow stable mount properties are guaranteed
> after may_open() irrespective of how the file was opened. And in that
> sense they thought they might actually catch a bug.

That would be a neat trick, seeing that there'd never been anything to
prevent mount -o remount,exec while something is executed on the
filesystem in question.

> But having it in there isn't wrong. In procfs permission/eligibility
> checks often are checked as close to the open as possible. Worst case
> it's something similar here. But it's certainly wrong to splat about it.

Bury it.

