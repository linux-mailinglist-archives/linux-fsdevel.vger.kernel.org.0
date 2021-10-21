Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8E9436032
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 13:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbhJUL3u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 07:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbhJUL3q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 07:29:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F065BC06174E;
        Thu, 21 Oct 2021 04:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CwTa+1wg5QXOlznIE1zlG7+NnKh5mI81WhlM1haZOqo=; b=z+uEzII9ZHUtZ3Fk7euDjAPwfS
        zeRAzK6qJ4cqLkR23nItq3LpHoYyrBUL2GcwY14aj4Ro7/8NUln5IOIFgwF969y2xn4yE3e9oWbtC
        cAMZqr3l+Z+j8PHC3/2XFGeydMqPet48ELB68dSEcR+FVoNODHpuRiVoFIoSyhzv6htMOgorOUP4+
        TCJPboNkUtEc4HJMC95EIvF7NKazXYCtJz4YxDfr6vkWlQE19P78Xzkl5FarR+aMvHDzOVgA+f8mx
        iKdGO6olcluS58IwGNSe+QsIM/RwCY0QX9aDLRdDhSfJYfcqX0Zl09fnqeH7w30Z48pNtQRMa2XIp
        kDlKTQug==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdWE8-007LU1-La; Thu, 21 Oct 2021 11:27:16 +0000
Date:   Thu, 21 Oct 2021 04:27:16 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jane Chu <jane.chu@oracle.com>
Cc:     david@fromorbit.com, djwong@kernel.org, dan.j.williams@intel.com,
        hch@infradead.org, vishal.l.verma@intel.com, dave.jiang@intel.com,
        agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        ira.weiny@intel.com, willy@infradead.org, vgoyal@redhat.com,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 4/6] dm,dax,pmem: prepare dax_copy_to/from_iter() APIs
 with DAXDEV_F_RECOVERY
Message-ID: <YXFOlKWUuwFUJxUZ@infradead.org>
References: <20211021001059.438843-1-jane.chu@oracle.com>
 <20211021001059.438843-5-jane.chu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021001059.438843-5-jane.chu@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 20, 2021 at 06:10:57PM -0600, Jane Chu wrote:
> Prepare dax_copy_to/from_iter() APIs with DAXDEV_F_RECOVERY flag
> such that when the flag is set, the underlying driver implementation
> of the APIs may deal with potential poison in a given address
> range and read partial data or write after clearing poison.

FYI, I've been wondering for a while if we could just kill off these
methods entirely.  Basically the driver interaction consists of two
parts:

 a) wether to use the flushcache/mcsafe variants of the generic helpers
 b) actually doing remapping for device mapper

to me it seems like we should handle a) with flags in dax_operations,
and only have a remap callback for device mapper.  That way we'd avoid
the indirect calls for the native case, and also avoid tons of
boilerplate code.  "futher decouple DAX from block devices" series
already massages the device mapper into a form suitable for such
callbacks.
