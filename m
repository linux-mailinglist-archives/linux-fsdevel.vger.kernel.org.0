Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72ED475BDD0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jul 2023 07:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjGUFm5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jul 2023 01:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjGUFm4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jul 2023 01:42:56 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4F71711;
        Thu, 20 Jul 2023 22:42:53 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:53604)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qMiuc-004rM4-GD; Thu, 20 Jul 2023 23:42:46 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:56814 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qMiub-00FWv4-7X; Thu, 20 Jul 2023 23:42:45 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Viacheslav Dubeyko <slava@dubeyko.com>,
        Matthew Wilcox <willy@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        syzbot <syzbot+7bb7cd3595533513a9e7@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        christian.brauner@ubuntu.com,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jeff Layton <jlayton@kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com,
        ZhangPeng <zhangpeng362@huawei.com>,
        linux-m68k@lists.linux-m68k.org
References: <000000000000dbce4e05f170f289@google.com>
        <5f45bb9a-5e00-48dd-82b0-46b19b1b98a3@app.fastmail.com>
        <CAHk-=wi8XyAUF9_z6-oa4Ava6PVZeE-=TVNcFK1puQHpOtqLLw@mail.gmail.com>
        <ab7a9477-ddc7-430f-b4ee-c67251e879b0@app.fastmail.com>
        <2575F983-D170-4B79-A6BA-912D4ED2CC73@dubeyko.com>
        <46F233BB-E587-4F2B-AA62-898EB46C9DCE@dubeyko.com>
        <Y7bw7X1Y5KtmPF5s@casper.infradead.org>
        <50D6A66B-D994-48F4-9EBA-360E57A37BBE@dubeyko.com>
        <CACT4Y+aJb4u+KPAF7629YDb2tB2geZrQm5sFR3M+r2P1rgicwQ@mail.gmail.com>
Date:   Fri, 21 Jul 2023 00:40:26 -0500
In-Reply-To: <CACT4Y+aJb4u+KPAF7629YDb2tB2geZrQm5sFR3M+r2P1rgicwQ@mail.gmail.com>
        (Dmitry Vyukov's message of "Thu, 20 Jul 2023 17:27:57 +0200")
Message-ID: <87y1j9ddpx.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1qMiub-00FWv4-7X;;;mid=<87y1j9ddpx.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX19b4haWTJRkCzfHy8zsGBgQylRh8f4gAnE=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Dmitry Vyukov <dvyukov@google.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 518 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 12 (2.3%), b_tie_ro: 10 (2.0%), parse: 1.33
        (0.3%), extract_message_metadata: 15 (2.9%), get_uri_detail_list: 2.2
        (0.4%), tests_pri_-2000: 10 (1.9%), tests_pri_-1000: 2.9 (0.6%),
        tests_pri_-950: 1.24 (0.2%), tests_pri_-900: 1.03 (0.2%),
        tests_pri_-200: 0.85 (0.2%), tests_pri_-100: 3.8 (0.7%),
        tests_pri_-90: 79 (15.3%), check_bayes: 77 (14.8%), b_tokenize: 16
        (3.1%), b_tok_get_all: 12 (2.2%), b_comp_prob: 4.7 (0.9%),
        b_tok_touch_all: 39 (7.6%), b_finish: 1.86 (0.4%), tests_pri_0: 309
        (59.7%), check_dkim_signature: 0.78 (0.2%), check_dkim_adsp: 2.9
        (0.6%), poll_dns_idle: 59 (11.5%), tests_pri_10: 2.4 (0.5%),
        tests_pri_500: 74 (14.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [syzbot] [hfs?] WARNING in hfs_write_inode
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dmitry Vyukov <dvyukov@google.com> writes:

> On Thu, 5 Jan 2023 at 17:45, Viacheslav Dubeyko <slava@dubeyko.com> wrote:
>> > On Wed, Jan 04, 2023 at 08:37:16PM -0800, Viacheslav Dubeyko wrote:
>> >> Also, as far as I can see, available volume in report (mount_0.gz) somehow corrupted already:
>> >
>> > Syzbot generates deliberately-corrupted (aka fuzzed) filesystem images.
>> > So basically, you can't trust anything you read from the disc.
>> >
>>
>> If the volume has been deliberately corrupted, then no guarantee that file system
>> driver will behave nicely. Technically speaking, inode write operation should never
>> happened for corrupted volume because the corruption should be detected during
>> b-tree node initialization time. If we would like to achieve such nice state of HFS/HFS+
>> drivers, then it requires a lot of refactoring/implementation efforts. I am not sure that
>> it is worth to do because not so many guys really use HFS/HFS+ as the main file
>> system under Linux.
>
>
> Most popular distros will happily auto-mount HFS/HFS+ from anything
> inserted into USB (e.g. what one may think is a charger). This creates
> interesting security consequences for most Linux users.
> An image may also be corrupted non-deliberately, which will lead to
> random memory corruptions if the kernel trusts it blindly.

I am going to point out that there are no known linux filesystems
that are safe to mount when someone has written a deliberately
corrupted filesystem on a usb stick.

Some filesystems like ext4 make a best effort to fix bugs of this sort
as they are discovered but unless something has changed since last I
looked no one makes the effort to ensure that it is 100% safe to mount
any possible corrupted version of any Linux filesystem.

If there is any filesystem in Linux that is safe to automount from
an untrusted USB stick I really would like to hear about it.  We could
allow mounting them in unprivileged user namespaces and give all kinds
of interesting capabilities to our users.

As it is I respectfully suggest that if there is a security issue it is
the userspace code that automounts any filesystem on an untrusted USB
stick.

Eric




