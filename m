Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA56E633DC4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Nov 2022 14:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233773AbiKVNeB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Nov 2022 08:34:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233791AbiKVNd5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Nov 2022 08:33:57 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B3551C1D
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Nov 2022 05:33:56 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id k19so17972914lji.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Nov 2022 05:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ginkel.com; s=google;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5+UL8YmYuxaAzETdr30Z6QYBlXK72yteH1Bc1JcIfos=;
        b=keIHJlTdlsw2h8a3PiynUjgxrGvKUiyAq6MElC7d6EJwVzp+xJ/zb5jrVwEVTXX8kh
         p9YXCNez8zaqjD+MAKQ5lfGJ+3U37/CLGzqW434Nz2CHG4lbQG1q7VmrX6cWuupCMlJZ
         QbgbuYkmCaYkyrP9kFOfhUQWe8VYCbM+9vyqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5+UL8YmYuxaAzETdr30Z6QYBlXK72yteH1Bc1JcIfos=;
        b=drYaJASUq+T949oNbxo18YRFjjEOEc0JQIifNdCAYR6EWJJYDqLY1pAs9PeEq+RFYg
         xHv6wNn9phjQiAA3zOEUnS8NyPuk51kHoUC9A6/3VPHtWAE69C8eBLiXAOrPrnhCVoOY
         hDAT1gzEFDYbro/rRJts8IBDVeI2X9B3ql3GIkEWqmzjvarPsbhvrZm2nKJ17WFiyugv
         NzRcb+YBcSB/FMwJm0R/w9sL60yswDjuBhqW9tX6VwmQma8KksQRvkDkYo40KNGyl54E
         X91x3uWTbUJ04znZC9kaHyNZnHLGdv6SnzhhtkmjaKti887kVAGgkadWr7RLh7eOU5t5
         jXPw==
X-Gm-Message-State: ANoB5pnugfkFgZAHWjiM82kfyNqesO5xBlIysJ2HzFy0cUUhPPbAhr2y
        l1aplTUCuAqvm/9qTGpE74Krvh4xpc6uRVAVMOJrgKhgsLpuA749
X-Google-Smtp-Source: AA0mqf64LHD1q4mcYCT3B+AmzEAcnWSzUbAxDKZlhZj89fn2Zm+eywNNH1Pu2IQUX8XAVUmA/kHdVqtiFa2hFoXJrUE=
X-Received: by 2002:a2e:aaa4:0:b0:277:a84:44f5 with SMTP id
 bj36-20020a2eaaa4000000b002770a8444f5mr2404824ljb.312.1669124034057; Tue, 22
 Nov 2022 05:33:54 -0800 (PST)
MIME-Version: 1.0
From:   Thilo-Alexander Ginkel <thilo@ginkel.com>
Date:   Tue, 22 Nov 2022 14:33:38 +0100
Message-ID: <CANvSZQ8XjO=x51TB9qKy7EZWEF0nK_1oAf55yuHX5L6AGML=eA@mail.gmail.com>
Subject: Prometheus Node Exporter and cadvisor seem to run into deadlocks (?)
 since change in fs/eventpoll.c
To:     linux-fsdevel@vger.kernel.org
Cc:     Stefan Bader <stefan.bader@canonical.com>,
        Kamal Mostafa <kamal@canonical.com>,
        Benjamin Segall <bsegall@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi there,

since applying the recent Ubuntu security release for the 5.4.0 kernel
(5.4.0-134) our Node Exporter and cadvisor processes have started
acting up when collecting metrics for consumption by Prometheus. What
has previously taken under a second is now taking > 1 minute.

A small reproducer in Go that queries netclass data (similar to what
Node Exporter does) is available at [1].

Bisecting did not really help (due to the non-deterministic nature of
the bug), but an educated guess in the Node Exporter issue #2500
discussion [2] on GitHub brought up the following commit as the
possible culprit:

commit bcf91619e32fe584ecfafa49a3db3d1db4ff70b2
Author: Benjamin Segall <bsegall@google.com>
Date:   Wed Jun 15 14:24:23 2022 -0700

    epoll: autoremove wakers even more aggressively

    BugLink: https://bugs.launchpad.net/bugs/1990190

    commit a16ceb13961068f7209e34d7984f8e42d2c06159 upstream.

    If a process is killed or otherwise exits while having active network
    connections and many threads waiting on epoll_wait, the threads will all
    be woken immediately, but not removed from ep->wq.  Then when network
    traffic scans ep->wq in wake_up, every wakeup attempt will fail, and will
    not remove the entries from the list.

    This means that the cost of the wakeup attempt is far higher than usual,
    does not decrease, and this also competes with the dying threads trying to
    actually make progress and remove themselves from the wq.

    Handle this by removing visited epoll wq entries unconditionally, rather
    than only when the wakeup succeeds - the structure of ep_poll means that
    the only potential loss is the timed_out->eavail heuristic, which now can
    race and result in a redundant ep_send_events attempt.  (But only when
    incoming data and a timeout actually race, not on every timeout)

    Shakeel added:

    : We are seeing this issue in production with real workloads and it has
    : caused hard lockups.  Particularly network heavy workloads with a lot
    : of threads in epoll_wait() can easily trigger this issue if they get
    : killed (oom-killed in our case).

    Link: https://lkml.kernel.org/r/xm26fsjotqda.fsf@google.com
    Signed-off-by: Ben Segall <bsegall@google.com>
    Tested-by: Shakeel Butt <shakeelb@google.com>
    Cc: Alexander Viro <viro@zeniv.linux.org.uk>
    Cc: Linus Torvalds <torvalds@linux-foundation.org>
    Cc: Shakeel Butt <shakeelb@google.com>
    Cc: Eric Dumazet <edumazet@google.com>
    Cc: Roman Penyaev <rpenyaev@suse.de>
    Cc: Jason Baron <jbaron@akamai.com>
    Cc: Khazhismel Kumykov <khazhy@google.com>
    Cc: Heiher <r@hev.cc>
    Cc: <stable@kernel.org>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Signed-off-by: Kamal Mostafa <kamal@canonical.com>
    Signed-off-by: Stefan Bader <stefan.bader@canonical.com>

I have reverted this commit in my test environment and haven't been
able to reproduce the issue since.

An alternative workaround seems to be to reduce Node Exporter's
concurrency, which hints at some kind of race condition being
involved.

There are also reports for other distributions, which suggests that
the issue is more wide-spread.

My Vagrant-based test environment is available at [3].

Any ideas?

Thanks & kind regards,
Thilo

[1] https://github.com/prometheus/node_exporter/issues/2500#issuecomment-1304847221
[2] https://github.com/prometheus/node_exporter/issues/2500#issuecomment-1322491565
[3] https://github.com/tgbyte/stuck-node-exporter
