Return-Path: <linux-fsdevel+bounces-52688-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 109FBAE5D65
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 09:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 437F63AA1F2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 07:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082D32522B5;
	Tue, 24 Jun 2025 07:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="TfTFuHG9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6298D25178E
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jun 2025 07:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750748738; cv=none; b=BNRZ28nuMlOyzL7KW1L6y+YTwK+MLlf0UcLdE9JnQTpAusP3nDvCVaMnlh5dUQiTbREnCuCgLvcTV6A0zVBpU1/XeR0lT0MEyVxoskfVQKPpgnYc1agezWenLDIiGTo8pXxFbrstaTm+fnbNOPhPik3njpXEzY7Jff0DErCE0B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750748738; c=relaxed/simple;
	bh=li+fONKsQ/7iUb0KZnZ4z4AT6Mv9rKgs6oWLXu3Lqjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DYHRUPez1O4uHw03nhUUKcDai87iOhTXVm7OwfPSUPVnSmJ3q+O+0GF+gDbf60Ely3RhNLZhk8CU5is8mdHAPuJ0/I8SBGm8hAu0uO7eHGP+LHaLGBy0IsMWIwoVct5LPLK9ZLI0B5yWlK+ulZOLQaQkV6Ke26mbjrmCmxipX5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=TfTFuHG9; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bjZOFYdYokSYXLpoVqCMF6sInCvYGS/PidERNoSWDb8=; b=TfTFuHG9NJCJiWq8JfB37zluZW
	cKtxAVSU4t/tlWLmdnW+X6cItW0kdAtZZVq+yK5W+JDmWTyvag0B1fd0vL5cXKL6nhD+JHosqXWBz
	D5bur1ng0ZgBgYi2UNhoHjKqiGt58cVBm0S9GMHYOBou+CIkjlNNvUCVz8L3kaqQFXFD3l2Rvv2SC
	9P7MUUL7KriJSJ6CfMjGouN2W8xXduDcKaVaABuWSEGd2DO49J7H5qYGnzsTFcTqp4axVlHB8/Ef6
	6dCGwAuggQp/Ojhu1yiqKFSl0VcJuhVa1qsFpvvQ4OXS+7nw+OlhoO5jsEv4X7kXSgS/hFilafK7g
	8CBTDBwA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTxin-00000008Zw3-46EU;
	Tue, 24 Jun 2025 07:05:34 +0000
Date: Tue, 24 Jun 2025 08:05:33 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Ian Kent <raven@themaw.net>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCHES v2][RFC][CFR] mount-related stuff
Message-ID: <20250624070533.GN1880847@ZenIV>
References: <20250610081758.GE299672@ZenIV>
 <20250623044912.GA1248894@ZenIV>
 <93a5388a-3063-4aa2-8e77-6691c80d9974@themaw.net>
 <20250623185540.GH1880847@ZenIV>
 <45bb3590-7a6e-455c-bb99-71f21c6b2e6c@themaw.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45bb3590-7a6e-455c-bb99-71f21c6b2e6c@themaw.net>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Jun 24, 2025 at 02:48:53PM +0800, Ian Kent wrote:

> Also alter may_umount_tree() to take a flag to indicate a reference to
> the passed in mount is held.
> 
> This avoids unnecessary umount requests being sent to the automount
> daemon if a mount in another mount namespace is in use when the expire
> check is done.

Huh?  I'm probably missing something, but all callers of may_umount_tree()
seem to be passing that flag...  propagate_mount_tree_busy() - sure, but why
does may_umount_tree() get that?

I'm half-asleep at the moment (3am here), so maybe it will make more sense
in the morning...

