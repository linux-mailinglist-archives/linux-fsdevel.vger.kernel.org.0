Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2C04C6F15
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Feb 2022 15:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234711AbiB1OP2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Feb 2022 09:15:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233953AbiB1OP0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Feb 2022 09:15:26 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33CB434B9;
        Mon, 28 Feb 2022 06:14:47 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id i27so13041430vsr.10;
        Mon, 28 Feb 2022 06:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=M1Xyh9NeSOMFmMurlKuwWO89EOwaqEp9Ci8MZPOB7hg=;
        b=aQVW5042c5kAuETKVfsgRwNQXwFLB2EOUw37B2jdhKR7o/b35p0/5pjBOAa3Evio9u
         0CKaT22JWbf1+YCaL9BYHd/pyi2LcGM+anIrkYOFAXzk8Oa0WKSC83op6Kw8pXS+XJ8F
         Xgx5n0pcvamDUkYx9VzPY02oHqMlfTq0ystCiJ/BvsToPA3doyOtjQ0BB0//FHofwP5w
         tUNdmGeiITmXVx8YdSWKdt/bcfpz7DDm/U4sBTkgoGLbp0j8TxRLKtT9lsyPHeFv6Zlk
         a/KytG5og6cw24Aw2pvbug3P2FOtiGNdqeWO10DNdyXyB+jqJhPGVPqmgWIOTh0ljKLp
         I6zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=M1Xyh9NeSOMFmMurlKuwWO89EOwaqEp9Ci8MZPOB7hg=;
        b=ykT+3Tcs2RN1vHlDbXoe/lq/JKbLgYX860mLNuFxxsae2nHyHBpoFxSv4DZ5jyS48H
         A6xpAuEfhu5e7YwrSGcAiF0iguIh3djIqHv6vacF3EBAejyanhDVLagEjNEsXihJkvVI
         8/J/8qSzWIQbASprOB7dWaP04zfvBlEVcya6y2kw9QMoc0jWTKJn3zTGTwikR52M5p/y
         vlSW4RL+2chIvl8/tuezljXQWLvG57OJIipmK8MxKgtTiTSchXwWdBxMSQMdzQzD/IvP
         YC3rVC1t21Qi0hVOCeFN2NkBoLGS6IoOsiR2OYpeNzQOkX7+XdLF0+eq9UrRAGIpUlnh
         LoXQ==
X-Gm-Message-State: AOAM53342MJy9PoVScbgy4WOqoSiLJvMX8Ti+5g1m/CUu0tR9TKATqYB
        JfA7a53V22elwiq25M1YyuvkgAWRigjCU11slvs=
X-Google-Smtp-Source: ABdhPJyzyJR+BDDAskg9D/cVOfI18uOQsM5+pRk3fyetFPg9yXUsjjt1l97iFK0dT6JkS678hbJrWQ73y6pWFZ/+8c4=
X-Received: by 2002:a05:6102:418a:b0:31a:1d33:6803 with SMTP id
 cd10-20020a056102418a00b0031a1d336803mr7784558vsb.40.1646057686549; Mon, 28
 Feb 2022 06:14:46 -0800 (PST)
MIME-Version: 1.0
References: <164311902471.2806745.10187041199819525677.stgit@warthog.procyon.org.uk>
 <164311919732.2806745.2743328800847071763.stgit@warthog.procyon.org.uk>
 <CACdtm0YtxAUMet_PSxpg69OR9_TQbMQOzU5Kbm_5YDe_C7Nb-w@mail.gmail.com> <3013921.1644856403@warthog.procyon.org.uk>
In-Reply-To: <3013921.1644856403@warthog.procyon.org.uk>
From:   Rohith Surabattula <rohiths.msft@gmail.com>
Date:   Mon, 28 Feb 2022 19:44:35 +0530
Message-ID: <CACdtm0Z4zXpbPBLJx-=AgBRd63hp_n+U-5qc0gQDQW0c2PY7gg@mail.gmail.com>
Subject: Re: [RFC PATCH 7/7] cifs: Use netfslib to handle reads
To:     David Howells <dhowells@redhat.com>
Cc:     smfrench@gmail.com, nspmangalore@gmail.com, jlayton@kernel.org,
        linux-cifs@vger.kernel.org, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi David,

