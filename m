Return-Path: <linux-fsdevel+bounces-2500-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E5F7E6640
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 10:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E0BA1C20C63
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 09:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CE3111A8;
	Thu,  9 Nov 2023 09:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+OaOBda"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2685211182;
	Thu,  9 Nov 2023 09:07:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C6CCC433C8;
	Thu,  9 Nov 2023 09:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699520860;
	bh=9QJk81gGMAQ5/sKxfhEhrKoP+doeq1VOeaBLWtULd0M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z+OaOBdaLjrd3UwJbyqg4FAUfkyU5WXGtBpxXtmDQKDC3IwBFT49oPDdovE1N47EQ
	 gMYcv2AsalIfjJJj04hT1UiMSGbKzaEaQAaCGF/0R7Fal5f4EXI9Y/71Ci3Ovbxv4n
	 hSulABZPZSaMIgjvlDLW0Rc5lL296htTxSWl4f+d66/BgCdDKTcwTpOJC0ZDAAiP36
	 Pd7Akutvf3CzAPSFOhl75xulViAxLwiHtOGDNvTSAPvh/jwA2hOH0X7I5jzefir0Q6
	 CZvlzdNveOuwhQ/NP6v9/lKlais2ZPUygaCzQaM5e6rVAohdTFz4RoG4nXcdfBNhRU
	 E2KFIBXEPhOBg==
Date: Thu, 9 Nov 2023 10:07:35 +0100
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
Message-ID: <20231109-umher-entwachsen-78938c126820@brauner>
References: <20231106-unser-fiskus-9d1eba9fc64c@brauner>
 <ZUker5S8sZXnsvOl@infradead.org>
 <20231106224210.GA3812457@perftesting>
 <20231107-leiden-drinnen-913c37d86f37@brauner>
 <ZUs+MkCMkTPs4EtQ@infradead.org>
 <20231108-zertreten-disqualifikation-bd170f2e8afb@brauner>
 <ZUuWSVgRT3k/hanT@infradead.org>
 <20231108-atemwege-polterabend-694ca7612cf8@brauner>
 <20231108-herleiten-bezwangen-ffb2821f539e@brauner>
 <ZUyCeCW+BdkiaTLW@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZUyCeCW+BdkiaTLW@infradead.org>

On Wed, Nov 08, 2023 at 10:55:52PM -0800, Christoph Hellwig wrote:
> On Wed, Nov 08, 2023 at 05:20:06PM +0100, Christian Brauner wrote:
> > This would also allow tools that want to to detect when they're crossing
> > into a new subvolume - be it on btrfs or bcachefs - and take appropriate
> > measures deciding what they want to do just relying on statx() without
> > any additional system calls.
> 
> How?  If they want to only rely on Posix and not just he historical
> unix/linux behavior they need to compare st_dev for the inode and it's
> parent to see if it the Posix concept of a mount point (not to be
> confused with the Linux concept of a mountpoint apparently) because
> that allows the file system to use a new inode number namespace.

That doesn't work anymore. Both overlayfs and btrfs make this
impossible or at least inconsistent.

Tools that want to rely on that definition can continue to do so and
really just ignore any of the new features. But tools that want to know
about this and adjust behavior can really benefit from this. Just
marking an inode as a subvolume root is worth it without committing to
any filesystem specifics now that we have two of them.

