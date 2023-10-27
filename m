Return-Path: <linux-fsdevel+bounces-1320-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDCC7D8FCB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 09:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88BDC1F23497
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 07:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9D6BA40;
	Fri, 27 Oct 2023 07:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ymw7Y0vk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4814E8489
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 07:28:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B14192;
	Fri, 27 Oct 2023 00:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=8/05csco78lhslJvbFaxQUgN8P1NV2s/miTgwO3CDd0=; b=Ymw7Y0vk2yyy7FOY6UpPF3FPWp
	wpQoxwCRYKF/S1j3emXpzQSlAjBrsXtWIJLgg/kYKwBhLhDnZI5cQtMdMB25hftKeybk4WqTQJ6kV
	tVZ53NExzI7KqfTG/omuVuGcW5I34tfO39rM4LaMm3aIEEDE8KDjdcszcV+QSaQRE994XdIAT0ypG
	EncVhXIlU8vBXiOw9vVvRiU2vaNIWFzRpFmTYD5y2CCd85ZKQ+9Smsm71CTqcoLpKuZoQWWhh7SZl
	RGRJJe1JJ7fHz4zbUwhMtZM5rVdZKmUEdoN7UMHJLtkcrWcIOCIEyKliH+wyDo3NK0yefqgWGpBAF
	YkxswOSQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qwHGh-00Fmon-0V;
	Fri, 27 Oct 2023 07:28:31 +0000
Date: Fri, 27 Oct 2023 00:28:31 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] exportfs: handle CONFIG_EXPORTFS=m also
Message-ID: <ZTtmn4o8WrU4+yHM@infradead.org>
References: <20231026192830.21288-1-rdunlap@infradead.org>
 <CAOQ4uxhYiu+ou0SiwYsuSd-YayRq+1=zgUw_2G79L8SxkDQV7g@mail.gmail.com>
 <ZTtSJYVmZ/l3d9wD@infradead.org>
 <CAOQ4uxjxTw0k33XqoEUrT6iHdOWrnyMMF=V19ph=HMvqOfC51w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxjxTw0k33XqoEUrT6iHdOWrnyMMF=V19ph=HMvqOfC51w@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Oct 27, 2023 at 09:11:57AM +0300, Amir Goldstein wrote:
> On Fri, Oct 27, 2023 at 9:01 AM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Thu, Oct 26, 2023 at 10:46:06PM +0300, Amir Goldstein wrote:
> > > I would much rather turn EXPORTFS into a bool config
> > > and avoid the unneeded build test matrix.
> >
> > Yes.  Especially given that the defaul on open by handle syscalls
> > require it anyway.
> 
> Note that those syscalls depend on CONFIG_FHANDLE and the latter
> selects EXPORTFS.

Yes, this means that for all somewhat sane configfs exportfs if always
built in anyway.  And for the ones where it isn't because people
are concerned about micro-optimizing kernel size, nfsd is unlikely
to be built in either.

> The bigger issue is that so many of the filesystems that use the
> generic export ops do not select EXPORTFS, so it's easier to
> leave the generic helper in libfs.c as Arnd suggested.

Agreed.


