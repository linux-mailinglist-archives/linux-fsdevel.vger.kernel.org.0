Return-Path: <linux-fsdevel+bounces-46513-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3882DA8A759
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 20:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DED71694DE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 18:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8812356BA;
	Tue, 15 Apr 2025 18:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AAm6SqV9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE49235348;
	Tue, 15 Apr 2025 18:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744743565; cv=none; b=SNJ1zk6sxPMf3RQiqn1wUOiKvKOeNYt8zg6qTmwDkWmdZT8UO3KnZ9Vnl9fzeWZe0+YmnHDHQFtUBIcNbWIr7+OL+z3SzCRjKCYa6OIaqB+NwfHkz5W6xtDh+4g5rPDoGWmnFNSyRZu0DF98DtSf1ZURqQThBtJojDpzDKR+CeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744743565; c=relaxed/simple;
	bh=q70ctjrGqLmxVUHKXN5p9/vzscrDP14u951WDIoOWbg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WhhobfJEibefFaQ0JTsYuK5380cDANeUzvLEvgyk5jsUlc1zCR/I/SKM/Y+dyjyLB6YZRodeW1bilg+tiivkZbtOaPQm3iYPXbyCP1VRGSdSPK5atfsGA4OMsiVnpvbcdEz/WfYVyRsWoGvXO5pQPaKZT/H/2CTssFADmCtG6BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AAm6SqV9; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-acae7e7587dso521883066b.2;
        Tue, 15 Apr 2025 11:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744743561; x=1745348361; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=hkp2i5c9bgqxiRKG/3h+HqHChQz8elSJkULnjDgaezo=;
        b=AAm6SqV9K46+AYF9omCKS9PgDmqtxglc1hVXx8UUxDbiFBaXbl3iDSQShCztoLcSI4
         M7J5n9hR1fJ/rPWCj/KvviUT/1PMbnCixa80scuMaZhM+GnE71Uk2RcVZr+Fvax0X6WN
         b2KSUIGqX7snDdwzAPrPBcheS7hIWSgLWXj+OMaWLgFhbiEgPIbMSti0VWwP6EsYbje3
         rbHP3jKKKHPQiInU7kBmQwL1XWlHjqnKvvg61vt+4WKZqVAl/6oNejx2UtE8tCzuK1bO
         zePBA42lwRO6KcLy7e2r0EcspYGdCGeO6SrAC4dRRsc7FJRKLqsZGWE9+jLLPIWNbJu1
         c9EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744743561; x=1745348361;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hkp2i5c9bgqxiRKG/3h+HqHChQz8elSJkULnjDgaezo=;
        b=Le1YOfLR59qAh7TOjKtSt71IKB3IDOJOA5g41RstcbuDUlwwuBFMS5sHfncP/xkS6M
         bH9mSP45NAERSQL0fLFCGHb085zdqJwXH8vCVqqjSf6Xk4HO/Q+oTopdCju7IYOhMNQn
         g7SuhGIWjtwC3Glf0DRFeq9Q5TrQD5nnCEQfhRASzqDRBhze4ANnjkgr9REeSH6/aqlq
         7jNpY+hHD963OX4bzln9Joe7hXPmlikIbHtIdYrPvTX89qhTi+xIgnJcAhnGnQVK86Nx
         gv2AAU1LmBDJr7uQUqxstADJNZcKGfx4CecpMGFtd5h1XkGvbWzvngJ2FO7uVR0U5m96
         tdag==
X-Forwarded-Encrypted: i=1; AJvYcCU3tZxmtVDSld8moPSEhC57PN1vval355yqATP1xOwVPva6HXZL7/RGErw+meIdD3V+vKskuuA=@vger.kernel.org, AJvYcCWpx9lyvaMH2zIB/M159z/8uTY2yTAmc7SkJboSOaa4Xcv9GRMzmJo9JzTQw6RnnTgoo75uGgiKPTenIsAG@vger.kernel.org, AJvYcCX1/GJT5FsbI4UuKzuw9yAiG/OHsY755LOXwVntNr6CD7x2bMZl6LHd1RjPab35821eTrPhgV/IoNJxVw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxBX5CbkMewnX7Tgu+dS3ANpZEJf5qp/6lgERygck3g/oen7Rp3
	JQhR5nE0jp7rhu//cyDqngXO5t9zj7aWO9KkAoCPWjg5ktEaYeRD
X-Gm-Gg: ASbGncuUd2pX5did0/eV/Uv50qaqKgjf3Zc94lcColtw71CyGudTPcxbxIsHgjiNpxM
	EEdmllkq5echuQQXvE0J96mkhaSNMVPFAAi3/XuZsvKc9tT6IPVsf++NpZelNBfKoqg0JvjzNp3
	CyQxroxOYwLxlANwZYWRREuYbEtCaxisOktLN0hoxfJLqxOZlIiRzGl3AxpshwH549roNl+tSbF
	Naq2nGHRCsxzO6h+iYyWK63UW/p1NAE4k5PYGY+5yYtKxV9krgTfn/S0Lar5v41H59JhukC4jrp
	7JfJomn7Gxs3qkAXYASgdCMWnXGY1Lr4dC/BK/BsNoAc/037Jn+7y1veB9czSPPkJv04O51oIQ=
	=
X-Google-Smtp-Source: AGHT+IGTCiRplDt7X2b9oOiIqzPnVtzAVrCP2VkK30vBE7aX2MZ8ZaJbKZHqziYeL/Ig1EMQ0/BoBQ==
X-Received: by 2002:a17:907:720a:b0:abf:6cc9:7ef5 with SMTP id a640c23a62f3a-acb3850f00dmr12406966b.47.1744743560630;
        Tue, 15 Apr 2025 11:59:20 -0700 (PDT)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb20c03de9sm177102666b.71.2025.04.15.11.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 11:59:19 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 25073BE2DE0; Tue, 15 Apr 2025 20:59:19 +0200 (CEST)
