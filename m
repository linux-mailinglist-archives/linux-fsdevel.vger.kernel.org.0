Return-Path: <linux-fsdevel+bounces-1085-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81FB57D546E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 16:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D0B3281A72
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 14:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E6730CFD;
	Tue, 24 Oct 2023 14:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CXhWXThu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851882E64E
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 14:53:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2C25C433C8;
	Tue, 24 Oct 2023 14:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1698159224;
	bh=lUFQ3v5CpOWCmK337y0OntuNv8kN0NqIfQIZ92fiWus=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CXhWXThuIDw9jKycAqBYeGO1zaSDEwHFFDU85loiH8gAoxWw5SqknD3YVaoS6JGqU
	 a1ThKCAQvYu0jUzy/7hHQ98oDaBztYtGaw1pGrb/aydcCO8bgK3ABc+ILTZuZ0AZd8
	 baKcazGQMt5RFzuENhwcElOglBDCbiCPld9XGvQA=
Date: Tue, 24 Oct 2023 07:53:43 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jan Kara <jack@suse.cz>
Cc: Hugh Dickins <hughd@google.com>, Matthew Wilcox <willy@infradead.org>,
 Hui Zhu <teawater@antgroup.com>, Theodore Ts'o <tytso@mit.edu>,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH] ext4: add __GFP_NOWARN to GFP_NOWAIT in readahead
Message-Id: <20231024075343.e5f0bd0d99962a4f0e32d1a0@linux-foundation.org>
In-Reply-To: <20231024100318.muhq5omspyegli4c@quack3>
References: <7bc6ad16-9a4d-dd90-202e-47d6cbb5a136@google.com>
	<20231024100318.muhq5omspyegli4c@quack3>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Oct 2023 12:03:18 +0200 Jan Kara <jack@suse.cz> wrote:

> On Mon 23-10-23 23:26:08, Hugh Dickins wrote:
> > Since mm-hotfixes-stable commit e509ad4d77e6 ("ext4: use bdev_getblk() to
> > avoid memory reclaim in readahead path") rightly replaced GFP_NOFAIL
> > allocations by GFP_NOWAIT allocations, I've occasionally been seeing
> > "page allocation failure: order:0" warnings under load: all with
> > ext4_sb_breadahead_unmovable() in the stack.  I don't think those
> > warnings are of any interest: suppress them with __GFP_NOWARN.
> > 
> > Fixes: e509ad4d77e6 ("ext4: use bdev_getblk() to avoid memory reclaim in readahead path")
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> 
> Yeah, makes sense. Just the commit you mention isn't upstream yet so I'm
> not sure whether the commit hash is stable.

e509ad4d77e6 is actually in mm-stable so yes, the hash should be stable.



