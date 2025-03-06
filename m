Return-Path: <linux-fsdevel+bounces-43370-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60649A55021
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 17:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 897A03A7902
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 16:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5A8212FAA;
	Thu,  6 Mar 2025 16:05:02 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595E6211A02
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Mar 2025 16:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741277102; cv=none; b=nZkO2TSHM8e47CPCCgubXPle3rXFINB9FXXKvGHome7hNLTlAZjxOA6bboB4okrg1HXzYcGgv+Lf06j51B6Wn2WwOqF89VlqKcb0W2RDF4K42MH70JbWGhNKptwvPTIw4S58/AxsGEv4XNN6V5dAme/9GKEsBoJNMpq8NcA863g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741277102; c=relaxed/simple;
	bh=cOoGxtcebT3u8VgggsX55aYM+nUJo9Wlfp8eesUGY+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R0fe85EoyTSwsDVzWzG0AZn4hIxvHX/CgZz3YxZWLtcIx3AdYFyKKWc4HZZ8bRIQJcD+jj8lygORGkXYuZwgf+rnEVvNswzVWWqxm/cdw3t5ABC13gwvlIGO2M0f7yv9VMkfgesS77QQokEM4Kr8g8fbN9NzC8Ik6133JR3S72M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-112-92.bstnma.fios.verizon.net [173.48.112.92])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 526FxGlE006357
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 6 Mar 2025 10:59:16 -0500
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 3D1372E010B; Thu, 06 Mar 2025 10:59:16 -0500 (EST)
Date: Thu, 6 Mar 2025 10:59:16 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: linux-ext4@vger.kernel.org, Jan Kara <jack@suse.com>,
        Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Baokun Li <libaokun1@huawei.com>,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2 2/2] ext4: protect ext4_release_dquot against freezing
Message-ID: <20250306155916.GA279274@mit.edu>
References: <20241121123855.645335-1-ojaswin@linux.ibm.com>
 <20241121123855.645335-3-ojaswin@linux.ibm.com>
 <Z8lBGaJGnM3SZZ-g@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8lBGaJGnM3SZZ-g@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>

On Thu, Mar 06, 2025 at 12:00:49PM +0530, Ojaswin Mujoo wrote:
> On Thu, Nov 21, 2024 at 06:08:55PM +0530, Ojaswin Mujoo wrote:
> > Protect ext4_release_dquot against freezing so that we
> > don't try to start a transaction when FS is frozen, leading
> > to warnings.
> > 
> > Further, avoid taking the freeze protection if a transaction
> > is already running so that we don't need end up in a deadlock
> > as described in
> > 
> >   46e294efc355 ext4: fix deadlock with fs freezing and EA inodes
> > 
> > Suggested-by: Jan Kara <jack@suse.cz>
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> 
> Hey Ted,
> 
> Just a ping, I think you might have missed this patch. Let me know if
> anything else is needed from my side.

Yes, I did miss this patch; thanks for the reminder. It looks good
and I've added it to my tree.

				- Ted

