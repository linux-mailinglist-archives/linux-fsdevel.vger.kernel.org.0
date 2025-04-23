Return-Path: <linux-fsdevel+bounces-47098-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D91A5A98E3E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 16:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE109189B1F7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 14:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3D62820A8;
	Wed, 23 Apr 2025 14:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qKrkXWJU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A1B1A0711;
	Wed, 23 Apr 2025 14:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745419878; cv=none; b=ajEXkFM9vZESJvdRvpciX96shCtM/hqVJpmduh4f3Sf2I5on7aJ/QKoO/oQeNdSl94/cRR9hyjwWia+dA71AhD7vP3RBVDMK5FImfpiMgM47PfHYfUF8zqFfPcDBRxbDvvnfT2ClQ6Y1kENmH6jOQqE1fm1muBLiUkNgmAwMLa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745419878; c=relaxed/simple;
	bh=hAjNAGLE2JHJoSv/yP/EQBtFAc8W1Wwcb53racrQZ4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lP4BkbBTwHl2y8MFWX19lLz96gvxc4qbCCLujgYm/X8JLDT5np+3mE/alXInsinEwIWTrXIJUPUkNfh89mDPPWGZ0+8aKTG3rHjZf1MQ3frzE1Vq5t0pw/o/yo+31MTvPPYs0+BmvTr2hk7DhW8gTdy6w/oqiy6BW3rrrqTqPKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qKrkXWJU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86D04C4CEE3;
	Wed, 23 Apr 2025 14:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745419876;
	bh=hAjNAGLE2JHJoSv/yP/EQBtFAc8W1Wwcb53racrQZ4Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qKrkXWJUBMpJ3Rlb1ky7vb/LcIxhy7RONl35uZKc7Tix0uDV2Nz99NL6QZ7vBJk4q
	 i4py3zMjNQcHs8+3vZDZg+7r21c1j4edOlgg936KFFLCGLWrdjr2HPdt9rYhTqOKfc
	 O67DXhq/WiLAmRzaxKWFxvS5s1l1B5hx+6xqMSNVOiOMvq8kJTqZCEHV2MZ3napJpg
	 oxAQDqvOJf/iTbXO5C/nO3n8Z+/VXb58+IwQMLZitD06sXlN4luH5dwfG/D8pt3otc
	 n8PmFPNZjCphJISW6lk1MRgYcXzHLevmfCEXKL90v6mKP8wiXfz5omLIYAZg1ziu6N
	 8hhCOkTANqJVQ==
Date: Wed, 23 Apr 2025 07:51:16 -0700
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
Subject: Re: [PATCH v7 11/14] xfs: add xfs_file_dio_write_atomic()
Message-ID: <20250423145116.GY25675@frogsfrogsfrogs>
References: <20250415121425.4146847-1-john.g.garry@oracle.com>
 <20250415121425.4146847-12-john.g.garry@oracle.com>
 <20250421040002.GU25675@frogsfrogsfrogs>
 <2467484b-382b-47c2-ae70-4a41d63cf4fc@oracle.com>
 <20250421164241.GD25700@frogsfrogsfrogs>
 <20250423054251.GA23087@lst.de>
 <20250423081902.GD28307@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423081902.GD28307@lst.de>

On Wed, Apr 23, 2025 at 10:19:02AM +0200, Christoph Hellwig wrote:
> On Wed, Apr 23, 2025 at 07:42:51AM +0200, Christoph Hellwig wrote:
> > On Mon, Apr 21, 2025 at 09:42:41AM -0700, Darrick J. Wong wrote:
> > > Well it turns out that was a stupid question -- zoned=1 can't be enabled
> > > with reflink, which means there's no cow fallback so atomic writes just
> > > plain don't work:
> > 
> > Exactly.  It is still on my todo list to support it, but there are a
> > few higher priority items on it as well, in addition to constant
> > interruptions for patch reviews :)
> 
> Actually, for zoned we don't need reflink support - as we always write
> out place only the stuffing of multiple remaps into a single transaction
> is needed.  Still no need to force John to do this work, I can look into
> this (probably fairly trivial) work once we have good enough test cases
> in xfstests that I can trust them to verify I got things right.

<nod> I think we'll need a new fstest to set an error trap on a step
midway through a multi-extent ioend completion to make sure that's
actually working properly.  And probably new write commands for fsx and
fsstress to exercise RWF_ATOMIC.

(Catherine: please send the accumulated atomic writes fstests)

--D

