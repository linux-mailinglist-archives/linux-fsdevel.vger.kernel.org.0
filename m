Return-Path: <linux-fsdevel+bounces-46994-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47444A9735F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 19:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CBA417F24C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 17:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B943296D1C;
	Tue, 22 Apr 2025 17:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="O63QewTx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6B41F099A;
	Tue, 22 Apr 2025 17:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745341962; cv=none; b=qNXVrYlLgMNUFqWGrZh1QAAifpQCEMiDck8+l/AFT2wtRsoVhxcan9cEcPDKxpmGICa9i+LDqufFHvsBEtXvIdMYhIlygnSmdjRVm1G9YgdvNMoxCqcH+NQ5YNsrmggaukuUmBteKrcxffioqfhhf8Pr5cWUlBnZ1gkMZ158lkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745341962; c=relaxed/simple;
	bh=Xkc61/hu/mfyjY3t8KHb69WVra3i/jl1C3l0fK1t+Jc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ae63M4hFkRRV1L+G20tidBHLXW/6WNeFiB32tG0f2vX0Zy0qZp3i6+sOPU6mx/J71b5IC01J0cWU5F6VOuedefcHRAw4jR1YJSW5XSV38lruGEpXUOk5/hzGf7omGRBy0S/2jZdjxAVbYOlolgXCf3CrStFz7YABhLlrum46fOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=O63QewTx; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1aU0iiunrDPRYHbB9QsvReXnK1Fu3QC3DAfxgJKVpac=; b=O63QewTxjK8DVStwfL5aFzIL8E
	uh3ayNse2Ic2OH+JV+W1A8WqoBAs3C7aYQ3onCpaOVO//zAOIlShRFs9mmEKc6t9fw2jPzGF0ZD+3
	lyziMZGsuZFsbqkjM7s42pEaZOTXwYvNWZllwIdfsu3EHxgDLWeLXf5ViNhg/KF72MAetQZEz4fK6
	QjfxSurIf6X9+6p+C1hxxagHo96DdUq6M+ZaRhVMU9py6HnVeEZ/OzYeI5qGEh59SWk7vYGUwqRgr
	Pf86ZI4XJz3q0DQcKxG0mPsnjJ3RNDq2V81Ryrr26sYiMwtEjvIX5m85U2X3abuGE52Escnorng8o
	y9mqylLw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7HAj-00000006mni-1kcb;
	Tue, 22 Apr 2025 17:12:37 +0000
Date: Tue, 22 Apr 2025 18:12:37 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Marco Elver <elver@google.com>
Cc: Christian Brauner <brauner@kernel.org>,
	syzbot <syzbot+81fdaf0f522d5c5e41fb@syzkaller.appspotmail.com>,
	jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] KCSAN: data-race in choose_mountpoint_rcu /
 umount_tree
Message-ID: <20250422171237.GA2023217@ZenIV>
References: <6807876f.050a0220.8500a.000f.GAE@google.com>
 <20250422-flogen-firmieren-105a92fbd796@brauner>
 <CANpmjNPbVDaw8hzYRRe2_uZ45Dkc-rwqg9oUhoiMo2zg6D0XKw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNPbVDaw8hzYRRe2_uZ45Dkc-rwqg9oUhoiMo2zg6D0XKw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Apr 22, 2025 at 04:42:52PM +0200, Marco Elver wrote:

> Seqlocks are generally supported, but have caused headaches in the
> past, esp. if the reader-side seqlock critical section does not follow
> the typical do-seqbegin-while-retry pattern, or the critical section
> is too large. If I read this right, the
> 
>   struct dentry *mountpoint = m->mnt_mountpoint;
> 
> is before the seqlock-reader beginning with "*seqp =
> read_seqcount_begin(&mountpoint->d_seq);" ?

Different seqlock - mount_lock protects mount tree and it's been sampled
all way back in the beginning of RCU pathwalk...