Below is the trace o/p when mounted with fsc option:
              vi-1631    [000] .....  2519.247539: netfs_read:
R=3D00000006 READAHEAD c=3D00000000 ni=3D0 s=3D0 1000
              vi-1631    [000] .....  2519.247540: netfs_read:
R=3D00000006 EXPANDED  c=3D00000000 ni=3D0 s=3D0 1000
              vi-1631    [000] .....  2519.247550: netfs_sreq:
R=3D00000006[0] PREP  DOWN f=3D00 s=3D0 0/100000 e=3D0
              vi-1631    [000] .....  2519.247551: netfs_sreq:
R=3D00000006[0] SUBMT DOWN f=3D00 s=3D0 0/100000 e=3D0
           cifsd-1390    [001] .....  2519.287542: netfs_sreq:
R=3D00000006[0] TERM  DOWN f=3D02 s=3D0 100000/100000 e=3D0
           cifsd-1390    [001] .....  2519.287545: netfs_rreq:
R=3D00000006 ASSESS f=3D20
           cifsd-1390    [001] .....  2519.287545: netfs_rreq:
R=3D00000006 UNLOCK f=3D20
           cifsd-1390    [001] .....  2519.287571: netfs_rreq:
R=3D00000006 DONE   f=3D00
           cifsd-1390    [001] .....  2519.287572: netfs_sreq:
R=3D00000006[0] FREE  DOWN f=3D02 s=3D0 100000/100000 e=3D0
           cifsd-1390    [001] .....  2519.287573: netfs_rreq:
R=3D00000006 FREE   f=3D00

Mount :
root@netfsvm:/sys/kernel/debug/tracing# sudo mount -t cifs
//netfsstg.file.core.windows.net/testshare on /mnt/testshare type cifs
(rw,relatime,vers=3D3.0,cache=3Dstrict,username=3Dnetfsstg,uid=3D0,noforceu=
id,gid=3D0,noforcegid,addr=3D52.239.170.72,file_mode=3D0777,dir_mode=3D0777=
,soft,persistenthandles,nounix,serverino,mapposix,fsc,rsize=3D1048576,wsize=
=3D1048576,bsize=3D1048576,echo_interval=3D60,actimeo=3D1)

I dont see writing fscache. It always downloads from the server.

root@netfsvm:/sys/kernel/debug/tracing# ps -A | grep cache
    450 ?        00:00:00 mkey_cache
   1361 ?        00:00:00 cachefilesd

root@netfsvm:/sys/kernel/debug/tracing# cat /proc/fs/fscache/stats
FS-Cache statistics
Cookies: n=3D29 v=3D1 vcol=3D0 voom=3D0
Acquire: n=3D29 ok=3D29 oom=3D0
LRU    : n=3D0 exp=3D0 rmv=3D0 drp=3D0 at=3D0
Invals : n=3D0
Updates: n=3D0 rsz=3D0 rsn=3D0
Relinqs: n=3D0 rtr=3D0 drop=3D0
NoSpace: nwr=3D0 ncr=3D0 cull=3D0
IO     : rd=3D0 wr=3D0
RdHelp : DR=3D0 RA=3D6 RP=3D0 WB=3D0 WBZ=3D7 rr=3D0 sr=3D0
RdHelp : ZR=3D0 sh=3D0 sk=3D7
RdHelp : DL=3D6 ds=3D6 df=3D0 di=3D0
RdHelp : RD=3D0 rs=3D0 rf=3D0
RdHelp : WR=3D0 ws=3D0 wf=3D0

