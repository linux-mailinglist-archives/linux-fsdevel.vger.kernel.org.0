Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F526911FA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2019 18:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbfHQQhA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 17 Aug 2019 12:37:00 -0400
Received: from mail-lj1-f170.google.com ([209.85.208.170]:38984 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbfHQQhA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 17 Aug 2019 12:37:00 -0400
Received: by mail-lj1-f170.google.com with SMTP id x4so7937373ljj.6
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Aug 2019 09:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=gh4Uf54lGK4BZME7LVlHMNrohQu549X8RdaI8EEyc2U=;
        b=ucmSPP0TeU4H54GmmFSX4Cbw/YJZftuFiiY89vjitwPTk9KKJY5ycyYQfwfYFdHg5c
         ZMpTLVGFFJx541rvL34eMhfZM/MzoscItMRHiVw2GSlweHhfuE/GFEwcIlgjcDkwPjZb
         s91eCkJZi50Zd82fmuQtlTG7cm7+EpxqhWLQP2T53D5zMMs9Jl8FtyEfQ29/yLEaIS3L
         iAcSvON1BBiNBJXR4tHKjfD1/dlbJK09TCRh6ey1KyPlOE9wZUzx7mmnVneQMOolnM8/
         Ta+isnau03b0FOX2KMb95v8o0sVN35kL8AO9XFsQnbhGL2ArPxZx6ud9C9V5ce4GOQSU
         Pdlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=gh4Uf54lGK4BZME7LVlHMNrohQu549X8RdaI8EEyc2U=;
        b=dJKtmX7DMt4EGHDRBbfayuh762GkAQrLUCrnUKy14APi527pxMu4tz/4QtzLNcCVvc
         mekDKiKhhTLm/ckep4GzLALoF6ENFznwRzVvAR/SDbD3leL00UTDfx27I97lK5hqD65x
         eLsZLb/0XNscK6wKnnDGE07oplpEDlBUoasOfNcmO44Ev4nEBKnzX/WsJ8nhLom8jO7a
         IRbr2vEXe6FdINSr+p5HCBz84IJ46Ptn8X1iSRa+RVEfS67k2eDhTw1SQEProxDspKSS
         zroRC8mrvMAxEPyOUde3uHgXLKQcQ58ui8K9jOPWqP2LPNu4RLLZmuUwKea+4mwnD4qT
         6Sbw==
X-Gm-Message-State: APjAAAV4CO2U1YVq+UbsZBagB75CJVh070S2zUqmVDShz3ZXQ5nkDBPU
        KsO1sKjkikKrZDVUrrFWEgx+IT1pxMWnxkMhbzA1SIosknvZbg==
X-Google-Smtp-Source: APXvYqykqyUbBf3gFxrxYebFwwEH7G9fHg8I2CBloFyhVPaSb9fhNy2DNaUEEsMzxIDRt18Ox0vyCgDmLwEfBQ1mEdI=
X-Received: by 2002:a2e:6393:: with SMTP id s19mr8076155lje.46.1566059817953;
 Sat, 17 Aug 2019 09:36:57 -0700 (PDT)
MIME-Version: 1.0
From:   Heiher <r@hev.cc>
Date:   Sun, 18 Aug 2019 00:36:46 +0800
Message-ID: <CAHirt9jesMHB_sXx7PyXTxrzLR=3xw9bHERueNMVkWOUkg6XXQ@mail.gmail.com>
Subject: Why the edge-triggered mode doesn't work for epoll file descriptor?
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

I've added a pipe file descriptor (fd1) to an epoll (fd3) with
EPOLLOUT in edge-triggered mode, and then added the fd3 to another
epoll (fd4) with EPOLLIN in edge-triggered too.

Next, waiting for fd4 without timeout. When fd1 to be writable, i
think epoll_wait(fd4, ...)  only return once, because all file
descriptors are added in edge-triggered mode.

But, the actual result is returns many and many times until do once
eopll_wait(fd3, ...).

#include <stdio.h>
#include <unistd.h>
#include <sys/epoll.h>

int
main (int argc, char *argv[])
{
    int efd[2];
    struct epoll_event e;

    efd[0] = epoll_create (1);
    if (efd[0] < 0)
        return -1;

    efd[1] = epoll_create (1);
    if (efd[1] < 0)
        return -2;

    e.events = EPOLLIN | EPOLLET;
    e.data.u64 = 1;
    if (epoll_ctl (efd[0], EPOLL_CTL_ADD, efd[1], &e) < 0)
        return -3;

    e.events = EPOLLOUT | EPOLLET;
    e.data.u64 = 2;
    if (epoll_ctl (efd[1], EPOLL_CTL_ADD, 1, &e) < 0)
        return -4;

    for (;;) {
        struct epoll_event events[16];
        int nfds;

        nfds = epoll_wait (efd[0], events, 16, -1);
        printf ("nfds: %d\n", nfds);
    }

    close (efd[1]);
    close (efd[0]);

    return 0;
}

-- 
Best regards!
Hev
https://hev.cc
