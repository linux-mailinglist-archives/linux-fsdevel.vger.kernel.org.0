Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608106A33E5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Feb 2023 21:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjBZUQo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Feb 2023 15:16:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBZUQn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Feb 2023 15:16:43 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F16714E8E
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Feb 2023 12:16:42 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id qa18-20020a17090b4fd200b0023750b675f5so8036871pjb.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Feb 2023 12:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JRygPWuFB5jpxgCDeu/k/O7jLoxofffpwNYn7bW41qM=;
        b=FyaKusYjm8nVUXJJnn20es6xKbhk81hTUHRRkxs+zZnJFb74PJG6yisvk6NfvOwA3h
         VVDQJWvcW+9J+HEoCygQJErQrwmNccYRtlCMflt8Yzlehly+UJbo2yjxQnZithjwegmo
         WobAAoGIKj6qBK8tnRIPaz6BERL9IEFLEX3277zTnggG/hn1y1hIWeVpl2yv2PeDnADE
         mqFzmmhZBzeNf9NkueHvkI2JGmap+f74mvM9WK1qPkR8SRn4hL7FnujY3X9An0Vo3A0L
         JAW9VD7PoBq9z0sCyCOFA9+mkyd+pIESb5Bgf//+rICR4BB5U2y9SHdX+IkXj9epNML9
         C/mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JRygPWuFB5jpxgCDeu/k/O7jLoxofffpwNYn7bW41qM=;
        b=Amy6bDke3bqBXhhL2KmjHDRBqMZ7Qq9dRlXmNRJjgjcXHqY4Kseg/D3UdrGqymXONC
         Hg5VooZBnU4L2MGnOu38XidYKhfjYpwZqvrofK+iQ37OZXRzmLW3c01a+YAhT4JTPXB+
         5+88Co1vdtROIlmHyj0h3aP5RD3uLEF6FkAnClkdG6ppmH0Ct910X0qOf1CItV+PE3xI
         zSXmw+58I0Z6LsFxZnKnj8axVDjSeE6ie/CCmSLnXnQ5mku+A4h+FtJyey1yaSjqwirv
         Bokyp/yxlmimr5n4QQ6WNAq09nPEg1klKHuIE39Zj8AjPMmUCETHcfBqMXrw1DeBumzN
         CLiA==
X-Gm-Message-State: AO0yUKVnX7v7RYFUv1yvIhh7qwuIHoY1QW9fnyoo22shj5nrpZES2KAz
        aU/qHJoTATZi2RpgnuzIIKc=
X-Google-Smtp-Source: AK7set+Oj1MU13hNbJ3Cl5GNxRd137HkwL16onsIV+yXxkaAAi/2T0VIBzPrzttCSP5Xg8BeGmgq2Q==
X-Received: by 2002:a05:6a20:690b:b0:cb:cd69:48d2 with SMTP id q11-20020a056a20690b00b000cbcd6948d2mr18632791pzj.30.1677442602035;
        Sun, 26 Feb 2023 12:16:42 -0800 (PST)
Received: from rh-tp ([2406:7400:63:469f:eb50:3ffb:dc1b:2d55])
        by smtp.gmail.com with ESMTPSA id y18-20020aa78052000000b005a8aab9ae7esm2801906pfm.216.2023.02.26.12.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 12:16:41 -0800 (PST)
Date:   Mon, 27 Feb 2023 01:46:23 +0530
Message-Id: <87ttz889ns.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        lsf-pc@lists.linux-foundation.org,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>,
        "kbus @imap.suse.de>> Keith Busch" <kbusch@kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: LSF/MM/BPF 2023 IOMAP conversion status update
In-Reply-To: <20230208160422.m4d4rx6kg57xm5xk@quack3>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jan Kara <jack@suse.cz> writes:

> On Sun 29-01-23 05:06:47, Matthew Wilcox wrote:
>> On Sat, Jan 28, 2023 at 08:46:45PM -0800, Luis Chamberlain wrote:
>> > I'm hoping this *might* be useful to some, but I fear it may leave quite
>> > a bit of folks with more questions than answers as it did for me. And
>> > hence I figured that *this aspect of this topic* perhaps might be a good
>> > topic for LSF.  The end goal would hopefully then be finally enabling us
>> > to document IOMAP API properly and helping with the whole conversion
>> > effort.
>>
>> +1 from me.

+1 from my end as well please.

