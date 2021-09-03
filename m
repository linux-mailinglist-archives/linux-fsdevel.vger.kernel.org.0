Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7104400787
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Sep 2021 23:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235475AbhICVqx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Sep 2021 17:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbhICVqv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Sep 2021 17:46:51 -0400
X-Greylist: delayed 383 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 03 Sep 2021 14:45:51 PDT
Received: from cupdev.net (unknown [IPv6:2a01:4f9:2a:1861::4464:12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C19C061575
        for <linux-fsdevel@vger.kernel.org>; Fri,  3 Sep 2021 14:45:51 -0700 (PDT)
To:     linux-fsdevel@vger.kernel.org
From:   Karolin Varner <karo@cupdev.net>
Subject: =?UTF-8?Q?Proposal=3a_Allow_mounting_and_bind_mounting_over_symlink?=
 =?UTF-8?Q?s_=e2=80=93_flag_to_not_expand_symlinks?=
Message-ID: <e2fbd746-bc05-45e0-34e3-93963326ead6@cupdev.net>
Date:   Fri, 3 Sep 2021 23:39:23 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Morning all!

I would like to propose adding a flag to the syscall underlying mount(2) that disables symlink expansion.

The motivating use case for this is as follows: I am trying to set up a netns namespace that requires a specific DNS setup,
to this end, I am creating a mount namespace and replacing /etc/resolve.conf. Unfortunately, resolv.conf is a symlink provided
by systemd-resolved. Bind mounting over said file with my replacement is impossible: With `-c` option, the `mount` command
actually targets `/etc/resolv.conf` instead of the file it's pointing to, but the kernel expands it internally and seems to
mount over the file being pointed to.

I highly similar use cases exist.

I have tried the nosymfollow option, which did not work. I think it affects only how symlinks are handled once the fs
is mounted.

Best,
Karolin Varner
