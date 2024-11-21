Return-Path: <linux-fsdevel+bounces-35405-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C13E9D4A86
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 11:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E24DD1F22641
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 10:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511111CC159;
	Thu, 21 Nov 2024 10:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="VKzFmuQl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Mkdi7aPF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5ECC1BBBDC
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Nov 2024 10:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732183891; cv=none; b=WyJGeWRAD5euT+fe14LjTX6XkRktdDvEK7t7R58yC0Zw1b7rNPLNNI98SDt1mnOD8FKecnADsmOL44tU7oXyuvw/lRGXRTpuuoeRWkVOWck8KaDwG9htcf2OnDLpPuTfn0Bw+XatYLpXZ1zeOKj41qSJojpnsnqjteS0FgsgdUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732183891; c=relaxed/simple;
	bh=LT3mmAj5X35ew+qcr8akZd8P84owvhb76NCS6ukJf5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qNhwAO9PF149JjasglMcXsgBsL4BgqoS8OA47bAH98YrYf/+X/p+NDXiAmQncwQr+t45lIU44BmTs5WsJiMXgqzd7EL1Q5ZFvhGuhozfVhkHwiheofadSSJTAa+aO0gR34qPhGIDV00o5Y82sq3ELYxRc180aL5OlypSLmLh/eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=VKzFmuQl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Mkdi7aPF; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 51B381140146;
	Thu, 21 Nov 2024 05:11:24 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Thu, 21 Nov 2024 05:11:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732183884;
	 x=1732270284; bh=mSVsqlePNcsz2j2bEdTE3g/q+E0KXGH1haUHUm6f594=; b=
	VKzFmuQlTK/cdJ4eiSo8AWozo+hSZKtLlr/DDw0xkDvQ9dCn0O9UhJXlJVYeToRe
	YRzMG0B6Zr50pdscyRlEcd5Hk9dqUvSA0VLVGQe/0sfqCHtWmXEpJ/vIMROetSe9
	R7TCNECLKt5fzPkgR4mLbU7+cpoZShvytxx2RBvaBi3ihdH3OUmQcc/4AX9N0LXr
	j6uzWiVM0Pl9SwnW46IO+RBFgqJUrPzf3xrS2iaDIvgeHY8wFW3gyjc6FtkMuMYa
	C2fdL3zQEe9IAtUcc4j8v2LqUc6DxXGwWVv789qbVn78YeV++maoBPceLKsBdnD+
	RPwPsjZcs9qQ14LnoALUEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732183884; x=
	1732270284; bh=mSVsqlePNcsz2j2bEdTE3g/q+E0KXGH1haUHUm6f594=; b=M
	kdi7aPFPGJO7DogEx3i0R+nUIt2oniha04E669h/xEf+KnW1gxh5Z/VYRtWu9IUW
	RiEzzI0e0wdTlYNozDFtDP+TnaNBe0gQgaZ9h9KfqQ0GiEnZKcD3zYO6WCMhdhar
	wqFTDrOfXN7gz0VjG+tyItkcfo/gSwpnffUOJwonnzpdZ7Di8hfpbH33H/stLdhF
	sKE6oBMgC4R23mG18/62zjblGTjroZyKuZhJcYtctMyiysDqlw27XB3joAH7FY/M
	RROqNyUANNUt39mGe5G0PjzHA4ATXTGO09amYqmgf14tXG6oxy3fcw2xGR1Yqso5
	k8Axas7evsBqnI3IpiZxQ==
X-ME-Sender: <xms:Sgc_Z7uzY9QLwv01Ubyq6bc-gz8OX7bdDeBZga2HMAKTiObSF3_K6Q>
    <xme:Sgc_Z8ekRyRzA0rb8arQfu6pDrROuKOeKQeuqw4nDJxXpk9VifbAIYTKpRpUX0Bft
    LhtqpX6okxPK91U>
