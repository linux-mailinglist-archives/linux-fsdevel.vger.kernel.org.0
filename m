Return-Path: <linux-fsdevel+bounces-38174-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9D59FD7AD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Dec 2024 21:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE3E73A2665
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Dec 2024 20:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BD31527B4;
	Fri, 27 Dec 2024 20:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="wEl4zUGK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NveJNyjq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42397A920
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Dec 2024 20:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735331567; cv=none; b=E5DYZd+qIQPZ+eU/Tgr53qpp0xA0sRQlHSBiHMC1e8Qd5ltOj4lFNrLy4I8vyGeoFEQk9FM8A5/krzd0iB/mLihZC9X+2DK9IIhsgUarb9c71IZgR1z6g64p1UgWuUiB/kp4uf0dsVOxyZL70b3dH4hK8n3Wg6TEjmUXy+GrP5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735331567; c=relaxed/simple;
	bh=k2or+EoNFYiFLVimva1STw2v53pIauJBqdLYy1jp2t0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IsmR6zXnhG/TbqFWoNEdiBlkwu4KSjTADfGkF4I8awgJ6zO/mVFM5hfz3CGbemY85LORDLqbJ9dUd5v3V6QdcmDO9KifSnbxMBUtXwRuvxScVMP2c39frM5cXRdXEYgvKN8WUPXCMxI4y20UQfQU0S9PWN5K9SMfHCdNtlKDioM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=wEl4zUGK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NveJNyjq; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 52C3F138017E;
	Fri, 27 Dec 2024 15:32:44 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 27 Dec 2024 15:32:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1735331564;
	 x=1735417964; bh=WrgE2vM9ya0b3ezY2PMB/tVUHQkB8Vw4qxsTL0C8BEQ=; b=
	wEl4zUGKqjdx/PibwZ8qWgB2M2ktXIawA6ANahTK0t6rzcyLX74+LuIhBM45VjGp
	SmsnvunmVS/69+csv87Ww6qet5/3+0U3L8wMvl6p4qvxhZDiAPbvIHcvKa/7Qv1y
	/MMWcezRN2/A0S8THn7L8GZsVBTOLEoXJcj14a+src5hRYPpNzJrKvyKTZs/dF7S
	s9BGlkpBZu0Qe9GTnX8wPDubuX9QmelpcC97XqCI9WPgmst3HAOrDQ10lfSU5cvY
	LdRJM4sFrs9kuL/1XTM/nY1Se1NTlIF97f44BR5MJZLDCItUV4RtmOL6tvOxoIiG
	bD/Mkdpn6ak88Hsuqs26vA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735331564; x=
	1735417964; bh=WrgE2vM9ya0b3ezY2PMB/tVUHQkB8Vw4qxsTL0C8BEQ=; b=N
	veJNyjqXGDR34xWFkRvxGS2BUxU75rnwtVJYT+9n4HvZuW7gSrYp7MDRzHPAFwt0
	vE15wdU6qZ6fWSUYnud/iHVee6H/56sLYNAlxP1MMkRbRfOM3tqSfRlyugLM+Jb1
	9KGR9uRU7EP3Yv0UMvByJdJuc4AQd218Zw6C6Nop5yoPsfTKfkQXEyxvcUg2aARc
	+EX+3Tq1b68LyNnAU5HN8stxngiNr6m6FJp+RubZEkNCLVSRoMWDYV2jyWHQsulY
	MqeXhafUWor/xy5eO8cZArjTi7iHjDVF8f1Z4JCFBaMqi69V9m1/krdLXf9tXzp7
	dfonYuZ8LJNTBiBzyqdjA==
X-ME-Sender: <xms:6g5vZzph4GCVoS_BHvn2PNrWNrsZ0t8mYyLuh0aU9a--ZfB6ly3E2A>
    <xme:6g5vZ9qdUQw8agIVjtvCX2LS-yqbLYy9I2pwif7Cgj5mBoVdASbn5r75i5LjoCwHe
    W3VaxFyMze5AmW0>
