Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62053123594
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 20:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbfLQTZl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 14:25:41 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41497 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbfLQTZk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 14:25:40 -0500
Received: by mail-qk1-f195.google.com with SMTP id x129so1769125qke.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Dec 2019 11:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+BHWFaTbiDPTOInGD7to0WQBWGeToevaH3Tu19eOi50=;
        b=dBnq6619BvR+WVQcs4ZCA92BvYK2E934EUFve7iL34F0ntl+1VLWZfw+8gWgx1glkf
         ojHeklP9+271Tp0XmpVEoBI6bh/3RbnzyMqePTP+hpcB9VONhT+TbIwfyfdjy1N6y+Dr
         2GIccsYjB0W6C6zZCZYj3jWPjKc8uKPxalwVUqALp15FuJY0yWDl35c608tFU2m0CWEa
         ovP6Gv8EBh29vHwXascYAj3maezrPOj1UCNboElV+CovO7fY0Xzncal0XDnuMZLxY65x
         Cjxx8ufbkEJjD2+tN7edLWZZ1LDFYCOWKu3JIHDVFcCT5TDBRQxtQGCleWZ+ONXCJXHe
         NzEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+BHWFaTbiDPTOInGD7to0WQBWGeToevaH3Tu19eOi50=;
        b=DAdJ3pmZAhI+pW1y2bOFo6KLDAzUt0zh3oErHzoBH4E2KtZnqwgiAXVeubVofmZQh+
         ouWL8+2PJjdeU2HWR1C4gLQ1GweQNFaE6XSEsFKwZDiRI0PU0jJmebWNi4zVcE+sFopP
         GpNsOuVxrSHgvd6vVtFjkoLbmd93b13Z2R+mpsX5F6inrKXhfOyHsP07spc9u/wenhwt
         2cDVFf8MhGClvurOWhwlCi4wPqAr6AS0S6wfDrMj6vrJh+Pv/CKLtINnJRscTMaOZm3d
         iq4sSP1ydT5OidEyVA55lYWObkCX34Hhu/RfpqFsosFaqPfSs2J/T7ae9qg5tWnjkuoc
         jqnw==
X-Gm-Message-State: APjAAAXS8uRuPtj8HNa0f4XTXW6ed4SC7XSqfeAmzrnYp4FikZo41O7f
        jxitbYvcpCMUKiqo4+T+8HeYbXM8dJz/+Q==
X-Google-Smtp-Source: APXvYqyMNLMGHmqB0KhVw5M2NU9LpkPJW/nKThlscidDsyKnfYWtrQNl5sqOBMAcTg+Kirpug0M0Gg==
X-Received: by 2002:a05:620a:1403:: with SMTP id d3mr6659065qkj.243.1576610739482;
        Tue, 17 Dec 2019 11:25:39 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::4217])
        by smtp.gmail.com with ESMTPSA id o7sm7340049qkd.119.2019.12.17.11.25.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 11:25:38 -0800 (PST)
Subject: Re: [PATCH v6 11/28] btrfs: make unmirroed BGs readonly only if we
 have at least one writable BG
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
References: <20191213040915.3502922-1-naohiro.aota@wdc.com>
 <20191213040915.3502922-12-naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <78769962-9094-3afc-f791-1b35030c67dc@toxicpanda.com>
Date:   Tue, 17 Dec 2019 14:25:37 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191213040915.3502922-12-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/12/19 11:08 PM, Naohiro Aota wrote:
> If the btrfs volume has mirrored block groups, it unconditionally makes
> un-mirrored block groups read only. When we have mirrored block groups, but
> don't have writable block groups, this will drop all writable block groups.
> So, check if we have at least one writable mirrored block group before
> setting un-mirrored block groups read only.
> 
> This change is necessary to handle e.g. xfstests btrfs/124 case.
> 
> When we mount degraded RAID1 FS and write to it, and then re-mount with
> full device, the write pointers of corresponding zones of written block
> group differ. We mark such block group as "wp_broken" and make it read
> only. In this situation, we only have read only RAID1 block groups because
> of "wp_broken" and un-mirrored block groups are also marked read only,
> because we have RAID1 block groups. As a result, all the block groups are
> now read only, so that we cannot even start the rebalance to fix the
> situation.

I'm not sure I understand.  In degraded mode we're writing to just one mirror of 
a RAID1 block group, correct?  And this messes up the WP for the broken side, so 
it gets marked with wp_broken and thus RO.  How does this patch help?  The block 
groups are still marked RAID1 right?  Or are new block groups allocated with 
SINGLE or RAID0?  I'm confused.  Thanks,

Josef
