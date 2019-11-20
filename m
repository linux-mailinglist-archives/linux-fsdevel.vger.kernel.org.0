Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2CF1044B3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2019 20:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbfKTT5g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Nov 2019 14:57:36 -0500
Received: from albireo.enyo.de ([37.24.231.21]:58154 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727085AbfKTT5g (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Nov 2019 14:57:36 -0500
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1iXW6X-0001jY-1c; Wed, 20 Nov 2019 19:57:33 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1iXW6W-0006rH-Vv; Wed, 20 Nov 2019 20:57:32 +0100
From:   Florian Weimer <fw@deneb.enyo.de>
To:     Rich Felker <dalias@libc.org>
Cc:     linux-fsdevel@vger.kernel.org, musl@lists.openwall.com,
        linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org
Subject: Re: [musl] getdents64 lost direntries with SMB/NFS and buffer size < unknown threshold
References: <20191120001522.GA25139@brightrain.aerifal.cx>
Date:   Wed, 20 Nov 2019 20:57:32 +0100
In-Reply-To: <20191120001522.GA25139@brightrain.aerifal.cx> (Rich Felker's
        message of "Tue, 19 Nov 2019 19:15:22 -0500")
Message-ID: <8736eiqq1f.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Rich Felker:

> An issue was reported today on the Alpine Linux tracker at
> https://gitlab.alpinelinux.org/alpine/aports/issues/10960 regarding
> readdir results from SMB/NFS shares with musl libc.
>
> After a good deal of analysis, we determined the root cause to be that
> the second and subsequent calls to getdents64 are dropping/skipping
> direntries (that have not yet been deleted) when some entries were
> deleted following the previous call. The issue appears to happen only
> when the buffer size passed to getdents64 is below some threshold
> greater than 2k (the size musl uses) but less than 32k (the size glibc
> uses, with which we were unable to reproduce the issue).

From the Gitlab issue:

  while ((dp = readdir(dir)) != NULL) {
      unlink(dp->d_name);
      ++file_cnt;
  }

I'm not sure that this is valid code to delete the contents of a
directory.  It's true that POSIX says this:

| If a file is removed from or added to the directory after the most
| recent call to opendir() or rewinddir(), whether a subsequent call
| to readdir() returns an entry for that file is unspecified.

But many file systems simply provide not the necessary on-disk data
structures which are need to ensure stable iteration in the face of
modification of the directory.  There are hacks, of course, such as
compacting the on-disk directory only on file creation, which solves
the file removal case.

For deleting an entire directory, that is not really a problem because
you can stick another loop around this while loop which re-reads the
directory after rewinddir.  Eventually, it will become empty.
