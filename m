Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA71202C54
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Jun 2020 21:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730309AbgFUTdE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Jun 2020 15:33:04 -0400
Received: from cloud1-vm154.de-nserver.de ([178.250.10.56]:26063 "EHLO
        cloud1-vm154.de-nserver.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729279AbgFUTdE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Jun 2020 15:33:04 -0400
Received: (qmail 3463 invoked from network); 21 Jun 2020 21:33:02 +0200
X-Fcrdns: No
Received: from phoffice.de-nserver.de (HELO [10.242.2.2]) (185.39.223.5)
  (smtp-auth username hostmaster@profihost.com, mechanism plain)
  by cloud1-vm154.de-nserver.de (qpsmtpd/0.92) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) ESMTPSA; Sun, 21 Jun 2020 21:33:02 +0200
X-GeoIP-Country: DE
Subject: Re: Kernel 5.4 breaks fuse 2.X nonempty mount option
From:   Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
To:     David Howells <dhowells@redhat.com>
Cc:     ebiggers@google.com, viro@zeniv.linux.org.uk, mszeredi@redhat.com,
        linux-fsdevel@vger.kernel.org,
        "p.kramme@profihost.ag" <p.kramme@profihost.ag>,
        Daniel Aberger - Profihost AG <d.aberger@profihost.ag>
References: <736d172c-84ff-3e9f-c125-03ae748218e8@profihost.ag>
 <1696715.1592552822@warthog.procyon.org.uk>
 <4a2f5aa9-1921-8884-f854-6a8b22c488f0@profihost.ag>
Message-ID: <2cfa1de5-a4df-5ad3-e35b-3024cad78ed1@profihost.ag>
Date:   Sun, 21 Jun 2020 21:33:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <4a2f5aa9-1921-8884-f854-6a8b22c488f0@profihost.ag>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-User-Auth: Auth by hostmaster@profihost.com through 185.39.223.5
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi David,

i did a git bisect and the breaking commit is:

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

most probably due to the following diffences:


old default:
               default:
-                       return 0;


new default:
+       default:
+               return -EINVAL;


it seems the old API silently did ignore unknown parameters while the
new one fails with EINVAL.

I'm not sure who to blame here but this seems to break existing usespace
fuse programs or may be libfuse 2.9.X in general.

Greets,
Stefan

Am 19.06.20 um 21:02 schrieb Stefan Priebe - Profihost AG:
> 
> Am 19.06.20 um 09:47 schrieb David Howells:
>> Stefan Priebe - Profihost AG <s.priebe@profihost.ag> wrote:
>>
>>> while using fuse 2.x and nonempty mount option - fuse mounts breaks
>>> after upgrading from kernel 4.19 to 5.4.
>>
>> Can you give us an example mount commandline to try?
> 
> see fstab which daniel sent or:
> ceph-fuse  /var/log/pve/tasks nonempty
> 
> Greets,
> Stefan
> 
>>
>> Thanks,
>> David
>>
