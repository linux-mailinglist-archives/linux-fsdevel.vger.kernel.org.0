Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38CD92467F0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Aug 2020 16:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbgHQOFl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Aug 2020 10:05:41 -0400
Received: from relay.sw.ru ([185.231.240.75]:41382 "EHLO relay3.sw.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728651AbgHQOFl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Aug 2020 10:05:41 -0400
Received: from [192.168.15.57]
        by relay3.sw.ru with esmtp (Exim 4.93)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1k7flF-0008ED-Hn; Mon, 17 Aug 2020 17:05:17 +0300
Subject: Re: [PATCH 00/23] proc: Introduce /proc/namespaces/ directory to
 expose namespaces lineary
To:     Andrei Vagin <avagin@gmail.com>
Cc:     adobriyan@gmail.com, "Eric W. Biederman" <ebiederm@xmission.com>,
        viro@zeniv.linux.org.uk, davem@davemloft.net,
        akpm@linux-foundation.org, christian.brauner@ubuntu.com,
        areber@redhat.com, serge@hallyn.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
References: <875za43b3w.fsf@x220.int.ebiederm.org>
 <9ceb5049-6aea-1429-e35f-d86480f10d72@virtuozzo.com>
 <20200806080540.GA18865@gmail.com>
 <2d65ca28-bcfa-b217-e201-09163640ebc2@virtuozzo.com>
 <20200810173431.GA68662@gmail.com>
 <33565447-9b97-a820-bc2c-a4ff53a7675a@virtuozzo.com>
 <20200812175338.GA596568@gmail.com>
 <8f3c9414-9efc-cc01-fb2a-4d83266e96b2@virtuozzo.com>
 <20200814011649.GA611947@gmail.com>
 <0af3f2fa-f2c3-fb7d-b57e-9c41fe94ca58@virtuozzo.com>
 <20200814192102.GA786465@gmail.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <56ed1fb9-4f1f-3528-3f09-78478b9dfcf2@virtuozzo.com>
Date:   Mon, 17 Aug 2020 17:05:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200814192102.GA786465@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 14.08.2020 22:21, Andrei Vagin wrote:
> On Fri, Aug 14, 2020 at 06:11:58PM +0300, Kirill Tkhai wrote:
>> On 14.08.2020 04:16, Andrei Vagin wrote:
>>> On Thu, Aug 13, 2020 at 11:12:45AM +0300, Kirill Tkhai wrote:
>>>> On 12.08.2020 20:53, Andrei Vagin wrote:
>>>>> On Tue, Aug 11, 2020 at 01:23:35PM +0300, Kirill Tkhai wrote:
>>>>>> On 10.08.2020 20:34, Andrei Vagin wrote:
>>>>>>> On Fri, Aug 07, 2020 at 11:47:57AM +0300, Kirill Tkhai wrote:
>>>>>>>> On 06.08.2020 11:05, Andrei Vagin wrote:
>>>>>>>>> On Mon, Aug 03, 2020 at 01:03:17PM +0300, Kirill Tkhai wrote:
>>>>>>>>>> On 31.07.2020 01:13, Eric W. Biederman wrote:
>>>>>>>>>>> Kirill Tkhai <ktkhai@virtuozzo.com> writes:
>>>>>>>>>>>
>>>>>>>>>>>> On 30.07.2020 17:34, Eric W. Biederman wrote:
>>>>>>>>>>>>> Kirill Tkhai <ktkhai@virtuozzo.com> writes:
>>>>>>>>>>>>>
>>>>>>>>>>>>>> Currently, there is no a way to list or iterate all or subset of namespaces
>>>>>>>>>>>>>> in the system. Some namespaces are exposed in /proc/[pid]/ns/ directories,
>>>>>>>>>>>>>> but some also may be as open files, which are not attached to a process.
>>>>>>>>>>>>>> When a namespace open fd is sent over unix socket and then closed, it is
>>>>>>>>>>>>>> impossible to know whether the namespace exists or not.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Also, even if namespace is exposed as attached to a process or as open file,
>>>>>>>>>>>>>> iteration over /proc/*/ns/* or /proc/*/fd/* namespaces is not fast, because
>>>>>>>>>>>>>> this multiplies at tasks and fds number.
>>>>>>>>>>>>>
>>>>>>>>>>>>> I am very dubious about this.
>>>>>>>>>>>>>
>>>>>>>>>>>>> I have been avoiding exactly this kind of interface because it can
>>>>>>>>>>>>> create rather fundamental problems with checkpoint restart.
>>>>>>>>>>>>
>>>>>>>>>>>> restart/restore :)
>>>>>>>>>>>>
>>>>>>>>>>>>> You do have some filtering and the filtering is not based on current.
>>>>>>>>>>>>> Which is good.
>>>>>>>>>>>>>
>>>>>>>>>>>>> A view that is relative to a user namespace might be ok.    It almost
>>>>>>>>>>>>> certainly does better as it's own little filesystem than as an extension
>>>>>>>>>>>>> to proc though.
>>>>>>>>>>>>>
>>>>>>>>>>>>> The big thing we want to ensure is that if you migrate you can restore
>>>>>>>>>>>>> everything.  I don't see how you will be able to restore these files
>>>>>>>>>>>>> after migration.  Anything like this without having a complete
>>>>>>>>>>>>> checkpoint/restore story is a non-starter.
>>>>>>>>>>>>
>>>>>>>>>>>> There is no difference between files in /proc/namespaces/ directory and /proc/[pid]/ns/.
>>>>>>>>>>>>
>>>>>>>>>>>> CRIU can restore open files in /proc/[pid]/ns, the same will be with /proc/namespaces/ files.
>>>>>>>>>>>> As a person who worked deeply for pid_ns and user_ns support in CRIU, I don't see any
>>>>>>>>>>>> problem here.
>>>>>>>>>>>
>>>>>>>>>>> An obvious diffference is that you are adding the inode to the inode to
>>>>>>>>>>> the file name.  Which means that now you really do have to preserve the
>>>>>>>>>>> inode numbers during process migration.
>>>>>>>>>>>
>>>>>>>>>>> Which means now we have to do all of the work to make inode number
>>>>>>>>>>> restoration possible.  Which means now we need to have multiple
>>>>>>>>>>> instances of nsfs so that we can restore inode numbers.
>>>>>>>>>>>
>>>>>>>>>>> I think this is still possible but we have been delaying figuring out
>>>>>>>>>>> how to restore inode numbers long enough that may be actual technical
>>>>>>>>>>> problems making it happen.
>>>>>>>>>>
>>>>>>>>>> Yeah, this matters. But it looks like here is not a dead end. We just need
>>>>>>>>>> change the names the namespaces are exported to particular fs and to support
>>>>>>>>>> rename().
>>>>>>>>>>
>>>>>>>>>> Before introduction a principally new filesystem type for this, can't
>>>>>>>>>> this be solved in current /proc?
>>>>>>>>>
>>>>>>>>> do you mean to introduce names for namespaces which users will be able
>>>>>>>>> to change? By default, this can be uuid.
>>>>>>>>
>>>>>>>> Yes, I mean this.
>>>>>>>>
>>>>>>>> Currently I won't give a final answer about UUID, but I planned to show some
>>>>>>>> default names, which based on namespace type and inode num. Completely custom
>>>>>>>> names for any /proc by default will waste too much memory.
>>>>>>>>
>>>>>>>> So, I think the good way will be:
>>>>>>>>
>>>>>>>> 1)Introduce a function, which returns a hash/uuid based on ino, ns type and some static
>>>>>>>> random seed, which is generated on boot;
>>>>>>>>
>>>>>>>> 2)Use the hash/uuid as default names in newly create /proc/namespaces: pid-{hash/uuid(ino, "pid")}
>>>>>>>>
>>>>>>>> 3)Allow rename, and allocate space only for renamed names.
>>>>>>>>
>>>>>>>> Maybe 2 and 3 will be implemented as shrinkable dentries and non-shrinkable.
>>>>>>>>
>>>>>>>>> And I have a suggestion about the structure of /proc/namespaces/.
>>>>>>>>>
>>>>>>>>> Each namespace is owned by one of user namespaces. Maybe it makes sense
>>>>>>>>> to group namespaces by their user-namespaces?
>>>>>>>>>
>>>>>>>>> /proc/namespaces/
>>>>>>>>>                  user
>>>>>>>>>                  mnt-X
>>>>>>>>>                  mnt-Y
>>>>>>>>>                  pid-X
>>>>>>>>>                  uts-Z
>>>>>>>>>                  user-X/
>>>>>>>>>                         user
>>>>>>>>>                         mnt-A
>>>>>>>>>                         mnt-B
>>>>>>>>>                         user-C
>>>>>>>>>                         user-C/
>>>>>>>>>                                user
>>>>>>>>>                  user-Y/
>>>>>>>>>                         user
>>>>>>>>
>>>>>>>> Hm, I don't think that user namespace is a generic key value for everybody.
>>>>>>>> For generic people tasks a user namespace is just a namespace among another
>>>>>>>> namespace types. For me it will look a bit strage to iterate some user namespaces
>>>>>>>> to build container net topology.
>>>>>>>
>>>>>>> I can’t agree with you that the user namespace is one of others. It is
>>>>>>> the namespace for namespaces. It sets security boundaries in the system
>>>>>>> and we need to know them to understand the whole system.
>>>>>>>
>>>>>>> If user namespaces are not used in the system or on a container, you
>>>>>>> will see all namespaces in one directory. But if the system has a more
>>>>>>> complicated structure, you will be able to build a full picture of it.
>>>>>>>
>>>>>>> You said that one of the users of this feature is CRIU (the tool to
>>>>>>> checkpoint/restore containers)  and you said that it would be good if
>>>>>>> CRIU will be able to collect all container namespaces before dumping
>>>>>>> processes, sockets, files etc. But how will we be able to do this if we
>>>>>>> will list all namespaces in one directory?
>>>>>>
>>>>>> There is no a problem, this looks rather simple. Two cases are possible:
>>>>>>
>>>>>> 1)a container has dedicated namespaces set, and CRIU just has to iterate
>>>>>>   files in /proc/namespaces of root pid namespace of the container.
>>>>>>   The relationships between parents and childs of pid and user namespaces
>>>>>>   are founded via ioctl(NS_GET_PARENT).
>>>>>>   
>>>>>> 2)container has no dedicated namespaces set. Then CRIU just has to iterate
>>>>>>   all host namespaces. There is no another way to do that, because container
>>>>>>   may have any host namespaces, and hierarchy in /proc/namespaces won't
>>>>>>   help you.
>>>>>>
>>>>>>> Here are my thoughts why we need to the suggested structure is better
>>>>>>> than just a list of namespaces:
>>>>>>>
>>>>>>> * Users will be able to understand securies bondaries in the system.
>>>>>>>   Each namespace in the system is owned by one of user namespace and we
>>>>>>>   need to know these relationshipts to understand the whole system.
>>>>>>
>>>>>> Here are already NS_GET_PARENT and NS_GET_USERNS. What is the problem to use
>>>>>> this interfaces?
>>>>>
>>>>> We can use these ioctl-s, but we will need to enumerate all namespaces in
>>>>> the system to build a view of the namespace hierarchy. This will be very
>>>>> expensive. The kernel can show this hierarchy without additional cost.
>>>>
>>>> No. We will have to iterate /proc/namespaces of a specific container to get
>>>> its namespaces. It's a subset of all namespaces in system, and these all the
>>>> namespaces, which are potentially allowed for the container.
>>>
>>> """
>>> Every /proc is related to a pid_namespace, and the pid_namespace
>>> is related to a user_namespace. The items, we show in this
>>> /proc/namespaces/ directory, are the namespaces,
>>> whose user_namespaces are the same as /proc's user_namespace,
>>> or their descendants.
>>> """ // [PATCH 11/23] fs: Add /proc/namespaces/ directory
>>>
>>> This means that if a user want to find out all container namespaces, it
>>> has to have access to the container procfs and the container should
>>> a separate pid namespace.
>>>
>>> I would say these are two big limitations. The first one will not affect
>>> CRIU and I agree CRIU can use this interface in its current form.
>>>
>>> The second one will be still the issue for CRIU. And they both will
>>> affect other users.
>>>
>>> For end users, it will be a pain. They will need to create a pid
>>> namespaces in a specified user-namespace, if a container doesn't have
>>> its own. Then they will need to mount /proc from the container pid
>>> namespace and only then they will be able to enumerate namespaces.
>>
>> In case of a container does not have its own pid namespace, CRIU already
>> sucks. Every file in /proc directory is not reliable after restore,
>> so /proc/namespaces is just one of them. Container, who may access files
>> in /proc, does have to have its own pid namespace.
> 
> Can you be more detailed here? What files are not reliable? And why we
> don't need to think about this use-case? If we have any issues here,
> maybe we need to think how to fix them instead of adding a new one.

Any file in /proc is not reliable. You can't guarantee, the pid you need
at restore time will be free. Simple example: a program reading information
about its threads. It can't believe /proc/XXX/task/YYY/ after restore,
any access will results in error. The same is with other files in /proc.
Why do you require additional guarantees from the only directory in /proc?
This is really strange approach.

The issue is already fixed, and the fix is called pid namespace.

Did you get my proposition? Any container will rename namespaces like it wants
in its own /proc. Current patchset does not contain this, but I wrote this in
replies. Maybe you missed that.

>>
>> Even if we imagine an unreal situation, when the rest of /proc files are reliable,
>> sub-directories won't help in this case also. In case of we introduce user ns
>> hierarchy, the namespaces names above container's user ns, will still
>> be unchangeble:
>>
>> /proc/namespaces/parent_user_ns/container_user_ns/...
>>
>> Path to container_user_ns is fixed. If container accesses /proc/namespace/parent_user_ns
>> file, it will suck a pow after restore again.
> 
> 
> In case of user ns hierarchy, a container will see only its sub-tree and
> it will not know a name of its root namespace. It will look like this:
> 
> From host:
> /proc/namespaces/user_ns_ct1/user1
>                              user2
> 
> /proc/namespaces/user_ns_ct2/user1
>                              user2
> 
> From ct1:
> /proc/namespaces/user1
>                  user2

This is not expedient. You can't reliable restore certain pid in the same pid namespace,
which is very likely used information.

But you request this strange functionality from rare used /proc/namespaces,
which is only for system utils. This is really strange and useless.

Hierarchy during user namespace is completely crap IMO. The world does not
spinning around CRIU. It will be really strange to analyze container net
namespaces topology (say, where veth is connected) iterating over user
namespaces directories. What is this information for? Nobody needs it.
It is just bad design and ugly interface, which makes users to say curses
for inventor of such the interface.

> And now could you explain how you are going to solve this problem with
> your interface?

I don't give more guarantees, than guarantees during pid restore.
What do you have on restore w/o pid namespace now?! If there is free pid,
you restore you program with this pid number. Otherwise, you restore with
another pid, or do not restore. The same is with namespace aliases. No more.

>>
>> So, the suggested sub-directories just don't work.
> 
> I am sure it will work.
> 
>>
>>> But to build a view of a hierarchy of these namespaces, they will need to
>>> use a binary tool which will open each of these namespaces, call
>>> NS_GET_PARENT and NS_GET_USERNS ioctl-s and build a tree.
>>
>> Yes, it's the same way we have on a construction of tasks tree.
>>
>> Linear /proc/namespaces is rather natural way. The sense is "all namespaces,
>> which are available for tasks in this /proc directory".
>>
>> Grouping by user ns directories looks odd. CRIU is only util, who needs
>> such the grouping. But even for CRIU performance advantages look dubious.
> 
> I can't agree with you here. This isn't about CRIU. Grouping by user ns
> doesn't look odd for me, because this is how namespaces are grouped in
> the kernel.

Nope. Namespaces are not grouped by user namespace hierarchy. Pid and
user namespace use their own parent/child grouping, all another namespaces
types are linked in double linked lists.

>>
>> For another utils, the preference of user ns grouping over another hierarchy
>> namespaces looks just weirdy weird.
>>
>> I can agree with an idea of separate top-level sub-directories for different
>> namespaces types like:
>>
>> /proc/namespaces/uts/
>> /proc/namespaces/user/
>> /proc/namespaces/pid/
>> ...
>>
>> But grouping of all another namespaces by user ns sub-directories absolutely
>> does not look sane for me.
> 
> I think we are stuck here and we need to ask an opinion of someone else.
> 
>>  
>>>>
>>>>>>
>>>>>>> * This is simplify collecting namespaces which belong to one container.
>>>>>>>
>>>>>>> For example, CRIU collects all namespaces before dumping file
>>>>>>> descriptors. Then it collects all sockets with socket-diag in network
>>>>>>> namespaces and collects mount points via /proc/pid/mountinfo in mount
>>>>>>> namesapces. Then these information is used to dump socket file
>>>>>>> descriptors and opened files.
>>>>>>
>>>>>> This is just the thing I say. This allows to avoid writing recursive dump.
>>>>>
>>>>> I don't understand this. How are you going to collect namespaces in CRIU
>>>>> without knowing which are used by a dumped container?
>>>>
>>>> My patchset exports only the namespaces, which are allowed for a specific
>>>> container, and no more above this. All exported namespaces are alive,
>>>> so someone holds a reference on every of it. So they are used.
>>>>
>>>> It seems you haven't understood the way I suggested here. See patch [11/23]
>>>> for the details. It's about permissions, and the subset of exported namespaces
>>>> is formalized there.
>>>
>>> Honestly, I have not read all patches in this series and you didn't
>>> describe this behavior in the cover letter. Thank you for pointing out
>>> to the 11 patch, but I still think it doesn't solve the problem
>>> completely. More details is in the comment which is a few lines above
>>> this one.
>>>
>>>>
>>>>>> But this has nothing about advantages of hierarchy in /proc/namespaces.
>>>
>>> Yes, it has. For example, in cases when a container doesn't have its own
>>> pid namespaces.
>>>
>>>>>
>>>>> Really? You said that you implemented this series to help CRIU dumping
>>>>> namespaces. I think we need to implement the CRIU part to prove that
>>>>> this interface is usable for this case. Right now, I have doubts about
>>>>> this.
>>>>
>>>> Yes, really. See my comment above and patch [11/23].
>>>>
>>>>>>
>>>>>>> * We are going to assign names to namespaces. But this means that we
>>>>>>> need to guarantee that all names in one directory are unique. The
>>>>>>> initial proposal was to enumerate all namespaces in one proc directory,
>>>>>>> that means names of all namespaces have to be unique. This can be
>>>>>>> problematic in some cases. For example, we may want to dump a container
>>>>>>> and then restore it more than once on the same host. How are we going to
>>>>>>> avoid namespace name conficts in such cases?
>>>>>>
>>>>>> Previous message I wrote about .rename of proc files, Alexey Dobriyan
>>>>>> said this is not a taboo. Are there problem which doesn't cover the case
>>>>>> you point?
>>>>>
>>>>> Yes, there is. Namespace names will be visible from a container, so they
>>>>> have to be restored. But this means that two containers can't be
>>>>> restored from the same snapshot due to namespace name conflicts.
>>>>>
>>>>> But if we will show namespaces how I suggest, each container will see
>>>>> only its sub-tree of namespaces and we will be able to specify any name
>>>>> for the container root user namespace.
>>>>
>>>> Now I'm sure you missed my idea. See proc_namespaces_readdir() in [11/23].
>>>>
>>>> I do export sub-tree.
>>>
>>> I got your idea, but it is unclear how your are going to avoid name
>>> conflicts.
>>>
>>> In the root container, you will show all namespaces in the system. These
>>> means that all namespaces have to have unique names. This means we will
>>> not able to restore two containers from the same snapshot without
>>> renaming namespaces. But we can't change namespace names, because they
>>> are visible from containers and container processes can use them.
>>
>> Grouping by user ns sub-directories does not solve a problem with names
>> of containers w/o own pid ns. See above.
> 
> It solves, you just doesn't understand how it works. See above.
> 
>>
>>>>
>>>>>>
>>>>>>> If we will have per-user-namespace directories, we will need to
>>>>>>> guarantee that names are unique only inside one user namespace.
>>>>>>
>>>>>> Unique names inside one user namespace won't introduce a new /proc
>>>>>> mount. You can't pass a sub-directory of /proc/namespaces/ to a specific
>>>>>> container. To give a virtualized name you have to have a dedicated pid ns.
>>>>>>
>>>>>> Let we have in one /proc mount:
>>>>>>
>>>>>> /mnt1/proc/namespaces/userns1/.../[namespaceX_name1 -- inode XXX]
>>>>>>
>>>>>> In another another /proc mount we have:
>>>>>>
>>>>>> /mnt2/proc/namespaces/userns1/.../[namespaceX_name1_synonym -- inode XXX]
>>>>>>
>>>>>> The virtualization is made per /proc (i.e., per pid ns). Container should
>>>>>> receive either /mnt1/proc or /mnt2/proc on restore as it's /proc.
>>>>>>
>>>>>> There is no a sense of directory hierarchy for virtualization, since
>>>>>> you can't use specific sub-directory as a root directory of /proc/namespaces
>>>>>> to a container. You still have to introduce a new pid ns to have virtualized
>>>>>> /proc.
>>>>>
>>>>> I think we can figure out how to implement this. As the first idea, we
>>>>> can use the same way how /proc/net is implemented.
>>>>>
>>>>>>
>>>>>>> * With the suggested structure, for each user namepsace, we will show
>>>>>>>   only its subtree of namespaces. This looks more natural than
>>>>>>>   filltering content of one directory.
>>>>>>
>>>>>> It's rather subjectively I think. /proc is related to pid ns, and user ns
>>>>>> hierarchy does not look more natural for me.
>>>>>
>>>>> or /proc is wrong place for this
