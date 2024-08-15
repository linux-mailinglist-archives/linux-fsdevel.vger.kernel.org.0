Return-Path: <linux-fsdevel+bounces-26018-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A4B95284E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 05:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E227E1C2231B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 03:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1399837703;
	Thu, 15 Aug 2024 03:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="EbvmbmIO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Rgxzq+L+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3AE6FC3;
	Thu, 15 Aug 2024 03:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723692834; cv=none; b=Ge4NVbA2h22YPvSTGZLNI5mHGX4X2EZJwW9PWft68R91r8YphdfU3vACg1t+/qjcTPvamQeTxxXlAQrTV9PAlBmhuG/vKwBDxA83jrxWCu3B/1JFxuvl28eMfqwLzwSRlOy+S5s6AL9wED0/xPlusO4riaW4mS5v2U7qll5VXqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723692834; c=relaxed/simple;
	bh=ixC0+t6WfWaaVZ/Lgn75gF74zaPemthMM9/IM/zFK+c=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=XSMtZBU5gijH95lagg0DilruaswciziskJ7qFTzGnneXv8SG9qhCa/MlCameZwlu43A7GlpuuLDnZKY2R51+2D5W+w92GZbc/eD2Ks1pBg3n3B9K5CEShYDsUrZ0xeRjK+7/tUFbvCeztyJKm53gYHjNu4ojy/Mt3C/NUIaY4/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=none smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=EbvmbmIO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Rgxzq+L+; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=themaw.net
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 395171151BDD;
	Wed, 14 Aug 2024 23:33:51 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 14 Aug 2024 23:33:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1723692831;
	 x=1723779231; bh=cJ2UvaJpYFZzglZBu7tFIhf+1iu0zJoGYRia8VK/wIQ=; b=
	EbvmbmIOklwGFyQiawwWpsUQZwfG0jDwpLagUzhxZeBWbJ0tGVR9sqBYHHeg/Upz
	+I5WR0s01ep1nhMXkJrs7ZVpr4RRQB/NijJDNiWAF/zzUdgaylz+nfC0l9jHp8L8
	E1fNEjFKmjEqvpXH2v8NRjkXAUmRnUmgWhSSN+3aqsTvtrgK6yh1BGNAKmWexYr0
	nYB2hTvShrDCUyhP//ffHlWmHpIfhteu7iQSWd8fNQ/ggCSrw4ZTjGOYvzBAnvOD
	oVo1NO27kOo/K3sBR5LdY/hLaJDBrteU6PNoIsOZUGJnuUSo1+fdPmGIrUNQEjRe
	wv7D6wpL/TFKFo7EvbAj5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723692831; x=
	1723779231; bh=cJ2UvaJpYFZzglZBu7tFIhf+1iu0zJoGYRia8VK/wIQ=; b=R
	gxzq+L+dixWxn5aZRi7QtrDiu2/vnUbnJj0NfrpILFwR91Oe0RFqrcs+fMzey3hu
	/SMJisZ6ioIoIgdeU17NAH4LCOaLEp5ZKrmo+IJ7kH70dYqkcERlqELt812mfkZ6
	g08F1aaoDmvze7Iq9fWDt+wSFcbXLUxG/yCphqxGcWem4oXw3BB+McnrCaWgUgzJ
	ZHyDgN84qaRGlGgPZFRux6bkh5cM4ZUrFDVPwuemRE+ovK2FS6KGZnyHWqS8Qg27
	MYGziYomtQ6/mxLV+ZaxEsXBd3nGGmcyIP3e8buRZmeM6g+MB71QCjpsidK7rUVM
	qpEYO+gO3rYm+6XXXyjWA==
X-ME-Sender: <xms:Hne9ZjZxHxqjznvMkq4f2q9qfVPeZKEW65mKgvjE_J9690mcCk4oag>
    <xme:Hne9ZibU19i-SpiZrCi3-5uL9iaGSo0sX-4Cspfi29C07tMVzfLLGDKv0xQMlMNQU
    mQL9wWrIBbW>