Date: Tue, 15 Apr 2025 20:59:19 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: David Howells <dhowells@redhat.com>,
	Christoph Hellwig <hch@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Hillf Danton <hdanton@sina.com>,
	Christian Brauner <brauner@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	regressions@lists.linux.dev, table@vger.kernel.org,
	Bernd Rinn <bb@rinn.ch>,
	Karri =?iso-8859-1?Q?H=E4m=E4l=E4inen?= <kh.bugreport@outlook.com>,
	Milan Broz <gmazyland@gmail.com>,
	Cameron Davidson <bugs@davidsoncj.id.au>, Markus <markus@fritz.box>
Subject: [regression 6.1.y] Regression from 476c1dfefab8 ("mm: Don't pin
 ZERO_PAGE in pin_user_pages()") with pci-passthrough for both KVM VMs and
 booting in xen DomU
Message-ID: <Z_6sh7Byddqdk1Z-@eldamar.lan>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi

[Apologies if this has been reported already but I have not found an
already filled corresponding report]

After updating from the 6.1.129 based version to 6.1.133, various
users have reported that their VMs do not boot anymore up (both KVM
and under Xen) if pci-passthrough is involved. The reports are at:

https://bugs.debian.org/1102889
https://bugs.debian.org/1102914
https://bugs.debian.org/1103153

Milan Broz bisected the issues and found that the commit introducing
the problems can be tracked down to backport of c8070b787519 ("mm:
Don't pin ZERO_PAGE in pin_user_pages()") from 6.5-rc1 which got
backported as 476c1dfefab8 ("mm: Don't pin ZERO_PAGE in
pin_user_pages()") in 6.1.130. See https://bugs.debian.org/1102914#60

#regzbot introduced: 476c1dfefab8b98ae9c3e3ad283c2ac10d30c774

476c1dfefab8b98ae9c3e3ad283c2ac10d30c774 is the first bad commit
commit 476c1dfefab8b98ae9c3e3ad283c2ac10d30c774
Author: David Howells <dhowells@redhat.com>
Date:   Fri May 26 22:41:40 2023 +0100

    mm: Don't pin ZERO_PAGE in pin_user_pages()

    [ Upstream commit c8070b78751955e59b42457b974bea4a4fe00187 ]

    Make pin_user_pages*() leave a ZERO_PAGE unpinned if it extracts a pointer
    to it from the page tables and make unpin_user_page*() correspondingly
    ignore a ZERO_PAGE when unpinning.  We don't want to risk overrunning a
    zero page's refcount as we're only allowed ~2 million pins on it -
    something that userspace can conceivably trigger.

    Add a pair of functions to test whether a page or a folio is a ZERO_PAGE.

    Signed-off-by: David Howells <dhowells@redhat.com>
    cc: Christoph Hellwig <hch@infradead.org>
    cc: David Hildenbrand <david@redhat.com>
    cc: Lorenzo Stoakes <lstoakes@gmail.com>
    cc: Andrew Morton <akpm@linux-foundation.org>
    cc: Jens Axboe <axboe@kernel.dk>
    cc: Al Viro <viro@zeniv.linux.org.uk>
    cc: Matthew Wilcox <willy@infradead.org>
    cc: Jan Kara <jack@suse.cz>
    cc: Jeff Layton <jlayton@kernel.org>
    cc: Jason Gunthorpe <jgg@nvidia.com>
    cc: Logan Gunthorpe <logang@deltatee.com>
    cc: Hillf Danton <hdanton@sina.com>
    cc: Christian Brauner <brauner@kernel.org>
    cc: Linus Torvalds <torvalds@linux-foundation.org>
    cc: linux-fsdevel@vger.kernel.org
    cc: linux-block@vger.kernel.org
    cc: linux-kernel@vger.kernel.org
    cc: linux-mm@kvack.org
    Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
    Reviewed-by: Christoph Hellwig <hch@lst.de>
    Acked-by: David Hildenbrand <david@redhat.com>
    Link: https://lore.kernel.org/r/20230526214142.958751-2-dhowells@redhat.com
    Signed-off-by: Jens Axboe <axboe@kernel.dk>
    Stable-dep-of: bddf10d26e6e ("uprobes: Reject the shared zeropage in uprobe_write_opcode()")
    Signed-off-by: Sasha Levin <sashal@kernel.org>

 Documentation/core-api/pin_user_pages.rst |  6 ++++++
 include/linux/mm.h                        | 26 ++++++++++++++++++++++++--
 mm/gup.c                                  | 31 ++++++++++++++++++++++++++++++-
 3 files changed, 60 insertions(+), 3 deletions(-)

Milan verified that the issue persists in 6.1.134 so far and the patch
itself cannot be just reverted.

The failures all have a similar pattern, when pci-passthrough is used
for a pci devide, for instance under qemu the bootup will fail with:

qemu-system-x86_64: -device {"driver":"vfio-pci","host":"0000:03:00.0","id":"hostdev0","bus":"pci.3","addr":"0x0"}: VFIO_MAP_DMA failed: Cannot allocate memory
qemu-system-x86_64: -device {"driver":"vfio-pci","host":"0000:03:00.0","id":"hostdev0","bus":"pci.3","addr":"0x0"}: vfio 0000:03:00.0: failed to setup container

(in the case as reported by Milan).

Any ideas here?

Regards,
Salvatore

