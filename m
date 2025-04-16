Return-Path: <linux-fsdevel+bounces-46581-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 223EDA90ADB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 20:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE9E27AC53A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 18:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398E321ADDE;
	Wed, 16 Apr 2025 18:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="hWlShU3j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FGf7PM2y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E0D21ADD1
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Apr 2025 18:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744826740; cv=none; b=JCucS8fevoPISzdodfG612gWDhMzdt+jJ+wt8WqKsuYbGEQm0HI9WhgU5ojmiuVRrjFvAGshaBVyDmhB7Zr/ONGOTDYcskinaiZeovaJSN83L9admZDEjJwN3yBaSINjZkZqVZWAVupxzbY6lwnEN9kAXO7OW6T7oHO2NWeaMnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744826740; c=relaxed/simple;
	bh=xxw3paJcMRosBzdDuG5YHe8bJwxjGEBfdtYRZNmfo/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uKbVlULZfge8xatGIETtRjEpKT4ys/dRlfznyMDgTSCHuMf4uEPleCEHynVREwsw0b2TGUF5Rq6p717h3ErnUX1rjcGyo/Z+tVQCcy6z1YWuM3xCQz4aVckU8TQkiNa8Bn888EpAoRrJNgH9ZfaUxoMES1O9WAP8djNihwWwqvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=hWlShU3j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FGf7PM2y; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 845D825401C8;
	Wed, 16 Apr 2025 14:05:36 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 16 Apr 2025 14:05:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744826736;
	 x=1744913136; bh=E2HPkzp2xycWr+mPX9uVsm7p9PCT7DkJPqAJdKUmO6w=; b=
	hWlShU3j+57EeDyNMtdo1YLhg6FS5FNPAzDavibdmGrKuf5huXBZbtuwGG78c8Ok
	1kDmOftoW//Xunqs5YVyWkkgLufrxtyrMTB5Tty4O1yY55+331giRNBtd9J3Z/1v
	U3WGfdcSkBfeMN+u1hjaSrNg4tjUaShtlPowZIxXxX8efUGbH98rifYy5puU3Sis
	LwZYSJx+WR4Zp2QwnDipP24Yh0nElCLqPYBAoA1XHOzXbDGXTU1iyRe+HkHulAxI
	A4dRUwkr6xfT1mRdEk2uiU0BMEuGOC/0EFhSHxAiyShUJyE1Mohq3NX5PSzMw1fc
	jEqgtRZjvrDrj18Xhm/INw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744826736; x=
	1744913136; bh=E2HPkzp2xycWr+mPX9uVsm7p9PCT7DkJPqAJdKUmO6w=; b=F
	Gf7PM2yK2OTGZXdThlUHiY9keRb5pHe1EqqqE9Ou/dspcRBBR5El08FsXsVDhtcY
	i7HTsxiSc2onSyu65nA7wFo8EZRQTfWoiedkvhEbm/AsRIDueQA+5GYmb2vVQraJ
	W0vQJK476MhJUq8M6VJrtq+zdaDOVcgtVmOlKdcCJAsc283MLU4pmx5RRksbsjvY
	3AyN8l5WrclxzZU38tktqt7cBfhlKHEVb4jtfE247q5HqWBT9ixaCYt377jE27uc
	7GxlN4vG3GIJOkDdN6oXW7q3pWeZsAC4mLIW4gt93LPIaJ9TaOZBVEgd2oF2FXUF
	2tyhSjLvTv8PBO6XxxXcg==
X-ME-Sender: <xms:b_H_Zw_jEV1Z_IArmK1QDke4C-N75bh2SC2uR5IG3sczsD7TWrgsSw>
    <xme:b_H_Z4tDZ06NtSNZEjJ4-xVk3nI7PqB66dNbMVo6RyWntS2tF4AcH2UAkOjQu6pV0
    BaZRcE7f1HTQk_O>
