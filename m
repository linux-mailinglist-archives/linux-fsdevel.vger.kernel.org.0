Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D18F76C04D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 00:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbjHAWUJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 18:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbjHAWUI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 18:20:08 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0384AE57;
        Tue,  1 Aug 2023 15:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1690928385; x=1691533185; i=quwenruo.btrfs@gmx.com;
 bh=XJqarvYWLizpx7k9KtCiaHYQbO5ntACLyw1MPfFbQs4=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=XtE3hxP4mJbtwPE6fQIperDvmc7VZvOftAOQUyL+dwYNF5LuMHT2YnJXJegDGryxtSM3S/S
 gnAxwjNVtjuI52ndY3jHZsI7Kkd2cYAUhi4shCr5sj+NXsMJyjzXCuVC74e2CCZP2EOz51Q8l
 60fYcN5HWiGga7YAQ6ITaQv6a0Q9tC9oxlV/riLR8gUe+6Cs9A10cZpNUEqmWI5OuF3PXrMXS
 qg8rvlKOX6LV1qOiULDpEJg/6U4O0Kx/WznAqH4LF2+eL5bUyZzbWMaYJGoXdiRwqg/mkip9r
 RYfwuhO25zbjU0L7rrme2nDhttj7feZeC/LvHGCaDrWvL3VLWx2w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MhU9j-1pwJvv2nel-00ec4D; Wed, 02
 Aug 2023 00:19:45 +0200
Message-ID: <e8778859-8783-21ff-484e-28591f1e65bd@gmx.com>
Date:   Wed, 2 Aug 2023 06:19:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [btrfs?] kernel BUG in prepare_to_merge
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        syzbot <syzbot+ae97a827ae1c3336bbb4@syzkaller.appspotmail.com>,
        clm@fb.com, dsterba@suse.com, johannes.thumshirn@wdc.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <000000000000a3d67705ff730522@google.com>
 <000000000000f2ca8f0601bef9ca@google.com> <20230731073707.GA31980@lst.de>
 <358fab94-4eaa-4977-dd69-fc39810f18e0@gmx.com>
 <ZMeC6BPCBT/5NR+S@infradead.org>
 <f294c55b-3855-9ec3-c66c-a698747f22e0@gmx.com>
 <ZMju6PMnJ6tnMgfy@infradead.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <ZMju6PMnJ6tnMgfy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:C+0x+woUT9Pd1BUKqOR/qGhQtvoOe2t1D+LfIm3f97FWQ3MDgse
 BPiVCF7aRxxwyXXYHyNYznGd+dDvQMkoXhQcnSsaNw2Z72tI5n7uwOOXGnqUa8kZfi1frDL
 d0DTIXQ6ynDozreiPhCGzSrWgp9rWdmKQ2YYrAdJ4O957HXdQ/RQcvuv4Li5DemoijpauMS
 3F7bQ1ZM7v9Fx6SLisaqQ==
UI-OutboundReport: notjunk:1;M01:P0:FbNdHwe7+u4=;0U4ew3ShL9nYoZFaKyWZN52nocB
 Ob3Zetq8y5bX7fzkmMprUkmSFOY8UGQQQRl+L95b84k0PFTavY6+JvUFvhKBTeK6F4ZVxIrc8
 uFrqjyyfswZuMir6LR8qDfZcINLgzbEQRjutGK3m89z7ecmVq4AGOGzfmbFwkZP/hQC+P6P3/
 CZ6EzlGU13yLAPPLskMDx3CeLyVmZqx/GcuNDrjHowiF7tQpqvDs7p3l9OUb2d3uXZ7nv62ue
 fLPVPYtBQTkfWSRlYYplT0TCck4ZYY7wt1no1WHldEh7gD7orD5cA+771A81tOMeDXUD7xZDZ
 ZX3XeeuQoXxbigslOhpVKn1EPB9znpqHkLVgy4/SJ+dvhrHmWZRC+2qML+FAAVNVBEuurFRXp
 wPkXpghYaIMAPsWNyQIiiIYDLkSw+cptRRGV1Pc5XQ01I0+lQU4z02bQfTlaMRJFh6K/1hNBK
 TVGkPugon3NQJlwv0F+GaVWkawPNEZat+3utKHcSGa4xqG/X2GKls77ZKWMyw72MZL6pwigkS
 htODGN5CgqTYorYBjvuzZ5obzoeAhhCbmm9DB9WkpXT5h/5BD7muAL9EGMBbk34d/SGypHjLp
 rqMNiIWnUJTaDnMscJWPny+BB3VVaboUzqj2r8+hk/h1MMcsvtjAI0SuYSnSSOjfqOcUQbxtd
 s1YWH1xIEepD8OrV2qqa3zrjZirWLq0uMCVvS/D6tnwolyK4KEWP6/f0CrPARkTwgQ0WxiF1G
 rCIqZEPqhT0RGCpshxtZ6nKgQyd7PUxwcjlzkxgRzuEXUgoSE1bmdifirSoL/KICp4hmAEQfV
 FWb7ayPzI3fJ4OAbjPS1kIrlJshcaw7YQq1tb8l74SjQlJfrS+ACzfKC4l4t6PuVbrA40ggfX
 xlT5G/upQC9GD1/10lVWYKWYeKKE5vBDYppA7oZFBWNcFzotYaQ+WMpBPGPP2nvK7KyPKGg0B
 WryYXQm4skAYpe8xExk/Ij4PUEw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/8/1 19:39, Christoph Hellwig wrote:
> With misc-next and your debug patch I first ran into another assert:
>
> [  250.848976][T35903] assertion failed: 0, in fs/btrfs/relocation.c:204=
2
> [  250.849963][T35903] ------------[ cut here ]------------
> [  250.850472][T35903] kernel BUG at fs/btrfs/relocation.c:2042!
>
> and here is the output from your assert:
>
> [ 1378.272143][T189001] BTRFS error (device loop1): reloc tree mismatch,=
 root 8 has no reloc root, expect reloc root key (-8, 132, 8) gen 17

Thanks a lot!

This indeed shows what I feared, on-disk corruption.

The root 8 is quota tree, which doesn't need to go through tree-reloc at
all.

The whole tree-relocation idea is for subvolume trees, which would do a
special snapshot for them, and then swap the highest tree nodes between
the tree reloc tree (the special snapshot) and the subvolume tree.

Thus for non-subvolume trees, relocation is done by just COWing the
involved tree blocks and call it a day.

This means we should never hit a reloc tree for non-subvolume trees, and
this looks like a on-disk format corruption.

Maybe I can reject those obviously incorrect reloc trees in tree-checker.

Thanks,
Qu

> [ 1378.274019][T189001] ------------[ cut here ]------------
> [ 1378.274540][T189001] BTRFS: Transaction aborted (error -117)
> [ 1378.277110][T189001] WARNING: CPU: 3 PID: 189001 at fs/btrfs/relocati=
on.c:1946 prepare_to_merge+0x10e0/0x1460
>
