Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E91223B08A6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 17:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbhFVPXF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 11:23:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57392 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232179AbhFVPXE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 11:23:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624375248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=d4qG1BgL83jc2NobbBwa+FD372Pv9PnyTc1bHAkSk00=;
        b=KexJYrgOyLE/x9mCXzzX0oVPpax8uNG4x5SkrzWi+P7Ihj6OsQsufK9gTZOqxdmMfsZv2u
        qBVytmBLlg3YBGMjDU46YdmGcpJzLdOyCEWc+8hZtg4qRGv2zuG+xyTRRfeIXO7S87YLBA
        exWs4KYynVyM71Du1vv5l3bSowQGuWk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-_VBSvZdPObOO47vKxdHgvA-1; Tue, 22 Jun 2021 11:20:45 -0400
X-MC-Unique: _VBSvZdPObOO47vKxdHgvA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7718591271;
        Tue, 22 Jun 2021 15:20:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-65.rdu2.redhat.com [10.10.118.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 64F19100F49F;
        Tue, 22 Jun 2021 15:20:41 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
cc:     dhowells@redhat.com, Ted Ts'o <tytso@mit.edu>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, willy@infradead.org,
        viro@zeniv.linux.org.uk, linux-mm@kvack.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Do we need to unrevert "fs: do not prefault sys_write() user buffer pages"?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3221174.1624375240.1@warthog.procyon.org.uk>
Date:   Tue, 22 Jun 2021 16:20:40 +0100
Message-ID: <3221175.1624375240@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

I've been looking at generic_perform_write() with an eye to adapting a version
for network filesystems in general.  I'm wondering if it's actually safe or
whether it needs 00a3d660cbac05af34cca149cb80fb611e916935 reverting, which is
itself a revert of 998ef75ddb5709bbea0bf1506cd2717348a3c647.

Anyway, I was looking at this bit:

	bytes = min_t(unsigned long, PAGE_SIZE - offset,
					iov_iter_count(i));
	...
	if (unlikely(iov_iter_fault_in_readable(i, bytes))) {
		status = -EFAULT;
		break;
	}

	if (fatal_signal_pending(current)) {
		status = -EINTR;
		break;
	}

	status = a_ops->write_begin(file, mapping, pos, bytes, flags,
					&page, &fsdata);
	if (unlikely(status < 0))
		break;

	if (mapping_writably_mapped(mapping))
		flush_dcache_page(page);

	copied = iov_iter_copy_from_user_atomic(page, i, offset, bytes);


and wondering if the iov_iter_fault_in_readable() is actually effective.  Yes,
it can make sure that the page we're intending to modify is dragged into the
pagecache and marked uptodate so that it can be read from, but is it possible
for the page to then get reclaimed before we get to
iov_iter_copy_from_user_atomic()?  a_ops->write_begin() could potentially take
a long time, say if it has to go and get a lock/lease from a server.

Also, I've been thinking about Willy's folio/THP stuff that allows bunches of
pages to be glued together into single objects for efficiency.  This is
problematic with the above code because the faultahead is limited to a maximum
of PAGE_SIZE, but we might be wanting to modify a larger object than that.

David

