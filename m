Return-Path: <linux-fsdevel+bounces-22937-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0BF923D26
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 14:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47CDA2846AB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 12:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4C51662F4;
	Tue,  2 Jul 2024 12:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RLlELJu9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A962F1C686;
	Tue,  2 Jul 2024 12:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719921884; cv=none; b=cXKpEyNWmdKC5dj9OnPFlQcZjOcBOD/n2VEqMyMG8aD/PG6RT1wfdWbOAi4jmgPqNYfeRpQJPfDIQ86YRcBAgEtOx7Gkw6WiMC8kuVrctJRmhDl59VqgNAyTu/8jgUqG5HW5Z+6I88bvRc0JLdoNn9BmpvUp5W0J8Sb2I5qRrm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719921884; c=relaxed/simple;
	bh=b5GM9ijpBeGynJURaypdSlk8pKpNi4papiSVaQlHPkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FGwKdGnknFTsnXmKXLhTqQgG7nUlVI1cVSGInLqCcRNaS6L1xpNrImGfp+uz2pAl1fK9WBcVbSC6hp5MAqBaw8X7C4SZTLBJeq2SxZ/AleOodb4pbv6OOO7Rei9dDl2t6n/x3YooLeAWfqhu1hfktQBFOah3KdMlB91TRNne0Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RLlELJu9; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=d9z4p2MzaEAaeaMBOOPYtXfjQBBoKbQHMUDRf2gF2pw=; b=RLlELJu9ZDvb6/ca5kEpiffpn9
	AXM4DXiayCCL/ue1TvQdBfuuONUrUp2KY9mHdvvHSFj8qiRwQCzBeWukZl/NQpK9fYgoDgolJ8RTp
	7CatmwQKkCDwqrfPy4afHx56bsBzomm9Qzd+VOf4LJS/FfLKPcIKwtH8K8VJAhNUAckJqcXkxnsv/
	1DSgpoQZfYdkDzfQZHPxKk1P5B9K0dd6w+7mrLkL3mRX0bFReG7ANIUEgNso3r3fYPet5Y3PR16zh
	LpHCDFHjoVx3UuaRSrtK6EOq8Lbhh6ho3GKWV2k3SpssdidQ4MXGuO6V/s4r3aqANyozmhV2Nb1Lj
	TeYixs3g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOcFN-00000006bnO-0uO9;
	Tue, 02 Jul 2024 12:04:33 +0000
Date: Tue, 2 Jul 2024 05:04:33 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>, kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 01/10] fs: turn inode ctime fields into a single ktime_t
Message-ID: <ZoPs0TfTEktPaCHo@infradead.org>
References: <20240626-mgtime-v1-0-a189352d0f8f@kernel.org>
 <20240626-mgtime-v1-1-a189352d0f8f@kernel.org>
 <20240701224941.GE612460@frogsfrogsfrogs>
 <3042db2f803fbc711575ec4f1c4a273912a50904.camel@kernel.org>
 <ZoOuSxRlvEQ5rOqn@infradead.org>
 <d91a29f0e600793917b73ac23175e02dafd56beb.camel@kernel.org>
 <20240702101902.qcx73xgae2sqoso7@quack3>
 <958080f6de517cf9d0a1994e3ca500f23599ca33.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <958080f6de517cf9d0a1994e3ca500f23599ca33.camel@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jul 02, 2024 at 07:44:19AM -0400, Jeff Layton wrote:
> Complaining about it is fairly simple. We could just throw a pr_warn in
> inode_set_ctime_to_ts when the time comes back as KTIME_MAX. This might
> also be what we need to do for filesystems like NFS, where a future
> ctime on the server is not necessarily a problem for the client.
> 
> Refusing to load the inode on disk-based filesystems is harder, but is
> probably possible. There are ~90 calls to inode_set_ctime_to_ts in the
> kernel, so we'd need to vet the places that are loading times from disk
> images or the like and fix them to return errors in this situation.
> 
> Is warning acceptable, or do we really need to reject inodes that have
> corrupt timestamps like this?

inode_set_ctime_to_ts should return an error if things are out of range.
How do we currently catch this when it comes from userland?