X-ME-Received: <xmr:b_H_Z2D8Ku45mUFofSOG6f2QgB8vmYdoedf8SCQR6ilUrgTaches4F1gF9VeE4OYNA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdejtdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddt
    vdejnecuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuh
    gsvghrthesfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnhepudelfedvudev
    udevleegleffffekudekgeevlefgkeeluedvheekheehheekhfefnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggv
    rhhtsehfrghsthhmrghilhdrfhhmpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmh
    htphhouhhtpdhrtghpthhtohepjhhorghnnhgvlhhkohhonhhgsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepjhgvfhhflhgvgihusehlihhnuhigrdgrlhhisggrsggrrdgtohhmpd
    hrtghpthhtohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopegrkhhp
    mheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheplhhinhhugi
    dqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhn
    uhigqdhmmheskhhvrggtkhdrohhrghdprhgtphhtthhopehshhgrkhgvvghlrdgsuhhtth
    eslhhinhhugidruggvvhdprhgtphhtthhopegurghvihgusehrvgguhhgrthdrtghomhdp
    rhgtphhtthhopeiiihihsehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:b_H_ZwchbzSoKYEk3dIP-24kkr6JKOh73unbXWKk9BJ92_5uJWe3NQ>
    <xmx:b_H_Z1MeteuCIpS4mYWq1KeYcXI4BAU_W6gJYswFG-nLpYOuFzIt8Q>
    <xmx:b_H_Z6kXx4T0WDyVVH5amNyoHYqFjcL3I3K3rcemQV-crewTc7RaTg>
    <xmx:b_H_Z3t6cDggBnZlKk4elQ65DFwH5nkdTfbqTyr6DfLPZECLWH88eA>
    <xmx:cPH_Z5GpTCdHwrzY1zpMKvRVGj15JDC2UGLMYCVUei7R_Ap8FGvehYgK>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Apr 2025 14:05:33 -0400 (EDT)
Message-ID: <70521e78-cca2-40e2-b3d3-da2ef74ca625@fastmail.fm>
Date: Wed, 16 Apr 2025 20:05:32 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/3] fuse: remove tmp folio for writebacks and internal
 rb tree
To: Joanne Koong <joannelkoong@gmail.com>,
 Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: miklos@szeredi.hu, akpm@linux-foundation.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, shakeel.butt@linux.dev,
 david@redhat.com, ziy@nvidia.com, jlayton@kernel.org, kernel-team@meta.com,
 Miklos Szeredi <mszeredi@redhat.com>
References: <20250404181443.1363005-1-joannelkoong@gmail.com>
 <20250404181443.1363005-4-joannelkoong@gmail.com>
 <db4f1411-f6de-4206-a6a3-5c9cf6b6d59d@linux.alibaba.com>
 <CAJnrk1bTGFXy+ZTchC7p4OYUnbfKZ7TtVkCsrsv87Mg1r8KkGA@mail.gmail.com>
 <7e9b1a40-4708-42a8-b8fc-44fa50227e5b@linux.alibaba.com>
 <CAJnrk1Z7Wi_KPe_TJckpYUVhv9mKX=-YTwaoQRgjT2z0fxD-7g@mail.gmail.com>
 <9a3cfb55-faae-4551-9bef-b9650432848a@linux.alibaba.com>
 <CAJnrk1a_YL-Dg4HeVWnmwUVH2tCN2MYu30kiV5KSv4mkezWOZg@mail.gmail.com>
 <a738a765-a5e1-44bc-b1cd-e1a42d73e255@linux.alibaba.com>
 <CAJnrk1ZZ7tRwPk0hUePDVcwKnec96qFkO3Mk1zyG2g5PO1XL=w@mail.gmail.com>
 <c66d712f-e2f1-4c6e-b9a6-14689101f866@linux.alibaba.com>
 <CAJnrk1buLrVuOxX-Q8QBZkqrM7fF_EaoOCmsxM0nyf1HndkYtA@mail.gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US
