Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 531D439BC4C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jun 2021 17:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbhFDPzu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Jun 2021 11:55:50 -0400
Received: from mail-qt1-f176.google.com ([209.85.160.176]:33402 "EHLO
        mail-qt1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbhFDPzu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Jun 2021 11:55:50 -0400
Received: by mail-qt1-f176.google.com with SMTP id a15so7370813qta.0;
        Fri, 04 Jun 2021 08:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BFNJl7w5MoErGTGxa0e9M8jpquhBhJupY2y4JLWlRpA=;
        b=ndbmBpyRMTLo5CTZFU0wHBaAV8AcbKUUW3wG9R46rMAh3CrQ1hVUUPP25ttvbRpN5o
         tzg1EVk7iJYeWLL9TkNIKhnL68/IuJUA8JefbrY+j5Yr+gY+PkxpC73fwdZxDTl39brw
         8VW6u1tyl9X8HLTnoUG9+DAxVN9btvcDVIFIvPX9yH9JaMAvif1QtFm7fgJOZUSJ/G7z
         jtDqjiWbOCcSGpQV6exeuZ7PKG5nlr5tdEj2NZJaDwDpmf2yLpkYSiEtIAHa2ia0nuTp
         5seoXqQ4jqBpSjrtbSX1eEsbSnhajLDfiC3QmTj+A/RSwe+Shj4BWgpBNYpOsJmCXAWI
         PX/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=BFNJl7w5MoErGTGxa0e9M8jpquhBhJupY2y4JLWlRpA=;
        b=SRSlUGJ9oz9u8g+KhOec1jOFeKIAPtNzNY8NmRYmuHVwOcJOPZi6aXURxlohhWo3LH
         mWmYhaXVAY4+9t10wa3Ry8xFLMGcOH2cAXV0/K/FVG6vC2E28EzRaWgx5A2mzf1DdtYT
         NizJ3lTMxH1+VnnYwIZ52sTWgN5Hys0AhhJv4lIaopyfto1Fz5ChelVz+9u/ZWUMV2qZ
         dGW5gD9HPgCdQT3Sf+fqV2xRdLkXVC80/XcGsyluXKx2kHMjdwj9YBLW/s2qWGcmc4xV
         57ADfAiLQM1Etmnq4VuAZ3pSNAye2Oh86Jsn4hShNKKTuk5POHikZQGf/uEnTToziefx
         KBdg==
X-Gm-Message-State: AOAM533WagopA/Er4Gjg97Li/NrdtDzWw4wzJQQA41iHx0lmdGdTDyyt
        cdgmkf+wk8foHSJr447zhziIOhs0iDSqTg==
X-Google-Smtp-Source: ABdhPJzFDKr1Iu4+DVLo0fA+2Du1paDWoFJUgPQH0szCpD4M4Al/EXPm2771IPIioqdkF1eqxM0yhQ==
X-Received: by 2002:ac8:67d5:: with SMTP id r21mr5254832qtp.92.1622821983655;
        Fri, 04 Jun 2021 08:53:03 -0700 (PDT)
Received: from localhost ([199.192.137.73])
        by smtp.gmail.com with ESMTPSA id 17sm3687916qtw.44.2021.06.04.08.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 08:53:03 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 4 Jun 2021 11:53:02 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dennis Zhou <dennis@kernel.org>,
        Dave Chinner <dchinner@redhat.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH v7 0/6] cgroup, blkcg: prevent dirty inodes to pin dying
 memory cgroups
Message-ID: <YLpMXmWvPsIK97ZE@slm.duckdns.org>
References: <20210604013159.3126180-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604013159.3126180-1-guro@fb.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 03, 2021 at 06:31:53PM -0700, Roman Gushchin wrote:
> To solve the problem inodes should be eventually detached from the
> corresponding writeback structure. It's inefficient to do it after
> every writeback completion. Instead it can be done whenever the
> original memory cgroup is offlined and writeback structure is getting
> killed. Scanning over a (potentially long) list of inodes and detach
> them from the writeback structure can take quite some time. To avoid
> scanning all inodes, attached inodes are kept on a new list (b_attached).
> To make it less noticeable to a user, the scanning and switching is performed
> from a work context.

Sorry for chiming in late but the series looks great to me and the only
comment I have is the migration target on the last patch, which isn't a
critical issue. Please feel free to add

 Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
