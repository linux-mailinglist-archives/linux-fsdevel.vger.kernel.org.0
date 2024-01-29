Return-Path: <linux-fsdevel+bounces-9383-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 283668408BA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 15:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD4EF1F22E86
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 14:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0912B152DFE;
	Mon, 29 Jan 2024 14:39:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40725D747;
	Mon, 29 Jan 2024 14:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706539149; cv=none; b=ohlulNzUiO2V7bHLRFEY6zK5ZZNKyEgzKagKm0eEL3dLIUGlASGHrM5BFIvpTJm+rUhemodxI0i8kPucLAddZ0mZiX0ProeE8KS/96LFvhulevRbAYmlnj7d2DKxbdL+wiiCCW589dYhLN8frK0kUffLugi5JxU+nD2KzhEOj7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706539149; c=relaxed/simple;
	bh=cl20W0OSVEqhA4Wo9siMG+VGLtonLKnMv9sFvFklJ3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZezZmybF1Kb9Mmg2KR9KV6zGBlFiClCgC4bKxNK+4AztGLWdaqCdN0QpL1t2t+3VKrwxMQmZJdLPeLF5JMTtULEB5fhxke2e3e9KJxCwMlrftiic10z7rDnXEL3AmENA5GKUrXC9v5NBhIQxjjg1uDmc+QZ72+AShxGWl8oQlXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BF20468C4E; Mon, 29 Jan 2024 15:39:02 +0100 (CET)
Date: Mon, 29 Jan 2024 15:39:02 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, martin.petersen@oracle.com,
	Keith Busch <kbusch@kernel.org>, axboe@kernel.dk, sagi@grimberg.me,
	jejb@linux.ibm.com, djwong@kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, dchinner@redhat.com, jack@suse.cz,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-scsi@vger.kernel.org, ming.lei@redhat.com,
	ojaswin@linux.ibm.com, bvanassche@acm.org,
	Alan Adamson <alan.adamson@oracle.com>
Subject: Re: [PATCH v3 15/15] nvme: Ensure atomic writes will be executed
 atomically
Message-ID: <20240129143902.GA654@lst.de>
References: <20240124113841.31824-1-john.g.garry@oracle.com> <20240124113841.31824-16-john.g.garry@oracle.com> <ZbGwv4uFdJyfKtk5@kbusch-mbp.dhcp.thefacebook.com> <dbb3ad13-7524-4861-8006-b2ea426fbacd@oracle.com> <20240129062035.GB19796@lst.de> <ca58facd-db6b-42b2-ace3-595817c81ca9@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca58facd-db6b-42b2-ace3-595817c81ca9@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jan 29, 2024 at 09:36:38AM +0000, John Garry wrote:
> That would probably be in blk_mq_dispatch_rq_list() for block drivers with 
> .queue_rq set, but I would need to check for a good place for ->queue_rqs . 
> I can't imagine that we just want to inefficiently iter all rqs at the 
> ->queue_rqs call point.
>
> However considering the nature of this change, it is not a good sign that 
> we/I need to check... I'd be more inclined to leave as is.

Heh.  At least early on having the checks in one place in nvme makes
me feel easier for sure.  If we can easily use the block limits for
the checks we shouldn't have to keep duplicate values in nvme, though.


