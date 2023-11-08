Return-Path: <linux-fsdevel+bounces-2370-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3B47E51F4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 09:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24BF5281416
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 08:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3A3DDC5;
	Wed,  8 Nov 2023 08:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u8DkWpMC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306FADDA2;
	Wed,  8 Nov 2023 08:27:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 542E7C433C7;
	Wed,  8 Nov 2023 08:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699432074;
	bh=/qrZjNcgbKWzX4hg4Kd3k7tvOc9vbsAhgGmJvj7+y5M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u8DkWpMCOIDI2IAQi0Bx1JbuIG4fGaIQPx3wKMp3PBZvsV1p9PP2mxR2ekalAcRDX
	 vEQuEYRPA3zv4t27oyGTkWznhYZJg3nBwFpoHTl491oZFbfN0wdfMndd4+rojLtSed
	 X/nj2dA26Ve9GZy2z72YdpiTQI4TATQ3iSOFi1Ls8CGCoGH2zSotTmh2fDHL0SjDYS
	 XySaiet8L00+VWN8EwGcAyIdo22hqS3WKVjC6Bju10E9Al95Gxp4cxdSiQPzLm72Ai
	 fO3ReP8w21fk21EP38ayjmXjJzRWgtzmdumTKmSwXxC4Z388JeyWWpCAqCII/OIpjL
	 U3YzmktC0BWxg==
Date: Wed, 8 Nov 2023 09:27:44 +0100
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
Message-ID: <20231108-zertreten-disqualifikation-bd170f2e8afb@brauner>
References: <ZUUDmu8fTB0hyCQR@infradead.org>
 <20231103-kursleiter-proklamieren-aae0a02aa1a4@brauner>
 <ZUibZgoQa9eNRsk4@infradead.org>
 <20231106-fragment-geweigert-1d80138523e5@brauner>
 <ZUjcI1SE+a2t8n1v@infradead.org>
 <20231106-unser-fiskus-9d1eba9fc64c@brauner>
 <ZUker5S8sZXnsvOl@infradead.org>
 <20231106224210.GA3812457@perftesting>
 <20231107-leiden-drinnen-913c37d86f37@brauner>
 <ZUs+MkCMkTPs4EtQ@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZUs+MkCMkTPs4EtQ@infradead.org>

On Tue, Nov 07, 2023 at 11:52:18PM -0800, Christoph Hellwig wrote:
> On Tue, Nov 07, 2023 at 10:06:18AM +0100, Christian Brauner wrote:
> > > But it doesn't appear to me there's agreement on the way forward.  vfsmounts
> > > aren't going to do anything from what I can tell, but I could very well be
> > > missing some detail.  And Christian doesn't seem to want that as a solution.
> > 
> > No, I really don't.
> > 
> > I still think that it is fine to add a statx() flag indicating that a
> > file is located on a subvolume. That allows interested userspace to
> > bounce to an ioctl() where you can give it additional information in
> > whatever form you like.
> 
> What is that flag going to buy us?

The initial list that Josef provided in
https://lore.kernel.org/linux-btrfs/20231025210654.GA2892534@perftesting
asks to give users a way to figure out whether a file is located on a
subvolume. Which I think is reasonable and there's a good chunk of
software out there that could really benefit from this. Now all of the
additional info that is requested doesn't need to live in statx(). But
that flag can serve as an indicator for userspace that they are on a
subvolume and that they can go to btrfs specific ioctls if they want to
figure out more details.

