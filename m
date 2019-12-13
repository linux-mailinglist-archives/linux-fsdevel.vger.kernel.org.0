Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC8911E838
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2019 17:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbfLMQ0L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Dec 2019 11:26:11 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:42921 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728225AbfLMQ0K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Dec 2019 11:26:10 -0500
Received: by mail-qv1-f67.google.com with SMTP id q19so1040130qvy.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2019 08:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=p2zNK7Z9rXnJvkUmnHIiSiOCLYCzfIxgsp3Urt3bVZI=;
        b=DcUdjlLuAQBgFO+ON9Fwnabvk311DFrPGfnZPeqd1J5AgTGQHp4uwL49LsE9iVrAw1
         Mya1GScFM60GV7J0Sf2B7mWcJNkoYLwHSSUoqI/a0eQ0LLVrMcDxQCMrPH6e2+2e1zBn
         xyrQ7vtzjbOfioNpq7+4l3SPHJcRUGMCDY3N74/87Gs2NrLMsf0ssBqA1eRglnQF592S
         se7VgtRQAR6nQveysu0elJWSOuOmfr3jAdh+w+wbguYRr9Nq/ReL2h0V5LZ5nccTpbdh
         pFiVdNGcQ/lyFC+Wk4Q+SwzLaM6+3BN3HIcDwybzqp6lre2vofy73WM1IMZcUWxhPWcA
         +cIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p2zNK7Z9rXnJvkUmnHIiSiOCLYCzfIxgsp3Urt3bVZI=;
        b=cpkshwqCqhLSKnNd9JBTIgcHd3zg+1z4UNUSTjZjj1W4mBd+L6eaGiFO/Vdhu67TA/
         LJqqQhyegghe3AZ357xMaWJQyeZS1doCuzq1c+l14KGx82ZxhJp99yBX/apMqwKSV6Zg
         CSqwPew/4OEcmmlLKe9T1EOZvw609LYst8lko21TGgPRsOOeMkWrDEfAbnDK4s0sNg3l
         UupBjhEg9ORI3hwXDz2/SSODp5/dhOnfUltz4aYPINGwxVnS5Ei2wHZC67NPgpBCizxi
         6SiQItOqLzt1U4iO0Jb4BVnQNJx2Z75AmHJyI/I+2zw8B4JZMn1DCnzHQ0fxh2Jt4tFp
         d+7A==
X-Gm-Message-State: APjAAAVDPi4gGYfTK95Wzt6xToMA2yyd9cV+PRSeKE7VQmM2uZOk6seJ
        n4RkoQoEEs9c7Ppd0kZSKzAFbfvYF/hH0w==
X-Google-Smtp-Source: APXvYqyPbSJgKMYYRYHBT9k14Z1sOoEKRwdNadOHhKZ4V/cQloJgSeMk5+RnXBKVkBJHfj+Yx0u79A==
X-Received: by 2002:a05:6214:13a3:: with SMTP id h3mr14329805qvz.212.1576254369514;
        Fri, 13 Dec 2019 08:26:09 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::4e65])
        by smtp.gmail.com with ESMTPSA id a66sm2991493qkb.27.2019.12.13.08.26.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2019 08:26:08 -0800 (PST)
Subject: Re: [PATCH v6 07/28] btrfs: disable fallocate in HMZONED mode
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
References: <20191213040915.3502922-1-naohiro.aota@wdc.com>
 <20191213040915.3502922-8-naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <c0533003-8aae-1dde-6997-794263341fb8@toxicpanda.com>
Date:   Fri, 13 Dec 2019 11:26:07 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191213040915.3502922-8-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/12/19 11:08 PM, Naohiro Aota wrote:
> fallocate() is implemented by reserving actual extent instead of
> reservations. This can result in exposing the sequential write constraint
> of host-managed zoned block devices to the application, which would break
> the POSIX semantic for the fallocated file.  To avoid this, report
> fallocate() as not supported when in HMZONED mode for now.
> 
> In the future, we may be able to implement "in-memory" fallocate() in
> HMZONED mode by utilizing space_info->bytes_may_use or so.
> 
> Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
