Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB1C14A9713
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Feb 2022 10:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357734AbiBDJpY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Feb 2022 04:45:24 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:36316 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357552AbiBDJpX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Feb 2022 04:45:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B8857B836FB;
        Fri,  4 Feb 2022 09:45:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BE29C004E1;
        Fri,  4 Feb 2022 09:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643967921;
        bh=Mb1R1CEJLIUyU5wYRD8/Qpqu3jJJ3pUvR4P+L2WzG/I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VdXT7cfXmWgRTGFrFK4UYDPtnMEiXnlrLID8e4DhBOmtkMoQoR1WrWRLjL6qE7/gy
         Vkyfh3bMBU1+zJL5PfximPP4YzMgQgKH/rMGPEkHjVWhp3FcOTy0iRDMWkQwMLXdTa
         FH4XnQFfBaba0OyF9OAof5Jf50zRKMQll7uoptUeIpZaA1ZKZ4b8U7u7sa1CPZ+28o
         85G6lbAIBHg6N5y5pgXEIB+2YZORRMjC5ZuKQ+HluxrBRuI2FoHI2kzxpFjUBRrrHB
         arxN5jZ0BaWG2sS0dSQvWzyohvvvbF8NrHuS9e5sT80CLx1esKSjW8gVU5JeLOziPS
         1XXWcXMno00GQ==
Date:   Fri, 4 Feb 2022 10:45:15 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     "Anton V. Boyarshinov" <boyarsh@altlinux.org>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        ebiederm@xmission.com, legion@kernel.org, ldv@altlinux.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Add ability to disallow idmapped mounts
Message-ID: <20220204094515.6vvxhzcyemvrb2yy@wittgenstein>
References: <20220204065338.251469-1-boyarsh@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220204065338.251469-1-boyarsh@altlinux.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 04, 2022 at 09:53:38AM +0300, Anton V. Boyarshinov wrote:
> Idmapped mounts may have security implications [1] and have
> no knobs to be disallowed at runtime or compile time.
> 
> This patch adds a sysctl and a config option to set its default value.
> 
> [1] https://lore.kernel.org/all/m18s7481xc.fsf@fess.ebiederm.org/
> 
> Based on work from Alexey Gladkov <legion@kernel.org>.
> 
> Signed-off-by: Anton V. Boyarshinov <boyarsh@altlinux.org>
> ---

Thank your for the general idea, Anton.

If you want to turn off idmapped mounts you can already do so today via:
echo 0 > /proc/sys/user/max_user_namespaces

Aside from that, idmapped mounts can only be created by fully privileged
users on the host for a selected number of filesystems. They can neither
be created as an unprivileged user nor can they be created inside user
namespaces.

I appreciate the worry. Any new feature may have security implications
and bugs. In addition, we did address these allegations multiple times
already (see [1], [2], [3], [4], [5]).

As the author/maintainer of this feature,
Nacked-by: Christian Brauner <brauner@kernel.org>

[1]: https://lore.kernel.org/lkml/20210213130042.828076-1-christian.brauner@ubuntu.com/T/#m3a9df31aa183e8797c70bc193040adfd601399ad
[2]: https://lore.kernel.org/lkml/m1r1ifzf8x.fsf@fess.ebiederm.org
[3]: https://lore.kernel.org/lkml/20210213130042.828076-1-christian.brauner@ubuntu.com/T/#m59cdad9630d5a279aeecd0c1f117115144bc15eb
[4]: https://lore.kernel.org/lkml/20210510125147.tkgeurcindldiwxg@wittgenstein
[5]: https://lore.kernel.org/linux-fsdevel/CAHrFyr4AYi_gad7LQ-cJ9Peg=Gt73Sded8k_ZHeRZz=faGzpQA@mail.gmail.com

