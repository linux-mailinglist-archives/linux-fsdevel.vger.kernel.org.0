Return-Path: <linux-fsdevel+bounces-43908-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DCCA5FAFC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 17:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80D693B35C0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 16:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86AAC26A0E3;
	Thu, 13 Mar 2025 16:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FnuYAtXc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8C226980A;
	Thu, 13 Mar 2025 16:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741881737; cv=none; b=ar3bOgBYovCAC+kyoGsvbizhbIpSt/SIkgjxvFylqfFvukir8N8r6sEZXnP2nE3AP9/uSpW/tWljBerO8NSJM5NKOV0ynnNzCE9Q/FStTCzcRycXKS6gqCPKDZbxfCh6YRTlADue5V2VYy6ZqTxQm0P8ng29P4MaUS2YlMzjm+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741881737; c=relaxed/simple;
	bh=SIwoOnJbCCZD6NLPzZTs8MK5F2JNGdpdSvWQ8Oqdt7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=euEWiLsjkNedMAshNKM5/B7obtDwnOaBDIUo7+fzF6qrhseVA3dl1K4CjPpF2iPs67W12hkaXwPt1HzS8AvUYmruyEnGufIohjWBerXx22gclLpd31Ipt4j1/Lqt9yNRrv6sewR1U+Zg3sNFRF5G0wlUag1TDVaZ8nMwkSnhS0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FnuYAtXc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF852C4CEDD;
	Thu, 13 Mar 2025 16:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741881737;
	bh=SIwoOnJbCCZD6NLPzZTs8MK5F2JNGdpdSvWQ8Oqdt7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FnuYAtXcv4mrX7gH+rVqZueFOZwmu7zNbeuLL+rzBt0Ym3wTPGutW76g/dTeEgnts
	 fl/Qx3h2ds9r996R1cLAefj3GAlxTP8ObHpJxxmL2YeBqSXmwSozI+/9S0svALjbrN
	 YoE+G3mnMJu5tQJYyGSBKyudVzTovgoTyJrtCeJNAvj4cxPZNpd4MZMECI00n8ByBA
	 my7S6e5iM+Q51hFo1k7l3+tYy7WOAjlIS9eJE0jvqUeq5UDbprCuVrKkE6MPR1QoOU
	 R+YEeQUj3rfxGdu+xvmdmhGJGW2TBh4PqhzMOc6GAxkY7QOnEfWryU4lDuI54OtsGQ
	 FAPHAi2E4wa9A==
Date: Thu, 13 Mar 2025 17:02:12 +0100
From: Joel Granados <joel.granados@kernel.org>
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Kees Cook <kees@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, sparclinux@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 6/6] s390: mv s390 sysctls into their own file under
 arch/s390 dir
Message-ID: <t3q6lsy4tjlp5ngapyguwdzu5arorznl3bgjr3iki3rudetuw5@waddjgfn7vvu>
References: <20250306-jag-mv_ctltables-v2-0-71b243c8d3f8@kernel.org>
 <20250306-jag-mv_ctltables-v2-6-71b243c8d3f8@kernel.org>
 <20250307152620.9880F75-hca@linux.ibm.com>
 <r73ph4ht5ejeeuj65nxocmqp7pury2mekz2lz3r6fs264s24c4@ransymcrzk2h>
 <your-ad-here.call-01741690967-ext-1293@work.hours>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <your-ad-here.call-01741690967-ext-1293@work.hours>

On Tue, Mar 11, 2025 at 12:02:47PM +0100, Vasily Gorbik wrote:
> On Mon, Mar 10, 2025 at 02:41:59PM +0100, Joel Granados wrote:
> > On Fri, Mar 07, 2025 at 04:26:20PM +0100, Heiko Carstens wrote:
> > > On Thu, Mar 06, 2025 at 12:29:46PM +0100, joel granados wrote:
> > > > Move s390 sysctls (spin_retry and userprocess_debug) into their own
> > > > files under arch/s390. We create two new sysctl tables
> > > > (2390_{fault,spin}_sysctl_table) which will be initialized with
> > > > arch_initcall placing them after their original place in proc_root_init.
> > > > 
> > > > This is part of a greater effort to move ctl tables into their
> > > > respective subsystems which will reduce the merge conflicts in
> > > > kernel/sysctl.c.
> > > > 
> > > > Signed-off-by: joel granados <joel.granados@kernel.org>
> > > > ---
> > > >  arch/s390/lib/spinlock.c | 18 ++++++++++++++++++
> > > >  arch/s390/mm/fault.c     | 17 +++++++++++++++++
> > > >  kernel/sysctl.c          | 18 ------------------
> > > >  3 files changed, 35 insertions(+), 18 deletions(-)
> > > 
> > > Acked-by: Heiko Carstens <hca@linux.ibm.com>
> > > 
> > > How should this go upstream? Will you take care of this, or should
> > > this go via the s390 tree?
> > 
> > thx for the review
> > 
> > It would be great if you can push it through the s390 tree. However, if
> > it is not possible to do so, please let me know and I'll add it to the
> > sysctl-next changes.
> 
> I've slightly changed the commit message
> s390: Move s390 sysctls into their own file under arch/s390
> 
> And applied, thank you!
ok. I'll remove it from my future versions.
Thx

-- 

Joel Granados

