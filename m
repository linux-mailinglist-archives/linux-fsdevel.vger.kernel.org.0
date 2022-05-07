Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFB351E682
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 May 2022 12:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446289AbiEGKrX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 May 2022 06:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446287AbiEGKrF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 May 2022 06:47:05 -0400
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52A8562CD
        for <linux-fsdevel@vger.kernel.org>; Sat,  7 May 2022 03:43:06 -0700 (PDT)
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <lnx-linux-fsdevel@m.gmane-mx.org>)
        id 1nnHtv-0005vl-93
        for linux-fsdevel@vger.kernel.org; Sat, 07 May 2022 12:43:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-fsdevel@vger.kernel.org
From:   =?UTF-8?Q?Jean-Pierre_Andr=c3=a9?= <jean-pierre.andre@wanadoo.fr>
Subject: Re: [PATCH v4 1/3] FUSE: Implement atomic lookup + create
Date:   Sat, 7 May 2022 12:42:56 +0200
Message-ID: <a712f535-7e34-4967-d335-f3680f9c4b6f@wanadoo.fr>
References: <20220502102521.22875-1-dharamhans87@gmail.com>
 <20220502102521.22875-2-dharamhans87@gmail.com> <YnGIUOP2BezDAb1k@redhat.com>
 <CACUYsyGoX+o19u41cZyF92eDBO-9rFN_EEWBvWBGrEMuNn29Mw@mail.gmail.com>
 <YnKR9CFYPXT1bM1F@redhat.com>
 <CACUYsyG+QRyObnD5eaD8pXygwBRRcBrGHLCUZb2hmMZbFOfFTg@mail.gmail.com>
 <YnPeqPTny1Eeat9r@redhat.com>
 <CACUYsyG9mKQK+pWcAcWFEtC2ad0_OBU6NZgBC965ZxQy5_JiXQ@mail.gmail.com>
 <YnUsw4O3F4wgtxTr@redhat.com> <78c2beed-b221-71b4-019f-b82522d98f1e@ddn.com>
 <YnVV2Rr4NMyFj5oF@redhat.com> <90fbe06b-4af7-c9ce-4aca-393aed709722@ddn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
