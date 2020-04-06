Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB94C19F8B5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Apr 2020 17:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbgDFPTL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Apr 2020 11:19:11 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:33274 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728843AbgDFPTL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Apr 2020 11:19:11 -0400
Received: by mail-pj1-f68.google.com with SMTP id cp9so99239pjb.0;
        Mon, 06 Apr 2020 08:19:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aBfDok83UFCkn0X8D+fWJrmNHdBWoIO84bdn980eTHw=;
        b=AB40wVEXYr//GaCjwVMa2IClSM1o1poqpwK+v4mxFG7Ux4ujrsTd4ztwlz5uiRewpX
         jOH0owTymoAqjGpJZeuiOUdFWtuRbAPcdkUX2Y7YzNJzMdl0TO1M0PUh9Xe8MFeIgrfU
         JXu94cqw2SiWcGsH1as6gM06jyjUdNofD89SuqVjBZG73tGFZNO2CnqH23F+cc71bGCf
         gA99oAF/gV62AtnQsq9Y+73GxuowAOvHwO0A5GTqvNNYhCyHFwdTlXeyGYU48/SYuyIv
         r6MfPiViRLH04Fvz8cwpq4pVNXc7A/2NIq+hOduRpFQR9SRj2MKWGs9i1Kc2361fJg7m
         baAg==
X-Gm-Message-State: AGi0PuajSse0wwTcEJvkGfqTjtYYAliJWMcwlBiY8Jk+MgkZXJEYHxCK
        PkeQVixmT+AaZjrI0AhH3hI=
X-Google-Smtp-Source: APiQypLohMHAjT+WYyd+ePgRHomKWtNjTSamyDoO53eqDsQlYbPSAxuCfWqY8eGCTaUyBSoLzgc/CQ==
X-Received: by 2002:a17:902:b187:: with SMTP id s7mr21513465plr.84.1586186349722;
        Mon, 06 Apr 2020 08:19:09 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id h10sm11187936pgf.23.2020.04.06.08.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 08:19:08 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id B104940246; Mon,  6 Apr 2020 15:19:07 +0000 (UTC)
Date:   Mon, 6 Apr 2020 15:19:07 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Nicolai Stange <nstange@suse.de>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Eric Sandeen <sandeen@sandeen.net>, axboe@kernel.dk,
        viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        rostedt@goodmis.org, mingo@redhat.com, jack@suse.cz,
        ming.lei@redhat.com, mhocko@suse.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>,
        syzbot+603294af2d01acfdd6da@syzkaller.appspotmail.com
Subject: Re: [RFC 2/3] blktrace: fix debugfs use after free
Message-ID: <20200406151907.GD11244@42.do-not-panic.com>
References: <20200402000002.7442-1-mcgrof@kernel.org>
 <20200402000002.7442-3-mcgrof@kernel.org>
 <3640b16b-abda-5160-301a-6a0ee67365b4@acm.org>
 <b827d03c-e097-06c3-02ab-00df42b5fc0e@sandeen.net>
 <75aa4cff-1b90-ebd4-17a4-c1cb6d390b30@acm.org>
 <87d08lj7l6.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d08lj7l6.fsf@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 06, 2020 at 11:18:13AM +0200, Nicolai Stange wrote:
> Bart Van Assche <bvanassche@acm.org> writes:

> So I'd suggest to drop patch [3/3] from this series and modify this
> patch [2/3] here to move the blk_q_debugfs_unregister(q) invocation from
> __blk_release_queue() to blk_unregister_queue() instead.

I'll take a stab.

> > Additionally, I think the following changes fix that problem by using
> > q->debugfs_dir in the blktrace code instead of debugfs_lookup():
> 
> That would fix the UAF, but !queue_is_mq() queues wouldn't get a debugfs
> directory created for them by blktrace anymore?

It would, it would just be done early on init as well, and it would now be
shared with the queue_is_mq() case.

  Luis
