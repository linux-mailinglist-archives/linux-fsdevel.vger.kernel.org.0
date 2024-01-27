Return-Path: <linux-fsdevel+bounces-9207-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7488C83EDB6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 15:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F04E283E17
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 14:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BC828E23;
	Sat, 27 Jan 2024 14:54:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22D028E02
	for <linux-fsdevel@vger.kernel.org>; Sat, 27 Jan 2024 14:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706367255; cv=none; b=lrOBeuOXzkahNSerdKpYxWjoyqquRwmEN/zmi+7jNufogRfXCBItzWiMNoJuZQBSOaxeN4LRkiUxi0JH5P+FFf5lLQVZ/dL5GTb4EWTKvLYNkrm+wfSb9p5bFk91k121lRYxqJ50d4X53hvNRewhcI+ZEPJXDNgIShFQxotS1Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706367255; c=relaxed/simple;
	bh=LQ1sGySf8PM4/fBTco9r88JsK6i5eRBbup78E/jD4q0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WLF9E2Ba+jFm8WkkHq0ijnkfY1/RefSvyZdo44W0vbJa0cxMSR6ZnQvTHn/CurA5efq7yGHe2+XQjFJhIOrfiww0c0dWraIvgOCZpMHcY3A1NO3hjXUDy37Wn2U89qQ43caZ11RnmV3R3Xvo7j+1rBVI+lRHde0twAEnxTPthJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F863C433F1;
	Sat, 27 Jan 2024 14:54:14 +0000 (UTC)
Date: Sat, 27 Jan 2024 09:54:12 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, Christian Brauner <brauner@kernel.org>, Al Viro
 <viro@zeniv.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [LSF/MM TOPIC] Making pseudo file systems inodes/dentries more
 like normal file systems
Message-ID: <20240127095412.46b6e3dc@rorschach.local.home>
In-Reply-To: <CAOQ4uxjRxp4eGJtuvV90J4CWdEftusiQDPb5rFoBC-Ri7Nr8BA@mail.gmail.com>
References: <20240125104822.04a5ad44@gandalf.local.home>
	<2024012522-shorten-deviator-9f45@gregkh>
	<20240125205055.2752ac1c@rorschach.local.home>
	<2024012528-caviar-gumming-a14b@gregkh>
	<20240125214007.67d45fcf@rorschach.local.home>
	<2024012634-rotten-conjoined-0a98@gregkh>
	<20240126101553.7c22b054@gandalf.local.home>
	<2024012600-dose-happiest-f57d@gregkh>
	<20240126114451.17be7e15@gandalf.local.home>
	<CAOQ4uxjRxp4eGJtuvV90J4CWdEftusiQDPb5rFoBC-Ri7Nr8BA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 27 Jan 2024 12:15:00 +0200
Amir Goldstein <amir73il@gmail.com> wrote:
> >  
> 
> I would like to attend the talk about what happened since we suggested
> that you use kernfs in LSFMM 2022 and what has happened since.

It was the lack of documentation to understand the concept it was
using. As I was very familiar with the way debugfs worked, I couldn't
map that same logic to how kernfs worked for what I wanted to do. I
remember spending a lot of time on it but just kept getting lost. I then
went to see if just modifying the current method with tracefs that was
like debugfs and things made a lot more sense. I guess the biggest
failure in that was my thinking that using the dentry as the main
handle was the proper way to do things, as supposed to being the exact
opposite. If I had known that from the beginning, I probably would have
approached it much differently.

> I am being serious, I am not being sarcastic and I am not claiming that
> you did anything wrong :)

Thanks ;-)

> 
> Also ,please do not forget to also fill out the Google form:
> 
>           https://forms.gle/TGCgBDH1x5pXiWFo7

Crap, I keep forgetting about that form.

> 
> So we have your attendance request with suggested topics in our spreadsheet.

Appreciate it.

-- Steve


