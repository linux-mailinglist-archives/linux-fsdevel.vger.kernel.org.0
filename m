Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99F38173CDB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2020 17:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbgB1Q1G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Feb 2020 11:27:06 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44859 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgB1Q1G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Feb 2020 11:27:06 -0500
Received: by mail-ot1-f67.google.com with SMTP id h9so3078910otj.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Feb 2020 08:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=akPX/Le0d2EiQmbAvQA94ZihJyml6bsfezTs1xR+aWI=;
        b=bukCJoLWpFuG4kP9cdoMOAtCcw6mtymH0738+Cr/dDuwu2ERG+5ejt9RigalXEkE32
         ogfqK+z82ZNA/pFMw3Cu3QBXiOahIJfVWFrSmMRHS/dIAbAT8wPAeq/8mbKwzGbs87el
         vvNtku4b4DFwyy2BaTPexmQz08UfnrFhesbV0UQsYbBzUnOuocPHTK+SKO6ylLGpWw9h
         Q59r+4Gy7GuB89UgLq2iltRlyb851aKavJ+mzpWZYrohrqmC2lFhYZEOIfwymFvKJz7g
         fsLSmh+43Inz1Qqeyiq/bD/wEsiC3YMv33ThnmFvBY8AOX+YrlWks1wsVEeDIpKM5wou
         FpPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=akPX/Le0d2EiQmbAvQA94ZihJyml6bsfezTs1xR+aWI=;
        b=Ju0OdVHB5ZTdnbjUdeHocHOZTEMY3jcFHatSgNQjgPQrJybLcM+sKX6bGTuaF0d8ZR
         /Ix8QjVz7VpeepPojNPOK/BTJ7xW8JtvJ8lzhIVEOdZx6MOTWPrLXBt/XwcvN4E15RWB
         BPESI+P5XuXf7RpUnB2QnrukSTvenn0FmBW54E4MWT8Fwkm1fMXA6wYgY/KqgBXxDQN3
         sH6HDDecjTy6H1Dapt9669InunfP802jqbNDyvdyW7Q9O2da24h78CxVp29yEmwD3k8j
         E7MBFO+XixhUb+fJpYBb7MJQxI3L5YFe0plmPPIq0m1qL3NhhBsfAz3v30cjf0cZNEJC
         CKEA==
X-Gm-Message-State: APjAAAWx6kWmK0rRbC0IbfVmKwCnzSpQLq9ZljpB5VCubfAA8RdO+G3m
        wVk727QjLqePbGw2WHR0ufH3Q3KbCYErRAnFFOGlNsAs
X-Google-Smtp-Source: APXvYqxPIfQgCnD3v9HTx5cFPLUInp7b+fRgEsmGH/hBamVfDcdplRO8p87KJZr4ZSNSQycJp3mYOu5p6SffilbLu3s=
X-Received: by 2002:a9d:6c9:: with SMTP id 67mr4103721otx.363.1582907225590;
 Fri, 28 Feb 2020 08:27:05 -0800 (PST)
MIME-Version: 1.0
References: <x49lfoxj622.fsf@segfault.boston.devel.redhat.com>
 <20200220215707.GC10816@redhat.com> <x498skv3i5r.fsf@segfault.boston.devel.redhat.com>
 <20200221201759.GF25974@redhat.com> <20200223230330.GE10737@dread.disaster.area>
 <20200224153844.GB14651@redhat.com> <20200227030248.GG10737@dread.disaster.area>
 <CAPcyv4gTSb-xZ2k938HxQeAXATvGg1aSkEGPfrzeQAz9idkgzQ@mail.gmail.com>
 <20200228013054.GO10737@dread.disaster.area> <CAPcyv4i2vjUGrwaRsjp1-L0wFf0a00e46F-SUbocQBkiQ3M1kg@mail.gmail.com>
 <20200228140508.GA2987@infradead.org>
In-Reply-To: <20200228140508.GA2987@infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 28 Feb 2020 08:26:54 -0800
Message-ID: <CAPcyv4ivX2cah1YLBZzWPdULOFX7Ds4nuboPh4mf94uN1YeMVg@mail.gmail.com>
Subject: Re: [PATCH v5 2/8] drivers/pmem: Allow pmem_clear_poison() to accept
 arbitrary offset and len
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Jeff Moyer <jmoyer@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        device-mapper development <dm-devel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 28, 2020 at 6:05 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Thu, Feb 27, 2020 at 07:28:41PM -0800, Dan Williams wrote:
> > "don't perform generic memory-error-handling, there's an fs that owns
> > this daxdev and wants to disposition errors". The fs/dax.c
> > infrastructure that sets up ->index and ->mapping would still need to
> > be there for ext4 until its ready to take on the same responsibility.
> > Last I checked the ext4 reverse mapping implementation was not as
> > capable as XFS. This goes back to why the initial design avoided
> > relying on not universally available / stable reverse-mapping
> > facilities and opted for extending the generic mm/memory-failure.c
> > implementation.
>
> The important but is that we stop using ->index and ->mapping when XFS
> is used as that enables using DAX+reflinks, which actually is the most
> requested DAX feature on XFS (way more than silly runtime flag switches
> for example).

Understood. To be clear the plan we are marching to is knock down all
the known objections to the removal of the "experimental" designation.
reflink is on that list and so is per-file dax. The thought was that
pef-file dax was a nearer term goal than reflink.
