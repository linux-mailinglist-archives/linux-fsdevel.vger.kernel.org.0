Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D440515497D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 17:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbgBFQoc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 11:44:32 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44810 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727593AbgBFQob (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 11:44:31 -0500
Received: by mail-qt1-f193.google.com with SMTP id w8so4969561qts.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Feb 2020 08:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2Rn/mUtoOayvFcRXPONgkjKqwFd/uYFM1HWZWYqyBTk=;
        b=JE+M5PugGrqTkTpYlk7x5WWnal6KPMuzC4FN1qoOduabyN5nDxMN0diR/N0agbVd1o
         Hs8fT2N/IkUHYL8PCduCO9hgUa65KfvyFnJ7fIybPOQNqBsFrWfYBBMcRO77/eESmq3o
         E/Z9JkZ0kpSBMtp1pFNEUedXkiwrX1J1Ij7mTNsD5Zw57+pm/V1/Hv+BG1hvU5/tfwiq
         UjOxLT0ElJmq0exkNjP7a8K1A4ngzoepTITpZAZkx6bJzCD0MkJepKDu6Fe/Gczqt8VA
         gY4SMYQfDouXPdTZzxCstFoDbynhk/DTdOYMpS289isao0RNgGjk+KZGco0bhHT2COxF
         6zJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2Rn/mUtoOayvFcRXPONgkjKqwFd/uYFM1HWZWYqyBTk=;
        b=MauxKtTHFCR78kSbwN0Qzz+MHGgTU9iQzHH40cGdj+bJjso2oBrMEX6dFkgtczcyE7
         NoDkyWffEc8QCmOFghlfMEi+jF/K6V5yO5X0QGMo1rMVHiOhQxi7NBTwhvuvzYCBk/H1
         BdQ29dsI+h1YTEATgE90L9pq6KJJG3AS0J8TZoNJ+LABO/TQO3Mgkcx0+lbbxc7JXsbb
         DxpSBtpdoiUeRASUUj1v16oUahm50/o8K+1vVtHeEvt4aYo0QRAZAURJW8HAE6Lo6gWo
         HNnolX3N1lacIqjAetdfUgf28eElC3r4tVmKGRA4Pa6WLxQa1tS6DBsOuPRDiCHU7+Qy
         Juow==
X-Gm-Message-State: APjAAAVpmUwOzRi/nWgnGrEBKfprBKSl1oFQQEn3/AnSGpFyx7pm3h+o
        Ighs3O6NMFEdCApH7RxSCOSOyIQWHwc=
X-Google-Smtp-Source: APXvYqwCCefmaEdGqfTpmRyrF5GSnNq3KYM10FESEr3kx4D/L0PbQpmCg43f3aAXzUnkGfbPjFekBg==
X-Received: by 2002:ac8:7765:: with SMTP id h5mr3480327qtu.223.1581007469146;
        Thu, 06 Feb 2020 08:44:29 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id e130sm1657834qkb.72.2020.02.06.08.44.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2020 08:44:28 -0800 (PST)
Subject: Re: [PATCH 06/20] btrfs: factor out gather_device_info()
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
References: <20200206104214.400857-1-naohiro.aota@wdc.com>
 <20200206104214.400857-7-naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <b2102ead-aa15-56a3-e284-4b8c47b06b61@toxicpanda.com>
Date:   Thu, 6 Feb 2020 11:44:27 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200206104214.400857-7-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/6/20 5:42 AM, Naohiro Aota wrote:
> Factor out gather_device_info() from __btrfs_alloc_chunk(). This function
> iterates over devices list and gather information about devices. This
> commit also introduces "max_avail" and "dev_extent_min" to fold the same
> calculation to one variable.
> 
> This commit has no functional changes.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