In-Reply-To: <90fbe06b-4af7-c9ce-4aca-393aed709722@ddn.com>
Cc:     fuse-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Bernd Schubert wrote on 5/6/22 8:45 PM:
> 
> 
> On 5/6/22 19:07, Vivek Goyal wrote:
>> On Fri, May 06, 2022 at 06:41:17PM +0200, Bernd Schubert wrote:
>>>
>>>
>>> On 5/6/22 16:12, Vivek Goyal wrote:
>>>
>>> [...]
>>>
>>>> On Fri, May 06, 2022 at 11:04:05AM +0530, Dharmendra Hans wrote:
>>>
>>>>
>>>> Ok, looks like your fuse file server is talking to a another file
>>>> server on network and that's why you are mentioning two network trips.
>>>>
>>>> Let us differentiate between two things first.
>>>>
>>>> A. FUSE protocol semantics
>>>> B. Implementation of FUSE protocl by libfuse.
>>>>
>>>> I think I am stressing on A and you are stressing on B. I just want
>>>> to see what's the difference between FUSE_CREATE and FUSE_ATOMIC_CREATE
>>>> from fuse protocol point of view. Again look at from kernel's point of
>>>> view and don't worry about libfuse is going to implement it.
>>>> Implementations can vary.
>>>
>>> Agreed, I don't think we need to bring in network for the kernel to 
>>> libfuse
>>> API.
>>>
>>>>
>>>>   From kernel's perspective FUSE_CREATE is supposed to create + open a
>>>> file. It is possible file already exists. Look at 
>>>> include/fuse_lowlevel.h
>>>> description for create().
>>>>
>>>>           /**
>>>>            * Create and open a file
>>>>            *
>>>>            * If the file does not exist, first create it with the 
>>>> specified
>>>>            * mode, and then open it.
>>>>            */
>>>>
>>>> I notice that fuse is offering a high level API as well as low level
>>>> API. I primarily know about low level API. To me these are just two
>>>> different implementation but things don't change how kernel sends
>>>> fuse messages and what it expects from server in return.
>>>>
>>>> Now with FUSE_ATOMIC_CREATE, from kernel's perspective, only difference
>>>> is that in reply message file server will also indicate if file was
>>>> actually created or not. Is that right?
>>>>
>>>> And I am focussing on this FUSE API apsect. I am least concerned at
>>>> this point of time who libfuse decides to actually implement 
>>>> FUSE_CREATE
>>>> or FUSE_ATOMIC_CREATE etc. You might make a single call in libfuse
>>>> server (instead of two) and that's performance optimization in libfuse.
>>>> Kernel does not care how many calls did you make in file server to
>>>> implement FUSE_CREATE or FUSE_ATOMIC_CREATE. All it cares is that
>>>> create and open the file.
>>>>
>>>> So while you might do things in more atomic manner in file server and
>>>> cut down on network traffic, kernel fuse API does not care. All it 
>>>> cares
>>>> about is create + open a file.
>>>>
>>>> Anyway, from kernel's perspective, I think you should be able to
>>>> just use FUSE_CREATE and still be do "lookup + create + open".
>>>> FUSE_ATOMIC_CREATE is just allows one additional optimization so
>>>> that you know whether to invalidate parent dir's attrs or not.
>>>>
>>>> In fact kernel is not putting any atomicity requirements as well on
>>>> file server. And that's why I think this new command should probably
>>>> be called FUSE_CREATE_EXT because it just sends back additional
>>>> info.
>>>>
>>>> All the atomicity stuff you have been describing is that you are
>>>> trying to do some optimizations in libfuse implementation to implement
>>>> FUSE_ATOMIC_CREATE so that you send less number of commands over
>>>> network. That's a good idea but fuse kernel API does not require you
>>>> do these atomically, AFAICS.
>>>>
>>>> Given I know little bit of fuse low level API, If I were to implement
>>>> this in virtiofs/passthrough_ll.c, I probably will do following.
>>>>
>>>> A. Check if caller provided O_EXCL flag.
>>>> B. openat(O_CREAT | O_EXCL)
>>>> C. If success, we created the file. Set file_created = 1.
>>>>
>>>> D. If error and error != -EEXIST, send error back to client.
>>>> E. If error and error == -EEXIST, if caller did provide O_EXCL flag,
>>>>      return error.
>>>> F. openat() returned -EEXIST and caller did not provide O_EXCL flag,
>>>>      that means file already exists.  Set file_created = 0.
>>>> G. Do lookup() etc to create internal lo_inode and stat() of file.
>>>> H. Send response back to client using fuse_reply_create().
>>>> This is one sample implementation for fuse lowlevel API. There could
>>>> be other ways to implement. But all that is libfuse + filesystem
>>>> specific and kernel does not care how many operations you use to
>>>> complete and what's the atomicity etc. Of course less number of
>>>> operations you do better it is.
>>>>
>>>> Anyway, I think I have said enough on this topic. IMHO, FUSE_CREATE
>>>> descritpion (fuse_lowlevel.h) already mentions that "If the file 
>>>> does not
>>>> exist, first create it with the specified mode and then open it". That
>>>> means intent of protocol is that file could already be there as well.
>>>> So I think we probably should implement this optimization (in kernel)
>>>> using FUSE_CREATE command and then add FUSE_CREATE_EXT to add 
>>>> optimization
>>>> about knowing whether file was actually created or not.
>>>>
>>>> W.r.t libfuse optimizations, I am not sure why can't you do 
>>>> optimizations
>>>> with FUSE_CREATE and why do you need FUSE_CREATE_EXT necessarily. If
>>>> are you worried that some existing filesystems will break, I think
>>>> you can create an internal helper say fuse_create_atomic() and then
>>>> use that if filesystem offers it. IOW, libfuse will have two
>>>> ways to implement FUSE_CREATE. And if filesystem offers a new way which
>>>> cuts down on network traffic, libfuse uses more efficient method. We
>>>> should not have to change kernel FUSE API just because libfuse can
>>>> do create + open operation more efficiently.
>>>
>>> Ah right, I like this. As I had written before, the first patch 
>>> version was
>>> using FUSE_CREATE and I was worried to break something. Yes, it 
>>> should be
>>> possible split into lookup+create on the libfuse side. That being said,
>>> libfuse will need to know which version it is - there might be an old 
>>> kernel
>>> sending the non-optimized version - libfuse should not do another lookup
>>> then.
>>
>> I am confused about one thing. For FUSE_CREATE command, how does it
>> matter whether kernel has done lookup() before sending FUSE_CREATE. All
>> FUSE_CREATE seems to say that crate a file (if it does not exist already)
>> and then open it and return file handle as well as inode attributes. It
>> does not say anything about whether a LOOKUP has already been done
>> by kernel or not.
>>
>> It looks like you are assuming that if FUSE_CREATE is coming, that
>> means client has already done FUSE_LOOKUP. So there is something we
>> are not on same page about.
>>
>> I looked at fuse_lowlevel API and passthrough_ll.c and there is no
>> assumption whether FUSE_LOOKUP has already been called by client
>> before calling FUSE_CREATE. Similarly, I looked at virtiofs code
>> and I can't see any such assumption there as well.
> 
> The current linux kernel code does this right now, skipping the lookup 
> just changes behavior.  Personally I would see it as bug if the 
> userspace implementation does not handle EEXIST for FUSE_CREATE. 
> Implementation developer and especially users might see it differently 
> if a kernel update breaks/changes things out of the sudden. 
> passthrough_ll.c is not the issue here, it handles it correctly, but 
> what about the XYZ other file systems out there - do you want to check 
> them one by one, including closed source ones? And wouldn't even a 
> single broken application count as regression?
> 
>>
>> https://github.com/qemu/qemu/blob/master/tools/virtiofsd/passthrough_ll.c
>>
>> So I am sort of lost. May be you can help me understsand this.
> 
> I guess it would be more interesting to look at different file systems 
> that are not overlay based. Like ntfs-3g - I have not looked at the code 
> yet, but especially disk based file system didn't have a reason so far 
> to handle EEXIST. And

