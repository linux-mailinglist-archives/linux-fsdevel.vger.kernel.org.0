Return-Path: <linux-fsdevel+bounces-53090-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F71AE9F06
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 15:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 322631C449BA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 13:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4958B2E6D09;
	Thu, 26 Jun 2025 13:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HZYW1/qm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2162E54B9
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jun 2025 13:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750945062; cv=none; b=Lxgq0XCzMpzV3kEvwR0AxSGhdZZvY1dPAqsqQfZ7MRQKcytXXgadDpRvKsMk8tYpw/diz0IhnuWV+Nv6by7v4CRlIjXrB+BLP1Mq8Y8dr8a48kbYNWaEa4M1yvpJsrUvyyzIFcOE6cUkZlvDQ+vYlF1PHiyHwVl7U/NtaSCNtLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750945062; c=relaxed/simple;
	bh=w2jzAQH4LMBMSnep14UttjTH0cLF3lqFH/x7Yg1wtpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P45M3PUcE+0xXwTbmk951UI8bIeFzGwcBzeD6htHaoEGoYj/E5Gb1Qpwrk8IIzNzMv6UaVryTi/wGTKEJfrWVZ4+SO9dcYY77Z3kS+wmkLq8CtU4mdT/I3m7lwDNheEpkldfM7/HZT4umktOz3QVhLNa2oG64T2vMcZ7VRWXxv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HZYW1/qm; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 26 Jun 2025 09:37:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750945048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Zd1X+WmxRI1gjnAViN5ZA4D1dRNipkc/fi1akXY9jY=;
	b=HZYW1/qmVmgByKRWFBJTkKMkIwBebA0CkI56exm57B8QcPMX1sVE07K8KqP7b+ctmywVC1
	5GUPprfANLw8S+pNZ81nRw1DvUldQUZRVWpRkaajYUZBBxgPAWu6wGWuWyVhiNWsIGUBJO
	EoLH8Ww3OPIOxRK9kYGypxlFizYAV8c=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v3] ovl: support layers on case-folding capable
 filesystems
Message-ID: <v3sqyceuxalkzmu5yweciry54qjfwif3lloefpsapomz6afpv6@metypepdf3dt>
References: <20250602171702.1941891-1-amir73il@gmail.com>
 <oxmvu3v6a3r4ca26b4dhsx45vuulltbke742zna3rrinxc7qxb@kinu65dlrv3f>
 <CAOQ4uxicRiha+EV+Fv9iAbWqBJzqarZhCa3OjuTr93NpT+wW-Q@mail.gmail.com>
 <CAOQ4uxiNjZKonPKh7Zbz89TmSE67BVHmAtLMZGz=CazNAYRmGQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxiNjZKonPKh7Zbz89TmSE67BVHmAtLMZGz=CazNAYRmGQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Sun, Jun 22, 2025 at 09:20:24AM +0200, Amir Goldstein wrote:
> On Mon, Jun 16, 2025 at 10:06 AM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Sun, Jun 15, 2025 at 9:20 PM Kent Overstreet
> > <kent.overstreet@linux.dev> wrote:
> > >
> > > On Mon, Jun 02, 2025 at 07:17:02PM +0200, Amir Goldstein wrote:
> > > > Case folding is often applied to subtrees and not on an entire
> > > > filesystem.
> > > >
> > > > Disallowing layers from filesystems that support case folding is over
> > > > limiting.
> > > >
> > > > Replace the rule that case-folding capable are not allowed as layers
> > > > with a rule that case folded directories are not allowed in a merged
> > > > directory stack.
> > > >
> > > > Should case folding be enabled on an underlying directory while
> > > > overlayfs is mounted the outcome is generally undefined.
> > > >
> > > > Specifically in ovl_lookup(), we check the base underlying directory
> > > > and fail with -ESTALE and write a warning to kmsg if an underlying
> > > > directory case folding is enabled.
> > > >
> > > > Suggested-by: Kent Overstreet <kent.overstreet@linux.dev>
> > > > Link: https://lore.kernel.org/linux-fsdevel/20250520051600.1903319-1-kent.overstreet@linux.dev/
> > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > ---
> > > >
> > > > Miklos,
> > > >
> > > > This is my solution to Kent's request to allow overlayfs mount on
> > > > bcachefs subtrees that do not have casefolding enabled, while other
> > > > subtrees do have casefolding enabled.
> > > >
> > > > I have written a test to cover the change of behavior [1].
> > > > This test does not run on old kernel's where the mount always fails
> > > > with casefold capable layers.
> > > >
> > > > Let me know what you think.
> > > >
> > > > Kent,
> > > >
> > > > I have tested this on ext4.
> > > > Please test on bcachefs.
> > >
> > > Where are we at with getting this in? I've got users who keep asking, so
> > > hoping we can get it backported to 6.15
> >
> > I'm planning to queue this for 6.17, but hoping to get an ACK from Miklos first.
> >
> 
> Hi Christian,
> 
> I would like to let this change soak in next for 6.17.
> I can push to overlayfs-next, but since you have some changes on vfs.file,
> I wanted to consult with you first.
> 
> The changes are independent so they could go through different trees,
> but I don't like that so much, so I propose a few options.
> 
> 1. make vfs.file a stable branch, so I can base overlayfs-next on it
> 2. rename to vfs.backing_file and make stable
> 3. take this single ovl patch via your tree, as I don't currently have
>     any other ovl patches queued to 6.17

I've got more users hitting the casefolding + overlayfs issue.

If we made the new behaviour bcachefs only, would that make it work for
you to get it into 6.16 + 6.15 backport?

Otherwise I'm going to have to get my own workaround out...

