Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACEB4B5C22
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Feb 2022 22:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbiBNVHW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Feb 2022 16:07:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbiBNVHV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Feb 2022 16:07:21 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3DB61081B9
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Feb 2022 13:07:11 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id q7so28767856wrc.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Feb 2022 13:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=algolia.com; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=A/acD8nSSN2qwtutUsyLXhKazSyANNDkpT+zY2rd4hY=;
        b=nVmTdnZw7YS+eOlZnhLC79w+4t4/B3iz1ng/yDksfg/oJnsdGedCB/leWt4F2kYknO
         7dGtPvmWBIBnrYjN2tStnfnG1f/GyVOsAz1QTFx8GHzm9xeiF7LTqpi/f3lj7RSa4/zw
         cacVk2TsFlUn65lyO5kHwFyc3nh3JDiFZc2kk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=A/acD8nSSN2qwtutUsyLXhKazSyANNDkpT+zY2rd4hY=;
        b=6Gpk4dHQ17vba17MlejLG/hVzh6N2a5nDG2dXJBZ9GSl77wPR4g4xu2XoZPO8btkP3
         och41MI55bsGauKV3VuaZOLjyKinKy/SO0BUmM93a4Cu9abe9sHFq9za3JnCRqZI9cWd
         2udIoI+MMqw/5Xy5LpwZfuiCiT41YjHfL3rMWjXbYe0XI95M0D4SeReq1up9pHUpMn8i
         T35Vu4IOduFla7VR60mfJPZ3+25k1bWBQ559XTHcYHK503xJgP235OyHul4Is/4Di3kI
         i21HKVINYRFU2ZPcstgsmLS6MZyrdXtD9a6m7enQqqT0YKMqmxb5CLAFyxqgKFR0p6Tc
         BuXQ==
X-Gm-Message-State: AOAM530orYdgm1XM+3H8GrK8r+MLBDl5PR4CT958uFzMUF153SbNque2
        aC5t/iWhEThj1RbHiPnrnoiVBI7Xyo6Xtzsn
X-Google-Smtp-Source: ABdhPJzMTd/9kIRwNcQZCPYOLULANyq8hwJbViUkoG0vZJn1Ki2BLhMt59etGy6TljzXYaha+J9ynw==
X-Received: by 2002:a5d:4910:: with SMTP id x16mr684033wrq.360.1644872830574;
        Mon, 14 Feb 2022 13:07:10 -0800 (PST)
Received: from xavier-xps ([2a01:e0a:830:d971:752e:e19b:a691:2171])
        by smtp.gmail.com with ESMTPSA id p12sm13244032wmg.36.2022.02.14.13.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 13:07:10 -0800 (PST)
Date:   Mon, 14 Feb 2022 22:07:08 +0100
From:   Xavier Roche <xavier.roche@algolia.com>
To:     linux-kernel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Xavier Roche <xavier.roche@algolia.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: fs: race between vfs_rename and do_linkat (mv and link)
Message-ID: <20220214210708.GA2167841@xavier-xps>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There has been a longstanding race condition between vfs_rename and do_linkat,
when those operations are done in parallel:

1. Moving a file to an existing target file (eg. mv file target)
2. Creating a link from the target file  to a third file (eg. ln target link)

A typical example would be (1) a regular process putting a new version
of a database in place and (2) a regular process backuping the live
database by hardlinking it.

My understanding is that as the target file is never erased on client
side, but just replaced, the link should never fail.

The issue seem to lie inside vfs_link (fs/namei.c):
       inode_lock(inode);
       /* Make sure we don't allow creating hardlink to an unlinked file */
       if (inode->i_nlink == 0 && !(inode->i_state & I_LINKABLE))
               error =  -ENOENT;

The possible answer is that the inode refcount is zero because the
file has just been replaced concurrently, old file being erased, and
as such, the link operation is failing.

The race appears to have been introduced by aae8a97d3ec30, to fix
_another_ race between unlink and link (but I'm not sure to understand
what were the implications).

Reverting the inode->i_nlink == 0 section "fixes" the issue, but would
probably reintroduce this another issue.

At this point I don't know what would be the best way to fix this issue.

Trivial case that will lead to ENOENT: (reproduced on 5.16.5)
Note that the race _seems_ to last while some IO are pending (getting the
race on tmpfs is typically much harder)

========== Cut here ==========
#!/bin/bash
#

rm -f link file target
touch target

# Link target -> link in loop
while ln target link && rm link; do :; done &

# Overwrite file -> target in loop until we fail
while touch file && mv file target; do :; done &

wait
========== Cut here ==========

Kudos to Xavier Grand from Algolia for spotting the issue with a
reproducible case.

The issue was reported three years ago, but only on the fsdevel
mailing-list, where it might have been overlooked.
It was also reported at https://bugzilla.kernel.org/show_bug.cgi?id=204705
