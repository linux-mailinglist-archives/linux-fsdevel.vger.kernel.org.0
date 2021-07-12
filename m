Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7D473C6085
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 18:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234062AbhGLQaW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 12:30:22 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:48846 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234121AbhGLQaW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 12:30:22 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 473C41FFC4;
        Mon, 12 Jul 2021 16:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626107253; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7kkMZjDRMj7KWtoreRqtMLkkZUCsdAlZuYuLwTsZNPg=;
        b=ANKcOJtZRrdncXCMYHeYRXJDZW7pZTXGHqeAeKUkQ/vNO2NdII3cOnrZinqVGKY8l6Zpg9
        PjZQ1Kc14uBK3/uJddNYCzf9ae0x6BfaXaFI5Z8WtHgKUtFnacdwjvHZJLgygDuoqzuPnR
        37AqK0IGI0a7lnKAddWIW/kLnofoSNE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626107253;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7kkMZjDRMj7KWtoreRqtMLkkZUCsdAlZuYuLwTsZNPg=;
        b=YALKMdjwp8L1vj3davMADw80cpNi32AL4IDzihl3Dx6/aEQMpWtp4Yc1cn0VdJZN9yO0IS
        WGDniz8wZ+uQPHCw==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 375E0A3BDF;
        Mon, 12 Jul 2021 16:27:33 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 2805B1F2AA9; Mon, 12 Jul 2021 18:27:33 +0200 (CEST)
Date:   Mon, 12 Jul 2021 18:27:33 +0200
From:   Jan Kara <jack@suse.cz>
To:     Michael Stapelberg <stapelberg+linux@google.com>
Cc:     Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-mm <linux-mm@kvack.org>
Subject: Re: [PATCH 0/5] writeback: Fix bandwidth estimates
Message-ID: <20210712162733.GB9804@quack2.suse.cz>
References: <20210705161610.19406-1-jack@suse.cz>
 <CAH9Oa-ba0Y4BxzM6=7fDN09zmetd3EUSfSPNu3EcFbdGV+KDvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH9Oa-ba0Y4BxzM6=7fDN09zmetd3EUSfSPNu3EcFbdGV+KDvg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 09-07-21 15:19:17, Michael Stapelberg wrote:
> Thanks for sending this patch series!
> 
> I have used the mmap.c reproducer as before, with the following parameters:
> * mkdir /tmp/mnt
> * fusermount -u /tmp/mnt; /root/fuse-2.9.9/example/fusexmp_fh -f /tmp/mnt
> * dd if=/dev/urandom of=/tmp/was bs=1M count=99
> * while :; do grep ^Bdi /sys/kernel/debug/bdi/0:44/stats; sleep 0.1; done
> * while :; do time WORKAROUND=1 ~/mmap /tmp/was
> /tmp/mnt/tmp/stapelberg.1; sleep 5; done
> 
> Previously, after a few iterations, the BdiWriteBandwidth measure
> would gradually approach 0.
> 
> With your patch series applied, the BdiWriteBandwidth is updated much
> more quickly, and converges to ≈16000 kBps.
> When I start copying more quickly, the bandwidth measure rises quickly.
> 
> As far as I understand, this should fix the problem (provided 16000
> kBps is an okay value).
> Certainly, I don’t see the downward spiral either with your patches :)

Thanks for testing! Can I add your Tested-by tag?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
