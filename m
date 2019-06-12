Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 406C3447F4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2019 19:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729486AbfFMRDQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jun 2019 13:03:16 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34585 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729449AbfFLWyh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jun 2019 18:54:37 -0400
Received: by mail-wm1-f66.google.com with SMTP id w9so5270610wmd.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jun 2019 15:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=JPDTuU1KnT4imMfQFt3NF1AkrQ8ighWpONZCIjWty8k=;
        b=Nq8XeflSpeNq85e0XL6YL6R2q9mdD488Rr1YrYR+xdjtkLsTPQ2J+RZ+++BpMD6zs4
         0PUUwrE079J3RlX/OYkGYC9YyuOcEvxfOqptTMqPnhFbZf51cS1TkTQ9shNS3Xmu8lsx
         LIgiKMllwi/VvpMIO63KrOTNKDCWxUyuXQuQOn/hk0cs1TLXFLsWrTHr16u4lAumEPal
         xZF48NOWp4DkVh8r8exkogr1ZfbxTHy6Q+3E5sGDd8BRh62mpDKONNBwxYDF8sMXCTBC
         RCCkc+wC5jS8dENlCKFJvHhLlIE5/3gbR6zPxnFgpahYIn1DIOkmO/0V6V3tLjJSwzEO
         UUyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=JPDTuU1KnT4imMfQFt3NF1AkrQ8ighWpONZCIjWty8k=;
        b=K0ui58DwXa/XCixUQ0TYqFyCbxjG3AChmssysp/gYNH1qX5DB7nxmx2VGCfZZPXl4r
         RzFVSqSARajhJp0Hzugs3rVYs/D9vKNJLiOsottmf+Cw7Sf3QFcqW2dyZV9JdiiHGwkE
         WrH36ZLu2h2q7wIgEsom6GjVZy5iLYBYbE43z+Vmn2xf9+kf8waxy+oWsOtgnH1M+yCV
         vJ+Ad2mmOzZrzzHchdMziO8cxsoEpVgCpfAmhQRkHqQbx3w43KLpq6I5H21BAGi+RJFG
         4h86qJwi1rP1umG6HboILkm8Xnh1FpjffGYabI6CtVXrtK2w/HxNkVYtrJdXqBOtkJJE
         vXgQ==
X-Gm-Message-State: APjAAAXsPe3RtgXpIn4ssLK+EYBUZCWCEd6EYzZ6Wl/G67OK3QXQXpbY
        aBbJElo1dtx1gJAtl3hE+WG2AJ5GvNupMQ==
X-Google-Smtp-Source: APXvYqzMwFI47ICM+9xHYN+8QsBe1OUPB18O7f91O/loMUm8TPCfIlC6qG8jtfcI5of1Ah/ZYCVwLQ==
X-Received: by 2002:a1c:acc8:: with SMTP id v191mr1006944wme.177.1560380074924;
        Wed, 12 Jun 2019 15:54:34 -0700 (PDT)
Received: from brauner.io ([212.91.227.56])
        by smtp.gmail.com with ESMTPSA id z14sm996092wre.96.2019.06.12.15.54.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 15:54:34 -0700 (PDT)
Date:   Thu, 13 Jun 2019 00:54:33 +0200
From:   Christian Brauner <christian@brauner.io>
To:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, dhowells@redhat.com
Subject: Regression for MS_MOVE on kernel v5.1
Message-ID: <20190612225431.p753mzqynxpsazb7@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hey,

Sorry to be the bearer of bad news but I think I observed a pretty
gnarly regression for userspace with MS_MOVE from kernel v5.1 onwards.

When propagating mounts across mount namespaces owned by different user
namespaces it is not possible anymore to move the mount in the less
privileged mount namespace.
Here is a reproducer:

sudo mount -t tmpfs tmpfs /mnt
sudo --make-rshared /mnt

# create unprivileged user + mount namespace and preserve propagation
unshare -U -m --map-root --propagation=unchanged

# now change back to the original mount namespace in another terminal:
sudo mkdir /mnt/aaa
sudo mount -t tmpfs tmpfs /mnt/aaa

# now in the unprivileged user + mount namespace
mount --move /mnt/aaa /opt

This will work on kernels prior to 5.1 but will fail on kernels starting
with 5.1.
Unfortunately, this is a pretty big deal for userspace. In LXD - which I
maintain when not doing kernel stuff - we use this mechanism to inject
mounts into running unprivileged containers. Users started reporting
failures against our mount injection feature just a short while ago
(cf.  [1], [2]) and I just came around to looking into this today.

I tracked this down to commit:

commit 3bd045cc9c4be2049602b47505256b43908b4e2f
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Wed Jan 30 13:15:45 2019 -0500

    separate copying and locking mount tree on cross-userns copies

    Rather than having propagate_mnt() check doing unprivileged copies,
    lock them before commit_tree().

    Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

reverting it makes MS_MOVE to work correctly again.
The commit changes the internal logic to lock mounts when propagating
mounts (user+)mount namespaces and - I believe - causes do_mount_move()
to fail at:

if (old->mnt.mnt_flags & MNT_LOCKED)
        goto out;

If that's indeed the case we should either revert this commit (reverts
cleanly, just tested it) or find a fix.

Thanks!
Christian

[1]: https://github.com/lxc/lxd/issues/5788
[2]: https://github.com/lxc/lxd/issues/5836