AFAIK ntfs-3g proper does not keep a context across calls and does
not know what LOOKUP was preparing a CREATE. However this may have
consequences in the high level of libfuse for managing the file tree.

The kernel apparently issues a LOOKUP to decide whether issuing a
CREATE (create+open) or an OPEN. If it sent blindly a CREATE,
ntfs-3g would return EEXIST if the name was already present in
the directory.

For a test, can you suggest a way to force ignore of such lookup
within libfuse, without applying your kernel patches ? Is there a
way to detect the purpose of a lookup ? (A possible way is to
hardcode a directory inode within which the lookups return ENOENT).

> 
>>
>>> Now there is 'fi.flags = arg->flags', but these are already taken by
>>> open/fcntl flags - I would not feel comfortable to overload these. At 
>>> best,
>>> struct fuse_create_in currently had a padding field, we could convert 
>>> these
>>> to something like 'ext_fuse_open_flags' and then use it for fuse 
>>> internal
>>> things. Difficulty here is that I don't know if all kernel 
>>> implementations
>>> zero the struct (BSD, MacOS), so I guess we would need to negotiate at
>>> startup/init time and would need another main feature flag? And with 
>>> that
>>> I'm not be sure anymore if the result would be actually more simple than
>>> what we have right now for the first patch.
>>
>> If FUSE_CREATE indeed has a dependency on FUSE_LOOKUP have been called
>> before that, then I agree that we can't implement new semantics with
>> FUSE_CREATE and we will have to introduce a new op say
>> FUSE_ATOMIC_CREATE/FUSE_LOOKUP_CREATE/FUSE_CREATE_EXT.
>>
>> But looking at fuse API, I don't see FUSE_CREATE ever guaranteeing that
>> a FUSE_LOOKUP has been done before this.
> 
> It is not in written document, but in the existing (linux) kernel behavior.
> 
> 
> You can look up "regressions due to 64-bit ext4 directory cookies" - 
> patches from me had been once already the reason for accidental breakage 
> and back that time I did not even have the slightest chance to predict 
> it, as glusterfs was relying on max 32bit telldir results and using the 
> other 32bit for its own purposes. Kernel behavior changed and 
> application broke, even though the application was relying on non-posix 
> behavior. In case of fuse there is no document like posix, but just API 
> headers and current behavior...
> 
> Thanks,
> Bernd
> 
> 
> 
> 
> 


