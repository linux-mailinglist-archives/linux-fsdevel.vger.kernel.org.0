Return-Path: <linux-fsdevel+bounces-33882-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF059C01B7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 11:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E19AE1C21CF9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 10:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E091E32D3;
	Thu,  7 Nov 2024 10:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L8+D/fUJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6A911713
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Nov 2024 10:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730973647; cv=none; b=uCY+nkPnBX/klKzmHUuVTP0pqaIJ3iqppyEX0KqR7rLIt5D8/OcE7UET3acXUJMzhTQ7R81x1d9OpAMMCb1NJ/dEClwI1IavIb+QJI1aPntU9N16DVSA1EvOzD04iJF9PSLax/l9FIh9nxU9rs/io4coBxCELDKo/xE/YyQZE50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730973647; c=relaxed/simple;
	bh=aqjoNKp2S9Ndl0SDCZhvztC+Qxb1K+IZewbpE7vLWNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZtN68JEqD93zV5yrNc4JCWmodpj+VLaXWNPkNdfN5NKHw3j+vRkdTNVQf/D5ZfEG3SpEuBuqVgV8RTqN5kfLlHq++V/UENifLPAS98yc6sMndeYHP4Z+WQ+HFccORFEcjZPUu/5vKYInsvxM3Wf5t648EL0vpsmGkfRK9zODS1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L8+D/fUJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730973644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wMRls0F9ydo7Vi4Rq8kDlXTiyUFTrT/9Qwqc8sG653I=;
	b=L8+D/fUJI9+1brh4sK6BzOQYu2L+KLmQgULCa20Y2sAy3DuhZiA4UF4akw0++Qu2UOFKpz
	I9UVrK8rfRvTsCC355wnHIEok0NutTMRXnSpJwlGKhUELD9+R84/AN6SP8eSl5TKJeVtc6
	ZVKfnonYrDvWSCDgTHAHx3lkTM90Lm8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-kYqAhd9IO3ec4VQAZTYpSg-1; Thu, 07 Nov 2024 05:00:43 -0500
X-MC-Unique: kYqAhd9IO3ec4VQAZTYpSg-1
X-Mimecast-MFC-AGG-ID: kYqAhd9IO3ec4VQAZTYpSg
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a9a157d028aso61035066b.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Nov 2024 02:00:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730973642; x=1731578442;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wMRls0F9ydo7Vi4Rq8kDlXTiyUFTrT/9Qwqc8sG653I=;
        b=nRF5Pq8+NWgGl4gDvoNJG0iQQDPwugFD0rPL8fDbHem3CGOEuEkZvGEqa/k0VN2XJe
         9GQiQ3hhwgxOvJmn/HSiGeVYR3q6ZbKTv6ywMI7UF/NAfQ5zeA4L+4/1WgZe9pbhKPqj
         EoigWhvPPIzkthW369t7fa9EYiv0PuWtp1Ffum5RB0gaT62W5eGZGSRiOJXOY7KjRWLT
         0iiYqt5QF8h9xXN5qIiC1H5IFVz/FjgJ03h0IOBBXWii8X5+LFUrkqoQMkmdCq5aX1s6
         suJFBQB39QYmjeqMctgTfbsd4vMcZO0gaeDBLLPXumwTCrCUXFXtRNZEHXnXFMWjmZ24
         jvAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsZk+y67dhqqoSn6zUD4YDsN1SFMv4pWPJdo+iPWcT+aOwAKecngRoTV8yhZh6zX/JROw7/0UQHL5G4pyQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyYyw70hG7tdZ7Zwxl9dY+bCb0swHo5t6VmThnGRsA0OtwPTp1X
	dcUXQkQgoyXiAUExCRp2JkmAxx7ge/3CJioZtUacAQxynUCsiWtPwltN1u5Dj5xa9npZ9zFRgPz
	RcjCG51a9xK+o9NRsjGJMZs9LJJ1Qy1xhftFSkWXkpbU2ZTIJcbXiwe5bqP43WCU=
X-Received: by 2002:a17:907:2d8d:b0:a99:482c:b2b9 with SMTP id a640c23a62f3a-a9e654f8c64mr2022863466b.29.1730973641828;
        Thu, 07 Nov 2024 02:00:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH+UiHY6KfVKme49Q9BKA6KUY4URDrdyvHhjCJaFYWZ6LZ65QWLQegd4LMhZnQOySL8p+kcuQ==
X-Received: by 2002:a17:907:2d8d:b0:a99:482c:b2b9 with SMTP id a640c23a62f3a-a9e654f8c64mr2022860366b.29.1730973641439;
        Thu, 07 Nov 2024 02:00:41 -0800 (PST)
Received: from ?IPV6:2003:cf:d711:bb59:b996:2e0b:622e:25cc? (p200300cfd711bb59b9962e0b622e25cc.dip0.t-ipconnect.de. [2003:cf:d711:bb59:b996:2e0b:622e:25cc])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0e2f0b5sm70060566b.192.2024.11.07.02.00.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2024 02:00:40 -0800 (PST)
Message-ID: <ae437cf6-caa2-4f9a-9ffa-bdc7873a99eb@redhat.com>
Date: Thu, 7 Nov 2024 11:00:39 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio-fs: Query rootmode during mount
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 virtualization@lists.linux.dev, Miklos Szeredi <mszeredi@redhat.com>,
 German Maglione <gmaglione@redhat.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Vivek Goyal <vgoyal@redhat.com>
