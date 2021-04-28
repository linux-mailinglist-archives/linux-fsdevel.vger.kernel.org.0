Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3037236DF43
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Apr 2021 20:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243662AbhD1S7L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Apr 2021 14:59:11 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:49208 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbhD1S7J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Apr 2021 14:59:09 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 1284E1F415D1
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Shreeya Patel <shreeya.patel@collabora.com>,
        Christoph Hellwig <hch@infradead.org>,
        adilger.kernel@dilger.ca, jaegeuk@kernel.org, chao@kernel.org,
        ebiggers@google.com, drosen@google.com, ebiggers@kernel.org,
        yuchao0@huawei.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, kernel@collabora.com,
        andre.almeida@collabora.com
Subject: Re: [PATCH v8 4/4] fs: unicode: Add utf8 module and a unicode layer
Organization: Collabora
References: <20210423205136.1015456-1-shreeya.patel@collabora.com>
        <20210423205136.1015456-5-shreeya.patel@collabora.com>
        <20210427062907.GA1564326@infradead.org>
        <61d85255-d23e-7016-7fb5-7ab0a6b4b39f@collabora.com>
        <YIgkvjdrJPjeoJH7@mit.edu> <87bl9z937q.fsf@collabora.com>
        <YIlta1Saw7dEBpfs@mit.edu>
Date:   Wed, 28 Apr 2021 14:58:20 -0400
In-Reply-To: <YIlta1Saw7dEBpfs@mit.edu> (Theodore Ts'o's message of "Wed, 28
        Apr 2021 10:12:59 -0400")
Message-ID: <87mtti6xtf.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

"Theodore Ts'o" <tytso@mit.edu> writes:

> On Tue, Apr 27, 2021 at 11:06:33AM -0400, Gabriel Krisman Bertazi wrote:
>> > I think the better argument to make is just one of simplicity;
>> > separating the Unicode data table from the kernel adds complexity.  It
>> > also reduces flexibility, since for use cases where it's actually
>> > _preferable_ to have Unicode functionality permanently built-in the
>> > kernel, we now force the use of some kind of initial ramdisk to load a
>> > module before the root file system (which might require Unicode
>> > support) could even be mounted.
>> 
>> FWIW, embedding FW images to the kernel is also well supported.  Making
>> the data trie a firmware doesn't make a ramdisk more of a requirement
>> than the module solution, I think.
>
> I don't think we support building firmware directly into the kernel
> any more.  We used to, but IIRC, there was the feeling that 99.99% of
> the time, firmware modules were not GPL compliant, and so we ripped
> out that support.

Support is still there on 5.12. See
Documentation/driver-api/firmware/built-in-fw.rst.

Personally, I use this feature very often on my development workflow,
for similar reasons to what you said below. In my case, avoiding the
complexity of initramfs but still being able to use my crappy
FW-dependent NIC card to boot from NFS. :)

> compiled as a module, which is convenient for those use cases, such as
> for example a mobile handset --- where there is no need for modules
> since the hardware doesn't change, and so modules and an initrd is
> just unnecessary complexity --- and firmware, which would make an
> initial ramdisk mandatory if you wanted to use the casefold feature.
>
> Put another way, the only reason why putting the unicode tables in a
> module is to make life easier for desktop distros.  For mobile
> handsets, modules are an anti-feature, which is why there was no call
> for supporting this initially, given the initial use case for the
> casefold feature.

What about support for firmware generation from the kernel tree and
installation to /lib/firmware? With a module, I can just call
modules_install, and dealing with modules is hardcoded in the mind of
every kernel developer.  Dealing with firmwares inside the kernel tree
is not common, and I didn't find an equivalent Makefile rule to build
and deploy firmwares on a path that firmware_loader knows about.

I think of firmware as code/data for a device, while modules is for the
kernel domain, even if it is a gross oversimplification.  Are there
other examples of firmware built from the kernel tree that are meant
exclusively to be used by the kernel, without hardware involvement?

For mobile devices, it wouldn't really matter whether it is built-in or
a firmware, right?  On a controlled environment like Android, you know
what to expect of your filesystem, so you know beforehand if your kernel
needs the table loaded (apart from sd cards.  Do people use ext4 for
sdcards in Android or is it all exfat?).  In those scenarios, you gain
very little by not making it built-in.

-- 
Gabriel Krisman Bertazi
