Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6634821FCA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2019 23:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbfEQVlh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 May 2019 17:41:37 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41428 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbfEQVlh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 May 2019 17:41:37 -0400
Received: by mail-pf1-f196.google.com with SMTP id q17so4278479pfq.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 May 2019 14:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=AGPNbGIVDM8DZYXdO8EWRMLfpACALLPcJohjiWTCYaQ=;
        b=EsnGURItIQiCHnIF0SYu65dLHTWdF2Ag/4SW+/ggx8Mvxk6Czs+rXGrjE+t7SbWqBD
         ja6jJ/g87LtROuuUOUbnQCglFt9rLAwHwMqvzOZOy6RoOUa1RHQahJ7tQLCXYBtr682q
         xvuq+7+Tt9Fbni8ypzzh+6nWEISzH901QEGr41teEvT+1z4X969giyoB6fh99eFXFoSA
         qSHGtMPPBXM2kwunOTihLSGEoapgobhJdsxlbO5Dqdo44t+NwsK9TFrtp4fitXF+ktKN
         RRVwHW3PsEUaen+k/RNoVprAniYzt4ip/GjAnJPYUEYQMGBnivdylyP6Oyo+oTP9rIrg
         DdAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AGPNbGIVDM8DZYXdO8EWRMLfpACALLPcJohjiWTCYaQ=;
        b=ewg0Q8gOdF7xV9BznnbwSyoMVTT+kJPaDSA2boTMQBmm1WdfDavh3r0aD5xFkijj4e
         iPLsb1QU8pbNgodEgU+O25qP3K3sE+vezEBcaBOUFUsAvspYmV6UuZ4EdgNyYxnk2aQq
         B/HG7dBstnKoKFBIs/8ATqo35mgKxNmPjHZRf4OcJCdATjfFS6yYr85fgKZ+IYJU0yLD
         hcZ0JOojgsvRzr7QKSNTqurm/r9htU5dMXvRJ15Pzmpbpr2u4geyx2RCApHLjh9nfJy7
         a7/pXMvwymGLRV4j2eCXsTyK8uewlbgV0AOgLV3FjV2WHfxy+95e+k659f4PAjDdJ7i7
         Yfkw==
X-Gm-Message-State: APjAAAVkIf+D9W86L7FPtkhjsB6dUHE9P3dP74ni9rgv5VE0rUG3lRpU
        nat96xZd1bE0v3w6zYADaqCW+3di7ciCiw==
X-Google-Smtp-Source: APXvYqwGmY1UDJcSi/iJ+lV7nRWwHFU7mQLPXlmrPRa2EFpCmnW4mY5Rn/jAGg5XoK9PJoeFu+XdnA==
X-Received: by 2002:a63:e550:: with SMTP id z16mr59599609pgj.329.1558129296212;
        Fri, 17 May 2019 14:41:36 -0700 (PDT)
Received: from x1.localdomain (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id z125sm15885331pfb.75.2019.05.17.14.41.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 14:41:35 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk
Subject: [PATCHSET 0/3] io_uring: support for linked SQEs
Date:   Fri, 17 May 2019 15:41:28 -0600
Message-Id: <20190517214131.5925-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We currently support a barrier operation, which ensures that previous
commands have finished before they are executed. This patchset
introduces support for linked commands. Linked commands form a
dependency between commands, but not for the execution pipeline in
general. Example:

[[ ReadA, WriteA], [ReadB, WriteB], [ReadC, WriteC]]

This is a weak ascii attempt at showing a series of reads and writes,
where each write depends on the previous read. WriteA will not be
started before ReadA is complete. Think of a copy like operation, where
ReadA is "read X bytes from file Y at offset Z" and WriteB is then
"write X bytes to file A at offset B", with the two sharing the same
iovec. While WriteA depends on the completion of ReadA, there are no
dependencies between ReadA and ReadB, and they may execute in parallel.

In terms of user API, ReadA will have IOSQE_IO_LINK set. When that is
set, the next command depends on it. If the next one also has
IOSQE_IO_LINK set, then the dependency continues. If it doesn't, then
the chain stops with the next command.

I wrote a trivial cp(2) implementation using linked reads and writes,
you can find that here:

http://git.kernel.dk/cgit/liburing/tree/examples/link-cp.c

in the liburing git repo. There's also a test program in there
exercising various types of chains.

I think this is a very powerful concept, and something that could even
be extended to be BPF driven at completion time if dependencies need
further linkage outside of what can be statically provided initially.
A potential series could be [Open file, Read, Close file] where the
fd needs to be carried forward, for example.

Patches are against current master from Linus, and are also in my
io_uring-next branch.

-- 
Jens Axboe


