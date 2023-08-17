Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C7477FC54
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Aug 2023 18:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353731AbjHQQrs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Aug 2023 12:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353771AbjHQQrp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Aug 2023 12:47:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D229273F;
        Thu, 17 Aug 2023 09:47:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B37D658F9;
        Thu, 17 Aug 2023 16:47:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2448EC433C9;
        Thu, 17 Aug 2023 16:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692290861;
        bh=S1u9Zd2p2ct/ztBtxvHnHmKyOh9+7SZn3m/BiYXFwLY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GHmNPkW60c8iMPszrpYG3/NYv3hHJHYWQcF8frhbCrR46XJfWtn/xhrX3vwQMHEDj
         996OttZVINb2W2tYfXi4oK3HeHQu2cAhNR34/JJdGJMs10+U3iyGAW0aMA39I5bjDe
         RDCeMs206RMcscACula8cgAPaN96J/hzm+zKZg25LOipqppnmzu2M1gIjfZtNgPPB6
         F218CfrVbFZQS3bo6TRnayZQeCZk5qJSYEoJoO0PVP6rWWw4ldGsAk+U/i0O/TEyfA
         GA4hG8wv6xyfR1YW4Bxab1YgNsxTZgY4zRyCLgRuVmz3pYWH/MS3ATakXW1ZgKhg8Q
         u7pC06KodvaPg==
Date:   Thu, 17 Aug 2023 09:47:39 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     sandeen@redhat.com,
        syzbot <syzbot+27eece6916b914a49ce7@syzkaller.appspotmail.com>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
Subject: Re: [syzbot] [ext4?] kernel panic: EXT4-fs (device loop0): panic
 forced after error (3)
Message-ID: <20230817164739.GC1483@sol.localdomain>
References: <000000000000530e0d060312199e@google.com>
 <20230817142103.GA2247938@mit.edu>
 <81f96763-51fe-8ea1-bf81-cd67deed9087@redhat.com>
 <20230817161118.GC2247938@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817161118.GC2247938@mit.edu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 17, 2023 at 12:11:18PM -0400, Theodore Ts'o wrote:
> On Thu, Aug 17, 2023 at 09:47:48AM -0500, Eric Sandeen wrote:
> > 
> > Just to play devil's advocate here - (sorry) - I don't see this as any
> > different from any other "malicious" filesystem image.
> > 
> > I've never been a fan of the idea that malicious images are real security
> > threats, but whether the parking lot USB stick paniced the box in an
> > unexpected way or "on purpose," the result is the same ...
> > 
> > I wonder if it might make sense to put EXT4_MOUNT_ERRORS_PANIC under a
> > sysctl or something, so that admins can enable it only when needed.
> 
> Well, if someone is stupid enough to plug in a parking lot USB stick
> into their system, they get everything they deserve.  And a forced
> panic isn't going to lead a more privilege escalation attack, so I
> really don't see a problem if a file system which is marked "panic on
> error", well, causes a panic.  It's a good way of (harmlessly)
> punishing stupid user tricks.  :-)
> 
> The other way of thinking about it is that if your threat model
> includes an attacker with physical access to the server with a USB
> port, attacks include a cable which has a USB port on one side, and a
> 120V/240V AC mains plug on the the other.  This will very likely cause
> a system shutdown, even if they don't have automount enabled.   :-)
> 

Eric S. is correct that for a filesystem image to enable panic on error, support
for panic on error should have to be properly consented to by the kernel
configuration, for example through an fs.allow_panic_on_error sysctl.

It can be argued that this not important, or not worth implementing when the
default will need to remain 1 for backwards compatibility.  Or even that
syzkaller should work around it in the mean time.  But it is incorrect to write
"This is fundamentally a syzbot bug."

- Eric
