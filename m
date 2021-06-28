Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB5BF3B5DD1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jun 2021 14:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232973AbhF1MUB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Jun 2021 08:20:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:60106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232802AbhF1MT7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Jun 2021 08:19:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F216561C3D;
        Mon, 28 Jun 2021 12:17:31 +0000 (UTC)
Date:   Mon, 28 Jun 2021 14:17:29 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     menglong8.dong@gmail.com
Cc:     mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Yang Yang <yang.yang29@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] sysctl: fix permission check while owner isn't
 GLOBAL_ROOT_UID
Message-ID: <20210628121729.xsbm63b5lxpsvhbu@wittgenstein>
References: <20210625083338.384184-1-yang.yang29@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210625083338.384184-1-yang.yang29@zte.com.cn>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 25, 2021 at 01:33:38AM -0700, menglong8.dong@gmail.com wrote:
> From: Yang Yang <yang.yang29@zte.com.cn>
> 
> With user namespace enabled, root in container can't modify
> /proc/sys/net/ipv4/ip_forward. While /proc/sys/net/ipv4/ip_forward
> belongs to root and mode is 644. Since root in container may
> be non-root in host, but test_perm() doesn't consider about it.

I'm confused about what the actual problem is tbh:

root@h3:~# stat -c "%A %a %n" /proc/sys/net/ipv4/ip_forward
-rw-r--r-- 644 /proc/sys/net/ipv4/ip_forward

root@h3:~# echo 0 > /proc/sys/net/ipv4/ip_forward

root@h3:~# cat /proc/sys/net/ipv4/ip_forward
0

root@h3:~# cat /proc/self/uid_map 
         0     100000 1000000000

Also, this patch changes the security requirements for all sysctls which
is unfortunately unacceptable.
