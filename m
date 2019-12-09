Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A65C117B48
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2019 00:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfLIXO3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 18:14:29 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23923 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfLIXO2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 18:14:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575933267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=khr9GokeYu7WS9DKs6jhiFXoGTLBzguBa3kePJRn0ZU=;
        b=N+f/U9vwykyhnY1XjBYotSidXu2lHwPdkRydBlF5gYfjzSVh8QEP7/DX4Bl1NxrJ3rvkGW
        qXM4xls1AKm+xdrM+68PkyKbOrJR3t3cJvVAeTkJErEpUWGq9447gWrG0cae8T8QkUpyBY
        RHUKb+e29AquWQgYmWyBL2JIt3UaRJM=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-G98FIOMrNHe_pl7sUnY0WA-1; Mon, 09 Dec 2019 18:14:20 -0500
Received: by mail-yb1-f200.google.com with SMTP id 132so5355468ybd.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Dec 2019 15:14:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=khr9GokeYu7WS9DKs6jhiFXoGTLBzguBa3kePJRn0ZU=;
        b=d7JIZPgivUdhVldHWJJmyb4tP1G+g3SmfqSyNOA7r9V9zduMDGvisF69aCJlSjnQAp
         dR/4xoXhjhBlvvOeOBTpVC6kS9l7Xzrr9oS47rDzqcHMvjU4Rd3d+XKQ47oajclh5QM4
         GW8CA7FEsUBm+csp7a2IuW55eDBEpVS9+XEEsR8tbeap/cqOYB2HNOmBq2ahsT/snWoo
         RMOWTrEz/6Bp3sRPE4QYGrSNYG8VuGwZ+91za5AldwiUYSlqQV1QIQAtOMgsu/st0TJK
         tFXP0d45162k2wR+qnwWwzMx+9RCVfuGF56EM0pc9/1lXs4WBvEqNJ1mTMrIAOeT21aH
         0SgA==
X-Gm-Message-State: APjAAAWfMtnxyzSqWA9V5iQd6mqys64A0GviNblsW0NNiwuF6Jipfs4k
        zJPtSuT8JI0f7jxR+Z73b2zsJ9rFjTcGHjbFvFXr4K6lvd+IX2SdiOJjCK5RlLV9b5QHhxCavd+
        mn9O7HFIHlbN4QZJQepy+5Mhp9A==
X-Received: by 2002:a25:6385:: with SMTP id x127mr22238930ybb.468.1575933259550;
        Mon, 09 Dec 2019 15:14:19 -0800 (PST)
X-Google-Smtp-Source: APXvYqwx1MtePmlt4BWVadoKds9t7CKvxMAc8qY2aR/QgTPSjT1bNf/ITjoMXPSEVhuWOzqN35EMig==
X-Received: by 2002:a25:6385:: with SMTP id x127mr22238910ybb.468.1575933259068;
        Mon, 09 Dec 2019 15:14:19 -0800 (PST)
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id w74sm628955yww.106.2019.12.09.15.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 15:14:18 -0800 (PST)
Message-ID: <8d872ab39c590dbfc6f02230dddb8740630f1444.camel@redhat.com>
Subject: Re: [LSF/MM/BPF TOPIC] How to make disconnected operation work?
From:   Jeff Layton <jlayton@redhat.com>
To:     David Howells <dhowells@redhat.com>,
        lsf-pc@lists.linux-foundation.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>
Cc:     linux-fsdevel@vger.kernel.org
Date:   Mon, 09 Dec 2019 18:14:07 -0500
In-Reply-To: <14196.1575902815@warthog.procyon.org.uk>
References: <14196.1575902815@warthog.procyon.org.uk>
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31)
MIME-Version: 1.0
X-MC-Unique: G98FIOMrNHe_pl7sUnY0WA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2019-12-09 at 14:46 +0000, David Howells wrote:
> I've been rewriting fscache and cachefiles to massively simplify it and make
> use of the kiocb interface to do direct-I/O to/from the netfs's pages which
> didn't exist when I first did this.
> 
> 	https://lore.kernel.org/lkml/24942.1573667720@warthog.procyon.org.uk/
> 	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=fscache-iter
> 
> I'm getting towards the point where it's working and able to do basic caching
> once again.  So now I've been thinking about what it'd take to support
> disconnected operation.  Here's a list of things that I think need to be
> considered or dealt with:
> 

I'm quite interested in this too. I see that you've already given a lot
of thought to potential interfaces here. I think we'll end up having to
add a fair number of new interfaces to make something like this work.

>  (1) Making sure the working set is present in the cache.
> 
>      - Userspace (find/cat/tar)
>      - Splice netfs -> cache
>      - Metadata storage (e.g. directories)
>      - Permissions caching
> 
>  (2) Making sure the working set doesn't get culled.
> 
>      - Pinning API (cachectl() syscall?)
>      - Allow culling to be disabled entirely on a cache
>      - Per-fs/per-dir config
> 
>  (3) Switching into/out of disconnected mode.
> 
>      - Manual, automatic
>      - On what granularity?
>        - Entirety of fs (eg. all nfs)
>        - By logical unit (server, volume, cell, share)
>
>  (4) Local changes in disconnected mode.
> 
>      - Journal
>      - File identifier allocation

Yep, necessary if you want to allow disconnected creates. By coincidence
I'm working an (experimental) patchset now to add async create support
to kcephfs, and part of that involves delegating out ranges of inode
numbers. I may have some experience to report with it by the time LSF
rolls around.

>      - statx flag to indicate provisional nature of info
>      - New error codes
> 	- EDISCONNECTED - Op not available in disconnected mode
> 	- EDISCONDATA - Data not available in disconnected mode
> 	- EDISCONPERM - Permission cannot be checked in disconnected mode
> 	- EDISCONFULL - Disconnected mode cache full
>      - SIGIO support?
> 
>  (5) Reconnection.
> 
>      - Proactive or JIT synchronisation
>        - Authentication
>      - Conflict detection and resolution
> 	 - ECONFLICTED - Disconnected mode resolution failed

ECONFLICTED sort of implies that reconnection will be manual. If it
happens automagically in the background you'll have no way to report
such errors.

Also, you'll need some mechanism to know what inodes are conflicted.
This is the real difficult part of this problem, IMO.


>      - Journal replay
>      - Directory 'diffing' to find remote deletions
>      - Symlink and other non-regular file comparison
> 
>  (6) Conflict resolution.
> 
>      - Automatic where possible
>        - Just create/remove new non-regular files if possible
>        - How to handle permission differences?
>      - How to let userspace access conflicts?
>        - Move local copy to 'lost+found'-like directory
>        	 - Might not have been completely downloaded
>        - New open() flags?
>        	 - O_SERVER_VARIANT, O_CLIENT_VARIANT, O_RESOLVED_VARIANT
>        - fcntl() to switch variants?
> 

Again, conflict resolution is the difficult part. Maybe the right
solution is to look at snapshotting-style interfaces -- i.e., handle a
disconnected mount sort of like you would a writable snapshot. Do any
(local) fs' currently offer writable snapshots, btw?

>  (7) GUI integration.
> 
>      - Entering/exiting disconnected mode notification/switches.
>      - Resolution required notification.
>      - Cache getting full notification.
> 
> Can anyone think of any more considerations?  What do you think of the
> proposed error codes and open flags?  Is that the best way to do this?
> 
> David
> 

-- 
Jeff Layton <jlayton@redhat.com>

