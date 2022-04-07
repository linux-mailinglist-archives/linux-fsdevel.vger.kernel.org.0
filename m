Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6524A4F7556
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Apr 2022 07:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240883AbiDGFci (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Apr 2022 01:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237986AbiDGFcd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Apr 2022 01:32:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD9A2F2;
        Wed,  6 Apr 2022 22:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xe6Wh61D0dwQPHufcErxm0z4ibDB+THnfb9jDNUjPFM=; b=LkkPADU1q8U/0mpL3Zb6QAn9os
        hxX9Dx4f/YFPryOx1G89Ukac7e+GnrZr6Vi7XptDrUVDdIoikVtZpwT5MhjVfjZxEPLqAB1riDhyb
        JZXA/S+ygmQFq1H64CEkLk2IXZuciM5lwrz2RsOHh1A+cOBallCX9RbVEHszGh2Ctev3pG9Vqq7f0
        nQ2RiVfpMq/6XTvvdVEJ3XrwHrwPh0EeFYX4xaWlK+xCWvdVq4FCvofnTm5fWE2yKlPrgCDO0JcOG
        fZ8rHrx6AMQJGf003qWsVghyNQuae6pEVuMbIQW/ea2bLZCSy5pGWAcNfXXeMlZwT8qPSNiE+iKS1
        th53VCdg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ncKih-009YRE-V6; Thu, 07 Apr 2022 05:30:11 +0000
Date:   Wed, 6 Apr 2022 22:30:11 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jane Chu <jane.chu@oracle.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "vgoyal@redhat.com" <vgoyal@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v7 4/6] dax: add DAX_RECOVERY flag and .recovery_write
 dev_pgmap_ops
Message-ID: <Yk52415cnFa39qil@infradead.org>
References: <20220405194747.2386619-1-jane.chu@oracle.com>
 <20220405194747.2386619-5-jane.chu@oracle.com>
 <Yk0i/pODntZ7lbDo@infradead.org>
 <196d51a3-b3cc-02ae-0d7d-ee6fbb4d50e4@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <196d51a3-b3cc-02ae-0d7d-ee6fbb4d50e4@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 06, 2022 at 05:32:31PM +0000, Jane Chu wrote:
> Yes, I believe Dan was motivated by avoiding the dm dance as a result of
> adding .recovery_write to dax_operations.
> 
> I understand your point about .recovery_write is device specific and
> thus not something appropriate for device agnostic ops.
> 
> I can see 2 options so far -
> 
> 1)  add .recovery_write to dax_operations and do the dm dance to hunt 
> down to the base device that actually provides the recovery action

That would be my preference.  But I'll wait for Dan to chime in.

> Okay, will run the checkpatch.pl test again.

Unfortuntely checkpatch.pl is broken in that regard.  It treats the
exception to occasionally go longer or readability as the default.
