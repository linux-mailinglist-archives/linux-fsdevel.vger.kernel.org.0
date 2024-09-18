Return-Path: <linux-fsdevel+bounces-29663-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 429A997BEA4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 17:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1B5A1F21BAB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 15:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6EEE1C8FC6;
	Wed, 18 Sep 2024 15:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SyFmWxfr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FBE13635D;
	Wed, 18 Sep 2024 15:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726673439; cv=none; b=e8gvuld52wxjrPL4+IR+x3bVsg8SKt1Qt5qisKDQX4jyv/vg1rb7QbegIt6486A4dGLSSnPN0JJlRiWbEsrcBsQx+8aaAwr53U4TvbPZlRCXRLwnpEzqUcVroUO6hcssTQROOHIBq6+7nDlVlAgh4pgydPEkEmIAiId5FPhbspg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726673439; c=relaxed/simple;
	bh=qWmcGf4tjdtirR4Kj1XukJnoH4Tbmqfncro2smwukNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FcAOAAFtu+kwFU0ailjr57ihOaRXe6aczhsf01dNoXMLf6l8H9zzHN7zTZ+XerbaLKYNiudCdtRL2/4Upnr4Uz7gMlJ6HfeiupYJd6D02dA5tXqvTggv+wHDARhJG3wLlcNX//9U44RIcNLgc8Iu5juu64jnm38d2V0XSbMUtl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SyFmWxfr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F786C4CECF;
	Wed, 18 Sep 2024 15:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726673438;
	bh=qWmcGf4tjdtirR4Kj1XukJnoH4Tbmqfncro2smwukNA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SyFmWxfr8BcC/Bmr287L6upWT3jb13/obSdHkbW8bvC7IrQdBLxn00oUM10FiO0g+
	 ZoRPHLNxOZGSD000NUg/Qm25zXU8diCEsRNd2gV6x+Bdr/1IrkOpGvcVYv9qOu4sX4
	 XcpXz77wUE/hE4gvxmIhBRbVdymMIv08awziAeEk64O19+OlUq3E4398SmevXWzoZS
	 9KOX3ueThKw6I7+sU5Qqw0n0rIMEYlO/SkI1f7colOr3csDs0M/MLis7nCf0T5uQ16
	 UTM4WIKiCOocMgwIxn0LeJsln1/JM+OhTlAs3zgdnCIIxanQyDJhUWkA/kH5DB8OdH
	 Es5xh0AbCXj+w==
Date: Wed, 18 Sep 2024 08:30:37 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Chandan Babu R <chandan.babu@oracle.com>,
	Christian Brauner <brauner@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 06/12] xfs: factor out a xfs_file_write_zero_eof helper
Message-ID: <20240918153037.GF182177@frogsfrogsfrogs>
References: <20240910043949.3481298-1-hch@lst.de>
 <20240910043949.3481298-7-hch@lst.de>
 <20240917211419.GC182177@frogsfrogsfrogs>
 <20240918050936.GA31238@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240918050936.GA31238@lst.de>

On Wed, Sep 18, 2024 at 07:09:36AM +0200, Christoph Hellwig wrote:
> On Tue, Sep 17, 2024 at 02:14:19PM -0700, Darrick J. Wong wrote:
> > I gotta say, I'm not a big fan of the "return 1 to loop again" behavior.
> > Can you add a comment at the top stating that this is a possible return
> > value and why it gets returned?
> 
> Sure.  If you have a better idea I'm all ears, too.

Sadly, I don't.  The closest I can think of is that iterator functions
return 1 for "here's an object", 0 for "no more objects", or negative
errno.  But this isn't iterating objects, it's (at best) "iterating" the
"not yet ready to do zeroing" states, and that's a stretch.

--D

