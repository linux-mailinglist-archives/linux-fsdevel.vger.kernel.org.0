Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0BE31A874
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2019 18:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbfEKQeP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 May 2019 12:34:15 -0400
Received: from mail.stbuehler.de ([5.9.32.208]:53128 "EHLO mail.stbuehler.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726775AbfEKQeP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 May 2019 12:34:15 -0400
Received: from [IPv6:2a02:8070:a29c:5000:823f:5dff:fe0f:b5b6] (unknown [IPv6:2a02:8070:a29c:5000:823f:5dff:fe0f:b5b6])
        by mail.stbuehler.de (Postfix) with ESMTPSA id 896B8C00A01;
        Sat, 11 May 2019 16:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=stbuehler.de;
        s=stbuehler1; t=1557592452;
        bh=F6SxG6GWQv/W/0uxngbHdi9LydCZszxlQZFk4fr952I=;
        h=Subject:From:To:References:Date:In-Reply-To:From;
        b=VAcqgmKWh2irzDrDWZroK7ydhiy3jA8O1EEjbk4y5neoDW8nCXm/q+xwccPoETTyW
         sy9hJY7p5ZJaG/+z3WR72etr0nDIyQaknp4mddMADpv4QXsVT6v4q3JXpPjML1LU3P
         zNRaoNNG1FY3TLqXviOspoQw1rPGlCNJlqSSDNkc=
Subject: Re: io_uring: O_NONBLOCK/IOCB_NOWAIT/RWF_NOWAIT mess
From:   =?UTF-8?Q?Stefan_B=c3=bchler?= <source@stbuehler.de>
To:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <366484f9-cc5b-e477-6cc5-6c65f21afdcb@stbuehler.de>
 <37071226-375a-07a6-d3d3-21323145de71@kernel.dk>
 <a60b2461-1db0-32cf-6eb2-35f7751a04ec@stbuehler.de>
Openpgp: preference=signencrypt
Message-ID: <e2bf63a3-703b-9be2-c171-5dcc1797d2b1@stbuehler.de>
Date:   Sat, 11 May 2019 18:34:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <a60b2461-1db0-32cf-6eb2-35f7751a04ec@stbuehler.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

I am a little bit disappointed that this seems to get ignored.

I will reply to this mail with some patches, but I really think someone
with a deeper understanding needs to think this through.

If there were some clear documentation/specification how those flags are
supposed to work (especially in combination) it would be much easier to
tell what is broken and how to fix it...

cheers,
Stefan

On 28.04.19 17:54, Stefan Bühler wrote:
> Hi,
> 
> On 23.04.19 22:31, Jens Axboe wrote:
>> On 4/23/19 1:06 PM, Stefan Bühler wrote:
>>> 2. {read,write}_iter and FMODE_NOWAIT / IOCB_NOWAIT is broken at the vfs
>>> layer: vfs_{read,write} should set IOCB_NOWAIT if O_NONBLOCK is set when
>>> they call {read,write}_iter (i.e. init_sync_kiocb/iocb_flags needs to
>>> convert the flag).
>>>
>>> And all {read,write}_iter should check IOCB_NOWAIT instead of O_NONBLOCK
>>> (hi there pipe.c!), and set FMODE_NOWAIT if they support IOCB_NOWAIT.
>>>
>>> {read,write}_iter should only queue the IOCB though if is_sync_kiocb()
>>> returns false (i.e. if ki_callback is set).
>>
>> That's a trivial fix. I agree that it should be done.
> 
> Doesn't look trivial to me.
> 
> Various functions take rwf_t flags, e.g. do_readv, which is called with
> 0 from readv and with flags from userspace in preadv2.
> 
> Now is preadv2() supposed to be non-blocking if the file has O_NONBLOCK,
> or only if RWF_NOWAIT was passed?
> 
> Other places seem (at least to me) explicitly mean "please block" if
> they don't pass RWF_NOWAIT, e.g. ovl_read_iter from fs/overlayfs, which
> uses ovl_iocb_to_rwf to convert iocb flags back to rwf.
> 
> Imho the clean way is to ignore O_NONBLOCK when there are rwf_t flags;
> e.g. kiocb_set_rw_flags should unset IOCB_NOWAIT if RWF_NOWAIT was not set.
> 
> But then various functions (like readv) will need to create rwf_t
> "default" flags from a file (similar to iocb_flags) instead of using 0.
> And ovl_iocb_to_rwf should probably be used in more places as well.
> 
> There is also generic_file_splice_read, which should use
> SPLICE_F_NONBLOCK to trigger IOCB_NOWAIT; again it is unclear whether
> O_NONBLOCK should trigger IOCB_NOWAIT too (do_sendfile explicitly does
> NOT with a "need to debate" comment).
> 
> 
> I don't think I'm the right person to do this - I think it requires a
> deeper understanding of all the code involved.
> 
> I do have patches for pipe.c and and socket.c to ignore O_NONBLOCK, use
> IOCB_NOWAIT and set FMODE_NOAWAIT after the fs part is ready.
> 
> cheers,
> Stefan
> 
