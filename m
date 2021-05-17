Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCB53839BF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 May 2021 18:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345466AbhEQQ0s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 May 2021 12:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345229AbhEQQ0o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 May 2021 12:26:44 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5143BC068C88
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 May 2021 08:00:25 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id f18so5992743qko.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 May 2021 08:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0iwhvs+6VvKWe5cUstxTCLL3gDqpdpHSbFsYoay5N9k=;
        b=aJtoVK31IL3XYzk4Ljmi8FNWT5sEx1fNSL9os/YhNRoHayO/p18JSEJhoxaHGRvG5i
         kFiFcwvvJW8q4/+h+vP0CvKrogeENot1VAfVm1DoLT8gmm45ftcb7FrUW+SIYnbsqHL5
         KnSvwKDL4UxADleu3rb4zo669TlnvjGaVm41RhihQlLz/+Q5or4J9tgKVRqxo/5n6q9O
         AgTTI04sZna5HXVTjOK4cHfOEJX92MQ9kuj1fxOed65Z9B0gjIM3VIfvgMm1iYgbeGJB
         Fm074hHCMECH0NgLj9y8yEHrhEVrsQwwkA0834qhAg32DVzLGYb5qCO/601McTKaNdXZ
         ZQJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0iwhvs+6VvKWe5cUstxTCLL3gDqpdpHSbFsYoay5N9k=;
        b=eR2Lf8UFYXeHncLnv0zzT3qOJ0rElga3KM0JG6VG2dhoj+dqeqo3dfSbqYfybhQ3qZ
         7hyHoOZcLzSIsk6lsR7/g5BUE3IRFjl4IXtIxZNLG7TCutaH+6RsbQ3/Fj4bYwF3d6pl
         HFDS1iVU2p7gj+uO5itZGdc95me289iFKtCHhajmfczDC3s8AOSjwoPq2/ds+3yjkTVv
         +WSED7tyLh6fTrhZZkMkyX3XnwnbZxI+oZfkmhAqGC+hhOwmCAGep7S0GbpWUXD4wJP7
         wB4JVJqQ79q9n2+EkuY3qTgZNk4CthER4UP0pvHRyj+nndz3NI+wQ/X+JNLhcxGo+HVP
         ITfw==
X-Gm-Message-State: AOAM532dr9KKK2wu89Mc/uyXbXyTkHn5Z1vLDZEMq4fo4ZyME9F8pNyi
        UhHt1Ln9xHty00qrCYr+4Mu91Q==
X-Google-Smtp-Source: ABdhPJzVZRUXR2A4P1VgifpzLXfuXyAqQKJXYQ9XPjD06JjLgDkZMPyV1FjTOjWUP3Su8/cx6PR8Iw==
X-Received: by 2002:a37:a2c5:: with SMTP id l188mr206208qke.413.1621263624266;
        Mon, 17 May 2021 08:00:24 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11c1::1180? ([2620:10d:c091:480::1:9b79])
        by smtp.gmail.com with ESMTPSA id t139sm10646948qka.85.2021.05.17.08.00.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 08:00:23 -0700 (PDT)
Subject: Re: [PATCH v3] fsnotify: rework unlink/rmdir notify events
To:     Jan Kara <jack@suse.cz>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        amir73il@gmail.com, wangyugui@e16-tech.com
References: <568db8243e9faa0efb9ffb545ffac5a2f87e65ef.1620999079.git.josef@toxicpanda.com>
 <20210517144832.GC25760@quack2.suse.cz>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <55e04814-3d3d-1884-b17d-95ed4b57dc33@toxicpanda.com>
Date:   Mon, 17 May 2021 11:00:21 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210517144832.GC25760@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/17/21 10:48 AM, Jan Kara wrote:
> Hi!
> 
> Thanks for the patch but I think you missed Amir's comments to your v2 [1]?
> Also ...
> 

I think they came in after I sent v3, but I got mailinglist signup spammed last 
week, so needless to say my ability to deal with emails for the last week has 
been hampered a bit.  I'm going through his review and will send out v4 
today/tomorrow.

>> diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
>> index 42e5a766d33c..714e6f9b74f5 100644
>> --- a/fs/devpts/inode.c
>> +++ b/fs/devpts/inode.c
>> @@ -617,12 +617,17 @@ void *devpts_get_priv(struct dentry *dentry)
>>    */
>>   void devpts_pty_kill(struct dentry *dentry)
>>   {
>> +	struct inode *dir = d_inode(dentry->d_parent);
>> +	struct inode *inode = d_inode(dentry);
>> +
>>   	WARN_ON_ONCE(dentry->d_sb->s_magic != DEVPTS_SUPER_MAGIC);
>>   
>> +	ihold(inode);
>>   	dentry->d_fsdata = NULL;
>>   	drop_nlink(dentry->d_inode);
>> -	fsnotify_unlink(d_inode(dentry->d_parent), dentry);
>>   	d_drop(dentry);
>> +	fsnotify_delete(dir, dentry, inode);
>> +	iput(inode);
>>   	dput(dentry);	/* d_alloc_name() in devpts_pty_new() */
>>   }
> 
> AFAICT d_drop() actually doesn't make the dentry negative so there's no
> need for this inode reference game? And similarly for d_invalidate() below?
> Or am I missing something?
> 

Nope you're right, I had it in my head that ___d_drop would do the 
dentry_unlink_inode, but it doesn't, I'll fix this, thanks,

Josef
