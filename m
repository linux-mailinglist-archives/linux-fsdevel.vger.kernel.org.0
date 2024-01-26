Return-Path: <linux-fsdevel+bounces-9030-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 679EE83D252
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 03:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B73B1C26373
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 02:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782A479C1;
	Fri, 26 Jan 2024 01:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sehDSZlX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9EB138C
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 01:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706234381; cv=none; b=Pq2kOJpMMMFnRbaWi3nm1JxAhSvnSCAl6diF6I3XmXprW+hDIzRIGWbo4/LECEa4+og8JnT78VCODSReSPx4wiWsrio+vWNVUqzBUVNGE78KVepl+I5u4Ay3o+JuyFjUdJENJzyqdkBf7lQvurTxcm58c0JsO+up8rMehuPtOOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706234381; c=relaxed/simple;
	bh=5VkjRFfYbTajdShDeexEPTVYVhyJz43XkJa9SFwv53w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yyw+C0TktPSq1QBsF0NhZ62NaQHmred1uJi9Zf+QfCCkoqZmD6s12xVhrLacl0ODm/p6y7jARXWXakbn6/+VISisDwP0VzQDTvl/UhbZ7jmryS1H6zzlA9RTAPakfDgEjP+0luom8VtNXi4HpI14a49Mep2dHSY0Seu9JCv9ATk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sehDSZlX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31E78C433F1;
	Fri, 26 Jan 2024 01:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706234381;
	bh=5VkjRFfYbTajdShDeexEPTVYVhyJz43XkJa9SFwv53w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sehDSZlXcjFPhDFMyOF4KCX9g50DznT1MmN6bW3H7a2qq2RoYAX+MUlE3Oyw9ICS8
	 HAyzWu4iX6vDZcv5mqpdtiCcd9r5E1/BQw2KNjHYPFHQoJS2S0Q+S5kCZscaH1jNh/
	 iZPJ5/2Z46hC9LJQjZRJCJSGoN5Aphpg+bg5Su6g=
Date: Thu, 25 Jan 2024 17:59:40 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [LSF/MM TOPIC] Making pseudo file systems inodes/dentries more
 like normal file systems
Message-ID: <2024012528-caviar-gumming-a14b@gregkh>
References: <20240125104822.04a5ad44@gandalf.local.home>
 <2024012522-shorten-deviator-9f45@gregkh>
 <20240125205055.2752ac1c@rorschach.local.home>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125205055.2752ac1c@rorschach.local.home>

On Thu, Jan 25, 2024 at 08:50:55PM -0500, Steven Rostedt wrote:
> On Thu, 25 Jan 2024 17:24:03 -0800
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> > On Thu, Jan 25, 2024 at 10:48:22AM -0500, Steven Rostedt wrote:
> > > Now that I have finished the eventfs file system, I would like to present a
> > > proposal to make a more generic interface that the rest of tracefs and even
> > > debugfs could use that wouldn't rely on dentry as the main handle.  
> > 
> > You mean like kernfs does for you today?  :)
> > 
> 
> I tried to use kernfs when doing a lot of this and I had issues. I
> don't remember what those were, but I can revisit it.

You might, as kernfs makes it so that the filesystem structures are
created on demand, when accessed, and then removed when memory pressure
happens.  That's what sysfs and configfs and cgroups use quite
successfully.

thanks,

greg k-h

