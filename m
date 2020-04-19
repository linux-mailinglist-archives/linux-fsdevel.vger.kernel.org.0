Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5F7C1AFEBB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Apr 2020 00:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbgDSWuT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Apr 2020 18:50:19 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36571 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbgDSWuS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Apr 2020 18:50:18 -0400
Received: by mail-pg1-f193.google.com with SMTP id o185so3572402pgo.3;
        Sun, 19 Apr 2020 15:50:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OxxnYeHTWroY6hmuHlAIlsKHz3BuO/6//L5YqJ82mMY=;
        b=iSTYK2egGsM2t0dHPtMw4AYOITY2ZmqiLC/NSdUTchQu3I4cUcAYW8QPnnKTJBntRG
         Iqy+JTubE2uJO7Wxzt3pzbnFsNA/vE63Ui8EpsN4ZVt5xBKSQRafkp3LVaMqWiDJgubw
         iemsKexwv7ufBpwh/qC8aHFHfoTqX6hSeuyw4ekuH81B678WhZyccfbGZYbjC942gi4M
         qVqVdaNVQYDS2M/gEvGk8bSicMCKlG4CJaYdX9JaCpYfuj74JLsxEtxHApBU4TohdzrD
         YsQfd7BPwhKu2gz2AHVoE9GyGV4LnnDhCBqQ313FFMcNv+NeNfiPohH1hgh0vj3IFzAk
         d0hg==
X-Gm-Message-State: AGi0PuZ/YIqH++F63SJMUuzFqXFLz6lexIa9jqlpKLaZ6VSGRcT5V1dN
        0Tajkjym/9EgB11sBpsHHPLoVimB3tM=
X-Google-Smtp-Source: APiQypKW5JUfcsFpRqbbC+YhkiXeOliCnTOExnj3O8GqgN3Ldx2ACG/U/AE1gygv1oLNFBasLCJLIQ==
X-Received: by 2002:a62:8106:: with SMTP id t6mr14151348pfd.81.1587336617865;
        Sun, 19 Apr 2020 15:50:17 -0700 (PDT)
Received: from [100.124.11.78] ([104.129.199.4])
        by smtp.gmail.com with ESMTPSA id fy21sm11943472pjb.25.2020.04.19.15.50.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Apr 2020 15:50:16 -0700 (PDT)
Subject: Re: [PATCH v2 05/10] blktrace: upgrade warns to BUG_ON() on
 unexpected circmunstances
To:     Luis Chamberlain <mcgrof@kernel.org>, axboe@kernel.dk,
        viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        rostedt@goodmis.org, mingo@redhat.com, jack@suse.cz,
        ming.lei@redhat.com, nstange@suse.de, akpm@linux-foundation.org
Cc:     mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20200419194529.4872-1-mcgrof@kernel.org>
 <20200419194529.4872-6-mcgrof@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <54b63fd9-0c73-5fdc-b43d-6ab4aec3a00d@acm.org>
Date:   Sun, 19 Apr 2020 15:50:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200419194529.4872-6-mcgrof@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/19/20 12:45 PM, Luis Chamberlain wrote:
> @@ -498,10 +498,7 @@ static struct dentry *blk_trace_debugfs_dir(struct blk_user_trace_setup *buts,
>   	struct dentry *dir = NULL;
>   
>   	/* This can only happen if we have a bug on our lower layers */
> -	if (!q->kobj.parent) {
> -		pr_warn("%s: request_queue parent is gone\n", buts->name);
> -		return NULL;
> -	}
> +	BUG_ON(!q->kobj.parent);

Does the following quote from Linus also apply to this patch: "there is 
NO F*CKING EXCUSE to knowingly kill the kernel." See also 
https://lkml.org/lkml/2016/10/4/1.

Thanks,

Bart.
