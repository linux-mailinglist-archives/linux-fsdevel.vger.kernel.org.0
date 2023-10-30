Return-Path: <linux-fsdevel+bounces-1539-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCE37DBAAC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 14:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A906B20DF9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 13:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34428168AC;
	Mon, 30 Oct 2023 13:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Cna6mS3W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C46168A8
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 13:25:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50CDEA2;
	Mon, 30 Oct 2023 06:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ilwoHemrW2teVoRctqXKwG4ZrUjujKvoTKzlqZcWFII=; b=Cna6mS3WD/044dWY1ZcTPlePc2
	ayl50jQ93qL4q/McVYm7dN0DIWAkNhx63rJXmaej1Ypj1/l24BMqLmetBEraWrn/Rf2kxrAwkFyIU
	oomWuv4lEWgEbQ0EooW8kdychF/VJlyVVVFH20IFDf4Ary4TWuoIzUmlMBkRMk9q5vwhUPf3Uf8RE
	NqTzLXzgs94WH4RpCSzSa5eE3mMJlvilaGaS//GEX4NxxZjqnB7TCdAZ59Zj7wHhX6rBFW1/vWjHw
	JxYOTIh75zlVe1R5N2YrFjdhid2XGMkyGoMtRfadzIhmKA+uF1zESBQSqNIDXgddiLkVZ8Z9/Jyna
	J5gFnFVA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qxSGj-003Ogt-24;
	Mon, 30 Oct 2023 13:25:25 +0000
Date: Mon, 30 Oct 2023 06:25:25 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>, Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
Message-ID: <ZT+uxSEh+nTZ2DEY@infradead.org>
References: <20231025135048.36153-1-amir73il@gmail.com>
 <ZTk1ffCMDe9GrJjC@infradead.org>
 <20231025210654.GA2892534@perftesting>
 <ZTtOmWEx5neNKkez@infradead.org>
 <20231027131726.GA2915471@perftesting>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027131726.GA2915471@perftesting>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Oct 27, 2023 at 09:17:26AM -0400, Josef Bacik wrote:
> We have this same discussion every time, and every time you stop responding
> after I point out the problems with it.

I'm not sure why you think I stop responding when the action item is not
for me.

> A per-subvolume vfsmount means that /proc/mounts /proc/$PID/mountinfo becomes
> insanely dumb.  I've got millions of machines in this fleet with thousands of
> subvolumes.  One of our workloads fires up several containers per task and runs
> multiple tasks per machine, so on the order of 10-20k subvolumes.

If you do not expose them in /proc/mounts and friends you don't have
any way to show where the mount point or whatever barrier you want
between different st_dev/fsid/etc is.  And you need that.

I've not seen any good alternative that keeps the invariant and doesn't
break things.  If you think there is one please explain it, but no,
adding new fields so that new software can see how we've broken all
the old software is not the answer.

A (not really) great partial answer would be to stop parsing the
text mount information so much, at least for your workloads that
definitively are little on the extreme side.  I think Miklos has been
working on interface that could be useful for that.

