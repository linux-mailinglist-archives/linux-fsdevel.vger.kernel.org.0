Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75EC4B9095
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2019 15:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbfITNYo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Sep 2019 09:24:44 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35913 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbfITNYo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Sep 2019 09:24:44 -0400
Received: by mail-pg1-f193.google.com with SMTP id h17so1289611pgb.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Sep 2019 06:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TnjUWTfkKNV9IYYnDetWaYAFTx5SNyQF7T/O6nAZyIk=;
        b=oPGRfpl7g0lNzp+u95nxNL00fbp1UzolwKahOe3y8pB1866yrJohE4JW6EH6mPMWxi
         6EbPSeLu8d6qUCqnOVjlkZDoSX9Wlkv/GwiShJ3LanugrQSBRYGtcr4ZqLRXQtF1kFJP
         97N5OQnxTO4MU6iBh6KcMOOq0XGT6ShuwVlHXv3jCx/0LBdGvFapcI6+kfoIDUoy8sN8
         sI+3NrK+9PML5h/ZuTW/9KOiChgpCFV34QeYB9s+RWUvQpYQUwJ6HTyL3+yszD/Dt+2K
         2Bvv0h8FQ7DUbE5/21IiCmE0IqnQFaQkKnycDVIKa3KkpgiKma99UhBWrbjF2jO1ZxpM
         onoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TnjUWTfkKNV9IYYnDetWaYAFTx5SNyQF7T/O6nAZyIk=;
        b=lIOl2URgvspGw8aiAEMlsiBngd6t3roGFlOf54kWc8n9QbC1ZMskj96YXagldkvVpY
         c3DRbFFM0nzcLbcjp9rTkVXpiksGAw3LnjMrGK/6wdXcX4gGSCIDXZq5Ine3WHTTBo8J
         Cd64CyQt9yUmIrJaWVS9ZUG6xNNp8AwjBJ57Uk8jTDPpO1ChVQpw10JEQSOmtu4Ey31Q
         mgKusWJBdFz2X1rIEFudc+DduPtGyE4/9jnSpfRSgHym/E6H6ymMoWtALkPz/EQxBIoL
         Fg2T1BH30bNCfdUIbqSHuDzY5QNRFZAGXijSppLkfmIQsP2FcHkuYMG0VS6L7coOWoMX
         rP9A==
X-Gm-Message-State: APjAAAVUjdrCBBJlFk2/OQBD3SQvUv5BdKkfM0RtNzfR+tuEHRe5HEcE
        qvaCpW1iV610CcrQDrBSCz+H
X-Google-Smtp-Source: APXvYqw1f00h0TcRIjdGKTb0dpj+aCBS0xHsBYQHglv/asRXjNcEkpA5MLy470Y98cojlA95xTR+eQ==
X-Received: by 2002:a62:2702:: with SMTP id n2mr17643873pfn.73.1568985883589;
        Fri, 20 Sep 2019 06:24:43 -0700 (PDT)
Received: from bobrowski ([110.232.114.101])
        by smtp.gmail.com with ESMTPSA id k9sm4405078pfk.72.2019.09.20.06.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 06:24:42 -0700 (PDT)
Date:   Fri, 20 Sep 2019 23:24:36 +1000
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, darrick.wong@oracle.com
Subject: Re: [PATCH v3 5/6] ext4: introduce direct IO write path using iomap
 infrastructure
Message-ID: <20190920132436.GA2863@bobrowski>
References: <cover.1568282664.git.mbobrowski@mbobrowski.org>
 <db33705f9ba35ccbe20fc19b8ecbbf2078beff08.1568282664.git.mbobrowski@mbobrowski.org>
 <20190916121248.GD4005@infradead.org>
 <20190916223741.GA5936@bobrowski>
 <20190917090613.GC29487@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917090613.GC29487@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 17, 2019 at 02:06:13AM -0700, Christoph Hellwig wrote:
> On Tue, Sep 17, 2019 at 08:37:41AM +1000, Matthew Bobrowski wrote:
> > > Independent of the error return issue you probably want to split
> > > modifying ext4_write_checks into a separate preparation patch.
> > 
> > Providing that there's no objections to introducing a possible performance
> > change with this separate preparation patch (overhead of calling
> > file_remove_privs/file_update_time twice), then I have no issues in doing so.
> 
> Well, we should avoid calling it twice.  But what caught my eye is that
> the buffered I/O path also called this function, so we are changing it as
> well here.  If that actually is safe (I didn't review these bits carefully
> and don't know ext4 that well) the overall refactoring of the write
> flow might belong into a separate prep patch (that is not relying
> on ->direct_IO, the checks changes, etc).

Yeah, no. Revisiting this again now and trying to implement the
ext4_write_checks() modifications as a pre-patch is a nightmare so to
speak. This is purely due to the way that ext4_file_write_iter() is currently
written and how both the current buffered I/O and direct I/O paths traverse
through and make use of it.

If anything, the changes applied to ext4_write_checks() should be a separate
patch that comes *after* the refactoring of the buffered and direct I/O write
flow. However, even then, there'd be code that we essentially introduce in the
write flow changes and then subsequently removed after the fact. Providing
that's OK, then sure, I can put this within a separate patch.

--<M>--
