Return-Path: <linux-fsdevel+bounces-13180-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A22B586C673
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 11:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BA4128ABA2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 10:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21038651AC;
	Thu, 29 Feb 2024 10:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mBFjhK5d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7722164A8E;
	Thu, 29 Feb 2024 10:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709201371; cv=none; b=tulC48sAA9mM+la66TubO7m9fLoUObm8ODtBY+ZT6uDCZkwcUvHRh/C/5pJJK7tSPehrq9/jNjLw/DcvMzkqZbE79fvsnuZSN6nMNs0VzyMejqxW0h3hE0rUvXeYP2Y27LBp4IYMq4rmVGzjl0Xl7unvsaGHvTwcCwqDZVm2PVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709201371; c=relaxed/simple;
	bh=jTspB3iUz57ARAjdinxW+/Q91yDRnm3gqja4T9fxZTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WrsTKjF96HJg9LsuOEf9iM8DPCUw7ftyD5DjIfnF9N71rtx7kO4DJjCgPx/wzCNFJP7+KfJ9nS4RSXO4XdgE9oetLb29/R4b6pQFobMgvFTTvJWWa4QV7LhkhKpTe/4xVVOWZLf5GYtGfn552X3lNcuA8X369E/+grAN3nLIlHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mBFjhK5d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F695C433F1;
	Thu, 29 Feb 2024 10:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709201371;
	bh=jTspB3iUz57ARAjdinxW+/Q91yDRnm3gqja4T9fxZTA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mBFjhK5d7fJpVw/6bDbc5tkU6ElHDTpzVkK/jIbuftZBarsoqfd0J/td4ycX7Y0NI
	 OwuwPlDbj8ZtIqnlCXOF2pG3huqmMUj5GBAof4EEoDRc9P6XPkyLOZ8+aLsqxoP9yI
	 E+m7pUJjav8Pn5m1m75Em6T0UBx+RyRZKKV0gXMgKErQBBb2lSrjaJ6CNubQUijnjS
	 Dck5QGzkyUjQu7qNjOmf68ZPRsSaTKxIdhCuhIRwbtTaqNBpNuQDQRK4HppSWMejtG
	 bsu5gpSsPoHrMRolGv5LGA7fro/ZxAwUPx7adyrYyWYoONQWysvfvvefct3/hkMK84
	 UhWf04m39lTrg==
Date: Thu, 29 Feb 2024 11:09:24 +0100
From: Christian Brauner <brauner@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Daniel =?utf-8?B?RMOtYXo=?= <daniel.diaz@linaro.org>, 
	Naresh Kamboju <naresh.kamboju@linaro.org>, open list <linux-kernel@vger.kernel.org>, 
	linux-ext4 <linux-ext4@vger.kernel.org>, linux-fsdevel@vger.kernel.org, lkft-triage@lists.linaro.org, 
	Jan Kara <jack@suse.cz>, Andreas Dilger <adilger.kernel@dilger.ca>, 
	Theodore Ts'o <tytso@mit.edu>, Randy Dunlap <rdunlap@infradead.org>, shikemeng@huaweicloud.com, 
	Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: ext4_mballoc_test: Internal error: Oops: map_id_range_down
 (kernel/user_namespace.c:318)
Message-ID: <20240229-stapfen-eistee-9d946b4a3a9d@brauner>
References: <CA+G9fYvnjDcmVBPwbPwhFDMewPiFj6z69iiPJrjjCP4Z7Q4AbQ@mail.gmail.com>
 <CAEUSe79PhGgg4-3ucMAzSE4fgXqgynAY_t8Xp+yiuZsw4Aj1jg@mail.gmail.com>
 <7e1c18e3-7523-4fe6-affe-d3f143ad79e3@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7e1c18e3-7523-4fe6-affe-d3f143ad79e3@roeck-us.net>

On Wed, Feb 28, 2024 at 11:33:36AM -0800, Guenter Roeck wrote:
> On 2/28/24 11:26, Daniel Díaz wrote:
> > Hello!
> > 
> > On Wed, 28 Feb 2024 at 12:19, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> > > Kunit ext4_mballoc_test tests found following kernel oops on Linux next.
> > > All ways reproducible on all the architectures and steps to reproduce shared
> > > in the bottom of this email.
> > > 
> > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > > 
> 
> [ ... ]
> 
> > +Guenter. Just the thing we were talking about, at about the same time.
> > 
> 
> Good that others see the same problem. Thanks a lot for reporting!

Hm...

static struct super_block *mbt_ext4_alloc_super_block(void)
{                                                                                                                                                                                                       struct ext4_super_block *es = kzalloc(sizeof(*es), GFP_KERNEL);
        struct ext4_sb_info *sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
        struct mbt_ext4_super_block *fsb = kzalloc(sizeof(*fsb), GFP_KERNEL);

        if (fsb == NULL || sbi == NULL || es == NULL)
                goto out;

        sbi->s_es = es;
        fsb->sb.s_fs_info = sbi;
        return &fsb->sb;

out:
        kfree(fsb);
        kfree(sbi);
        kfree(es);
        return NULL;
}

That VFS level struct super_block that is returned from this function is
never really initialized afaict? Therefore, sb->s_user_ns == NULL:

i_uid_write(sb, ...)
-> NULL = i_user_ns(sb)
   -> make_kuid(NULL)
      -> map_id_range_down(NULL)

Outside of this test this can never be the case. See alloc_super() in
fs/super.c. So to stop the bleeding this needs something like:

static struct super_block *mbt_ext4_alloc_super_block(void)
{
        struct ext4_super_block *es = kzalloc(sizeof(*es), GFP_KERNEL);
        struct ext4_sb_info *sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
        struct mbt_ext4_super_block *fsb = kzalloc(sizeof(*fsb), GFP_KERNEL);

        if (fsb == NULL || sbi == NULL || es == NULL)
                goto out;

        sbi->s_es = es;
        fsb->sb.s_fs_info = sbi;
+       fsb.sb.s_user_ns = &init_user_ns;
        return &fsb->sb;

out:
        kfree(fsb);
        kfree(sbi);
        kfree(es);
        return NULL;
}

