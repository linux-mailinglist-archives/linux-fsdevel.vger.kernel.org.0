Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84CD43EC86A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Aug 2021 11:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237218AbhHOJm6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Aug 2021 05:42:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:34786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233413AbhHOJm5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Aug 2021 05:42:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BA0F860295;
        Sun, 15 Aug 2021 09:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629020547;
        bh=GSfHvZE/Q+UBpMvO/QW4NWjmTbLIJVvGzR58O4IoWVo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HhBuMmVMJ3oXH0dzUi0Fuy5CdwP6wfFidET79td5sbgoRkXMXjjTToVpC+PsCW8x9
         Yr6MfwdVkHjQozyWXN1s2T5M89VkdTfrVoKEMKFEmiR0PWHNhlY29Lv58QqLWd5tE8
         QZC/iZctxtu5UVFMQ39lb2ttM0+NOsGxEqPWCIh91pdzLrXUXvDux9ShB6C+0SvXwd
         mBIuhtvlw7EF/9AxhSmVA0QA3mtM+3oR8sAWW9XGiIQ3mZ0vEd9tgTIVcV0Yqn4w4c
         gQXFz7pXE/ZcrMV5c+/QfD7KzDhJGAtMw55xytvJf4QBX3Ar7vUKlLCRfSe75hvz60
         U32qpiamU50zA==
Received: by pali.im (Postfix)
        id C887C98C; Sun, 15 Aug 2021 11:42:24 +0200 (CEST)
Date:   Sun, 15 Aug 2021 11:42:24 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     linux-fsdevel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, linux-cifs@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, "Theodore Y . Ts'o" <tytso@mit.edu>,
        Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki <salah.triki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        Anton Altaparmakov <anton@tuxera.com>,
        Pavel Machek <pavel@ucw.cz>,
        Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC PATCH 01/20] fat: Fix iocharset=utf8 mount option
Message-ID: <20210815094224.dswbjywnhvajvzjv@pali>
References: <20210808162453.1653-1-pali@kernel.org>
 <20210808162453.1653-2-pali@kernel.org>
 <87h7frtlu0.fsf@mail.parknet.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87h7frtlu0.fsf@mail.parknet.co.jp>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sunday 15 August 2021 12:42:47 OGAWA Hirofumi wrote:
> Pali Rohár <pali@kernel.org> writes:
> 
> > Currently iocharset=utf8 mount option is broken and error is printed to
> > dmesg when it is used. To use UTF-8 as iocharset, it is required to use
> > utf8=1 mount option.
> >
> > Fix iocharset=utf8 mount option to use be equivalent to the utf8=1 mount
> > option and remove printing error from dmesg.
> 
> This change is not equivalent to utf8=1. In the case of utf8=1, vfat
> uses iocharset's conversion table and it can handle more than ascii.
> 
> So this patch is incompatible changes, and handles less chars than
> utf8=1. So I think this is clean though, but this would be regression
> for user of utf8=1.

I do not think so... But please correct me, as this code around is mess.

Without this change when utf8=1 is set then iocharset= encoding is used
for case-insensitivity implementation (toupper / tolower conversion).
For all other parts are use correct utf8* conversion functions.

But you use touppper / tolower functions from iocharset= encoding on
stream of utf8 bytes then you either get identity or some unpredictable
garbage in utf8. So when comparing two (different) non-ASCII filenames
via this method you in most cases get that filenames are different.
Because converting their utf8 bytes via toupper / tolower functions from
iocharset= encoding results in two different byte sequences in most
cases. Even for two utf8 case-insensitive same strings.

But you can play with it and I guess it is possible to find two
different utf8 strings which after toupper / tolower conversion from
some iocharset= encoding would lead to same byte sequence.

This patch uses for utf8 tolower / touppser function simple 7-bit
tolower / toupper ascii function. And so for 7-bit ascii file names
there is no change.

So this patch changes behavior when comparing non 7-bit ascii file
names, but only in cases when previously two different file names were
marked as same. As now they are marked correctly as different. So this
is changed behavior, but I guess it is bug fix which is needed.
If you want I can put this change into separate patch.

Issue that two case-insensitive same files are marked as different is
not changed by this patch and therefore this issue stay here.

> Thanks.
> -- 
> OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
