Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28F921AFEC5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Apr 2020 00:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbgDSWzT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Apr 2020 18:55:19 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37963 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbgDSWzT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Apr 2020 18:55:19 -0400
Received: by mail-pf1-f194.google.com with SMTP id y25so4026073pfn.5;
        Sun, 19 Apr 2020 15:55:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B2msURkv1HA8pgGW6DbM9XBVc7YNXdLDiKpjaDG1YVk=;
        b=OsEfXpZNvFLL8/zGn0AqR2NuR7A9QWyc3AhFj36GPwb2DcFTE8ecTGIx19RPDC7KXM
         BZuKwF1IMNiniKT2ybYcXOVyTCqm12l5RaUPqEt8iZbPdBU6x+oFCjy2rVDv9QXuu5yT
         R54h+5HrgA2WaadSW5COdjDGt6deENesvMZBBaqfQWOtFlKxKcCRWGLb5UK6KW9fBN2h
         MtWPSavPJHzSYaZxSkvt9ErhJpG2xfRAIwm+zg7QhKpIiAqmlAyl2wuyWCSiRKlkWb4k
         5b6SfYe9LFj8dEQgGKbItfkusuFP0KgS3ckBg1barIIL1j8S5JqyVWrwv9lOb6FEpQCK
         sW7A==
X-Gm-Message-State: AGi0PuaI3tp22aJdT/lmMS7/UhvGEmr8UqUtWB+IogE5zhr86AmOrNe5
        OsuNhHODlwZL55/vLsCDt1ddSPclWVg=
X-Google-Smtp-Source: APiQypJqULytJjZ0dNx4CNr/3fDiqkbJiEvNC2PKjACY87YZXhStXzwaxas2+Bodjrg58qN8tfS4HA==
X-Received: by 2002:a63:1d4:: with SMTP id 203mr13204249pgb.74.1587336918151;
        Sun, 19 Apr 2020 15:55:18 -0700 (PDT)
Received: from [100.124.11.78] ([104.129.198.64])
        by smtp.gmail.com with ESMTPSA id o1sm2276514pjs.39.2020.04.19.15.55.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Apr 2020 15:55:17 -0700 (PDT)
Subject: Re: [PATCH v2 07/10] blktrace: move debugfs file creation to its own
 function
To:     Luis Chamberlain <mcgrof@kernel.org>, axboe@kernel.dk,
        viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        rostedt@goodmis.org, mingo@redhat.com, jack@suse.cz,
        ming.lei@redhat.com, nstange@suse.de, akpm@linux-foundation.org
Cc:     mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20200419194529.4872-1-mcgrof@kernel.org>
 <20200419194529.4872-8-mcgrof@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <c0457200-4273-877f-a28d-8c744c7ae7c1@acm.org>
Date:   Sun, 19 Apr 2020 15:55:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200419194529.4872-8-mcgrof@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/19/20 12:45 PM, Luis Chamberlain wrote:
> +static int blk_trace_create_debugfs_files(struct blk_user_trace_setup *buts,
> +					  struct dentry *dir,
> +					  struct blk_trace *bt)
> +{
> +	int ret = -EIO;
> +
> +	bt->dropped_file = debugfs_create_file("dropped", 0444, dir, bt,
> +					       &blk_dropped_fops);
> +
> +	bt->msg_file = debugfs_create_file("msg", 0222, dir, bt, &blk_msg_fops);
> +
> +	bt->rchan = relay_open("trace", dir, buts->buf_size,
> +				buts->buf_nr, &blk_relay_callbacks, bt);
> +	if (!bt->rchan)
> +		return ret;
> +
> +	return 0;
> +}

How about adding IS_ERR() checks for the debugfs_create_file() return 
values?

Thanks,

Bart.
