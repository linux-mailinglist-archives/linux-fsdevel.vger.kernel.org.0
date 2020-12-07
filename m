Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1D0B2D15D6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 17:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgLGQU1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 11:20:27 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:37562 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgLGQU1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 11:20:27 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607357985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C/sQljTyhwUHTax9M8bioo3pwWQ7vbfn0SifDxcVhSU=;
        b=daPJYYstwXwkwp7Us5EjfmoRdt/dKmWwd1ay66mz3AYkonITnKgsDvtsMQTXOZyQ84kDo2
        WokUttcO1OEThJXxPfmwEAduSnbEHcwAWCa7lvCZfW/umpij7Xr0mhn5x4LnIGYFWnaMfO
        SNQwLy0EZFRt+vK6udNE784KCz+lbgkGq8JlXhCd80RDYtjt1fwi+OHvq7a1eYPcewWElK
        3llyPa6hpUsQpM6POeFUkXeLIp9+7M48VDuO78bxd2TlW4PGsV/QMqsS/6ZX8Sa9Jfa9T4
        Steq0NCMw+NVM8oh2I5UmGUFM5HpXTCvJLDSL8pGZHeAhb+oqUlhInhB33poNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607357985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C/sQljTyhwUHTax9M8bioo3pwWQ7vbfn0SifDxcVhSU=;
        b=6T3c4F0TLNkZ/0M/LqgMkgAIlzNgeXLtZd/k8BXHbBREzVmKufMvVAGQuEVBqTjWqG/R4e
        k9VJJ4G6u22o+hBw==
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Eric Biggers <ebiggers@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        David Howells <dhowells@redhat.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Steve French <sfrench@samba.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Brian King <brking@us.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH 03/17] drivers/gpu: Convert to mem*_page()
In-Reply-To: <20201207064655.GK1563847@iweiny-DESK2.sc.intel.com>
References: <20201124060755.1405602-1-ira.weiny@intel.com> <20201124060755.1405602-4-ira.weiny@intel.com> <160648211578.10416.3269409785516897908@jlahtine-mobl.ger.corp.intel.com> <20201204160504.GH1563847@iweiny-DESK2.sc.intel.com> <878sad9p7f.fsf@nanos.tec.linutronix.de> <20201207064655.GK1563847@iweiny-DESK2.sc.intel.com>
Date:   Mon, 07 Dec 2020 17:19:44 +0100
Message-ID: <87ft4h6127.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Dec 06 2020 at 22:46, Ira Weiny wrote:
> On Fri, Dec 04, 2020 at 11:33:08PM +0100, Thomas Gleixner wrote:
>> On Fri, Dec 04 2020 at 08:05, Ira Weiny wrote:
>> > So I think I'm going to submit the base patch to Andrew today (with some
>> > cleanups per the comments in this thread).
>> 
>> Could you please base that on tip core/mm where the kmap_local() muck is
>> and use kmap_local() right away?
>
> Sure.  Would that mean it should go through you and not Andrew?

If Andrew has no objections of course.

Thanks,

        tglx
