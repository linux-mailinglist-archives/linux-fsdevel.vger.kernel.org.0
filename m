Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE17B2CF6CB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Dec 2020 23:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbgLDWdv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Dec 2020 17:33:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgLDWdv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Dec 2020 17:33:51 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E75C0613D1;
        Fri,  4 Dec 2020 14:33:10 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607121189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YbRXY429jy10ThX2bWwmeNckWbunoi+DH/zVHNz4Hkg=;
        b=zZgk97fS/Cu1ayNQt8zCSx+RyGvBPt3BEbtm4/2J0+wYSt7qAt6S6lrIbTMFbW5zPvJAU1
        zR4xvxFeAx/SRlb7YupffZ8F6YfLtK8qQ8zNls/G+rvxmeqVtD770eJ0vGJ9mB8n0/b1JA
        Cdj9si6bqurOhG4SB5uF58outH8W5uvUm3+K95JPjhBxa13SygviLAmCHaYJeblezOyfLs
        N+J1GlhrZWDPMVMh28Jz8zrYUtKlIXwRHZFcNT+tvzdKkMPK2NnRAvUPb8d7vVedO7smUv
        28AQaFm92Jbtf4yp602X8ur9q7xCkWiNgVBSfABcaMLndKkOgSR0sNCxTTlxpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607121189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YbRXY429jy10ThX2bWwmeNckWbunoi+DH/zVHNz4Hkg=;
        b=upIBhyrHbsbvHciDx/4TpyV/LlhEy5Xqw9SdhaA99Phzx/iTH3SYoU7Xz2RPcQPNxHNKwU
        86WcyyOx8qiQaFAA==
To:     Ira Weiny <ira.weiny@intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
In-Reply-To: <20201204160504.GH1563847@iweiny-DESK2.sc.intel.com>
References: <20201124060755.1405602-1-ira.weiny@intel.com> <20201124060755.1405602-4-ira.weiny@intel.com> <160648211578.10416.3269409785516897908@jlahtine-mobl.ger.corp.intel.com> <20201204160504.GH1563847@iweiny-DESK2.sc.intel.com>
Date:   Fri, 04 Dec 2020 23:33:08 +0100
Message-ID: <878sad9p7f.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 04 2020 at 08:05, Ira Weiny wrote:
> So I think I'm going to submit the base patch to Andrew today (with some
> cleanups per the comments in this thread).

Could you please base that on tip core/mm where the kmap_local() muck is
and use kmap_local() right away?

Thanks,

        tglx
