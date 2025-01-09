Return-Path: <linux-fsdevel+bounces-38731-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C9EA0761C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 13:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B13F167EA8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 12:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE97218599;
	Thu,  9 Jan 2025 12:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OkM9Mwvl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58C7215074;
	Thu,  9 Jan 2025 12:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736427121; cv=none; b=UIxwVDP24FdFibpWmQ03IXwmGGdJom8taOOes51I3K1+PooCvnycKNJ+AwLNXCCZ/qxZrbduM3cvk8Bj5bq5+9ozEMKFSK09AGDIidzXcMYtKpVU9t/3Le5JR/rlh+3xeNicrrQNdm7ajOKfxMEX4D6c6plGqt4GCyv/KRBK0G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736427121; c=relaxed/simple;
	bh=6rL6tUKhjj3WyA+6BhezGDghygJw8yrS/N5DE4lxM0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b9As4Klvocnziv6/gNRWh8+CpuQ9ETAxxEt1pzpwxz3b1HdXzaqsGWjAJoy/ftMGdbu8+m7EwSrCOMnITO+wFt3Io8WRCBJPpEQ8Mn8EsXao7quWt0zB5SUtoSMSc9J/cJAcdmhMACePCZm3C7y9yqKZbPSm4fLAXWz7zndyJdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OkM9Mwvl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C7BDC4CED2;
	Thu,  9 Jan 2025 12:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736427120;
	bh=6rL6tUKhjj3WyA+6BhezGDghygJw8yrS/N5DE4lxM0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OkM9MwvlkD0KZChe88jyz6vLE1koIrsv1Sb96OB3JTHE7NScbmtyGT9otlMzshB5k
	 WHvOBvAsL4SjOa/wVdxxyP0m0dI/zFxWBx9abYyy7362Gh/RTW04/bcScWe6O35C9X
	 fgYKtIDoU1+amkkzJL90jnG7pa/KI3t4lF+H9ROoBdf8wJJAiFASPynkmYoVl7bTd2
	 FQEIXxFSnQ7a3Bbw75oJbSVw4Z2IBviJOkRFXEY12m9uFAME4holB1yKRpXePj46sl
	 QkJDlAtO6XMGLeRXQoJ5ENBIXW+IrMUf8rmayQicYg2FQLFWOyg+/7UPKO5pS5s4Tt
	 4kJJ8/deYogPg==
Date: Thu, 9 Jan 2025 13:51:56 +0100
From: Christian Brauner <brauner@kernel.org>
To: Daniel Vacek <neelx@suse.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-fsdevel@vger.kernel.org, 
	linux-btrfs <linux-btrfs@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: mnt_list corruption triggered during btrfs/326
Message-ID: <20250109-unabsehbar-dehnen-52c493b5c1fd@brauner>
References: <ec6784ed-8722-4695-980a-4400d4e7bd1a@gmx.com>
 <324cf712-7a7e-455b-b203-e221cb1ed542@gmx.com>
 <20250104-gockel-zeitdokument-59fe0ff5b509@brauner>
 <CAPjX3FepKnPQhhUpgaqFbj_W54WwcxBa++-C1AVd1GDi98-t4g@mail.gmail.com>
 <20250107-infusion-aushilfen-0110ff7c9e61@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250107-infusion-aushilfen-0110ff7c9e61@brauner>

On Tue, Jan 07, 2025 at 04:00:34PM +0100, Christian Brauner wrote:
> > > Can you please try and reproduce this with
> > > commit 211364bef4301838b2e1 ("fs: kill MNT_ONRB")
> > 
> > This patch should indirectly address both errors but it does not
> > explain why the flag is sometimes missing.
> 
> Yeah, I'm well aware that's why I didn't fast-track it.
> I just didn't have the time to think about this yet.

I think I know how it happens.

btrfs_get_tree_subvol()
{
	mnt = fc_mount()
	// Register the newly allocated mount with sb->mounts:
	lock_mount_hash();
	list_add_tail(&mnt->mnt_instance, &mnt->mnt.mnt_sb->s_mounts);
	unlock_mount_hash();
}

So now it's public on sb->s_mounts.

Concurrently someone does a ro remount:

reconfigure_super()
-> sb_prepare_remount_readonly()
   {
           list_for_each_entry(mnt, &sb->s_mounts, mnt_instance) {
   }

This walks all mounts registered in sb->s_mounts and raises
MNT_WRITE_HOLD, then raise MNT_READONLY, and then removes
MNT_WRITE_HOLD.

This can happen concurrently with mount_subvol() because sb->s_umount
isn't held anymore:

-> mount_subvol()
   -> mount_subtree()
      -> alloc_mnt_ns()
         mnt_add_to_ns()
	 vfs_path_lookup()
	 put_mnt_ns()

The flag modification of mnt_add_to_ns() races the flag modification of
the read-only remount. So MNT_ONRB might be lost...

If that's correct, then a) we know how this happens and b) that killing
MNT_ONRB is the correct fix for this.

