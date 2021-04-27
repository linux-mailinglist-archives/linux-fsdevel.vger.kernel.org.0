Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72BEA36C849
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Apr 2021 17:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236510AbhD0PHY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Apr 2021 11:07:24 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60322 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235466AbhD0PHX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Apr 2021 11:07:23 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 8E3091F4262B
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
        <YIgkvjdrJPjeoJH7@mit.edu>
Date:   Tue, 27 Apr 2021 11:06:33 -0400
In-Reply-To: <YIgkvjdrJPjeoJH7@mit.edu> (Theodore Ts'o's message of "Tue, 27
        Apr 2021 10:50:38 -0400")
Message-ID: <87bl9z937q.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

"Theodore Ts'o" <tytso@mit.edu> writes:

> On Tue, Apr 27, 2021 at 03:39:15PM +0530, Shreeya Patel wrote:
>> > > Hence, make UTF-8 encoding loadable by converting it into a module and
>> > > also add built-in UTF-8 support option for compiling it into the
>> > > kernel whenever required by the filesystem.
>> > The way this is implemement looks rather awkward.
>
> I think that's a bit awkard is the trying to create an abstraction
> separation between the unicode and utf8 layers, just in case, at some
> point, we want fs/unicode to support more than just utf8.
>
> I think we're better off being opinionated here, and say that the only
> unicode encoding that will be supported by the kernel is UTF-8.
> Period.  In which case, we don't need to try to insert this unneeded
> abstraction layer.
>
> If you really want to make make fs/unicode support more than one
> encoding --- say, UTF-16LE, as used by NTFS --- at that point we can
> think about what the abstractions should look like.  For example, it
> doesn't _actually_ make sense for the data-trie structures to be part
> of the utf-8 encoding.  The normalization tables are for Unicode, and
> it wouldn't make sense for UTF-16 to have its own normalization
> tables, bloating the kernel even more.
>
> It *is* true that the normalization tables have been optimized for
> utf-8, because that's what the whole world actually uses; utf-16le is
> really a legacy use case.  So presumably, we would probably find a way
> to code up the utf-16 functions in a way that used the utf-8 data
> tables, even if it wasn't 100% optimal in terms of speed.
>
> But it's probably not worth it at this point.
>
>> > Given that the large memory usage is for a data table and not for code,
>> > why not treat is as a firmware blob and load it using request_firmware?
>> 
>> utf8 module not just has the data table but also has some kernel code.
>> The big part that we are trying to keep out of the kernel is a tree
>> structure that gets traversed based on a key that is the file name.
>> This is done when issuing a lookup in the filesystem, which has to be very
>> fast. So maybe it would not be so good to use request_firmware for
>> such a core feature.
>
> Speed really isn't a great argument here; the request_firmware is
> something that would only need to be done once, when a file system
> which requires Unicode normalization and/or case-folding is mounted.
>
> I think the better argument to make is just one of simplicity;
> separating the Unicode data table from the kernel adds complexity.  It
> also reduces flexibility, since for use cases where it's actually
> _preferable_ to have Unicode functionality permanently built-in the
> kernel, we now force the use of some kind of initial ramdisk to load a
> module before the root file system (which might require Unicode
> support) could even be mounted.

FWIW, embedding FW images to the kernel is also well supported.  Making
the data trie a firmware doesn't make a ramdisk more of a requirement
than the module solution, I think.

> The argument *for* making the Unicode table be a loadable firmware is
> that it might make it possible to upgrade to a newer version of
> Unicode without needing to do a kernel recompile.  On average, Unicode
> relases a new to support new character sets every year or so, or when
> there Japanese Emperor requiring a new reign name :-).  Usually the
> new character sets are for obscure ancient alphabets, and so it's
> really not a big deal if the kernel doesn't support, say,
> Chorasmian[1] or Dives Akuru[2].  Perhaps people would make a much
> bigger deal about new Emoji characters, or new code points for the
> Creative Commons symbols.  I'm personally not excited enough to claim
> that it's worth the extra complexity, but some people might think so.
> :-)

We don't really care about emojis since they are not usually
normalized/folded, and unless you are using strict mode, they will be
invisible for the user. On a unrelated note, newer scripts are more
interesting and we should come up with some update policy someday, since
we are already lagging the unicode spec.  At least we are still in the
Reiwa Era, which was first supported in 12.1 :)

>
> [1] used in Central Asia across Uzbekistan, Kazakhstan, and
> Turkmenistan to write an extinct Eastern Iranian language.
>
> [2] historically used in the Maldives until the 20th century.
>
> Of course, using those new Emoji symbols in file names would reduce
> portability of that file system if Strict Normalization was mandated.
> Fortunately, ext4 and f2fs don't enable strict normalizaation by
> default, which is also good, because it means if we don't have the
> latest Unicode update in the kernel, it doesn't really matter that
> much.... again, not worth the extra complexity/headache IMHO.

ah yes, exactly.

>
> Cheers,
>
> 					- Ted

-- 
Gabriel Krisman Bertazi
