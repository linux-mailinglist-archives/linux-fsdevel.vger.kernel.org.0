Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA6B01449E3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2020 03:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbgAVCfn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jan 2020 21:35:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45211 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727141AbgAVCfn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jan 2020 21:35:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579660541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=POKaWFUS4afE4It6ZHd31CDAZnMuACgIqyaXU7tr/+U=;
        b=VPPBIcDyUOyf3D69VPS+HhNegTf2PzuGZccMtnkqPM3KlkQi1YoiccftQXzvo0NvaEqthY
        p2jpHo+xreCAcy2JlndFZ4zLUcpjM/5QDhMdqX8igoUHNW6TrGF/9njNdhPItf83qhDHgQ
        o783hdABo9nqqsn2iek+mmHmCiqBuho=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-K7gQCDYqPcOo69yCPwXNiQ-1; Tue, 21 Jan 2020 21:35:36 -0500
X-MC-Unique: K7gQCDYqPcOo69yCPwXNiQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B11A7477;
        Wed, 22 Jan 2020 02:35:35 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-112-7.rdu2.redhat.com [10.10.112.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 873EB89E73;
        Wed, 22 Jan 2020 02:35:32 +0000 (UTC)
From:   jglisse@redhat.com
To:     lsf-pc@lists.linux-foundation.org
Cc:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org
Subject: [LSF/MM/BPF TOPIC] Generic page write protection
Date:   Tue, 21 Jan 2020 18:32:22 -0800
Message-Id: <20200122023222.75347-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>


Provide a generic way to write protect page (=C3=A0 la KSM) to enable new=
 mm
optimization:
    - KSM (kernel share memory) to deduplicate pages (for file
      back pages too not only anonymous memory like today)
    - page duplication NUMA (read only duplication) in multiple
      different physical page. For instance share library code
      having a copy on each NUMA node. Or in case like GPU/FPGA
      duplicating memory read only inside the local device memory.
    ...

Note that this write protection is intend to be broken at anytime in
reasonable time (like KSM today) so that we never block more than
necessary anything that need to write to the page.


The goal is to provide a mechanism that work for both anonymous and
file back memory. For this we need to a pointer inside struct page.
For anonymous memory KSM uses the anon_vma field which correspond
to mapping field for file back pages.

So to allow generic write protection for file back pages we need to
avoid relying on struct page mapping field in the various kernel code
path that do use it today.

The page->mapping fields is use in 5 different ways:
 [1]- Functions operating on file, we can get the mapping from the file
      (issue here is that we might need to pass the file down the call-
      stack)

 [2]- Core/arch mm functions, those do not care about the file (if they
      do then it means they are vma related and we can get the mapping
      from the vma). Those functions only want to be able to walk all
      the pte point to the page (for instance memory compaction, memory
      reclaim, ...). We can provide the exact same functionality for
      write protected pages (like KSM does today).

 [3]- Block layer when I/O fails. This depends on fs, for instance for
      fs which uses buffer_head we can update buffer_head to store the
      mapping instead of the block_device as we can get the block_device
      from the mapping but not the mapping from the block_device.

      So solving this is mostly filesystem specific but i have not seen
      any fs that could not be updated properly so that block layer can
      report I/O failures without relying on page->mapping

 [4]- Debugging (mostly procfs/sysfs files to dump memory states). Those
      do not need the mapping per say, we just need to report page states
      (and thus write protection information if page is write protected).

 [5]- GUP (get user page) if something calls GUP in write mode then we
      need to break write protection (like KSM today). GUPed page should
      not be write protected as we do not know what the GUPers is doing
      with the page.


Most of the patchset deals with [1], [2] and [3] ([4] and [5] are mostly
trivial).

For [1] we only need to pass down the mapping to all fs and vfs callback
functions (this is mostly achieve with coccinelle). Roughly speaking the
patches are generated with following pseudo code:

add_mapping_parameter(func)
{
    function_add_parameter(func, mapping);

    for_each_function_calling (caller, func) {
        calling_add_parameter(caller, func, mapping);

        if (function_parameters_contains(caller, mapping|file))
            continue;

        add_mapping_parameter(caller);
    }
}

passdown_mapping()
{
    for_each_function_in_fs (func, fs_functions) {
        if (!function_body_contains(func, page->mapping))
            continue;

        if (function_parameters_contains(func, mapping|file))
            continue;

        add_mapping_parameter(func);
    }
}

For [2] KSM is generalized and extended so that both anonymous and file
back pages can be handled by a common write protected page case.

For [3] it depends on the filesystem (fs which uses buffer_head are
easily handled by storing mapping into the buffer_head struct).


To avoid any regression risks the page->mapping field is left intact as
today for non write protect pages. This means that if you do not use the
page write protection mechanism then it can not regress. This is achieve
by using an helper function that take the mapping from the context
(current function parameter, see above on how function are updated) and
the struct page. If the page is not write protected then it uses the
mapping from the struct page (just like today). The only difference
between before and after the patchset is that all fs functions that do
need the mapping for a page now also do get it as a parameter but only
use the parameter mapping pointer if the page is write protected.

Note also that i do not believe that once confidence is high that we
always passdown the correct mapping down each callstack, it does not
mean we will be able to get rid of the struct page mapping field.

I posted patchset before [*1] and i intend to post an updated patchset
before LSF/MM/BPF. I also talked about this at LSF/MM 2018. I still
believe this will a topic that warrent a discussion with FS/MM and
block device folks.


[*1] https://lwn.net/Articles/751050/
     https://cgit.freedesktop.org/~glisse/linux/log/?h=3Dgeneric-write-pr=
otection-rfc
[*2] https://lwn.net/Articles/752564/


To: lsf-pc@lists.linux-foundation.org
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-block@vger.kernel.org
Cc: linux-mm@kvack.org

