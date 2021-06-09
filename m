Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC663A0871
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jun 2021 02:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbhFIAjG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Jun 2021 20:39:06 -0400
Received: from mail-il1-f170.google.com ([209.85.166.170]:35392 "EHLO
        mail-il1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbhFIAjF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Jun 2021 20:39:05 -0400
Received: by mail-il1-f170.google.com with SMTP id b9so22395612ilr.2;
        Tue, 08 Jun 2021 17:37:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=z9xvYmw13b60K378g+x+OptBkyWgf9AfbCR5AXVFM5Q=;
        b=Bdk2keqKmepkOviS2h7YcK3ugh5FZB9Pad8h3E6LaYpmIswBb28HN5cKX0dToXpVwG
         pZ+65Yw8jpkkz1Ik2e5V4Hf1LjwQLRgLphvChq5zhRT6XwXyjd2bFfidVWR7DoAbdwhF
         BQZVImIkVaTOZfy5hEdGiJxdXnyXR3+gQj5Ak4CW9Dee2O6wjeOFLaLmuS9N3xTpBrxx
         s8YP0fBiRl/fDS15dUCBag2obukDgUKEMvSVyYz11SC7zt1AryQxnFNUj8s6lJadAwOf
         pg6xk0giIPmjtMqmp4SvAgeYDzY9A0SQW3XsLS1nDoVlSX1UXgFYmtE6bHVQzm26Mgk6
         1ZRw==
X-Gm-Message-State: AOAM531wgX3iTj7LyfWu4/6JZpZWEQc+eJRzZX6ILrgfpm6qGFZPJT8j
        gtAL7OTyq4rzCaGp+0dVcZ8=
X-Google-Smtp-Source: ABdhPJya9bbFM8vdeKIdzDKdWIbr8Lb1teNvv6b2Ph//eGKubN2nQ8omGTaOwxmop/DoG9Rh33jelQ==
X-Received: by 2002:a92:c704:: with SMTP id a4mr21787667ilp.157.1623199031629;
        Tue, 08 Jun 2021 17:37:11 -0700 (PDT)
Received: from google.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id a18sm697476ilc.31.2021.06.08.17.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 17:37:11 -0700 (PDT)
Date:   Wed, 9 Jun 2021 00:37:10 +0000
From:   Dennis Zhou <dennis@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, Dave Chinner <dchinner@redhat.com>,
        cgroups@vger.kernel.org
Subject: Re: [PATCH v9 8/8] writeback, cgroup: release dying cgwbs by
 switching attached inodes
Message-ID: <YMANNhixU0QUqZIJ@google.com>
References: <20210608230225.2078447-1-guro@fb.com>
 <20210608230225.2078447-9-guro@fb.com>
 <20210608171237.be2f4223de89458841c10fd4@linux-foundation.org>
 <YMAKBgVgOhYHhB3N@carbon.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMAKBgVgOhYHhB3N@carbon.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 08, 2021 at 05:23:34PM -0700, Roman Gushchin wrote:
> On Tue, Jun 08, 2021 at 05:12:37PM -0700, Andrew Morton wrote:
> > On Tue, 8 Jun 2021 16:02:25 -0700 Roman Gushchin <guro@fb.com> wrote:
> > 
> > > Asynchronously try to release dying cgwbs by switching attached inodes
> > > to the nearest living ancestor wb. It helps to get rid of per-cgroup
> > > writeback structures themselves and of pinned memory and block cgroups,
> > > which are significantly larger structures (mostly due to large per-cpu
> > > statistics data). This prevents memory waste and helps to avoid
> > > different scalability problems caused by large piles of dying cgroups.
> > > 
> > > Reuse the existing mechanism of inode switching used for foreign inode
> > > detection. To speed things up batch up to 115 inode switching in a
> > > single operation (the maximum number is selected so that the resulting
> > > struct inode_switch_wbs_context can fit into 1024 bytes). Because
> > > every switching consists of two steps divided by an RCU grace period,
> > > it would be too slow without batching. Please note that the whole
> > > batch counts as a single operation (when increasing/decreasing
> > > isw_nr_in_flight). This allows to keep umounting working (flush the
> > > switching queue), however prevents cleanups from consuming the whole
> > > switching quota and effectively blocking the frn switching.
> > > 
> > > A cgwb cleanup operation can fail due to different reasons (e.g. not
> > > enough memory, the cgwb has an in-flight/pending io, an attached inode
> > > in a wrong state, etc). In this case the next scheduled cleanup will
> > > make a new attempt. An attempt is made each time a new cgwb is offlined
> > > (in other words a memcg and/or a blkcg is deleted by a user). In the
> > > future an additional attempt scheduled by a timer can be implemented.
> > > 
> > > ...
> > >
> > > +/*
> > > + * Maximum inodes per isw.  A specific value has been chosen to make
> > > + * struct inode_switch_wbs_context fit into 1024 bytes kmalloc.
> > > + */
> > > +#define WB_MAX_INODES_PER_ISW	115
> > 
> > Can't we do 1024/sizeof(struct inode_switch_wbs_context)?
> 
> It must be something like
> DIV_ROUND_DOWN_ULL(1024 - sizeof(struct inode_switch_wbs_context), sizeof(struct inode *)) + 1

Sorry to keep popping in for 1 offs but maybe this instead? I think the
above would result in > 1024 kzalloc() call.

DIV_ROUND_DOWN_ULL(max(1024 - sizeof(struct inode_switch_wbs_context), sizeof(struct inode *)),
                   sizeof(struct inode *))

might need max_t not sure.

> 
> But honestly 1024 came out of a thin air too, so I'm not sure it worth it.
> I liked the number 128 but then made it fit into the closest kmalloc cache.
> 
> Btw, thank you for picking these patches up!

Thanks,
Dennis