X-ME-Received: <xmr:Hne9Zl_Q57qDLrX1ldlHb9_JxzyI8GmKidAyknBnuGyoFDQbhLsu75Y2TRA9gwbYUeP3cpJCgGDYhUt7A0_Ohm2AZpLGwbMpcsmvcVXXdEvDYWe-HAx9eqE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddthedgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfuffhvfevfhgjtgfgsehtkeertddtvdej
    necuhfhrohhmpefkrghnucfmvghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqne
    cuggftrfgrthhtvghrnhepvefgvdehhfevhfevgfegffejheetieegjefhjeefffeutdfh
    tdeikefhgfejjeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomheprhgrvhgvnhesthhhvghmrgifrdhnvghtpdhnsggprhgtphhtthhopeehpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhr
    tghpthhtoheprghuthhofhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Hne9Zpp-YJjsM0bv3cYfB_nBf3rhxnm9xWXw4ev5LaBW7A13V1HVdQ>
    <xmx:H3e9ZuoHEBFInkZnWYXDE-hkwRqPSdr53KHOyjQFMYBrXjJz0fxbog>
    <xmx:H3e9ZvQ2jmNnqAcCNEWJxesfXUbCubB4hYGTZVD_6lCB3e8z2cYynA>
    <xmx:H3e9ZmovetxcUmCJyAseNE-KaBGSeoGewQZYdhd27lRbAqc96eJIYg>
    <xmx:H3e9ZnmBdlSgSt2NlPEz22OG1tFq4kCxszv2LhHdumq0UEnKKoFJlEE0>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Aug 2024 23:33:48 -0400 (EDT)
Message-ID: <ea45c08a-f2cd-47fe-a45c-1f0431bd32ec@themaw.net>
Date: Thu, 15 Aug 2024 11:33:45 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] autofs: add per dentry expire timeout
From: Ian Kent <raven@themaw.net>
To: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
 autofs mailing list <autofs@vger.kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20240814090231.963520-1-raven@themaw.net>
 <20240814-darauf-schund-23ec844f4a09@brauner>
 <67656e13-c816-44f0-8a69-5efa7c76a907@themaw.net>
Content-Language: en-US
Autocrypt: addr=raven@themaw.net;
 keydata= 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
