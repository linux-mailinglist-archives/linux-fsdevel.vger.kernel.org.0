Return-Path: <linux-fsdevel+bounces-2057-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9034A7E1DA4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 10:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 295ABB20D15
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 09:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7A6171A9;
	Mon,  6 Nov 2023 09:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5qnBZas"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FABC443D
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 09:57:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C868FC433C7;
	Mon,  6 Nov 2023 09:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699264623;
	bh=rzHnLpsLcwaSyMOYQyHFlfGI9zVL9VbpUnphQkNsJIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A5qnBZasSDZ8riDWZCC+bOZPnszAHCjGSJ098cRA0Uqp8Lj+C1SNyPfye9CoWTdMT
	 TetnlELHnOSaAOnnByVCtILwRcy+uqY2aC2nCOmREbDiLy3Up4/DX4It37iVk2hcMW
	 tVnl10aHm2i2CNeuihTOP174yu9pIkS6pke74nlSdmwK5TffdKGURt/kThfyJnP2JN
	 cAHPkIy25h/5bFrCaelzgoWkTJAuNnRuFFuBp/TsOells19gBRvLpFS3CnsRZKUa5m
	 cHpRCiU6rOtZ0jq2ICgBr5CJaKolJyEyY6ZLG1zEphtZHf5X9vTVSZ0hIzcZwnyDA6
	 OqZTIgmADB/tQ==
Date: Mon, 6 Nov 2023 10:56:57 +0100
From: Christian Brauner <brauner@kernel.org>
To: Qu Wenruo <wqu@suse.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Qu Wenruo <quwenruo.btrfs@gmx.com>,
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
Message-ID: <20231106-drehung-besagen-7fdd84ca5887@brauner>
References: <ZUE0CWQWdpGHm81L@infradead.org>
 <20231101-nutzwert-hackbeil-bbc2fa2898ae@brauner>
 <590e421a-a209-41b6-ad96-33b3d1789643@gmx.com>
 <20231101-neigen-storch-cde3b0671902@brauner>
 <20231102051349.GA3292886@perftesting>
 <20231102-schafsfell-denkzettel-08da41113e24@brauner>
 <ZUUDmu8fTB0hyCQR@infradead.org>
 <20231103-kursleiter-proklamieren-aae0a02aa1a4@brauner>
 <ZUibZgoQa9eNRsk4@infradead.org>
 <1d08a205-b2c5-4276-b271-088facc142ea@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1d08a205-b2c5-4276-b271-088facc142ea@suse.com>

> Another thing is, the st_dev situation has to be kept, as there are too many
> legacy programs that relies on this to distinguish btrfs subvolume
> boundaries, this would never be changed unfortunately, even if we had some
> better solution (like the proposed extra subvolid through statx).

It would retain backwards compatibility as userspace would need to
explicitly query for STATX_SUBVOLUME otherwise they get they fake
st_dev.

> Which I believe the per-subvolume-vfsmount and the automount behavior for
> subvolume can help a lot.

Very much opposed to this at this point. I've seen the code for this in
the prior patchset and it's implication nothing about this makes me want
this.

