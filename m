Return-Path: <linux-fsdevel+bounces-980-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FF67D47EC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 09:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A8171C20B2B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 07:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF455134A1;
	Tue, 24 Oct 2023 07:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1jFGFjja"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FA51170F
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 07:06:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A642C10C;
	Tue, 24 Oct 2023 00:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aSAEUUc9lFBEtVvww0Jt4hfvlUP/bfy8AtKAMM6xXWk=; b=1jFGFjjaZf1Hxd88eaA9/EV8S1
	sYjtvzDAlGEL86xdcNQ54uEvhFmZFE9XrgVsdncPjPykYAtNHbyj9x3AWoZf0B/8+o9Km99BFvC96
	sFQNsD2SLvhPLtfcTr34Cz8J4N2X6nrJHnxcmYDpsjedlRHb24AiVGMXETz/0RpYz3wQ44H/64xvs
	vjZRan1LkfQW88W7Wcdcqpss9OifF5oFk4ei7nyRvmyWWhsr1ruorIZFpgb8O28E/OL08nE/o290e
	XiOXG1pkkew2wL29hOvqXFcHuNU69QBaaQOwyCaBq3G/5GIm7gzNm66c6jQwz7YNJqYCEOm7NMn3y
	gu3gOeGA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qvBUg-0092L6-0k;
	Tue, 24 Oct 2023 07:06:26 +0000
Date: Tue, 24 Oct 2023 00:06:26 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: LOOP_CONFIGURE uevents
Message-ID: <ZTds8va6evIjnpJG@infradead.org>
References: <20231018152924.3858-1-jack@suse.cz>
 <20231019-galopp-zeltdach-b14b7727f269@brauner>
 <ZTExy7YTFtToAOOx@infradead.org>
 <20231020-enthusiasmus-vielsagend-463a7c821bf3@brauner>
 <20231020120436.jgxdlawibpfuprnz@quack3>
 <20231023-biberbau-spatzen-282ccea0825a@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023-biberbau-spatzen-282ccea0825a@brauner>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Oct 23, 2023 at 04:08:21PM +0200, Christian Brauner wrote:
> No you get uevents if you trigger a partition rescan but only if there
> are actually partitions. What you never get however is a media change
> event even though we do increment the disk sequence number and attach an
> image to the loop device.
> 
> This seems problematic because we leave userspace unable to listen for
> attaching images to a loop device. Shouldn't we regenerate the media
> change event after we're done setting up the device and before the
> partition rescan for LOOP_CONFIGURE?

Maybe.  I think people mostly didn't care about the even anyway, but
about the changing sequence number to check that the content hasn't
changed.

