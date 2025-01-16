Return-Path: <linux-fsdevel+bounces-39383-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8B3A13368
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 07:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFF931881EDF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 06:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD880193079;
	Thu, 16 Jan 2025 06:52:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80D7142659;
	Thu, 16 Jan 2025 06:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737010357; cv=none; b=ldGI3ZRpebS7ZvFVOnmhUaQHJ95dIr9li0S0pt0rFeMlilyaM8fKlV00rnTDomtkRJecCKHi/MGdVGzNlqTf/OC/dIh8iXELNGMBlt5YDlCQ8VbxFD4iWR5Qec5XCTFdVz1N1XY3ZWUMwuetSYKZ6TurNR3X67nCNpb4B6tWcfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737010357; c=relaxed/simple;
	bh=KNezwoRZeW5VMIIh6/hRXjNmXq9JA6/AmC+sLP5tvxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qORxybBq8t6ErxVk78KnFOrkNSDN0uRHIBSbiOQmIA0+5bE/fBe8UM5n7mtpmx878JjkB7BAqFQdeK6z/rdlAwtOItHo2wwmmIJ2bXP0RhJV95YpmuG/om3AK7U2f36a1udEx/lYnz+toi3YK2SWuqJ4+l2BQtpJ5Fm5LyTk0qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3CFC268D15; Thu, 16 Jan 2025 07:52:26 +0100 (CET)
Date: Thu, 16 Jan 2025 07:52:25 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Dave Chinner <david@fromorbit.com>,
	John Garry <john.g.garry@oracle.com>, brauner@kernel.org,
	cem@kernel.org, dchinner@redhat.com, hch@lst.de,
	ritesh.list@gmail.com, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	martin.petersen@oracle.com
Subject: Re: [PATCH 1/4] iomap: Lift blocksize restriction on atomic writes
Message-ID: <20250116065225.GA25695@lst.de>
References: <20241204154344.3034362-1-john.g.garry@oracle.com> <20241204154344.3034362-2-john.g.garry@oracle.com> <Z1C9IfLgB_jDCF18@dread.disaster.area> <3ab6000e-030d-435a-88c3-9026171ae9f1@oracle.com> <Z1IX2dFida3coOxe@dread.disaster.area> <20241212013433.GC6678@frogsfrogsfrogs> <Z4Xq6WuQpVOU7BmS@dread.disaster.area> <20250114235726.GA3566461@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114235726.GA3566461@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jan 14, 2025 at 03:57:26PM -0800, Darrick J. Wong wrote:
> Ok, let's do that then.  Just to be clear -- for any RWF_ATOMIC direct
> write that's correctly aligned and targets a single mapping in the
> correct state, we can build the untorn bio and submit it.  For
> everything else, prealloc some post EOF blocks, write them there, and
> exchange-range them.
> 
> Tricky questions: How do we avoid collisions between overlapping writes?
> I guess we find a free file range at the top of the file that is long
> enough to stage the write, and put it there?  And purge it later?
> 
> Also, does this imply that the maximum file size is less than the usual
> 8EB?

I think literally using the exchrange code for anything but an
initial prototype is a bad idea for the above reasons.  If we go
beyond proving this is possible you'd want a version of exchrange
where the exchange partners is not a file mapping, but a cow staging
record.


