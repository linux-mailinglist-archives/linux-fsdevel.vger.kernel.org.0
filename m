Return-Path: <linux-fsdevel+bounces-9244-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45ED983F5EC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jan 2024 15:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7823D1C2266C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jan 2024 14:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A409E219E5;
	Sun, 28 Jan 2024 14:42:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C6A23746;
	Sun, 28 Jan 2024 14:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706452943; cv=none; b=QrhnPZjkYTRfDMsGix+ig0t06UJeYMnS7GZLFF6Y10V1duMgd1g7rnjAZL67DsRr9L4LueX0RSZlKaD/j9knAeoqijeNZCzUHESm87x8yw4AutIlmOHTAv3UzREnSiV27eEBTHWAvW1vz4eFsVG8n6fLVshlTZLKsZr9SDlD+AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706452943; c=relaxed/simple;
	bh=FBRxdLBuITlKzDaTXnO/ff75eo4i2DldFirQAXk8jy8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W3PNpsSS6IHteAxuGeNrAO2hmgPcdgrBxFd2N4+hOEjbozK5kF/5kphGqcM56xRmep8Ck9jv/AZUNzK/2VrcpFklEocwhUB9My+KWvIousMZjKiDQApqa1cEOt2YNxMFdEhS3tzBlvRBLFRx96NutFhQcuyZefeKcFz5zC1vToQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24FEAC433C7;
	Sun, 28 Jan 2024 14:42:21 +0000 (UTC)
Date: Sun, 28 Jan 2024 09:42:19 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Devel
 <linux-trace-devel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Christian Brauner <brauner@kernel.org>, Ajay Kaher
 <ajay.kaher@broadcom.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] eventfs: Have inodes have unique inode numbers
Message-ID: <20240128094219.01e1ef1b@rorschach.local.home>
In-Reply-To: <20240127094717.63c09edb@rorschach.local.home>
References: <20240126150209.367ff402@gandalf.local.home>
	<CAHk-=wgZEHwFRgp2Q8_-OtpCtobbuFPBmPTZ68qN3MitU-ub=Q@mail.gmail.com>
	<20240126162626.31d90da9@gandalf.local.home>
	<CAHk-=wj8WygQNgoHerp-aKyCwFxHeyKMguQszVKyJfi-=Yfadw@mail.gmail.com>
	<CAHk-=whNfNti-mn6vhL-v-WZnn0i7ZAbwSf_wNULJeyanhPOgg@mail.gmail.com>
	<0C9AF227-60F1-4D9B-9099-1A86502359BA@goodmis.org>
	<CAHk-=whDnGUm1zAhq7Oa+5BjzjChxObWdy4J4n2TAmMWb_RWtw@mail.gmail.com>
	<20240127094717.63c09edb@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 27 Jan 2024 09:47:17 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> Now some of this was needed due to the way the dir wrapper worked so I
> may be able to revisit this and possibly just use an ei->ref counter.
> But I wasted enough time on this and I'm way behind in my other
> responsibilities, so this is not something I can work on now.

Ironically, one of the responsibilities that I've been putting off to
fix up eventfs was writing that document on a support group for
maintainer burnout. :-p

-- Steve