In-Reply-To: <67656e13-c816-44f0-8a69-5efa7c76a907@themaw.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15/8/24 11:10, Ian Kent wrote:
> On 14/8/24 22:39, Christian Brauner wrote:
>> On Wed, Aug 14, 2024 at 05:02:31PM GMT, Ian Kent wrote:
>>> Add ability to set per-dentry mount expire timeout to autofs.
>>>
>>> There are two fairly well known automounter map formats, the autofs
>>> format and the amd format (more or less System V and Berkley).
>>>
>>> Some time ago Linux autofs added an amd map format parser that
>>> implemented a fair amount of the amd functionality. This was done
>>> within the autofs infrastructure and some functionality wasn't
>>> implemented because it either didn't make sense or required extra
>>> kernel changes. The idea was to restrict changes to be within the
>>> existing autofs functionality as much as possible and leave changes
>>> with a wider scope to be considered later.
>>>
>>> One of these changes is implementing the amd options:
>>> 1) "unmount", expire this mount according to a timeout (same as the
>>>     current autofs default).
>>> 2) "nounmount", don't expire this mount (same as setting the autofs
>>>     timeout to 0 except only for this specific mount) .
>>> 3) "utimeout=<seconds>", expire this mount using the specified
>>>     timeout (again same as setting the autofs timeout but only for
>>>     this mount).
>>>
>>> To implement these options per-dentry expire timeouts need to be
>>> implemented for autofs indirect mounts. This is because all map keys
>>> (mounts) for autofs indirect mounts use an expire timeout stored in
>>> the autofs mount super block info. structure and all indirect mounts
>>> use the same expire timeout.
>>>
>>> Now I have a request to add the "nounmount" option so I need to add
>>> the per-dentry expire handling to the kernel implementation to do this.
>>>
>>> The implementation uses the trailing path component to identify the
>>> mount (and is also used as the autofs map key) which is passed in the
>>> autofs_dev_ioctl structure path field. The expire timeout is passed
>>> in autofs_dev_ioctl timeout field (well, of the timeout union).
>>>
>>> If the passed in timeout is equal to -1 the per-dentry timeout and
>>> flag are cleared providing for the "unmount" option. If the timeout
>>> is greater than or equal to 0 the timeout is set to the value and the
>>> flag is also set. If the dentry timeout is 0 the dentry will not expire
>>> by timeout which enables the implementation of the "nounmount" option
>>> for the specific mount. When the dentry timeout is greater than zero it
>>> allows for the implementation of the "utimeout=<seconds>" option.
>>>
>>> Signed-off-by: Ian Kent <raven@themaw.net>
>>> ---
>>>   fs/autofs/autofs_i.h         |  4 ++
>>>   fs/autofs/dev-ioctl.c        | 97 
>>> ++++++++++++++++++++++++++++++++++--
>>>   fs/autofs/expire.c           |  7 ++-
>>>   fs/autofs/inode.c            |  2 +
>>>   include/uapi/linux/auto_fs.h |  2 +-
>>>   5 files changed, 104 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/fs/autofs/autofs_i.h b/fs/autofs/autofs_i.h
>>> index 8c1d587b3eef..77c7991d89aa 100644
>>> --- a/fs/autofs/autofs_i.h
>>> +++ b/fs/autofs/autofs_i.h
>>> @@ -62,6 +62,7 @@ struct autofs_info {
>>>       struct list_head expiring;
>>>         struct autofs_sb_info *sbi;
>>> +    unsigned long exp_timeout;
>>>       unsigned long last_used;
>>>       int count;
>>>   @@ -81,6 +82,9 @@ struct autofs_info {
>>>                       */
>>>   #define AUTOFS_INF_PENDING    (1<<2) /* dentry pending mount */
>>>   +#define AUTOFS_INF_EXPIRE_SET    (1<<3) /* per-dentry expire 
>>> timeout set for
>>> +                      this mount point.
>>> +                    */
>>>   struct autofs_wait_queue {
>>>       wait_queue_head_t queue;
>>>       struct autofs_wait_queue *next;
>>> diff --git a/fs/autofs/dev-ioctl.c b/fs/autofs/dev-ioctl.c
>>> index 5bf781ea6d67..f011e026358e 100644
>>> --- a/fs/autofs/dev-ioctl.c
>>> +++ b/fs/autofs/dev-ioctl.c
>>> @@ -128,7 +128,13 @@ static int validate_dev_ioctl(int cmd, struct 
>>> autofs_dev_ioctl *param)
>>>               goto out;
>>>           }
>>>   +        /* Setting the per-dentry expire timeout requires a trailing
>>> +         * path component, ie. no '/', so invert the logic of the
>>> +         * check_name() return for AUTOFS_DEV_IOCTL_TIMEOUT_CMD.
>>> +         */
>>>           err = check_name(param->path);
>>> +        if (cmd == AUTOFS_DEV_IOCTL_TIMEOUT_CMD)
>>> +            err = err ? 0 : -EINVAL;
>>>           if (err) {
>>>               pr_warn("invalid path supplied for cmd(0x%08x)\n",
>>>                   cmd);
>>> @@ -396,16 +402,97 @@ static int autofs_dev_ioctl_catatonic(struct 
>>> file *fp,
>>>       return 0;
>>>   }
>>>   -/* Set the autofs mount timeout */
>>> +/*
>>> + * Set the autofs mount expire timeout.
>>> + *
>>> + * There are two places an expire timeout can be set, in the autofs
>>> + * super block info. (this is all that's needed for direct and offset
>>> + * mounts because there's a distinct mount corresponding to each of
>>> + * these) and per-dentry within within the dentry info. If a 
>>> per-dentry
>>> + * timeout is set it will override the expire timeout set in the 
>>> parent
>>> + * autofs super block info.
>>> + *
>>> + * If setting the autofs super block expire timeout the 
>>> autofs_dev_ioctl
>>> + * size field will be equal to the autofs_dev_ioctl structure size. If
>>> + * setting the per-dentry expire timeout the mount point name is 
>>> passed
>>> + * in the autofs_dev_ioctl path field and the size field updated to
>>> + * reflect this.
>>> + *
>>> + * Setting the autofs mount expire timeout sets the timeout in the 
>>> super
>>> + * block info. struct. Setting the per-dentry timeout does a little 
>>> more.
>>> + * If the timeout is equal to -1 the per-dentry timeout (and flag) is
>>> + * cleared which reverts to using the super block timeout, 
>>> otherwise if
>>> + * timeout is 0 the timeout is set to this value and the flag is left
>>> + * set which disables expiration for the mount point, lastly the flag
>>> + * and the timeout are set enabling the dentry to use this timeout.
>>> + */
>>>   static int autofs_dev_ioctl_timeout(struct file *fp,
>>>                       struct autofs_sb_info *sbi,
>>>                       struct autofs_dev_ioctl *param)
>>>   {
>>> -    unsigned long timeout;
>>> +    unsigned long timeout = param->timeout.timeout;
>>> +
>>> +    /* If setting the expire timeout for an individual indirect
>>> +     * mount point dentry the mount trailing component path is
>>> +     * placed in param->path and param->size adjusted to account
>>> +     * for it otherwise param->size it is set to the structure
>>> +     * size.
>>> +     */
>>> +    if (param->size == AUTOFS_DEV_IOCTL_SIZE) {
>>> +        param->timeout.timeout = sbi->exp_timeout / HZ;
>>> +        sbi->exp_timeout = timeout * HZ;
>>> +    } else {
>>> +        struct dentry *base = fp->f_path.dentry;
>>> +        struct inode *inode = base->d_inode;
>>> +        int path_len = param->size - AUTOFS_DEV_IOCTL_SIZE - 1;
>>> +        struct dentry *dentry;
>>> +        struct autofs_info *ino;
>>> +
>>> +        if (!autofs_type_indirect(sbi->type))
>>> +            return -EINVAL;
>>> +
>>> +        /* An expire timeout greater than the superblock timeout
>>> +         * could be a problem at shutdown but the super block
>>> +         * timeout itself can change so all we can really do is
>>> +         * warn the user.
>>> +         */
>>> +        if (timeout >= sbi->exp_timeout)
>>> +            pr_warn("per-mount expire timeout is greater than "
>>> +                "the parent autofs mount timeout which could "
>>> +                "prevent shutdown\n");
>> Wouldn't it be possible to just record the lowest known per-dentry
>> timeout in idk sbi->exp_lower_bound and reject sbi->exp_timeout changes
>> that go below that?
>
> Not sure I understand what your saying here.

Having re-read what you said I think I understand what your saying now.


I was mislead by the lower bound wording, the warning talks about a 
per-dentry timeout setting

that's longer than the timeout set for this indirect autofs mount. TBH 
I'm not even sure this

warning is worthwhile since most user space builds should just leave 
in-use mounts mounted at exit

and automount should just re-instate them at startup and continue on as 
though nothing had happened.

But I thought it worth a warning so that users know the timeouts they 
are using are longer than the

parent (global for these indirect mounts) timeout.


I can certainly get rid of it if you prefer.


Ian

>
>
> The (amd) auto-mounted mounts are each meant to be able to expire 
> independently,
>
> according to the timeout set for each of them rather than use the 
> global timeout set
>
> in the autofs (parent) mount.
>
>
> But your comment is useful because I do use a polling mechanism in 
> user space to check
>
> for expiration and the frequency of checking becomes a problem when I 
> introduce this.
>
> Setting a lower bound may make the frequency to short (for very large 
> directories) and
>
> I think there will be difficulties working out when the frequency 
> needs to be reduced
>
> after changes. But these are problems that I think can be left to user 
> space, not sure
>
> yet. For now it will be adequate to go with the default frequency 
> based on the parent
>
> mount as it is now (ie. a check frequency of one quarter of the expire 
> global timeout).
>
>
> Ian
>
>

