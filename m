Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACFFA630C05
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Nov 2022 06:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbiKSFOy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Nov 2022 00:14:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiKSFOv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Nov 2022 00:14:51 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24ECA8B866
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Nov 2022 21:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gAHIijS0RHQdRe4KPHt7NPKU96uo1uvtAM9z4s/vv8U=; b=AFsixgRA/Wl1kvHEtAnDew0vR2
        1T40ZB07hM8wHOvVf2uTR7zMj/spVkA2rMv60DLTRok8mCU9Ks7IW0EsnBAAOM5I3FL33O+88N/AC
        WlLyY9fz+7ST5MBmIVk8OG/TbVKCARuvZoRscRbIPl/U4RocczaAcYh/4uotaUmfP8NLo2Xg8xBDL
        GExFIczsZnUJuwvGp2EqiELDXR2GS2ujE8L6886YrzIzLW/gQmKhF6ymw0n6pLmHSYaXRNctGdi74
        kSU4VYaIXkxjQTRZYvpRjIaoQS1I8HXqFfxS+9s25LDZaElCr/KyoCAHKU0yPb1CJvn5xew3hX51g
        O8yAja1w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1owGBX-004zMx-2z;
        Sat, 19 Nov 2022 05:14:36 +0000
Date:   Sat, 19 Nov 2022 05:14:35 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Gaosheng Cui <cuigaosheng1@huawei.com>
Cc:     dhowells@redhat.com, willy@infradead.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3] fs: fix undefined behavior in bit shift for SB_NOUSER
Message-ID: <Y3hmOzZwqpyHv8Ab@ZenIV>
References: <20221031142621.194389-1-cuigaosheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031142621.194389-1-cuigaosheng1@huawei.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 31, 2022 at 10:26:21PM +0800, Gaosheng Cui wrote:
> Shifting signed 32-bit value by 31 bits is undefined, so changing most
> significant bit to unsigned, and mark all of the flags as unsigned so
> that we don't mix types. The UBSAN warning calltrace like below:

... is completely irrelevant.  If you want to credit UBSAN for finding
that - sure, no problem, but who cares about the call chain leading to
use of SB_NOUSER?  If nothing else, report would be just as valid if
the only use had been in initializer for static variable...

I've no problem with the change itself, but I'd go with something along
the lines of

----
SB_... flags are masks for struct super_block ->s_flags, which is an
unsigned long.  In particular, SB_NOUSER lives in bit 31.  1 << 31
is not the right way to spell that - it's not just that it is an
undefined behaviour; it's not the right value when used to initialize
an unsigned long variable.  Nasal demons aside, on 64bit architecture
	unsigned long v = 1 << 31;
is *not* going to have v equal to 0x80000000 - it'll be 0xffffffff80000000.

Make the entire bunch explicitly unsigned - 1U << constant.  Note that
it doesn't make sense to go for 1UL - the flags are arch-independent
and that limits us to 32 bits anyway.

Spotted by UBSAN.
----

for commit message.  Not sure about "Fixes:", to be honest...
