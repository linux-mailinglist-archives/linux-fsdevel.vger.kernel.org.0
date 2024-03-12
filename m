Return-Path: <linux-fsdevel+bounces-14249-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0C3879DF5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 22:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CAA01C20CFA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 21:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94774143C4D;
	Tue, 12 Mar 2024 21:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="iL2F21DM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RAwXHMup"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wfout7-smtp.messagingengine.com (wfout7-smtp.messagingengine.com [64.147.123.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB984AEEB
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Mar 2024 21:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710280533; cv=none; b=GBeDFea3A6366W9LxDSDg7p9Q31he2OM+IbyHXWTocMN5Qw303CJC8Qe5uRd6SzceYf6g+U7TurrTqmXJwYHmkMhrAHibiOoDgBSLxqINlA5/sXrIKtYXg8LSjz/4lKEIgigMI3eWpP/+WRwZMA7pGenxUUQWeJY0q3yjVlb81w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710280533; c=relaxed/simple;
	bh=yHX4+5DcPpWatpBUhVImzbpFssqO5NpVfFRrMEDS5nU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gv8d8HACocLNkIE/E2w3N/Zold+rlwUZ3y87agRTOMAKtNdSbqBGRs83y3XiY6XUN1miQYTh0K6J4DK3/zW4bOfbeRhKEX/9V5VsTUrxlkpuXqUZr1iysitl3/bW62CO92ACvyujdWM/6ZDHqlPutidObZAAFn3vScLu90HkFbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=iL2F21DM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RAwXHMup; arc=none smtp.client-ip=64.147.123.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id 3A0481C00096;
	Tue, 12 Mar 2024 17:55:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 12 Mar 2024 17:55:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1710280529;
	 x=1710366929; bh=cyCXieIeAznG1M3EGMP/llScIKJc1qSszayzCheqv24=; b=
	iL2F21DMZcG52sd4ImdiyG8DQZdi6+IhCyv6vZPLQGbWfO5rDy2i/f6r+LWh7VZC
	SrqU1sHutFl5ba1wqSGf8Lnn1Z4lk72dWyux6Tn9ER7CMDNa4ZspWWKym5e6vTYA
	IFGTIaAx88s6gquR6NMkds+HLM0l8BrAVmx5f2rJpeK0g2sSYaUHUDqIqjLW8lu5
	Upb3lcgdaVy8Ro3NBg7tHKV/pYQwOnpaCudmVmjdli/Zoq+JwcDvHW8A4BwuftZ/
	iPwvzeD1SmXeGKoKqtG4yv6/EE8IbVM64R1HP3/MG/yhVbThDlBaKC9OfseGSBE8
	2BLoMMzfRJrEGxXua6TiDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1710280529; x=
	1710366929; bh=cyCXieIeAznG1M3EGMP/llScIKJc1qSszayzCheqv24=; b=R
	AwXHMupT/Rsgn9eSP10fdpybnN1L5ASmKgllHTul19BBxpx+GhsfbeDr2A/jnx5r
	w6QNSRCIg5TGzA4dstiDh37lBbiB1gbI/SckdegpjZcUW3dyi/T+aq3t++n1WDI/
	Rb19eJdyGEBPqDFSfLiDsixplAEuyOD202yRuxrYeyI2oupTfloEr4fLKXZ03Erj
	3Z2DI+p+VRND8wLihATJ/XDotVTRdg2uSxhXQXKBXh3dzoYYJ51JI/J/cS5d09+B
	NSOHPR5xg3U5Ddl+Uy4WIrNOqeQRe9t2AaIh73RqUgt7CbV76sdmtAvRrU9HWjMz
	CbJz5Pwo508dQYblqZa2w==
X-ME-Sender: <xms:Uc_wZdjij-LS5S6up9dwEPtgZiGOE81Zo06NXqSfE_AXD_2HJ9kXNA>
    <xme:Uc_wZSDCJ3TecN29akWmxECdgb5-ejc7wcKE16HIUiBYaeUA_DnbzuNgrMhj5lzek
    onvZu77xQSyeYtw>
X-ME-Received: <xmr:Uc_wZdG_NtqmpHNSUroSS_zxuuNA7FqLVJxNsuN0XhI2MfEgY8g8ge0Olp80uSLluOFN8rfVfBo0-KcIuxhI7Hm2wLKYkZQDUhVk9rSHzSVo0mC_hayS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeefgdduheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnhepudelfedvudevudevleegleffffekudekgeev
    lefgkeeluedvheekheehheekhfefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdr
    fhhm
X-ME-Proxy: <xmx:Uc_wZSTeNHFtdwVpRc22ZvJkmeUXvg-9p-Pj2f6GblFkJ-Gwlal9TA>
    <xmx:Uc_wZayxivCDjNJmfguvj_vqTdeWMMuwKe0KslUk8l7FRGF0FBL0zQ>
    <xmx:Uc_wZY7KJHp_mUmqL8u1PJP43FbKeM5bSq4omzN9RUS_9ss6FbUCHg>
    <xmx:Uc_wZfxjK2HWNQAjLOhLuyJan89PCTVav6KreyKqFJPZayMFQB6-zg>
    <xmx:Uc_wZVwUhraBi2pgPsfXvcARvI0AADj6epauur8ed9paL9jMuqEFTR2ga9k>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Mar 2024 17:55:28 -0400 (EDT)
Message-ID: <2172443f-8c83-4abf-a7bb-cc3ca252c7c5@fastmail.fm>
Date: Tue, 12 Mar 2024 22:55:26 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: update size attr before doing IO
To: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
 Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, kernel-team@meta.com,
 josef@toxicpanda.com, amir73il@gmail.com
References: <9d71a4fd1f1d8d4cfc28480f01e5fe3dc5a7e3f0.1709821568.git.sweettea-kernel@dorminy.me>
 <CAJfpeguHZCkkY2MZjJJZ2HhvhQuMhmwqnqGoxV-+wjsKwijX6w@mail.gmail.com>
 <4911426f-cf12-44f4-aef1-1000668ad3a0@dorminy.me>
Content-Language: en-US, de-DE, fr
From: Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <4911426f-cf12-44f4-aef1-1000668ad3a0@dorminy.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 3/12/24 19:18, Sweet Tea Dorminy wrote:
> 
> 
> On 3/11/24 06:01, Miklos Szeredi wrote:
>> On Thu, 7 Mar 2024 at 16:10, Sweet Tea Dorminy
>> <sweettea-kernel@dorminy.me> wrote:
>>>
>>> All calls into generic vfs functions need to make sure that the inode
>>> attributes used by those functions are up to date, by calling
>>> fuse_update_attributes() as appropriate.
>>>
>>> generic_write_checks() accesses inode size in order to get the
>>> appropriate file offset for files opened with O_APPEND. Currently, in
>>> some cases, fuse_update_attributes() is not called before
>>> generic_write_checks(), potentially resulting in corruption/overwrite of
>>> previously appended data if i_size is out of date in the cached inode.
>>
>> While this all sounds good, I don't think it makes sense.
>>
>> Why?  Because doing cached O_APPEND writes without any sort of
>> exclusion with remote writes is just not going to work.
>>
>> Either the server ignores the current size and writes at the offset
>> that the kernel supplied (which will be the cached size of the file)
>> and executes the write at that position, or it appends the write to
>> the current EOF.  In the former case the cache will be consistent, but
>> append semantics are not observed, while in the latter case the append
>> semantics are observed, but the cache will be inconsistent.
>>
>> Solution: either exclude remote writes or don't use the cache.
>>
>> Updating the file size before the write does not prevent the race,
>> only makes the window smaller.
> 
> Definitely agree with you.
> 
> The usecase at hand is a sort of NFS-like network filesystem, where
> there's exclusion of remote writes while the file is open, but no
> problem with remote writes while the file is closed.
> 
> The alternative we considered was to add a fuse_update_attributes() call
> to open.
> 
> We thought about doing so during d_revalidate/lookup_fast(). But as far
> as I understand, lookup_fast() is not just called during open, and will
> use the cached inode if the dentry timeout hasn't expired. We tried
> setting dentry timeout to 0, but that lost too much performance. So that
> didn't seem to work.
> 
> But updating attributes after giving the filesystem a chance to
> invalidate them during open() would work, I think?

You mean something like this?

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index d19cbf34c634..2723270323d9 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -204,7 +204,7 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
        if (inode && fuse_is_bad(inode))
                goto invalid;
        else if (time_before64(fuse_dentry_time(entry), get_jiffies_64()) ||
-                (flags & (LOOKUP_EXCL | LOOKUP_REVAL | LOOKUP_RENAME_TARGET))) {
+                (flags & (LOOKUP_EXCL | LOOKUP_REVAL | LOOKUP_RENAME_TARGET | LOOKUP_OPEN))) {
                struct fuse_entry_out outarg;
                FUSE_ARGS(args);
                struct fuse_forget_link *forget;


I think this would make sense and could be caught by the atomic-open/revalidate
(once I get back to it).



> 
> That would also conveniently fix the issue where copy_file_range()
> currently checks the size before calling into fuse at all, which I'd
> been building a more elaborate changeset for.
> 
> How does that sound?
> 
> Thanks!
> 
> Sweet Tea
> 

