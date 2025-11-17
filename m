Return-Path: <linux-fsdevel+bounces-68792-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CA9C66621
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 23:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A0394348EBB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 22:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B5934AAFB;
	Mon, 17 Nov 2025 22:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="bommFxq7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44CF191F91;
	Mon, 17 Nov 2025 22:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763417067; cv=none; b=BymgiJ6tc5WZ/ld9RE1XLQsXxiDhF3DsJQ7YlyD5g59DyfLaNP3MZArY/dkrKm5VAcBMct70P6k38uEH8oAprWg27rjQBWCmGJJxpm6c/f/A3xR7E+aVR3hV/bnr7+3LXyGQXZ6XNZFo7K0wwE3pzgGPX8Niez3/wmEojBj5kGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763417067; c=relaxed/simple;
	bh=OWk69CcgDplGRjwOx6Tl5yDcCY20HqQfCP8TDdquZeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KkkyrWqB05OiBq0gYebHBRImejhyxOtY49+ACeRXETE0QLCop2Zb/xubTC8SwTun3HyFMEikzvrp4L9BZUo1woJetSrIEagLMCob7I6H7nS/xs83bSArBvBZ0XP83tv0zdRWL5TTz66ddlmtDle/0KxF9CDdPjPhS7JkwM7Dv/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=bommFxq7; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=x4vYLxHITOk7FY5Vha316u1XPKmx4CmxosD+41s+PrI=; b=bommFxq7sliAeyjvLPQEoXoIVd
	pKa5o1Yb4IZq/+Xwuf716utrTFwG+e1EsNxYWcpzPTbdpHRsyC+gnwvbW2CxCuCIULA7mQDMxwK5/
	AD9OstpSMVU2Lx+nYqPNClApquHbL/pPqjnm6CSLnpit0oArJLDk/9tAqD/lIMvZ5qr2Fe2hFo0DW
	O1QvQUtGp8okxdB0iNSpx11sF0WGBhQtqqPRzaeS3gnJrqxtzofIHkzHybBV0AkLPLWQ3z6hODug1
	LIuAWXCkHx6YuL1QuzIbhbKRobQAT7Rzt9v5JNZjbJHnm8L2IAhzA7JyTKsGV5a7GQI7nzes/1y1g
	a0CeNx3Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vL7KZ-00000007Jyi-1gmT;
	Mon, 17 Nov 2025 22:04:15 +0000
Date: Mon, 17 Nov 2025 22:04:15 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: bot+bpf-ci@kernel.org, linux-fsdevel@vger.kernel.org,
	torvalds@linux-foundation.org, brauner@kernel.org, jack@suse.cz,
	raven@themaw.net, miklos@szeredi.hu, neil@brown.name,
	a.hindborg@kernel.org, linux-mm@kvack.org,
	linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev,
	kees@kernel.org, rostedt@goodmis.org, linux-usb@vger.kernel.org,
	paul@paul-moore.com, casey@schaufler-ca.com,
	linuxppc-dev@lists.ozlabs.org, john.johansen@canonical.com,
	selinux@vger.kernel.org, borntraeger@linux.ibm.com,
	bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
	daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
	yonghong.song@linux.dev, ihor.solodrai@linux.dev,
	Chris Mason <clm@meta.com>
Subject: Re: [functionfs] mainline UAF (was Re: [PATCH v3 36/50] functionfs:
 switch to simple_remove_by_name())
Message-ID: <20251117220415.GB2441659@ZenIV>
References: <20251111065520.2847791-37-viro@zeniv.linux.org.uk>
 <20754dba9be498daeda5fe856e7276c9c91c271999320ae32331adb25a47cd4f@mail.kernel.org>
 <20251111092244.GS2441659@ZenIV>
 <e6b90909-fdd7-4c4d-b96e-df27ea9f39c4@meta.com>
 <20251113092636.GX2441659@ZenIV>
 <2025111316-cornfield-sphinx-ba89@gregkh>
 <20251114074614.GY2441659@ZenIV>
 <2025111555-spoon-backslid-8d1f@gregkh>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025111555-spoon-backslid-8d1f@gregkh>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Nov 15, 2025 at 08:21:34AM -0500, Greg Kroah-Hartman wrote:

> Ugh, messy.  But yes, this does look better, thanks for that.  Want me
> to take it through the USB tree, or will you take it through one of
> yours? (I don't remember what started this thread...)

See #work.functionfs in my tree - that patch carved up + fix for UAF
on uncancelled scheduled work.  Individual patches in followups.
If you have problems with that series, please say so.  Otherwise
I'm merging it with #work.persistence (with #36 in there updated as
posted)...