X-ME-Received: <xmr:6g5vZwNq6hq9KpfbDs85SaqCUpNcibHcIQPqTP5GL8C0uxACBqVcOEold7QHi5Ma9vUvgtSRGw2B82i7x3uF7tBKva7Qmv1ZB9_ad779q3PNlikXBWfC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvtddgudefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddv
    jeenucfhrhhomhepuegvrhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusg
    gvrhhtsehfrghsthhmrghilhdrfhhmqeenucggtffrrghtthgvrhhnpeduleefvdduvedu
    veelgeelffffkedukeegveelgfekleeuvdehkeehheehkefhfeenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghr
    thesfhgrshhtmhgrihhlrdhfmhdpnhgspghrtghpthhtohepudefpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehjohgrnhhnvghlkhhoohhnghesghhmrghilhdrtghomhdp
    rhgtphhtthhopehshhgrkhgvvghlrdgsuhhttheslhhinhhugidruggvvhdprhgtphhtth
    hopegurghvihgusehrvgguhhgrthdrtghomhdprhgtphhtthhopeiiihihsehnvhhiughi
    rgdrtghomhdprhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpth
    htoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehjvghffhhlvgiguheslhhinhhugidrrghlihgsrggsrgdrtghomhdprhgtph
    htthhopehjohhsvghfsehtohigihgtphgrnhgurgdrtghomhdprhgtphhtthhopehlihhn
    uhigqdhmmheskhhvrggtkhdrohhrgh
X-ME-Proxy: <xmx:6g5vZ25Btaq0umAXlrW1pgS8EfkdHM3ZevJTZpuwDoVTms8hFjDvSA>
    <xmx:6g5vZy50oXl6Ye4H93UM5SxEfdc8e6_lNTuGeUW5VASiyOlMS0p-mQ>
    <xmx:6g5vZ-hnblcwOKnz0FgFwDwwnKEHwx8G0Yw3PC20uN3gqrYV6XCCJQ>
    <xmx:6g5vZ04_2tebxozdffvaKLMrKdqY1L4g0GhNipe0U_aH3JtIhC-KYw>
    <xmx:7A5vZ1KZGVG1OW27g16se75MiObZXl16UCJhGkTkc5sal-5P6UmNniGu>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Dec 2024 15:32:41 -0500 (EST)
Message-ID: <934dc31b-e38a-4506-a2eb-59a67f544305@fastmail.fm>
Date: Fri, 27 Dec 2024 21:32:39 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
To: Joanne Koong <joannelkoong@gmail.com>,
 Shakeel Butt <shakeel.butt@linux.dev>
Cc: David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
 miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
 jefflexu@linux.alibaba.com, josef@toxicpanda.com, linux-mm@kvack.org,
 kernel-team@meta.com, Matthew Wilcox <willy@infradead.org>,
 Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@kernel.org>
References: <ukkygby3u7hjhk3cgrxkvs6qtmlrigdwmqb5k22ru3qqn242au@s4itdbnkmvli>
 <CAJnrk1bRk9xkVkMg8twaNi-gWBRps7A6HubMivKBHQiHzf+T8w@mail.gmail.com>
 <2bph7jx4hvhxpgp77shq2j7mo4xssobhqndw5v7hdvbn43jo2w@scqly5zby7bm>
 <71d7ac34-a5e5-4e59-802b-33d8a4256040@redhat.com>
 <b16bff80-758c-451b-a96c-b047f446f992@fastmail.fm>
 <9404aaa2-4fc2-4b8b-8f95-5604c54c162a@redhat.com>
 <qsytb6j4j6v7kzmiygmmsrdgfkwszpjudvwbq5smkhowfd75dd@beks3genju7x>
 <3f3c7254-7171-4987-bb1b-24c323e22a0f@redhat.com>
 <kyn5ji73biubd5fqbpycu4xsheqvomb3cu45ufw7u2paj5rmhr@bhnlclvuujcu>
 <c91b6836-fa30-44a9-bc15-afc829acaba9@redhat.com>
 <h3jbqkgaatads2732mzoyucjmin6rakzsvkjvdaw2xzjlieapc@k6r7xywaeozg>
 <CAJnrk1YwNw7C=EMfKQzN88Zq_2Qih5Te_bfkeaOf=tG+L3u9eA@mail.gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJnrk1YwNw7C=EMfKQzN88Zq_2Qih5Te_bfkeaOf=tG+L3u9eA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 12/27/24 21:08, Joanne Koong wrote:
