Return-Path: <linux-fsdevel+bounces-39545-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D9CA15798
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 19:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFA11188AF87
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 18:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000C11D6DDA;
	Fri, 17 Jan 2025 18:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fhxoB819"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5569B1AAA1A;
	Fri, 17 Jan 2025 18:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737139775; cv=none; b=nFKflwpUmqvKUpGx9uiBiYCYKmr7TEx7KIgjuHftz/CI6VZkUTLOZB/ulC/4Bviw7kmDrge89P4ssW2bbb1Lel6M69K4YvbkiA9fOfi6nzKwJcIM0CxqXxMXWOaFJZpkZcf+TPH248uJfj4Vi4+Gdu5GgHEAVlOAM70EKXJ244I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737139775; c=relaxed/simple;
	bh=zDdwjxZU/sF8rw75zRI/8i1HXIyyWGHyARyxnUpsYsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FJAzRrPov9H/aLaNNQbrU/h/yUp9LQlYQdGZ9pqPunJTuM3DN1RgrvsNpqpRAR+rRISC8zlwrygJYQc2GdhhYczLV7a1mltzwu11u7zYAEoZKugDzPZOqLqti8scJXD5O29zVNVnJgg5yWAdm4IwUcjxtEn/PgdhCrc7RZemvLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fhxoB819; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB947C4CEDD;
	Fri, 17 Jan 2025 18:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737139774;
	bh=zDdwjxZU/sF8rw75zRI/8i1HXIyyWGHyARyxnUpsYsM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fhxoB8196SJnzt8YHfRBi11hGbdssLESTCTL7/QcpsiKdwkh3XTs8k8oB2foRwFxz
	 jewgRuzP7Bwt/1940pxoKSbI+UKZGvngWsy7EjDDtZoibl/TJFfunOFBixqn1sQOPg
	 In2yQzNs1cSy5ZxDUytJGAWGVLeMbNXGoJ0frmQ2TH4YlqaqxtM1iH+ZPVyHWUtNmn
	 b9YgR4IdvRUFdc1MRy0CI1VCI8O1yhUG3ua6beiIS/jdPWyrb7r3yAfVw7bWi9tTyf
	 n1ZgQWLK5Eh3hyTxordQ4spwgCMSOJ9xbWJ6uTR/reLdWjo3BWMaMi8Zc7OF//nwmg
	 SGIyOeS23SWmQ==
Date: Fri, 17 Jan 2025 10:49:34 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Dave Chinner <david@fromorbit.com>,
	John Garry <john.g.garry@oracle.com>, brauner@kernel.org,
	cem@kernel.org, dchinner@redhat.com, ritesh.list@gmail.com,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, martin.petersen@oracle.com
Subject: Re: [PATCH 1/4] iomap: Lift blocksize restriction on atomic writes
Message-ID: <20250117184934.GI1611770@frogsfrogsfrogs>
References: <20241204154344.3034362-1-john.g.garry@oracle.com>
 <20241204154344.3034362-2-john.g.garry@oracle.com>
 <Z1C9IfLgB_jDCF18@dread.disaster.area>
 <3ab6000e-030d-435a-88c3-9026171ae9f1@oracle.com>
 <Z1IX2dFida3coOxe@dread.disaster.area>
 <20241212013433.GC6678@frogsfrogsfrogs>
 <Z4Xq6WuQpVOU7BmS@dread.disaster.area>
 <20250114235726.GA3566461@frogsfrogsfrogs>
 <20250116065225.GA25695@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116065225.GA25695@lst.de>

On Thu, Jan 16, 2025 at 07:52:25AM +0100, Christoph Hellwig wrote:
> On Tue, Jan 14, 2025 at 03:57:26PM -0800, Darrick J. Wong wrote:
> > Ok, let's do that then.  Just to be clear -- for any RWF_ATOMIC direct
> > write that's correctly aligned and targets a single mapping in the
> > correct state, we can build the untorn bio and submit it.  For
> > everything else, prealloc some post EOF blocks, write them there, and
> > exchange-range them.
> > 
> > Tricky questions: How do we avoid collisions between overlapping writes?
> > I guess we find a free file range at the top of the file that is long
> > enough to stage the write, and put it there?  And purge it later?
> > 
> > Also, does this imply that the maximum file size is less than the usual
> > 8EB?
> 
> I think literally using the exchrange code for anything but an
> initial prototype is a bad idea for the above reasons.  If we go
> beyond proving this is possible you'd want a version of exchrange
> where the exchange partners is not a file mapping, but a cow staging
> record.

The trouble is that the br_startoff attribute of cow staging mappings
aren't persisted on disk anywhere, which is why exchange-range can't
handle the cow fork.  You could open an O_TMPFILE and swap between the
two files, though that gets expensive per-io unless you're willing to
stash that temp file somewhere.

At this point I think we should slap the usual EXPERIMENTAL warning on
atomic writes through xfs and let John land the simplest multi-fsblock
untorn write support, which only handles the corner case where all the
stars are <cough> aligned; and then make an exchange-range prototype
and/or all the other forcealign stuff.

(Lifting in smaller pieces sounds a lot better than having John carry
around an increasingly large patchset...)

--D

