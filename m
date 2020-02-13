Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0976815CB88
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2020 20:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbgBMT60 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Feb 2020 14:58:26 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:52451 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728237AbgBMT6Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Feb 2020 14:58:25 -0500
Received: by mail-pj1-f68.google.com with SMTP id ep11so2845693pjb.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Feb 2020 11:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/xT/XuQsLzUEx3lw8PVvV4XkvqWlaBmWIKUnuJvZZ8Q=;
        b=mbVhw3rGFArj1q9GBRNozeLTcOwrCmcpkF9FLOaDKs2YpaiCqvSobDCEDEHBXTqZUi
         Nl9h//pBRrY4pr4TVPO9K3xk1M96aLR9h7zewerryVI45Qpwwtu1+CoSDNfZCTqr1QwB
         MZFnZp3WoHnOnvX0JP+eTtLZpNIuyig4JH5TOVboYoaPV9HIX6codmMzxTOXyHpVAeTO
         +C2Vos9nnRZma0X9eOdyN0oC5IQWWuSWBZ0H/ZZuAS/DzUO3ODj+wRUF33LbKCDGLf5H
         JIPAwcCnr3mPbyIPjntXqFGnOitQcoNLucuQkUvzUjV69kf8tGsnVa/JljjetbfLKY5s
         b5Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/xT/XuQsLzUEx3lw8PVvV4XkvqWlaBmWIKUnuJvZZ8Q=;
        b=nHmy+0RBMXjXwJ0pwXgc7Dn61mzGhVYgtxB+3LvyLIEkPfPHwmDDD96x3aiN8RKLUu
         0b0W7C/4ImbXt+vJ8KoQYo+EctWxvKo3NqhwSPL/BrcsigpfLnaOnmwHBGVl0ApUXwyw
         dyBO7CPQrrYcY6aUmjqdTTfsm+/Zi/IojJ7HXpKnTY/gd7MAhTuANi/xiPZsj/M+EsyD
         +hJm1oBQNZdW9OJoLbTx8beTg+Zqljw7Wlwrv/bErjxzptfZPbNHXSdG0OUYXCjFtwmv
         yf0X6ntC/+qpa52nRs/ZiQ+K/BHtZNje0dgKeaS2u4HdnPJO1w0FDP8B/wlDa39WSb+2
         TdeQ==
X-Gm-Message-State: APjAAAXT+HsNUiC5YzVoYvZukzQ6ruL1aE/dRPLhE6byzL+el2h63ZTI
        abvHPcTjloS34NUhzTqVEYWWknXNmpk=
X-Google-Smtp-Source: APXvYqzXDLR0fJZMH6LY0odLXBkPq/9aX53jQBBoG60fQOymWwYpNVIyAFxKpRz3cgaQTjdeONTkbQ==
X-Received: by 2002:a17:902:24:: with SMTP id 33mr15084616pla.91.1581623904906;
        Thu, 13 Feb 2020 11:58:24 -0800 (PST)
Received: from ?IPv6:2620:10d:c085:21cf::1150? ([2620:10d:c090:400::5:249c])
        by smtp.gmail.com with ESMTPSA id b3sm4024761pft.73.2020.02.13.11.58.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2020 11:58:24 -0800 (PST)
Subject: Re: [PATCH v2 16/21] btrfs: factor out release_block_group()
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
References: <20200212072048.629856-1-naohiro.aota@wdc.com>
 <20200212072048.629856-17-naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <15d7df0e-4fb9-bd44-f51b-8be3bdddb1eb@toxicpanda.com>
Date:   Thu, 13 Feb 2020 14:58:21 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200212072048.629856-17-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/12/20 2:20 AM, Naohiro Aota wrote:
> Factor out release_block_group() from find_free_extent(). This function is
> called when it gives up an allocation from a block group. Each allocation
> policy should reset their information for an allocation in the next block
> group.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
