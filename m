Return-Path: <linux-fsdevel+bounces-59331-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0ABB3751D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 00:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8C2A7C3013
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 22:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF4E2D6E5C;
	Tue, 26 Aug 2025 22:53:55 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from swift.blarg.de (swift.blarg.de [138.201.185.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0028630CDB4;
	Tue, 26 Aug 2025 22:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.201.185.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756248834; cv=none; b=IBe9HGxeAgT8G8+pyIeY15QX3KIjYj2olQvTaMHoaGoms6vyUUtI7+06pwphZiBaFG6NTXcwklzjXBMcFHsR+ZpjloiwlWb+u9mJbtxjux0rI2FNaaTQ9uofuhvjUb0C7K3qAaSBr7f189xZGvlbBQRmtsqk6acprNUqB9DYELQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756248834; c=relaxed/simple;
	bh=WJ8xk8Hzpo1e/n1NboDi3ScR24dGBtVGs2sLNxkIkRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cFVUc+M5lBvBmhs5wUGIg1pmks1dNBLdLcXUkvZxAC8jdCxw335n8oU+8g9lmE2jU1YgoSfh8gk6c2Swfc4G8QBzEkYqm0MiVt1tFXD/TmY9lMS0ryG0qYDvkYpwSMZzzvMvlBgM8rXKc0UGIvqcIsgrEhxrrEGjwqdQ9kqyx04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blarg.de; spf=pass smtp.mailfrom=blarg.de; arc=none smtp.client-ip=138.201.185.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blarg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blarg.de
Received: from swift.blarg.de (swift.blarg.de [IPv6:2a01:4f8:c17:52a8::2])
	(Authenticated sender: max)
	by swift.blarg.de (Postfix) with ESMTPSA id 83A3440230;
	Wed, 27 Aug 2025 00:53:50 +0200 (CEST)
Date: Wed, 27 Aug 2025 00:53:49 +0200
From: Max Kellermann <max@blarg.de>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "brauner@kernel.org" <brauner@kernel.org>,
	Patrick Donnelly <pdonnell@redhat.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"slava@dubeyko.com" <slava@dubeyko.com>,
	David Howells <dhowells@redhat.com>,
	Alex Markuze <amarkuze@redhat.com>,
	"willy@infradead.org" <willy@infradead.org>,
	"idryomov@gmail.com" <idryomov@gmail.com>
Subject: Re: [RFC PATCH 3/4] ceph: introduce ceph_submit_write() method
Message-ID: <aK46_c261i65FZ2f@swift.blarg.de>
Mail-Followup-To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	"brauner@kernel.org" <brauner@kernel.org>,
	Patrick Donnelly <pdonnell@redhat.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"slava@dubeyko.com" <slava@dubeyko.com>,
	David Howells <dhowells@redhat.com>,
	Alex Markuze <amarkuze@redhat.com>,
	"willy@infradead.org" <willy@infradead.org>,
	"idryomov@gmail.com" <idryomov@gmail.com>
References: <20250205000249.123054-1-slava@dubeyko.com>
 <20250205000249.123054-4-slava@dubeyko.com>
 <Z6-xg-p_mi3I1aMq@casper.infradead.org>
 <aK4v548CId5GIKG1@swift.blarg.de>
 <c2b5eafc60e753cba2f7ffe88941f10d65cefa64.camel@ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2b5eafc60e753cba2f7ffe88941f10d65cefa64.camel@ibm.com>

On 2025/08/27 00:33, Viacheslav Dubeyko <Slava.Dubeyko@ibm.com> wrote:
> Of course, we can revert any patch. This patchset has been sent not with the
> goal of pure refactoring but it fixes several bugs. Reverting means returning
> these bugs back.

You should have listened of Matthew and submit separate minimal
bug-fixing patches instead of posting huge patches which move code
around, change semantics and hidden somewhere deep within fix some bug
(and then introduce new bugs).

> This patchset was available for review for a long time.

There was exactly one review, and no, you were not "happy to rework
and to make any patch more better" - you openly rejected Matthew's
review.

> From my point of view, reverting is not answer and it makes sense to
> continue fix bugs and to make CephFS code more stable.

Your argument only appears to sound right, but it is detached from the
reality I'm living in.

Your patches made Ceph less stable.  6.14 had one Ceph-related crash
every other week, but 6.15 with your patches made all servers crash
within hours.

The point is: the Linux kernel was better without your patches.  Your
patches may have fixed a bug, but have introduced a dozen new bugs,
including one that very quickly crashes the whole kernel, one that was
really obvious enough, just nobody cared enough to read deeply enough
after you rejected Matthew's review.  Too bad no maintainer stopped
you!

Of course, the bug that was fixed by your patch set should be fixed -
but not the way you did it.  Every aspect of your approach to fixing
the bug was bad.

The best way forward for you would be to revert this patch set and
write a minimal patch that only fixes the bug.  If you want to be
helpful here, please give this a try.

Max

