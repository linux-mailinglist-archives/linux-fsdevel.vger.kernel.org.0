Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D13223872E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2019 11:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbfFGJlD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jun 2019 05:41:03 -0400
Received: from mail.virtlab.unibo.it ([130.136.161.50]:59931 "EHLO
        mail.virtlab.unibo.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727066AbfFGJlB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jun 2019 05:41:01 -0400
Received: from cs.unibo.it (host5.studiodavoli.it [109.234.61.227])
        by mail.virtlab.unibo.it (Postfix) with ESMTPSA id 61729225FC;
        Fri,  7 Jun 2019 11:40:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cs.unibo.it;
        s=virtlab; t=1559900457;
        bh=p3nmSHEzOUO5BOb54+2CKD74gBNjIPrvKQK7XPQshIU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OLAWx9WOHF7zcShpJLMQSW6BMxAgONoEQKFWJsyUDxY+AHqHlsg0DIziy9julLUWo
         fJa0jfywY4wPOOdRxrBxZTeQ0SUGTJNNgXfdT3seJKiDfg2AdO2atoMacLIJ3MR4MC
         ltOkCzh1WhNnI8RUMKh+v1Di5QRPEG49bVeIIvoQ=
Date:   Fri, 7 Jun 2019 11:40:51 +0200
From:   Renzo Davoli <renzo@cs.unibo.it>
To:     Roman Penyaev <rpenyaev@suse.de>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Davide Libenzi <davidel@xmailserver.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH 1/1] eventfd new tag EFD_VPOLL: generate epoll events
Message-ID: <20190607094051.GA8353@cs.unibo.it>
References: <20190526142521.GA21842@cs.unibo.it>
 <20190527073332.GA13782@kroah.com>
 <20190527133621.GC26073@cs.unibo.it>
 <480f1bda66b67f740f5da89189bbfca3@suse.de>
 <20190531104502.GE3661@cs.unibo.it>
 <cd20672aaf13f939b4f798d0839d2438@suse.de>
 <20190603150010.GE4312@cs.unibo.it>
 <5d44edf655e193789823094d1b4301fd@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d44edf655e193789823094d1b4301fd@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Roman,

On Thu, Jun 06, 2019 at 10:11:57PM +0200, Roman Penyaev wrote:
> Hi Renzo,
> On 2019-06-03 17:00, Renzo Davoli wrote:
> > Please, have a look of the README.md page here:
> > https://github.com/virtualsquare/vuos
> Is that similar to what user-mode linux does?  I mean the principle.

let us write this proportion:
user-mode-linux / umvu = linux / namespace

In a comparison between user-mode linux and umvu,
while the way to get the system call requests is the same (ptrace)
the goal is different.

user-mode linux catches all the system calls, none of them is forwarded to
the real kernel: it uses a linux kernel compiled as a process to give processes
the illusion to live in another machine.

umvu catches all the system calls and then it decides if the syscall must be forwarded
to the kernel (maybe modified) or entirely processed at user-level by the hypervisor
(by means of specific plug-in modules like vufuse for file systems, vudev for devices
 and so on).
While the "illusion" of user-mode linux is a global illusion, the "illusion" provided by
umvu is limited and configurable. After a "mount" of a filesystem using vufuse,
the file system tree is the same *but* the subtree of the mountpoint.
The illusion is limited to the subtree as only the system call requests for paths inside
the subtree are processed by umvu and its modules.

It is similar to a namespace implemented at user level.
w.r.t. namespaces:
* umvu does not change the attack surface of the kernel (it is just a virtualization
		-- a.k.a. illusion -- provided by a user process to other user processes)
* umvu can provide features not currently supported by the kernel (e.g. a file system
		organization unavailable as kernel code, networking stacks at user level etc.)
* ...

umvu is an implementation of vuos concepts using ptrace. In a future maybe it will be
possibile to reimplement the same idea of partial virtual machines using other
syscall tracing/filtering tools.
> 
> > I am not trying to port some tools to use user-space implemented
> > stacks or device
> > drivers/emulators, I am seeking to a general purpose approach.
> 
> You still intersect *each* syscall, why not to do the same for epoll_wait()
> and replace events with correct value?  Seems you do something similar
> already
> in a vu_wrap_poll.c: wo_epoll_wait(), right?
> 
> Don't get me wrong, I really want to understand whether everything really
> looks so bad without proposed change. It seems not, because the whole
> principle
> is based on intersection of each syscall, thus one more one less - it does
> not
> become more clean and especially does not look like a generic purpose
> solution,
> which you seek.  I may be wrong.
Your comments are precious. Thank you as I see that you have browsed into my code
to have a better view of the problem.