root@netfsvm:/sys/kernel/debug/tracing# cat /proc/fs/fscache/cookies
COOKIE   VOLUME   REF ACT ACC S FL DEF
=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D =3D=3D=3D =3D=
=3D=3D =3D =3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
00000002 00000001   1   0   0 - 4008 302559bec76a7924,
0a13e961000000000a13e96100000000d01f4719d01f4719
00000003 00000001   1   0   0 - 4000 0000000000640090,
37630162000000003763016200000000e8650f119c49f411
00000004 00000001   1   0   0 - 4000 00000000001800f0,
244e016200000000244e01620000000044975123c042f525
00000005 00000001   1   0   0 - 4000 00000000007000a0,
ea92e96100000000ea92e96100000000acee2035acee2035
00000006 00000001   1   0   0 - 4000 00000000007000c0,
ad92e96100000000ad92e96100000000407da317407da317
00000007 00000001   1   0   0 - 4000 00000000002800e0,
4aeaf361000000004aeaf3610000000078c77b0d6850dc1f
00000008 00000001   1   0   0 - 4008 0000000000140080,
df92136200000000df92136200000000b8e0f30eb8e0f30e
00000009 00000001   1   0   0 - 4008 00000000001400e0,
d39d136200000000d39d136200000000f4e6e51bf4e6e51b
0000000a 00000001   1   0   0 - 4008 0000000000140090,
d99d136200000000d99d136200000000dcd77d28dcd77d28
0000000b 00000001   1   0   0 - 4008 0000000000540080,
cdd21c6200000000cdd21c62000000009c8cd90c9c8cd90c
0000000c 00000001   1   0   0 - 4008 00000000005400c0,
cdd21c6200000000cdd21c6200000000f44b440df44b440d
0000000d 00000001   1   0   0 - 4008 00000000005400a0,
cdd21c6200000000cdd21c62000000005487b50f5487b50f
0000000e 00000001   1   0   0 - 4008 00000000005400e0,
ebd21c6200000000ebd21c6200000000c07c1800c07c1800
0000000f 00000001   1   0   0 - 4008 0000000000540090,
ebd21c6200000000ebd21c620000000094fc730094fc7300
00000010 00000001   1   0   0 - 4008 00000000005400d0,
ebd21c6200000000ebd21c6200000000bcb78902bcb78902
00000011 00000001   1   0   0 - 4008 00000000005400b0,
29d31c620000000029d31c62000000002c02e8252c02e825
00000012 00000001   1   0   0 - 4008 00000000005400f0,
29d31c620000000029d31c6200000000c83fae26c83fae26
00000013 00000001   1   0   0 - 4008 0000000000540088,
29d31c620000000029d31c6200000000e4fcc328e4fcc328
00000014 00000001   1   0   0 - 4008 00000000005400c8,
3bd31c62000000003bd31c6200000000747b780b747b780b
00000015 00000001   1   0   0 - 4008 00000000005400a8,
3bd31c62000000003bd31c6200000000ecf57e0decf57e0d
00000016 00000001   1   0   0 - 4008 00000000005400e8,
b0d51c6200000000b0d51c62000000002005e5092005e509
00000017 00000001   1   0   0 - 4008 0000000000540098,
b0d51c6200000000b0d51c620000000034035f0a34035f0a
00000018 00000001   1   0   0 - 4008 00000000005400d8,
b0d51c6200000000b0d51c62000000001cfdc00c1cfdc00c
00000019 00000001   1   0   0 - 4008 00000000005400b8,
50d61c620000000050d61c62000000004453d0384453d038
0000001a 00000001   1   0   0 - 4008 00000000005400f8,
50d61c620000000050d61c6200000000d4113b39d4113b39
0000001b 00000001   1   0   0 - 4008 0000000000540084,
51d61c620000000051d61c62000000002042020020420200
0000001c 00000001   1   0   0 - 4008 00000000005400c4,
16d71c620000000016d71c62000000009ceb0d019ceb0d01
0000001d 00000001   1   0   0 - 4008 00000000005400a4,
16d71c620000000016d71c6200000000dcae7801dcae7801
0000001e 00000001   1   0   0 - 4008 00000000005400e4,
16d71c620000000016d71c6200000000ec2af903ec2af903

I have enabled below fscache and cachefiles related tracepoints. But
nothing is getting printed in trace o/p.
echo 1 >/sys/kernel/debug/tracing/events/fscache/fscache_access/enable
echo 1 >/sys/kernel/debug/tracing/events/fscache/fscache_active/enable
echo 1 >/sys/kernel/debug/tracing/events/cachefiles/cachefiles_coherency/en=
able
echo 1 >/sys/kernel/debug/tracing/events/cachefiles/cachefiles_read/enable
echo 1 >/sys/kernel/debug/tracing/events/cachefiles/cachefiles_write/enable
echo 1 >/sys/kernel/debug/tracing/events/cachefiles/cachefiles_io_error/ena=
ble
echo 1 >/sys/kernel/debug/tracing/events/cachefiles/cachefiles_vfs_error/en=
able
echo 1 > events/cachefiles/cachefiles_vol_coherency/enable

