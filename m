Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E012D223AC2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jul 2020 13:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgGQLph (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jul 2020 07:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbgGQLph (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jul 2020 07:45:37 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44939C061755;
        Fri, 17 Jul 2020 04:45:37 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id ed14so4095569qvb.2;
        Fri, 17 Jul 2020 04:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:mime-version
         :content-disposition;
        bh=RGmCnCujTCPHPAqseUf5nHct0c3cR5+Pl0sn8j65GRA=;
        b=La4PoFUSodowSJLHupAbyoCryYe4IscT0uVjcLdnBdcKu34q4TNYPqzS0Nr/jQc+EM
         F2XyfYyxL8FQhKctiFagZGB9yxdA12JMq8JEvISZeKuMS1vZ5/Oau3CFZLgR8K43xiUU
         E86yO3eN5U8q9hW+83UrqolEyLOq60sn5RWpuN0fRb6KFwI9m265IqtAwKVQfl4cygy3
         0jKEYBIANHgXGZAdahfISR5yQA6FuB5q/EXPJLjCM6LtRPdNK0IPKb1/gbZHs22PgaEY
         wX7lul5113brAi0ptNWB69Sc4TE4p22uWbGzG5GisCJcFbMfc7QZcO5iTG1ztdjRVt0Y
         Uktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mime-version:content-disposition;
        bh=RGmCnCujTCPHPAqseUf5nHct0c3cR5+Pl0sn8j65GRA=;
        b=qGMcyCf5HiazK1TIB0hEeejdA3gHvOawaLPnyms2I80MHbS8qx+o82rYiqdlXZqGh9
         uQ5m45QAM8osavfd8fGRENDtx5tn/ZC+BQnWASw5CozGSRLCv3P1BKgxernNSPlQG9t9
         yNmzTbUayGQqaOXmynwmmr5iiTyctbQMfboKgsKnnHRvV+lHE+s82oxgRpWQRVtzPLac
         3HFO243rZmJKbIS/t+Xwtf4YQuHe4MvutB4I+Z51/IOetbxdqF2n8fs5zAzNBL7cKrf8
         yOZ7ZRyScGsqvrb3/NPEtql26mXxDLaTdTfuF+3rHq1g5AJ/xFfK8dMVcQNiN6SA6235
         QlEg==
X-Gm-Message-State: AOAM531570kqhHP5igGwvvl+K2wnd1utHryrtT/hwfmxrojj0j/iwn7n
        kCwVuEussoQoreJ4MQ/jPMSPFLuE0k3W
X-Google-Smtp-Source: ABdhPJzKXuvJZlL9/a9hkaENPQ8WnD+XhRB2h7wtRwtCk65prLKd7UbjOiRuatykH0KlTfyqjIJ2+Q==
X-Received: by 2002:a0c:a992:: with SMTP id a18mr8145355qvb.211.1594986336193;
        Fri, 17 Jul 2020 04:45:36 -0700 (PDT)
Received: from PWN (c-76-119-149-155.hsd1.ma.comcast.net. [76.119.149.155])
        by smtp.gmail.com with ESMTPSA id s8sm10967968qtc.17.2020.07.17.04.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 04:45:35 -0700 (PDT)
Date:   Fri, 17 Jul 2020 07:45:32 -0400
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Daniel Colascione <dancol@google.com>
Cc:     timmurray@google.com, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, viro@zeniv.linux.org.uk, paul@paul-moore.com,
        nnk@google.com, sds@tycho.nsa.gov, lokeshgidra@google.com,
        jmorris@namei.org
Subject: Reporting a use-after-free read bug in userfaultfd_release()
Message-ID: <20200717114532.GA688728@PWN>
Reply-To: 20200401213903.182112-4-dancol@google.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

Syzbot reported the following use-after-free bug in
userfaultfd_release():

	https://syzkaller.appspot.com/bug?id=4b9e5aea757b678d9939c364e50212354a3480a6

It seems to be caused by this patch. I took a look at the stack trace.
In the patch:

	fd = get_unused_fd_flags(O_RDONLY | O_CLOEXEC);
	if (fd < 0) {
		fput(file);
		goto out;
	}

If get_unused_fd_flags() fails, `ctx` is freed. Later however, before
returning back to userland, userfaultfd_release() is called and tries to
use `ctx` again, causing a use-after-free bug.

The syzbot reproducer does a setrlimit() then a userfaultfd(). The
former sets a hard limit on number of open files to zero, which causes
get_unused_fd_flags() to fail.

Thank you,

Peilin Ye
