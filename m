Return-Path: <linux-fsdevel+bounces-57469-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB959B21FAA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 09:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91D0A1AA65E5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 07:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F332D323D;
	Tue, 12 Aug 2025 07:35:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96E31FBE87;
	Tue, 12 Aug 2025 07:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754984103; cv=none; b=Rskhv3ut2gotU3Pp/7nchVIj9cslo3OB3QvN9ODRgfxYv7r+bGzDszsn2q3WHosc1qOqjTI52LA6hsLvJHmRvpLNOxZxvpJTGWE/DQD6etRNbkRABsm9n6BjBJZDEIhVta0db47FzsctvaS6iq8gOfzM+LnEtn9T/Yt4/Ardeco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754984103; c=relaxed/simple;
	bh=fpPmlW0i9kHCUWfSkI6CZ14DUBCPw4G4k3GCkQNT3OQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ss8AMjq3KmXTMTYJqZMt2ZlCq17pbSOVyCALxsRiT9Y/S6OPpVoOoFoYjAbiq4RzP6gtCiLeNhReGlK1nOhM6Shma8b3NnLzDrYRPw5FxKm51Wq/6ylO2v5b6ns3KxmJEqtlLIzg0AZsBOmQ+SBjwYkmALpmBZBETJwuGByc9eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9E9B268AA6; Tue, 12 Aug 2025 09:34:56 +0200 (CEST)
Date: Tue, 12 Aug 2025 09:34:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Andrey Albershteyn <aalbersh@redhat.com>, fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	david@fromorbit.com, ebiggers@kernel.org
Subject: Re: [PATCH RFC 06/29] fsverity: report validation errors back to
 the filesystem
Message-ID: <20250812073455.GA18413@lst.de>
References: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org> <20250728-fsverity-v1-6-9e5443af0e34@kernel.org> <20250811114603.GB8969@lst.de> <20250811153142.GJ7965@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811153142.GJ7965@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Aug 11, 2025 at 08:31:42AM -0700, Darrick J. Wong wrote:
> On Mon, Aug 11, 2025 at 01:46:03PM +0200, Christoph Hellwig wrote:
> > On Mon, Jul 28, 2025 at 10:30:10PM +0200, Andrey Albershteyn wrote:
> > > From: "Darrick J. Wong" <djwong@kernel.org>
> > > 
> > > Provide a new function call so that validation errors can be reported
> > > back to the filesystem.
> > 
> > This feels like an awfull generic name for a very specific error
> > condition.
> 
> <shrug> ->verity_failure?

Either that or make it generic.  Either way it needs to be documented
in the usual places that document file operations including explaining
when it is supposed to be called.


