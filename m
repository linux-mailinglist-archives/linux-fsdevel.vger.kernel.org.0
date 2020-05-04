Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE79C1C487F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 May 2020 22:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgEDUmH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 May 2020 16:42:07 -0400
Received: from 172.103.241.96.cable.tpia.cipherkey.com ([172.103.241.96]:56342
        "EHLO mail.pkts.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgEDUmH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 May 2020 16:42:07 -0400
Received: from Roundcube.pkts.ca (localhost [127.0.0.1])
        (authenticated bits=0)
        by mail.pkts.ca (8.15.2/8.15.2) with ESMTPSA id 044Kg6KH028139
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 4 May 2020 13:42:06 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 04 May 2020 13:42:06 -0700
From:   Charles Howes <vger.kernel.org@ch.pkts.ca>
To:     linux-fsdevel@vger.kernel.org
Subject: Question: How to prefix "../root" to output of readlink in
 /proc/<pid>/fd/ ?
Message-ID: <83e0cb6b9d7c4212dedd2e87c2f73f2c@ch.pkts.ca>
X-Sender: vger.kernel.org@ch.pkts.ca
User-Agent: Roundcube Webmail/1.3.10
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi linux-fsdevel,

When you go into /proc/<pid>/fd and type 'ls -l', you see the numbered 
file descriptors as symlinks to the real files, devices, etc.  Opening 
the file descriptors allows you to access the contents, even if the 
object has already been deleted.

In several virtualized environments (e.g. kubernetes/docker, chroot, 
etc), you can still access the contents, but the target of the symlink 
(output of readlink) is shown as an absolute path from the *virtual* 
root directory.  This may not be the same environment the caller is in, 
resulting in (apparently) broken links.

One solution would be to show the path relative to /proc/<pid>/root 
instead, turning
   "6 -> /some/directory/foo" (broken link)
into
   "6 -> ../root/some/directory/foo" (relative link using process' actual 
root directory),
or possibly
   "6 -> /proc/1234/root/some/directory/foo" (absolute link using actual 
root directory).

Pros:
-----

+ This fixes some (maybe all?) of the erroneously broken links in 
/proc/<pid>/fd
+ This would work for all processes, virtualized or not.
+ It can't break existing code (any further), unless existing code 
depends on erroneously broken links.
+ It's short.

Cons:
-----

- Maybe there is existing code that assumes absolute links instead of 
relative links?

Implementation details:
-----------------------
It looks like adding some code to do_proc_readlink 
(https://github.com/torvalds/linux/blob/690e2aba7beb1ef06352803bea41a68a3c695015/fs/proc/base.c 
) might do the trick; d_path() already appends ' (deleted)' to the link 
if necessary, prepending '../root' to paths that start with '/' should 
work the same way.

Question:
---------
I'd like to write a patch for this, but after reading some of the 
patches in linux-fsdevel, it looks like there are lots of  
implementation details I could get wrong through ignorance of kernel 
internals.  What would you recommend for a good example to copy?

Conversely, if this is a 5-minute job for someone here, would anyone 
like to take it on?

Thanks!

-- 
Charles Howes <vger.kernel.org@ch.pkts.ca>
