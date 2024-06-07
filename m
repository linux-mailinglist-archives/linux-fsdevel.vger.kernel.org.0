Return-Path: <linux-fsdevel+bounces-21266-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 788B1900A11
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 18:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 291761F29527
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 16:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C12199E90;
	Fri,  7 Jun 2024 16:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="F9IDInIq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B130F154444
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jun 2024 16:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717776648; cv=none; b=WR6FXFKxjcrBAWpQp5RaQteXU+KZhFFXJeAcTVhkFLF7HnHSf8e+Po5xQWAKd2jkRoGEJDugqOFqHNnSo+teeLPUl5FNMKdK3fcIRC+6+x3eGeX+vLj/oDsgQD6rLTe17P4ICtpMo6Bc4Mml6dy8WPQ67BQrdp/K2IcNo4e+ULg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717776648; c=relaxed/simple;
	bh=ENyK17JAlKP6Vh3s5ogkZGade3dpZzHpFOAyvJiCZcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WGOxovsjShErF6vDOvoxt9Mp+vhwFWX20J7AAhtxqMcWypaI7/6sGirjLfH+JSJc5PJm4J+k+84gfghKxOxQp0jFGUNyp8qYDxtOqPlWebw46ArUVxb9v3SGy8esn96sJP5LYyu6T15KvFA08e6xlrcTIcwtmE5sHNIjll5Uh2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=F9IDInIq; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mDZEDH2wUNyPM/7Me1/gSh1O60mkgFmTbxt/HUjDhG0=; b=F9IDInIqVJNvfzz+KDXcrL2MnK
	FYlQdD4o+xP2apJAcm9T8KjElaPUFfYVUIo/a0QvLNulx+XPNipJ0CYgfz90PGAaVJhFwmLH0wZb0
	leLsGFKuA4Vlw31lJyo0H0b5m8TOZOdQARi8kWmhZn3pjKVcdWMXyKel8YDAFYwIqyYonHgPcQNQh
	2aiY/KPKJcDwk9mDbCMxJbFhJEyie7sNE7ur5RhBAU7ESIT+knmoCNgMB7YlNs61J21p9rxooCGr6
	XDjO+T8W7WaJ0cqO5icE5nDjPYudp/HoqMeOxOmFzV+25rBqqTMto3FE8JQB6xy0CeY9QuEtqwmbL
	lzno3AOg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1sFcAt-00DANq-0j;
	Fri, 07 Jun 2024 16:10:43 +0000
Date: Fri, 7 Jun 2024 17:10:43 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: [PATCH 11/19] switch simple users of fdget() to CLASS(fd, ...)
Message-ID: <20240607161043.GZ1629371@ZenIV>
References: <20240607015656.GX1629371@ZenIV>
 <20240607015957.2372428-1-viro@zeniv.linux.org.uk>
 <20240607015957.2372428-11-viro@zeniv.linux.org.uk>
 <20240607-gelacht-enkel-06a7c9b31d4e@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607-gelacht-enkel-06a7c9b31d4e@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Jun 07, 2024 at 05:26:53PM +0200, Christian Brauner wrote:
> On Fri, Jun 07, 2024 at 02:59:49AM +0100, Al Viro wrote:
> > low-hanging fruit; that's another likely source of conflicts
> > over the cycle and it might make a lot of sense to split;
> > fortunately, it can be split pretty much on per-function
> > basis - chunks are independent from each other.
> > 
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > ---
> 
> I can pick conversions from you for files where I already have changes
> in the tree anyway or already have done conversion as part of other
> patches.

Some notes:

	This kind of conversions depends upon fdput(empty) being not just
a no-op, but a no-op visible to compiler.  Representation change arranges
for that.

	CLASS(...) has some misfeatures or nearly C++ level of tastelessness;
for this series I decided to try it and see how it goes, but... AFAICS in
a lot of cases it's the wrong answer.

	1.  Variable declarations belong in the beginning of block.
CLASS use invites violating that; to make things worse, in-block goto
bypassing such declaration is only caught by current clang.  Two
examples got caught by Intel buildbot in this patch, actually - one
in fs/select.c, another in ocfs2.

	2. The loss of control over the location of destructor call can
be dangerous in some cases.  Delaying it is not a problem for struct
file references (well, except for goto problems above), but there's
an opposite issue.  Example from later in this series:
	if (arg != -1) {
		struct perf_event *output_event;
		struct fd output;
		ret = perf_fget_light(arg, &output);
		if (ret)
			return ret;
		output_event = output.file->private_data;
		ret = perf_event_set_output(event, output_event);
		fdput(output);
	} else {
		ret = perf_event_set_output(event, NULL);
	}
gets converted to
	if (arg != -1) {
		struct perf_event *output_event;
		CLASS(fd, output)(arg);
		if (!is_perf_file(output))
			return -EBADF;
		output_event = fd_file(output)->private_data;
		return perf_event_set_output(event, output_event);
	} else {
		return perf_event_set_output(event, NULL);
	}

Nice, but that invites the next step, doesn't it?  Like this:

	struct perf_event *output_event = NULL;
	if (arg != -1) {
		CLASS(fd, output)(arg);
		if (!is_perf_file(output))
			return -EBADF;
		output_event = fd_file(output)->private_data;
	}
	return perf_event_set_output(event, output_event);

See the trouble here?  The last variant would be broken - the value of
file->private_data escapes the scope and can end up used after
the file gets closed.

In the original variant it's easy to see - we have an explicit
fdput() marking the place where protection disappears.  After
the conversion to implicit cleanups we lose that.

Yes, use of __cleanup can nicely shrink the source and make
some leaks less likely.  But my impression from this experiment
is that we should be very cautious with using that technics ;-/

