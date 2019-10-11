Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93A6ED469D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2019 19:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728592AbfJKR3d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Oct 2019 13:29:33 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35111 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728400AbfJKR3d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Oct 2019 13:29:33 -0400
Received: by mail-qk1-f195.google.com with SMTP id w2so9621039qkf.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Oct 2019 10:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZlawNqiIrlxi2ApwYIHMt2ySb3DJnX83ekR46WNEuD8=;
        b=oPPZKlXEFUHuhWPRBTB66f5TuNdKPo1F7y980pmfv6qBeoF5EBbbrFzaVKf4tRDFD9
         nsRbvAMYRmSnt1HPyn858h9l/ankSGXrGBV1BPcmeeGod5InqJLRRgLFUsY+eWdwI7RQ
         D2Oo+HiEYJl3E2r6HFeEkaXCYXeHt4NrE64ZbUnYIqawfcCQNbHyAdxBFAsEY2tnbh43
         Xow6Z1wv7o/d43lUPjeFJRBDg/K0m+3vXXGJWxGr8yBL/eU72+4+nVmHp+SaaeWlvZz2
         gqgU4wbswzub8Ea5ju/4bA05o5KFJiKuvbkLfzRE4hlkMY9lLGXgg7cUtXL++LJjf7aw
         j5+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZlawNqiIrlxi2ApwYIHMt2ySb3DJnX83ekR46WNEuD8=;
        b=HeJwwxqPRuxtxi+SMUZHIUq+tGsdDK9tOOrwS28BBMZ5Kodd3UnMAQDANxqyt1bdaN
         22L8UV7GJIHADFmk6s3ewl1cTUTJXzAUn5Rvudx5uprqaA/IUG8AD0mHuSjZwg0Znc67
         8YkF4MtZaahmSBvptWkbPoMSzjtQyvxgVun8OFSkCDbgf8SHpTu/T+96h3zkST8lpMSE
         M9p9mV//wCEOnQz7nyLbB0en00lD8Pw6bSq9ePVpkkjya+AnD5LazT5WmS4VH/KEDfXi
         Tuyal+CJK7LUbXqhEu47ssGPB/36QUzaCidj/ls8u6yafLsbvOTcujXOaH0/UnEkR9+F
         LoDQ==
X-Gm-Message-State: APjAAAXTBo6OxE/0s8XjxIQkX5cwb0mFV+XZh/Do5s/uclotMmLa9q6m
        D5VN/NGR4ul8BLjH44vEkFZDQsFXmwZKTg==
X-Google-Smtp-Source: APXvYqxfCYATJC2AnPyv48KSLBOW2raArpyn9mUn3NRL0X1Sb3+H0K6byZ3xLJwNc/FxgyzGZKSpdw==
X-Received: by 2002:a37:4fd1:: with SMTP id d200mr16492961qkb.413.1570814970811;
        Fri, 11 Oct 2019 10:29:30 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::d36])
        by smtp.gmail.com with ESMTPSA id z20sm5309890qtu.91.2019.10.11.10.29.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Oct 2019 10:29:30 -0700 (PDT)
Date:   Fri, 11 Oct 2019 13:29:28 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Eric Sandeen <sandeen@redhat.com>
Cc:     fsdevel <linux-fsdevel@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        Josef Bacik <jbacik@fb.com>
Subject: Re: [PATCH] fs: avoid softlockups in s_inodes iterators
Message-ID: <20191011172927.4d4wnvgd7rfwwr7o@macbook-pro-91.dhcp.thefacebook.com>
References: <841d0e0f-f04c-9611-2eea-0bcc40e5b084@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <841d0e0f-f04c-9611-2eea-0bcc40e5b084@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 11, 2019 at 11:49:38AM -0500, Eric Sandeen wrote:
> Anything that walks all inodes on sb->s_inodes list without rescheduling
> risks softlockups.
> 
> Previous efforts were made in 2 functions, see:
> 
> c27d82f fs/drop_caches.c: avoid softlockups in drop_pagecache_sb()
> ac05fbb inode: don't softlockup when evicting inodes
> 
> but there hasn't been an audit of all walkers, so do that now.  This
> also consistently moves the cond_resched() calls to the bottom of each
> loop.
> 
> One remains: remove_dquot_ref(), because I'm not quite sure how to deal
> with that one w/o taking the i_lock.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>

You've got iput cleanups in here and cond_resched()'s.  I feel like this is a
missed opportunity to pad your patch count.  Thanks,

Josef
