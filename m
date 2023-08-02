Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3CDF76C5DB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 08:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232685AbjHBGy0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 02:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232109AbjHBGyA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 02:54:00 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AA810E7;
        Tue,  1 Aug 2023 23:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1690959200; x=1691564000; i=quwenruo.btrfs@gmx.com;
 bh=mhY0z8g5+DjHvEyUJswmu07uXJuvqEAZJbpbvbp1T+o=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=dBJ66a1qJp90U2BPSs/sgBTXA+/ktZPd306dbWl77CHsy0oRB92MxJDVLUgdXqmwpUySSm3
 iZDelrstIdffQ7Zq+gZjWUs3f9q9+oSZztkhJawxyLF2SAAk8HbaP1FEBoso6ROrAICy233wv
 su+NNR23f3w6qz3UHvNgQX2hyRE/zPg5JXPK1NlYo3tcjFgj/PN3avyoXxWF2lpZzG0IjLgkV
 Ey5KHaIpVCXy5e1+2dfRx449WrSrdEJOvPFswRejnAnl3JZEELPy+aOEJQPveCNmJNNqkAFdj
 yOJzaOUJFk7BsRWgbPQnpQPC048X0n3DE5bWE0GrbeBan35YQDCg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N3siG-1piqzw0932-00zq17; Wed, 02
 Aug 2023 08:53:20 +0200
Message-ID: <3ae87897-9fb8-20c5-66ea-3289e255fe5e@gmx.com>
Date:   Wed, 2 Aug 2023 14:53:14 +0800
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
 <ZMju6PMnJ6tnMgfy@infradead.org> <ZMkkEEQVr1T/p/vJ@infradead.org>
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
In-Reply-To: <ZMkkEEQVr1T/p/vJ@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:H5nqUZVztp9ZkVGMCr3YWYSea7QVHjKfnZx91DOMlosrRZpGZhD
 7fh+wnzLlhMGEyJ6NVhwF5AWP6+f6wDvVfMK0+befr0KxAdl+XN5ZQXgImlxfj9YfqCxYJx
 aitdCh1SblOgblomMZJTJD+z/BnkpEay5cjq0zIruLxIkClh5bXfNYOS+v74eDWf8A0VT4S
 M78uKIbMqgBOIW22VFmqg==
UI-OutboundReport: notjunk:1;M01:P0:I3jzw7hBI9I=;D6hIwMab4cxD/+O3ARtSb1ZDkWr
 0qTOYS4z/Re4+7S3/2QqQCNTWhfd1P+Obk+YSv7dFKwlq8abnXyIBvTYEMyec5yq+oKnaGcYV
 mjzMnwsYozcgjHSoDh+koq8LKQPffr0z4e5XZ+tVkfpD7L/vwi7lhp9uzcPN9NeAG2rfkgJdH
 +vczzzw6+TCmmtaGWTy4DLGigvRGPCFPp9DQpdAjE+wSZmCNDp5YoD4bjo2KL+tM7jofC2LwP
 64V8SQ901zwiGi1sUkQaytmNxz62s3FytINg2vkfdFt5RJg1DNSWnYvFdN4k/mQHIH21I4jHS
 RQ4ol8z+CvI0KTJMywe0RDc0m0IHTBzeROZkz2ymeBvS2DxOER9A8KIRseMLjiDnGC7XFqtCj
 baqliB2kKeQcWFO4W8dgZng1M7hcMOlGnpl9UtGQwGA+s6ty5SdDLJ/J7hPvHerJp5vuTYXed
 sxicve+rLm5T8HHiMyOjRDr1fA0MYjVz5MYzNrg+iynUKzKvj6ZIMnDbSNx5brzYioP3jyAZt
 JlKKbn4sCJKFrLAUN3W+b8cnlgF2NIbEek6y620V4xKj0HiTEdBU4oxpVhtIy2ha0J5r8PdAx
 UqzQgxl0JCcEZ5VDqcKDJhpOrb5T6WS2zThT1MnZi6CxsmGjoaKAknRRAFI/nvRHt32XmkTM7
 rFNwhTnsy/ikOa7GzeXI8poIhuuGjvNxmBE+bDn9ZQzBWwpRmwvDKN2KHMyYbiWSU0cjshbVm
 xHmBUHP9muhY0bR6a3p/9Nrko2RuTqBv+hkIMqY0A+n3wP/YhjXhEXRG/yzD3ngnVEusUJNJm
 +IfWeUFh3+4wo0YlIix3xMaJXDGRWfoy/vF2wGZ5ekHh5NzBbQZBt8/SpFjRwJof9WAcwX5km
 yWB1GoYohBX3VmlHPYfjTyqpi/DFsMuaJxWuIDoDBAwIPOiREGdLth1WIq/2aq4cmtNSaWDOv
 ldSJ1AdDUnvson7wTMy/Ydgzn0M=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/8/1 23:26, Christoph Hellwig wrote:
> In the meantime I've also reproduced it with just
> "btrfs: fix the btrfs_get_global_root return value", but it took
> a rather long time.
>
> After wading through the code my suspicion is that before this fix
> the ERR_PTR return made that for those cases btrfs_get_root_ref and
> btrfs_get_fs_root_commit_root don't actually do the
> btrfs_lookup_fs_root.  Although that seemed unintentional as far
> as I can tell it might have prevented some additional problems
> with whatever syzcaller is fuzzing here.  Not sure if anyone who
> knows this code has any good idea where to start looking?
>


I'm also looking into the case, the weird part seems to be we're getting
some race between qgroup tree creation and relocation.

More rounds of syzbot testing shows it's not on-disk data corruption,
but runtime corruption lead to the invalid reloc tree key.

Normally if we're relocating tree 8 (quota tree), we should get
fs_info->quota_root, and it should not has ROOT_SHAREABLE flag, thus we
just go COW the involved quota tree block.

But by somehow, if the quota tree is created by btrfs_init_fs_root() it
would has the ROOT_SHAREABLE flag and leads to the incorrect reloc tree
creation.

My current guess is, some race like this:

             Thread A             |           Thread B
=2D--------------------------------+------------------------------
btrfs_quota_enable()             |
|                                | btrfs_get_root_ref()
|                                | |- btrfs_get_global_root()
|                                | |  Returned NULL
|                                | |- btrfs_lookup_fs_root()
|                                | |  Returned NULL
|- btrfs_create_tree()           | |
|  Now quota root item is        | |
|  inserted                      | |- btrfs_read_tree_root()
|                                | |  Got the newly inserted quota root
|                                | |- btrfs_init_fs_root()
|                                | |  Set ROOT_SHAREABLE flag

By this, with a relocation and quota enabling, we create a race that we
can get a quota root with ROOT_SHAREABLE set, and lead to the problem.

Personally speaking, I don't have a particularly good idea on how to fix i=
t.

We may skip any non-subvolume related trees in btrfs_init_fs_root(), but
that doesn't seem correct to me.

Any good ideas on this?

Thanks,
Qu