Regards,
Rohith

On Mon, Feb 14, 2022 at 10:03 PM David Howells <dhowells@redhat.com> wrote:
>
> Rohith Surabattula <rohiths.msft@gmail.com> wrote:
>
> > I have tested netfs integration with fsc mount option enabled. But, I
> > observed function "netfs_cache_prepare_read" always returns
> > "NETFS_DOWNLOAD_FROM_SERVER" because cres->ops(i.e cachefiles
> > operations) is not set.
>
> I see it download from the server and write to the cache:
>
>         # cat /proc/fs/fscache/stats
>         ...
>         IO     : rd=3D0 wr=3D4     <---- no reads, four writes made
>         RdHelp : DR=3D0 RA=3D4 RP=3D0 WB=3D0 WBZ=3D0 rr=3D0 sr=3D0
>         RdHelp : ZR=3D0 sh=3D0 sk=3D0
>         RdHelp : DL=3D4 ds=3D4 df=3D0 di=3D0
>         RdHelp : RD=3D0 rs=3D0 rf=3D0
>         RdHelp : WR=3D4 ws=3D4 wf=3D0
>
> Turning on the cachefiles_vol_coherency tracepoint, I see:
>
>      kworker/2:2-1040    [002] .....   585.499799: cachefiles_vol_coheren=
cy: V=3D00000003 VOL BAD cmp  B=3D480004
>      kworker/2:2-1040    [002] .....   585.499872: cachefiles_vol_coheren=
cy: V=3D00000003 VOL SET ok   B=3D480005
>
> every time I unmount and mount again.  One of the fields is different eac=
h
> time.
>
> Using the netfs tracepoints, I can see the download being made from the s=
erver
> and then the subsequent write to the cache:
>
>           md5sum-4689    [003] .....   887.382290: netfs_read: R=3D000000=
05 READAHEAD c=3D0000004e ni=3D86 s=3D0 20000
>           md5sum-4689    [003] .....   887.383076: netfs_read: R=3D000000=
05 EXPANDED  c=3D0000004e ni=3D86 s=3D0 400000
>           md5sum-4689    [003] .....   887.383252: netfs_sreq: R=3D000000=
05[0] PREP  DOWN f=3D01 s=3D0 0/400000 e=3D0
>           md5sum-4689    [003] .....   887.383252: netfs_sreq: R=3D000000=
05[0] SUBMT DOWN f=3D01 s=3D0 0/400000 e=3D0
>            cifsd-4687    [002] .....   887.394926: netfs_sreq: R=3D000000=
05[0] TERM  DOWN f=3D03 s=3D0 400000/400000 e=3D0
>            cifsd-4687    [002] .....   887.394928: netfs_rreq: R=3D000000=
05 ASSESS f=3D22
>            cifsd-4687    [002] .....   887.394928: netfs_rreq: R=3D000000=
05 UNLOCK f=3D22
>     kworker/u8:4-776     [000] .....   887.395000: netfs_rreq: R=3D000000=
05 WRITE  f=3D02
>     kworker/u8:4-776     [000] .....   887.395005: netfs_sreq: R=3D000000=
05[0] WRITE DOWN f=3D03 s=3D0 400000/400000 e=3D0
>      kworker/3:2-1001    [003] .....   887.627881: netfs_sreq: R=3D000000=
05[0] WTERM DOWN f=3D03 s=3D0 400000/400000 e=3D0
>      kworker/3:2-1001    [003] .....   887.628163: netfs_rreq: R=3D000000=
05 DONE   f=3D02
>      kworker/3:2-1001    [003] .....   887.628165: netfs_sreq: R=3D000000=
05[0] FREE  DOWN f=3D03 s=3D0 400000/400000 e=3D0
>     kworker/u8:4-776     [000] .....   887.628216: netfs_rreq: R=3D000000=
05 FREE   f=3D02
>
> Can you mount a cifs share with "-o fsc", read a file and then look in
> /proc/fs/fscache/cookies and /proc/fs/fscache/stats for me?
>
> David
>
