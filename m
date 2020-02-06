Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D42B15483A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 16:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbgBFPj7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 10:39:59 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60527 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727060AbgBFPj7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 10:39:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581003597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yYOYGUmwnwR/sxALNyTmJEU8tjH1tqXxiHmaN9nBtbg=;
        b=ZjzLOh9EJ2zL/wQz+7OJN7EjnBs7pgXdIhd003kEwLwcPhFWub24KuHVnXf5PtNV08u1gJ
        qj9fDYlKWVQvm/d7+ShGN8lR8GKj9+W96kAs1xCRGeNH8Iw+bWahMGIhkUDIzDkEILt+Mf
        /O5HNqB7Wr2MO/fW9qk7dNmqM3y0Dcc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-W7fKFVbAO-mVmHC7HOWqXg-1; Thu, 06 Feb 2020 10:39:50 -0500
X-MC-Unique: W7fKFVbAO-mVmHC7HOWqXg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 85C7010054E3;
        Thu,  6 Feb 2020 15:39:49 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E35AE857BF;
        Thu,  6 Feb 2020 15:39:48 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     dan.j.williams@intel.com, linux-fsdevel@vger.kernel.org,
        linux-nvdimm@lists.01.org, willy@infradead.org
Subject: Re: [patch] dax: pass NOWAIT flag to iomap_apply
References: <x49r1z86e1d.fsf@segfault.boston.devel.redhat.com>
        <20200206084740.GE14001@quack2.suse.cz>
        <x49tv43lr98.fsf@segfault.boston.devel.redhat.com>
        <20200206144338.GB26114@quack2.suse.cz>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Thu, 06 Feb 2020 10:39:47 -0500
In-Reply-To: <20200206144338.GB26114@quack2.suse.cz> (Jan Kara's message of
        "Thu, 6 Feb 2020 15:43:38 +0100")
Message-ID: <x49ftfnlo70.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jan Kara <jack@suse.cz> writes:

> On Thu 06-02-20 09:33:39, Jeff Moyer wrote:
>> Jan Kara <jack@suse.cz> writes:
>> 
>> > On Wed 05-02-20 14:15:58, Jeff Moyer wrote:
>> >> fstests generic/471 reports a failure when run with MOUNT_OPTIONS="-o
>> >> dax".  The reason is that the initial pwrite to an empty file with the
>> >> RWF_NOWAIT flag set does not return -EAGAIN.  It turns out that
>> >> dax_iomap_rw doesn't pass that flag through to iomap_apply.
>> >> 
>> >> With this patch applied, generic/471 passes for me.
>> >> 
>> >> Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
>> >
>> > The patch looks good to me. You can add:
>> >
>> > Reviewed-by: Jan Kara <jack@suse.cz>
>> >
>> > BTW, I've just noticed ext4 seems to be buggy in this regard and even this
>> > patch doesn't fix it. So I guess you've been using XFS for testing this?
>> 
>> That's right, sorry I didn't mention that.  Will you send a patch for
>> ext4, or do you want me to look into it?
>
> I've taken down a note in todo list to eventually look into that but if you
> can have a look, I'm more than happy to remove that entry :).

OK, I'll take a look.

-Jeff

