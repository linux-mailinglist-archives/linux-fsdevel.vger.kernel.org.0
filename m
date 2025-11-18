Return-Path: <linux-fsdevel+bounces-68991-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 28977C6ACE5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 18:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C618635D939
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 16:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D8936A028;
	Tue, 18 Nov 2025 16:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AxCKqRr5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDE7324B26
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 16:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763485149; cv=none; b=KrA4AzJeQFJpMFoOLioVsddL6ybSYvDi1iB0FMP8BJRrRyh2K+lbeYW12CdOSvn7ZtO/azmY0Bx9Y7ll1eQXHqn7lhchI1WbIYWfaYt6/1Ix/xJ3io+2Jr+SDUgQFue0zwWIPzL6CpiMH4mi5zG2eD6WxWYiHT+3MWbOLU4RGGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763485149; c=relaxed/simple;
	bh=WLo847SDfD1QCxmTeZRltY/5VT8tCb0utDVdohvrHV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XDD5FrK5HI4/8XoHWaGacD9UjONEh4J/l61cqzJjQmYf3JPOMV+UJ8iQqSBiYPVofA4HqfnYHTugTGzPeuCm/c65ODndTi40nwu3H3QiZWTyT2MtJDizA6s435yRvRXe7mGh6BDiO8GSV/jfkWe+vWe/tnBgNY3psevmgws12Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AxCKqRr5; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4779c9109ceso2545755e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 08:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763485144; x=1764089944; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fH6yrr3mk2hF9MFwBpc5vjdUGcfqUWDzkCmJwfsCLRY=;
        b=AxCKqRr5a5xxPl2UANZnhewAyqm1nQ86VFlYBuaB+e/cXwTpWLEz8MHHvRk6oXUKSv
         lvU2mst8vPljvJW12VQCpUx+DS/Ns5ErBbn0tcnBvFLEw0CQEWRL8K6XNm1XKEPYjM5/
         0LYaxzdAhofSSVNQtl3AzEfz6RSguCIC+r01jLvH8U69letgFxFoW5EB43oHnT5ngs+K
         vCZ8iCMxxr0l9gEONU71R4c+yDlDkTOnkKDTt0sq3bbn0CBU0hUsjEBzglGa+C1hjimv
         NA+qfTAGEWNkC9B15B/HCoY6vNHrhK+D35jKO9gvext2jgYZFkiZQ9vDxeZ7fg7zeu6p
         2ZMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763485144; x=1764089944;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fH6yrr3mk2hF9MFwBpc5vjdUGcfqUWDzkCmJwfsCLRY=;
        b=jC+YKl+c0Xsc/Tvrxos+kH7qw8OaEpILoq5GpFzzpX4ip0z5itOFWEDIrT3X8dPsB+
         u4WxQxgo13Pr+n207rXp64atMEJQhYM7MKLIp6wmZWOhvQiyAe8OwHsnQYcdwRyez34i
         hxg19nMdYffnzMPOfvArKmwrSKVJC3M52mMnVQxCPTHKk1FQ2zd5A8MjC4CF/0bOuUES
         FoVrb4pjfoW7eKkYKXFHI44qum+cYLaC8ECD1xRH0KSYzZ8YXeQFZHY22l7w5xAJCt01
         C05NI43gtgiU3Jivl0K2ZIedUN2XEA17wo2eHQzAcIjhKlQDCIEzva6ZnCmDBng0mxst
         3cQw==
X-Forwarded-Encrypted: i=1; AJvYcCX8sO8SBdHn7Bf3z/Nqky0wheKkl+LbKIMCB31zqWy2DdrA0f+UAj7hvREjNsg/Ud4S/WoUwBQtmSynwUiD@vger.kernel.org
X-Gm-Message-State: AOJu0YyByKIdRq9GAltk6BBc+1fsu8dP9Fq/CsM5jskDv41k2xHGXCNl
	nuIqyssfHw1ZxTLqEFYppD4I9xECFL0+iMNlyElbGky0myA13l9UXcr9
X-Gm-Gg: ASbGncu+dR6Ye3cy5Ug/9Y9Ebsvc718Hu7dwIaD//DbMp0DLZFvB024Ug9jvlK442RL
	A+pX8nX1woiArLPxaBFG3dT5fai4AXlKEdIyXSZDcDHH09eXyNXdVNWl54cEEex5Ln8t6+nfoQa
	kQlRoUEyP+ghiwxxmFGgjUacnG2x2kdZSWyHFa9fz45Ivn1iT5RKUoZHikuObvwTuxh+l6Vcr7X
	MXB8QrjOFQvMwR3p5PBdrWLc9S+UTHLGUHnmoFbSTbsvNuycIL1NyxkRPpeGMUB+bAVA1a3Yf4k
	Tgs9tGKtgIpw47f4J8fjOSs8Qkgklg6PQ0qtMQxkEtFNgOsEbEoZ/i3CqJDzpzVmFOzDRaDLuC/
	zDs+xN4/w7QGaY4Uw5MO7azVghp0RX3cCq58dyW+jRwU+R8gINZZ6rcsjoGNCwtoX+tJBj388Ri
	JPPTEuAQef4DWWsYodfy0=