X-ME-Received: <xmr:Sgc_Z-xKYEGfMdkWE0z9AnC9ZrwtDxeWijKfJAWo7ovtenPxgIRanZ1SvYX4s8xsYAtaOu2TqgmO5dSzuRYEqEcOleS7T55YZig5wVTGzzJCYSxd_GXq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeeigdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeen
    ucfhrhhomhepuegvrhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrh
    htsehfrghsthhmrghilhdrfhhmqeenucggtffrrghtthgvrhhnpeeutdekieelgeehudek
    gffhtdduvddugfehleejjeegleeuffeukeehfeehffevleenucffohhmrghinhepghhith
    hhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdrfhhmpdhnsggprh
    gtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjvghffhhlvgig
    uheslhhinhhugidrrghlihgsrggsrgdrtghomhdprhgtphhtthhopehjohgrnhhnvghlkh
    hoohhnghesghhmrghilhdrtghomhdprhgtphhtthhopehmihhklhhoshesshiivghrvggu
    ihdrhhhupdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehshhgrkhgvvghlrdgsuhhttheslhhinhhugidruggv
    vhdprhgtphhtthhopehjohhsvghfsehtohigihgtphgrnhgurgdrtghomhdprhgtphhtth
    hopehlihhnuhigqdhmmheskhhvrggtkhdrohhrghdprhgtphhtthhopehkvghrnhgvlhdq
    thgvrghmsehmvghtrgdrtghomh
X-ME-Proxy: <xmx:Sgc_Z6Naw1cipAv1PtKO_SanJxpA72DCVYh6uuUJSGq6vmObzZVeTQ>
    <xmx:Sgc_Z7_NIwburX5AAFBYBerLfHLx6btXHuHjVKj6skoJdk0ebnDsWw>
    <xmx:Sgc_Z6XQEpdLMLPwrOs9ERVY_QnhJ0ZOBm_O2hsE5CNnYti84zeWLg>
    <xmx:Sgc_Z8elMBtD4ygXFjhf9DxXdNZF4BaXNNxTnq5zPUvFvEz_AqEGMQ>
    <xmx:TAc_Z3TGpwTLfCpe-84hnzypFyBrq1sHxjylf1ZD_ntA0h1uQSetHDuP>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Nov 2024 05:11:21 -0500 (EST)
Message-ID: <9c04038b-074a-448d-a23f-8c5931aacd97@fastmail.fm>
Date: Thu, 21 Nov 2024 11:11:20 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/5] fuse: remove tmp folio for writebacks and internal
 rb tree
To: Jingbo Xu <jefflexu@linux.alibaba.com>,
 Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, shakeel.butt@linux.dev,
 josef@toxicpanda.com, linux-mm@kvack.org, kernel-team@meta.com
References: <20241115224459.427610-1-joannelkoong@gmail.com>
 <20241115224459.427610-6-joannelkoong@gmail.com>
 <cad4a8b3-8065-4187-875f-1810263b988c@linux.alibaba.com>
 <CAJnrk1aiNZM_JhCwNX+XCdBWsqWxujLi3sUYaQEuN-qnA2gneQ@mail.gmail.com>
 <53277184-6c03-469a-bb5e-3249460258ba@linux.alibaba.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <53277184-6c03-469a-bb5e-3249460258ba@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/21/24 04:08, Jingbo Xu wrote:
