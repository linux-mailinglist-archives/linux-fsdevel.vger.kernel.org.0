Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 752FE5AC72
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jun 2019 18:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfF2QMJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Jun 2019 12:12:09 -0400
Received: from mail-io1-f44.google.com ([209.85.166.44]:44811 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbfF2QMJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Jun 2019 12:12:09 -0400
Received: by mail-io1-f44.google.com with SMTP id s7so19053545iob.11
        for <linux-fsdevel@vger.kernel.org>; Sat, 29 Jun 2019 09:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=59azEh7BXrcbkZlQa9IzXL9jo7RflCXRCdxV5RsH6eo=;
        b=toYLAA3uRCCr4OHmBH3iwLBQUtsCxxRQ4ujWl53T26TF4OjO7eKMHxTaHSW+/HqLpC
         4TyxVglVF913QWWttwJb00fCGk00TqL+Osz6dLHfgzBkMcj7FH8YnkW7/k214zbSwA2T
         3yntvBC9fp+zZDJXD3KOinxx0Yf4C/BCWGDfWYH5QLkPYo2Jttnd4mGcuu3xy319d92W
         UM2luQ1qUTrcX3fuU2ueNGBk98kmB3lxNR30+qcXbVrlGsZOgTbMgqewWBcxN4UjN5kD
         rEhdAt39xJika8pSZAsxxQndTiue9ipN/MC6lfw6yZ8hrv4XIBi0hhH57vzR4Bk6MhNU
         ZGng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=59azEh7BXrcbkZlQa9IzXL9jo7RflCXRCdxV5RsH6eo=;
        b=VvP5Qhbo03VhfYoRPijOlMpN8+4Pu3mitx+3OCwnqZ5e3JctGRQMjyiT3uYEqIJPn9
         gahtSiB3E285yF1rc+FYRjE5j3rXp3l7tb2wL0stHEgbFaM0yKm6EG6xsHwn0TQLHmqa
         WE6LWkAmIX2rc/oh9wgIpOQcLRq/VOkEGamzO2QhfOS8hziIbzzFw2M+Klr0IeR1PD0c
         QkzwZYPonon87m2CaBBwb57vZnAhQSFyufy8Z73/fwdQE8orLmB8JooVkL6/K/di+P66
         Ij5SRnfEoolwz2JMWsvSUurqtMVm1Uk/N3P+794a2CgdeJ4+RCWa9JzPcrkvm/BZDPsv
         kbgA==
X-Gm-Message-State: APjAAAU1TfDsl0pXTUNt0XaWaZ9PZZ926SQ8os6qP1X2nRcqLayj0sh4
        AZM6SKeWn2NMtlUGAyUpKBqHN0IybE1CQA==
X-Google-Smtp-Source: APXvYqyTq9gsZw9yuZnztcHVO2rMiDbn1QfkVSrpjstVWs9PZRh2dzpCkHJGOA+hd3G1d/CI1DKSlg==
X-Received: by 2002:a6b:5103:: with SMTP id f3mr17328919iob.142.1561824727855;
        Sat, 29 Jun 2019 09:12:07 -0700 (PDT)
Received: from x1.thefacebook.com ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id o5sm4743484iob.7.2019.06.29.09.12.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 29 Jun 2019 09:12:06 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     davem@davemloft.net
Subject: [PATCHSET 0/2] io_uring: add sendmsg/recvmsg support
Date:   Sat, 29 Jun 2019 10:12:02 -0600
Message-Id: <20190629161204.27226-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds basic support for sendmsg(2) and recvmsg(2) through io_uring.
Similarly to how we handle file IO, we first attempt a non-blocking
call, and if that fails with -EAGAIN/-ENONBLOCK, we punt to an async
worker.

Pretty straightforward, and a test case can be found in the liburing
repository.

-- 
Jens Axboe


