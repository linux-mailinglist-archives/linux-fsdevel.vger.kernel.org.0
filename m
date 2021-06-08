Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E64F39FB0A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jun 2021 17:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbhFHPml (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Jun 2021 11:42:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27772 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231961AbhFHPme (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Jun 2021 11:42:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623166841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ORZc1zixp8oUuIUPVE92AjT1Etx12X1YTrPl2rXFZL0=;
        b=b10QH0SjzzwvTh+KzmpOx8XQjL4/RMSkcQ8les2UjUf8mnfR1vHPdCLKNKus3wBGoBnPW2
        SBKrnA5uWax8bg9GLrhY+RMv4jISbyrk9qBgEM4bwdR4Z5E1oVE4/JGh6R56Vf2hknPdvI
        VHVor0rIIPlsQ69rk5tgTYmBUV60iOc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-SIJqB3DqPim6Z4V8wMQ4Ag-1; Tue, 08 Jun 2021 11:40:39 -0400
X-MC-Unique: SIJqB3DqPim6Z4V8wMQ4Ag-1
Received: by mail-wr1-f72.google.com with SMTP id x9-20020a5d49090000b0290118d8746e06so9643064wrq.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Jun 2021 08:40:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ORZc1zixp8oUuIUPVE92AjT1Etx12X1YTrPl2rXFZL0=;
        b=VxS0poLD68BFJO1UfeX8rFgUtPWoI4084IFUAIDBkb2aLhrVlpQUMzhLSf8TXvumZA
         cY1RhGOV1SHspubdmUmcDZUbwcWgIU3ZJ5Xx/+RJNUH8b+0hr/U/Jgqc3wiQ8XfY8MxM
         vEMRmQJXPLNLKlpwXjDMpa3Blr6vqkAvJO87cmyKv2mbAqHCWNyceoeZwSm0zQIpTrkq
         MyMHBwMJNhpm/XbkwkSvHZSVK2/F6rGpiWkbW/0uc563gTgR+SuqznIk07+eY16B2eTZ
         xtbruADNAyDMVfP1rHiAXE3RH9PBX2F9o5hVnl9kUC0IS1GsryjrkrkrxaoRpITf905Y
         StAQ==
X-Gm-Message-State: AOAM5335oNIBcPaLJmMKwa+9jDydpqMajsD0qi9l/qvoE6hkv23rRq4y
        Wf8krrQ3glrHpxNoB+gy912SoUDuvmykdt7RzDs2OzlKKebEYdPmifU/JbQzvjKI3WEM0eusxUr
        omFYCBfqcmkCoC6sPZs9qnob5dg==
X-Received: by 2002:adf:e591:: with SMTP id l17mr18369839wrm.46.1623166838506;
        Tue, 08 Jun 2021 08:40:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxk0Z/tAFwqxqMSIUyFBJY4g4TjfpttrnmxkRMh9DwuD2UbZhmt7nHdIZyip6VFTSh9Dm7Tig==
X-Received: by 2002:adf:e591:: with SMTP id l17mr18369820wrm.46.1623166838358;
        Tue, 08 Jun 2021 08:40:38 -0700 (PDT)
Received: from dresden.str.redhat.com ([2a02:908:1e46:160:b272:8083:d5:bc7d])
        by smtp.gmail.com with ESMTPSA id u7sm17307067wrt.18.2021.06.08.08.40.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 08:40:38 -0700 (PDT)
Subject: Re: [PATCH v2 5/7] fuse: Call vfs_get_tree() for submounts
To:     Greg Kurz <groug@kaod.org>, Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        virtio-fs@redhat.com, Vivek Goyal <vgoyal@redhat.com>
References: <20210604161156.408496-1-groug@kaod.org>
 <20210604161156.408496-6-groug@kaod.org>
From:   Max Reitz <mreitz@redhat.com>
Message-ID: <f4161490-f7ed-78f0-bf05-96040cbb31e9@redhat.com>
Date:   Tue, 8 Jun 2021 17:40:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210604161156.408496-6-groug@kaod.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 04.06.21 18:11, Greg Kurz wrote:
> We recently fixed an infinite loop by setting the SB_BORN flag on
> submounts along with the write barrier needed by super_cache_count().
> This is the job of vfs_get_tree() and FUSE shouldn't have to care
> about the barrier at all.
>
> Split out some code from fuse_dentry_automount() to the dedicated
> fuse_get_tree_submount() handler for submounts and call vfs_get_tree().
>
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>   fs/fuse/dir.c   | 53 +++++--------------------------------------------
>   fs/fuse/inode.c | 36 +++++++++++++++++++++++++++++++++
>   2 files changed, 41 insertions(+), 48 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>

