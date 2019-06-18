Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5C104A256
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2019 15:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729365AbfFRNfU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jun 2019 09:35:20 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36603 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727584AbfFRNfU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jun 2019 09:35:20 -0400
Received: by mail-qk1-f194.google.com with SMTP id g18so8555416qkl.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Jun 2019 06:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eK5CJpBaboC0hEciRwXZ1C92olmsKQDqEljQyovaSOk=;
        b=YiOIvK80pvLydz0Im11/2kCXM2Q0lUk5O+a5AZ31v1AzEl3ej4o/STSbJdcXX7ZraH
         +GGCVaNrn9LDGqvkcfri9GbBuDCEmFegVmn/iknd2QUnX+RSbIlFFUZUg2qtuetXPiPM
         fjbZZb+dHRGhp6NSOeuGscXvchIXuS/ArJydWEHllez8zvYJw29+mtkc5suxgAUZUxvH
         5Juf+4m7vbsy0ubcdX7FAogWdjuyya45XbnwY7S4GjhdxiayBWhwt2lPp+mANs+neTDl
         O64zdCjP6r3v7lqVCFQC4kPESsjGi7VflBVxF2a17Y1ijMCHMMkjhdG118TQtm8CZ5uT
         VwBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eK5CJpBaboC0hEciRwXZ1C92olmsKQDqEljQyovaSOk=;
        b=XRY1OVhNv4bpGsOxbY/4nP5o6C1aDAPk82WFPy/LLKwptBKZP1zPhSslcgV2k4cYJu
         YiHZfJuTTvrJMz4A+bUqK1lCMIQBn4rKoZ/JpQtSzPVUXS9sEwfxCnbyhqBIhCfRMEol
         dGceXIECCzYEWzLXfRo4chOY4ycRHzqoV0sf6IIaAEr0df+1/lB8/HId6YM2dKYkLhiw
         4lrZMkEjxvIo9vIYvOtLwlbRwEyFyDvQFUwO7n7/1FYI1kUr6IP0/umCu+BKde+hOHWd
         TnGT7i4+EU2kEDVcERLcMtgiVHQjIvRwNOT+ZO9mz2l4dKsIQoFtilDJpIDGKERBAXCE
         D3jQ==
X-Gm-Message-State: APjAAAXEM36EV72OtiMvdndAbAZrvKKmXdppyEZi6wp/lfh2cuqgy0It
        B2skACmSFkrOnjvEyQwF5XGhvsL1vyn+bQ==
X-Google-Smtp-Source: APXvYqwaGvkUTLPL4DeUKFYdt9gDCaWFB8CBgJI60dAMnRNNCBM8p/c0pVpCPwsG2XyYSuc2ymA8SQ==
X-Received: by 2002:a05:620a:44:: with SMTP id t4mr5034628qkt.189.1560864919497;
        Tue, 18 Jun 2019 06:35:19 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::a0ec])
        by smtp.gmail.com with ESMTPSA id f25sm10849540qta.81.2019.06.18.06.35.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 06:35:18 -0700 (PDT)
Date:   Tue, 18 Jun 2019 09:35:17 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Qu Wenruo <wqu@suse.com>, Nikolay Borisov <nborisov@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Matias =?utf-8?B?QmrDuHJsaW5n?= <mb@lightnvm.io>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 08/19] btrfs: make unmirroed BGs readonly only if we have
 at least one writable BG
Message-ID: <20190618133516.giriyfzpnhdquuot@MacBook-Pro-91.local>
References: <20190607131025.31996-1-naohiro.aota@wdc.com>
 <20190607131025.31996-9-naohiro.aota@wdc.com>
 <20190613140921.a2kmty5p6lzqztej@MacBook-Pro-91.local>
 <SN6PR04MB5231CACF687ED7001C73111A8CEA0@SN6PR04MB5231.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR04MB5231CACF687ED7001C73111A8CEA0@SN6PR04MB5231.namprd04.prod.outlook.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 18, 2019 at 07:42:46AM +0000, Naohiro Aota wrote:
> On 2019/06/13 23:09, Josef Bacik wrote:
> > On Fri, Jun 07, 2019 at 10:10:14PM +0900, Naohiro Aota wrote:
> >> If the btrfs volume has mirrored block groups, it unconditionally makes
> >> un-mirrored block groups read only. When we have mirrored block groups, but
> >> don't have writable block groups, this will drop all writable block groups.
> >> So, check if we have at least one writable mirrored block group before
> >> setting un-mirrored block groups read only.
> >>
> > 
> > I don't understand why you want this.  Thanks,
> > 
> > Josef
> > 
> 
> This is necessary to handle e.g. btrfs/124 case.
> 
> When we mount degraded RAID1 FS and write to it, and then
> re-mount with full device, the write pointers of corresponding
> zones of written BG differ.  The patch 07 mark such block group
> as "wp_broken" and make it read only.  In this situation, we only
> have read only RAID1 BGs because of "wp_broken" and un-mirrored BGs
> are also marked read only, because we have RAID1 BGs.
> As a result, all the BGs are now read only, so that we
> cannot even start the rebalance to fix the situation.

Ah ok, please add this explanation to the changelog.  Thanks,

Josef
