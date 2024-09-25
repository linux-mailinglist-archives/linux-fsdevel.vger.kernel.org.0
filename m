Return-Path: <linux-fsdevel+bounces-30125-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7802C98686C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 23:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 023A6284B82
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 21:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E161534EC;
	Wed, 25 Sep 2024 21:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="lh4VTquL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iSwaEIRt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B232F13AA5F
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Sep 2024 21:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727300542; cv=none; b=FTgH6upeToYP4QyMwqhq9MjOIB0MkX1uZfnHW33trACnPpfMDtb6jmkVUXDc8+KZcvUhYfbuc6Ef6DRta2IYFKmf7UW5IwiyfMrMpiUJ+rG+Lv4zg+Vic/D8bRr2wVxtEyveLo5A+yEIXWneuv+rWSunvcgkWK3ftPZVJNuJbgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727300542; c=relaxed/simple;
	bh=GckInD7EWFcX7GPJAcK/x1Y1NjJemSDuXg4bcm4WTZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nNbs3oYX1t0+t3RJ+RdnYM2hCwh9JTFnjX+LEbwhO1QA7B8yWghfkb9mhlIDQZLkgT7Ll5stdGfJNng5rqMuAZOSLr6xWJJfVXIyYDxCw/0HrtprBCpyiFl8k94Qo+y8IXqOMP+eoUDoPOGs7g96RwuOS+IkN8s/OkOb1WJIr+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=lh4VTquL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iSwaEIRt; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id ADAB8114019A;
	Wed, 25 Sep 2024 17:42:19 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 25 Sep 2024 17:42:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1727300539;
	 x=1727386939; bh=jy8hYqzIpYDgZDGxEkmjMxGauGUbI8uv6wRmfEnjWsM=; b=
	lh4VTquLbuvaCzKHXn88mvon9oDlIhSKkqIqnt3z6/3usOioX7ElE4QDWalwd+5O
	ktQOxW6RiyqYZT2KexCYJakU5WvcvjQoc0qOagiB9PDmpZ3K6fiJ31RTMvugq5ih
	cZgQakJMFy8WhMucDan0xoghaHlMA0XU/xdnwFkk5lHfJIKhYpMvhmgM9iKBWqej
	G5aw2+udzhrKLm6uGUFOa9I8yqCwf40DZQGzUR9n/NiZi6F3oQX+5ML4eJHgrWiD
	d3vr+sSOLCjFrCTfC7hoYV+uDt+4vvdPeQpIy8D1G0sVKwSrDc+aZU6Go5DOhi53
	UPH7pQIq/qPYzKE5cyfLDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727300539; x=
	1727386939; bh=jy8hYqzIpYDgZDGxEkmjMxGauGUbI8uv6wRmfEnjWsM=; b=i
	SwaEIRt5Vcf4EhapKBLokHg/ddvZ+IF0UkxjafmqEXv6TYIkS+RbBfLIj5nQ1rd6
	Rya4Jgn5dY+F1lUbY/Yup1q1wTpIpawSOBaCdIjgc1eKFm5Dl+zEf3SQN7+kH+MD
	n2kjsdyjEbXjBDDGG9aamQCAcmhv3EDrZg7igF5sgGgQYS2C6I/JBu+caJfotgT4
	apYWaOhe0vmh3d3ZA1kwkYyU5cTK9j+BMIzjkwINWGo5YuT6KLNz1rpZ91MPJjCm
	FrxMMqHc04o9jO+S2Lk6M42K3CKRNAu90PcDAmvk5+q+PolzLtC03QMFcobpk8D8
	dHizHuy86nO4ZAb4BPjzg==
X-ME-Sender: <xms:u4P0Zs6gMN8IkN-NAhduCI8FL-hM5ss5qLvl6VntuAzYmO1NXHgXeg>
    <xme:u4P0Zt6nC-LqN2xawe-V4Kl_PhG3Bvpza0ZmDxEedYGvYO2t0lG9AHvymWLiSbwvs
    juCXbcN9UpWuD1b>
