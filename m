Return-Path: <linux-fsdevel+bounces-45843-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B63A7D8C9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 10:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECDB97A3669
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 08:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B16D22AE49;
	Mon,  7 Apr 2025 08:58:00 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E2522AE59;
	Mon,  7 Apr 2025 08:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744016280; cv=none; b=f//Ye/pOzm5+xRO4yL5GH3BAYua7HEM7mscmFEMIXovCEZKqcd6lbEfWGaSQrP2VjjVSMggrUT7D1P+0YLHlvDfbg+zPl1mRbaz2SbfE+QSUPvyCpyYx2t9NTBjBptup1KuU3zjMF3RaZLtaJ4cYrlh+5JN8NIF4mkEC9sd8dRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744016280; c=relaxed/simple;
	bh=9PQv40AXr73VKzg3AKN9kD+hmUZLTMvzTS/zSiUJ9+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SWUJcCnf1wLBr3sBPHyauKh1chpGY4SO0jv1c8EJ1gmcUfxnNwNUiUH5qIDV7Bhzz639qh3grDr6J5pZf0nv3UwiaohStlwz+IUT1e/8FvsVRtGkX7+/YRxUgbSbMFjjWYthmOFK6L669VO6aSGpNBkg4jShfU07ethWCket1i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id CDBC268BFE; Mon,  7 Apr 2025 10:57:51 +0200 (CEST)
Date: Mon, 7 Apr 2025 10:57:51 +0200
From: "hch@lst.de" <hch@lst.de>
To: Julian Stecklina <julian.stecklina@cyberus-technology.de>
Cc: "hch@lst.de" <hch@lst.de>,
	"hsiangkao@linux.alibaba.com" <hsiangkao@linux.alibaba.com>,
	"torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] initrd: support erofs as initrd
Message-ID: <20250407085751.GA27074@lst.de>
References: <20250320-initrd-erofs-v1-1-35bbb293468a@cyberus-technology.de> <20250321050114.GC1831@lst.de> <582bc002-f0c8-4dbb-8fa5-4c10a479b518@linux.alibaba.com> <933797c385f2e222ade076b3e8fc5810fa47f5bd.camel@cyberus-technology.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <933797c385f2e222ade076b3e8fc5810fa47f5bd.camel@cyberus-technology.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Mar 21, 2025 at 01:17:54PM +0000, Julian Stecklina wrote:
> Of course there are some solutions to using erofs images at boot now:
> https://github.com/containers/initoverlayfs
> 
> But this adds yet another step in the already complex boot process and feels
> like a hack. It would be nice to just use erofs images as initrd. The other
> building block to this is automatically sizing /dev/ram0:
> 
> https://lkml.org/lkml/2025/3/20/1296
> 
> I didn't pack both patches into one series, because I thought enabling erofs
> itself would be less controversial and is already useful on its own. The
> autosizing of /dev/ram is probably more involved than my RFC patch. I'm hoping
> for some input on how to do it right. :)

Booting from erofs seems perfectly fine to me.  Booting from erofs on
an initrd is not.  There is no reason to fake up a block device, just
have a version of erofs that directly points to pre-loaded kernel
memory instead.  This is a bit more work, but a lot more efficient
in that it removes the block path from the I/O stack, removes the boot
time copy and allows for much more flexible memory management.


