Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8673C4A54B4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Feb 2022 02:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbiBABdg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jan 2022 20:33:36 -0500
Received: from mail-pl1-f181.google.com ([209.85.214.181]:40730 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbiBABdd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jan 2022 20:33:33 -0500
Received: by mail-pl1-f181.google.com with SMTP id y17so14090064plg.7;
        Mon, 31 Jan 2022 17:33:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=kZzz0ZYedVF3geNCITujBz9Zssyga+6PVvZeF/gIoDU=;
        b=I1/ehDaucbNojiD5ORkRdw1ZJaPq6xwG2Qyl2sQQ3mUeoDPkuYab5ejWvARjV2tbjZ
         y6/6P0ajvhneYoxCsQFj7ip2EBZVIwiAhbQr3z3ssBlVdMWMhWKS1W88J3xQndrTGG8Q
         GTyJu3RVtt4tPlQMi3+VmkLwfF8+VFzbH9P4tVkjw5K/oXNFMqDOVB6ye1H59OtEl9hU
         ZDZ9/DG5JUT0plIlReW4oKuc3FYzowpUhluA9iBBSJv/4YXqBDnN1ziIdrZ2Yxe/SLB9
         dkcSMTRsaGIei7Mc31HReonRLKNgTO3v/QOG5k3WY0zASXIi03LYo0vSls2hKytw3kDm
         ejLQ==
X-Gm-Message-State: AOAM531tE5550oiAyf1Cf1d6GCxWROqb46h0XNzZW2KOXfFXWRIirdr5
        7N/Pl+0Sdnud3ZmOB1D521A=
X-Google-Smtp-Source: ABdhPJwyNJSCImOrvU/mdIW6gh3qj/6cZSSMKVuaeGq/vVBBGhmfv/RsFnQmUhjEcL/u5ZN1P+cl5w==
X-Received: by 2002:a17:90b:388d:: with SMTP id mu13mr36859368pjb.239.1643679212988;
        Mon, 31 Jan 2022 17:33:32 -0800 (PST)
Received: from garbanzo (136-24-173-63.cab.webpass.net. [136.24.173.63])
        by smtp.gmail.com with ESMTPSA id v9sm20344629pfu.60.2022.01.31.17.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 17:33:32 -0800 (PST)
Date:   Mon, 31 Jan 2022 17:33:29 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     lsf-pc@lists.linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Steven Whitehouse <swhiteho@redhat.com>,
        Steve French <stfrench@microsoft.com>,
        Samuel Cabrero <scabrero@suse.de>,
        David Teigland <teigland@redhat.com>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Josef Bacik <josef@toxicpanda.com>, mcgrof@kernel.org
Subject: [LSF/MM/BPF TOPIC] are we going to use ioctls forever?
Message-ID: <20220201013329.ofxhm4qingvddqhu@garbanzo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It would seem we keep tacking on things with ioctls for the block
layer and filesystems. Even for new trendy things like io_uring [0].
For a few years I have found this odd, and have slowly started
asking folks why we don't consider alternatives like a generic
netlink family. I've at least been told that this is desirable
but no one has worked on it. *If* we do want this I think we just
not only need to commit to do this, but also provide a target. LSFMM
seems like a good place to do this.

Possible issues? Kernels without CONFIG_NET. Is that a deal breaker?
We already have a few filesystems with their own generic netlink
families, so not sure if this is a good argument against this.

mcgrof@fulton ~/linux-next (git::master)$ git grep genl_register_family fs
fs/cifs/netlink.c:      ret = genl_register_family(&cifs_genl_family);
fs/dlm/netlink.c:       return genl_register_family(&family);
fs/ksmbd/transport_ipc.c:       ret = genl_register_family(&ksmbd_genl_family);
fs/quota/netlink.c:     if (genl_register_family(&quota_genl_family) != 0)
mcgrof@fulton ~/linux-next (git::master)$ git grep genl_register_family drivers/block
drivers/block/nbd.c:    if (genl_register_family(&nbd_genl_family)) {

Are there other reasons to *not* use generic netlink for new features?
For folks with experience using generic netlink on the block layer and
their own fs, any issues or pain points observed so far?

[0] https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=nvme-passthru-wip.2&id=d11e20acbd93fbbcdaf87e73615cdac53b814eca

  Luis
