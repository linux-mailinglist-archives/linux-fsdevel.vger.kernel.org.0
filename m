Return-Path: <linux-fsdevel+bounces-59339-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B25BDB3795B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 06:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8322B3663A1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 04:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C8B2D3725;
	Wed, 27 Aug 2025 04:57:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from swift.blarg.de (swift.blarg.de [138.201.185.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FF626E706;
	Wed, 27 Aug 2025 04:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.201.185.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756270636; cv=none; b=TVal42kvMI94PNXha25HE0rYul/xdS2MO3rWfwsL4E+rozmTheXdGeQpePviZNU/gsGGJOPheKF8IqxPcWGhUb4zoAdacs/shK3mJXykA3BqI6bpl3fYI0d4CLtNERImwhwDzYS/Mx6Xfqsdvg3WN45ke9aXIl8UeOG7bA9aKec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756270636; c=relaxed/simple;
	bh=IyVahI6QrFyvU7FHkeFmFHYidFzPlEK+OjrUBfoDlac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pZSsVnuej+9SP9CNLWGonDAcHy84EPGgdnRC44XBr8ORIpEsRHue3/rxk40LolhSQ9zxe5n8ScbgAN2/yubw2a0ngNQg0yJ9qfh5nIOEOtlAs9mnl83zIxyP31GQrAjJfRGLZd8RBXOiUR1fhSl/5WXBT4QJyi7cBIJvoNKR9AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blarg.de; spf=pass smtp.mailfrom=blarg.de; arc=none smtp.client-ip=138.201.185.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blarg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blarg.de
Received: from swift.blarg.de (swift.blarg.de [IPv6:2a01:4f8:c17:52a8::2])
	(Authenticated sender: max)
	by swift.blarg.de (Postfix) with ESMTPSA id F0ED440230;
	Wed, 27 Aug 2025 06:57:11 +0200 (CEST)
Date: Wed, 27 Aug 2025 06:57:10 +0200
From: Max Kellermann <max@blarg.de>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: David Howells <dhowells@redhat.com>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"slava@dubeyko.com" <slava@dubeyko.com>,
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Alex Markuze <amarkuze@redhat.com>,
	Patrick Donnelly <pdonnell@redhat.com>,
	"willy@infradead.org" <willy@infradead.org>,
	"idryomov@gmail.com" <idryomov@gmail.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH 3/4] ceph: introduce ceph_submit_write() method
Message-ID: <aK6QJp3rx_yUzRo5@swift.blarg.de>
Mail-Followup-To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	David Howells <dhowells@redhat.com>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"slava@dubeyko.com" <slava@dubeyko.com>,
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Alex Markuze <amarkuze@redhat.com>,
	Patrick Donnelly <pdonnell@redhat.com>,
	"willy@infradead.org" <willy@infradead.org>,
	"idryomov@gmail.com" <idryomov@gmail.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <20250205000249.123054-1-slava@dubeyko.com>
 <20250205000249.123054-4-slava@dubeyko.com>
 <Z6-xg-p_mi3I1aMq@casper.infradead.org>
 <aK4v548CId5GIKG1@swift.blarg.de>
 <c2b5eafc60e753cba2f7ffe88941f10d65cefa64.camel@ibm.com>
 <aK46_c261i65FZ2f@swift.blarg.de>
 <4a75d243b3002ae8608b6e2530452924d192524f.camel@ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a75d243b3002ae8608b6e2530452924d192524f.camel@ibm.com>

On 2025/08/27 05:06, Viacheslav Dubeyko <Slava.Dubeyko@ibm.com> wrote:
> The open-source is space for collaboration and respect of each other. It is not
> space for offensive or bullying behavior.

This is now your third reply to a comment on your patch set (one to
Matthew and two to me), and you are still sidestepping the valid
criticism.  This time, instead of talking how to fix it, you are
explaining how well you tested this, and then this meta-comment.

No, for the bug discussion, it does not matter how well you tested
this.  If it's buggy, it's buggy.  For me, as an amateur, the bug was
obvious enough to see in the source code, and after my long
explanation, it should be easy enough for everybody else to see, isn't
it?  And no, I don't owe you a test case.  I explained the exact
conditions that need to occur for the crash to happen, and I have to
trust that you are capable of easily injecting such an error, aren't
you?

This is not what I call "collaboration" neither "respect", to me it
rather seems like ignorance.  You were not collaborating with the
reviewer and you are not respecting the bug report.  You just divert
the discussion instead of talking about the actual problems.


And, note: in both of your replies to me, you removed me from the
recipient list.  Everybody else you kept, you only removed me.  I had
to look up your replies on lore.kernel.org.  (You did not do that with
your replies to Matthew and David.)

What kind of funny behavior is that?

Max

