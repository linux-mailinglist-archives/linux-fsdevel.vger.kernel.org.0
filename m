Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAC5D418D8E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Sep 2021 03:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232385AbhI0Buu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Sep 2021 21:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbhI0But (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Sep 2021 21:50:49 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB1EC061570;
        Sun, 26 Sep 2021 18:49:12 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id cv2so4163404qvb.5;
        Sun, 26 Sep 2021 18:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=ygEFtDYZxT9vrjkErAYv8Q0mwvXb7MdrTep5bixORxg=;
        b=FT2jkQ4UFhn/ygqm6BeHtVvO06xiH/nGq++DBQBpVJLPfYmmPG5A3BnV7mBCced2Ih
         +6+YSt6k0WHPQJWKq8FKaQE5JaLI+G72JHZOZPnVOyKrnrINuP2pFeoYsuau5y7wSY62
         4GZ8aX1DWpd8f6K3X3iuhFmpyPXi0foAcE52ygBlyDgz356syItUMOY4wO8/fM2y/xfz
         aZQc3uCVHYhPeKmw9iQKD0YBTodycG1SNJgi///6il7dDE9z69dZB2Ee48bW6iketLpZ
         +ELy8vkrpaWqJPScWfqx4HrBAz102Xkob8f0Y34RKwe/v5wUTVPURNiZ8O91g13g816W
         kang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=ygEFtDYZxT9vrjkErAYv8Q0mwvXb7MdrTep5bixORxg=;
        b=KFpRLNPg3bGRI9hbv8YfbA3YyuM5slotEMJMvMXu7C3fg1hCvpv9DkrVwtCjgQNojZ
         TCar9d7VC7pieO38ZDdwbvxX8OqSwtBuMy7p9+PmRenZCblo7pMYhHFwkGS5s+VZ6kVu
         eBIvM18OXSv1+XWi2pqdBw3c4+m60zQURCGY7h0sgKe8crc77iwV+2UH3mavZLHiFmBM
         XxliZpEsUxmfBCRg1GcHSzn+tx2xmEBr9xXcpC+nZj1Tg7Mry69AHVWWRoH3mTTtiE46
         IY0QD+N9FhMa/+urQ6UwILDz96twi9OYAsSiqlXUR6adFulMFE81nJRHF6ztWzxR6y6a
         ixfA==
X-Gm-Message-State: AOAM533dycWQysxOivAwlmPk1/UNb2lNiD/WlAVT/M8rJy8th7Df7kF/
        xzSiDRsAlOESaT3vxgIrrrOBVBVrSw==
X-Google-Smtp-Source: ABdhPJyI9oRizxJsb5pUccZaHs6QrGxS7CXzT9l767IlIawi0c8tQkHVicOyK0OVkTP2PLXpwl6hMQ==
X-Received: by 2002:a0c:f3c6:: with SMTP id f6mr21341819qvm.33.1632707350122;
        Sun, 26 Sep 2021 18:49:10 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id n20sm11522054qkk.135.2021.09.26.18.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 18:49:09 -0700 (PDT)
Date:   Sun, 26 Sep 2021 21:49:07 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: bcachefs - snapshots
Message-ID: <YVEjEwCiqje7yDyV@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Snapshots have been merged! 9 months of work and 3k lines of new code, finally
released. Some highlights:

 - btrfs style subvolumes & snapshots interface
 - snapshots are writeable
 - highly scalable: number of snapshots is limited only by your disk space
 - highly space efficient: no internal fragmentation issues

Design doc here: https://bcachefs.org/Snapshots/

The core functionality is complete - snapshot creation and deletion works, fsck
changes are done (most of the complexity was in making fsck work without
O(number of snapshots) performance - tricky). Everything else is a todo item:

 - still need to export different st_dev for files in different subvolumes
   (we'll never allocate a new inode with an inode number that collides with an
   inode inother subvolume - but snapshots will naturally result in colliding
   inode numbers)

 - need to hide dirents that point to snapshots when inside snapshots...

 - snapshot creation is not atomic w.r.t. page cache, we do sync_fs() but don't
   block buffered writes

 - other niggling page cache stuff - need to walk page cache and mark blocks as
   no longer reserved on snapshot creation

 - we no longer have quota support, since old style quotas interact badly with
   snapshots

 - we need per subvolume disk space accounting before i can implement btrfs
   style subvolume quotas

 - all the things I neglected to think of yet, and all the bugs I haven't found
   yet

Go wild, please try and break it.
