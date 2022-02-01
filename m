Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0994A5484
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Feb 2022 02:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbiBABLE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jan 2022 20:11:04 -0500
Received: from mail-pf1-f180.google.com ([209.85.210.180]:36742 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbiBABLD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jan 2022 20:11:03 -0500
Received: by mail-pf1-f180.google.com with SMTP id 192so14417382pfz.3;
        Mon, 31 Jan 2022 17:11:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=jOdu8BK0aHwVRtofXibmBugDwe7ABt+3hwddEIBt+RU=;
        b=dBOs7jFJx3Rv3vqGZCOQOqDkF0RdddT0EbHgguPeUpdUbTeQ8n59IhxKJ2b9jzAP+g
         1CarPeJGsZmqahOlyhWKc8gRCVKVmNxuA3LnVgZaM7W0E1O8gqGUVFVgs9uWI7oa56yq
         JD79J5pjTyuK1FUuwlTfSYEnp0kIeOnoR6u1goxrqv4e+Nz4OnYxnCjDzThdmlcqqN/5
         dtjrP9uGt1Jw2vJAIlquEilu6Cfx93y8dab7JR2lz5nTTTQpoNUH6PfeAJvOENRk5MX1
         Zdeu5VEgGqmdvgxgOaznmHttodJN/xkEKFMuRWuOTHp5wmxGeasXpSzjw77/MhhKZR+E
         +Wxw==
X-Gm-Message-State: AOAM533XS70SMJ6B2blm31tTje+1V66+Ow4tpewRWPhlwKiWw05EDZEh
        fvIIBrjTMpNNjgYvNOmi9BU=
X-Google-Smtp-Source: ABdhPJzSvSQJaT10CRpVEE50uSgPZwPQaff/3Q20sHiKgbPqQE7HP8Wb3nAjllSdyEPxhP3qt26IHw==
X-Received: by 2002:a05:6a00:b42:: with SMTP id p2mr22813636pfo.50.1643677863000;
        Mon, 31 Jan 2022 17:11:03 -0800 (PST)
Received: from garbanzo (136-24-173-63.cab.webpass.net. [136.24.173.63])
        by smtp.gmail.com with ESMTPSA id lb7sm503889pjb.56.2022.01.31.17.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 17:11:02 -0800 (PST)
Date:   Mon, 31 Jan 2022 17:10:59 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     lsf-pc@lists.linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>,
        Hannes Reinecke <hare@suse.com>,
        Eryu Guan <guaneryu@gmail.com>, Omar Sandoval <osandov@fb.com>,
        mcgrof@kernel.org
Subject: [LSF/MM/BPF TOPIC] scaling error injection for block / fs
Message-ID: <20220201011059.kqyrftg2hpgtjtpp@garbanzo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We *used* to not any error handling as part of the block layer's
*add_disk() paths since the code's inception. Fortunately that's now
history, but the only piece of code changes that were dropped from
that effort was error injection [0], this was since Hannes noted that
we may want to discuss if the approach is the best we can do.

I looked into this and indeed the BFP method to do error injection
is a viable alternative [1]. However this was even further generalized
from kprobes and all one now needs is to sprinkle ALLOW_ERROR_INJECTION()
on calls we went to enable error injection for. This makes things much
easier, instead of having to have a kernel bpf program to load
load_bpf_file() and then to run that and specify the comands you want
on the shell you can now just use something as simple as just shell:

-------------------------------------------------------------------
#!/bin/bash

rm -f testfile.img
dd if=/dev/zero of=testfile.img bs=1M seek=1000 count=1
DEVICE=$(losetup --show -f testfile.img)
mkfs.btrfs -f $DEVICE
mkdir -p tmpmnt

FAILTYPE=fail_function
FAILFUNC=open_ctree
echo $FAILFUNC > /sys/kernel/debug/$FAILTYPE/inject
echo -12 > /sys/kernel/debug/$FAILTYPE/$FAILFUNC/retval
echo N > /sys/kernel/debug/$FAILTYPE/task-filter
echo 100 > /sys/kernel/debug/$FAILTYPE/probability
echo 0 > /sys/kernel/debug/$FAILTYPE/interval
echo -1 > /sys/kernel/debug/$FAILTYPE/times
echo 0 > /sys/kernel/debug/$FAILTYPE/space
echo 1 > /sys/kernel/debug/$FAILTYPE/verbose

mount -t btrfs $DEVICE tmpmnt
if [ $? -ne 0 ]
then
       echo "SUCCESS!"
else
       echo "FAILED!"
       umount tmpmnt
fi

echo > /sys/kernel/debug/$FAILTYPE/inject

rmdir tmpmnt
losetup -d $DEVICE
rm testfile.img
-------------------------------------------------------------------

This seems to be much more adaptable to what we do in blktests and
fstests. So before I go forward with adding error injection for the
block layer (only one user) or fs (only btrfs uses this so far), I think
it would be prudent for us to socialize if this *is* the scalable
strategy we'd like to see moving forward. If not then LSFMM seems like a
good place to iron out any possible kinks or concerns folks might have.

If we already have consensus and this is *the* way to go then I'll just
go forward and start adding some knobs / tests for this.

Perhaps the only issue I can think of is that you need a kernel
which enables error injection, and so production kernels would not
cut it.

Thoughts?

[0] https://lkml.kernel.org/r/20210512064629.13899-9-mcgrof@kernel.org
[1] https://lwn.net/Articles/740146/
[2] https://patchwork.ozlabs.org/project/netdev/patch/151563182380.628.2420967932180154822.stgit@devbox/

  Luis
