Return-Path: <linux-fsdevel+bounces-45611-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4F7A79E2E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 10:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84ADC1898423
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 08:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD819242900;
	Thu,  3 Apr 2025 08:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="loTtuiX9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B30A241CA0;
	Thu,  3 Apr 2025 08:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743668954; cv=none; b=myVPcHWAu4ZsiRP+P7ff9smiWFCbySEuaYST+tMLCfjql+xG09BIgm0CZfDPPH+u+/kZNsN60vSBppXEUyNlAqkrA/gEPacEOZIrdXINu9qRJ4dmLhV0OKTlurct747jRQgbQaym+3XIOh5ARYiH5wFyqMgX/w3wWFzDPTUr9dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743668954; c=relaxed/simple;
	bh=6Q0o/wQZri1Pyt2xHdfoIcLzBUXXSfJYHFcZ/T1SrAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AXGg2JkPE9YS9zFaF7Wh+kbxDaDaoAdnQ8LP8aItRDhYyu7ijkg9E2F5Jt4IDm2+mrVf2WOVjQ+z26lJ5uUQluxjwzXjBTun45UEIk4emFLuaqFScmT5xdShnA68sN/IOp9ZLJG+8W2NWeM6PBzmks7ERINqZukATsZCHBPfDDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=loTtuiX9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EF75C4CEE3;
	Thu,  3 Apr 2025 08:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743668953;
	bh=6Q0o/wQZri1Pyt2xHdfoIcLzBUXXSfJYHFcZ/T1SrAs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=loTtuiX9XmfuQGA0az8bjKDUu+NtWlEwvlVhODlRMMCmPwcklfnDRFVadarrNIov4
	 xvgB5UP6JlyCiSudM4rZAu/a97d1ZYb8zxDEmQVNTqeYBju7cVCoCp3/Hhoh1I2J0S
	 Dge32ZVYG7YN/bDTpdi9yqe8w02jM0IiMjS7VJ7jpZFKF5nmCA61qIkpK4duuvMgU1
	 +6oBIimpFhPEP4QdB1OIN2OKmZyyzuIbtE7dFLNYYFi58DDUMuKirIHV//ir5sxXvp
	 exFdNFJatapTdoTTzY1ouJs00TGLQzA/M78vjTLVEFUE9gOYZT4paULxzcfGB74wCi
	 Evo+xkPTYT+ig==
Date: Thu, 3 Apr 2025 10:29:08 +0200
From: Christian Brauner <brauner@kernel.org>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "dan.carpenter@linaro.org" <dan.carpenter@linaro.org>, 
	"lkp@intel.com" <lkp@intel.com>, David Howells <dhowells@redhat.com>, 
	Patrick Donnelly <pdonnell@redhat.com>, "slava@dubeyko.com" <slava@dubeyko.com>, 
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	Alex Markuze <amarkuze@redhat.com>, "willy@infradead.org" <willy@infradead.org>, 
	"idryomov@gmail.com" <idryomov@gmail.com>
Subject: Re: [PATCH] ceph: fix variable dereferenced before check in
 ceph_umount_begin()
Message-ID: <20250403-quast-anpflanzen-efe6b672fc24@brauner>
References: <20250328183359.1101617-1-slava@dubeyko.com>
 <Z-bt2HBqyVPqA5b-@casper.infradead.org>
 <202939a01321310a9491eb566af104f17df73c22.camel@ibm.com>
 <20250401-wohnraum-willen-de536533dd94@brauner>
 <3eca2c6b9824e5bf9b2535850be0f581f709a3ba.camel@ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3eca2c6b9824e5bf9b2535850be0f581f709a3ba.camel@ibm.com>

On Tue, Apr 01, 2025 at 06:29:06PM +0000, Viacheslav Dubeyko wrote:
> On Tue, 2025-04-01 at 12:38 +0200, Christian Brauner wrote:
> > On Fri, Mar 28, 2025 at 07:30:11PM +0000, Viacheslav Dubeyko wrote:
> > > On Fri, 2025-03-28 at 18:43 +0000, Matthew Wilcox wrote:
> > > > On Fri, Mar 28, 2025 at 11:33:59AM -0700, Viacheslav Dubeyko wrote:
> > > > > This patch moves pointer check before the first
> > > > > dereference of the pointer.
> > > > > 
> > > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > > > > Closes: https://lore.kernel.org/r/202503280852.YDB3pxUY-lkp@intel.com/   
> > > > 
> > > > Ooh, that's not good.  Need to figure out a way to defeat the proofpoint
> > > > garbage.
> > > > 
> > > 
> > > Yeah, this is not good.
> > > 
> > > > > diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> > > > > index f3951253e393..6cbc33c56e0e 100644
> > > > > --- a/fs/ceph/super.c
> > > > > +++ b/fs/ceph/super.c
> > > > > @@ -1032,9 +1032,11 @@ void ceph_umount_begin(struct super_block *sb)
> > > > >  {
> > > > >  	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(sb);
> > > > >  
> > > > > -	doutc(fsc->client, "starting forced umount\n");
> > > > >  	if (!fsc)
> > > > >  		return;
> > > > > +
> > > > > +	doutc(fsc->client, "starting forced umount\n");
> > > > 
> > > > I don't think we should be checking fsc against NULL.  I don't see a way
> > > > that sb->s_fs_info can be set to NULL, do you?
> > > 
> > > I assume because forced umount could happen anytime, potentially, we could have
> > > sb->s_fs_info not set. But, frankly speaking, I started to worry about fsc-
> > 
> > No, it must be set. The VFS guarantees that the superblock is still
> > alive when it calls into ceph via ->umount_begin().
> 
> So, if we have the guarantee of fsc pointer validity, then we need to change
> this checking of fsc->client pointer. Or, probably, completely remove this check
> here?

If the fsc->client pointer can be NULLed before the mount is shut down
then yes. If it can't then the check can be removed completely.

