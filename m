Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1337B1FFE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 16:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbjI1OrV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 10:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbjI1OrR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 10:47:17 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA53180;
        Thu, 28 Sep 2023 07:47:13 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1CF7E40E0198;
        Thu, 28 Sep 2023 14:47:08 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id N5pJ5cn_zyMK; Thu, 28 Sep 2023 14:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1695912422; bh=tPU8iyjpgSIBCOSk7Wcxg0E9kh+miOLhLUIx3QkgCHU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ll1gXe5e3fpQ+szMHmOHc//PTgpilvT7S57e0IhATDq6tDehQ1o2EgoeCSI3zAsOv
         qLVwdxpZ+qYC/b7BX0RvHDqR/ZJh9mBvjVSE2WZv0pIlr84uYoOdc67yRLc+Eo+hE1
         v2Pg11lRg/BSvQU3bFmybtXtMo0YECtYBA5cpNRoVipS9y1xGTtLH9BZr2Fi4ONlMb
         uGYzpt3Yd+6AnMrLawD9QtPwfC8B0eRUH3Tpy50UTZZ8oFios1DjxXwX+3aeNWQku0
         A10Gxc28sw7EpIUasKSPCHEj2tyXssapZOMiyrYxvAcxlDTGoD4imkyj0SWvJBtXjU
         39xT6FcjXg2qgoS/js4We3RiaJNc6r+iQbhDT7RWlnU43MNPbtHmBHoY6I3YITtohr
         VckEzdycdx+VfDUprobZdo3u3ga7ikM0rxh/prcT9/gqYvNnJbxVESsVIS8V/1lU2T
         Q9WYW0nN+FHfenvuPDPLDmqaDZc2aDwRyUGhNMSRHdkIyfLEVzsgTxPl63Q1F73s7e
         PDU3q6FHB8dJkwgh8Cp+rCpGcmtUdWoetVfw2wrus17tp0nL6mHg8Ei7V7KtFQrsFi
         VV0DsvItSODlgmWqQajBBVIxGbjMw43m0FrOGyXk9cWLoO+8AGwt8PnhXmwH2QTvEQ
         rI6+ntonm/tg4EWbBwe1M3T4=
Received: from nazgul.tnic (unknown [88.128.88.93])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D96CC40E00B3;
        Thu, 28 Sep 2023 14:46:41 +0000 (UTC)
Date:   Thu, 28 Sep 2023 16:47:07 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     David Howells <dhowells@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        David Laight <David.Laight@aculab.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: Re: [PATCH v7 02/12] iov_iter, x86: Be consistent about the __user
 tag on copy_mc_to_user()
Message-ID: <20230928144707.GBZRWR693kYmj8Z0NX@fat_crate.local>
References: <20230925120309.1731676-1-dhowells@redhat.com>
 <20230925120309.1731676-3-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230925120309.1731676-3-dhowells@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 25, 2023 at 01:02:59PM +0100, David Howells wrote:
> copy_mc_to_user() has the destination marked __user on powerpc, but not on
> x86; the latter results in a sparse warning in lib/iov_iter.c.
> 
> Fix this by applying the tag on x86 too.
> 
> Fixes: ec6347bb4339 ("x86, powerpc: Rename memcpy_mcsafe() to copy_mc_to_{user, kernel}()")
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Dan Williams <dan.j.williams@intel.com>
> cc: Thomas Gleixner <tglx@linutronix.de>
> cc: Ingo Molnar <mingo@redhat.com>
> cc: Borislav Petkov <bp@alien8.de>
> cc: Dave Hansen <dave.hansen@linux.intel.com>
> cc: "H. Peter Anvin" <hpa@zytor.com>
> cc: Alexander Viro <viro@zeniv.linux.org.uk>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: Christoph Hellwig <hch@lst.de>
> cc: Christian Brauner <christian@brauner.io>
> cc: Matthew Wilcox <willy@infradead.org>
> cc: Linus Torvalds <torvalds@linux-foundation.org>
> cc: David Laight <David.Laight@ACULAB.COM>
> cc: x86@kernel.org
> cc: linux-block@vger.kernel.org
> cc: linux-fsdevel@vger.kernel.org
> cc: linux-mm@kvack.org
> ---
>  arch/x86/include/asm/uaccess.h | 2 +-
>  arch/x86/lib/copy_mc.c         | 8 ++++----
>  2 files changed, 5 insertions(+), 5 deletions(-)

Acked-by: Borislav Petkov (AMD) <bp@alien8.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
