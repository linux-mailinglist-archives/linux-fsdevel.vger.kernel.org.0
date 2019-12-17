Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51E5C1235DE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 20:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbfLQTlH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 14:41:07 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42941 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727621AbfLQTlG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 14:41:06 -0500
Received: by mail-qk1-f196.google.com with SMTP id z14so9268817qkg.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Dec 2019 11:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OXcOcA9d+MHJWB5VMSs6SxDFCnOQjcTdSoeRtxoyNNw=;
        b=C8DmYru3/62U1CvUclv4lmLvDRbbcZUvS7tWSkcnAXnEiMu7JmCfTZjW9hJZgmNlQt
         nh1akoYc4QIblNvVNECkWVwvm0fFgJMH2f22v3qdzdilrb7Jnhwq8WWVCfmLSQ/nRqWm
         AZTXPBywnUu124Z7UcBYawMwh8P7uDdsR+aF15ELyJnE/lgcX/Iw9Yq9ai4qCyGpvQel
         nAh4+npgJ4yMH242dgMhsxvlIO7Kh9sgYtSZ9umgHmurT3BO4C08Y1ECbS6xFuPetNlY
         ZzJTjyS3o/d/Ny1VZSVSPvhNdGZRsGYxaT6a3Nxzyf4URTS17loaFezYwgG6wT7f4Iv9
         e1lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OXcOcA9d+MHJWB5VMSs6SxDFCnOQjcTdSoeRtxoyNNw=;
        b=n6A8w3ilY51wC3ccA0BolSj6Ckutz+HXUay3MgilwD7dryEAqg9uqRSxwmVguHWKJV
         M4c/MIpMJRDht63xwP+XBL3nl9K3Ek6lr6mB4UDeWkF62yPsjbWBaD3gQadmwi3T5oHr
         szn8aeUMu0ZLJ+GzC5z1egwICzWcLMU3ynJf79d6iHXx69QuQz5qu4BnxTzjCPVew+mb
         GS6MN75uMb3LtNmC3jOJqF335fPp22qwjLRCL9pzutKwO27M5dpJqHD15yTons0IiZoq
         UPLP2FcVZkt8vLknaKDyXJofPutgvtRBDIV63I1FgbEAbaCCU7E+qkJlhePc0rOx+CcE
         1kOA==
X-Gm-Message-State: APjAAAX6gQk7DI5wH+je3qPVidXhcVs8iphO5e3G8/NcehjXqrIRgfGk
        g5ePTQF6EcyMOnLgebpNWyhy8HWpV/nhZA==
X-Google-Smtp-Source: APXvYqz2lTzYdUxfG8Eh0IcBHWntYr8J1vmidj2ohxpEsm4OsH1KyLnfzf03uAMW+DNMEvB5uSB0SA==
X-Received: by 2002:a05:620a:634:: with SMTP id 20mr6838264qkv.269.1576611665267;
        Tue, 17 Dec 2019 11:41:05 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::4217])
        by smtp.gmail.com with ESMTPSA id a19sm7362317qka.75.2019.12.17.11.41.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 11:41:04 -0800 (PST)
Subject: Re: [PATCH v6 14/28] btrfs: redirty released extent buffers in
 HMZONED mode
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
References: <20191213040915.3502922-1-naohiro.aota@wdc.com>
 <20191213040915.3502922-15-naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <ef8e982c-7946-1025-d919-fd7ee3dfd8d6@toxicpanda.com>
Date:   Tue, 17 Dec 2019 14:41:03 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191213040915.3502922-15-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/12/19 11:09 PM, Naohiro Aota wrote:
> Tree manipulating operations like merging nodes often release
> once-allocated tree nodes. Btrfs cleans such nodes so that pages in the
> node are not uselessly written out. On HMZONED drives, however, such
> optimization blocks the following IOs as the cancellation of the write out
> of the freed blocks breaks the sequential write sequence expected by the
> device.
> 
> This patch introduces a list of clean and unwritten extent buffers that
> have been released in a transaction. Btrfs redirty the buffer so that
> btree_write_cache_pages() can send proper bios to the devices.
> 
> Besides it clears the entire content of the extent buffer not to confuse
> raw block scanners e.g. btrfsck. By clearing the content,
> csum_dirty_buffer() complains about bytenr mismatch, so avoid the checking
> and checksum using newly introduced buffer flag EXTENT_BUFFER_NO_CHECK.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
