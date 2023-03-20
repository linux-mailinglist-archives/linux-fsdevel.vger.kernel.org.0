Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 834066C1DD3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Mar 2023 18:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233454AbjCTR0V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Mar 2023 13:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233485AbjCTR0C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Mar 2023 13:26:02 -0400
X-Greylist: delayed 72724 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 20 Mar 2023 10:21:33 PDT
Received: from smtp-42ae.mail.infomaniak.ch (smtp-42ae.mail.infomaniak.ch [84.16.66.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34051392AC
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Mar 2023 10:21:32 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4PgM2y6NW5zMqNB4;
        Mon, 20 Mar 2023 18:21:14 +0100 (CET)
Received: from unknown by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4PgM2y1wKBzN4g2w;
        Mon, 20 Mar 2023 18:21:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1679332874;
        bh=OS074Ouynzu9ANDNW44geO0N3xPcAVOvS7DiWUmnpko=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=oUmzcGJuCOCBUHhMd9TkX7+FVz28UCB5qymShBLWMzlppJVbcrrFkTMkigRDGHaNr
         Ey2ObCNd3gsf2HaXoke1lmr3PN5B0POu3TQubwW9hWsUSgehixdebYR/qkzpeoxnWJ
         EyiOOBiAp2AT0cK7ClsLh2SI4tcc2IdPC1opEP3E=
Message-ID: <5d415985-d6ac-2312-3475-9d117f3be30f@digikod.net>
Date:   Mon, 20 Mar 2023 18:21:13 +0100
MIME-Version: 1.0
User-Agent: 
Subject: Re: Does Landlock not work with eCryptfs?
Content-Language: en-US
To:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>
Cc:     landlock@lists.linux.dev, Tyler Hicks <code@tyhicks.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
References: <20230319.2139b35f996f@gnoack.org>
 <c1c9c688-c64d-adf2-cc96-dc2aaaae5944@digikod.net>
 <20230320.c6b83047622f@gnoack.org>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <20230320.c6b83047622f@gnoack.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 20/03/2023 18:15, Günther Noack wrote:
> Hello!
> 
> On Sun, Mar 19, 2023 at 10:00:46PM +0100, Mickaël Salaün wrote:
>> Hi Günther,
>>
>> Thanks for the report, I confirm there is indeed a bug. I tested with a
>> Debian distro:
>>
>> ecryptfs-setup-private --nopwcheck --noautomount
>> ecryptfs-mount-private
>> # And then with the kernel's sample/landlock/sandboxer:
>> LL_FS_RO="/usr" LL_FS_RW="${HOME}/Private" sandboxer ls ~/Private
>> ls: cannot open directory '/home/user/Private': Permission denied
>>
>> Actions other than listing a directory (e.g. creating files/directories,
>> reading/writing to files) are controlled as expected. The issue might be
>> that directories' inodes are not the same when listing the content of a
>> directory or when creating new files/directories (which is weird). My
>> hypothesis is that Landlock would then deny directory reading because the
>> directory's inode doesn't match any rule. It might be related to the overlay
>> nature of ecryptfs.
>>
>> Tyler, do you have some idea?
> 
> I had a hunch, and found out that the example can be made to work by
> granting the LANDLOCK_ACCESS_FS_READ_DIR right on the place where the
> *encrypted* version of that home directory lives:
> 
>    err := landlock.V1.RestrictPaths(
>            landlock.RODirs(dir),
>            landlock.PathAccess(llsys.AccessFSReadDir, "/home/.ecryptfs/gnoack/.Private"),
>    )
> 
> It does seem a bit like eCryptfs it calling security_file_open() under
> the hood for the encrypted version of that file? Is that correct?

Yes, that's right, the lower directory is used to list the content of 
the ecryptfs directory: 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/ecryptfs/file.c#n112 
iterate_dir(lower_file, …)
