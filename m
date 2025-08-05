Return-Path: <linux-fsdevel+bounces-56770-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44985B1B6D0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 16:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F326177A71
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 14:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9658727933A;
	Tue,  5 Aug 2025 14:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="gpbfF/nK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601182797A9
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Aug 2025 14:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754405058; cv=none; b=FsTVb9MI5VUYG8BKFTwKUkloKHRiT0nI45ivxX4M3shOpq9F+YdBSg8XQPIxS52yOUxxsnPuvI4HZOj5iM+tIjQv+VT4k31h+F/PMEWHYSaSbq8P/YuH+1dLC9oUCCFmFhwWUABC1NoBS5T4X1WBi+0H/kmoTAXoAK0RKhJSsAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754405058; c=relaxed/simple;
	bh=56zAqxQb+EXsLQfWV+Nv5mXSvAnpP+GR7TUF2q+RONE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=q9mlTQBaX4ZCc458Wegph0cyKjSDihigdKKivGUUGrMjZrshzNmaJ6zwKZOfZLOiF2wzFSs4Wj6TWmQglRo7WYE6Q7D7kYVKx6PKspVxhJxnLPZAhKf241Lso7VubkIyw4GM/N+X/bpOWmqquVxXupnBCmAb5FUw+eGa7owWKPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=gpbfF/nK; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-114-137.bstnma.fios.verizon.net [173.48.114.137])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 575EhwY6023281
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 5 Aug 2025 10:43:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1754405040; bh=TB3k5YKrolHS/wGUjD2XWMujqEOA7pI1XujVrZoQ09I=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=gpbfF/nK3AA4Y1mnGA0hs/TfMSdbkijSUdIs273Q6zm9/psDK+utT8OHPH+gl46KP
	 436vfh7zQOAzczzy5UfO8xFYFWy12q7HCXbWf5ZBOx8k+bDBlJXmb+yBV1k39yiWCS
	 x7exXNqYDYucIGA3Ks6QpKCBjrqerdRty2vSCJ31kMpML94GdTisBXAxsvG5FkoWAP
	 RIwfJ4syMf5yurVaLy8MKiNQQPQpF61rB/roGZvQYChjci/tSHFcqGTeCcIqvxP/mL
	 2ibjIT2kfSg/BMwgBCzZepQB9YA88kj0iIQhbXEvpZuOh/leO+dGsa5vxt9rQWo/7w
	 J74RKGlyqQoNg==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id DEFF72E00D6; Tue, 05 Aug 2025 10:43:57 -0400 (EDT)
Date: Tue, 5 Aug 2025 10:43:57 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Linux Kernel Developers List <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, netdev@vger.kernel.org, ksummit@lists.linux.dev
Subject: Maintainers Summit 2025 Call for Topics
Message-ID: <20250805144357.GA762104@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This year, the Maintainers Summit will be held in Tokyo, Japan on
Wednesday, December 10th, 2025, just before the Linux Plumber's Conference
(December 11 -- 13th).

As in previous years, the Maintainers Summit is invite-only, where the
primary focus will be process issues around Linux Kernel Development.
It will be limited to 30 invitees and a handful of sponsored
attendees.

Linus has generated a list of people for the program committee to
consider.  People who suggest topics that should be discussed at the
Maintainers Summit will also be added to the list for consideration.
To make topic suggestions for the Maintainers Summit, please send
e-mail to ksummit@lists.linux.dev with a subject prefix of
[MAINTAINERS SUMMIT].  Late submissions will be considered, but people
submit submissions before September 10th will be considered for
receiving an invite.  Invitations may be issued after that date, but
only on a space-availale basis.

For an examples of past Maintainers Summit topics, please see the
these LWN articles:

 * 2025 https://lwn.net/Articles/990740/
 * 2024 https://lwn.net/Articles/951847/
 * 2022 https://lwn.net/Articles/908320/


Related to the Maintainer's Summit, the Kernel Summit is organized as
a track which is run in parallel with the other tracks at the Linux
Plumbers Conference (LPC), and is open to all registered attendees of
LPC.  The goal of the Kernel Summit track will be to provide a forum
to discuss specific technical issues that would be easier to resolve
in person than over e-mail.  The program committee will also consider
"information sharing" topics if they are clearly of interest to the
wider development community (i.e., advanced training in topics that
would be useful to kernel developers).

To suggest a topic for the Kernel Summit, please do two things. by
September 10th, 2025. First, please send e-mail with a subject prefix of
[TECH TOPIC] to ksummit@lists.linux.dev.  As before, please use a separate
e-mail for each topic.

Secondly, please create a topic at the Linux Plumbers Conference
proposal submission site and target it to the Kernel Summit track:

        https://lpc.events/event/19/abstracts

Please do both steps.  I'll try to notice if someone forgets one or
the other, but your chances of making sure your proposal gets the
necessary attention and consideration are maximized by submitting both
to the mailing list and the web site.

The program committee this year is composed of the following people:

Christian Brauner
Jon Corbet
Greg KH
Ted Ts'o
Rafael J. Wysocki


