Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8A811D269
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 17:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729946AbfLLQf1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 11:35:27 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:37565 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729927AbfLLQf1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 11:35:27 -0500
Received: by mail-il1-f195.google.com with SMTP id t9so2568182iln.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2019 08:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3FtLIVj+wnM2ARUnkHjLCIs+M1M/IA6PpWp8jtXGxBs=;
        b=xbcplkXMsLKBVhI2XoEAIhOCDrqD47HX6n1yvO5V22GmwrrQQBKbWggYHs4jvP1r5e
         d06kkPEOnjJE94l1i8s0OQBGyq2uCnz06HSXakJyefIeamZrYC04IsPHZG0q8AamKYX7
         hQiBFF2unkfh+vzBU4sfnsk8eFSJqiqGb27+ELN3raRO+1VzqxuUmJvQteWCoq4j74gw
         zDZjlxcYlLJc7nj02zY/1J5oio91PD6bX3m6ftojddzXMI4lyWGMcOBLF2IgQDl1+DS4
         M8/9vHNTZSCqOo/1DexoCnH9ZtJ4bViECOh2oT+MHZ1qxnhhm7JEOSFNx7VJQCROP4qJ
         4jQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3FtLIVj+wnM2ARUnkHjLCIs+M1M/IA6PpWp8jtXGxBs=;
        b=NCSFSHRwqxTBkszcLLHTDeg9Dpg5wd9IS7k4MV2AZClzVFTwRxA6dNhzPCGVqG7uPQ
         r8O1ByGa/mIjBkGjXDaaKLrHRTfpZW14hg4J+ihEkwl+OQArDv5VS9TBExXUAyR/hcPf
         LKRQq5tHTwhQO1JRwSbOEUUE6NbmPc4aWCskEc4vOfq+GqPDo1+dQ+C+hZL7LnUYWyqK
         2v/h3RNCOfwi0QoWn5wmCw8bfD9GIECOex8MJ6Bc07wVayGxWpoGvmZNyYxqgX0K8eXc
         5mz+f567GnoYVDrNxGVNwkWfIzD324aLhZ8GQx3JQSFUeHOLplDNmftJlHfLjsSVGS4Y
         VrvQ==
X-Gm-Message-State: APjAAAUf8lp1vK3rsu7o9YwFv86stICfEEM4InoyncQGkMq1lsdrs23d
        5yzFycs2aRmqI7OXVAIHwB8FQuhu6cIK/A==
X-Google-Smtp-Source: APXvYqxAPt9ybQh/T8WYBX6qxbHJzz4zpYaVA1B8qE0Zhi2chspe24qfeJl3SeUOs00SEoxpnZbeng==
X-Received: by 2002:a92:5d03:: with SMTP id r3mr8554165ilb.278.1576168525332;
        Thu, 12 Dec 2019 08:35:25 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id x62sm1843784ill.86.2019.12.12.08.35.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2019 08:35:24 -0800 (PST)
Subject: Re: [PATCH 15/24] compat_ioctl: scsi: move ioctl handling into
 drivers
To:     Christoph Hellwig <hch@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jason Wang <jasowang@redhat.com>,
        Doug Gilbert <dgilbert@interlog.com>,
        =?UTF-8?Q?Kai_M=c3=a4kisara?= <Kai.Makisara@kolumbus.fi>,
        linux-kernel@vger.kernel.org, y2038@lists.linaro.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        John Garry <john.garry@huawei.com>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20191211204306.1207817-1-arnd@arndb.de>
 <20191211204306.1207817-16-arnd@arndb.de>
 <20191211180155-mutt-send-email-mst@kernel.org>
 <858768fb-5f79-8259-eb6a-a26f18fb0e04@redhat.com>
 <20191212162729.GB27991@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6e265890-23e5-6368-4e36-d59ff47879b2@kernel.dk>
Date:   Thu, 12 Dec 2019 09:35:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191212162729.GB27991@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/12/19 9:27 AM, Christoph Hellwig wrote:
> On Thu, Dec 12, 2019 at 01:28:08AM +0100, Paolo Bonzini wrote:
>> I think it's because the only ioctl for virtio-blk is SG_IO.  It makes
>> sense to lump it in with scsi, but I wouldn't mind getting rid of
>> CONFIG_VIRTIO_BLK_SCSI altogether.
> 
> CONFIG_VIRTIO_BLK_SCSI has been broken for about two years, as it
> never set the QUEUE_FLAG_SCSI_PASSTHROUGH flag after that was
> introduced.  I actually have a patch that I plan to send to remove
> this support as it was a really idea to start with (speaking as
> the person who had that idea back in the day).

We had this very discussion two years ago, and we never got it removed.
Let's please get it done.

-- 
Jens Axboe