> On Thu, Dec 26, 2024 at 12:13 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
>>
>> On Tue, Dec 24, 2024 at 01:37:49PM +0100, David Hildenbrand wrote:
>>> On 23.12.24 23:14, Shakeel Butt wrote:
>>>> On Sat, Dec 21, 2024 at 05:18:20PM +0100, David Hildenbrand wrote:
>>>> [...]
>>>>>
>>>>> Yes, so I can see fuse
>>>>>
>>>>> (1) Breaking memory reclaim (memory cannot get freed up)
>>>>>
>>>>> (2) Breaking page migration (memory cannot be migrated)
>>>>>
>>>>> Due to (1) we might experience bigger memory pressure in the system I guess.
>>>>> A handful of these pages don't really hurt, I have no idea how bad having
>>>>> many of these pages can be. But yes, inherently we cannot throw away the
>>>>> data as long as it is dirty without causing harm. (maybe we could move it to
>>>>> some other cache, like swap/zswap; but that smells like a big and
>>>>> complicated project)
>>>>>
>>>>> Due to (2) we turn pages that are supposed to be movable possibly for a long
>>>>> time unmovable. Even a *single* such page will mean that CMA allocations /
>>>>> memory unplug can start failing.
>>>>>
>>>>> We have similar situations with page pinning. With things like O_DIRECT, our
>>>>> assumption/experience so far is that it will only take a couple of seconds
>>>>> max, and retry loops are sufficient to handle it. That's why only long-term
>>>>> pinning ("indeterminate", e.g., vfio) migrate these pages out of
>>>>> ZONE_MOVABLE/MIGRATE_CMA areas in order to long-term pin them.
>>>>>
>>>>>
>>>>> The biggest concern I have is that timeouts, while likely reasonable it many
>>>>> scenarios, might not be desirable even for some sane workloads, and the
>>>>> default in all system will be "no timeout", letting the clueless admin of
>>>>> each and every system out there that might support fuse to make a decision.
>>>>>
>>>>> I might have misunderstood something, in which case I am very sorry, but we
>>>>> also don't want CMA allocations to start failing simply because a network
>>>>> connection is down for a couple of minutes such that a fuse daemon cannot
>>>>> make progress.
>>>>>
>>>>
>>>> I think you have valid concerns but these are not new and not unique to
>>>> fuse. Any filesystem with a potential arbitrary stall can have similar
>>>> issues. The arbitrary stall can be caused due to network issues or some
>>>> faultly local storage.
>>>
>>> What concerns me more is that this is can be triggered by even unprivileged
>>> user space, and that there is no default protection as far as I understood,
>>> because timeouts cannot be set universally to a sane defaults.
>>>
>>> Again, please correct me if I got that wrong.
>>>
>>
>> Let's route this question to FUSE folks. More specifically: can an
>> unprivileged process create a mount point backed by itself, create a
>> lot of dirty (bound by cgroup) and writeback pages on it and let the
>> writeback pages in that state forever?
>>
>>>
>>> BTW, I just looked at NFS out of interest, in particular
>>> nfs_page_async_flush(), and I spot some logic about re-dirtying pages +
>>> canceling writeback. IIUC, there are default timeouts for UDP and TCP,
>>> whereby the TCP default one seems to be around 60s (* retrans?), and the
>>> privileged user that mounts it can set higher ones. I guess one could run
>>> into similar writeback issues?
>>
>> Yes, I think so.
>>
>>>
>>> So I wonder why we never required AS_WRITEBACK_INDETERMINATE for nfs?
>>
>> I feel like INDETERMINATE in the name is the main cause of confusion.
>> So, let me explain why it is required (but later I will tell you how it
>> can be avoided). The FUSE thread which is actively handling writeback of
>> a given folio can cause memory allocation either through syscall or page
>> fault. That memory allocation can trigger global reclaim synchronously
>> and in cgroup-v1, that FUSE thread can wait on the writeback on the same
>> folio whose writeback it is supposed to end and cauing a deadlock. So,
>> AS_WRITEBACK_INDETERMINATE is used to just avoid this deadlock.
>>
>> The in-kernel fs avoid this situation through the use of GFP_NOFS
>> allocations. The userspace fs can also use a similar approach which is
>> prctl(PR_SET_IO_FLUSHER, 1) to avoid this situation. However I have been
>> told that it is hard to use as it is per-thread flag and has to be set
>> for all the threads handling writeback which can be error prone if the
>> threadpool is dynamic. Second it is very coarse such that all the
>> allocations from those threads (e.g. page faults) become NOFS which
>> makes userspace very unreliable on highly utilized machine as NOFS can
>> not reclaim potentially a lot of memory and can not trigger oom-kill.
>>
>>> Not
>>> sure if I grasped all details about NFS and writeback and when it would
>>> redirty+end writeback, and if there is some other handling in there.
>>>
>> [...]
>>>>
>>>> Please note that such filesystems are mostly used in environments like
>>>> data center or hyperscalar and usually have more advanced mechanisms to
>>>> handle and avoid situations like long delays. For such environment
>>>> network unavailability is a larger issue than some cma allocation
>>>> failure. My point is: let's not assume the disastrous situaion is normal
>>>> and overcomplicate the solution.
>>>
>>> Let me summarize my main point: ZONE_MOVABLE/MIGRATE_CMA must only be used
>>> for movable allocations.
>>>
>>> Mechanisms that possible turn these folios unmovable for a
>>> long/indeterminate time must either fail or migrate these folios out of
>>> these regions, otherwise we start violating the very semantics why
>>> ZONE_MOVABLE/MIGRATE_CMA was added in the first place.
>>>
>>> Yes, there are corner cases where we cannot guarantee movability (e.g., OOM
>>> when allocating a migration destination), but these are not cases that can
>>> be triggered by (unprivileged) user space easily.
>>>
>>> That's why FOLL_LONGTERM pinning does exactly that: even if user space would
>>> promise that this is really only "short-term", we will treat it as "possibly
>>> forever", because it's under user-space control.
>>>
>>>
>>> Instead of having more subsystems violate these semantics because
>>> "performance" ... I would hope we would do better. Maybe it's an issue for
>>> NFS as well ("at least" only for privileged user space)? In which case,
>>> again, I would hope we would do better.
>>>
>>>
>>> Anyhow, I'm hoping there will be more feedback from other MM folks, but
>>> likely right now a lot of people are out (just like I should ;) ).
>>>
>>> If I end up being the only one with these concerns, then likely people can
>>> feel free to ignore them. ;)
>>
>> I agree we should do better but IMHO it should be an iterative process.
>> I think your concerns are valid, so let's push the discussion towards
>> resolving those concerns. I think the concerns can be resolved by better
>> handling of lifetime of folios under writeback. The amount of such
>> folios is already handled through existing dirty throttling mechanism.
>>
>> We should start with a baseline i.e. distribution of lifetime of folios
>> under writeback for traditional storage devices (spinning disk and SSDs)
>> as we don't want an unrealistic goal for ourself. I think this data will
>> drive the appropriate timeout values (if we decide timeout based
>> approach is the right one).
>>
>> At the moment we have timeout based approach to limit the lifetime of
>> folios under writeback. Any other ideas?
> 
> I don't see any other approach that would handle splice, other than
> modifying the splice code to prevent the underlying buf->page from
> being migrated while it's being copied out, which seems non-viable to
> consider. The other alternatives I see are to either a) do the extra
> temp page copying for splice and "abort" the writeback if migration is
> triggered or b) gate this to only apply to servers running as
> privileged. I assume the majority of use cases do use splice, in which
> case a) would be pointless and would make the internal logic more
> complicated (eg we would still need the rb tree and would now need to
> check writeback against the folio writeback state or the rb tree,
> etc). I'm not sure how useful this would be either if this is just
> gated to privileged servers.


