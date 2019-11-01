Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38A31EBC6C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2019 04:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbfKADjo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Oct 2019 23:39:44 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46982 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbfKADjo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Oct 2019 23:39:44 -0400
Received: by mail-pl1-f193.google.com with SMTP id q21so3719123plr.13;
        Thu, 31 Oct 2019 20:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XwgBM4tH1Q8I4Gfu0R8qT8WSU2nCFDzcBchnJHKspqw=;
        b=U/XIL3lCaOi0gX7mAqApGfYU+6QQ+ZylWY9Noj9uyAuPfmlNdM6UM2PvhZeRNA70u5
         RB9WqTFENxvRB+AffKCFgMGLPVnQe2dS+qCvsOApRoDgKTm+nBPMVT7fzcKMjc53qRR7
         silhRQvljJwFISxfyCVW7kgeNow43bQ9YPg00Y9DLZlmhpJTWPPGz+we+L4/CAPJwd9z
         niaGxSqCplgRbfA883bpYC+DBKQki3R/9IGTIpQltqnosgNl3q4bIvnEZtm2sdJbFiFP
         T7H+jTtSXkiSQ/Kmz/HdGAdmCm4wVk3k2f2NAKbZKxmYV2ulS1IYTK7kZC5RvUyDwHY/
         XpkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XwgBM4tH1Q8I4Gfu0R8qT8WSU2nCFDzcBchnJHKspqw=;
        b=lLKIQz61IK5kCriPkV4cvq5z5rZx/5PdEFVlXy4kW6NkP2Ay4Il0UwvfiTbQy/d58V
         X0FpsujVggosCZ0LqJ7kfGc4Tbz1uXSAqL3EQnuy1iN5FcGUI973mHrvIA/Ltr4w0fzb
         TwbbtCYRN1VaSC+RlnMmzOq39YFr4TJIxEYrhrzeJT2kKyCNQ5bRXzA2BrPCf3P8k0kV
         /ux+viW1VABoPCNr5s3uDnff+GR3BKNFgnyyQE/IdMzS/2O9Veyborcro6V98vH8tQdv
         AQo1AsyzO+I1IklMPf1cD/d38nCSKPTSQJwc54kiHV14Jo/UXim8+Ob2XqPU0vXsBIvs
         PwKQ==
X-Gm-Message-State: APjAAAUvgWoy81JyvGMcuTt54+7e825d2YQg1T8rK1uQJghDDw8tiYpZ
        uKWCeEuT1u+gU/V8Rna4Qw==
X-Google-Smtp-Source: APXvYqytVzOvXBKVGtOeseyP+9IAS9KExyRLld2RnMGSy9BytG4hu3DMp7Df1r3xY5nRQdvawu+wqQ==
X-Received: by 2002:a17:902:b10c:: with SMTP id q12mr9789131plr.97.1572579583711;
        Thu, 31 Oct 2019 20:39:43 -0700 (PDT)
Received: from mypc ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id z18sm4840827pgv.90.2019.10.31.20.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 20:39:42 -0700 (PDT)
Date:   Fri, 1 Nov 2019 11:39:33 +0800
From:   Pingfan Liu <kernelfans@gmail.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Brian Foster <bfoster@redhat.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] xfs/log: protect the logging content under xc_ctx_lock
Message-ID: <20191101033933.GA7498@mypc>
References: <20191030133327.GA29340@mypc>
 <1572442631-4472-1-git-send-email-kernelfans@gmail.com>
 <20191031214031.GV4614@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031214031.GV4614@dread.disaster.area>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 01, 2019 at 08:40:31AM +1100, Dave Chinner wrote:
> On Wed, Oct 30, 2019 at 09:37:11PM +0800, Pingfan Liu wrote:
> > xc_cil_lock is not enough to protect the integrity of a trans logging.
> > Taking the scenario:
> >   cpuA                                 cpuB                          cpuC
> > 
> >   xlog_cil_insert_format_items()
> > 
> >   spin_lock(&cil->xc_cil_lock)
> >   link transA's items to xc_cil,
> >      including item1
> >   spin_unlock(&cil->xc_cil_lock)
> >                                                                       xlog_cil_push() fetches transA's item under xc_cil_lock
> >                                        issue transB, modify item1
> >                                                                       xlog_write(), but now, item1 contains content from transB and we have a broken transA
> 
> TL;DR: 1. log vectors. 2. CIL context lock exclusion.
> 
> When CPU A formats the item during commit, it copies all the changes
> into a list of log vectors, and that is attached to the log item
> and the item is added to the CIL. The item is then unlocked. This is
> done with the CIL context lock held excluding CIL pushes.
> 
> When CPU C pushes on the CIL, it detatches the -log vectors- from
> the log item and removes the item from the CIL. This is done hold
> the CIL context lock, excluding transaction commits from modifying
> the CIL log vector list. It then formats the -log vectors- into the
> journal by passing them to xlog_write().  It does not use log items
> for this, and because the log vector list has been isolated and is
> now private to the push context, we don't need to hold any locks
> anymore to call xlog_write....
Yes. I failed to realize it. The critical "item->li_lv = NULL" in
xlog_cil_push(), which isolates the vectors and free of new
modification even after releasing xc_ctx_lock.
[...]
> >  	 * initialise the new context and attach it to the CIL. Then attach
> > @@ -783,6 +767,25 @@ xlog_cil_push(
> >  	up_write(&cil->xc_ctx_lock);
>         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> We don't hold the CIL context lock anymore....
> 
Doze on it, make a mistaken reverse recognition of the up/down meaning.

Thank you for very patient and detailed explain. I get a full
understanding now.

Regards,
	Pingfan
