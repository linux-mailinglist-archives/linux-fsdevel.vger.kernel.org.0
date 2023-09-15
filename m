Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63B027A22B6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 17:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236138AbjIOPnk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 11:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236207AbjIOPnQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 11:43:16 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FF12130
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Sep 2023 08:43:00 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id ada2fe7eead31-44ebf4c623eso1021950137.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Sep 2023 08:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hefring-com.20230601.gappssmtp.com; s=20230601; t=1694792580; x=1695397380; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TKd8P1ObZVIt5Y+naauSBYNI9NKQ+uh5MAJBtM9jGKY=;
        b=ChGQuaYbixpDRysTiLUTV3BB52ca14ZtMmvlJfm0PKI5OGPSZM+NtYLkOE7ITAXwuB
         xxytnXamzbIbpAonoiM4Sse13kSJcPuyGCZK73RzAmEqYNGxD0jMJfdewd8lBoHzqxFC
         G98PBU8aQCKwPgfdhSYvvwDlcLy/TVv4baEMdgKd/IgGW0EJFvSP6ikZpuvLUHYYol61
         GrdtgY2lzfgCLEtrc9ZPSkEE7KPsYcksQigzNtV/PHEFbqcwEUj5hM7/Xp9U9QrL3/kq
         q12Sm1+wOnESB+NnLzwYBRHLXzX/Zkj2OXJDNh0T4z4O/ruIE51ytjA72YItJMBx/bPt
         sfkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694792580; x=1695397380;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TKd8P1ObZVIt5Y+naauSBYNI9NKQ+uh5MAJBtM9jGKY=;
        b=dLJLEN6AiwR5ijX7qiG3bMO26y1+tQLvm4q8sF1FyceyhOgEOLi/UJck6dGcFG2/uz
         lLbglAu7RDTfsxFl8gfn4TS8Ns+EvykVi9xViME996S27M9SiD5KLGpANzDJvdbCJdvj
         oSrQnaqyJrYOum9gtvcZ6NCqTERkrEkccD4H8xZleWqhUMWSKNhKSMlQtgoKhaj64MwE
         ohSniNkCzL6UIYiBjQ59T99Y0rdVDXu2CQWTfD40WLJxY/McGt653kU+1g5oMvUcWIb8
         7FAy7k5D4gKI3PAYYMKMUQ27IjY18ruQofRfYqnQY5bmzUteIMmX+JntHrCDIKH0OQXr
         Vnqg==
X-Gm-Message-State: AOJu0YxsM8+DcBaQJmu1skD3Q5DhDFsu76F4duBtzhyUnXgAoWtxHnc8
        VEv2dXgNYZfe8hlV/ozG66RZaw==
X-Google-Smtp-Source: AGHT+IExzsnZapUN4xOIpkd9Pl9MR4cQU11dkQE/LySYUUOdMw5EvfBgiZrq7xyxsl+B7thwdGpZFg==
X-Received: by 2002:a67:f148:0:b0:44e:98ad:43db with SMTP id t8-20020a67f148000000b0044e98ad43dbmr1910546vsm.7.1694792580101;
        Fri, 15 Sep 2023 08:43:00 -0700 (PDT)
Received: from dell-precision-5540 ([50.212.55.89])
        by smtp.gmail.com with ESMTPSA id oh1-20020a056214438100b0064cb3358338sm1222855qvb.110.2023.09.15.08.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 08:42:59 -0700 (PDT)
Date:   Fri, 15 Sep 2023 11:42:51 -0400
From:   Ben Wolsieffer <ben.wolsieffer@hefring.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Greg Ungerer <gerg@uclinux.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>
Subject: Re: [PATCH] proc: nommu: /proc/<pid>/maps: release mmap read lock
Message-ID: <ZQR7eyCU2cXXaseD@dell-precision-5540>
References: <20230914163019.4050530-2-ben.wolsieffer@hefring.com>
 <20230914100203.e5905ee145b7cb580c8df9c4@linux-foundation.org>
 <ZQNDHXyl8c6YZ4Q6@dell-precision-5540>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQNDHXyl8c6YZ4Q6@dell-precision-5540>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 14, 2023 at 01:30:08PM -0400, Ben Wolsieffer wrote:
> On Thu, Sep 14, 2023 at 10:02:03AM -0700, Andrew Morton wrote:
> > On Thu, 14 Sep 2023 12:30:20 -0400 Ben Wolsieffer <ben.wolsieffer@hefring.com> wrote:
> > 
> > > The no-MMU implementation of /proc/<pid>/map doesn't normally release
> > > the mmap read lock, because it uses !IS_ERR_OR_NULL(_vml) to determine
> > > whether to release the lock. Since _vml is NULL when the end of the
> > > mappings is reached, the lock is not released.
> > > 
> > 
> > Thanks.  Is this bug demonstrable from userspace?  If so, how?
> 
> Yes, run "cat /proc/1/maps" twice. You should observe that the
> second run hangs.
 
Hi Andrew,

I apologize because I realized I provided an incorrect reproducer for
this bug. I responded from what I remembered of this bug (I originally
wrote the patch over a year ago) and did not test it.

Reading /proc/1/maps twice doesn't reproduce the bug because it only
takes the read lock, which can be taken multiple times and therefore
doesn't show any problem if the lock isn't released. Instead, you need
to perform some operation that attempts to take the write lock after
reading /proc/<pid>/maps. To actually reproduce the bug, compile the
following code as 'proc_maps_bug':

#include <stdio.h>
#include <unistd.h>
#include <sys/mman.h>

int main(int argc, char *argv[]) {
        void *buf;
        sleep(1);
        buf = mmap(NULL, 4096, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
        puts("mmap returned");
        return 0;
}

Then, run:

  ./proc_maps_bug &; cat /proc/$!/maps; fg

Without this patch, mmap() will hang and the command will never
complete.

Additionally, it turns out you cannot reproduce this bug on recent
kernels because 0c563f148043 ("proc: remove VMA rbtree use from nommu")
introduces a second bug that completely breaks /proc/<pid>/maps and
prevents the locking bug from being triggered. I will have a second
patch for that soon.

Thanks, Ben
