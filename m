Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01A73456217
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Nov 2021 19:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbhKRSQK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Nov 2021 13:16:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbhKRSQK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Nov 2021 13:16:10 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0292AC061574;
        Thu, 18 Nov 2021 10:13:10 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id w1so30906296edc.6;
        Thu, 18 Nov 2021 10:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MR6HCnfEdOmSa0vPnzGfLi+AiErSezoUtjplUYba5T0=;
        b=cuH4iWLjrrRh1KzLh8i/JeI3eRywIWW0hdf/W1EOFyQL6va1Dib4hhm/JQ9/DO15WY
         dKP9Ps+1Cqmh41412VvGT0qJ7u3icE8JtkSGeeYtNPis6NNIFYr2EL22pelOiIMSUAUh
         Xed4jPqYI1Wxx+lfFHvCAyjVNOT6h1FzMzlMO3KbkZIWT4UTbxt4Mwpwab23IvLdnT5A
         yxiPl28LGfPJaxFMXLe9qJ2enHCwmxNC6uofGVqpItl21Kz40bpe8a61syr97SRJGam9
         gjW4yHXs4u9sG16abDmYdJciap6Qdb+vqCCVDH1nJK7Q+Gqre4PxeU4h+4wzyNdg8/Ew
         Z3DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MR6HCnfEdOmSa0vPnzGfLi+AiErSezoUtjplUYba5T0=;
        b=UTuSXlsmYJFJgFpk7dpkA1J9Rwn5H8FyhTbuhwTPp12lltUTIfneAgQQyr95YgBM2Q
         MpYOULjK7mlKiEkI8xC0++f+LN1bW/IPlsDPObkcZwAs4T3dHGoVYTrTAoUzB9rFkTPf
         JijVHNyceJ5ihlun4G9Ye5GXhWqbfrFKBqf6Lm98bF4On3nHWr+Z73QdxS1Zznb//9vF
         s1pT7vIEOJY8KW7HKgno+b4TFJq0+Y0WXrLCxPg+SyIko3kLIicxCm/ZVpg3UDgXuLkv
         ZVAzDyZKV27t77mcWubf3eEeZO/svIxQEtsa6oD8P3w3J76HbhBMlhhgc7xTDmavpbra
         4l7Q==
X-Gm-Message-State: AOAM530e1hBjLoVLuollpluQAteO/fePXM4nA8KYI29jzPTC1shvbnNC
        VT+ov7bnQtwVll93U9Vx6aando2lVQs=
X-Google-Smtp-Source: ABdhPJwfJBKGQyc19XG7oaA0PKZjf+OQoErav0ZNOQWItZ4EeiFQbBkugDFUyRXGS3Hb1BY6NshGqw==
X-Received: by 2002:a17:906:4099:: with SMTP id u25mr1320210ejj.453.1637259187648;
        Thu, 18 Nov 2021 10:13:07 -0800 (PST)
Received: from crow.. ([95.87.219.163])
        by smtp.gmail.com with ESMTPSA id d10sm224135eja.4.2021.11.18.10.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 10:13:07 -0800 (PST)
From:   "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, ebiederm@xmission.com,
        rostedt@goodmis.org, mingo@redhat.com, hagen@jauu.net,
        rppt@kernel.org, James.Bottomley@HansenPartnership.com,
        akpm@linux-foundation.org, vvs@virtuozzo.com, shakeelb@google.com,
        christian.brauner@ubuntu.com, mkoutny@suse.com,
        "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
Subject: [RFC PATCH 0/4] namespacefs: Proof-of-Concept
Date:   Thu, 18 Nov 2021 20:12:06 +0200
Message-Id: <20211118181210.281359-1-y.karadz@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We introduce a simple read-only virtual filesystem that provides
direct mechanism for examining the existing hierarchy of namespaces
on the system. For the purposes of this PoC, we tried to keep the
implementation of the pseudo filesystem as simple as possible. Only
two namespace types (PID and UTS) are coupled to it for the moment.
Nevertheless, we do not expect having significant problems when
adding all other namespace types.

