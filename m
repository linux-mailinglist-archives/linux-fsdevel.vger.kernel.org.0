Return-Path: <linux-fsdevel+bounces-2366-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 371F07E51AD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 09:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 670B31C20D4D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 08:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFB6DDA2;
	Wed,  8 Nov 2023 08:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S8xIZVO9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E221D520;
	Wed,  8 Nov 2023 08:09:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EBEFC433C7;
	Wed,  8 Nov 2023 08:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699430955;
	bh=40NPbOu4TZfdTIZHvVL7ejkKr4/46rOAHmQWUbWSGeg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S8xIZVO9QgAJEgzKAjndRTE1MGuznqvTXbAtWH6THGucOKgtrXqu01dAzqs6C78Dz
	 N7WYahENaxACMHjMrzTamfA7qcgH1PKTD0/TR9rOCuSbMVk1PpLxx7A1Ru4w7E5Yq1
	 j8kF1C95CwH78EKGXrwNWZYwAYONDM/qUA1wA/xE2nfGXqxKtCuUxyP6HUiN4Pw083
	 X4K1eaFvry0hU/tAL4eVgVrkWmMSLQcBlj8NHw6ea31z1QF1LfWvgpGTA8D2Kk9bvJ
	 tnPjFuCHHpOtSlBUDHFxKma1+0B1bkPJ4+026V5UjlpRIQqlqyjegoASBt3PQGlL6I
	 d9dGF6X5aJ8Rw==
Date: Wed, 8 Nov 2023 09:09:10 +0100
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, Josef Bacik <josef@toxicpanda.com>,
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
Message-ID: <20231108-labil-holzplatten-bba8180011b4@brauner>
References: <20231103-kursleiter-proklamieren-aae0a02aa1a4@brauner>
 <ZUibZgoQa9eNRsk4@infradead.org>
 <20231106-fragment-geweigert-1d80138523e5@brauner>
 <49454bf2-af6e-4dcf-b9a1-22acbfdc756d@gmx.com>
 <20231106-postfach-erhoffen-9a247559e10d@brauner>
 <ZUjcgU9ItPg/foNB@infradead.org>
 <20231106-datei-filzstift-c62abf899f8f@brauner>
 <ZUkeBM1sik1daE1N@infradead.org>
 <20231107-herde-konsens-7ee4644e8139@brauner>
 <ZUs/Ja35dwo5i2e1@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZUs/Ja35dwo5i2e1@infradead.org>

> of a bubble.  There is absolutely no implication that this is intentional
> or even malicious.

Ok, sometimes it's easy to miss nuances in mail which is why such
comments are easy to misread.

> 
> > > definition of a mount point, and that one used on basically every
> > > other unix system.  It might not work as-is for software that actually
> > > particularly knows how to manage btrfs subvolumes, but those are, by
> > > defintion, not the problem anyway.
> > 
> > On current systems and since forever bind-mounts do not change device
> > numbers unless they are a new filesystem mount. Making subvolumes
> > vfsmounts breaks that. That'll mean a uapi change for
> > /proc/<pid>/mountinfo for a start.
> 
> a bind mount can of course change the dev_t - if it points to a
> different super block at the moment.

No, a bind mount just takes an existing directory tree of an existing
filesystem and makes it visible on some location in the filesystem
hierarchy. It doesn't change the device number it will inherit it from
the superblock it belongs. mount -t xfs /dev/sda /mnt creates a new
filesystem and a first mount for that filesystem. Any other additional
bind-mount off of that will inherit the same device id in
/proc/<pid>/mountinfo.

