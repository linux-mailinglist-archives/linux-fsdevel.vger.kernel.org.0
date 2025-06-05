Return-Path: <linux-fsdevel+bounces-50724-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF03ACEEB3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 13:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C92A27A9650
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 11:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE6E1F418D;
	Thu,  5 Jun 2025 11:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OMNlcLlr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE10E1F4C8B
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Jun 2025 11:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749124208; cv=none; b=DhM9QcPTJFDqIrE6g/yqxlz547Uu1FoyTEN4tAYSGC4kNk/Ag+cdTz5G0OOEy14W75lRdOjDyE6WrgmUocdQjwOxGOMevwKTbIlsCiA/n7NbcEbHGW4hnldyrCqy5jOisJPk4oh/50AtkM2zuIPygwYBnrxRNKRaX8sGy9uJrLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749124208; c=relaxed/simple;
	bh=XL/XPNORzoa8dBjdpqpKrjEr2eeoUqWPIHHPNQi75u0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iyplkd7A1MwRuk7Hh9bxSQxfdIzJPCdbciNzf3quKQRy6GNPR95vuYP5eyEbkp8lL3JJepMeJFo0cTwWgXoUveOmthAWOLr+xV//k6DK4fvNmYOZU6tGi8zcQXjxhIo47lyxhzFkb3FUDKirkgW2iLeD4AwnZsDJaubqqmeLH5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OMNlcLlr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B707CC4CEE7;
	Thu,  5 Jun 2025 11:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749124208;
	bh=XL/XPNORzoa8dBjdpqpKrjEr2eeoUqWPIHHPNQi75u0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OMNlcLlrCSRNKBKYLvyL0b11+R+TbdRA5o4DUiWgEPsTLICsNXwt4jCpiXm1W0vee
	 PaFKSqOzw0wbuMds6bQGaI1+EmALRCXFv+RzQ0MmqjYn7HiT8ZbfLIE61VmRE5SyiP
	 3ewZ07ta/AnvG3BWsmqrXc0SdUy/3AFdJK2rHSd+g6npUCgcPh5MR21C/GUogYTFFg
	 aVuNv9KQMTleH0Mrhz8m9YUIIBDy6Qr18moGJq6SK06qmLVO+Vg1TusDnHcn/R7wJq
	 znPQV3LUNggABQXFyb0z7dpaXwivlw0njwg56CCMvFRsGgj7B805TM4SF9tMClSk7I
	 Tq1O7bmT8xvhw==
Date: Thu, 5 Jun 2025 13:50:03 +0200
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, NeilBrown <neil@brown.name>
Subject: Re: [PATCH] ovl: fix regression caused for lookup helpers API changes
Message-ID: <20250605-futter-harfe-67c3532e6021@brauner>
References: <20250605101530.2336320-1-amir73il@gmail.com>
 <20250605-bogen-ansprachen-08f6b5554ad4@brauner>
 <CAOQ4uxgf+0B5vy1ObhLqeRNmW8JzdotqHAwG7qS3xBZmfAABvQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgf+0B5vy1ObhLqeRNmW8JzdotqHAwG7qS3xBZmfAABvQ@mail.gmail.com>

On Thu, Jun 05, 2025 at 01:14:20PM +0200, Amir Goldstein wrote:
> On Thu, Jun 5, 2025 at 1:00 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Thu, 05 Jun 2025 12:15:30 +0200, Amir Goldstein wrote:
> > > The lookup helpers API was changed by merge of vfs-6.16-rc1.async.dir to
> > > pass a non-const qstr pointer argument to lookup_one*() helpers.
> > >
> > > All of the callers of this API were changed to pass a pointer to temp
> > > copy of qstr, except overlays that was passing a const pointer to
> > > dentry->d_name that was changed to pass a non-const copy instead
> > > when doing a lookup in lower layer which is not the fs of said dentry.
> > >
> > > [...]
> >
> > Applied to the vfs.fixes branch of the vfs/vfs.git tree.
> > Patches in the vfs.fixes branch should appear in linux-next soon.
> >
> 
> Could you fix the grammatical mistake in my commit title:
> 
> s/caused for/caused by/

Already done including the ones in the comments to your fix. ;)

