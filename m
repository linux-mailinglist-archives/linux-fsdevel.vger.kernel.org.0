Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82AEA4837FC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jan 2022 21:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbiACURe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jan 2022 15:17:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbiACURc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jan 2022 15:17:32 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA23C061761
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Jan 2022 12:17:32 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id j17so31725717qtx.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Jan 2022 12:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=Z+4dvYAVW+j0wGcJEqsm3l7X49nKlhTo4PX3QCjARbI=;
        b=Qw9Jx9WY063FuYx+JVQOsWkzBedAxK2DCaL6XmLunRK1zNv4pF5HOCMt1bkHjtFyrl
         ANnu3cChhHaR7nRHSJ7M7/poL1lFHRJ/08RW8pajfCnHxNhT8AstTD0fxDgWx2VsiwJ6
         9fvGaH1QNYylKsRp+kZoKWV0lZLaSY2QRFG4aOBditRJ0fJ3hbhlUP9Ixx/GjxAlr5Xu
         zMv0AJSJJ58a0suCzw9URtww3P/PKVmpcLkLhSuXHsE8vd49OJoYtqJ3KdnSDIdTXboH
         gY/t6WPd2qeXqO+1/6mQ4PHeyAWSQMTrLZsifWn8ozjlvXw3+DnStRUBQHRMJT58qGxD
         Kozg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=Z+4dvYAVW+j0wGcJEqsm3l7X49nKlhTo4PX3QCjARbI=;
        b=uGmp+XemQm/h/rqBC9zzksmqPwdcvhZgV5IKMICBT+yCD+EiRE5bKprlS8HXI3g3dV
         2e371zR5PYL2AcfQnpm+0k03AMNBOa03e6UF4wPKv8oTmUuPDGjpwHdQHH31y4PeevYa
         rk+Ajixzuse1N4phIVdjUnYPdd8QtyTHZqd8c/VHDKfPLtl+7UjtJjtxYLZYY+Cn1z7d
         lm/JBobuk12iDpWJPb6NspW7kkcHzdO0heZQ7ygIZDyiz9u1ZrpvQtXYCHg64yX/CEGZ
         D8Uco0IH1qbPR3f5PhkyO8ULfbGk0DjiQtTwfeXgsEB6vmA4iMzL/X3L3zuFnf4yEonC
         RcRw==
X-Gm-Message-State: AOAM5324CX/cNLG7NWdfWd07tnDHJZmQmhep2LqG2RJshxGW6iLk0Ccj
        ZN0cpxYaKC4tMvvVRgiNncmFOA==
X-Google-Smtp-Source: ABdhPJyKl4m1Y1Oq58YEXMHG463q9HzkROZdjykUOsOVYl7lEApjy7SN7bG5Xk0WnWFA+a53grJZMA==
X-Received: by 2002:ac8:424f:: with SMTP id r15mr41340371qtm.265.1641241051183;
        Mon, 03 Jan 2022 12:17:31 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id j13sm29376286qtr.21.2022.01.03.12.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 12:17:30 -0800 (PST)
Date:   Mon, 3 Jan 2022 12:17:28 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Christoph Hellwig <hch@infradead.org>
cc:     Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH next 1/3] truncate,shmem: Fix data loss when hole punched
 in folio
In-Reply-To: <YdKq9bOcZ0M30LZ8@infradead.org>
Message-ID: <7e41698-915-93c2-2cc1-6cfc18ede6f@google.com>
References: <43bf0e3-6ad8-9f67-7296-786c7b3b852f@google.com> <YdKq9bOcZ0M30LZ8@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 2 Jan 2022, Christoph Hellwig wrote:
> On Sun, Jan 02, 2022 at 05:32:28PM -0800, Hugh Dickins wrote:
> >  
> > +	same_folio = (lstart >> PAGE_SHIFT) == (lend >> PAGE_SHIFT);
> 
> Should this move to the else branch?

We could add an else branch and move it there, yes.  I liked
Matthew's else-less style with partial_end, and followed that.

Whatever: since he posted that diff yesterday, I imagine he'll
just merge this into the fixed patch, in whatever style he prefers.

> 
> Same for the other copy of this code.  Otherwise this looks sane.

Thanks,
Hugh
