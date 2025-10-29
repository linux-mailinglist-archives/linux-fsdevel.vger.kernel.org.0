Return-Path: <linux-fsdevel+bounces-66174-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0694DC182B9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 04:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E62A14E8A4C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 03:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F2B2EC562;
	Wed, 29 Oct 2025 03:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="XcXd34Uj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F3078F2B;
	Wed, 29 Oct 2025 03:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761708254; cv=none; b=dHd7HWpIxzq6+MXGmsPOSMkOOUTw9wlnjUwVrKcKIWyZ/kxd6JUfMpNREdkQKdw1FrAMxa8v5Jow4Qsc9lxrkw3w+y8WZ5tA9Qgkz1L/ZnzW58Cn15DppWcb0BiNpi2lmSN2Jh6L7TlwCNYC7o4s/c58iceFu0fE7fkd9paNNn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761708254; c=relaxed/simple;
	bh=3kU3w3v+1u/nUSOObGzhFYNXx/3gI0FR3AhIQTfeUHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZ4kvJAju1k9lEPXQgtgy0Dp2fkDGzinVhR0dey59GxvPXcVsdYOG3hWh/4uF0dWopFwMjS0vklREwYTuJTaKLUKIaneIuVRAfxBpONMIG/PBUHK73hxoaOSwTuXgharJKi5liyBSZMk5Vm8FiIIORdsBieKBlOLqLNbewotecU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=XcXd34Uj; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/74EwcCNII2uB0u4CPJWojlcJa9JLtb0FVKMbO2Wykg=; b=XcXd34Uj7enu+oskIPJPOtc2sW
	+JUVmiqxAcaM83jJ33Kj00wrrLLwo9mF6yh+svt4+qcE1PgJRBuN1EjWahP1tsM29WdL0OMW4u/zI
	wtsAkFC3DMZiEmRlreDEn6/IgmA37eL1BXSnR3JtjGswJcK3NCUEauvGde4K+59f8KsJEo6T5yKwq
	t4bKDSK3qMusrrsuHwPazN+I9d3szv/tBoGXBSjlJL/knw65vXnnJOFJhIz3yUjx4i5Ghlc/+rHgG
	7zcbEOG1Ix7lCoeZLSwiWl97ry3iG7ZT6wVMc9hHzyolLyGaE7QLp2JbVftwMF2LmmAKECmJ3Nj5R
	/es8Sg3A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDwn6-0000000DcBo-2Wtj;
	Wed, 29 Oct 2025 03:24:04 +0000
Date: Wed, 29 Oct 2025 03:24:04 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Paul Moore <paul@paul-moore.com>
Cc: linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
	brauner@kernel.org, jack@suse.cz, raven@themaw.net,
	miklos@szeredi.hu, neil@brown.name, a.hindborg@kernel.org,
	linux-mm@kvack.org, linux-efi@vger.kernel.org,
	ocfs2-devel@lists.linux.dev, kees@kernel.org, rostedt@goodmis.org,
	gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	casey@schaufler-ca.com, linuxppc-dev@lists.ozlabs.org,
	john.johansen@canonical.com, selinux@vger.kernel.org,
	borntraeger@linux.ibm.com, bpf@vger.kernel.org
Subject: Re: [PATCH v2 35/50] convert selinuxfs
Message-ID: <20251029032404.GQ2441659@ZenIV>
References: <20251028004614.393374-1-viro@zeniv.linux.org.uk>
 <20251028004614.393374-36-viro@zeniv.linux.org.uk>
 <CAHC9VhRQNmPZ3Sz496WPgQp-OkijiF7GgmHuR+=Kn3qBE6nj6Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhRQNmPZ3Sz496WPgQp-OkijiF7GgmHuR+=Kn3qBE6nj6Q@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Oct 28, 2025 at 08:02:39PM -0400, Paul Moore wrote:

> I suppose the kill_litter_super()->kill_anon_super() should probably
> be pulled out into another patch as it's not really related to the
> d_make_persistent() change,

It very much is related - anything persistent left at ->kill_sb() time
will be taken out by generic_shutdown_super().  If all pinned objects
in there are marked persistent, kill_litter_super() becomes equivalent
to kill_anon_super() for that fs.

Sure, we can switch to kill_anon_super() in a separate later patch,
but conversion to d_make_persistent() will be a hard prereq for it.
No point splitting that one line, IMO...