X-Google-Smtp-Source: AGHT+IHheqrevn6qdnNYQ2vphQ/c4Oh/9NTKjjDZ/bfh4YOqWf8mlyCRscmyfz955g1yg1atfOYTwg==
X-Received: by 2002:a05:600c:35c3:b0:477:9c9e:ec6c with SMTP id 5b1f17b1804b1-477a9c3c61cmr18310965e9.8.1763485143511;
        Tue, 18 Nov 2025 08:59:03 -0800 (PST)
Received: from [192.168.1.105] ([165.50.73.153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e91f2dsm34086949f8f.19.2025.11.18.08.59.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 08:59:03 -0800 (PST)
Message-ID: <a6232916-7bc5-44ac-9ac7-17ec306fe45a@gmail.com>
Date: Tue, 18 Nov 2025 18:58:44 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/super: fix memory leak of s_fs_info on
 setup_bdev_super failure
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: brauner@kernel.org, jack@suse.cz,
 syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com, frank.li@vivo.com,
 glaubitz@physik.fu-berlin.de, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, slava@dubeyko.com,
 syzkaller-bugs@googlegroups.com, skhan@linuxfoundation.org,
 david.hunter.linux@gmail.com, khalid@kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org
References: <20251114165255.101361-1-mehdi.benhadjkhelifa@gmail.com>
 <20251118145957.GD2441659@ZenIV>
 <6c482108-78b8-4e09-814a-67820a5c021e@gmail.com>
 <20251118163509.GE2441659@ZenIV>
Content-Language: en-US
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
In-Reply-To: <20251118163509.GE2441659@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/18/25 5:35 PM, Al Viro wrote:
> On Tue, Nov 18, 2025 at 05:21:59PM +0100, Mehdi Ben Hadj Khelifa wrote:
> 
>>> Almost certainly bogus; quite a few fill_super() callbacks seriously count
>>> upon "->kill_sb() will take care care of cleanup if we return an error".
>>
>> So should I then free the allocated s_fs_info in the kill_block_super
>> instead and check for the null pointer in put_fs_context to not execute
>> kfree in subsequent call to hfs_free_fc()?
> 
> Huh?  How the hell would kill_block_super() know what to do with ->s_fs_info
> for that particular fs type?  kill_block_super() is a convenience helper,
> no more than that...
> 
Yes, I missed that. Since i only looked at the hfs_free_fc(), I forgot 
that in kill_block_super() it handles all fs types not only hfs which 
only frees s_fs_info.

>> Because the error generated in setup_bdev_super() when returned to
>> do_new_mount() (after a lot of error propagation) it doesn't get handled:	
>> 	if (!err)
>> 		err = do_new_mount_fc(fc, path, mnt_flags);
>> 	put_fs_context(fc);
>> 	return err;
> 
> Would be hard to handle something that is already gone, wouldn't it?
> deactivate_locked_super() after the fill_super() failure is where
> the superblock is destroyed - nothing past that point could possibly
> be of any use.
> 
> I would still like the details on the problem you are seeing.

The Problem isn't produced by fill_super failure, instead it's produced 
by setup_bdev_super failure just a line before it. here is a snip from 
fs/super:

		error = setup_bdev_super(s, fc->sb_flags, fc);
		if (!error)
			error = fill_super(s, fc);
		if (error) {
			deactivate_locked_super(s);
			return error;
		}
and in the above code, fc->s_fs_info has already been transferred to sb 
as you have mentionned in the sget_fc() function before the above snip.
But subsequent calls after setup_bdev_super fail to free s_fs_info IIUC.


> 
> Normal operation (for filesystems that preallocate ->s_fs_info and hang
> it off fc) goes like this:
> 
> 	* fc->s_fs_info is allocated in ->init_fs_context()
> 	* it is modified (possibly) in ->parse_param()
> 	* eventually ->get_tree() is called and at some point it
> asks for superblock by calling sget_fc().  It may fail (in which
> case fc->s_fs_info stays where it is), if may return a preexisting
> superblock (ditto) *OR* it may create and return a new superblock.
> In that case fc->s_fs_info is no more - it's been moved over to
> sb->s_fs_info.  NULL is left behind.  From that point on the
> responsibility for that sucker is with the filesystem; nothing in
> VFS has any idea where to find it.
> 
In this case, it doesn create a new superblock which transferes the 
ownership of the pointer. But as i said the problem is that in the error 
path of setup_bdev_super(), there is no freeing of such memory and since 
the pointer has already been transfered and it's the responsibility is 
with the filesystem, put_fs_context() calling hfs_free_fc() doesn't free 
the allocated memory too.
> Again, there is no such thing as transferring it back to fc - once
> fill_super() has been called, there might be any number of additional
> things that need to be undone.
> 
As I said above, fill_super isn't even called in this case.
> For HFS I would expect that hfs_fill_super() would call hfs_mdb_put(sb)
> on all failures and have it called from subsequent ->put_super() if
> we succeed and later unmount the filesystem.  That seems to be where
> ->s_fs_info is taken out of superblock and freed.
> 
> What do you observe getting leaked and in which case does that happen?
> 
Exactly in bdev_file_open_by_dev() in the setup_bdev_super call 
mentionned above is what triggers the error path that doesn't free the 
hfs_sb_info since hfs_free_fc calls kfree on a NULL pointer..

