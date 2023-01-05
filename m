Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9CC65E4B4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jan 2023 05:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjAEEh3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Jan 2023 23:37:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjAEEhZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Jan 2023 23:37:25 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8401F17074
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 Jan 2023 20:37:24 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id d127so29822753oif.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Jan 2023 20:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KzlzPB+YgVJM+mqLyWb7Jpzkio+HI4A/2g+wVfxujuw=;
        b=HAUXf7mFXIYyV1f5OEzSdpVvu5bdXzr58K/l4qp1Yc2Msh9HLv9LttHaBxSmF4/cWo
         gtxkyOBvweS0YhLASiqJgMuFgCFzR61gIEJtypv+rxN0J2rzJRR9jErM2WpLYsDjiwvg
         hrLmM7bFT3FHsZmBFARjPYaegUFokbflpMfX1srzqCKOdLxtzt22GpCB2eG9I1MGsjcT
         hv9rsSK84+irAv9P9Yu73p7VVoiTscxfgVyr2Ca2SZ50S6DHO+WrgSJR8hBTRwAKslWi
         9DQKWjj3CoQM8dF1TEOzljaDQdL1Bzf092vtOATl4kPyO1Yzl4+tzT1i27ONuxV+Qyw6
         Ymig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KzlzPB+YgVJM+mqLyWb7Jpzkio+HI4A/2g+wVfxujuw=;
        b=M+8nbz9Ac7bTeElf0KM1Z6TQeVjggFCStHaiLbDWPgjWe5oPFlo9c4yUdj3/tX3y80
         V0KDjrNMRzIz5FgwywlS1BYJiiujn8GDvGx976TXVmoj+wa5/r8/25m30UOS8gVgREED
         jxbfPePv0Cgaq5fUbCiTQHpJSCJoO0xMcFft+h6sQBaBWYlZkG5fNqaGYZcV4hKUr5dV
         8EfAveOUHZJy8QiTqeVQag1udwkaI7wPxhm7t2s/vfU26dUPo25V6ta10Rm3KYQei15x
         d1in3jh1Ry8QvBv23lFwNqOZGfTEAmoNNFLs7pZKFUsiGJZ8MXPWtc9WEk6h7RHbjPQX
         9HVQ==
X-Gm-Message-State: AFqh2kpH00yoa3swf8h0sunJ6ZLe8aaMT0W7f0sd3UqCylW0YxexivNs
        AnQDBVDWR84/BJaAmjaz/tauVA==
X-Google-Smtp-Source: AMrXdXue7tFNUtDrOkPpDiwYn1bRxxXc+X+xfON360+y/aa5P18aQdNRvj96yd6KXPWrG43yTWqQug==
X-Received: by 2002:a05:6808:19aa:b0:35e:de57:51ae with SMTP id bj42-20020a05680819aa00b0035ede5751aemr33258969oib.15.1672893443726;
        Wed, 04 Jan 2023 20:37:23 -0800 (PST)
Received: from smtpclient.apple (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id v142-20020acaac94000000b003549dde122fsm14980200oie.5.2023.01.04.20.37.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jan 2023 20:37:22 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [syzbot] [hfs?] WARNING in hfs_write_inode
From:   Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <2575F983-D170-4B79-A6BA-912D4ED2CC73@dubeyko.com>
Date:   Wed, 4 Jan 2023 20:37:16 -0800
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        syzbot <syzbot+7bb7cd3595533513a9e7@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        christian.brauner@ubuntu.com,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jeff Layton <jlayton@kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com,
        Matthew Wilcox <willy@infradead.org>,
        ZhangPeng <zhangpeng362@huawei.com>,
        linux-m68k@lists.linux-m68k.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <46F233BB-E587-4F2B-AA62-898EB46C9DCE@dubeyko.com>
References: <000000000000dbce4e05f170f289@google.com>
 <5f45bb9a-5e00-48dd-82b0-46b19b1b98a3@app.fastmail.com>
 <CAHk-=wi8XyAUF9_z6-oa4Ava6PVZeE-=TVNcFK1puQHpOtqLLw@mail.gmail.com>
 <ab7a9477-ddc7-430f-b4ee-c67251e879b0@app.fastmail.com>
 <2575F983-D170-4B79-A6BA-912D4ED2CC73@dubeyko.com>
To:     Arnd Bergmann <arnd@arndb.de>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Jan 4, 2023, at 4:36 PM, Viacheslav Dubeyko <slava@dubeyko.com> =
wrote:
>=20
> Hi Arnd,
>=20
>> On Jan 4, 2023, at 2:33 PM, Arnd Bergmann <arnd@arndb.de> wrote:

<skipped>

>>>=20
>>> Something like this ENTIRELY UNTESTED patch?
>>>=20
>>> Do we have anybody who looks at hfs?
>>=20
>> Adding Viacheslav Dubeyko to Cc, he's at least been reviewing
>> patches for HFS and HFS+ somewhat recently. The linux-m68k
>> list may have some users dual-booting old MacOS.
>>=20
>> Viacheslav, see the start of the thread at
>> https://lore.kernel.org/lkml/000000000000dbce4e05f170f289@google.com/
>>=20
>=20
> Let me take a look into the issue.
>=20

As far as I can see, I cannot reproduce the issue for newly created HFS =
volume
with simple operation of creation of several files of 4MB in size. The =
sync_fs
operation definitely calls hfs_write_inode() method. But I don't see =
such issue.

The hfs_write_inode() allocates struct hfs_find_data fd variable on =
stack
(fs/hfs/inode.c:426). The fd.entrylength is initialized in =
__hfs_brec_find()
(fs/hfs/bfind.c:100). Technically, fd->entrylength =3D len - keylen can =
introduce
overflow. But, such issue can take place for corrupted volume. Internal =
logic
error should result with returning error by hfs_brec_find =
(fs/hfs/inode.c:466):

if (hfs_brec_find(&fd))
     /* panic? */
     goto out;

And, finally, logic should end without going into the issue.

Also, as far as I can see, available volume in report (mount_0.gz) =
somehow corrupted already:

sudo losetup /dev/loop20 ./mount_0
sudo fsck.hfs -d /dev/loop20
** /dev/loop20
Using cacheBlockSize=3D32K cacheTotalBlock=3D1024 cacheSize=3D32768K.
** Checking HFS volume.
hfs_swap_BTNode: record #1 invalid offset (0xFFF8)
   Invalid node structure
(3, 0)
   Invalid B-tree node size
(3, 0)
** Volume check failed.
volume check failed with error 7=20
volume type is HFS=20
primary MDB is at block 2 0x02=20
alternate MDB is at block 62 0x3e=20
primary VHB is at block 0 0x00=20
alternate VHB is at block 0 0x00=20
sector size =3D 512 0x200=20
VolumeObject flags =3D 0x19=20
total sectors for volume =3D 64 0x40=20
total sectors for embedded volume =3D 0 0x00

So, HFS volume corruption had happened somehow earlier.
The reported issue is only a side effect of volume corruption.
The real issue of HFS volume corruption had taken place before.
And it was a silent issue somehow.

Finally, I don=E2=80=99t see any issue with WARN_ON() in =
fs/hfs/inode.c:489.
If we have some issue, then it could happen in b-tree logic or
HFS volume was corrupted somehow else. But available report doesn=E2=80=99=
t
provide any hint what could be wrong during testing.

Thanks,
Slava.


