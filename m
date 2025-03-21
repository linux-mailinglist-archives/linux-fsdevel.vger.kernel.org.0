Return-Path: <linux-fsdevel+bounces-44669-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BD6A6B3E3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 06:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AD7D17FFC9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 05:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DC01E7C1E;
	Fri, 21 Mar 2025 05:00:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020591A841F;
	Fri, 21 Mar 2025 05:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742533234; cv=none; b=eOq3+jbA1KoTSQ03yjV1NIU+NlnQPOvc5GEEjXq8NPssaz0L7S3mYJvnadI8Uh6TZB+AG/kAbkc1ErCiKEFC/NzMIhoUlrhapjvWtm6hRsIPeLDcZE/OE1RLqApH8xEirZgaXtyYQc4lcPuoGOEcN7vLwExFEARXWbWesjvunHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742533234; c=relaxed/simple;
	bh=tyUJyRb+4jxbOGl5r3BYu4mr6qqcD1gKzy+hMrIURts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SsY021YDiRhuvah5xgPzB8ok8mm5Fr/HxAaZBXrufQpaA9EA09VXzAe8C8dfON3KLPq8wUVO5ykaoQSnVO3SPkQFbwcAnyOtt04Hg6kEM+H7g98pqMhY+ESTu+3usnLxZY0MYEKO5sPCvyUqtgB0d2yz+K3+DMOWnG8OmnXZRg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 05F5A68AFE; Fri, 21 Mar 2025 06:00:24 +0100 (CET)
Date: Fri, 21 Mar 2025 06:00:23 +0100
From: Christoph Hellwig <hch@lst.de>
To: Theodore Ts'o <tytso@mit.edu>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Luis Chamberlain <mcgrof@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	lsf-pc@lists.linux-foundation.org, david@fromorbit.com,
	leon@kernel.org, hch@lst.de, kbusch@kernel.org, sagi@grimberg.me,
	axboe@kernel.dk, joro@8bytes.org, brauner@kernel.org, hare@suse.de,
	willy@infradead.org, john.g.garry@oracle.com, p.raghav@samsung.com,
	gost.dev@samsung.com, da.gomez@samsung.com
Subject: Re: [LSF/MM/BPF TOPIC] breaking the 512 KiB IO boundary on x86_64
Message-ID: <20250321050023.GB1831@lst.de>
References: <Z9v-1xjl7dD7Tr-H@bombadil.infradead.org> <87o6xvsfp7.fsf@gmail.com> <20250320213034.GG2803730@frogsfrogsfrogs> <87jz8jrv0q.fsf@gmail.com> <20250321030526.GW89034@frogsfrogsfrogs> <20250321045604.GA1161423@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321045604.GA1161423@mit.edu>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Mar 21, 2025 at 12:56:04AM -0400, Theodore Ts'o wrote:
> As I recall, in the eary days Linux's safety for DIO and Bufered I/O
> was best efforts, and other Unix system the recommendation to "don't
> mix the streams" was far stronger.  Even if it works reliably for
> Linux, it's still something I recommend that people avoid if at all
> possible.

It still is a best effort, just a much better effort now.  It's still
pretty easy to break the coherent.