When fully functional, 'namespacefs' will allow the user to see all
namespaces that are active on the system and to easily retrieve the
specific data, managed by each namespace. For example the PIDs of
all tasks enclosed in the individual PID namespaces. Any existing
namespace on the system will be represented by its corresponding
directory in namespacesfs. When a namespace is created a directory
will be added. When a namespace is destroyed, its corresponding
directory will be removed. The hierarchy of the directories will
follow the hierarchy of the namespaces.

One may argue that most of the information, being exposed by this
new filesystem is already provided by 'procfs' in /proc/*/ns/. In
fact, 'namespacefs' aims to be complementary to 'procfs', showing not
only the individual connections between a process and its namespaces,
but also the global hierarchy of these connections. As a usage example,
before playing with 'namespacefs', I had no idea that the Chrome web
browser creates a number of nested PID namespaces. I can only guess
that each tab or each site is isolated in a nested namespace.

Being able to see the structure of the namespaces can be very useful
in the context of the containerized workloads. This will provide
universal methods for detecting, examining and monitoring all sorts
of containers running on the system, without relaying on any specific
user-space software. Fore example, with the help of 'namespacefs',
the simple Python script below can discover all containers, created
by 'Docker' and Podman' (by all user) that are currently running on
the system.


import sys
import os
import pwd

path = '/sys/fs/namespaces'

def pid_ns_tasks(inum):
    tasks_file = '{0}/pid/{1}/tasks'.format(path ,inum)
    with open(tasks_file) as f:
        return [int(pid) for pid in f]

def uts_ns_inum(pid):
    uts_ns_file = '/proc/{0}/ns/uts'.format(pid)
    uts_ns = os.readlink(uts_ns_file)
    return  uts_ns.split('[')[1].split(']')[0]

def container_info(pid_inum):
    pids = pid_ns_tasks(inum)
    name = ''
    uid = -1

    if len(pids):
        uts_inum = uts_ns_inum(pids[0])
        uname_file = '{0}/uts/{1}/uname'.format(path, uts_inum)
        if os.path.exists(uname_file):
            stat_info = os.stat(uname_file)
            uid = stat_info.st_uid
            with open(uname_file) as f:
                name = f.read().split()[1]

    return name, pids, uid

if __name__ == "__main__":
    pid_ns_list = os.listdir('{0}/pid'.format(path))
    for inum in pid_ns_list:
        name, pids, uid = container_info(inum)
        if (name):
            user = pwd.getpwuid(uid).pw_name
            print("{0} -> pids: {1} user: {2}".format(name, pids, user))



The idea for 'namespacefs' is inspired by the discussion of the
'Container tracing' topic [1] during the 'Tracing micro-conference' [2]
at LPC 2021.

1. https://www.youtube.com/watch?v=09bVK3f0MPg&t=5455s
2. https://www.linuxplumbersconf.org/event/11/page/104-accepted-microconferences


Yordan Karadzhov (VMware) (4):
  namespacefs: Introduce 'namespacefs'
  namespacefs: Add methods to create/remove PID namespace directories
  namespacefs: Couple namespacefs to the PID namespace
  namespacefs: Couple namespacefs to the UTS namespace

 fs/Kconfig                  |   1 +
 fs/Makefile                 |   1 +
 fs/namespacefs/Kconfig      |   6 +
 fs/namespacefs/Makefile     |   4 +
 fs/namespacefs/inode.c      | 410 ++++++++++++++++++++++++++++++++++++
 include/linux/namespacefs.h |  73 +++++++
 include/linux/ns_common.h   |   4 +
 include/uapi/linux/magic.h  |   2 +
 kernel/pid_namespace.c      |   9 +
 kernel/utsname.c            |   9 +
 10 files changed, 519 insertions(+)
 create mode 100644 fs/namespacefs/Kconfig
 create mode 100644 fs/namespacefs/Makefile
 create mode 100644 fs/namespacefs/inode.c
 create mode 100644 include/linux/namespacefs.h

-- 
2.33.1

