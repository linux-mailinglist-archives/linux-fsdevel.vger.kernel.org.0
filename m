Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6142A09B5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Oct 2020 16:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgJ3PYy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Oct 2020 11:24:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:58066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbgJ3PYy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Oct 2020 11:24:54 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E707820725;
        Fri, 30 Oct 2020 15:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604071493;
        bh=T2KvBAlC4JJIyi5sSwStQYRy5LCf5duxKL2gGp64a+g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PztylyBAKxmttAPFkdF06ceMHW1ttTYxC1mWX3RWyEfn+YlSDPFwl4UDGKOtVkzw1
         y/v9iPcEQt+r/UmjmcWTT8nZ3jTBzdOPXzu2vtTBiEf/WqPTCR3uJoVQRqtK+Icjcs
         fedZmAR80qlTgfOmiDSYpN9WQOd2NJUKVlTeHULk=
Received: by pali.im (Postfix)
        id BA0C586D; Fri, 30 Oct 2020 16:24:50 +0100 (CET)
Date:   Fri, 30 Oct 2020 16:24:50 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, dsterba@suse.cz, aaptel@suse.com,
        willy@infradead.org, rdunlap@infradead.org, joe@perches.com,
        mark@harmstone.com, nborisov@suse.com,
        linux-ntfs-dev@lists.sourceforge.net, anton@tuxera.com
Subject: Re: [PATCH v11 00/10] NTFS read-write driver GPL implementation by
 Paragon Software
Message-ID: <20201030152450.77mtzkxjove36qfd@pali>
References: <20201030150239.3957156-1-almaz.alexandrovich@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201030150239.3957156-1-almaz.alexandrovich@paragon-software.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello and thanks for update!

I have just two comments for the last v11 version.

I really do not like nls_alt mount option and I do not think we should
merge this mount option into ntfs kernel driver. Details I described in:
https://lore.kernel.org/linux-fsdevel/20201009154734.andv4es3azkkskm5@pali/

tl;dr it is not systematic solution and is incompatible with existing
in-kernel ntfs driver, also incompatible with in-kernel vfat, udf and
ext4 (with UNICODE support) drivers. In my opinion, all kernel fs
drivers which deals with UNICODE should handle it in similar way.

It would be really bad if userspace application need to behave
differently for this new ntfs driver and differently for all other
UNICODE drivers.

Second comment is simplification of usage nls_load() with UTF-8 parameter
which I described in older email:
https://lore.kernel.org/linux-fsdevel/948ac894450d494ea15496c2e5b8c906@paragon-software.com/

You wrote that you have applied it, but seems it was lost (maybe during
rebase?) as it is not present in the last v11 version.

I suggested to not use nls_load() with UTF-8 at all. Your version of
ntfs driver does not use kernel's nls utf8 module for UTF-8 support, so
trying to load it should be avoided. Also kernel can be compiled without
utf8 nls module (which is moreover broken) and with my above suggestion,
ntfs driver would work correctly. Without that suggestion, mounting
would fail.