> 
> 
> On 11/21/24 5:53 AM, Joanne Koong wrote:
>> On Wed, Nov 20, 2024 at 1:56 AM Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
>>>
>>> On 11/16/24 6:44 AM, Joanne Koong wrote:
>>>> In the current FUSE writeback design (see commit 3be5a52b30aa
>>>> ("fuse: support writable mmap")), a temp page is allocated for every
>>>> dirty page to be written back, the contents of the dirty page are copied over
>>>> to the temp page, and the temp page gets handed to the server to write back.
>>>>
>>>> This is done so that writeback may be immediately cleared on the dirty page,
>>>> and this in turn is done for two reasons:
>>>> a) in order to mitigate the following deadlock scenario that may arise
>>>> if reclaim waits on writeback on the dirty page to complete:
>>>> * single-threaded FUSE server is in the middle of handling a request
>>>>   that needs a memory allocation
>>>> * memory allocation triggers direct reclaim
>>>> * direct reclaim waits on a folio under writeback
>>>> * the FUSE server can't write back the folio since it's stuck in
>>>>   direct reclaim
>>>> b) in order to unblock internal (eg sync, page compaction) waits on
>>>> writeback without needing the server to complete writing back to disk,
>>>> which may take an indeterminate amount of time.
>>>>
>>>> With a recent change that added AS_WRITEBACK_INDETERMINATE and mitigates
>>>> the situations described above, FUSE writeback does not need to use
>>>> temp pages if it sets AS_WRITEBACK_INDETERMINATE on its inode mappings.
>>>>
>>>> This commit sets AS_WRITEBACK_INDETERMINATE on the inode mappings
>>>> and removes the temporary pages + extra copying and the internal rb
>>>> tree.
>>>>
>>>> fio benchmarks --
>>>> (using averages observed from 10 runs, throwing away outliers)
>>>>
>>>> Setup:
>>>> sudo mount -t tmpfs -o size=30G tmpfs ~/tmp_mount
>>>>  ./libfuse/build/example/passthrough_ll -o writeback -o max_threads=4 -o source=~/tmp_mount ~/fuse_mount
>>>>
>>>> fio --name=writeback --ioengine=sync --rw=write --bs={1k,4k,1M} --size=2G
>>>> --numjobs=2 --ramp_time=30 --group_reporting=1 --directory=/root/fuse_mount
>>>>
>>>>         bs =  1k          4k            1M
>>>> Before  351 MiB/s     1818 MiB/s     1851 MiB/s
>>>> After   341 MiB/s     2246 MiB/s     2685 MiB/s
>>>> % diff        -3%          23%         45%
>>>>
>>>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
>>>> ---
>>>>  fs/fuse/file.c | 339 +++----------------------------------------------
>>>>  1 file changed, 20 insertions(+), 319 deletions(-)
>>>>
>>>> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
>>>> index 88d0946b5bc9..56289ac58596 100644
>>>> --- a/fs/fuse/file.c
>>>> +++ b/fs/fuse/file.c
>>>> @@ -1172,7 +1082,7 @@ static ssize_t fuse_send_write_pages(struct fuse_io_args *ia,
>>>>       int err;
>>>>
>>>>       for (i = 0; i < ap->num_folios; i++)
>>>> -             fuse_wait_on_folio_writeback(inode, ap->folios[i]);
>>>> +             folio_wait_writeback(ap->folios[i]);
>>>>
>>>>       fuse_write_args_fill(ia, ff, pos, count);
>>>>       ia->write.in.flags = fuse_write_flags(iocb);
>>>> @@ -1622,7 +1532,7 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
>>>>                       return res;
>>>>               }
>>>>       }
>>>> -     if (!cuse && fuse_range_is_writeback(inode, idx_from, idx_to)) {
>>>> +     if (!cuse && filemap_range_has_writeback(mapping, pos, (pos + count - 1))) {
>>>>               if (!write)
>>>>                       inode_lock(inode);
>>>>               fuse_sync_writes(inode);
>>>> @@ -1825,7 +1735,7 @@ static void fuse_writepage_free(struct fuse_writepage_args *wpa)
>>>>               fuse_sync_bucket_dec(wpa->bucket);
>>>>
>>>>       for (i = 0; i < ap->num_folios; i++)
>>>> -             folio_put(ap->folios[i]);
>>>> +             folio_end_writeback(ap->folios[i]);
>>>
>>> I noticed that if we folio_end_writeback() in fuse_writepage_finish()
>>> (rather than fuse_writepage_free()), there's ~50% buffer write
>>> bandwridth performance gain (5500MB -> 8500MB)[*]
>>>
>>> The fuse server is generally implemented in multi-thread style, and
>>> multi (fuse server) worker threads could fetch and process FUSE_WRITE
>>> requests of one fuse inode.  Then there's serious lock contention for
>>> the xarray lock (of the address space) when these multi worker threads
>>> call fuse_writepage_end->folio_end_writeback when they are sending
>>> replies of FUSE_WRITE requests.
>>>
>>> The lock contention is greatly alleviated when folio_end_writeback() is
>>> serialized with fi->lock.  IOWs in the current implementation
>>> (folio_end_writeback() in fuse_writepage_free()), each worker thread
>>> needs to compete for the xarray lock for 256 times (one fuse request can
>>> contain at most 256 pages if FUSE_MAX_MAX_PAGES is 256) when completing
>>> a FUSE_WRITE request.
>>>
>>> After moving folio_end_writeback() to fuse_writepage_finish(), each
>>> worker thread needs to compete for fi->lock only once.  IOWs the locking
>>> granularity is larger now.
>>>
>>
>> Interesting! Thanks for sharing. Are you able to consistently repro
>> these results and on different machines? When I run it locally on my
>> machine using the commands you shared, I'm seeing roughly the same
>> throughput:
>>
>> Current implementation (folio_end_writeback() in fuse_writepage_free()):
>>   WRITE: bw=385MiB/s (404MB/s), 385MiB/s-385MiB/s (404MB/s-404MB/s),
>> io=113GiB (121GB), run=300177-300177msec
>>   WRITE: bw=384MiB/s (403MB/s), 384MiB/s-384MiB/s (403MB/s-403MB/s),
>> io=113GiB (121GB), run=300178-300178msec
>>
>> fuse_end_writeback() in fuse_writepage_finish():
>>   WRITE: bw=387MiB/s (406MB/s), 387MiB/s-387MiB/s (406MB/s-406MB/s),
>> io=113GiB (122GB), run=300165-300165msec
>>   WRITE: bw=381MiB/s (399MB/s), 381MiB/s-381MiB/s (399MB/s-399MB/s),
>> io=112GiB (120GB), run=300143-300143msec
>>
>> I wonder if it's because your machine is so much faster that lock
>> contention makes a difference for you whereas on my machine there's
>> other things that slow it down before lock contention comes into play.
> 
> Yeah, I agree that the lock contention matters only when the writeback
> kworker consumes 100% CPU, i.e. when the writeback kworker is the
> bottleneck.  To expose that, the passthrough_hp daemon works in
> benchmark[*] mode (I noticed that passthrough_hp can be the bottleneck
> when disabling "--bypass-rw" mode).
> 
> [*]
> https://github.com/libfuse/libfuse/pull/807/commits/e83789cc6e83ca42ccc9899c4f7f8c69f31cbff9
> 
> 
>>
>> I see your point about why it would make sense that having
>> folio_end_writeback() in fuse_writepage_finish() inside the scope of
>> the fi->lock could make it faster, but I also could see how having it
>> outside the lock could make it faster as well. I'm thinking about the
>> scenario where if there's 8 threads all executing
>> fuse_send_writepage() at the same time, calling folio_end_writeback()
>> outside the fi->lock would unblock other threads trying to get the
>> fi->lock and that other thread could execute while
>> folio_end_writeback() gets executed.
>>
>> Looking at it some more, it seems like it'd be useful if there was
>> some equivalent api to folio_end_writeback() that takes in an array of
>> folios and would only need to grab the xarray lock once to clear
>> writeback on all the folios in the array.
> 
> Yes it's exactly what we need.
> 
> 
>>
>> When fuse supports large folios [*] this will help lock contention on
>> the xarray lock as well because there'll be less folio_end_writeback()
>> calls.
> 
> Cool, it definitely helps.
> 
> 
>>
>> I'm happy to move the fuse_end_writeback() call to
>> fuse_writepage_finish() considering what you're seeing. 5500 Mb ->
>> 8800 Mb is a huge perf improvement!
> 
> This statistics is tested in benchmark ("--bypass-rw") mode.  When
> disabling "--bypass-rw" mode and testing fuse passthrough_hp over a ext4
> over nvme, the performance gain is ~10% (4009MB/s ->4428MB/s).

Thanks for Jingbo and Joanne for looking into this! In typical HPC case
one expects currently >15GB/s for a single client  - Infiniband RDMA
and possibly multi rail. The --bypass-rw is rather close to that.



Thanks,
Bernd

