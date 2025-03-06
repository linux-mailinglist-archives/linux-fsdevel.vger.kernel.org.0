Return-Path: <linux-fsdevel+bounces-43380-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7DAFA554D2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 19:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3B26179950
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 18:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1920625CC6D;
	Thu,  6 Mar 2025 18:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ecVWJsoa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F24A255E54;
	Thu,  6 Mar 2025 18:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741285339; cv=none; b=k4EYyYqms2N8VZHxF1ntq8+atAqS8dzkIgHQ5F+uQtZDx/HznVYgAO/v9vqcbG3x+XXZS3MNIHiYwqRGhoRzVZvkGmZsJNTkK78sH4kDaRyuxNaVAVzEyxuj4XDDu2gifCrDQbSM5WzQkeNIPnKh/q0zFXTxkiNVuNWl5l2xg4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741285339; c=relaxed/simple;
	bh=f/DAyFRfrcxycuNo+j6HqGGnFsiZgkCkDeeRtaUS+j0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VzvHikBJMhBaKf92VIZr9jgq2djfmecZ65rZqcStzn7QjBOGpIgYBurh/o+irmlUQDBApbsREHAznZnY5DDtU3x4pBcBAootqXPhb+W0D1NhOoFTCKvXgmhq4BFwLRrNXOxPxte9sJm937yfCrVqldo1P/69EzHWxaq3A+EFjjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ecVWJsoa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8814C4CEE0;
	Thu,  6 Mar 2025 18:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741285338;
	bh=f/DAyFRfrcxycuNo+j6HqGGnFsiZgkCkDeeRtaUS+j0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ecVWJsoar/PsiGE2bBYrH6s5aTX6dM83afvDWAuEGw2U6YeB5w4cAvhXhEwS0pN5C
	 +xuHx1yEJ1sFKq8V5y+MVm7A7o3f8kSMGPdolfIDIB8W8nESaKG7BbuxnTpb+ijYMd
	 Ns5hzJwzsBC42LYkmURAtC+EmlhPnxfQGt/2+Qbf2rTQmHLOzEKUxqZpmXWpr1X96+
	 /EpSbo/2BigofuGHDdu4hpQeCNX/lu196edGTtd7+QC+bTtZj/z4PvmZ7QkmlsoJxs
	 bN6kmwBN58ILxrbRd+SV4FAVfUUuMs6PBF2BLtD2Y2USkJW6GLU5pDtqrMI6/mVnu7
	 5/FbPj8sFlMXw==
Date: Thu, 6 Mar 2025 10:22:17 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
	ritesh.list@gmail.com, jack@suse.cz, tytso@mit.edu,
	linux-ext4@vger.kernel.org, nirjhar.roy.lists@gmail.com,
	zlang@kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] xfstests: Centralizing filesystem configs and
 device configs
Message-ID: <20250306182217.GB2803730@frogsfrogsfrogs>
References: <Z55RXUKB5O5l8QjM@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z55RXUKB5O5l8QjM@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>

On Sat, Feb 01, 2025 at 10:23:29PM +0530, Ojaswin Mujoo wrote:
> Greetings,
> 
> This proposal is on behalf of Me, Nirjhar and Ritesh. We would like to submit
> a proposal on centralizing filesystem and device configurations within xfstests
> and maybe a further discussion on some of the open ideas listed by Ted here [3].
> More details are mentioned below.
> 
> ** Background ** 
> There was a discussion last year at LSFMM [1] about creating a central fs-config
> store, that can then be used by anyone for testing different FS
> features/configurations. This can also bring an awareness among other developers
> and testers on what is being actively maintained by FS maintainers. We recently
> posted an RFC [2] for centralizing filesystem configuration which is under
> review. The next step we are considering is to centralize device configurations
> within xfstests itself. In line with this, Ted also suggested a similar idea (in
> point A) [3], where he proposed specifying the device size for the TEST and
> SCRATCH devices to reduce costs (especially when using cloud infrastructure) and
> improve the overall runtime of xfstests.
> 
> Recently Dave introduced a feature [4] to run the xfs and generic tests in
> parallel. This patch creates the TEST and SCRATCH devices at runtime without
> requiring them to be specified in any config file. However, at this stage, the
> automatic device initialization appears to be somewhat limited. We believe that
> centralizing device configuration could help enhance this functionality as well.
> 
> ** Proposal ** 
> We would like to propose a discussion at LSFMM on two key features: central
> fsconfig and central device-config within xfstests. We can explore how the
> fsconfig feature can be utilized, and by then, we aim to have a PoC for central
> device-config feature, which we think can also be discussed in more detail. At
> this point, we are hoping to get a PoC working with loop devices by default. It
> will be good to hear from other developers, maintainers, and testers about their
> thoughts and suggestions on these two features.
> 
> Additionally, we would like to thank Ted for listing several features he uses in
> his custom kvm-xfstests and gce-xfstests [3]. If there is an interest in further
> reducing the burden of maintaining custom test scripts and wrappers around
> xfstests, we can also discuss essential features that could be integrated
> directly into xfstests, whether from Ted's list or suggestions from others.
> 
> Thoughts and suggestions are welcome.

Considering all the questions downthread, I'm wondering, are you just
going to stuff all the known configs into a single configs/default file
and then modify known_hosts() to set HOST_OPTIONS to that?

	[ -f /etc/xfsqa.config ]             && export HOST_OPTIONS=/etc/xfsqa.config
	[ -f $HOST_CONFIG_DIR/default ]      && export HOST_OPTIONS=$HOST_CONFIG_DIR/default
	[ -f $HOST_CONFIG_DIR/$HOST ]        && export HOST_OPTIONS=$HOST_CONFIG_DIR/$HOST
	[ -f $HOST_CONFIG_DIR/$HOST.config ] && export HOST_OPTIONS=$HOST_CONFIG_DIR/$HOST.config

Then configs/default contains things like:

[xfs_nocrc]
MKFS_OPTIONS="-m crc=0"

Would that work for running configurations in this manner:

	./check -s xfs_nocrc -g all

?

(I am completely ignorant of config files and never use them.)

--D

> 
> ** References **
> [1] https://lore.kernel.org/all/87h6h4sopf.fsf@doe.com/
> [2] https://lore.kernel.org/all/9a6764237b900f40e563d8dee2853f1430245b74.1736496620.git.nirjhar.roy.lists@gmail.com/
> [3] https://lore.kernel.org/all/20250110163859.GB1514771@mit.edu/
> [4] https://lore.kernel.org/all/20241127045403.3665299-1-david@fromorbit.com/
> 

