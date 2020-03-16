Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2322186849
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Mar 2020 10:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730489AbgCPJzN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Mar 2020 05:55:13 -0400
Received: from verein.lst.de ([213.95.11.211]:53451 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730025AbgCPJzN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Mar 2020 05:55:13 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id DC0AC68CEC; Mon, 16 Mar 2020 10:55:09 +0100 (CET)
Date:   Mon, 16 Mar 2020 10:55:09 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jan Kara <jack@suse.cz>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dave Chinner <david@fromorbit.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH V5 00/12] Enable per-file/per-directory DAX operations
 V5
Message-ID: <20200316095509.GA13788@lst.de>
References: <20200227052442.22524-1-ira.weiny@intel.com> <20200305155144.GA5598@lst.de> <20200309170437.GA271052@iweiny-DESK2.sc.intel.com> <20200311033614.GQ1752567@magnolia> <20200311062952.GA11519@lst.de> <CAPcyv4h9Xg61jk=Uq17xC6AGj9yOSAJnCaTzHcfBZwOVdRF9dw@mail.gmail.com> <20200316095224.GF12783@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200316095224.GF12783@quack2.suse.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 16, 2020 at 10:52:24AM +0100, Jan Kara wrote:
> > This sounds reasonable to me.
> > 
> > As for deprecating the mount option, I think at a minimum it needs to
> > continue be accepted as an option even if it is ignored to not break
> > existing setups.
> 
> Agreed. But that's how we usually deprecate mount options. Also I'd say
> that statx() support for reporting DAX state and some education of
> programmers using DAX is required before we deprecate the mount option
> since currently applications check 'dax' mount option to determine how much
> memory they need to set aside for page cache before they consume everything
> else on the machine...

I don't even think we should deprecate it.  It isn't painful to maintain
and actually useful for testing.  Instead we should expand it into a
tristate:

  dax=off
  dax=flag
  dax=always

where the existing "dax" option maps to "dax=always" and nodax maps
to "dax=off". and dax=flag becomes the default for DAX capable devices.
