Return-Path: <linux-fsdevel+bounces-44427-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D06E6A68725
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 09:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 312153BF982
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 08:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CC5251786;
	Wed, 19 Mar 2025 08:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BcFg2WkQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2C015A85A;
	Wed, 19 Mar 2025 08:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742373780; cv=none; b=NmOfr63g0VDqTF8d74k76dj5W6lNxVUMV3fk2asIQliBDSiR6OqSmUrY8N/UVWwc31q7dkztClwK6mQW6rkVFi8Ah4+zvH4q7yxVwtS8pbchSAy2eUujRbVpoRizH+xiBs2MKe1fXg6D7WISTTuL0f3iz+Eook7Yey0cK7OTna8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742373780; c=relaxed/simple;
	bh=IkEiNEdqmolE27++iMMEHfqbw6Gq8wNRl3q5lhELABE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IpAA9SkPLKSzIvlOI0fTlW2vF/4/gHKY0ZtqHtmhXlINLv3+3MLzURFht1VV3XuL2MIQWE6oIelL1Hykfoq2g80oRgWagtZth4wcoR4IqliN25iCSljStHbu2v59FkpHWup86OPIXOt0xOLU4xHE4lyGEgZ6Dy06odMjQ5lH7/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BcFg2WkQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1637C4CEE9;
	Wed, 19 Mar 2025 08:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742373779;
	bh=IkEiNEdqmolE27++iMMEHfqbw6Gq8wNRl3q5lhELABE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BcFg2WkQ5+E9suI1jQUWXbUciZ0z1Ncl160NNNt9tkMkhafL6XmvmT3enS/ABYT0X
	 u716aw/fJ7nMfQ7B2fEGvjWFsiwdmOt3mzVuE90zLnfmY6QqQTNQY8omq1UFLIRfJ+
	 QnrAM1oGpEVLdJRiminYzPg/W5s2nDbt8abPc58Par2n2KCtBiJEjwEpSa+g4Xc7iI
	 oJ8pBR+fSFy6J3uhajS+YraX9hHHEbx2ezWSo86xeT3l9ktBnu9QBh7G4KqtECi0Vn
	 LTb02bRSOCq3Rv9QRYOs5/UdDyaWTaaGulFxUYT0Z4yNPoU8pPVnSsJ9ksHLN+t7Cu
	 ATOvw6dnCtlsA==
Date: Wed, 19 Mar 2025 09:42:54 +0100
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	David Howells <dhowells@redhat.com>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/6 RFC v2] tidy up various VFS lookup functions
Message-ID: <20250319-vierbeinig-aufruf-ea327bc39320@brauner>
References: <20250319031545.2999807-1-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250319031545.2999807-1-neil@brown.name>

On Wed, Mar 19, 2025 at 02:01:31PM +1100, NeilBrown wrote:
> This a revised version of a previous posting.  I have dropped the change
> to some lookup functions to pass a vfsmount.  I have also dropped the

Thank you for compromising! I appreciate it.

> I haven't included changes to afs because there are patches in vfs.all
> which make a lot of changes to lookup in afs.  I think (if they are seen
> as a good idea) these patches should aim to land after the afs patches
> and any further fixup in afs can happen then.

If you're fine with this then I suggest we delay this to v6.16. So I've
moved this to the vfs-6.16.async.dir branch which won't show up in -next
before the v6.15 merge window has concluded. I'm pushing this out now.

