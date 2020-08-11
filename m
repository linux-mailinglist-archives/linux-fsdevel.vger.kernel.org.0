Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B176E2419A0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Aug 2020 12:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbgHKKXr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Aug 2020 06:23:47 -0400
Received: from relay.sw.ru ([185.231.240.75]:36654 "EHLO relay3.sw.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728378AbgHKKXr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Aug 2020 06:23:47 -0400
Received: from [192.168.15.228]
        by relay3.sw.ru with esmtp (Exim 4.93)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1k5RRE-0001Gl-QN; Tue, 11 Aug 2020 13:23:24 +0300
Subject: Re: [PATCH 00/23] proc: Introduce /proc/namespaces/ directory to
 expose namespaces lineary
To:     Andrei Vagin <avagin@gmail.com>
Cc:     adobriyan@gmail.com, "Eric W. Biederman" <ebiederm@xmission.com>,
        viro@zeniv.linux.org.uk, davem@davemloft.net,
        akpm@linux-foundation.org, christian.brauner@ubuntu.com,
        areber@redhat.com, serge@hallyn.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
References: <159611007271.535980.15362304262237658692.stgit@localhost.localdomain>
 <87k0yl5axy.fsf@x220.int.ebiederm.org>
 <56928404-f194-4194-5f2a-59acb15b1a04@virtuozzo.com>
 <875za43b3w.fsf@x220.int.ebiederm.org>
 <9ceb5049-6aea-1429-e35f-d86480f10d72@virtuozzo.com>
 <20200806080540.GA18865@gmail.com>
 <2d65ca28-bcfa-b217-e201-09163640ebc2@virtuozzo.com>
 <20200810173431.GA68662@gmail.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <33565447-9b97-a820-bc2c-a4ff53a7675a@virtuozzo.com>
Date:   Tue, 11 Aug 2020 13:23:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200810173431.GA68662@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10.08.2020 20:34, Andrei Vagin wrote:
> On Fri, Aug 07, 2020 at 11:47:57AM +0300, Kirill Tkhai wrote:
>> On 06.08.2020 11:05, Andrei Vagin wrote:
>>> On Mon, Aug 03, 2020 at 01:03:17PM +0300, Kirill Tkhai wrote:
>>>> On 31.07.2020 01:13, Eric W. Biederman wrote:
>>>>> Kirill Tkhai <ktkhai@virtuozzo.com> writes:
>>>>>
>>>>>> On 30.07.2020 17:34, Eric W. Biederman wrote:
>>>>>>> Kirill Tkhai <ktkhai@virtuozzo.com> writes:
>>>>>>>
>>>>>>>> Currently, there is no a way to list or iterate all or subset of namespaces
>>>>>>>> in the system. Some namespaces are exposed in /proc/[pid]/ns/ directories,
>>>>>>>> but some also may be as open files, which are not attached to a process.
>>>>>>>> When a namespace open fd is sent over unix socket and then closed, it is
>>>>>>>> impossible to know whether the namespace exists or not.
>>>>>>>>
>>>>>>>> Also, even if namespace is exposed as attached to a process or as open file,
>>>>>>>> iteration over /proc/*/ns/* or /proc/*/fd/* namespaces is not fast, because
>>>>>>>> this multiplies at tasks and fds number.
>>>>>>>
>>>>>>> I am very dubious about this.
>>>>>>>
>>>>>>> I have been avoiding exactly this kind of interface because it can
>>>>>>> create rather fundamental problems with checkpoint restart.
>>>>>>
>>>>>> restart/restore :)
>>>>>>
>>>>>>> You do have some filtering and the filtering is not based on current.
>>>>>>> Which is good.
>>>>>>>
>>>>>>> A view that is relative to a user namespace might be ok.    It almost
>>>>>>> certainly does better as it's own little filesystem than as an extension
>>>>>>> to proc though.
>>>>>>>
>>>>>>> The big thing we want to ensure is that if you migrate you can restore
>>>>>>> everything.  I don't see how you will be able to restore these files
>>>>>>> after migration.  Anything like this without having a complete
>>>>>>> checkpoint/restore story is a non-starter.
>>>>>>
>>>>>> There is no difference between files in /proc/namespaces/ directory and /proc/[pid]/ns/.
>>>>>>
>>>>>> CRIU can restore open files in /proc/[pid]/ns, the same will be with /proc/namespaces/ files.
>>>>>> As a person who worked deeply for pid_ns and user_ns support in CRIU, I don't see any
>>>>>> problem here.
>>>>>
>>>>> An obvious diffference is that you are adding the inode to the inode to
>>>>> the file name.  Which means that now you really do have to preserve the
>>>>> inode numbers during process migration.
>>>>>
>>>>> Which means now we have to do all of the work to make inode number
>>>>> restoration possible.  Which means now we need to have multiple
>>>>> instances of nsfs so that we can restore inode numbers.
>>>>>
>>>>> I think this is still possible but we have been delaying figuring out
>>>>> how to restore inode numbers long enough that may be actual technical
>>>>> problems making it happen.
>>>>
>>>> Yeah, this matters. But it looks like here is not a dead end. We just need
>>>> change the names the namespaces are exported to particular fs and to support
>>>> rename().
>>>>
>>>> Before introduction a principally new filesystem type for this, can't
>>>> this be solved in current /proc?
>>>
>>> do you mean to introduce names for namespaces which users will be able
>>> to change? By default, this can be uuid.
>>
>> Yes, I mean this.
>>
>> Currently I won't give a final answer about UUID, but I planned to show some
>> default names, which based on namespace type and inode num. Completely custom
>> names for any /proc by default will waste too much memory.
>>
>> So, I think the good way will be:
>>
>> 1)Introduce a function, which returns a hash/uuid based on ino, ns type and some static
>> random seed, which is generated on boot;
>>
>> 2)Use the hash/uuid as default names in newly create /proc/namespaces: pid-{hash/uuid(ino, "pid")}
>>
>> 3)Allow rename, and allocate space only for renamed names.
>>
>> Maybe 2 and 3 will be implemented as shrinkable dentries and non-shrinkable.
>>
>>> And I have a suggestion about the structure of /proc/namespaces/.
>>>
>>> Each namespace is owned by one of user namespaces. Maybe it makes sense
>>> to group namespaces by their user-namespaces?
>>>
>>> /proc/namespaces/
>>>                  user
>>>                  mnt-X
>>>                  mnt-Y
>>>                  pid-X
>>>                  uts-Z
>>>                  user-X/
>>>                         user
>>>                         mnt-A
>>>                         mnt-B
>>>                         user-C
>>>                         user-C/
>>>                                user
>>>                  user-Y/
>>>                         user
>>
>> Hm, I don't think that user namespace is a generic key value for everybody.
>> For generic people tasks a user namespace is just a namespace among another
>> namespace types. For me it will look a bit strage to iterate some user namespaces
>> to build container net topology.
> 
> I can’t agree with you that the user namespace is one of others. It is
> the namespace for namespaces. It sets security boundaries in the system
> and we need to know them to understand the whole system.
> 
> If user namespaces are not used in the system or on a container, you
> will see all namespaces in one directory. But if the system has a more
> complicated structure, you will be able to build a full picture of it.
> 
> You said that one of the users of this feature is CRIU (the tool to
> checkpoint/restore containers)  and you said that it would be good if
> CRIU will be able to collect all container namespaces before dumping
> processes, sockets, files etc. But how will we be able to do this if we
> will list all namespaces in one directory?

There is no a problem, this looks rather simple. Two cases are possible:

1)a container has dedicated namespaces set, and CRIU just has to iterate
  files in /proc/namespaces of root pid namespace of the container.
  The relationships between parents and childs of pid and user namespaces
  are founded via ioctl(NS_GET_PARENT).
  
2)container has no dedicated namespaces set. Then CRIU just has to iterate
  all host namespaces. There is no another way to do that, because container
  may have any host namespaces, and hierarchy in /proc/namespaces won't
  help you.

> Here are my thoughts why we need to the suggested structure is better
> than just a list of namespaces:
> 
> * Users will be able to understand securies bondaries in the system.
>   Each namespace in the system is owned by one of user namespace and we
>   need to know these relationshipts to understand the whole system.

Here are already NS_GET_PARENT and NS_GET_USERNS. What is the problem to use
this interfaces?

> * This is simplify collecting namespaces which belong to one container.
> 
> For example, CRIU collects all namespaces before dumping file
> descriptors. Then it collects all sockets with socket-diag in network
> namespaces and collects mount points via /proc/pid/mountinfo in mount
> namesapces. Then these information is used to dump socket file
> descriptors and opened files.

This is just the thing I say. This allows to avoid writing recursive dump.
But this has nothing about advantages of hierarchy in /proc/namespaces.

> * We are going to assign names to namespaces. But this means that we
> need to guarantee that all names in one directory are unique. The
> initial proposal was to enumerate all namespaces in one proc directory,
> that means names of all namespaces have to be unique. This can be
> problematic in some cases. For example, we may want to dump a container
> and then restore it more than once on the same host. How are we going to
> avoid namespace name conficts in such cases?

Previous message I wrote about .rename of proc files, Alexey Dobriyan
said this is not a taboo. Are there problem which doesn't cover the case
you point?

> If we will have per-user-namespace directories, we will need to
> guarantee that names are unique only inside one user namespace.

Unique names inside one user namespace won't introduce a new /proc
mount. You can't pass a sub-directory of /proc/namespaces/ to a specific
container. To give a virtualized name you have to have a dedicated pid ns.

Let we have in one /proc mount:

/mnt1/proc/namespaces/userns1/.../[namespaceX_name1 -- inode XXX]

In another another /proc mount we have:

/mnt2/proc/namespaces/userns1/.../[namespaceX_name1_synonym -- inode XXX]

The virtualization is made per /proc (i.e., per pid ns). Container should
receive either /mnt1/proc or /mnt2/proc on restore as it's /proc.

There is no a sense of directory hierarchy for virtualization, since
you can't use specific sub-directory as a root directory of /proc/namespaces
to a container. You still have to introduce a new pid ns to have virtualized
/proc.

> * With the suggested structure, for each user namepsace, we will show
>   only its subtree of namespaces. This looks more natural than
>   filltering content of one directory.

It's rather subjectively I think. /proc is related to pid ns, and user ns
hierarchy does not look more natural for me.
