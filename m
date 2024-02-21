Return-Path: <linux-fsdevel+bounces-12281-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 504A285E3AF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 17:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFA6DB238AB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 16:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4C082D8F;
	Wed, 21 Feb 2024 16:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LIZnfZSb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BB180C08;
	Wed, 21 Feb 2024 16:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708534001; cv=none; b=uB8ka+SukxwHzYORKBytl/5YSvTJnkZw4Uox1ljR2oZvalFitCk/5Q0bnv73n4Wnyu6BkTr8Yhh7uZY6TNxhYHlH/x3LjpX4UWObJP2PrzlKKNZSoD6Zy2Ym6PsHTF7gWeGvO5PF/1ZzD5wfCA6QTG6wfTrlMhAzvfr4OP0LjkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708534001; c=relaxed/simple;
	bh=luA14+I6agAb3WN5vu4hfd77tv/XVl+XGCXKT2dSywU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O/NmuNjUalKQQ9GbCKeErKmSEinBOsaGhZnalqu49yWAq/EV6WwvT3A8EZYtNA9+BlT+DQDUD24QYd1skzGhDaREB4R7alm5HkUk262rbaviajeCkL7Sk5deueKZyZyw9h13i2KSfbN482ky8g2KM6fJi4/aMGVcLxnzpNU2mZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LIZnfZSb; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vF4GgIZYKuqOR3J0iKSalWbeQz2cXnj9J6PDCw6QbdU=; b=LIZnfZSbF8BBDRZJKgm/dANAND
	Pj5o4ch1ijcAdKTXqu/PHyN4BOjz1UNbWo1yfvHfhYqeXS6vqlD4XhzL3NCKSrLF0v7JHy88R4UEw
	QRgJD7w8D5BaTHlGn8746lF9PdG+6aGkkMFsJvRikkCymDHmAbB+cia5F+khV1bPMoP0X09cgj449
	1Srv9rvO2zVLgGiT0eeXimbsxdTohA5aAEoCet6oTs93rs54pifPdkYHS7sitdSkuy5o0Fq7c1E8E
	dPzMzf8bMT3XAlxyFznlWVhE/Jo0T5CIRvFbx2yEx9OOpG5sbo0hL3QaOGT1yx/y0VDn4bLFVEucB
	XZfobmgQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcpjz-00000001miw-0uED;
	Wed, 21 Feb 2024 16:46:39 +0000
Date: Wed, 21 Feb 2024 08:46:39 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, anand.jain@oracle.com, aalbersh@redhat.com,
	djwong@kernel.org, linux-fsdevel@vger.kernel.org,
	kdevops@lists.linux.dev, patches@lists.linux.dev
Subject: Re: [PATCH 3/3] check: add --print-start-done to enhance watchdogs
Message-ID: <ZdYo7zjD_lDlOdia@bombadil.infradead.org>
References: <20240216181859.788521-1-mcgrof@kernel.org>
 <20240216181859.788521-4-mcgrof@kernel.org>
 <ZdLOKCYnM3XybqQp@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdLOKCYnM3XybqQp@dread.disaster.area>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Mon, Feb 19, 2024 at 02:42:32PM +1100, Dave Chinner wrote:
> On Fri, Feb 16, 2024 at 10:18:59AM -0800, Luis Chamberlain wrote:
> > fstests specific watchdogs want to know when the full test suite will
> > start and end. Right now the kernel ring buffer can get augmented but we
> > can't know for sure if it was due to a test or some odd hardware issue
> > after fstests ran. This is specially true for systems left running tests in
> > loops in automation where we are not running things ourselves but rather just
> > get access to kernel logs, or for filesystem runner watdogs such as the one
> > in kdevops [0]. It is also often not easy to determine for sure based on
> > just logs when fstests check really has completed unless we have a
> > matching log of who spawned that test runner. Although we could keep track of
> > this ourselves by an annotation locally on the test runner, it is useful to
> > have independent tools which are not attached to the process which spawned
> > check to just peak into a system and verify the system's progress with
> > fstests by just using the kernel log. Keeping this in the test target kernel
> > ring buffer enables these use cases.
> > 
> > This is useful for example for filesyste checker specific watchdogs like the
> > one in kdevops so that the watchdog knows when to start hunting for crashes
> > based just on the kernel ring buffer, and so it also knows when the show is
> > over.
> 
> Why can't the runner that requires timing information in the
> kernel log just emit a message to the kernel log before it
> runs check and again immediately after completion of the check
> script?

That's exactly what is done today, it just seemed to me that since this
has been useful to a test runner now for years, it might make sense to
generalize this.
 
  Luis