In-Reply-To: <CAJnrk1buLrVuOxX-Q8QBZkqrM7fF_EaoOCmsxM0nyf1HndkYtA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/16/25 18:43, Joanne Koong wrote:
> On Tue, Apr 15, 2025 at 6:40 PM Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
>>
>> On 4/15/25 11:59 PM, Joanne Koong wrote:
>>> On Tue, Apr 15, 2025 at 12:49 AM Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
>>>>
>>>> Hi Joanne,
>>>>
>>>> Sorry for the late reply...
>>>
>>> Hi Jingbo,
>>>
>>> No worries at all.
>>>>
>>>>
>>>> On 4/11/25 12:11 AM, Joanne Koong wrote:
>>>>> On Thu, Apr 10, 2025 at 8:11 AM Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
>>>>>>
>>>>>> On 4/10/25 11:07 PM, Joanne Koong wrote:
>>>>>>> On Wed, Apr 9, 2025 at 7:12 PM Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> On 4/10/25 7:47 AM, Joanne Koong wrote:
>>>>>>>>>    On Tue, Apr 8, 2025 at 7:43 PM Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
>>>>>>>>>>
>>>>>>>>>> Hi Joanne,
>>>>>>>>>>
>>>>>>>>>> On 4/5/25 2:14 AM, Joanne Koong wrote:
>>>>>>>>>>> In the current FUSE writeback design (see commit 3be5a52b30aa
>>>>>>>>>>> ("fuse: support writable mmap")), a temp page is allocated for every
>>>>>>>>>>> dirty page to be written back, the contents of the dirty page are copied over
>>>>>>>>>>> to the temp page, and the temp page gets handed to the server to write back.
>>>>>>>>>>>
>>>>>>>>>>> This is done so that writeback may be immediately cleared on the dirty page,
>>>>>>>>>>> and this in turn is done in order to mitigate the following deadlock scenario
>>>>>>>>>>> that may arise if reclaim waits on writeback on the dirty page to complete:
>>>>>>>>>>> * single-threaded FUSE server is in the middle of handling a request
>>>>>>>>>>>    that needs a memory allocation
>>>>>>>>>>> * memory allocation triggers direct reclaim
>>>>>>>>>>> * direct reclaim waits on a folio under writeback
>>>>>>>>>>> * the FUSE server can't write back the folio since it's stuck in
>>>>>>>>>>>    direct reclaim
>>>>>>>>>>>
>>>>>>>>>>> With a recent change that added AS_WRITEBACK_INDETERMINATE and mitigates
>>>>>>>>>>> the situations described above, FUSE writeback does not need to use
>>>>>>>>>>> temp pages if it sets AS_WRITEBACK_INDETERMINATE on its inode mappings.
>>>>>>>>>>>
>>>>>>>>>>> This commit sets AS_WRITEBACK_INDETERMINATE on the inode mappings
>>>>>>>>>>> and removes the temporary pages + extra copying and the internal rb
>>>>>>>>>>> tree.
>>>>>>>>>>>
>>>>>>>>>>> fio benchmarks --
>>>>>>>>>>> (using averages observed from 10 runs, throwing away outliers)
>>>>>>>>>>>
>>>>>>>>>>> Setup:
>>>>>>>>>>> sudo mount -t tmpfs -o size=30G tmpfs ~/tmp_mount
>>>>>>>>>>>   ./libfuse/build/example/passthrough_ll -o writeback -o max_threads=4 -o source=~/tmp_mount ~/fuse_mount
>>>>>>>>>>>
>>>>>>>>>>> fio --name=writeback --ioengine=sync --rw=write --bs={1k,4k,1M} --size=2G
>>>>>>>>>>> --numjobs=2 --ramp_time=30 --group_reporting=1 --directory=/root/fuse_mount
>>>>>>>>>>>
>>>>>>>>>>>          bs =  1k          4k            1M
>>>>>>>>>>> Before  351 MiB/s     1818 MiB/s     1851 MiB/s
>>>>>>>>>>> After   341 MiB/s     2246 MiB/s     2685 MiB/s
>>>>>>>>>>> % diff        -3%          23%         45%
>>>>>>>>>>>
>>>>>>>>>>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
>>>>>>>>>>> Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
>>>>>>>>>>> Acked-by: Miklos Szeredi <mszeredi@redhat.com>
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Hi Jingbo,
>>>>>>>>>
>>>>>>>>> Thanks for sharing your analysis for this.
>>>>>>>>>
>>>>>>>>>> Overall this patch LGTM.
>>>>>>>>>>
>>>>>>>>>> Apart from that, IMO the fi->writectr and fi->queued_writes mechanism is
>>>>>>>>>> also unneeded then, at least the DIRECT IO routine (i.e.
>>>>>>>>>
>>>>>>>>> I took a look at fi->writectr and fi->queued_writes and my
>>>>>>>>> understanding is that we do still need this. For example, for
>>>>>>>>> truncates (I'm looking at fuse_do_setattr()), I think we still need to
>>>>>>>>> prevent concurrent writeback or else the setattr request and the
>>>>>>>>> writeback request could race which would result in a mismatch between
>>>>>>>>> the file's reported size and the actual data written to disk.
>>>>>>>>
>>>>>>>> I haven't looked into the truncate routine yet.  I will see it later.
>>>>>>>>
>>>>>>>>>
>>>>>>>>>> fuse_direct_io()) doesn't need fuse_sync_writes() anymore.  That is
>>>>>>>>>> because after removing the temp page, the DIRECT IO routine has already
>>>>>>>>>> been waiting for all inflight WRITE requests, see
>>>>>>>>>>
>>>>>>>>>> # DIRECT read
>>>>>>>>>> generic_file_read_iter
>>>>>>>>>>    kiocb_write_and_wait
>>>>>>>>>>      filemap_write_and_wait_range
>>>>>>>>>
>>>>>>>>> Where do you see generic_file_read_iter() getting called for direct io reads?
>>>>>>>>
>>>>>>>> # DIRECT read
>>>>>>>> fuse_file_read_iter
>>>>>>>>    fuse_cache_read_iter
>>>>>>>>      generic_file_read_iter
>>>>>>>>        kiocb_write_and_wait
>>>>>>>>         filemap_write_and_wait_range
>>>>>>>>        a_ops->direct_IO(),i.e. fuse_direct_IO()
>>>>>>>>
>>>>>>>
>>>>>>> Oh I see, I thought files opened with O_DIRECT automatically call the
>>>>>>> .direct_IO handler for reads/writes but you're right, it first goes
>>>>>>> through .read_iter / .write_iter handlers, and the .direct_IO handler
>>>>>>> only gets invoked through generic_file_read_iter() /
>>>>>>> generic_file_direct_write() in mm/filemap.c
>>>>>>>
>>>>>>> There's two paths for direct io in FUSE:
>>>>>>> a) fuse server sets fi->direct_io = true when a file is opened, which
>>>>>>> will set the FOPEN_DIRECT_IO bit in ff->open_flags on the kernel side
>>>>>>> b) fuse server doesn't set fi->direct_io = true, but the client opens
>>>>>>> the file with O_DIRECT
>>>>>>>
>>>>>>> We only go through the stack trace you listed above for the b) case.
>>>>>>> For the a) case, we'll hit
>>>>>>>
>>>>>>>          if (ff->open_flags & FOPEN_DIRECT_IO)
>>>>>>>                  return fuse_direct_read_iter(iocb, to);
>>>>>>>
>>>>>>> and
>>>>>>>
>>>>>>>          if (ff->open_flags & FOPEN_DIRECT_IO)
>>>>>>>                  return fuse_direct_write_iter(iocb, from);
>>>>>>>
>>>>>>> which will invoke fuse_direct_IO() / fuse_direct_io() without going
>>>>>>> through the kiocb_write_and_wait() -> filemap_write_and_wait_range() /
>>>>>>> kiocb_invalidate_pages() -> filemap_write_and_wait_range() you listed
>>>>>>> above.
>>>>>>>
>>>>>>> So for the a) case I think we'd still need the fuse_sync_writes() in
>>>>>>> case there's still pending writeback.
>>>>>>>
>>>>>>> Do you agree with this analysis or am I missing something here?
>>>>>>
>>>>>> Yeah, that's true.  But instead of calling fuse_sync_writes(), we can
>>>>>> call filemap_wait_range() or something similar here.
>>>>>>
>>>>>
>>>>> Agreed. Actually, the more I look at this, the more I think we can
>>>>> replace all fuse_sync_writes() and get rid of it entirely.
>>>>
>>>>
>>>> I have seen your latest reply that this cleaning up won't be included in
>>>> this series, which is okay.
>>>>
>>>>
>>>>> fuse_sync_writes() is called in:
>>>>>
>>>>> fuse_fsync():
>>>>>          /*
>>>>>           * Start writeback against all dirty pages of the inode, then
>>>>>           * wait for all outstanding writes, before sending the FSYNC
>>>>>           * request.
>>>>>           */
>>>>>          err = file_write_and_wait_range(file, start, end);
>>>>>          if (err)
>>>>>                  goto out;
>>>>>
>>>>>          fuse_sync_writes(inode);
>>>>>
>>>>>          /*
>>>>>           * Due to implementation of fuse writeback
>>>>>           * file_write_and_wait_range() does not catch errors.
>>>>>           * We have to do this directly after fuse_sync_writes()
>>>>>           */
>>>>>          err = file_check_and_advance_wb_err(file);
>>>>>          if (err)
>>>>>                  goto out;
>>>>>
>>>>>
>>>>>        We can get rid of the fuse_sync_writes() and
>>>>> file_check_and_advance_wb_err() entirely since now without temp pages,
>>>>> the file_write_and_wait_range() call actually ensures that writeback
>>>>> is completed
>>>>>
>>>>>
>>>>>
>>>>> fuse_writeback_range():
>>>>>          static int fuse_writeback_range(struct inode *inode, loff_t
>>>>> start, loff_t end)
>>>>>          {
>>>>>                  int err =
>>>>> filemap_write_and_wait_range(inode->i_mapping, start, LLONG_MAX);
>>>>>
>>>>>                  if (!err)
>>>>>                          fuse_sync_writes(inode);
>>>>>
>>>>>                  return err;
>>>>>          }
>>>>>
>>>>>
>>>>>        We can replace fuse_writeback_range() entirely with
>>>>> filemap_write_and_wait_range().
>>>>>
>>>>>
>>>>>
>>>>> fuse_direct_io():
>>>>>          if (fopen_direct_io && fc->direct_io_allow_mmap) {
>>>>>                  res = filemap_write_and_wait_range(mapping, pos, pos +
>>>>> count - 1);
>>>>>                  if (res) {
>>>>>                          fuse_io_free(ia);
>>>>>                          return res;
>>>>>                  }
>>>>>          }
>>>>>          if (!cuse && filemap_range_has_writeback(mapping, pos, (pos +
>>>>> count - 1))) {
>>>>>                  if (!write)
>>>>>                          inode_lock(inode);
>>>>>                  fuse_sync_writes(inode);
>>>>>                  if (!write)
>>>>>                          inode_unlock(inode);
>>>>>          }
>>>>>
>>>>>
>>>>>         I think this can just replaced with
>>>>>                  if (fopen_direct_io && (fc->direct_io_allow_mmap || !cuse)) {
>>>>>                          res = filemap_write_and_wait_range(mapping,
>>>>> pos, pos + count - 1);
>>>>>                          if (res) {
>>>>>                                  fuse_io_free(ia);
>>>>>                                  return res;
>>>>>                          }
>>>>>                  }
>>>>
>>>> Alright. But I would prefer doing this filemap_write_and_wait_range() in
>>>> fuse_direct_write_iter() rather than fuse_direct_io() if possible.
>>>>
>>>>>         since for the !fopen_direct_io case, it will already go through
>>>>> filemap_write_and_wait_range(), as you mentioned in your previous
>>>>> message. I think this also fixes a bug (?) in the original code - in
>>>>> the fopen_direct_io && !fc->direct_io_allow_mmap case, I think we
>>>>> still need to write out dirty pages first, which we don't currently
>>>>> do.
>>>>
>>>> Nope.  In case of fopen_direct_io && !fc->direct_io_allow_mmap, there
>>>> won't be any page cache at all, right?
>>>>
>>>
>>> Isn't there still a page cache if the file was previously opened
>>> without direct io and then the client opens another handle to that
>>> file with direct io? In that case, the pages could still be dirty in
>>> the page cache and would need to be written back first, no?
>>
>> Do you mean that when the inode is firstly opened, FOPEN_DIRECT_IO is
>> not set by the FUSE server, while it is secondly opened, the flag is set?
>>
>> Though the behavior of the FUSE daemon is quite confusing in this case,
>> it is completely possible in real life.  So yes we'd better add
>> filemap_write_and_wait_range() unconditionally in fopen_direct_io case.
>>
> 
> I think this behavior on the server side is pretty common. From what
> I've seen on most servers, the server when handling the open sets
> fi->direct_io depending on if the client opens with O_DIRECT, eg
> 
>          if (fi->flags & O_DIRECT)
>                  fi->direct_io = 1;

One should do that, actually, to get a shared lock on the inode.
With the additional

fi.parallel_direct_writes = 1;

> 
> If a client opens a file without O_DIRECT and then opens the same file
> with O_DIRECT, then we run into this case. Though I'm not sure how
> common it generally is for clients to do this.
> 


I guess the common case is

application1 does mmap
application2 does normal read/write

fuse-server might set  fi->direct_io = 1 on all opens, with the
additional

fuse_set_feature_flag(connp, FUSE_CAP_DIRECT_IO_ALLOW_MMAP);

Probably will only come to it tomorrow, but will review,
especially to check about cached/uncached io-modes.



Thanks,
Bernd

