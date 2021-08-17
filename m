Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 896FF3EEF06
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Aug 2021 17:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237063AbhHQPUr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Aug 2021 11:20:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46037 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235902AbhHQPUn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Aug 2021 11:20:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629213610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Be+Prm+eAgDG7EnJxJOUP6plitOtAD+UIwtIrNoX3hY=;
        b=YnySQ//VW1CwyjykXpIMY8CtGV4uVmsOYlk9W5GQALpFVn2DNaULs3meIpxPzxOyximBIr
        5qvJ2n68UBsGXCdafOzSr63Sn6BDYop7SVKcR21+5//vGbJ6WAh/E8IXNe2A7m8f67LhN1
        DUvRsnl6z1TObHMWrHguROTLhqIfTKI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-C0N0TL4FMMuP7TLeFOLm0Q-1; Tue, 17 Aug 2021 11:20:06 -0400
X-MC-Unique: C0N0TL4FMMuP7TLeFOLm0Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A665100E324;
        Tue, 17 Aug 2021 15:20:05 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.10.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0F4636A90E;
        Tue, 17 Aug 2021 15:19:53 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 82EE3220637; Tue, 17 Aug 2021 11:19:52 -0400 (EDT)
Date:   Tue, 17 Aug 2021 11:19:52 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     JeffleXu <jefflexu@linux.alibaba.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        virtualization@lists.linux-foundation.org,
        virtio-fs-list <virtio-fs@redhat.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [Virtio-fs] [PATCH v4 0/8] fuse,virtiofs: support per-file DAX
Message-ID: <YRvTmIjt/WAl/UOP@redhat.com>
References: <20210817022220.17574-1-jefflexu@linux.alibaba.com>
 <CAJfpeguw1hMOaxpDmjmijhf=-JEW95aEjxfVo_=D_LyWx8LDgw@mail.gmail.com>
 <YRuCHvhICtTzMK04@work-vm>
 <CAJfpegvM+S5Xru3Yfc88C64mecvco=f99y-TajQBDfkLD-S8zQ@mail.gmail.com>
 <0896b1f6-c8c4-6071-c05b-a333c6cccacd@linux.alibaba.com>
 <CAJfpeguA3zeJq-HJUVZHv4nNybqFezkzPNhcWmj0n5+i7YpW4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpeguA3zeJq-HJUVZHv4nNybqFezkzPNhcWmj0n5+i7YpW4Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 17, 2021 at 04:11:14PM +0200, Miklos Szeredi wrote:

[..]
> > As for virtiofs, Dr. David Alan Gilbert has mentioned that various files
> > may compete for limited DAX window resource.
> >
> > Besides, supporting DAX for small files can be expensive. Small files
> > can consume DAX window resource rapidly, and if small files are accessed
> > only once, the cost of mmap/munmap on host can not be ignored.
> 
> That's a good point.   Maybe we should disable DAX for file sizes much
> smaller than the chunk size?

This indeed seems like a valid concern. 2MB chunk size will consume
512 struct page entries. If an entry is 64 bytes in size, then that's
32K RAM used to access 4K bytes of file. Does not sound like good usage
of resources.

If we end up selectively disabling dax based on file size, two things
come to me mind.

- Will be good if it is users can opt-in for this behavior. There
  might be a class of users who always want to enable dax on all
  files.

- Secondly, we will have to figure out how to do it safely in the
  event of shared filesystem where file size can change suddenly.
  Will need to make sure change from dax to no-dax and vice-versa
  is safe w.r.t page cache and other paths.

Thanks
Vivek