I'm not so sure about that majority of unprivileged servers. 
Try this patch and then run an unprivileged process.

diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index ee0b3b1d0470..adebfbc03d4c 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -3588,6 +3588,7 @@ static int _fuse_session_receive_buf(struct fuse_session *se,
                        res = fcntl(llp->pipe[0], F_SETPIPE_SZ, bufsize);
                        if (res == -1) {
                                llp->can_grow = 0;
+                               fuse_log(FUSE_LOG_ERR, "cannot grow pipe\n");
                                res = grow_pipe_to_max(llp->pipe[0]);
                                if (res > 0)
                                        llp->size = res;
@@ -3678,6 +3679,7 @@ static int _fuse_session_receive_buf(struct fuse_session *se,
 
        } else {
                /* Don't overwrite buf->mem, as that would cause a leak */
+               fuse_log(FUSE_LOG_WARNING, "Using splice\n");
                buf->fd = tmpbuf.fd;
                buf->flags = tmpbuf.flags;
        }
@@ -3687,6 +3689,7 @@ static int _fuse_session_receive_buf(struct fuse_session *se,
 
 fallback:
 #endif
+       fuse_log(FUSE_LOG_WARNING, "Splice fallback\n");
        if (!buf->mem) {
                buf->mem = buf_alloc(se->bufsize, internal);
                if (!buf->mem) {


And then run this again after 
sudo sysctl -w fs.pipe-max-size=1052672

(Please don't change '/proc/sys/fs/fuse/max_pages_limit'
from default).

And now we would need to know how many users either limit
max-pages + header to fit default pipe-max-size (1MB) or
increase max_pages_limit. Given there is no warning in
libfuse about the fallback from splice to buf copy, I doubt
many people know about that - who would change system
defaults without the knowledge?


And then, I still doubt that copy-to-tmp-page-and-splice
is any faster than no-tmp-page-copy-but-copy-to-lib-fuse-buffer. 
Especially as the tmp page copy is single threaded, I think.
But needs to be benchmarked.


Thanks,
Bernd




