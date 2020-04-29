Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1DA01BDBF7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 14:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgD2MVz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Apr 2020 08:21:55 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33764 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbgD2MVz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Apr 2020 08:21:55 -0400
Received: by mail-pl1-f196.google.com with SMTP id t7so791347plr.0;
        Wed, 29 Apr 2020 05:21:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8hYyIcFg83pPVTyQcqYDesu3NloqLxLSIbckmr0AwHk=;
        b=JrxAkFrbFloSjpp2rbn9klvLI0OhbYSsdXqkMBfIPNsgqeUA8ADBI1MSnk55XxAMgv
         u3gl1DTZ4FxFDxbkdYJIv2zOnDx/lolIrBxBsZl19CsIaL+QUnq3MCeu4CWpjkerQ7wD
         8HB3rDXbUH7Zed0YUqgg5ysDgllZTvZteNmZqbfsFM2ntpZz5CFUOoEvkVeXJUTTSXBs
         28WcE1DupmcpiO95iS/kSxLmMR1GHCLwf4gwHLdGSH4pQufLwwO6z36UegaV00gT/O4/
         kcqHFGk44lYltrd6fDJvAsSMY600aVHbUI1yWqN5psNtcW8HhpCzeK2TN2Ggi0AQgNmp
         wSog==
X-Gm-Message-State: AGi0PuZI82T/fLIMhjkx6iV6F6OO14Kj44mQzqN8YuxIVMJBC4WkgrpS
        XapShQfLFSxIj3WmcISSq/c=
X-Google-Smtp-Source: APiQypK7Azz2+WxwoHE3rVYKcE7BGDyy2jhBIIpR257VCG9YgyRto2jm/uAjKMSpahuJrXm0uANnmA==
X-Received: by 2002:a17:90a:fa0e:: with SMTP id cm14mr2871825pjb.92.1588162914403;
        Wed, 29 Apr 2020 05:21:54 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id h9sm966620pfo.129.2020.04.29.05.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 05:21:53 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 861A4403AB; Wed, 29 Apr 2020 12:21:52 +0000 (UTC)
Date:   Wed, 29 Apr 2020 12:21:52 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org, mhocko@suse.com, yukuai3@huawei.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>,
        syzbot+603294af2d01acfdd6da@syzkaller.appspotmail.com
Subject: Re: [PATCH v3 4/6] blktrace: fix debugfs use after free
Message-ID: <20200429122152.GL11244@42.do-not-panic.com>
References: <20200429074627.5955-1-mcgrof@kernel.org>
 <20200429074627.5955-5-mcgrof@kernel.org>
 <20200429112637.GD21892@infradead.org>
 <20200429114542.GJ11244@42.do-not-panic.com>
 <20200429115051.GA27378@infradead.org>
 <20200429120230.GK11244@42.do-not-panic.com>
 <20200429120406.GA913@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429120406.GA913@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 29, 2020 at 05:04:06AM -0700, Christoph Hellwig wrote:
> On Wed, Apr 29, 2020 at 12:02:30PM +0000, Luis Chamberlain wrote:
> > > Err, that function is static and has two callers.
> > 
> > Yes but that is to make it easier to look for who is creating the
> > debugfs_dir for either the request_queue or partition. I'll export
> > blk_debugfs_root and we'll open code all this.
> 
> No, please not.  exported variables are usually a bad idea.  Just
> skip the somewhat pointless trivial static function.

Alrighty. It has me thinking we might want to only export those symbols
to a specific namespace. Thoughts, preferences?

BLOCK_GENHD_PRIVATE ?

The scsi-generic driver seems... rather unique, and I'd imagine we'd
want to discourage such concoctions in the future, so proliferations
of these symbols.

  Luis
