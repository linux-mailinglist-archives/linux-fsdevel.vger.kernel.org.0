Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEDFB763D99
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 19:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjGZRX4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 13:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjGZRXz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 13:23:55 -0400
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2BC1BC1
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 10:23:53 -0700 (PDT)
Date:   Wed, 26 Jul 2023 17:23:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spawn.link;
        s=protonmail2; t=1690392230; x=1690651430;
        bh=xht0eNWiq91QqwjoETUuyoeUTJAOT+E+Nv0Zqu3eDMI=;
        h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=ghDddWh5ZraQzHYL5jj/f1p7VdtBQDLUuSYJQyxvWCa0Ib3B2YftOvHSrEL9XgMeb
         1A2qoRQgFE1E8CZy1wofnPA1fCZHT9mvCxu3B+m+noP8zG/z3eGILA/qOunvJrTuEB
         j0luuniDPYHXeqsCw3v85R+5Bxh4P7VpuKyg7YQkXvRU0sCZU/4CNiqosbxfhPGgPp
         eU9nvZNphOBYqnwXDnwl8gLqSdnjv8NOnBZtSxc89Zkcxecy5uTDB+FxZTbgwjYXv8
         VCYgKavP2RYiqkvcOkQLOvMoLFxSOiSQA7QIywByOm5knjrdJbFpQxAjE5jG6+2xL2
         b82yPTSdVZMew==
To:     Bernd Schubert <bernd.schubert@fastmail.fm>,
        Jaco Kroon <jaco@uls.co.za>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Antonio SJ Musumeci <trapexit@spawn.link>
Subject: Re: [PATCH] fuse: enable larger read buffers for readdir.
Message-ID: <831e5a03-7126-3d45-2137-49c1a25769df@spawn.link>
In-Reply-To: <0731f4b9-cd4e-2cb3-43ba-c74d238b824f@fastmail.fm>
References: <20230726105953.843-1-jaco@uls.co.za> <b5255112-922f-b965-398e-38b9f5fb4892@fastmail.fm> <7d762c95-e4ca-d612-f70f-64789d4624cf@uls.co.za> <0731f4b9-cd4e-2cb3-43ba-c74d238b824f@fastmail.fm>
Feedback-ID: 55718373:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/26/23 10:45, Bernd Schubert wrote:
>
> On 7/26/23 17:26, Jaco Kroon wrote:
>> Hi,
>>
>> On 2023/07/26 15:53, Bernd Schubert wrote:
>>>
>>> On 7/26/23 12:59, Jaco Kroon wrote:
>>>> Signed-off-by: Jaco Kroon <jaco@uls.co.za>
>>>> ---
>>>>  =C2=A0 fs/fuse/Kconfig=C2=A0=C2=A0 | 16 ++++++++++++++++
>>>>  =C2=A0 fs/fuse/readdir.c | 42 ++++++++++++++++++++++++---------------=
---
>>>>  =C2=A0 2 files changed, 40 insertions(+), 18 deletions(-)
>>>>
>>>> diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
>>>> index 038ed0b9aaa5..0783f9ee5cd3 100644
>>>> --- a/fs/fuse/Kconfig
>>>> +++ b/fs/fuse/Kconfig
>>>> @@ -18,6 +18,22 @@ config FUSE_FS
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 If you want to develop a u=
serspace FS, or if you want to use
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a filesystem based on FUSE=
, answer Y or M.
>>>>  =C2=A0 +config FUSE_READDIR_ORDER
>>>> +=C2=A0=C2=A0=C2=A0 int
>>>> +=C2=A0=C2=A0=C2=A0 range 0 5
>>>> +=C2=A0=C2=A0=C2=A0 default 5
>>>> +=C2=A0=C2=A0=C2=A0 help
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 readdir performance varies=
 greatly depending on the size of
>>>> the read.
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Larger buffers results in =
larger reads, thus fewer reads and
>>>> higher
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 performance in return.
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 You may want to reduce thi=
s value on seriously constrained
>>>> memory
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 systems where 128KiB (assu=
ming 4KiB pages) cache pages is
>>>> not ideal.
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This value reprents the or=
der of the number of pages to
>>>> allocate (ie,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the shift value).=C2=A0 A =
value of 0 is thus 1 page (4KiB) where
>>>> 5 is 32
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pages (128KiB).
>>>> +
>>> I like the idea of a larger readdir size, but shouldn't that be a
>>> server/daemon/library decision which size to use, instead of kernel
>>> compile time? So should be part of FUSE_INIT negotiation?
>> Yes sure, but there still needs to be a default.=C2=A0 And one page at a=
 time
>> doesn't cut it.
> With FUSE_INIT userspace would make that decision, based on what kernel
> fuse suggests? process_init_reply() already handles other limits - I
> don't see why readdir max has to be compile time option. Maybe a module
> option to set the limit?
>
> Thanks,
> Bernd

I had similar question / comment. This seems to me to be more=20
appropriately handed by the server via FUSE_INIT.

And wouldn't "max" more easily be FUSE_MAX_MAX_PAGES? Is there a reason=20
not to allow upwards of 256 pages sized readdir buffer?