Currently I have also been working on adding subpage size dirty tracking
support to iomap layer so that we don't have the write amplification
problem in case of buffered writes for bs < ps systems [1].
This also improves the performance including in some real world usecases
like postgres db workload.

Now there are some further points that we would like to discuss
on how to optimize/improve iomap dirty bitmap tracking for large folios.
I can try to come up with some ideas in that regard so that we can
discuss about these as well with others [2]

[1]: https://lore.kernel.org/all/cover.1677428794.git.ritesh.list@gmail.com/
[2]: https://lore.kernel.org/all/20230130210113.opdvyliooizicrsk@rh-tp/

>>
>> I've made a couple of abortive efforts to try and convert a "trivial"
>> filesystem like ext2/ufs/sysv/jfs to iomap, and I always get hung up on
>> what the semantics are for get_block_t and iomap_begin().
>
> Yeah, I'd be also interested in this discussion. In particular as a
> maintainer of part of these legacy filesystems (ext2, udf, isofs).
>
>> > Perhaps fs/buffers.c could be converted to folios only, and be done
>> > with it. But would we be loosing out on something? What would that be?
>>
>> buffer_heads are inefficient for multi-page folios because some of the
>> algorthims are O(n^2) for n being the number of buffers in a folio.
>> It's fine for 8x 512b buffers in a 4k page, but for 512x 4kb buffers in
>> a 2MB folio, it's pretty sticky.  Things like "Read I/O has completed on
>> this buffer, can I mark the folio as Uptodate now?"  For iomap, that's a
>> scan of a 64 byte bitmap up to 512 times; for BHs, it's a loop over 512
>> allocations, looking at one bit in each BH before moving on to the next.
>> Similarly for writeback, iirc.
>>
>> So +1 from me for a "How do we convert 35-ish block based filesystems
>> from BHs to iomap for their buffered & direct IO paths".  There's maybe a
>> separate discussion to be had for "What should the API be for filesystems
>> to access metadata on the block device" because I don't believe the
>> page-cache based APIs are easy for fs authors to use.
>
> Yeah, so the actual data paths should be relatively easy for these old
> filesystems as they usually don't do anything special (those that do - like
> reiserfs - are deprecated and to be removed). But for metadata we do need
> some convenience functions like - give me block of metadata at this block
> number, make it dirty / clean / uptodate (block granularity dirtying &
> uptodate state is absolute must for metadata, otherwise we'll have data
> corruption issues). From the more complex functionality we need stuff like:
> lock particular block of metadata (equivalent of buffer lock), track that
> this block is metadata for given inode so that it can be written on
> fsync(2). Then more fancy filesystems like ext4 also need to attach more
> private state to each metadata block but that needs to be dealt with on
> case-by-case basis anyway.
>
>> Maybe some related topics are
>> "What testing should we require for some of these ancient filesystems?"
>> "Whose job is it to convert these 35 filesystems anyway, can we just
>> delete some of them?"
>
> I would not certainly miss some more filesystems - like minix, sysv, ...
> But before really treatening to remove some of these ancient and long
> untouched filesystems, we should convert at least those we do care about.
> When there's precedent how simple filesystem conversion looks like, it is
> easier to argue about what to do with the ones we don't care about so much.
>
>> "Is there a lower-performance but easier-to-implement API than iomap
>> for old filesystems that only exist for compatibiity reasons?"
>
> As I wrote above, for metadata there ought to be something as otherwise it
> will be real pain (and no gain really). But I guess the concrete API only
> matterializes once we attempt a conversion of some filesystem like ext2.
> I'll try to have a look into that, at least the obvious preparatory steps
> like converting the data paths to iomap.

I have worked in past with Jan and others on adding iomap support to DIO
for ext4. I have also added fiemap, bmap and swap operations to move to iomap
for ext4 and I would like to continue working in this direction for
making ext4 completely switch to iomap (including the buffered-io path).

I would definitely like to convert ext2 to iomap (work along with you on
this of course :)). This in my opinion too, can help us figure
out whether iomap requires any changes so as to support ext* family of
filesystem specially for buffered io path. This IMO is simpler then to
start with ext4 buffered-io path which makes fscrypt, fsverity etc.
get in our way...

Let me also take a look at this and get back to you. At first I will get
started with ext2 DIO path (which I think should be very straight
forward, since we already have iomap_ops for DAX in ext2). While at it,
I will also see what is required for the buffered I/O path conversion.

[3]: https://lore.kernel.org/all/?q=s%3Aiomap+and+f%3Aritesh

-ritesh
