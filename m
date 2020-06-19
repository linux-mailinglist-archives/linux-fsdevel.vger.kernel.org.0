Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B213B201C56
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jun 2020 22:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392200AbgFSUXx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Jun 2020 16:23:53 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:54794 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392082AbgFSUXw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Jun 2020 16:23:52 -0400
Received: by mail-pj1-f68.google.com with SMTP id u8so4508001pje.4;
        Fri, 19 Jun 2020 13:23:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RNk3YYxZgiMdt5E1Q+HAeQPHMt5QiUV6QIFeXf5YA6E=;
        b=Znu/O3rgl5x+2/g2VK8Uox5QocoVot9+V13koAF7V5goz9AvVLHwRL2SlhqEUEyoze
         kMhlaXutNvU03sEbVemqqm9PX+sll7AaWVOf03BtIm/4KZkAWBRuHEMvPZFtlbp7Oxb0
         zobeEByLLXL8URLOCin2SuqCNC5UDKhil61DtfwDIlzBRYpIuUc+mhiexPAqbLXAuCiY
         uqBXGfGhvV8n/X9dCU00h7voJsDLHnFR13yeQzXqi2wllfovX10lnUaJec2S9N1z2b5N
         Pmf16mLyccJd06d7sQyd1oTA/QMa99U08QuX93DwHdfDehPKBKpiGz+RD0Js/DP0clb8
         zV+w==
X-Gm-Message-State: AOAM532GnDlQOpmz1nS4rnZnpa8pHvcyaQmSz5KM8stGMkV3SLAqubr2
        DzyIQLI+18ITc7NB2+nw2XQ=
X-Google-Smtp-Source: ABdhPJwyTucVAhYVByutNy/3iB7HUovNaBJeVj/WU7TGkfz1k4YvkICw6ZEx8Vi19BK0QPdR+PbQWw==
X-Received: by 2002:a17:902:e989:: with SMTP id f9mr10040039plb.268.1592598231563;
        Fri, 19 Jun 2020 13:23:51 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id b1sm6738696pfr.89.2020.06.19.13.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 13:23:49 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 9DED34063E; Fri, 19 Jun 2020 20:23:48 +0000 (UTC)
Date:   Fri, 19 Jun 2020 20:23:48 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org, mhocko@suse.com, yukuai3@huawei.com,
        martin.petersen@oracle.com, jejb@linux.ibm.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v6 3/6] block: revert back to synchronous request_queue
 removal
Message-ID: <20200619202348.GJ11244@42.do-not-panic.com>
References: <20200608170127.20419-1-mcgrof@kernel.org>
 <20200608170127.20419-4-mcgrof@kernel.org>
 <e1fad3cd-32a1-7a08-b8a4-084dfbff4680@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1fad3cd-32a1-7a08-b8a4-084dfbff4680@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 12, 2020 at 06:53:40PM -0700, Bart Van Assche wrote:
> On 2020-06-08 10:01, Luis Chamberlain wrote:
> > + * Drivers exist which depend on the release of the request_queue to be
> > + * synchronous, it should not be deferred.
> 
> This sounds mysterious. Which drivers? Why do these depend on this
> function being synchronous?

Sorry that should be "Userspace can exist". I've fixed that.

> Anyway:
> 
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>

  Luis