X-ME-Received: <xmr:u4P0ZrdF0PPeSlzzQrmZaf2-c3EWCn-sEOLlDb0CfpJzKcPRlXdhjcK8QoOKqW2iWDeDIQaBv0Y_UH9SWY5EGw6dlociUUwNDQQx_6vtx2mMqp3TAz38>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtiedgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdej
    necuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvg
    hrthesfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnhepvefhgfdvledtudfg
    tdfggeelfedvheefieevjeeifeevieetgefggffgueelgfejnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhht
    sehfrghsthhmrghilhdrfhhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtohep
    lhgruhhrrgdrphhrohhmsggvrhhgvghrsegtvghrnhdrtghhpdhrtghpthhtohepfhhush
    gvqdguvghvvghlsehlihhsthhsrdhsohhurhgtvghfohhrghgvrdhnvghtpdhrtghpthht
    oheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:u4P0ZhKF5ymC3tJBCTk0nBh0woRDzH94o_6zbut_NVqUQInFhRzaXA>
    <xmx:u4P0ZgKZ_V2vcwtbyhtkdE6NPjzZgoGql_Q_SPcXUagcThGqAZwPaA>
    <xmx:u4P0ZiyOMCeMJ0_2JPEJSEvOuGlNwno6Y5UlEQ4GXK_709vMp2c8CA>
    <xmx:u4P0ZkKilfp34Wy1cZ_21koOmqSJXIcEp8ZhCuVG9RkkvcAk7FbIKg>
    <xmx:u4P0ZlF3jAPLQdzUXG6Epqs7Jr5Yx7BHW5rYDWB8_mkPj21QfzUTYQxo>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Sep 2024 17:42:18 -0400 (EDT)
Message-ID: <e137f814-f9ca-44d0-9620-8c421d50d685@fastmail.fm>
Date: Wed, 25 Sep 2024 23:42:17 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [fuse-devel] Symlink caching: Updating the target can result in
 corrupted symlinks - kernel issue?
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Laura Promberger <laura.promberger@cern.ch>,
 "fuse-devel@lists.sourceforge.net" <fuse-devel@lists.sourceforge.net>,
 linux-fsdevel@vger.kernel.org
References: <GV0P278MB07187F9B0E7B576AD0B362B485802@GV0P278MB0718.CHEP278.PROD.OUTLOOK.COM>
 <CAJfpegvVtao9OotO3sZopxxkSTkRV-cizpE1r2VtG7xZExZFOQ@mail.gmail.com>
 <a48f642d-a129-4a55-8338-d446725dc868@fastmail.fm>
 <CAJfpegv=7cnS9N7Fb8dMXSNgA1neYuhqavGeBdTAKFHXhL19KQ@mail.gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJfpegv=7cnS9N7Fb8dMXSNgA1neYuhqavGeBdTAKFHXhL19KQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/25/24 16:25, Miklos Szeredi wrote:
> On Wed, 25 Sept 2024 at 16:07, Bernd Schubert
> <bernd.schubert@fastmail.fm> wrote:
>>
>> Hi Miklos,
>>
>> On 9/25/24 14:20, Miklos Szeredi wrote:
>>> On Thu, 15 Aug 2024 at 16:45, Laura Promberger <laura.promberger@cern.ch> wrote:
>>>
>>>> - But for corrupted symlinks `fuse_change_attributes()` exits before `fuse_change_attributes_common()` is called and as such the length stays the old one.
>>>
>>> The reason is that the attr_version check fails.  The trace logs show
>>> a zero attr_version value, which suggests that the check can not fail.
>>> But we know that fuse_dentry_revalidate() supplies a non-zero
>>> attr_version to fuse_change_attributes() and if there's a racing
>>> fuse_reverse_inval_inode() which updates the fuse_inode's
>>> attr_version, then it would result in fuse_change_attributes() exiting
>>> before updating the cached attributes, which is what you observe.
>>
>>
>> I'm a bit confused by this, especially due to "fuse_reverse_inval_inode()",
>> isn't this about FUSE_NOTIFY_INVAL_ENTRY and the additional flag
>> FUSE_EXPIRE_ONLY? I.e. the used code path is fuse_reverse_inval_entry()?
>> And that path doesn't change the attr_version? Which I'm also confused
>> about.
> 
> The trace does have several fuse_reverse_inval_inode() calls, which
> made me conclude that this was the cause.

Yeah, you are right, I checked cvmfs and it uses both.

> 
>>> This is probably okay, as the cached attributes remain invalid and the
>>> next call to fuse_change_attributes() will likely update the inode
>>> with the correct values.
>>>
>>> The reason this causes problems is that cached symlinks will be
>>> returned through page_get_link(), which truncates the symlink to
>>> inode->i_size.  This is correct for filesystems that don't mutate
>>> symlinks, but for cvmfs it causes problems.
>>>
>>> My proposed solution would be to just remove this truncation.  This
>>> can cause a regression in a filesystem that relies on supplying a
>>> symlink larger than the file size, but this is unlikely.   If that
>>> happens we'd need to make this behavior conditional.
>>
>> I wonder if we can just repeat operations if we detect changes in the
>> middle. Hard started to work on a patch, but got distracted and I
>> first would like to create a passthrough reproducer.
> 
> I think in this case it's much cleaner to just ignore the file size.
> Old, non-cached readlink code never did anything with i_size, why
> should the cached one care about it?

Yeah, I see your point. (Probably just my too long out-of-tree habit
to avoid vfs changes whenever possible).

Thanks,
Bernd


