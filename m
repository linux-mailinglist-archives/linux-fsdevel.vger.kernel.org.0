Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD201A0927
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Apr 2020 10:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbgDGIPL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Apr 2020 04:15:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:45178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbgDGIPK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Apr 2020 04:15:10 -0400
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB04120801;
        Tue,  7 Apr 2020 08:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586247309;
        bh=dEmA4cuG8bN53q2x0ul8u7PDRTuM3LEq8qspwvwBuBs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sEPhxcAf0XJ1a/fHnUbFabJSW9BJgkWw4M+iMRNsfNAGz9pwcvkddldUVoXII9uYX
         DwpG9K6MA9N81tQfTVll8qFqqcFLU4IAVX+LbbjyLsOkhWunUJUJGSOkldcLUzNyCb
         +W1xJXUSztqeWWqOXN1G6jsKXGr5QKksADzEDQWU=
Received: by mail-vk1-f170.google.com with SMTP id q7so49897vkb.9;
        Tue, 07 Apr 2020 01:15:09 -0700 (PDT)
X-Gm-Message-State: AGi0PubOEp3yAodyOl46Q+Hr5HvCFljR+cWpjzfuKuwjiVme3TAM90yY
        2Abm1aiSK3Y7ddrXefyQQDW+x8nUpK0ljDrvt4Q=
X-Google-Smtp-Source: APiQypLzXB/kSZidaZLKVq0R9ObzvkBjKLK6kgXeMYHi+lv2tPUK43YS2V0Y/KpoI0sDDmaev+p5BRyXgal4YlIrpWo=
X-Received: by 2002:ac5:cbd5:: with SMTP id h21mr587035vkn.60.1586247308681;
 Tue, 07 Apr 2020 01:15:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200402000002.7442-1-mcgrof@kernel.org> <20200402000002.7442-3-mcgrof@kernel.org>
 <3640b16b-abda-5160-301a-6a0ee67365b4@acm.org> <b827d03c-e097-06c3-02ab-00df42b5fc0e@sandeen.net>
 <75aa4cff-1b90-ebd4-17a4-c1cb6d390b30@acm.org> <87d08lj7l6.fsf@suse.de> <20200406151907.GD11244@42.do-not-panic.com>
In-Reply-To: <20200406151907.GD11244@42.do-not-panic.com>
From:   Luis Chamberlain <mcgrof@kernel.org>
Date:   Tue, 7 Apr 2020 02:15:03 -0600
X-Gmail-Original-Message-ID: <CAB=NE6VJW4TiPHSqr8GXQ326WCbFa_rgT6kKz0bHus6i0Coz4Q@mail.gmail.com>
Message-ID: <CAB=NE6VJW4TiPHSqr8GXQ326WCbFa_rgT6kKz0bHus6i0Coz4Q@mail.gmail.com>
Subject: Re: [RFC 2/3] blktrace: fix debugfs use after free
To:     Nicolai Stange <nstange@suse.de>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Jan Kara <jack@suse.cz>,
        Ming Lei <ming.lei@redhat.com>, Michal Hocko <mhocko@suse.com>,
        linux-block@vger.kernel.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>,
        syzbot+603294af2d01acfdd6da@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 6, 2020 at 9:19 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Mon, Apr 06, 2020 at 11:18:13AM +0200, Nicolai Stange wrote:
> > Bart Van Assche <bvanassche@acm.org> writes:
>
> > So I'd suggest to drop patch [3/3] from this series and modify this
> > patch [2/3] here to move the blk_q_debugfs_unregister(q) invocation from
> > __blk_release_queue() to blk_unregister_queue() instead.
>
> I'll take a stab.

That didn't work. I'll look for alternatives.

  Luis
