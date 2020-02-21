Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A36F9168A60
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Feb 2020 00:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729655AbgBUX1G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 18:27:06 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39729 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbgBUX05 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 18:26:57 -0500
Received: by mail-oi1-f193.google.com with SMTP id 18so353622oij.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Feb 2020 15:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0Qjb28JuFNd9gOL/WSqmB2kriWyv5u53CrYdkf6Wy1Y=;
        b=TbwlC6/OrsWHxLiHo7OXqsvf/ROPkSFjJO1MBYg1yRPYgiKYPSofcItFNCaMiRPqUg
         ekVKNLY9y1PeCxEUWaSDpZ27kasvrGCcmLmTlo26XYh0b/2TauVoNpEh5kth8ND8N5Ha
         WooPz1Nm1JTzfThjUvTHDj61iIKbc2/48vx9sJnbA3uOgV0hFKgJ1Nh32QSV9HnXuzR9
         bp5UUR33XZYEueszk5XSdy5dxhzlDPlnoyesaSyx7IXU5Iopv4iymYu2RXAjDyvIqgPT
         LJF3lNwhgVAvbffRoFHg+eiJEAG6brTEsvGZFVYpbMG15bUtHaA1J0W4U/s+7/aq3YiG
         GuBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0Qjb28JuFNd9gOL/WSqmB2kriWyv5u53CrYdkf6Wy1Y=;
        b=ExoR8LI+PAiM1C6MlLCR4d6amY8uGcDG3gcaz0rqNajbPwN1eyzu/oiBnRvlnQ4PN0
         nDK4Y0XCInGhjic3Dbh53R+k9x55+uMrOfcpieY7WnFeTD5zqKvHFKK8wiQsn9BcZseo
         eqYIyl9YjkHHCTv6kBF8vqPEpsvnTW/nMXOqKmQt8OHwsf6zIoNIE3D9aD4BWTCEzB45
         v+jsSEdtxLZ09egnKUHUuB5RMDDD9tAJRV8d7IPXLESMDSzKAWbP84eDHcO4R9yEf1nH
         ZR21FvQu+bWw8tTGq/3rOY/3gd/BHgsnRdImjtBzJTJECeTTAuE1Nk4AhUUFXhqBAAcc
         edHw==
X-Gm-Message-State: APjAAAX//qxqBXadfITxRKB1HTI1nkXxkebYLyAG3D2bxaW2c1MeCp+6
        N8JSEyu7NMC3CbYGVCmJGEnldMZCL8e83lx8TDC4xw==
X-Google-Smtp-Source: APXvYqy2rdUEqZ3R4aMaqDNTBL6bwDfhIb/6cZCDZKDfBRXKgwgp6CIVU2tXnuzooMcwkImhJrj6TbiItSwmVWFD3ug=
X-Received: by 2002:a05:6808:a83:: with SMTP id q3mr4285182oij.0.1582327616863;
 Fri, 21 Feb 2020 15:26:56 -0800 (PST)
MIME-Version: 1.0
References: <20200221004134.30599-1-ira.weiny@intel.com> <20200221004134.30599-8-ira.weiny@intel.com>
 <20200221174449.GB11378@lst.de> <20200221224419.GW10776@dread.disaster.area>
In-Reply-To: <20200221224419.GW10776@dread.disaster.area>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 21 Feb 2020 15:26:45 -0800
Message-ID: <CAPcyv4gueN4BsE94CGeO_rDad+MBs==5a+m7SKymJ_RywNCW3w@mail.gmail.com>
Subject: Re: [PATCH V4 07/13] fs: Add locking for a dynamic address space
 operations state
To:     Dave Chinner <david@fromorbit.com>
Cc:     Christoph Hellwig <hch@lst.de>, "Weiny, Ira" <ira.weiny@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 21, 2020 at 2:44 PM Dave Chinner <david@fromorbit.com> wrote:
>
> On Fri, Feb 21, 2020 at 06:44:49PM +0100, Christoph Hellwig wrote:
> > On Thu, Feb 20, 2020 at 04:41:28PM -0800, ira.weiny@intel.com wrote:
> > > From: Ira Weiny <ira.weiny@intel.com>
> > >
> > > DAX requires special address space operations (aops).  Changing DAX
> > > state therefore requires changing those aops.
> > >
> > > However, many functions require aops to remain consistent through a deep
> > > call stack.
> > >
> > > Define a vfs level inode rwsem to protect aops throughout call stacks
> > > which require them.
> > >
> > > Finally, define calls to be used in subsequent patches when aops usage
> > > needs to be quiesced by the file system.
> >
> > I am very much against this.  There is a reason why we don't support
> > changes of ops vectors at runtime anywhere else, because it is
> > horribly complicated and impossible to get right.  IFF we ever want
> > to change the DAX vs non-DAX mode (which I'm still not sold on) the
> > right way is to just add a few simple conditionals and merge the
> > aops, which is much easier to reason about, and less costly in overall
> > overhead.
>
> *cough*
>
> That's exactly what the original code did. And it was broken
> because page faults call multiple aops that are dependent on the
> result of the previous aop calls setting up the state correctly for
> the latter calls. And when S_DAX changes between those calls, shit
> breaks.
>
> It's exactly the same problem as switching aops between two
> dependent aops method calls - we don't solve anything by merging
> aops and checking IS_DAX in each method because the race condition
> is still there.
>
> /me throws his hands in the air and walks away

Please come back, because I think it's also clear that the "we don't
support changes of ops vectors at runtime" assertion is already being
violated by ext4 [1]. So that leaves "IFF we ever want to change the
dax vs non-dax mode" which I thought was already consensus given the
lingering hopes about having some future where the kernel is able to
dynamically optimize for dax vs non-dax based on memory media
performance characteristics. I thought the only thing missing from the
conclusion of the last conversation [2] was the "physical" vs
"effective" split that we identified at LSF'19 [3]. Christoph, that
split allows for for your concern about application intent to be
considered / overridden by kernel policy, and it allows for
communication of the effective state which applications need for
resource planning [4] independent of MAP_SYNC and other dax semantics.

The status quo of globally enabling dax for all files is empirically
the wrong choice for page-cache friendly workloads running on
slower-than-DRAM pmem media.

I am struggling to see how we address the above items without first
having a dynamic / less than global-filesystem scope facility to
control dax.

[1]: https://lore.kernel.org/linux-fsdevel/20191108131238.GK20863@quack2.suse.cz
[2]: https://lore.kernel.org/linux-fsdevel/20170927064001.GA27601@infradead.org
[3]: https://lwn.net/Articles/787973/
[4]: https://lwn.net/Articles/787233/
