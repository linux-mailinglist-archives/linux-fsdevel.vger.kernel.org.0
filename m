Return-Path: <linux-fsdevel+bounces-13415-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A5E86F81C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 02:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A52AD1F21209
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 01:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB56917C8;
	Mon,  4 Mar 2024 01:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZepK8EyH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755B31362
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Mar 2024 01:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709514534; cv=none; b=CMbQxx7KMcWRB/SGWgQOsvpupXBR1s7vRi/vdqqypOJWQqUdaHgXK9SN848rEfUErDlqa+9S5og5r9BBb3YaVshAXQxRrqv6iko0O8dATlJO7i8jkc4lXcU8ga9Whsgs4gt+lkk8vXmuHXPRBPNoF8SEL94ceJu+JWql7+W4X3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709514534; c=relaxed/simple;
	bh=BaIPMoi+JCx+cnjqKbk0VdqwLBg3iHJnr4v4BT02EJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q977HOnov5pn+Vtbuqo2fuxCsswbZ/VhxfTcKkTCf0RvTxpj+pIXL2wzhpsAkpt5w3/YfupqWvf4V5U1ux31R1hmCxWXas0yyO1A/c5YBis1up3v84mfH5Gwc4iH97P7Mx7j1wKDgOiYqUiZTsB9X684/AZNA+XohwTnlxmxCEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZepK8EyH; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 3 Mar 2024 20:08:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709514529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xtv9aQ5t06LlZiJbAcrYPbD1WX5Zy7UgyrMyZJRn+Dg=;
	b=ZepK8EyHokNvFzXeedPSN990wceCwBFV5nQZejWsn8Df1vYz+Fkb+ccgpjA7hqd5p1sDQc
	g9Ob+GRlpXD7iFBHzRcRyfjl6JQdg8HY/XFro50x+PTKASC9OQ10Hu0Jzn+4JN/5pyxtE0
	grlXk7Q0DTY5e/oxDLxp9Ecd5YPZZZM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: John Stoffel <john@stoffel.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [WIP] bcachefs fs usage update
Message-ID: <apot5wnom6wqdvjb6hfforcooxuqonmjl7z6morjyhdbgi6isq@5fcb3hld62xu>
References: <gajhq3iyluwmr44ee2fzacfpgpxmr2jurwqg6aeiab4lfila3p@b3l7bywr3yed>
 <26084.50716.415474.905903@quad.stoffel.home>
 <tis2cx7vpb2qyywdwq6a74o2ryjmnn7skhsrcarix7v4sz7vad@7sf7bh2unloo>
 <26085.7607.331602.673876@quad.stoffel.home>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26085.7607.331602.673876@quad.stoffel.home>
X-Migadu-Flow: FLOW_OUT

On Sun, Mar 03, 2024 at 08:02:47PM -0500, John Stoffel wrote:
> >>>>> "Kent" == Kent Overstreet <kent.overstreet@linux.dev> writes:
> 
> > On Sun, Mar 03, 2024 at 01:49:00PM -0500, John Stoffel wrote:
> >> Again, how does this help the end user?  What can they do to even
> >> change these values?  They're great for debugging and info on the
> >> filesystem, but for an end user that's just so much garbage and don't
> >> tell you what you need to know.
> 
> > This is a recurring theme for you; information that you don't
> > understand, you think we can just delete... while you also say that you
> > haven't even gotten off your ass and played around with it.
> 
> Fair complaint.  But I'm also coming at this NOT from a filesystem
> developer point of view, but from the Sysadmin view, which is
> different.  
> 
> > So: these tools aren't for the lazy, I'm not a believer in the Gnome
> > 3 philosophy of "get rid of anything that's not for the lowest
> > common denominator".
> 
> Ok, I can see that, but I never was arguing for simple info, I was
> also arguing for parseable information dumps, for futher tooling.  I'm
> happy to write my own tools to parse this output if need be to give
> _me_ what I find useful.  
> 
> But you edlided that part of my comments.  Fine.  
> 
> > Rather - these tools will be used by people interested in learning more
> > about what their computers are doing under the hood, and they will
> > definitely be used when there's something to debug; I am a big believer
> > in tools that educate the user about how the system works, and tools
> > that make debugging easier.
> 
> > 'df -h' already exists if that's the level of detail you want :)
> 
> Sure, but when it comes to bcachefs, and sub-volumes (I'm following
> the discussion of statx and how to make sub-volumes distinct from
> their parent volumes) will df -h from gnu's coreutils package know how
> to display the extra useful information, like compression ratios,
> dedupe, etc.  And how snapshots are related to each other in terms of
> disk space usage.  

Getting subvolumes plumbed all the way into df -h is not on my short
term radar. I _am_ looking at, possibly, standardizing some APIs for
walking subvolumes - so depending on how that goes, perhaps.

> This is not the same level of detail needed by a filesystem developer,
> and I _never_ said it was.  I'm looking for the inforation
> needed/wanted by a SysAdmin when an end user comes whining about
> needing more space.  And then being able to examine the system
> holistically to give them an answer.  Which usually means "delete
> something!"  *grin*

'bcachefs fs usage' needs to show _all_ disk accounting information
bcachefs has, because we need there to be one single tool that shows all
the information we have - that's this tool.

If we're collecting information, it needs to be available.

There will no doubt be switches and options for providing reduced forms,
but for now I'm mainly concerned with making sure all the information
that we have is there in a reasonably understandable way.

