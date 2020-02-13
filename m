Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76F2B15CB73
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2020 20:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbgBMT4A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Feb 2020 14:56:00 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33663 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728295AbgBMT4A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Feb 2020 14:56:00 -0500
Received: by mail-pl1-f196.google.com with SMTP id ay11so2771115plb.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Feb 2020 11:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VgxHsPmHPGg4sC0uTzgaMUIq9km6z2KjLAlVXB4OSAc=;
        b=wDDgt0VAc0fFjaaOju5sZ52ZgOgQpWo0FNRTZ/mPNtCQAcT4Y3nywim0UrYjnWK4Mf
         MZ4wknYdF1OnN/1wT7xAzNXQ5f4qMgVGjRewNDu433+PdE2jOAhE8ysUEd8YyHerEdH3
         WXef/q2fI57BOttNfzt4rBJ3k/yZW9g9X4aFt26NVev9PlBEagAOb+H1bWN52a9H9Yjk
         htdmBUHhYGPlSObce2zidZH//7lkFypl51WHsNPK5SSZhfgaIQCsNHlIM8zt4/07Uz7l
         nKmKIWkTuIjNKTYUIQHVYmyoatR7C1pcYd8WB2ici2fdMeo3B0IqCKGMJa4XyB8FG+qt
         Rf/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VgxHsPmHPGg4sC0uTzgaMUIq9km6z2KjLAlVXB4OSAc=;
        b=iKzErYqGlLUM6/SA65pYjv3im8fficMd0oKHx8U/14RSigVqYKsXwem+9oPHJnI45W
         RZngIi/HQe2143mKCpaogVidMM1XFuarLYNAmQn7NWVL4kVDwSbo4mBwyFmtqIAeXC0z
         NdHQPG6PfhNoekxFjGBMohZWgyAtjTiG8uEo4eF60PmSaTx5r1Eetx4/vAMVFFt+iacs
         +OizAaxa8538CmxSYQFcehrnx2AF4tU71npH001W5phJXh1WOGbYoXZSD9PBQ5W3dmCG
         3+v8EL8hDQqXejgS1jfXOWpefq1jdif3bFFP3DAInblv6teVZoUm4y877UH0d9raTL0l
         s9Sg==
X-Gm-Message-State: APjAAAUBNYH38ysFyfvLANWfVx1yIMkuNL4HHAu8C/slcSEmeZdBw+VS
        aqa6EXj50pA3V++vRmsvetL3b4a+70I=
X-Google-Smtp-Source: APXvYqwAx9zP7es/QcYfeT81LkVC2VtNWyy6+ejLQzIib6b4auHD5A1Mde5zf5Gx/VzLYuZeBnzyMQ==
X-Received: by 2002:a17:90a:858c:: with SMTP id m12mr6641561pjn.127.1581623757740;
        Thu, 13 Feb 2020 11:55:57 -0800 (PST)
Received: from ?IPv6:2620:10d:c085:21cf::1150? ([2620:10d:c090:400::5:249c])
        by smtp.gmail.com with ESMTPSA id c15sm3924605pfo.137.2020.02.13.11.55.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2020 11:55:57 -0800 (PST)
Subject: Re: [PATCH v2 11/21] btrfs: introduce extent allocation policy
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
References: <20200212072048.629856-1-naohiro.aota@wdc.com>
 <20200212072048.629856-12-naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <8539869f-cac1-9872-bbcb-141852044d3c@toxicpanda.com>
Date:   Thu, 13 Feb 2020 14:55:53 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200212072048.629856-12-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/12/20 2:20 AM, Naohiro Aota wrote:
> This commit introduces extent allocation policy for btrfs. This policy
> controls how btrfs allocate an extents from block groups.
> 
> There is no functional change introduced with this commit.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
