Return-Path: <linux-fsdevel+bounces-47939-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D29AA77A4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 18:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FE224A293F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 16:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F7325E45E;
	Fri,  2 May 2025 16:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QGY8Ts1r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AE125EFBB;
	Fri,  2 May 2025 16:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746204266; cv=none; b=DK8JEbo0NRkNGBiOZTL4i+4/dXoWfUXPPfeLHVQ+A3HbVUeole1Wt0/p9WMSwgG54SOskpI4suwO5yNuKeh7aaTf6YrDa/0ON3MtTXKrZDvzyrrQ90p4FHmnuQX+stpz/yjUlIULeqEKD/96B+8uLrUWymY/dcYeZvxUwcaYDAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746204266; c=relaxed/simple;
	bh=lusvwOhXbDnfRhmLRU1E/sjRB2/jznK6wsy2qGyuVgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K1KZwxVw0GtJqhQslL8O0/l20QARyUsHIzX03hzHmvH5obGPgED1kuLJHYR6kZyifzXCvHXMcYsifPx/PB30W4o+AKjUfoOsmB8cP3OWjGs3nnJvMm6sssrcEVGBJ6uM+f7kRr6lh9tpQCbQHFAQo6hzlLMJEBoywCzB75D2Kho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QGY8Ts1r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57930C4CEE9;
	Fri,  2 May 2025 16:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746204265;
	bh=lusvwOhXbDnfRhmLRU1E/sjRB2/jznK6wsy2qGyuVgw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QGY8Ts1r9bETAdAko31lN2Ol1l9jh3v9jTEzkvwlTco+H8xV9YyxCOilxNcmyzuB3
	 iVpJav6QJIIupPEgG0nDyMywJtpgu1Fg9B3vSHRhQd5iEKFLfRn7pP+8AfN8YlQxIj
	 LHjqm73dIcJ6wIgC9bAyFWTk0tKGyUqu8tbk9MPd0DIqKJp/92+JYyVKobh/wLihP6
	 OVr/rVGfVJwdw1I/rjokOoBeWL6J58rE159TrR8Uspk/CIERFFTKlvitokQ1B8XLaN
	 Edv2BE4xe1Rtri996q48oLn+mf1T1ZILNj17R42C3/pGKX8A70OKl7nOHztqbcwoiB
	 HCoDBGr3pxLiw==
Date: Fri, 2 May 2025 09:44:24 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: John Garry <john.g.garry@oracle.com>, brauner@kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, cem@kernel.org,
	linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, catherine.hoang@oracle.com,
	linux-api@vger.kernel.org
Subject: Re: [PATCH 16/15] xfs: only call xfs_setsize_buftarg once per buffer
 target
Message-ID: <20250502164424.GO25675@frogsfrogsfrogs>
References: <20250501165733.1025207-1-john.g.garry@oracle.com>
 <20250501195208.GF25675@frogsfrogsfrogs>
 <20250502065726.GA8309@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250502065726.GA8309@lst.de>

On Fri, May 02, 2025 at 08:57:26AM +0200, Christoph Hellwig wrote:
> On Thu, May 01, 2025 at 12:52:08PM -0700, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > It's silly to call xfs_setsize_buftarg from xfs_alloc_buftarg with the
> > block device LBA size because we don't need to ask the block layer to
> > validate a geometry number that it provided us.  Instead, set the
> > preliminary bt_meta_sector* fields to the LBA size in preparation for
> > reading the primary super.
> > 
> > It's ok to lose the sync_blockdev call at buftarg creation time for the
> > external log and rt devices because we don't read from them until after
> > calling xfs_setup_devices.  We do need an explicit sync for the data
> > device because we read the primary super before calling
> > xfs_setup_devices.
> 
> Should we just it for all of them in open_devices now that the sync
> is decoupled from setting the block size?

Yeah.

> Otherwise this looks good, but I guess this should go before the atomic
> writes series in the end?

Yep.

--D

