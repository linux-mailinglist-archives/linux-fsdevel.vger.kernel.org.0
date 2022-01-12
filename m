Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98C5648BDDE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jan 2022 05:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350680AbiALE2Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jan 2022 23:28:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbiALE2Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jan 2022 23:28:16 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE21BC06173F
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Jan 2022 20:28:15 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id q186so1856464oih.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Jan 2022 20:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=LZtWmPGQEylMl27a95oHEEFMgz6flTZjSnwWdQnptpk=;
        b=rxtOkz6QILIxVkVp4Wsd+qxbtmnmwwouMiRWY53cMXJVC/qCWPHxrgGCqDmfagNc71
         +MrLZIUF7UXKsGLaSL7MVZaR52vwOLam3kHHSHgeortaqeVIYQLxc0fAA2gMWMlbfoh7
         V00frTkKcOFBVys0X8gxUq+hhpen7m7baXYnwSbBoPQqHZlSaZWwy3Zs6GY7JSK7hzYa
         7I/1+RicyCuoZAw/34noouyUpiGQ+AKBRiTe9zTWi+kZoTSX+b5+B794T1VfUdjUFKoE
         Z+7tbyVl6wSsZCiaSdKMaTqKMKP8HM2h3WLaw6lkk6Dm9fY2zv78fTJ6ooVO0CeIzfQP
         /sLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=LZtWmPGQEylMl27a95oHEEFMgz6flTZjSnwWdQnptpk=;
        b=S3eKv467J4NbSUxWktC2vFg4yYWfWfvmJwdjhwALbh5Bl1JTysS6mrVnnl43YI7Lnk
         SmiDEHFkHB4oLMu+f2EvPKLXJwT9AmW0vX8bNW1NJGyqT1R5apMNyAcOqryrf75EyGtH
         ts7O7kpQodweULDab0d50axCWsTRgpQ91qxmSjBv26HggvdnneSWQUvQmLoaScRtxD7j
         GLNEuwDAhMfs3VsXSMi6vWhrqf/OHmBtF39/6elXpKTqeFhS/wRJXRpr1QVsmP20JhWD
         XwEBZyptfshkTjO+NHf96DV4qtdlLi7nkN6ZbpHgv1PQ3MIHMMofQCCS4vhMrVHRMmqu
         2EZw==
X-Gm-Message-State: AOAM532GbKYST23rFqzsSdSosHV+NqdBTm6+PGkFyL3Ufrfwan47iqWV
        gEJU+X1AY2vnxTXBIQAI8+2jzQ==
X-Google-Smtp-Source: ABdhPJz+x7ra4zniEkvn4mIcNbZDei9J4aWiqie7lTDvKWpmXTTdsYnybrjr475jveqwnABjfGIUwA==
X-Received: by 2002:a05:6808:ec2:: with SMTP id q2mr3953557oiv.136.1641961694937;
        Tue, 11 Jan 2022 20:28:14 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id k24sm2440634otl.31.2022.01.11.20.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 20:28:14 -0800 (PST)
Date:   Tue, 11 Jan 2022 20:28:02 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Lukas Czerner <lczerner@redhat.com>
cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Zdenek Kabelac <zkabelac@redhat.com>, hughd@google.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: unusual behavior of loop dev with backing file in tmpfs
In-Reply-To: <20211126075100.gd64odg2bcptiqeb@work>
Message-ID: <5e66a9-4739-80d9-5bb5-cbe2c8fef36@google.com>
References: <20211126075100.gd64odg2bcptiqeb@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 26 Nov 2021, Lukas Czerner wrote:
> 
> I've noticed unusual test failure in e2fsprogs testsuite
> (m_assume_storage_prezeroed) where we use mke2fs to create a file system
> on loop device backed in file on tmpfs. For some reason sometimes the
> resulting file number of allocated blocks (stat -c '%b' /tmp/file) differs,
> but it really should not.
> 
> I was trying to create a simplified reproducer and noticed the following
> behavior on mainline kernel (v5.16-rc2-54-g5d9f4cf36721)
> 
> # truncate -s16M /tmp/file
> # stat -c '%b' /tmp/file
> 0
> 
> # losetup -f /tmp/file
> # stat -c '%b' /tmp/file
> 672
> 
> That alone is a little unexpected since the file is really supposed to
> be empty and when copied out of the tmpfs, it really is empty. But the
> following is even more weird.
> 
> We have a loop setup from above, so let's assume it's /dev/loop0. The
> following should be executed in quick succession, like in a script.
> 
> # dd if=/dev/zero of=/dev/loop0 bs=4k
> # blkdiscard -f /dev/loop0
> # stat -c '%b' /tmp/file
> 0
> # sleep 1
> # stat -c '%b' /tmp/file
> 672
> 
> Is that expected behavior ? From what I've seen when I use mkfs instead
> of this simplified example the number of blocks allocated as reported by
> stat can vary a quite a lot given more complex operations. The file itself
> does not seem to be corrupted in any way, so it is likely just an
> accounting problem.
> 
> Any idea what is going on there ?

I have half an answer; but maybe you worked it all out meanwhile anyway.

Yes, it happens like that for me too: 672 (but 216 on an old installation).

Half the answer is that funny code at the head of shmem_file_read_iter():
	/*
	 * Might this read be for a stacking filesystem?  Then when reading
	 * holes of a sparse file, we actually need to allocate those pages,
	 * and even mark them dirty, so it cannot exceed the max_blocks limit.
	 */
	if (!iter_is_iovec(to))
		sgp = SGP_CACHE;
which allocates pages to the tmpfs for reads from /dev/loop0; whereas
normally a read of a sparse tmpfs file would just give zeroes without
allocating.

[Do we still need that code? Mikulas asked 18 months ago, and I never
responded (sorry) because I failed to arrive at an informed answer.
It comes from a time while unionfs on tmpfs was actively developing,
and solved a real problem then; but by the time it went into tmpfs,
unionfs had already been persuaded to proceed differently, and no
longer needed it. I kept it in for indeterminate other stacking FSs,
but it's probably just culted cargo, doing more harm than good. I
suspect the best thing to do is, after the 5.17 merge window closes,
revive Mikulas's patch to delete it and see if anyone complains.]

But what is asynchronously reading /dev/loop0 (instantiating pages
initially, and reinstantiating them after blkdiscard)? I assume it's
some block device tracker, trying to read capacity and/or partition
table; whether from inside or outside the kernel, I expect you'll
guess much better than I can.

Hugh