References: <20241024164726.77485-1-hreitz@redhat.com>
 <CAJfpeguWjwXtM4VJYP2+-0KK5Jkz80eKpWc-ST+yMuKL6Be0=w@mail.gmail.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <CAJfpeguWjwXtM4VJYP2+-0KK5Jkz80eKpWc-ST+yMuKL6Be0=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 07.11.24 09:58, Miklos Szeredi wrote:
> On Thu, 24 Oct 2024 at 18:47, Hanna Czenczek <hreitz@redhat.com> wrote:
>
>> To be able to issue INIT (and GETATTR), we need to at least partially
>> initialize the super_block structure, which is currently done via
>> fuse_fill_super_common().
> What exactly is needed to be initialized?

It isn’t much, but I believe it’s most of fuse_fill_super_common() 
(without restructuring the code so flags returned by INIT are put into a 
separate structure and then re-joined into sb and fc later).

fuse_send_init() reads sb->s_bdi->ra_pages, process_init_reply() writes 
it and sb->s_time_gran, ->s_flags, ->s_stack_depth, ->s_export_op, and 
->s_iflags.  In addition, process_init_reply() depends on several flags 
and objects in fc being set up (among those are fc->dax and 
fc->default_permissions), which is done by fuse_fill_super_common().

So I think what we need from fuse_fill_super_common() is:
- fuse_sb_defaults() (so these values can then be overwritten by 
process_init_reply()),
- fuse_dax_conn_alloc(),
- fuse_bdi_init(),
- fc->default_permissions at least, but I’d just take the fc->[flag] 
setting block as a whole then.

I assume we’ll also want the SB_MANDLOCK check then, and 
rcu_assign_pointer().  Then we might as well also set the block sizes 
and the subtype.

The problem is that I don’t know the order things in 
fuse_fill_super_common() need to be in, and fuse_dev_alloc_install() is 
called before fuse_bdi_init(), so I didn’t want to move that.

So what I understand is that calling fuse_dev_alloc_install() there 
isn’t necessary?  I’m happy to move that to part 2, as you suggest, but 
I’m not sure we can really omit much from part 1 without changing how 
process_init_reply() operates.  We could in theory delay 
process_init_reply() until after GETATTR (and thus after setting 
s_root), but that seems kind of wrong, and would still require setting 
up BDI and DAX for fuse_send_init().

>> @@ -1762,18 +1801,12 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
>>          sb->s_d_op = &fuse_dentry_operations;
>>
>>          mutex_lock(&fuse_mutex);
>> -       err = -EINVAL;
>> -       if (ctx->fudptr && *ctx->fudptr)
>> -               goto err_unlock;
>> -
>>          err = fuse_ctl_add_conn(fc);
>>          if (err)
>>                  goto err_unlock;
>>
>>          list_add_tail(&fc->entry, &fuse_conn_list);
>>          sb->s_root = root_dentry;
>> -       if (ctx->fudptr)
>> -               *ctx->fudptr = fud;
> This is wrong, because we need the fuse_mutex protection for checking
> and setting the private_data on the fuse device file.
>
> If this split is needed (which I'm not sure) then fud allocation
> should probably be moved to part2 instead of moving the *ctx->fudptr
> setup to part1.
>
>
>> @@ -1635,8 +1657,16 @@ static void virtio_kill_sb(struct super_block *sb)
>>          struct fuse_mount *fm = get_fuse_mount_super(sb);
>>          bool last;
>>
>> -       /* If mount failed, we can still be called without any fc */
>> -       if (sb->s_root) {
>> +       /*
>> +        * Only destroy the connection after full initialization, i.e.
>> +        * once s_root is set (see commit d534d31d6a45d).
>> +        * One exception: For virtio-fs, we call INIT before s_root is
>> +        * set so we can determine the root node's mode.  We must call
>> +        * DESTROY after INIT.  So if an error occurs during that time
>> +        * window (specifically in fuse_make_root_inode()), we still
>> +        * need to call virtio_fs_conn_destroy() here.
>> +        */
>> +       if (sb->s_root || (fm->fc && fm->fc->initialized && !fm->submount)) {
> How could fm->submount be set if sb->s_root isn't?

fuse_get_tree_submount(), specifically fuse_fill_super_submount() whose 
error path leads to deactivate_locked_super(), can fail before 
sb->s_root is set.

Still, the idea was rather to make it clear that this condition (INIT 
sent but s_root not set) is unique to non-submounts, so as not to mess 
with the submount code unintentionally.

> Or sb->s_root set
> and fc->initialized isn't?

That would be the non-virtio-fs non-submount case (fuse_fill_super()), 
where s_root is set first and INIT sent after.

Hanna

> Seems it would be sufficient to check fm->fc->initialized, no?
>
> Thanks,
> Miklos
>


