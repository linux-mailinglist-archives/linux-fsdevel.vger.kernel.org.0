Return-Path: <linux-fsdevel+bounces-54889-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E50B048D8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 22:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4F964A04B2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 20:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342C623A9AC;
	Mon, 14 Jul 2025 20:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="WVcUu3Ec"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3362C238C36
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Jul 2025 20:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752526415; cv=none; b=iA/cv0PvF8MiYJN0T81YQAYkR+zbFDTeBKRbJXg69vlPYR+p3r4wBSj+dPw9a45CzYSES+k8bVKE67ymLSzy4IZNUCu3oOIe/U4CQoz9qhsgAH0fLJyU0I9u+ryDBObkZ0C4Y6vxV8XzIJuhPqJNARY40+OOkJITYyC/rtDbPtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752526415; c=relaxed/simple;
	bh=tawgDwkEVojw2NKv3CCTeFgxnOZvyRkv0Ij9fIpT1q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uW+DkSwBhohAWtjAcE2FGb96Ikbhm46ZGnyhvS6dbc4tauAViT7ByPscRLh1jQGoURNE8QL5g2OYGGk/rovHJCx2BcUeuBv9Upowp8W23jWkUAbekUXpZ01vK67lwh1fqt4X5MVwgb+fO9SoAs/+5Y7M1TF+7SuyzntvsoXWIFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=WVcUu3Ec; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-74b50c71b0aso2718057b3a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Jul 2025 13:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1752526413; x=1753131213; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5cPjSq9x4JfK6ES05iG56c2eRWJnFpbKNKAZhIdXJx4=;
        b=WVcUu3EcyUWDMr4Db3o/k3d1rGqBToLoC4m6y7TOnYgaQF6NVsoW4Qz1hJFxqVy/rb
         yvdvB03zGshWUydtQl9Ki5USN8M3JvnCiRk4CcgPUUez8WYwn0P7dbK0l4Hh1kWZN41k
         PY8OQjJbpphLNFzraemZ3WHnLqXoxZzvOPGRm11OWCLmq0hngEuvVQWZUTMx3h9MGkPp
         rtlXoS3MNwRzraFe7JqspyFbBI1XFkWRnkDAhEvzTxblL35OJxF5WRuo/XVkFV8v2KMW
         FRNYxf114pSiL+L60F/xcUneJewAOmZueur0anMFLWpMh8skgjCWAD0enfSDvYnC68nq
         k5dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752526413; x=1753131213;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5cPjSq9x4JfK6ES05iG56c2eRWJnFpbKNKAZhIdXJx4=;
        b=oI1pJuCUKVIYL/+hADvBuTme+JwnnoKi4bJbsp+dBHXSYnY7dKTOFE00pn/PGEeZw3
         lbV8N+6ZNF3Ylj9VqudhaWhHRBZxO0bikA6FI1LNl6U62ck2F11ZGtDCnKtg6qii0fE7
         mAs9YssF/I6Hhvxbd5Su5NduHmZZ7hHCyzAJbwaBpDtjgXluRnmkfeazeFiQshiSQ35f
         c0SfTO+g9AaW8Se5n86RPIqkZI+ThDXuuotMKsWYP6Gtd//W2xp1ezOP8xVd1RxhV6FC
         /nXWAKECbzV3mEctagxBwX8tMSNDgXhsd4tbKi7Vbr2F9VL++cOd28Xmo9QEznqoF0xP
         0fRw==
X-Forwarded-Encrypted: i=1; AJvYcCVPoIzMl+n79NqlJqp8DsvQYth/cNGb3nu8SnV7djUO7irAO/6u7hgInb2CNAsBdYTFUj7MoJacsoXTq2aA@vger.kernel.org
X-Gm-Message-State: AOJu0YwhQn3e2ToeEgiYA+gKXotUgJEzc2nnLf0N5xRse7f6hdrNjuJl
	znOLHl8Sz/k1DQO16c0fWPltOaU/Z4+uB0u7YWl6tPtd0g5mqCGhsUviths1tCzE2ZE=
X-Gm-Gg: ASbGncs0YZe93EMs8z6KLlH2kbD5KoWgYQfEM2fHRq5iAAv54PAllFBSEdG84IgjRay
	xyObg7OQ61LyTE25ixMGxLxcDsR1eZDM64RCVnoyGhlBqRSoaJ3c8ixblT11jgrWSgcGCZNdZ7o
	Xne09f20rWP/xChs5KoZwf5r7LiFDJqs3XDIlmXe70BNvvGbAxxcfUFK/ajl6nIbpkTS8NRkoEO
	raOi/zrEzie4KLUXYfuw/XsmpHXbBc+4yCsi3D8tu8trgKSswjfPoeDuOCdMLHGUVoG2et6FByh
	d2J1h+KQxiQXYq5l0BYZx+tZEHuFTdMMikIgANX4b9CddGc5YD5agMCTSBwnBSg+PQXCSdisnMn
	Il/Ba/vxFpdy7EbsSpzArcZBUFDwyhFiFPd1vLOZcJTM5ZRs2hjg427eDr0TiPbHPJMM/Kfbkrw
	==
X-Google-Smtp-Source: AGHT+IHnv77H5wfprCmfDWdElJKQH3XAqXLK31tfmThyrslKpxVkW1UVIPHA5IdRfKXL32HPE3IWSA==
X-Received: by 2002:a05:6300:40f:b0:232:1668:848d with SMTP id adf61e73a8af0-23216688519mr15759146637.27.1752526413510;
        Mon, 14 Jul 2025 13:53:33 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-184-88.pa.nsw.optusnet.com.au. [49.180.184.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe7297bcsm10529816a12.73.2025.07.14.13.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 13:53:32 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1ubQAz-0000000B4D2-3tkT;
	Tue, 15 Jul 2025 06:53:29 +1000
Date: Tue, 15 Jul 2025 06:53:29 +1000
From: Dave Chinner <david@fromorbit.com>
To: Christoph Hellwig <hch@lst.de>
Cc: John Garry <john.g.garry@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: Do we need an opt-in for file systems use of hw atomic writes?
Message-ID: <aHVuSU3TB4eNRq8V@dread.disaster.area>
References: <20250714131713.GA8742@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714131713.GA8742@lst.de>

On Mon, Jul 14, 2025 at 03:17:13PM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> I'm currently trying to sort out the nvme atomics limits mess, and
> between that, the lack of a atomic write command in nvme, and the
> overall degrading quality of cheap consumer nvme devices I'm starting
> to free really uneasy about XFS using hardware atomics by default without
> an explicit opt-in, as broken atomics implementations will lead to
> really subtle data corruption.
> 
> Is is just me, or would it be a good idea to require an explicit
> opt-in to user hardware atomics?

This isn't a filesystem question - this is a question about what
features the block device should expose by default to the
user/filesystem by default.

Block device feature configuration is typically done at hotplug time
with udev rules.  Require the user to add a custom udev rule for the
block device to enable hardware atomics if you are concerned that
hardware atomic writes are problematic.

Once the user has opted in to having their bdev feature activated,
then the filesystem should be able to detect and use it
automatically.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

