Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1D315CB8F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2020 20:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbgBMT7o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Feb 2020 14:59:44 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34614 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728336AbgBMT7o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Feb 2020 14:59:44 -0500
Received: by mail-pl1-f193.google.com with SMTP id j7so2772823plt.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Feb 2020 11:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pPkfkOFFdh0jcREMI7g1Z7cpM5SfsiemF4uKFR/CWyg=;
        b=teboRsB6pBVnkZNEGTn83RkunST5DXNaNupY69XMhSNzhLfh4i7oPk0rh1PDp3vcNl
         eJicgkTD+SPp7s9vbAalEskjQqCsF+qXUJWkxzDNcAkOuHNl+wwRqPDp5Wbl/XS4u9XO
         U4yh+4wycItGpEYnhiX3JczRcBh6gaWwoI6jkjOhdOiYoxYdrQ/0qGmiZNhUdIlfCyYC
         ZAFhrqpD8ndkVqjkdyn1/zVXFqrAgvnMyhT+qyRf5VQSTrhZZan/Y08kNCrS55fD5ms5
         UHdgwKWtQZYyKj3YDMxCCGS8XOoG7P7OUXMTpCnE5P3aqxiQO1alJW+ITbhIpTvjShUq
         FMbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pPkfkOFFdh0jcREMI7g1Z7cpM5SfsiemF4uKFR/CWyg=;
        b=V63uI8bWkyd6y5T04EyWaeUtWKeqaTrnpQ2YObav7NsAmCaLfY9nG5pkH+e9GAkXbU
         B1wRzHnoPnj7ZYgBlAInQlhTSsAqAPnfw7F75hQ+i4atTDJ4wWHKl0oROb3bLL3XtS4a
         JxutKcYd2+LWu5vfl85mSSV7/BS9Tq2B/VxuG0rvS2YWjwQfD6naJMjdctkKuHlK7yNw
         lE5s2NHdI+9PmuoSR5nQtQzJID2bmOz3Z92V02XtAfP2ZdQ9rV5nxqWQvIQk+VDH7oGf
         jUqOSezMhMb9E4HQAq+em+IZwRt9fFaYumaBZcE9KV1nADZyCAwvwv/dXF8k+8EKQtyE
         1OxA==
X-Gm-Message-State: APjAAAWqqLon3EHonBauICT9/R/fW0/u9lXwMz9OGol2f41ca9Av4M4J
        Ko1HgBS/dkarcMBKVEadDI+i10+5vvQ=
X-Google-Smtp-Source: APXvYqzaIPZ3utcS4esVe+3lQ3n6yMi468Aj3ONw6/eLMGow+lON+XRa6dYscAJFvV8G4giFu588Fg==
X-Received: by 2002:a17:902:b587:: with SMTP id a7mr15304876pls.82.1581623983052;
        Thu, 13 Feb 2020 11:59:43 -0800 (PST)
Received: from ?IPv6:2620:10d:c085:21cf::1150? ([2620:10d:c090:400::5:249c])
        by smtp.gmail.com with ESMTPSA id s18sm4248352pgn.34.2020.02.13.11.59.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2020 11:59:42 -0800 (PST)
Subject: Re: [PATCH v2 21/21] btrfs: factor out prepare_allocation()
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
References: <20200212072048.629856-1-naohiro.aota@wdc.com>
 <20200212072048.629856-22-naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <17882921-b142-70b5-248a-ef263e7a8159@toxicpanda.com>
Date:   Thu, 13 Feb 2020 14:59:39 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200212072048.629856-22-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/12/20 2:20 AM, Naohiro Aota wrote:
> This function finally factor out prepare_allocation() form
> find_free_extent(). This function is called before the allocation loop and
> a specific allocator function like prepare_allocation_clustered() should
> initialize their private information and can set proper hint_byte to
> indicate where to start the allocation with.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
