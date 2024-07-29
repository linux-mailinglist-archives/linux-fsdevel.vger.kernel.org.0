Return-Path: <linux-fsdevel+bounces-24450-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0F893F722
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 15:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C698EB21E44
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 13:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA2C154C0D;
	Mon, 29 Jul 2024 13:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="mzrbQO8z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB58714EC60
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jul 2024 13:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722261569; cv=none; b=f2h4rYXztSbUZDm+6zbUhA03nlOeDygXakag8yNXrhr/4j2/pMF99YvUnrE/BfwS0eH3lPkZoTmwI2vLQGqOy5JcBvOuJtHfj1z1HWpfCU0h8NvhzA4ev6rCGJUH0jeEtr3ZwSELwF3cJCakq57M2hspwmJcGndVtVyiawFvjug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722261569; c=relaxed/simple;
	bh=RQu8iSqpeNKuiSQCz+oMPqtXvZeV68r8qmaYM5C1oco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ol+/dbf7NZmE/63hMRnN/Txb484P7EHete9BMyuWuTe0JCpMWnCG1Eo8OgHjfE+6OiZFqg3yTdCYGEf+2Sy1DB1eZhkWd8iORWJD9J776NGqsCh3/MoUisQHpSr/2BOn9LzFbGYEKvXRXGkqTJVHFFWGOOR9jumrLAQqEoBbF9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=mzrbQO8z; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-113-198.bstnma.fios.verizon.net [173.48.113.198])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 46TDwmVU016155
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jul 2024 09:58:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1722261532; bh=PM7Dhelwt8evrmwJBsFtoBMEI3ETn1PNdtUW08NA2t0=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=mzrbQO8z5kGT7QrVsd7S36FKlagze53iuANsryUVbqE2vNlJqGm2c7jzPQFw+M/Lo
	 Q6snREaMJuIDbwc9yA+W0bu2/Bek1F4/aRsRcCqpcStJgP6lLpQyUIxYMqMasNMmJe
	 MKAbdgzt3IvNc3aAcH6IfoBl8lh48hVSB0VW7kz3pmapwQ/kXr7SI9eLF6vHd3d8RW
	 uR3AQ/CMwQoewSX6076TUuXVYlqYlieHJ5OJS2ySdJEUrdWVFKoC1xuFrsYdL57xmn
	 A27g05NMVy4148nADQRz8SrUDI84rPzMGWygSrUMeazfyeyfieFGc/yRi17Bl6bBkl
	 w2Tkh1JbsZU1A==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id EC47215C02D3; Mon, 29 Jul 2024 09:58:47 -0400 (EDT)
Date: Mon, 29 Jul 2024 09:58:47 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        syzbot <syzbot+20d7e439f76bbbd863a7@syzkaller.appspotmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Mateusz Guzik <mjguzik@gmail.com>,
        paulmck@kernel.org, Hillf Danton <hdanton@sina.com>,
        rcu@vger.kernel.org, frank.li@vivo.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [f2fs?] WARNING in rcu_sync_dtor
Message-ID: <20240729135847.GB557749@mit.edu>
References: <0000000000004ff2dc061e281637@google.com>
 <20240729-himbeeren-funknetz-96e62f9c7aee@brauner>
 <20240729132721.hxih6ehigadqf7wx@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729132721.hxih6ehigadqf7wx@quack3>

On Mon, Jul 29, 2024 at 03:27:21PM +0200, Jan Kara wrote:
> 
> So in ext4 we have EXT4_FLAGS_SHUTDOWN flag which we now use
> internally instead of SB_RDONLY flag for checking whether the
> filesystem was shutdown (because otherwise races between remount and
> hitting fs error were really messy). However we still *also* set
> SB_RDONLY so that VFS bails early from some paths which generally
> results in less error noise in kernel logs and also out of caution
> of not breaking something in this path. That being said we also
> support EXT4_IOC_SHUTDOWN ioctl for several years and in that path
> we set EXT4_FLAGS_SHUTDOWN without setting SB_RDONLY and nothing
> seems to have blown up. So I'm inclined to belive we could remove
> setting of SB_RDONLY from ext4 error handling. Ted, what do you
> think?

Well, there are some failures of generic/388 (which involves calling
the shutdown ioctl while running fsstress).  I believe that most of
those failures are file system corruption errors, as opposed to other
sorts of failures, but we don't run KASAN kernels all that often,
especially since generic/388 is now on the exclude list.

The failure rate of generic/388 varies depending on the storage device
involved, but it varies from less than 10% to 50% of the time, if
memory serves correctly.  Since EXT4_IOC_SHUTDOWN is used most of the
time as a debugging/test (although there are some users use it in
production, but the failure rate when you're not doing something
really aggressive like fsstress is very small), this has been on the
"one of these days, when we have tons of free time, we should really
look into this.  The challenge is fixing this in a way that doesn't
involve adding new locking in various file system hotpaths.

So "nothing seems to have blown up" might be a bit strong.  But it's
something we can try doing, and see whether it results in more rather
than less syzbot complaints.

> Also as the "filesystem shutdown" is spreading across multiple
> filesystems, I'm playing with the idea that maybe we could lift a
> flag like this to VFS so that we can check it in VFS paths and abort
> some operations early.  But so far I'm not convinced the gain is
> worth the need to iron out various subtle semantical differences of
> "shutdown" among filesystems.

I think that might be a good idea.  Hopefully subtle semantic
differences are ones that won't matter in terms of the VFS aborting
operations early.

						- Ted

