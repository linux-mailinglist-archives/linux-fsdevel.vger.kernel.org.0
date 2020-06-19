Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32B582008CF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jun 2020 14:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbgFSMiQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Jun 2020 08:38:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57135 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725446AbgFSMiP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Jun 2020 08:38:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592570293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P5+ozR9Mh9wRcX5EutPvXQ198atkpIm6K5Bk+g+xg4k=;
        b=NWtyybu2e3WWfi0CMSA5GNo6XXmgfGfAs0EljT0qLuSjQlKesm3JRi+1jZjCT+hiA7Bu4n
        oBEQUYnlBAP8dsFscVIkK5JG6Xl/UmEN9b4hUMbW+xTd39c9nN3rtj+pMe6B9ww55HqO/w
        VAVqTBCiG3R34211FHxJTQQvN68DJLY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-JwP6ZuSBMA-7djNeuQmRSA-1; Fri, 19 Jun 2020 08:38:11 -0400
X-MC-Unique: JwP6ZuSBMA-7djNeuQmRSA-1
Received: by mail-wm1-f71.google.com with SMTP id 11so2632181wmj.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jun 2020 05:38:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P5+ozR9Mh9wRcX5EutPvXQ198atkpIm6K5Bk+g+xg4k=;
        b=TRJsQBrvLa631vq6iBUrQ8wuif73Hcu0JTYIYOrvCM/DoIgN7K3ba4S6Uqv7jtOyq2
         2VuTqtfE+dfcmgFLmZMImE3ht3VaVRzPz6wKFVS7bFgCgTgOm7VMLNx/e7qCOG88GAv9
         bye63jvqLFDG8RvGdhjR5BJfqgAYqeWZz7lXq59/Eml4QaUjk/HeoEO5niZTi+VheI0C
         dBHvHU1yezi6twvTi649EiWWeQjiBYvTN2B7CWJShQYobCuUU7VkA7wHJ+bQoUcgzeka
         w3VJmBnQrF91Bj5vp7xGw/Ox+YEWG75iqN7YjpQkG5eorK0npuWTJive9h6H/Ae/qNce
         ChiQ==
X-Gm-Message-State: AOAM533U/FZ/ikvn7m404D3ypug4uvW3GH5q16nDuXKvKg2li0NzdaD6
        W2RF6yqaA4sjnwefmZU9dEXFw5NXXUoLCw9DX/ifJrFJL6kR+Np3v7MjTQSod8s88ii3LbrIj22
        CEGG6lqoBvPY/q42TKCLJn8em9Q==
X-Received: by 2002:a5d:5492:: with SMTP id h18mr3793405wrv.330.1592570290572;
        Fri, 19 Jun 2020 05:38:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyFuZ25wuwkQUd6CbPEmnrMjWv/3vMT/uGmOlAWutX7ws8+y5hFhlt6h1yO/BomxmeA09glnA==
X-Received: by 2002:a5d:5492:: with SMTP id h18mr3793384wrv.330.1592570290339;
        Fri, 19 Jun 2020 05:38:10 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e1d2:138e:4eff:42cb? ([2001:b07:6468:f312:e1d2:138e:4eff:42cb])
        by smtp.gmail.com with ESMTPSA id b204sm6017655wmb.12.2020.06.19.05.38.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2020 05:38:09 -0700 (PDT)
Subject: Re: [PATCH v3 0/7] libfs: group and simplify linux fs code
To:     Steven Rostedt <rostedt@goodmis.org>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
References: <20200504090032.10367-1-eesposit@redhat.com>
 <20200617170045.7d41976d@oasis.local.home>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <689597ee-114f-9334-2e1c-10a8250a61e1@redhat.com>
Date:   Fri, 19 Jun 2020 14:38:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200617170045.7d41976d@oasis.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 17/06/20 23:00, Steven Rostedt wrote:
> 
> What happened to this work?

Nobody has acked it or queued it.  Al?

Paolo

> -- Steve
> 
> 
> On Mon,  4 May 2020 11:00:25 +0200
> Emanuele Giuseppe Esposito <eesposit@redhat.com> wrote:
> 
>> libfs.c has many functions that are useful to implement dentry and inode
>> operations, but not many at the filesystem level.  As a result, code to
>> create files and inodes has a lot of duplication, to the point that
>> tracefs has copied several hundred lines from debugfs.
>>
>> The main two libfs.c functions for filesystems are simple_pin_fs and
>> simple_release_fs, which hide a somewhat complicated locking sequence
>> that is needed to serialize vfs_kern_mount and mntget.  In this series,
>> my aim is to add functions that create dentries and inodes of various
>> kinds (either anonymous inodes, or directory/file/symlink).  These
>> functions take the code that was duplicated across debugfs and tracefs
>> and move it to libfs.c.
>>
>> In order to limit the number of arguments to the new functions, the
>> series first creates a data type that is passed to both
>> simple_pin_fs/simple_release_fs and the new creation functions.  The new
>> struct, introduced in patch 2, simply groups the "mount" and "count"
>> arguments to simple_pin_fs and simple_release_fs.
>>
>> Patches 1-4 are preparations to introduce the new simple_fs struct and
>> new functions that are useful in the remainder of the series.  Patch 5
>> introduces the dentry and inode creation functions.  Patch 6-7 can then
>> adopt them in debugfs and tracefs.
>>
>> Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
>>
>> v1->v2: rename simple_new_inode in new_inode_current_time,
>> more detailed explanations, put all common code in fs/libfs.c
>>
>> v2->v3: remove unused debugfs_get_inode and tracefs_get_inode
>> functions
>>
>> Emanuele Giuseppe Esposito (7):
>>   apparmor: just use vfs_kern_mount to make .null
>>   libfs: wrap simple_pin_fs/simple_release_fs arguments in a struct
>>   libfs: introduce new_inode_current_time
>>   libfs: add alloc_anon_inode wrapper
>>   libfs: add file creation functions
>>   debugfs: switch to simplefs inode creation API
>>   tracefs: switch to simplefs inode creation API
>>
>>  drivers/gpu/drm/drm_drv.c       |  11 +-
>>  drivers/misc/cxl/api.c          |  13 +-
>>  drivers/scsi/cxlflash/ocxl_hw.c |  14 +-
>>  fs/binfmt_misc.c                |   9 +-
>>  fs/configfs/mount.c             |  10 +-
>>  fs/debugfs/inode.c              | 169 +++---------------
>>  fs/libfs.c                      | 299 ++++++++++++++++++++++++++++++--
>>  fs/tracefs/inode.c              | 106 ++---------
>>  include/linux/fs.h              |  31 +++-
>>  security/apparmor/apparmorfs.c  |  38 ++--
>>  security/inode.c                |  11 +-
>>  11 files changed, 399 insertions(+), 312 deletions(-)
>>
> 

