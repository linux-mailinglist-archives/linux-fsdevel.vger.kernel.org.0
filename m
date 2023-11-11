Return-Path: <linux-fsdevel+bounces-2750-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0858B7E8AC2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Nov 2023 12:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22EE41C20846
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Nov 2023 11:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82A514265;
	Sat, 11 Nov 2023 11:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a7gS8VLQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A7A13FFA
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 Nov 2023 11:52:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5807CC433C8;
	Sat, 11 Nov 2023 11:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1699703558;
	bh=+XSoOsUIt+Qklc0oDQmck6hgWaZwqafHOVXnnzp3INY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a7gS8VLQXMJPQ7p1Z/w5kxb1bzJ1a6DogrBwWUxLBNZtWgvetyHZMDIt/WFIv0Oo5
	 Rk3P/luja1a6OtBQXq8YOtWtA1EXz1FECoOWJiEDngzWh8bsYX7JD2o0owAqkIsi2e
	 Vvt/oYUQ/Tp0yl2afjwV/j+UXyR0FzSf/6yGJSVw=
Date: Sat, 11 Nov 2023 06:52:36 -0500
From: Greg KH <gregkh@linuxfoundation.org>
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
	virtio-fs@redhat.com, mzxreary@0pointer.de, stefanha@redhat.com
Subject: Re: [Virtio-fs] [PATCH] virtiofs: Export filesystem tags through
 sysfs
Message-ID: <2023111104-iron-colossal-960f@gregkh>
References: <20231005203030.223489-1-vgoyal@redhat.com>
 <CAJfpegspVnkXAa5xfvjEQ9r5__vXpcgR4qubdG8=p=aiS2goRg@mail.gmail.com>
 <ZSRg2uiBNmY4mKHr@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSRg2uiBNmY4mKHr@redhat.com>

On Mon, Oct 09, 2023 at 04:21:46PM -0400, Vivek Goyal wrote:
> On Mon, Oct 09, 2023 at 11:53:42AM +0200, Miklos Szeredi wrote:
> > On Thu, 5 Oct 2023 at 22:30, Vivek Goyal <vgoyal@redhat.com> wrote:
> > >
> > > virtiofs filesystem is mounted using a "tag" which is exported by the
> > > virtiofs device. virtiofs driver knows about all the available tags but
> > > these are not exported to user space.
> > >
> > > People have asked these tags to be exported to user space. Most recently
> > > Lennart Poettering has asked for it as he wants to scan the tags and mount
> > > virtiofs automatically in certain cases.
> > >
> > > https://gitlab.com/virtio-fs/virtiofsd/-/issues/128
> > >
> > > This patch exports tags through sysfs. One tag is associated with each
> > > virtiofs device. A new "tag" file appears under virtiofs device dir.
> > > Actual filesystem tag can be obtained by reading this "tag" file.
> > >
> > > For example, if a virtiofs device exports tag "myfs", a new file "tag"
> > > will show up here.
> > >
> > > /sys/bus/virtio/devices/virtio<N>/tag
> > >
> > > # cat /sys/bus/virtio/devices/virtio<N>/tag
> > > myfs
> > >
> > > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> > 
> > Hi Vivek,
> > 
> > This needs something under Documentation/.
> 
> Hi Miklos,
> 
> Hmm.., I can easily update the virtiofs documentation.
> 
> Initially I was thinking to put something in Documentation/ABI/testing/
> as well. But I don't see any virtio related. In fact can't find any
> files related to "virtio" at all.
> 
> So I will just update the Documentation/filesystems/virtiofs.rst for now.

No, please put it in Documentation/ABI/ that is where sysfs file
information goes, and where our tools actually look for it (and test for
it!)

thanks,

greg k-h

