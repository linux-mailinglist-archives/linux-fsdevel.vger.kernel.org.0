Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5D3811E819
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2019 17:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbfLMQVy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Dec 2019 11:21:54 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:45975 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728075AbfLMQVx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Dec 2019 11:21:53 -0500
Received: by mail-qv1-f66.google.com with SMTP id c2so1029080qvp.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2019 08:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nIZRJE4uUi0ljEVbmM7fOvmC1VdPXwNbDiuvEiYRTYU=;
        b=W2+1S7YidDWZ7eShTuUss+jB2fR/Q3WNKkkQ8ukrZe+a9sKpTFtHslNYGwxTTnEzBs
         iStnP593HpJZLfxhxBAcRDSPUAz3+q4YWnrVtVEGvJTte6p0yMtynC/6ZE7GNq1HDP/u
         +XEjZKKvrcu/ZMi+BqJ/fJHAZNY3pd2x8qU5MTV4jwTvhP+2INt9xJESSh65lMI67lSB
         ZXcvA8Y02mGWGZVzHJaPi6rdygbxK7LLoJGwgi6zrS1viA/vrqQTynm/6WPsswQd1gQQ
         thUMpXNuCEL5SJPzMoDikxElmUNEgxeqCVmcOmJSLJfCj+SAa7TnhFzE6yiUaCICo8cv
         hwEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nIZRJE4uUi0ljEVbmM7fOvmC1VdPXwNbDiuvEiYRTYU=;
        b=G7iUOugl0fw1vQeSllmBCdNa2a/0XeBgPIVK0/hiuATwImEhvYokzZFd0ANCbxoMmt
         X7oTEwwTLGCGAzvI+L/7CgYxXXuyt6Fd8SL1K3BmHsQ0MT7EOyfhth77JWweAsP1Qt2l
         i9/dKKz6399O8RyPPCluR90FZFGnPrWnNcV2ybGOirsBjxLytQVzNwEn0sqj97lJzwvS
         gkRdTmbaXtCxVzxoX6E05UZmELQRkEpw5xoaOVks9RWAZVmn4zckCN7ijIDQHAsFqnNH
         07wbWI2tfmGkfOpGZTbchVh0edKq5aSPGroNM1MjA5n8nDwi6re51V7hVN7utJK59CPI
         1nlQ==
X-Gm-Message-State: APjAAAVU8IqYhXTJuCodRvpuh+owUsD2TBW43rrzR8cSdGH51wUW9zdV
        iEP3dKzUQ2Y9opcM8DR1Twittb0T3XhRrQ==
X-Google-Smtp-Source: APXvYqz9NbjXBFOT064bsAOiDZ+RQrjLPSdAchdLZ18nhfRmb6IvXrlMbJq9WES6Fo269U6JcDKYQw==
X-Received: by 2002:a0c:ada3:: with SMTP id w32mr13718072qvc.99.1576254112145;
        Fri, 13 Dec 2019 08:21:52 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::4e65])
        by smtp.gmail.com with ESMTPSA id i2sm3555499qte.87.2019.12.13.08.21.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2019 08:21:51 -0800 (PST)
Subject: Re: [PATCH v6 04/28] btrfs: disallow RAID5/6 in HMZONED mode
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
References: <20191213040915.3502922-1-naohiro.aota@wdc.com>
 <20191213040915.3502922-5-naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <460f3205-419e-63cf-376b-ddc2e2e88689@toxicpanda.com>
Date:   Fri, 13 Dec 2019 11:21:50 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191213040915.3502922-5-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/12/19 11:08 PM, Naohiro Aota wrote:
> Supporting the RAID5/6 profile in HMZONED mode is not trivial. For example,
> non-full stripe writes will cause overwriting parity blocks. When we do a
> non-full stripe write, it writes to the parity block with the data at that
> moment. Then, another write to the stripes will try to overwrite the parity
> block with new parity value. However, sequential zones do not allow such
> parity overwriting.
> 
> Furthermore, using RAID5/6 on SMR drives, which usually have a huge
> capacity, incur large overhead of rebuild. Such overhead can lead to higher
> to higher volume failure rate (e.g. additional drive failure during
> rebuild) because of the increased rebuild time.
> 
> Thus, let's disable RAID5/6 profile in HMZONED mode for now.
> 
> Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
