Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCB6B437F7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2019 17:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732605AbfFMPC2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jun 2019 11:02:28 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46678 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732508AbfFMO0B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jun 2019 10:26:01 -0400
Received: by mail-qt1-f196.google.com with SMTP id h21so22707601qtn.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jun 2019 07:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7Gz4cYRh+oElC85Gy1pK6Xy10nwHn3MvUJ0ScJkTm3E=;
        b=uI/WQ5SJ/Qt2yWiJ1l/NoXQydtuj3RBnifEE0KmNR+6FVkvydHwwsCA93oVRfFgx+5
         BbP4HXJl+lJPEFu0NtF2YEmfE80+FvyYM15T/vSlwPRXeJ6pt7imuegIW7KylC65MCvg
         HqplX/eVXsXZ5Oe3RwAMtqeGscFQsCJhbYU5IwTd7TsNM2qDuTmvIa0NUaGcN/Goudsi
         pjkI7EP4IVbghzl/wKxWw0i4piIgyDi+TSc2g1oPZ/yWjj8IEXIp70nC/K98Cbo2Ncvu
         r0cfi8q/MlVGtDGtLGM1t7f9pgXz18KeabwhOelrkXfpR/joO78cnX9fH7oHr+JZlnuW
         HPCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7Gz4cYRh+oElC85Gy1pK6Xy10nwHn3MvUJ0ScJkTm3E=;
        b=ocNkOpgWCY3RgwOITWEZi7twHVvQdmgPgJSRmHAGoagyfj4OCY0nV9CmDS50zN6U0+
         qQueQ0XYPCY162A9q3pjzj88guadmIFpf3MP8mTw0++u7c41dBmRBIqFtTFg1+Jncna4
         7q9lddOIq5Gwl7Hzms5cp0pnsXRi+QW4i7SCSq93OS9daTc7hFKuxGdE+JrRP+9YX6Oc
         4NnSn2f+B/m1vEdABUO8XNhWUKD0uQJMuzhZb3zAOu/VG2cQ4MDI6Dqfr0TNaZNOpMAF
         h8q9+X6CYy14LnwKqi6k0Eh6sB+gadTMMr4m3ofy2+cMfpMkzzI2hoK5VzltsOLMpP2X
         IEqA==
X-Gm-Message-State: APjAAAWBW7QMv3R+ydsQFueAxLe+wEhgirWxiueqotBxhJWiZSqLwYZv
        b+TLQjNCbhOfRZ65NOy1la4vrQ==
X-Google-Smtp-Source: APXvYqxeUOEmsQrFHvHAs097IsIUaG6o5mfZFPDjwDneMLPyqTGTvnKsPGdmZfcdm7OKvfoz923ueQ==
X-Received: by 2002:ac8:1b64:: with SMTP id p33mr77811221qtk.62.1560435960588;
        Thu, 13 Jun 2019 07:26:00 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::9d6b])
        by smtp.gmail.com with ESMTPSA id q37sm1950915qtj.94.2019.06.13.07.25.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 07:25:59 -0700 (PDT)
Date:   Thu, 13 Jun 2019 10:25:58 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Qu Wenruo <wqu@suse.com>, Nikolay Borisov <nborisov@suse.com>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        linux-fsdevel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias =?utf-8?B?QmrDuHJsaW5n?= <mb@lightnvm.io>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 16/19] btrfs: wait existing extents before truncating
Message-ID: <20190613142557.sexckoyaylbspran@MacBook-Pro-91.local>
References: <20190607131025.31996-1-naohiro.aota@wdc.com>
 <20190607131025.31996-17-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607131025.31996-17-naohiro.aota@wdc.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 07, 2019 at 10:10:22PM +0900, Naohiro Aota wrote:
> When truncating a file, file buffers which have already been allocated but
> not yet written may be truncated.  Truncating these buffers could cause
> breakage of a sequential write pattern in a block group if the truncated
> blocks are for example followed by blocks allocated to another file. To
> avoid this problem, always wait for write out of all unwritten buffers
> before proceeding with the truncate execution.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  fs/btrfs/inode.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 89542c19d09e..4e8c7921462f 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -5137,6 +5137,17 @@ static int btrfs_setsize(struct inode *inode, struct iattr *attr)
>  		btrfs_end_write_no_snapshotting(root);
>  		btrfs_end_transaction(trans);
>  	} else {
> +		struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
> +
> +		if (btrfs_fs_incompat(fs_info, HMZONED)) {
> +			u64 sectormask = fs_info->sectorsize - 1;
> +
> +			ret = btrfs_wait_ordered_range(inode,
> +						       newsize & (~sectormask),
> +						       (u64)-1);

Use ALIGN().  Thanks,

Josef
