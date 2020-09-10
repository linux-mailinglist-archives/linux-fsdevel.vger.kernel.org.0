Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2012642C4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Sep 2020 11:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730312AbgIJJsr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Sep 2020 05:48:47 -0400
Received: from shelob.oktetlabs.ru ([91.220.146.113]:47991 "EHLO
        shelob.oktetlabs.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730082AbgIJJsm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Sep 2020 05:48:42 -0400
Received: by shelob.oktetlabs.ru (Postfix, from userid 122)
        id 96A3F7F5E3; Thu, 10 Sep 2020 12:48:38 +0300 (MSK)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on shelob.oktetlabs.ru
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=5.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU autolearn=unavailable autolearn_force=no
        version=3.4.2
Received: from [0.0.0.0] (shelob.oktetlabs.ru [192.168.34.2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by shelob.oktetlabs.ru (Postfix) with ESMTPSA id CA8127F52C;
        Thu, 10 Sep 2020 12:48:34 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru CA8127F52C
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oktetlabs.ru;
        s=default; t=1599731314;
        bh=gHQgcN/IIqSo6DdSdAqvcE97Apz/JWjmzVKn29sT11Q=;
        h=To:Cc:From:Subject:Date;
        b=kJIb3SBxpJ2SuCGObP/FZPVmQNUfupTG5QtxrpzYqqnNAsfdwQwkmMiKvy/gcu9Mz
         Bu9wV+j3Dk8LjdVL3ruox47z7U8nC/fSsMpXaAOi+aEu9k1puZTLz/rS/QRW5ZNGFa
         RLkZhdXjOPSSHV8jNfXS10+OzkKJn6fUt1x4F7/Q=
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org
From:   Sergey Nikitin <nikitins@oktetlabs.ru>
Subject: PROBLEM: epoll_wait() does not return events when running in multiple
 threads
Message-ID: <8076083c-0ae3-9cef-6238-9a651b026ade@oktetlabs.ru>
Date:   Thu, 10 Sep 2020 12:48:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------61BF450312C3FE14D449097E"
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a multi-part message in MIME format.
--------------61BF450312C3FE14D449097E
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi!

epoll does not report an event to all the threads running epoll_wait() 
on the same epoll descriptor.
The behavior appeared in recent kernel versions starting with 5.6 probably.

How to reproduce:
- create a pair of sockets
- create epoll instance
- register the socket on the epoll instance, listen for EPOLLIN events
- start 2 threads running epoll_wait()
- send some data to the socket
- see that epoll_wait() within one of the threads reported an event, 
unlike another.

I attached a python script reproducing the issue.
Here's the output on my environment:
1. Fail case
   $ cat /proc/version
   Linux version 5.7.9-200.fc32.x86_64 
(mockbuild@bkernel01.iad2.fedoraproject.org) (gcc version 10.1.1 
20200507 (Red Hat 10.1.1-1) (GCC), GNU ld version 2.34-3.fc32) #1 SMP 
Fri Jul 17 16:23:37 UTC 2020
   $ ./multiple_same_epfd.py
   MainThread: created epfd5
   Thread-1 epfd5: start polling
   Thread-2 epfd5: start polling
   MainThread: Send some data
   Thread-2 epfd5: got events: 1
   Thread-1 epfd5: got events: 0
2. Pass case
   $ cat /proc/version
   Linux version 5.4.17-200.fc31.x86_64 
(mockbuild@bkernel04.phx2.fedoraproject.org) (gcc version 9.2.1 20190827 
(Red Hat 9.2.1-1) (GCC)) #1 SMP Sat Feb 1 19:00:13 UTC 2020
   $ ./multiple_same_epfd.py
   MainThread: created epfd5
   Thread-1 epfd5: start polling
   Thread-2 epfd5: start polling
   MainThread: Send some data
   Thread-2 epfd5: got events: 1
   Thread-1 epfd5: got events: 1

I created a Bugzilla bug also:
https://bugzilla.kernel.org/show_bug.cgi?id=208943

-- 
Best regards,
Sergey Nikitin


--------------61BF450312C3FE14D449097E
Content-Type: text/x-python; charset=UTF-8;
 name="multiple_same_epfd.py"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="multiple_same_epfd.py"

#!/usr/bin/python3

import select
import socket
import threading

# Mutex to print messages from multiple threads
lock = threading.Lock()


def epoll_wait_thread(epfd):
    lock.acquire()
    print(threading.currentThread().getName(), " epfd", epfd.fileno(), ": start polling", sep='')
    lock.release()
    events = epfd.poll(3)
    lock.acquire()
    print(threading.currentThread().getName(), " epfd", epfd.fileno(), ": got events: ", len(events), sep='')
    lock.release()


# Create a connection
s1, s2 = socket.socketpair(socket.AF_UNIX)

# Create epoll descriptor and register a socket
epfd = select.epoll()
epfd.register(s1.fileno(), select.EPOLLIN)
print(threading.currentThread().getName(), ": created epfd", epfd.fileno(), sep='')

# Start 2 threads with epoll_wait() routine
threads = []
for i in range(2):
    thread = threading.Thread(target=epoll_wait_thread, args=(epfd,))
    thread.start()
    threads.append(thread)

# Send some data to unblock epoll_wait() threads
lock.acquire()
print(threading.currentThread().getName(), ": Send some data", sep='')
lock.release()
s2.sendall(b'qwerty')

# Cleanup
for thread in threads:
    thread.join()
epfd.close()
s1.close()
s2.close()

--------------61BF450312C3FE14D449097E--
