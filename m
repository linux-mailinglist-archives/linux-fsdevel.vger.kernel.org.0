Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C44820A662
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jun 2020 22:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389843AbgFYULA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Jun 2020 16:11:00 -0400
Received: from cloud1-vm154.de-nserver.de ([178.250.10.56]:56083 "EHLO
        cloud1-vm154.de-nserver.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389344AbgFYULA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Jun 2020 16:11:00 -0400
Received: (qmail 12076 invoked from network); 25 Jun 2020 22:10:58 +0200
X-Fcrdns: No
Received: from phoffice.de-nserver.de (HELO [10.242.2.6]) (185.39.223.5)
  (smtp-auth username hostmaster@profihost.com, mechanism plain)
  by cloud1-vm154.de-nserver.de (qpsmtpd/0.92) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) ESMTPSA; Thu, 25 Jun 2020 22:10:58 +0200
X-GeoIP-Country: DE
Subject: Re: Kernel 5.4 breaks fuse 2.X nonempty mount option
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     David Howells <dhowells@redhat.com>,
        Eric Biggers <ebiggers@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        "p.kramme@profihost.ag" <p.kramme@profihost.ag>,
        Daniel Aberger - Profihost AG <d.aberger@profihost.ag>
References: <736d172c-84ff-3e9f-c125-03ae748218e8@profihost.ag>
 <1696715.1592552822@warthog.procyon.org.uk>
 <4a2f5aa9-1921-8884-f854-6a8b22c488f0@profihost.ag>
 <2cfa1de5-a4df-5ad3-e35b-3024cad78ed1@profihost.ag>
 <CAJfpegvLJBAzGCpR6CQ1TG8-fwMB9oN8kVFijs7vK+dvQ6Tm5w@mail.gmail.com>
From:   Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Message-ID: <bffa6591-6698-748d-ba26-a98142b03ae8@profihost.ag>
Date:   Thu, 25 Jun 2020 22:10:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAJfpegvLJBAzGCpR6CQ1TG8-fwMB9oN8kVFijs7vK+dvQ6Tm5w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-User-Auth: Auth by hostmaster@profihost.com through 185.39.223.5
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Am 25.06.20 um 21:54 schrieb Miklos Szeredi:
> On Sun, Jun 21, 2020 at 9:33 PM Stefan Priebe - Profihost AG
> <s.priebe@profihost.ag> wrote:
>>
>> Hi David,
>>
>> i did a git bisect and the breaking commit is:
>>
>> commit c30da2e981a703c6b1d49911511f7ade8dac20be
>> Author: David Howells <dhowells@redhat.com>
>> Date:   Mon Mar 25 16:38:31 2019 +0000
>>
>>     fuse: convert to use the new mount API
>>
>>     Convert the fuse filesystem to the new internal mount API as the old
>>     one will be obsoleted and removed.  This allows greater flexibility in
>>     communication of mount parameters between userspace, the VFS and the
>>     filesystem.
>>
>>     See Documentation/filesystems/mount_api.txt for more information.
>>
>>     Signed-off-by: David Howells <dhowells@redhat.com>
>>     Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
>>     Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
>>
>> most probably due to the following diffences:
>>
>>
>> old default:
>>                default:
>> -                       return 0;
>>
>>
>> new default:
>> +       default:
>> +               return -EINVAL;
>>
>>
>> it seems the old API silently did ignore unknown parameters while the
>> new one fails with EINVAL.
> 
> v4.19 has this:
> 
> static int parse_fuse_opt(char *opt, struct fuse_mount_data *d, int is_bdev,
>                           struct user_namespace *user_ns)
> {
> [...]
>         while ((p = strsep(&opt, ",")) != NULL) {
> [...]
>                 token = match_token(p, tokens, args);
>                 switch (token) {
> [...]
>                 default:
>                         return 0;
> 
> and
> 
> static int fuse_fill_super(struct super_block *sb, void *data, int silent)
> {
> [...]
>         err = -EINVAL;
>         if (sb->s_flags & SB_MANDLOCK)
>                 goto err;
> 
>         sb->s_flags &= ~(SB_NOSEC | SB_I_VERSION);
> 
>         if (!parse_fuse_opt(data, &d, is_bdev, sb->s_user_ns))
>                 goto err;
> [...]
>  err:
>         return err;
> }
> 
> That looks like it returns -EINVAL for unknown options.  Can you
> perform a "strace" on the old and the new kernel to see what the
> difference is?
> 
> BTW, the hard rule is: userspace regressions caused by kernel changes
> must be fixed.  It's just not clear where exactly this is coming from.

Does a userspace strace really help? I did a git bisect between kernel
v5.3 (working) und v5.4 (not working) and it shows


commit c30da2e981a703c6b1d49911511f7ade8dac20be
Author: David Howells <dhowells@redhat.com>
Date:   Mon Mar 25 16:38:31 2019 +0000

    fuse: convert to use the new mount API

    Convert the fuse filesystem to the new internal mount API as the old
    one will be obsoleted and removed.  This allows greater flexibility in
    communication of mount parameters between userspace, the VFS and the
    filesystem.

    See Documentation/filesystems/mount_api.txt for more information.

    Signed-off-by: David Howells <dhowells@redhat.com>
    Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
    Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>

as the regression commit.

Stefan

> 
> Thanks,
> Miklos
> 