umvu is a modular tool. The executable of umvu is a dispatcher between the
system call requests coming from the user processes and modules (loaded at
run time as dynamic plug-in libraries)

+-----------------+         +------+      +---------------------------------+
+processes running|<------->| umvu |<---->| module (e.g. vufuse/vudev/vunet)|
+  "inside" umvu  |         +------+      +---------------------------------+
+-----------------+

Each module "registers" to umvu its "responsabilities"
It can register:
* a pathname (it will receive the syscall requests for that subtree)
* an address_family (all the syscall for sockets of that AF)
* major/minor numbers of a char or block device
* a systam call number
* ....
(each module can register more items)

The problem is not in the dialogue between umvu and the user processes
(<---> on the left in the diagram above) but between umvu and its modules
(<---> on the right). 
(wi_epoll_wait, wd_epoll_wait, wo_epoll_wait are the three wrappers used
 respectively before, during and after epoll_wait in the dialogue on the left with the
user processes).

When a user process generates a "read" syscall request and umvu discovers that
the fd is managed by vufuse, it forwards to vufuse a "read" request
having the same signature of the "read" system call (plus a trailing fdprivate arg for
syscalls using a fd. This arg can be used to speed up virtualization but can be safely
ignored).

If for the same "read" request the file descriptor is managed by vunet,
it is forwarded to vunet (actually it is converted to "recvmsg": if fd is a socket
recvmesg manages all read/recv/recvfrom/recvmsg, umvu tends to simplify the API 
by unifying similar system calls).

But what about poll/epoll/ppoll/select/pselect?
umvu takes care of all the system call requests but it needs a clean way to ask
modules some feedback when the expected events happen.

I think the clean way to do it is illustrated in test_modules/unrealsock.c
This is a test module: it registers the address families AF_INET, AF_INET6 and AF_NETLINK
then it forwards all the requests to the system calls.
In this way when this module is loaded all system calls requests 
related to sockets of the mentioned families are sent to unrealsock 
which uses the system call.

When unrealsock is loaded
   vu_insmod unrealsock
nothing apparently happens.
It is possible to run ssh, ask for ip addresses using "ip addr" etc.
The difference is that all the system call requests "pass through" umvu
and are sent to the real kernel by unrealsock.

We use modules like unrealsock to test umvu features in an independent manner (without
specific modules and submodules).

All the stuff related the virtualization of poll/ppoll/select/pselect/epoll is managed at
line 77:
		vu_syscall_handler(s, epoll_ctl) = epoll_ctl;

It says: "dear module if I need to get informed by you about an event on a file descriptor
I'll call an epoll_ctl". That's all.

Here it works as I am diverting the request to the system call which is able to generate
EPOLL_PRI and all other flavours of EPOLL_*.
When I want to write a module able to virtualize a network stack I need to write my epoll_ctl 
so I need a way to generate EPOLL_PRI when I receive an OOB packet, EPOLL_IN must be set 
when the stack receives a packet and reset when the buffer gets empty, etc.

For sure I could teach people aiming to write a module for umvu that there is a variable in
proxima centaury (I mean an helper function using data.ptr of struct epoll_event) and
then if they generate an EPOLL_IN it will be processed as if it were an EPOLL_PRI.
why?

Let us reverse the question.
Why not giving linux programmers the ability to have file descriptors on which arbitrary 
EPOLL events can be generated as they need/please? eventfd/EFD_VPOLL is (in my opinion) 
a simple way to implement this feature, we can converge on a different API.
It is not a Copernican revolution of the code. It seems to me that it is not a dangerous
feature (I could be wrong, please tell me!). It is possible to generate signals normally
sent by the kernel (e.g. SEGV), why it is not possible to generate an EPOLL_PRI?
There is at least one happy user of the new feature (me) and other may come.
It is just one (tiny) more degree of freedom.

Many kernel features were added for one usage (e.g. seccomp was created to lend/rent processing
power in a safe way) and then it was discovered that they are useful in other cases (e.g.
sandboxes for browsers).

Again thanks to everybody who will have read this message up to this point ;-)

	renzo
