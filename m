Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADA4065F5DF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jan 2023 22:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235337AbjAEVfF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Jan 2023 16:35:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233552AbjAEVfD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Jan 2023 16:35:03 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F85F6719F;
        Thu,  5 Jan 2023 13:35:03 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id w3so9057259ply.3;
        Thu, 05 Jan 2023 13:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:subject:from:references:cc:to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qS8dYeQhr6rkdNYW42bpwedt2Pigt8o7DrRMO2YKtVU=;
        b=UCgyrtdLtFsbGmj/eBbq/f3ZZiJB/MKhu+RLWoa3idj3eAnIDuWC8TMlDlv7fVqkgS
         yDQuTp7NTBi87IpnaEHOvOogUuAsh1Q2MquSyivxTvRKZHpVO3JdAFQlxG8RPHCo0nxN
         ZvVH8ZoXwbVVGf9f4yH65qY+IkZnelbQGn7dOaVl8RPn9QnISWceookRfQk0g3nPkfpM
         +sfqiDANuikeNxN6Rhc6372iqF6pU950h2IDed+nfgMUvEiq97GfyatWdnmBUfr7TpM5
         OkW8YWg0asew5JNPOgiSIGrzonn2qg1Og3y6SoOCDfRUzcFCfxFas++1qTWd4Kvfj1c2
         5IJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:subject:from:references:cc:to:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qS8dYeQhr6rkdNYW42bpwedt2Pigt8o7DrRMO2YKtVU=;
        b=abKTeaGkJhks1OjliYKDXD1oKAabjp7peqDo4JMLIW4Xdh7xlAJjC6SloeF2aG1qF5
         onIHYoSWiFRFrmmkPE7lab4sD8X9lb4RX2Z9RmxBaPiFuArjJfwyzb/AJKSuUvR03fUT
         7T/tuH8uGcuVGdBIpbwHfZeYSzqIqn+zs6VxPPabIvZjjGvdVsS1JHV3sx8VwhrIjqcI
         VaGvpaShPBGF6ggdhtCM2EnWiBylGl3yecAohC7dotD6/Yj5nu5RqZwlE129uhuVYl8o
         x7yVEiTW0rWlap4yGSeGEOVIkM5P1hwjqzQqUSfztI5xNUawiaXlfT5hnLuy08zptmX3
         uzUA==
X-Gm-Message-State: AFqh2ko0z5du8OlOso+8trEx+kh+UoZ0Kf9Iix6rC5xKFfqkh/dpnsLb
        xBIu9FQAaBrW92b9uxNfe34=
X-Google-Smtp-Source: AMrXdXvEjtBdEejyjymJrx33ei3vhOefzX4zzvUy5Xr8CKi8JrPBqwxPYilZZERkNcsikGfUKx+pyA==
X-Received: by 2002:a17:90a:f698:b0:226:9f:e871 with SMTP id cl24-20020a17090af69800b00226009fe871mr34089497pjb.21.1672954502659;
        Thu, 05 Jan 2023 13:35:02 -0800 (PST)
Received: from Schmitz-MacBook-Pro.local (122-62-142-61-fibre.sparkbb.co.nz. [122.62.142.61])
        by smtp.googlemail.com with ESMTPSA id g6-20020a17090a640600b00225ffb9c43dsm1777712pjj.5.2023.01.05.13.34.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jan 2023 13:35:01 -0800 (PST)
To:     Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     syzbot <syzbot+7bb7cd3595533513a9e7@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        christian.brauner@ubuntu.com,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        jlayton@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Matthew Wilcox <willy@infradead.org>,
        ZhangPeng <zhangpeng362@huawei.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        linux-m68k@lists.linux-m68k.org, flar@allandria.com
References: <000000000000dbce4e05f170f289@google.com>
 <5f45bb9a-5e00-48dd-82b0-46b19b1b98a3@app.fastmail.com>
 <CAHk-=wi8XyAUF9_z6-oa4Ava6PVZeE-=TVNcFK1puQHpOtqLLw@mail.gmail.com>
 <ab7a9477-ddc7-430f-b4ee-c67251e879b0@app.fastmail.com>
From:   Michael Schmitz <schmitzmic@gmail.com>
Subject: Re: [syzbot] [hfs?] WARNING in hfs_write_inode
Message-ID: <1bd49fc0-d64f-4eb8-841a-4b09e178b5fd@gmail.com>
Date:   Fri, 6 Jan 2023 10:34:53 +1300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <ab7a9477-ddc7-430f-b4ee-c67251e879b0@app.fastmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Arnd,

Am 05.01.23 um 11:33 schrieb Arnd Bergmann:
> On Wed, Jan 4, 2023, at 20:06, Linus Torvalds wrote:
>> I suspect this code is basically all dead. From what I can tell, hfs
>> only gets updates for
>>
>>  (a) syzbot reports
>>
>>  (b) vfs interface changes
> There is clearly no new work going into it, and most data exchange
> with MacOS would use HFS+, but I think there are still some users.
PowerPC yaboot boot partitions spring to mind here. Plain HFS is still
used in places where it can't be replaced AFAIK.
>
>> and the last real changes seem to have been by Ernesto A. Fern=C3=A1nd=
ez
>> back in 2018.
>>
>> Hmm. Looking at that code, we have another bug in there, introduced by=

>> an earlier fix for a similar issue: commit 8d824e69d9f3 ("hfs: fix OOB=

>> Read in __hfs_brec_find") added
>>
>> +       if (HFS_I(main_inode)->cat_key.CName.len > HFS_NAMELEN)
>> +               return -EIO;
>>
>> but it's after hfs_find_init(), so it should actually have done a
>> hfs_find_exit() to not leak memory.
>>
>> So we should probably fix that too.
>>
>> Something like this ENTIRELY UNTESTED patch?

Looking at Linus' patch, I wonder whether the missing fd.entrylength
size test in the HFS_IS_RSRC(inode) case was due to the fact that a
file's resource fork may be empty?

Adding Brad Boyer (bfind.c author) to Cc. Brad might know what
fd.entrylength should be set to in such a case.

Cheers,

=C2=A0=C2=A0=C2=A0 Michael


>>
>> Do we have anybody who looks at hfs?
> Adding Viacheslav Dubeyko to Cc, he's at least been reviewing
> patches for HFS and HFS+ somewhat recently. The linux-m68k
> list may have some users dual-booting old MacOS.
>
> Viacheslav, see the start of the thread at
> https://lore.kernel.org/lkml/000000000000dbce4e05f170f289@google.com/
>
>      Arnd

