Return-Path: <linux-fsdevel+bounces-2358-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D2C7E515D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 08:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 710B72815D2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 07:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0839D515;
	Wed,  8 Nov 2023 07:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CQdvT4K6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2715D2EF;
	Wed,  8 Nov 2023 07:52:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F96D125;
	Tue,  7 Nov 2023 23:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wjnYzG80G+BeOWTXwlFdkAedh/VTtMEXqGs+GUtpxGQ=; b=CQdvT4K6SW3PzDMIUIL/ejfdgG
	uEuNR7SSzcX3edBTEDluXza2Vr3ap10liqHiOP7JeMScy5DspeRhk0h1YFKVmkuiGssIw0Rx55SMM
	jaLiVF2TFHy3GPf1kTv4ae31Nio+29c3eTLBA0y2UdI/AQg5Wvp+nISrBTsa5hE4ya+C7+xEzx77M
	g4YRwV8NpekhYf5hWE4Z4sZMAG/PLKBzCg0LGHSDiIB0P4D4LsHosEbFX7tA3zhojXFBZErDv0Tp9
	bF/NwItlfv9fvWRv+Q2Zrfl0LNwBr5mjB0N0se4kCYKgcECpJZ9xZc95tHhPMbiD7gqhoIbmchHBf
	zxhH8GXw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r0dLy-003DAD-1g;
	Wed, 08 Nov 2023 07:51:58 +0000
Date: Tue, 7 Nov 2023 23:51:58 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Qu Wenruo <quwenruo.btrfs@gmx.com>,
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
Message-ID: <ZUs+HuQWZvDDVC7a@infradead.org>
References: <20231102051349.GA3292886@perftesting>
 <20231102-schafsfell-denkzettel-08da41113e24@brauner>
 <ZUUDmu8fTB0hyCQR@infradead.org>
 <20231103-kursleiter-proklamieren-aae0a02aa1a4@brauner>
 <ZUibZgoQa9eNRsk4@infradead.org>
 <20231106-fragment-geweigert-1d80138523e5@brauner>
 <ZUjcI1SE+a2t8n1v@infradead.org>
 <20231106-unser-fiskus-9d1eba9fc64c@brauner>
 <ZUker5S8sZXnsvOl@infradead.org>
 <20231106224210.GA3812457@perftesting>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231106224210.GA3812457@perftesting>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Nov 06, 2023 at 05:42:10PM -0500, Josef Bacik wrote:
> Again, this is where I'm confused, because this doesn't change anything, we're
> still going to report st_dev as being different, which is what you hate.

It's not something I hate.  It's that changing it without a mount point
has broken things and will probably still break things.


