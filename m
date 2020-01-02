Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2F212EAB9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2020 21:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbgABUAz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jan 2020 15:00:55 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36323 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728296AbgABUAz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jan 2020 15:00:55 -0500
Received: by mail-wm1-f67.google.com with SMTP id p17so6738745wma.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Jan 2020 12:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=C/zqVBJss9FeKefd7C+16Ae2FlqoKun4UIZaiQyERGc=;
        b=bh8Rm5/FVZosPDfz+Mw5ff9vf/2j572WpXz9+0Va/yBflPMsqI44Jg62X6+/AeFj3V
         EQOKao/TAmkbp7yJsDnHSorYgfsmsL56FykZIR9KD9Auh8Fsw8QNNDLcYKCVg/9crTl2
         LwAVJFQWG9hTjgUfWKh/qZiatAQDrsgMONkdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C/zqVBJss9FeKefd7C+16Ae2FlqoKun4UIZaiQyERGc=;
        b=DTP4fYiD21x5PMw+xNjm92femPN0OeeYaHZX7WVoCr5PRMbSZNRxT2TPfG2s6KeCpe
         YBguUwatIaH75oF1SoGF5/E+WnpESl3MqWT19tVOGIQZnQqwn/Y+Jqo6+FlK1fztl4EL
         eqckVMqMMHMU2os20ai6GOrH6GBe3qBQ4Tgpp8PvX5rdN4bF8YH+vyl6qT6h2OEqhrLM
         tNZAxwQVh0isQhc+oawB4K8Yj6xDn3YFIpHHBMMKMgJut7Um5/Fg+cPCyN+m0Q3HEBEe
         nw1WbPL1tmzfSoea2QeVm1nktSwotMGXLKeN692BBrmDnop0QFNWBXxMsKkITHuSAmME
         ZfvA==
X-Gm-Message-State: APjAAAWx4SnlMpdEKLVbV4ZWGYMcFvpc01I7OWclQFSJ2dbSR5/lSrSR
        werv4LxlKgOY6sT6t3xxgQLoNX/exNbFqw==
X-Google-Smtp-Source: APXvYqzbBWegsQESMIUakWIouetdLTOWbJmmDhnF1qFIOEZFCKKaMuyr8vQCuBQy7j9XFt+KfkRr9A==
X-Received: by 2002:a7b:c183:: with SMTP id y3mr15283378wmi.45.1577995253252;
        Thu, 02 Jan 2020 12:00:53 -0800 (PST)
Received: from localhost ([2620:10d:c092:200::1:3256])
        by smtp.gmail.com with ESMTPSA id n10sm56618651wrt.14.2020.01.02.12.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 12:00:52 -0800 (PST)
Date:   Thu, 2 Jan 2020 20:00:52 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, kernel-team@fb.com
Subject: Re: [PATCH v2 1/2] tmpfs: Add per-superblock i_ino support
Message-ID: <20200102200052.GA1181932@chrisdown.name>
References: <cover.1577990599.git.chris@chrisdown.name>
 <738b3d565fe7c65f41c38e439fe3cbfa14f87465.1577990599.git.chris@chrisdown.name>
 <CAOQ4uxi0v4WL30gpedUbex-TD5wN8p8kCop_3VDYV0UBJGB21w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAOQ4uxi0v4WL30gpedUbex-TD5wN8p8kCop_3VDYV0UBJGB21w@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Amir Goldstein writes:
>Wouldn't it be easier to check max_inodes instead of passing this
>use_sb_ino arg?
>Is there any case where they *need* to differ?

Hmm, I suppose probably not? In that case should I just check against 
SB_KERNMOUNT, since max_inodes can only be 0 in that case?

>> @@ -3378,6 +3411,8 @@ enum shmem_param {
>>         Opt_nr_inodes,
>>         Opt_size,
>>         Opt_uid,
>> +       Opt_inode32,
>> +       Opt_inode64,
>
>Does not belong to this patch..
>
>>  };
>>
>>  static const struct fs_parameter_spec shmem_param_specs[] = {
>> @@ -3389,6 +3424,8 @@ static const struct fs_parameter_spec shmem_param_specs[] = {
>>         fsparam_string("nr_inodes",     Opt_nr_inodes),
>>         fsparam_string("size",          Opt_size),
>>         fsparam_u32   ("uid",           Opt_uid),
>> +       fsparam_flag  ("inode32",       Opt_inode32),
>> +       fsparam_flag  ("inode64",       Opt_inode64),
>
>Ditto

Bleh, I'll fix this and send v3.

>>         {}
>>  };
>>
>> @@ -3690,7 +3727,8 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
>>  #endif
>>         uuid_gen(&sb->s_uuid);
>>
>> -       inode = shmem_get_inode(sb, NULL, S_IFDIR | sbinfo->mode, 0, VM_NORESERVE);
>> +       inode = shmem_get_inode(sb, NULL, S_IFDIR | sbinfo->mode, 0,
>> +                               VM_NORESERVE, true);
>
>Should usb_sb_ino be true for the kern_mount??
>In any case, it wouldn't matter if it was false, hence no need to pass
>an argument
>and can either check for sbinfo->max_inodes or the SB_KERNMOUNT flag in
>shmem_get_inode().

Ok, cool. I'll fix these up and send v3. Thanks!
