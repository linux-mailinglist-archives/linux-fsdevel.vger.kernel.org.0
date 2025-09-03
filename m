Return-Path: <linux-fsdevel+bounces-60194-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBEFB428F8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 20:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2E9F17D34E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 18:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FDA2D6E54;
	Wed,  3 Sep 2025 18:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="khWb699O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18C417A2F6
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 18:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756925243; cv=none; b=iepr5aQ9HiycOmPTEjKHvpGNff7BhVALJCzk4o6/yfGypp5otmThjPq4hTSixCDka5epoyhM8xig4/E7xcrN5Bqq+M5Gyn8KR5qm5vxRYdFMaQ/mVfQ1VNg2i11gIIOksAitf7SGbP4NbfbSrtMHYp5QcNQe/8wn4059A4idBGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756925243; c=relaxed/simple;
	bh=SxcicSb9G1HTySanb336sDHIxjsLYY4Fo4CVWb41tAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=shgqV7em95BspsksxflSOkOTAt0jMiHpe6a9TbjxiFy795UcOlZHj9aC08i/+xaRVAnA6/Ko0z8FxSvEwMS5YBmSm2OGj5GZvH5PW+XjuFI3DZcLDvMTwxQqJlr+Rq5LfcXCgw4J30rri4VpnyFq+/RpY7ISTfpkvlnhw10nMqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=khWb699O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B0B6C4CEF1;
	Wed,  3 Sep 2025 18:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756925243;
	bh=SxcicSb9G1HTySanb336sDHIxjsLYY4Fo4CVWb41tAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=khWb699Of3YN4HJNsQZCFswVB3YGH4whgD6FNUW9wFtmqavuTyUTNnh871uFbSlIk
	 qg+ufr+3KjRh01gJxDqwvtpdvJZBhWblV2V7/Ex+Mr0Pt6njhXMEQWJVxyRq8SARqI
	 AVguVSn016GLnwoSHbXVOcHByT7n4BL6MPxG+HcMNpYG/ndy2q9VsCG3Ne1feZV65t
	 o+wTizzonlQRMoxOqQ5V3GrTQPkeiNrV6TVIXnZ1OQHX25Lzv9OAFt1sD9Iu1T1jLN
	 RFyXoYFbO7QYq3tFu6C3x3P17opUaKkKkLJ4rgWKNCGBMK3SrZM1iOZ4THqnivfFQ6
	 P5yolCim8wS3A==
Date: Wed, 3 Sep 2025 11:47:22 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Joanne Koong <joannelkoong@gmail.com>, bernd@bsbernd.com,
	neal@gompa.dev, John@groves.net, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/7] fuse: capture the unique id of fuse commands being
 sent
Message-ID: <20250903184722.GH1587915@frogsfrogsfrogs>
References: <175573708506.15537.385109193523731230.stgit@frogsfrogsfrogs>
 <175573708609.15537.12935438672031544498.stgit@frogsfrogsfrogs>
 <CAJnrk1Z_xLxDSJDcsdes+e=25ZGyKL4_No0b1fF_kUbDfB6u2w@mail.gmail.com>
 <20250826185201.GA19809@frogsfrogsfrogs>
 <CAJfpegs-89B2_Y-=+i=E7iSJ38AgGUM2-9mCfeQ9UKA2gYEzxQ@mail.gmail.com>
 <20250903155405.GE1587915@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903155405.GE1587915@frogsfrogsfrogs>

On Wed, Sep 03, 2025 at 08:54:05AM -0700, Darrick J. Wong wrote:
> On Wed, Sep 03, 2025 at 05:48:46PM +0200, Miklos Szeredi wrote:
> > On Tue, 26 Aug 2025 at 20:52, Darrick J. Wong <djwong@kernel.org> wrote:
> > 
> > > Hrmm.  I was thinking that it would be very nice to have
> > > fuse_request_{send,end} bracket the start and end of a fuse request,
> > > even if we kill it immediately.
> > 
> > I'm fine with that, and would possibly simplify some code that checks
> > for an error and calls ->end manually.  But that makes it a
> > non-trivial change unfortunately.
> 
> Yes, and then you have to poke the idr structure for a request id even
> if that caller already knows that the connection's dead.  That seems
> like a waste of cycles, but OTOH maybe we just don't care?
> 
> (Though I suppose seeing more than one request id of zero in the trace
> output implies very strongly that the connection is really dead)

Well.... given the fuse_iqueue::reqctr usage, the first request gets a
unique id of 2 and increments by two thereafter.  So it's a pretty safe
bet that unique==0 means the request isn't actually being sent, or that
your very lucky in that your fuse server has been running for a /very/
long time.

I think I just won't call trace_fuse_request_send for requests that are
immediately ended; and I'll refactor the req->in.h.unique assignment
into a helper so that virtiofs and friends can call the helper and get
the tracepoint automatically.

For example, fuse_dev_queue_req now becomes:


static inline void fuse_request_assign_unique_locked(struct fuse_iqueue *fiq,
						     struct fuse_req *req)
{
	if (req->in.h.opcode != FUSE_NOTIFY_REPLY)
		req->in.h.unique = fuse_get_unique_locked(fiq);

	/* tracepoint captures in.h.unique and in.h.len */
	trace_fuse_request_send(req);
}

static void fuse_dev_queue_req(struct fuse_iqueue *fiq, struct fuse_req *req)
{
	spin_lock(&fiq->lock);
	if (fiq->connected) {
		fuse_request_assign_unique_locked(fiq, req);
		list_add_tail(&req->list, &fiq->pending);
		fuse_dev_wake_and_unlock(fiq);
	} else {
		spin_unlock(&fiq->lock);
		req->out.h.error = -ENOTCONN;
		clear_bit(FR_PENDING, &req->flags);
		fuse_request_end(req);
	}
}

--D

