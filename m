Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 798A7145A0D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2020 17:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbgAVQmr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jan 2020 11:42:47 -0500
Received: from mail-io1-f53.google.com ([209.85.166.53]:35290 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgAVQmr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jan 2020 11:42:47 -0500
Received: by mail-io1-f53.google.com with SMTP id h8so7305865iob.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jan 2020 08:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+38KoZ4LOlfHsCMrv5MDbJAohwM+DFmbcG7PpNyUiPk=;
        b=R8iLp6XWjWffu+yxUkg43lmBI7nFlQVVZ84FKk7WGgdd65Aj8rTYc7oQkzNmb0jK2d
         EciMSO94BVRpTKXl7Z9KrJRMQPCCZztevhDLwNjOItO767C4RepMX70o+2VZnLHY6pmY
         LKA/L9Fs8pBpgHmzyC/UDefJoC7k6K4zslx+x11Khr6mIAPgetUwExRqDiXYDn8GesZh
         gnUIfvK5QtA+gOUTVQrVJagj1sx6BlXmip6LUC78eau7oEVp5I4qr3yG38bq4upapoAP
         tPfASacc0cJcpR2GZulEI59KvyPXdHSTzx5F33nhQcHF4brygk9FQbIqfC8pKY9cPytQ
         PLLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+38KoZ4LOlfHsCMrv5MDbJAohwM+DFmbcG7PpNyUiPk=;
        b=s8hdhfOa54eDT7yeMRCx+9cLEEI8nNv0hasof9FYct6Zi7Q4HJqt2DxChevacp5U5X
         nkkWKVSFpjsxCXBoxNg0dPUcmqP9vfNt75tXtjKzmJbJUp9samdkD+7mkzrOSayNxrlY
         +XHBqHUKjdMwFv7MbszDL6mP0X45o7qrn33LjjVA3MOGaP+w6PNxpOo6+q39lVomr+DE
         1ykQsnbew0bLWCY7wiyL8Fo7a2ffdo7BYOozH1ujUfVoaeeUUmCFCPEsNdiI2PBXnZSg
         +2M0PlWQoaPn8YhsCnSjwldiSHjEJ5c9awW6mlMbYWihk9vcTXJ1BcXEK9Qbt0SU3jnD
         zLZQ==
X-Gm-Message-State: APjAAAX+Il5vkqWluFrfaS/TTN4q53PzNf91mwR9e1fobqLQ1ixtMdT8
        EYq+ugn1qiPBkVJM7fRkXMp1kg==
X-Google-Smtp-Source: APXvYqzvQN59P1PlJXDv6H8PrNxhyXOmikny502SB9obSt5aXGSjHYqxdJ9D5MazHmRtNyHEKkrYWg==
X-Received: by 2002:a6b:e803:: with SMTP id f3mr7924877ioh.49.1579711366986;
        Wed, 22 Jan 2020 08:42:46 -0800 (PST)
Received: from x1.localdomain ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id o6sm14599681ilc.76.2020.01.22.08.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 08:42:46 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, jannh@google.com
Subject: [PATCHSET v2 0/3] Add io_uring support for epoll_ctl
Date:   Wed, 22 Jan 2020 09:42:41 -0700
Message-Id: <20200122164244.27799-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds support for epoll manipulation through io_uring, in particular
epoll_ctl(2). Patch 1 is just a prep patch, patch 2 adds non-block
support for epoll, and patch 3 wires it up for io_uring.

Patch 2 isn't the prettiest thing in the world, but we need to do
nonblock grabbing of the mutexes and be able to back out safely.

Please review, thanks.

Since v1:

- Use right version...
- Fix locking in eventpoll
- Don't EINVAL on sqe->off in epoll prep for io_uring

-- 
Jens Axboe


